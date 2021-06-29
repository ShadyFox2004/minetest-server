-- fire/init.lua

-- Global namespace for functions
fire = {}

-- 'Enable fire' setting
local fire_enabled = minetest.settings:get_bool("enable_fire")
if fire_enabled == nil then
	-- enable_fire setting not specified, check for disable_fire
	local fire_disabled = minetest.settings:get_bool("disable_fire")
	if fire_disabled == nil then
		-- Neither setting specified, check whether singleplayer
		fire_enabled = minetest.is_singleplayer()
	else
		fire_enabled = not fire_disabled
	end
end

-- Flood flame function
function fire.flood_flame(pos, _, newnode)
	-- Play flame extinguish sound if liquid is not an 'igniter'
	if minetest.get_item_group(newnode.name, "igniter") == 0 then
		minetest.sound_play("fire_extinguish_flame",
			{pos = pos, max_hear_distance = 16, gain = 0.15}, true)
	end
	-- Remove the flame
	return false
end

function fire.remove_flammable(pos)
	local p = minetest.find_node_near(pos, 1, {"group:flammable"})
	if not p then
		return
	end
	local flammable_node = minetest.get_node(p)
	local def = minetest.registered_nodes[flammable_node.name]
	if def.on_burn then
		def.on_burn(p)
	else
		minetest.remove_node(p)
		minetest.check_for_falling(p)
	end
end

function fire.register_node(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name, {
		description = def.description,
		drawtype = "firelike",
		tiles = def.tiles or {{
			name = txt .. "_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			}}
		},
		inventory_image = def.inventory_image or txt .. ".png",
		paramtype = "light",
		light_source = def.light_source or 13,
		walkable = false,
		buildable_to = true,
		sunlight_propagates = true,
		floodable = true,
		damage_per_second = def.damage_per_second or 4,
		groups = def.groups or {igniter = 2, dig_immediate = 3, fire = 1},
		drop = def.drop or "",
		on_flood = def.on_flood or fire.flood_flame,
		on_timer = def.on_timer,
		on_construct = def.on_construct
	})

	if fire_enabled and def.spreading then
		-- Ignite neighboring nodes, add basic flames
		minetest.register_abm({
			label = "Ignite flame",
			nodenames = {"group:flammable"},
			neighbors = {"group:igniter"},
			interval = 7,
			chance = 12,
			catch_up = false,
			action = def.ignite or function(pos)
				local p = minetest.find_node_near(pos, 1, {"air"})
				if p then
					minetest.set_node(p, {name = name})
				end
			end
		})

		-- Remove flammable nodes around basic flame
		minetest.register_abm({
			label = "Remove flammable nodes",
			nodenames = {name},
			neighbors = "group:flammable",
			interval = 5,
			chance = 18,
			catch_up = false,
			action = def.remove_flammable or fire.remove_flammable
		})
	end
end

-- Deprecated function kept temporarily to avoid crashes if mod fire nodes call it
function fire.update_sounds_around() end
