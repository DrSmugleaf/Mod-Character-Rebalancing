-- This library function allows us to use a file in a specified location.
modimport("libs/use.lua")

-- Allows use to call global environment variables without initializing them in our files.
env = use "libs/mod_env"

LogHelper = use "data/scripts/LogHelper"
ChangeStartingInventory = use "data/scripts/ChangeStartingInventory"
InventoryModifiers = use "data/scripts/InventoryModifiers"
ModifyCharacter = use "data/scripts/ModifyCharacter"
ModifyStats = use "data/scripts/ModifyStats"
ModBalancingEnabled = use "data/scripts/ModBalancingEnabled"

-- These lines of code prevent keystrokes from happening during critical moments.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
-- End prevention of keystrokes.

modBalancingEnabled = ModBalancingEnabled()
modifyStats = ModifyStats

-- Import tamamo changes.
use "data/tamamo/tamamo"

local MOD_NAME = "Mod Character Rebalancing"
local MOD_PREFIX = "MCR"
local MOD_ID = "385300215"
local MOD_VERSION = "2.1.1"

local enableStartingItems = GetModConfigData("ENABLE_STARTING_ITEMS")
	local amountOfFlint = GetModConfigData("AMOUNT_OF_FLINT")
	local amountOfGrass = GetModConfigData("AMOUNT_OF_GRASS")
	local amountOfLogs = GetModConfigData("AMOUNT_OF_LOGS")
	local amountOfMeat = GetModConfigData("AMOUNT_OF_MEAT")
	local amountOfTwigs = GetModConfigData("AMOUNT_OF_TWIGS")
	local giveThermalStone = GetModConfigData("GIVE_THERMAL_STONE")

local startingItems = {}

----------------------------------------------------
-- Check config settings and add items to a table --
----------------------------------------------------
if enableStartingItems == 1 then -- If starting items is enabled
	
	LogHelper.printInfo("Starting Items enabled")
	
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
	
	LogHelper.printInfo("Starting Items disabled")
	
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


-------------------------------------
-- Load Character Balancing config --
-------------------------------------

	local crashBandicootBalanced = GetModConfigData("CRASHBANDICOOT_BALANCED")
	local darkSakuraBalanced = GetModConfigData("DARKSAKURA_BALANCED")
	--local devonBalanced = GetModConfigData("DEVON_BALANCED")
	local drokBalanced = GetModConfigData("DROK_BALANCED")
	local endiaBalanced = GetModConfigData("ENDIA_BALANCED")
	local eskoBalanced = GetModConfigData("ESKO_BALANCED")
	local farozBalanced = GetModConfigData("FAROZ_BALANCED")
	local filiaBalanced = GetModConfigData("FILIA_BALANCED")
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


--local function modifyPrefab(inst, stats)

--end

--------------------------------------------------------------------------------
-- Component to make certain items undroppable when given the tag undroppable --
--------------------------------------------------------------------------------
AddComponentPostInit("inventory", function(self) -- Add the function to the component inventory
	local DropItem_base = self.DropItem
	function self:DropItem(item, ...)
		if item and item:HasTag("undroppable") then -- Check for the tag
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
									levelBase = 50,
									
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


local function balanceEskoStats(inst)
	
	local eskoStats =	{
							levelBase = 25,
							foodPrefab1 = "fish",
							levelPerFood1 = 1,
							
							initialHealth = 75,
							initialHunger = 100,
							initialSanity = 75,
							initialDamage = 0.7,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealth = 125,
							finalHunger = 150,
							finalSanity = 100,
							finalDamage = 1,
							finalWalk = 1.5,
							finalRun = 1.5,
							
							hungerRate = 2,
							
							
							initialHealthNerf = 100,
							initialHungerNerf = 100,
							initialSanityNerf = 100,
							initialDamageNerf = 0.7,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealthNerf = 150,
							finalHungerNerf = 150,
							finalSanityNerf = 125,
							finalDamageNerf = 0.9,
							finalWalkNerf = 1.25,
							finalRunNerf = 1.25,
							
							hungerRateNerf = 1.75,
						}
	
	modifyStats(inst, eskoStats)
	
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


local function balanceFiliaStats(inst)
	
	local filiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 150,
							damage = 1.5,
							walkSpeed = 1.5,
							runSpeed = 1.5,
						}
						
	modifyStats(inst, filiaStats)
	
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
	
	local levelBase = 25
	
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

		max_upgrades = levelDifficulty+levelBase
		
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

	ChangeStartingInventory:modifyInventory(inst, {"goldnugget", "redgem", "redgem", "bluegem", "bluegem", "purplegem"})

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
	
	local levelBase = 50
	
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
	
		max_upgrades = levelDifficulty+levelBase
			
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

	ChangeStartingInventory:modifyInventory(inst, {"smallmeat", "smallmeat"})
	
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
	
	local levelBase = 0
	
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

		max_upgrades = levelDifficulty+levelBase
		
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
							damageNerf = 0.8,
							walkSpeedNerf = 1.25,
							runSpeedNerf = 1.25,
						}
	
	modifyStats(inst, warkStats)
	
end


local function balanceWolfStats(inst)

	inst.components.sanity.dapperness = TUNING.DAPPERNESS_TINY*-0.75
	
end


local function balanceWoodieStats(inst)

	local woodieStats = {

							levelBase =  0,

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


--[[
local function balanceZimStats(inst)

end
]]


---------------------------------------------------------------------------------
-- Add the previously set functions to each character or character item prefab --
---------------------------------------------------------------------------------
if modBalancingEnabled == 1 then -- TODO: Replace with a function
	
	LogHelper.printInfo("Mod Balancing enabled")
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-382501575") then
		if crashBandicootBalanced == 1 then
			AddPrefabPostInit("crashbandi", balanceCrashBandicootStats)
			LogHelper.printInfo("Balancing Crash Bandicoot")
		else
			LogHelper.printInfo("Ignoring Crash Bandicoot")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384048428") then
		if darkSakuraBalanced == 1 then
			AddPrefabPostInit("sakura", balanceDarkSakuraStats)
			LogHelper.printInfo("Balancing Dark Sakura Matou")
		else
			LogHelper.printInfo("Ignoring Dark Sakura Matou")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-366048578") then
		if devonBalanced == 1 then
			AddPrefabPostInit("devon", balanceDevonStats)
			LogHelper.printInfo("Balancing Devon")
		else
			LogHelper.printInfo("Ignoring Devon")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-373622746") then
		if drokBalanced == 1 then
			AddPrefabPostInit("drok", balanceDrokStats)
			LogHelper.printInfo("Balancing Drok the Caveman")
		else
			LogHelper.printInfo("Ignoring Drok the Caveman")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-363966651") then
		if endiaBalanced == 1 then
			AddPrefabPostInit("endia", balanceEndiaStats)
			LogHelper.printInfo("Balancing Endia")
		else
			LogHelper.printInfo("Ignoring Endia")
		end
	end

	if GLOBAL.KnownModIndex:IsModEnabled("workshop-356880841") then
		if eskoBalanced == 1 then
			AddPrefabPostInit("esk", balanceEskoStats)
			LogHelper.printInfo("Balancing Esko")
		else
			LogHelper.printInfo("Ignoring Esko")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-364491382") then
		if farozBalanced == 1 then
			AddPrefabPostInit("faroz", balanceFarozStats)
			AddPrefabPostInit("faroz_gls", balanceFarozGlasses)
			LogHelper.printInfo("Balancing Faroz")
		else
			LogHelper.printInfo("Ignoring Faroz")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-398833909") then
		if filiaBalanced == 1 then
			AddPrefabPostInit("filia", balanceFiliaStats)
			LogHelper.printInfo("Balancing Filia")
		else
			LogHelper.printInfo("Ignoring Filia")
		end
	end
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-374341561") then
		if fionnaBalanced == 1 then
			AddPrefabPostInit("fionna", balanceFionnaStats)
			LogHelper.printInfo("Balancing Fionna")
		else
			LogHelper.printInfo("Ignoring Fionna")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359318959") then
		if freeSpiritBalanced == 1 then
			AddPrefabPostInit("freebre", balanceFreeSpiritStats)
			LogHelper.printInfo("Balancing FreeSpirit the Umbreon")
		else
			LogHelper.printInfo("Ignoring FreeSpirit the Umbreon")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-381660473") then
		if gabenBalanced == 1 then
			AddPrefabPostInit("gbe", balanceGabenStats)
			LogHelper.printInfo("Releasing HL3")
		else
			LogHelper.printInfo("Delaying HL3")
		end
	end]]		
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-363819976") then
		if girBalanced == 1 then
			AddPrefabPostInit("gir", balanceGirStats)
			LogHelper.printInfo("Balancing Gir")
		else
			LogHelper.printInfo("Ignoring Gir")
		end
	end]]
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359821133") then
		if haruzBalanced == 1 then	
			AddPrefabPostInit("haruz", balanceHaruzStats)
			LogHelper.printInfo("Balancing Haruz")
		else
			LogHelper.printInfo("Ignoring Haruz")
		end
	end
	
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-369898161") then
		if hellaMerdurialBalanced == 1 then	
			AddPrefabPostInit("hella", balanceHellaMerdurialStats)
			LogHelper.printInfo("Balancing Hella")
		else
			LogHelper.printInfo("Ignoring Hella")
		end
	end]]
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-380079744") then
		if luffyBalanced == 1 then
			AddPrefabPostInit("luffy", balanceLuffyStats)
			LogHelper.printInfo("Balancing Luffy")
		else
			LogHelper.printInfo("Ignoring Luffy")
		end
	end		
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369228986") then
		if madeleineBalanced == 1 then	
			AddPrefabPostInit("madeleine", balanceMadeleineStats)
			LogHelper.printInfo("Balancing Madeleine")
		else
			LogHelper.printInfo("Ignoring Madeleine")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-357013795") then
		if michaelTheFoxBalanced == 1 then	
			AddPrefabPostInit("fox", balanceMichaelTheFoxStats)
			LogHelper.printInfo("Balancing Michael the Fox")
		else
			LogHelper.printInfo("Ignoring Michael the Fox")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-368321978") then
		if mikuHatsuneBalanced == 1 then
			AddPrefabPostInit("miku", balanceMikuHatsuneStats)
			LogHelper.printInfo("Balancing Miku Hatsune")
		else
			LogHelper.printInfo("Ignoring Miku Hatsune")
		end
	end
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-364189966") then
		if mitsuruBalanced == 1 then	
			AddPrefabPostInit("mitsuru", balanceMitsuruStats)
			LogHelper.printInfo("Balancing Mitsuru")
		else
			LogHelper.printInfo("Ignoring Mitsuru")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-351877222") then
		if neptuniaBalanced == 1 then
			AddPrefabPostInit("nep", balanceNeptuniaStats)
			LogHelper.printInfo("Balancing Neptunia")
		else
			LogHelper.printInfo("Ignoring Neptunia")
		end
	end]]			
	
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-360319890") then
		if serasBalanced == 1 then	
			AddPrefabPostInit("seras", balanceSerasStats)
			LogHelper.printInfo("Balancing Seras")
		else
			LogHelper.printInfo("Ignoring Seras")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-359479220") then
		if sollyzBalanced == 1 then	
			AddPrefabPostInit("sollyz", balanceSollyzStats)
			LogHelper.printInfo("Balancing Sollyz")
		else
			LogHelper.printInfo("Ignoring Sollyz")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369544255") then
		if shovelKnightBalanced == 1 then
			AddPrefabPostInit("winston", balanceShovelKnightStats)
			AddPrefabPostInit("skweaponshovelbladebasic", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladechargehandle", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladetrenchblade", balanceShovelKnightBlades)
			AddPrefabPostInit("skweaponshovelbladedropspark", balanceShovelKnightBlades)
			LogHelper.printInfo("Balancing Shovel Knight")
		else
			LogHelper.printInfo("Ignoring Shovel Knight")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-368541793") then
		if thanaBalanced == 1 then	
			AddPrefabPostInit("thana", balanceThanaStats)
			LogHelper.printInfo("Balancing Thana")
		else
			LogHelper.printInfo("Ignoring Thana")
		end
	end]]
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-379628839") then
		if theMedicBalanced == 1 then
			AddPrefabPostInit("medic", balanceTheMedicStats)
			LogHelper.printInfo("Balancing The Medic")
		else
			LogHelper.printInfo("Ignoring The Medic")
		end
	end]]			
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369518979") then
		if warkBalanced == 1 then	
			AddPrefabPostInit("wark", balanceWarkStats)
			LogHelper.printInfo("Balancing Wark")
		else
			LogHelper.printInfo("Ignoring Wark")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-369435452") then
		if wolfBalanced == 1 then	
			AddPrefabPostInit("wolft", balanceWolfStats)
			LogHelper.printInfo("Balancing Wolf")
		else
			LogHelper.printInfo("Ignoring Wolf")
		end
	end
		
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-384633033") then
		if woodieBalanced == 1 then	
			AddPrefabPostInit("woodie", balanceWoodieStats)
			AddPrefabPostInit("lucy", balanceWoodieAxe)
			LogHelper.printInfo("Balancing PrzemoLSZ's Woodie")
		else
			LogHelper.printInfo("Ignoring PrszemoLSZ's Woodie")
		end
	end
		
	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-357209437") then
		if zimBalanced == 1 then	
			AddPrefabPostInit("izim", balanceZimStats)
			LogHelper.printInfo("Balancing Zim")
		else
			LogHelper.printInfo("Ignoring Zim")
		end
	end]]
	
	else
	
	LogHelper.printInfo("Mod Balancing disabled")
	
end
