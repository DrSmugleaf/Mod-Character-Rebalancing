local tamamoBalanced = GetModConfigData("TAMAMO_BALANCED")

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
							damage = 0.7,
							insulation = 35,
							dapperness = 0,
							hungerRate = 1.5,
						}
	
	ModifyStats(inst, tamamoStats)

	inst.feral = false
	
	inst:RemoveTag('<span class="searchlite">birdwhisperer</span>')
	inst:AddTag("scarytoprey")
	
	inst.components.eater.ignorespoilage = false
	function inst.components.eater:Eat(food)
		return DefaultEater.Eat(self, food)
	end


	local function BallFn(inst)

		if inst:HasTag("playerghost") then return end
		if inst.transformed then
		inst.AnimState:SetBuild("tamamo")
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
		inst.components.health.absorb = 0.05
		inst.components.combat.damagemultiplier = 0.7
		inst.components.temperature.inherentinsulation = 35
		inst.components.hunger:SetRate(0.18310)
		 
		else
		inst.AnimState:SetBuild("tamamo_ball")
		inst.components.locomotor.walkspeed = (2.5)
		inst.components.locomotor.runspeed = (3.5)
		inst.components.health.absorb = 0.40
		inst.components.combat.damagemultiplier = 0.4
		inst.components.temperature.inherentinsulation = 65
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
		 
		end
		 
		inst.transformed = not inst.transformed

		return true

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