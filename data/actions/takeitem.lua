--[[
-- The following is to prevent this file from being run more than once.
--
-- This is necessary to allow it to be loaded both from modmain.lua and
-- modworldgenmain.lua without the former load overriding the latter.
--]]
local _IDENTIFIER = "CS_ACTION.TAKEITEM"

if _G.rawget(_G, _IDENTIFIER) then
	return
end

ACTIONS.TAKEITEM._fn = ACTIONS.TAKEITEM.fn
ACTIONS.TAKEITEM.fn = function(act)
	local targ = act.invobject

	if targ.components.characterspecific and not targ.components.characterspecific:CanPickUp(act.doer) then
        return false, "CHARACTERSPECIFIC"
    end

    return ACTIONS.TAKEITEM._fn(act)
end

_G[_IDENTIFIER] = true