-- ore_dungeon_loot/init.lua

dungeon_loot.register_loot({
	{name = "base_ores:coal_lump", part = 90, count = {1, 12}},
	{name = "base_ores:gold_ingot", part = 50},
	{name = "base_ores:steel_ingot", part = 40, count = {1, 6}},
	{name = "base_ores:mese_crystal", part = 10, count = {2, 3}},
	{name = "base_ores:mese_block", part = 15, y = {-32768, -512}}
})
