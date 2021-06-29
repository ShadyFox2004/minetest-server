-- trees_dungeon_loot/init.lua 

local loot = {}

-- consumable
if minetest.get_modpath("base_trees") then
	table.insert(loot, {name = "base_trees:apple", part = 40, count = {1, 4}})
	table.insert(loot, {name = "base_trees:stick", part = 60, count = {3, 6}})
end

if minetest.get_modpath("cactus") then
	table.insert(loot, {name = "cactus:cactus", part = 40, count = {1, 4},
		types = {"sandstone", "desert"}})
end

dungeon_loot.register_loot(loot)

