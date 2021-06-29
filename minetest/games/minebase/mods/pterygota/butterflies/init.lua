-- butterflies/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("butterflies")

-- register butterflies
local butter_list = {
	{"white",  S("White Butterfly")},
	{"red",    S("Red Butterfly")},
	{"violet", S("Violet Butterfly")}
}

for i in ipairs (butter_list) do
	local desc = butter_list[i][2]

	pterygota.register_pterygota("butterflies:butterfly_" .. butter_list[i][1], {
		visible = {description = desc, pointable = true},
		hidden = {description = desc}
	})
end

-- register decoration
pterygota.register_deco("butterflies:butterfly", {
	place_on = {"base_earth:dirt_with_grass"},
	biomes = {"base_biomes:grassland", "base_biomes:deciduous_forest"},
	decoration = {
		"butterflies:butterfly_white",
		"butterflies:butterfly_red",
		"butterflies:butterfly_violet"
	},
	spawn_by = "group:flower",
	num_spawn_by = 1
})

