local CRKeyHandler = Class(function(self, inst)
	self.inst = inst
	self.handler = TheInput:AddKeyHandler(function(key, down) self:OnRawKey(key, down) end )

end)

function CRKeyHandler:OnRawKey(key, down)
	local player = ThePlayer
  	if (key and not down) and not IsPaused() then
      	player:PushEvent("CRkeypressed", {inst = self.inst, player = player, key = key})
    elseif key and down and not IsPaused() then
      	player:PushEvent("CRkeydown", {inst = self.inst, player = player, key = key})
  	end
end

return CRKeyHandler