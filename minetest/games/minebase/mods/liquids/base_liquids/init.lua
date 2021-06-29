-- base_liquids/init.lua 

local S = minetest.get_translator("base_liquids")

minetest.register_alias("mapgen_water_source", "base_liquids:water_source")
minetest.register_alias("mapgen_river_water_source", 
	"base_liquids:river_water_source")

liquids.register_liquid("base_liquids:water", {
	source = {
		description = S("Water Source"),
		waving = 3,
		alpha = 191,
		post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	},
	flowing = {
		description = S("Flowing Water"),
		waving = 3,
		length = 0.5,
		alpha = 191,
		groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
			cools_lava = 1},
	}
})

liquids.register_liquid("base_liquids:river_water", {
	source = {
		description = S("River Water Source"),
		alpha = 160,
		-- Not renewable to avoid horizontal spread of water sources in sloping
		-- rivers that can cause water to overflow riverbanks and cause floods.
		-- River water source is instead made renewable by the 'force renew'
		-- option used in the 'bucket' mod by the river water bucket.
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	},
	flowing = {
		description = S("Flowing River Water"),
		length = 0.5,
		alpha = 160,
		liquid_renewable = false,
		liquid_range = 2,
		groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
			cools_lava = 1},
	}
})

liquids.register_liquid("base_liquids:lava", {
	source = {
		description = S("Lava Source"),
		length = 3.0,
		light_source = liquids.LIGHT_MAX - 1,
		liquid_viscosity = 7,
		liquid_renewable = false,
		damage_per_second = 4 * 2,
		post_effect_color = {a = 191, r = 255, g = 64, b = 0},
		groups = {lava = 3, liquid = 2, igniter = 1, falling_node = 1, float = 1},
	},
	flowing = {
		description = S("Flowing Lava"),
		length = 3.3,
		light_source = liquids.LIGHT_MAX - 1,
		liquid_viscosity = 7,
		liquid_renewable = false,
		damage_per_second = 4 * 2,
		groups = {lava = 3, liquid = 2, igniter = 1,
			not_in_creative_inventory = 1},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_liquids:lava_source",
	burntime = 60,
})

minetest.register_node("base_liquids:snow", {
	description = S("Snow"),
	tiles = {"base_liquids_snow.png"},
	inventory_image = "base_liquids_snowball.png",
	wield_image = "base_liquids_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	is_ground_content = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = sounds.get_defaults("liquid_sounds:snow"),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_earth:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_liquids:dirt_with_snow"})
		end
	end,
})

minetest.register_node("base_liquids:cloud", {
	description = S("Cloud"),
	tiles = {"base_liquids_cloud.png"},
	is_ground_content = false,
	sounds = sounds.get_defaults("default"),
	groups = {dig_immediate = 3},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"mossy:permafrost",
		"base_earth:permafrost_with_stones",
		"base_earth:stone",
		"base_earth:gravel"
	},
	sidelen = 4,
	noise_params = {
		offset = 0,
		scale = 1.0,
		spread = {x = 100, y = 100, z = 100},
		seed = 172555,
		octaves = 3,
		persist = 1.0
	},
	biomes = {"base_biomes:tundra", "base_biomes:tundra_beach"},
	y_max = 50,
	y_min = 1,
	decoration = "base_liquids:snow",
})

craft.register_craft19("base_liquids:snow_block", "base_liquids:snow")

minetest.register_node("base_liquids:snow_block", {
	description = S("Snow Block"),
	tiles = {"base_liquids_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = sounds.get_defaults("liquid_sounds:snow"),
	is_ground_content = false,
	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "base_earth:dirt_with_grass" then
			minetest.set_node(pos, {name = "base_liquids:dirt_with_snow"})
		end
	end,
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("base_liquids:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"base_liquids_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	is_ground_content = false,
	drop = "base_liquids:ice",
	sounds = sounds.get_defaults("liquid_sounds:ice"),
})

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("base_liquids:ice", {
	description = S("Ice"),
	tiles = {"base_liquids_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = sounds.get_defaults("liquid_sounds:ice"),
})

minetest.register_node("base_liquids:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"base_liquids_snow.png", "base_earth_dirt.png",
	{name = "base_earth_dirt.png^base_liquids_snow_side.png",
		tileable_vertical = false}},
	is_ground_content = false,
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	sounds = sounds.get_defaults("earth_sounds:dirt", {
		footstep = {name = "liquids_api_snow_footstep", gain = 0.2},
	}),
	drop = "base_earth:dirt"
})

earth.register_stone_nodes("base_liquids:obsidian", {
	stone = {
		description = S("Obsidian"),
		groups = {cracky = 1, level = 2}
	},
	brick = {
		description = S("Obsidian Brick"),
		groups = {cracky = 1, level = 2}
	},
	block = {
		description = S("Obsidian Block"),
		groups = {cracky = 1, level = 2}
	}
})

minetest.register_craftitem("base_liquids:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "base_liquids_obsidian_shard.png",
})
craft.register_craft19("base_liquids:obsidian", "base_liquids:obsidian_shard")


--
-- Lavacooling
--

local function cool_lava(pos, node)
	if node.name == "base_liquids:lava_source" then
		minetest.set_node(pos, {name = "base_liquids:obsidian"})
	else -- Lava flowing
		minetest.set_node(pos, {name = "base_earth:stone"})
	end
	minetest.sound_play("liquids_api_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.25}, true)
end

if minetest.settings:get_bool("enable_lavacooling") ~= false then
	minetest.register_abm({
		label = "Lava cooling",
		nodenames = {"base_liquids:lava_source", "base_liquids:lava_flowing"},
		neighbors = {"group:cools_lava", "group:water"},
		interval = 2,
		chance = 2,
		catch_up = false,
		action = cool_lava
	})
end


