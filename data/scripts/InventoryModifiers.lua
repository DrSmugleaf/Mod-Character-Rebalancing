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
-- AddComponentPostInit("inventory", function(self)
-- 	local old_Equip = self.Equip -- Store old function
-- 	function self:Equip(item, ...)
-- 		-- Checks if item is character specific, and if the player isn't the owner, make it say so
-- 		if item.components.characterspecific and item.components.characterspecific.character ~= self.inst.prefab then
-- 			self.inst.components.talker:Say("This isn't mine")
-- 			self:DropItem(item)
-- 			return false -- Prevents item from being obtained
-- 		end
-- 		return old_Equip(self, item, ...) -- Normal function execution
-- 	end
-- end)
--[[Add the characterspecific component to the items:
inst:AddComponent("characterspecific")
inst.components.characterspecific:SetOwner(inst.prefab)
]]

return InventoryModifiers
