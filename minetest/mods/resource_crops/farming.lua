-- Re-register wheat and cotton from the farming mod included in minetest-game so they grow.

--Cotton
farming.add_plant("farming:cotton_8", {"farming:cotton_2", "farming:cotton_4", "farming:cotton_6"})
minetest.override_item("farming:seed_cotton", {
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_2")
	end
})

--Wheat
farming.add_plant("farming:wheat_8", {"farming:wheat_2", "farming:wheat_4", "farming:wheat_6"})
minetest.override_item("farming:seed_wheat", {
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_2")
	end
})


minetest.register_abm({
  nodenames = {"farming:seed_cotton"},
  interval = 1,
  chance = 1,
  action = function(pos)
    minetest.set_node(pos, {name="farming:cotton_2"})
  end
})
minetest.register_abm({
  nodenames = {"farming:seed_wheat"},
  interval = 1,
  chance = 1,
  action = function(pos)
    minetest.set_node(pos, {name="farming:wheat_2"})
  end
})
