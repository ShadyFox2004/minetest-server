--Essence ore
if resourcecrops.settings.essence_ore then
minetest.register_node("resource_crops:essence_ore", {
	description = "Essence Ore",
	tiles = {"default_stone.png^resource_crops_essence_ore.png"},
	groups = {cracky = 2},
	drop = "resource_crops:essence_dust",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_ore({
	ore_type         = "scatter",
	ore              = "resource_crops:essence_ore",
	wherein          = "default:stone",
	clust_scarcity   = 10*10*10,
	clust_num_ores   = 4,
	clust_size       = 4,
	y_min            = -5000,
	y_max            = -5,
})
end

--Essence harvester
if resourcecrops.settings.essence_harvester then
minetest.register_node("resource_crops:essence_harvester", {
	description = "Essence Harvester",
	tiles = {"resource_crops_essence_harvester.png", "resource_crops_essence_harvester_bottom.png",
             "resource_crops_essence_harvester.png", "resource_crops_essence_harvester.png",
             "resource_crops_essence_harvester.png", "resource_crops_essence_harvester.png"},
    light_source = 10,
	groups = {cracky = 2},
})
minetest.register_craft({
	output = "resource_crops:essence_harvester",
	recipe = {
		{"default:diamond", "default:steel_ingot", "default:diamond"},
		{"default:steel_ingot", "resource_crops:essence_block", "default:steel_ingot"},
		{"default:diamond", "default:steel_ingot", "default:diamond"}
	}
})
minetest.register_abm({
    nodenames = {"resource_crops:essence_harvester"},
    neighbors = {"group:resourceplant"},
    interval = 5,
    chance = 1,
    action = function(pos)
		pos.y = pos.y - 1
		local plant = minetest.get_node(pos)
        local plant_pos = pos
        
		if resourcecrops.check_crop_node(pos) then
			resourcecrops.harvest_crop(pos)
		end
	end,
})
end

--Punch crop to harvest it.
if resourcecrops.settings.punch_harvest then
minetest.register_on_punchnode(function(pos)
    if resourcecrops.check_crop_node(pos) then
		resourcecrops.harvest_crop(pos)
	end
end)
end

minetest.register_alias_force("resourcecrops:essence_harvester", "resource_crops:essence_harvester")
