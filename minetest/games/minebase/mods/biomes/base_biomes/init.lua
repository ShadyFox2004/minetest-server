-- base_biomes/init.lua 

biomes.define_default({
	stone_cobble = "base_earth:stone_cobble",
	mossy_stone_cobble = "mossy:stone_cobble",
	sand = "base_earth:sand",
	water = "base_liquids:water_source",
	lava = "base_liquids:lava_source",
	stone_cobble_stair = "earth_stairs:stone_cobble_stair"
})

-- Icesheet

biomes.register_biome_set("base_biomes:icesheet", {
	surface = {
		node_dust = "base_liquids:snow_block",
		node_top = "base_liquids:snow_block",
		node_filler = "base_liquids:snow_block",
		node_stone = "base_liquids:cave_ice",
		node_water_top = "base_liquids:ice",
		depth_water_top = 10,
		node_river_water = "base_liquids:ice",
		node_riverbed = "base_earth:gravel",
		node_dungeon = "base_liquids:ice",
		node_dungeon_stair = "liquid_stairs:ice_stair",
		y_min = -8,
		heat_point = 0,
		humidity_point = 73
	}, 
	ocean = {
		node_dust = "base_liquids:snow_block",
		node_water_top = "base_liquids:ice",
		depth_water_top = 10,
		y_max = -9,
	},
	under = {}
})

-- Tundra

biomes.register_biome("base_biomes:tundra_highland", {
	node_dust = "base_liquids:snow",
	node_top = "base_earth:permafrost_with_stones",
	node_riverbed = "base_earth:gravel",
	y_min = 47,
	heat_point = 0,
	humidity_point = 40,
})

biomes.register_biome_set("base_biomes:tundra", {
	surface = {
		node_top = "base_earth:permafrost_with_stones",
		node_filler = "base_earth:permafrost",
		depth_filler = 1,
		node_riverbed = "base_earth:gravel",
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40
	},
	ocean = {
		node_riverbed = "base_earth:gravel",
		y_max = -4,
	},
	under = {}
})

biomes.register_biome("base_biomes:tundra_beach", {
	node_top = "base_earth:gravel",
	node_filler = "base_earth:gravel",
	depth_filler = 2,
	node_riverbed = "base_earth:gravel",
	vertical_blend = 1,
	y_max = 1,
	y_min = -3,
	heat_point = 0,
	humidity_point = 40,
})

-- Taiga

biomes.register_biome_set("base_biomes:taiga", {
	surface = {
		node_dust = "base_liquids:snow",
		node_top = "base_liquids:dirt_with_snow",
		node_filler = "base_earth:dirt",
		y_min = 4,
		heat_point = 25,
		humidity_point = 70
	},
	ocean = {
		node_dust = "base_liquids:snow",
		y_max = 3,
	},
	under = {}
})

-- Snowy grassland

biomes.register_biome_set("base_biomes:snowy_grassland", {
	surface = {
		node_dust = "base_liquids:snow",
		node_top = "base_liquids:dirt_with_snow",
		node_filler = "base_earth:dirt",
		depth_filler = 1,
		y_min = 4,
		heat_point = 20,
		humidity_point = 35
	}, 
	ocean = {
		node_dust = "base_liquids:snow",
		y_max = 3,
	},
	under = {}
})

-- Grassland

biomes.register_biome_set("base_biomes:grassland", {
	surface = {
		node_top = "base_earth:dirt_with_grass",
		node_filler = "base_earth:dirt",
		depth_filler = 1,
		y_min = 6,
		humidity_point = 35
	},
	ocean = {
		y_max = 3,
		humidity_point = 35,
	},
	under = {}
})

biomes.register_biome("base_biomes:grassland_dunes", {
	node_top = "base_earth:sand",
	node_filler = "base_earth:sand",
	depth_filler = 2,
	vertical_blend = 1,
	y_max = 5,
	y_min = 4,
	humidity_point = 35,
})

-- Coniferous forest

biomes.register_biome_set("base_biomes:coniferous_forest", {
	surface = {
		node_top = "base_earth:dirt_with_coniferous_litter",
		node_filler = "base_earth:dirt",
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	},
	ocean = {
		y_max = 3,
	},
	under = {}
})

biomes.register_biome("base_biomes:coniferous_forest_dunes", {
	node_top = "base_earth:sand",
	node_filler = "base_earth:sand",
	vertical_blend = 1,
	y_max = 5,
	y_min = 4,
	heat_point = 45,
	humidity_point = 70,
})

-- Deciduous forest

biomes.register_biome_set("base_biomes:deciduous_forest", {
	surface = {
		node_top = "base_earth:dirt_with_grass",
		node_filler = "base_earth:dirt",
		heat_point = 60,
		humidity_point = 68,
	},
	ocean = {
		y_max = -2,
	},
	under = {
		heat_point = 92,
		humidity_point = 16,
	}
})

biomes.register_biome("base_biomes:deciduous_forest_shore", {
	node_top = "base_earth:dirt",
	node_filler = "base_earth:dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 60,
	humidity_point = 68,
})

-- Sandstone desert

biomes.register_biome_set("base_biomes:sandstone_desert", {
	surface = {
		node_top = "base_earth:sand",
		node_filler = "base_earth:sand",
		depth_filler = 1,
		node_stone = "base_earth:sandstone",
		node_dungeon = "base_earth:sandstonebrick",
		node_dungeon_stair = "earth_stairs:sandstone_block_stair",
		y_min = 4,
		heat_point = 60,
		humidity_point = 0,
	}, 
	ocean = {
		node_stone = "base_earth:sandstone",
		node_dungeon = "base_earth:sandstonebrick",
		node_dungeon_stair = "earth_stairs:sandstone_block_stair",
		y_max = 3,
	},
	under = {}
})

-- Cold desert

biomes.register_biome_set("base_biomes:cold_desert", {
	surface = {
		node_top = "base_earth:silver_sand",
		node_filler = "base_earth:silver_sand",
		depth_filler = 1,
		y_min = 4,
		heat_point = 40,
		humidity_point = 0,
	},
	ocean = {
		y_max = 3,
	},
	under = {}
})

-- Savanna

biomes.register_biome_set("base_biomes:savanna", {
	surface = {
		node_top = "base_earth:dry_dirt_with_dry_grass",
		node_filler = "base_earth:dry_dirt",
		depth_filler = 1,
		heat_point = 89,
		humidity_point = 42,
	},
	ocean = {
		y_max = -2,
	},
	under = {}
})

biomes.register_biome("base_biomes:savanna_shore", {
	node_top = "base_earth:dry_dirt",
	node_filler = "base_earth:dry_dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 89,
	humidity_point = 42,
})

-- Rainforest

biomes.register_biome_set("base_biomes:rainforest", {
	surface = {
		node_top = "base_earth:dirt_with_rainforest_litter",
		node_filler = "base_earth:dirt",
		heat_point = 86,
		humidity_point = 65,
	},
	ocean = {
		y_max = -2,
	},
	under = {}
})

biomes.register_biome("base_biomes:rainforest_swamp", {
	node_top = "base_earth:dirt",
	node_filler = "base_earth:dirt",
	y_max = 0,
	y_min = -1,
	heat_point = 86,
	humidity_point = 65,
})


-- stratum ores

biomes.register_stratum("base_earth:silver_sandstone", {
	wherein = {"base_earth:stone"},
	y_max = 46,
	y_min = 10,
	offset = 28,
	biomes = {"base_biomes:cold_desert"}
})

biomes.register_stratum("base_earth:silver_sandstone", {
	wherein = {"base_earth:stone"},
	y_max = 42,
	y_min = 6,
	offset = 24,
	biomes = {"base_biomes:cold_desert"}
})

biomes.register_stratum("base_earth:desert_sandstone", {
	wherein = {"base_earth:desert_stone"},
	y_max = 46,
	y_min = 10,
	offset = 28,
	biomes = {"base_biomes:desert"}
})

biomes.register_stratum("base_earth:desert_sandstone", {
	wherein = {"base_earth:desert_stone"},
	y_max = 42,
	y_min = 6,
	offset = 24,
	biomes = {"base_biomes:desert"}
})

biomes.register_stratum("base_earth:sandstone", {
	wherein = {"base_earth:desert_stone"},
	y_max = 39,
	y_min = 3,
	offset = 21,
	biomes = {"base_biomes:desert"}
})

