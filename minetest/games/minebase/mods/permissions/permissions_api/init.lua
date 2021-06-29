-- permissions_api/init.lua

local S = minetest.get_translator("permissions_api")

permissions = {}

function permissions.generate_secret()
	local secret = {}
	for i = 1, 20 do 
		table.insert(secret, string.char(rand.az(32, 126)))
	end
	return table.concat(secret, "")
end

function permissions.create_key(itemstack, user, name, secret)
	local inv = minetest.get_inventory({type="player", 
		name=user:get_player_name()})

	-- update original itemstack
	itemstack:take_item()

	-- finish and return the new key
	local new_stack = ItemStack("base_permissions:key")
	local meta = new_stack:get_meta()
	meta:set_string("secret", secret)
	meta:set_string("description", S("Key to @1's @2", user:get_player_name(),
		minetest.registered_nodes[name].description))

	if itemstack:get_count() == 0 then
		itemstack = new_stack
	else
		if inv:add_item("main", new_stack):get_count() > 0 then
			minetest.add_item(user:get_pos(), new_stack)
		end -- else: added to inventory successfully
	end
	return itemstack
end

function permissions.correct_key(item, secret)
	if minetest.get_item_group(item:get_name(), "key") == 1 then
		local key_meta = item:get_meta()

		if key_meta:get_string("secret") == "" then
			local key_oldmeta = item:get_metadata()
			if key_oldmeta == "" or not minetest.parse_json(key_oldmeta) then
				return false
			end

			key_meta:set_string("secret", minetest.parse_json(key_oldmeta).secret)
			item:set_metadata("")
		end

		return secret == key_meta:get_string("secret")
	end
end

function permissions.can_interact_with_node(player, pos)
	if player and player:is_player() then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
	else
		return false
	end

	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if not owner or owner == "" or owner == player:get_player_name() then
		return true
	end

	-- Is player wielding the right key?
	if permissions.correct_key(player:get_wielded_item(), 
		meta:get_string("key_lock_secret")) then
		return true
	end

	return false
end


