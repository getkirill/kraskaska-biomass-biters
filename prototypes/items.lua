local function string_ends(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local prefix = "kraskaska-biomass-biters:"
data:extend{{
    name = prefix .. "bioslush",
    type = "item",
    icon = "__kraskaska-biomass-biters__/graphics/bioslush.png",
    icon_size = 64,
    stack_size = 100,
    group = "intermediate-products",
    subgroup = "raw-material"
}, {
    name = prefix .. "bioslush",
    type = "recipe",
    category = prefix .. "slush-shocking",
    ingredients = {{"wood", 10}, {
        type = "fluid",
        name = "crude-oil",
        amount = 20
    }},
    result = prefix .. "bioslush",
    enabled = false,
    energy_required = 10
}}
data:extend{{
    name = prefix .. "biomass",
    type = "item",
    icon = "__kraskaska-biomass-biters__/graphics/biomass.png",
    icon_size = 64,
    stack_size = 100,
    group = "intermediate-products",
    subgroup = "raw-material"
}, {
    name = prefix .. "biomass",
    type = "recipe",
    category = prefix .. "biomass-garden",
    ingredients = {{prefix .. "bioslush", 10}},
    result = prefix .. "biomass",
    enabled = false,
    energy_required = 5
}}
local function biomass_units_to_grown(units)
    local new_units = {}
    for _, unit in ipairs(units) do
        new_unit = unit
        new_unit[1] = prefix .. "grown-" .. new_unit[1]
        table.insert(new_units, new_unit)
    end
    return new_units
end
local function biomass_unit_copy(type, name, ingredients)
    if not (type == "unit-spawner" or type == "unit" or type == "turret") then
        return
    end
    local unit = table.deepcopy(data.raw[type][name])
    local og_name = unit.name
    local localised_name = data.raw[type][name].localised_name or {"entity-name." .. og_name}
    unit.name = prefix .. "grown-" .. unit.name
    unit.localised_name = {"kraskaska-biomass-biters.unit-suffix", localised_name}
    unit.flags = {"placeable-player", "placeable-off-grid", "not-repairable", "breaths-air", "player-creation"}
    if settings.startup[prefix .. "mineable-units"].value then
        unit.minable = {
            mining_time = 1,
            result = unit.name
        }
    end
    if type == "unit-spawner" then
        unit.result_units = biomass_units_to_grown(unit.result_units)
    end
    local item = {
        name = unit.name,
        localised_name = {"kraskaska-biomass-biters.unit-suffix", localised_name},
        type = "item",
        icon = unit.icon,
        icon_size = unit.icon_size,
        subgroup = unit.subgroup,
        place_result = unit.name,
        stack_size = 10
    }
    local recipe = {
        name = unit.name,
        localised_name = {"kraskaska-biomass-biters.unit-suffix", localised_name},
        type = "recipe",
        category = prefix .. "biomass-garden",
        ingredients = ingredients,
        result = unit.name,
        enabled = false
    }
    data:extend{unit, item, recipe}
end
local function biomass_generate_from_spawner(spawner)
    for _, unit in ipairs(spawner.result_units) do
        biomass_unit_copy("unit", unit[1], {{prefix .. "biomass", 5}})
    end
    biomass_unit_copy("unit-spawner", spawner.name, {{prefix .. "biomass", 5}})
end
local function biomass_worm_criteria(turret)
    return turret.type == "turret" and (turret.subgroup == "enemies" or string.find(turret.name, "worm"))
end
-- data:extend{{
--     name = prefix .. "grown-small-biter",
--     type = "item",
--     icon = "__base__/graphics/icons/small-biter.png",
--     icon_size = 64,
--     subgroup = "gun",
--     place_result = "small-biter",
--     stack_size = 10
-- }, {
--     name = prefix .. "grown-small-biter",
--     type = "recipe",
--     category = prefix .. "biomass-garden",
--     ingredients = {{prefix .. "biomass", 5}},
--     result = prefix .. "grown-small-biter",
--     enabled = true
-- }}
-- biomass_unit_copy("unit", "small-biter", {{prefix .. "biomass", 5}})
-- biomass_unit_copy("unit", "medium-biter", {{prefix .. "biomass", 5}})
-- biomass_unit_copy("unit", "big-biter", {{prefix .. "biomass", 5}})
-- biomass_unit_copy("unit", "behemoth-biter", {{prefix .. "biomass", 5}})
-- biomass_unit_copy("unit-spawner", "biter-spawner", {{prefix .. "biomass", 15}})

--------------------------------
-- biters, spitters, spawners --
--------------------------------
if not settings.startup[prefix .. "support-all-spawners"].value then
    biomass_generate_from_spawner(data.raw["unit-spawner"]["biter-spawner"])
    biomass_generate_from_spawner(data.raw["unit-spawner"]["spitter-spawner"])
end

local rampant_spawners = {}
local all_spawners = {}
local all_worms = {}
local all_units = {}
for _, v in pairs(data.raw["unit-spawner"]) do
    -- Rampant support
    if string_ends(v.name, "rampant") and settings.startup[prefix .. "rampant-support"].value then
        table.insert(rampant_spawners, v)
    end
    table.insert(all_spawners, v)
end
for _, v in pairs(data.raw["unit"]) do
    table.insert(all_units, v)
end
if settings.startup[prefix .. "rampant-support"].value and not settings.startup[prefix .. "support-all-spawners"].value then
    for _, v in ipairs(rampant_spawners) do
        biomass_generate_from_spawner(v)
    end
end
if settings.startup[prefix .. "support-all-spawners"].value then
    for _, v in ipairs(all_spawners) do
        biomass_generate_from_spawner(v)
    end
end

-----------
-- worms --
-----------
if settings.startup[prefix .. "add-worms"] then
    if not (settings.startup[prefix .. "support-all-worms"].value and
        settings.startup[prefix .. "support-all-spawners"].value) then
        biomass_unit_copy("turret", "small-worm-turret", {{prefix .. "biomass", 5}})
        biomass_unit_copy("turret", "medium-worm-turret", {{prefix .. "biomass", 5}})
        biomass_unit_copy("turret", "big-worm-turret", {{prefix .. "biomass", 5}})
        biomass_unit_copy("turret", "behemoth-worm-turret", {{prefix .. "biomass", 5}})
    end

    local rampant_worms = {}
    for _, v in pairs(data.raw["turret"]) do
        if biomass_worm_criteria(v) then
            -- Rampant support
            if string_ends(v.name, "rampant") and settings.startup[prefix .. "rampant-support"].value then
                table.insert(rampant_worms, v)
            end
            table.insert(all_worms, v)
        end
    end
    if settings.startup[prefix .. "rampant-support"].value and
        not (settings.startup[prefix .. "support-all-spawners"].value and
            settings.startup[prefix .. "support-all-worms"].value) then
        for _, v in ipairs(rampant_worms) do
            biomass_unit_copy("turret", v.name, {{prefix .. "biomass", 5}})
        end
    end
    if settings.startup[prefix .. "support-all-spawners"].value and
        settings.startup[prefix .. "support-all-worms"].value then
        for _, v in ipairs(all_worms) do
            biomass_unit_copy("turret", v.name, {{prefix .. "biomass", 5}})
        end
    end
end

----------
-- Loot --
----------
local bioslush_loot = {
    count_max = 10,
    count_min = 1,
    item = prefix.."bioslush",
    probability = 1
}

for _, v in ipairs(all_spawners) do
    local loot = v.loot or {}
    table.insert(loot, bioslush_loot)
    data.raw["unit-spawner"][v.name].loot = loot
end
for _, v in ipairs(all_units) do
    local loot = v.loot or {}
    table.insert(loot, bioslush_loot)
    data.raw["unit"][v.name].loot = loot
end
for _, v in ipairs(all_worms) do
    local loot = v.loot or {}
    table.insert(loot, bioslush_loot)
    data.raw["turret"][v.name].loot = loot
end