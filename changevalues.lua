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

local function effect(etype,unitTarget,ctype,strength)
	local i
	local value = 0
	local int16 = 30000
	local int32 = 200000000

	if ctype == 'fixed' then
		if etype == 'web' or etype =='all' then
			value = unitTarget.counters.webbed + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.webbed = value
		end
		if etype == 'stun' or etype =='all' then
			value = unitTarget.counters.stunned + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.stunned = value
		end
		if etype == 'winded' or etype =='all' then 
			value = unitTarget.counters.winded + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.winded = value
		end
		if etype == 'unconscious' or etype =='all' then 
			value = unitTarget.counters.unconscious + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.unconscious = value
		end
		if etype == 'pain' or etype =='all' then 
			value = unitTarget.counters.pain + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.pain = value
		end
		if etype == 'nausea' or etype =='all' then 
			value = unitTarget.counters.nausea + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.nausea = value
		end
		if etype == 'dizziness' or etype =='all' then 
			value = unitTarget.counters.dizziness + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.dizziness = value
		end
		if etype == 'paralysis' or etype =='all' then 
			value = unitTarget.counters.paralysis + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.paralysis = value
		end
		if etype == 'numbness' or etype =='all' then 
			value = unitTarget.counters.numbness + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.numbness = value
		end
		if etype == 'fever' or etype =='all' then 
			value = unitTarget.counters.fever + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.fever = value
		end
		if etype == 'exhaustion' or etype =='all' then 
			value = unitTarget.counters.exhaustion + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.exhaustion = value
		end
		if etype == 'hunger' or etype =='all' then 
			value = unitTarget.counters.hunger_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.hunger_timer = value
		end
		if etype == 'thirst' or etype =='all' then 
			value = unitTarget.counters.thirst_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.thirst_timer = value
		end
		if etype == 'sleep' or etype =='all' then 
			value = unitTarget.counters.sleepiness_timer + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.sleepiness_timer = value
		end
		if etype == 'infection' or etype =='all' then 
			value = unitTarget.body.infection_level + strength
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.body.infection_level = value
		end
		if etype == 'blood' or etype == 'all' then
			value = unitTarget.body.blood_count + strength
			if value > unitTarget.body.blood_max then value = unitTarget.body.blood_max end
			if value < 0 then blood = 0 end
			unitTarget.body.blood_count = value
		end
	elseif ctype == 'percent' then
		local percent = (100+strength)/100
		if etype == 'web' or etype =='all' then
			value = math.floor(unitTarget.counters.webbed*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.webbed = value
		end
		if etype == 'stun' or etype =='all' then
			value = math.floor(unitTarget.counters.stunned*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.stunned = value
		end
		if etype == 'winded' or etype =='all' then 
			value = math.floor(unitTarget.counters.winded*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.winded = value
		end
		if etype == 'unconscious' or etype =='all' then 
			value = math.floor(unitTarget.counters.unconscious*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.counters.unconscious = value
		end
		if etype == 'pain' or etype =='all' then 
			value = math.floor(unitTarget.counters.pain*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.pain = value
		end
		if etype == 'nausea' or etype =='all' then 
			value = math.floor(unitTarget.counters.nausea*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.nausea = value
		end
		if etype == 'dizziness' or etype =='all' then 
			value = math.floor(unitTarget.counters.dizziness*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.dizziness = value
		end
		if etype == 'paralysis' or etype =='all' then 
			value = math.floor(unitTarget.counters.paralysis*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.paralysis = value
		end
		if etype == 'numbness' or etype =='all' then 
			value = math.floor(unitTarget.counters.numbness*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.numbness = value
		end
		if etype == 'fever' or etype =='all' then 
			value = math.floor(unitTarget.counters.fever*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.fever = value
		end
		if etype == 'exhaustion' or etype =='all' then 
			value = math.floor(unitTarget.counters.exhaustion*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.exhaustion = value
		end
		if etype == 'hunger' or etype =='all' then 
			value = math.floor(unitTarget.counters.hunger_timer*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.hunger_timer = value
		end
		if etype == 'thirst' or etype =='all' then 
			value = math.floor(unitTarget.counters.thirst_timer*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.thirst_timer = value
		end
		if etype == 'sleep' or etype =='all' then 
			value = math.floor(unitTarget.counters.sleepiness_timer*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.counters.sleepiness_timer = value
		end
		if etype == 'infection' or etype =='all' then 
			value = math.floor(unitTarget.body.infection_level*percent)
			if value > int32 then value = int32 end
			if value < 0 then value = 0 end
			unitTarget.body.infection_level = value
		end
		if etype == 'blood' or etype == 'all' then
			blood = math.floor(unitTarget.body.blood_count*percent)
			if blood > unitTarget.body.blood_max then blood = unitTarget.body.blood_max end
			if blood < 0 then blood = 0 end
			unitTarget.body.blood_count = blood
		end
	end
end

local types = args[1]
local unit = df.unit.find(tonumber(args[2]))
local ctype = args[3]
local strengtha = split(args[4],'/')
local typea = split(types,'/')

for i,etype in ipairs(typea) do
	effect(etype,unit,ctype,tonumber(strengtha[i]))
end
