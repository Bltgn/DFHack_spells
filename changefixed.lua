
--[[
Description: Changes the counter value for all creatures in a radius.

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:radiuseffect][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height][SYN_CLASS:strength]
type = counter that is changed (VALID TOKENS: web, stun, winded, unconscious, pain, nausea, dizziness, paralysis, numbness, fever, exhaustion, hunger, thirst, sleep, infection)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane, if radius = -1 then only affects target creature (VALID TOKENS: INTEGER[-1 - map size])
height = number of tiles above target creature you want creatures to be affected in the z direction (VALID TOKENS: INTEGER[0 - map height])
strength = value of counter, note that some counters have different maximums from others (VALID TOKENS: INTEGER[0+])

Example:
[INTERACTION:SPELL_NATURE_PLANT_ENTANGLE]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:radiuseffect]
			[SYN_CLASS:web]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:10]
			[SYN_CLASS:5]
			[SYN_CLASS:10000]
			[CE_SPEED_CHANGE:SPEED_PERC:100:START:0:END:1]

]]
args={...}

function isSelected(unit,unitTarget,radius,height)
	local pos = {dfhack.units.getPosition(unitTarget)}

	local mapx, mapy, mapz = dfhack.maps.getTileSize()
	local xmin = unit.pos.x - radius
	local xmax = unit.pos.x + radius
	local ymin = unit.pos.y - radius
	local ymax = unit.pos.y + radius
	local zmax = unit.pos.z + height
	if xmin < 1 then xmin = 1 end
	if ymin < 1 then ymin = 1 end
	if xmax > mapx then xmax = mapx-1 end
	if ymax > mapy then ymax = mapy-1 end
	if zmax > mapz then zmax = mapz-1 end

	if pos[1] <= xmin or pos[1] >= xmax then
		return false
	end

	if pos[2] <= ymin or pos[2] >= ymax then
		return false
	end

	return pos[3] >= unit.pos.z and pos[3] <= zmax

end

function effect(etype,unit,radius,height,strength)
	local i
	local unitList = df.global.world.units.active
	local value = 0
	local int16 = 30000
	local int32 = 200000000

	if (radius == -1) then
		local unitTarget = unit
		if etype == 'web' then
			value = unitTarget.counters.webbed + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.webbed = value
		end
		if etype == 'stun' then
			value = unitTarget.counters.stunned + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.stunned = value
		end
		if etype == 'winded' then 
			value = unitTarget.counters.winded + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.winded = value
		end
		if etype == 'unconscious' then 
			value = unitTarget.counters.unconscious + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.unconscious = value
		end
		if etype == 'pain' then 
			value = unitTarget.counters.pain + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.pain = value
		end
		if etype == 'nausea' then 
			value = unitTarget.counters.nausea + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.nausea = value
		end
		if etype == 'dizziness' then 
			value = unitTarget.counters.dizziness + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.dizziness = value
		end
		if etype == 'paralysis' then 
			value = unitTarget.counters.paralysis + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.paralysis = value
		end
		if etype == 'numbness' then 
			value = unitTarget.counters.numbness + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.numbness = value
		end
		if etype == 'fever' then 
			value = unitTarget.counters.fever + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.fever = value
		end
		if etype == 'exhaustion' then 
			value = unitTarget.counters.exhaustion + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.exhaustion = value
		end
		if etype == 'hunger' then 
			value = unitTarget.counters.hunger_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.hunger_timer = value
		end
		if etype == 'thirst' then 
			value = unitTarget.counters.thirst_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.thirst_timer = value
		end
		if etype == 'sleep' then 
			value = unitTarget.counters.sleepiness_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.sleepiness_timer = value
		end
		if etype == 'infection' then 
			value = unitTarget.body.infection_level + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.body.infection_level = value
		end
	else
		for i = #unitList - 1, 0, -1 do
			local unitTarget = unitList[i]
			if isSelected(unit, unitTarget, radius, height) then
				if etype == 'web' then
					value = unitTarget.counters.webbed + strength
					if value > int16 then value = int16 end
					if value < 0 then value = 0 end
					unitTarget.counters.webbed = value
				end
				if etype == 'stun' then
					value = unitTarget.counters.stunned + strength
					if value > int16 then value = int16 end
					if value < 0 then value = 0 end
					unitTarget.counters.stunned = value
				end
				if etype == 'winded' then 
					value = unitTarget.counters.winded + strength
					if value > int16 then value = int16 end
					if value < 0 then value = 0 end
					unitTarget.counters.winded = value
				end
				if etype == 'unconscious' then 
					value = unitTarget.counters.unconscious + strength
					if value > int16 then value = int16 end
					if value < 0 then value = 0 end
					unitTarget.counters.unconscious = value
				end
				if etype == 'pain' then 
					value = unitTarget.counters.pain + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.pain = value
				end
				if etype == 'nausea' then 
					value = unitTarget.counters.nausea + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.nausea = value
				end
				if etype == 'dizziness' then 
					value = unitTarget.counters.dizziness + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.dizziness = value
				end
				if etype == 'paralysis' then 
					value = unitTarget.counters.paralysis + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.paralysis = value
				end
				if etype == 'numbness' then 
					value = unitTarget.counters.numbness + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.numbness = value
				end
				if etype == 'fever' then 
					value = unitTarget.counters.fever + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.fever = value
				end
				if etype == 'exhaustion' then 
					value = unitTarget.counters.exhaustion + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.exhaustion = value
				end
				if etype == 'hunger' then 
					value = unitTarget.counters.hunger_timer + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.hunger_timer = value
				end
				if etype == 'thirst' then 
					value = unitTarget.counters.thirst_timer + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.thirst_timer = value
				end
				if etype == 'sleep' then 
					value = unitTarget.counters.sleepiness_timer + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.counters.sleepiness_timer = value
				end
				if etype == 'infection' then 
					value = unitTarget.body.infection_level + strength
					if value > int32 then value = int32 end
					if value < 0 then value = 0 end
					unitTarget.body.infection_level = value
				end
			end
		end
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local height = tonumber(args[4])
local strength = tonumber(args[5])

effect(etype,unit,radius,height,strength)
