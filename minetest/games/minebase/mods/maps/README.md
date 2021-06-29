Minebase mod: Maps
==================
See [license.txt](./license.txt) for license information.

Usage
-----
In survival mode, use of the minimap requires the mapping kit item in your
inventory. It can take up to 5 seconds for adding to or removal from inventory
to have an effect, however to instantly allow the use of the minimap 'use'
(leftclick) the item.  
Minimap radar mode is always disallowed in survival mode.

Minimap and minimap radar mode are automatically allowed in creative mode and
for any player with the 'creative' privilege.

The `maps.update_hud_flags()` function is global so can be redefined by a mod for
alternative behaviour.

Crafting
--------
`maps:mapping_kit`  

`base_glass:common_glass`  
`base_books:paper`  
`group:stick`  
`base_ores:steel_ingot`  
`group:wood`  
`dye:black`

| 			| input	|		|	| output
|:---------------------:|:-----:|:-------------:|:-----:|:-----:
| Common Glass		| Paper	| Stick		|	| 	
| Steel Ingot		| Paper	| Steel Ingot	| &rarr;| Mapping Kit
| Wood			| Paper | Black Dye	| 	|


Authors of source code
----------------------
paramat (MIT)
LibraSubtilis (MIT)

Authors of media (textures)
---------------------------
```txt
TumeniNodes (CC BY-SA 3.0):
  maps_mapping_kit.png (map)

paramat (CC BY-SA 3.0):
  maps_mapping_kit.png (compass and pen)
```

