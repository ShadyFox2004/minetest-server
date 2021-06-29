-- base_initial_stuff/init.lua

local stuff_string = minetest.settings:get("initial_stuff") or
		"base_tools:steel_pick,base_tools:steel_axe,base_tools:steel_shovel," ..
		"torches:common 99,base_earth:stone_cobble 99"

initial_stuff.add_from_csv(stuff_string)
