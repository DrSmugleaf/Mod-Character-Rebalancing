return Class(function(self, inst)
	self.inst = inst

	if self.inst.components.keyhandler ~= nil then
		return nil
	end

	self.handler = TheInput:AddKeyHandler(function(key, down) self:OnRawKey(key, down) end )

	function self:OnRawKey(key, down)
		local player = ThePlayer
	  	if (key and not down) and not IsPaused() then
	      	player:PushEvent("keypressed", {inst = self.inst, player = player, key = key})
	    elseif key and down and not IsPaused() then
	      	player:PushEvent("keydown", {inst = self.inst, player = player, key = key})
	  	end
	end

	function self:AddActionListener(Key, Namespace, Action)
		
	end

	local function OnKeyPressed(inst, data)
		if data.inst == ThePlayer then
			if data.key == Key then
				if TheWorld.ismastersim then
					inst:PushEvent("keyaction", { Namespace = Namespace, Action = Action })
				else
					SendModRPCToServer( MOD_RPC[Namespace][Action] )
				end
			end
		end
	end

end)