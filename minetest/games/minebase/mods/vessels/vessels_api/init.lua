-- vessels_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("vessels_api")

vessels = {}

function vessels.register_bottle(name, def)
	name = name .. "_bottle"
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = "plantlike",
		tiles = {txt .. ".png"},
		inventory_image = txt .. ".png",
		wield_image = txt .. ".png",
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
		groups = def.groups or {vessel = 1, dig_immediate = 3, attached_node = 1},
		sounds = def.sounds or sounds.get_defaults("glass_sounds:glass"),
	})

	if def.material then
		minetest.register_craft( {
			output = name .. " " .. (def.output or 10),
			recipe = {
				{def.material, "", def.material},
				{def.material, "", def.material},
				{"", def.material, ""}
			}
		})
	end
end

function vessels.register_glass(name, def)
	name = name .. "_glass"
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = "plantlike",
		tiles = {txt .. ".png"},
		inventory_image = txt .. "_inv.png",
		wield_image = txt .. ".png",
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
		groups = def.groups or {vessel = 1, dig_immediate = 3, attached_node = 1},
		sounds = def.sounds or sounds.get_defaults("glass_sounds:glass"),
	})

	if def.material then
		minetest.register_craft( {
			output = name .. " " .. (def.output or 14),
			recipe = {
				{def.material, "", def.material},
				{def.material, "", def.material},
				{def.material, def.material, def.material}
			}
		})
	end
end
