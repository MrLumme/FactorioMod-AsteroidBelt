local sprite_dir = "__AsteroidBelt__/graphics/sprite/"

-- Code taken from Director_K1
if data.raw["utility-sprites"] and data.raw["utility-sprites"]["default"] then
    local utility_sprites = data.raw["utility-sprites"]["default"]
    local starmap_star = utility_sprites["starmap_star"] or {
        type = "sprite",
        layers = {
            {
                filename = "__core__/graphics/icons/starmap-star.png",
                size = 512,
                scale = 0.5,
                shift = { 0, 0 },
                draw_as_light = true,
            },
        },
    }
    starmap_star.layers = starmap_star.layers or {}

    local solar_system_sprites = {
        {
			filename = sprite_dir .. "asteroid-belt.png",
			size = 2436,
			scale = 1.1,
			shift = { 0, 0 }
		},
        {
			filename = "__core__/graphics/icons/starmap-star.png",
			size = 512,
			scale = 0.5,
			shift = { 0, 0 }
		},
    }

    for _, sprite in ipairs(solar_system_sprites) do
        table.insert(starmap_star.layers, sprite)
    end

    utility_sprites["starmap_star"] = starmap_star
end

require("compatibility.interstellar-travel")
require("compatibility.nexus")