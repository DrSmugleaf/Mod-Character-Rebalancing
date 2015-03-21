local growlieBalanced = GetModConfigData("GROWLIE_BALANCED")


	
local function balanceGrowlieStats(inst)

	local growlieStats =	{
								health = 75,
								hunger = 100,
								sanity = 100,
								damage = 1.25,
								insulation = 0,
								walkSpeed = 1.25,
								runSpeed = 1.25,
								dapperness = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrain = 0.75,
								monsterDrain = 0.75,
								strongStomach = false,
								hungerRate = 1.5,


								healthNerf = 100,
								hungerNerf = 125,
								sanityNerf = 125,
								damageNerf = 1.25,
								insulationNerf = 0,
								walkSpeedNerf = 1,
								runSpeedNerf = 1,
								dappernessNerf = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrainNerf = 0.6,
								monsterDrainNerf = 0.6,
								strongStomachNerf = false,
								hungerRateNerf = 1.5,


								levelBase = 50,
								
								foodPrefab1 = "corn",
								foodPrefab2 = "pumpkin",
								foodPrefab3 = "eggplant",
								foodPrefab4 = "pomegranate",
								foodPrefab5 = "dragonfruit",
								levelPerFood1 = 1,
								levelPerFood2 = 3,
								levelPerFood3 = 3,
								levelPerFood4 = 5,
								levelPerFood5 = 5,
								
								initialHealth = 50,
								initialHunger = 75,
								initialSanity = 75,
								initialDamage = 0.75,
								initialInsulation = 0,
								initialWalk = 1,
								initialRun = 1,
								
								finalHealth = 100,
								finalHunger = 150,
								finalSanity = 100,
								finalDamage = 1,
								finalInsulation = 0,
								finalWalk = 1,
								finalRun = 1,


								initialHealthNerf = 50,
								initialHungerNerf = 75,
								initialSanityNerf = 75,
								initialDamageNerf = 0.75,
								initialInsulationNerf = 0,
								initialWalkNerf = 1,
								initialRunNerf = 1,

								finalHealthNerf = 100,
								finalHungerNerf = 150,
								finalSanityNerf = 100,
								finalDamageNerf = 1,
								finalInsulationNerf = 0,
								finalWalkNerf = 1,
								finalRunNerf = 1,
							}
						
	ModifyStats(inst, growlieStats)



	inst.components.eater.foodprefs = { FOODGROUP.OMNI, FOODTYPE.GROWLIEFOOD, }
	
end

local function makeNightmareFuelEdible(inst)
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.WOOD

	inst.components.edible.oneaten = function(inst, eater)
		if not eater.prefab == "growlie" then
			eater.components.health:DoDelta(-10)
			eater.components.hunger:DoDelta(-10)
			eater.components.sanity:DoDelta(0)
			eater.components.talker:Say("That tasted very demonic.")
		end
	end
end

local function balanceGrowlieSpear(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("growlie")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("I don't think a gem on a stick would be useful to me.")

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-400461720") then
		if growlieBalanced then
			AddPrefabPostInit("growlie", balanceGrowlieStats)
			AddPrefabPostInit("spear_growlie", balanceGrowlieSpear)
			AddPrefabPostInit("nightmarefuel", makeNightmareFuelEdible)
			LogHelper.printInfo("Balancing Growlie")
		else
			LogHelper.printInfo("Ignoring Growlie")
		end
	end

end