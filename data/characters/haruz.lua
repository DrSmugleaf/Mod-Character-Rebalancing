local haruzBalanced = GetModConfigData("HARUZ_BALANCED")
local levelSetting = GetModConfigData("LEVEL_SETTING")

local function balanceHaruzStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-1

	if levelSetting > 0 then

		local oldPreLoad = inst.OnPreLoad
		local oldEat = inst.components.eater.oneatfn
		
		local levelBase = 25
		
		local initialHealth = 75
		local initialHunger = 75
		local initialSanity = 75
		
		local finalHealth = 150
		local finalHunger = 200
		local finalSanity = 125
		
		inst.components.health:SetMaxHealth(initialHealth)
		inst.components.hunger:SetMax(initialHunger)
		inst.components.sanity:SetMax(initialSanity)
				
				
		local function newUpg(inst)

			max_upgrades = levelDifficulty+levelBase
			
			local upgrades = math.min(inst.level, max_upgrades)
	 
			local hunger_percent = inst.components.hunger:GetPercent()
			local health_percent = inst.components.health:GetPercent()
			local sanity_percent = inst.components.sanity:GetPercent()
			

			inst.components.health.maxhealth = math.ceil (initialHealth + upgrades * (finalHealth - initialHealth) / max_upgrades)		
			inst.components.hunger.max = math.ceil (initialHunger + upgrades * (finalHunger - initialHunger) / max_upgrades)
			inst.components.sanity.max = math.ceil (initialSanity + upgrades * (finalSanity - initialSanity) / max_upgrades)
			
			inst.components.talker:Say("Level : ".. (inst.level))
			if inst.level > math.ceil (max_upgrades-1) then
				inst.components.talker:Say("Level : Max!")
			end
		
			inst.components.hunger:SetPercent(hunger_percent)
			inst.components.health:SetPercent(health_percent)
			inst.components.sanity:SetPercent(sanity_percent)
		end
		
		local function newEat(inst, food)
			oldEat(inst, food)
		if food and food.components.edible and food.components.edible.foodtype == "MEAT" then
			newUpg(inst)
		end
	end
		
		local function newPreLoad(inst, data)
			oldPreLoad(inst, data)
			newUpg(inst)
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)
			inst.components.sanity:DoDelta(0)
		end
		
		inst.components.eater:SetOnEatFn(newEat)
		inst.OnPreLoad = newPreLoad
	end
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359821133") then
		if haruzBalanced then	
			AddPrefabPostInit("haruz", balanceHaruzStats)
			LogHelper.printInfo("Balancing Haruz")
		else
			LogHelper.printInfo("Ignoring Haruz")
		end
	end

end