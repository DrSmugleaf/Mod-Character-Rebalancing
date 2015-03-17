local woodieBalanced = GetModConfigData("WOODIE_BALANCED")

local function balanceWoodieStats(inst)

	inst:AddTag("lucy")

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


	if not TheWorld.ismastersim then
		return inst
	end

	if inst.components.inventoryitem then
		inst.components.inventoryitem._onpickupfn = inst.components.inventoryitem.onpickupfn

		inst.components.inventoryitem.onpickupfn = function(inst, doer, ...)
			if not doer:HasTag("lucy") then
				self.inst.components.talker:Say("This isn't mine")
	 			self:DropItem(item)
	 			return false -- Prevents item from being obtained
	 		else
	 			return inst.components.inventoryitem._onpickupfn(inst, doer, ...)
	 		end
		end
	end
	
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