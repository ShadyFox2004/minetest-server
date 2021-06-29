-- trees_api/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("trees_api")

trees = {}

dofile(minetest.get_modpath("trees_api") .. "/groups.lua")

--
-- Functions
--

function trees.after_place_leaves(pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local node = minetest.get_node(pos)
		node.param2 = 1
		minetest.set_node(pos, node)
	end
end

function trees.leafdecay_after_destruct(pos, oldnode)
	local def = minetest.registered_nodes[oldnode.name]._leafdecay
	for _, v in pairs(minetest.find_nodes_in_area(vector.subtract(pos, def.radius),
			vector.add(pos, def.radius), def.leaves)) do
		local node = minetest.get_node(v)
		local timer = minetest.get_node_timer(v)
		if node.param2 ~= 1 and not timer:is_started() then
			timer:start(rand.az(20, 120) / 10)
		end
	end
end

local movement_gravity = tonumber(minetest.settings:get("movement_gravity")) 
	or 9.81

function trees.leafdecay_on_timer(pos)
	local def = minetest.registered_nodes[minetest.get_node(pos).name]._leafdecay
	if minetest.find_node_near(pos, def.radius, def.trunks) then
		return false
	end

	local node = minetest.get_node(pos)
	local drops = minetest.get_node_drops(node.name)
	for _, item in ipairs(drops) do
		local is_leaf
		for _, v in pairs(def.leaves) do
			if v == item then
				is_leaf = true
			end
		end
		if minetest.get_item_group(item, "leafdecay_drop") ~= 0 or
				not is_leaf then
			minetest.add_item({
				x = pos.x - 0.5 + math.random(),
				y = pos.y - 0.5 + math.random(),
				z = pos.z - 0.5 + math.random(),
			}, item)
		end
	end

	minetest.remove_node(pos)
	minetest.check_for_falling(pos)

	-- spawn a few particles for the removed node
	minetest.add_particlespawner({
		amount = 8,
		time = 0.001,
		minpos = vector.subtract(pos, {x=0.5, y=0.5, z=0.5}),
		maxpos = vector.add(pos, {x=0.5, y=0.5, z=0.5}),
		minvel = vector.new(-0.5, -1, -0.5),
		maxvel = vector.new(0.5, 0, 0.5),
		minacc = vector.new(0, -movement_gravity, 0),
		maxacc = vector.new(0, -movement_gravity, 0),
		minsize = 0,
		maxsize = 0,
		node = node,
	})
end

local function on_construct_sapling(pos)
	minetest.get_node_timer(pos):start(rand.az(300, 1500))
end

function trees.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

function trees.sapling_on_place(itemstack, placer, pointed_thing)
	local sapling_name = itemstack:get_name()
	local sdef = minetest.registered_nodes[sapling_name]
	local minp_relative = sdef._minp
	local maxp_relative = sdef._maxp
	local interval	= sdef._max_interval

	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
	--		minetest.chat_send_player(player_name,
	--			itemstack:get_definition().description .. " will intersect protection " ..
	--			"on growth")
		minetest.chat_send_player(player_name,
		    S("@1 will intersect protection on growth.",
			itemstack:get_definition().description))
		return itemstack
	end

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end

--
-- Trees
--

local noDef = {}
function trees.register_tree_node(name, def)
	local txt = name:gsub(":", "_")

	def.groups.tree = 1
	minetest.register_node(name .. "_tree", {
		description = def.description or txt,
		tiles = def.tiles or {txt .. "_tree_top.png", txt 
			.. "_tree_top.png", txt .. "_tree.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = def.groups,
		sounds = sounds.get_defaults("tree_sounds:wood"),
		on_place = minetest.rotate_node,
		after_destruct = trees.leafdecay_after_destruct,
		_leafdecay = not def.no_decay and {
			trunks = {name .. "_tree"},
			leaves = def.decay_leaves or {name .. "_leaves"},
			radius = def.decay_r or 3,
		}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name .. "_tree",
		burntime = def.burntime,
	})
end

function trees.register_wood(name, def)
	local txt = name:gsub(":", "_")

	def.groups.wood = 1
	if def.groups.oddly_breakable_by_hand then
		def.groups.oddly_breakable_by_hand = def.groups.oddly_breakable_by_hand + 1
	end
	minetest.register_node(name .. "_wood", {
		description = def.description or txt,
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = def.tiles or {txt .. "_wood.png"},
		is_ground_content = false,
		groups = def.groups,
		sounds = sounds.get_defaults("tree_sounds:wood"),
	})

	minetest.register_craft({
		output = name .. "_wood 4",
		recipe = {
			{name .. "_tree"},
		}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name .. "_wood",
		burntime = def.burntime,
	})
end

function trees.register_leaves(name, def)
	local txt = name:gsub(":", "_")

	local rarity, trunk
	if not name:find("bush") then
		rarity = 20
		trunk = "_tree"
	else
		rarity = 5
		trunk = "_stem"
	end

	minetest.register_node(name .. "_leaves", {
		description = def.description or txt,
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = def.tiles or {txt .. "_leaves.png"},
		special_tiles = def.special_tiles or {txt .. "_leaves_simple.png"},
		paramtype = "light",
		is_ground_content = false,
		groups = def.groups or {snappy = 3, leafdecay = 3, flammable = 2, 
			leaves = 1},
		drop = def.drop or {
			max_items = 1,
			items = {
				{items = {name .. "_sapling"}, rarity = rarity},
				{items = {name .. "_leaves"}}
			}
		},
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		after_place_node = trees.after_place_leaves,
		on_timer = def.on_timer or trees.leafdecay_on_timer,
		node_dig_prediction = def.node_dig_prediction,
		after_dig_node = def.after_dig_node,
		_leafdecay = not def.no_decay and {
			trunks = {name .. trunk},
			leaves = def.decay_leaves or {name .. "_leaves"},
			radius = def.decay_r or 3,
		}
	})
end

local function sapling_on_timer(pos) 
	if not trees.can_grow(pos) then
		-- try again 5 min later
		minetest.get_node_timer(pos):start(300)
	else
		return minetest.registered_nodes[minetest.get_node(pos).name]
			._grow_sapling(pos)
	end
end

function trees.register_sapling(name, def)
	local txt = name:gsub(":", "_")

	minetest.register_node(name .. "_sapling", {
		description = def.description or txt,
		drawtype = "plantlike",
		tiles = def.tiles or {txt .. "_sapling.png"},
		inventory_image = def.inventory_image or txt .. "_sapling.png",
		wield_image = def.wield_image or txt .. "_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = sapling_on_timer,
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.3, 4 / 16}
		},
		groups = def.groups or {snappy = 2, dig_immediate = 3, 
			flammable = 2,attached_node = 1, sapling = 1},
		sounds = sounds.get_defaults("tree_sounds:leaves"),
		on_construct = def.on_construct or on_construct_sapling,
		on_place = trees.sapling_on_place,
		_minp = def.minp or {x = -2, y = 1, z = -2},
		_maxp = def.maxp or {x = 2, y = 14, z = 2},
		_max_interval = def.max_interval or 4,
		_grow_sapling = def.grow_sapling
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name .. "_sapling",
		burntime = def.burntime,
	})
end

function trees.register_tree_decoration(name, def)
	minetest.register_decoration({
		name = name .. "_tree",
		deco_type = "schematic",
		fill_ratio = def.fill_ratio or 0.02,
		place_on = def.place_on,
		place_offset_y = def.place_offset_y or 0,
		sidelen = def.sidelen or 16,
		noise_params = def.noise_params,
		biomes = def.biomes,
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		schematic = def.schematic,
		flags = def.flags or "place_center_x, place_center_z",
		rotation = "random",
		spawn_by = def.spawn_by,
		num_spawn_by = def.spawn_by and (def.num_spawn_by or 1)
	})
end

function trees.register_tree(name, def)
	trees.register_tree_node(name, def.tree)
	trees.register_leaves(name, def.leaves)
	trees.register_sapling(name, def.sapling)

	if def.wood then
		def.wood.groups = def.wood.groups or def.tree.groups
		trees.register_wood(name, def.wood)
	end

	if def.deco then
		trees.register_tree_decoration(name,def.deco)
	end

	if def.deco_log then
		def.deco_log.place_offset_y = def.deco_log.place_offset_y or 1
		def.deco_log.flags = def.deco_log.flags or "place_center_x"
		if def.deco_log.spawn_by then
			def.deco_log.num_spawn_by = def.deco_log.num_spawn_by or 8
		end
		trees.register_tree_decoration(name,def.deco_log)
	end 
end

--
-- Bushes
--

function trees.register_bush_stem(name, def)
	local txt = name:gsub(":", "_")

	minetest.register_node(name .. "_stem", {
		description = def.description or txt,
		drawtype = "plantlike",
		visual_scale = def.visual_scale or 1.41,
		waving = def.waving,
		tiles = def.tiles or {txt .. "_stem.png"},
		inventory_image = def.inventory_image or txt .. "_stem.png",
		wield_image = def.wield_image or txt .. "_stem.png",
		paramtype = "light",
		paramtype2 = def.paramtype2,
		place_param2 = def.place_param2,
		sunlight_propagates = true,
		walkable = def.walkable,
		buildable_to = def.buildable_to,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 1, 
			flammable = 2},
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
		},
		after_destruct = trees.leafdecay_after_destruct,
		_leafdecay = not def.no_decay and {
			trunks = {name .. "_stem"},
			leaves = def.decay_leaves or {name .. "_leaves"},
			radius = def.decay_r or 3,
		}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name .. "_stem",
		burntime = def.burntime,
	})
end

function trees.register_bush_decoration(name, def)
	minetest.register_decoration({
		name = name,
		deco_type = def.deco_type or "schematic",
		place_on = def.place_on,
		sidelen = def.sidelen or 16,
		noise_params = def.noise_params,
		biomes = def.biomes,
		y_max = def.y_max or 31000,
		y_min = def.y_min or 1,
		place_offset_y = def.place_offset_y or 0,
		decoration = def.decoration,
		param2 = def.param2,
		schematic = def.schematic,
		flags = "place_center_x, place_center_z",
	})
end

function trees.register_bush(name, def)
	name = name .. "_bush"

	if def.stem then
		trees.register_bush_stem(name, def.stem)
	end
	
	if def.leaves then
		def.leaves.decay_r = def.leaves.decay_r or 1
		trees.register_leaves(name, def.leaves)
	end

	if def.sapling then
		trees.register_sapling(name, def.sapling)
	end

	if def.wood then
		trees.register_wood(name, def.wood)
	end

	if def.deco then
		trees.register_bush_decoration(name,def.deco)
	end
end

