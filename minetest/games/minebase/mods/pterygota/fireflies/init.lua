-- firefly/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("fireflies")

pterygota.register_pterygota("fireflies:firefly", {
	visible = {
		description = S("Firefly"),
		length = 1.5,
		light_source = 6,
		pointable = true,
		on_timer = pterygota.on_timer_bright
	},
	hidden = {
		description = S("Hidden Firefly"),
		on_timer = pterygota.on_timer_dark,
		deco = {
			place_on = {
				"base_earth:dirt_with_grass",
				"base_earth:dirt_with_coniferous_litter",
				"base_earth:dirt_with_rainforest_litter",
				"base_earth:dirt"
			},
			fill_ratio = 0.0005,
			biomes = {
				"base_biomes:deciduous_forest",
				"base_biomes:coniferous_forest",
				"base_biomes:rainforest",
				"base_biomes:rainforest_swamp"
			},
			y_min = -1,
		}
	}
})

pterygota.register_deco("fireflies:firefly_hidden_high", {
	place_on = {
		"base_earth:dirt_with_grass",
		"base_earth:dirt_with_coniferous_litter",
		"base_earth:dirt_with_rainforest_litter",
		"base_earth:dirt"
	},
	place_offset_y = 3,
	fill_ratio = 0.0005,
	biomes = {
		"base_biomes:deciduous_forest",
		"base_biomes:coniferous_forest",
		"base_biomes:rainforest",
		"base_biomes:rainforest_swamp"
	},
	y_min = -1,
	decoration = "fireflies:firefly_hidden",
})

if minetest.get_modpath("base_vessels") and minetest.get_modpath("glass_sounds") 
	then
	-- firefly in a bottle
	pterygota.register_visible("fireflies:firefly_bottle", {
		description = S("Firefly in a Bottle"),
		length = 1.5,
		light_source = 9,
		pointable = true,
		groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
		sounds = sounds.get_defaults("glass_sounds:glass"),
		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			local lower_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
			if minetest.is_protected(pos, player:get_player_name()) or
					minetest.get_node(lower_pos).name ~= "air" then
				return
			end

			local upper_pos = {x = pos.x, y = pos.y + 2, z = pos.z}
			local firefly_pos

			if not minetest.is_protected(upper_pos, player:get_player_name()) and
					minetest.get_node(upper_pos).name == "air" then
				firefly_pos = upper_pos
			elseif not minetest.is_protected(lower_pos, player:get_player_name()) then
				firefly_pos = lower_pos
			end

			if firefly_pos then
				minetest.set_node(pos, {name = "base_vessels:glass_bottle"})
				minetest.set_node(firefly_pos, {name = "fireflies:firefly"})
				minetest.get_node_timer(firefly_pos):start(1)
			end
		end
	})

	minetest.register_craft( {
		output = "fireflies:firefly_bottle",
		recipe = {
			{"fireflies:firefly"},
			{"base_vessels:glass_bottle"}
		}
	})
end
