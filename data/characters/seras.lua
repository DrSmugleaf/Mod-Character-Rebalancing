local serasBalanced = GetModConfigData("SERAS_BALANCED")


local function balanceSerasStats(inst)

	ChangeStartingInventory:modifyInventory(inst, {"smallmeat", "smallmeat"})
	
end

local function balanceSerasSword(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("seras")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("This sword is disgusting!")
	
end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-360319890") then
		if serasBalanced then	
			AddPrefabPostInit("seras", balanceSerasStats)
			AddPrefabPostInit("bloodsword", balanceSerasSword)
			LogHelper.printInfo("Balancing Seras")
		else
			LogHelper.printInfo("Ignoring Seras")
		end
	end

end