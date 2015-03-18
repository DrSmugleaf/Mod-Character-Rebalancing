ACTIONS.GIVETOPLAYER._fn = ACTIONS.GIVETOPLAYER.fn
ACTIONS.GIVETOPLAYER.fn = function(act)
	if act.target.components.inventoryitem:IsCharacterSpecific(act.doer) then
            return ACTION.GIVETOPLAYER._fn
        end

    return false, "CHARACTERSPECIFIC"
end