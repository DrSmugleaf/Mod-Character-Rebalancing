local drokBalanced = GetModConfigData("DROK_BALANCED")

local function balanceDrokStats(inst)

	local drokStats =	{
							health = 175,
							hunger = 200,
							damage = 1.5,
						}
	
	ModifyStats(inst, drokStats)
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-373622746") then
		if drokBalanced then
			AddPrefabPostInit("drok", balanceDrokStats)
			LogHelper.printInfo("Balancing Drok the Caveman")
		else
			LogHelper.printInfo("Ignoring Drok the Caveman")
		end
	end

end