local crashBandicootBalanced = GetModConfigData("CRASHBANDICOOT_BALANCED")

local function balanceCrashBandicootStats(inst)

	local crashBandicootStats = {
									levelBase = 50,
									
									foodPrefab1 = "wumpa",
									foodPrefab2 = "wumpa_cooked",
									foodPrefab3 = "carrot",
									levelPerFood1 = 2,
									levelPerFood2 = 2,
									levelPerFood3 = 1,
									
									initialHealth = 75,
									initialHunger = 75,
									initialSanity = 100,
									initialWalkNerf = 1,
									initialRunNerf = 1,
									
									finalHealth = 100,
									finalHunger = 125,
									finalSanity = 150,
									finalRunNerf = 1,
									finalWalkNerf = 1,
								}
	
	ModifyStats(inst, crashBandicootStats)
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-382501575") then
		if crashBandicootBalanced then
			AddPrefabPostInit("crashbandi", balanceCrashBandicootStats)
			LogHelper.printInfo("Balancing Crash Bandicoot")
		else
			LogHelper.printInfo("Ignoring Crash Bandicoot")
		end
	end

end