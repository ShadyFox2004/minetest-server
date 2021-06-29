-- furnaces_api/init.lua

local S = minetest.get_translator("furnaces_api")

furnaces = {}

local function register_furnace(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_node(name .. (def.sub or ""), {
		description = def.description or txt,
		tiles = def.tiles or {
			txt .. "_top.png", txt .. "_bottom.png",
			txt .. "_side.png", txt .. "_side.png",
			txt .. "_side.png", txt .. "_front.png"
		},
		paramtype = def.paramtype,
		paramtype2 = def.paramtype2 or "facedir",
		groups = def.groups or {cracky=2},
		legacy_facedir_simple = true,
		is_ground_content = false,
		drop = def.drop,
		light_source = def.light_source,
		sounds = def.sounds or sounds.get_defaults("earth_sounds:stone"),

		on_construct = def.on_construct or furnaces.on_construct,
		can_dig = def.can_dig or furnaces.can_dig,

		on_timer = def.on_timer or furnaces.node_timer,

		on_metadata_inventory_move = def.on_metadata_inventory_move or furnaces
			.on_metadata_inventory_move,
		on_metadata_inventory_put = def.on_metadata_inventory_put or furnaces
			.on_metadata_inventory_put,
		on_metadata_inventory_take = def.on_metadata_inventory_take or furnaces
			.on_metadata_inventory_take,
		on_blast = def.on_blast or furnaces.on_blast,

		allow_metadata_inventory_put = def.allow_metadata_inventory_put 
			or furnaces.allow_metadata_inventory_put,
		allow_metadata_inventory_move = def.allow_metadata_inventory_move 
			or furnaces.allow_metadata_inventory_move,
		allow_metadata_inventory_take = def.allow_metadata_inventory_take 
			or furnaces.allow_metadata_inventory_take,

		infotext = def.infotext or txt .. (def.sub or ""),
		sunlight_propagates = def.sunlight_propagates,
		walkable = boolean.qq(def.walkable, true),
		damage_per_second = def.damage_per_second,
		collision_box = def.collision_box,
		selection_box = def.selection_box,
		floodable = def.floodable or false,
		on_destruct = def.on_destruct,
		after_destruct = def.after_destruct,
		on_flood = def.on_flood,
		preserve_metadata = def.preserve_metadata,
		after_place_node = def.after_place_node,
		after_dig_node = def.after_dig_node,
		on_punch = def.on_punch,
		on_dig = def.on_dig,

		_active = name .. "_active",
		_inactive = name
	})

	if def.recipe then
		minetest.register_craft({
			output = name .. (def.sub or ""),
			recipe = def.recipe
		})
	end
end

function furnaces.register_furnace(name, def)
	register_furnace(name, def.inactive)

	if def.active then
		local active = def.active
		local txt = name:gsub(":", "_")

		active.tiles = active.tiles or {
			txt .. "_top.png", txt .. "_bottom.png",
			txt .. "_side.png", txt .. "_side.png",
			txt .. "_side.png",
			{
				image = txt .. "_front_active.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 1.5
				},
			}
		}
		active.light_source = active.light_source or 8
		active.drop = name
		active.groups = active.groups or {cracky = 2, not_in_creative_inventory = 1}
		active.sub = "_active"
		register_furnace(name, active)
	end
end

function furnaces.get_active_formspec(fuel_percent, item_percent)
	return table.concat({"size[8,8.5]",
		"list[context;src;2.75,0.5;1,1;]",
		"list[context;fuel;2.75,2.5;1,1;]",
		"image[2.75,1.5;1,1;furnaces_api_fire_bg.png^[lowpart:",
		(fuel_percent), ":furnaces_api_fire_fg.png]",
		"image[3.75,1.5;1,1;formspecs_arrow_bg.png^[lowpart:",
		(item_percent), ":formspecs_arrow_fg.png^[transformR270]",
		"list[context;dst;4.75,0.96;2,2;]",
		"list[current_player;main;0,4.25;8,1;]",
		"list[current_player;main;0,5.5;8,3;8]",
		"listring[context;dst]",
		"listring[current_player;main]",
		"listring[context;src]",
		"listring[current_player;main]",
		"listring[context;fuel]",
		"listring[current_player;main]",
		formspecs.get_hotbar_bg(0, 4.25)})
end

furnaces.inactive_formspec = "size[8,8.5]"
	.. "list[context;src;2.75,0.5;1,1;]"
	.. "list[context;fuel;2.75,2.5;1,1;]"
	.. "image[2.75,1.5;1,1;furnaces_api_fire_bg.png]"
	.. "image[3.75,1.5;1,1;formspecs_arrow_bg.png^[transformR270]"
	.. "list[context;dst;4.75,0.96;2,2;]"
	.. "list[current_player;main;0,4.25;8,1;]"
	.. "list[current_player;main;0,5.5;8,3;8]"
	.. "listring[context;dst]"
	.. "listring[current_player;main]"
	.. "listring[context;src]"
	.. "listring[current_player;main]"
	.. "listring[context;fuel]"
	.. "listring[current_player;main]"
	.. formspecs.get_hotbar_bg(0, 4.25)

function furnaces.can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

function furnaces.allow_metadata_inventory_put(pos, listname, _, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}})
			.time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", S("Empty"))
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

function furnaces.allow_metadata_inventory_move(pos, from_list, from_index, 
	to_list, to_index, _, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return furnaces.allow_metadata_inventory_put(pos, to_list, to_index, stack, 
		player)
end

function furnaces.allow_metadata_inventory_take(pos, _, _, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

function furnaces.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size('src', 1)
	inv:set_size('fuel', 1)
	inv:set_size('dst', 4)
	furnaces.node_timer(pos, 0)
end

function furnaces.on_metadata_inventory_move(pos)
	return minetest.get_node_timer(pos):start(1.0)
end

function furnaces.on_metadata_inventory_put(pos)
	-- start timer function, it will sort out whether furnace can burn or not.
	return minetest.get_node_timer(pos):start(1.0)
end

function furnaces.on_metadata_inventory_take(pos)
	-- check whether the furnace is empty or not.
	return minetest.get_node_timer(pos):start(1.0)
end

function furnaces.on_blast(pos)
	local drops = {}
	inv_utils.get_inventory_drops(pos, "src", drops)
	inv_utils.get_inventory_drops(pos, "fuel", drops)
	inv_utils.get_inventory_drops(pos, "dst", drops)
	drops[#drops+1] = minetest.registered_nodes[minetest.get_node(pos).name]
		._inactive
	minetest.remove_node(pos)
	return drops
end

function furnaces.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

function furnaces.node_timer(pos, elapsed)
	--
	-- Initialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local cookable, cooked
	local fuel

	local update = true
	while elapsed > 0 and update do
		update = false

		srclist = inv:get_list("src")
		fuellist = inv:get_list("fuel")

		--
		-- Cooking
		--

		-- Check if we have cookable content
		local aftercooked
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", 
			width = 1, items = srclist})
		cookable = cooked.time ~= 0

		local el = math.min(elapsed, fuel_totaltime - fuel_time)
		if cookable then -- fuel lasts long enough, adjust el to cooking duration
			el = math.min(el, cooked.time - src_time)
		end

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + el
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + el
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)
						inv:set_stack("src", 1, aftercooked.items[1])
						src_time = src_time - cooked.time
						update = true
					else
						dst_full = true
					end
					-- Play cooling sound
					minetest.sound_play("base_liquids_cool_lava",
						{pos = pos, max_hear_distance = 16, gain = 0.1}, true)
				else
					-- Item could not be cooked: probably missing fuel
					update = true
				end
			end
		else
			-- Furnace ran out of fuel
			if cookable then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- Take fuel from fuel list
					inv:set_stack("fuel", 1, afterfuel.items[1])
					-- Put replacements in dst list or drop them on the furnace.
					local replacements = fuel.replacements
					if replacements[1] then
						local leftover = inv:add_item("dst", replacements[1])
						if not leftover:is_empty() then
							local above = vector.new(pos.x, pos.y + 1, pos.z)
							local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above
							minetest.item_drop(replacements[1], nil, drop_pos)
						end
					end
					update = true
					fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = elapsed - el
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end
	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		if dst_full then
			item_state = S("100% (output full)")
		else
			item_state = S("@1%", item_percent)
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = S("Not cookable")
		else
			item_state = S("Empty")
		end
	end

	local fuel_state = S("Empty")
	local active = false
	local result = false
	local node_def = minetest.registered_nodes[minetest.get_node(pos).name]

	if fuel_totaltime ~= 0 then
		active = true
		local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = S("@1%", fuel_percent)
		formspec = furnaces.get_active_formspec(fuel_percent, item_percent)
		furnaces.swap_node(pos, node_def._active)
		-- make sure timer restarts automatically
		result = true

		-- Play sound every 5 seconds while the furnace is active
		if timer_elapsed == 0 or (timer_elapsed+1) % 5 == 0 then
			minetest.sound_play("furnaces_api_active",
				{pos = pos, max_hear_distance = 16, gain = 0.5}, true)
		end
	else
		if fuellist and not fuellist[1]:is_empty() then
			fuel_state = S("@1%", 0)
		end
		formspec = furnaces.inactive_formspec
		furnaces.swap_node(pos, node_def._inactive)
		-- stop timer on the inactive furnace
		minetest.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)
	end


	local infotext = node_def.infotext .. "\n" .. S("(Item: @1; Fuel: @2)", 
		item_state, fuel_state)

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end
