-- steel_bar_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("wheat_stairs")

stairs.register_glass_all("steel_bar_stairs:block", {
	material = "steel_bars:bar",
	groups = {cracky = 1, oddly_breakable_by_hand = 3},
	sounds = sounds.get_defaults("ore_sounds:metal"),
	use_texture_alpha = "clip",
	worldaligntex = false,
	stair_description = S("Steel Bar Stair"),
	slab_description = S("Steel Bar Slab"),
	inner_stair_description = S("Inner Steel Bar Stair"),
	outer_stair_description = S("Outer Steel Bar Stair"),
	step_description = S("Steel Bar Step"),
	inner_step_description = S("Inner Steel Bar Step"),
	outer_step_description = S("Outer Steel Bar Step"),
	steps_description = S("Steel Bar Steps"),
	steps_half_description = S("Steel Bar Steps Half"),
	steps_slab_description = S("Steel Bar Steps Slab"),
	full = "steel_bars_bars.png",
	split = "steel_bar_stairs_block_split.png",
	stairside = "steel_bar_stairs_block_stairside.png",
	outer_stairside = "steel_bar_stairs_block_outer_side.png",
	quartered = "steel_bar_stairs_block_outer_side.png",
})
