-- tree_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("tree_stairs")

stairs.register_all("tree_stairs:apple_wood", {
	material = "base_trees:apple_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_apple_wood.png"},
	stair_description = S("Wooden Stair"),
	slab_description = S("Wooden Slab"),
	inner_stair_description = S("Inner Wooden Stair"),
	outer_stair_description = S("Outer Wooden Stair"),
	step_description = S("Wooden Step"),
	inner_step_description = S("Inner Wooden Step"),
	outer_step_description = S("Outer Wooden Step"),
	steps_description = S("Wooden Steps"),
	steps_half_description = S("Wooden Steps Half"),
	steps_slab_description = S("Wooden Steps Slab"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	worldaligntex = true
})

stairs.register_all("tree_stairs:jungle_wood", {
	material = "base_trees:jungle_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_jungle_wood.png"},
	stair_description = S("Jungle Wood Stair"),
	slab_description = S("Jungle Wood Slab"),
	inner_stair_description = S("Inner Jungle Wood Stair"),
	outer_stair_description = S("Outer Jungle Wood Stair"),
	step_description = S("Jungle Wood Step"),
	inner_step_description = S("Inner Jungle Wood Step"),
	outer_step_description = S("Outer Jungle Wood Step"),
	steps_description = S("Jungle Wood Steps"),
	steps_half_description = S("Jungle Wood Steps Half"),
	steps_slab_description = S("Jungle Wood Steps Slab"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	worldaligntex = true
})

stairs.register_all("tree_stairs:pine_wood", {
	material = "base_trees:pine_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	tiles = {"base_trees_pine_wood.png"},
	stair_description = S("Pine Wood Stair"),
	slab_description = S("Pine Wood Slab"),
	inner_stair_description = S("Inner Pine Wood Stair"),
	outer_stair_description = S("Outer Pine Wood Stair"),
	step_description = S("Pine Wood Step"),
	inner_step_description = S("Inner Pine Wood Step"),
	outer_step_description = S("Outer Pine Wood Step"),
	steps_description = S("Pine Wood Steps"),
	steps_half_description = S("Pine Wood Steps Half"),
	steps_slab_description = S("Pine Wood Steps Slab"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	worldaligntex = true
})

stairs.register_all("tree_stairs:acacia_wood", {
	material = "base_trees:acacia_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	tiles = {"base_trees_acacia_wood.png"},
	stair_description = S("Acacia Wood Stair"),
	slab_description = S("Acacia Wood Slab"),
	inner_stair_description = S("Inner Acacia Wood Stair"),
	outer_stair_description = S("Outer Acacia Wood Stair"),
	step_description = S("Acacia Wood Step"),
	inner_step_description = S("Inner Acacia Wood Step"),
	outer_step_description = S("Outer Acacia Wood Step"),
	steps_description = S("Acacia Wood Steps"),
	steps_half_description = S("Acacia Wood Steps Half"),
	steps_slab_description = S("Acacia Wood Steps Slab"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	worldaligntex = true
})

stairs.register_all("tree_stairs:aspen_wood", {
	material = "base_trees:aspen_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	tiles = {"base_trees_aspen_wood.png"},
	stair_description = S("Aspen Wood Stair"),
	slab_description = S("Aspen Wood Slab"),
	inner_stair_description = S("Inner Aspen Wood Stair"),
	outer_stair_description = S("Outer Aspen Wood Stair"),
	step_description = S("Aspen Wood Step"),
	inner_step_description = S("Inner Aspen Wood Step"),
	outer_step_description = S("Outer Aspen Wood Step"),
	steps_description = S("Aspen Wood Steps"),
	steps_half_description = S("Aspen Wood Steps Half"),
	steps_slab_description = S("Aspen Wood Steps Slab"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	worldaligntex = true
})
