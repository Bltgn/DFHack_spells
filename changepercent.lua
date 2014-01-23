
--[[
Description: 

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:changeblood][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height][SYN_CLASS:strength]
type = counter that is changed (VALID TOKENS: blood)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane, if radius = -1 then only affects target creature (VALID TOKENS: INTEGER[-1 - map size])
height = number of tiles above target creature you want creatures to be affected in the z direction (VALID TOKENS: INTEGER[0 - map height])
strength = percent of blood to lose/gain, will never go above max blood count, a value of -100 will kill the unit. (VALID TOKENS: INTEGER[-100 - 100])

Example:
[INTERACTION:SPELL_DIVINE_DARK_DRAIN_BLOOD]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:changepercent]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:10]
			[SYN_CLASS:5]
			[SYN_CLASS:-10]
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
	local percent = (100 + strength)/100
	local blood = 0

	if (radius == -1) then
		unitTarget = unit
		if etype == 'blood' then
			blood = math.floor(unitTarget.body.blood_count*percent)
			if blood > unitTarget.body.blood_max then blood = unitTarget.body.blood_max end
			if blood < 0 then blood = 0 end
			unitTarget.body.blood_count = blood
		end
	else
		for i = #unitList - 1, 0, -1 do
			unitTarget = unitList[i]
			if isSelected(unit, unitTarget, radius, height) then
				if etype == 'blood' then
					blood = math.floor(unitTarget.body.blood_count*percent)
					if blood > unitTarget.body.blood_max then blood = unitTarget.body.blood_max end
					if blood < 0 then blood = 0 end
					unitTarget.body.blood_count = blood
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
