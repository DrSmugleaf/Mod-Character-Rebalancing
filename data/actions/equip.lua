--[[
-- The following is to prevent this file from being run more than once.
--
-- This is necessary to allow it to be loaded both from modmain.lua and
-- modworldgenmain.lua without the former load overriding the latter.
--]]
local _IDENTIFIER = "CS_ACTION.EQUIP"

if _G.rawget(_G, _IDENTIFIER) then
	return
end


ACTIONS.EQUIP._fn = ACTIONS.EQUIP.fn
ACTIONS.EQUIP.fn = function(act)
    if act.invobject.components.characterspecific and not act.invobject.components.characterspecific:CanPickUp(act.doer) then
       return false, "CHARACTERSPECIFIC"
    end
    
    return ACTIONS.EQUIP._fn(act)
end

_G[_IDENTIFIER] = true