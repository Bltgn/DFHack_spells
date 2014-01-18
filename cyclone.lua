
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

function findLOS(unit,radius,strength,height)
   local view = fov.get_fov(radius, unit.pos)
	 local i
	 local unitList = df.global.world.units.active

	 for i = #unitList - 1, 0, -1 do
      unitTarget = unitList[i]
			if isSelected(unitTarget, view,height) then

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

rando = dfhack.random.new()
rollx = rando:unitrandom()*strength
rolly = rando:unitrandom()*strength
rollz = rando:random(tonumber(strength))
bsize = unitTarget.body.size_info.size_cur
resultx = math.floor(rollx*70000/bsize)
resulty = math.floor(rolly*70000/bsize)
resultz = math.floor(rollz*70000/bsize)+1

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
unitoccupancy = dfhack.maps.getTileBlock(unitTarget.pos).occupancy[unitTarget.pos.x%16][unitTarget.pos.y%16]
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

unit = df.unit.find(tonumber(args[1]))
radius = tonumber(args[2])
height = tonumber(args[3])
strength = tonumber(args[4])

findLOS(unit,radius,strength,height)
