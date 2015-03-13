local luffyBalanced = GetModConfigData("LUFFY_BALANCED")

local function balanceLuffyStats(inst)

	local luffyStats =	{
							health = 100,
							sanity = 100,
							hungerRate = 2.0,
						}
						
	ModifyStats(inst, luffyStats)

end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-380079744") then
		if luffyBalanced then
			AddPrefabPostInit("luffy", balanceLuffyStats)
			LogHelper.printInfo("Balancing Luffy")
		else
			LogHelper.printInfo("Ignoring Luffy")
		end
	end	

end