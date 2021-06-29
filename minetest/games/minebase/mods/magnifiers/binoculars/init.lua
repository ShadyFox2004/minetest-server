-- binoculars/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("binoculars")

magnifiers.register_magnifier("binoculars:binoculars", {
	description = S("Binoculars"),
	recipe = {
		{"base_glass:obsidian", "", "base_glass:obsidian"},
		{"base_ores:bronze_ingot", "base_ores:bronze_ingot", 
			"base_ores:bronze_ingot"},
		{"base_glass:obsidian", "", "base_glass:obsidian"},
	}
})

