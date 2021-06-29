-- earth_api/init.lua 

earth = {}

function earth.define_default(def)
	earth.stone = def.stone
end

function earth.register_stone(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		short_description = def.short_description,
		groups = def.groups or {cracky = 3},
		palette = def.palette,
		color = def.color,
		stack_max = def.stack_max,
		range = def.range,
		light_source = def.light_source,
		node_placement_prediction = def.node_placement_prediction,
		node_dig_prediction = def.node_dig_prediction,
		sound = def.sound,
		tiles = def.tiles or {txt .. ".png"},
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		use_texture_alpha = def.use_texture_alpha,
		post_effect_color = def.post_effect_color,
		paramtype2 = def.paramtype2,
		place_param2 = def.place_param2,
		is_ground_content = def.is_ground_content,
		diggable = def.diggable, 
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone"),
		drop = def.drop,
	})
end

function earth.register_brick(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_brick", {
		description = def.description or txt .. "_brick",
		short_description = def.short_description,
		groups = def.groups or {cracky = 2},
		palette = def.palette,
		color = def.color,
		stack_max = def.stack_max,
		range = def.range,
		light_source = def.light_source,
		node_placement_prediction = def.node_placement_prediction,
		node_dig_prediction = def.node_dig_prediction,
		sound = def.sound,
		tiles = def.tiles or {txt .. "_brick.png"},
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		use_texture_alpha = def.use_texture_alpha,
		post_effect_color = def.post_effect_color,
		paramtype2 = def.paramtype2 or "facedir",
		place_param2 = def.place_param2 or 0,
		is_ground_content = def.is_ground_content,
		diggable = def.diggable,
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone"),
		drop = def.drop,
	})
end

function earth.register_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_block", {
		description = def.description or txt .. "_block",
		short_description = def.short_description,
		groups = def.groups or {cracky = 2},
		palette = def.palette,
		color = def.color,
		stack_max = def.stack_max,
		range = def.range,
		light_source = def.light_source,
		node_placement_prediction = def.node_placement_prediction,
		node_dig_prediction = def.node_dig_prediction,
		sound = def.sound,
		tiles = def.tiles or {txt .. "_block.png"},
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		use_texture_alpha = def.use_texture_alpha,
		post_effect_color = def.post_effect_color,
		paramtype2 = def.paramtype2,
		place_param2 = def.place_param2,
		is_ground_content = def.is_ground_content or false,
		diggable = def.diggable,
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone"),
		drop = def.drop,
	})
end

function earth.register_cobble(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_cobble", {
		description = def.description or txt .. "_cobble",
		short_description = def.short_description,
		groups = def.groups or {cracky = 3},
		palette = def.palette,
		color = def.color,
		stack_max = def.stack_max,
		range = def.range,
		light_source = def.light_source,
		node_placement_prediction = def.node_placement_prediction,
		node_dig_prediction = def.node_dig_prediction,
		sound = def.sound,
		tiles = def.tiles or {txt .. "_cobble.png"},
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		use_texture_alpha = def.use_texture_alpha,
		post_effect_color = def.post_effect_color,
		paramtype2 = def.paramtype2,
		place_param2 = def.place_param2,
		is_ground_content = def.is_ground_content or false,
		diggable = def.diggable,
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone"),
		drop = def.drop,
	})
end

function earth.register_stone_nodes(name, def)
	if def.cobble then
		def.cobble.groups = def.cobble.groups or {cracky = 3, stone = 2}
		earth.register_cobble(name, def.cobble)
		def.stone.drop = def.stone.drop or name .. "_cobble"

		minetest.register_craft({
			type = "cooking",
			output = name,
			recipe = name .. "_cobble"
		})
	end

	def.stone.groups = def.stone.groups or {cracky = 3, stone = 1}
	earth.register_stone(name, def.stone)

	if def.brick then
		def.brick.groups = def.brick.groups or {cracky = 2, stone = 1},
		earth.register_brick(name, def.brick)
		craft.register_craft44(name .. "_brick", name)
	end

	if def.block then
		def.block.groups = def.block.groups or {cracky = 2, stone = 1}
		earth.register_block(name, def.block)
		craft.register_craft99(name .. "_block", name)
	end
end

function earth.register_sand(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		short_description = def.short_description,
		groups = def.groups or {crumbly = 3, falling_node = 1, sand = 1},
		palette = def.palette,
		color = def.color,
		stack_max = def.stack_max,
		range = def.range,
		light_source = def.light_source,
		node_placement_prediction = def.node_placement_prediction,
		node_dig_prediction = def.node_dig_prediction,
		sound = def.sound,
		tiles = def.tiles or {txt .. ".png"},
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		use_texture_alpha = def.use_texture_alpha,
		post_effect_color = def.post_effect_color,
		paramtype2 = def.paramtype2,
		place_param2 = def.place_param2,
		is_ground_content = def.is_ground_content or false,
		diggable = def.diggable,
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:sand"),
		drop = def.drop,
	})
end

function earth.register_ore(name, def)
	minetest.register_ore({
		ore_type = "blob",
		ore = name,
		ore_param2 = def.ore_param2,
		wherein = def.wherein or {earth.stone},
		clust_scarcity = def.clust_scarcity or 16 * 16 * 16,
		clust_num_ores = def.clust_num_ores or 8,
		clust_size = def.clust_size or 5,
		y_max = def.y_max or 31000,
		y_min = def.y_min or -31000,
		flags = def.flags,
		noise_threshold = def.noise_threshold or 0.0,
		noise_params = def.noise_params or {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = def.seed or 2316,
			octaves = 1,
			persist = 0.0
		},
		biomes = def.biomes
	})
end

function earth.register_sand_nodes(name, def)
	local namestone = name .. "stone"
	earth.register_sand(name, def.sand)

	if def.stone then
		craft.register_craft14(namestone, name)
		def.stone.groups = def.stone.groups or {cracky = 3, crumbly = 1},
		earth.register_stone(namestone, def.stone)

		if def.brick then
			craft.register_craft44(namestone .. "_brick 4", namestone)
		end

		if def.block then
			craft.register_craft99(namestone .. "_block", namestone)
		end
	end

	if def.brick then
		earth.register_brick(namestone, def.brick)
	end

	if def.block then
		earth.register_block(namestone, def.block)
	end

	if def.ore then
		earth.register_ore(name, def.ore)
	end 
end

function earth.register_node_with(name, def)
	local txt = name:gsub(":", "_")
	local txt_with = string.sub(name, 1, name:find(":") - 1) .. "_" .. def.with
	minetest.register_node(name .. "_with_" .. def.with, {
		description = def.description or txt .. "_with_" .. def.with,
		tiles = def.tiles or {
			txt_with .. ".png", txt .. ".png",
			{name = txt .. ".png^" .. txt_with .. "_side.png", 
				tileable_vertical = false}
		},
		groups = def.groups or {crumbly = 3, soil = 1, spreading_dirt_type = 1},
		is_ground_content = def.is_ground_content or false,
		drop = def.drop or name,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:dirt", {
			footstep = {name = "earth_grass_footstep", gain = def.gain or 0.4},
		})
	})
end

function earth.register_deco(name, def)
	minetest.register_decoration({
		deco_type = def.deco_type or "simple",
		place_on = def.place_on,
		sidelen = def.sidelen or 4,
		fill_ratio = def.fill_ratio,
		noise_params = def.noise_params or {
			offset = -1.25,
			scale = 0.25,
			spread = {x = 150, y = 150, z = 150},
			seed = 27162,
			octaves = 4,
			persist = 1.0
		},
		biomes = def.biomes,
		y_min = def.y_min or 1,
		y_max = def.y_max or 31000,	
		spawn_by = def.spawn_by,
		num_spawn_by = def.num_spawn_by,
		flags = def.flags or "force_placement",
		place_offset_y = def.place_offset_y or -1,
		decoration = def.decoration,
		height = def.height,
		height_max = def.height_max,
		param2 = def.param2,
		param2_max = def.param2_max,
		schematic = def.schematic,
		replacements = def.replacements,
		rotation = def.rotation,
	})
end

function earth.register_nodes_with(name, def)
	if def.base_node then
		def.base_node.tiles = def.base_node.tiles or {name:gsub(":", "_") .. ".png"}
		minetest.register_node(name, def.base_node)

		if def.base_node.deco then
			def.base_node.deco.decoration = def.base_node.deco.decoration or name 
			earth.register_deco(name, def.base_node.deco)
		end
	end

	for _, de in ipairs(def) do
		earth.register_node_with(name, de)
		
		if de.deco then
			de.deco.decoration = de.deco.decoration or name .. "_with_" .. de.with
			earth.register_deco(name, de.deco)
		end
	end
end

