args={...}

local function createcallback(unitTarget,etype)
	return function (resetboolean)
		if etype == 'caged' then unitTarget.flags1.caged = false end
		if etype == 'projectile' then unitTarget.flags1.projectile = false end
	end
end

local function effect(etype,unitTarget,time)
	if etype == 'caged' then unitTarget.flags1.caged = true end
	if etype == 'projectile' then unitTarget.flags1.projectile = true end
	if time ~= 0 then
		dfhack.timeout(time,'ticks',createcallback(unitTarget,etype))
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))
local time = tonumber(args[3])

effect(etype,unit,time)
