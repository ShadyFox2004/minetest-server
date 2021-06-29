-- glass_api/init.lua 

glass = {}

function glass.register_glass(name, def)
	local txt = name:gsub(":", "_")
	name = name .. "_glass"
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype or "glasslike_framed_optional",
		tiles = def.tiles or {txt .. "_glass.png", txt .. "_glass_detail.png"},
		use_texture_alpha = "clip", -- only needed for stairs API
		paramtype = "light",
		paramtype2 = def.paramtype2 or "glasslikeliquidlevel",
		sunlight_propagates = true,
		is_ground_content = false,
		groups = def.groups or {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = def.sounds or sounds.get_defaults("glass_sounds:glass"),
	})

	if def.input then
		minetest.register_craft({
			type = "cooking",
			output = name,
			recipe = def.input
		})
	end
end
