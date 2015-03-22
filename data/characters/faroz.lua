local farozBalanced = GetModConfigData("FAROZ_BALANCED")


local function balanceFarozStats(inst)

	local farozStats =	{
							dapperness = -0.25,
							nightDrain = 1.25,
							monsterDrain = 1.25,
						}
						
	ModifyStats(inst, farozStats)
	
end

local function balanceFarozGlasses(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("faroz")
	inst.components.characterspecific:SetStorable(false)
	inst.components.characterspecific:SetComment("These seem heavier than they look.")
	
end


if ModBalancingEnabled() then 

	if KnownModIndex:IsModEnabled("workshop-364491382") then
		if farozBalanced then
			AddPrefabPostInit("faroz", balanceFarozStats)
			AddPrefabPostInit("faroz_gls", balanceFarozGlasses)
			LogHelper.printInfo("Balancing Faroz")
		else
			LogHelper.printInfo("Ignoring Faroz")
		end
	end

end