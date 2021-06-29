-- base_vessels/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_vessels")

vessels.register_bottle("base_vessels:glass", {
	description = S("Empty Glass Bottle"),
	material = "base_glass:common_glass"
})

vessels.register_glass("base_vessels:drinking", {
	description = S("Empty Drinking Glass"),
	material = "base_glass:common_glass"
})

vessels.register_bottle("base_vessels:steel", {
	description = S("Empty Heavy Steel Bottle"),
	sounds = sounds.get_defaults("default"),
	material = "base_ores:steel_ingot",
	output = 5
})

-- Glass and steel recycling

minetest.register_craft( {
	type = "shapeless",
	output = "base_vessels:glass_fragments",
	recipe = {
		"base_vessels:glass_bottle",
		"base_vessels:glass_bottle",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "base_vessels:glass_fragments",
	recipe = {
		"base_vessels:drinking_glass",
		"base_vessels:drinking_glass",
	},
})

minetest.register_craft( {
	type = "cooking",
	output = "base_ores:steel_ingot",
	recipe = "base_vessels:steel_bottle",
})

