local storage = minetest.get_mod_storage()
local world_path = minetest.get_worldpath()
local org_file = world_path .. "/beds_spawns"
local file = world_path .. "/beds_spawns"
local bkwd = false

-- check for PA's beds mod spawns
local cf = io.open(world_path .. "/beds_player_spawns", "r")
if cf ~= nil then
	io.close(cf)
	file = world_path .. "/beds_player_spawns"
	bkwd = true
end

local function read_spawns()
	local input = io.open(file, "r")
	if input then
		if not bkwd then
			repeat
				local x = tonumber(input:read("*n"))
				if x == nil then
					break
				end
				local y = tonumber(input:read("*n"))
				local z = tonumber(input:read("*n"))
				local name = input:read("*l"):sub(2)
				local pos = {x = x, y = y, z = z}
				beds.spawn[name] = pos
				storage:set_string(name, minetest.serialize(pos))
			until input:read(0) == nil
		else
			beds.spawn = minetest.deserialize(input:read("*all"))
			for name, pos in pairs(beds.spawn) do
				print(34, dump)
				storage:set_string(name, minetest.serialize(pos))
			end
		end
		io.close(input)
		os.remove(file)
	else 
		local tab = storage:to_table().fields
		for name, pos in pairs(tab) do
			beds.spawn[name] = minetest.deserialize(pos)
		end
	end
end
read_spawns()

function beds.set_spawn(name, pos)
	local player = minetest.get_player_by_name(name)
	pos = vector.round(pos)
	if not minetest.is_protected(pos, name) then
		beds.spawn[name] = pos
		storage:set_string(name, minetest.serialize(pos))
	end
end

function beds.remove_spawns_at(pos)
	for name, pos2 in pairs(beds.spawn) do
		if vector.equals(vector.round(pos2), pos) then
			beds.spawn[name] = nil
			storage:set_string(name, "")
		end
	end
end
