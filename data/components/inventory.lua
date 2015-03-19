local function InventoryPostInit(inst)

	inst._CanTakeItemInSlot = inst.CanTakeItemInSlot

	function inst:CanTakeItemInSlot(item, slot)
		if ThePlayer ~= nil then
			if item.components.characterspecific and not item.components.characterspecific:CanPickUp(ThePlayer) then
    			local owner = item.components.inventoryitem.owner or ThePlayer or self.inst
    			if owner ~= nil then
    				owner.components.inventory:DropItem(item)
    				owner.components.talker:Say(item.components.characterspecific:GetComment())
    			end
    			return false
    		end

		elseif item.components.inventoryitem.owner ~= nil then
			if item.components.characterspecific and not item.components.characterspecific:CanPickUp(item.components.inventoryitem.owner) then
    			local owner = item.components.inventoryitem.owner or ThePlayer or self.inst
    			if owner ~= nil then
    				owner.components.inventory:DropItem(item)
    				owner.components.talker:Say(item.components.characterspecific:GetComment())
    			end
    			return false
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