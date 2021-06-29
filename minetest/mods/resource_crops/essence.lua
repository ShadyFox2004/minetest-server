--reused resourcecrops.add_crop code because of drop changes.
--Seed

minetest.register_craftitem("resource_crops:essence_seed", {
	description = ("Essence Seeds"),
	inventory_image = "resource_crops_essence_seed.png",
	groups = {essence_seed = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "resource_crops:essencecrop_1")
	end
})

--Crop Step 1
minetest.register_node("resource_crops:essencecrop_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"resource_crops_crop_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

--Crop Step 2
minetest.register_node("resource_crops:essencecrop_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"resource_crops_crop_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

--Crop Step 4
minetest.register_node("resource_crops:essencecrop_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"resource_crops_crop_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

--Crop Full Grown
minetest.register_node("resource_crops:essencecrop", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"resource_crops_essence_crop.png"},
    selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
		},
	},
	drop = {
		max_items = 4,
		items = {
			{ items = {"resource_crops:essence_seed"} },
			{ items = {"resource_crops:essence_seed"}, rarity = 30},
			{ items = {"resource_crops:essence_dust"} },
			{ items = {"resource_crops:essence_dust"}, rarity = 30}
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, resourceplant=1,},
	sounds = default.node_sound_leaves_defaults(),
})

--Register Items
minetest.register_craftitem("resource_crops:essence_dust", {
	description = ("Essence Dust"),
	groups = {magic_essence = 1},
	inventory_image = "resource_crops_essence_dust.png"
})

--Add Plant
farming.add_plant("resource_crops:essencecrop", {"resource_crops:essencecrop_1", "resource_crops:essencecrop_2", "resource_crops:essencecrop_3"})

--Register essences
minetest.register_craftitem("resource_crops:essence_weak", {
	description = ("Weak Essence"),
	groups = {magic_essence = 1, essence = 1},
	inventory_image = "resource_crops_essence_weak.png"
})
minetest.register_craftitem("resource_crops:essence_regular", {
	description = ("Regular Essence"),
	groups = {magic_essence = 1, essence = 1},
	inventory_image = "resource_crops_essence_regular.png"
})
minetest.register_craftitem("resource_crops:essence_strong", {
	description = ("Strong Essence"),
	groups = {magic_essence = 1, essence = 1},
	inventory_image = "resource_crops_essence_strong.png"
})
minetest.register_craftitem("resource_crops:essence_extreme", {
	description = ("Extreme Essence"),
	groups = {magic_essence = 1, essence = 1},
	inventory_image = "resource_crops_essence_extreme.png"
})

minetest.register_node("resource_crops:essence_block", {
	description = "Essence Block",
	tiles = {"resource_crops_essence_block.png"},
	groups = {snappy=1,oddly_breakable_by_hand=2},
})


--Register Recipies
minetest.register_craft({
	output = "resource_crops:essence_weak",
	recipe = {
		{"", "resource_crops:essence_dust", ""},
		{"resource_crops:essence_dust", "resource_crops:upgrade_stone_weak", "resource_crops:essence_dust"},
		{"", "resource_crops:essence_dust", ""}
	},
	replacements = {{"resource_crops:upgrade_stone_weak", "resource_crops:upgrade_stone_weak"}},
})
minetest.register_craft({
	output = "resource_crops:essence_regular",
	recipe = {
		{"", "resource_crops:essence_weak", ""},
		{"resource_crops:essence_weak", "resource_crops:upgrade_stone_regular", "resource_crops:essence_weak"},
		{"", "resource_crops:essence_weak", ""}
	},
	replacements = {{"resource_crops:upgrade_stone_regular", "resource_crops:upgrade_stone_regular"}},
})
minetest.register_craft({
	output = "resource_crops:essence_strong",
	recipe = {
		{"", "resource_crops:essence_regular", ""},
		{"resource_crops:essence_regular", "resource_crops:upgrade_stone_strong", "resource_crops:essence_regular"},
		{"", "resource_crops:essence_regular", ""}
	},
	replacements = {{"resource_crops:upgrade_stone_strong", "resource_crops:upgrade_stone_strong"}},
})
minetest.register_craft({
	output = "resource_crops:essence_extreme",
	recipe = {
		{"", "resource_crops:essence_strong", ""},
		{"resource_crops:essence_strong", "resource_crops:upgrade_stone_extreme", "resource_crops:essence_strong"},
		{"", "resource_crops:essence_strong", ""}
	},
	replacements = {{"resource_crops:upgrade_stone_extreme", "resource_crops:upgrade_stone_extreme"}},
})
minetest.register_craft({
	output = "resource_crops:essence_block",
	recipe = {
		{"resource_crops:essence_regular", "resource_crops:essence_extreme", "resource_crops:essence_regular"},
		{"resource_crops:essence_extreme", "resource_crops:upgrade_stone_extreme", "resource_crops:essence_extreme"},
		{"resource_crops:essence_regular", "resource_crops:essence_extreme", "resource_crops:essence_regular"}
	},
	replacements = {{"resource_crops:upgrade_stone_extreme", "resource_crops:upgrade_stone_extreme"}},
})

--Essence Downgrades
minetest.register_craft({
	output = 'resource_crops:essence_regular 89',
	recipe = {{'resource_crops:essence_block'}}
})
minetest.register_craft({
	output = "resource_crops:essence_strong 9",
	recipe = {{"resource_crops:essence_extreme"}}
})
minetest.register_craft({
	output = "resource_crops:essence_regular 9",
	recipe = {{"resource_crops:essence_strong"}}
})
minetest.register_craft({
	output = "resource_crops:essence_weak 9",
	recipe = {{"resource_crops:essence_regular"}}
})
minetest.register_craft({
	output = "resource_crops:essence_dust 9",
	recipe = {{"resource_crops:essence_weak"}}
})
minetest.register_craft({
	output = "resource_crops:essence_dust",
	recipe = {{"resource_crops:essence_seed"}}
})
print("essence seed")

minetest.register_craft({
	output = "resource_crops:essence_seed",
	recipe = {
		{"resource_crops:essence_dust", "resource_crops:essence_weak", "resource_crops:essence_dust"},
		{"resource_crops:essence_weak", "group:seed"         , "resource_crops:essence_weak"},
		{"resource_crops:essence_dust", "resource_crops:essence_weak", "resource_crops:essence_dust"}
	}
})
