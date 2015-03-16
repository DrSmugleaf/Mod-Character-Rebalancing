local freeSpiritBalanced = GetModConfigData("FREESPIRIT_BALANCED")

local function balanceFreeSpiritStats(inst)

	local freeSpiritStats =	{
									health = 150,
									hunger = 125,
									sanity = 125,
									insulation = 0,
									strongStomach = false,
									hungerRate = 1,


									--[[healthNerf = 125,
									hungerNerf = 150,
									sanityNerf = 150,
									damageNerf = 1.25,
									insulationNerf = 0,
									walkSpeedNerf = 1,
									runSpeedNerf = 1,
									dappernessNerf = 0,
									nightDrainNerf = 1,
									monsterDrainNerf = 1,
									strongStomachNerf = false,
									hungerRateNerf = 1.25,


									levelBase = 100,
									
									foodPrefab1 = "wumpa",
									foodPrefab2 = "wumpa_cooked",
									foodPrefab3 = "carrot",
									levelPerFood1 = 2,
									levelPerFood2 = 2,
									levelPerFood3 = 1,
									
									initialHealth = 75,
									initialHunger = 75,
									initialSanity = 100,
									initialDamage = 1,
									initialInsulation = 0,
									initialWalk = 1.25,
									initialRun = 1.25,
									
									finalHealth = 100,
									finalHunger = 125,
									finalSanity = 150,
									finalDamage = 1,
									finalInsulation = 0,
									finalRun = 1.50,
									finalWalk = 1.50,


									initialHealthNerf = 100,
									initialHungerNerf = 100,
									initialSanityNerf = 125,
									initialDamageNerf = 1,
									initialInsulationNerf = 0,
									initialWalkNerf = 1,
									initialRunNerf = 1,

									finalHealthNerf = 150,
									finalHungerNerf = 150,
									finalSanityNerf = 200,
									finalDamageNerf = 1.50,
									finalInsulationNerf = 0,
									finalWalkNerf = 1,
									finalRunNerf = 1,]]
							}
	
	ModifyStats(inst, freeSpiritStats)
	
end

if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-359318959") then
		if freeSpiritBalanced then
			AddPrefabPostInit("freebre", balanceFreeSpiritStats)
			LogHelper.printInfo("Balancing FreeSpirit the Umbreon")
		else
			LogHelper.printInfo("Ignoring FreeSpirit the Umbreon")
		end
	end

end