local icon_dir = "__AsteroidBelt__/graphics/icon/"

local util = require("utility")

-- Belt Constants

local belt_distance = (
	(util.get_avg_dist("fulgora", "gleba", 0.40) * 0.5)
	+ (data.raw["planet"]["aquilo"].distance * 0.5))
local belt_width = 5

-- General Asteroid Constants
local ast_locs = {"inner", "outer", "belt"}
local ast_types = {"metallic", "carbonic", "oxide"}
local ast_sizes = {"small", "medium", "big"}

-- Inner Asteroid Constants {Probability, Speed, Angle}

local inner_base = {
	["chunk"] = {0.005, 0.1, 0.3},
	["small"] = {0.008, 0.05, 0.6},
	["medium"] = {0.01, 0.01, 0.9}
}
local inner_multipliers = {
	["metallic"] = {0.8, 0.9, 0.3},
	["carbonic"] = {1.0, 1.0, 0.6},
	["oxide"] = {0.5, 0.8, 1.0}
}

-- Outer Asteroid Constants {Probability, Speed, Angle}

local outer_base = {
	["small"] = {0.003, 0.06, 0.7},
	["medium"] = {0.05, 0.01, 0.4},
	["big"] = {0.006, 0.005, 0.1}
}
local outer_multipliers = {
	["metallic"] = {0.8, 0.9, 0.6},
	["carbonic"] = {0.6, 1.0, 1.0},
	["oxide"] = {1.0, 0.8, 0.3}
}

-- Belt Asteroid Constants {Probability, Speed, Angle}

local belt_base = {
	["small"] = {0.004, 0.2, 0.9},
	["medium"] = {0.05, 0.1, 0.6},
	["big"] = {0.01, 0.01, 0.3}
}
local belt_multipliers = {
	["metallic"] = {0.9, 0.9, 1.0},
	["carbonic"] = {1.2, 1.0, 0.3},
	["oxide"] = {0.7, 0.8, 0.6}
}

-- Move To Belt Asteroid Constants {Probability, Speed, Angle}

local move_to_base = {
	["chunk"] = {0.0002, 0.1, 0.3},
	["small"] = {0.004, 0.05, 0.6},
	["medium"] = {0.007, 0.01, 0.9}
}
local move_to_multipliers = {
	["metallic"] = {0.8, 0.9, 0.3},
	["carbonic"] = {1.0, 1.0, 0.6},
	["oxide"] = {0.5, 0.8, 1.0}
}

-- Asteroid Densities

local inner_asteroid_density =
	util.generate_ast_def(inner_base, inner_multipliers)
local outer_asteroid_density =
	util.generate_ast_def(outer_base, outer_multipliers)

local move_to_belt_asteroid_density =
	util.generate_con_ast_def(move_to_base, move_to_multipliers)
	
local belt_asteroid_density =
	util.generate_con_ast_def(belt_base, belt_multipliers)
table.insert(belt_asteroid_density, {
	type = "asteroid-chunk",
	asteroid = "promethium-asteroid-chunk",
	spawn_points = {
		{
			probability = 0.0000001,
			speed = 0.5,
			distance = 0.1
		},
		{
			probability = 0.0000001,
			speed = 0.5,
			distance = 0.9
		}
	}
})

-- Locations

local inner_belt_edge = {
	name = "asteroid-belt-inner-edge",
	type = "space-location",
	icon = icon_dir .. "inner-belt-edge-starmap.png",
	icon_size = 256,
	
	redrawn_connections_keep = true,
	redrawn_connections_exclude = true,
	orientation = util.get_avg_orien("fulgora", "gleba", 0.5),
	distance = belt_distance - belt_width / 2,
	starmap_icon = icon_dir .. "inner-belt-edge-starmap.png",
	starmap_icon_size = 256,
	
	draw_orbit = false,
	fly_condition = false,
	solar_power_in_space = 75,
	
	asteroid_spawn_definitions = inner_asteroid_density
}

local outer_belt_edge = table.deepcopy(inner_belt_edge)
outer_belt_edge.name = "asteroid-belt-outer-edge"
outer_belt_edge.icon = icon_dir .. "outer-belt-edge-starmap.png"

outer_belt_edge.orientation  = (util.get_avg_orien("fulgora", "gleba", 0.5) * 0.6 + data.raw["planet"]["aquilo"].orientation * 0.4)
outer_belt_edge.distance = belt_distance + belt_width / 2
outer_belt_edge.starmap_icon = icon_dir .. "outer-belt-edge-starmap.png"

outer_belt_edge.solar_power_in_space = 70

outer_belt_edge.asteroid_spawn_definitions = outer_asteroid_density

-- Connections

local inner_outer_connection = {
	name = "asteroid-belt-inner-edge-asteroid-belt-outer-edge",
	type = "space-connection",
	icon = icon_dir .. "asteroid-belt.png",
	
	from = "asteroid-belt-inner-edge",
	to = "asteroid-belt-outer-edge",
	length = 5000,
	asteroid_spawn_definitions = belt_asteroid_density
}

local aquilo_belt_connection

if not mods["interstellar-travel"] then
	aquilo_belt_connection = table.deepcopy(data.raw["space-connection"]["fulgora-aquilo"])
	aquilo_belt_connection.name = "asteroid-belt-outer-edge-aquilo"
	aquilo_belt_connection.from = "asteroid-belt-outer-edge"
	aquilo_belt_connection.length = 10000
end

data.raw["space-connection"]["gleba-aquilo"].to = "asteroid-belt-inner-edge"
data.raw["space-connection"]["gleba-aquilo"].length = 20000
data.raw["space-connection"]["gleba-aquilo"].asteroid_spawn_definitions = move_to_belt_asteroid_density
data.raw["space-connection"]["fulgora-aquilo"].to = "asteroid-belt-inner-edge"
data.raw["space-connection"]["fulgora-aquilo"].length = 20000
data.raw["space-connection"]["fulgora-aquilo"].asteroid_spawn_definitions = move_to_belt_asteroid_density

-- Apply
local extend_table = {
	inner_belt_edge,
	outer_belt_edge,
	inner_outer_connection
}

if not mods["interstellar-travel"] then
    table.insert(extend_table, aquilo_belt_connection)
end

data:extend(extend_table)
