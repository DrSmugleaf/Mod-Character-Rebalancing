local woodieBalanced = GetModConfigData("WOODIE_BALANCED")

local function balanceWoodieStats(inst)

	local woodieStats = {

							levelBase =  0,

							foodPrefab1 =  "butterflymuffin",
							levelPerFood1 = 1,
								
							initialHealth = 75,
							initialHunger = 100,
							initialSanity = 100,

							finalHealth = 175,
							finalHunger = 200,
							finalSanity = 175,
						}

	ModifyStats(inst, woodieStats)
	
end

local function balanceWoodieAxe(inst)
	
    inst:AddTag("undroppable")
	
	inst:AddComponent("characterspecific")
	inst.components.characterspecific:SetOwner("woodie")
	
end

if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-384633033") then
		if woodieBalanced then	
			AddPrefabPostInit("woodie", balanceWoodieStats)
			AddPrefabPostInit("lucy", balanceWoodieAxe)
			LogHelper.printInfo("Balancing PrzemoLSZ's Woodie")
		else
			LogHelper.printInfo("Ignoring PrszemoLSZ's Woodie")
		end
	end

end