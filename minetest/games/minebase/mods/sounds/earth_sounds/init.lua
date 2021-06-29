-- earth_sounds/init.lua


sounds.register_defaults("earth_sounds:stone", {
	footstep = {name = "base_sounds_hard_footstep", gain = 0.3},
	dig = {name = "base_sounds_hard_footstep", gain = 0.3},
	dug = {name = "base_sounds_hard_footstep", gain = 1.0}
})

sounds.register_defaults("earth_sounds:dirt", {
	footstep = {name = "earth_sounds_dirt_footstep", gain = 0.4},
	dig = {name = "earth_sounds_dirt_footstep", gain = 0.4},
	dug = {name = "earth_sounds_dirt_footstep", gain = 1.0},
	place = {name = "base_sounds_place_node", gain = 1.0}
})

sounds.register_defaults("earth_sounds:sand", {
	footstep = {name = "earth_sounds_sand_footstep", gain = 0.05},
	dig = {name = "earth_sounds_sand_footstep", gain = 0.15},
	dug = {name = "earth_sounds_sand_footstep", gain = 0.15},
	place = {name = "base_sounds_place_node", gain = 1.0}
})

sounds.register_defaults("earth_sounds:gravel", {
	footstep = {name = "earth_sounds_gravel_footstep", gain = 0.1},
	dig = {name = "earth_sounds_gravel_dig", gain = 0.35},
	dug = {name = "earth_sounds_gravel_dug", gain = 1.0},
	place = {name = "base_sounds_place_node", gain = 1.0}
})
