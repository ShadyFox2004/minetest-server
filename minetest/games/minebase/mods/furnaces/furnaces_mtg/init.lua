-- furnace_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("furnace", "base_furnaces:furnace")

minetest.register_alias("default:furnace", "base_furnaces:furnace")
minetest.register_alias("default:furnace_active", 
	"base_furnaces:furnace_active")

minetest.register_lbm({
	name = "furnaces_mtg:furnace",
	nodenames = {"base_furnaces:furnace"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", furnaces.inactive_formspec)
	end
})

