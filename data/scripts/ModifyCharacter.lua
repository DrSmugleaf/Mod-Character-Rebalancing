local ModifyCharacter = {}

-----------------------------------------
-- Function to add modes to characters --
-----------------------------------------
function ModifyCharacter:addMode(inst, Key, Action)

	local function OnKeyPressed(inst, data)
		if data.inst == ThePlayer then
			if data.key == Key then
				if TheWorld.ismastersim then
					--BufferedAction(inst, inst, ACTIONS[Action]):Do()
					inst:PushEvent("MCRAction")
				else
					--SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS[Action].code, inst, ACTIONS[Action].mod_name)
					SendModRPCToServer( MOD_RPC.MCR[Action] )
				end
			end
		end
	end

	inst:AddComponent("keyhandler")
	inst:ListenForEvent("keypressed", OnKeyPressed)

end

return ModifyCharacter