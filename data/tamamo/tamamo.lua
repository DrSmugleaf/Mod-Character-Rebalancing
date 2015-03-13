local tamamoBalanced = GetModConfigData("TAMAMO_BALANCED")

local function FeralFn(inst)
	if inst.transformed then
			local tamamoStats =	{
								health = 125,
								damage = 1,
								walkSpeed = 1,
								runSpeed = 1,
								dapperness = 0,
								hungerRate = 1,
							}
			
			modifyStats(inst, tamamoStats)
	else
			local tamamoStats =	{
								health = 125,
								damage = 1.5,
								walkSpeed = 1.5,
								runSpeed = 1.5,
								dapperness = -2*TUNING.DAPPERNESS_LARGE,
								hungerRate = 1.5,
							}
			modifyStats(inst, tamamoStats)
	end
end

local function balanceTamamoStats(inst)
	
	local DefaultEater = require("components/eater")

	-- Adds the mod rpc handler for Tamamo.
	AddModRPCHandler("MCR", "FERAL", FeralFn)
	
	local tamamoStats =	{
							health = 125,
							walkSpeed = 1,
							runSpeed = 1,
							damage = 1,
							dapperness = 0,
							hungerRate = 1,
						}
	
	modifyStats(inst, tamamoStats)
	
	ModifyCharacter:addMode(inst, GLOBAL.KEY_X, "FERAL")
	
	inst:RemoveTag('<span class="searchlite">birdwhisperer</span>')
	inst:AddTag("scarytoprey")
	
	inst.components.eater.ignorespoilage = false
	function inst.components.eater:Eat(food)
		return DefaultEater.Eat(self, food)
	end

	-- This is used for our changes to be made as server host.
	if TheWorld.ismastersim then
		inst:ListenForEvent("MCRAction", FeralFn)
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