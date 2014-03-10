args={...}

flowtypes = {
miasma = 0,
mist = 1,
mist2 = 2,
dust = 3,
lavamist = 4,
smoke = 5,
dragonfire = 6,
firebreath = 7,
web = 8,
undirectedgas = 9,
undirectedvapor = 10,
oceanwave = 11,
seafoam = 12
}

function storm(stype,unit,radius,number,itype,strength)

	local i
	local rando = dfhack.random.new()
	local snum = flowtypes[stype]
	local inum = 0
	if itype ~= 0 then
		inum = dfhack.matinfo.find(itype).index
	end

	local mapx, mapy, mapz = dfhack.maps.getTileSize()
	local xmin = unit.pos.x - radius
	local xmax = unit.pos.x + radius
	local ymin = unit.pos.y - radius
	local ymax = unit.pos.y + radius
	if xmin < 1 then xmin = 1 end
	if ymin < 1 then ymin = 1 end
	if xmax > mapx then xmax = mapx-1 end
	if ymax > mapy then ymax = mapy-1 end

	local dx = xmax - xmin
	local dy = ymax - ymin
	local pos = {}
	pos.x = 0
	pos.y = 0
	pos.z = 0

	for i = 1, number, 1 do

		local rollx = rando:random(dx) - radius
		local rolly = rando:random(dy) - radius

		pos.x = unit.pos.x + rollx
		pos.y = unit.pos.y + rolly
		pos.z = unit.pos.z
		
		local j = 0
		while not dfhack.maps.ensureTileBlock(pos.x,pos.y,pos.z+j).designation[pos.x%16][pos.y%16].outside do
			j = j + 1
		end
		pos.z = pos.z + j
		dfhack.maps.spawnFlow(pos,snum,0,inum,strength)
	end
end

local stype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local radius = tonumber(args[3])
local number = tonumber(args[4])
local strength = tonumber(args[5])
local itype = 0
if #args > 5 then
	itype = args[6]
end

storm(stype,unit,radius,number,itype,strength)
