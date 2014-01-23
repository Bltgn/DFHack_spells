
--[[
Description: Changes to the boolean values, the changes last a certain number of ticks. 

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:changeboolean][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height][SYN_CLASS:time]
type = counter that is changed (VALID TOKENS: caged, projectile)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane, if radius = -1 then only affects target creature (VALID TOKENS: INTEGER[-1 - map size])
height = number of tiles above target creature you want creatures to be affected in the z direction (VALID TOKENS: INTEGER[0 - map height])
time = number of in game ticks that you want the change to last for, if you want the effect to be permanent use 0 (VALID TOKENS: INTEGER[0+])

Example:
[INTERACTION:SPELL_ARCANE_MYSTIC_BANISH]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:changeboolean]
			[SYN_CLASS:caged]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:10]
			[SYN_CLASS:5]
			[SYN_CLASS:10000]
			[CE_SPEED_CHANGE:SPEED_PERC:100:START:0:END:1]
]]

args={...}

function createcallback(unitTarget,etype)
	return function (resetboolean)
		if etype == 'caged' then unitTarget.flags.caged = 'false' end
		if etype == 'projectile' then unitTarget.flags.projectile = 'false' end
	end
end

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

function effect(etype,unit,radius,height,time)
	local i
	local unitList = df.global.world.units.active
	local percent = (100 + strength)/100
	local blood = 0

	if (radius == -1) then
		unitTarget = unit
		if etype == 'caged' then unitTarget.flags.caged = 'true' end
		if etype == 'projectile' then unitTarget.flags.projectile = 'true' end
		if time ~= 0 then
			dfhack.timeout(time,'ticks',createcallback(unitTarget,etype))
		end
	else
		for i = #unitList - 1, 0, -1 do
			unitTarget = unitList[i]
			if isSelected(unit, unitTarget, radius, height) then
				if etype == 'caged' then unitTarget.flags.caged = 'true' end
				if etype == 'projectile' then unitTarget.flags.projectile = 'true' end
				if time ~= 0 then
					dfhack.timeout(time,'ticks',createcallback(unitTarget,etype))
				end
			end
		end
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local height = tonumber(args[4])
local time = tonumber(args[5])

effect(etype,unit,radius,height,time)
