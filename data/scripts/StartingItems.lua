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