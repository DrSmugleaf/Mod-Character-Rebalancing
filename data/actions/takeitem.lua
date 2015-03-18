ACTIONS.TAKEITEM._fn = ACTIONS.TAKEITEM.fn
ACTIONS.TAKEITEM.fn = function(act)
	if act.target.components.inventoryitem:IsCharacterSpecific(act.doer) then
            return ACTION.TAKEITEM._fn
        end

    return false, "CHARACTERSPECIFIC"
end