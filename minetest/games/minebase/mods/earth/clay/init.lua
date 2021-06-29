-- clay/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("clay")

minetest.register_node("clay:node", {
	description = S("Clay"),
	tiles = {"clay_node.png"},
	groups = {crumbly = 3},
	drop = "clay:lump 4",
	sounds = sounds.get_defaults("earth_sounds:dirt"),
})

minetest.register_node("clay:brick_block", {
	description = S("Brick Block"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"clay_brick_block.png^[transformFX",
		"clay_brick_block.png",
	},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = sounds.get_defaults("earth_sounds:stone"),
})

minetest.register_craftitem("clay:lump", {
	description =  S("Clay Lump"),
	inventory_image = "clay_lump.png",
})

minetest.register_craftitem("clay:brick", {
	description = S("Clay Brick"),
	inventory_image = "clay_brick.png",
})

minetest.register_craft({
	output = "clay:lump 4",
	recipe = {
		{"clay:node"},
	}
})

minetest.register_craft({
	output = "clay:brick 4",
	recipe = {
		{"clay:brick_block"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "clay:brick",
	recipe = "clay:lump",
})

earth.register_ore("clay:node", {
	wherein         = {"base_earth:sand"},
	y_max           = 0,
	y_min           = -15,
	seed = -316,
})

