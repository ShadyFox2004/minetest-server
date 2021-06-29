Minebase API
============

The structure of Minebase is modular and it has an extensive APIs with default 
values. This enables the user to change most of the behavior of registered 
objects by providing their own values. In addition, the APIs often integrate 
provided values that are nil by default like callbacks.

Glossary
--------

I provide links to explanations from the first edition of "Programming in Lua". 
Keep in mind that some information might be outdated because the 
[fourth edition](http://www.lua.org/pil/#4ed) has already been published.

OR  
Is used to connect alternatives.

?  
Used to express an unknown value.

_  
Is used as a name for variables and parameters that aren't used. If used 
multiple times within a function, the value is overwritten, but that doesn't 
matter.

[⊆](https://en.wikipedia.org/wiki/Subset)
Used to express that the values of a type on the left side have to be part of 
the set on the right side.

### Types 
[BiomeDef](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L7862)  
A table with keys used in a biome definition.

BookDef  
A table with keys used in a book definition.

[Boolean](http://www.lua.org/pil/2.2.html)  
A type with the two possible values true and false.

[Box](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1245)    
A table with two coordinates. The keys are 1, 2, 3, 4, 5 and 6 not x1, y1 et 
cetera.  
{x1, y1, z1, x2, y2, z2}

Byte  
An Integer in the range of 0 to 255.

CartDef  
A table with keys used in a cart definition.

CartItem  
A table with keys used in the definition of a craftitem for cart entities.

CreativeInv  
A table representing the creative inventory of a player.

DoorDef
A table with keys used in the definition of a door.

DoorItemDef
A table with keys used in the definition of a craftitem for doors.

Drops  
A table with Itemstacks.

DropsT  
A table with ItemStacks as tables.

[Float](http://lua-users.org/wiki/NumbersTutorial)  
A number with a fractional component. This component can be 0 because the type 
structure still differs from an Integer.

[Formspec](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L2052)  
A string containing formspec definitions.

[Groups](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1621)  
A table with GroupNames as keys and a number as value.

[GroupName](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1621)  
A name used in the groups attribute.

Integer  
A [number](http://lua-users.org/wiki/NumbersTutorial) value without a fractional 
component. 

[InvRef](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L5958)  
A reference to an inventory of the Minetest Engine.

[ItemStack](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L6019)  
An object representing a stack of items. It occupies one slot in an inventory.

LangCode  
A string representing a language.
"en", "fr"

Listname  
A string associated with a list of ItemStacks in an inventory.
"mod:item"

LootDef
A table with the keys name, part, x, y and z. x, y and z are optional tables 
with min and max values for chests the items are going to be found in.

[LuaEntity](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L6205)  
A table with methods used to control entities.

Mixed
At least two different types are allowed. The allowed types should be specified
in the description.

[Meter](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1259)  
The size of one node is considered 1 m³.

[Name](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L262)  
A string representing a registered item, node, entity, biome or something else. 
"mod:item", "mod:node", "mod:biome"

[Node](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L964)  
A table with values assigned to the keys name, param1 and param2.  
{name = Name, param1 = Byte, param2 = Byte}

[ObjectRef](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L6185)  
A userdata object of the Minetest Engine that is usable in Lua code. It is used
to represent moving things.

[Player](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L6336)  
An representing a Player. The object only lasts as long as the player is logged 
in. In case he logs in again a different object is created.

[PlayerControls](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L6402)  
A table with keys representing the keys a player pressed at a given time.

[PointedThing](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1487)  
A table representing the pointed node, object or nothing.  
{type = "nothing"}, {type = "node", under = Position, above = Position}, {type = "object", ref = ObjectRef}

[Position](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1279)  
A table with numeric values assigned to the keys x, y and z. Keep in mind that the y axis is pointing upwards.  
{x = 0, y = 0, z = 0}, {x = 10, y = -5, z = 0}

Room  
A table containing a list of walls, a size as Square and a type.  
{  
	walls = Table,  
	size = Square,  
	typ3 = "normal" OR "desert" OR "sandstone" OR "ice"  
}  
walls is a list of zero, one or more WallDefs.

Seconds  
A float representing a duration in seconds.

Secret  
A string with a random sequence of printable ASCII characters. 

[Serialized](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L5684)  
A string representing a value or object.

Square    
A table with positiv integers or zero assigned to the keys x and z.  
{x = 8, z = 0}, {x = 4, z = 20}


[String](http://www.lua.org/pil/2.4.html)  
A type representing character sequences with ASCII or UTF-8 characters. They are
enclosed with " or ' within the code.
"abcde", 'éßâ'

[Table](http://www.lua.org/pil/2.5.html)  
A lua table.

[Texture](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L392)  
A string containing the name of a texture.  
"mod_item.png"

[ToolCapabilities](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L1817)  
A table representing the attributes of a tool for example digging groups, the 
punch interval and damage.

TrapdoorDef
A table with keys used in the definition of a trapdoor.

[Vector](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt#L3129)  
A table with numeric values assigned to the keys x, y and z like Position. A 
vector doesn't represent a position, it represents a relative direction.
{x = 0, y = 0, z = 0}, {x = -4, y = 0, z = 20}

WallDef  
A table representing a wall using a position and a vector.  
{pos = {x = 1, y = 4, z = -4}, facing = {x = -1, y = 0, z = 4}}

Beds API
--------

#### can_dig
Checks whether the bed is occupied or not and returns true, if it is. Otherwise
it returns false.
```lua
function beds.can_dig(bed_pos)
bed_pos : Position
return  : Boolean
```

#### check_in_beds
Returns true, if all players are in bed and false otherwise.
```lua
function beds.check_in_beds(players)
players : Table
return  : Boolean
```
Players is a list of one, zero or more Players.  
If players is omitted, the function checks all connected players.

#### destruct_bed
Removes the other node of the bed and the spawn point.
```lua
function beds.destruct_bed(pos)
pos     : Position
```

#### get_other_pos
Returns the position of the other node of the bed.
```lua
function beds.get_other_pos(pos, n)
pos     : Position
n       : Integer ⊆ {1, 2}
return  : Position
```
n represents one part of the bed. 1 is the bottom 2 is the top.

#### get_player_in_bed_count
Counts and returns the amount of players laying in bed.
```lua
function beds.get_player_in_bed_count()
return  : Integer
```

#### kick_players
Pushes all players out of bed.
```lua
function beds.kick_players()
```

#### lay_down
Puts the player into the bed or pushes him out.
```lua
function beds.lay_down(player, pos, bed_pos, state, skip)
player  : Player
pos     : Position
bed_pos : Position
state   : Boolean
skip    : Boolean
```
state and skip are optional.  
If state is false (not nil), the player is pushed out of the bed. Otherwise the
player is put into bed.  
If skip is true, the function doesn't change settings that are irrelevant once
a player left.

#### on_place
Places both nodes of the bed, if it is possible and allowed. Otherwise 
the first node is returned to the inventory.
```lua
function beds.on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
```

#### on_rotate
A callback that provides custom behavior for screwdrivers. It returns true, if 
the node was rotated, false otherwise.
```lua
function beds.on_rotate(pos, node, user, _, new_param2)
pos             : Position
node            : Node
user            : Player
_               : Mixed
new_param2      : Byte
return          : Boolean
```

#### on_rightclick
Puts the player into the bed, if possible. It also sets the spawn point, if its
not occupied.
```lua
function beds.on_rightclick(pos, player)
pos     : Position
player  : Player
```

#### register_bed
A function that registers a bed.
```lua
function beds.register_bed(name, def)
name    : Name
def     : Table

beds.register_bed("mod:node", {
	-- registers nodes: "mod:node_bottom", "mod:node_top"
	-- essential 

	-- optional
	description = "mod_node"
	short_description = "",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, 
		bed = 1},
	inventory_image = "mod_node_inventory.png",
	inventory_overlay = nil,
	wield_image = "mod_node_inventory.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	range = 4.0,
	liquids_pointable = false,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = {
		breaks = nil,
		eat = nil
	},
	on_place = beds.on_place,
	-- Textures of node; +Y, -Y, +X, -X, +Z, -Z
	tiles = {
		bottom = {
			"mod_node_top1.png",
			"mod_node_under.png",
			"mod_node_side1.png",
			"mod_node_side1.png^[transformFX",
			"mod_node_foot.png",
			"mod_node_foot.png",
		},
		top = {
			"mod_node_top2.png",
			"mod_node_under.png",
			"mod_node_side2.png",
			"mod_node_side2.png^[transformFX",
			"mod_node_head.png",
			"mod_node_head.png",
		},
	},
	overlay_tiles = {
		bottom = nil,
		top = nil
	},
	special_tiles = {
		bottom = nil,
		top = nil
	},
	paramtype2 = "facedir",
	place_param2 = nil,
	node_box = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
	},
	selection_box = Box,
	collision_box = Box,
	sounds = sounds.get_defaults("tree_sounds:wood"),
	drop = nil,
	on_destruct = beds.destruct_bed,
	preserve_metadata = nil,
	can_dig = can_dig, -- local
	on_rightclick = on_rightclick, -- local
	on_rotate = beds.on_rotate,
	recipe = nil,

	-- fixed
	drop = "mod:node_bottom",
	stack_max = 1,
	light_source = 0,
	drawtype = "nodebox",
	visual_scale = 1,
	use_texture_alpha = "clip",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = false,
	walkable = true,
	pointable = true,  -- false for second node
	diggable = true,
	climbable = false,
	buildable_to = false,
	floodable = false,
	liquidtype = "none",
	leveled = 0,
	legacy_facedir_simple = false,
	legacy_wallmounted = false,
	waving = 0,
})
```

#### remove_spawns_at
Removes spawn points.
```lua
function beds.remove_spawns_at(pos)
pos     : Position
```

#### set_spawn
Sets and saves the spawn for a player.
```lua
function beds.set_spawn(name, pos)
name    : String
pos     : Position
```

#### skip_night
Skips over the night.
```lua
function beds.skip_night()
```


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

Books 
------
#### create_formspec
Creates a formspec displayed to the user. The formspec for the owner allows to
edit the content. Everyone else is only allowed to read.
```lua
function books.create_formspec(player_name, data)
player_name     : Name
data            : BookData
return          : Formspec

books.create_formspec("singleplayer", {
	title = "",
	owner = String,
	page = Integer,
	page_max = Integer,
	description = "",
	text = "",
})
```

#### get_lines
Takes a text and returns a sequence with the lines.
```lua
function books.get_lines(text)
text    : String
return  : Table
```

#### on_use
Shows the content of a book to the player.
```lua
function books.on_use(itemstack, user)
itemstack       : ItemStack
user            : Player
return          : ItemStack
```

#### page_content
Takes the data of a book and returns the content of the current page.
```lua
function books.page_content(data)
data    : BookData
return  : String
```

#### register_book
Registers a book.
```lua
function books.register_book(name, def)
name    : Name
def     : BookDef

books.register_book("mod:item", {
	-- essential

	-- optional 
	description = "mod_item",
	short_description = "",
	groups = {book = 1, flammable = 3, not_in_creative_inventory = def.not_in_creative_inventory},
	inventory_image = "mod_item.png",
	inventory_overlay = nil,
	wield_image = "mod_item.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	range = 4.0,
	node_placement_prediction = nil,
	sound = nil,
	on_use = books.on_use,
	not_in_creative_inventory = nil
})
```
#### register_book_set
Registers a book and a written book. 
```lua
function books.register_book_set(name, def)
name    : Name
def     : Table

books.register_book_set(name, {
	-- essential
	new = BookDef,

	-- optional
	written = {
		-- optional
		stack_max = 1
		not_in_creative_inventory = 1
	}
})
```

#### turn_page
Determines which page should be displayed. If it reaches the beginning or the 
end, it jumps to the other side.
```lua
function books.turn_page(to_right, page_no, page_max)
to_right        : Boolean
page_no         : Integer
page_max        : Integer
return          : Integer
```
If to_right is true, the next page is returned, otherwise the previous page.

Boolean
-------
#### qq
Returns one, if it is not nil. Otherwise it returns two.
```lua
function boolean.qq(one, two)
one     : Mixed
two     : Mixed
return  : Mixed
```

Buckets 
------
#### on_place
Places the liquid on a pointed block.
```lua
function buckets.on_place(itemstack, user, pointed_thing)
itemstack       : ItemStack
user            : Player
pointed_thing   : PointedThing
```
#### on_use
Takes a liquid source node.
```lua
function buckets.on_use(itemstack, user, pointed_thing)
itemstack       : ItemStack
user            : Player
pointed_thing   : PointedThing
```
#### register_liquid
Registers a bucket or a different container containing a liquid.
```lua
function buckets.register_liquid(name, def)
name    : Name
def     : Table

buckets.register_liquid("mod:item", {
	-- essential
	source = Name

	-- optional
	description = "mod_item",
	short_desciption = "",
	groups = nil,
	inventory_image = "mod_item.png",
	inventory_overlay = nil,
	wield_image = nil,
	wield_overlay = nil,
	palette = nil,
	color = nil, 
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 1,
	range = 4.0,
	light_source = 0,
	node_placement_prediction = nil,
	sound = nil,
	on_place = buckets.on_place,
	empty = "buckets_api:bucket_empty",
	
	-- fixed
	liquids_pointable = true,
})
```

Carts 
------
#### check_front_up_down
Determines whether the rail of railtype is leading the cart up, forward or down.
It returns a vector with the new direction.
```lua
function carts.check_front_up_down(pos, dir, check_up, railtype)
pos             : Position
dir             : Vector
check_up        : Boolean
railtype        : GroupName
return          : Vector
```
If check_up is true, the function checks a possible rise, otherwise it is not.
It always checks for a drop or no height change.  
railtype is a group name assigned to connect_to_raillike in the groups 
attribute of rails.

#### craftitem_on_place
Places a cart on a rail node. In case of success returns an ItemStack with one 
cart less (unless you are in creative mode).
```lua
function carts.craftitem_on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
return          : ItemStack
```

#### get_rail_direction
Determines the direction a cart is going to take at a junction.
```lua
function carts.get_rail_direction(entity, pos, dir, ctrl, old_switch, railtype)
entity          : LuaEntity
pos             : Position
dir             : Vector
ctrl            : PlayerControls
old_switch      : Mixed ⊆ {nil, 1, 2}
railtype        : GroupName
return          : Vector
```
old_switch disables the possibility to turn left (1) or right (2) or it has no 
effect.

#### get_rail_groups
Adds rail groups to a given groups table or returns a new table with rail 
groups.
```lua
function carts.get_rail_groups(groups)
groups  : Groups
return  : Groups
```

#### get_sign
Takes a number and returns a number representing the sign.
```lua
function carts.get_sign(z)
z       : Number
return  : Integer ⊆ {-1, 0, 1}
```

#### get_staticdata
Returns a string representing attributes of the entity. It is used by the engine 
to keep them over multiple instances. Every time the area is loaded a new
instance is created.
```lua
function carts.get_staticdata(entity)
entity  : LuaEntity
return  : Serialized
```

#### is_rail
Returns true if, the node in position pos is a rail node and false otherwise.
```lua
function carts.is_rail(pos, railtype)
pos             : Position
railtype        : GroupName
return          : Boolean
```
If the optional railtype is provided, it also checks the type of the rail.

#### on_activate
Is called by the engine to initialise a new instance with new or saved values.
```lua
function carts.on_activate(entity, staticdata, dtime_s)
entity          : LuaEntity
staticdata      : Serialized
dtime_s         : Seconds
```

#### on_punch
Is called by the engine when a cart is punched. This pushes the cart away.
```lua
function carts.on_punch(entity, puncher, time_from_last_punch, 
	tool_capabilities)
entity                  : LuaEntity
puncher                 : Player
time_from_last_punch    : Seconds
tool_capabilities       : ToolCapabilities
```

#### on_step
Is called by the engine on every sever tick and updates the behavior and 
properties of the cart.
```lua
function carts.on_step(entity, dtime)
entity  : LuaEntity
dtime   : Seconds
```

#### pathfinder
Looks ahead to find the path of the rails and returns the new position and 
direction. The player controls (left and right key) change the direction the 
cart is directed at junctions.
```lua
function carts.pathfinder(entity, pos, old_pos, old_dir, distance, ctrl,
	pf_switch, railtype)
entity          : LuaEntity
pos             : Position
ols_pos         : Position
old_dir         : Vector
distance        : Meter
ctrl            : PlayerControls
pf_switch       : Mixed ⊆ {nil, 1, 2}
railtype        : GroupName
return          : Position, Vector
```
pf_switch is the same as old_switch in get_rail_direction.

#### rail_on_step
Updates the behavior and properties of the cart that are related to the rails.
It also attaches items dropped into the cart to the cart once it starts moving.
```lua
function carts.rail_on_step(entity, dtime)
entity  : LuaEntity
dtime   : Seconds
```

#### rail_sound
Updates the sound caused by the cart.
```lua
function carts.rail_sound(entity, dtime)
entity  : LuaEntity
dtime   : Seconds
```

#### register_cart
Registers a cart entity. It also registers a craftitem, if it is provided.
```lua
function carts.register_cart(name, def)
name    : Name
def     : Table

carts.register_cart("mod:entity", {
	-- essential
	
	-- optional
	entity = CartDef,
	craftitem = nil
})
```
#### register_craftitem
Registers a craftitem for a cart entity.
```lua
function carts.register_craftitem(name, def)
name    : Name
def     : CartItem

carts.register_craftitem("mod:item", {
	-- essential

	-- optional
	description = txt,
	short_description = "",
	groups = nil,
	inventory_image = minetest.inventorycube("mod_item_top.png", 
		"mod_item_front.png", "mod_item_side.png"),
	inventory_overlay = nil,
	wield_image = "mod_item_front.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	range = 4.0,
	sound = nil,
	on_place = carts.craftitem_on_place,
})
```

#### register_entity
Registers a cart entity.
```lua
function carts.register_entity(name, def)
name    : Name
def     : CartDef

carts.register_entity("mod:entity", {
	-- essential initial_properties

	-- optional initial_properties
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual_size = {x = 1, y = 1, z = 1},
	mesh = "carts_api_cart.b3d",
	textures = {"mod_entity.png"},
	colors = nil,
	use_texture_alpha = false,
	backface_culling = true,
	glow = 0,
	infotext = S("left-click push, right-click mount") .. "\n" 
		.. S("aux + left-click to pick up"),
	static_save = true,
	damage_texture_modifier = nil,
	shaded = nil,
	show_on_minimap = false,
	
	-- fixed initial_properties
	physical = false, -- otherwise going uphill breaks
	collide_with_objects = false,
	pointable = true,
	visual = "mesh",
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = 0,
	stepheight = 0,
	automatic_face_movement_dir = 0.0,
	automatic_face_movement_max_rotation_per_sec = -1,

	-- essential callbacks and custom attributes

	-- optional callbacks and custom attributes
	on_activate = carts.on_activate,
	on_step = carts.on_step, 
	on_punch = carts.on_punch,
	on_rightclick = seats.on_rightclick,
	on_detach_child = seats.on_detach_child,
	get_staticdata = carts.get_staticdata,
	attach_at = {{x = 0, y = 0, z = 0}},
	eye_offset = {{x = 0, y = 0, z = 0}},
	pos_offset = {{x = 0, y = 0, z = 0}},
	detach_offset = {{x = 0, y = 0, z = 0}},
	max_passengers = 1,
	railtype = nil,
	attached_items = {},

	-- fixed custom attributes
	punched = false, -- used to re-send velocity and position
	velocity = {x=0, y=0, z=0}, -- only used on punch
	old_dir = {x=1, y=0, z=0}, -- random value to start the cart on punch
	old_pos = nil,
	old_switch = 0,
	name = "mod:entity"
})

```
#### register_rail
Registers a rail node.
```lua
function carts.register_rail(name, def)
name    : Name
def     : Table

carts.register_rail("mod:node", {
	-- essential

	-- optional
	description = "mod_node",
	short_description = "",
	groups = carts.get_rail_groups(def.groups),
	inventory_image = "mod_node_straight.png",
	inventory_overlay = nil,
	wield_image = "mod_node_straight.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	range = 4.0,
	liquids_pointable = false,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	sound = nil,
	tiles = {
		"mod_node_straight.png", "mod_node_curved.png",
		"mod_node_t_junction.png", "mod_node_crossing.png"
	},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "opaque",
	post_effect_color = nil,
	paramtype = "light",
	paramtype2 = "none",
	place_param2 = nil,
	walkable = false,
	pointable = true, 
	diggable = true,
	damage_per_second = 0,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	waving = 0,
	sounds = sounds.get_defaults("ore_sounds:metal"),
	drop = "",
	preserve_metadata = nil,
	recipe = nil,

	-- fixed 
	drawtype = "raillike",
	visual_scale = 1.0,
	is_ground_content = false,
	sunlight_propagates = true,
	climbable = false, 
	buildable_to = false, 
	floodable = false,
	liquidtype = "none",
	leveled = 0,
})
```

#### velocity_to_dir
Creates and returns a vector that points into the direction the card is moving.
```lua
function carts.velocity_to_dir(v)
v       : Vector
return  : Vector ⊆ {(1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0), (0, 1, 1),
        (0, 1, -1), (0, -1, 1), (0, -1, -1)}
```

Killme 
------
#### command "killme"
```lua
```

Sethome 
------
#### command "home"
```lua
```
#### command "sethome"
```lua
```
#### get
```lua
```
#### go
```lua
```
#### set
```lua
```


Containers 
------

#### close
Closes an open container.
```lua
function containers.close(name)
name    : Name
```

#### create_formspec
```lua
function containers.create_formspec(inventory1, def)
inventory1      : Name
def             : Table
return          : Formspec

containers.create_formspec("main", {
	-- essential 

	-- optional
	width = 8,
	height = 9,
	list1 = "main",
	x1 = 0, 
	y1 = 0.3,
	inventory1_width = 8, 
	inventory1_height = 4,
	x2 = 0, 
	y2 = 4.85,
	x2 = 0,
	y2 = 6.08,
	overlay = ""
})

```
#### lid_obstructed
Returns true, if something is blocking the lid from opening and false otherwise.
```lua
function containers.lid_obstructed(pos)
pos     : Position
return  : Boolean
```

#### on_metadata_inventory_move
Updates the container after an ItemStack was moved within it.
```lua
function containers.on_metadata_inventory_move(pos, _, _, _, _, _, player)
pos     : Position
_       : Mixed
player  : Player
```

#### on_metadata_inventory_put
Updates the container after an ItemStack was put into it.
```lua
function containers.on_metadata_inventory_put(pos, _, _, _, player)
pos     : Position
_       : Mixed
player  : Player
```

#### on_metadata_inventory_take
Updates the container after an ItemStack was taken from it.
```lua
function containers.on_metadata_inventory_take(pos, _, _, _, player)
pos     : Position
_       : Mixed
player  : Player
```

#### register_container
Registers a container.
```lua
function containers.register_container(name, def)
name    : Name
def     : Table

containers.register_container("mod:node", {
	-- registeres two nodes: "mod:node" and "mod:node_opened"
	-- essential
	closed = {
		-- essential

		-- optional
		description = "mod_node",
		short_description = "",
		groups = {choppy = 2, oddly_breakable_by_hand = 2},
		inventory_image = nil,
		inventory_overlay = nil,
		wield_image = nil,
		wield_overlay = nil,
		palette = nil,
		color = nil,
		wield_scale = {x = 1, y = 1, z = 1},
		stack_max = 100,
		range = 4.0,
		light_source = 0,
		node_placement_prediction = nil,
		node_dig_prediction = "air",
		sound = nil,
		drawtype = "normal", 
		visual_scale = 1.0,
		tiles = {"mod_node_top.png", "mod_node_bottom.png",
			"mod_node_side.png^[transformFX", "mod_node_side.png", 
			"mod_node_back.png", "mod_node_front.png",
		},
		overlay_tiles = nil,
		special_tiles = nil,
		use_texture_alpha = "opaque",
		paramtype2 = "facedir",
		place_param2 = nil,
		node_box = nil,
		connects_to = nil,
		connect_sides = nil,
		mesh = "normal", 
		selection_box = nil,
		collision_box = nil,
		legacy_facedir_simple = true,
		sounds = sounds.get_defaults("tree_sounds:wood"),
		drop = nil,
		on_construct = callbacks_p.on_construct,
		preserve_metadata = nil,
		after_place_node = callbacks_p.after_place_node,
		can_dig = callbacks_p.can_dig,
		on_punch = nil,
		on_rightclick = callbacks_p.on_rightclick,
		on_timer = nil,
		allow_metadata_inventory_move = callbacks_p.allow_metadata_inventory_move,
		allow_metadata_inventory_put = callbacks_p.allow_metadata_inventory_put,
		allow_metadata_inventory_take = callbacks_p.allow_metadata_inventory_take,
		on_metadata_inventory_move = containers.on_metadata_inventory_move,
		on_metadata_inventory_put = containers.on_metadata_inventory_put,
		on_metadata_inventory_take = containers.on_metadata_inventory_take,
		on_blast = callbacks_p.on_blast,
		on_key_use = callbacks_p.on_key_use,
		on_skeleton_key_use = callbacks_p.on_skeleton_key_use,
		inventory_width = 8,
		inventory_height = 4,
		allowed_item_group = nil,
		soundC = "mod_node_open",
		formspec_def = nil,
		update = nil,
		opening_side = "+y",
		protected = false,
		recipe = nil,
		burntime = nil,

		-- fixed
		liquids_pointable = false,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = false,
		walkable = true, 
		pointable = true, 
		diggable = true,
		climbable = false, 
		buildable_to = false, 
		floodable = false,
		leveled = 0,
		legacy_wallmounted = false,
		waving = 0,
		node_opened = "mod:node_opened",
		node_closed = "mod:node",
	},

	-- optional
	opened = {
		-- essential

		-- optional
		description = "mod_node",
		short_description = "",
		groups = {not_in_creative_inventory = 1},
		drawtype = "mesh",
		visual_scale = 1,
		tiles = {
			"mod_node_top.png", "mod_node_bottom.png", 
			"mod_node_side.png", "mod_node_side.png", 
			"mod_node_front.png", "mod_node_inside.png"
		}
		overlay_tiles = nil,
		special_tiles = nil,
		paramtype2 = "facedir",
		place_param2 = nil,
		node_box = nil,
		connects_to = nil,
		connect_sides = nil,
		mesh = "containers_chest_open.obj",
		selection_box = {
			type = "fixed",
			fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
		},
		collision_box = nil,
		sounds = sounds.get_defaults("tree_sounds:wood"),
		drop = "mod:node",
		on_construct = callbacks_p.on_construct,
		preserve_metadata = nil,
		after_place_node = callbacks_p.after_place_node,
		can_dig = open.can_dig,
		on_punch = nil,
		on_rightclick = callbacks_p.on_rightclick,
		on_timer = nil,
		allow_metadata_inventory_move = callbacks_p.allow_metadata_inventory_move,
		allow_metadata_inventory_put = callbacks_p.allow_metadata_inventory_put,
		allow_metadata_inventory_take = callbacks_p.allow_metadata_inventory_take,
		on_metadata_inventory_move = containers.on_metadata_inventory_move,
		on_metadata_inventory_put = containers.on_metadata_inventory_put,
		on_metadata_inventory_take = containers.on_metadata_inventory_take,
		on_key_use = callbacks_p.on_key_use,
		on_skeleton_key_use = callbacks_p.on_skeleton_key_use,
		soundC = "mod_node_open",
		protected = def.closed.protected

		-- fixed 
		wield_scale = {x = 1, y = 1, z = 1},
		liquids_pointable = false,
		light_source = 0,
		node_dig_prediction = "air",
		on_place = minetest.item_place,
		on_drop = minetest.item_drop,
		use_texture_alpha = "opaque",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = false,
		walkable = true, 
		pointable = true, 
		diggable = true,
		climbable = false, 
		buildable_to = false, 
		floodable = false,
		liquidtype = "none",
		leveled = 0,
		legacy_facedir_simple = true,
		legacy_wallmounted = false,
		waving = 0,
		on_blast = open.on_blast,
		node_closed = "mod:node",
	}
})
```
If tiles are provided for the closed node, the third texture is transformed with 
"^[transformFX".  
If def.protected is true, callbacks_p is containers.protected, otherwise it is 
containers.unprotected.  
If custom groups are provided for the open container, it is still added to 
not_in_creative_inventory.  
If no tiles are provided for the open node, the textures of the closed node are
used.

containers.protected
--------------------

#### protected.after_place_node
Sets the owner of a protected container after it was placed.
```lua
function containers.protected.after_place_node(pos, placer)
pos     : Position
placer  : Player
```

#### protected.allow_metadata_inventory_move
Returns the amount of items the player is allowed to move within a protected 
container. 
```lua
function containers.protected.allow_metadata_inventory_move(pos, _, _, _ , _, 
	count, player)
pos     : Position
_       : Mixed
count   : Integer
player  : Player
return  : Integer
```

#### protected.allow_metadata_inventory_put
Returns the amount of items the player is allowed to put into a protected 
container.
```lua
function containers.protected.allow_metadata_inventory_put(pos, _, _, stack, 
	player)
pos     : Position
_       : Mixed
stack   : ItemStack
player  : Player
return  : Integer
```

#### protected.allow_metadata_inventory_take
Returns the amount of items the player is allowed to take from a protected
container.
```lua
function containers.protected.allow_metadata_inventory_take(pos, _, _, stack, 
	player)
pos     : Position
_       : Mixed
stack   : ItemStack
player  : Player
return  : Integer
```

#### protected.can_dig
Returns true, if the player is allowed to dig the protected container, false 
otherwise.
```lua
function containers.protected.can_dig(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### protected.on_blast
Does nothing. Protected containers are not blown up.
```lua
function containers.protected.on_blast()
```

#### protected.on_construct
Sets the owner of a placed protected container, as well as the inventory and 
other attributes.
```lua
function containers.protected.on_construct(pos)
pos     : Position
```

#### protected.on_key_use
Opens a protected container, if the key fits into the lock.
```lua
function containers.protected.on_key_use(pos, player)
pos     : Position
player  : Player
```

#### protected.on_rightclick
Opens a protected container, if the player is allowed to do it.
```lua
function containers.protected.on_rightclick(pos, node, clicker, itemstack)
pos             : Position
node            : Node
clicker         : Player
itemstack       : ItemStack
```

#### protected.on_skeleton_key_use
```lua
function containers.protected.on_skeleton_key_use(pos, player, newsecret)
pos             : Position
player          : Player
newsecret       :
return          :
```
containers.unprotected
----------------------

#### unprotected.allow_metadata_inventory_put
Returns the amount of items the player is allowed to put into an unprotected 
container.
```lua
function containers.unprotected.allow_metadata_inventory_put(pos, _, _, stack)
pos     : Position
_       : Mixed
stack   : ItemStack
return  : Integer
```

#### unprotected.can_dig
Returns true, if the player is allowed to dig the unprotected container, false 
otherwise.
```lua
function containers.unprotected.can_dig(pos, player)
pos     : Position
player  : Player 
return  : Boolean
```

#### unprotected.on_blast
Drops all items and the container.
```lua
function containers.unprotected.on_blast(pos)
pos     : Position
return  : DropsT
```

#### unprotected.on_construct
Sets up the inventory of a placed unprotected container and other attributes.
```lua
function containers.unprotected.on_construct(pos)
pos     : Position
```

#### unprotected.on_rightclick
Opens an unprotected container.
```lua
function containers.unprotected.on_rightclick(pos, node, clicker, itemstack)
pos             : Position
node            : Node
clicker         : Player
itemstack       : ItemStack
```

Craft API 
---------

This mod provides registry functions for recurring combinations of craft
recipes.  

#### register_craft14
Registers two crafts. One that splits an item into four parts and a second that 
merges those four items into one.

| input	|	| output 	||
|:-----:|:-----:|:-------------:|:-----:|
| one	| &harr;| four 		| four	|
|	|	| four 	 	| four  |				
```lua
craft.register_craft14(one, four)
one     : Name
four    : Name
```

#### register_craft19
Registers two crafts. One that splits an item into nine parts and a second that 
merges those nine items into one.

| input	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|
| one	| &harr;| nine 	| nine	| nine	|
| 	| 	| nine	| nine	| nine	|
| 	|	| nine	| nine	| nine	|
```lua
craft.register_craft19(one, nine)
one     : Name
nine    : Name
```

#### register_craft44
Registers two crafts. Both transform four items into the other item type. The 
shape is important.

| input	|	|	| output 	||
|:-----:|:-----:|:-----:|:-------------:|:-----:|
| four1	| four1	| &harr;| four2 	| four2	|
| four1	| four1	| 	| four2	 	| four2 |				
```lua
craft.register_craft44(four1, four2)
four1   : Name
four2   : Name
```

#### register_craft99
Registers two crafts. Both transform nine items into the other item type. 

| input	|	|	|	| output|||
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| nine1	| nine1	| nine1	| &harr;| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
| nine1	| nine1	| nine1	|	| nine2	| nine2	| nine2	|
```lua
craft.register_craft99(nine1, nine2)`
nine1   : Name
nine2   : Name
```

#### register_craft_metadata_copy
Registers a craft recipe that copies the metadata of one item to a new item of 
type result. The original item used for crafting is preserved. The craft recipe 
is shapeless.
```lua
function craft.register_craft_metadata_copy(ingredient, result)
ingredient      : Name
result          : Name
```

#### horizontal_half
Registers a craft that creates the result from three parts. The shape is 
important.

| input	|	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|:-----:|
| part	| part	| part	| &rarr;| result
```lua
craft.horizontal_half(part, result)
part    : Name
result  : Name
```

#### side_by_side
Registers a craft that creates the result from two different items or from two 
items of the same type. The shape is important.

| input	|	|	| output|
|:-----:|:-----:|:-----:|:-----:|
| one	| two	| &rarr;| result

```lua
craft.side_by_side(one, two, result)
one     : Name
two     : Name
result  : Name
```
If result is omitted, one is used twice and two becomes the result.

#### stacked
Registers a craft that creates the result from two different items or from two 
items of the same type. The shape is important.

| input	|	| output|
|:-----:|:-----:|:-----:|
| two	| &rarr;| result
| one	|	| 

```lua
craft.stacked(one, two, result)
one     : Name
two     : Name
result  : Name
```
If result is omitted, one is used twice and two becomes the result.


Creative 
------
#### description
Returns the description in the language lang_code.
```lua
function creative.description(def, lang_code)
def             : Table
lang_code       : LangCode
return          : String
```

#### init_creative_inventory
Initialises the creative inventory for a player and returns a table with cached
information.
```lua
function creative.init_creative_inventory(player)
player  : Player
return  : CreativeInv

CreativeInv = {
	size = 0,
	filter = "",
	start_i = 0,
	old_filter = nil,
	old_content = nil
}
```

#### is_enabled
Returns true, if creative is enabled for the player or everyone, false 
otherwise. Is is also assigned to minetest.is_creative_enabled.
```lua
function creative.is_enabled(name)
name    : Name
return  : Boolean
```

#### is_enabled_for
Calls is_enabled and returns its return value. It is deprecated.
```lua
function creative.is_enabled_for(name)
name	: Name
return  : Boolean
```

#### match
Looks for an occurence of filter in s and returns the length of s - the length 
of filter, 0 or 999.
```lua
function creative.match(s, filter)
s       : Name
filter  : String
return  : Integer
```
#### handle_node_drops
For players not playing in creative mode, it does the same as the default. It 
adds items to the inventory of players playing in creative mode, if there isn't 
already an item of that type inside. It is also assigned to minetest.
handle_node_drops.
```lua
function creative.handle_node_drops(pos, drops, digger)
pos     : Position
drops   : Drops
digger  : Player
```

#### old_is_creative_enabled
Creative overwrites minetest.is_creative_enabled, but a reference to the old 
function is saved here.
```lua
function creative.old_is_creative_enabled(name)
name    : Name
return  : Boolean
```

#### old_handle_node_drops
Creative overwrites minetest.handle_node_drops, but a reference to the old 
function is saved here.
```lua
function creative.old_handle_node_drops(pos, drops, digger)
pos     : Position
drops   : Drops
digger  : Player
```

#### register_tab
Registers a tab in the creative inventory.
```lua
function creative.register_tab(name, def)
name    : Name
def     : CreativeTabDef

CreativeTabDef = {
	-- essential
	title = Name,

	-- optional
	is_in_nav = tab.is_in_nav,
	get = function(_, player, context) 
		return tab.get(player, context, def.items)
	end,
	on_enter = tab.on_enter,
	on_player_receive_fields = tab.on_player_receive_fields
}
```

#### get_homepage_name
Returns the default homepage for players not playing in creative mode and 
another page for those playing in creative.
```lua
function creative.get_homepage_name(player)
player  : Player
return  : Name
```

#### update_creative_inventory
Updates the visible content of the inventory.
```lua
function creative.update_creative_inventory(player_name, tab_content)
player_name     : Name
tab_content     : CreativeInv
```

Doors 
------

#### after_dig_node
Removes the second node of the door.
```lua
function doors.after_dig_node(pos, node)
pos     : Position
node    : Node
```

#### door_toggle
Opens or closes the door. It depends on the current status. Returns true on 
success, false otherwise.
```lua
function doors.door_toggle(pos, node, clicker)
pos     : Position
node    : Node
clicker : Player
return  : Boolean
```

#### on_blast
Removes both nodes.
```lua
function doors.on_blast(pos)
pos     : Position
return  : Name
```

#### on_destruct
Removes the second node.
```lua
function doors.on_destruct(pos)
pos     : Position
```

#### on_key_use
Allows the player to open a door, if the key fits into the lock. It returns
true, if it fits and false otherwise.
```lua
function doors.on_key_use(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### on_place
Places a door, if possible. It also puts the hinges on the right side, if there
is a door on the left side.
```lua
function doors.on_place(itemstack, placer, pointed_thing)
itemstack       : ItemStack
placer          : Player
pointed_thing   : PointedThing
return          : ItemStack
```

#### on_rightclick
Toggles the door.
```lua
function doors.on_rightclick(pos, node, clicker, itemstack)
pos             : Position
node            : Node
clicker         : Player
itemstack       : ItemStack
return          : ItemStack
```

#### on_rotate
Returns false. Doors can't be rotated.
```lua
function doors.on_rotate() 
return  : Boolean
```

#### on_skeleton_key_use
Sets the lock of a door to newsecret, if it doesn't have a lock. It returns the 
lock, a translated description and the owner.
```lua
function doors.on_skeleton_key_use(pos, player, newsecret)
pos             : Position
player          : Player
newsecret       : String 
return          : String, String, String
```

#### protected_on_blast
Does nothing, protected doors can't be blown up.
```lua
function doors.protected_on_blast() 
```

#### register_craftitem
Registers a craftitem for the door.
```lua
function doors.register_craftitem(name, def)
name    : Name
def     : DoorItemDef

doors.register_craftitem("mod:item", {
	-- essential

	-- optional
	description = "mod_item",
	short_description = "",
	groups = nil,
	inventory_image = "mod_item_item.png",
	inventory_overlay = nil,
	wield_image = nil,
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	light_source = 0,
	node_placement_prediction = nil,
	node_dig_prediction = "air",
	on_place = doors.on_place,
	sounds = sounds.get_defaults("tree_sounds:wood"),
	protected = nil,
	recipe = nil,

	-- fixed
	liquids_pointable = false,
})
```

#### register_door
Registeres a door.
```lua
function doors.register_door(name, def)
name    : Name
def     : DoorDef

doors.register_door("mod:node", {
	-- essential

	-- optional
	description = "mod_node",
	short_description = "",
	groups = {not_in_creative_inventory = 1, door = 1},
	palette = nil,
	color = nil,
	light_source = 0,
	drawtype = "mesh",
	tiles = {{name = txt .. ".png", backface_culling = true }},
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "clip",
	paramtype2 = "facedir",
	place_param2 = nil,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed", 
		fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}
	},
	collision_box = {
		type = "fixed", 
		fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}
	},
	sounds = sounds.get_defaults("tree_sounds:wood"),
	drop = "mod:node",
	on_destruct = doors.on_destruct,
	after_dig_node = doors.after_dig_node,
	can_dig = nil,
	on_rightclick = doors.on_rightclick,
	on_blast = nil,
	on_rotate = doors.on_rotate,
	on_key_use = doors.on_key_use,
	on_skeleton_key_use = doors.on_skeleton_key_use,
	door = {
		name = "mod:node",
		sounds = { 
			"doors_api_wood_open", 
			"doors_api_wood_close"
		},
	},

	-- fixed
	paramtype = "light",
	is_ground_content = false,
	walkable = true,
	buildable_to = false,
	mesh = doorMesh,
})
```
doorMesh is one of the meshes in the models folder. The function registeres four
nodes, one for every mesh.  
If the door, is protected it also uses:  
```
can_dig_door
doors.protected_on_blast 
doors.on_key_use
doors.on_skeleton_key_use 
```

#### register_trapdoor
Registeres a trapdoor.
```lua
local function register_trapdoor(name, def)
name    : Name
def     : TrapdoorDef

doors.register_trapdoor("mod:node", {
	description = "mod_node",
	short_description = "",
	groups = nil,
	inventory_image = "mod_node.png",
	inventory_overlay = nil,
	wield_image = "mod_node.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	light_source = 0,
	drawtype = "nodebox",
	visual_scale = 1,
	tiles = trapdoorTiles,
	overlay_tiles = nil,
	special_tiles = nil,
	use_texture_alpha = "clip",
	paramtype2 = "facedir",
	place_param2 = nil, 
	sunlight_propagates = true,
	node_box = trapdoorNodebox,
	connects_to = nil,
	connect_sides = nil,
	mesh = nil,
	selection_box = trapdoorSelectionbox,
	collision_box = nil,
	sounds = sounds.get_defaults("tree_sounds:wood"),
	drop = "mod:node",
	on_destruct = doors.on_destruct,
	after_place_node = nil,
	can_dig = nil,
	on_rightclick = doors.trapdoor_on_rightclick,
	on_blast = nil,
	on_key_use = nil,
	on_skeleton_key_use = nil,
	sound_close = "doors_api_wood_open", 
	sound_open = "doors_api_wood_close",
	tile_front = "mod_node.png",
	tile_side = "mod_node_side.png",

	-- fixed
	paramtype = "light",
	is_ground_content = false,
	walkable = true,
	buildable_to = false,
	type = "trapdoor"
})
```
This function generates textures based on tile_side and tile_front, if no tiles
are provided by the definition (trapdoorTiles).  
It also uses two default nodeboxes and selectionboxes, one for opened and the 
second for closed trapdoors (trapdoorNodebox, trapdoorSelectionbox).  
If the trapdoor is protected, it also uses:  
```
can_dig_door
doors.trapdoor_after_place_node
doors.protected_on_blast
doors.on_key_use 
doors.on_skeleton_key_use
```

#### trapdoor_after_place_node
Currently only sets the owner of a placed trapdoor.
```lua
function doors.trapdoor_after_place_node(pos, placer, itemstack)
pos             : Position
placer          : Player
itemstack       : ItemStack
return          : Boolean
```

#### trapdoor_on_blast
Removes the trapdoor.
```lua
function doors.trapdoor_on_blast(pos)
pos     : Position
return  : Table (with a Name)
```

#### trapdoor_on_rightclick
Toggles the trapdoor.
```lua
function doors.trapdoor_on_rightclick(pos, node, clicker, itemstack)
pos             : Position
node            : Node
clicker         : Player
itemstack       : ItemStack
return          : ItemStack
```

#### trapdoor_toggle
Opens or closes the trapdoor. The action depends on its current state. Returns 
true on success, false otherwise.
```lua
function doors.trapdoor_toggle(pos, node, clicker)
pos             : Position
node            : Node
clicker         : Player
return          : Boolean
```

doors_get 
---------

#### door.close
Closes the door on position pos and returns true on success, false otherwise.
```lua
function doors_get.door.close(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### door.open
Opens the door on position pos and returns true on success, false otherwise.
```lua
function doors_get.door.open(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### door.state
Returns the current state of the door on position pos. True represents an open
door, false a closed one.
```lua
function doors_get.door.state(pos)
pos     : Position
return  : Boolean
```

#### door.toggle
Opens or closes the door. It depends on the current status. Returns true on 
success, false otherwise.
```lua
function doors_get.door.toggle(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### trapdoor.close
Closes the trapdoor on position pos and returns true on success, false 
otherwise.
```lua
function doors_get.trapdoor.close(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### trapdoor.open
Opens the trapdoor on position pos and returns true on success, false otherwise.
```lua
function doors_get.trapdoor.open(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

#### trapdoor.state
Returns the current state of the trapdoor on position pos. True represents an 
open trapdoor, false a closed one.
```lua
function doors_get.trapdoor.state(pos)
pos     : Position
return  : Boolean
```

#### trapdoor.toggle
Opens or closes the trapdoor. It depends on the current status. Returns true on 
success, false otherwise.
```lua
function doors_get.trapdoor.toggle(pos, player)
pos     : Position
player  : Player
return  : Boolean
```

Dungeon Loot 
------
#### filter_rooms
Returns rooms suited for dungeon loot, based on the provided positions.
```lua
function dungeon_loot.filter_rooms(poslist)
poslist : PosList
return  : Rooms
```
PosList is a list of zero, one or more Positions.  
Rooms is a list of zero, one or more Rooms.

#### find_walls
Searches for walls from a given position to identify rooms.
```lua
function dungeon_loot.find_walls(cpos)
cpos    : Position
return  : Room

Room {
	walls = Table,
	size = Square,
	typ3 = "normal" OR "desert" OR "sandstone" OR "ice"
}

WallDef {
	pos = Position,
	facing = Vector
}

```
walls is a list of zero, one or more WallDefs.

#### get_loot
Returns the loot available in a specified position and dungeontype.
```lua
function dungeon_loot.get_loot(pos, dungeontype)
pos             : Position
dungeontype     : DungeonTypeList
return          : LootDefList, LootDefParts
```
DungeonTypeList is a table of dungeon types the loot is going to be found in. 
"normal", "desert", "sandstone" and "ice" are currently supported.  
LootDefList is a list of LootDefs.  
LootDefParts is a corresponding list of their part values.

#### populate_chest
Adds items to the chest on position pos.
```lua
function dungeon_loot.populate_chest(pos, dungeontype)
pos             : Position
dungeontype     : DungeonTypeList
```

#### register_loot
Registers a single item or a sequence of items as dungeon loot.
```lua
function dungeon_loot.register_loot(loot)
loot    : Mixed ⊆ {LootDef, {LootDef}}

LootDef {
	name = Name, part = Integer, count = {Integer, Integer}, 
	x = {Integer, Integer}, y = {Integer, Integer}, 
	z = {Integer, Integer},
	types = DungeonTypeList
}
```
part is the amount of times the item is put into a chest in ratio to the sum of 
all part values for items that can be placed inside a chest on a given position.  
count represents the minimum and maximum amount of items found inside a chest.  
x, y and z are optional tables with min and max values for chests the items are 
going to be found in.  

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

Mossy
-----
#### register_growth
```lua
```
#### replace
```lua
```

Env Sounds 
------
#### cyclic_update
```lua
```
#### register_sound
```lua
```
#### update_sound
```lua
```

Farming 
------
#### grow_plant
```lua
```
#### hoe_on_use
```lua
```
#### on_place_seed
```lua
```
#### place_seed
```lua
```
#### register_harvest
```lua
```
#### register_hoe
```lua
```
#### register_plant
```lua
```
#### register_plant
```lua
```
#### register_plant_steps
```lua
```
#### register_seed
```lua
```
#### tick
```lua
```

Fences 
------
#### register_fence
```lua
```
#### register_gate
```lua
```
#### register_mesepost
```lua
```
#### register_post
```lua
```
#### register_rail
```lua
```

Fire 
------
#### flame_on_timer
```lua
```
#### flood_flame
```lua
```
#### on_use_lighter
```lua
```
#### register_node
```lua
```
#### remove_flammable
```lua
```
#### update_sounds_around
```lua
```

Flowers 
------
#### flower_spread
```lua
```
#### mushroom_spread
```lua
```
#### on_place_waterlily
```lua
```
#### register_decoration
```lua
```
#### register_flower
```lua
```
#### register_mushroom
```lua
```
#### register_waterlily
```lua
```

Formspecs 
------
#### create_listcolors
```lua
```
#### create_prepend
```lua
```
#### get_hotbar_bg
```lua
```

Furnaces 
------
#### allow_metadata_inventory_move
```lua
```
#### allow_metadata_inventory_put
```lua
```
#### allow_metadata_inventory_take
```lua
```
#### can_dig
```lua
```
#### get_active_formspec
```lua
```
#### node_timer
```lua
```
#### on_blast
```lua
```
#### on_construct
```lua
```
#### on_metadata_inventory
```lua
```
#### on_metadata_inventory_move
```lua
```
#### on_metadata_inventory_put
```lua
```
#### register_furnace
```lua
```
#### swap_node
```lua
```

Glass 
------
#### register_glass
```lua
```


Grasses 
------
#### dig_up
```lua
```
#### on_place
```lua
```
#### register_decoration
```lua
```
#### register_grass
```lua
```
#### register_grass_set
```lua
```

Hydrophytes 
------
#### after_destruct
```lua
```
#### on_place
```lua
```
#### register_coral
```lua
```
#### register_decoration
```lua
```
#### register_phyte
```lua
```
#### register_phyte_set
```lua
```


Initial Stuff 
------
#### add
```lua
```
#### add_from_csv
```lua
```
#### clear
```lua
```
#### give
```lua
```


Ladders 
------
#### register_ladder
```lua
```


Lights 
------
#### on_flood
```lua
```
#### register_torch
```lua
```
#### register_torch_ceiling
```lua
```
#### register_torch_floor
```lua
```
#### register_torch_wall
```lua
```

Liquids 
------
#### register_liquid
```lua
```
#### register_liquid_node
```lua
```


Magnifiers 
------
#### register_magnifier
```lua
```
#### update_fov
```lua
```
#### update_player_property
```lua
```


Maps 
------
#### update_hud_flags
```lua
```


Mounts 
------
#### attach
```lua
```
#### attached
```lua
```
#### detach
```lua
```
#### detach_all
```lua
```
#### drive
```lua
```
#### force_detach
```lua
```
#### get_staticdata
```lua
```
#### get_velocity
```lua
```
#### on_activate
```lua
```
#### on_place
```lua
```
#### on_punch
```lua
```
#### on_rightclick
```lua
```
#### on_step
```lua
```
#### register_craftitem
```lua
```
#### register_entity
```lua
```
#### register_mount
```lua
```
    

Ores 
------
#### register_blob_ores
```lua
```
#### register_block
```lua
```
#### register_crystal
```lua
```
#### register_crystal_item
```lua
```
#### register_fragment
```lua
```
#### register_ingot
```lua
```
#### register_lump
```lua
```
#### register_metal
```lua
```
#### register_mineral
```lua
```
#### register_ore
```lua
```
#### register_scatter_ores
```lua
```


Permissions 
------
#### can_interact_with_node
```lua
```
#### correct_key
```lua
```
#### create_key
```lua
```
#### generate_secret
```lua
```


Players 
------
#### calculate_knockback
```lua
```
#### get_animation
```lua
```
#### register_model
```lua
```
#### set_animation
```lua
```
#### set_model
```lua
```
#### set_textures
```lua
```

Pterygota 
------
#### catch
```lua
```
#### on_place
```lua
```
#### on_timer_bright
```lua
```
#### on_timer_dark
```lua
```
#### register_deco
```lua
```
#### register_hidden
```lua
```
#### register_pterygota
```lua
```
#### register_visible
```lua
```

Rand 
------
#### az
```lua
```
#### dy
```lua
```
#### pick
```lua
```
#### seq
```lua
```
#### xdy
```lua
```


Screwdrivers 
------
#### check_attached_node
```lua
```
#### exzet
```lua
```
#### facedir
```lua
```
#### handler
```lua
```
#### register_screwdriver
```lua
```
#### rotate
```lua
```
#### wallmounted
```lua
```

Seats API
---------
#### attach
```lua
```
#### attached
```lua
```
#### detach
```lua
```
#### detach_on
```lua
```
#### detach_all
```lua
```
#### force_detach
```lua
```
#### on_activate
```lua
```
#### on_detach_child
```lua
```
#### on_rightclick
```lua
```

Inv Utils API 
-------------

#### get_inventory_drops
Copies the items of the inventory list listname in the inventory at pos as 
tables into the output table drops.
```txt
craft.get_inventory_drops(pos, listname, drops)`  
pos     : Position
list    : Listname
drops   : Table
```

sfCraftguide
------
#### execute_search
```lua
```
#### extract_groups
```lua
```
#### get_craftable_recipes
```lua
```
#### get_formspecs
```lua
```
#### groups_to_item
```lua
```
#### is_fuel
```lua
```
#### item_button_fs
```lua
```
#### item_has_groups
```lua
```
#### on_receive_fields
```lua
```
#### recipe_fs
```lua
```
#### show_item
```lua
```

sfinv
-----
#### get_formspec
```lua
```
#### get_nav_fs
```lua
```
#### get_or_create_context
```lua
```
#### get_page
```lua
```
#### make_formspec
```lua
```
#### override_page
```lua
```
#### register_page
```lua
```
#### set_context
```lua
```
#### set_page
```lua
```
#### set_player_inventory_formspec
```lua
```

Signs 
------
#### on_construct
```lua
```
#### on_receive_fields
```lua
```
#### register_sign
```lua
```

Sounds 
------
#### get_defaults
```lua
```
#### register_defaults
```lua
```

Stairs 
------
#### on_place_slab
```lua
```
#### on_place_stair
```lua
```
#### register_all
```lua
```
#### register_fuel
```lua
```
#### register_glass_all
```lua
```
#### register_glass_stair_and_slab
```lua
```
#### register_glass_step_nodes
```lua
```
#### register_inner_stair
```lua
```
#### register_inner_step
```lua
```
#### register_outer_stair
```lua
```
#### register_outer_step
```lua
```
#### register_slab
```lua
```
#### register_stair
```lua
```
#### register_stair_and_slab
```lua
```
#### register_step
```lua
```
#### register_step_crafts
```lua
```
#### register_step_nodes
```lua
```
#### register_steps
```lua
```
#### register_steps_half
```lua
```
#### register_steps_slab
```lua
```
#### rotate_and_place
```lua
```

T4b
---
#### count
```lua
```

Tools 
------
#### register_axe
```lua
```
#### register_pick
```lua
```
#### register_set
```lua
```
#### register_shovel
```lua
```
#### register_sword
```lua
```

Trees 
------
#### after_place_leaves
```lua
```
#### can_grow
```lua
```
#### leafdecay_after_destruct
```lua
```
#### leafdecay_on_timer
```lua
```
#### register_bush
```lua
```
#### register_bush_decoration
```lua
```
#### register_bush_stem
```lua
```
#### register_leaves
```lua
```
#### register_sapling
```lua
```
#### register_tree
```lua
```
#### register_tree_decoration
```lua
```
#### register_tree_node
```lua
```
#### register_wood
```lua
```
#### sapling_on_place
```lua
```

Vessels 
------
#### register_bottle
```lua
```
#### register_glass
```lua
```

Walls 
------
#### register_wall
```lua
```


xPanes 
------
#### connects_dir
```lua
```
#### register_pane
```lua
```
#### swap
```lua
```
#### update_pane
```lua
```

