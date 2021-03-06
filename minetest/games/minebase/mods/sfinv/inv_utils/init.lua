-- inv_utils/init.lua

inv_utils = {}

function inv_utils.get_inventory_drops(pos, listname, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(listname) do
		local stack = inv:get_stack(listname, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

