-- meselamps/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("meselamps")

lights.register_light("meselamps:lamp", {
	description = S("Mese Lamp"),
	tiles = {"meselamps_lamp.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = sounds.get_defaults("glass_sounds:glass"),
	recipe = {
		{"base_glass:common_glass"},
		{"base_ores:mese_crystal"},
	}
})

