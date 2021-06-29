-- initial_stuff_api/init.lua

initial_stuff = {
	items = {}
}

function initial_stuff.give(player)
	local inv = player:get_inventory()
	for _, stack in ipairs(initial_stuff.items) do
		inv:add_item("main", stack)
	end
end

function initial_stuff.add(stack)
	initial_stuff.items[#initial_stuff.items + 1] = ItemStack(stack)
end

function initial_stuff.clear()
	initial_stuff.items = {}
end

function initial_stuff.add_from_csv(str)
	local items = str:split(",")
	for _, itemname in ipairs(items) do
		initial_stuff.add(itemname)
	end
end

if minetest.settings:get_bool("initial_stuff") then
	minetest.register_on_newplayer(initial_stuff.give)
end
