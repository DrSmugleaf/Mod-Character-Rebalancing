local darkSakuraBalanced = GetModConfigData("DARKSAKURA_BALANCED")

local function balanceDarkSakuraStats(inst)

	local darkSakuraStats =	{
								health = 75,
								hunger = 75,
								sanity = 75,
								insulation = 0,
								nightDrain = 1.25,
								monsterDrain = 1.25,
								strongStomach = true,
								hungerRate = 2,


								healthNerf = 75,
								hungerNerf = 75,
								sanityNerf = 75,
								insulationNerf = 0,
								nightDrainNerf = 1.25,
								monsterDrainNerf = 1.25,
								strongStomachNerf = true,
								hungerRateNerf = 2,


								levelBase = 50,
								
								foodPrefab1 = "monsterlasagna",
								levelPerFood1 = 1,
								
								initialHealth = 42,
								initialHunger = 100,
								initialSanity = 100,
								initialInsulation = 0,
								
								finalHealth = 84,
								finalHunger = 150,
								finalSanity = 150,
								finalInsulation = 0,


								initialHealthNerf = 42,
								initialHungerNerf = 100,
								initialSanityNerf = 100,
								initialInsulationNerf = 0,

								finalHealthNerf = 84,
								finalHungerNerf = 150,
								finalSanityNerf = 150,
								finalInsulationNerf = 0,
							}

	ModifyStats(inst, darkSakuraStats)

end

if ModBalancingEnabled() then 

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384048428") then
		if darkSakuraBalanced then
			AddPrefabPostInit("sakura", balanceDarkSakuraStats)
			LogHelper.printInfo("Balancing Dark Sakura Matou")
		else
			LogHelper.printInfo("Ignoring Dark Sakura Matou")
		end
	end

end