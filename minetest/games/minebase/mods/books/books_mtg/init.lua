-- books_mtg/init.lua 

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("paper", "base_books:paper")
minetest.register_alias("book", "base_books:book")

minetest.register_alias("default:paper", "base_books:paper")
minetest.register_alias("default:book", "base_books:book")
minetest.register_alias("default:book_written", "base_books:book_written")
