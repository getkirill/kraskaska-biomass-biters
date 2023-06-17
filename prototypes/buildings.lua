local prefix = "kraskaska-biomass-biters:"
data:extend{{
    name = prefix .. "slush-shocking",
    type = "recipe-category"
}, {
    name = prefix .. "slush-shocker",
    type = "assembling-machine",
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = prefix .. "slush-shocker"},
    icon = "__kraskaska-biomass-biters__/graphics/slush-shocker.png",
    icon_size = 256,
    stack_size = 10,
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    drawing_box = {{-2, -2}, {2, 2}},
    energy_usage = "3600kW",
    energy_source = {
        type = "electric",
        emissions_per_minute = 30,
        usage_priority = "secondary-input"
    },
    crafting_speed = 1,
    crafting_categories = {prefix .. "slush-shocking"},
    animation = {
        filename = "__kraskaska-biomass-biters__/graphics/slush-shocker.png",
        width = 256,
        height = 256,
        scale = 0.5
    },
    fluid_boxes = {{
        pipe_connections = {{
            type = "input",
            position = {-2.5, -0.5}
        }},
        base_area = 10,
        base_level = -1,
        production_type = "input"
    }, {
        pipe_connections = {{
            type = "input",
            position = {-2.5, 0.5}
        }},
        base_area = 10,
        base_level = -1,
        production_type = "input"
    }}
}, {
    name = prefix .. "slush-shocker",
    type = "item",
    icon = "__kraskaska-biomass-biters__/graphics/slush-shocker.png",
    icon_size = 256,
    subgroup = "production-machine",
    place_result = prefix .. "slush-shocker",
    stack_size = 10
}, {
    name = prefix .. "slush-shocker",
    type = "recipe",
    ingredients = {{"steel-plate", 10}, {"iron-plate", 20}, {"advanced-circuit", 10}},
    result = prefix .. "slush-shocker",
    enabled = false
}}
data:extend{{
    name = prefix .. "biomass-garden",
    type = "recipe-category"
}, {
    name = prefix .. "biomass-garden",
    type = "assembling-machine",
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = prefix .. "biomass-garden"},
    icon = "__kraskaska-biomass-biters__/graphics/biomass-garden.png",
    icon_size = 256,
    stack_size = 10,
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    drawing_box = {{-2, -2}, {2, 2}},
    energy_usage = "1MW",
    energy_source = {
        type = "electric",
        emissions_per_minute = 5,
        usage_priority = "secondary-input"
    },
    crafting_speed = 1,
    crafting_categories = {prefix .. "biomass-garden"},
    animation = {
        filename = "__kraskaska-biomass-biters__/graphics/biomass-garden.png",
        width = 256,
        height = 256,
        scale = 0.5
    }
    -- fluid_boxes = {{
    --     pipe_connections = {{
    --         type = "input",
    --         position = {-2.5, -0.5}
    --     }},
    --     base_area = 10,
    --     base_level = -1,
    --     production_type = "input"
    -- }, {
    --     pipe_connections = {{
    --         type = "input",
    --         position = {-2.5, 0.5}
    --     }},
    --     base_area = 10,
    --     base_level = -1,
    --     production_type = "input"
    -- }}
}, {
    name = prefix .. "biomass-garden",
    type = "item",
    icon = "__kraskaska-biomass-biters__/graphics/biomass-garden.png",
    icon_size = 256,
    subgroup = "production-machine",
    place_result = prefix .. "biomass-garden",
    stack_size = 10
}, {
    name = prefix .. "biomass-garden",
    type = "recipe",
    ingredients = {{"steel-plate", 15}, {"iron-plate", 15}, {"advanced-circuit", 15}, {prefix .. "bioslush", 5}},
    result = prefix .. "biomass-garden",
    enabled = false
}}
