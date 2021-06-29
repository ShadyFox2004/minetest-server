-- base_trapdoors/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_trapdoors")

doors.register_trapdoor("base_trapdoors:wood", {
	description = S("Wooden Trapdoor"),
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
})

doors.register_trapdoor("base_trapdoors:steel", {
	description = S("Steel Trapdoor"),
	protected = true,
	sounds = sounds.get_defaults("ore_sounds:metal"),
	sound_open = "doors_api_steel_open",
	sound_close = "doors_api_steel_close",
	groups = {cracky = 1, level = 2, door = 1},
})

minetest.register_craft({
	output = "base_trapdoors:wood 2",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "base_trapdoors:steel",
	recipe = {
		{"base_ores:steel_ingot", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:steel_ingot"},
	}
})

----fuels----

minetest.register_craft({
	type = "fuel",
	recipe = "base_trapdoors:wood",
	burntime = 7,
})

