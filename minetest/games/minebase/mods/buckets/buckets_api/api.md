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
