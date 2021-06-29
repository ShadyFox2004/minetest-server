-- walls/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_walls")

walls.register_wall("base_walls:stone_cobble", {
	description = S("Cobblestone Wall"), 
	material = "base_earth:stone_cobble", 
})

walls.register_wall("base_walls:desert_stone_cobble", {
	description = S("Desert Cobblestone Wall"), 
	material = "base_earth:desert_stone_cobble"
})

