-- liquids_api/init.lua 

liquids = {LIGHT_MAX = 14}

function liquids.register_liquid_node(name, def)
	local txt = name:gsub(":", "_")
	local tiles = {
		{
			name = txt .. "_" .. def.liquidtype .. "_animated.png",
			backface_culling = false,
			animation = def.animation or {
				type = "vertical_frames",
				aspect_w = def.aspect_w or 16,
				aspect_h = def.aspect_h or 16,
				length = def.length or 2.0,
			},
		},
		{
			name = txt .. "_" .. def.liquidtype .. "_animated.png",
			backface_culling = true,
			animation = def.animation or {
				type = "vertical_frames",
				aspect_w = def.aspect_w or 16,
				aspect_h = def.aspect_h or 16,
				length = def.length or 2.0,
			},
		},
	}

	local special_tiles
	if def.liquidtype == "flowing" then
		special_tiles = tiles
		tiles = {txt .. ".png"}
	end

	minetest.register_node(name .. "_" .. def.liquidtype, {
		description = def.description or txt,
		drawtype = def.liquidtype == "flowing" and "flowingliquid" or "liquid",
		waving = def.waving,
		tiles = def.tiles or tiles,
		special_tiles = def.special_tiles or special_tiles,
		use_texture_alpha = def.use_texture_alpha or "blend",
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = def.drowning or 1,
		light_source = def.light_source,
		liquidtype = def.liquidtype,
		liquid_range = def.liquid_range or 8,
		liquid_alternative_flowing = name .. "_flowing",
		liquid_alternative_source = name .. "_source",
		liquid_renewable = boolean.qq(def.liquid_renewable, true),
		liquid_viscosity = def.liquid_viscosity or 1,
		damage_per_second = def.damage_per_second,
		post_effect_color = def.post_effekt_color or {a = 103, r = 30, g = 68, 
			b = 90},
		groups = def.groups or {water = 3, liquid = 3, cools_lava = 1, 
			falling_node = 1, float = 1},
		sounds = def.sounds or sounds.get_defaults("liquid_sounds:water"),
	})
end

function liquids.register_liquid(name, def)
	def.source.liquidtype = "source"
	liquids.register_liquid_node(name, def.source)

	def.flowing.liquidtype = "flowing"
	def.flowing.paramtype2 = "flowingliquid"
	def.flowing.post_effect_color = def.flowing.post_effect_color 
		or def.source.post_effect_color
	liquids.register_liquid_node(name, def.flowing)
end

