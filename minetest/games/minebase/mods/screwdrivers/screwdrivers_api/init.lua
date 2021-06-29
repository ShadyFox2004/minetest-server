-- screwdrivers/init.lua

--Values range 0 - 23
--facedir / 4 = axis direction:
--0 = y+,   1 = z+,   2 = z-,   3 = x+,   4 = x-,   5 = y-
--facedir modulo 4 = rotation around that axis
screwdrivers = {ROTATE_FACE = 1, ROTATE_AXIS = 2}

-- Load support for Minebase translation.
local S = minetest.get_translator("screwdrivers")

-- For attached wallmounted nodes: returns true if rotation is valid
-- simplified version of minetest:builtin/game/falling.lua#L148.
function screwdrivers.check_attached_node(pos, rotation)
	local d = minetest.wallmounted_to_dir(rotation)
	local p2 = vector.add(pos, d)
	local n = minetest.get_node(p2).name
	local def2 = minetest.registered_nodes[n]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

screwdrivers.rotate = {}

local facedir_tbl = {
	[screwdrivers.ROTATE_FACE] = { [0] = 
		 1,   2,   3,   0,
		 5,   6,   7,   4,
		 9,  10,  11,   8,
		13,  14,  15,  12,
		17,  18,  19,  16,
		21,  22,  23,  20,
	},
	[screwdrivers.ROTATE_AXIS] = { [0] = 
		 4,  4,  4,  4,
		 8,  8,  8,  8,
		12, 12, 12, 12,
		16, 16, 16, 16,
		20, 20, 20, 20,
		 0,  0,  0,  0,
	},
}

function screwdrivers.rotate.facedir(pos, node, mode)
	local rotation = node.param2 % 32 -- get first 5 bits
	local other = node.param2 - rotation
	rotation = facedir_tbl[mode][rotation] or 0
	return rotation + other
end

screwdrivers.rotate.colorfacedir = screwdrivers.rotate.facedir

local wallmounted_tbl = {
	[screwdrivers.ROTATE_FACE] = {[0] = 1, 0, 5,  4,  2,  3},
	[screwdrivers.ROTATE_AXIS] = {[0] = 3, 0, 5,  4,  2,  1}
}

function screwdrivers.rotate.wallmounted(pos, node, mode)
	local rotation = node.param2 % 8 -- get first 3 bits
	local other = node.param2 - rotation
	rotation = wallmounted_tbl[mode][rotation] or 0
	if minetest.get_item_group(node.name, "attached_node") ~= 0 then
		-- find an acceptable orientation
		for i = 1, 5 do
			if not screwdrivers.check_attached_node(pos, rotation) then
				rotation = wallmounted_tbl[mode][rotation] or 0
			else
				break
			end
		end
	end
	return rotation + other
end

screwdrivers.rotate.colorwallmounted = screwdrivers.rotate.wallmounted

-- Handles rotation
function screwdrivers.handler(itemstack, user, pointed_thing, mode, uses)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return
	end

	local node = minetest.get_node(pos)
	local ndef = minetest.registered_nodes[node.name]
	if not ndef then
		return itemstack
	end
	-- can we rotate this paramtype2?
	local fn = screwdrivers.rotate[ndef.paramtype2]
	if not fn and not ndef._on_rotate then
		return itemstack
	end

	local should_rotate = true
	local new_param2
	if fn then
		new_param2 = fn(pos, node, mode)
	else
		new_param2 = node.param2
	end

	-- Node provides a handler, so let the handler decide instead if the node can be rotated
	if ndef._on_rotate then
		-- Copy pos and node because callback can modify it
		local result = ndef._on_rotate(vector.new(pos),
				{name = node.name, param1 = node.param1, param2 = node.param2},
				user, mode, new_param2)
		if result == false then -- Disallow rotation
			return itemstack
		elseif result == true then
			should_rotate = false
		end
	elseif ndef._on_rotate == false then
		return itemstack
	elseif ndef.can_dig and not ndef.can_dig(pos, user) then
		return itemstack
	end

	if should_rotate and new_param2 ~= node.param2 then
		node.param2 = new_param2
		minetest.swap_node(pos, node)
		minetest.check_for_falling(pos)
	end

	if not minetest.is_creative_enabled(player_name) then
		itemstack:add_wear(65535 / ((uses or 200) - 1))
	end

	return itemstack
end

local xz = {
	{ [0] = 
		 4,  5,  6,  7,
		22, 23, 20, 21,
		 0,  1,  2,  3,
		13, 14, 15, 12,
		19, 16, 17, 18,
		10, 11,  8,  9
	},
	{ [0] = 
		12, 13, 14, 15,
		 7,  4,  5,  6,
		 9, 10, 11,  8,
		20, 21, 22, 23,
		 0,  1,  2,  3,
		16, 17, 18, 19
	},
	{ [0] = 
		 8,  9, 10, 11,
		 0,  1,  2,  3,
		22, 23, 20, 21,
		15, 12, 13, 14,
		17, 18, 19, 16,
		 6,  7,  4,  5,
	},
	{ [0] = 
		16, 17, 18, 19,
		 5,  6,  7,  4,
		11,  8,  9, 10,
		 0,  1,  2,  3,
		20, 21, 22, 23,
		12, 13, 14, 15,
	},
}

local function exzetParam2(user, button, param2)
	local yaw = user:get_look_horizontal()
	local rotation = param2 % 32
	if user:get_player_control().aux1 then
		yaw = (yaw + 3.141593) % 6.283185
	end
	if button == 1 then
		if yaw < 1.570796 then
			param2 = param2 - rotation + xz[1][rotation]
		elseif yaw < 3.141593 then
			param2 = param2 - rotation + xz[4][rotation]
		elseif yaw < 4.712389 then
			param2 = param2 - rotation + xz[3][rotation]
		else
			param2 = param2 - rotation + xz[2][rotation]
		end
	else
		if yaw < 1.570796 then
			param2 = param2 - rotation + xz[4][rotation]
		elseif yaw < 3.141593 then
			param2 = param2 - rotation + xz[3][rotation]
		elseif yaw < 4.712389 then
			param2 = param2 - rotation + xz[2][rotation]
		else
			param2 = param2 - rotation + xz[1][rotation]
		end
	end
	return param2
end

function screwdrivers.exzet(itemstack, user, pointed_thing, button)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return
	end

	local node = minetest.get_node(pos)
	local ndef = minetest.registered_nodes[node.name]
	if not ndef then
		return itemstack
	end

	if ndef._on_rotate then
		return itemstack
	end

	node.param2 = exzetParam2(user, button, node.param2)
	minetest.swap_node(pos, node)
	minetest.check_for_falling(pos)

	if not minetest.is_creative_enabled(player_name) then
		itemstack:add_wear(65535 / ((uses or 200) - 1))
	end

	return itemstack
end

function screwdrivers.register_screwdriver(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name, {
		description = def.description, 
		inventory_image = def.inventory_image or txt .. ".png",
		wield_image = def.wield_image or txt .. ".png",
		groups = def.groups or {tool = 1},
		on_use = def.on_use,
		on_place = def.on_place,
		on_secondary_use = def.on_secondary_use,
		on_drop = def.on_drop,
		after_use = def.after_use
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})
	end
end



