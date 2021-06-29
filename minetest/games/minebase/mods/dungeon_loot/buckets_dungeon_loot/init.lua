-- buckets_dungeon_loot/init.lua

local loot = {{name = "buckets_api:bucket_empty", part = 55}}

if minetest.get_modpath("buckets_lava") then
	table.insert(loot, {name = "buckets_lava:bucket", part = 45, 
		y = {-32768, -1}, types = {"normal"}})
end

if minetest.get_modpath("buckets_water") then
	table.insert(loot, {name = "buckets_water:bucket", part = 45,
		types = {"sandstone", "desert", "ice"}})
	table.insert(loot, {name = "buckets_water:bucket", part = 45, 
		y = {0, 32768}, types = {"normal"}})
end

dungeon_loot.register_loot(loot)

