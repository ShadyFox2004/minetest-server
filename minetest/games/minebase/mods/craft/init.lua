-- craft/init.lua 

craft = {}

function craft.register_craft14(one, four)
	minetest.register_craft({
		output = four .. " 4",
		recipe = {{one}}
	})

	minetest.register_craft({
		output = one,
		recipe = {
			{four, four},
			{four, four},
		}
	})
end

function craft.register_craft44(four1, four2)
	minetest.register_craft({
		output = four1 .. " 4",
		recipe = {
			{four2, four2},
			{four2, four2}
		}
	})

	minetest.register_craft({
		output = four2 .. " 4",
		recipe = {
			{four1, four1},
			{four1, four1}
		}
	})
end

function craft.register_craft19(one, nine)
	minetest.register_craft({
		output = nine .. " 9",
		recipe = {{one}}
	})

	minetest.register_craft({
		output = one,
		recipe = {
			{nine, nine, nine},
			{nine, nine, nine},
			{nine, nine, nine},
		}
	})
end

function craft.register_craft99(nine1, nine2)
	minetest.register_craft({
		output = nine2 .. " 9",
		recipe = {
			{nine1, nine1, nine1},
			{nine1, nine1, nine1},
			{nine1, nine1, nine1},
		}
	})

	minetest.register_craft({
		output = nine1 .. " 9",
		recipe = {
			{nine2, nine2, nine2},
			{nine2, nine2, nine2},
			{nine2, nine2, nine2},
		}
	})
end

function craft.horizontal_half(part, result)
	minetest.register_craft({
		output = result,
		recipe = {
			{part, part, part},
		},
	})
end

function craft.side_by_side(one, two, result)
	if not result then
		result = two
		two = one
	end
	minetest.register_craft({
		output = result,
		recipe = {
			{one, two},
		},
	})
end

function craft.stacked(one, two, result)
	if not result then
		result = two
		two = one
	end
	minetest.register_craft({
		output = result,
		recipe = {
			{two},
			{one}
		},
	})
end

local metadata_copy = {}
minetest.register_on_craft(function(itemstack, _, old_craft_grid, craft_inv)
	local result = itemstack:get_name()
	if not metadata_copy[result] then
		return
	end

	local original
	local index
	for i = 1, #old_craft_grid do
		if old_craft_grid[i]:get_name() == result then
			original = old_craft_grid[i]
			index = i
		end
	end
	if not original then
		return
	end
	itemstack:get_meta():from_table(original:get_meta():to_table())
	craft_inv:set_stack("craft", index, original)
end)

function craft.register_craft_metadata_copy(ingredient, result)
	metadata_copy[result] = true
	minetest.register_craft({
		type = "shapeless",
		output = result,
		recipe = {ingredient, result}
	})
end
