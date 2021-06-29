-- furnace/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_furnaces")

furnaces.register_furnace("base_furnaces:furnace", {
	inactive = {
		description = S("Furnace"),
		infotext = S("Furnace inactive"),
		recipe = {
			{"group:stone", "group:stone", "group:stone"},
			{"group:stone", "", "group:stone"},
			{"group:stone", "group:stone", "group:stone"},
		}
	},
	active = {
		description = S("Furnace"),
		infotext = S("Furnace active"),
	}
})

