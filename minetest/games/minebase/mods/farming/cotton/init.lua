-- cotton/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("cotton")

farming.register_plant("cotton:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	steps = 8,
	minlight = 13,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

minetest.register_decoration({
	name = "cotton:wild",
	deco_type = "simple",
	place_on = {"base_earth:dry_dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4242,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"base_biomes:savanna"},
	y_max = 31000,
	y_min = 1,
	decoration = "cotton:wild",
})

minetest.register_craftitem("cotton:string", {
	description = S("String"),
	inventory_image = "cotton_string.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"cotton:cotton", "cotton:cotton"},
		{"cotton:cotton", "cotton:cotton"},
	}
})

minetest.register_craft({
	output = "cotton:string 2",
	recipe = {
		{"cotton:cotton"},
		{"cotton:cotton"},
	}
})


-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "cotton:cotton",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "cotton:string",
	burntime = 1,
})

-- Make base_grasses:jungle_grass occasionally drop cotton seed.

-- This is the old source of cotton seeds that makes no sense. It is a leftover
-- from Mapgen V6 where jungle_grass was the only plant available to be a source.
-- This source is kept for now to avoid disruption but should probably be
-- removed in future as players get used to the new source.

for i = 1, 3 do
	minetest.override_item("base_grasses:jungle_grass_" .. i, {drop = {
		max_items = 1,
		items = {
			{items = {"cotton:cotton_seed"}, rarity = 8},
			{items = {"base_grasses:jungle_grass_1"}},
		}
	}})
end


-- Wild cotton as a source of cotton seed

minetest.register_node("cotton:wild", {
	description = S("Wild Cotton"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"cotton_wild.png"},
	inventory_image = "cotton_wild.png",
	wield_image = "cotton_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1, flammable = 4},
	drop = "cotton:cotton_seed",
	sounds = sounds.get_defaults("tree_sounds:leaves"),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.3, 6 / 16},
	},
})


