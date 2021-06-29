-- liquid_sounds/init.lua

sounds.register_defaults("liquid_sounds:ice", {
	footstep = {name = "liquid_sounds_ice_footstep", gain = 0.3},
	dig = {name = "liquid_sounds_ice_dig", gain = 0.5},
	dug = {name = "liquid_sounds_ice_dug", gain = 0.5}
})

sounds.register_defaults("liquid_sounds:water", {
	footstep = {name = "liquid_sounds_water_footstep", gain = 0.2}
})

sounds.register_defaults("liquid_sounds:snow", {
	footstep = {name = "liquid_sounds_snow_footstep", gain = 0.2},
	dig = {name = "liquid_sounds_snow_footstep", gain = 0.3},
	dug = {name = "liquid_sounds_snow_footstep", gain = 0.3},
	place = {name = "base_sounds_place_node", gain = 1.0}
})

