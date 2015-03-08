local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local MOD_NAME = "Mod Character Rebalancing"

--------------------------------
-- Load Starting Items config --
--------------------------------
local enableStartingItems = GetModConfigData("ENABLE_STARTING_ITEMS")
	local amountOfFlint = GetModConfigData("AMOUNT_OF_FLINT")
	local amountOfGrass = GetModConfigData("AMOUNT_OF_GRASS")
	local amountOfLogs = GetModConfigData("AMOUNT_OF_LOGS")
	local amountOfMeat = GetModConfigData("AMOUNT_OF_MEAT")
	local amountOfTwigs = GetModConfigData("AMOUNT_OF_TWIGS")
	local giveThermalStone = GetModConfigData("GIVE_THERMAL_STONE")
	
	local startingItems = {}
	
	
-------------------------------------
-- Load Character Balancing config --
-------------------------------------
local modBalancingEnabled = GetModConfigData("MOD_BALANCING_ENABLED")
	local crashBandicootBalanced = GetModConfigData("CRASHBANDICOOT_BALANCED")
	local darkSakuraBalanced = GetModConfigData("DARKSAKURA_BALANCED")
	--local devonBalanced = GetModConfigData("DEVON_BALANCED")
	local drokBalanced = GetModConfigData("DROK_BALANCED")
	local endiaBalanced = GetModConfigData("ENDIA_BALANCED")
	local farozBalanced = GetModConfigData("FAROZ_BALANCED")
	--local fionnaBalanced = GetModConfigData("FIONNA_BALANCED")
	local freeSpiritBalanced = GetModConfigData("FREESPIRIT_BALANCED")
	--local gabenBalanced = GetModConfigData("GABEN_BALANCED")
	--local girBalanced = GetModConfigData("GIR_BALANCED")
	local haruzBalanced = GetModConfigData("HARUZ_BALANCED")
	--local hellaMerdurialBalanced = GetModConfigData("HELLAMERDURIAL_BALANCED")
	local luffyBalanced = GetModConfigData("LUFFY_BALANCED")
	local madeleineBalanced = GetModConfigData("MADELEINE_BALANCED")
	local michaelTheFoxBalanced = GetModConfigData("MICHAELTHEFOX_BALANCED")
	local mikuHatsuneBalanced = GetModConfigData("MIKUHATSUNE_BALANCED")
	local mitsuruBalanced = GetModConfigData("MITSURU_BALANCED")
	--local neptuniaBalanced = GetModConfigData("NEPTUNIA_BALANCED")
	local serasBalanced = GetModConfigData("SERAS_BALANCED")
	local sollyzBalanced = GetModConfigData("SOLLYZ_BALANCED")
	local shovelKnightBalanced = GetModConfigData("SHOVELKNIGHT_BALANCED")
	local tamamoBalanced = GetModConfigData("TAMAMO_BALANCED")
	--local thanaBalanced = GetModConfigData("THANA_BALANCED")
	--local theMedicBalanced = GetModConfigData("THEMEDIC_BALANCED")
	local warkBalanced = GetModConfigData("WARK_BALANCED")
	local wolfBalanced = GetModConfigData("WOLF_BALANCED")
	local woodieBalanced = GetModConfigData("WOODIE_BALANCED")
	--local zimBalanced = GetModConfigData("ZIM_BALANCED")
	
	
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
	
end
	
	
-------------------------------
-- Load Special Modes config --
-------------------------------
local nerfSpeed = GetModConfigData("NERF_SPEED")
local hardcoreMode = GetModConfigData("HARDCORE_MODE")


--------------------------------------------------------------
-- Printing to console functions with mod name and prefixes --
--------------------------------------------------------------
local function printDebug(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[DEBUG] ".. (message))
	end
	
end
local function printError(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[ERROR] ".. (message))
	end
	
end
local function printFatal(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[FATAL] ".. (message))
	end
	
end
local function printInfo(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[INFO] ".. (message))
	end
	
end
local function printWarn(message)

	if message then
	print("[".. (MOD_NAME).. "] ".. "[WARN] ".. (message))
	end
	
end


----------------------------------------------------
-- Check config settings and add items to a table --
----------------------------------------------------
if enableStartingItems == 1 then -- If starting items is enabled
	
	printInfo("Starting Items enabled")
	
	for _= 1, amountOfFlint do -- For the amount of flint specified in the config
		table.insert(startingItems, "flint") -- Insert it into the table "startingItems"
	end
	for _= 1, amountOfGrass do
		table.insert(startingItems, "cutgrass")
	end
	for _= 1, amountOfLogs do
		table.insert(startingItems, "log")
	end
	for _= 1, amountOfMeat do
		table.insert(startingItems, "meat")
	end
	for _= 1, amountOfTwigs do
		table.insert(startingItems, "twigs")
	end
	
	if giveThermalStone == 1 then
		table.insert(startingItems, "heatrock")
	end
	
else
	
	printInfo("Starting Items disabled")
	
end


--------------------------------------------------
-- Put starting items in the player's inventory --
--------------------------------------------------
AddPlayerPostInit(function(inst) -- Add to every player

    if inst.OnNewSpawn then -- Store old function
        inst.old_OnNewSpawn = inst.OnNewSpawn
    end
     
    inst.OnNewSpawn = function(inst) -- On spawn, do the following function
	
        if inst.components.inventory ~= nil then
		
            inst.components.inventory.ignoresound = true
            for i, v in ipairs(startingItems) do -- For each value inserted above into the table
                inst.components.inventory:GiveItem(GLOBAL.SpawnPrefab(v)) -- Give that amount of items to the player
            end
            inst.components.inventory.ignoresound = false
			
        end
		
        if inst.old_OnNewSpawn then
		
            return inst:old_OnNewSpawn(inst)
			
        end
    end
end)


--------------------------------------------------
-- Delete and add items to a player's inventory --
--------------------------------------------------
local function changeStartingInventory(inst, start_inv)

	local oldSpawn = inst.OnNewSpawn
	start_inv = start_inv or {}
	for _,v in pairs(startingItems) do -- Load starting items too since this deletes inventories
		table.insert(start_inv, v)
	end
	inst.OnNewSpawn = function()
	
	if oldSpawn ~= nil then oldSpawn() end
	
	if inst.components.inventory ~= nil then
		inst.components.inventory.ignoresound = true
		for i = 1, inst.components.inventory:GetNumSlots() do
			inst.components.inventory:RemoveItemBySlot(i) -- Remove all items
		end
		for _, v in ipairs(start_inv) do
			inst.components.inventory:GiveItem(GLOBAL.SpawnPrefab(v)) -- Give new items
		end
		inst.components.inventory.ignoresound = false
	end
	end
end


--local function modifyPrefab(inst, stats)

--end


-----------------------------------------------------------------------
-- Add a leveling system to a character or plainly modify it's stats --
-----------------------------------------------------------------------
local function modifyStats(inst, stats)

	-- Load the given stats
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
  
  

	if hardcoreMode == 0 then levelNerf = stats.levelNerf
	elseif hardcoreMode == 1 then levelNerf = stats.hardcoreMode end

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
	
	if levelSetting > 0 and initialHealth or initialHunger or initialSanity or initialDamage or initialInsulation or initialWalk or initialRun then
		
		if not levelNerf then
			levelNerf = 0
		end
		
		maxUpgrades = levelDifficulty+levelNerf
		
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
		
end


local function CRAddMode(inst, CRKey, CRAction)
  local function OnKeyPressed(inst, data)
		if data.inst == GLOBAL.ThePlayer then
			if data.key == CRKey then --Welcome to GLOBAL ville
				if GLOBAL.TheWorld.ismastersim then
					GLOBAL.BufferedAction(inst, inst, GLOBAL.ACTIONS[CRAction]):Do()
				else
					GLOBAL.SendRPCToServer(GLOBAL.RPC.DoWidgetButtonAction, GLOBAL.ACTIONS[CRAction].code, inst, GLOBAL.ACTIONS[CRAction].mod_name)
				end
			end
		end
	end
	inst:AddComponent("CRkeyhandler")
	inst:ListenForEvent("CRkeypressed", OnKeyPressed)
end


--------------------------------------------------------------------------------
-- Component to make certain items undroppable when given the tag undroppable --
--------------------------------------------------------------------------------
AddComponentPostInit("inventory", function(self) -- Add the function to the component inventory
	local DropItem_base = self.DropItem
	function self:DropItem(item, ...)
		if item:HasTag("undroppable") then -- Check for the tag
			return false -- Can't be dropped
		else
			return DropItem_base(self, item, ...)
		end
	end
end)


------------------------------------------------
-- Component to make items character specific --
------------------------------------------------
AddComponentPostInit("inventory", function(self)
	local old_Equip = self.Equip -- Store old function
	function self:Equip(item, ...)
		-- Checks if item is character specific, and if the player isn't the owner, make it say so
		if item.components.characterspecific and item.components.characterspecific.character ~= self.inst.prefab then
			self.inst.components.talker:Say("This isn't mine")
			self:DropItem(item)
			return false -- Prevents item from being obtained
		end
		return old_Equip(self, item, ...) -- Normal function execution
	end
end)
--[[Add the characterspecific component to the items:
inst:AddComponent("characterspecific")
inst.components.characterspecific:SetOwner(inst.prefab)
]]


-----------------------------------------------------
-- Make functions to change each character's stats --
-----------------------------------------------------
local function balanceCrashBandicootStats(inst)

	local crashBandicootStats = {
									levelNerf = 50,
									levelNerfHardcore = 250,
									
									foodPrefab1 = "wumpa",
									foodPrefab2 = "wumpa_cooked",
									foodPrefab3 = "carrot",
									levelPerFood1 = 2,
									levelPerFood2 = 2,
									levelPerFood3 = 1,
									
									initialHealth = 75,
									initialHunger = 75,
									initialSanity = 100,
									initialWalkNerf = 1,
									initialRunNerf = 1,
									
									finalHealth = 100,
									finalHunger = 125,
									finalSanity = 150,
									finalRunNerf = 1,
									finalWalkNerf = 1,
								}
	
	modifyStats(inst, crashBandicootStats)
	
end


local function balanceDarkSakuraStats(inst)

	local darkSakuraStats =	{
								health = 75,
								hunger = 100,
							}

	modifyStats(inst, darkSakuraStats)

end


--local function balanceDevonStats(inst)
--end


local function balanceDrokStats(inst)

	local drokStats =	{
							health = 175,
							hunger = 200,
							damage = 1.5,
						}
	
	modifyStats(inst, drokStats)
	
end


local function balanceEndiaStats(inst)

	local endiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 75,
						}
						
	modifyStats(inst, endiaStats)
	
end


local function balanceFarozStats(inst)

	local farozStats =	{
							dapperness = -0.25,
							nightDrain = 1.25,
							monsterDrain = 1.25,
						}
						
	modifyStats(inst, farozStats)
	
end

local function balanceFarozGlasses(inst)

	inst:AddTag("undroppable")
	
	inst:AddComponent("characterspecific")
	inst.components.characterspecific:SetOwner("faroz")
	
end


--local function balanceFionnaStats(inst)
--end


local function balanceFreeSpiritStats(inst)

	local freeSpiritStats =	{
								health = 150,
								hunger = 100,
								sanity = 150,
							}
	
	modifyStats(inst, freeSpiritStats)
	
end


--local function balanceGabenStats(inst)
--end


--local function balanceGirStats(inst)
--end


local function balanceHaruzStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-1

if levelSetting > 0 then

	local oldPreLoad = inst.OnPreLoad
	local oldEat = inst.components.eater.oneatfn
	
	local levelNerf = 25
	
	local initialHealth = 75
	local initialHunger = 75
	local initialSanity = 75
	
	local finalHealth = 150
	local finalHunger = 200
	local finalSanity = 125
	
	inst.components.health:SetMaxHealth(initialHealth)
	inst.components.hunger:SetMax(initialHunger)
	inst.components.sanity:SetMax(initialSanity)
			
			
	local function newUpg(inst)

		max_upgrades = levelDifficulty+levelNerf
		
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (initialHealth + upgrades * (finalHealth - initialHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (initialHunger + upgrades * (finalHunger - initialHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (initialSanity + upgrades * (finalSanity - initialSanity) / max_upgrades)
		
		inst.components.talker:Say("Level : ".. (inst.level))
		if inst.level > math.ceil (max_upgrades-1) then
			inst.components.talker:Say("Level : Max!")
		end
	
		inst.components.hunger:SetPercent(hunger_percent)
		inst.components.health:SetPercent(health_percent)
		inst.components.sanity:SetPercent(sanity_percent)
	end
	
	local function newEat(inst, food)
		oldEat(inst, food)
	if food and food.components.edible and food.components.edible.foodtype=="MEAT" then
		newUpg(inst)
	end
end
	
	local function newPreLoad(inst, data)
		oldPreLoad(inst, data)
		newUpg(inst)
		inst.components.health:DoDelta(0)
		inst.components.hunger:DoDelta(0)
		inst.components.sanity:DoDelta(0)
	end
	
	inst.components.eater:SetOnEatFn(newEat)
	inst.OnPreLoad = newPreLoad
end
end


--local function balanceHellaMerdurialStats(inst)
--end


local function balanceLuffyStats(inst)

	local luffyStats =	{
							health = 100,
							sanity = 100,
							hungerRate = 2.0,
						}
						
	modifyStats(inst, luffyStats)

end


local function balanceMadeleineStats(inst)

	changeStartingInventory(inst, {"goldnugget", "redgem", "redgem", "bluegem", "bluegem", "purplegem"})

end


local function balanceMichaelTheFoxStats(inst)

	local michaelTheFoxStats =	{
									health = 75,
									hunger = 125,
									sanity = 75,
									damage = 0.75,
									nightDrain = 1.25,
									monsterDrain = 1.25,
									dapperness = TUNING.DAPPERNESS_TINY*-1,
									
									healthNerf = 100,
									hungerNerf = 150,
									sanityNerf = 100,
									damageNerf = 0.85,
									nightDrainNerf = 1.10,
									monsterDrainNerf = 1.10,
									dappernessNerf = TUNING.DAPPERNESS_TINY*0.5,
									walkSpeedNerf = 1.25,
									runSpeedNerf = 1.25,
								}

	modifyStats(inst, michaelTheFoxStats)
	inst:AddTag("insomniac")

end


local function balanceMikuHatsuneStats(inst)

	local mikuHatsuneStats =	{
									health = 100,
									hunger = 100,
									sanity = 100,
									damage = 0.75,
								}
								
	modifyStats(inst, mikuHatsuneStats)

end


local function balanceMitsuruStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-1

if levelSetting > 0 then

	local oldPreLoad = inst.OnPreLoad
	local oldEat = inst.components.eater.oneatfn
	
	local levelNerf = 50
	
	local initialHealth = 75
	local initialHunger = 75
	local initialSanity = 50
	local initialDamage = 1.0
	local initialInsulation = 0
	
	local finalHealth = 100
	local finalHunger = 150
	local finalSanity = 125
	local finalDamage = 1.5
	local finalInsulation = 75
	
	inst.components.health:SetMaxHealth(initialHealth)
	inst.components.hunger:SetMax(initialHunger)
	inst.components.sanity:SetMax(initialSanity)
	
	local function newUpg(inst)
	
		max_upgrades = levelDifficulty+levelNerf
			
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (initialHealth + upgrades * (finalHealth - initialHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (initialHunger + upgrades * (finalHunger - initialHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (initialSanity + upgrades * (finalSanity - initialSanity) / max_upgrades)
		
		inst.components.combat.damagemultiplier = math.ceil (initialDamage + upgrades * (finalDamage - initialDamage) / max_upgrades)
		inst.components.temperature.inherentinsulation = math.ceil (initialInsulation + upgrades * (finalInsulation - initialInsulation) / max_upgrades)

		inst.components.talker:Say("Level : ".. (inst.level))
		
		if inst.level > math.ceil (max_upgrades-1) then
			inst.components.talker:Say("Level : Max!")
		end
	
		inst.components.hunger:SetPercent(hunger_percent)
		inst.components.health:SetPercent(health_percent)
		inst.components.sanity:SetPercent(sanity_percent)
	end
	
	local function newEat(inst, food)
		oldEat(inst, food)
	if food and food.components.edible and food.prefab == "corn" or food.prefab == "carrot" or food.prefab == "eggplant" or food.prefab == "dragonfruit" then
			newUpg(inst)
		end
	end
	
	local function newPreLoad(inst, data)
		oldPreLoad(inst, data)
		newUpg(inst)
		inst.components.health:DoDelta(0)
		inst.components.hunger:DoDelta(0)
		inst.components.sanity:DoDelta(0)
	end
	
	inst.components.eater:SetOnEatFn(newEat)
	inst.OnPreLoad = newPreLoad
end
end


--local function balanceNeptuniaStats(inst)
--end


local function balanceSerasStats(inst)

	changeStartingInventory(inst, {"smallmeat", "smallmeat"})
	
end


local function balanceShovelKnightStats(inst)

end

local function balanceShovelKnightBlades(inst)
	
    inst:AddTag("undroppable")
	
	inst:AddComponent("characterspecific")
	inst.components.characterspecific:SetOwner("winston")
	
end


local function balanceSollyzStats(inst)

if levelSetting > 0 then

	local oldPreLoad = inst.OnPreLoad
	local oldEat = inst.components.eater.oneatfn
	
	local levelNerf = 0
	
	local initialHealth = 50
	local initialHunger = 75
	local initialSanity = 50
	
	local finalHealth = 100
	local finalHunger = 150
	local finalSanity = 90
	
	inst.components.health:SetMaxHealth(initialHealth)
	inst.components.hunger:SetMax(initialHunger)
	inst.components.sanity:SetMax(initialSanity)
	
	local function newUpg(inst)

		max_upgrades = levelDifficulty+levelNerf
		
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (initialHealth + upgrades * (finalHealth - initialHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (initialHunger + upgrades * (finalHunger - initialHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (initialSanity + upgrades * (finalSanity - initialSanity) / max_upgrades)
		
		inst.components.talker:Say("Level : ".. (inst.level))
		if inst.level > math.ceil (max_upgrades-1) then
			inst.components.talker:Say("Level : Max!")
		end
	
		inst.components.hunger:SetPercent(hunger_percent)
		inst.components.health:SetPercent(health_percent)
		inst.components.sanity:SetPercent(sanity_percent)
	end
	
	local function newEat(inst, food)
		oldEat(inst, food)
	if food and food.components.edible and food.prefab == "fish"  then
			newUpg(inst)
		end
	end
	
	local function newPreLoad(inst, data)
		oldPreLoad(inst, data)
		newUpg(inst)
		inst.components.health:DoDelta(0)
		inst.components.hunger:DoDelta(0)
		inst.components.sanity:DoDelta(0)
	end
	
	inst.components.eater:SetOnEatFn(newEat)
	inst.OnPreLoad = newPreLoad
end
end

	local FERAL = GLOBAL.Action()
	FERAL.str = "Feral"
	FERAL.id = "FERAL"
	FERAL.fn = function(act)
		local silent = true
		--act.target.AnimState:SetBuild("tamamo_ball")
		act.target.Light:Enable(true) --inst. -> not assigned act.target is.
		if act.target.transformed then
			--act.target.AnimState:SetBuild("tamamo")
			act.target.Light:Enable(false)
		else
			--act.target.AnimState:SetBuild("tamamo_ball")
			act.target.Light:Enable(true)
		end
		act.target.transformed = not act.target.transformed
		-- act.target.components.health:SetCurrentHealth(1)
		-- act.target.components.health:DoDelta(0)
		return true
	end
AddAction(FERAL)

local function balanceTamamoStats(inst)

	local light = inst.entity:AddLight()
	inst.Light:Enable(false)
	inst.Light:SetRadius(15)
	inst.Light:SetFalloff(0.75)
	inst.Light:SetIntensity(.6)
	inst.Light:SetColour(70/255,255/255,12/255)
	
	
	
	
	local tamamoStats =	{
							health = 50
						}
						
	modifyStats(inst, tamamoStats)
	
	CRAddMode(inst, GLOBAL.KEY_T, "FERAL")
	
end



--local function balanceThanaStats(inst)
--end


--local function balanceTheMedicStats(inst)
--end


local function balanceWarkStats(inst)

	local warkStats =	{
							health = 125,
							hunger = 150,
							damage = 0.8,
							
							healthNerf = 150,
							hungerNerf = 150,
							damageNerf = 1,
							walkSpeedNerf = 1,
							runSpeedNerf = 1,
						}
	
	modifyStats(inst, warkStats)
	
end


local function balanceWolfStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-0.75
	
end


local function balanceWoodieStats(inst)

	local woodieStats = {

							levelNerf =  0,

							foodPrefab1 =  "butterflymuffin",
							levelPerFood1 = 1,
								
							initialHealth = 75,
							initialHunger = 100,
							initialSanity = 100,

							finalHealth = 175,
							finalHunger = 200,
							finalSanity = 175,
						}

	modifyStats(inst, woodieStats)
	
end

local function balanceWoodieAxe(inst)
	
    inst:AddTag("undroppable")
	
	inst:AddComponent("characterspecific")
	inst.components.characterspecific:SetOwner("woodie")
	
end


--[[local function balanceZimStats(inst)
end]]


--if not GLOBAL.TheNet:GetIsClient() then
---------------------------------------------------------------------------------
-- Add the previously set functions to each character or character item prefab --
---------------------------------------------------------------------------------
if modBalancingEnabled == 1 then -- TODO: Replace with a function
	
	printInfo("Mod Balancing enabled")
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-382501575") then
		if crashBandicootBalanced == 1 then
			AddPrefabPostInit("crashbandi", balanceCrashBandicootStats)
			printInfo("Balancing Crash Bandicoot")
		else
			printInfo("Ignoring Crash Bandicoot")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384048428") then
		if devonBalanced == 1 then
			AddPrefabPostInit("devon", balanceDarkSakuraStats)
			printInfo("Balancing Dark Sakura Matou")
		else
			printInfo("Ignoring Dark Sakura Matou")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-366048578") then
		if devonBalanced == 1 then
			AddPrefabPostInit("devon", balanceDevonStats)
			printInfo("Balancing Devon")
		else
			printInfo("Ignoring Devon")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-373622746") then
		if drokBalanced == 1 then
			AddPrefabPostInit("drok", balanceDrokStats)
			printInfo("Balancing Drok the Caveman")
		else
			printInfo("Ignoring Drok the Caveman")
		end
	end
	
		if GLOBAL.KnownModIndex:IsModEnabled("workshop-363966651") then
			if endiaBalanced == 1 then
				AddPrefabPostInit("endia", balanceEndiaStats)
				printInfo("Balancing Endia")
				--printInfoToConsole(info, "Balancing Endia")
			end
		end

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-364491382") then
		if farozBalanced == 1 then
			AddPrefabPostInit("faroz", balanceFarozStats)
			AddPrefabPostInit("faroz_gls", balanceFarozGlasses)
			printInfo("Balancing Faroz")
		else
			printInfo("Ignoring Faroz")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-374341561") then
		if fionnaBalanced == 1 then
			AddPrefabPostInit("fionna", balanceFionnaStats)
			printInfo("Balancing Fionna")
		else
			printInfo("Ignoring Fionna")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359318959") then
		if freeSpiritBalanced == 1 then
			AddPrefabPostInit("freebre", balanceFreeSpiritStats)
			printInfo("Balancing FreeSpirit the Umbreon")
		else
			printInfo("Ignoring FreeSpirit the Umbreon")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-381660473") then
		if gabenBalanced == 1 then
			AddPrefabPostInit("gbe", balanceGabenStats)
			printInfo("Releasing HL3")
		else
			printInfo("Delaying HL3")
		end
	end]]		
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-363819976") then
		if girBalanced == 1 then
			AddPrefabPostInit("gir", balanceGirStats)
			printInfo("Balancing Gir")
		else
			printInfo("Ignoring Gir")
		end
	end]]
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359821133") then
		if haruzBalanced == 1 then	
			AddPrefabPostInit("haruz", balanceHaruzStats)
			printInfo("Balancing Haruz")
		else
			printInfo("Ignoring Haruz")
		end
	end
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-369898161") then
		if hellaMerdurialBalanced == 1 then	
			AddPrefabPostInit("hella", balanceHellaMerdurialStats)
			printInfo("Balancing Hella")
		else
			printInfo("Ignoring Hella")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-380079744") then
		if luffyBalanced == 1 then
			AddPrefabPostInit("luffy", balanceLuffyStats)
			printInfo("Balancing Luffy")
		else
			printInfo("Ignoring Luffy")
		end
	end		
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369228986") then
		if madeleineBalanced == 1 then	
			AddPrefabPostInit("madeleine", balanceMadeleineStats)
			printInfo("Balancing Madeleine")
		else
			printInfo("Ignoring Madeleine")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-357013795") then
		if michaelTheFoxBalanced == 1 then	
			AddPrefabPostInit("fox", balanceMichaelTheFoxStats)
			printInfo("Balancing Michael the Fox")
		else
			printInfo("Ignoring Michael the Fox")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-368321978") then
		if mikuHatsuneBalanced == 1 then
			AddPrefabPostInit("miku", balanceMikuHatsuneStats)
			printInfo("Balancing Miku Hatsune")
		else
			printInfo("Ignoring Miku Hatsune")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-364189966") then
		if mitsuruBalanced == 1 then	
			AddPrefabPostInit("mitsuru", balanceMitsuruStats)
			printInfo("Balancing Mitsuru")
		else
			printInfo("Ignoring Mitsuru")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-351877222") then
		if neptuniaBalanced == 1 then
			AddPrefabPostInit("nep", balanceNeptuniaStats)
			printInfo("Balancing Neptunia")
		else
			printInfo("Ignoring Neptunia")
		end
	end]]			
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-360319890") then
		if serasBalanced == 1 then	
			AddPrefabPostInit("seras", balanceSerasStats)
			printInfo("Balancing Seras")
		else
			printInfo("Ignoring Seras")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359479220") then
		if sollyzBalanced == 1 then	
			AddPrefabPostInit("sollyz", balanceSollyzStats)
			printInfo("Balancing Sollyz")
		else
			printInfo("Ignoring Sollyz")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369544255") then
		if shovelKnightBalanced == 1 then
			AddPrefabPostInit("winston", balanceShovelKnightStats)
			AddPrefabPostInit("skweaponshovelbladebasic", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladechargehandle", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladetrenchblade", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladedropspark", balanceShovelKnightBlades)
			printInfo("Balancing Shovel Knight")
		else
			printInfo("Ignoring Shovel Knight")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-399799824") then
		if tamamoBalanced == 1 then	
			AddPrefabPostInit("tamamo", balanceTamamoStats)
			printInfo("Balancing Tamamo")
		else
			printInfo("Ignoring Tamamo")
		end
	end
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-368541793") then
		if thanaBalanced == 1 then	
			AddPrefabPostInit("thana", balanceThanaStats)
			printInfo("Balancing Thana")
		else
			printInfo("Ignoring Thana")
		end
	end]]
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-379628839") then
		if theMedicBalanced == 1 then
			AddPrefabPostInit("medic", balanceTheMedicStats)
			printInfo("Balancing The Medic")
		else
			printInfo("Ignoring The Medic")
		end
	end]]			
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369518979") then
		if warkBalanced == 1 then	
			AddPrefabPostInit("wark", balanceWarkStats)
			printInfo("Balancing Wark")
		else
			printInfo("Ignoring Wark")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369435452") then
		if wolfBalanced == 1 then	
			AddPrefabPostInit("wolft", balanceWolfStats)
			printInfo("Balancing Wolf")
		else
			printInfo("Ignoring Wolf")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384633033") then
		if woodieBalanced == 1 then	
			AddPrefabPostInit("woodie", balanceWoodieStats)
			AddPrefabPostInit("lucy", balanceWoodieAxe)
			printInfo("Balancing PrzemoLSZ's Woodie")
		else
			printInfo("Ignoring PrszemoLSZ's Woodie")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-357209437") then
		if zimBalanced == 1 then	
			AddPrefabPostInit("izim", balanceZimStats)
			printInfo("Balancing Zim")
		else
			printInfo("Ignoring Zim")
		end
	end]]
	
	else
	
	printInfo("Mod Balancing disabled")
	
end
