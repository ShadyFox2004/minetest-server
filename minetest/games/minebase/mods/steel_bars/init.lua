-- steel_bars/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("steel_bars")

minetest.register_craftitem("steel_bars:bar", {
	description = S("Steel Bar"),
	inventory_image = "steel_bars_bar.png",
})

minetest.register_craft({
	output = "steel_bars:bar",
	type = "shaped",
	recipe = {
		{"base_ores:steel_ingot","",""},
		{"base_ores:steel_ingot","",""},
		{"base_ores:steel_ingot","",""}
	}
})

minetest.register_craft({
	output = "base_ores:steel_ingot 3",
	type = "cooking",
	recipe = "steel_bars:bar",
	cooktime = 4
})


minetest.register_node("steel_bars:block", {
	description = S("Steel Bar Block"),
	drawtype = "glasslike_framed_optional",
	tiles = {"steel_bars_bars.png"},
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = "clip",
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = sounds.get_defaults("ore_sounds:metal"),
})

minetest.register_craft({
	output = "steel_bars:block",
	type = "shaped",
	recipe = {
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"},
		{"steel_bars:bar", "steel_bars:bar", "steel_bars:bar"}
	}
})


if minetest.get_modpath("base_tools") then
	minetest.register_craft({
		output = "base_tools:steel_pick",
		recipe = {
			{"", "steel_bars:bar", ""},
			{"", "group:stick", ""},
			{"", "group:stick", ""}
		}
	})
end

if minetest.get_modpath("base_ladders") then
	minetest.register_craft({
		output = "base_ladders:steel_ladder 15",
		type = "shaped",
		recipe = {
			{"","",""},
			{"steel_bars:bar","base_ores:steel_ingot","steel_bars:bar"},
			{"","",""}
		}
	})
end

if minetest.get_modpath("base_rails") then
	minetest.register_craft({
		output = "base_rails:rail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","","steel_bars:bar"},
			{"","group:wood",""}
		}
	})

	minetest.register_craft({
		output = "base_rails:powerrail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","base_ores:mese_crystal","steel_bars:bar"},
			{"","group:wood",""}
		}
	})

	minetest.register_craft({
		output = "base_rails:brakerail 18",
		type = "shaped",
		recipe = {
			{"","group:wood",""},
			{"steel_bars:bar","base_ores:coal_lump","steel_bars:bar"},
			{"","group:wood",""}
		}
	})
end

