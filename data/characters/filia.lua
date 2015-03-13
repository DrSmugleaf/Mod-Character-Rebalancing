local filiaBalanced = GetModConfigData("FILIA_BALANCED")

local function balanceFiliaStats(inst)
	
	local filiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 150,
							damage = 1.5,
							walkSpeed = 1.5,
							runSpeed = 1.5,
						}
						
	ModifyStats(inst, filiaStats)
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-398833909") then
		if filiaBalanced then
			AddPrefabPostInit("filia", balanceFiliaStats)
			LogHelper.printInfo("Balancing Filia")
		else
			LogHelper.printInfo("Ignoring Filia")
		end
	end
	
end