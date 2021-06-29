-- base_soil/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_soil")

minetest.override_item("base_earth:dirt", {
	soil = {
		base = "base_earth:dirt",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.override_item("base_earth:dirt_with_grass", {
	soil = {
		base = "base_earth:dirt_with_grass",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.override_item("base_earth:dirt_with_dry_grass", {
	soil = {
		base = "base_earth:dirt_with_dry_grass",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.override_item("base_earth:dirt_with_rainforest_litter", {
	soil = {
		base = "base_earth:dirt_with_rainforest_litter",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.override_item("base_earth:dirt_with_coniferous_litter", {
	soil = {
		base = "base_earth:dirt_with_coniferous_litter",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.override_item("base_earth:dry_dirt", {
	soil = {
		base = "base_earth:dry_dirt",
		dry = "base_soil:dry_dirt",
		wet = "base_soil:dry_dirt_wet"
	}
})

minetest.override_item("base_earth:dry_dirt_with_dry_grass", {
	soil = {
		base = "base_earth:dry_dirt_with_dry_grass",
		dry = "base_soil:dry_dirt",
		wet = "base_soil:dry_dirt_wet"
	}
})

minetest.register_node("base_soil:dirt", {
	description = S("Soil"),
	tiles = {"base_earth_dirt.png^base_soil_dirt.png", "base_earth_dirt.png"},
	drop = "base_earth:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:dirt"),
	soil = {
		base = "base_earth:dirt",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.register_node("base_soil:dirt_wet", {
	description = S("Wet Soil"),
	tiles = {"base_earth_dirt.png^base_soil_dirt_wet.png", "base_earth_dirt.png^base_soil_dirt_wet_side.png"},
	drop = "base_earth:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:dirt"),
	soil = {
		base = "base_earth:dirt",
		dry = "base_soil:dirt",
		wet = "base_soil:dirt_wet"
	}
})

minetest.register_node("base_soil:dry_dirt", {
	description = S("Dry Soil"),
	tiles = {"base_earth_dry_dirt.png^base_soil_dirt.png", "base_earth_dry_dirt.png"},
	drop = "base_earth:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:dirt"),
	soil = {
		base = "base_earth:dry_dirt",
		dry = "base_soil:dry_dirt",
		wet = "base_soil:dry_dirt_wet"
	}
})

minetest.register_node("base_soil:dry_dirt_wet", {
	description = S("Wet Dry Soil"),
	tiles = {"base_earth_dry_dirt.png^base_soil_dirt_wet.png", "base_earth_dry_dirt.png^base_soil_dirt_wet_side.png"},
	drop = "base_earth:dry_dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:dirt"),
	soil = {
		base = "base_earth:dry_dirt",
		dry = "base_soil:dry_dirt",
		wet = "base_soil:dry_dirt_wet"
	}
})

minetest.override_item("base_earth:desert_sand", {
	groups = {crumbly=3, falling_node=1, sand=1, soil = 1},
	soil = {
		base = "base_earth:desert_sand",
		dry = "base_soil:desert_sand_soil",
		wet = "base_soil:desert_sand_wet"
	}
})
minetest.register_node("base_soil:desert_sand_soil", {
	description = S("Desert Sand Soil"),
	drop = "base_earth:desert_sand",
	tiles = {"base_soil_desert_sand.png", "base_earth_desert_sand.png"},
	groups = {crumbly=3, not_in_creative_inventory = 1, falling_node=1, sand=1, soil = 2, desert = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:sand"),
	soil = {
		base = "base_earth:desert_sand",
		dry = "base_soil:desert_sand_soil",
		wet = "base_soil:desert_sand_wet"
	}
})

minetest.register_node("base_soil:desert_sand_wet", {
	description = S("Wet Desert Sand Soil"),
	drop = "base_earth:desert_sand",
	tiles = {"base_soil_desert_sand_wet.png", "base_soil_desert_sand_wet_side.png"},
	groups = {crumbly=3, falling_node=1, sand=1, not_in_creative_inventory=1, soil=3, wet = 1, desert = 1, field = 1},
	sounds = sounds.get_defaults("earth_sounds:sand"),
	soil = {
		base = "base_earth:desert_sand",
		dry = "base_soil:desert_sand_soil",
		wet = "base_soil:desert_sand_wet"
	}
})

minetest.register_abm({
	label = "Farming soil",
	nodenames = {"group:field"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		local n_def = minetest.registered_nodes[node.name] or nil
		local wet = n_def.soil.wet or nil
		local base = n_def.soil.base or nil
		local dry = n_def.soil.dry or nil
		if not n_def or not n_def.soil or not wet or not base or not dry then
			return
		end

		pos.y = pos.y + 1
		local nn = minetest.get_node_or_nil(pos)
		if not nn or not nn.name then
			return
		end
		local nn_def = minetest.registered_nodes[nn.name] or nil
		pos.y = pos.y - 1

		if nn_def and nn_def.walkable and minetest.get_item_group(nn.name, "plant") 
			== 0 then
			minetest.set_node(pos, {name = base})
			return
		end
		-- check if there is water nearby
		local wet_lvl = minetest.get_item_group(node.name, "wet")
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil and not base node, turn it into wet soil
			if wet_lvl == 0 then
				minetest.set_node(pos, {name = wet})
			end
		else
			-- only turn back if there are no unloaded blocks (and therefore
			-- possible water sources) nearby
			if not minetest.find_node_near(pos, 3, {"ignore"}) then
				-- turn it back into base if it is already dry
				if wet_lvl == 0 then
					-- only turn it back if there is no plant/seed on top of it
					if minetest.get_item_group(nn.name, "plant") == 0 
						and minetest.get_item_group(nn.name, "seed") == 0 then
						minetest.set_node(pos, {name = base})
					end

				-- if its wet turn it back into dry soil
				elseif wet_lvl == 1 then
					minetest.set_node(pos, {name = dry})
				end
			end
		end
	end,
})


