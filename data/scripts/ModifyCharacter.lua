local ModifyCharacter = {}

-----------------------------------------
-- Function to add modes to characters --
-----------------------------------------
function ModifyCharacter:addMode(inst, Key, Namespace, Action)

	local function OnKeyPressed(inst, data)
		if data.inst == ThePlayer then
			if data.key == Key then
				if TheWorld.ismastersim then
					--BufferedAction(inst, inst, ACTIONS[Action]):Do()
					ThePlayer:PushEvent("Action", { Namespace = Namespace, Action = Action })
				else
					--SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS[Action].code, inst, ACTIONS[Action].mod_name)
					--local Namespace = MOD_RPC[Namespace]

					SendModRPCToServer( MOD_RPC[Namespace][Action] )
				end
			end
		end
	end

	inst:AddComponent("keyhandler")

	inst:ListenForEvent("keypressed", OnKeyPressed)

end

return ModifyCharacter