local growlieBalanced = GetModConfigData("GROWLIE_BALANCED")
local nerfSpeed = GetModConfigData("NERF_SPEED")


local function balanceGrowlieStats(inst)

	inst.Light:Enable(false)
	inst.Light:SetRadius(2)
	inst.Light:SetFalloff(.5)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(152/255,153/255,255/255)

	local function applyForm(inst)
		if inst.form == "demonic" then
			local damageMultiplier = nil
			local speed = nil
			if not nerfSpeed then
				damageMultiplier = 1.50
				speed = 1.50
			elseif nerfSpeed then
				damageMultiplier = 1.50
				speed = 1.25
			end

			inst.components.combat.damagemultiplier = damageMultiplier
			inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED * speed
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED * speed
		end

		if inst.form == "normal" then
			local damageMultiplier = nil
			local speed = nil
			if not nerfSpeed then
				damageMultiplier = 1.25
				speed = 1.25
			elseif nerfSpeed then
				damageMultiplier = 1.25
				speed = 1
			end
			inst.components.combat.damagemultiplier = damageMultiplier
			inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED * speed
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED * speed
		end

	end

	local function becomenormal(inst, silent)

		if inst.form == "normal" then
			return
		end

		inst.form = "normal"

	end

	local function becomedemonic(inst, silent)

		if inst.form == "demonic" then
			return
		end

		inst.form = "demonic"

	end

	local function onhungerchange(inst, data, forcesilent)

		if inst.sg:HasStateTag("nomorph") or
			inst:HasTag("playerghost") or
			inst.components.health:IsDead() then
			return
		end

		local silent = inst.sg:HasStateTag("silentmorph") or not inst.entity:IsVisible() or forcesilent

		if inst.form == "demonic" then
			if inst.components.sanity.current > (30) then
				becomenormal(inst, silent)
			end
		elseif inst.form == "normal" then
			if inst.components.sanity.current < (30) then
				becomedemonic(inst, silent)
			end
		end
		applyForm(inst)

	end

	local function onnewstate(inst)

		if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
			inst._wasnomorph = not inst._wasnomorph
			if not inst._wasnomorph then
				onhungerchange(inst)
			end
		end

	end

	local function onbecameghost(inst)
		if inst._wasnomorph ~= nil then
			inst.strength = "normal"
			inst._wasnomorph = nil
			inst.talksoundoverride = nil
			inst.hurtsoundoverride = nil
			inst:RemoveEventCallback("hungerdelta", onhungerchange)
			inst:RemoveEventCallback("newstate", onnewstate)
		end
	end

	local function onbecamehuman(inst)
	    if inst._wasnomorph == nil then
	        inst.strength = "normal"
	        inst._wasnomorph = inst.sg:HasStateTag("nomorph")
	        inst.talksoundoverride = nil
	        inst.hurtsoundoverride = nil
	        inst:ListenForEvent("sanitydelta", onhungerchange)
	        inst:ListenForEvent("newstate", onnewstate)
	        onhungerchange(inst, nil, true)
	    end
	end

	inst.form = "normal"
	inst._wasnomorph = nil
	inst.talksoundoverride = nil
	inst.hurtsoundoverride = nil

	inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
	inst:ListenForEvent("ms_becameghost", onbecameghost)

	if inst:HasTag("playerghost") then
		onbecameghost(inst)
	else
		onbecamehuman(inst)
	end
	inst.OnNewSpawn = onload

	ChangeStartingInventory:modifyInventory(inst, {})

	local growlieStats =	{
								health = 75,
								hunger = 100,
								sanity = 100,
								damage = 1.25,
								insulation = 0,
								walkSpeed = 1.25,
								runSpeed = 1.25,
								dapperness = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrain = 0.75,
								monsterDrain = 0.75,
								strongStomach = false,
								hungerRate = 1.5,


								healthNerf = 100,
								hungerNerf = 125,
								sanityNerf = 125,
								damageNerf = 1.25,
								insulationNerf = 0,
								walkSpeedNerf = 1,
								runSpeedNerf = 1,
								dappernessNerf = TUNING.DAPPERNESS_TINY * -0.33,
								nightDrainNerf = 0.6,
								monsterDrainNerf = 0.6,
								strongStomachNerf = false,
								hungerRateNerf = 1.5,
							}
						
	ModifyStats(inst, growlieStats)
	
end

local function balanceGrowlieSpear(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("growlie")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("I don't think a gem on a stick would be useful to me.")

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-400461720") then
		if growlieBalanced then
			AddPrefabPostInit("growlie", balanceGrowlieStats)
			AddPrefabPostInit("spear_growlie", balanceGrowlieSpear)
			AddPrefabPostInit("terrorbeak", function(inst)
				if inst.components.combat.onkilledbyother then
					inst.components.combat._onkilledbyother = inst.components.combat.onkilledbyother
				end
				
				inst.components.combat.onkilledbyother = function(inst, attacker)
					if attacker and attacker.components.sanity then
						if attacker.prefab == "growlie" and attacker.form == "demonic" then
							return attacker.components.sanity:DoDelta(0)
						end
						
						if inst.components.combat._onkilledbyother then
							return inst.components.combat._onkilledbyother(inst, attacker)
						end
					end
					
				end
			end)
			AddPrefabPostInit("crawlinghorror", function(inst)
				if inst.components.combat.onkilledbyother then
					inst.components.combat._onkilledbyother = inst.components.combat.onkilledbyother
				end
				
				inst.components.combat.onkilledbyother = function(inst, attacker)
					if attacker and attacker.components.sanity then
						if attacker.prefab == "growlie" and attacker.form == "demonic" then
							return attacker.components.sanity:DoDelta(0)
						end
						
						if inst.components.combat._onkilledbyother then
							return inst.components.combat._onkilledbyother(inst, attacker)
						end
					end
					
				end
			end)
			LogHelper.printInfo("Balancing Growlie")
		else
			LogHelper.printInfo("Ignoring Growlie")
		end
	end

end