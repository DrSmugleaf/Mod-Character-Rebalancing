local PrintPrefix = {}

--------------------------------------------------------------
-- Printing to console functions with mod name and prefixes --
--------------------------------------------------------------
local MOD_NAME = "Mod Character Rebalancing"

function PrintPrefix.printDebug(message)

	if message then
	print("[".. (MOD_NAME).. "] ".. "[DEBUG] ".. (message))
	end
	
end

function PrintPrefix.printError(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[ERROR] ".. (message))
	end
	
end

function PrintPrefix.printFatal(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[FATAL] ".. (message))
	end
	
end

function PrintPrefix.printInfo(message)
	
	if message then
	print("[".. (MOD_NAME).. "] ".. "[INFO] ".. (message))
	end
	
end

function PrintPrefix.printWarn(message)

	if message then
	print("[".. (MOD_NAME).. "] ".. "[WARN] ".. (message))
	end
	
end

return PrintPrefix