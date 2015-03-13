local InventoryModifiers = {}

-------------------------------------------
-- Make characters unable to equip items --
-------------------------------------------
function InventoryModifiers:makeUnequippable(inst, head, body)

	local old_Equip = inst.components.inventory.Equip
	
	if head == true and body == false then
		inst.components.inventory.Equip = function(self, item, ...)
			if item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
				self.inst.components.talker:Say("I can't equip this")
				self:DropItem(item)
				return false
			end
			return old_Equip(self, item, ...)
		end

	elseif head == false and body == true then
		inst.components.inventory.Equip = function(self, item, ...)
			if item.components.equippable.equipslot == EQUIPSLOTS.BODY then
				self.inst.components.talker:Say("I can't equip this")
				self:DropItem(item)
				return false
			end
			return old_Equip(self, item, ...)
		end

	elseif head == true and body == true then
		inst.components.inventory.Equip = function(self, item, ...)
			if item.components.equippable.equipslot == EQUIPSLOTS.HEAD or item.components.equippable.equipslot == EQUIPSLOTS.BODY then
				self.inst.components.talker:Say("I can't equip this")
				self:DropItem(item)
				return false
			end
			return old_Equip(self, item, ...)
		end

	end

end

return InventoryModifiers
