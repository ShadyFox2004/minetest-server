-- fences_api/init.lua

fences = {LIGHT_MAX = 14}

fences.coll_extra = minetest.settings:get_bool("enable_fence_tall") 
	and 3/8 or 0

function fences.register_post(name, def)
	local name = name .. "_post"
	local txt = name:gsub(":", "_")
	local texture = "fences_api_overlay.png^" .. (def.texture or txt .. ".png") 
		.. "^fences_api_overlay.png^[makealpha:255,126,126"

	if def.groups then
		def.groups.fence = 1
	end

	minetest.register_node(name, {
		description = def.description or txt,
		paramtype = "light",
		drawtype = "nodebox",
		node_box = def.node_box or {
			type = "connected",
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
			connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/8 },
				         {-1/16, -5/16, -1/2,   1/16, -3/16, -1/8 }},
			connect_left =  {{-1/2,   3/16, -1/16, -1/8,   5/16,  1/16},
				         {-1/2,  -5/16, -1/16, -1/8,  -3/16,  1/16}},
			connect_back =  {{-1/16,  3/16,  1/8,   1/16,  5/16,  1/2 },
				         {-1/16, -5/16,  1/8,   1/16, -3/16,  1/2 }},
			connect_right = {{ 1/8,   3/16, -1/16,  1/2,   5/16,  1/16},
				         { 1/8,  -5/16, -1/16,  1/2,  -3/16,  1/16}}
		},
		collision_box = def.collision_box or {
			type = "connected",
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fences.coll_extra, 1/8},
			connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 + fences.coll_extra, -1/8},
			connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 + fences.coll_extra,  1/8},
			connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 + fences.coll_extra,  1/2},
			connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 + fences.coll_extra,  1/8}
		},
		connects_to = def.connects_to or {"group:fence", "group:wood", "group:tree", 
			"group:wall"},
		inventory_image = def.inventory_image or texture,
		wield_image = def.wield_image or texture,
		tiles = def.tiles or {txt .. ".png"},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 2, 
			flammable = 2, fence = 1},
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name,
		burntime = def.burntime or 7
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 4",
			recipe = {
				{ def.material, 'group:stick', def.material },
				{ def.material, 'group:stick', def.material },
			}
		})
	end
end

function fences.register_rail(name, def)
	local name = name .. "_rail"
	local txt = name:gsub(":", "_")
	local texture = "fences_api_overlay_rail.png^" .. (def.texture 
		or txt .. ".png") .. "^fences_api_overlay_rail.png^[makealpha:255,126,126"

	if def.groups then
		def.groups.fence = 1
	end

	minetest.register_node(name, {
		description = def.description or txt,
		paramtype = "light",
		drawtype = "nodebox",
		node_box = def.node_box or {
			type = "connected",
			fixed = {{-1/16,  3/16, -1/16, 1/16,  5/16, 1/16},
				 {-1/16, -3/16, -1/16, 1/16, -5/16, 1/16}},
			connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/16},
				         {-1/16, -5/16, -1/2,   1/16, -3/16, -1/16}},
			connect_left =  {{-1/2,   3/16, -1/16, -1/16,  5/16,  1/16},
				         {-1/2,  -5/16, -1/16, -1/16, -3/16,  1/16}},
			connect_back =  {{-1/16,  3/16,  1/16,  1/16,  5/16,  1/2 },
				         {-1/16, -5/16,  1/16,  1/16, -3/16,  1/2 }},
			connect_right = {{ 1/16,  3/16, -1/16,  1/2,   5/16,  1/16},
		                         { 1/16, -5/16, -1/16,  1/2,  -3/16,  1/16}}
		},
		collision_box = def.collision_box or {
			type = "connected",
			fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fences.coll_extra, 1/8},
			connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 + fences.coll_extra, -1/8},
			connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 + fences.coll_extra,  1/8},
			connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 + fences.coll_extra,  1/2},
			connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 + fences.coll_extra,  1/8}
		},
		connects_to = def.connects_to or {"group:fence", "group:wall"},
		inventory_image = def.inventory_image or texture,
		wield_image = def.wield_image or texture,
		tiles = def.tiles or {txt .. ".png"},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 2, 
			flammable = 2, fence = 1},
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
	})

	minetest.register_craft({
		type = "fuel",
		recipe = name,
		burntime = def.burntime or 5 
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 16",
			recipe = {
				{ def.material, def.material },
				{ "", ""},
				{ def.material, def.material },
			}
		})
	end
end

function fences.register_mesepost(name, def)
	local txt = name:gsub(":", "_") .. "_post"
	local name = name .. "_mesepost"

	local texture = (def.texture or txt .. ".png")
		.. "^fences_api_mesepost_side.png^[makealpha:0,0,0"
	local texture_dark = (def.texture or txt .. ".png")

	minetest.register_node(name, {
		description = def.description or txt,
		wield_image = def.wield_image or texture,
		inventory_image = def.inventory_image or texture,
		drawtype = "nodebox",
		node_box = def.node_box or {
			type = "fixed",
			fixed = {
				{-2 / 16, -8 / 16, -2 / 16, 2 / 16, 8 / 16, 2 / 16},
			},
		},
		paramtype = "light",
		tiles = def.tiles or {def.texture, def.texture, texture_dark, texture_dark, 
			texture, texture},
		use_texture_alpha = "opaque",
		light_source = def.light_source or fences.LIGHT_MAX,
		sunlight_propagates = true,
		is_ground_content = false,
		groups = def.groups or {choppy = 2, oddly_breakable_by_hand = 2, 
			flammable = 2},
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 4",
			recipe = {
				{'', 'base_glass:common', ''},
				{'base_ores:mese_crystal', 'base_ores:mese_crystal', 'base_ores:mese_crystal'},
				{'', def.material, ''},
			}
		})
	end
end

local function register_gate(name, def)
	local txt = name:gsub(":", "_")
	name = name .. "_gate"

	if type(def.tiles) == "table" then
		fence.tiles.backface_culling = true
	end

	local groups
	if def.groups then
		groups = table.copy(def.groups)
		groups.fence = 1
	else
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, fence = 1}
	end

	local sound, collision_box, mesh, swap
	if def.sub == "_open" then
		sound = "fences_api_gate_close"
		collision_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/8, 1/2, 1/2 + fences.coll_extra, 1/8}
		}
		mesh = "fences_api_gate_open.obj"
		groups.not_in_creative_inventory = 1
		swap = name .. "_closed"
	else
		sound = "fences_api_gate_open"
		collision_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/8, -3/8, 1/2 + fences.coll_extra, 1/8},
				 {-1/2, -3/8, -1/2, -3/8, 3/8, 0}}
		}
		mesh = "fences_api_gate_closed.obj"
		swap = name .. "_open"
	end

	minetest.register_node(name .. def.sub, {
		description = def.description,
		drawtype = "mesh",
		tiles = def.tiles or {txt .. "_post.png", backface_culling = true},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = def.drop or name .. "_closed",
		connect_sides = def.connect_sides or {"left", "right"},
		groups = groups,
		sounds = def.sounds or sounds.get_defaults("tree_sounds:wood"),
		sound = sound,
		swap = swap,
		mesh = def.mesh or mesh,
		collision_box = def.collision_box or collision_box,
		on_rightclick = def.on_rightclick or function(pos, node, clicker, 
			itemstack, pointed_thing)
			local node_def = minetest.registered_nodes[node.name]
			minetest.swap_node(pos, {name = node_def.swap, param2 = node.param2})
			minetest.sound_play(node_def.sound, {pos = pos, gain = 0.3,
				max_hear_distance = 8}, true)
			return itemstack
		end,
		selection_box = def.selection_box or {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/4, 1/2, 1/2, 1/4}
		},
	})
end

function fences.register_gate(name, def)
	def.sub = "_open"
	register_gate(name, def)

	def.sub = "_closed"
	register_gate(name, def)

	if def.material then
		minetest.register_craft({
			output = name .. "_gate_closed",
			recipe = {
				{"group:stick", def.material, "group:stick"},
				{"group:stick", def.material, "group:stick"}
			}
		})
	end

	minetest.register_craft({
		type = "fuel",
		recipe = name .. "_gate_closed",
		burntime = def.burntime or 7,
	})
end

function fences.register_fence(name, def)
	fences.register_post(name, def.post)

	if def.rail then
		def.rail.material = def.rail.material or def.post.material
		def.rail.groups = def.rail.groups or def.post.groups
		fences.register_rail(name, def.rail)
	end

	if def.mesepost then
		def.mesepost.material = def.mesepost.material or def.post.material
		fences.register_mesepost(name, def.mesepost)
	end

	if def.gate then
		def.gate.material = def.gate.material or def.post.material
		def.gate.groups = def.gate.groups or def.post.groups
		def.gate.burntime = def.gate.burntime or def.post.burntime
		fences.register_gate(name, def.gate)
	end
end

