-- lights_api/init.lua

lights = {LIGHT_MAX = 14}

function lights.on_flood(pos, oldnode, newnode)
	local name = oldnode.name
	local index = name:find("_")
	if index then
		index = name:reverse():find("_")
		name = name:sub(1, #name - index)
	end 
	minetest.add_item(pos, ItemStack(name .. " 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"liquids_api_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1},
			true
		)
	end
	-- Remove the node
	return false
end

local function register_torch(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. (def.sub or ""), {
		description = def.description or txt,
		drawtype = def.drawtype or "mesh",
		mesh = def.mesh,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		tiles = def.tiles or {{
			name = txt .. "_animated.png",
			animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, 
				length = 3.3}
		}},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		liquids_pointable = def.liquids_pointable,
		light_source = def.light_source or 12,
		groups = def.groups,
		drop = def.drop or name,
		selection_box = def.selection_box,
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		floodable = true,
		floor_version = def.sub and name,
		on_flood = def.on_flood or lights.on_flood,
		_on_rotate = def.on_rotate or false,
		on_place = def.on_place
	})

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name .. (def.sub or ""),
			burntime = def.burntime,
		})
	end
end

function lights.register_torch_floor(name, def)
	local txt = name:gsub(":", "_")
	def.mesh = def.mesh or "lights_api_torch.obj"
	def.inventory_image = def.inventory_image or txt .. ".png"
	def.wield_image = def.wield_image or txt .. ".png"
	def.liquids_pointable = false
	def.groups = def.groups or {choppy=2, dig_immediate=3, flammable=1, 
		attached_node=1, torch=1}
	def.selection_box = def.selection_box or {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	}
	return register_torch(name, def)
end

function lights.register_torch_wall(name, def)
	local txt = name:gsub(":", "_")
	def.mesh = def.mesh or "lights_api_torch_wall.obj"
	def.groups = def.groups or {choppy=2, dig_immediate=3, flammable=1, 
		not_in_creative_inventory=1, attached_node=1, torch=1}
	def.selection_box = def.selection_box or {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	}
	def.sub = "_wall"
	return register_torch(name, def)
end

function lights.register_torch_ceiling(name, def)
	local txt = name:gsub(":", "_")
	def.mesh = def.mesh or "lights_api_torch_ceiling.obj"
	def.groups = def.groups or {choppy=2, dig_immediate=3, flammable=1, 
		not_in_creative_inventory=1, attached_node=1, torch=1}
	def.selection_box = def.selection_box or {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	}
	def.sub = "_ceiling"
	return register_torch(name, def)
end

function lights.register_torch(name, def)
	lights.register_torch_floor(name, def.floor)

	if def.wall then
		lights.register_torch_wall(name, def.wall)
	end

	if def.ceiling then
		lights.register_torch_ceiling(name, def.ceiling)
	end
end

function lights.register_light(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		tiles = def.tiles or {txt .. ".png"},
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		paramtype = "light",
		paramtype2 = def.paramtype2,
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = boolean.qq(def.walkable, true),
		light_source = lights.LIGHT_MAX,
		drop = def.drop,
		groups = def.groups or {dig_immediate = 3},
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		drawtype = def.drawtype,
		mesh = def.mesh,
		selection_box = def.selection_box,
		on_flood = def.on_flood,
		_on_rotate = def.on_rotate,
		on_place = def.on_place
	})
	
	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = def.burntime,
		})
	end
end
