-- base_grasses/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_grasses")

grasses.register_grass_set("base_grasses:grass", {
	first = {
		description = S("Grass"),
		grass_type = "normal_grass"
	},
	other = {},
	max = 5
})

grasses.register_grass_set("base_grasses:dry_grass", {
	first = {
		description = S("Dry Grass"),
		grass_type = "dry_grass",
	},
	other = {},
	max = 5
})

grasses.register_grass_set("base_grasses:fern", {
	first = {
		description = S("Fern"),
		grass_type = "fern"
	},
	other = {
		visual_scale = 2,
	},
	max = 3
})

grasses.register_grass_set("base_grasses:marram_grass", {
	first = {
		description = S("Marram Grass"),
		grass_type = "marram_grass"
	},
	other = {},
	max = 3,
	deco = {
		sidelen = 4,
		place_on = {"base_earth:sand"},
		biomes = {"base_biomes:coniferous_forest_dunes", "base_biomes:grassland_dunes"},
		noise_params = {
			offset = -0.7,
			scale = 4.0,
			spread = {x = 16, y = 16, z = 16},
			seed = 513337,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
		y_max = 6,
		y_min = 4,
		decoration = {
			"base_grasses:marram_grass_1",
			"base_grasses:marram_grass_2",
			"base_grasses:marram_grass_3",
		},
	}
})

grasses.register_grass_set("base_grasses:jungle_grass", {
	first = {
		description = S("Jungle Grass"),
		visual_scale = 1.69,
		burntime = 3,
		grass_type = "jungle_grass"
	},
	other = {},
	max = 3,
	deco = {
		place_on = {"base_earth:dirt_with_rainforest_litter"},
		sidelen = 80,
		biomes = {"base_biomes:rainforest"},
		fill_ratio = 0.1,
		decoration = {
			"base_grasses:jungle_grass_1",
			"base_grasses:jungle_grass_2",
			"base_grasses:jungle_grass_3"
		}
	}
})

local function register_grass_decoration(offset, scale, length)
	grasses.register_decoration("base_grasses:grass", {
		place_on = {"base_earth:dirt_with_grass"},
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"base_biomes:grassland", "base_biomes:deciduous_forest"},
		i = length,
	})
end

register_grass_decoration(-0.03,  0.09,  5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0,      0.06,  3)
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)

local function register_dry_grass_decoration(offset, scale, length)
	grasses.register_decoration("base_grasses:dry_grass", {
		place_on = {"base_earth:dry_dirt_with_dry_grass"},
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"base_biomes:savanna"},
		i = length
	})
end

register_dry_grass_decoration(0.01, 0.05,  5)
register_dry_grass_decoration(0.03, 0.03,  4)
register_dry_grass_decoration(0.05, 0.01,  3)
register_dry_grass_decoration(0.07, -0.01, 2)
register_dry_grass_decoration(0.09, -0.03, 1)

local function register_fern_decoration(seed, length)
	grasses.register_decoration("base_grasses:fern", {
		place_on = {"base_earth:dirt_with_coniferous_litter"},
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"base_biomes:coniferous_forest"},
		y_min = 6,
		i = length
	})
end

register_fern_decoration(14936, 3)
register_fern_decoration(801,   2)
register_fern_decoration(5,     1)

--
-- Papyrus
--

minetest.register_node("base_grasses:papyrus", {
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"base_grasses_papyrus.png"},
	inventory_image = "base_grasses_papyrus.png",
	wield_image = "base_grasses_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = sounds.get_defaults("tree_sounds:leaves"),

	after_dig_node = function(pos, node, _, digger)
		grasses.dig_up(pos, node, digger)
	end,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_grasses:papyrus",
	burntime = 3,
})

local function grow_papyrus(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	if name ~= "base_earth:dirt" and
			name ~= "base_earth:dirt_with_grass" and
			name ~= "base_earth:dirt_with_dry_grass" and
			name ~= "base_earth:dirt_with_rainforest_litter" and
			name ~= "base_earth:dry_dirt" and
			name ~= "base_earth:dry_dirt_with_dry_grass" then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "base_grasses:papyrus" and height < 4 do
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
	minetest.set_node(pos, {name = "base_grasses:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"base_grasses:papyrus"},
	-- Grows on the dirt and surface dirt nodes of the biomes papyrus appears in,
	-- including the old savanna nodes.
	-- 'base_earth:dirt_with_grass' is here only because it was allowed before.
	neighbors = {
		"base_earth:dirt",
		"base_earth:dirt_with_grass",
		"base_earth:dirt_with_dry_grass",
		"base_earth:dirt_with_rainforest_litter",
		"base_earth:dry_dirt",
		"base_earth:dry_dirt_with_dry_grass",
	},
	interval = 14,
	chance = 71,
	action = grow_papyrus
})

local modpath = minetest.get_modpath("base_grasses")
minetest.register_decoration({
	name = "base_grasses:papyrus_on_dirt",
	deco_type = "schematic",
	place_on = {"base_earth:dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"base_biomes:rainforest_swamp"},
	y_max = 0,
	y_min = 0,
	schematic =  modpath .. "/schematics/base_grasses_papyrus_on_dirt.mts",
})

minetest.register_decoration({
	name = "base_grasses:papyrus_on_dry_dirt",
	deco_type = "schematic",
	place_on = {"base_earth:dry_dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"base_biomes:savanna_shore"},
	y_max = 0,
	y_min = 0,
	schematic = modpath .. "/schematics/base_grasses_papyrus_on_dry_dirt.mts",
})

