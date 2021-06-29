-- chests/init.lua

-- support for Minebase translation.
local S = minetest.get_translator("chests")

containers.register_container("chests:common", {
	closed = {
		description = S("Chest"),
		tiles = {
			"chests_common_top.png",
			"chests_common_top.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_front.png"
		},
		burntime = 30,
		recipe = {
			{"group:wood", "group:wood", "group:wood"},
			{"group:wood", "", "group:wood"},
			{"group:wood", "group:wood", "group:wood"},
		}
	},
	opened = {inside = "chests_common_inside.png"}
})

containers.register_container("chests:common_locked", {
	closed = {
		description = S("Locked Chest"),
		tiles = {
			"chests_common_top.png",
			"chests_common_top.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_side.png",
			"chests_common_lock.png"
		},
		protected = true,
		burntime = 30,
		recipe = {
			{"group:wood", "group:wood", "group:wood"},
			{"group:wood", "base_ores:steel_ingot", "group:wood"},
			{"group:wood", "group:wood", "group:wood"},
		},
		sound = "chests_common_open"
	},
	opened = {
		inside = "chests_common_inside.png",
		sound = "chests_common_close"
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "chests:common_locked",
	recipe = {"chests:common", "base_ores:steel_ingot"},
})

