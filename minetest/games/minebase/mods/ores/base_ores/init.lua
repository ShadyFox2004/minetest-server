-- base_ores/init.lua

local S = minetest.get_translator("base_ores")

ores.register_metal("base_ores:copper", {
	lump = {description = S("Copper Lump")},
	ingot = {description = S("Copper Ingot")},
	mineral = {description = S("Copper Ore")},
	block = {description = S("Copper Block")},
	scatter_ores = {{
			clust_scarcity = 9 * 9 * 9,
			clust_num_ores = 5,
			y_min          = 1025,
		}, {
			clust_scarcity = 12 * 12 * 12,
			clust_num_ores = 4,
			y_max          = -64,
			y_min          = -127,
		}, {
			clust_scarcity = 9 * 9 * 9,
			clust_num_ores = 5,
			y_max          = -128,
		}
	}
})

ores.register_metal("base_ores:gold", {
	lump = {description = S("Gold Lump")},
	ingot = {description = S("Gold Ingot")},
	mineral = {description = S("Gold Ore")},
	block = {description = S("Gold Block")},
	scatter_ores = {{
			clust_scarcity = 13 * 13 * 13,
			clust_num_ores = 5,
			y_min          = 1025,
		}, {
			clust_scarcity = 15 * 15 * 15,
			clust_num_ores = 3,
			clust_size     = 2,
			y_max          = -256,
			y_min          = -511,
		}, {
			clust_scarcity = 13 * 13 * 13,
			clust_num_ores = 5,
			y_max          = -512,
		}
	}
})

ores.register_metal("base_ores:tin", {
	lump = {description = S("Tin Lump")},
	ingot = {description = S("Tin Ingot")},
	mineral = {description = S("Tin Ore")},
	block = {description = S("Tin Block")},
	scatter_ores = {{
			clust_scarcity = 10 * 10 * 10,
			clust_num_ores = 5,
			y_min          = 1025,
		}, {
			clust_scarcity = 13 * 13 * 13,
			clust_num_ores = 4,
			y_max          = -64,
			y_min          = -127,
		}, {
			clust_scarcity = 10 * 10 * 10,
			clust_num_ores = 5,
			y_max          = -128,
		}
	}
})

-- coal 
ores.register_metal("base_ores:coal", {
	lump = {
		description = S("Coal Lump"),
		groups = {coal = 1, flammable = 1}
	},
	mineral = {
		description = S("Coal Ore"),
		groups = {cracky = 3},
	},
	block = {
		description = S("Coal Block"),
		groups = {cracky = 3},
	},
	scatter_ores = {{
			clust_scarcity = 8 * 8 * 8,
			clust_num_ores = 9,
			y_min          = 1025,
		}, {
			clust_scarcity = 8 * 8 * 8,
			clust_num_ores = 8,
			y_max          = 64,
			y_min          = -127,
		}, {
			clust_scarcity = 12 * 12 * 12,
			clust_num_ores = 30,
			clust_size     = 5,
			y_max          = -128,
		}
	}
})

craft.register_craft19("base_ores:coal_block", "base_ores:coal_lump")

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_ores:coal_block",
	burntime = 370
})

-- iron/steel
ores.register_metal("base_ores:iron", {
	lump = {description = S("Iron Lump")},
	mineral = {description = S("Iron Ore")},
	scatter_ores = {{
			clust_scarcity = 9 * 9 * 9,
			clust_num_ores = 12,
			y_min          = 1025,
		}, {
			clust_scarcity = 7 * 7 * 7,
			clust_num_ores = 5,
			y_max          = -128,
			y_min          = -255,
		}, {
			clust_scarcity = 12 * 12 * 12,
			clust_num_ores = 29,
			clust_size     = 5,
			y_max          = -256,
		}
	}
})

ores.register_metal("base_ores:steel", {
	ingot = {description = S("Steel Ingot")},
	block = {description = S("Steel Block")}
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:steel_ingot",
	recipe = "base_ores:iron_lump",
})

-- bronze
minetest.register_craft({
	output = "base_ores:bronze_ingot 9",
	recipe = {
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:tin_ingot", "base_ores:copper_ingot"},
		{"base_ores:copper_ingot", "base_ores:copper_ingot", "base_ores:copper_ingot"},
	}
})

ores.register_metal("base_ores:bronze", {
	ingot = {description = S("Bronze Ingot")},
	block = {description = S("Bronze Block")}
})

-- crystals 
ores.register_crystal("base_ores:diamond", {
	crystal = {description = S("Diamond")},
	mineral = {description = S("Diamond Ore")},
	block = {
		description = S("Diamond Block"),
		groups = {cracky = 1, level = 3}
	},
	scatter_ores = {{
			clust_scarcity = 15 * 15 * 15,
			clust_num_ores = 4,
			y_min          = 1025,
		}, {
			clust_scarcity = 17 * 17 * 17,
			clust_num_ores = 4,
			y_max          = -1024,
			y_min          = -2047,
		}, {
			clust_scarcity = 15 * 15 * 15,
			clust_num_ores = 4,
			y_max          = -2048,
		}
	}
})

ores.register_crystal("base_ores:mese", {
	crystal = {description = S("Mese Crystal")},
	fragment = {description = S("Mese Crystal Fragment")},
	mineral = {description = S("Mese Ore")},
	block = {description = S("Mese Block")},
	scatter_ores = {{
			clust_scarcity = 14 * 14 * 14,
			clust_num_ores = 5,
			y_min          = 1025,
		}, {
			clust_scarcity = 18 * 18 * 18,
			clust_num_ores = 3,
			clust_size     = 2,
			y_max          = -512,
			y_min          = -1023,
		}, {
			clust_scarcity = 14 * 14 * 14,
			clust_num_ores = 5,
			y_max          = -1024,
		}, {
			ore            = "base_ores:mese_block",
			clust_scarcity = 36 * 36 * 36,
			clust_num_ores = 3,
			clust_size     = 2,
			y_min          = 1025,
		}, {
			ore            = "base_ores:mese_block",
			clust_scarcity = 36 * 36 * 36,
			clust_num_ores = 3,
			clust_size     = 2,
			y_max          = -2048,
			y_min          = -4095,
		}, {
			ore            = "base_ores:mese_block",
			clust_scarcity = 28 * 28 * 28,
			clust_num_ores = 5,
			y_max          = -4096,
		}
	}
})

