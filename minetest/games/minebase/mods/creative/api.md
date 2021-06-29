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
