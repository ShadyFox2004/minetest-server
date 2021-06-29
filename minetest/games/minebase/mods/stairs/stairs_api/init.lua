-- stairs/init.lua

-- Global namespace for functions

stairs = {}

function stairs.rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

function stairs.register_fuel(name, material, modifier)
	local baseburntime = minetest.get_craft_result({
		method = "fuel",
		width = 1,
		items = {material}
	}).time
	if baseburntime > 0 then
		minetest.register_craft({
			type = "fuel",
			recipe = name,
			burntime = math.floor(baseburntime * modifier),
		})
	end
end

local function adapt_stair_images(tiles, worldaligntex)
	local out = {}
	for i, tile in ipairs(tiles) do
		if type(tile) == "string" then
			out[i] = {
				name = tile,
				backface_culling = true,
			}
			if worldaligntex then
				out[i].align_style = "world"
			end
		else
			out[i] = table.copy(tile)
			if out[i].backface_culling == nil then
				out[i].backface_culling = true
			end
			if worldaligntex and out[i].align_style == nil then
				out[i].align_style = "world"
			end
		end
	end
	return out
end

function stairs.on_place_stair(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	return stairs.rotate_and_place(itemstack, placer, pointed_thing)
end

function stairs.register_stair(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name .. "_stair"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.stair_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = def.on_place or stairs.on_place_stair,
	})

	if def.material then
		-- Recipe matches appearence in inventory
		minetest.register_craft({
			output = name .. " 8",
			recipe = {
				{"", "", def.material},
				{"", def.material, def.material},
				{def.material, def.material, def.material},
			},
		})

		-- Use stairs to craft full blocks again (1:1)
		minetest.register_craft({
			output = def.material .. " 3",
			recipe = {
				{name, name},
				{name, name},
			},
		})
		
		stairs.register_fuel(name, def.material, 0.75)
	end
end

local function adapt_slab_images(tiles, worldaligntex) 
	local out = {}
	for i, tile in ipairs(tiles) do
		if type(tile) == "string" then
			out[i] = {name = tile}
			if worldaligntex then
				out[i].align_style = "world"
			end
		else
			out[i] = table.copy(tile)
			if worldaligntex and tile.align_style == nil then
				out[i].align_style = "world"
			end
		end
	end
	return out
end

function stairs.on_place_slab(itemstack, placer, pointed_thing)
	local under = minetest.get_node(pointed_thing.under)
	local wield_item = itemstack:get_name()
	local player_name = placer and placer:get_player_name() or ""

	if under and (under.name:find("_slab$") or under.name:find("_steps?$")) then
		-- place slab using under node orientation
		local dir = minetest.dir_to_facedir(vector.subtract(
			pointed_thing.above, pointed_thing.under), true)

		local p2 = under.param2

		-- Placing a slab on an upside down slab should make it right-side up.
		if p2 >= 20 and dir == 8 then
			p2 = p2 - 20
		-- same for the opposite case: slab below normal slab
		elseif p2 <= 3 and dir == 4 then
			p2 = p2 + 20
		end

		-- else attempt to place node with proper param2
		minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
		if not minetest.is_creative_enabled(player_name) then
			itemstack:take_item()
		end
		return itemstack
	else
		return stairs.rotate_and_place(itemstack, placer, pointed_thing)
	end
end

function stairs.register_slab(name, def)
	local slab_images = adapt_slab_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.slab = 1
	name = name .. "_slab"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.slab_description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = def.on_place or stairs.on_place_slab,
	})


	if def.material then
		minetest.register_craft({
			output = name .. " 6",
			recipe = {
				{def.material, def.material, def.material},
			},
		})

		-- Use 2 slabs to craft a full block again (1:1)
		minetest.register_craft({
			output = def.material,
			recipe = {
				{name},
				{name},
			},
		})

		stairs.register_fuel(name, def.material, 0.5)
	end
end

function stairs.register_inner_stair(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name  .. "_inner_stair"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.inner_stair_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
			},
		},
		on_place = def.on_place or stairs.on_place_stair,
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 7",
			recipe = {
				{"", def.material, ""},
				{def.material, "", def.material},
				{def.material, def.material, def.material},
			},
		})

		stairs.register_fuel(name, def.material, 0.875)
	end
end

function stairs.register_outer_stair(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name .. "_outer_stair"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.outer_stair_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
			},
		},
		on_place = def.on_place or stairs.on_place_stair,
	})

	if def.material then
		minetest.register_craft({
			output = name .. " 6",
			recipe = {
				{"", def.material, ""},
				{def.material, def.material, def.material},
			},
		})

		stairs.register_fuel(name, def.material, 0.625)
	end
end

function stairs.register_stair_and_slab(name, def)
	stairs.register_stair(name, def)
	stairs.register_slab(name, def) 
	stairs.register_inner_stair(name, def)
	stairs.register_outer_stair(name, def)
end

function stairs.register_step(name, def)
	local slab_images = adapt_slab_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.slab = 1
	name = name .. "_step"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.step_description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0.0, 0.5, 0.0, 0.5},
		},
		on_place = def.on_place or stairs.on_place_slab,
	})

	if def.material then
		stairs.register_fuel(name, def.material, 0.25)
	end
end

function stairs.register_outer_step(name, def)
	local slab_images = adapt_slab_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.slab = 1
	name = name .. "_outer_step"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.outer_step_description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0.0, 0.0, 0.0, 0.5},
		},
		on_place = def.on_place or stairs.on_place_slab,
	})


	if def.material then
		stairs.register_fuel(name, def.material, 0.125)
	end
end

function stairs.register_inner_step(name, def)
	local slab_images = adapt_slab_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.slab = 1
	name = name .. "_inner_step"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.inner_step_description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5,  0.0, 0.5, 0.0, 0.5},
				{-0.5, -0.5, -0.5, 0.0, 0.0, 0.0}
			}
		},
		on_place = def.on_place or stairs.on_place_slab,
	})


	if def.material then
		stairs.register_fuel(name, def.material, 0.375)
	end
end

function stairs.register_steps(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name .. "_steps"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.steps_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed", 
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.0},
				{-0.5,  0.0,  0.0, 0.5, 0.5, 0.5},
			}
		},
		on_place = def.on_place or stairs.on_place_slab,
	})

	if def.material then
		stairs.register_fuel(name, def.material, 0.5)
	end
end

function stairs.register_steps_half(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name .. "_steps_half"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.steps_half_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed", 
			fixed = {
				{-0.5, -0.5, -0.5, 0.0, 0.0, 0.0},
				{-0.5,  0.0,  0.0, 0.0, 0.5, 0.5},
			}
		},
		on_place = def.on_place or stairs.on_place_stair,
	})

	if def.material then
		stairs.register_fuel(name, def.material, 0.25)
	end
end

function stairs.register_steps_slab(name, def)
	local stair_images = adapt_stair_images(def.tiles, def.worldaligntex)
	local groups = table.copy(def.groups)
	groups.stair = 1
	name = name  .. "_steps_slab"
	local mat_def = minetest.registered_nodes[def.material]

	minetest.register_node(name, {
		description = def.description or def.steps_slab_description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = def.use_texture_alpha or mat_def 
			and mat_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.0, 0.5, 0.5},
				{ 0.0, -0.5, -0.5, 0.5, 0.0, 0.0},
				{ 0.0,  0.0,  0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = def.on_place or stairs.on_place_stair,
	})

	if def.material then
		stairs.register_fuel(name, def.material, 0.75)
	end
end

local function steps_craft(part, result)
	minetest.register_craft({
		output = result,
		recipe = {
			{"", part},
			{part, ""},
		},
	})
end

function stairs.register_step_crafts(name, def)
	local step = name .. "_step"
	local steps_half = name .. "_steps_half"
	local outer_step = name .. "_outer_step"
	local inner_step = name .. "_inner_step"

	craft.horizontal_half(steps_half, outer_step .. " 6")
	craft.side_by_side(outer_step, step)

	if def.outer_stair_description then
		craft.horizontal_half(name .. "_outer_stair", outer_step .. " 15")
	end
	if def.slab_description then
		local slab = name .. "_slab"
		craft.side_by_side(step, slab)
		craft.side_by_side(outer_step, inner_step, slab)
		craft.side_by_side(slab, steps_half, name .. "_steps_slab")

		if def.stair_description then
			craft.stacked(slab, step, name .. "_stair")
		end
		if def.outer_stair_description then
			craft.stacked(slab, outer_step, name .. "_outer_stair")
		end
		if def.inner_stair_description then
			craft.stacked(slab, inner_step, name .. "_inner_stair")
		end
	end
	local steps = name .. "_steps"
	steps_craft(step, steps)

	craft.side_by_side(outer_step, step, inner_step)
	if def.inner_stair_description then
		craft.horizontal_half(name .. "_inner_stair", inner_step .. " 7")
	end

	craft.horizontal_half(steps, step .. " 6")
	if def.stair_description then
		craft.horizontal_half(name .. "_stair", step .. " 9")
	end

	steps_craft(outer_step, steps_half)
	craft.side_by_side(steps_half, steps_half, steps)

	craft.horizontal_half(name .. "_steps_slab", inner_step .. " 6")
end

function stairs.register_step_nodes(name, def)
	stairs.register_step(name, def)
	stairs.register_outer_step(name, def)
	stairs.register_inner_step(name, def)
	stairs.register_steps(name, def)
	stairs.register_steps_half(name, def)
	stairs.register_steps_slab(name, def)
	stairs.register_step_crafts(name, def)
end

function stairs.register_all(name, def)
	stairs.register_stair_and_slab(name, def)
	stairs.register_step_nodes(name, def)
end

function stairs.register_glass_stair_and_slab(name, def)
	def.tiles = {def.split, def.full, def.stairside .. "^[transformFX", 
		def.stairside, def.full, def.split}
	stairs.register_stair(name, def)

	def.tiles = {def.full, def.full, def.split}
	stairs.register_slab(name, def)

	def.tiles = {def.stairside .. "^[transformR270", def.full, def.stairside 
		.. "^[transformFX", def.full, def.full, def.stairside}
	stairs.register_inner_stair(name, def)

	def.tiles = {def.stairside .. "^[transformR90", def.full, def.outer_stairside, 
			def.stairside, def.stairside .. "^[transformR90", def.outer_stairside}
	stairs.register_outer_stair(name, def)
end

function stairs.register_glass_step_nodes(name, def)
	def.tiles = {def.split, def.split, def.outer_stairside .. "^[transformR180", 
		def.outer_stairside .. "^[transformR90", def.split, def.split}
	stairs.register_step(name, def)

	def.tiles = {def.stairside .. "^[transformR270", def.stairside, def.quartered, 
			def.split, def.split, def.quartered }
	stairs.register_inner_step(name, def)

	def.tiles = {def.quartered}
	stairs.register_outer_step(name, def)

	def.tiles = {def.split, def.split, def.quartered, def.quartered, def.split,
			def.split}
	stairs.register_steps(name, def)

	def.tiles = {def.quartered}
	stairs.register_steps_half(name, def)

	def.tiles = {def.stairside .. "^[transformR270", 
		def.stairside .. "^[transformR270", def.quartered, def.full, 
		def.stairside .. "^[transformR180", def.stairside}
	stairs.register_steps_slab(name, def)

	stairs.register_step_crafts(name, def)
end

function stairs.register_glass_all(name, def)
	stairs.register_glass_stair_and_slab(name, def)
	def.use_texture_alpha = "clip"
	stairs.register_glass_step_nodes(name, def)
end

