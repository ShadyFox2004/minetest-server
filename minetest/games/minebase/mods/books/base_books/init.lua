-- base_books/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_books")

books.register_book_set("base_books:book", {
	new = {
		description = S("Book"),
		recipe = {
			{"base_books:paper"},
			{"base_books:paper"},
			{"base_books:paper"},
		},
		burntime = 3
	},
	written = {
		description = S("Book with Text"),
		burntime = 3
	}
})

minetest.register_craftitem("base_books:paper", {
	description = S("Paper"),
	inventory_image = "base_books_paper.png",
	groups = {flammable = 3},
})

minetest.register_craft({
	output = "base_books:paper",
	recipe = {
		{"base_grasses:papyrus", "base_grasses:papyrus", "base_grasses:papyrus"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "base_books:paper",
	burntime = 1,
})

