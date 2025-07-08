if not mods["interstellar-travel"] then
  return
 end

local icon_dir = "__AsteroidBelt__/graphics/icon/" 
local util = require("utility")

-- Belt Constants

local belt_width = 5
 
 
local sye_nauvis_asteroid_belt_inner_edge = {
    type = "space-connection",
    name = "sye-nauvis-asteroid-belt-inner-edge",
    icon = icon_dir .. "asteroid-belt.png",
    from = "sye-nauvis",
    to = "asteroid-belt-inner-edge",
    length = 12000,
    asteroid_spawn_definitions = belt_asteroid_density
}

local fulgora_sye_nauvis = {
    type = "space-connection",
    name = "fulgora-sye-nauvis",
    icon = icon_dir .. "asteroid-belt.png",
    from = "fulgora",
    to = "sye-nauvis",
    length = 48000,
    asteroid_spawn_definitions = belt_asteroid_density
}

local extend_table = {
	sye_nauvis_asteroid_belt_inner_edge,
	fulgora_sye_nauvis
}

data:extend(extend_table)

if data.raw["space-connection"]["nauvis-to-miara"] then
    data.raw["space-connection"]["nauvis-to-miara"].from = "asteroid-belt-outer-edge"
end

if data.raw["space-connection"]["nauvis-to-twelpa"] then
    data.raw["space-connection"]["nauvis-to-twelpa"].from = "asteroid-belt-outer-edge"
end

if data.raw["space-connection"]["nauvis-to-jarbid"] then
    data.raw["space-connection"]["nauvis-to-jarbid"].from = "asteroid-belt-outer-edge"
end

if data.raw["space-connection"]["nauvis-to-dea-dia"] then
	    data.raw["space-connection"]["nauvis-to-dea-dia"].from = "asteroid-belt-outer-edge"
end

if data.raw["space-connection"]["nauvis-to-senestella"] then
	    data.raw["space-connection"]["nauvis-to-senestella"].from = "asteroid-belt-outer-edge"
end

if data.raw["space-location"]["asteroid-belt-inner-edge"] then
    data.raw["space-location"]["asteroid-belt-inner-edge"].orientation = util.get_avg_orien("sye-nauvis", "gleba", 1)
end

if data.raw["space-location"]["asteroid-belt-outer-edge"] then
    data.raw["space-location"]["asteroid-belt-outer-edge"].orientation = (util.get_avg_orien("sye-nauvis", "gleba", 1) * 0.7 + data.raw["planet"]["aquilo"].orientation * 0.4)
end

if data.raw["space-connection"]["aquilo_belt_connection"] then
    data.raw["space-location"]["aquilo_belt_connection"] = nil
end
