-- This library function allows us to use a file in a specified location.
modimport("libs/use.lua")

-- Allows use to call global environment variables without initializing them in our files.
use "libs/mod_env"(env)

-- These lines of code prevent keystrokes from happening during critical moments.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
-- End prevention of keystrokes.

LogHelper = use "data/scripts/LogHelper"
ChangeStartingInventory = use "data/scripts/ChangeStartingInventory"
InventoryModifiers = use "data/scripts/InventoryModifiers"
ModifyCharacter = use "data/scripts/ModifyCharacter"
ModifyStats = use "data/scripts/ModifyStats"
ModBalancingEnabled = use "data/scripts/ModBalancingEnabled"

-- Import character changes.
use "data/characters/init"

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

	
	
	--local devonBalanced = GetModConfigData("DEVON_BALANCED")
	
	

	
	
	
	--local fionnaBalanced = GetModConfigData("FIONNA_BALANCED")
	
	--local gabenBalanced = GetModConfigData("GABEN_BALANCED")
	--local girBalanced = GetModConfigData("GIR_BALANCED")
	
	--local hellaMerdurialBalanced = GetModConfigData("HELLAMERDURIAL_BALANCED")
	
	
	

	
	
	--local neptuniaBalanced = GetModConfigData("NEPTUNIA_BALANCED")
	
	
	
	--local thanaBalanced = GetModConfigData("THANA_BALANCED")
	--local theMedicBalanced = GetModConfigData("THEMEDIC_BALANCED")
	


	--local zimBalanced = GetModConfigData("ZIM_BALANCED")
	
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






--local function balanceDevonStats(inst)
--end

















--local function balanceFionnaStats(inst)
--end





--local function balanceGabenStats(inst)
--end


--local function balanceGirStats(inst)
--end





--local function balanceHellaMerdurialStats(inst)
--end
















--local function balanceNeptuniaStats(inst)
--end










--local function balanceThanaStats(inst)
--end


--local function balanceTheMedicStats(inst)
--end




--[[
local function balanceZimStats(inst)

end
]]

-- if modBalancingEnabled == 1 then -- TODO: Replace with a function
	
-- 	LogHelper.printInfo("Mod Balancing enabled")
		
	
		
	
		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-366048578") then
-- 		if devonBalanced == 1 then
-- 			AddPrefabPostInit("devon", balanceDevonStats)
-- 			LogHelper.printInfo("Balancing Devon")
-- 		else
-- 			LogHelper.printInfo("Ignoring Devon")
-- 		end
-- 	end]]
		
	
	
	
		
	
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-374341561") then
-- 		if fionnaBalanced == 1 then
-- 			AddPrefabPostInit("fionna", balanceFionnaStats)
-- 			LogHelper.printInfo("Balancing Fionna")
-- 		else
-- 			LogHelper.printInfo("Ignoring Fionna")
-- 		end
-- 	end]]
		
	
		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-381660473") then
-- 		if gabenBalanced == 1 then
-- 			AddPrefabPostInit("gbe", balanceGabenStats)
-- 			LogHelper.printInfo("Releasing HL3")
-- 		else
-- 			LogHelper.printInfo("Delaying HL3")
-- 		end
-- 	end]]		
	
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-363819976") then
-- 		if girBalanced == 1 then
-- 			AddPrefabPostInit("gir", balanceGirStats)
-- 			LogHelper.printInfo("Balancing Gir")
-- 		else
-- 			LogHelper.printInfo("Ignoring Gir")
-- 		end
-- 	end]]
	
	
	
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-369898161") then
-- 		if hellaMerdurialBalanced == 1 then	
-- 			AddPrefabPostInit("hella", balanceHellaMerdurialStats)
-- 			LogHelper.printInfo("Balancing Hella")
-- 		else
-- 			LogHelper.printInfo("Ignoring Hella")
-- 		end
-- 	end]]
		
		
		
	
	
	
		
	
	
	
		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-351877222") then
-- 		if neptuniaBalanced == 1 then
-- 			AddPrefabPostInit("nep", balanceNeptuniaStats)
-- 			LogHelper.printInfo("Balancing Neptunia")
-- 		else
-- 			LogHelper.printInfo("Ignoring Neptunia")
-- 		end
-- 	end]]			
	

		

		

		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-368541793") then
-- 		if thanaBalanced == 1 then	
-- 			AddPrefabPostInit("thana", balanceThanaStats)
-- 			LogHelper.printInfo("Balancing Thana")
-- 		else
-- 			LogHelper.printInfo("Ignoring Thana")
-- 		end
-- 	end]]
		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-379628839") then
-- 		if theMedicBalanced == 1 then
-- 			AddPrefabPostInit("medic", balanceTheMedicStats)
-- 			LogHelper.printInfo("Balancing The Medic")
-- 		else
-- 			LogHelper.printInfo("Ignoring The Medic")
-- 		end
-- 	end]]			
		

		

		

		
-- 	--[[if GLOBAL.KnownModIndex:IsModEnabled("workshop-357209437") then
-- 		if zimBalanced == 1 then	
-- 			AddPrefabPostInit("izim", balanceZimStats)
-- 			LogHelper.printInfo("Balancing Zim")
-- 		else
-- 			LogHelper.printInfo("Ignoring Zim")
-- 		end
-- 	end]]
	
-- 	else
	
-- 	LogHelper.printInfo("Mod Balancing disabled")
	
-- end
