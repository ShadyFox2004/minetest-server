<center>
    <h1>Blueprints API</h1>
    <img src="blueprint-types.png" alt=" " />
</center>

## Blueprint rules

Blueprint rules define how nodes can be blueprinted. They are just a table with
the following parameters:

 - `allowed`: Specifies whether the item is allowed to be blueprinted
    (`true`, `false` or `'default'`). If this is `'default'`, the item will be
    blueprinted if it is visible in the creative inventory (does not have the
    `not_in_creative_inventory` group).
 - `param2`: Allows the node's param2 to be saved in the blueprint. Defaults to
    `true`.
 - `meta`: Allows the node's metadata to be copied. Can either be `true` to
    allow everything to be copied, or a table with a list of metadata strings
    to copy.
 - `pvmeta`: A table containing a list of metadata strings to mark as private
    when restoring from the blueprint.
 - `inv_lists`: A table containing the inventory lists to be copied.
 - `item`: A custom blueprint item to give the player when blueprinting the
    object. Made with `blueprints.register_blueprint()`.

*All parameters are optional, and will default to the ones specified in
`core.lua`.*

To modify these rules for your node, you can add a `_blueprints` field to your
node's definition with a table containing any of the above parameters. Unknown
rules will be silently ignored.

## Functions

The following API functions exist, where the `node` parameter is normally a
`string`:

### Node rules and aliases

 - `blueprints.get_rules(node)`: Gets a rules table for the node specified.
    You should not modify this table, as you may inadvertently modify the
    default rules. The `allowed` parameter will always be returned with either
    `true` or `false`, the value for `'default'` will be calculated when this
    is called.
 - `blueprints.register_alias(old_node, new_node)`: This will make blueprints
    treat `old_node` as the same as `new_node` internally. Blueprints made with
    `new_node` can be applied to `old_node`s, and the blueprint rules of
    `new_node` will be used for `old_node` as well.
 - `blueprints.check_alias(node)`: Checks for node aliases, will return `node`
    if no alias exists. Nodes registered with `mesecon.register_node` will be
    auto-aliased (`_on` to `_off`), however this can be overridden by adding
    a new alias. Aliases are not recursive.

### Creating/applying blueprint strings/tables.

 - `blueprints.get_blueprint(pos, raw = false, force = false)`: Returns a
    blueprint string (or table if raw is true) for the object. If the node
    cannot be blueprinted, this will return `nil`. If `force` is `true`, the
    rules will be ignored and the entire node will be blueprinted.
 - `blueprints.apply_blueprint(pos, blueprint, only_if_exists = false, force = false)`:
    Applies the blueprint `blueprint` at `pos`, the blueprint specified may be
    a string or table. Returns `true` on success or `nil` on faliure. If `force`
    is `true`, the rules will be ignored when applying the blueprint. This must
    also have been `true` when `get_blueprint` was called.

### Other possibly useful function(s).
 - `blueprints.check_protection(pos, name)`: Checks the protection at `pos` for
    `name`, automatically recording a violation if one exists. Returns `true`
    and records a violation if `name` has no access to `pos`, otherwise returns
    `false`.

### Registering blueprints.
 - `blueprints.register_blueprint(name, def)`: Registers a non-blank blueprint.
    `def` is optional, and if left out, sensible defaults will be used. Any
    parameters valid with craftitems should work here, however `on_use`,
    `on_place`, `stack_max` and a few others may be overridden. If
    `inventory_image` is not specified, one will be generated based on the node
    name (for example `blueprints:test_blueprint` would become
    `blueprints_test_blueprint.png`) and are overlayed on top of the empty
    blueprint texture. If you want to use a custom blank blueprint, you can
    specify the `blank` parameter in the table.
 - `bluepritns.register_blank_blueprint(name, def)`: The same as
    `reigster_blueprint`, except for blank blueprints. `blank` should not be
    specified here, and a `def` containing `description` is mandatory.
