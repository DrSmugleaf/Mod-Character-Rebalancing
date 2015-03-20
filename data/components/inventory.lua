--[[
-- The following is to prevent this file from being run more than once.
--
-- This is necessary to allow it to be loaded both from modmain.lua and
-- modworldgenmain.lua without the former load overriding the latter.
--]]
local _IDENTIFIER = "CS_INVENTORY"

if _G.rawget(_G, _IDENTIFIER) then
    return
end

local function InventoryPostInit(inst)

	inst._CanTakeItemInSlot = inst.CanTakeItemInSlot

	function inst:CanTakeItemInSlot(item, slot)
		if ThePlayer ~= nil then
			if item.components.characterspecific and not item.components.characterspecific:CanPickUp(ThePlayer) then
    			local owner = item.components.inventoryitem.owner or ThePlayer or self.inst
    			if owner ~= nil then
    				owner.components.inventory:DropItem(item)
    				owner.components.talker:Say(item.components.characterspecific:GetComment())
                    return false
    			end
    		end

		elseif item.components.inventoryitem.owner ~= nil then
			if item.components.characterspecific and not item.components.characterspecific:CanPickUp(item.components.inventoryitem.owner) then
    			local owner = item.components.inventoryitem.owner or ThePlayer or self.inst
    			if owner ~= nil then
    			     owner.components.inventory:DropItem(item)
    			     owner.components.talker:Say(item.components.characterspecific:GetComment())
    			     return false
                end
    		end
		end

    	return inst:_CanTakeItemInSlot(item, slot)
	end

	inst._GiveItem = inst.GiveItem

	function inst:GiveItem( inst, slot, src_pos )
		if not self:CanTakeItemInSlot(inst, slot) then
    		return false
    	end

		return self:_GiveItem(inst , slot, src_pos)
	end

	return inst
end

AddComponentPostInit("inventory", InventoryPostInit)
AddComponentPostInit("inventory_relica", InventoryPostInit)

_G[_IDENTIFIER] = true