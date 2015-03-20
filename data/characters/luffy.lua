local luffyBalanced = GetModConfigData("LUFFY_BALANCED")


local function balanceLuffyStats(inst)

	local luffyStats =	{
							health = 100,
							sanity = 100,
							hungerRate = 2.0,
						}
						
	ModifyStats(inst, luffyStats)

end

local function balanceLuffyHat(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("luffy")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("This hat just makes me uncomfortable.")
	
end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-380079744") then
		if luffyBalanced then
			AddPrefabPostInit("luffy", balanceLuffyStats)
			AddPrefabPostInit("luffyhat", balanceLuffyHat)
			LogHelper.printInfo("Balancing Luffy")
		else
			LogHelper.printInfo("Ignoring Luffy")
		end
	end	

end