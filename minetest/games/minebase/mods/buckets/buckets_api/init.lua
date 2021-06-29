-- buckets_api/init.lua 

-- Load support for Minebase translation.
local S = minetest.get_translator("buckets_api")

minetest.register_craft({
	output = "buckets_api:bucket_empty 1",
	recipe = {
		{"base_ores:steel_ingot", "", "base_ores:steel_ingot"},
		{"", "base_ores:steel_ingot", ""},
	}
})

buckets = {}
buckets.liquids = {}

local function check_protection(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("warning", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

function buckets.on_place(itemstack, user, pointed_thing)
	-- Must be pointing to node
	if pointed_thing.type ~= "node" then
		return
	end

	local node = minetest.get_node_or_nil(pointed_thing.under)
	local ndef = node and minetest.registered_nodes[node.name]

	-- Call on_rightclick if the pointed node defines it
	if ndef and ndef.on_rightclick and
			not (user and user:is_player() and
			user:get_player_control().sneak) then
		return ndef.on_rightclick(
			pointed_thing.under,
			node, user,
			itemstack)
	end

	local lpos

	-- Check if pointing to a buildable node
	if ndef and ndef.buildable_to then
		-- buildable; replace the node
		lpos = pointed_thing.under
	else
		-- not buildable to; place the liquid above
		-- check if the node above can be replaced

		lpos = pointed_thing.above
		node = minetest.get_node_or_nil(lpos)
		local above_ndef = node and minetest.registered_nodes[node.name]

		if not above_ndef or not above_ndef.buildable_to then
			-- do not remove the bucket with the liquid
			return itemstack
		end
	end

	local def = itemstack:get_definition()
	if check_protection(lpos, user
			and user:get_player_name()
			or "", "place " .. def._source) then
		return
	end

	minetest.set_node(lpos, {name = def._source})
	return ItemStack(def._empty)
end

function buckets.on_use(itemstack, user, pointed_thing)
	if pointed_thing.type == "object" then
		pointed_thing.ref:punch(user, 1.0, { full_punch_interval=1.0 }, nil)
		return user:get_wielded_item()
	elseif pointed_thing.type ~= "node" then
		-- do nothing if it's neither object nor node
		return
	end
	-- Check if pointing to a liquid source
	local node = minetest.get_node(pointed_thing.under)
	local liquiddef = buckets.liquids[node.name]
	local item_count = user:get_wielded_item():get_count()

	if liquiddef ~= nil
	and liquiddef.itemname ~= nil
	and node.name == liquiddef.source then
		if check_protection(pointed_thing.under,
				user:get_player_name(),
				"take ".. node.name) then
			return
		end

		-- default set to return filled bucket
		local giving_back = liquiddef.itemname

		-- check if holding more than 1 empty bucket
		if item_count > 1 then

			-- if space in inventory add filled bucked, otherwise drop as item
			local inv = user:get_inventory()
			if inv:room_for_item("main", {name=liquiddef.itemname}) then
				inv:add_item("main", liquiddef.itemname)
			else
				local pos = user:get_pos()
				pos.y = math.floor(pos.y + 0.5)
				minetest.add_item(pos, liquiddef.itemname)
			end

			-- set to return empty buckets minus 1
			giving_back = "buckets_api:bucket_empty "..tostring(item_count-1)

		end

		-- force_renew requires a source neighbour
		local source_neighbor = false
		if liquiddef.force_renew then
			source_neighbor =
				minetest.find_node_near(pointed_thing.under, 1, liquiddef.source)
		end
		if not (source_neighbor and liquiddef.force_renew) then
			minetest.add_node(pointed_thing.under, {name = "air"})
		end

		return ItemStack(giving_back)
	else
		-- non-liquid nodes will have their on_punch triggered
		local node_def = minetest.registered_nodes[node.name]
		if node_def then
			node_def.on_punch(pointed_thing.under, node, user, pointed_thing)
		end
		return user:get_wielded_item()
	end
end

-- Register a new liquid
--    groups = (optional) groups of the bucket item, for example {water_bucket = 1}
--    force_renew = (optional) bool. Force the liquid source to renew if it has a
--                  source neighbour, even if defined as 'liquid_renewable = false'.
--                  Needed to avoid creating holes in sloping rivers.
-- This function can be called from any mod (that depends on bucket).
function buckets.register_liquid(name, def)
	local txt = name:gsub(":", "_")
	buckets.liquids[def.source] = {
		itemname = name,
		source = def.source,
		flowing = def.flowing,
		force_renew = def.force_renew,
	}
	buckets.liquids[def.flowing] = buckets.liquids[def.source]

	if name then
		minetest.register_craftitem(name, {
			description = def.description or txt,
			short_desciption = def.short_desciption,
			groups = def.groups,
			inventory_image = def.inventory_image or txt .. ".png",
			inventory_overlay = def.inventory_overlay,
			wield_image = def.wield_image,
			wield_overlay = def.wield_overlay,
			palette = def.palette,
			color = def.color, 
			wield_scale = def.wield_scale,
			stack_max = 1,
			range = def.range,
			liquids_pointable = true,
			light_source = def.light_source,
			node_placement_prediction = def.node_placement_prediction,
			sound = def.sound,
			on_place = def.on_place or buckets.on_place,
			_empty = def.empty or "buckets_api:bucket_empty",
			_source = def.source
		})
	end
end

minetest.register_craftitem("buckets_api:bucket_empty", {
	description = S("Empty Bucket"),
	inventory_image = "buckets_api_bucket.png",
	groups = {tool = 1},
	liquids_pointable = true,
	on_use = buckets.on_use
})

