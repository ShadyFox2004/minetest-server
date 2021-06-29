-- liquids_dungeon_loot/init.lua 

dungeon_loot.register_loot({
	{name = "base_liquids:snow", part = 80, count = {8, 64}, y = {-64, 32768}, 
		types = {"ice"}},
	{name = "base_liquids:obsidian", part = 25, count = {1, 3}, 
		y = {-32768, -512}}
})

