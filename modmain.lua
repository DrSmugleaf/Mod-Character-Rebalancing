local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local enableStartingItems = GetModConfigData("ENABLE_STARTING_ITEMS") -- Load starting items config
	local amountOfFlint = GetModConfigData("AMOUNT_OF_FLINT")
	local amountOfGrass = GetModConfigData("AMOUNT_OF_GRASS")
	local amountOfLogs = GetModConfigData("AMOUNT_OF_LOGS")
	local amountOfMeat = GetModConfigData("AMOUNT_OF_MEAT")
	local amountOfTwigs = GetModConfigData("AMOUNT_OF_TWIGS")
	local giveThermalStone = GetModConfigData("GIVE_THERMAL_STONE")
	
	local startingItems = {}
	
local modBalancingEnabled = GetModConfigData("MOD_BALANCING_ENABLED") -- Load mod balancing config
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
	--local thanaBalanced = GetModConfigData("THANA_BALANCED")
	--local theMedicBalanced = GetModConfigData("THEMEDIC_BALANCED")
	local warkBalanced = GetModConfigData("WARK_BALANCED")
	local wolfBalanced = GetModConfigData("WOLF_BALANCED")
	local woodieBalanced = GetModConfigData("WOODIE_BALANCED")
	--local zimBalanced = GetModConfigData("ZIM_BALANCED")
local levelSetting = GetModConfigData("LEVEL_SETTING")
	if levelSetting == 0 then
	elseif levelSetting == 1 then
		levelDifficulty = 30
	elseif levelSetting == 2 then
		levelDifficulty = 50
	elseif levelSetting == 3 then
		levelDifficulty = 75
	elseif levelSetting == 4 then
		levelDifficulty = 100
	end
local nerfSpeed = GetModConfigData("NERF_SPEED")
local hardcoreMode = GetModConfigData("HARDCORE_MODE")

local function printDebug(message)

	print("[Mod Character Rebalancing] [DEBUG]".. (message))
	
end

local function printError(message)

	print("[Mod Character Rebalancing] [ERROR]".. (message))
	
end

local function printFatal(message)

	print("[Mod Character Rebalancing] [FATAL]".. (message))
	
end

local function printInfo(message)

	print("[Mod Character Balancing] [INFO] ".. (message))
	
end

local function printWarn(message)

	print("[Mod Character Rebalancing] [WARN]".. (message))
	
end


if enableStartingItems == 1 then -- Starting Items' config loading
	
	printInfo("Starting Items enabled")
	
	for _= 1, amountOfFlint do
		table.insert(startingItems, "flint")
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


AddPlayerPostInit(function(inst) -- Starting Items' item spawning
    if inst.OnNewSpawn then
        inst.old_OnNewSpawn = inst.OnNewSpawn
    end
     
    inst.OnNewSpawn = function(inst)
        if inst.components.inventory ~= nil then
            inst.components.inventory.ignoresound = true
            for i, v in ipairs(startingItems) do
                inst.components.inventory:GiveItem(GLOBAL.SpawnPrefab(v))
            end
            inst.components.inventory.ignoresound = false
        end
        if inst.old_OnNewSpawn then
            return inst:old_OnNewSpawn(inst)
        end
    end
end)


local function changeStartingInventory(inst, start_inv) -- Change a character's inventory
	local oldSpawn = inst.OnNewSpawn
	start_inv = start_inv or {}
	for _,v in pairs(startingItems) do -- Load starting items since this deletes inventories
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


local function modifyPrefab(inst, stats)

end

local function modifyStats(inst, stats)

--[[Parameters to use:

local levelNerf = 


	local foodType = 
OR
	local foodPrefab1 = 
	local foodPrefab2 = 
	local foodPrefab3 = 
	local foodPrefab4 = 
	local foodPrefab5 = 
		local levelPerFood1 = 
		local levelPerFood2 = 
		local levelPerFood3 = 
		local levelPerFood4 = 
		local levelPerFood5 = 
OR
	local function newEat(inst, food)
		oldEat(inst, food)
	if food and food.components.edible and food.components.edible.foodtype=="MEAT" then
		newUpg(inst)
	end
	end

local InitialMaxHealth = 
local InitialMaxHunger = 
local InitialMaxSanity = 
local InitialMaxDamage = 
local InitialMaxInsulation = 

local FinalMaxHealth = 
local FinalMaxHunger = 
local FinalMaxSanity = 
local FinalMaxDamage = 
local FinalMaxInsulation = 
]]


--[[local changeHealth = stats.changeHealth
local changeHunger = stats.changeHunger
local changeSanity = stats.changeSanity
local changeDamage = stats.changeDamage
local changeInsulation = stats.changeInsulation]]

local health = stats.health
local hunger = stats.hunger
local sanity = stats.sanity
local damage = stats.damage
local insulation = stats.insulation
local walkSpeed = stats.walkSpeed
local runSpeed = stats.runSpeed
local dapperness = stats.dapperness
local nightDrain = stats.nightDrain
local monsterDrain = stats.monsterDrain
local strongStomach = stats.strongStomach
local hungerRate = stats.hungerRate

local levelNerf = stats.levelNerf

local foodtypeLeveling = stats.foodtypeLeveling
	local foodType = stats.foodType

local foodprefabLeveling = stats.foodprefabLeveling
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

local InitialMaxHealth = stats.InitialMaxHealth
local InitialMaxHunger = stats.InitialMaxHunger
local InitialMaxSanity = stats.InitialMaxSanity
local InitialMaxDamage = stats.InitialMaxDamage
local InitialMaxInsulation = stats.InitialMaxInsulation

local FinalMaxHealth = stats.FinalMaxHealth
local FinalMaxHunger = stats.FinalMaxHunger
local FinalMaxSanity = stats.FinalMaxSanity
local FinalMaxDamage = stats.FinalMaxDamage
local FinalMaxInsulation = stats.FinalMaxInsulation

if levelSetting > 0 and InitialMaxHealth or InitialMaxHunger or InitialMaxSanity or InitialMaxDamage or InitialMaxInsulation then
	
	if not levelNerf then
		levelNerf = 0
	end
	
	maxUpgrades = levelDifficulty+levelNerf
	
	function applyUpgrades(inst)

		local upgrades = math.min(inst.level, maxUpgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		
		
		if InitialMaxHealth and FinalMaxHealth and upgrades and maxUpgrades then
		inst.components.health.maxhealth = math.ceil (InitialMaxHealth + upgrades * (FinalMaxHealth - InitialMaxHealth) / maxUpgrades)		
		end
		
		if InitialMaxHunger and FinalMaxHunger and upgrades and maxUpgrades then
		inst.components.hunger.max = math.ceil (InitialMaxHunger + upgrades * (FinalMaxHunger - InitialMaxHunger) / maxUpgrades)
		end
		
		if InitialMaxSanity and FinalMaxSanity and upgrades and maxUpgrades then
		inst.components.sanity.max = math.ceil (InitialMaxSanity + upgrades * (FinalMaxSanity - InitialMaxSanity) / maxUpgrades)
		end
		
		if InitialMaxDamage and FinalMaxDamage and upgrades and maxUpgrades then
		inst.components.combat.damagemultiplier = math.ceil (InitialMaxDamage + upgrades * (FinalMaxDamage - InitialMaxDamage) / maxUpgrades)
		end
		
		if InitialMaxInsulation and FinalMaxInsulation and upgrades and maxUpgrades then
		inst.components.temperature.inherentinsulation = math.ceil (InitialMaxInsulation + upgrades * (FinalMaxInsulation - InitialMaxInsulation) / maxUpgrades)
		end
		
		
		inst.components.talker:Say("Level : ".. (inst.level))
		
		if inst.level > math.ceil (maxUpgrades-1) then
			inst.components.talker:Say("Level : Max!")
		end
	
		inst.components.hunger:SetPercent(hunger_percent)
		inst.components.health:SetPercent(health_percent)
		inst.components.sanity:SetPercent(sanity_percent)
	end
	
	--[[
	if foodType then
		local function oneat(inst, food)
			if food and food.components.edible and food.components.edible.foodtype=="foodType" then
				inst.level = inst.level + 1
				applyUpgrades(inst)
				inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
			end
		end
	end]]
	
	--local oneat
	--if foodPrefab1 and levelPerFood1 then
		function oneat(inst, food)
			if foodPrefab1 and levelPerFood1 then
				if food and food.components.edible and food.prefab == foodPrefab1 then --or food.prefab == foodPrefab2.prefab or food.prefab == foodPrefab3.prefab or food.prefab == foodPrefab4.prefab or food.prefab == foodPrefab5.prefab then
					inst.level = inst.level + levelPerFood1
					applyUpgrades(inst)
					inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
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
	--end

	
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
	
else

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
		inst.components.locomotor.walkspeed = walkSpeed
		inst.components.locomotor.runspeed = runSpeed
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
end

AddComponentPostInit("inventory", function(self)
	local DropItem_base = self.DropItem
	function self:DropItem(item, ...)
		if item:HasTag("undroppable") then
			return false
		else
			return DropItem_base(self, item, ...)
		end
	end
end)

AddComponentPostInit("inventory", function(self)
	local old_Equip = self.Equip -- store old function
	function self:Equip(item, ...)
		-- checks if item is character specific, and if the player isn't the owner, make it say so.
		if item.components.characterspecific and item.components.characterspecific.character ~= self.inst.prefab then
			self.inst.components.talker:Say("This isn't mine")
			self:DropItem(item)
			return false -- prevents item from being got
		end
		return old_Equip(self, item, ...) -- normal function execution
	end
end)
--[[Add the characterspecific component to the items:
inst:AddComponent("characterspecific")
inst.components.characterspecific:SetOwner(inst.prefab)

]]

local function balanceCrashBandicootStats(inst)

	local crashBandicootStats = {
									levelNerf =  50,

									foodprefabLeveling = true,
									foodPrefab1 = "wumpa",
									foodPrefab2 = "wumpa_cooked",
									foodPrefab3 = "carrot",
									levelPerFood1 = 2,
									levelPerFood2 = 2,
									levelPerFood3 = 1,
									
									InitialMaxHealth = 75,
									InitialMaxHunger = 75,
									InitialMaxSanity = 100,

									FinalMaxHealth = 100,
									FinalMaxHunger = 125,
									FinalMaxSanity = 150,
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
	
	local InitialMaxHealth = 75
	local InitialMaxHunger = 75
	local InitialMaxSanity = 75
	
	local FinalMaxHealth = 150
	local FinalMaxHunger = 200
	local FinalMaxSanity = 125
	
	inst.components.health:SetMaxHealth(InitialMaxHealth)
	inst.components.hunger:SetMax(InitialMaxHunger)
	inst.components.sanity:SetMax(InitialMaxSanity)
			
			
	local function newUpg(inst)

		max_upgrades = levelDifficulty+levelNerf
		
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (InitialMaxHealth + upgrades * (FinalMaxHealth - InitialMaxHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (InitialMaxHunger + upgrades * (FinalMaxHunger - InitialMaxHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (InitialMaxSanity + upgrades * (FinalMaxSanity - InitialMaxSanity) / max_upgrades)
		
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
	
	local InitialMaxHealth = 75
	local InitialMaxHunger = 75
	local InitialMaxSanity = 50
	local InitialMaxDamage = 1.0
	local InitialMaxInsulation = 0
	
	local FinalMaxHealth = 100
	local FinalMaxHunger = 150
	local FinalMaxSanity = 125
	local FinalMaxDamage = 1.5
	local FinalMaxInsulation = 75
	
	inst.components.health:SetMaxHealth(InitialMaxHealth)
	inst.components.hunger:SetMax(InitialMaxHunger)
	inst.components.sanity:SetMax(InitialMaxSanity)
	
	local function newUpg(inst)
	
		max_upgrades = levelDifficulty+levelNerf
			
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (InitialMaxHealth + upgrades * (FinalMaxHealth - InitialMaxHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (InitialMaxHunger + upgrades * (FinalMaxHunger - InitialMaxHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (InitialMaxSanity + upgrades * (FinalMaxSanity - InitialMaxSanity) / max_upgrades)
		
		inst.components.combat.damagemultiplier = math.ceil (InitialMaxDamage + upgrades * (FinalMaxDamage - InitialMaxDamage) / max_upgrades)
		inst.components.temperature.inherentinsulation = math.ceil (InitialMaxInsulation + upgrades * (FinalMaxInsulation - InitialMaxInsulation) / max_upgrades)

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
	
	local InitialMaxHealth = 50
	local InitialMaxHunger = 75
	local InitialMaxSanity = 50
	
	local FinalMaxHealth = 100
	local FinalMaxHunger = 150
	local FinalMaxSanity = 90
	
	inst.components.health:SetMaxHealth(InitialMaxHealth)
	inst.components.hunger:SetMax(InitialMaxHunger)
	inst.components.sanity:SetMax(InitialMaxSanity)
	
	local function newUpg(inst)

		max_upgrades = levelDifficulty+levelNerf
		
		local upgrades = math.min(inst.level, max_upgrades)
 
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()
		

		inst.components.health.maxhealth = math.ceil (InitialMaxHealth + upgrades * (FinalMaxHealth - InitialMaxHealth) / max_upgrades)		
		inst.components.hunger.max = math.ceil (InitialMaxHunger + upgrades * (FinalMaxHunger - InitialMaxHunger) / max_upgrades)
		inst.components.sanity.max = math.ceil (InitialMaxSanity + upgrades * (FinalMaxSanity - InitialMaxSanity) / max_upgrades)
		
		inst.components.locomotor.walkspeed =  math.ceil (4 - upgrades / 7)
		inst.components.locomotor.runspeed = math.ceil (6 - upgrades / 6)
		
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


--local function balanceThanaStats(inst)
--end


--local function balanceTheMedicStats(inst)
--end


local function balanceWarkStats(inst)

	local warkStats =	{
							health = 125,
							hunger = 150,
							damage = 0.8,
						}
	
	modifyStats(inst, warkStats)
	
end


local function balanceWolfStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-0.75
	
end


local function balanceWoodieStats(inst)

	local woodieStats = {

							levelNerf =  0,

							foodprefabLeveling = true,
							foodPrefab1 =  "butterflymuffin",
							levelPerFood1 = 1,
								
							InitialMaxHealth = 75,
							InitialMaxHunger = 100,
							InitialMaxSanity = 100,

							FinalMaxHealth = 175,
							FinalMaxHunger = 200,
							FinalMaxSanity = 175,
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

-- Replace with a function
if modBalancingEnabled == 1 then
	
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
	