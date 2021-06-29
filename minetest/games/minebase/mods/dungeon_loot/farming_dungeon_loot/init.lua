-- farming_dungeon_loot/init.lua

local loot = {}

if minetest.global_exists("wheat") then
	table.insert({name = "wheat:wheat", part = 50, count = {2, 5}})
end

if minetest.global_exists("dungeon_loot") then
	table.insert(loot, {name = "cotton:string", part = 50, count = {1, 8}})
	table.insert(loot, {name = "cotton:cotton_seed", part = 40, count = {1, 4},
			types = {"normal"}})
end

dungeon_loot.register_loot(loot)
