local endiaBalanced = GetModConfigData("ENDIA_BALANCED")


local function balanceEndiaStats(inst)

	local endiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 75,
						}
						
	ModifyStats(inst, endiaStats)
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-363966651") then
		if endiaBalanced then
			AddPrefabPostInit("endia", balanceEndiaStats)
			LogHelper.printInfo("Balancing Endia")
		else
			LogHelper.printInfo("Ignoring Endia")
		end
	end


end