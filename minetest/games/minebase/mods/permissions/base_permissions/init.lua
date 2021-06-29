-- base_permissions/init.lua

local S = minetest.get_translator("base_permissions")

minetest.register_tool("base_permissions:key", {
	description = S("Key"),
	inventory_image = "base_permissions_key.png",
	groups = {key = 1, not_in_creative_inventory = 1},
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		node = minetest.get_node(pos)

		if not node or node.name == "ignore" then
			return itemstack
		end

		local ndef = minetest.registered_nodes[node.name]
		if not ndef then
			return itemstack
		end

		local on_key_use = ndef._on_key_use
		if on_key_use then
			on_key_use(pos, placer)
		end

		return nil
	end
})

minetest.register_craftitem("base_permissions:skeleton_key", {
	description = S("Skeleton Key"),
	inventory_image = "base_permissions_key_skeleton.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		local node = minetest.get_node(pos)

		if not node then
			return itemstack
		end

		local node_reg = minetest.registered_nodes[node.name]
		local on_skeleton_key_use = node_reg and node_reg._on_skeleton_key_use
		if not on_skeleton_key_use then
			return itemstack
		end
		
		-- make a new key secret in case the node callback needs it
		local secret = on_skeleton_key_use(pos, user, permissions.generate_secret())

		if secret then
			return permissions.create_key(itemstack, user, node.name, secret)
		end
	end
})

minetest.register_craft({
	output = "base_permissions:skeleton_key",
	recipe = {
		{"base_ores:gold_ingot"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:gold_ingot",
	recipe = "base_permissions:key",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "base_ores:gold_ingot",
	recipe = "base_permissions:skeleton_key",
	cooktime = 5,
})


