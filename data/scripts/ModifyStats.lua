-------------------------------
-- Load Special Modes config --
-------------------------------
local nerfSpeed = GetModConfigData("NERF_SPEED")
local hardcoreMode = GetModConfigData("HARDCORE_MODE")

-------------------------------------------------------------------------
-- Load Leveling System config and assign base max levels difficulties --
-------------------------------------------------------------------------
local levelSetting = GetModConfigData("LEVEL_SETTING")

if levelSetting then

	if levelSetting == 1 then levelDifficulty = 30
	
	elseif levelSetting == 2 then levelDifficulty = 50
		
	elseif levelSetting == 3 then levelDifficulty = 75
		
	elseif levelSetting == 4 then levelDifficulty = 100
	
	end
	
	if hardcoreMode == 1 then levelDifficulty = levelDifficulty + 200 end
	
end


-----------------------------------------------------------------------
-- Add a leveling system to a character or plainly modify it's stats --
-----------------------------------------------------------------------
return function(inst, stats)

	-- Load the given stats
	
	local levelBase = stats.levelBase

	local health = nil
	local hunger = nil
	local sanity = nil
	local damage = nil
	local insulation = nil
	local walkSpeed = nil
	local runSpeed = nil
	local dapperness = nil
	local nightDrain = nil
	local monsterDrain = nil
	local strongStomcah = nil
	local hungerRate = nil
	
	if nerfSpeed == 0 then
		health = stats.health
		hunger = stats.hunger
		sanity = stats.sanity
		damage = stats.damage
		insulation = stats.insulation
		walkSpeed = stats.walkSpeed
		runSpeed = stats.runSpeed
		dapperness = stats.dapperness
		nightDrain = stats.nightDrain
		monsterDrain = stats.monsterDrain
		strongStomach = stats.strongStomach
		hungerRate = stats.hungerRate
	elseif nerfSpeed == 1 then
		health = stats.healthNerf
		hunger = stats.hungerNerf
		sanity = stats.sanityNerf
		damage = stats.damageNerf
		insulation = stats.insulationNerf
		walkSpeed = stats.walkSpeedNerf
		runSpeed = stats.runSpeedNerf
		dapperness = stats.dappernessNerf
		nightDrain = stats.nightDrainNerf
		monsterDrain = stats.monsterDrainNerf
		strongStomach = stats.strongStomachNerf
		hungerRate = stats.hungerRateNerf
	end
	
	
	--if hardcoreMode == 0 then levelBase = stats.levelBase
	--elseif hardcoreMode == 1 then levelBase = stats.hardcoreMode end

	local foodType = stats.foodType

	local foodPrefab1 = stats.foodPrefab1
	local foodPrefab2 = stats.foodPrefab2
	local foodPrefab3 = stats.foodPrefab3
	local foodPrefab4 = stats.foodPrefab4
	local foodPrefab5 = stats.foodPrefab5
		local levelPerFood1 = stats.levelPerFood1
		local levelPerFood2 = stats.levelPerFood2
		local levelPerFood3 = stats.levelPerFood3
		local levelPerFood4 = stats.levelPerFood4
		local levelPerFood5 = stats.levelPerFood5


	if nerfSpeed == 0 then
		initialHealth = stats.initialHealth
		initialHunger = stats.initialHunger
		initialSanity = stats.initialSanity
		initialDamage = stats.initialDamage
		initialInsulation = stats.initialInsulation
		initialWalk = stats.initialWalk
		initialRun = stats.initialRun
		finalHealth = stats.finalHealth
		finalHunger = stats.finalHunger
		finalSanity = stats.finalSanity
		finalDamage = stats.finalDamage
		finalInsulation = stats.finalInsulation
		finalWalk = stats.finalWalk
		finalRun = stats.finalRun
	elseif nerfSpeed == 1 then
		initialHealth = stats.initialHealthNerf
		initialHunger = stats.initialHungerNerf
		initialSanity = stats.initialSanityNerf
		initialDamage = stats.initialDamageNerf
		initialInsulation = stats.initialInsulationNerf
		initialWalk = stats.initialWalkNerf
		initialRun = stats.initialRunNerf
		finalHealth = stats.finalHealthNerf
		finalHunger = stats.finalHungerNerf
		finalSanity = stats.finalSanityNerf
		finalDamage = stats.finalDamageNerf
		finalInsulation = stats.finalInsulationNerf
		finalWalk = stats.finalWalkNerf
		finalRun = stats.finalRunNerf
	end
	
	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()
	
	if levelSetting > 0 and initialHealth or initialHunger or initialSanity or initialDamage or initialInsulation or initialWalk or initialRun then
		
		if not levelBase then
			levelBase = 0
		end
		
		maxUpgrades = levelDifficulty+levelBase
		
		function applyUpgrades(inst)

			local upgrades = math.min(inst.level, maxUpgrades)
	 
			local hunger_percent = inst.components.hunger:GetPercent()
			local health_percent = inst.components.health:GetPercent()
			local sanity_percent = inst.components.sanity:GetPercent()
			
			
			if initialHealth and finalHealth and upgrades and maxUpgrades then
			inst.components.health.maxhealth = math.ceil (initialHealth + upgrades * (finalHealth - initialHealth) / maxUpgrades)		
			end
			
			if initialHunger and finalHunger and upgrades and maxUpgrades then
			inst.components.hunger.max = math.ceil (initialHunger + upgrades * (finalHunger - initialHunger) / maxUpgrades)
			end
			
			if initialSanity and finalSanity and upgrades and maxUpgrades then
			inst.components.sanity.max = math.ceil (initialSanity + upgrades * (finalSanity - initialSanity) / maxUpgrades)
			end
			
			if initialDamage and finalDamage and upgrades and maxUpgrades then
			inst.components.combat.damagemultiplier = math.ceil (initialDamage + upgrades * (finalDamage - initialDamage) / maxUpgrades)
			end
			
			if initialInsulation and finalInsulation and upgrades and maxUpgrades then
			inst.components.temperature.inherentinsulation = math.ceil (initialInsulation + upgrades * (finalInsulation - initialInsulation) / maxUpgrades)
			end
			
			if initialWalk and finalWalk and initialRun and finalRun and upgrades and maxUpgrades then
			inst.components.locomotor.walkspeed =  math.ceil (TUNING.WILSON_WALK_SPEED * (initialWalk + upgrades * (finalWalk - initialWalk) / maxUpgrades))
			inst.components.locomotor.runspeed = math.ceil (TUNING.WILSON_RUN_SPEED * (initialRun + upgrades * (finalRun - initialRun) / maxUpgrades))
			end
			
			inst.components.talker:Say("Level : ".. (inst.level))
			
			if inst.level > math.ceil (maxUpgrades-1) then
				inst.components.talker:Say("Level : Max!")
			end
			
			inst.components.hunger:SetPercent(hunger_percent)
			inst.components.health:SetPercent(health_percent)
			inst.components.sanity:SetPercent(sanity_percent)
		end
		
		if foodType then
			local function oneat(inst, food)
			
				if food and food.components.edible and food.components.edible.foodtype=="foodType" then
					inst.level = inst.level + 1
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
				
			end
		end
		
		function oneat(inst, food)
			if foodPrefab1 and levelPerFood1 then -- If the variables exist
				if food and food.components.edible and food.prefab == foodPrefab1 then -- If its a food, edible and has the specified prefab
					inst.level = inst.level + levelPerFood1 -- Level up according to the variable levelPerFood
					applyUpgrades(inst) -- Set the stats
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup") -- Play a sound
				end
			end
			if foodPrefab2 and levelPerFood2 then
				if food and food.components.edible and food.prefab == foodPrefab2 then
					inst.level = inst.level + levelPerFood2
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
			end
			if foodPrefab3 and levelPerFood3 then
				if food and food.components.edible and food.prefab == foodPrefab3 then
					inst.level = inst.level + levelPerFood3
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
			end
			if foodPrefab4 and levelPerFood4 then
				if food and food.components.edible and food.prefab == foodPrefab4 then
					inst.level = inst.level + levelPerFood4
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
			end
			if foodPrefab5 and levelPerFood5 then
				if food and food.components.edible and food.prefab == foodPrefab5 then
					inst.level = inst.level + levelPerFood5
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				end
			end
		end
			
		local function onpreload(inst, data)
			if data then
				if data.level then
					inst.level = data.level
					applyUpgrades(inst)
					if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
					if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
					if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
					inst.components.health:DoDelta(0)
					inst.components.hunger:DoDelta(0)
					inst.components.sanity:DoDelta(0)
				end
			end
		end
		
		local function onsave(inst, data)
			data.level = inst.level
			data.charge_time = inst.charge_time
		end
		
		inst.level = 0
		inst.components.eater:SetOnEatFn(oneat)
		applyUpgrades(inst)
			
		inst.OnSave = onsave
		inst.OnPreLoad = onpreload
	end

		if health then
			inst.components.health:SetMaxHealth(health)
		end
		
		if hunger then
			inst.components.hunger:SetMax(hunger)
		end
		
		if sanity then
			inst.components.sanity:SetMax(sanity)
		end
		
		if damage then
			inst.components.combat.damagemultiplier = damage
		end
		
		if insulation then
			inst.components.temperature.inherentinsulation = insulation
		end
		
		if walkSpeed and runSpeed then
			inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED * walkSpeed
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED * runSpeed
		end
		
		if dapperness then
			inst.components.sanity.dapperness = dapperness
		end
		
		if nightDrain then
			inst.components.sanity.night_drain_mult = nightDrain
		end
		
		if monsterDrain then
			inst.components.sanity.neg_aura_mult = monsterDrain
		end
		
		if strongStomach then
			inst.components.eater.strongstomach = strongStomach
		end
		
		if hungerRate then
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * hungerRate)
		end
		
	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)

	inst.components.hunger:DoDelta(0)
	inst.components.health:DoDelta(0)
	inst.components.sanity:DoDelta(0)
	
end