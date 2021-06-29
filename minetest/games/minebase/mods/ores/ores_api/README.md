Minebase mod: Ores API
==========================
See [license.txt](./license.txt) for license information.

Authors of source code
----------------------
Originally by celeron55, Perttu Ahola <celeron55@gmail.com> (LGPLv2.1+)  
Various Minetest developers and contributors (LGPLv2.1+)  
LibraSubtilis (LGPLv3+)


Calculation
-----------

The values of the tool sets on 06.12.2020 are: 


-		| scarcity	| num_ores	| size	
----------------|---------------|---------------|----------
copper		|  9, 12,  9	|  5, 4,  5	| 3, 3, 3
gold		| 13, 15, 13	|  5, 3,  5	| 3, 2, 3
tin		| 10, 13, 10	|  5, 4,  5	| 3, 3, 3
coal		|  8,  8, 12	|  9, 8, 30	| 3, 3, 5
iron		|  9,  7, 12	| 12, 5, 29	| 3, 3, 5
diamond		| 15, 17, 15	|  4, 4,  4	| 3, 3, 3
mese		| 14, 18, 14	|  5, 3,  5	| 3, 2, 3
meseblock	| 36, 36, 28	|  3, 3,  5	| 2, 2, 3
average		| 15		| 7		| 3

-	| y_min			| y_max
--------|-----------------------|--------------------
copper	| 1025,  -127, -31000	| 31000,   -64,  -128
gold	| 1025,  -511, -31000	| 31000,  -256,  -512
tin	| 1025,  -127, -31000	| 31000,   -64,  -128
coal	| 1025,  -127, -31000	| 31000,    64,  -128
iron	| 1025,  -255, -31000	| 31000,  -128,  -256
diamond	| 1025, -2047, -31000	| 31000, -1024, -2048
mese	| 1025, -1023, -31000	| 31000,  -512, -1024
meseb.	| 1025, -4095, -31000	| 31000, -2048, -4096


I use values of diamond and mese as base values and create functions that 
calculate other values with one given value x. If x is 1 the base values are 
used. If x is greater than 1, then the ore is more rare and deeper located.

-	| scarcity	| num_ores	| size	
--------|---------------|---------------|-----------
diamond	| 15, 17, 15	| 4, 4, 4	| 3, 3, 3
mese	| 14, 18, 14	| 5, 3, 5	| 2, 2, 3
base	| 18		| 3		| 2
	
-	| y_min			| y_max
--------|-----------------------|-----------------
diamond	| 1025, -2047, -31000	| 31000, -1024, -2048
mese	| 1025, -1023, -31000	| 31000,  -512, -1024
base	| -31000		| -2048
