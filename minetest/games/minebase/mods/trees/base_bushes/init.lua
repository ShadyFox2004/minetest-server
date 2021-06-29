-- base_bushes/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_bushes")
local base_bushes_path = minetest.get_modpath("base_bushes")

-- apple bush
trees.register_bush("base_bushes:apple", {
	stem = {
		description = S("Bush Stem"),
		burntime = 7
	},
	leaves = {
		description = S("Bush Leaves"),
	},
	sapling = {
		description = S("Bush Sapling"),
		burntime = 3,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16}
		},
		minp = {x = -1, y = 0, z = -1},
		maxp = {x = 1, y = 1, z = 1},
		max_interval = 2,
		grow_sapling = function(pos)
			local path = base_bushes_path .. "/schematics/base_bushes_apple.mts"
			minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				path, "0", nil, false)
		end
	},
	deco = {
		place_on = {"base_earth:dirt_with_grass"},
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"base_biomes:grassland", "base_biomes:deciduous_forest"},
		schematic = base_bushes_path .. "/schematics/base_bushes_apple.mts",
	}
})

minetest.register_craft({
	output = "base_trees:apple_wood",
	recipe = {{"base_bushes:apple_bush_stem"}}
})

-- acacia bush
trees.register_bush("base_bushes:acacia", { 
	stem = {
		description = S("Acacia Bush Stem"),
		burntime = 8
	},
	leaves = {
		description = S("Acacia Bush Leaves"),
	},
	sapling = {
		description = S("Acacia Bush Sapling"),
		burntime = 4,
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -0.3, 3 / 16}
		},
		minp =	{x = -1, y = 0, z = -1},
		maxp = {x = 1, y = 1, z = 1},
		max_interval = 2,
		grow_sapling = function(pos)
			local path = base_bushes_path .. "/schematics/base_bushes_acacia.mts"
			minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				path, "0", nil, false)
		end
	},
	deco = {
		place_on = {"base_earth:dry_dirt_with_dry_grass"},
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 90155,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"base_biomes:savanna"},
		schematic = base_bushes_path .. "/schematics/base_bushes_acacia.mts",
	}
})

minetest.register_craft({
	output = "base_trees:acacia_wood",
	recipe = {{"base_bushes:acacia_bush_stem"}}
})

-- pine bush
trees.register_bush("base_bushes:pine", { 
	stem = {
		description = S("Pine Bush Stem"),
		burntime = 6
	},
	leaves = {
		description = S("Pine Bush Needles"),
		tiles = {"base_bushes_pine_bush_needles.png"},
		special_tiles = {"base_bushes_pine_bush_needles_simple.png"},
		drop = {
			max_items = 1,
			items = {
				{items = {"base_bushes:pine_bush_sapling"}, rarity = 5},
				{items = {"base_bushes:pine_bush_leaves"}}
			}
		}
	},
	sapling = {
		description = S("Pine Bush Sapling"),
		burntime = 2,
		minp = {x = -1, y = 0, z = -1},
		maxp = {x = 1, y = 1, z = 1},
		max_interval = 2,
		grow_sapling = function(pos)
			local path = base_bushes_path .. "/schematics/base_bushes_pine.mts"
			minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				path, "0", nil, false)
		end
	},
	deco = {
		place_on = {"base_liquids:dirt_with_snow"},
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"base_biomes:taiga", "base_biomes:snowy_grassland"},
		y_min = 4,
		schematic = base_bushes_path .. "/schematics/base_bushes_pine.mts",
	}
})

minetest.register_craft({
	output = "base_trees:pine_wood",
	recipe = {{"base_bushes:pine_bush_stem"}}
})

-- Blueberry bush
trees.register_bush("base_bushes:blueberry", {
	leaves = {
		description = S("Blueberry Bush Leaves"),
		no_decay = true,
		drop = {
			max_items = 1,
			items = {
				{items = {"base_bushes:blueberry_bush_sapling"}, rarity = 5},
				{items = {"base_bushes:blueberry_bush_leaves"}}
			}
		},
		on_timer = function(pos, elapsed)
			if minetest.get_node_light(pos) < 11 then
				minetest.get_node_timer(pos):start(200)
			else
				minetest.set_node(pos, {name 
					= "base_bushes:blueberry_bush_with_berries_leaves"})
			end
		end
	},
	sapling = {
		description = S("Blueberry Bush Sapling"),
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16}
		},
		minp = {x = -1, y = 0, z = -1},
		maxp = {x = 1, y = 1, z = 1},
		max_interval = 2,
		grow_sapling = function(pos)
			local path = base_bushes_path .. "/schematics/base_bushes_blueberry.mts"
			minetest.place_schematic({x = pos.x - 1, y = pos.y, z = pos.z - 1},
				path, "0", nil, false)
		end
	},
	deco = {
		place_on = {"base_earth:dirt_with_grass", "base_liquids:dirt_with_snow"},
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 697,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"base_biomes:grassland", "base_biomes:snowy_grassland"},
		place_offset_y = 1,
		schematic = base_bushes_path .. "/schematics/base_bushes_blueberry.mts",
	}
})

trees.register_leaves("base_bushes:blueberry_bush_with_berries", { 
	description = S("Blueberry Bush Leaves with Berries"),
	tiles = {"base_bushes_blueberry_bush_leaves.png" 
		.. "^base_bushes_blueberry_bush_overlay.png"},
	special_tiles = {"base_bushes_blueberry_bush_leaves.png" 
		.. "^base_bushes_blueberry_bush_overlay.png"},
	drop = "base_bushes:blueberries",
	no_decay = true,
	node_dig_prediction = "base_bushes:blueberry_bush_leaves",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name = "base_bushes:blueberry_bush_leaves"})
		minetest.get_node_timer(pos):start(rand.az(300, 1500))
	end,
})

minetest.register_craftitem("base_bushes:blueberries", {
	description = S("Blueberries"),
	inventory_image = "base_bushes_blueberries.png",
	groups = {food_blueberries = 1, food_berry = 1},
	on_use = minetest.item_eat(2),
})

-- dry shrub

trees.register_bush("base_bushes:dry", {
	stem = {
		description = S("Dry Shrub"),
		visual_scale = 1,
		waving = 1,
		paramtype2 = "meshoptions",
		place_param2 = 4,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1},
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.3, 6 / 16},
		},
		burntime = 2
	},
	deco = {
		deco_type = "simple",
		place_on = {"base_earth:desert_sand", "base_earth:sand", 
			"base_earth:silver_sand"},
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"base_biomes:desert", "base_biomes:sandstone_desert", 
			"base_biomes:cold_desert"},
		y_min = 2,
		decoration = "base_bushes:dry",
		param2 = 4,
	}
})

