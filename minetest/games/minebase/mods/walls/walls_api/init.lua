-- walls_api/init.lua

local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") 
	and 3/8 or 0

walls = {}

function walls.register_wall(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description or txt,
		drawtype = def.drawtype or "nodebox",
		node_box = def.node_box or {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = def.collision_box or {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + fence_collision_extra,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + fence_collision_extra,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2 + fence_collision_extra,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2 + fence_collision_extra,1/4},
		},
		connects_to = def.connects_to or { "group:wall", "group:stone", 
			"group:fence" },
		paramtype = def.paramtype or "light",
		is_ground_content = false,
		tiles = def.tiles or def.material and {def.material:gsub(":", "_") 
			.. ".png"} or {txt .. ".png"},
		walkable = true,
		groups = def.groups or { cracky = 3, wall = 1, stone = 2 },
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone")
	})

	-- crafting recipe
	if def.material then
		minetest.register_craft({
			output = name .. " 6",
			recipe = {
				{ "", "", "" },
				{ def.material, def.material, def.material},
				{ def.material, def.material, def.material},
			}
		})
	end
end

