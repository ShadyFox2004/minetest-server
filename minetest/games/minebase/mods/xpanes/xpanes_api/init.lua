-- xpanes_api/init.lua

xpanes = {}

local function is_pane(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
end

function xpanes.connects_dir(pos, name, dir)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside) then
		return true
	end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then
		return false
	end
	local list = minetest.find_nodes_in_area(aside, aside, connects_to)

	if #list > 0 then
		return true
	end

	return false
end

function xpanes.swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then
		return
	end

	minetest.swap_node(pos, {name = name, param2 = param2})
end

function xpanes.update_pane(pos)
	if not is_pane(pos) then
		return
	end
	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = xpanes.connects_dir(pos, name, dir)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		xpanes.swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		xpanes.swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			xpanes.swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			xpanes.swap(pos, node, name, 0)
		end
	else
		xpanes.swap(pos, node, name, 0)
	end
end

minetest.register_on_placenode(function(pos, node)
	if minetest.get_item_group(node, "pane") then
		xpanes.update_pane(pos)
	end
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		xpanes.update_pane(vector.add(pos, dir))
	end
end)

function xpanes.update_pane_dirs(pos)
	for i = 0, 3 do
		xpanes.update_pane(vector.add(pos, minetest.facedir_to_dir(i)))
	end
end
minetest.register_on_dignode(xpanes.update_pane_dirs)

function xpanes.register_pane(name, def)
	for i = 1, 15 do
		minetest.register_alias(name .. "_" .. i, name .. "_flat")
	end

	local flatgroups = table.copy(def.groups)
	flatgroups.pane = 1
	minetest.register_node(name .. "_flat", {
		description = def.description or name:sub(":","_") .. "_flat",
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		paramtype2 = "facedir",
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[3],
			def.textures[1],
			def.textures[1]
		},
		groups = flatgroups,
		drop = name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connect_sides = { "left", "right" },
	})

	local groups = table.copy(def.groups)
	groups.pane = 1
	groups.not_in_creative_inventory = 1
	minetest.register_node(name, {
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		description = def.description or name:sub(":","_"),
		tiles = {
			def.textures[3],
			def.textures[3],
			def.textures[1]
		},
		groups = groups,
		drop = name .. "_flat",
		sounds = def.sounds,
		use_texture_alpha = def.use_texture_alpha and "blend" or "clip",
		node_box = {
			type = "connected",
			fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
			connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
			connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
			connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
			connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", 
			"group:tree"},
	})

	minetest.register_craft({
		output = name .. "_flat 16",
		recipe = def.recipe
	})
end

minetest.register_lbm({
	name = "xpanes_api:gen2",
	nodenames = {"group:pane"},
	action = function(pos, node)
		xpanes.update_pane(pos)
		xpanes.update_pane_dirs(pos)
	end
})

