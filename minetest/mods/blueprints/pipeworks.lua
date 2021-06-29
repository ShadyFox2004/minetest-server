--
-- Minetest blueprints mod: Pipeworks integration
--

-- Filters
local rules = {
    allowed   = true,
    param2    = true,
    meta      = true,
    inv_lists = {'main'}
}

blueprints.easy_override('blueprints:pipeworks_filter', {
    'pipeworks:filter', 'pipeworks:mese_filter', 'pipeworks:digiline_filter'
}, rules)

-- Alias "old-style" tubes
local alias_pipeworks_tube = function(basename, no_underscore)
    local _ = '_'
    if no_underscore then _ = '' end
    local name0 = basename .. _ .. '000000'
    for a = 0, 1 do
        local name1 = basename .. _ .. a
        for b = 0, 1 do
            local name2 = name1 .. b
            for c = 0, 1 do
                local name3 = name2 .. c
                for d = 0, 1 do
                    local name4 = name3 .. d
                    for e = 0, 1 do
                        local name5 = name4 .. e
                        for f = 0, 1 do
                            local name = name5 .. f
                            blueprints.register_alias(name, name0)
                        end
                    end
                end
            end
        end
    end
    return name0
end

-- Sorting tubes
rules.inv_lists = {'line1', 'line2', 'line3', 'line4', 'line5', 'line6'}
local tubes = {'pipeworks:mese_tube', 'pipeworks:lua_tube'}
for _, tube in ipairs(tubes) do
    local sane = false
    if minetest.registered_items[tube .. '000000'] then
        sane = true
    elseif minetest.registered_items[tube .. '_000000'] then
        sane = '_'
    end

    if sane then
        print(' - ' .. tube)
        tubes[_] = alias_pipeworks_tube(tube, sane ~= '_')
    end
end
blueprints.easy_override('blueprints:pipeworks_tube', tubes, rules)
tubes = nil

-- Autocrafters
rules.inv_lists = {'recipe', 'output'}
blueprints.easy_override('blueprints:pipeworks_autocrafter',
    'pipeworks:autocrafter', rules)

-- Disable teleportation tube blueprinting
if minetest.registered_nodes['pipeworks:teleport_tube_1'] then
    minetest.override_item('pipeworks:teleport_tube_1', {
        _blueprints = {
            allowed = false
        }
    })
end
