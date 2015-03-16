local madeleineBalanced = GetModConfigData("MADELEINE_BALANCED")

local function balanceMadeleineStats(inst)

	ChangeStartingInventory:modifyInventory(inst, {"goldnugget", "redgem", "redgem", "bluegem", "bluegem", "purplegem"})

end

if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-369228986") then
		if madeleineBalanced then	
			AddPrefabPostInit("madeleine", balanceMadeleineStats)
			LogHelper.printInfo("Balancing Madeleine")
		else
			LogHelper.printInfo("Ignoring Madeleine")
		end
	end

end