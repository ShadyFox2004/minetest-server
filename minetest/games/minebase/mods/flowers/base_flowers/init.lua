-- base_flowers/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_flowers")

--
-- Flowers
--

flowers.register_flower("base_flowers:rose",{
	description = S("Red Rose"),
	image = "base_flowers_rose.png",
	box_size = {-2 / 16, -0.5, -2 / 16, 2 / 16, -0.3, 2 / 16},
	groups = {color_red = 1, flammable = 1},
	deco = {seed = 436}
})

flowers.register_flower("base_flowers:tulip",{
	description = S("Orange Tulip"),
	image = "base_flowers_tulip.png",
	box_size = {-2 / 16, -0.5, -2 / 16, 2 / 16, -0.3, 2 / 16},
	groups = {color_orange = 1, flammable = 1},
	deco = {seed = 19822}
})

flowers.register_flower("base_flowers:dandelion_yellow",{
	description = S("Yellow Dandelion"),
	image = "base_flowers_dandelion_yellow.png",
	box_size = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16},
	groups = {color_yellow = 1, flammable = 1},
	deco = {seed = 1220999}
})

flowers.register_flower("base_flowers:chrysanthemum_green",{
	description = S("Green Chrysanthemum"),
	image = "base_flowers_chrysanthemum_green.png",
	box_size = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16},
	groups = {color_green = 1, flammable = 1},
	deco = {seed = 80081}
})

flowers.register_flower("base_flowers:geranium",{
	description = S("Blue Geranium"),
	image = "base_flowers_geranium.png",
	box_size = {-2 / 16, -0.5, -2 / 16, 2 / 16, -0.3, 2 / 16},
	groups = {color_blue = 1, flammable = 1},
	deco = {seed = 36662}
})

flowers.register_flower("base_flowers:viola",{
	description = S("Viola"),
	image = "base_flowers_viola.png",
	box_size = {-5 / 16, -0.5, -5 / 16, 5 / 16, -0.3, 5 / 16},
	groups = {color_violet = 1, flammable = 1},
	deco = {seed = 1133}
})

flowers.register_flower("base_flowers:dandelion_white",{
	description = S("White Dandelion"),
	image = "base_flowers_dandelion_white.png",
	box_size = {-5 / 16, -0.5, -5 / 16, 5 / 16, -0.3, 5 / 16},
	groups = {color_white = 1, flammable = 1},
	deco = {seed = 73133}
})

flowers.register_flower("base_flowers:tulip_black",{
	description = S("Black Tulip"),
	image = "base_flowers_tulip_black.png",
	box_size = {-2 / 16, -0.5, -2 / 16, 2 / 16, -0.3, 2 / 16},
	groups = {color_black = 1, flammable = 1},
	deco = {seed = 42}
})


--
-- Mushrooms
--

flowers.register_mushroom("base_flowers:mushroom_red",{
	description = S("Red Mushroom"),
	image = "base_flowers_mushroom_red.png",
	groups = {mushroom = 1, snappy = 3, attached_node = 1, flammable = 1},
	on_use = minetest.item_eat(-5),
	box_size = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16},
	deco = {}
})

flowers.register_mushroom("base_flowers:mushroom_brown", {
	description = S("Brown Mushroom"),
	image = "base_flowers_mushroom_brown.png",
	groups = {mushroom = 1, food_mushroom = 1, snappy = 3, attached_node = 1, 
		flammable = 1},
	on_use = minetest.item_eat(1),
	box_size = {-3 / 16, -0.5, -3 / 16, 3 / 16, -0.3, 3 / 16},
	deco = {}
})

--
-- Waterlily
--

flowers.register_waterlily("base_flowers:waterlily",{
	description = S("Waterlily"),
	tiles = {"base_flowers_waterlily.png", "base_flowers_waterlily_bottom.png"},
	groups = {snappy = 3, flower = 1, flammable = 1},
	box_size = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16},
	deco = {}
})

