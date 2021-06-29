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
