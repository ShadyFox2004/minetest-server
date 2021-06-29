-- Load support for Minebase translation.
local S = minetest.get_translator("buckets_river_water")

-- River water source is 'liquid_renewable = false' to avoid horizontal spread
-- of water sources in sloping rivers that can cause water to overflow
-- riverbanks and cause floods.
-- River water source is instead made renewable by the 'force renew' option
-- used here.

buckets.register_liquid("buckets_river_water:bucket", {
	description = S("River Water Bucket"),
	source = "base_liquids:river_water_source",
	flowing = "base_liquids:river_water_flowing",
	groups = {tool = 1, water_bucket = 1},
	force_renew = true
})

