-- ladders_api/init.lua

ladders = {}

function ladders.register_ladder(name, def)
	local txt = name:gsub(":", "_")
	name = name .. "_ladder"
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype or "signlike",
		tiles = def.tiles or {txt .. "_ladder.png"},
		inventory_image = txt .. "_ladder.png",
		wield_image = txt .. "_ladder.png",
		paramtype = "light",
		paramtype2 = def.paramtype2 or "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		climbable = true,
		is_ground_content = false,
		selection_box = def.selection_box or {type = "wallmounted"},
		groups = def.groups or {oddly_breakable_by_hand = 3},
		sounds = def.sounds,
		legacy_wallmounted = true
	})

	if def.material then
		minetest.register_craft({
			output = name .. (def.output_count and (" " .. def.output_count) 
				or " 10"),
			recipe = {
				{def.material, "", def.material},
				{def.material, def.material, def.material},
				{def.material, "", def.material},
			}
		})
	end

	if def.burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = def.burntime
		})
	end
end
