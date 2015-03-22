local eskoBalanced = GetModConfigData("ESKO_BALANCED")

local function balanceEskoStats(inst)
	
	local eskoStats =	{
							health = 100,
							hunger = 125,
							sanity = 100,
							damage = 0.8,
							insulation = 0,
							walkSpeed = 1.30,
							runSpeed = 1.30,
							dapperness = 0,
							nightDrain = 1,
							monsterDrain = 1,
							strongStomach = false,
							hungerRate = 2,


							healthNerf = 150,
							hungerNerf = 150,
							sanityNerf = 150,
							damageNerf = 0.8,
							insulationNerf = 0,
							walkSpeedNerf = 1.15,
							runSpeedNerf = 1.15,
							dappernessNerf = 0,
							nightDrainNerf = 1,
							monsterDrainNerf = 1,
							strongStomachNerf = false,
							hungerRateNerf = 1.75,



							levelBase = 25,
							foodPrefab1 = "fish",
							levelPerFood1 = 1,
							
							initialHealth = 75,
							initialHunger = 100,
							initialSanity = 75,
							initialDamage = 0.7,
							initialInsulation = 0,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealth = 125,
							finalHunger = 150,
							finalSanity = 100,
							finalDamage = 1,
							finalInsulation = 0,
							finalWalk = 1.5,
							finalRun = 1.5,
							
							
							initialHealthNerf = 100,
							initialHungerNerf = 100,
							initialSanityNerf = 100,
							initialDamageNerf = 0.7,
							initialInsulationNerf = 0,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealthNerf = 150,
							finalHungerNerf = 150,
							finalSanityNerf = 150,
							finalDamageNerf = 1,
							finalInsulationNerf = 0,
							finalWalkNerf = 1.15,
							finalRunNerf = 1.15,
						}
	
	ModifyStats(inst, eskoStats)
	
end

if ModBalancingEnabled() then 

	if KnownModIndex:IsModEnabled("workshop-356880841") then
		if eskoBalanced then
			AddPrefabPostInit("esk", balanceEskoStats)
			LogHelper.printInfo("Balancing Esko")
		else
			LogHelper.printInfo("Ignoring Esko")
		end
	end

end