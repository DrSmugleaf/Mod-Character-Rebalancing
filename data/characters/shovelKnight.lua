local shovelKnightBalanced = GetModConfigData("SHOVELKNIGHT_BALANCED")


local function balanceShovelKnightStats(inst)
end

local function balanceShovelKnightBlades(inst)
	
	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("winston")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("I'm not mighty enough for glorious shovelry!")

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-369544255") then
		if shovelKnightBalanced then
			AddPrefabPostInit("winston", balanceShovelKnightStats)
			AddPrefabPostInit("skweaponshovelbladebasic", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladechargehandle", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladetrenchblade", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladedropspark", balanceShovelKnightBlades)
			LogHelper.printInfo("Balancing Shovel Knight")
		else
			LogHelper.printInfo("Ignoring Shovel Knight")
		end
	end

end