-- dyes_api/init.lua

dyes = {}

function dyes.register_dye(name, def)
	local txt = name:gsub(":", "_")
	local color_name = "color_" .. name:match(":.*$")
	if def.groups then
		def.groups.dye = 1
		def.groups[color_name] = 1
	else
		def.groups =  {dye = 1, [color_name] = 1}
	end

	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = txt .. ".png",
		groups = def.groups
	})

	if def.recipe then
		minetest.register_craft({
			output = name .. " 4",
			recipe = {
				{"group:flower," .. color_name}
			},
		})
	end
end
