-- tree_sounds/init.lua

sounds.register_defaults("tree_sounds:wood" , {
	footstep = {name = "tree_sounds_wood_footstep", gain = 0.3},
	dig = {name = "tree_sounds_wood_footstep", gain = 0.3},
	dug = {name = "tree_sounds_wood_footstep", gain = 1.0}
})

sounds.register_defaults("tree_sounds:leaves", {
	footstep = {name = "earth_sounds_grass_footstep", gain = 0.45},
	dig = {name = "earth_sounds_grass_footstep", gain = 0.45},
	dug = {name = "earth_sounds_grass_footstep", gain = 0.7},
	place = {name = "base_sounds_place_node", gain = 1.0}
})
