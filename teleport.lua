
--[[
Description: 

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:teleport][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height]
type = type of thing to be teleported (VALID TOKENS: unit)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane, if radius = -1 then only affects target creature (VALID TOKENS: INTEGER[-1 - map size])
height = number of tiles above target creature you want creatures to be affected in the z direction (VALID TOKENS: INTEGER[0 - map height])

Example:
[INTERACTION:SPELL_ARCANE_TIME_RETREAT]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:teleport]
			[SYN_CLASS:unit]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:-1]
			[SYN_CLASS:0]
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

local ttype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local dir = tonumber(args[3])
local radius = tonumber(args[4])
local i
local unitList = df.global.world.units.active

pers,status = dfhack.persistent.get('teleport')
if pers.ints[7] == 1 then
	if itype == 'unit' then
		if (radius == -1) then
			if dir == 1 then
				local unitoccupancy = dfhack.maps.getTileBlock(unit.pos).occupancy[unit.pos.x%16][unit.pos.y%16]
				unit.pos.x = pers.ints[1]
				unit.pos.y = pers.ints[2]
				unit.pos.z = pers.ints[3]
				if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
			elseif dir == 2 then
				local unitoccupancy = dfhack.maps.getTileBlock(unit.pos).occupancy[unit.pos.x%16][unit.pos.y%16]
				unit.pos.x = pers.ints[4]
				unit.pos.y = pers.ints[5]
				unit.pos.z = pers.ints[6]
				if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
			end
		else
			for i = #unitList - 1, 0, -1 do
				local unitTarget = unitList[i]
				if isSelected(unit,unitTarget,radius,height) then
					if dir == 1 then
						local unitoccupancy = dfhack.maps.getTileBlock(unit.pos).occupancy[unit.pos.x%16][unit.pos.y%16]
						unit.pos.x = pers.ints[1]
						unit.pos.y = pers.ints[2]
						unit.pos.z = pers.ints[3]
						if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
					elseif dir == 2 then
						local unitoccupancy = dfhack.maps.getTileBlock(unit.pos).occupancy[unit.pos.x%16][unit.pos.y%16]
						unit.pos.x = pers.ints[4]
						unit.pos.y = pers.ints[5]
						unit.pos.z = pers.ints[6]
						if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
					end
				end
			end
		end
	end
end
