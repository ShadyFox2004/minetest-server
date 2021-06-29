-- mossy_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("mossy_stairs")

stairs.register_all("mossy_stairs:stone_cobble", {
	material = "mossy:stone_cobble",
	groups = {cracky = 3},
	tiles = {"mossy_stone_cobble.png"},
	stair_description = S("Mossy Cobblestone Stair"),
	slab_description = S("Mossy Cobblestone Slab"),
	inner_stair_description = S("Inner Mossy Cobblestone Stair"),
	outer_stair_description = S("Outer Mossy Cobblestone Stair"),
	step_description = S("Mossy Cobblestone Step"),
	inner_step_description = S("Inner Mossy Cobblestone Step"),
	outer_step_description = S("Outer Mossy Cobblestone Step"),
	steps_description = S("Mossy Cobblestone Steps"),
	steps_half_description = S("Mossy Cobblestone Steps Half"),
	steps_slab_description = S("Mossy Cobblestone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

mossy.register_growth("mossy_stairs:mossy", {
	nodenames = {"earth_stairs:stone_cobble_slab", 
		"earth_stairs:stone_cobble_stair", "earth_stairs:stone_cobble_inner_stair", 
		"earth_stairs:stone_cobble_outer_stair", "earth_stairs:stone_cobble_step",
		"earth_stairs:stone_cobble_inner_step",
		"earth_stairs:stone_cobble_outer_step", "earth_stairs:stone_cobble_steps",
		"earth_stairs:stone_cobble_steps_half", "earth_stairs:stone_cobble_steps_slab",
	},
	map = {
		["earth_stairs:stone_cobble_slab"] = "mossy_stairs:stone_cobble_slab",
		["earth_stairs:stone_cobble_stair"] = "mossy_stairs:stone_cobble_stair",
		["earth_stairs:stone_cobble_inner_stair"] 
			= "mossy_stairs:stone_cobble_inner_stair",
		["earth_stairs:stone_cobble_outer_stair"] 
			= "mossy_stairs:stone_cobble_outer_stair",
		["earth_stairs:stone_cobble_step"] = "mossy_stairs:stone_cobble_step",
		["earth_stairs:stone_cobble_inner_step"] = "mossy_stairs:stone_cobble_inner_step",
		["earth_stairs:stone_cobble_outer_step"] = "mossy_stairs:stone_cobble_outer_step",
		["earth_stairs:stone_cobble_steps"] = "mossy_stairs:stone_cobble_steps",
		["earth_stairs:stone_cobble_steps_half"] = "mossy_stairs:stone_cobble_steps_half",
		["earth_stairs:stone_cobble_steps_slab"] = "mossy_stairs:stone_cobble_steps_slab" 
	}
})

