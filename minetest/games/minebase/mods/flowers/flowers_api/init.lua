-- flowers_api/init.lua

flowers = {}

function flowers.register_decoration(name, def)
	minetest.register_decoration({
		name = name,
		deco_type = "simple",
		place_on = def.place_on,
		sidelen = 16,
		noise_params = def.noise_params,
		biomes = def.biomes,
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		decoration = def.decoration or name,
		param2 = def.param2 or 0,
		param2_max = def.param2_max or 3,
		place_offset_y = def.place_offset_y or 0,
	})
end

function flowers.register_flower(name, def)
	def.groups.snappy = 3
	def.groups.flower = 1
	def.groups.flora = 1
	def.groups.attached_node = 1

	minetest.register_node(name, {
		description = def.description,
		drawtype = "plantlike",
		waving = 1,
		tiles = { def.image },
		inventory_image = def.image,
		wield_image = def.image,
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = def.groups,
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		}
	})

	if def.deco then
		local deco = def.deco
		deco.place_on = deco.place_on or {"base_earth:dirt_with_grass"}
		deco.noise_params = deco.noise_params or {
			offset = -0.02,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = deco.seed,
			octaves = 3,
			persist = 0.6
		}
		deco.biomes = deco.biomes or {"base_biomes:grassland", 
			"base_biomes:deciduous_forest"}
		flowers.register_decoration(name, deco)
	end
end

function flowers.flower_spread(pos, node)
	pos.y = pos.y - 1
	local under = minetest.get_node(pos)
	pos.y = pos.y + 1
	-- Replace flora with dry stem in desert sand and silver sand,
	-- as this is the only way to generate them.
	-- However, preserve grasses in sand dune biomes.
	if minetest.get_item_group(under.name, "sand") == 1 and
			under.name ~= "base_earth:sand" then
		minetest.set_node(pos, {name = "base_bushes:dry_stem"})
		return
	end

	if minetest.get_item_group(under.name, "soil") == 0 then
		return
	end

	local light = minetest.get_node_light(pos)
	if not light or light < 13 then
		return
	end

	local pos0 = vector.subtract(pos, 4)
	local pos1 = vector.add(pos, 4)
	-- Testing shows that a threshold of 3 results in an appropriate maximum
	-- density of approximately 7 flora per 9x9 area.
	if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
		return
	end

	local soils = minetest.find_nodes_in_area_under_air(
		pos0, pos1, "group:soil")
	local num_soils = #soils
	if num_soils >= 1 then
		for si = 1, math.min(3, num_soils) do
			local soil = soils[rand.dy(num_soils)]
			local soil_name = minetest.get_node(soil).name
			local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
			light = minetest.get_node_light(soil_above)
			if light and light >= 13 and
					-- Only spread to same surface node
					soil_name == under.name and
					-- Desert sand is in the soil group
					soil_name ~= "base_earth:desert_sand" then
				minetest.set_node(soil_above, {name = node.name})
			end
		end
	end
end

minetest.register_abm({
	label = "Flower spread",
	nodenames = {"group:flora"},
	interval = 13,
	chance = 300,
	action = flowers.flower_spread
})

function flowers.register_mushroom(name, def)
	minetest.register_node(name, {
		description = def.description,
		tiles = { def.image },
		inventory_image = def.image,
		wield_image = def.image,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = def.groups,
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		on_use = def.on_use,
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		}
	})

	if def.deco then
		local deco = def.deco
		deco.place_on = deco.place_on or {"base_earth:dirt_with_grass", 
			"base_earth:dirt_with_coniferous_litter"}
		deco.noise_params = deco.noise_params or {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		}
		deco.biomes = deco.biomes or {"base_biomes:deciduous_forest", 
			"base_biomes:coniferous_forest"}
		flowers.register_decoration(name, deco)
	end
end

function flowers.mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 3 then
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:soil", "group:tree"})
	if #positions == 0 then
		return
	end
	local pos2 = positions[rand.dy(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 3 then
		minetest.set_node(pos2, {name = node.name})
	end
end

minetest.register_abm({
	label = "Mushroom spread",
	nodenames = {"group:mushroom"},
	interval = 11,
	chance = 150,
	action = flowers.mushroom_spread
})

function flowers.on_place_waterlily(itemstack, placer, pointed_thing)
	local pos = pointed_thing.above
	local node = minetest.get_node(pointed_thing.under)
	local def = minetest.registered_nodes[node.name]

	if def and def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
				pointed_thing)
	end

	if def and def.liquidtype == "source" and
			minetest.get_item_group(node.name, "water") > 0 then
		local player_name = placer and placer:get_player_name() or ""
		if not minetest.is_protected(pos, player_name) then
			minetest.set_node(pos, {name = itemstack:get_name() ..
				(def.waving == 3 and "_waving" or ""),
				param2 = rand.az(0, 3)})
			if not minetest.is_creative_enabled(player_name) then
				itemstack:take_item()
			end
		else
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos, player_name)
		end
	end

	return itemstack
end

function flowers.register_waterlily(name, def)
	local water_lily = {
		description = def.description,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = def.tiles,
		inventory_image = def.tiles[1],
		wield_image = def.tiles[1],
		use_texture_alpha = "clip",
		liquids_pointable = true,
		walkable = false,
		buildable_to = true,
		floodable = true,
		groups = def.groups,
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		node_placement_prediction = "",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = def.box_size
		},
		on_place = def.on_place or flowers.on_place_waterlily
	}

	local water_lily_waving = table.copy(water_lily)
	water_lily_waving.waving = 3
	water_lily_waving.drop = name
	water_lily_waving.groups.not_in_creative_inventory = 1

	minetest.register_node(name, water_lily)
	minetest.register_node(name .. "_waving", water_lily_waving)

	if def.deco then
		local deco = def.deco
		deco.place_on = deco.place_on or {"base_earth:dirt"}
		deco.noise_params = deco.noise_params or {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		}
		deco.biomes = deco.biomes or {"base_biomes:rainforest_swamp", 
			"base_biomes:savanna_shore", "base_biomes:deciduous_forest_shore"}
		deco.y_max = 0
		deco.y_min = 0
		deco.decoration = deco.decoration or name.."_waving"
		deco.param2 = 0
		deco.param2_max = 3
		deco.place_offset_y = 1
		flowers.register_decoration(name, deco)
	end
end
