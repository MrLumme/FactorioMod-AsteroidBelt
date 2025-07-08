local sprite_dir = "__AsteroidBelt__/graphics/technology/"

-----------
-- ADDED --
-----------

data:extend({
	{
		name = "space-discovery-asteroid-belt",
		type = "technology",
		icon = sprite_dir .. "space-discovery-asteroid-belt.png",
		icon_size = 512,
		essential = true,
		prerequisites = {
			"rocket-turret", "space-platform-thruster"
		},
		unit = {
			count = 1000,
			time = 60,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"space-science-pack", 1}
			}
		},
		effects = {
			{
				type = "unlock-space-location",
				space_location = "asteroid-belt-inner-edge",
			},
			{
				type = "unlock-space-location",
				space_location = "asteroid-belt-outer-edge",
			}
		}
	},
})

-------------
-- CHANGED --
-------------

table.insert(data.raw.technology["planet-discovery-aquilo"].prerequisites, "space-discovery-asteroid-belt")