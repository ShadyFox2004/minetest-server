-- liquids_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("water_flowing", "base_liquids:water_flowing")
minetest.register_alias("water_source", "base_liquids:water_source")
minetest.register_alias("lava_flowing", "base_liquids:lava_flowing")
minetest.register_alias("lava_source", "base_liquids:lava_source")
minetest.register_alias("snow", "base_liquids:snow")
minetest.register_alias("cloud", "base_liquids:cloud")

minetest.register_alias("default:ice", "base_liquids:ice")
minetest.register_alias("default:cave_ice", "base_liquids:ice")
minetest.register_alias("default:lava_flowing", "base_liquids:lava_flowing")
minetest.register_alias("default:lava", "base_liquids:lava")
minetest.register_alias("default:lava_source", "base_liquids:lava_source")
minetest.register_alias("default:river_water_flowing", 
	"base_liquids:river_water_flowing")
minetest.register_alias("default:river_water_source", 
	"base_liquids:river_water_source")
minetest.register_alias("default:snowball", "base_liquids:snowball")
minetest.register_alias("default:snowblock", "base_liquids:snow_block")
minetest.register_alias("default:snow", "base_liquids:snow")
minetest.register_alias("default:cloud", "base_liquids:cloud")
minetest.register_alias("default:dirt_with_snow", "base_liquids:dirt_with_snow")
minetest.register_alias("default:water_flowing", "base_liquids:water_flowing")
minetest.register_alias("default:water_source", "base_liquids:water_source")
minetest.register_alias("default:obsidian", "base_liquids:obsidian")
minetest.register_alias("default:obsidian_block", "base_liquids:obsidian_block")
minetest.register_alias("default:obsidianbrick", "base_liquids:obsidian_brick")
