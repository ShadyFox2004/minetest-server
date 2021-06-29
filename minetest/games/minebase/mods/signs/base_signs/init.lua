-- base_signs/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_signs")

signs.register_sign("base_signs:wood", {
	description = S("Wooden Sign"),
	sounds = sounds.get_defaults("tree_sounds:wood"),
	groups = {choppy = 2, attached_node = 1, flammable = 2, 
		oddly_breakable_by_hand = 3},
	material = "group:wood",
	burntime = 10
})

signs.register_sign("base_signs:steel", {
	description = S("Steel Sign"), 
	sounds = sounds.get_defaults("ore_sounds:metal"),
	groups = {cracky = 2, attached_node = 1},
	material = "base_ores:steel_ingot"
})

