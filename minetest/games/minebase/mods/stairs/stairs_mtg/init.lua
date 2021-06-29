-- stairs_mtg/init.lua 

-- Register aliases for new pine node names
minetest.register_alias("stairs:stair_pinewood", "tree_stairs:pine_wood_stair")
minetest.register_alias("stairs:slab_pinewood", "tree_stairs:pine_wood_slab")

local tmp = {
	clay_stairs = {"brick"},
	earth_stairs = {
		cobble = "stone_cobble", stonebrick = "stone_brick", desert_cobble 
		= "desert_stone_cobble", desert_stonebrick = "desert_stone_brick",
		sandstonebrick = "sandstone_brick",
		"stone", "stone_block", "desert_stone",  "desert_stone_block",
		"sandstone",  "sandstone_block", "desert_sandstone", 
		"desert_sandstone_brick", "desert_sandstone_block",
		"silver_sandstone", "silver_sandstone_brick", "silver_sandstone_block",
	},
	glass_stairs = {glass = "common_glass","obsidian_glass"},
	liquid_stairs = {
		obsidianbrick = "obsidian_brick", "obsidian", "obsidian_block", "ice", 
		"snowblock",
	},
	mossy_stairs = {mossycobble = "stone_cobble"},
	ore_stairs = { 
		steelblock = "steel_block", tinblock = "tin_block", 
		copperblock = "copper_block", bronzeblock = "bronze_block", 
		goldblock = "gold_block"
	},
	tree_stairs = {
		wood = "apple_wood", junglewood = "jungle_wood", "pine_wood", "acacia_wood", 
		"aspen_wood",
	},
	wheat_stairs = {"straw"}
}

-- Get setting for replace ABM
local replace = minetest.settings:get_bool("enable_stairs_replace_abm")

local function upside_down(oldName, newName)
	minetest.register_node(oldName .. "upside_down", {
		replace_name = newName,
		groups = {slabs_replace = 1},
	})
end

for mod, map in pairs(tmp) do
	for oldName, name in pairs(map) do
		oldName = type(oldName) == "string" and oldName or name
		newName = mod .. ":" .. name
		minetest.register_alias("stairs:stair_" .. oldName,  newName.. "_stair")
		minetest.register_alias("stairs:slab_" .. oldName, newName .. "_slab")
		minetest.register_alias("stairs:stair_outer_" .. oldName, newName 
			.. "_outer_stair")
		minetest.register_alias("stairs:stair_inner_" .. oldName, newName 
			.. "_inner_stair")

		if replace then
			upside_down(":stairs:stair_" .. oldName, newName .. "_stair")
			upside_down(":stairs:slab_" .. oldName, newName .. "_slab")
		end
	end
end


-- Optionally replace old "upside_down" nodes with new param2 versions.
-- Disabled by default.

if replace then
	minetest.register_abm({
		label = "Slab replace",
		nodenames = {"group:slabs_replace"},
		interval = 16,
		chance = 1,
		action = function(pos, node)
			node.name = minetest.registered_nodes[node.name].replace_name
			node.param2 = node.param2 + 20
			if node.param2 == 21 then
				node.param2 = 23
			elseif node.param2 == 23 then
				node.param2 = 21
			end
			minetest.set_node(pos, node)
		end,
	})
end

