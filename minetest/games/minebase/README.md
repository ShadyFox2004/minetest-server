Minebase
========

Minebase is a game for the Minetest Engine. It is a fork of Minetest Game and 
thus shares many features with it, but much of the code was refactored to 
address the discontent with it. This implies that many mods made for Minetest
Game won't work in this game. You have to check the dependencies of the mods to
be sure. If a mod depends on default or another mod that has been removed or 
changed significantly, you will get error messages.  
Similar to Minetest Game, this game is a base for modding. I am going to add 
mods with new features, but mods like "More Trees" or "Minetest Game Plus" are 
not going to be added. 
Regarding mods quality is more important than quantity. In case you like to mod 
and want to contribute to this project, use the appropriate tools on Gitlab.

Version 0.1.0.0 is the first release.

API Documentation
-----------------
I started to write documentations for the APIs of the modules, but stopped doing 
so because nearly nobody showed interest in the game. If people start playing 
it, I am going to work on it again.

Installation
------------

Unzip the archive, rename the folder to minebase and place it in a games folder. 
A more extensive explanation can be found [here](https://wiki.minetest.net/Games#Installing_games).

The Minetest engine can be found at [GitHub](https://github.com/minetest/minetest).

Compatibility
-------------

It is possible to convert a Minetest Game world to a Minebase world, but I 
didn't write a script to convert a Minebase world back. That is the reason why
you should create a backup before converting your world. Keep in mind that some 
mods made for Minetest Game, won't run with Minebase.  
This game does not support v6.  
legacy.lua was dropped.  
TNT was removed because I want the theme of this game to be more medieval.  

Contributing
------------

In case you want to contribute to this game, the code should be structured 
similar to the modpacks already included. The modpack should at least 
consist of two mods, one that provides an API and a second mod using it.
Registry functions that directly or indirectly rely on one of the 
minetest.register_\* functions, should expect two arguments, the name and a 
definition as a table.
If you spot bugs or want to improve the code otherwise, feel free to open 
issues.

Versioning 
----------

This project uses a modified version of [SemVer](https://semver.org/) for 
version numbers. In addition to a major, minor and patch number there is a 
age number. On every birthday this number is incremented and all other numbers 
are reset to 0 (Age.Major.Minor.Patch).
The birthday is the day of my first commit to this repository on Nov 1 2020. It
was a Sunday at 12:27:53 to be exact.

Links
---------

- [LICENSE.txt](./LICENSE.txt)
