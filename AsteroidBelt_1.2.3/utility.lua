local utility = {}

-- General Asteroid Constants

utility.ast_types = {"metallic", "carbonic", "oxide", "promethium"}
utility.ast_sizes = {"chunk", "small", "medium", "big", "huge"}
utility.con_ast_distance = {0.1, 0.4, 0.9}

-- Functions

function utility.get_space_location(space_location_name)
	if data.raw["planet"][space_location_name] then
		return data.raw["planet"][space_location_name]
	else 
		return data.raw["space-location"][space_location_name]
	end
end

function utility.get_avg_dist(sl_1, sl_2, bias)
	local bias = bias or 0.5
	local loc_1 = utility.get_space_location(sl_1)
	local loc_2 = utility.get_space_location(sl_2)
	
	if loc_1 and loc_2 then
		return ((loc_1.distance * bias) + (loc_2.distance * (1 - bias)))
	else
		return -1
	end
end

function utility.get_avg_orien(sl_1, sl_2, bias)
	local loc_1 = utility.get_space_location(sl_1)
	local loc_2 = utility.get_space_location(sl_2)
	
	if loc_1 and loc_2 then
		return ((loc_1.orientation * bias) + (loc_2.orientation * (1 - bias)))
	else
		return -1
	end
end

function utility.remove_connection(sl_1, sl_2)
	local loc_1 = utility.get_space_location(sl_1)
	local loc_2 = utility.get_space_location(sl_2)
	
	for name, connection in pairs(data.raw["space-connection"]) do 
		if (connection.to == loc_1.name or connection.from == loc_1.name) and (connection.to == loc_2.name or connection.from == loc_2.name) then
			connection = nil
			return true
		end
	end
	return false
end

function utility.generate_ast_def(base_stats, type_multipliers)
	asteroid_def = {}
	for t, type in pairs(utility.ast_types) do
		for s, size in pairs(utility.ast_sizes) do
			if base_stats[size] and type_multipliers[type] then
				if size == "chunk" then
					table.insert(asteroid_def, {
						type = "asteroid-chunk",
						asteroid = type .. "-asteroid-chunk",
						probability = 
							base_stats[size][1] * type_multipliers[type][1],
						speed = 
							base_stats[size][2] * type_multipliers[type][2],
						angle_when_stopped = 
							base_stats[size][3] * type_multipliers[type][3]
					})
				else
					table.insert(asteroid_def, {
						type = "entity",
						asteroid = size .. "-" .. type .. "-asteroid",
						probability = 
							base_stats[size][1] * type_multipliers[type][1],
						speed = 
							base_stats[size][2] * type_multipliers[type][2],
						angle_when_stopped = 
							base_stats[size][3] * type_multipliers[type][3]
					})
				end
			end
		end
	end
	return asteroid_def
end

function utility.generate_con_ast_def(base_stats, type_multipliers)
	asteroid_def = {}
	for t, type in pairs(utility.ast_types) do
		for s, size in pairs(utility.ast_sizes) do
			if base_stats[size] and type_multipliers[type] then
			
				local entry = {}
				
				if size == "chunk" then
					entry.type = "asteroid-chunk"
					entry.asteroid = type .. "-asteroid-chunk"
				else
					entry.type = "entity"
					entry.asteroid = size .. "-" .. type .. "-asteroid"
				end
				
				local pro = base_stats[size][1] * type_multipliers[type][1]
				local spd = base_stats[size][2] * type_multipliers[type][2]
				local ang = base_stats[size][3] * type_multipliers[type][3]
				
				entry.spawn_points = {}
				for i = 1, 3 do
					local mult = 1
					if not 1 == 2 then
						mult = 0.3
					end
					
					table.insert(entry.spawn_points, {
						probability = pro * mult,
						speed = spd,
						angle_when_stopped = ang,
						distance = utility.con_ast_distance[i]
					})
				end
				
				table.insert(asteroid_def, entry)
			end
		end
	end
	return asteroid_def
end

return utility
