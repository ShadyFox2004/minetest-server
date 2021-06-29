-- boats/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("boats")

mounts.register_mount("boats:boat", {
	entity = {
		mesh = "boats_boat.obj",
		visual_size = {x = 1, y = 1},
		wield_scale = {x = 1, y = 1, z = 1},
		collisionbox = {-0.5, -0.35, -0.5, 0.5, 0.3, 0.5},
		textures = {"base_trees_apple_wood.png"},
		stepheight = 0,
		visual = "mesh",
		terrain_type = 2,
		max_speed_forward = 4,
		max_speed_reverse = 3,
		accel = 3,
		braking = 3,
		turn_speed = 3,
		player_rotation = {x = 0, y = 0, z = 0},
		drop_on_destroy = {"default:wood 3"},
		attach_at = {{x = 0.5, y = 1, z = -3}},
		eye_offset = {{x = 0, y = 0, z = 0}},
		max_passengers = 1,
	},
	craftitem = {
		description = S("Boat"),
		wield_scale = {x = 2, y = 2, z = 1},
		groups = {flammable = 2},
		recipe = {
			{"",           "",           ""          },
			{"group:wood", "",           "group:wood"},
			{"group:wood", "group:wood", "group:wood"},
		},
		burntime = 20,
		onplace_position_adj = 0,
	}
})
