local mitsuruBalanced = GetModConfigData("MITSURU_BALANCED")
local levelSetting = GetModConfigData("LEVEL_SETTING")

local function balanceMitsuruStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-1

	if levelSetting > 0 then

		local oldPreLoad = inst.OnPreLoad
		local oldEat = inst.components.eater.oneatfn
		
		local levelBase = 50
		
		local initialHealth = 75
		local initialHunger = 75
		local initialSanity = 50
		local initialDamage = 1.0
		local initialInsulation = 0
		
		local finalHealth = 100
		local finalHunger = 150
		local finalSanity = 125
		local finalDamage = 1.5
		local finalInsulation = 75
		
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
			
			inst.components.combat.damagemultiplier = math.ceil (initialDamage + upgrades * (finalDamage - initialDamage) / max_upgrades)
			inst.components.temperature.inherentinsulation = math.ceil (initialInsulation + upgrades * (finalInsulation - initialInsulation) / max_upgrades)

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
		if food and food.components.edible and food.prefab == "corn" or food.prefab == "carrot" or food.prefab == "eggplant" or food.prefab == "dragonfruit" then
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

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-364189966") then
		if mitsuruBalanced then	
			AddPrefabPostInit("mitsuru", balanceMitsuruStats)
			LogHelper.printInfo("Balancing Mitsuru")
		else
			LogHelper.printInfo("Ignoring Mitsuru")
		end
	end

end