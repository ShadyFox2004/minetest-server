-- steel_bar_doors/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("steel_bar_doors")

doors.register_door("steel_bar_doors:door", {
	tiles = {{name = "steel_bar_doors_door.png", backface_culling = true}},
	description = S("Steel Bar Door"),
	inventory_image = "steel_bar_doors_door_item.png",
	protected = true,
	groups = {node = 1, cracky = 1, level = 2},
	sounds = sounds.get_defaults("ore_sounds:metal"),
	sound_open = "steel_bar_doors_door_open",
	sound_close = "steel_bar_doors_door_close",
	recipe = {
		{"steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar"},
	},
})

doors.register_trapdoor("steel_bar_doors:trapdoor", {
	description = S("Steel Bar Trapdoor"),
	inventory_image = "steel_bar_doors_trapdoor.png",
	wield_image = "steel_bar_doors_trapdoor.png",
	tile_front = "steel_bar_doors_trapdoor.png",
	tile_side = "steel_bar_doors_trapdoor_side.png",
	protected = true,
	groups = {node = 1, cracky = 1, level = 2, door = 1},
	sounds = sounds.get_defaults("ore_sounds:metal"),
	sound_open = "steel_bar_doors_door_open",
	sound_close = "steel_bar_doors_door_close",
})

minetest.register_craft({
	output = "steel_bar_doors:trapdoor",
	recipe = {
		{"steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar"},
	}
})

