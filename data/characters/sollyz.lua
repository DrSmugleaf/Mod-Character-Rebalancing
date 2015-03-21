local sollyzBalanced = GetModConfigData("SOLLYZ_BALANCED")
local levelSetting = GetModConfigData("LEVEL_SETTING")

local function balanceSollyzStats(inst)

	if not levelSetting == "disabled" then

		local oldPreLoad = inst.OnPreLoad
		local oldEat = inst.components.eater.oneatfn
		
		local levelBase = 0
		
		local initialHealth = 50
		local initialHunger = 75
		local initialSanity = 50
		
		local finalHealth = 100
		local finalHunger = 150
		local finalSanity = 90
		
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
		if food and food.components.edible and food.prefab == "fish"  then
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

	if KnownModIndex:IsModEnabled("workshop-359479220") then
		if sollyzBalanced then	
			AddPrefabPostInit("sollyz", balanceSollyzStats)
			LogHelper.printInfo("Balancing Sollyz")
		else
			LogHelper.printInfo("Ignoring Sollyz")
		end
	end

end