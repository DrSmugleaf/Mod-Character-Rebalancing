local ChangeStartingInventory = {}

--------------------------------------------------
-- Delete and add items to a player's inventory --
--------------------------------------------------
local startingItems = {}

function ChangeStartingInventory:modifyInventory(inst, start_inv)

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
			--inst.components.inventory:GiveItem(GLOBAL.SpawnPrefab(v)) -- Give new items
			inst.components.inventory:GiveItem(SpawnPrefab(v))
		end
		inst.components.inventory.ignoresound = false
	end
	end
end

return ChangeStartingInventory
