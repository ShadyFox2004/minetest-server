Biomes 
------

#### define_default
Sets provided nodes as default values for the biomes.
```lua
function biomes.define_default(def)
def     : Table

biomes.define_default({
	-- essential 
	sand = Name,
	stone_cobble = Name,
	mossy_stone_cobble = Name,
	water = Name,
	lava = Name,
	stone_cobble_stair = Name,
})
```

#### register_biome
Registers a new biome.
```lua
function biomes.register_biome(name, def)
name    : Name
def     : BiomeDef

biomes.register_biome("mod:biome", {
	-- essential
	name = "mod:biome",

	-- optional
	node_dust = nil,
	node_top = mapgen_stone,
	depth_top = 1,
	node_filler = mapgen_stone,
	depth_filler = 3,
	node_stone = mapgen_stone,
	node_water_top = nil,
	depth_water_top = 0,
	node_water = mapgen_water_source,
	node_river_water = mapgen_river_water_source,
	node_riverbed = biomes.sand,
	depth_riverbed = 2,
	node_cave_liquid = {mapgen_water_source, mapgen_lava_source},
	node_dungeon = biomes.stone_cobble,
	node_dungeon_alt = biomes.mossy_stone_cobble,
	node_dungeon_stair = biomes.stone_cobble_stair,
	y_max = 31000,
	y_min = 1,
	max_pos = nil,
	min_pos = nil,
	vertical_blend = 0,
	heat_point = 50,
	humidity_point = 50,
})
```
You should only use y_min and y_max or min_pos and max_pos, but not both.

#### register_biome_set
Registers a biome. It also registers an ocean and an underground biome, if 
provided.
```lua
function biomes.register_biome_set(name, def)
name    : Name
def     : Table

biomes.register_biome_set("mod:biome",{
	-- essential
	surface = BiomeDef,

	-- optional
	ocean = {
		-- optional
		heat_point = def.surface.heat_point
		humidity_point = def.surface.humidity_point
	},
	under = {
		-- optional
		heat_point = def.surface.heat_point
		humidity_point = def.surface.humidity_point
	}
})
```


#### register_ocean
Registers an ocean biome.
```lua
function biomes.register_ocean(name, def)
name    : Name
def     : BiomeDef

biomes.register_ocean("mod:biome", {
	-- essential
	name = "mod:biome_ocean",

	-- optional
	node_dust = nil,
	node_top = biomes.sand,
	depth_top = 1,
	node_filler = biomes.sand,
	depth_filler = 3,
	node_stone = mapgen_stone,
	node_water_top = nil,
	depth_water_top = 0,
	node_water = mapgen_water_source,
	node_river_water = mapgen_river_water_source,
	node_riverbed = biomes.sand,
	depth_riverbed = 2,
	node_cave_liquid = biomes.water,
	node_dungeon = biomes.stone_cobble,
	node_dungeon_alt = biomes.mossy_stone_cobble,
	node_dungeon_stair = biomes.stone_cobble_stair,
	y_max = 31000,
	y_min = -255,
	max_pos = nil,
	min_pos = nil,
	vertical_blend = 1,
	heat_point = 50,
	humidity_point = 50,
})
```
You should only use y_min and y_max or min_pos and max_pos, but not both.

#### register_stratum
```lua
function biomes.register_stratum(name, def)
name    : Name
def     : Table

biomes.register_stratum("mod:ore", {
	-- essential
	ore = "mod:ore",
	biomes = Name OR NameList,

	-- optional
	ore_param2 = 0,
	wherein = mapgen_stone,
	clust_scarcity = 1,
	clust_num_ores = ?,
	clust_size = ?,
	y_max = 43,
	y_min = 7,
	flags = "",
	noise_threshold = nil,
	noise_params = {
		offset = def.offset,
		scale = def.scale,
		spread = def.spread,
		seed = def.seed,
		octaves = def.octaves,
	},
	offset = 25,
	scale = 16,
	spread = {x = 128, y = 128, z = 128},
	seed = 90122,
	octaves = 1,
	np_stratum_thickness = nil,
	stratum_thickness = 2,

	-- fixed
	ore_type = "stratum"
})
```
NameList is a list of one ore more Names.

#### register_under
Registers an underground biome.
```lua
function biomes.register_under(name, def)
name    : Name
def     : BiomeDef

biomes.register_under("mod:biome", {
	-- essential
	name = "mod:biome_under",

	-- optional
	node_dust = nil,
	node_top = mapgen_stone,
	depth_top = 1,
	node_filler = mapgen_stone,
	depth_filler = 3,
	node_stone = mapgen_stone,
	node_water_top = nil,
	depth_water_top = 0,
	node_water = mapgen_water_source,
	node_river_water = mapgen_river_water_source,
	node_riverbed = biomes.sand,
	depth_riverbed = 2,
	node_cave_liquid = {biomes.water, biomes.lava},
	node_dungeon = biomes.stone_cobble,
	node_dungeon_alt = biomes.mossy_stone_cobble,
	node_dungeon_stair = biomes.stone_cobble_stair,
	y_max = -256,
	y_min = -31000,
	max_pos = nil,
	min_pos = nil,
	vertical_blend = 0,
	heat_point = 50,
	humidity_point = 50,
})
```
You should only use y_min and y_max or min_pos and max_pos, but not both.
