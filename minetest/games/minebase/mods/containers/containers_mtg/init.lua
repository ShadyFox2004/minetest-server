-- containers/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("chest", "chests:common")
minetest.register_alias("locked_chest", "chests:common_locked")
minetest.register_alias("bookshelf", "shelves:book")


minetest.register_alias("default:chest", "chests:common")
minetest.register_alias("default:chest_locked", "chests:common_locked")
minetest.register_alias("default:bookshelf", "shelves:book")
minetest.register_alias("vessels:shelf", "shelves:vessels")

minetest.register_lbm({
	name = "containers_mtg:shelves",
	nodenames = {"bones:bones", "shelves:book", "shelves:vessels"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","")
		local inv = minetest.get_meta(pos):get_inventory()
		local node_def = minetest.registered_nodes[node.name]
		inv:set_size(node_def._formspec_def and node_def._formspec_def.list1 or 
			"main", 32)
	end
})

