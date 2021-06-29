--
-- Minetest blueprints mod: Core functions
--

blueprints = {}

-- Default rules
-- These may be overriden on a per-node basis using '_blueprints' in the node's
--  definition.
blueprints.default_rules = {
    -- allowed - Allows the node to be blueprint-ified. If this is 'default',
    --  it will only allow nodes that are in the creative inventory, and will
    --  be set to either true or false when blueprints.get_rules() is called.
    allowed   = 'default',

    -- param2 - Allows param2 to be saved in the blueprint.
    param2    = true,

    -- meta - Specifies which meta strings to save. This can be 'true' to save
    --  everything.
    -- meta      = {'formspec', 'infotext'},
    meta      = true,

    -- pvmeta - Specifies which meta strings to mark as private.
    pvmeta    = {},

    -- inv_lists - A list of inventory lists to be copied.
    inv_lists = {},

    -- item - The blueprint item to use.
    item      = 'blueprints:print'
}

-- Aliases - Allow multiple nodes to be treated internally as one.
local aliases = {}
blueprints.register_alias = function(old_node, new_node)
    aliases[old_node] = new_node
end

blueprints.check_alias = function(node)
    if aliases[node] then return aliases[node] end
    local def = minetest.registered_nodes[node]
    -- Mesecons integration
    if def and def.__mesecon_state and def.__mesecon_basename then
        node = def.__mesecon_basename .. '_off'
    end
    return node
end

blueprints.check_reverse_alias = function(new_node, old_node)
    return blueprints.check_alias(old_node) == new_node
end

-- Get a list of rules for a node.
blueprints.get_rules = function(node)
    if node and type(node) ~= 'string' then node = node.name end

    -- Check aliases
    node = blueprints.check_alias(node)

    -- Unknown nodes cannot be blueprinted.
    local def = false
    if node and node ~= 'ignore' then
        def = minetest.registered_nodes[node]
    end
    if not def then
        return {
            allowed   = false,
            param2    = false,
            meta      = {},
            pvmeta    = {},
            inv_lists = {},
            item      = 'blueprints:blank'
        }
    end

    -- Use the default rules
    local node_rules = def._blueprints
    if not node_rules then
        if def.groups and def.groups.not_in_creative_inventory then
            node_rules = {}
        else
            return blueprints.default_rules
        end
    end

    -- Replace any omitted values with the defaults.
    local rules = {}
    for k, v in pairs(blueprints.default_rules) do
        if node_rules[k] ~= nil then
            rules[k] = node_rules[k]
        else
            rules[k] = v
        end
    end

    -- Check for 'You hacker you!'
    if rules.allowed == 'default' then
        if def.groups and def.groups.not_in_creative_inventory then
            rules.allowed = false
        else
            rules.allowed = true
        end
    end

    return rules
end

-- Get a nicer inv_lists
local function get_inv_lists(rules)
    local inv_lists = {}
    if rules.inv_lists then
        for _, list in ipairs(rules.inv_lists) do
            inv_lists[list] = true
        end
    end
    return inv_lists
end

-- Get a blueprint string for a node.
blueprints.get_blueprint = function(pos, raw, force)
    -- Check aliases
    local node  = minetest.get_node(pos)
    node.name   = blueprints.check_alias(node.name)

    -- Get the rules list
    local rules
    local rules = blueprints.get_rules(node)
    if force then
        rules.meta = true
    elseif not rules.allowed then
        return
    end

    -- Using a meta table allows ints/floats/etc to be copied nicely.
    local blueprint = {name = node.name, pattern = rules.pattern}
    local metatable = minetest.get_meta(pos):to_table()

    -- Copy across allowed metadata fields
    if (rules.meta == true or #rules.meta > 0) and metatable.fields then
        if rules.meta == true then
            blueprint.meta = metatable.fields
        else
            blueprint.meta = {}
            for _, name in ipairs(rules.meta) do
                blueprint.meta[name] = metatable.fields[name]
            end
        end
    end

    -- Get a nicer inv_lists
    local inv_lists
    if not force then inv_lists = get_inv_lists(rules) end

    -- Copy allowed inventories
    if metatable.inventory then
        blueprint.inv = {}
        for listname, list in pairs(metatable.inventory) do
            blueprint.inv[listname] = {}
            for id, itemstack in ipairs(list) do
                if force or inv_lists[listname] then
                    blueprint.inv[listname][id] = itemstack:to_table() or ''
                else
                    blueprint.inv[listname][id] = ''
                end
            end
        end
    end

    -- Copy across param2
    if rules.param2 then
        blueprint.param2 = node.param2
    end

    -- Return the blueprint
    if not raw then
        blueprint = minetest.serialize(blueprint)
    end
    return blueprint
end

-- Apply blueprints (and double-check the allowed fields)
blueprints.apply_blueprint = function(pos, blueprint, only_if_exists, force)
    -- Deserialize if required and get the rules
    if type(blueprint) == 'string' then
        blueprint = minetest.deserialize(blueprint)
    end
    if not blueprint then return end

    -- Make sure the node exists
    if only_if_exists then
        local node = minetest.get_node(pos)
        if node.name ~= blueprint.name then
            -- "Un-alias" the blueprint.
            if blueprints.check_reverse_alias(blueprint.name, node.name) then
                blueprint.name = node.name
            else
                return
            end
        end
    end

    -- Get the rules
    local rules = blueprints.get_rules(blueprint)
    if not rules or (not rules.allowed and not force) then return end

    -- Set the node (and param2)
    local node = {name = blueprint.name}
    if rules.param2 and blueprint.param2 then
        node.param2 = blueprint.param2
    end
    minetest.set_node(pos, node)
    local metatable = {fields = {}, inventory = {}}

    -- Copy across allowed metadata fields
    if blueprint.meta and rules.meta then
        if rules.meta == true or force then
            metatable.fields = blueprint.meta
        else
            for _, name in ipairs(rules.meta) do
                metatable.fields[name] = blueprint.meta[name]
            end
        end
    end

    -- Copy allowed inventories
    if blueprint.inv then
        local inv_lists
        if not force then inv_lists = get_inv_lists(rules) end

        for name, inv in pairs(blueprint.inv) do
            metatable.inventory[name] = {}
            for id, item in ipairs(inv) do
                if not force and not inv_lists[name] then item = '' end
                metatable.inventory[name][id] = ItemStack(item)
            end
        end
    end

    -- Update the node meta
    local meta = minetest.get_meta(pos)
    meta:from_table(metatable)
    meta:mark_as_private(rules.pvmeta)
    return true
end

-- Protection check function
blueprints.check_protection = function(pos, name)
    if type(name) ~= 'string' then
        name = name:get_player_name()
    end

    if minetest.is_protected(pos, name) and
      not minetest.check_player_privs(name, {protection_bypass=true}) then
        minetest.record_protection_violation(pos, name)
        return true
    end

    return false
end
