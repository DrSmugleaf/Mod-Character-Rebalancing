local KeyHandler = Class(function(self, inst)
	self.inst = inst
	self.handler = TheInput:AddKeyHandler(function(key, down) self:OnRawKey(key, down) end )
end)

function KeyHandler:OnRawKey(key, down)
	local player = ThePlayer
  	if (key and not down) and not IsPaused() then
      	player:PushEvent("keypressed", {inst = self.inst, player = player, key = key})
    elseif key and down and not IsPaused() then
      	player:PushEvent("keydown", {inst = self.inst, player = player, key = key})
  	end
end

function KeyHandler:AddActionListener(Namespace, Key, Action)
	self.inst:ListenForEvent("keypressed", function(inst, data)
		if data.inst == ThePlayer then
			if data.key == Key then
				if TheWorld.ismastersim then
					ThePlayer:PushEvent("keyaction", { Namespace = Namespace, Action = Action, Fn = MOD_RPC_HANDLERS[Namespace][MOD_RPC[Namespace][Action].id] })
				else
					SendModRPCToServer( MOD_RPC[Namespace][Action] )
				end
			end
		end
	end)
end

return KeyHandler