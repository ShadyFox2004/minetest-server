-- base_fences/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("base_fences")

fences.register_fence("base_fences:apple_wood", {
	post = {
		description = S("Apple Wood Fence"),
		material = "base_trees:apple_wood",
		burntime = 7,
	},
	rail = {
		description = S("Apple Wood Fence Rail"),
		burntime = 5
	},
	mesepost = {description = S("Apple Wood Mese Post Light")},
	gate = {description = S("Apple Wood Fence Gate")}
})

fences.register_fence("base_fences:acacia_wood", {
	post = {
		description = S("Acacia Wood Fence"),
		material = "base_trees:acacia_wood",
		burntime = 8,
	},
	rail = {
		description = S("Acacia Wood Fence Rail"),
		burntime = 6,
	},
	mesepost = {description = S("Acacia Wood Mese Post Light")},
	gate = {description = S("Acacia Wood Fence Gate")}
})

fences.register_fence("base_fences:jungle_wood", {
	post = {
		description = S("Jungle Wood Fence"),
		material = "base_trees:jungle_wood",
		burntime = 9,
	},
	rail = {
		description = S("Jungle Wood Fence Rail"),
		burntime = 7,
	},
	mesepost = {description = S("Jungle Wood Mese Post Light")},
	gate = {description = S("Jungle Wood Fence Gate")}
})

fences.register_fence("base_fences:pine_wood", {
	post = {
		description = S("Pine Wood Fence"),
		material = "base_trees:pine_wood",
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		burntime = 6,
	},
	rail = {
		description = S("Pine Wood Fence Rail"),
		burntime = 4,
	},
	mesepost = {description = S("Pine Wood Mese Post Light")},
	gate = {description = S("Pine Wood Fence Gate")}
})

fences.register_fence("base_fences:aspen_wood", {
	post = {
		description = S("Aspen Wood Fence"),
		material = "base_trees:aspen_wood",
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		burntime = 5,
	},
	rail = {
		description = S("Aspen Wood Fence Rail"),
		burntime = 3,
	},
	mesepost = {description = S("Aspen Wood Mese Post Light")},
	gate = {description = S("Aspen Wood Fence Gate")}
})

