local shovelKnightBalanced = GetModConfigData("SHOVELKNIGHT_BALANCED")

local function balanceShovelKnightStats(inst)

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
	
	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("winston")
	inst.components.characterspecific:SetStorable(true)
	
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