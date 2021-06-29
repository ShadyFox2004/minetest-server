# Resource Crops

Resource Crops is a mod made by TwigGlenn4 that adds crops that grow resources to [Minetest](https://www.minetest.net/), 
a free and open source infinite world block sandbox game. This mod was inspired by the Mystical Agricutlure mod for Minecraft.

## Suggestions
You should install a crafting guide mod, such as [Unified Inventory](https://forum.minetest.net/viewtopic.php?t=3933)

Growing crops takes time, and getting higher teir crops is a very slow process.
If you do not want to wait as long, you can change the settings:

```
resourcecrops_growth_interval (growth interval) = 30
resourcecrops_growth_chance (growth chance) = 2
```

## Items & Nodes
### Essence Ore
Essence Ore is found between depths of -5 and -5000.
### Essence Harvester
The Essence Harvester will harvest a resource crop of any type, dropping the items under it on the crop. It must be placed above the crop it will harvest.
### Seeds
Seeds are placed on farmland, only grow when it is wet, and can be crafted into it's respective essence.
### Essences 
Essences are usually crafted into their results by filling the crafting grid.
### Elements
Mostly used as another way to get misc items. Fire essence can be crafted with an item to smelt it, 
but this only works with ores for the metals that have crops and all smelting recipies from *minetest_game*
### Inferno Stone
The Inferno Stone can be crafted with an item to get the twice the result of smelting that item, and you get the Inferno Stone back.
This only works on the same items as fire essence.
### Crops
Crops require a light level of at least 8, so they can grow in torchlight. You can punch a crop to harvest it, 
which drops it's items and resets the crop to it's first growth level.


## Config
The options have short descriptions found in the client interface settings or [`settingtypes.txt`](settingtypes.txt)
To change the config options of this mod, you have two options:

### Client Interface
1. With Minetest running, click the menu tab called "Settings".
2. Click the "Advanced Setting".
3. Open the "Mods" section.
4. Open the "resource_crops" subsection.
5. Change values as you wish!

### Text Editor & Server
1. Find "resourcecrops" in your "mods" folder.
2. Open "settingtypes.txt", copy options you want to change, but not the lines starting with "#".
3. Find "minetest.conf" in minetest's main folder, it might be beside the "mods" folder.
4. Paste the options you copied into minetest.conf, change them to your liking.

## Compat
### Mods
This mod alters the growth of crops from the *farming* mod in *minetest_game*. Cotton and wheat now have a 4-step growth cycle like the other added crops. 

If [More Ores](https://forum.minetest.net/viewtopic.php?t=549) 
or [Technic](https://forum.minetest.net/viewtopic.php?t=2538) 
are installed, their respective crops can be grown. if not, the crops are automatically disabled.

### Minetest
This mod works on minetest 0.4.16 and is compatible with the 5.0.0 update.
It might work on older versions if the required dependencies are installed, but I cannot guarantee it.

## License

- Resource Crops is licensed with the MIT license, see
  [`LICENSE.md`](LICENSE.md) for details.