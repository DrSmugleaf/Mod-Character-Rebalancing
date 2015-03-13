local serasBalanced = GetModConfigData("SERAS_BALANCED")

local function balanceSerasStats(inst)

	ChangeStartingInventory:modifyInventory(inst, {"smallmeat", "smallmeat"})
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-360319890") then
		if serasBalanced then	
			AddPrefabPostInit("seras", balanceSerasStats)
			LogHelper.printInfo("Balancing Seras")
		else
			LogHelper.printInfo("Ignoring Seras")
		end
	end

end