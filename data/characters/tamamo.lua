local tamamoBalanced = GetModConfigData("TAMAMO_BALANCED")
local tamamoPreset = GetModConfigData("TAMAMO_PRESET")

local function FeralFn(inst)
	if inst:HasTag("playerghost") then return end
	if inst.feral then
			local tamamoStats =	{
									health = 125,
									walkSpeed = 1,
									runSpeed = 1,
									damage = 0.7,
									insulation = 35,
									dapperness = 0,
									hungerRate = 1.5,
								}
			
			ModifyStats(inst, tamamoStats)

			inst.components.health.absorb = 0.05

			inst.feral = false
	else
			local tamamoStats =	{
									health = 125,
									damage = 1.5,
									insulation = 35,
									walkSpeed = 1.5,
									runSpeed = 1.5,
									dapperness = -2*TUNING.DAPPERNESS_LARGE,
									hungerRate = 2.5,
								}
								
			ModifyStats(inst, tamamoStats)

			inst.components.health.absorb = 0.05

			inst.feral = true
	end
end

local function BallFn(inst)

	if inst:HasTag("playerghost") then return end
		
	if not inst.transformed then
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
		inst.components.health.absorb = 0.05
		inst.components.combat.damagemultiplier = 0.7
		inst.components.temperature.inherentinsulation = 35
		inst.components.hunger:SetRate(0.18310)
		 
		else
		inst.components.locomotor.walkspeed = (2.5)
		inst.components.locomotor.runspeed = (3.5)
		inst.components.health.absorb = 0.40
		inst.components.combat.damagemultiplier = 0.4
		inst.components.temperature.inherentinsulation = 65
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			 
	end
end

local function balanceTamamoStats(inst)

	-- Adds the mod rpc handler for Tamamo.
	AddModRPCHandler("MCR", "FERAL", FeralFn)
	AddModRPCHandler("MCR", "BALL", BallFn)

	if not inst.components.keyhandler then
		inst:AddComponent("keyhandler")
	end

	inst.components.keyhandler:AddActionListener("MCR", KEY_X, "FERAL")
	inst.components.keyhandler:AddActionListener("MCR", TUNING.TAMAMO.KEY, "BALL")

	-- This is used for our changes to be made as server host.
	if not TheWorld.ismastersim then
		return inst
	end
	
	local DefaultEater = require("components/eater")
	
	local tamamoStats =	{
							health = 125,
							walkSpeed = 1,
							runSpeed = 1,
							damage = 0.7,
							insulation = 35,
							dapperness = 0,
							hungerRate = 1.5,
						}
	
	ModifyStats(inst, tamamoStats)

	inst.feral = false
	
	inst:RemoveTag('<span class="searchlite">birdwhisperer</span>')

	if not tamamoPreset then
		inst:AddTag("scarytoprey")
	end
	
	inst.components.eater.ignorespoilage = false
	function inst.components.eater:Eat(food)
		return DefaultEater.Eat(self, food)
	end

end

if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-399799824") then
		if tamamoBalanced then	
			AddPrefabPostInit("tamamo", balanceTamamoStats)
			LogHelper.printInfo("Balancing Tamamo")
		else
			LogHelper.printInfo("Ignoring Tamamo")
		end
	end

end