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
