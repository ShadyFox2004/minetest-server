-- signs_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("signs_api")

signs = {}

function signs.on_construct(pos)
	minetest.get_meta(pos):set_string("formspec", "field[text;;${text}]")
end

function signs.on_receive_fields(pos, formname, fields, sender)
	local player_name = sender:get_player_name()
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return
	end
	local text = fields.text
	if not text then
		return
	end
	if string.len(text) > 512 then
		minetest.chat_send_player(player_name, S("Text too long"))
		return
	end
	local meta = minetest.get_meta(pos)
	meta:set_string("text", text)

	if #text > 0 then
		meta:set_string("infotext", S('"@1"', text))
	else
		meta:set_string("infotext", '')
	end
end

function signs.register_sign(name, def)
	local txt = name:gsub(":", "_")
	name = name .. "_sign_wall"
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype or "nodebox",
		tiles = def.tiles or {txt .. "_sign_wall.png"},
		inventory_image = def.inventory_image or txt .. "_sign.png",
		wield_image = def.wield_image or txt .. "_sign.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "opaque",
		node_box = def.node_box or {
			type = "wallmounted",
			wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
			wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
			wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
		},
		legacy_wallmounted = true,
		groups = def.groups or {attached_node = 1, oddly_breakable_by_hand = 3},
		sounds = def.sounds,
		on_construct = signs.on_construct,
		on_receive_fields = signs.on_receive_fields
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 3",
			recipe = {
				{def.material, def.material, def.material},
				{def.material, def.material, def.material},
				{"", "group:stick", ""},
			}
		})
	end

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = def.burntime,
		})
	end
end

