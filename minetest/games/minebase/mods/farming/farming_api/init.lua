-- farming_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("farming_api")

-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming_api")
farming.get_translator = S
farming.LIGHT_MAX = 14
farming.interval = {166, 286}
farming.retry = {40, 80}

-- Wear out hoes, place soil
farming.registered_plants = {}

function farming.hoe_on_use(itemstack, user, pointed_thing)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end

	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end

	-- check if (wet) soil defined
	local regN = minetest.registered_nodes
	if regN[under.name].soil == nil or regN[under.name].soil.wet == nil 
		or regN[under.name].soil.dry == nil then
		return
	end

	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- turn the node into soil and play sound
	minetest.set_node(pt.under, {name = regN[under.name].soil.dry})
	minetest.sound_play("earth_api_dig_crumbly", {
		pos = pt.under,
		gain = 0.5,
	}, true)

	if not minetest.is_creative_enabled(player_name) then
		-- wear tool
		local wdef = itemstack:get_definition()
		itemstack:add_wear(65535/(wdef._max_uses - 1))
		-- tool break sound
		if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
			minetest.sound_play(wdef.sound.breaks, {pos = pt.above,
				gain = 0.5}, true)
		end
	end
	return itemstack
end

function farming.register_hoe(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name, {
		description = def.description or S("Hoe"),
		inventory_image = def.inventory_image or txt .. ".png",
		groups = def.groups,
		sound = def.sound or {breaks = "tools_api_breaks"},
		on_use = def.on_use or farming.hoe_on_use,
		on_place = def.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		after_use = def.after_use,
		_max_uses = def.max_uses or 30
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	elseif def.material then
		minetest.register_craft({
			output = name,
			recipe = {
				{def.material, def.material},
				{"", "group:stick"},
				{"", "group:stick"}
			}
		})
	end
end

function farming.tick(pos, min, max)
	minetest.get_node_timer(pos):start(rand.az(min, max))
end

-- Seed placement
function farming.place_seed(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	farming.tick(pt.above, farming.interval[1], farming.interval[2])
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end
	return itemstack
end

function farming.grow_plant(pos, elapsed)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]

	if not def._next_plant then
		-- disable timer for fully grown plant
		return
	end

	-- grow seed
	if minetest.get_item_group(node.name, "seed") and def._fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			farming.tick(pos, farming.retry[1], farming.retry[2])
			return
		end
		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def._fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				local placenode = {name = def._next_plant}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				minetest.swap_node(pos, placenode)
				if minetest.registered_nodes[def._next_plant]._next_plant then
					farming.tick(pos, farming.interval[1], farming.interval[2])
					return
				end
			end
		end

		return
	end

	-- check if on wet soil
	local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
	if minetest.get_item_group(below.name, "soil") < 3 then
		farming.tick(pos, farming.retry[1], farming.retry[2])
		return
	end

	-- check light
	local light = minetest.get_node_light(pos)
	if not light or light < def._minlight or light > def._maxlight then
		farming.tick(pos, farming.retry[1], farming.retry[2])
		return
	end

	-- grow
	local placenode = {name = def._next_plant}
	if def.place_param2 then
		placenode.param2 = def.place_param2
	end
	minetest.swap_node(pos, placenode)

	-- new timer needed?
	if minetest.registered_nodes[def._next_plant]._next_plant then
		farming.tick(pos, farming.interval[1], farming.interval[2])
	end
	return
end

function farming.on_place_seed(itemstack, placer, pointed_thing)
	local under = pointed_thing.under
	local node = minetest.get_node(under)
	local udef = minetest.registered_nodes[node.name]
	if udef and udef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return udef.on_rightclick(under, node, placer, itemstack,
			pointed_thing) or itemstack
	end
	return farming.place_seed(itemstack, placer, pointed_thing, 
		itemstack:get_definition().name)
end

function farming.register_seed(name, def)
	local txt = name:gsub(":", "_")
	local groups
	if def.groups then
		groups = def.groups
		groups.seed = 1
		groups.snappy = 3
		groups.attached_node = 1
		groups.flammable = 2
	else
		groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	end

	minetest.register_node(name, {
		description = def.description or S("Seed"),
		tiles = {def.inventory_image or txt .. ".png"},
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.inventory_image or txt .. ".png",
		drawtype = "signlike",
		groups = groups,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		sounds = sounds.get_defaults("earth_sounds:dirt", {
			dig = {name = "", gain = 0},
			dug = {name = "base_earth_grass_footstep", gain = 0.2},
			place = {name = "base_sounds_place_node", gain = 0.25},
		}),
		on_place = farming.on_place_seed, 
		on_timer = farming.grow_plant,
		_fertility = def.fertility or {},
		_next_plant = def.base_name .. "_1",
		_minlight = def.minlight or 1,
		_maxlight = def.maxlight or farming.LIGHT_MAX,
	})
end

function farming.register_harvest(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.harvest_description or txt,
		inventory_image = def.inventory_image or txt .. ".png",
		groups = def.groups or {flammable = 2},
	})
end

function farming.register_plant_steps(name, def)
	local txt = name:gsub(":", "_")
	farming.registered_plants[name] = def
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end

		minetest.register_node(name .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {txt .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = def.drop or {
				items = {
					{items = {name}, rarity = base_rarity},
					{items = {name}, rarity = base_rarity * 2},
					{items = {name .. "_seed"}, rarity = base_rarity},
					{items = {name .. "_seed"}, rarity = base_rarity * 2},
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5},
			},
			groups = {snappy = 3, flammable = 2, plant = 1, 
				not_in_creative_inventory = 1, attached_node = 1, [name] = i
			},
			sounds = sounds.get_defaults("tree_sounds:leaves"),
			on_timer = farming.grow_plant,
			_next_plant = i < def.steps and name .. "_" .. (i + 1) or nil,
			_minlight = def.minlight,
			_maxlight = def.maxlight or farming.LIGHT_MAX,
		})
	end
end

local function lbm_nodes_fu(pos, node)
	farming.tick(pos, farming.retry[1], farming.retry[2])
end

function farming.register_plant(name, def)
	def.steps = def.steps or 8
	def.base_name = name
	farming.register_seed(name .. "_seed", def)
	farming.register_harvest(name, def)
	farming.register_plant_steps(name, def)

	local lbm_nodes = {name .. "_seed"}
	for i = 1, def.steps - 1 do
		table.insert(lbm_nodes, name .. "_" .. i)
	end

	-- replacement LBM for pre-nodetimer plants
	minetest.register_lbm({
		name = name .. "_start_nodetimer",
		nodenames = lbm_nodes,
		action = lbm_nodes_fu,
	})
end
