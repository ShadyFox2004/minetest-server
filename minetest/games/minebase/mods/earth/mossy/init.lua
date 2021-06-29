-- mossy/init.lua

local S = minetest.get_translator("mossy")

earth.register_cobble("mossy:stone", {
	description = S("Mossy Cobblestone"),
	groups = {cracky = 3, stone = 1}
})

minetest.register_craft({
	type = "cooking",
	output = "base_earth:stone",
	recipe = "mossy:stone_cobble",
})

minetest.register_node("mossy:permafrost", {
	description = S("Permafrost with Moss"),
	tiles = {"mossy_permafrost.png", "base_earth_permafrost.png",
	{name = "base_earth_permafrost.png^mossy_permafrost_side.png",
		tileable_vertical = false}},
	groups = {cracky = 3},
	drop = "base_earth:permafrost",
	sounds = sounds.get_defaults("earth_sounds:dirt", {
		footstep = {name = "earth_grass_footstep", gain = 0.25},
	})
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"base_earth:permafrost_with_stones"},
	sidelen = 4,
	noise_params = {
		offset = -0.8,
		scale = 2.0,
		spread = {x = 100, y = 100, z = 100},
		seed = 53995,
		octaves = 3,
		persist = 1.0
	}, 	
	biomes = {"base_biomes:tundra"},
	y_max = 50,
	y_min = 2,
	decoration = "mossy:permafrost",
	place_offset_y = -1,
	flags = "force_placement"
})

--
-- Moss growth on near water
--

mossy = {map = {}}

function mossy.replace(pos, node)
	node.name = mossy.map[node.name]
	if node.name then
		minetest.set_node(pos, node)
	end
end

function mossy.register_growth(name, def)
	if type(def.nodenames) == "table" and type(def.map) == "table" then
		minetest.register_abm({
			label = name .. "_growth",
			nodenames = def.nodenames,
			neighbors = {"group:water"},
			interval = def.interval or 16,
			chance = def.chance or 200,
			catch_up = false,
			action = mossy.replace
		})
		for key, val in pairs(def.map) do
			mossy.map[key] = val

			minetest.register_craft({
				type = "cooking",
				output = key,
				recipe = val
			})
		end
	end
end

mossy.register_growth("base_earth:mossy", {
	nodenames = {"base_earth:stone_cobble", "base_earth:permafrost"},
	map = {
		["base_earth:stone_cobble"] = "mossy:stone_cobble",
		["base_earth:permafrost"] = "mossy:permafrost",
	}
})

