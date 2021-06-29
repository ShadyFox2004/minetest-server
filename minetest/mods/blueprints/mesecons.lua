--
-- Minetest blueprints mod: Mesecons integration
--

-- Microcontroller blueprints
local microcontrollers = {}
for _, rawname in ipairs({'fpga', 'microcontroller', 'luacontroller'}) do
    local basename = 'mesecons_' .. rawname .. ':' .. rawname
    local name0    = basename .. '0000'
    if minetest.registered_nodes[name0] then
        for a = 0, 1 do for b = 0, 1 do for c = 0, 1 do for d = 0, 1 do
            local name = basename .. a .. b .. c .. d
            blueprints.register_alias(name, name0)
        end end end end
    end
    microcontrollers[#microcontrollers + 1] = name0
end

blueprints.easy_override('blueprints:microcontroller', microcontrollers, {
    allowed = true,
    meta    = true,
    pvmeta  = {'code', 'lc_memory'}
})
microcontrollers = nil
