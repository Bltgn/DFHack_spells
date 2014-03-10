<<<<<<< HEAD

--[[
Description: Changes to the boolean values, the changes last a certain number of ticks.

Use:
[SYN_CLASS:\COMMAND]
[SYN_CLASS:addsyndrome]
[SYN_CLASS:type]
[SYN_CLASS:\UNIT_ID]
[SYN_CLASS:radius]
[SYN_CLASS:target]
[SYN_CLASS:affected class]
[SYN_CLASS:affected creature]
[SYN_CLASS:affected syndrome class]
[SYN_CLASS:required tokens]
[SYN_CLASS:immune class]
[SYN_CLASS:immune creature]
[SYN_CLASS:immune syndrome class]
[SYN_CLASS:forbidden tokens]

type = syndrome to be added. specified in an inorganic (VALID TOKENS: ANY INORGANIC)
radius = x,y,z extent of the effect from the target creature, if x=y=z=-1 then will only be target creature, if x=y=z=0 then will only be target creatures space (VALID TOKEN: INTEGER[-1 - mapsize])
target = who is eligible to be targeted (VALID TOKENS: enemy, civ, all)
affected class = creature class that is affected, use NONE to skip this check (VALID TOKENS: ANY CREATURE CLASS TOKENS {seperated by commas}, or NONE)
affected creature = creature that is affected, use NONE to skip this check (VALID TOKENS: ANY CREATURE;CASTE COMBINATIONS {seperated by commas}, or NONE)
affected syndrome class = syndrome class that is affected, use NONE to skip this check (VALID TOKENS: ANY SYNDROME CLASS TOKENS {seperated by commas}, or NONE)
require tokens = tokens that are required, use NONE to skip this check (VALID TOKENS: ANY TOKENS FOUND IN 'tokens.txt')
immune class = creature class that is immune, use NONE to skip this check (VALID TOKENS: ANY CREATURE CLASS TOKENS {seperated by commas}, or NONE)
immune creature = creature that is immune, use NONE to skip this check (VALID TOKENS: ANY CREATURE;CASTE COMBINATIONS {seperated by commas}, or NONE)
immune syndrome class = syndrome class that is immune, use NONE to skip this check (VALID TOKENS: ANY SYNDROME CLASS TOKENS {seperated by commas}, or NONE)
forbidden tokens = tokens that are forbidden, use NONE to skip this check (VALID TOKENS: ANY TOKENS FOUND IN 'tokens.txt')

Example:
[INTERACTION:UPGRADE_CLASS_MAGE]
	[I_SOURCE:CREATURE_ACTION]
	[I_TARGET:C:CREATURE]
		[IT_LOCATION:CONTEXT_CREATURE]
		[IT_MANUAL_INPUT:target]
	[I_EFFECT:ADD_SYNDROME]
		[IE_TARGET:C]
		[IE_IMMEDIATE]
		[SYNDROME]
			[SYN_CLASS:\COMMAND]
			[SYN_CLASS:addsyndrome]
			[SYN_CLASS:CLASS_CHANGE_ARCH_MAGE]
			[SYN_CLASS:\UNIT_ID]
			[SYN_CLASS:-1,-1,-1]
			[SYN_CLASS:civ]
			[SYN_CLASS:NONE]
			[SYN_CLASS:NONE]
			[SYN_CLASS:MAGE]
			[SYN_CLASS:NONE]
			[SYN_CLASS:NONE]
			[SYN_CLASS:NONE]
			[SYN_CLASS:NONE]
			[SYN_CLASS:NONE]
			[CE_SPEED_CHANGE:SPEED_PERC:100:START:0:END:1]
]]

=======
>>>>>>> Major Overhaul
args={...}

local function alreadyHasSyndrome(unit,syn_id) --taken from Putnam's itemSyndrome
    for _,syndrome in ipairs(unit.syndromes.active) do
        if syndrome.type == syn_id then return true end
    end
    return false
end

local function assignSyndrome(target,syn_id) --taken from Putnam's itemSyndrome
    if target==nil then
        return nil
    end
    if alreadyHasSyndrome(target,syn_id) then
        local syndrome
        for k,v in ipairs(target.syndromes.active) do
            if v.type == syn_id then syndrome = v end
        end
        if not syndrome then return nil end
        syndrome.ticks=1
        return true
    end
    local newSyndrome=df.unit_syndrome:new()
    local target_syndrome=df.syndrome.find(syn_id)
    newSyndrome.type=target_syndrome.id
    newSyndrome.year=df.global.cur_year
    newSyndrome.year_time=df.global.cur_year_tick
    newSyndrome.ticks=0
    newSyndrome.unk1=0
<<<<<<< HEAD
    --newSyndrome.flags=0
    for k,v in ipairs(target_syndrome.ce) do
        local sympt=df.unit_syndrome.T_symptoms:new()
        sympt.unk1=0
        sympt.unk2=0
        sympt.ticks=0
=======
    for k,v in ipairs(target_syndrome.ce) do
        local sympt=df.unit_syndrome.T_symptoms:new()
        sympt.ticks=0
				sympt.unk1=0
				sympt.unk2=0
>>>>>>> Major Overhaul
        sympt.flags=2
        newSyndrome.symptoms:insert("#",sympt)
    end
    target.syndromes.active:insert("#",newSyndrome)
    if itemsyndromedebug then
        print("Assigned syndrome #" ..syn_id.." to unit.")
    end
    return true
end

function effect(etype,unitTarget)
	local syndromes = dfhack.matinfo.find(etype).material.syndrome
	for j = 0, #syndromes -1, 1 do
		assignSyndrome(unitTarget,syndromes[j].id)
	end
end

local etype = args[1]
local unit = df.unit.find(tonumber(args[2]))

effect(etype,unit)
