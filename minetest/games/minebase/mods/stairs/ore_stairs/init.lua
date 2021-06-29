-- ore_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("ore_stairs")

stairs.register_all("ore_stairs:steel_block", {
	material = "base_ores:steel_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_steel_block.png"},
	stair_description = S("Steel Block Stair"),
	slab_description = S("Steel Block Slab"),
	inner_stair_description = S("Inner Steel Block Stair"),
	outer_stair_description = S("Outer Steel Block Stair"),
	step_description = S("Steel Block Step"),
	inner_step_description = S("Inner Steel Block Step"),
	outer_step_description = S("Outer Steel Block Step"),
	steps_description = S("Steel Block Steps"),
	steps_half_description = S("Steel Block Steps Half"),
	steps_slab_description = S("Steel Block Steps Slab"),
	sounds = sounds.get_defaults("ore_sounds:metal"),
	worldaligntex = true
})

stairs.register_all("ore_stairs:tin_block", {
	material = "base_ores:tin_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_tin_block.png"},
	stair_description = S("Tin Block Stair"),
	slab_description = S("Tin Block Slab"),
	inner_stair_description = S("Inner Tin Block Stair"),
	outer_stair_description = S("Outer Tin Block Stair"),
	step_description = S("Tin Block Step"),
	inner_step_description = S("Inner Tin Block Step"),
	outer_step_description = S("Outer Tin Block Step"),
	steps_description = S("Tin Block Steps"),
	steps_half_description = S("Tin Block Steps Half"),
	steps_slab_description = S("Tin Block Steps Slab"),
	sounds = sounds.get_defaults("ore_sounds:metal"),
	worldaligntex = true
})

stairs.register_all("ore_stairs:copper_block", {
	material = "base_ores:copper_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_copper_block.png"},
	stair_description = S("Copper Block Stair"),
	slab_description = S("Copper Block Slab"),
	inner_stair_description = S("Inner Copper Block Stair"),
	outer_stair_description = S("Outer Copper Block Stair"),
	step_description = S("Copper Block Step"),
	inner_step_description = S("Inner Copper Block Step"),
	outer_step_description = S("Outer Copper Block Step"),
	steps_description = S("Copper Block Steps"),
	steps_half_description = S("Copper Block Steps Half"),
	steps_slab_description = S("Copper Block Steps Slab"),
	sounds = sounds.get_defaults("ore_sounds:metal"),
	worldaligntex = true
})

stairs.register_all("ore_stairs:bronze_block", {
	material = "base_ores:bronze_block",
	groups = {cracky = 1, level = 2},
	tiles = {"base_ores_bronze_block.png"},
	stair_description = S("Bronze Block Stair"),
	slab_description = S("Bronze Block Slab"),
	inner_stair_description = S("Inner Bronze Block Stair"),
	outer_stair_description = S("Outer Bronze Block Stair"),
	step_description = S("Bronze Block Step"),
	inner_step_description = S("Inner Bronze Block Step"),
	outer_step_description = S("Outer Bronze Block Step"),
	steps_description = S("Bronze Block Steps"),
	steps_half_description = S("Bronze Block Steps Half"),
	steps_slab_description = S("Bronze Block Steps Slab"),
	sounds = sounds.get_defaults("ore_sounds:metal"),
	worldaligntex = true
})

stairs.register_all("ore_stairs:gold_block", {
	material = "base_ores:gold_block",
	groups = {cracky = 1},
	tiles = {"base_ores_gold_block.png"},
	stair_description = S("Gold Block Stair"),
	slab_description = S("Gold Block Slab"),
	inner_stair_description = S("Inner Gold Block Stair"),
	outer_stair_description = S("Outer Gold Block Stair"),
	step_description = S("Gold Block Step"),
	inner_step_description = S("Inner Gold Block Step"),
	outer_step_description = S("Outer Gold Block Step"),
	steps_description = S("Gold Block Steps"),
	steps_half_description = S("Gold Block Steps Half"),
	steps_slab_description = S("Gold Block Steps Slab"),
	sounds = sounds.get_defaults("ore_sounds:metal"),
	worldaligntex = true
})
