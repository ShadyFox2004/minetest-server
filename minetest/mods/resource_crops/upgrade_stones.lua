minetest.register_craftitem("resource_crops:upgrade_stone_weak", {
	description = ("Weak Upgrade Stone"),
	inventory_image = "resource_crops_upgrade_stone_weak.png",
	stack_max = 1,
})
minetest.register_craft({
    output = "resource_crops:upgrade_stone_weak",
    recipe = {{"resource_crops:essence_dust", "resource_crops:essence_dust", "resource_crops:essence_dust"},
              {"resource_crops:essence_dust", "default:diamond", "resource_crops:essence_dust"},
              {"resource_crops:essence_dust", "resource_crops:essence_dust", "resource_crops:essence_dust"}},
})

minetest.register_craftitem("resource_crops:upgrade_stone_regular", {
	description = ("Regular Upgrade Stone"),
	inventory_image = "resource_crops_upgrade_stone_regular.png",
	stack_max = 1,
})
minetest.register_craft({
    output = "resource_crops:upgrade_stone_regular",
    recipe = {{"", "group:essence_weak", ""},
              {"group:essence_weak", "resource_crops:upgrade_stone_weak", "group:essence_weak"},
              {"", "group:essence_weak", ""}},
    replacements = {{"resource_crops:upgrade_stone_weak", "resource_crops:upgrade_stone_weak"}}
})

minetest.register_craftitem("resource_crops:upgrade_stone_strong", {
	description = ("Strong Upgrade Stone"),
	inventory_image = "resource_crops_upgrade_stone_strong.png",
	stack_max = 1,
})
minetest.register_craft({
    output = "resource_crops:upgrade_stone_strong",
    recipe = {{"", "group:essence_regular", ""},
              {"group:essence_regular", "resource_crops:upgrade_stone_regular", "group:essence_regular"},
              {"", "group:essence_regular", ""}},
    replacements = {{"resource_crops:upgrade_stone_regular", "resource_crops:upgrade_stone_regular"}}
})

minetest.register_craftitem("resource_crops:upgrade_stone_extreme", {
	description = ("Extreme Upgrade Stone"),
	inventory_image = "resource_crops_upgrade_stone_extreme.png",
	stack_max = 1,
})
minetest.register_craft({
    output = "resource_crops:upgrade_stone_extreme",
    recipe = {{"", "group:essence_strong", ""},
              {"group:essence_strong", "resource_crops:upgrade_stone_strong", "group:essence_strong"},
              {"", "group:essence_strong", ""}},
    replacements = {{"resource_crops:upgrade_stone_strong", "resource_crops:upgrade_stone_strong"}}
})
