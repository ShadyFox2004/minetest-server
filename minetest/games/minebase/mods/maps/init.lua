-- maps/init.lua

-- Mod global namespace

maps = {}

minetest.register_alias("map:mapping_kit", "maps:mapping_kit")

-- Load support for Minebase translation.
local S = minetest.get_translator("maps")


-- Update HUD flags
-- Global to allow overriding

function maps.update_hud_flags(player)
	local creative_enabled = minetest.is_creative_enabled(player
		:get_player_name())

	local minimap_enabled = creative_enabled or
		player:get_inventory():contains_item("main", "maps:mapping_kit")
	local radar_enabled = creative_enabled

	player:hud_set_flags({
		minimap = minimap_enabled,
		minimap_radar = radar_enabled
	})
end


-- Set HUD flags 'on joinplayer'

minetest.register_on_joinplayer(function(player)
	maps.update_hud_flags(player)
end)


-- Cyclic update of HUD flags

local function cyclic_update()
	for _, player in ipairs(minetest.get_connected_players()) do
		maps.update_hud_flags(player)
	end
	minetest.after(5.3, cyclic_update)
end

minetest.after(5.3, cyclic_update)


-- Mapping kit item

minetest.register_craftitem("maps:mapping_kit", {
	description = S("Mapping Kit") .. "\n" .. S("Use with 'Minimap' key"),
	inventory_image = "maps_mapping_kit.png",
	stack_max = 1,
	groups = {flammable = 3, tool = 1},

	on_use = function(_, user)
		maps.update_hud_flags(user)
	end,
})


-- Crafting

minetest.register_craft({
	output = "maps:mapping_kit",
	recipe = {
		{"base_glass:common", "base_books:paper", "group:stick"},
		{"base_ores:steel_ingot", "base_books:paper", "base_ores:steel_ingot"},
		{"group:wood", "base_books:paper", "dye:black"},
	}
})


-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "maps:mapping_kit",
	burntime = 5,
})
