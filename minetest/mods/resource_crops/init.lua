resourcecrops = {}
local modname = minetest.get_current_modname()
resourcecrops.path = minetest.get_modpath(modname)
local function runfile(file)
    dofile(resourcecrops.path .. "/" .. file .. ".lua")
end
runfile("lib")
runfile("settings")
--FIX FARMING MOD CROPS
runfile("farming")
--ESSENCE--
runfile("essence")
--UPGRADE STONES--
runfile("upgrade_stones")
--BASE--
runfile("base")
if resourcecrops.settings.elements then
    runfile("elements")
end

if resourcecrops.settings.crop_coal then
    resourcecrops.add_crop("Coal", "coal", "weak", "default:coal_lump", "default:coal_lump 2")
end if resourcecrops.settings.crop_tin then
    resourcecrops.add_crop("Tin", "tin", "weak", "default:tin_ingot", "default:tin_lump 2")
end if resourcecrops.settings.crop_copper then
    resourcecrops.add_crop("Copper", "copper", "regular", "default:copper_ingot", "default:copper_lump 2")
end if resourcecrops.settings.crop_iron then
    resourcecrops.add_crop("Iron", "iron", "regular", "default:iron_ingot", "default:iron_lump 2")
end if resourcecrops.settings.crop_gold then
    resourcecrops.add_crop("Gold", "gold", "strong", "default:gold_ingot", "default:gold_lump 2")
end if resourcecrops.settings.crop_diamond then
    resourcecrops.add_crop("Diamond", "diamond", "extreme", "default:diamond", "default:diamond")
end if resourcecrops.settings.crop_mese then
    resourcecrops.add_crop("Mese", "mese", "strong", "default:mese_crystal", "default:mese_crystal")
end


if resourcecrops.settings.crop_silver then
    resourcecrops.add_crop("Silver", "silver", "regular", "moreores:silver_ingot", "moreores:silver_lump 2")
end if resourcecrops.settings.crop_mithril then
    resourcecrops.add_crop("Mithril", "mithril", "strong", "moreores:mithril_ingot", "moreores:mithril_lump 2")
end

if resourcecrops.settings.crop_brass then
    resourcecrops.add_crop("Brass", "brass", "regular", "technic:brass_ingot", "technic:brass_ingot 2")
end if resourcecrops.settings.crop_cast_iron then
    resourcecrops.add_crop("Cast Iron", "cast_iron", "regular", "technic:cast_iron_ingot", "technic:cast_iron_ingot 2")
end if resourcecrops.settings.crop_carbon_steel then
    resourcecrops.add_crop("Carbon Steel", "carbon_steel", "strong", "technic:carbon_steel_ingot", "technic:carbon_steel_ingot")
end if resourcecrops.settings.crop_chromium then
    resourcecrops.add_crop("Chromium", "chromium", "regular", "technic:chromium_ingot", "technic:chromium_lump 2")
end if resourcecrops.settings.crop_lead then
    resourcecrops.add_crop("Lead", "lead", "regular", "technic:lead_ingot", "technic:lead_lump 2")
end if resourcecrops.settings.crop_sulfur then
    resourcecrops.add_crop("Suflur", "sulfur", "weak", "technic:sulfur_lump", "technic:sulfur_lump 2")
end if resourcecrops.settings.crop_uranium then
    resourcecrops.add_crop("Uranium", "uranium", "extreme", "technic:uranium_ingot", "technic:uranium_lump 2")
end if resourcecrops.settings.crop_zinc then
    resourcecrops.add_crop("Zinc", "zinc", "regular", "technic:zinc_ingot", "technic:zinc_lump 2")
end if resourcecrops.settings.crop_rubber then
    resourcecrops.add_crop("Rubber", "rubber", "regular", "technic:rubber", "technic:rubber 3")
end if resourcecrops.settings.crop_terumet then
resourcecrops.add_crop("Terumetal", "terumetal", "strong", "terumet:lump_raw", "terumet:lump_raw 2")
end
print("Resource Crops loaded!")
