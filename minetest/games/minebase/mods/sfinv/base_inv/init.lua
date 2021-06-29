-- base_inv/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("base_inv")

sfinv.register_page("base_inv:crafting", {
	title = S("Crafting"),
	get = function(self, player, context)
		return sfinv.make_formspec(player, context, [[
				list[current_player;craft;1.75,0.5;3,3;]
				list[current_player;craftpreview;5.75,1.5;1,1;]
				image[4.75,1.5;1,1;base_inv_crafting_arrow.png]
				listring[current_player;main]
				listring[current_player;craft]
			]], true)
	end,
	homepage = true
})
