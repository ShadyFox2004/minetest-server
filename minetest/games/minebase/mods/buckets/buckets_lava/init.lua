-- Load support for Minebase translation.
local S = minetest.get_translator("buckets_lava")

buckets.register_liquid("buckets_lava:bucket", {
	description = S("Lava Bucket"),
	source = "base_liquids:lava_source",
	flowing = "base_liquids:lava_flowing",
	groups = {tool = 1}
})

minetest.register_craft({
	type = "fuel",
	recipe = "buckets_lava:bucket",
	burntime = 60,
	replacements = {{"buckets_lava:bucket", "buckets_api:bucket_empty"}},
})

