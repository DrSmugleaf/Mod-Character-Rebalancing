local tamamoBalanced = GetModConfigData("TAMAMO_BALANCED")

local function FeralFn(inst)
	if inst.feral then
			local tamamoStats =	{
								health = 125,
								damage = 1,
								walkSpeed = 1,
								runSpeed = 1,
								dapperness = 0,
								hungerRate = 1,
							}
			
			ModifyStats(inst, tamamoStats)

			inst.feral = false
	else
			local tamamoStats =	{
								health = 125,
								damage = 1.5,
								walkSpeed = 1.5,
								runSpeed = 1.5,
								dapperness = -2*TUNING.DAPPERNESS_LARGE,
								hungerRate = 1.5,
							}
			ModifyStats(inst, tamamoStats)

			inst.feral = true
	end
end

local function balanceTamamoStats(inst)

	-- Adds the mod rpc handler for Tamamo.
	AddModRPCHandler("MCR", "FERAL", FeralFn)

	if not inst.components.keyhandler then
		inst:AddComponent("keyhandler")
	end

	inst.components.keyhandler:AddActionListener("MCR", KEY_X, "FERAL")

	-- This is used for our changes to be made as server host.
	if not TheWorld.ismastersim then
		return inst
	end
	
	local DefaultEater = require("components/eater")
	
	local tamamoStats =	{
							health = 125,
							walkSpeed = 1,
							runSpeed = 1,
							damage = 1,
							dapperness = 0,
							hungerRate = 1,
						}
	
	ModifyStats(inst, tamamoStats)

	inst.feral = false
	
	inst:RemoveTag('<span class="searchlite">birdwhisperer</span>')
	inst:AddTag("scarytoprey")
	
	inst.components.eater.ignorespoilage = false
	function inst.components.eater:Eat(food)
		return DefaultEater.Eat(self, food)
	end

end

if ModBalancingEnabled() then

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-399799824") then
		if tamamoBalanced then	
			AddPrefabPostInit("tamamo", balanceTamamoStats)
			LogHelper.printInfo("Balancing Tamamo")
		else
			LogHelper.printInfo("Ignoring Tamamo")
		end
	end

end