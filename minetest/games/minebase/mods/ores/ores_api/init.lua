-- ores_api/init.lua

ores = {}
local scarcity_modifier = 100 / (tonumber(minetest.settings
	:get("ore_percentage")) or 100)

minetest.clear_registered_ores()

function ores.register_lump(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_lump", {
		description = def.description or txt .. "_lump",
		inventory_image = txt .. "_lump.png",
		groups = def.groups
	})
end

function ores.register_ingot(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_ingot", {
		description = def.description or txt .. "_ingot",
		inventory_image = txt .. "_ingot.png"
	})
end

function ores.register_mineral(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_mineral", {
		description = def.description or txt .. "_mineral",
		tiles = def.tiles or {"base_earth_stone.png^" .. txt .. "_mineral.png"},
		groups = def.groups or {cracky = 2},
		drop = def.drop or name .. "_lump",
		sounds = sounds.get_defaults("earth_sounds:stone"),
	})
end

function ores.register_block(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. "_block", {
		description = def.description or txt .. "_block",
		tiles = def.tiles or {txt .. "_block.png"},
		is_ground_content = false,
		groups = def.groups or {cracky = 1, level = 2},
		sounds = def.sounds,
	})
end

function ores.register_ore(name, def)
	minetest.register_ore({
		ore_type = def.ore_type or "scatter",
		ore = def.ore or name .. "_mineral",
		wherein = def.wherein or "base_earth:stone",
		clust_scarcity = math.floor((def.clust_scarcity or 15 * 15 * 15) 
			* scarcity_modifier), 
		clust_num_ores = def.clust_num_ores or 7,
		clust_size = def.clust_size or 3,
		y_max = def.y_max or 31000,
		y_min = def.y_min or -31000,
		noise_threshold = def.noise_threshold,
		noise_params = def.noise_params
	})
end

function ores.register_blob_ores(name, def)
	for _, ore in pairs(def) do
		ore.ore_type = "blob"
		ores.register_ore(name, ore)
	end
end

-- The calculations are similar to those in tools_api.
local function calc_ore_values(ore)
	local y = ore.x >= - 2 and ore.x + 9 or 7
	ore.clust_scarcity = ore.clust_scarcity or - 360 / y + 54
	ore.clust_num_ores = ore.clust_num_ores or 3
	ore.clust_size = ore.clust_size or 2
	ore.y_max = ore.y_max or 40960 / (9 + y) - 6144
end

function ores.register_scatter_ores(name, def)
	for _, ore in pairs(def) do
		ore.ore_type = "scatter"
		if ore.x then
			calc_ore_values(ore)
		end
		ores.register_ore(name, ore)
	end
end

function ores.register_metal(name, def)
	if def.lump then
		ores.register_lump(name, def.lump)

		if def.ingot then
			minetest.register_craft({
				type = "cooking",
				output = name .. "_ingot",
				recipe = name .. "_lump",
			})
		end
	end
	
	if def.ingot then
		ores.register_ingot(name, def.ingot)

		if def.block then
			craft.register_craft19(name .. "_block", name .. "_ingot")
		end
	end
	
	if def.mineral then
		ores.register_mineral(name, def.mineral)
	end

	if def.block then
		def.block.sounds = sounds.get_defaults("ore_sounds:metal")
		ores.register_block(name, def.block)
	end
	
	if def.blob_ores then
		ores.register_blob_ores(name, def.blob_ores)
	end

	if def.scatter_ores then
		ores.register_scatter_ores(name, def.scatter_ores)
	end
end

function ores.register_crystal_item(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_crystal", {
		description = def.description or txt .. "_crystal",
		inventory_image = txt .. "_crystal.png",
		groups = def.groups
	})
end

function ores.register_fragment(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name .. "_crystal_fragment", {
		description = def.description or txt .. "_crystal_fragment",
		inventory_image = txt .. "_crystal_fragment.png",
	})
end

function ores.register_crystal(name, def)
	if def.crystal then
		ores.register_crystal_item(name, def.crystal)
		
		if def.fragment then
			craft.register_craft19(name .. "_crystal", name .. "_crystal_fragment")
		end
		if def.block then
			craft.register_craft19(name .. "_block", name .. "_crystal")
		end
	end

	if def.fragment then
		ores.register_fragment(name, def.fragment)
	end

	if def.mineral then
		def.mineral.drop = def.mineral.drop or name .. "_crystal"
		def.mineral.groups = def.mineral.groups or {cracky = 1}
		ores.register_mineral(name, def.mineral)
	end

	if def.block then
		ores.register_block(name, def.block)
	end

	if def.blob_ores then
		ores.register_blob_ores(name, def.blob_ores)
	end

	if def.scatter_ores then
		ores.register_scatter_ores(name, def.scatter_ores)
	end
end


