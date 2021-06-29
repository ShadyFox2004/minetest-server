-- fire_env_sounds/init.lua

if minetest.settings:get_bool("flame_sound", true) then
	env_sounds.register_sound("fire_env_sounds:fire", {
		trigger = {"fire:basic_flame", "fire:permanent_flame"},
		base_volume = 0.06,
		max_volume = 0.18,
		per_node = 0.0075
	})
end
