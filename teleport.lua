args={...}

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function isSelected(unit,Target,rx,ry,rz)
	local pos = Target.pos

	local mapx, mapy, mapz = dfhack.maps.getTileSize()
	local xmin = unit.pos.x - rx
	local xmax = unit.pos.x + rx
	local ymin = unit.pos.y - ry
	local ymax = unit.pos.y + ry
	local zmin = unit.pos.z
	local zmax = unit.pos.z + rz
	if xmin < 1 then xmin = 1 end
	if ymin < 1 then ymin = 1 end
	if xmax > mapx then xmax = mapx-1 end
	if ymax > mapy then ymax = mapy-1 end
	if zmax > mapz then zmax = mapz-1 end

	if pos.x < xmin or pos.x > xmax then return false end
	if pos.y < ymin or pos.y > ymax then return false end
	if pos.z < zmin or pos.z > zmax then return false end

	return true
end

local ttype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local dir = tonumber(args[3])
local radius = args[4]
local radiusa = split(radius,'/')
local rx = tonumber(radiusa[1])
local ry = tonumber(radiusa[2])
local rz = tonumber(radiusa[3])

pers,status = dfhack.persistent.get('teleport')
if pers.ints[7] == 1 then
	if ttype == 'unit' or ttype == 'both' then
	local unitList = df.global.world.units.active
		for i = #unitList - 1, 0, -1 do
			local unitTarget = unitList[i]
			if isSelectedItem(unit,unitTarget,rx,ry,rz) then
				if dir == 1 then
					local unitoccupancy = dfhack.maps.getTileBlock(unitTarget.pos).occupancy[unitTarget.pos.x%16][unitTarget.pos.y%16]
					unitTarget.pos.x = pers.ints[1]
					unitTarget.pos.y = pers.ints[2]
					unitTarget.pos.z = pers.ints[3]
					if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
				elseif dir == 2 then
					local unitoccupancy = dfhack.maps.getTileBlock(unitTarget.pos).occupancy[unitTarget.pos.x%16][unitTarget.pos.y%16]
					unitTarget.pos.x = pers.ints[4]
					unitTarget.pos.y = pers.ints[5]
					unitTarget.pos.z = pers.ints[6]
					if not unit.flags1.on_ground then unitoccupancy.unit = false else unitoccupancy.unit_grounded = false end
				end
			end
		end
	end
	if ttype == 'item' or ttype == 'both' then
		local itemList = df.global.world.items.all
		for i = #itemList - 1, 0, -1 do
			local itemTarget = itemList[i]
			if isSelectedItem(unit,itemTarget,rx,ry,rz) then
				if dir == 1 then
					local pos = {}
					pos.x = pers.ints[1]
					pos.y = pers.ints[2]
					pos.z = pers.ints[3]
					dfhack.items.moveToGround(itemTarget, pos)
				elseif dir == 2 then
					local pos = {}
					pos.x = pers.ints[4]
					pos.y = pers.ints[5]
					pos.z = pers.ints[6]
					dfhack.items.moveToGround(itemTarget, pos)
				end
			end
		end
	end
end
