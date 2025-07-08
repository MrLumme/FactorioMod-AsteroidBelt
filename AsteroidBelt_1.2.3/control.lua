local utility = require("utility")

script.on_init(
	function()
		storage.heat_pumps = {}
	end
)


script.on_event(
	defines.events.on_built_entity,
	function(event) 
		
		local direction = event.entity.direction
		local out_name = "heat-pump-output-north"
		local out_pos = event.entity.position
		
		if event.entity.direction == 0 then
			out_pos.y = out_pos.y - 1
		elseif event.entity.direction == 4 then
			out_name = "heat-pump-output-east"
		elseif event.entity.direction == 8 then
			out_name = "heat-pump-output-south"
		elseif event.entity.direction == 12 then
			out_name = "heat-pump-output-west"
			out_pos.x = out_pos.x - 1
		end
		
		local output = game.surfaces[1].create_entity{
			name = out_name, 
			force = event.entity.force,
			position = out_pos, 
			direction = event.entity.direction
		}
		
		table.insert(
			storage.heat_pumps, {event.entity.unit_number, output.unit_number}
		)
	end,
	{{filter = "name", name = "heat-pump-input"}}
)

script.on_event(
	defines.events.on_player_mined_entity,
	function(event)
		utility.remove_heat_pump(event.entity)
	end,
	{{filter = "name", name = "heat-pump-input"}}
)