-- cactus/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("cactus")
local cactus_path = minetest.get_modpath("cactus") 

minetest.register_craft({
	type = "fuel",
	recipe = "cactus:cactus",
	burntime = 15,
})

minetest.register_craft({
	output = "cactus:large_seedling",
	recipe = {
		{"", "cactus:cactus", ""},
		{"cactus:cactus", "cactus:cactus", "cactus:cactus"},
		{"", "cactus:cactus", ""},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "cactus:large_seedling",
	burntime = 5,
})

--
-- Cactus growing
--

-- Wrapping the functions in ABM action is necessary to make overriding them possible

local function grow_cactus(pos, node)
	if node.param2 >= 4 then
		return
	end
	pos.y = pos.y - 1
	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "cactus:cactus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "cactus:cactus"})
	return true
end

local function grow_large_cactus(pos)
	local path = cactus_path .. "/schematics/cactus_large.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end

minetest.register_abm({
	label = "Grow cactus",
	nodenames = {"cactus:cactus"},
	neighbors = {"group:sand"},
	interval = 12,
	chance = 83,
	action = grow_cactus
})

--
-- Mapgen 
--

minetest.register_decoration({
	name = "cactus:large",
	deco_type = "schematic",
	place_on = {"base_earth:desert_sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"base_biomes:desert"},
	y_max = 31000,
	y_min = 4,
	schematic = cactus_path .. "/schematics/cactus_large.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	name = "cactus:cactus",
	deco_type = "simple",
	place_on = {"base_earth:desert_sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"base_biomes:desert"},
	y_max = 31000,
	y_min = 4,
	decoration = "cactus:cactus",
	height = 2,
	height_max = 5,
})

minetest.register_node("cactus:cactus", {
	description = S("Cactus"),
	tiles = {"cactus_top.png", "cactus_top.png",
		"cactus_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 3},
	sounds = sounds.get_defaults("tree_sounds:wood"),
	on_place = minetest.rotate_node,
})

minetest.register_node("cactus:large_seedling", {
	description = S("Large Cactus Seedling"),
	drawtype = "plantlike",
	tiles = {"cactus_large_seedling.png"},
	inventory_image = "cactus_large_seedling.png",
	wield_image = "cactus_large_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, -0.3, 5 / 16}
	},
	groups = {choppy = 3, dig_immediate = 3, attached_node = 1},
	sounds = sounds.get_defaults("tree_sounds:wood"),
	_minp = {x = -2, y = -1, z = -2},
	_maxp = {x = 2, y = 5, z = 2},
	_max_interval = 4,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = trees.sapling_on_place(itemstack, placer, pointed_thing)

		return itemstack
	end,

	on_construct = function(pos)
		-- Normal cactus farming adds 1 cactus node by ABM,
		-- interval 12s, chance 83.
		-- Consider starting with 5 cactus nodes. We make sure that growing a
		-- large cactus is not a faster way to produce new cactus nodes.
		-- Confirmed by experiment, when farming 5 cacti, on average 1 new
		-- cactus node is added on average every
		-- 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s.
		-- Large cactus contains on average 14 cactus nodes.
		-- 14 * 199.2 = 2788.8s.
		-- Set random range to average to 2789s.
		minetest.get_node_timer(pos):start(rand.az(1859, 3719))
	end,

	on_timer = function(pos)
		local node_under = minetest.get_node_or_nil(
			{x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under then
			-- Node under not yet loaded, try later
			minetest.get_node_timer(pos):start(300)
			return
		end

		if minetest.get_item_group(node_under.name, "sand") == 0 then
			-- Seedling dies
			minetest.remove_node(pos)
			return
		end

		local light_level = minetest.get_node_light(pos)
		if not light_level or light_level < 13 then
			-- Too dark for growth, try later in case it's night
			minetest.get_node_timer(pos):start(300)
			return
		end

		grow_large_cactus(pos)
	end,
})

