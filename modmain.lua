-- This library function allows us to use a file in a specified location.
modimport("libs/use.lua")

-- Allows use to call global environment variables without initializing them in our files.
use "libs/mod_env"(env)

-- These lines of code prevent keystrokes from happening during critical moments.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
-- End prevention of keystrokes.

-- Scripts Initialization.
use "data/scripts/init"

-- Character Initialization.
use "data/characters/init"

local MOD_NAME = "Mod Character Rebalancing"
local MOD_PREFIX = "MCR"
local MOD_ID = "385300215"
local MOD_VERSION = "2.1.1"




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
		
	
		
	
		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-366048578") then
-- 		if devonBalanced == 1 then
-- 			AddPrefabPostInit("devon", balanceDevonStats)
-- 			LogHelper.printInfo("Balancing Devon")
-- 		else
-- 			LogHelper.printInfo("Ignoring Devon")
-- 		end
-- 	end]]
		
	
	
	
		
	
-- 	--[[if KnownModIndex:IsModEnabled("workshop-374341561") then
-- 		if fionnaBalanced == 1 then
-- 			AddPrefabPostInit("fionna", balanceFionnaStats)
-- 			LogHelper.printInfo("Balancing Fionna")
-- 		else
-- 			LogHelper.printInfo("Ignoring Fionna")
-- 		end
-- 	end]]
		
	
		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-381660473") then
-- 		if gabenBalanced == 1 then
-- 			AddPrefabPostInit("gbe", balanceGabenStats)
-- 			LogHelper.printInfo("Releasing HL3")
-- 		else
-- 			LogHelper.printInfo("Delaying HL3")
-- 		end
-- 	end]]		
	
-- 	--[[if KnownModIndex:IsModEnabled("workshop-363819976") then
-- 		if girBalanced == 1 then
-- 			AddPrefabPostInit("gir", balanceGirStats)
-- 			LogHelper.printInfo("Balancing Gir")
-- 		else
-- 			LogHelper.printInfo("Ignoring Gir")
-- 		end
-- 	end]]
	
	
	
-- 	--[[if KnownModIndex:IsModEnabled("workshop-369898161") then
-- 		if hellaMerdurialBalanced == 1 then	
-- 			AddPrefabPostInit("hella", balanceHellaMerdurialStats)
-- 			LogHelper.printInfo("Balancing Hella")
-- 		else
-- 			LogHelper.printInfo("Ignoring Hella")
-- 		end
-- 	end]]
		
		
		
	
	
	
		
	
	
	
		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-351877222") then
-- 		if neptuniaBalanced == 1 then
-- 			AddPrefabPostInit("nep", balanceNeptuniaStats)
-- 			LogHelper.printInfo("Balancing Neptunia")
-- 		else
-- 			LogHelper.printInfo("Ignoring Neptunia")
-- 		end
-- 	end]]			
	

		

		

		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-368541793") then
-- 		if thanaBalanced == 1 then	
-- 			AddPrefabPostInit("thana", balanceThanaStats)
-- 			LogHelper.printInfo("Balancing Thana")
-- 		else
-- 			LogHelper.printInfo("Ignoring Thana")
-- 		end
-- 	end]]
		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-379628839") then
-- 		if theMedicBalanced == 1 then
-- 			AddPrefabPostInit("medic", balanceTheMedicStats)
-- 			LogHelper.printInfo("Balancing The Medic")
-- 		else
-- 			LogHelper.printInfo("Ignoring The Medic")
-- 		end
-- 	end]]			
		

		

		

		
-- 	--[[if KnownModIndex:IsModEnabled("workshop-357209437") then
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
