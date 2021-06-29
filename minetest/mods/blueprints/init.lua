--
-- Minetest blueprints mod
--
-- © 2018 by luk3yx
--

local path = minetest.get_modpath('blueprints')

-- Load the core functions
dofile(path .. '/core.lua')

-- Add the registering API
dofile(path .. '/register.lua')

-- Register the default blueprints
blueprints.register_blank_blueprint('blueprints:blank', {
    description = 'Blank blueprint'
})
blueprints.register_blueprint('blueprints:print')

-- Crafting
if minetest.get_modpath('basic_materials') then
    minetest.register_craft({
        output = 'blueprints:blank',
        recipe = {
            {'basic_materials:plastic_strip', 'basic_materials:plastic_strip',
                'basic_materials:plastic_strip'},
            {'basic_materials:plastic_strip', 'default:paper',
                'basic_materials:plastic_strip'},
            {'basic_materials:plastic_strip', 'basic_materials:plastic_strip',
                'basic_materials:plastic_strip'}
        }
    })
end

-- Pipeworks integration
if minetest.get_modpath('pipeworks') then
    dofile(path .. '/pipeworks.lua')
end

-- Mesecons integration
if minetest.get_modpath('mesecons') then
    dofile(path .. '/mesecons.lua')
end
