minetest.set_gen_notify({dungeon = true, temple = true})

local function is_wall(node)
	return node.name ~= "air" and node.name ~= "ignore"
end

local dirs = {{x=1, z=0}, {x=-1, z=0}, {x=0, z=1}, {x=0, z=-1}}
function dungeon_loot.find_walls(cpos)
	local get_node = minetest.get_node

	local ret = {}
	local mindist = {x=0, z=0}
	local min = function(a, b) return a ~= 0 and math.min(a, b) or b end
	for _, dir in ipairs(dirs) do
		for i = 1, 9 do -- 9 = max room size / 2
			local pos = vector.add(cpos, {x=dir.x*i, y=0, z=dir.z*i})

			-- continue in that direction until we find a wall-like node
			local node = get_node(pos)
			if is_wall(node) then
				local front_below = vector.subtract(pos, {x=dir.x, y=1, z=dir.z})
				local above = vector.add(pos, {x=0, y=1, z=0})

				-- check that it:
				--- is at least 2 nodes high (not a staircase)
				--- has a floor
				if is_wall(get_node(front_below)) and is_wall(get_node(above)) then
					table.insert(ret, {pos = pos, facing = {x=-dir.x, y=0, z=-dir.z}})
					if dir.z == 0 then
						mindist.x = min(mindist.x, i-1)
					else
						mindist.z = min(mindist.z, i-1)
					end
				end
				-- abort even if it wasn't a wall cause something is in the way
				break
			end
		end
	end

	local biome = minetest.get_biome_data(cpos)
	biome = biome and minetest.get_biome_name(biome.biome) or ""
	local typ3 = "normal"
	if biome:find("desert") == 1 then
		typ3 = "desert"
	elseif biome:find("sandstone_desert") == 1 then
		typ3 = "sandstone"
	elseif biome:find("icesheet") == 1 then
		typ3 = "ice"
	end

	return {
		walls = ret,
		size = {x=mindist.x*2, z=mindist.z*2},
		typ3 = typ3,
	}
end

function dungeon_loot.populate_chest(pos, dungeontype)
	local inv = minetest.get_meta(pos):get_inventory()
	if not inv then return end

	local item_list, parts = dungeon_loot.get_loot(pos, dungeontype)
	item_list = rand.pick(parts, item_list, rand.dy(math.min(#item_list, 
		dungeon_loot.STACKS_PER_CHEST_MAX)))

	local items = {}
	for _, loot in ipairs(item_list) do
		local itemdef = minetest.registered_items[loot.name]
		local amount = 1
		if loot.count then
			amount = rand.az(loot.count[1], loot.count[2])
		end

		if itemdef.stack_max == 1 then
			-- not stackable, add separately
			for n = 1, amount do
				table.insert(items, loot.name)
			end
		else
			table.insert(items, ItemStack({name = loot.name, count = amount}))
		end
	end

	for _, item in ipairs(items) do
		inv:add_item("main", item)
	end
end

function dungeon_loot.filter_rooms(poslist)
	local rooms = {}
	-- process at most 8 rooms to keep runtime of this predictable
	local num_process = math.min(#poslist, 8)
	for i = 1, num_process do
		local room = dungeon_loot.find_walls(poslist[i])
		-- skip small rooms and everything that doesn't at least have 3 walls
		if math.min(room.size.x, room.size.z) >= 4 and #room.walls >= 3 then
			table.insert(rooms, room)
		end
	end
	return rooms
end

minetest.register_on_generated(function(minp, maxp, blockseed)
	local gennotify = minetest.get_mapgen_object("gennotify")
	local poslist = gennotify["dungeon"] or {}
	for _, entry in ipairs(gennotify["temple"] or {}) do
		table.insert(poslist, entry)
	end
	if #poslist == 0 then return end
	
	local rooms = dungeon_loot.filter_rooms(poslist)
	local num_chests = math.min(#rooms, rand.az(dungeon_loot.CHESTS_MIN, 
		dungeon_loot.CHESTS_MAX))

	local room
	for i = 1, num_chests do
		room = rooms[rand.dy(#rooms)] 
		-- choose place somewhere in front of any of the walls
		local wall = room.walls[rand.dy(#room.walls)]
		local v, vi -- vector / axis that runs alongside the wall
		if wall.facing.x ~= 0 then
			v, vi = {x=0, y=0, z=1}, "z"
		else
			v, vi = {x=1, y=0, z=0}, "x"
		end
		local chestpos = vector.add(wall.pos, wall.facing)
		local off = rand.az(-room.size[vi]/2 + 1, room.size[vi]/2 - 1)
		chestpos = vector.add(chestpos, vector.multiply(v, off))

		if minetest.get_node(chestpos).name == "air" then
			-- make it face inwards to the room
			local facedir = minetest.dir_to_facedir(vector.multiply(wall.facing, -1))
			minetest.add_node(chestpos, {name = "chests:common", param2 = facedir})
			dungeon_loot.populate_chest(chestpos, room.typ3)
		end
	end
end)
