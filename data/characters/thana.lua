local thanaBalanced = GetModConfigData("THANA_BALANCED")

local function WingsFn(inst)
	if inst:HasTag("playerghost") then return end
	if inst.wings then
			local thanaStats =	{

								}
			
			ModifyStats(inst, thanaStats)

			inst.wings = false
	else
			local thanaStats =	{

								}

			ModifyStats(inst, thanaStats)

			inst.wings = true
	end
end

local function balanceThanaStats(inst)

	-- Adds the mod rpc handler for Thana.
	AddModRPCHandler("MCR", "WINGS", WingsFn)

	if not inst.components.keyhandler then
		inst:AddComponent("keyhandler")
	end

	inst.components.keyhandler:AddActionListener("MCR", KEY_X, "WINGS")

	-- This is used for our changes to be made as server host.
	if not TheWorld.ismastersim then
		return inst
	end

	
	local thanaStats =	{

						}
	
	ModifyStats(inst, thanaStats)

	inst.wings = false

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-368541793") then
		if thanaBalanced then	
			AddPrefabPostInit("thana", balanceThanaStats)
			LogHelper.printInfo("Balancing Thana")
		else
			LogHelper.printInfo("Ignoring Thana")
		end
	end

end