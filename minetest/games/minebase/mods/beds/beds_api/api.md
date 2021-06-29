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

