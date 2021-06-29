--Register an alias for steel ingot and undo technic's name change.
minetest.register_alias("default:iron_ingot", "default:steel_ingot")
if resourcecrops.has_technic then
minetest.override_item("default:iron_ingot", { description = "Steel Ingot" })
end

--Harvest and replant a crop, drop it's items.
function resourcecrops.harvest_crop(pos)
	local plant = minetest.get_node(pos)
	local plant_type = plant.name:gsub("resource_crops:", ""):gsub("crop", "")
	local crop_essence
	if plant_type == "essence" then
		crop_essence = "resource_crops:essence_dust"
	end
	if plant_type ~= "essence" then
		crop_essence = "resource_crops:"..plant_type.."_essence"
	end
	minetest.set_node(pos, {name=plant.name.."_1"})
	local itemstacks = minetest.get_node_drops(plant.name)
	for _, itemname in ipairs(itemstacks) do
		minetest.add_item(pos, itemname)
	end
end

--Check if the node is a crop. true/false.
function resourcecrops.check_crop_node(pos)
	local node = minetest.get_node(pos)
	local node_names = {}
	for str in string.gmatch(node.name, "([^:]+)") do
		table.insert(node_names, str)
	end
	local node_mod = node_names[1]
	local node_name = node_names[2]
	if node_mod == "resource_crops" then
		if string.sub(node_name, -4) == "crop" then
			return true
		else
			return false
		end
    else
        return false
	end
end

--Rewrite the farming mod's add plant function.
function farming.add_plant(full_grown, names)
	local interval = resourcecrops.settings.growth_interval
	local chance = resourcecrops.settings.growth_chance
	local all_names = names
	table.insert(all_names, full_grown)
	minetest.register_abm({
		nodenames = all_names,
		interval = 1,
		chance = 1,
		action = function(pos)
			local plant = minetest.get_node(pos)
			pos.y = pos.y - 1
			local under = minetest.get_node(pos)
			pos.y = pos.y + 1
			if under.name == "air" then
				local plant_type = plant.name:gsub("resource_crops:", ""):gsub("crop", "")
				if string.sub(string.sub(plant_type, -2), 0, 1) ~= "_" then
					resourcecropsharvest_crop()
				end
				minetest.remove_node(pos)
			end
		end,
	})

	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.get_node_light(pos) then
				return
			end
			if minetest.get_node_light(pos) < 8 then
				return
			end
			local step = nil
			for i,name in ipairs(names) do
				if name == node.name then
					step = i
					break
				end
			end
			if step == nil then
				return
			end
			local new_node = {name=names[step+1]}
			if new_node.name == nil then
				new_node.name = full_grown
			end
			minetest.set_node(pos, new_node)
		end
	})

	table.insert(farming.registered_plants, {
		full_grown = full_grown,
		names = names,
		interval = interval,
		chance = chance,
	})
end


--Start a plant when seed is placed.
function farming.place_seed(itemstack, placer, pointed_thing, plantname)
	-- Call on_rightclick if the pointed node defines it
	if pointed_thing.type == "node" and placer and
		not placer:get_player_control().sneak then
		local n = minetest.get_node(pointed_thing.under)
		local nn = n.name
		if minetest.registered_nodes[nn] and minetest.registered_nodes[nn].on_rightclick then
			return minetest.registered_nodes[nn].on_rightclick(pointed_thing.under, n,
			placer, itemstack, pointed_thing) or itemstack, false
		end
	end

	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name=plantname, param2 = 1})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end


--Add a resource crop.
function resourcecrops.add_crop(visible_name, resource_name, essence_type, recipe_input, recipe_output)
	--Seed
	minetest.register_craftitem("resource_crops:"..resource_name.."_seed", {
		description = (visible_name.." Seeds"),
		inventory_image = "resource_crops_"..resource_name.."_seed.png",
		groups = {essence_seed = 1},
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, "resource_crops:"..resource_name.."crop_1")
		end
	})

	--Crop Step 1
	minetest.register_node("resource_crops:"..resource_name.."crop_1", {
		paramtype = "light",
		walkable = false,
		drawtype = "plantlike",
		drop = "",
		tiles = {"resource_crops_crop_1.png"},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
			},
		},
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
		sounds = default.node_sound_leaves_defaults(),
	})

	--Crop Step 2
	minetest.register_node("resource_crops:"..resource_name.."crop_2", {
		paramtype = "light",
		walkable = false,
		drawtype = "plantlike",
		drop = "",
		tiles = {"resource_crops_crop_2.png"},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
			},
		},
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
		sounds = default.node_sound_leaves_defaults(),
	})

	--Crop Step 3
	minetest.register_node("resource_crops:"..resource_name.."crop_3", {
		paramtype = "light",
		walkable = false,
		drawtype = "plantlike",
		drop = "",
		tiles = {"resource_crops_crop_3.png"},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
			},
		},
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
		sounds = default.node_sound_leaves_defaults(),
	})

	--Crop Full Grown
	minetest.register_node("resource_crops:"..resource_name.."crop", {
		paramtype = "light",
		walkable = false,
		drawtype = "plantlike",
		tiles = {"resource_crops_"..resource_name.."_crop.png"},
	    selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.5+1/4, 0.5}
			},
		},
		drop = {
			max_items = 4,
			items = {
				{ items = {"resource_crops:"..resource_name.."_seed"} },
				{ items = {"resource_crops:"..resource_name.."_seed"}, rarity = 30},
				{ items = {"resource_crops:"..resource_name.."_essence"} },
				{ items = {"resource_crops:"..resource_name.."_essence"}, rarity = 30}
			}
		},
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1, resourceplant=1,},
		sounds = default.node_sound_leaves_defaults(),
	})

	local essence_groups = {}
	essence_groups["essence"] = 1
	essence_groups["essence_"..essence_type] = 1

	--Register Essence
	minetest.register_craftitem("resource_crops:"..resource_name.."_essence", {
		description = (visible_name.." Essence"),
		inventory_image = "resource_crops_"..resource_name.."_essence.png",
		groups = essence_groups
	})

	--Register Recipies
	if recipe_output then
		minetest.register_craft({
			output = recipe_output,
			recipe = {{"resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence"},
					  {"resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence"},
					  {"resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence"}}
		})
	end
	if recipe_input then
		minetest.register_craft({
			output = "resource_crops:"..resource_name.."_seed",
			recipe = {{recipe_input, "resource_crops:essence_"..essence_type, recipe_input},
					  {"resource_crops:essence_"..essence_type, "resource_crops:essence_seed", "resource_crops:essence_"..essence_type},
					  {recipe_input, "resource_crops:essence_"..essence_type, recipe_input}}
		})
	end
	minetest.register_craft({
		output = "resource_crops:"..resource_name.."_essence",
		recipe = {
			{"resource_crops:"..resource_name.."_seed"}
		}
	})
	--Add Plant
	farming.add_plant("resource_crops:"..resource_name.."crop", {"resource_crops:"..resource_name.."crop_1", "resource_crops:"..resource_name.."crop_2", "resource_crops:"..resource_name.."crop_3"})

	minetest.register_alias_force("resourcecrops:"..resource_name.."_seed", "resource_crops:"..resource_name.."_seed")
	minetest.register_alias_force("resourcecrops:"..resource_name.."crop_1", "resource_crops:"..resource_name.."crop_1")
	minetest.register_alias_force("resourcecrops:"..resource_name.."crop_2", "resource_crops:"..resource_name.."crop_2")
	minetest.register_alias_force("resourcecrops:"..resource_name.."crop_3", "resource_crops:"..resource_name.."crop_3")
	minetest.register_alias_force("resourcecrops:"..resource_name.."crop", "resource_crops:"..resource_name.."crop")
	minetest.register_alias_force("resourcecrops:"..resource_name.."_essence", "resource_crops:"..resource_name.."_essence")
end
