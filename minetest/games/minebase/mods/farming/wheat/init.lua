-- wheat/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("wheat")

farming.register_plant("wheat:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	steps = 8,
	minlight = 13,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("wheat:flour", {
	description = S("Flour"),
	inventory_image = "wheat_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("wheat:bread", {
	description = S("Bread"),
	inventory_image = "wheat_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "wheat:flour",
	recipe = {"wheat:wheat", "wheat:wheat", "wheat:wheat", "wheat:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "wheat:bread",
	recipe = "wheat:flour"
})

-- Straw

minetest.register_craft({
	output = "wheat:straw 3",
	recipe = {
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
		{"wheat:wheat", "wheat:wheat", "wheat:wheat"},
	}
})

minetest.register_craft({
	output = "wheat:wheat 3",
	recipe = {
		{"wheat:straw"},
	}
})

minetest.register_node("wheat:straw", {
	description = S("Straw"),
	tiles = {"wheat_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = sounds.get_defaults("tree_sounds:leaves"),
})

minetest.register_craft({
	type = "fuel",
	recipe = "wheat:straw",
	burntime = 3,
})

-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "wheat:wheat",
	burntime = 1,
})

-- Make base_grasses:grass_* occasionally drop wheat seed

for i = 1, 5 do
	minetest.override_item("base_grasses:grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {"wheat:wheat_seed"}, rarity = 5},
			{items = {"base_grasses:grass_1"}},
		}
	}})
end

