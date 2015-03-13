local michaelTheFoxBalanced = GetModConfigData("MICHAELTHEFOX_BALANCED")

local function balanceMichaelTheFoxStats(inst)

	local michaelTheFoxStats =	{
									health = 75,
									hunger = 125,
									sanity = 75,
									damage = 0.75,
									nightDrain = 1.25,
									monsterDrain = 1.25,
									dapperness = TUNING.DAPPERNESS_TINY*-1,
									
									healthNerf = 100,
									hungerNerf = 150,
									sanityNerf = 100,
									damageNerf = 0.85,
									nightDrainNerf = 1.10,
									monsterDrainNerf = 1.10,
									dappernessNerf = TUNING.DAPPERNESS_TINY*0.5,
									walkSpeedNerf = 1.25,
									runSpeedNerf = 1.25,
								}

	ModifyStats(inst, michaelTheFoxStats)
	inst:AddTag("insomniac")

end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-357013795") then
		if michaelTheFoxBalanced then	
			AddPrefabPostInit("fox", balanceMichaelTheFoxStats)
			LogHelper.printInfo("Balancing Michael the Fox")
		else
			LogHelper.printInfo("Ignoring Michael the Fox")
		end
	end

end