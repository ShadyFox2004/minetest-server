-- base_tools/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("base_tools")

--
-- tool sets
--

tools.register_set("base_tools:wood", {
	material = "group:wood",
	pick = {
		description = S("Wooden Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		groups = {pickaxe = 1, flammable = 2}
	},
	shovel = {
		description = S("Wooden Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		groups = {shovel = 1, flammable = 2}
	},
	axe = {
		description = S("Wooden Axe"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=0,
			groupcaps={
				choppy = {times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		groups = {axe = 1, flammable = 2}
	},
	sword = {
		description = S("Wooden Sword"),
		tool_capabilities = {
			full_punch_interval = 1,
			max_drop_level=0,
			groupcaps={
				snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		},
		groups = {sword = 1, flammable = 2}
	}
})

tools.register_set("base_tools:stone", {
	material = "group:stone",
	pick = {
		description = S("Stone Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 1.3,
			max_drop_level=0,
			groupcaps={
				cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
			},
			damage_groups = {fleshy=3},
		}
	},
	shovel = {
		description = S("Stone Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.4,
			max_drop_level=0,
			groupcaps={
				crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
			},
			damage_groups = {fleshy=2},
		}
	},
	axe = {
		description = S("Stone Axe"),
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
			},
			damage_groups = {fleshy=3},
		},
	},
	sword = {
		description = S("Stone Sword"),
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level=0,
			groupcaps={
				snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
			},
			damage_groups = {fleshy=4},
		}
	}
})

tools.register_set("base_tools:bronze", {
	material = "base_ores:bronze_ingot",
	pick = {
		description = S("Bronze Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[1]=4.50, [2]=1.80, [3]=0.90}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
	},
	shovel = {
		description = S("Bronze Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.1,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.65, [2]=1.05, [3]=0.45}, uses=25, maxlevel=2},
			},
			damage_groups = {fleshy=3},
		},
	},
	axe = {
		description = S("Bronze Axe"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.75, [2]=1.70, [3]=1.15}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
	},
	sword = {
		description = S("Bronze Sword"),
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.75, [2]=1.30, [3]=0.375}, uses=25, maxlevel=2},
			},
			damage_groups = {fleshy=6},
		},
	}
})

tools.register_set("base_tools:steel", {
	material = "base_ores:steel_ingot",
	pick = {
		description = S("Steel Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
	},
	shovel = {
		description = S("Steel Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.1,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
			},
			damage_groups = {fleshy=3},
		},
	},
	axe = {
		description = S("Steel Axe"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
	},
	sword = {
		description = S("Steel Sword"),
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
			},
			damage_groups = {fleshy=6},
		},
	}
})

tools.register_set("base_tools:mese", {
	material = "base_ores:mese_crystal",
	pick = {
		description = S("Mese Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=3,
			groupcaps={
				cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=5},
		},
	},
	shovel = {
		description = S("Mese Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=3,
			groupcaps={
				crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=4},
		},
	},
	axe = {
		description = S("Mese Axe"),
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=6},
		},
	},
	sword = {
		description = S("Mese Sword"),
		tool_capabilities = {
			full_punch_interval = 0.7,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=7},
		},
	}
})

tools.register_set("base_tools:diamond", {
	material = "base_ores:diamond_crystal",
	pick = {
		description = S("Diamond Pickaxe"),
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=3,
			groupcaps={
				cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=5},
		},
	},
	shovel = {
		description = S("Diamond Shovel"),
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=4},
		},
	},
	axe = {
		description = S("Diamond Axe"),
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=7},
		},
	},
	sword = {
		description = S("Diamond Sword"),
		tool_capabilities = {
			full_punch_interval = 0.7,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
			},
			damage_groups = {fleshy=8},
		}
	}
})

--
-- Register Craft Recipies
--

minetest.register_craft({
	type = "fuel",
	recipe = "base_tools:wood_pick",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_tools:wood_shovel",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_tools:wood_axe",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_tools:wood_sword",
	burntime = 5,
})
