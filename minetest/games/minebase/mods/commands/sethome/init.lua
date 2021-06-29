-- sethome/init.lua

sethome = {}

-- Load support for Minebase translation.
local S = minetest.get_translator("sethome")

function sethome.set(name, pos)
	local player = minetest.get_player_by_name(name)
	if not player or not pos then
		return false
	end
	player:get_meta():set_string("sethome:home", minetest.pos_to_string(pos))
	return true
end

function sethome.get(name)
	local player = minetest.get_player_by_name(name)
	if player then
		local pos = minetest.string_to_pos(player:get_meta()
			:get_string("sethome:home"))
		if pos then
			return pos
		end
	end
end

function sethome.go(name)
	local pos = sethome.get(name)
	local player = minetest.get_player_by_name(name)
	if player and pos then
		player:set_pos(pos)
		return true
	end
	return false
end

minetest.register_privilege("home", {
	description = S("Can use /sethome and /home"),
	give_to_singleplayer = false
})

minetest.register_chatcommand("home", {
	description = S("Teleport you to your home point"),
	privs = {home = true},
	func = function(name)
		if sethome.go(name) then
			return true, S("Teleported to home!")
		end
		return false, S("Set a home using /sethome")
	end,
})

minetest.register_chatcommand("sethome", {
	description = S("Set your home point"),
	privs = {home = true},
	func = function(name)
		name = name or "" -- fallback to blank name if nil
		local player = minetest.get_player_by_name(name)
		if player and sethome.set(name, player:get_pos()) then
			return true, S("Home set!")
		end
		return false, S("Player not found!")
	end,
})
