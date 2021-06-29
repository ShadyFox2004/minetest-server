-- base_hydrophytes/init.lua

local S = minetest.get_translator("base_hydrophytes")

hydrophytes.register_phyte("base_hydrophytes:coral_green", {
	description = S("Green Coral"),
	root = "base_hydrophytes:coral_skeleton",
})

hydrophytes.register_phyte("base_hydrophytes:coral_pink", {
	description = S("Pink Coral"),
	root = "base_hydrophytes:coral_skeleton",
})

hydrophytes.register_phyte("base_hydrophytes:coral_cyan", {
	description = S("Cyan Coral"),
	root = "base_hydrophytes:coral_skeleton",
})

hydrophytes.register_coral("base_hydrophytes:coral_brown", {
	description = S("Brown Coral"),
	drop = "base_hydrophytes:coral_skeleton",
})

hydrophytes.register_coral("base_hydrophytes:coral_orange" , {
	description = S("Orange Coral"),
	drop = "base_hydrophytes:coral_skeleton",
})

hydrophytes.register_coral("base_hydrophytes:coral_skeleton" , {
	description = S("Coral Skeleton"),
})

hydrophytes.register_decoration("base_hydrophytes:corals", {
	place_on = {"base_earth:sand"},
	biomes = {
		"base_biomes:desert_ocean",
		"base_biomes:savanna_ocean",
		"base_biomes:rainforest_ocean",
	},
	y_max = -2,
	y_min = -8,
	decoration = {
		"base_hydrophytes:coral_green", "base_hydrophytes:coral_pink",
		"base_hydrophytes:coral_cyan", "base_hydrophytes:coral_brown",
		"base_hydrophytes:coral_orange", "base_hydrophytes:coral_skeleton",
	},
})

hydrophytes.register_phyte_set("base_hydrophytes:kelp", {
	phyte = {
		description = S("Kelp"),
		paramtype2 = "leveled",
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-2/16, 0.5, -2/16, 2/16, 0.7, 2/16},
			},
		},
		sounds = sounds.get_defaults("earth_sounds:sand", {
			dig = {name = "base_sounds_dig_snappy", gain = 0.2},
			dug = {name = "base_earth_grass_footstep", gain = 0.25},
		}),
		root = "base_earth:sand",
		max = {4,6}
	},
	deco = {
		place_on = {"base_earth:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"base_biomes:taiga_ocean",
			"base_biomes:snowy_grassland_ocean",
			"base_biomes:grassland_ocean",
			"base_biomes:coniferous_forest_ocean",
			"base_biomes:deciduous_forest_ocean",
			"base_biomes:sandstone_desert_ocean",
			"base_biomes:cold_desert_ocean"},
		param2 = 48,
		param2_max = 96,
	}
})
