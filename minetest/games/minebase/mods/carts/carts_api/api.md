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
