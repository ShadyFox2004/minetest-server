-- tools_api/init.lua

--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

tools = {}

function tools.register_pick(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_pick", {
		description = def.description or txt .. "_pick",
		inventory_image = def.inventory_image or txt .. "_pick.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.2,
			max_drop_level = 0,
			groupcaps = {
				cracky = {times = {3.2, 1.5, 0.9}, uses = 10, maxlevel = 1},
			},
			damage_groups = {fleshy = 2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = def.groups or {pickaxe = 1}
	})

	minetest.register_craft({
		output = name .. "_pick",
		recipe = {
			{def.material, def.material, def.material},
			{"", "group:stick", ""},
			{"", "group:stick", ""}
		}
	})
end

function tools.register_shovel(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_shovel", {
		description = def.description or txt .. "_shovel",
		inventory_image = def.inventory_image or txt .. "_shovel.png",
		wield_image = def.wield_image or txt .. "_shovel.png^[transformR90",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.2,
			max_drop_level = 0,
			groupcaps = {
				crumbly = {times = {1.7, 1.0, 0.4}, uses = 10, maxlevel = 1},
			},
			damage_groups = {fleshy = 2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = def.groups or {shovel = 1}
	})

	minetest.register_craft({
		output = name .. "_shovel",
		recipe = {
			{def.material},
			{"group:stick"},
			{"group:stick"}
		}
	})
end

function tools.register_axe(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .."_axe", {
		description = def.description or txt .. "_axe",
		inventory_image = def.inventory_image or txt .. "_axe.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				choppy = {times = {2.5, 1.7, 1.0}, uses = 10, maxlevel = 1},
			},
			damage_groups = {fleshy = 2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = {axe = 1}
	})

	minetest.register_craft({
		output = name .. "_axe",
		recipe = {
			{def.material, def.material},
			{def.material, "group:stick"},
			{"", "group:stick"}
		}
	})
end

function tools.register_sword(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_tool(name .. "_sword", {
		description = def.description or txt .. "_sword",
		inventory_image = def.inventory_image or txt .. "_sword.png",
		tool_capabilities = def.tool_capabilities or {
			full_punch_interval = 1,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times = {2.3, 1.2, 0.4}, uses = 10, maxlevel = 1},
			},
			damage_groups = {fleshy = 2},
		},
		sound = {breaks = "tools_api_breaks"},
		groups = {sword = 1}
	})

	minetest.register_craft({
		output = name .. "_sword",
		recipe = {
			{def.material},
			{def.material},
			{"group:stick"}
		}
	})
end

-- These functions enable users to create tool sets without understanding the 
-- mechanisms behind it.

local function set_capabilities(capabilities, values)
	capabilities.full_punch_interval = capabilities.full_punch_interval or values[1]
	capabilities.max_drop_level = capabilities.max_drop_level or values[2]
	capabilities.groupcaps = capabilities.groupcaps or values[3]
	capabilities.damage_groups = capabilities.damage_groups or values[4]
end

local function calc_capabilities(x, def)
	x = x >= -2 and x or -2
	local y = x + 9

	def.pick.tool_capabilities = def.pick.tool_capabilities or {}
	set_capabilities(def.pick.tool_capabilities, {
		9 / y, 
		3 + x, 
		{
			cracky = {times = {20 / y, 10 / y, 5 / y}, 
			uses = 3 * y, maxlevel = 3 + x}
		},
		{fleshy = 0.5 * y}
	})

	def.shovel.tool_capabilities = def.shovel.tool_capabilities or {}
	set_capabilities(def.shovel.tool_capabilities, {
		10 / y, 
		3 + x, 
		{
			crumbly = {times = {11 / y, 5 / y, 3 / y}, 
			uses = 3 * y, maxlevel = 3 + x}
		},
		{fleshy = 0.4 * y}
	})
	
	def.axe.tool_capabilities = def.axe.tool_capabilities or {}
	set_capabilities(def.axe.tool_capabilities, {
		9 / y, 
		1 + x, 
		{
			choppy = {times = {21 / y, 9 / y, 5 / y}, 
			uses = 3 * y, maxlevel = 3 + x}
		}, 
		{fleshy = 0.7 * y}
	})

	def.sword.tool_capabilities = def.sword.tool_capabilities or {}
	set_capabilities(def.sword.tool_capabilities, {
		7 / y,
		1 + x,
		{
			snappy = {times = {19 / y, 9 / y, 3 / y}, 
			uses = 4 * y, maxlevel = 3 + x}
		},
		{fleshy = 0.8 * y}
	})
end

function tools.register_set(name, def)
	if def.material then 
		def.pick.material = def.material
		def.shovel.material = def.material
		def.axe.material = def.material
		def.sword.material = def.material
	end

	if def.x then
		calc_capabilities(def.x, def)
	end

	tools.register_pick(name, def.pick)
	tools.register_shovel(name, def.shovel)
	tools.register_axe(name, def.axe)
	tools.register_sword(name, def.sword)
end
