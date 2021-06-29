-- shelves/init.lua 

-- support for Minebase translation.
local S = minetest.get_translator("shelves")

local function update_bookshelf(pos)
	local meta = minetest.get_meta(pos)
	local invlist = meta:get_inventory():get_list("books")

	local sum_written, sum_empty = 0, 0
	for _, stack in ipairs(invlist) do
		local metatable = stack:get_meta():to_table() or {}
		if metatable.fields and metatable.fields.text then
			sum_written = sum_written + stack:get_count()
		else
			sum_empty = sum_empty + stack:get_count()
		end
	end
	if sum_written + sum_empty == 0 then
		meta:set_string("infotext", S("Empty Bookshelf"))
	else
		meta:set_string("infotext", S("Bookshelf (@1 written, @2 empty books)", 
			sum_written, sum_empty))
	end
end

containers.register_container("shelves:book", {
	closed = {
		description = S("Bookshelf"),
		tiles = {"base_trees_apple_wood.png", "base_trees_apple_wood.png", 
			"base_trees_apple_wood.png", "base_trees_apple_wood.png", 
			"shelves_book.png", "shelves_book.png"},
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		recipe = {
			{"group:wood", "group:wood", "group:wood"},
			{"base_books:book", "base_books:book", "base_books:book"},
			{"group:wood", "group:wood", "group:wood"},
		},
		allowed_item_group = "book",
		burntime = 30,
		formspec_def = {
			list1 = "books",
		},
		update = update_bookshelf
	}
})

local function update_vessels_shelf(pos)
	local meta = minetest.get_meta(pos)
	local invlist = meta:get_inventory():get_list("vessels")

	local sum = 0
	for _, stack in ipairs(invlist) do
		if not stack:is_empty() then
			sum = sum + stack:get_count()
		end
	end
	if sum == 0 then
		meta:set_string("infotext", S("Empty Vessels Shelf"))
	else
		meta:set_string("infotext", S("Vessels Shelf (@1 items)", sum))
	end
end

containers.register_container("shelves:vessels", {
	closed = {
		description = S("Vessels Shelf"),
		tiles = {"base_trees_apple_wood.png", "base_trees_apple_wood.png", 
			"base_trees_apple_wood.png", "base_trees_apple_wood.png", 
			"shelves_vessels.png", "shelves_vessels.png"},
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		allowed_item_group = "vessel",
		recipe = {
			{"group:wood", "group:wood", "group:wood"},
			{"group:vessel", "group:vessel", "group:vessel"},
			{"group:wood", "group:wood", "group:wood"},
		},
		burntime = 30,
		formspec_def = {
			list1 = "vessels",
		},
		update = update_vessels_shelf
	}
})

