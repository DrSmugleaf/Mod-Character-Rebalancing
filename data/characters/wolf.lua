local wolfBalanced = GetModConfigData("WOLF_BALANCED")

local function balanceWolfStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-0.75
	
end

if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-369435452") then
		if wolfBalanced then	
			AddPrefabPostInit("wolft", balanceWolfStats)
			LogHelper.printInfo("Balancing Wolf")
		else
			LogHelper.printInfo("Ignoring Wolf")
		end
	end

end