local warkBalanced = GetModConfigData("WARK_BALANCED")

local function balanceWarkStats(inst)

	local warkStats =	{
							health = 125,
							hunger = 150,
							damage = 0.8,
							
							healthNerf = 150,
							hungerNerf = 150,
							damageNerf = 0.8,
							walkSpeedNerf = 1.25,
							runSpeedNerf = 1.25,
						}
	
	ModifyStats(inst, warkStats)
	
end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369518979") then
		if warkBalanced then	
			AddPrefabPostInit("wark", balanceWarkStats)
			LogHelper.printInfo("Balancing Wark")
		else
			LogHelper.printInfo("Ignoring Wark")
		end
	end

end