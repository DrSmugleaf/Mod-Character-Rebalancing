local ModifyCharacter = {}

-----------------------------------------
-- Function to add modes to characters --
-----------------------------------------
function ModifyCharacter:addMode(inst, Key, Action)

	local function OnKeyPressed(inst, data)
		if data.inst == ThePlayer then
			if data.key == Key then
				if TheWorld.ismastersim then
					BufferedAction(inst, inst, ACTIONS[Action]):Do()
				else
					SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS[Action].code, inst, ACTIONS[Action].mod_name)
				end
			end
		end
	end
	inst:AddComponent("CRkeyhandler")
	inst:ListenForEvent("CRkeypressed", OnKeyPressed)

end

return ModifyCharacter