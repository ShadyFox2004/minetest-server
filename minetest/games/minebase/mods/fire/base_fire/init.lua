-- base_fire/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_fire")

function fire.flame_on_timer(pos)
	if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	end
	-- Restart timer
	return true
end

fire.register_node("base_fire:flame", {
	description = S("Fire"),
	groups = {igniter = 2, dig_immediate = 3, fire = 1, 
		not_in_creative_inventory = 1},
	spreading = true,
	on_timer = fire.flame_on_timer, 
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(rand.az(30, 60))
	end
})

fire.register_node("base_fire:permanent", {
	description = S("Permanent Fire"),
	inventory_image = "base_fire_flame.png",
	tiles = {{
		name = "base_fire_flame_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
})

function fire.on_use_lighter(itemstack, user, pointed_thing)
	local sound_pos = pointed_thing.above or user:get_pos()
	minetest.sound_play("fire_flint_and_steel",
		{pos = sound_pos, gain = 0.5, max_hear_distance = 8}, true)
	local player_name = user:get_player_name()
	if pointed_thing.type == "node" then
		local node_under = minetest.get_node(pointed_thing.under).name
		local nodedef = minetest.registered_nodes[node_under]
		if not nodedef then
			return
		end
		if minetest.is_protected(pointed_thing.under, player_name) then
			minetest.chat_send_player(player_name, "This area is protected")
			return
		end
		if nodedef.on_ignite then
			nodedef.on_ignite(pointed_thing.under, user)
		elseif minetest.get_item_group(node_under, "flammable") >= 1
				and minetest.get_node(pointed_thing.above).name == "air" then
			minetest.set_node(pointed_thing.above, {name = "base_fire:flame"})
		end
	end
	if not minetest.is_creative_enabled(player_name) then
		-- Wear tool
		local wdef = itemstack:get_definition()
		itemstack:add_wear(1000)

		-- Tool break sound
		if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
			minetest.sound_play(wdef.sound.breaks,
				{pos = sound_pos, gain = 0.5}, true)
		end
		return itemstack
	end
end


-- Flint and Steel
minetest.register_tool("base_fire:flint_and_steel", {
	description = S("Flint and Steel"),
	inventory_image = "base_fire_flint_steel.png",
	sound = {breaks = "tools_api_tool_breaks"},
	on_use = fire.on_use_lighter
})

minetest.register_craft({
	output = "base_fire:flint_and_steel",
	recipe = {
		{"base_earth:flint", "base_ores:steel_ingot"}
	}
})

-- Override coalblock to enable permanent flame above
-- Coalblock is non-flammable to avoid unwanted flame nodes
minetest.override_item("base_ores:coal_block", {
	after_destruct = function(pos)
		pos.y = pos.y + 1
		if minetest.get_node(pos).name == "base_fire:permanent" then
			minetest.remove_node(pos)
		end
	end,
	on_ignite = function(pos)
		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(flame_pos).name == "air" then
			minetest.set_node(flame_pos, {name = "base_fire:permanent"})
		end
	end
})

