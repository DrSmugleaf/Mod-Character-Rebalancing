local function InventoryItemPostInit(inst)
	if not TheWorld.ismastersim then
		return inst
	end

	inst.characterspecific_tags = {}

	function inst:AddCharacterSpecificTag(tag)
		table.insert(self.characterspecific_tags, tag)
	end

	function inst:IsCharacterSpecific(new_owner)
		for _, tag in pairs(self.characterspecific_tags) do
            if new_owner:HasTag(tag) then
                return true
            end
        end

        return false
    end

	return inst
end

AddComponentPostInit("inventoryitem", InventoryItemPostInit)