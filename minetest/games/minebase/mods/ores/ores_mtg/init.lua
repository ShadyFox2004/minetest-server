-- ores_mtg/init.lua

-- Aliases to support loading worlds using nodes following the old naming convention
-- These can also be helpful when using chat commands, for example /giveme
minetest.register_alias("stone_with_coal", "base_ores:coal_mineral")
minetest.register_alias("stone_with_iron", "base_ores:iron_mineral")
minetest.register_alias("mese", "base_ores:mese_mineral")
minetest.register_alias("steelblock", "base_ores:steel_block")
minetest.register_alias("lump_of_coal", "base_ores:coal_lump")
minetest.register_alias("lump_of_iron", "base_ores:iron_lump")
minetest.register_alias("steel_ingot", "base_ores:steel_ingot")

-- 'mese_block' was used for a while for the block form of mese
minetest.register_alias("default:mese_block", "base_ores:mese_block")

--
minetest.register_alias("default:stone_with_coal", "base_ores:coal_mineral")
minetest.register_alias("default:coal_lump", "base_ores:coal_lump")
minetest.register_alias("default:coalblock", "base_ores:coal_block")

minetest.register_alias("default:stone_with_copper", "base_ores:copper_mineral")
minetest.register_alias("default:copper_lump", "base_ores:copper_lump")
minetest.register_alias("default:copper_ingot", "base_ores:copper_ingot")
minetest.register_alias("default:copperblock", "base_ores:copper_block")

minetest.register_alias("default:stone_with_gold", "base_ores:gold_mineral")
minetest.register_alias("default:gold_lump", "base_ores:gold_lump")
minetest.register_alias("default:gold_ingot", "base_ores:gold_ingot")
minetest.register_alias("default:goldblock", "base_ores:gold_block")

minetest.register_alias("default:stone_with_tin", "base_ores:tin_mineral")
minetest.register_alias("default:tin_lump", "base_ores:tin_lump")
minetest.register_alias("default:tin_ingot", "base_ores:tin_ingot")
minetest.register_alias("default:tinblock", "base_ores:tin_block")

minetest.register_alias("default:stone_with_iron", "base_ores:iron_mineral")
minetest.register_alias("default:iron_lump", "base_ores:iron_lump")
minetest.register_alias("default:steel_ingot", "base_ores:steel_ingot")
minetest.register_alias("default:steelblock", "base_ores:steel_block")

minetest.register_alias("default:bronze_ingot", "base_ores:bronze_ingot")
minetest.register_alias("default:bronzeblock", "base_ores:bronze_block")

minetest.register_alias("default:stone_with_mese", "base_ores:mese_mineral")
minetest.register_alias("default:mese_crystal", "base_ores:mese_crystal")
minetest.register_alias("default:mese_crystal_fragment", 
	"base_ores:mese_crystal_fragment")
minetest.register_alias("default:mese", "base_ores:mese_block")

minetest.register_alias("default:stone_with_diamond", 
	"base_ores:diamond_mineral")
minetest.register_alias("default:diamond", "base_ores:diamond_crystal")
minetest.register_alias("default:diamondblock", "base_ores:diamond_block")
