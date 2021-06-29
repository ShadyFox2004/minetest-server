-- base_hoes/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_hoes")

farming.register_hoe("base_hoes:wood", {
	description = S("Wooden Hoe"),
	inventory_image = "base_hoes_wood.png",
	max_uses = 30,
	material = "group:wood",
	groups = {hoe = 1, flammable = 2},
})

farming.register_hoe("base_hoes:stone", {
	description = S("Stone Hoe"),
	inventory_image = "base_hoes_stone.png",
	max_uses = 90,
	material = "group:stone",
	groups = {hoe = 1}
})

farming.register_hoe("base_hoes:steel", {
	description = S("Steel Hoe"),
	inventory_image = "base_hoes_steel.png",
	max_uses = 500,
	material = "base_ores:steel_ingot",
	groups = {hoe = 1}
})

-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "farming:hoe_wood",
	burntime = 5,
})

-- The following are deprecated by removing the 'material' field to prevent
-- crafting and removing from creative inventory, to cause them to eventually
-- disappear from worlds. The registrations should be removed in a future
-- release.

farming.register_hoe("base_hoes:bronze", {
	description = S("Bronze Hoe"),
	inventory_image = "base_hoes_bronze.png",
	max_uses = 220,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})

farming.register_hoe("base_hoes:mese", {
	description = S("Mese Hoe"),
	inventory_image = "base_hoes_mese.png",
	max_uses = 350,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})

farming.register_hoe("base_hoes:diamond", {
	description = S("Diamond Hoe"),
	inventory_image = "base_hoes_diamond.png",
	max_uses = 500,
	groups = {hoe = 1, not_in_creative_inventory = 1},
})


