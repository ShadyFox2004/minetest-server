-- base_doors/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_doors")

doors.register_door("base_doors:wood", {
	description = S("Wooden Door"),
	groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	recipe = {
		{"group:wood", "group:wood"},
		{"group:wood", "group:wood"},
		{"group:wood", "group:wood"},
	}
})

doors.register_door("base_doors:steel", {
		description = S("Steel Door"),
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = sounds.get_defaults("ore_sounds:metal"),
		sound_open = "doors_api_steel_open",
		sound_close = "doors_api_steel_close",
		recipe = {
			{"base_ores:steel_ingot", "base_ores:steel_ingot"},
			{"base_ores:steel_ingot", "base_ores:steel_ingot"},
			{"base_ores:steel_ingot", "base_ores:steel_ingot"},
		}
})

doors.register_door("base_doors:glass", {
		tiles = {"base_doors_glass.png"},
		description = S("Glass Door"),
		groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
		sounds = sounds.get_defaults("glass_sounds:glass"),
		sound_open = "doors_api_glass_open",
		sound_close = "doors_api_glass_close",
		recipe = {
			{"base_glass:common_glass", "base_glass:common_glass"},
			{"base_glass:common_glass", "base_glass:common_glass"},
			{"base_glass:common_glass", "base_glass:common_glass"},
		}
})

doors.register_door("base_doors:obsidian_glass", {
		tiles = {"base_doors_obsidian_glass.png"},
		description = S("Obsidian Glass Door"),
		groups = {node = 1, cracky=3},
		sounds = sounds.get_defaults("glass_sounds:glass"),
		sound_open = "doors_api_glass_open",
		sound_close = "doors_api_glass_close",
		recipe = {
			{"base_glass:obsidian_glass", "base_glass:obsidian_glass"},
			{"base_glass:obsidian_glass", "base_glass:obsidian_glass"},
			{"base_glass:obsidian_glass", "base_glass:obsidian_glass"},
		},
})

----fuels----

minetest.register_craft({
	type = "fuel",
	recipe = "base_doors:wood",
	burntime = 14,
})

