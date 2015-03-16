local shovelKnightBalanced = GetModConfigData("SHOVELKNIGHT_BALANCED")

local function balanceShovelKnightStats(inst)

end

local function balanceShovelKnightBlades(inst)
	
	if inst == nil then print("We're fucked.") return end

	inst.components.inventoryitem.keepondeath = true
	
	inst:AddComponent("characterspecific")
	inst.components.characterspecific:SetOwner("winston")
	
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