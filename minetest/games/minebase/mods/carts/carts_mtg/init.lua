-- carts_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("rail", "base_rails:rail")
minetest.register_alias("default:rail", "base_rails:rail")


-- Aliases for Mintest Game carts mod
minetest.register_alias("carts:rail", "base_rails:rail")
minetest.register_alias("carts:powerrail", "base_rails:powerrail")
minetest.register_alias("carts:brakerail", "base_rails:brakerail")
minetest.register_alias("carts:cart", "base_carts:cart")

minetest.register_entity(":carts:cart", {
	on_activate = function (entity, staticdata)
		minetest.add_entity(entity.object:get_pos(), "base_carts:cart", staticdata)
		entity.object:remove()
	end
})
