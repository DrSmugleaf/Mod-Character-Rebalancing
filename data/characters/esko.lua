local eskoBalanced = GetModConfigData("ESKO_BALANCED")

local function balanceEskoStats(inst)
	
	local eskoStats =	{
							levelBase = 25,
							foodPrefab1 = "fish",
							levelPerFood1 = 1,
							
							initialHealth = 75,
							initialHunger = 100,
							initialSanity = 75,
							initialDamage = 0.7,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealth = 125,
							finalHunger = 150,
							finalSanity = 100,
							finalDamage = 1,
							finalWalk = 1.5,
							finalRun = 1.5,
							
							hungerRate = 2,
							
							
							initialHealthNerf = 100,
							initialHungerNerf = 100,
							initialSanityNerf = 100,
							initialDamageNerf = 0.7,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealthNerf = 150,
							finalHungerNerf = 150,
							finalSanityNerf = 125,
							finalDamageNerf = 0.9,
							finalWalkNerf = 1.25,
							finalRunNerf = 1.25,
							
							hungerRateNerf = 1.75,
						}
	
	ModifyStats(inst, eskoStats)
	
end

if ModBalancingEnabled() then 

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-356880841") then
		if eskoBalanced then
			AddPrefabPostInit("esk", balanceEskoStats)
			LogHelper.printInfo("Balancing Esko")
		else
			LogHelper.printInfo("Ignoring Esko")
		end
	end

end