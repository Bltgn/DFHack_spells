
fov = require 'fov'

args={...}

function isSelected(unit,view,height)
	local pos = {dfhack.units.getPosition(unit)}

	if pos[1] < view.xmin or pos[1] > view.xmax then
		return false
	end

	if pos[2] < view.ymin or pos[2] > view.ymax then
		return false
	end

	return pos[3] >= view.z and pos[3] <= view.z + height

end

function radiuseffect(etype,unit,radius,height,strength)
	local view = fov.get_fov(radius, unit.pos)
	local i
	local unitList = df.global.world.units.active

	for i = #unitList - 1, 0, -1 do
		unitTarget = unitList[i]
		if isSelected(unitTarget, view, height) then
			if etype == 'web' then unitTarget.counters.webbed = strength end
			if etype == 'stun' then unitTarget.counters.stunned = strength end
			if etype == 'winded' then unitTarget.counters.winded = strength end
			if etype == 'unconcious' then unitTarget.counters.unconcious = strength end
			if etype == 'pain' then unitTarget.counters.pain = strength end
			if etype == 'nausea' then unitTarget.counters.nausea = strength end
			if etype == 'dizziness' then unitTarget.counters.dizziness = strength end
			if etype == 'paralysis' then unitTarget.counters.paralysis = strength end
			if etype == 'numbness' then unitTarget.counters.numbness = strength end
			if etype == 'fever' then unitTarget.counters.fever = strength end
			if etype == 'exhaustion' then unitTarget.counters.exhaustion = strength end
			if etype == 'hunger' then unitTarget.counters.hunger_timer = strength end
			if etype == 'thirst' then unitTarget.counters.thirst_timer = strength end
			if etype == 'sleep' then unitTarget.counters.sleepiness_timer = strength end
			if etype == 'infection' then unitTarget.body.infection_level = strength end
		end
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local height = tonumber(args[4])
local strength = tonumber(args[5])

radiuseffect(etype,unit,radius,height,strength)
