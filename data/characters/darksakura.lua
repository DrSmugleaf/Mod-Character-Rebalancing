local darkSakuraBalanced = GetModConfigData("DARKSAKURA_BALANCED")

local function balanceDarkSakuraStats(inst)

	local darkSakuraStats =	{
								health = 75,
								hunger = 100,
							}

	ModifyStats(inst, darkSakuraStats)

end

if ModBalancingEnabled() then 

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384048428") then
		if darkSakuraBalanced then
			AddPrefabPostInit("sakura", balanceDarkSakuraStats)
			LogHelper.printInfo("Balancing Dark Sakura Matou")
		else
			LogHelper.printInfo("Ignoring Dark Sakura Matou")
		end
	end

end