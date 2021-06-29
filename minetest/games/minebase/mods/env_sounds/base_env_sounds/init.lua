-- base_env_sounds/init.lua

local trigger = {"base_liquids:water_flowing", 
	"base_liquids:river_water_flowing"}

if minetest.settings:get_bool("river_source_sounds") then
	table.insert(trigger, "base_liquids:river_water_source")
end

env_sounds.register_sound("base_env_sounds:water", {trigger = trigger})

env_sounds.register_sound("base_env_sounds:lava", {
	trigger = {"base_liquids:lava_source", "base_liquids:lava_flowing"},
	base_volume = 0,
	max_volume = 0.6,
	per_node = {
		["base_liquids:lava_source"] = 0.008,
		["base_liquids:lava_flowing"] = 0.002,
	},
})

