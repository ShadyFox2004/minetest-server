Contributing
------------

In case you want to contribute to this game, the code should be structured 
similar to the modpacks already included. The modpack should at least 
consist of two mods, one that provides an API and a second mod using it.
Registry functions that directly or indirectly rely on one of the 
minetest.register_\* functions, should except two arguments, the name and a 
definition as a table.
If you spot bugs or want to improve the code otherwise, feel free to open 
issues.

