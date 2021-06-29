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
