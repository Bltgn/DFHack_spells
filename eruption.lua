
--[[
Description: Causes an "eruption" of water or magma under a creature with a specified radius and a specified height.

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:eruption][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height][SYN_CLASS:depth]
type = type of liquid created (VALID TOKENS: magma, water)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane (VALID TOKENS: INTEGER[0 - map size])
height = number of tiles high the liquid is created, allows for large columns of water and magma to be made (VALID TOKENS: INTEGER[0 - map height])
depth =  amount of liquid created at center, falls off as you move away from the center to 1 at the max radius (VALID TOKENS: INTEGER[1 - 7])

Example: 
Code: [Select]
[INTERACTION:SPELL_ELEMENTAL_FIRE_VOLCANO]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:eruption]
			[SYN_CLASS:magma]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:4]
			[SYN_CLASS:0]
			[SYN_CLASS:7]
			[CE_SPEED_CHANGE:SPEED_PERC:100:START:0:END:1]

]]

args={...}

function eruption(etype,unit,radius,height,depth)
	local i
	local rando = dfhack.random.new()

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

	local dx = xmax - xmin
	local dy = ymax - ymin
	local hx = depth/dx

	for i = xmin, xmax, 1 do
		for j = ymin, ymax, 1 do
			for k = unit.pos.z, zmax, 1 do
				if (math.abs(i-unit.pos.x) + math.abs(j-unit.pos.y)) <= radius then
					block = dfhack.maps.ensureTileBlock(i,j,k)
					dsgn = block.designation[i%16][j%16]
					if not dsgn.hidden then
						size = math.floor(depth-hx*(math.abs(unit.pos.x-i)+math.abs(unit.pos.y-j)))
						if size < 1 then size = 1 end
						dsgn.flow_size = size
						if etype == 'magma' then
							dsgn.liquid_type = true
						end
						flow = block.liquid_flow[i%16][j%16]
						flow.temp_flow_timer = 10
						flow.unk_1 = 10
						block.flags.update_liquid = true
						block.flags.update_liquid_twice = true
					end
				end
			end
		end
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local height = tonumber(args[4])
local depth = tonumber(args[5])

eruption(etype,unit,radius,height,depth)
