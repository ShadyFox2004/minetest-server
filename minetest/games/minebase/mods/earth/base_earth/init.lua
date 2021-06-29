-- base_earth/init.lua 

local S = minetest.get_translator("base_earth")
minetest.register_alias("mapgen_stone", "base_earth:stone")

earth.define_default({stone = "base_earth:stone"})

earth.register_stone_nodes("base_earth:stone", {
	stone = {description = S("Stone")},
	cobble = {description = S("Cobblestone")},
	brick = {description = S("Stone Brick")},
	block = {description = S("Stone Block")}
})

earth.register_stone_nodes("base_earth:desert_stone", {
	stone = {description = S("Desert Stone")},
	cobble = {description = S("Desert Cobblestone")},
	brick = {description = S("Desert Stone Brick")},
	block = {description = S("Desert Stone Block")}
})

earth.register_sand_nodes("base_earth:sand", {
	sand = {description = S("Sand")},
	stone = {description = S("Sandstone")},
	brick = {description = S("Sandstone Brick")},
	block = {description = S("Sandstone Block")}
})

earth.register_sand_nodes("base_earth:desert_sand", {
	sand = {description = S("Desert Sand")},
	stone = {description = S("Desert Sandstone")},
	brick = {description = S("Desert Sandstone Brick")},
	block = {description = S("Desert Sandstone Block")}
})

earth.register_sand_nodes("base_earth:silver_sand", {
	sand = {description = S("Silver Sand")},
	stone = {description = S("Silver Sandstone")},
	brick = {description = S("Silver Sandstone Brick")},
	block = {description = S("Silver Sandstone Block")},
	ore = {seed = 2316}
})

earth.register_nodes_with("base_earth:dirt", {
	base_node = {
		description = S("Dirt"),
		groups = {crumbly = 3, soil = 1},
		is_ground_content = false,
		sounds = sounds.get_defaults("earth_sounds:dirt"),
	}, {
		with = "grass",
		description = S("Dirt with Grass"),
		gain = 0.25
	},{
		with = "grass_footsteps",
		description = S("Dirt with Grass and Footsteps"),
		tiles = {"base_earth_grass.png^base_earth_footprint.png", 
			"base_earth_dirt.png",
			{name = "base_earth_dirt.png^base_earth_grass_side.png",
				tileable_vertical = false}},
		groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
		gain = 0.25
	}, {
		with = "coniferous_litter",
		description = S("Dirt with Coniferous Litter"),
	},{
		with = "dry_grass",
		description = S("Dirt with Dry Grass"),
	}, {
		with = "rainforest_litter",
		description = S("Dirt with Rainforest Litter"),
	}
})

earth.register_ore("base_earth:dirt", {
	y_min = -31,
	seed = 17676,
	-- Only where base_earth:dirt is present as surface material
	biomes = {"base_biomes:taiga", "base_biomes:snowy_grassland", 
		"base_biomes:grassland", "base_biomes:coniferous_forest",
		"base_biomes:deciduous_forest", "base_biomes:deciduous_forest_shore", 
		"base_biomes:rainforest", "base_biomes:rainforest_swamp"}
})

earth.register_nodes_with("base_earth:dry_dirt", {
	base_node = {
		description = S("Dry Dirt"),
		groups = {crumbly = 3, soil = 1},
		sounds = sounds.get_defaults("earth_sounds:dirt"),
		is_ground_content = false,
		deco = {
			place_on = {"base_earth:dry_dirt_with_dry_grass"},
			noise_params = {
				offset = -1.5,
				scale = -1.5,
				spread = {x = 200, y = 200, z = 200},
				seed = 329,
				octaves = 4,
				persist = 1.0
			},
			biomes = {"base_biomes:savanna"},
		}
	}, {
		with = "dry_grass",
		description = S("Dry Dirt with Dry Grass"),
		groups = {crumbly = 3, soil = 1},
	}
})

earth.register_nodes_with("base_earth:permafrost", {
	base_node = {
		description = S("Permafrost"),
		groups = {cracky = 3},
		is_ground_content = false,
		sounds = sounds.get_defaults("earth_sounds:dirt"),
	}, {
		with = "stones",
		description = S("Permafrost with Stones"),
		tiles = {"base_earth_permafrost.png^base_earth_stones.png", 
			"base_earth_permafrost.png", {name = "base_earth_permafrost.png" 
			.. "^base_earth_stones_side.png", tileable_vertical = false}},
		groups = {cracky = 3},
		sounds = sounds.get_defaults("earth_sounds:gravel"),
	} 
})

minetest.register_node("base_earth:gravel", {
	description = S("Gravel"),
	tiles = {"base_earth_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	is_ground_content = false,
	sounds = sounds.get_defaults("earth_sounds:gravel"),
	drop = {
		max_items = 1,
		items = {
			{items = {"base_earth:flint"}, rarity = 16},
			{items = {"base_earth:gravel"}}
		}
	}
})

minetest.register_craftitem("base_earth:flint", {
	description = S("Flint"),
	inventory_image = "base_earth_flint.png"
})

earth.register_ore("base_earth:gravel", {seed = 766})

earth.dirt_seeding_nodes = {
	["base_liquids:snow"] = "base_liquids:dirt_with_snow",
	["grass"] = "base_earth:dirt_with_grass",
	["dry_grass"] = "base_earth:dirt_with_dry_grass"
}

minetest.register_abm({
	label = "Grass spread",
	nodenames = {"base_earth:dirt"},
	neighbors = {
		"air",
		"group:grass",
		"group:dry_grass",
		"base_liquids:snow",
	},
	interval = 6,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end

		-- Look for spreading dirt-type neighbours
		local p2 = minetest.find_node_near(pos, 1, "group:spreading_dirt_type")
		if p2 then
			local n2 = minetest.get_node(p2)
			minetest.set_node(pos, {name = n2.name})
			return
		end

		-- Else, any seeding nodes on top?
		local name = minetest.get_node(above).name
		for seed, new in pairs(earth.dirt_seeding_nodes) do
			if seed:find(":") then
				if name == seed then
					return minetest.set_node(pos, {name = new})
				end
			elseif minetest.get_item_group(name, seed) ~= 0 then
				return minetest.set_node(pos, {name = new})
			end
		end
	end
})

minetest.register_abm({
	label = "Grass covered",
	nodenames = {"group:spreading_dirt_type", "base_earth:dry_dirt_with_dry_grass"},
	interval = 8,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			if node.name == "base_earth:dry_dirt_with_dry_grass" then
				minetest.set_node(pos, {name = "base_earth:dry_dirt"})
			else
				minetest.set_node(pos, {name = "base_earth:dirt"})
			end
		end
	end
})

minetest.register_craft({
	type = "shapeless",
	output = "base_earth:gravel",
	recipe = {"base_earth:stone_cobble"}
})
