-- glass_xpanes/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("glass_xpanes")

xpanes.register_pane("glass_xpanes:glass", {
	description = S("Glass Pane"),
	textures = {"base_glass_common_glass.png", "", "glass_xpanes_common_edge.png"},
	inventory_image = "base_glass_common_glass.png",
	wield_image = "base_glass_common_glass.png",
	sounds = sounds.get_defaults("glass_sounds:glass"),
	groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3},
	recipe = {
		{"base_glass:common_glass", "base_glass:common_glass", "base_glass:common_glass"},
		{"base_glass:common_glass", "base_glass:common_glass", "base_glass:common_glass"}
	}
})

xpanes.register_pane("glass_xpanes:obsidian", {
	description = S("Obsidian Glass Pane"),
	textures = {"base_glass_obsidian_glass.png", "", 
		"glass_xpanes_obsidian_edge.png"},
	inventory_image = "base_glass_obsidian_glass.png",
	wield_image = "base_glass_obsidian_glass.png",
	sounds = sounds.get_defaults("glass_sounds:glass"),
	groups = {snappy=2, cracky=3},
	recipe = {
		{"base_glass:obsidian_glass", "base_glass:obsidian_glass", "base_glass:obsidian_glass"},
		{"base_glass:obsidian_glass", "base_glass:obsidian_glass", "base_glass:obsidian_glass"}
	}
})
