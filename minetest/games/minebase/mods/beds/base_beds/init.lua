-- base_beds/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("beds")

-- Simple shaped bed

beds.register_bed("base_beds:bed", {
	description = S("Simple Bed"),
	selection_box = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "base_beds:bed_bottom",
	burntime = 12,
})
