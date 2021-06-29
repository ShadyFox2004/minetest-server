-- glass/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("glass")

glass.register_glass("base_glass:common", {
	description = S("Glass"),
	input = "group:sand"
})

glass.register_glass("base_glass:obsidian", {
	description = S("Obsidian Glass"),
	groups = {cracky = 3},
	input = "base_liquids:obsidian_shard"
})

minetest.register_craftitem("base_glass:glass_fragments", {
	description = S("Glass Fragments"),
	inventory_image = "base_glass_glass_fragments.png",
})

minetest.register_craft({
	type = "cooking",
	output = "base_glass:common",
	recipe = "base_glass:glass_fragments",
})

