-- trash/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("trash")

containers.register_container("trash:trash", {
	closed = {
		description = S("Trash"),
		tiles = {
			"trash_trash_top.png",
			"trash_trash_bottom.png",
			"trash_trash_side.png",
			"trash_trash_side.png",
			"trash_trash_side.png",
			"trash_trash_side.png"
		},
		protected = true,
		recipe = {
			{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"},
			{"base_ores:steel_ingot", "base_earth:dirt", "base_ores:steel_ingot"},
			{"base_ores:steel_ingot", "base_ores:steel_ingot", "base_ores:steel_ingot"}
		},
		sounds = sounds.get_defaults("ore_sounds:metal"),
		sound = "ore_sounds_metal_footstep",
		inventory_height = 3,
		formspec_def = {
			overlay = "image_button[3.5,3.4;1,1;trash_discard.png;trash_discard;]"
				.. "tooltip[trash_discard;", minetest.formspec_escape(S("Discard")), "]"
		}
	},
	opened = {
		inside = "trash_trash_inside.png",
		sound = "ore_sounds_metal_footstep",
	}
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "trash:trash" or fields.quit then
		return false
	end
	local tmp = containers.open_containers[player:get_player_name()]
	if tmp then
		local inv = minetest.get_inventory({type="node", pos = tmp.pos})
		tmp = inv:get_list("main")
		for _, stack in ipairs(tmp) do
			stack:clear()
		end
		inv:set_list("main", tmp)
	end
	return false
end)
