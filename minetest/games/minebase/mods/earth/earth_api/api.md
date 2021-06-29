Earth 
------
#### define_defaults
```lua
function earth.define_default(def)
def     : EarthDefaults

EarthDefaults {
	stone = Name
}

```

#### register_block
Registers a block node.
```lua
function earth.register_block(name, def)
name    : Name
def     : BlockDef

earth.register_block("mod:node", {
	-- essential

	-- optional
	description = "mod_node_block",
	short_description = "",
	groups = {cracky = 2},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node_block.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = false,
	post_effect_color = nil,
	paramtype2 = nil,
	place_param2 = nil,
	is_ground_content = false,
	diggable = true,
	leveled = nil,
	leveled_max = nil,
	sounds = sounds.get_defaults("earth_sounds:stone"),
	drop = nil,
})
```

#### register_brick
Registers a brick node.
```lua
function earth.register_brick(name, def)
name    : Name
def     : BrickDef

earth.register_brick("mod:node", {
	-- essential

	-- optional
	description = "mod_node_brick"
	short_description = "",
	groups = {cracky = 2},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node_brick.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = false,
	post_effect_color = nil,
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = true,
	diggable = true,
	leveled = nil,
	leveled_max = nil,
	sounds = sounds.get_defaults("earth_sounds:stone")
	drop = nil,
})

```
#### register_cobble
Registers a cobble node.
```lua
function earth.register_cobble(name, def)
name    : Name
def     : CobbleDef

earth.register_cobble("mod:node", {
	-- essential

	-- optional
	description = "mod_node_cobble",
	short_description = "",
	groups = {cracky = 3},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mode_node_cobble.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = false,
	post_effect_color = nil,
	paramtype2 = nil,
	place_param2 = nil,
	is_ground_content = false,
	diggable = true,
	leveled = 0,
	leveled_max = 127,
	sounds = sounds.get_defaults("earth_sounds:stone"),
	drop = nil,
})
```

#### register_deco
Registers decoration.
```lua
function earth.register_deco(name, def)
name    : Name
def     : DecoDef

earth.register_deco("mod:deco", {
	-- essential
	place_on = nil,
	biomes = nil,

	-- optional (there are multiple valid combination of these attributes)
	deco_type = "simple",
	sidelen = 4,
	fill_ratio = nil,
	noise_params = {
		offset = -1.25,
		scale = 0.25,
		spread = {x = 150, y = 150, z = 150},
		seed = 27162,
		octaves = 4,
		persist = 1.0
	},
	y_min = 1,
	y_max = 31000,	
	spawn_by = nil,
	num_spawn_by = nil,
	flags = "force_placement"
	place_offset_y = -1,
	decoration = nil,
	height = nil,
	height_max = nil,
	param2 = nil,
	param2_max = nil,
	schematic = nil,
	replacements = nil,
	rotation = nil,
})
```

#### register_node_with
```lua
```

#### register_nodes_with
```lua
```

#### register_ore
Registers a blob ore.
```lua
function earth.register_ore(name, def)
name    : Name
def     : OreDef

earth.register_ore("mod:node", {
	-- essential

	-- optional
	ore = "mod_node",
	ore_param2 = nil,
	wherein = {earth.stone},
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 8,
	clust_size = 5,
	y_max = 31000,
	y_min = -31000,
	flags = nil,
	noise_threshold = 0.0,
	noise_params = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 2316,
		octaves = 1,
		persist = 0.0
	},
	seed = 2316,
	biomes = nil

	-- fixed
	ore_type = "blob",
})
```

#### register_sand
Registers a sand node.
```lua
function earth.register_sand(name, def)
name    : Name
def     : SandDef

function earth.register_sand("mod:node", {
	description = "mod_node",
	short_description = "",
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "opague",
	post_effect_color = nil,
	paramtype2 = nil,
	place_param2 = nil,
	is_ground_content = false,
	diggable = true,
	leveled = 0,
	leveled_max = 127,
	sounds = sounds.get_defaults("earth_sounds:sand")
	drop = nil,
})
```

#### register_sand_nodes
Registers a set of sand nodes, associated crafting recipes and an ore. The names
for the stone variation have the infix stone.
```lua
function earth.register_sand_nodes(name, def)
name    : Name
def     : SandDefs

earth.register_sand_nodes("mod:node", {
	sand = {
		description = "mod_node",
		short_description = "",
		groups = {crumbly = 3, falling_node = 1, sand = 1},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_node.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = "opague",
		post_effect_color = nil,
		is_ground_content = false,
		diggable = true,
		leveled = 0,
		leveled_max = 127,
		sounds = sounds.get_defaults("earth_sounds:sand")
		drop = nil,
	},
	stone = {
		-- essential

		-- optional
		description = "mod_nodestone",
		short_description = "",
		groups = {cracky = 3, crumbly = 1},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_nodestone.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = "opaque",
		post_effect_color = nil,
		is_ground_content = true,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone")
		drop = nil,
	},
	brick = {
		-- essential

		-- optional
		description = "mod_nodestone_brick"
		short_description = "",
		groups = {cracky = 2},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_nodestone_brick.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = false,
		post_effect_color = nil,
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = true,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone")
		drop = nil,
	},
	block = {
		-- essential

		-- optional
		description = "mod_nodestone_block",
		short_description = "",
		groups = {cracky = 2},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_nodestone_block.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = false,
		post_effect_color = nil,
		is_ground_content = false,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone"),
		drop = nil,
	},
	ore = OreDef
})
```

#### register_stone
Registers a stone node.
```lua
function earth.register_stone(name, def)
name    : Name
def     : StoneDef

earth.register_stone("mod:node", {
	-- essential

	-- optional
	description = "mod_node",
	short_description = "",
	groups = {cracky = 3},
	palette = nil,
	color = nil,
	stack_max = 100,
	range = 4,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {"mod_node.png"},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "opaque",
	post_effect_color = nil,
	paramtype2 = nil,
	place_param2 = nil,
	is_ground_content = true,
	diggable = true,
	leveled = nil,
	leveled_max = nil,
	sounds = sounds.get_defaults("earth_sounds:stone")
	drop = nil,
})

```
#### register_stone_nodes
Registers a set of stone nodes and associated crafting recipes. All are part of
the groups cracky and stone.
```lua
function earth.register_stone_nodes(name, def)
name    : Name
def     : StoneDefs

earth.register_stone_nodes("mod:node", {
	stone = {
		-- essential

		-- optional
		description = "mod_node",
		short_description = "",
		groups = {cracky = 3, stone = 1},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_node.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = "opaque",
		post_effect_color = nil,
		is_ground_content = true,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone")
		drop = "mod:node_cobble", -- If a cobble node is defined.
	},
	cobble = {
		description = "mod_node_cobble",
		short_description = "",
		groups = {cracky = 3, stone = 2},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mode_node_cobble.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = false,
		post_effect_color = nil,
		is_ground_content = false,
		diggable = true,
		leveled = 0,
		leveled_max = 127,
		sounds = sounds.get_defaults("earth_sounds:stone"),
		drop = nil,
	},
	brick = {
		-- essential

		-- optional
		description = "mod_node_brick"
		short_description = "",
		groups = {cracky = 2, stone = 1},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_node_brick.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = false,
		post_effect_color = nil,
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = true,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone")
		drop = nil,
	},
	block = {
		-- essential

		-- optional
		description = "mod_node",
		short_description = "",
		groups = {cracky = 2, stone = 1},
		palette = nil,
		color = nil,
		stack_max = 100,
		range = 4,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		tiles = {"mod_node_block.png"},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = false,
		post_effect_color = nil,
		is_ground_content = false,
		diggable = true,
		leveled = nil,
		leveled_max = nil,
		sounds = sounds.get_defaults("earth_sounds:stone"),
		drop = nil,
	}
})
```
