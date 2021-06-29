-- books_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_books")

books = {form = {}}

function books.get_lines(text)
	local lines = {}
	for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
		lines[#lines+1] = str
	end
	return lines
end

local lpp = 14 -- Lines per book's page
function books.page_content(data)
	local lines = books.get_lines(data.text)
	return table.concat(lines, "\n", ((lpp * data.page) - lpp) + 1, 
		math.min(lpp * data.page, #lines)) .. "\n"
end

function books.create_formspec(player_name, data)
	local title, text, owner = "", "", player_name
	local page, page_max, string = 1, 1, ""

	if data.owner then
		title = data.title
		text = data.text
		owner = data.owner

		if data.page then
			page = data.page
			page_max = data.page_max
			string = books.page_content(data)
		end
	end

	local esc = minetest.formspec_escape
	if owner == player_name then
		return table.concat({"size[8,8]",
			"field[0.5,1;7.5,0;title;",  esc(S("Title:")), ";", esc(title), "]",
			"textarea[0.5,1.5;7.5,7;text;", esc(S("Contents:")), ";", esc(text), "]",
			"button_exit[2.5,7.5;3,1;save;", esc(S("Save")), "]"})
	else
		return table.concat({"size[8,8]",
			"label[0.5,0.5;", esc(S("by @1", owner)), "]",
			"tablecolumns[color;text]",
			"tableoptions[background=#00000000;highlight=#00000000;border=false]",
			"table[0.4,0;7,0.5;title;#FFFF00,", esc(title), "]",
			"textarea[0.5,1.5;7.5,7;;",
				minetest.formspec_escape(string ~= "" and string or text), ";]",
			"image_button[2.3,7.6;0.9,0.9;formspecs_prev_icon.png;book_prev;]",
			"label[3.2,7.7;", esc(S("Page @1 of @2", page, page_max)), "]",
			"image_button[4.9,7.6;0.9,0.9;formspecs_next_icon.png;book_next;]"})
	end
end

function books.on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()

	-- Backwards compatibility
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local formspec = books.create_formspec(player_name, meta:to_table().fields)

	local name = itemstack:get_name()
	name = name:sub(-8) == "_written" and name:sub(1, -9) or name
	minetest.show_formspec(player_name, name, formspec)
	return itemstack
end

function books.turn_page(to_right, page_no, page_max)
	if to_right then
		return page_no < page_max and page_no + 1 or 1
	else
		return page_no > 1 and page_no - 1 or page_max
	end
end

local max_text_size = 10000
local max_title_size = 80
local short_title_size = 35
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if not books.form[formname] then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.save and fields.title and fields.text
			and fields.title ~= "" and fields.text ~= "" then
		local new_stack, data
		if stack:get_name() ~= formname .. "_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name(formname .. "_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack(formname .. "_written")
			end
		else
			data = stack:get_meta():to_table().fields
		end

		if data and data.owner and data.owner ~= player:get_player_name() then
			return
		end

		data = data or {}
		data.title = fields.title:sub(1, max_title_size)
		data.owner = player:get_player_name()
		local short_title = data.title
		-- Don't bother triming the title if the trailing dots would make it longer
		if #short_title > short_title_size + 3 then
			short_title = short_title:sub(1, short_title_size) .. "..."
		end
		data.description = S("\"@1\" by @2", short_title, data.owner)
		data.text = fields.text:sub(1, max_text_size)
		data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

		if new_stack then
			new_stack:get_meta():from_table({ fields = data })
			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(player:get_pos(), new_stack)
			end
		else
			stack:get_meta():from_table({ fields = data })
		end

	elseif fields.book_next or fields.book_prev then
		local data = stack:get_meta():to_table().fields
		if not data or not data.page then
			return
		end

		data.page = books.turn_page(fields.book_next, tonumber(data.page), 
			tonumber(data.page_max))

		stack:get_meta():from_table({fields = data})
		stack = books.on_use(stack, player)
	end

	-- Update stack
	player:set_wielded_item(stack)
end)

function books.register_book(name, def)
	local txt = name:gsub(":", "_")
	minetest.register_craftitem(name, {
		description = def.description or txt,
		short_description = def.short_description,
		groups = def.groups or {book = 1, flammable = 3, 
			not_in_creative_inventory = def.not_in_creative_inventory},
		inventory_image = def.inventory_image or txt .. ".png",
		inventory_overlay = def.inventory_overlay,
		wield_image = def.wield_image or txt .. ".png",
		wield_overlay = def.wield_overlay,
		palette = def.palette,
		color = def.color,
		wield_scale = def.wield_scale,
		stack_max = def.stack_max,
		range = def.range,
		node_placement_prediction = def.node_placement_prediction,
		sound = def.sound,
		on_use = def.on_use or books.on_use,
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
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

function books.register_book_set(name, def)
	local txt = name:gsub(":", "_")
	books.register_book(name, def.new)
	books.form[name] = true 
	
	if def.written then
		def.written.stack_max = def.written.stack_max or 1
		def.written.not_in_creative_inventory = 1
		books.register_book(name .. "_written", def.written)
		craft.register_craft_metadata_copy(name, name .. "_written")
	end
end
