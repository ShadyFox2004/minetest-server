local mesecons_rules = {
	{x =  1,y =  0,z =  0,},
	{x = -1,y =  0,z =  0,},
	{x =  0,y =  0,z =  1,},
	{x =  0,y =  0,z = -1,},
	{x =  1,y = -1,z =  0,},
	{x = -1,y = -1,z =  0,},
	{x =  0,y = -1,z =  1,},
	{x =  0,y = -1,z = -1,},
	{x =  0,y = -1,z =  0,},
}

carts:register_rail("mesecons_carts:mese_cond_rail_off", {
	description = "Mesecons Conducting Rail",
	tiles = {
		"mesecons_carts_mese_cond_off_straight.png",
		"mesecons_carts_mese_cond_off_curve.png",
		"mesecons_carts_mese_cond_off_tjunction.png",
		"mesecons_carts_mese_cond_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		conductor = {
			rules = mesecons_rules,
			state = mesecon.state.off,
			onstate = "mesecons_carts:mese_cond_rail_on",
			offstate = "mesecons_carts:mese_cond_rail_off",
		},
	},
}, {})

carts:register_rail("mesecons_carts:mese_cond_rail_on", {
	description = "Mesecons Conducting Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_mese_cond_on_straight.png",
		"mesecons_carts_mese_cond_on_curve.png",
		"mesecons_carts_mese_cond_on_tjunction.png",
		"mesecons_carts_mese_cond_on_crossing.png",
	},
	drop = "mesecons_carts:mese_cond_rail_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		conductor = {
			rules = mesecons_rules,
			state = mesecon.state.on,
			onstate = "mesecons_carts:mese_cond_rail_on",
			offstate = "mesecons_carts:mese_cond_rail_off",
		},
	},
}, {})

carts:register_rail("mesecons_carts:power_rail_off", {
	description = "Mesecons-Controlled Powered Rail",
	tiles = {
		"mesecons_carts_pwr_off_straight.png",
		"mesecons_carts_pwr_off_curve.png",
		"mesecons_carts_pwr_off_tjunction.png",
		"mesecons_carts_pwr_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_on = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:power_rail_on"})
			end,
		},
	},
}, {})

carts:register_rail("mesecons_carts:power_rail_on", {
	description = "Mesecons-Controlled Powered Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_pwr_on_straight.png",
		"mesecons_carts_pwr_on_curve.png",
		"mesecons_carts_pwr_on_tjunction.png",
		"mesecons_carts_pwr_on_crossing.png",
	},
	drop = "mesecons_carts:power_rail_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_off = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:power_rail_off"})
			end,
		},
	},
}, {acceleration = 5,})

carts:register_rail("mesecons_carts:power_rail_strong_off", {
	description = "Mesecons-Controlled Strong Powered Rail",
	tiles = {
		"mesecons_carts_pwr_strong_off_straight.png",
		"mesecons_carts_pwr_strong_off_curve.png",
		"mesecons_carts_pwr_strong_off_tjunction.png",
		"mesecons_carts_pwr_strong_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_on = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:power_rail_strong_on"})
			end,
		},
	},
}, {})

carts:register_rail("mesecons_carts:power_rail_strong_on", {
	description = "Mesecons-Controlled Strong Powered Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_pwr_strong_on_straight.png",
		"mesecons_carts_pwr_strong_on_curve.png",
		"mesecons_carts_pwr_strong_on_tjunction.png",
		"mesecons_carts_pwr_strong_on_crossing.png",
	},
	drop = "mesecons_carts:power_rail_strong_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_off = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:power_rail_strong_off"})
			end,
		},
	},
}, {acceleration = 10,})

carts:register_rail("mesecons_carts:brake_rail_off", {
	description = "Mesecons-Controlled Brake Rail",
	tiles = {
		"mesecons_carts_brk_off_straight.png",
		"mesecons_carts_brk_off_curve.png",
		"mesecons_carts_brk_off_tjunction.png",
		"mesecons_carts_brk_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_on = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:brake_rail_on"})
			end,
		},
	},
}, {})

carts:register_rail("mesecons_carts:brake_rail_on", {
	description = "Mesecons-Controlled Brake Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_brk_on_straight.png",
		"mesecons_carts_brk_on_curve.png",
		"mesecons_carts_brk_on_tjunction.png",
		"mesecons_carts_brk_on_crossing.png",
	},
	drop = "mesecons_carts:brake_rail_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_off = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:brake_rail_off"})
			end,
		},
	},
}, {acceleration = -5,})

carts:register_rail("mesecons_carts:brake_rail_strong_off", {
	description = "Mesecons-Controlled Strong Brake Rail",
	tiles = {
		"mesecons_carts_brk_strong_off_straight.png",
		"mesecons_carts_brk_strong_off_curve.png",
		"mesecons_carts_brk_strong_off_tjunction.png",
		"mesecons_carts_brk_strong_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_on = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:brake_rail_strong_on"})
			end,
		},
	},
}, {})

carts:register_rail("mesecons_carts:brake_rail_strong_on", {
	description = "Mesecons-Controlled Strong Brake Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_brk_strong_on_straight.png",
		"mesecons_carts_brk_strong_on_curve.png",
		"mesecons_carts_brk_strong_on_tjunction.png",
		"mesecons_carts_brk_strong_on_crossing.png",
	},
	drop = "mesecons_carts:brake_rail_strong_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_off = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:brake_rail_strong_off"})
			end,
		},
	},
}, {acceleration = -10,})

local function detector_onstep(cart)
	local cartpos = cart.object:get_pos()
	local trackpos = {}
	trackpos.x = math.floor(cartpos.x + 0.5)
	trackpos.y = math.floor(cartpos.y + 0.5)
	trackpos.z = math.floor(cartpos.z + 0.5)
	local track = minetest.get_node(trackpos)
	if track.name ~= "mesecons_carts:detector_rail_off" then return end
	minetest.set_node(trackpos,{name = "mesecons_carts:detector_rail_on",})
	mesecon.receptor_on(trackpos,mesecons_rules)
	minetest.after(0.25,function(pos)
		local node = minetest.get_node(pos)
		if node.name == "mesecons_carts:detector_rail_on" then
			minetest.set_node(pos,{name = "mesecons_carts:detector_rail_off",})
			mesecon.receptor_off(pos,mesecons_rules)
		end
	end,trackpos)
end

carts:register_rail("mesecons_carts:detector_rail_off", {
	description = "Mesecons Detector Rail",
	tiles = {
		"mesecons_carts_det_off_straight.png",
		"mesecons_carts_det_off_curve.png",
		"mesecons_carts_det_off_tjunction.png",
		"mesecons_carts_det_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		receptor = {
			rules = mesecons_rules,
			state = mesecon.state.off,
		},
	},
}, {on_step = detector_onstep,})

carts:register_rail("mesecons_carts:detector_rail_on", {
	description = "Mesecons Detector Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_det_on_straight.png",
		"mesecons_carts_det_on_curve.png",
		"mesecons_carts_det_on_tjunction.png",
		"mesecons_carts_det_on_crossing.png",
	},
	drop = "mesecons_carts:detector_rail_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		receptor = {
			rules = mesecons_rules,
			state = mesecon.state.on,
		},
	},
}, {})

minetest.register_lbm({
	name = "mesecons_carts:detector_turnoff",
	label = "Turn off detector rails",
	nodenames = {"mesecons_carts:detector_rail_on",},
	run_at_every_load = true,
	action = function(pos)
		minetest.set_node(pos,{name = "mesecons_carts:detector_rail_off",})
		mesecon.receptor_off(pos,mesecons_rules)
	end,
})

local function grab_cart(cart)
	local cartpos = cart.object:get_pos()
	local trackpos = {}
	trackpos.x = math.floor(cartpos.x + 0.5)
	trackpos.y = math.floor(cartpos.y + 0.5)
	trackpos.z = math.floor(cartpos.z + 0.5)
	local track = minetest.get_node(trackpos)
	if track.name ~= "mesecons_carts:startstop_rail_off" then return end
	local velocity = cart.object:get_velocity()
	if velocity.x == 0 and velocity.y == 0 and velocity.z == 0 then return end
	local meta = minetest.get_meta(trackpos)
	meta:set_string("velocity",minetest.serialize(velocity))
	cartpos.x = math.floor(cartpos.x + 0.5)
	cartpos.z = math.floor(cartpos.z + 0.5)
	cart.object:set_pos(cartpos)
	meta:set_string("pos",minetest.serialize(cartpos))
	cart.object:set_velocity(vector.new(0,0,0))
end

local function restart_cart(pos)
	local meta = minetest.get_meta(pos)
	local velocity_serial = meta:get_string("velocity")
	local cartpos_serial = meta:get_string("pos")
	if not (velocity_serial and cartpos_serial) then return end
	local velocity = minetest.deserialize(velocity_serial)
	local cartpos = minetest.deserialize(cartpos_serial)
	if not (type(velocity) == "table" and type(cartpos) == "table") then return end
	local possible_carts = minetest.get_objects_inside_radius(cartpos,0.5)
	for _,object in pairs(possible_carts) do
		local cart = object:get_luaentity()
		if cart and cart.name == "carts:cart" then
			cart.object:set_velocity(velocity)
		end
	end
end

carts:register_rail("mesecons_carts:startstop_rail_off", {
	description = "Mesecons-Controlled Start-Stop Rail",
	tiles = {
		"mesecons_carts_startstop_off_straight.png",
		"mesecons_carts_startstop_off_curve.png",
		"mesecons_carts_startstop_off_tjunction.png",
		"mesecons_carts_startstop_off_crossing.png",
	},
	groups = carts:get_rail_groups(),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_on = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:startstop_rail_on"})
				restart_cart(pos)
			end,
		},
	},
}, {on_step = grab_cart,})

carts:register_rail("mesecons_carts:startstop_rail_on", {
	description = "Mesecons-Controlled Start-Stop Rail (on state - you hacker you!)",
	tiles = {
		"mesecons_carts_startstop_on_straight.png",
		"mesecons_carts_startstop_on_curve.png",
		"mesecons_carts_startstop_on_tjunction.png",
		"mesecons_carts_startstop_on_crossing.png",
	},
	drop = "mesecons_carts:startstop_rail_off",
	groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
	mesecons = {
		effector = {
			rules = mesecons_rules,
			action_off = function(pos,node)
				minetest.swap_node(pos,{name = "mesecons_carts:startstop_rail_off"})
			end,
		},
	},
}, {})

minetest.register_craft({
	output = "mesecons_carts:power_rail_off 3",
	recipe = {
		{"carts:rail","","",},
		{"carts:rail","basic_materials:motor","mesecons:wire_00000000_off",},
		{"carts:rail","","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:power_rail_strong_off 3",
	recipe = {
		{"carts:rail","basic_materials:motor","",},
		{"carts:rail","","mesecons:wire_00000000_off",},
		{"carts:rail","basic_materials:motor","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:brake_rail_off 3",
	recipe = {
		{"carts:rail","","",},
		{"carts:rail","default:sand","mesecons:wire_00000000_off",},
		{"carts:rail","","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:brake_rail_strong_off 3",
	recipe = {
		{"carts:rail","default:sand","",},
		{"carts:rail","","mesecons:wire_00000000_off",},
		{"carts:rail","default:sand","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:detector_rail_off 3",
	recipe = {
		{"carts:rail","","",},
		{"carts:rail","mesecons_detector:object_detector_off","mesecons:wire_00000000_off",},
		{"carts:rail","","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:startstop_rail_off 3",
	recipe = {
		{"carts:rail","basic_materials:motor","",},
		{"carts:rail","","mesecons:wire_00000000_off",},
		{"carts:rail","default:sand","",},
	},
})

minetest.register_craft({
	output = "mesecons_carts:mese_cond_rail_off 6",
	recipe = {
		{"carts:rail","mesecons:wire_00000000_off","carts:rail",},
		{"carts:rail","mesecons:wire_00000000_off","carts:rail",},
		{"carts:rail","mesecons:wire_00000000_off","carts:rail",},
	},
})

if minetest.get_modpath("digilines") then
	local digilines_rules = {
		{x =  1,y =  0,z =  0,},
		{x = -1,y =  0,z =  0,},
		{x =  0,y =  0,z =  1,},
		{x =  0,y =  0,z = -1,},
		{x =  1,y = -1,z =  0,},
		{x = -1,y = -1,z =  0,},
		{x =  0,y = -1,z =  1,},
		{x =  0,y = -1,z = -1,},
		{x =  1,y =  1,z =  0,},
		{x = -1,y =  1,z =  0,},
		{x =  0,y =  1,z =  1,},
		{x =  0,y =  1,z = -1,},
		{x =  0,y = -1,z =  0,},
		{x =  0,y =  1,z =  0,},
	}
	
	carts:register_rail("mesecons_carts:mese_digi_cond_rail_off", {
		description = "Mesecons and Digilines Conducting Rail",
		tiles = {
			"mesecons_carts_mese_digi_cond_off_straight.png",
			"mesecons_carts_mese_digi_cond_off_curve.png",
			"mesecons_carts_mese_digi_cond_off_tjunction.png",
			"mesecons_carts_mese_digi_cond_off_crossing.png",
		},
		groups = carts:get_rail_groups(),
		mesecons = {
			conductor = {
				rules = mesecons_rules,
				state = mesecon.state.off,
				onstate = "mesecons_carts:mese_digi_cond_rail_on",
				offstate = "mesecons_carts:mese_digi_cond_rail_off",
			},
		},
		digiline = {
			wire = {
				rules = digilines_rules,
			},
		},
	}, {})

	carts:register_rail("mesecons_carts:mese_digi_cond_rail_on", {
		description = "Mesecons and Digilines Conducting Rail (on state - you hacker you!)",
		tiles = {
			"mesecons_carts_mese_digi_cond_on_straight.png",
			"mesecons_carts_mese_digi_cond_on_curve.png",
			"mesecons_carts_mese_digi_cond_on_tjunction.png",
			"mesecons_carts_mese_digi_cond_on_crossing.png",
		},
		drop = "mesecons_carts:mese_digi_cond_rail_off",
		groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
		mesecons = {
			conductor = {
				rules = mesecons_rules,
				state = mesecon.state.on,
				onstate = "mesecons_carts:mese_digi_cond_rail_on",
				offstate = "mesecons_carts:mese_digi_cond_rail_off",
			},
		},
		digiline = {
			wire = {
				rules = digilines_rules,
			},
		},
	}, {})
	
	carts:register_rail("mesecons_carts:digi_cond_rail", {
		description = "Digilines Conducting Rail",
		tiles = {
			"mesecons_carts_digi_cond_straight.png",
			"mesecons_carts_digi_cond_curve.png",
			"mesecons_carts_digi_cond_tjunction.png",
			"mesecons_carts_digi_cond_crossing.png",
		},
		groups = carts:get_rail_groups(),
		digiline = {
			wire = {
				rules = digilines_rules,
			},
		},
	}, {})
	
	local function digilinesrail_onstep(cart,dtime)
		local cartpos = cart.object:get_pos()
		local trackpos = {}
		trackpos.x = math.floor(cartpos.x + 0.5)
		trackpos.y = math.floor(cartpos.y + 0.5)
		trackpos.z = math.floor(cartpos.z + 0.5)
		local track = minetest.get_node(trackpos)
		if not string.find(track.name,"mesecons_carts:digilines_rail") then return end
		local trackmeta = minetest.get_meta(trackpos)
		local response = {}
		local velocity = cart.object:get_velocity()
		response.pos = {x = cartpos.x,y = cartpos.y,z = cartpos.z,}
		response.velocity = {x = velocity.x,z = velocity.z,}
		response.driver = cart.driver
		digiline:receptor_send(trackpos,digilines_rules,trackmeta:get_string("channel"),response)
	end
	
	local function digilinesrail_handle_digilines(pos,node,channel,msg)
		local trackmeta = minetest.get_meta(pos)
		if channel ~= trackmeta:get_string("channel") then return end
		if msg == "grab" then
			local possible_carts = minetest.get_objects_inside_radius(pos,1)
			for _,object in pairs(possible_carts) do
				local cart = object:get_luaentity()
				if cart and cart.name == "carts:cart" then
					local velocity = cart.object:get_velocity()
					trackmeta:set_string("velocity",minetest.serialize(velocity))
					cart.object:set_velocity(vector.new(0,0,0))
					cart.object:set_pos(pos)
				end
			end
		elseif msg == "release" then
			local velocity = trackmeta:get_string("velocity")
			if velocity then velocity = minetest.deserialize(velocity) end
			if not velocity then return end
			local possible_carts = minetest.get_objects_inside_radius(pos,0.5)
			for _,object in pairs(possible_carts) do
				local cart = object:get_luaentity()
				if cart and cart.name == "carts:cart" then
					cart.object:set_velocity(velocity)
				end
			end
		elseif msg == "idle" or msg == "power0" or msg == "brake0" then
			minetest.swap_node(pos,{name = "mesecons_carts:digilines_rail_idle",})
		elseif type(msg) == "string" then
			if string.sub(msg,1,5) == "power" then
				local strength = string.sub(msg,6,-1)
				if strength then strength = tonumber(strength) end
				if not strength then return end
				strength = math.min(15,math.max(1,math.floor(strength)))
				local newnode = "mesecons_carts:digilines_rail_pwr_"..strength
				minetest.swap_node(pos,{name = newnode,})
			elseif string.sub(msg,1,5) == "brake" then
				local strength = string.sub(msg,6,-1)
				if strength then strength = tonumber(strength) end
				if not strength then return end
				strength = math.min(15,math.max(1,math.floor(strength)))
				local newnode = "mesecons_carts:digilines_rail_brk_"..strength
				minetest.swap_node(pos,{name = newnode,})
			end
		end
	end
	
	carts:register_rail("mesecons_carts:digilines_rail_idle", {
		description = "Digilines-Controlled Rail",
		tiles = {
			"mesecons_carts_digi_straight.png",
			"mesecons_carts_digi_curve.png",
			"mesecons_carts_digi_tjunction.png",
			"mesecons_carts_digi_crossing.png",
		},
		_digistuff_channelcopier_fieldname = "channel",
		after_place_node = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec","field[channel;Channel;${channel}")
			meta:set_string("channel","")
			meta:set_string("velocity",minetest.serialize(vector.new(0,0,0)))
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if not fields.channel then return end
			local name = sender:get_player_name()
			if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
				minetest.record_protection_violation(pos,name)
				return
			end
			minetest.get_meta(pos):set_string("channel",fields.channel)
		end,
		digiline = {
			wire = {
				rules = digilines_rules,
			},
			receptor = {},
			effector = {
				action = digilinesrail_handle_digilines,
			},
		},
		groups = carts:get_rail_groups(),
	}, {on_step = digilinesrail_onstep,})
	
	for i=1,15,1 do
		carts:register_rail("mesecons_carts:digilines_rail_pwr_"..i, {
			description = string.format("Digilines-Controlled Rail (powered, strength %d - you hacker you!)",i),
			tiles = {
				"mesecons_carts_digi_straight.png",
				"mesecons_carts_digi_curve.png",
				"mesecons_carts_digi_tjunction.png",
				"mesecons_carts_digi_crossing.png",
			},
			_digistuff_channelcopier_fieldname = "channel",
			drop = "mesecons_carts:digilines_rail_idle",
			after_place_node = function(pos)
				local meta = minetest.get_meta(pos)
				meta:set_string("formspec","field[channel;Channel;${channel}")
				meta:set_string("channel","")
				meta:set_string("velocity",minetest.serialize(vector.new(0,0,0)))
			end,
			on_receive_fields = function(pos, formname, fields, sender)
				if not fields.channel then return end
				local name = sender:get_player_name()
				if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
					minetest.record_protection_violation(pos,name)
					return
				end
				minetest.get_meta(pos):set_string("channel",fields.channel)
			end,
			digiline = {
				wire = {
					rules = digilines_rules,
				},
				receptor = {},
				effector = {
					action = digilinesrail_handle_digilines,
				},
			},
			groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
		}, {on_step = digilinesrail_onstep,acceleration = i,})
		carts:register_rail("mesecons_carts:digilines_rail_brk_"..i, {
			description = string.format("Digilines-Controlled Rail (brake, strength %d - you hacker you!)",i),
			tiles = {
				"mesecons_carts_digi_straight.png",
				"mesecons_carts_digi_curve.png",
				"mesecons_carts_digi_tjunction.png",
				"mesecons_carts_digi_crossing.png",
			},
			_digistuff_channelcopier_fieldname = "channel",
			drop = "mesecons_carts:digilines_rail_idle",
			after_place_node = function(pos)
				local meta = minetest.get_meta(pos)
				meta:set_string("formspec","field[channel;Channel;${channel}")
				meta:set_string("channel","")
				meta:set_string("velocity",minetest.serialize(vector.new(0,0,0)))
			end,
			on_receive_fields = function(pos, formname, fields, sender)
				if not fields.channel then return end
				local name = sender:get_player_name()
				if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
					minetest.record_protection_violation(pos,name)
					return
				end
				minetest.get_meta(pos):set_string("channel",fields.channel)
			end,
			digiline = {
				wire = {
					rules = digilines_rules,
				},
				receptor = {},
				effector = {
					action = digilinesrail_handle_digilines,
				},
			},
			groups = carts:get_rail_groups({not_in_creative_inventory = 1,}),
		}, {on_step = digilinesrail_onstep,acceleration = i*-1,})
	end
	minetest.register_craft({
		output = "mesecons_carts:digilines_rail_idle 3",
		recipe = {
			{"carts:rail","basic_materials:motor","",},
			{"carts:rail","mesecons_luacontroller:luacontroller0000","digilines:wire_std_00000000",},
			{"carts:rail","default:sand","",},
		},
	})
	minetest.register_craft({
		output = "mesecons_carts:digi_cond_rail 6",
		recipe = {
			{"carts:rail","digilines:wire_std_00000000","carts:rail",},
			{"carts:rail","digilines:wire_std_00000000","carts:rail",},
			{"carts:rail","digilines:wire_std_00000000","carts:rail",},
		},
	})
	minetest.register_craft({
		output = "mesecons_carts:mese_digi_cond_rail_off",
		type = "shapeless",
		recipe = {"mesecons_carts:mese_cond_rail_off","digilines:wire_std_00000000",},
	})
	minetest.register_craft({
		output = "mesecons_carts:mese_digi_cond_rail_off",
		type = "shapeless",
		recipe = {"mesecons_carts:digi_cond_rail","mesecons:wire_00000000_off",},
	})
end
