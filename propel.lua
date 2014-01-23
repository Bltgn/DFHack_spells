
--[[
Description: Used to turn all creatures in a specified radius into projectiles that are flung with a specified velocity. Currently affects friends and enemies, but must have an enemy initial target. Currently only affects creatures at the same height or above the target creature.

Use: 
[SYN_CLASS:\COMMAND][SYN_CLASS:cyclone][SYN_CLASS:type][SYN_CLASS:\UNIT_ID][SYN_CLASS:radius][SYN_CLASS:height][SYN_CLASS:strength]
type = whether you want the velocity to be random or a fixed amount, relative velocity not currently supported (VALID TOKEN: random, fixed, relative)
radius = number of tiles away from target creature you want creatures to be affected in the x-y plane, if radius is set to -1 will only affect target creature (VALID TOKEN: INTEGER[-1 - map size])
height = number of tiles above target creature you want creatures to be affected in the z direction (VALID TOKEN: INTEGER[0 - map height])
strength = x_y_z strength of the velocity, actual strength is determined by type (VALID TOKEN: INTEGER_INTEGER_INTEGER)

Example:
[INTERACTION:SPELL_ELEMENTAL_AIR_CYCLONE]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:propel]
			[SYN_CLASS:random]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:10]
			[SYN_CLASS:5]
			[SYN_CLASS:10_10_100]
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

function propel(ptype,unit,radius,strength,height)
	local i
	local unitList = df.global.world.units.active
	local sx, sy, sz = string.match(strength,"(%d+)_(%d+)_(%d+)")
	local dx = 1
	local dy = 1
	local dz = 1

	if (radius == -1) then
		unitTarget = unit

		if unitTarget==nil then
			print ("No unit under cursor!  Aborting!")
			return
		end

		if unitTarget.flags1.dead==true then
			print ("Dead unit!  Aborting!")
			return
		end

		if unitTarget.flags1.projectile==true then
			print ("Already a projectile!  Aborting!")
			return
		end

		if unitTarget.flags1.rider==true or unit.flags1.caged==true or unit.flags2.swimming==true or unit.flags3.exit_vehicle1==true or unit.flags3.exit_vehicle2==true then
			print ("Not eligible (rider, caged, swimming, minecart)!  Aborting!")
			return
		end

		local count=0
		local l = df.global.world.proj_list
		local lastlist=l
		l=l.next
		while l do
			count=count+1
			if l.next==nil then
				lastlist=l
			end
			l = l.next
		end

		if ptype == 'random' then
			rando = dfhack.random.new()
			rollx = rando:unitrandom()*tonumber(sx)
			rolly = rando:unitrandom()*tonumber(sy)
			rollz = rando:unitrandom()*tonumber(sz)
			bsize = unitTarget.body.size_info.size_cur
			resultx = math.floor(rollx)
			resulty = math.floor(rolly)
			resultz = math.floor(rollz)
		elseif ptype == 'fixed' then
			resultx = tonumber(sx)
			resulty = tonumber(sy)
			resultz = tonumber(sz)
		elseif ptype == 'relative' then
			resultx = tonumber(sx)*dx
			resulty = tonumber(sy)*dy
			resultz = tonumber(sz)*dz
		else
			print('Not a valid type')
		end

		newlist = df.proj_list_link:new()
		lastlist.next=newlist
		newlist.prev=lastlist
		proj = df.proj_unitst:new()
		newlist.item=proj
		proj.link=newlist
		proj.id=df.global.proj_next_id
		df.global.proj_next_id=df.global.proj_next_id+1
		proj.unit=unitTarget
		proj.origin_pos.x=unitTarget.pos.x
		proj.origin_pos.y=unitTarget.pos.y
		proj.origin_pos.z=unitTarget.pos.z
		proj.prev_pos.x=unitTarget.pos.x
		proj.prev_pos.y=unitTarget.pos.y
		proj.prev_pos.z=unitTarget.pos.z
		proj.cur_pos.x=unitTarget.pos.x
		proj.cur_pos.y=unitTarget.pos.y
		proj.cur_pos.z=unitTarget.pos.z
		proj.flags.no_impact_destroy=true
		proj.flags.piercing=true
		proj.flags.parabolic=true
		proj.flags.unk9=true
		proj.speed_x=resultx
		proj.speed_y=resulty
		proj.speed_z=resultz
		unitoccupancy = dfhack.maps.ensureTileBlock(unitTarget.pos).occupancy[unitTarget.pos.x%16][unitTarget.pos.y%16]
		if not unitTarget.flags1.on_ground then 
			unitoccupancy.unit = false 
		else 
			unitoccupancy.unit_grounded = false 
		end
		unitTarget.flags1.projectile=true
		unitTarget.flags1.on_ground=false
	else
		for i = #unitList - 1, 0, -1 do
			unitTarget = unitList[i]
			if isSelected(unit,unitTarget,radius,height) then

				if unitTarget==nil then
					print ("No unit under cursor!  Aborting!")
					return
				end

				if unitTarget.flags1.dead==true then
					print ("Dead unit!  Aborting!")
					return
				end

				if unitTarget.flags1.projectile==true then
					print ("Already a projectile!  Aborting!")
					return
				end

				if unitTarget.flags1.rider==true or unit.flags1.caged==true or unit.flags2.swimming==true or unit.flags3.exit_vehicle1==true or unit.flags3.exit_vehicle2==true then
					print ("Not eligible (rider, caged, swimming, minecart)!  Aborting!")
					return
				end

				local count=0
				local l = df.global.world.proj_list
				local lastlist=l
				l=l.next
				while l do
					count=count+1
					if l.next==nil then
						lastlist=l
					end
					l = l.next
				end

				if ptype == 'random' then
					rando = dfhack.random.new()
					rollx = rando:unitrandom()*tonumber(sx)
					rolly = rando:unitrandom()*tonumber(sy)
					rollz = rando:unitrandom()*tonumber(sz)
					bsize = unitTarget.body.size_info.size_cur
					resultx = math.floor(rollx)--*70000/bsize)
					resulty = math.floor(rolly)--*70000/bsize)
					resultz = math.floor(rollz)--*70000/bsize)+1
				elseif ptype == 'fixed' then
					resultx = tonumber(sx)
					resulty = tonumber(sy)
					resultz = tonumber(sz)
				elseif ptype == 'relative' then
					resultx = tonumber(sx)*dx
					resulty = tonumber(sy)*dy
					resultz = tonumber(sz)*dz
				else
					print('Not a valid type')
				end

				newlist = df.proj_list_link:new()
				lastlist.next=newlist
				newlist.prev=lastlist
				proj = df.proj_unitst:new()
				newlist.item=proj
				proj.link=newlist
				proj.id=df.global.proj_next_id
				df.global.proj_next_id=df.global.proj_next_id+1
				proj.unit=unitTarget
				proj.origin_pos.x=unitTarget.pos.x
				proj.origin_pos.y=unitTarget.pos.y
				proj.origin_pos.z=unitTarget.pos.z
				proj.prev_pos.x=unitTarget.pos.x
				proj.prev_pos.y=unitTarget.pos.y
				proj.prev_pos.z=unitTarget.pos.z
				proj.cur_pos.x=unitTarget.pos.x
				proj.cur_pos.y=unitTarget.pos.y
				proj.cur_pos.z=unitTarget.pos.z
				proj.flags.no_impact_destroy=true
				proj.flags.piercing=true
				proj.flags.parabolic=true
				proj.flags.unk9=true
				proj.speed_x=resultx
				proj.speed_y=resulty
				proj.speed_z=resultz
				unitoccupancy = dfhack.maps.ensureTileBlock(unitTarget.pos).occupancy[unitTarget.pos.x%16][unitTarget.pos.y%16]
				if not unitTarget.flags1.on_ground then 
					unitoccupancy.unit = false 
				else 
					unitoccupancy.unit_grounded = false 
				end
				unitTarget.flags1.projectile=true
				unitTarget.flags1.on_ground=false
			end
		end
	end
end

local ptype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local height = tonumber(args[4])
local strength = args[5]

propel(ptype,unit,radius,strength,height)
