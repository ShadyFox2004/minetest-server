-- formspecs/init.lua

formspecs = {listcolors = {
		slot_bg_normal = "#1E1E1E",
		slot_bg_hover = "#323232", 
		slot_border = "#141414", 
		tooltip_bgcolor = "#3C3C3C", 
		tooltip_fontcolor = "#FFFFFF"
	},
}

function formspecs.create_listcolors(lc)
	return "bgcolor[#080808BB;true]" 
		.. "listcolors[" .. lc.slot_bg_normal .. ";" .. lc.slot_bg_hover .. ";" 
		.. lc.slot_border .. ";" .. lc.tooltip_bgcolor .. ";" 
		.. lc.tooltip_fontcolor .. "]"
end

formspecs.listcolorsString = formspecs.create_listcolors(formspecs.listcolors)
function formspecs.create_prepend(player, lc)
	local formspec = lc and formspecs.create_listcolors(lc) 
		or formspecs.listcolorsString

	if minetest.get_player_information(player:get_player_name())
		.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;formspecs_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;formspecs_formbg.png;true]"
	end
	return formspec
end

minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
	player:set_formspec_prepend(formspecs.create_prepend(player))

	-- Set hotbar textures
	player:hud_set_hotbar_image("formspecs_hotbar.png")
	player:hud_set_hotbar_selected_image("formspecs_hotbar_selected.png")
end)

function formspecs.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .. "image[" .. x + i .. "," .. y .. ";1,1;formspecs_hb_bg.png]"
	end
	return out
end

formspecs.gui_survival_form = "size[8,8.5]" 
	.. "list[current_player;main;0,4.25;8,1;]" 
	.. "list[current_player;main;0,5.5;8,3;8]" 
	.. "list[current_player;craft;1.75,0.5;3,3;]" 
	.. "list[current_player;craftpreview;5.75,1.5;1,1;]" 
	.. "image[4.75,1.5;1,1;formspecs_arrow_bg.png^[transformR270]"
	.. "listring[current_player;main]"
	.. "listring[current_player;craft]"
	.. formspecs.get_hotbar_bg(0,4.25)
