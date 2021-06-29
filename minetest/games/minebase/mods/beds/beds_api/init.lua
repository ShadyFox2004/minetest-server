-- beds_api/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("beds_api")
local esc = minetest.formspec_escape

beds = {}
beds.player = {}
beds.bed_position = {}
beds.pos = {}
beds.spawn = {}
beds.get_translator = S

beds.formspec = "size[8,11;true]" ..
	"no_prepend[]" ..
	"bgcolor[#080808BB;true]" ..
	"button_exit[2,10;4,0.75;leave;" .. esc(S("Leave Bed")) .. "]"

local modpath = minetest.get_modpath("beds_api")

-- Load files

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/spawns.lua")
