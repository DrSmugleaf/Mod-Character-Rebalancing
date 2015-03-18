ACTIONS.GIVEALLTOPLAYER._fn = ACTIONS.GIVEALLTOPLAYER.fn
ACTIONS.GIVEALLTOPLAYER.fn = function(act)
	if act.target.components.inventoryitem:IsCharacterSpecific(act.doer) then
            return ACTION.GIVEALLTOPLAYER._fn
        end

    return false, "CHARACTERSPECIFIC"
end