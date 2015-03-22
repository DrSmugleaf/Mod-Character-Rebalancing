local endiaBalanced = GetModConfigData("ENDIA_BALANCED")


local function balanceEndiaStats(inst)

	local endiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 100,
							damage = 0.85,
							insulation = 0,
							walkSpeed = 1,
							runSpeed = 1,
							dapperness = TUNING.DAPPERNESS_TINY * -0.33,
							nightDrain = 1.15,
							monsterDrain = 1.15,
							strongStomach = false,
							hungerRate = 1,


							healthNerf = 75,
							hungerNerf = 100,
							sanityNerf = 100,
							damageNerf = 0.85,
							insulationNerf = 0,
							walkSpeedNerf = 1,
							runSpeedNerf = 1,
							dappernessNerf = TUNING.DAPPERNESS_TINY * -0.33,
							nightDrainNerf = 1.15,
							monsterDrainNerf = 1.15,
							strongStomachNerf = false,
							hungerRateNerf = 1,


							levelBase = 100,
							
							foodPrefab1 = "corn",
							foodPrefab2 = "pumpkin",
							foodPrefab3 = "eggplant",
							foodPrefab4 = "pomegranate",
							foodPrefab5 = "dragonfruit",
							levelPerFood1 = 1,
							levelPerFood2 = 3,
							levelPerFood3 = 3,
							levelPerFood4 = 5,
							levelPerFood5 = 5,
							
							initialHealth = 50,
							initialHunger = 75,
							initialSanity = 75,
							initialDamage = 0.75,
							initialInsulation = 0,
							initialWalk = 1,
							initialRun = 1,
							
							finalHealth = 100,
							finalHunger = 150,
							finalSanity = 100,
							finalDamage = 1,
							finalInsulation = 0,
							finalWalk = 1,
							finalRun = 1,


							initialHealthNerf = 50,
							initialHungerNerf = 75,
							initialSanityNerf = 75,
							initialDamageNerf = 0.75,
							initialInsulationNerf = 0,
							initialWalkNerf = 1,
							initialRunNerf = 1,

							finalHealthNerf = 100,
							finalHungerNerf = 150,
							finalSanityNerf = 100,
							finalDamageNerf = 1,
							finalInsulationNerf = 0,
							finalWalkNerf = 1,
							finalRunNerf = 1,
						}
						
	ModifyStats(inst, endiaStats)
	
end

local function balanceEndiaAmulet(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("endia")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("I can't understand how this artifact works.")

end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-363966651") then
		if endiaBalanced then
			AddPrefabPostInit("endia", balanceEndiaStats)
			AddPrefabPostInit("endiaamulet", balanceEndiaAmulet)
			LogHelper.printInfo("Balancing Endia")
		else
			LogHelper.printInfo("Ignoring Endia")
		end
	end

end