-- dye/init.lua

dye = {}

-- Load support for Minebase translation.
local S = minetest.get_translator("dye")

-- Make dye names and descriptions available globally

dye.dyes = {
	{"white",      "White"},
	{"grey",       "Grey"},
	{"dark_grey",  "Dark Grey"},
	{"black",      "Black"},
	{"violet",     "Violet"},
	{"blue",       "Blue"},
	{"cyan",       "Cyan"},
	{"dark_green", "Dark Green"},
	{"green",      "Green"},
	{"yellow",     "Yellow"},
	{"brown",      "Brown"},
	{"orange",     "Orange"},
	{"red",        "Red"},
	{"magenta",    "Magenta"},
	{"pink",       "Pink"},
}

-- Define items
for _, row in ipairs(dye.dyes) do
	dyes.register_dye("dye:" .. row[1], {
		description = S(row[2] .. " Dye"),
	})
end



-- Manually add coal -> black dye

minetest.register_craft({
	output = "dye:black 4",
	recipe = {
		{"group:coal"}
	},
})

-- Manually add blueberries->violet dye

minetest.register_craft({
	output = "dye:violet 2",
	recipe = {
		{"base_bushes:blueberries"}
	},
})

-- Mix recipes

local dye_recipes = {
	-- src1, src2, dst
	-- RYB mixes
	{"red", "blue", "violet"}, -- "purple"
	{"yellow", "red", "orange"},
	{"yellow", "blue", "green"},
	-- RYB complementary mixes
	{"yellow", "violet", "dark_grey"},
	{"blue", "orange", "dark_grey"},
	-- CMY mixes - approximation
	{"cyan", "yellow", "green"},
	{"cyan", "magenta", "blue"},
	{"yellow", "magenta", "red"},
	-- other mixes that result in a color we have
	{"red", "green", "brown"},
	{"magenta", "blue", "violet"},
	{"green", "blue", "cyan"},
	{"pink", "violet", "magenta"},
	-- mixes with black
	{"white", "black", "grey"},
	{"grey", "black", "dark_grey"},
	{"green", "black", "dark_green"},
	{"orange", "black", "brown"},
	-- mixes with white
	{"white", "red", "pink"},
	{"white", "dark_grey", "grey"},
	{"white", "dark_green", "green"},
}

for _, mix in pairs(dye_recipes) do
	minetest.register_craft({
		type = "shapeless",
		output = "dye:" .. mix[3] .. " 2",
		recipe = {"dye:" .. mix[1], "dye:" .. mix[2]},
	})
end

