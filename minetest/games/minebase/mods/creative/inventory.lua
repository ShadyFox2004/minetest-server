-- creative/inventory.lua

-- support for Minebase translation.
local S = creative.get_translator

local player_inventory = {}
local inventory_cache = {}

local function init_creative_cache(items)
	inventory_cache[items] = {}
	local i_cache = inventory_cache[items]

	for name, def in pairs(items) do
		if def.groups.not_in_creative_inventory ~= 1 then 
			if not def.description or def.description == "" then
				print("warning", "The following item has no description: ", dump(def))
			end
			i_cache[name] = def
		end
	end
	table.sort(i_cache)
	return i_cache
end

local detached = {}
function detached.allow_move(_, _, _, to_list, _, count, player)
	local name = player and player:get_player_name() or ""
	if not creative.is_enabled(name) or to_list == "main" then
		return 0
	end
	return count
end

function detached.allow_put()
	return 0
end

function detached.allow_take(_, _, _, _, player)
	local name = player and player:get_player_name() or ""
	return not creative.is_enabled(name) and 0 or -1
end

function detached.on_move()
end

function creative.init_creative_inventory(player)
	local player_name = player:get_player_name()
	player_inventory[player_name] = {
		size = 0,
		filter = "",
		start_i = 0,
		old_filter = nil, -- use only for caching in update_creative_inventory
		old_content = nil
	}

	minetest.create_detached_inventory("creative_" .. player_name, detached, 
		player_name)

	return player_inventory[player_name]
end

local NO_MATCH = 999
function creative.match(s, filter)
	if filter == "" then
		return 0
	end
	if s:lower():find(filter, 1, true) then
		return #s - #filter
	end
	return NO_MATCH
end

function creative.description(def, lang_code)
	local s = def.description
	if lang_code then
		s = minetest.get_translated_string(lang_code, s)
	end
	return s:gsub("\n.*", "") -- First line only
end

function creative.update_creative_inventory(player_name, tab_content)
	local inv = player_inventory[player_name] or
			creative.init_creative_inventory(minetest.get_player_by_name(player_name))
	local player_inv = minetest.get_inventory({type = "detached", 
		name = "creative_" .. player_name})

	if inv.filter == inv.old_filter and tab_content == inv.old_content then
		return
	end
	inv.old_filter = inv.filter
	inv.old_content = tab_content

	local items = inventory_cache[tab_content] or init_creative_cache(tab_content)

	local lang
	local player_info = minetest.get_player_information(player_name)
	if player_info and player_info.lang_code ~= "" then
		lang = player_info.lang_code
	end

	local creative_list = {}
	local order = {}
	for name, def in pairs(items) do
		local m = creative.match(creative.description(def), inv.filter)
		if m > 0 then
			m = math.min(m, creative.match(creative.description(def, lang), 
				inv.filter))
		end
		if m > 0 then
			m = math.min(m, creative.match(name, inv.filter))
		end

		if m < NO_MATCH then
			creative_list[#creative_list+1] = name
			-- Sort by match value first so closer matches appear earlier
			order[name] = string.format("%02d", m) .. name
		end
	end

	table.sort(creative_list, function(a, b) return order[a] < order[b] end)

	player_inv:set_size("main", #creative_list)
	player_inv:set_list("main", creative_list)
	inv.size = #creative_list
end

-- Create the trash field
local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(_, _, _, stack)
		return stack:get_count()
	end,
	on_put = function(inv, listname)
		inv:set_list(listname, {})
	end,
})
trash:set_size("main", 1)

creative.formspec_add = ""

local tab = {}

function tab.is_in_nav(_, player)
	return creative.is_enabled(player:get_player_name())
end

function tab.get(player, context, items)
	local player_name = player:get_player_name()
	creative.update_creative_inventory(player_name, items)
	local inv = player_inventory[player_name]
	local pagenum = math.floor(inv.start_i / (4*8) + 1)
	local pagemax = math.ceil(inv.size / (4*8))
	local esc = minetest.formspec_escape
	return sfinv.make_formspec(player, context,
		table.concat({"label[6.2,4.15;", minetest.colorize("#FFFF00", 
			tostring(pagenum)),
				" / ", tostring(pagemax), "]",
			[[
				list[detached:creative_trash;main;4.02,4.1;1,1;]
				listring[]
				image_button[2.63,4.05;0.8,0.8;formspecs_search_icon.png;creative_search;]
				image_button[3.25,4.05;0.8,0.8;formspecs_clear_icon.png;creative_clear;]
				image_button[5,4.05;0.8,0.8;formspecs_prev_icon.png;creative_prev;]
				image_button[7.25,4.05;0.8,0.8;formspecs_next_icon.png;creative_next;]
			]],
			"tooltip[creative_search;", esc(S("Search")), "]",
			"tooltip[creative_clear;", esc(S("Reset")), "]",
			"tooltip[creative_prev;", esc(S("Previous page")), "]",
			"tooltip[creative_next;", esc(S("Next page")), "]",
			"listring[current_player;main]",
			"field_close_on_enter[creative_filter;false]",
			"field[0.3,4.2;2.8,1.2;creative_filter;;", esc(inv.filter), "]",
			"listring[detached:creative_", player_name, ";main]",
			"list[detached:creative_", player_name, ";main;0,0;8,4;",
			tostring(inv.start_i), "]", creative.formspec_add}), 
		true)
end

function tab.on_enter(_, player, context)
	local player_name = player:get_player_name()
	local inv = player_inventory[player_name]
	if inv then
		inv.start_i = 0
	end
end

function tab.on_player_receive_fields(_, player, context, fields)
	local player_name = player:get_player_name()
	local inv = player_inventory[player_name]
	assert(inv)

	if fields.creative_clear then
		inv.start_i = 0
		inv.filter = ""
		sfinv.set_player_inventory_formspec(player, context)
	elseif fields.creative_search or
			fields.key_enter_field == "creative_filter" then
		inv.start_i = 0
		inv.filter = fields.creative_filter:lower()
		sfinv.set_player_inventory_formspec(player, context)
	elseif not fields.quit then
		local start_i = inv.start_i or 0

		if fields.creative_prev then
			start_i = start_i - 4*8
			if start_i < 0 then
				start_i = inv.size - (inv.size % (4*8))
				if inv.size == start_i then
					start_i = math.max(0, inv.size - (4*8))
				end
			end
		elseif fields.creative_next then
			start_i = start_i + 4*8
			if start_i >= inv.size then
				start_i = 0
			end
		end

		inv.start_i = start_i
		sfinv.set_player_inventory_formspec(player, context)
	end
end

function creative.register_tab(name, def)
	sfinv.register_page(name, {
		title = def.title,
		is_in_nav = def.is_in_nav or tab.is_in_nav,
		get = def.get or function(_, player, context) 
			return tab.get(player, context, def.items)
		end,
		on_enter = def.on_enter or tab.on_enter,
		on_player_receive_fields = def.on_player_receive_fields 
			or tab.on_player_receive_fields
	})
end

-- Sort registered items
local registered_nodes = {}
local registered_tools = {}
local registered_craftitems = {}

minetest.register_on_mods_loaded(function()
	for name, def in pairs(minetest.registered_items) do
		local group = def.groups or {}

		local nogroup = not (group.node or group.tool or group.craftitem)
		if group.node or (nogroup and minetest.registered_nodes[name]) then
			registered_nodes[name] = def
		elseif group.tool or (nogroup and minetest.registered_tools[name]) then
			registered_tools[name] = def
		elseif group.craftitem or (nogroup and minetest.registered_craftitems[name]) then
			registered_craftitems[name] = def
		end
	end
end)

creative.register_tab("creative:all", {
	title = S("All"), 
	items = minetest.registered_items
})

creative.register_tab("creative:nodes", {
	title = S("Nodes"), 
	items = registered_nodes
})

creative.register_tab("creative:tools", {
	title = S("Tools"), 
	items = registered_tools
})

creative.register_tab("creative:craftitems", {
	title = S("Items"), 
	items = registered_craftitems
})

function creative.get_homepage_name(player)
	if creative.is_enabled(player:get_player_name()) then
		return "creative:all"
	else
		return sfinv.homepage
	end
end
