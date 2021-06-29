--
-- Minetest blueprints mod: Register blueprint items
--

-- Create image name from item name
local function image_from_item(name)
    return name:gsub(':', '_') .. '.png'
end

-- Handle on_use for non-blank blueprints.
blueprints.on_use = function(itemstack, user, pointed_thing)
    user = user:get_player_name()
    if pointed_thing.type ~= 'node' then
        if user then
            minetest.chat_send_player(user,
                'You can only apply blueprints to a node.')
        end
        return
    end
    local pos = pointed_thing.under
    if blueprints.check_protection(pos, user) then return end

    -- Sanity check on the blueprint
    local blueprint = itemstack:get_meta():get_string('blueprint')
    blueprint = minetest.deserialize(blueprint)
    if not blueprint or not blueprint.name then
        if user then
            minetest.chat_send_player(user, 'Invalid blueprint!')
        end
        return
    end

    -- Attempt to apply the blueprint
    local success   = blueprints.apply_blueprint(pos, blueprint, true)
    if not success and user then
        -- Check if the nodes match
        local node = minetest.get_node(pos)
        if node.name ~= blueprint.name then
            minetest.chat_send_player(user,
                'You can only apply this blueprint to "' .. blueprint.name
                .. '" nodes.')
        else
            minetest.chat_send_player(user,
                'The blueprint failed to be applied!')
        end
    end
end

-- Handle on_place for not-blank blueprints.
blueprints.on_place = function(itemstack, placer, pointed_thing)
    if not placer then return end
    local inv = placer:get_inventory()
    placer = placer:get_player_name()
    if #placer == 0 then placer = false end
    if pointed_thing.type ~= 'node' then
        if placer then
            minetest.chat_send_player(placer,
                'You can only place blueprints on a node.')
        end
        return
    end

    -- Check protection
    local pos       = pointed_thing.above
    if blueprints.check_protection(pos, placer) then return end

    -- Validate the blueprint
    local blueprint = itemstack:get_meta():get_string('blueprint')
    blueprint = minetest.deserialize(blueprint)
    if not blueprint or not blueprint.name then
        if placer then
            minetest.chat_send_player(placer, 'Invalid blueprint!')
        end
        return
    end

    if not inv:contains_item('main', blueprint.name) then
        if placer then
            minetest.chat_send_player(placer,
                'You do not have enough items to place this blueprint.')
        end
        return
    end

    local success   = blueprints.apply_blueprint(pos, blueprint)
    if success then
        inv:remove_item('main', blueprint.name)
    elseif placer then
        minetest.chat_send_player(placer,
            'The blueprint failed to be applied!')
    end
end

-- Register non-blank blueprints.
blueprints.register_blueprint = function(name, def)
    -- Set the on_use and add a blueprints group
    if not def then def = {} end
    if not def.groups then def.groups = {} end
    if not def.description then
        def.description = 'Blueprint'
    end
    def.on_use   = blueprints.on_use
    def.on_place = blueprints.on_place
    def.groups.blueprint = 1
    def.groups.not_in_creative_inventory = 1
    def.stack_max = 1

    local blank = 'blueprints:blank'
    if def._blank then
        blank = def._blank
        def._blank = nil
    end

    if not def.inventory_image then
        def.inventory_image = image_from_item(blank) .. '^' ..
            image_from_item(name)
    end

    -- Register the craftitem
    minetest.register_craftitem(name, def)

    -- Allow the blueprint to be crafted back to the empty one.
    minetest.register_craft({
        output = blank,
        type   = 'shapeless',
        recipe = {name}
    })
end

-- Register blank blueprints
blueprints.blank_on_use = function(itemstack, user, pointed_thing)
    if user and type(user) ~= 'string' then user = user:get_player_name() end
    if pointed_thing.type ~= 'node' then
        if user then
            minetest.chat_send_player(user,
                'You can only take blueprints of nodes.')
        end
        return
    end

    -- Get the blueprint rules
    local pos   = pointed_thing.under
    if blueprints.check_protection(pos, user) then return end
    local node  = minetest.get_node(pos)
    node.name = blueprints.check_alias(node.name)
    local rules = blueprints.get_rules(node)

    -- Is the node allowed to become a blueprint?
    if not rules.allowed then
        if user then
            minetest.chat_send_player(user,
                'You cannot take a blueprint of that node.')
        end
        return
    end

    -- Take the blueprint
    local blueprint = blueprints.get_blueprint(pos)
    if not blueprint then
        if user then
            minetest.chat_send_player(user,
                'Error taking the blueprint.')
        end
        return
    end

    -- Add it to an itemstack
    local stack = ItemStack(rules.item)
    local meta  = stack:get_meta()
    meta:set_string('blueprint', blueprint)
    meta:set_string('description',
        minetest.registered_nodes[node.name].description .. ' blueprint')
    return stack
end

-- Register blank blueprints.
blueprints.register_blank_blueprint = function(name, def)
    -- Set the on_use and add a blueprints group
    if not def.groups then def.groups = {} end
    def.on_use = blueprints.blank_on_use
    def.groups.blank_blueprint = 1
    def.stack_max = 1

    if not def.inventory_image then
        def.inventory_image = image_from_item(name)
    end

    -- Register the craftitem
    minetest.register_craftitem(name, def)
end

-- Create an easy node overriding function
blueprints.easy_override = function(blueprintname, names, raw_rules)
    if type(names) == 'string' then names = {names} end

    -- Copy the rules table and add the blueprint name to the rules.
    local rules = {}
    if raw_rules then
        for k, v in pairs(raw_rules) do
            if blueprints.default_rules[k] ~= nil then
                rules[k] = v
            end
        end
    end
    rules.item = blueprintname

    -- Override all the nodes that exist.
    local o = false
    for _, name in ipairs(names) do
        if minetest.registered_nodes[name] then
            o = true
            minetest.override_item(name, {_blueprints = rules})
        end
    end

    -- Create the blueprint if required.
    if o then
        blueprints.register_blueprint(blueprintname)
    end
end
