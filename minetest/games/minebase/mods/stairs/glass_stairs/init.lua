-- glass_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("glass_stairs")

stairs.register_glass_all("glass_stairs:common_glass", {
	material = "base_glass:common_glass",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sounds.get_defaults("glass_sounds:glass"),
	worldaligntex = false,
	stair_description = S("Glass Stair"),
	slab_description = S("Glass Slab"),
	inner_stair_description = S("Inner Glass Stair"),
	outer_stair_description = S("Outer Glass Stair"),
	step_description = S("Glass Step"),
	inner_step_description = S("Inner Glass Step"),
	outer_step_description = S("Outer Glass Step"),
	steps_description = S("Glass Steps"),
	steps_half_description = S("Glass Steps Half"),
	steps_slab_description = S("Glass Steps Slab"),
	full = "base_glass_common_glass.png",
	split = "glass_stairs_common_split.png",
	stairside = "glass_stairs_common_stairside.png",
	outer_stairside = "glass_stairs_common_outer_stairside.png",
	quartered = "glass_stairs_common_quartered.png",
})

stairs.register_glass_all("glass_stairs:obsidian_glass", {
	material = "base_glass:obsidian_glass",
	groups = {cracky = 3},
	sounds = sounds.get_defaults("glass_sounds:glass"),
	worldaligntex = false,
	stair_description = S("Obsidian Glass Stair"),
	slab_description = S("Obsidian Glass Slab"),
	inner_stair_description = S("Inner Obsidian Glass Stair"),
	outer_stair_description = S("Outer Obsidian Glass Stair"),
	step_description = S("Obsidian Glass Step"),
	inner_step_description = S("Inner Obsidian Glass Step"),
	outer_step_description = S("Outer Obsidian Glass Step"),
	steps_description = S("Obsidian Glass Steps"),
	steps_half_description = S("Obsidian Glass Steps Half"),
	steps_slab_description = S("Obsidian Glass Steps Slab"),
	full = "base_glass_obsidian_glass.png",
	split = "glass_stairs_obsidian_split.png",
	stairside = "glass_stairs_obsidian_stairside.png",
	outer_stairside = "glass_stairs_obsidian_outer_stairside.png",
	quartered = "glass_stairs_obsidian_quartered.png",
})

