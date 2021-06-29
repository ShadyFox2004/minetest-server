Minebase mod: Tools API
==========================
See [license.txt](./license.txt) for license information.

Authors of source code
----------------------
Originally by celeron55, Perttu Ahola <celeron55@gmail.com> (LGPLv2.1+)  
Various Minetest developers and contributors (LGPLv2.1+)  
LibraSubtilis (LGPLv2.1+)

Authors of media (sounds)
----------------------------------------------------------
Everything not listed in here:
celeron55, Perttu Ahola <celeron55@gmail.com> (CC BY-SA 3.0)

```txt
Tool breaking sounds added by sofar: CC-BY-3.0
  base_tools_breaks.* - http://www.freesound.org/people/HerbertBoland/sounds/33206/
```

Capability Calculation
----------------------
The values of the tool sets on 06.12.2020 are: 

groupcaps
-	| cracky	| crumbly	| choppy	| snappy
--------|---------------|---------------|---------------|--------------
wood	|    ,    , 1.6	| 3.0, 1.6, 0.6	| , 3.0, 1.6	| , 1.6, 0.4
stone	|    , 2.0, 1.0	| 1.8, 1.2, 0.5	| 3.0, 2.0, 1.3	| , 1.4, 0.4
bronze	| 4.5, 1.8, 0.9	| 1.7, 1.1, 0.5	| 2.8, 1.7, 1.2	| 2.8, 1.3, 0.4
steel	| 4.0, 1.6, 0.8	| 1.5, 0.9, 0.4	| 2.5, 1.4, 1.0	| 2.5, 1.2, 0.4
mese	| 2.4, 1.2, 0.6	| 1.2, 0.6, 0.3	| 2.2, 1.0, 0.6	| 2.0, 1.0, 0.4
diamond	| 2.0, 1.0, 0.5	| 1.1, 0.5, 0.3	| 2.1, 0.9, 0.5	| 1.9, 0.9, 0.3
average	| 3.2, 1.5, 0.9	| 1.7, 1.0, 0.4	| 2.5, 1.7, 1.0	| 2.3, 1.2, 0.4

use, fleshy, full_punch_interval
-	| cracky	| crumbly	| choppy	| snappy
--------|---------------|---------------|---------------|--------------
wood	| 10, 2, 1.2	| 10, 2, 1.2	| 10, 2, 1.0	| 10, 2, 1.0
stone	| 20, 3, 1.3	| 20, 2, 1.4	| 20, 3, 1.2	| 20, 4, 1.2
bronze	| 20, 4, 1.0	| 25, 3, 1.1	| 20, 4, 1.0	| 25, 6, 0.8
steel	| 20, 4, 1.0	| 30, 3, 1.1	| 20, 4, 1.0	| 30, 6, 0.8
mese	| 20, 5, 0.9 	| 20, 4, 1.1	| 20, 6, 0.9	| 30, 7, 0.7
diamond	| 30, 5, 0.9	| 30, 4, 1.0	| 30, 7, 0.9	| 40, 8, 0.7
average	| 20, 4, 1.1	| 23, 3, 1.2	| 20, 4, 1.0	| 26, 6, 0.9

maxlevel, max_drop_level
-	| cracky	| crumbly	| choppy	| snappy
--------|---------------|---------------|---------------|--------------
wood	| 1, 0		| 1, 0		| 1, 0		| 1, 0 
stone	| 1, 0		| 1, 0		| 1, 0 		| 1, 0
bronze	| 2, 1		| 2, 1		| 2, 1		| 2, 1 
steel	| 2, 1		| 2, 1		| 2, 1		| 2, 1 
mese	| 3, 3		| 3, 3		| 3, 1		| 3, 1 
diamond	| 3, 3		| 3, 1		| 3, 1		| 3, 1 
average	| 2, 1		| 2, 1		| 2, 1		| 2, 1 

I use the best values as base values and create functions that calculate all
values with one given value x. If x is 1 the base values are used. If x is 
greater than 1, then the tool has better stats than the base values.

groupcaps  
use, fleshy, full_punch_interval  
maxlevel, max_drop_level
-	| cracky	| crumbly	| choppy	| snappy
--------|---------------|---------------|---------------|--------------
diamond	| 2.0, 1.0, 0.5	| 1.1, 0.5, 0.3	| 2.1, 0.9, 0.5	| 1.9, 0.9, 0.3
diamond	| 30, 5, 0.9	| 30, 4, 1.0	| 30, 7, 0.9	| 40, 8, 0.7
mese	| 3, 3		| 3, 3		| 3, 1		| 3, 1 

