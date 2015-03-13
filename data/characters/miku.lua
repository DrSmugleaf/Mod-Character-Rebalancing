local mikuHatsuneBalanced = GetModConfigData("MIKUHATSUNE_BALANCED")

local function balanceMikuHatsuneStats(inst)

	local mikuHatsuneStats =	{
									health = 100,
									hunger = 100,
									sanity = 100,
									damage = 0.75,
								}
								
	ModifyStats(inst, mikuHatsuneStats)

end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-368321978") then
		if mikuHatsuneBalanced then
			AddPrefabPostInit("miku", balanceMikuHatsuneStats)
			LogHelper.printInfo("Balancing Miku Hatsune")
		else
			LogHelper.printInfo("Ignoring Miku Hatsune")
		end
	end

end