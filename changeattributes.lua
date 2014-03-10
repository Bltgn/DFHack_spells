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
		if etype == 'strength' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.STRENGTH + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.STRENGTH = value
		end
		if etype == 'agility' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.AGILITY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.AGILITY = value
		end
		if etype == 'endurance' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.ENDURANCE + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.ENDURANCE = value
		end
		if etype == 'toughness' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.TOUGHNESS + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.TOUGHNESS = value
		end
		if etype == 'resistance' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.DISEASE_RESISTANCE + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.DISEASE_RESISTANCE = value
		end
		if etype == 'recuperation' or etype == 'all' or etype == 'physical' then
			value = unitTarget.body.physical_attrs.RECUPERATION + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.RECUPERATION = value
		end
		if etype == 'analytical' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.ANALYTICAL_ABILITY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.ANALYTICAL_ABILITY = value
		end
		if etype == 'focus' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.FOCUS + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.FOCUS = value
		end
		if etype == 'wlllpower' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.WILLPOWER + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.WILLPOWER = value
		end
		if etype == 'creativity' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.CREATIVITY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.CREATIVITY = value
		end
		if etype == 'intuition' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.INTUITION + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.INTUITION = value
		end
		if etype == 'patience' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.PATIENCE + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.PATIENCE = value
		end
		if etype == 'memory' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.MEMORY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.MEMORY = value
		end
		if etype == 'linguistic' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.LINGUISTIC_ABILITY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.LINGUISTIC_ABILITY = value
		end
		if etype == 'spatial' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.SPATIAL_SENSE + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.SPATIAL_SENSE = value
		end
		if etype == 'musicality' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.MUSICALITY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.MUSICALITY = value
		end
		if etype == 'kinesthetic' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.KINESTHETIC_SENSE + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.KINESTHETIC_SENSE = value
		end
		if etype == 'empathy' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.EMPATHY + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.EMPATHY = value
		end
		if etype == 'social' or etype =='all' or etype == 'mental' then
			value = unitTarget.status.current_soul.mental_attrs.SOCIAL_AWARENESS + strength
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.SOCIAL_AWARENESS = value
		end
	elseif ctype == 'percent' then
		local percent = (100+strength)/100
		if etype == 'strength' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.STRENGTH*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.STRENGTH = value
		end
		if etype == 'agility' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.AGILITY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.AGILITY = value
		end
		if etype == 'endurance' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.ENDURANCE*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.ENDURANCE = value
		end
		if etype == 'toughness' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.TOUGHNESS*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.TOUGHNESS = value
		end
		if etype == 'resistance' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.DISEASE_RESISTANCE*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.DISEASE_RESISTANCE = value
		end
		if etype == 'recuperation' or etype == 'all' or etype == 'physical' then
			value = math.floor(unitTarget.body.physical_attrs.RECUPERATION*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.body.physical_attrs.RECUPERATION = value
		end
		if etype == 'analytical' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.ANALYTICAL_ABILITY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.ANALYTICAL_ABILITY = value
		end
		if etype == 'focus' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.FOCUS*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.FOCUS = value
		end
		if etype == 'wlllpower' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.WILLPOWER*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.WILLPOWER = value
		end
		if etype == 'creativity' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.CREATIVITY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.CREATIVITY = value
		end
		if etype == 'intuition' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.INTUITION*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.INTUITION = value
		end
		if etype == 'patience' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.PATIENCE*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.PATIENCE = value
		end
		if etype == 'memory' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.MEMORY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.MEMORY = value
		end
		if etype == 'linguistic' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.LINGUISTIC_ABILITY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.LINGUISTIC_ABILITY = value
		end
		if etype == 'spatial' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.SPATIAL_SENSE*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.SPATIAL_SENSE = value
		end
		if etype == 'musicality' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.MUSICALITY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.MUSICALITY = value
		end
		if etype == 'kinesthetic' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.KINESTHETIC_SENSE*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.KINESTHETIC_SENSE = value
		end
		if etype == 'empathy' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.EMPATHY*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.EMPATHY = value
		end
		if etype == 'social' or etype =='all' or etype == 'mental' then
			value = math.floor(unitTarget.status.current_soul.mental_attrs.SOCIAL_AWARENESS*percent)
			if value > int16 then value = int16 end
			if value < 0 then value = 0 end
			unitTarget.status.current_soul.mental_attrs.SOCIAL_AWARENESS = value
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
