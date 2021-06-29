-- base_rails/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_rails")

carts.register_rail("base_rails:rail", {
	description = S("Rail"),
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})

carts.register_rail("base_rails:powerrail", {
	description = S("Powered Rail"),
	railparams = {acceleration = 5},
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:mese_crystal", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})

carts.register_rail("base_rails:brakerail", {
	description = S("Brake Rail"),
	railparams = {acceleration = -3},
	recipe = {
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "base_ores:coal_lump", "base_ores:steel_ingot"},
		{"base_ores:steel_ingot", "group:wood", "base_ores:steel_ingot"},
	}
})

