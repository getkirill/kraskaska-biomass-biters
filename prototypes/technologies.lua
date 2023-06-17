local function string_starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local prefix = "kraskaska-biomass-biters:"
-- local grown_units = {}
-- local grown_spawners = {}
local biomass_garden_recipes = {}
for _, v in pairs(data.raw["unit"]) do
    if string_starts(v.name, prefix .. "grown-") then
        table.insert(biomass_garden_recipes, {
            type = "unlock-recipe",
            recipe = v.name
        })
    end
end
for _, v in pairs(data.raw["unit-spawner"]) do
    if string_starts(v.name, prefix .. "grown-") then
        table.insert(biomass_garden_recipes, {
            type = "unlock-recipe",
            recipe = v.name
        })
    end
end
for _, v in pairs(data.raw["turret"]) do
    if string_starts(v.name, prefix .. "grown-") then
        table.insert(biomass_garden_recipes, {
            type = "unlock-recipe",
            recipe = v.name
        })
    end
end
table.insert(biomass_garden_recipes, {
    type = "unlock-recipe",
    recipe = prefix .. "biomass-garden"
})
table.insert(biomass_garden_recipes, {
    type = "unlock-recipe",
    recipe = prefix .. "biomass"
})
data:extend{{
    type = "technology",
    name = prefix .. "biomass-garden",
    prerequisites = {"advanced-electronics"},
    icon = "__kraskaska-biomass-biters__/graphics/biomass-garden.png",
    icon_size = 256,
    unit = {
        count_formula = "120",
        ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}},
        time = 25
    },
    effects = biomass_garden_recipes
}, {
  type = "technology",
    name = prefix .. "slush-shocker",
    prerequisites = {prefix.."biomass-garden", "production-science-pack"},
    icon = "__kraskaska-biomass-biters__/graphics/slush-shocker.png",
    icon_size = 256,
    unit = {
        count_formula = "200",
        ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"production-science-pack", 1}},
        time = 40
    },
    effects = {{type = "unlock-recipe", recipe = prefix .. "slush-shocker"}, {type = "unlock-recipe", recipe = prefix .. "bioslush"}}
}}
