local growlieBalanced = GetModConfigData("GROWLIE_BALANCED")



local function balanceGrowlieStats(inst)

	ChangeStartingInventory:modifyInventory(inst, {})

	local growlieStats =	{
								health = 75,
								hunger = 100,
								sanity = 100,
								damage = 1.25,
								insulation = 0,
								walkSpeed = 1.25,
								runSpeed = 1.25,
								dapperness = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrain = 0.75,
								monsterDrain = 0.75,
								strongStomach = false,
								hungerRate = 1.5,


								healthNerf = 100,
								hungerNerf = 125,
								sanityNerf = 125,
								damageNerf = 1.25,
								insulationNerf = 0,
								walkSpeedNerf = 1,
								runSpeedNerf = 1,
								dappernessNerf = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrainNerf = 0.6,
								monsterDrainNerf = 0.6,
								strongStomachNerf = false,
								hungerRateNerf = 1.5,
							}
						
	ModifyStats(inst, growlieStats)
	
end

local function balanceGrowlieSpear(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("growlie")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("I don't think a gem on a stick would be useful to me.")

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-400461720") then
		if growlieBalanced then
			AddPrefabPostInit("growlie", balanceGrowlieStats)
			AddPrefabPostInit("spear_growlie", balanceGrowlieSpear)
			LogHelper.printInfo("Balancing Growlie")
		else
			LogHelper.printInfo("Ignoring Growlie")
		end
	end

end