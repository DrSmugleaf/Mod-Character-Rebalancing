local freeSpiritBalanced = GetModConfigData("FREESPIRIT_BALANCED")


local function balanceFreeSpiritStats(inst)

	local freeSpiritStats =	{
									health = 150,
									hunger = 125,
									sanity = 125,
									insulation = 0,
									strongStomach = false,
									hungerRate = 1,
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