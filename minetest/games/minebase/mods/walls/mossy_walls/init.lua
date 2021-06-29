-- mossy_walls/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("mossy_walls")

walls.register_wall("mossy_walls:stone_cobble", {
	description = S("Mossy Cobblestone Wall"), 
	material = "mossy:stone_cobble"
})

mossy.register_growth("mossy_walls:stone_cobble", {
	nodenames = {"base_walls:stone_cobble"},
	map = {
		["base_walls:stone_cobble"] = "mossy_walls:stone_cobble",
	}
})
