-- earth_stairs/init.lua

-- Load support for Minebase translation.
local S = minetest.get_translator("earth_stairs")

stairs.register_all("earth_stairs:stone", {
	material = "base_earth:stone",
	groups = {cracky = 3},
	tiles = {"base_earth_stone.png"},
	stair_description = S("Stone Stair"),
	slab_description = S("Stone Slab"),
	inner_stair_description = S("Inner Stone Stair"),
	outer_stair_description = S("Outer Stone Stair"),
	step_description = S("Stone Step"),
	inner_step_description = S("Inner Stone Step"),
	outer_step_description = S("Outer Stone Step"),
	steps_description = S("Stone Steps"),
	steps_half_description = S("Stone Steps Half"),
	steps_slab_description = S("Stone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:stone_cobble", {
	material = "base_earth:stone_cobble",
	groups = {cracky = 3},
	tiles = {"base_earth_stone_cobble.png"},
	stair_description = S("Cobblestone Stair"),
	slab_description = S("Cobblestone Slab"),
	inner_stair_description = S("Inner Cobblestone Stair"),
	outer_stair_description = S("Outer Cobblestone Stair"),
	step_description = S("Cobblestone Step"),
	inner_step_description = S("Inner Cobblestone Step"),
	outer_step_description = S("Outer Cobblestone Step"),
	steps_description = S("Cobblestone Steps"),
	steps_half_description = S("Cobblestone Steps Half"),
	steps_slab_description = S("Cobblestone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:stone_brick", {
	material = "base_earth:stone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_stone_brick.png"},
	stair_description = S("Stone Brick Stair"),
	slab_description = S("Stone Brick Slab"),
	inner_stair_description = S("Inner Stone Brick Stair"),
	outer_stair_description = S("Outer Stone Brick Stair"),
	step_description = S("Stone Brick Step"),
	inner_step_description = S("Inner Stone Brick Step"),
	outer_step_description = S("Outer Stone Brick Step"),
	steps_description = S("Stone Brick Steps"),
	steps_half_description = S("Stone Brick Steps Half"),
	steps_slab_description = S("Stone Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("earth_stairs:stone_block", {
	material = "base_earth:stone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_stone_block.png"},
	stair_description = S("Stone Block Stair"),
	slab_description = S("Stone Block Slab"),
	inner_stair_description = S("Inner Stone Block Stair"),
	outer_stair_description = S("Outer Stone Block Stair"),
	step_description = S("Stone Block Step"),
	inner_step_description = S("Inner Stone Block Step"),
	outer_step_description = S("Outer Stone Block Step"),
	steps_description = S("Stone Block Steps"),
	steps_half_description = S("Stone Block Steps Half"),
	steps_slab_description = S("Stone Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:desert_stone", {
	material = "base_earth:desert_stone",
	groups = {cracky = 3},
	tiles = {"base_earth_desert_stone.png"},
	stair_description = S("Desert Stone Stair"),
	slab_description = S("Desert Stone Slab"),
	inner_stair_description = S("Inner Desert Stone Stair"),
	outer_stair_description = S("Outer Desert Stone Stair"),
	step_description = S("Desert Stone Step"),
	inner_step_description = S("Inner Desert Stone Step"),
	outer_step_description = S("Outer Desert Stone Step"),
	steps_description = S("Desert Stone Steps"),
	steps_half_description = S("Desert Stone Steps Half"),
	steps_slab_description = S("Desert Stone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:desert_stone_cobble", {
	material = "base_earth:desert_stone_cobble",
	groups = {cracky = 3},
	tiles = {"base_earth_desert_stone_cobble.png"},
	stair_description = S("Desert Cobblestone Stair"),
	slab_description = S("Desert Cobblestone Slab"),
	inner_stair_description = S("Inner Desert Cobblestone Stair"),
	outer_stair_description = S("Outer Desert Cobblestone Stair"),
	step_description = S("Desert Cobblestone Step"),
	inner_step_description = S("Inner Desert Cobblestone Step"),
	outer_step_description = S("Outer Desert Cobblestone Step"),
	steps_description = S("Desert Cobblestone Steps"),
	steps_half_description = S("Desert Cobblestone Steps Half"),
	steps_slab_description = S("Desert Cobblestone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:desert_stone_brick", {
	material = "base_earth:desert_stone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_stone_brick.png"},
	stair_description = S("Desert Stone Brick Stair"),
	slab_description = S("Desert Stone Brick Slab"),
	inner_stair_description = S("Inner Desert Stone Brick Stair"),
	outer_stair_description = S("Outer Desert Stone Brick Stair"),
	step_description = S("Desert Stone Brick Step"),
	inner_step_description = S("Inner Desert Stone Brick Step"),
	outer_step_description = S("Outer Desert Stone Brick Step"),
	steps_description = S("Desert Stone Brick Steps"),
	steps_half_description = S("Desert Stone Brick Steps Half"),
	steps_slab_description = S("Desert Stone Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("earth_stairs:desert_stone_block", {
	material = "base_earth:desert_stone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_stone_block.png"},
	stair_description = S("Desert Stone Block Stair"),
	slab_description = S("Desert Stone Block Slab"),
	inner_stair_description = S("Inner Desert Stone Block Stair"),
	outer_stair_description = S("Outer Desert Stone Block Stair"),
	step_description = S("Desert Stone Block Step"),
	inner_step_description = S("Inner Desert Stone Block Step"),
	outer_step_description = S("Outer Desert Stone Block Step"),
	steps_description = S("Desert Stone Block Steps"),
	steps_half_description = S("Desert Stone Block Steps Half"),
	steps_slab_description = S("Desert Stone Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:sandstone", {
	material = "base_earth:sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_sandstone.png"},
	stair_description = S("Sandstone Stair"),
	slab_description = S("Sandstone Slab"),
	inner_stair_description = S("Inner Sandstone Stair"),
	outer_stair_description = S("Outer Sandstone Stair"),
	step_description = S("Sandstone Step"),
	inner_step_description = S("Inner Sandstone Step"),
	outer_step_description = S("Outer Sandstone Step"),
	steps_description = S("Sandstone Steps"),
	steps_half_description = S("Sandstone Steps Half"),
	steps_slab_description = S("Sandstone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:sandstone_brick", {
	material = "base_earth:sandstone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_sandstone_brick.png"},
	stair_description = S("Sandstone Brick Stair"),
	slab_description = S("Sandstone Brick Slab"),
	inner_stair_description = S("Inner Sandstone Brick Stair"),
	outer_stair_description = S("Outer Sandstone Brick Stair"),
	step_description = S("Sandstone Brick Step"),
	inner_step_description = S("Inner Sandstone Brick Step"),
	outer_step_description = S("Outer Sandstone Brick Step"),
	steps_description = S("Sandstone Brick Steps"),
	steps_half_description = S("Sandstone Brick Steps Half"),
	steps_slab_description = S("Sandstone Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("earth_stairs:sandstone_block", {
	material = "base_earth:sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_sandstone_block.png"},
	stair_description = S("Sandstone Block Stair"),
	slab_description = S("Sandstone Block Slab"),
	inner_stair_description = S("Inner Sandstone Block Stair"),
	outer_stair_description = S("Outer Sandstone Block Stair"),
	step_description = S("Sandstone Block Step"),
	inner_step_description = S("Inner Sandstone Block Step"),
	outer_step_description = S("Outer Sandstone Block Step"),
	steps_description = S("Sandstone Block Steps"),
	steps_half_description = S("Sandstone Block Steps Half"),
	steps_slab_description = S("Sandstone Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:desert_sandstone", {
	material = "base_earth:desert_sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_desert_sandstone.png"},
	stair_description = S("Desert Sandstone Stair"),
	slab_description = S("Desert Sandstone Slab"),
	inner_stair_description = S("Inner Desert Sandstone Stair"),
	outer_stair_description = S("Outer Desert Sandstone Stair"),
	step_description = S("Desert Sandstone Step"),
	inner_step_description = S("Inner Desert Sandstone Step"),
	outer_step_description = S("Outer Desert Sandstone Step"),
	steps_description = S("Desert Sandstone Steps"),
	steps_half_description = S("Desert Sandstone Steps Half"),
	steps_slab_description = S("Desert Sandstone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:desert_sandstone_brick", {
	material = "base_earth:desert_sandstone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_sandstone_brick.png"},
	stair_description = S("Desert Sandstone Brick Stair"),
	slab_description = S("Desert Sandstone Brick Slab"),
	inner_stair_description = S("Inner Desert Sandstone Brick Stair"),
	outer_stair_description = S("Outer Desert Sandstone Brick Stair"),
	step_description = S("Desert Sandstone Brick Step"),
	inner_step_description = S("Inner Desert Sandstone Brick Step"),
	outer_step_description = S("Outer Desert Sandstone Brick Step"),
	steps_description = S("Desert Sandstone Brick Steps"),
	steps_half_description = S("Desert Sandstone Brick Steps Half"),
	steps_slab_description = S("Desert Sandstone Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("earth_stairs:desert_sandstone_block", {
	material = "base_earth:desert_sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_desert_sandstone_block.png"},
	stair_description = S("Desert Sandstone Block Stair"),
	slab_description = S("Desert Sandstone Block Slab"),
	inner_stair_description = S("Inner Desert Sandstone Block Stair"),
	outer_stair_description = S("Outer Desert Sandstone Block Stair"),
	step_description = S("Desert Sandstone Block Step"),
	inner_step_description = S("Inner Desert Sandstone Block Step"),
	outer_step_description = S("Outer Desert Sandstone Block Step"),
	steps_description = S("Desert Sandstone Block Steps"),
	steps_half_description = S("Desert Sandstone Block Steps Half"),
	steps_slab_description = S("Desert Sandstone Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:silver_sandstone", {
	material = "base_earth:silver_sandstone",
	groups = {crumbly = 1, cracky = 3},
	tiles = {"base_earth_silver_sandstone.png"},
	stair_description = S("Silver Sandstone Stair"),
	slab_description = S("Silver Sandstone Slab"),
	inner_stair_description = S("Inner Silver Sandstone Stair"),
	outer_stair_description = S("Outer Silver Sandstone Stair"),
	step_description = S("Silver Sandstone Step"),
	inner_step_description = S("Inner Silver Sandstone Step"),
	outer_step_description = S("Outer Silver Sandstone Step"),
	steps_description = S("Silver Sandstone Steps"),
	steps_half_description = S("Silver Sandstone Steps Half"),
	steps_slab_description = S("Silver Sandstone Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

stairs.register_all("earth_stairs:silver_sandstone_brick", {
	material = "base_earth:silver_sandstone_brick",
	groups = {cracky = 2},
	tiles = {"base_earth_silver_sandstone_brick.png"},
	stair_description = S("Silver Sandstone Brick Stair"),
	slab_description = S("Silver Sandstone Brick Slab"),
	inner_stair_description = S("Inner Silver Sandstone Brick Stair"),
	outer_stair_description = S("Outer Silver Sandstone Brick Stair"),
	step_description = S("Silver Sandstone Brick Step"),
	inner_step_description = S("Inner Silver Sandstone Brick Step"),
	outer_step_description = S("Outer Silver Sandstone Brick Step"),
	steps_description = S("Silver Sandstone Brick Steps"),
	steps_half_description = S("Silver Sandstone Brick Steps Half"),
	steps_slab_description = S("Silver Sandstone Brick Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = false
})

stairs.register_all("earth_stairs:silver_sandstone_block", {
	material = "base_earth:silver_sandstone_block",
	groups = {cracky = 2},
	tiles = {"base_earth_silver_sandstone_block.png"},
	stair_description = S("Silver Sandstone Block Stair"),
	slab_description = S("Silver Sandstone Block Slab"),
	inner_stair_description = S("Inner Silver Sandstone Block Stair"),
	outer_stair_description = S("Outer Silver Sandstone Block Stair"),
	step_description = S("Silver Sandstone Block Step"),
	inner_step_description = S("Inner Silver Sandstone Block Step"),
	outer_step_description = S("Outer Silver Sandstone Block Step"),
	steps_description = S("Silver Sandstone Block Steps"),
	steps_half_description = S("Silver Sandstone Block Steps Half"),
	steps_slab_description = S("Silver Sandstone Block Steps Slab"),
	sounds = sounds.get_defaults("earth_sounds:stone"),
	worldaligntex = true
})

