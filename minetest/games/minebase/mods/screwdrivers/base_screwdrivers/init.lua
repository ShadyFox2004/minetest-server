-- base_screwdrivers/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_screwdrivers")

screwdrivers.register_screwdriver("base_screwdrivers:screwdriver", {
	description = S("Screwdriver") .. "\n" .. S("left-click rotates face, right"
		.. "-click rotates axis"),
	on_use = function(itemstack, user, pointed_thing)
		screwdrivers.handler(itemstack, user, pointed_thing, 
			screwdrivers.ROTATE_FACE, 200)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdrivers.handler(itemstack, user, pointed_thing, 
			screwdrivers.ROTATE_AXIS, 200)
		return itemstack
	end,
	recipe = {
		{"base_ores:steel_ingot"},
		{"group:stick"}
	}
})

screwdrivers.register_screwdriver("base_screwdrivers:exzet", {
	description = S("Exzet") .. "\n" .. S("left-click push from left, "
		.. "right-click push from right") .. ",\n" .. S("aux + left-click pull to "
		.. "left, aux + right-click pull to right"),
	on_use = function(itemstack, user, pointed_thing)
		screwdrivers.exzet(itemstack, user, pointed_thing, 1)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdrivers.exzet(itemstack, user, pointed_thing, 2)
		return itemstack
	end,
	recipe = {
		{"base_ores:gold_ingot"},
		{"group:stick"}
	}
})
