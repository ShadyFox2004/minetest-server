-- earth_dungeon_loot/init.lua

dungeon_loot.register_loot({
	{name = "base_earth:flint", part = 40, count = {1, 3}},
	{name = "base_earth:sand", part = 80, count = {4, 32}, y = {-64, 32768}, 
		types = {"normal"}},
	{name = "base_earth:desert_sand", part = 80, count = {4, 32}, 
		y = {-64, 32768}, types = {"sandstone"}},
	{name = "base_earth:desert_cobble", part = 80, count = {4, 32}, 
		types = {"desert"}},
	{name = "base_earth:dirt", part = 60, count = {2, 16}, y = {-64, 32768}, 
		types = {"normal", "sandstone", "desert"}}
})

