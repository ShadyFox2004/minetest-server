-- Load support for Minebase translation.
local S = minetest.get_translator("buckets_water")

buckets.register_liquid("buckets_water:bucket", {
	description = S("Water Bucket"),
	source = "base_liquids:water_source",
	flowing = "base_liquids:water_flowing",
	groups = {tool = 1, water_bucket = 1}
})

