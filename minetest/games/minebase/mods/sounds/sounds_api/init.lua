-- sounds_api/init.lua

sounds = {defaults={}}

function sounds.register_defaults(name, def)
	sounds.defaults[name] = {
		footstep = def.footstep or {name = "", gain = 1.0},
		dug = def.dug or {name = "sounds_api_dug_node", gain = 0.25},
		place = def.place or {name = "sounds_api_place_node_hard", gain = 1.0},
		dig = def.dig
	}
end

function sounds.get_defaults(name, tab)
	tab = tab or {}
	if sounds.defaults[name] then
		for key, val in pairs(sounds.defaults[name]) do
			tab[key] = tab[key] or table.copy(val)
			minetest.sound_play(name, tab[key])
		end
	else
		print("No sound defaults:", name)
	end
	return tab
end

sounds.register_defaults("default", {})

