-- clay_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("clay_stairs")

stairs.register_all("clay_stairs:brick", {
	stair_description = S("Brick Stair"),
	slab_description = S("Brick Slab"),
	inner_stair_description = S("Inner Brick Stair"),
	outer_stair_description = S("Outer Brick Stair"),
	inner_step_description = S("Inner Brick Step"),
	outer_step_description = S("Outer Brick Step"),
	step_description = S("Brick Step"),
	steps_description = S("Brick Steps"),
	steps_half_description = S("Brick Steps Half"),
	steps_slab_description = S("Brick Steps Slab"),
	material = "clay:brick_block",
	groups = {cracky = 3},
	tiles = {"clay_brick_block.png"},
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})
