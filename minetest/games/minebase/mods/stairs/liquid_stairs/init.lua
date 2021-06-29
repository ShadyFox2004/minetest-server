-- liquid_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("liquid_stairs")

stairs.register_all("liquid_stairs:obsidian", {
	material = "base_liquids:obsidian",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian.png"},
	stair_description = S("Obsidian Stair"),
	slab_description = S("Obsidian Slab"),
	inner_stair_description = S("Inner Obsidian Stair"),
	outer_stair_description = S("Outer Obsidian Stair"),
	step_description = S("Obsidian Step"),
	inner_step_description = S("Inner Obsidian Step"),
	outer_step_description = S("Outer Obsidian Step"),
	steps_description = S("Obsidian Steps"),
	steps_half_description = S("Obsidian Steps Half"),
	steps_slab_description = S("Obsidian Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("liquid_stairs:obsidian_brick", {
	material = "base_liquids:obsidian_brick",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian_brick.png"},
	stair_description = S("Obsidian Brick Stair"),
	slab_description = S("Obsidian Brick Slab"),
	inner_stair_description = S("Inner Obsidian Brick Stair"),
	outer_stair_description = S("Outer Obsidian Brick Stair"),
	step_description = S("Obsidian Brick Step"),
	inner_step_description = S("Inner Obsidian Brick Step"),
	outer_step_description = S("Outer Obsidian Brick Step"),
	steps_description = S("Obsidian Brick Steps"),
	steps_half_description = S("Obsidian Brick Steps Half"),
	steps_slab_description = S("Obsidian Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("liquid_stairs:obsidian_block", {
	material = "base_liquids:obsidian_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_liquids_obsidian_block.png"},
	stair_description = S("Obsidian Block Stair"),
	slab_description = S("Obsidian Block Slab"),
	inner_stair_description = S("Inner Obsidian Block Stair"),
	outer_stair_description = S("Outer Obsidian Block Stair"),
	step_description = S("Obsidian Block Step"),
	inner_step_description = S("Inner Obsidian Block Step"),
	outer_step_description = S("Outer Obsidian Block Step"),
	steps_description = S("Obsidian Block Steps"),
	steps_half_description = S("Obsidian Block Steps Half"),
	steps_slab_description = S("Obsidian Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("liquid_stairs:ice", {
	material = "base_liquids:ice",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	tiles = {"base_liquids_ice.png"},
	stair_description = S("Ice Stair"),
	slab_description = S("Ice Slab"),
	inner_stair_description = S("Inner Ice Stair"),
	outer_stair_description = S("Outer Ice Stair"),
	step_description = S("Ice Step"),
	inner_step_description = S("Inner Ice Step"),
	outer_step_description = S("Outer Ice Step"),
	steps_description = S("Ice Steps"),
	steps_half_description = S("Ice Steps Half"),
	steps_slab_description = S("Ice Steps Slab"),
	sounds = sounds.get_defaults("liquid_sounds:ice"),
	worldaligntex = true
})

stairs.register_all("liquid_stairs:snowblock", {
	material = "base_liquids:snowblock",
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	tiles = {"base_liquids_snow.png"},
	stair_description = S("Snow Block Stair"),
	slab_description = S("Snow Block Slab"),
	inner_stair_description = S("Inner Snow Block Stair"),
	outer_stair_description = S("Outer Snow Block Stair"),
	step_description = S("Snow Block Step"),
	inner_step_description = S("Inner Snow Block Step"),
	outer_step_description = S("Outer Snow Block Step"),
	steps_description = S("Snow Block Steps"),
	steps_half_description = S("Snow Block Steps Half"),
	steps_slab_description = S("Snow Block Steps Slab"),
	sounds = sounds.get_defaults("liquid_sounds:snow"),
	worldaligntex = true
})

