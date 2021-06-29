mounts = {}

------------------------------------------------------------------------------

local function node_is(pos)
	local node = minetest.get_node(pos)
	if node.name == "air" then
		return "air"
	end
	if minetest.get_item_group(node.name, "liquid") ~= 0 then
		return "liquid"
	end
	if minetest.get_item_group(node.name, "walkable") ~= 0 then
		return "walkable"
	end
	return "other"
end

local function get_sign(i)
	i = i or 0
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

-------------------------------------------------------------------------------

function mounts.get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

function mounts.attach(entity, player, seat)
	if not entity._player_rotation then
		entity._player_rotation = {x=0, y=0, z=0}
	end

	local rot_view = 0
	if entity._player_rotation.y == 90 then
		rot_view = math.pi / 2
	end

	seats.attach(entity, player, seat)
	player:set_look_horizontal(entity.object:get_yaw() - rot_view)
end

local aux_timer = 0

local function after_crash(entity)
	entity.object:remove()
end

function mounts.drive(entity, dtime, moveresult, is_mob, moving_anim, 
	stand_anim, jump_height, can_fly, can_go_down, can_go_up, crash_threshold)
	-- Sanity checks
	local ent_def = minetest.registered_entities[entity._name]

	can_fly = can_fly or ent_def._can_fly
	can_go_down = can_go_down or ent_def._can_go_down
	can_go_up = can_go_up or ent_def._can_go_up
	crash_threshold = crash_threshold or ent_def._crash_threshold

	for seat, passenger in pairs(entity._passengers) do
		if not passenger:get_attach() then
			entity._passengers[seat] = nil
		end
	end

	aux_timer = aux_timer + dtime

	if can_fly then
		jump_height = 0
	end

	local rot_steer, rot_view = math.pi / 2, 0
	if entity._player_rotation.y == 90 then
		rot_steer, rot_view = 0, math.pi / 2
	end

	local acce_y = 0

	local velo = entity.object:get_velocity()
	entity._v = get_v(velo) * get_sign(entity._v)

	-- process controls
	if entity._passengers[1] then
		local ctrl = entity._passengers[1]:get_player_control()
		if ctrl.aux1 then
			if aux_timer >= 0.2 then
				entity._mouselook = not entity._mouselook
				aux_timer = 0
			end
		end
		if ctrl.up then
			if get_sign(entity._v) >= 0 then
				entity._v = entity._v + entity._accel / 10
			else
				entity._v = entity._v + entity._braking / 10
			end
		elseif ctrl.down then
			if entity._max_speed_reverse == 0 and entity._v == 0 then return end
			if get_sign(entity._v) < 0 then
				entity._v = entity._v - entity._accel / 10
			else
				entity._v = entity._v - entity._braking / 10
			end
		end
		if entity._mouselook then
			if ctrl.left then
				entity.object:set_yaw(entity.object:get_yaw() + get_sign(entity._v)
					* math.rad(1 + dtime) * entity._turn_speed)
			elseif ctrl.right then
				entity.object:set_yaw(entity.object:get_yaw() - get_sign(entity._v)
					* math.rad(1 + dtime) * entity._turn_speed)
			end
		else
			entity.object:set_yaw(entity._passengers[1]:get_look_horizontal() 
				- rot_steer + 1.570796)
		end
		if ctrl.jump then
			if jump_height > 0 and velo.y == 0 then
				velo.y = velo.y + (jump_height * 3) + 1
				acce_y = acce_y + (acce_y * 3) + 1
			end
			if can_go_up and can_fly == true then
				velo.y = velo.y + 1
				acce_y = acce_y + 1
			end
		end
		if ctrl.sneak then
			if can_go_down and can_fly == true then
				velo.y = velo.y - 1
				acce_y = acce_y - 1
			end
		end
	end

	-- if not moving then set animation and return
	if entity._v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		if is_mob then
			if stand_anim and stand_anim ~= nil then
				set_animation(entity, stand_anim)
			end
		end
		return
	end

	-- set animation
	if is_mob then
		if moving_anim and moving_anim ~= nil then
			set_animation(entity, moving_anim)
		end
	end

	-- Stop!
	local s = get_sign(entity._v)
	entity._v = entity._v - 0.02 * s
	if s ~= get_sign(entity._v) then
		entity.object:set_velocity({x = 0, y = 0, z = 0})
		entity._v = 0
		return
	end

	-- Stop! (upwards and downwards; applies only if `can_fly` is enabled)
	if can_fly == true then
		local s2 = get_sign(velo.y)
		local s3 = get_sign(acce_y)
		velo.y = velo.y - 0.02 * s2
		acce_y = acce_y - 0.02 * s3
		if s2 ~= get_sign(velo.y) then
			entity.object:set_velocity({x=0, y=0, z=0})
			velo.y = 0
			return
		end
		if s3 ~= get_sign(acce_y) then
			entity.object:set_velocity({x=0, y=0, z=0})
			acce_y = 0 -- luacheck: ignore
			return
		end
	end

	-- enforce speed limit forward and reverse
	local max_spd = entity._max_speed_reverse
	if get_sign(entity._v) >= 0 then
		max_spd = entity._max_speed_forward
	end
	if math.abs(entity._v) > max_spd then
		entity._v = entity._v - get_sign(entity._v)
	end

	-- Enforce speed limit when going upwards or downwards (applies only if 
	-- `can_fly` is enabled)
	if can_fly == true then
		local max_spd_flying = entity._max_speed_downward
		if get_sign(velo.y) >= 0 or get_sign(acce_y) >= 0 then
			max_spd_flying = entity._max_speed_upward
		end

		if math.abs(velo.y) > max_spd_flying then
			velo.y = velo.y - get_sign(velo.y)
		end
		
		if math.abs(acce_y) > max_spd_flying then
			acce_y = acce_y - get_sign(acce_y)
		end
	end

	-- Set position, velocity and acceleration
	local p = entity.object:get_pos()
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = -9.8, z = 0}

	p.y = p.y - 0.5
	local ni = node_is(p)
	local v = entity._v
	if ni == "air" then
		if can_fly == true then
			new_acce.y = 0
			-- When going down, this will prevent from exceeding the maximum speed.
			acce_y = acce_y - get_sign(acce_y) 
		end
	elseif ni == "liquid" then
		if entity._terrain_type == 2 or entity._terrain_type == 3 then
			new_acce.y = 0
			p.y = p.y + 1
			if node_is(p) == "liquid" then
				if velo.y >= 5 then
					velo.y = 5
				elseif velo.y < 0 then
					new_acce.y = 20
				else
					new_acce.y = 5
				end
			else
				if math.abs(velo.y) < 1 then
					local pos = entity.object:get_pos()
					pos.y = math.floor(pos.y) + 0.5
					entity.object:set_pos(pos)
					velo.y = 0
				end
			end
		else
			v = v*0.25
		end
	--elseif ni == "walkable" then
		--v = 0
		--new_acce.y = 1
	end

	new_velo = mounts.get_velocity(v, entity.object:get_yaw() - rot_view, 
		velo.y)
	new_acce.y = new_acce.y + acce_y

	entity.object:set_velocity(new_velo)
	entity.object:set_acceleration(new_acce)

	-- CRASH!
	--[==[
	if moveresult.collides then
		local intensity = entity._v2 - v
		print(dump(moveresult))
		if intensity >= crash_threshold then
			if is_mob then
				entity.object:set_hp(entity.object:get_hp() - intensity)
			else
				for seat, passenger in pairs(entity._passengers) do
					seats.detach(passenger, entity._detach_offset[seat])
					passenger:set_velocity(new_velo)
					passenger:set_hp(passenger:get_hp() - intensity)
				end

				local pos = entity.object:get_pos()

				------------------
				-- Handle drops --
				------------------

				--[[ `entity.drop_on_destory` is table which stores all the items that 
					will be dropped on destroy.
					It will drop one of those items, from `1` to the length, or the end of 
					the table.
				]]

				local i, j
				if #entity._drop_on_destroy > 1 then
					i = rand.az(1, #entity._drop_on_destroy or 1)
					j = rand.az(2, #entity._drop_on_destroy or 2)
				else
					i, j = 1, 1
				end

				minetest.add_item(pos, entity._drop_on_destroy[i])
				if i ~= j then
					minetest.add_item(pos, entity._drop_on_destroy[j])
				end

				entity._removed = true
				-- delay remove to ensure player is detached
				minetest.after(0.1, after_crash, entity)
			end
		end
	end
	--]==]

	entity._v2 = v
end

function mounts.on_rightclick(entity, clicker)
	return seats.on_rightclick(entity, clicker, mounts.attach)
end

local function fromStatic(str)
	local out = minetest.deserialize(str)
	if type(out) == "table" then
		for key, stat in pairs(out) do
			if type(stat) == "string" and stat:find("^return") then
				out[key] = fromStatic(stat)
			else
				out[key] = stat
			end
		end
	end
	return out
end

local function toStatic(tab)
	local out = {}
	for key, stat in pairs(tab) do
		local typ3 = type(stat)
		if typ3 == 'table' then
			out[key] = minetest.serialize(toStatic(stat))
		elseif typ3 ~= 'function' and typ3 ~= 'nil' and typ3 ~= 'userdata' then
			out[key] = tab[key]
		end
	end
	return out
end

function mounts.on_activate(entity, staticdata, dtime_s)
	entity.object:set_armor_groups({immortal = 1})
	local data = fromStatic(staticdata)
	if data then
		for key, stat in pairs(data) do
			entity[key] = stat
		end
	end
	seats.on_activate(entity)
	entity._v2 = entity._v
end

function mounts.get_staticdata(entity)
	return minetest.serialize(toStatic(entity))
end

local function after_punch(entity)
	entity.object:remove()
end

function mounts.on_punch(entity, puncher)
	if not puncher or not puncher:is_player() or entity._removed 
		or entity._passengers[1] then
		return
	end
	local punchername = puncher:get_player_name()
	if entity._owner == punchername or minetest.get_player_privs(punchername)
		.protection_bypass then
		entity._removed = true
		seats.detach_all(entity)
		-- delay remove to ensure player is detached
		minetest.after(0.1, after_punch, entity)
		if not minetest.is_creative_enabled(punchername) then
			puncher:get_inventory():add_item("main", entity._name)
		else
			local inv = puncher:get_inventory()
			if not inv:contains_item("main", entity._name) then
				inv:add_item("main", entity._name)
			end
		end
	end
end

function mounts.on_step(entity, dtime, moveresult)
	mounts.drive(entity, dtime, moveresult, false, nil, nil, 0)
end

function mounts.register_entity(name, def)
	minetest.register_entity(name, {
		infotext = def.infotext, 
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual or "mesh",
		mesh = def.mesh,
		visual_size = def.visual_size,
		textures = def.textures,
		stepheight = def.stepheight,
		on_rightclick = def.on_rightclick or mounts.on_rightclick,
		on_activate = def.on_activate or mounts.on_activate,
		get_staticdata = def.get_staticdata or mounts.get_staticdata,
		on_punch = def.on_punch or mounts.on_punch,
		on_step = def.on_step or mounts.on_step,
		on_detach_child = seats.on_detach_child,

		_terrain_type = def.terrain_type,
		_can_fly = def.can_fly,
		_can_go_down = def.can_go_down,
		_can_go_up = def.can_go_up,
		_player_rotation = def.player_rotation,
		_attach_at = def.attach_at or {{x = 0, y = 0, z = 0}},
		_eye_offset = def.eye_offset or {{x = 0, y = 0, z = 0}},
		_pos_offset = def.pos_offset or {{x = 0, y = 0, z = 0}},
		_detach_offset = def.detach_offset or {{x = 0, y = 0, z = 0}},
		_max_passengers = def.max_passengers or 1,
		_crash_threshold = def.crash_threshold or 2,
		_max_speed_forward = def.max_speed_forward,
		_max_speed_reverse = def.max_speed_reverse,
		_max_speed_upward = def.max_speed_upward,
		_max_speed_downward = def.max_speed_downward,
		_accel = def.accel,
		_braking = def.braking,
		_turn_speed = def.turn_speed,
		_drop_on_destroy = def.drop_on_destroy or {},
		_v = 0,
		_v2 = 0,
		_mouselook = false,
		_removed = false,
		_owner = "",
		_name = name
	})
end

function mounts.on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return
	end
	local def = itemstack:get_definition()
	local name = itemstack:get_name()

	local ent
	if minetest.get_item_group(minetest.get_node(pointed_thing.under).name, 
		"liquid") == 0 then
		if def._terrain_type == 0 or def._terrain_type == 1 
			or def._terrain_type == 3 then
			pointed_thing.above.y = pointed_thing.above.y + def._on_place_position_adj
			ent = minetest.add_entity(pointed_thing.above, name)
		else
			return
		end
	else
		if def._terrain_type == 2 or def._terrain_type == 3 then
			pointed_thing.under.y = pointed_thing.under.y + 0.5
			ent = minetest.add_entity(pointed_thing.under, name)
		else
			return
		end
	end
	if ent:get_luaentity()._player_rotation.y == 90 then
		ent:set_yaw(placer:get_look_horizontal())
	else
		ent:set_yaw(placer:get_look_horizontal() - math.pi / 2)
	end
	local name = placer:get_player_name()
	ent:get_luaentity()._owner = name
	if not minetest.is_creative_enabled(name) then
		itemstack:take_item()
	end
	return itemstack
end

function mounts.register_craftitem(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.description or txt,
		inventory_image = def.inventory_image or txt .. "_inventory.png",
		wield_image = def.wield_image or txt .. "_wield.png",
		wield_scale = def.wield_scale,
		groups = def.groups,
		liquids_pointable = def.terrain_type == 2 or def.terrain_type == 3,
		on_place = def.on_place or mounts.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		on_use = def.on_use,
		after_use = def.after_use,
		_terrain_type = def.terrain_type,
		_on_place_position_adj = def.on_place_position_adj
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
			burntime = def.burntime
		})
	end
end

function mounts.register_mount(name, def)
	mounts.register_entity(name, def.entity)

	if def.craftitem then
		def.craftitem.terrain_type = def.entity.terrain_type
		mounts.register_craftitem(name, def.craftitem)
	end
end
