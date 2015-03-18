local shovelKnightBalanced = GetModConfigData("SHOVELKNIGHT_BALANCED")

local function balanceShovelKnightStats(inst)

	inst:AddTag("shovelblades")

	local function ondeathkill(inst, deadthing)

		inst.components.sanity:DoDelta(0)

	end

	local function onkill(inst, data)

		if data.afflicter == inst 
			and not data.inst:HasTag("prey") 
			and not data.inst:HasTag("veggie") 
			and not data.inst:HasTag("structure") then
			inst.components.sanity:DoDelta(5)
		end

	end

	inst._onplayerkillthing = function(player, data)
		onkill(inst, data)
	end

end

local function balanceShovelKnightConjurerCoat(inst)

	local function activate(owner)
		owner:ListenForEvent("killed", owner._onplayerkillthing, owner)
	end

end

local function balanceShovelKnightBlades(inst)
	
	if inst == nil then print("We're fucked.") return end

	inst.components.inventoryitem.keepondeath = true
	
	if not TheWorld.ismastersim then
		return inst
	end

	if inst.components.inventoryitem then
		inst.components.inventoryitem._onpickupfn = inst.components.inventoryitem.onpickupfn

		inst.components.inventoryitem.onpickupfn = function(inst, doer, ...)
			if not doer:HasTag("shovelblades") then
				doer.components.talker:Say("This isn't mine")
				if self and self.activeitem then
	 			self:DropItem(item)
	 			return false -- Prevents item from being obtained
	 			end
	 		else
	 			return inst.components.inventoryitem._onpickupfn(inst, doer, ...)
	 		end
		end
	end
	
end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-369544255") then
		if shovelKnightBalanced then
			AddPrefabPostInit("winston", balanceShovelKnightStats)
			AddPrefabPostInit("skweaponshovelbladebasic", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladechargehandle", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladetrenchblade", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladedropspark", balanceShovelKnightBlades)
			AddPrefabPostInit("skarmorconjurerscoat", balanceShovelKnightConjurerCoat)
			LogHelper.printInfo("Balancing Shovel Knight")
		else
			LogHelper.printInfo("Ignoring Shovel Knight")
		end
	end

end