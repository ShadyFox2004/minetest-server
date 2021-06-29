-- seats_api/init.lua

seats = {passengers = {}}
local v000 = {x = 0, y = 0, z = 0}

local function after_attach(player, animation)
	players.set_animation(player, animation, 30)
end

local function after_detach(player, pos)
	player:set_pos(pos)
end

-------------------------------------------------------------------------------

minetest.register_on_shutdown(function()
	local players = minetest.get_connected_players()
	for i = 1, #players do
		seats.detach_on(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	seats.detach_on(player)
	return true
end)

-------------------------------------------------------------------------------

function seats.attach(entity, player, seat, animation)
	seat = seat or #entity._passengers + 1
	local attach_at = entity._attach_at[seat] or v000
	local eye_offset = entity._eye_offset[seat] or v000
	
	entity._passengers[seat] = player
	seats.passengers[player] = entity

	player:set_attach(entity.object, "", attach_at, entity._player_rotation 
		or nil)
	players.player_attached[player:get_player_name()] = true
	player:set_eye_offset(eye_offset, {x=0, y=0, z=0})
	minetest.after(0.2, after_attach, player, animation or "sit")
end

function seats.attached(entity, player)
	for i, passenger in pairs(entity._passengers) do
		if player == passenger then
			return i
		end
	end 
	return nil
end

function seats.force_detach(player)
	local attached_to = player:get_attach()
	if attached_to then
		local entity = attached_to:get_luaentity()
		local seat = seats.attached(entity, player)
		if seat then
			entity._passengers[seat] = nil
			seats.passengers[player] = nil
		end
		player:set_detach()
		players.player_attached[player:get_player_name()] = false
		player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
		players.set_animation(player, "stand", 30, "force_detach")
	end
end

function seats.detach_on(player)
	local entity = seats.passengers[player]
	if entity then
		local seat = seats.attached(entity, player)
		if seat then
			entity._passengers[seat] = nil
		end
		seats.passengers[player] = nil
		players.player_attached[player:get_player_name()] = false
		players.set_animation(player, "stand", 30, "force_detach")
	end
end

function seats.detach(player, offset)
	offset = offset or v000
	seats.force_detach(player)
	local pos = player:get_pos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, after_detach, player, pos)
end

function seats.detach_all(entity)
	for seat, passenger in pairs(entity._passengers) do
		seats.detach(passenger, entity._detach_offset[seat])
	end
end

function seats.on_activate(entity)
	if not entity._passengers then
		entity._passengers = {}
	end
end

function seats.on_rightclick(entity, clicker, attach)
	if not clicker or not clicker:is_player() then
		return
	end
	attach = attach or seats.attach
	local seat = seats.attached(entity, clicker)
	if seat then
		seats.detach(clicker, entity._detach_offset[seat])
	else
		if entity._owner == clicker:get_player_name() then
			seats.force_detach(clicker)
			attach(entity, clicker, 1)
		elseif entity._passengers[1] and t4b.count(entity._passengers) 
			< entity._max_passengers then
			seats.force_detach(clicker)
			attach(entity, clicker)
		end
	end
end

function seats.on_detach_child(_, child)
	return seats.detach_on(child)
end

minetest.register_on_leaveplayer(seats.detach_on)
