local entity_dir = "__AsteroidBelt__/prototypes/entity/"

local util = require("utility")

-----------------
-- PREPARATION --
-----------------

data.raw["planet"]["aquilo"].distance = data.raw["planet"]["aquilo"].distance + 10
data.raw["space-location"]["solar-system-edge"].distance = data.raw["space-location"]["solar-system-edge"].distance + 15

-----------
-- ADDED --
-----------

-- Asteroid Belt
require(entity_dir .. "asteroid-belt")

-------------
-- CHANGED --
-------------

if data.raw["planet"]["maraxsis"] then
	data.raw["planet"]["maraxsis"].orientation = util.get_avg_orien("gleba", "asteroid-belt-outer-edge", 0.5)
	data.raw["planet"]["maraxsis"].distance = util.get_avg_dist("aquilo", "asteroid-belt-outer-edge", 0.8)
	data.raw["space-connection"]["vulcanus-maraxsis"].from = "aquilo"
	data.raw["space-connection"]["fulgora-maraxsis"].from = "asteroid-belt-outer-edge"
end

if data.raw["planet"]["corrundum"] then
	data.raw["space-connection"]["aquilo-corrundum"] = nil
end

if data.raw["space-location"]["secretas"] then
	data.raw["space-location"]["secretas"].distance = data.raw["planet"]["aquilo"].distance + 8
	data.raw["planet"]["frozeta"].distance = data.raw["space-location"]["secretas"].distance - 1
	data.raw["planet"]["frozeta"].orientation = data.raw["space-location"]["secretas"].orientation + 0.01
end

if mods["Paracelsin"] then
	data.raw["planet"]["paracelsin"].distance = data.raw["planet"]["aquilo"].distance + 3
	data.raw["space-connection"]["fulgora-paracelsin"].from = "asteroid-belt-outer-edge"
end

if data.raw["planet"]["cubium"] then
	data.raw["planet"]["cubium"].orientation = data.raw["space-location"]["asteroid-belt-outer-edge"].orientation + 0.2 
	data.raw["planet"]["cubium"].distance = util.get_avg_dist("aquilo", "asteroid-belt-outer-edge", 0.5)
	data.raw["space-connection"]["vulcanus-cubium"].from = "asteroid-belt-outer-edge"
	data.raw["space-connection"]["gleba-cubium"].from = "aquilo"
	if data.raw["planet"]["paracelsin"] then
		data.raw["space-connection"]["fulgora-paracelsin"] = nil
		data.raw["space-connection"]["gleba-cubium"].from = "paracelsin"
		data.raw["planet"]["cubium"].orientation = util.get_avg_orien("paracelsin", "asteroid-belt-outer-edge", 0.6)
		data.raw["planet"]["cubium"].distance = util.get_avg_dist("paracelsin", "asteroid-belt-outer-edge", 0.4)
	end
end
