-- hydrophytes_api/init.lua

hydrophytes = {}

function hydrophytes.on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" or not placer then
		return itemstack
	end

	local def = itemstack:get_definition()
	local pos_under = pointed_thing.under
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick 
		and not placer:get_player_control().sneak then
		return def_under.on_rightclick(pos_under, node_under, placer, itemstack, 
			pointed_thing) or itemstack
	end

	if node_under.name ~= def._root then
		return itemstack
	end
	
	local height = def._max and rand.az(def._max[1], def._max[2]) or 1
	local pos_top = {x = pos_under.x, y = pos_under.y + height, z = pos_under.z}
	local node_top = minetest.get_node(pos_top)
	local def_top = minetest.registered_nodes[node_top.name]
	local player_name = placer:get_player_name()

	if minetest.is_protected(pos_under, player_name) then
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	local tmp
	for fi = 1, height do
		tmp = {x = pos_under.x, y = pos_under.y + fi, z = pos_under.z}
		if minetest.is_protected(tmp, player_name) then
			minetest.record_protection_violation(tmp, player_name)
			return itemstack
		end
		tmp = minetest.get_node(tmp)
		if not tmp or minetest.registered_nodes[tmp.name].liquidtype 
			~= "source" then
			return itemstack
		end
	end

	minetest.set_node(pos_under, {name = itemstack:get_name(), param2 = height 
		* 16})

	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

function hydrophytes.after_destruct(pos, oldnode)
	minetest.set_node(pos, {name = minetest.registered_nodes[oldnode.name]._root})
end

function hydrophytes.register_phyte(name, def)
	local txt = name:gsub(":", "_")
	local rootTxt = def.root:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = "plantlike_rooted",
		waving = def.waving or 1,
		paramtype = "light",
		paramtype2 = def.paramtype2,
		tiles = def.tiles or {rootTxt .. ".png"},
		special_tiles = def.special_tiles or {{name = txt .. ".png", 
			tileable_vertical = true}},
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.wield_image or txt .. ".png",
		groups = def.groups or {snappy = 3},
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 0.7, 4/16},
			},
		},
		node_dig_prediction = def.node_dig_prediction or def.root,
		node_placement_prediction = def.node_placement_prediction or "",
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone", {
			dig = {name = "base_sounds_dig_snappy", gain = 0.2},
			dug = {name = "base_earth_grass_footstep", gain = 0.25},
		}),
		on_place = def.on_place or hydrophytes.on_place,
		after_destruct = def.after_destruct or hydrophytes.after_destruct,
		_root = def.root,
		_max = def.max
	})
end

function hydrophytes.register_coral(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		groups = def.groups or {cracky = 3},
		drop = def.drop,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone")
	})
end

function hydrophytes.register_decoration(name, def)
	minetest.register_decoration({
		name = name,
		deco_type = "simple",
		place_on = def.place_on,
		place_offset_y = def.place_offset_y or -1,
		sidelen = def.sidelen or 4,
		noise_params = def.noise_params or {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = def.biomes or {
			"base_biomes:coniferous_forest_ocean",
			"base_biomes:cold_desert_ocean",
			"base_biomes:deciduous_forest_ocean",
			"base_biomes:desert_ocean",
			"base_biomes:grassland_ocean",
			"base_biomes:rainforest_ocean",
			"base_biomes:sandstone_desert_ocean",
			"base_biomes:savanna_ocean",
			"base_biomes:snowy_grassland_ocean",
			"base_biomes:taiga_ocean"
		},
		y_max = def.y_max or -5,
		y_min = def.y_min or -10,
		flags = def.flags or "force_placement",
		decoration = def.decoration or name,
		param2 = def.param2,
		param2_max = def.param2_max
	})
end

function hydrophytes.register_phyte_set(name, def)
	hydrophytes.register_phyte(name, def.phyte)

	if def.deco then
		hydrophytes.register_decoration(name, def.deco)
	end
end
