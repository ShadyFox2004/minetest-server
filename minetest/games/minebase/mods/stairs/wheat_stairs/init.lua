-- wheat_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("wheat_stairs")

stairs.register_all("wheat_stairs:straw", {
	stair_description = S("Straw Stair"),
	slab_description = S("Straw Slab"), 
	inner_stair_description = S("Inner Straw Stair"),
	outer_stair_description = S("Outer Straw Stair"),
	step_description = S("Straw Step"),
	inner_step_description = S("Inner Straw Step"),
	outer_step_description = S("Outer Straw Step"),
	steps_description = S("Straw Steps"),
	steps_half_description = S("Straw Steps Half"),
	steps_slab_description = S("Straw Steps Slab"),
	material = "wheat:straw",
	groups = {snappy = 3, flammable = 4},
	tiles = {"wheat_straw.png"},
	sounds = sounds.get_defaults("tree_sounds:leaves"),
	worldaligntex = true
})

