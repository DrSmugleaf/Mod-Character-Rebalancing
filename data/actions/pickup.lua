ACTIONS.PICKUP._fn = ACTIONS.PICKUP.fn
ACTIONS.PICKUP.fn = function(act)
    if act.doer.components.inventory ~= nil and
        act.target ~= nil and
        act.target.components.inventoryitem ~= nil and
        not act.target:IsInLimbo() and
        not act.target:HasTag("catchable") then

        if act.target.components.inventoryitem:IsCharacterSpecific(act.doer) then
            return ACTION.PICKUP._fn
        end

        return false, "CHARACTERSPECIFIC"
    end
end