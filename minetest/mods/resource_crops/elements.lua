--EARTH--
resourcecrops.add_crop("Earth", "earth", "extreme", "group:stone", nil)

--NATURE--
minetest.register_craftitem("resource_crops:grass_seed", {
    description = ("Grass Seed"),
    inventory_image = "resource_crops_grass_seed.png",
})
resourcecrops.add_crop("Nature", "nature", "extreme", "group:leaves", "resource_crops:grass_seed")
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    if node.name == "default:dirt" then
	local puncher_name = puncher:get_player_name()
	local item = puncher:get_wielded_item()
	if item:get_name() == "resource_crops:grass_seed" then
	    minetest.set_node(pos, {name="default:dirt_with_grass"})
	    if not (creative and creative.is_enabled_for and creative.is_enabled_for(puncher:get_player_name())) then
		item:take_item()
		puncher:set_wielded_item(item)
	    end
	end
    end 
end)

--WATER--
resourcecrops.add_crop("Water", "water", "extreme", nil, "default:snow 9")
minetest.register_craft({
    output = "resource_crops:water_seed",
    recipe = {{"bucket:bucket_water", "resource_crops:essence_extreme", "bucket:bucket_water"},
	      {"resource_crops:essence_extreme", "resource_crops:essence_seed", "resource_crops:essence_extreme"},
	      {"bucket:bucket_water", "resource_crops:essence_extreme", "bucket:bucket_water"}},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}, {"bucket:bucket_water", "bucket:bucket_empty"}, {"bucket:bucket_water", "bucket:bucket_empty"}, {"bucket:bucket_water", "bucket:bucket_empty"}}
})
minetest.register_craft({
    output = "resource_crops:water_seed",
    recipe = {{"bucket:bucket_river_water", "resource_crops:essence_extreme", "bucket:bucket_river_water"},
	      {"resource_crops:essence_extreme", "resource_crops:essence_seed", "resource_crops:essence_extreme"},
	      {"bucket:bucket_river_water", "resource_crops:essence_extreme", "bucket:bucket_river_water"}},
    replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}, {"bucket:bucket_river_water", "bucket:bucket_empty"}, {"bucket:bucket_river_water", "bucket:bucket_empty"}, {"bucket:bucket_river_water", "bucket:bucket_empty"}}
})

--FIRE--
resourcecrops.add_crop("Fire", "fire", "extreme", nil, "fire:permanent_flame")
minetest.register_craft({
    output = "resource_crops:fire_seed",
    recipe = {{"bucket:bucket_lava", "resource_crops:essence_extreme", "bucket:bucket_lava"},
	      {"resource_crops:essence_extreme", "resource_crops:essence_seed", "resource_crops:essence_extreme"},
	      {"bucket:bucket_lava", "resource_crops:essence_extreme", "bucket:bucket_lava"}},
    replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}, {"bucket:bucket_lava", "bucket:bucket_empty"}, {"bucket:bucket_lava", "bucket:bucket_empty"}, {"bucket:bucket_lava", "bucket:bucket_empty"}}
})
local function fire_essence_smelt(input, result)
minetest.register_craft({
    output = result,
    recipe = {{"resource_crops:fire_essence", input}}
})
minetest.register_craft({
    output = result.." 2",
    recipe = {{"resource_crops:inferno_stone", input}},
    replacements = {{"resource_crops:inferno_stone", "resource_crops:inferno_stone"}}
})
end



--CRAFTING--
--NATURE--
minetest.register_craft({
    type = "shapeless",
    output = "default:dirt_with_grass",
    recipe = {"resource_crops:grass_seed", "resource_crops:grass_seed"}
})
minetest.register_craft({
    type = "shapeless",
    output = "farming:wheat 9",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence"}
})
minetest.register_craft({
    type = "shapeless",
    output = "farming:cotton 9",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence"}
})
minetest.register_craft({
    type = "shapeless",
    output = "default:sapling 9",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence"}
})
minetest.register_craft({
    type = "shapeless",
    output = "default:papyrus 9",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence"}
})
minetest.register_craft({
    type = "shapeless",
    output = "default:leaves 18",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence"}
})
minetest.register_craft({
    type = "shapeless",
    output = "default:tree 9",
    recipe = {"resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence", "resource_crops:nature_essence"}
})



--EARTH--
minetest.register_craft({
    output = "default:dirt 36",
    recipe = {{"resource_crops:earth_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:gravel 36",
    recipe = {{"", "resource_crops:earth_essence", ""},
	      {"resource_crops:earth_essence", "", "resource_crops:earth_essence"},
	      {"", "resource_crops:earth_essence", ""}}
})
minetest.register_craft({
    output = "default:sandstone 18",
    recipe = {{"", "resource_crops:earth_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:desert_sandstone 18",
    recipe = {{"resource_crops:earth_essence", "", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:silver_sandstone 18",
    recipe = {{"resource_crops:earth_essence", "resource_crops:earth_essence", ""},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:stone 18",
    recipe = {{"", "resource_crops:earth_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:desert_stone 18",
    recipe = {{"resource_crops:earth_essence", "resource_crops:earth_essence", ""},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"}}
})



--WATER--
minetest.register_craft({
    output = "bucket:bucket_water",
    recipe = {{"resource_crops:water_essence", "resource_crops:water_essence", "resource_crops:water_essence"},
	      {"resource_crops:water_essence", "resource_crops:water_essence", "resource_crops:water_essence"},
	      {"resource_crops:water_essence", "bucket:bucket_empty", ""}}
})
minetest.register_craft({
    output = "bucket:bucket_river_water",
    recipe = {{"resource_crops:water_essence", "resource_crops:water_essence", "resource_crops:water_essence"},
	      {"resource_crops:water_essence", "resource_crops:water_essence", "resource_crops:water_essence"},
	      {"", "bucket:bucket_empty", "resource_crops:water_essence"}}
})



--FIRE--
minetest.register_craftitem("resource_crops:inferno_stone", {
	description = ("Inferno Stone"),
	inventory_image = "resource_crops_inferno_stone.png",
	stack_max = 1,
})
minetest.register_craft({
	output = "bucket:bucket_lava",
	recipe = {{"resource_crops:fire_essence", "resource_crops:fire_essence", "resource_crops:fire_essence"},
		  {"resource_crops:fire_essence", "resource_crops:fire_essence", "resource_crops:fire_essence"},
		  {"resource_crops:fire_essence", "bucket:bucket_empty", "resource_crops:fire_essence"}}
})
minetest.register_craft({
	output = "default:torch 18",
	recipe = {{"resource_crops:fire_essence"},
		  {"default:stick"}}
})
minetest.register_craft({
	output = "resource_crops:inferno_stone",
	recipe = {{"resource_crops:fire_essence", "resource_crops:essence_block", "resource_crops:fire_essence"},
		  {"bucket:bucket_lava", "default:stone", "bucket:bucket_lava"},
		  {"resource_crops:fire_essence", "resource_crops:essence_block", "resource_crops:fire_essence"}},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}, {"bucket:bucket_lava", "bucket:bucket_empty"}}
})

--MIX--
minetest.register_craft({
    output = "default:obsidian",
    recipe = {{"resource_crops:fire_essence", "resource_crops:fire_essence", "resource_crops:fire_essence"},
		  {"resource_crops:earth_essence", "resource_crops:earth_essence", "resource_crops:earth_essence"},
		  {"resource_crops:water_essence", "resorucecrops:water_essence", "resource_crops:water_essence"}}
})
minetest.register_craft({
    output = "default:clay 36",
    recipe = {{"resource_crops:earth_essence", "resource_crops:water_essence"},
	      {"resource_crops:water_essence", "resource_crops:earth_essence"}}
})
minetest.register_craft({
    output = "default:clay 36",
    recipe = {{"resource_crops:water_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:water_essence"}}
})
minetest.register_craft({
    output = "default:sand 36",
    recipe = {{"resource_crops:fire_essence", "resource_crops:earth_essence"},
	      {"resource_crops:earth_essence", "resource_crops:fire_essence"}}
})
minetest.register_craft({
    output = "default:sand 36",
    recipe = {{"resource_crops:earth_essence", "resource_crops:fire_essence"},
	      {"resource_crops:fire_essence", "resource_crops:earth_essence"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "resource_crops:fire_essence",
	burntime = 60,
})
--FIRE ESSENCE SMELTING--
fire_essence_smelt("default:clay_lump", "default:clay_brick")
fire_essence_smelt("default:copper_lump", "default:copper_ingot")
fire_essence_smelt("default:tin_lump", "default:tin_ingot")
fire_essence_smelt("default:iron_lump", "default:iron_ingot")
fire_essence_smelt("default:gold_lump", "default:gold_ingot")
fire_essence_smelt("default:cobble", "default:stone")
fire_essence_smelt("default:mossy_cobble", "default:stone")
fire_essence_smelt("default:desert_cobble", "default:desert_stone")
fire_essence_smelt("group:sand", "default:glass")
fire_essence_smelt("default:obsidian_shard", "default:obsidian_glass")
fire_essence_smelt("default:key", "default:gold_ingot")
fire_essence_smelt("default:skeleton_key", "default:gold_ingot")
if resourcecrops.has_moreores then
    fire_essence_smelt("moreores:silver_lump", "moreores:silver_ingot")
    fire_essence_smelt("moreores:mithril_lump", "moreores:mithril_ingot")
end
if resourcecrops.has_technic_ores then
    fire_essence_smelt("technic:uranium_lump", "technic:uranium_ingot")
    fire_essence_smelt("technic:chromium_lump", "technic:chromium_ingot")
    fire_essence_smelt("technic:zinc_lump", "technic:zinc_ingot")
    fire_essence_smelt("technic:lead_lump", "technic:lead_ingot")
    fire_essence_smelt("default:iron_ingot", "technic:cast_iron_ingot")
    fire_essence_smelt("technic:cast_iron_ingot", "default:iron_ingot")
    fire_essence_smelt("technic:carbon_steel_ingot", "default:iron_ingot")
end
