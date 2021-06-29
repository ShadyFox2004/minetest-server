-- steel_bar_xpanes/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("steel_bars")

xpanes.register_pane("steel_bar_xpanes:bars", {
	description = S("Steel Bars"),
	textures = {"steel_bars_bars.png", "", "steel_bars_bars_top.png"},
	inventory_image = "steel_bars_bars.png",
	wield_image = "steel_bars_bars.png",
	groups = {cracky=2},
	sounds = sounds.get_defaults("ore_sounds:metal"),
	recipe = {
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"}
	}
})
