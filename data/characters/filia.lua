local filiaBalanced = GetModConfigData("FILIA_BALANCED")


local function balanceFiliaStats(inst)
	
	local filiaStats =	{
							health = 75,
							hunger = 100,
							sanity = 75,
							damage = 1.25,
							insulation = 0,
							walkSpeed = 1.50,
							runSpeed = 1.50,
							dapperness = 0,
							nightDrain = 1.25,
							monsterDrain = 1.25,
							strongStomach = true,
							hungerRate = 1.75,


							healthNerf = 100,
							hungerNerf = 150,
							sanityNerf = 100,
							damageNerf = 1.50,
							insulationNerf = 0,
							walkSpeedNerf = 1,
							runSpeedNerf = 1,
							dappernessNerf = 0,
							nightDrainNerf = 1.25,
							monsterDrainNerf = 1.25,
							strongStomachNerf = true,
							hungerRateNerf = 1.75,


							levelBase = 25,
							
							foodPrefab1 = "monsterlasagna",
							levelPerFood1 = 1,
							
							initialHealth = 50,
							initialHunger = 75,
							initialSanity = 75,
							initialDamage = 1,
							initialInsulation = 0,
							initialWalk = 1.15,
							initialRun = 1.15,
							
							finalHealth = 100,
							finalHunger = 100,
							finalSanity = 100,
							finalDamage = 1.25,
							finalInsulation = 0,
							finalRun = 1.50,
							finalWalk = 1.50,


							initialHealthNerf = 75,
							initialHungerNerf = 100,
							initialSanityNerf = 75,
							initialDamageNerf = 1,
							initialInsulationNerf = 0,
							initialWalkNerf = 1,
							initialRunNerf = 1,

							finalHealthNerf = 100,
							finalHungerNerf = 150,
							finalSanityNerf = 100,
							finalDamageNerf = 1.50,
							finalInsulationNerf = 0,
							finalWalkNerf = 1,
							finalRunNerf = 1,
						}
						
	ModifyStats(inst, filiaStats)
	
end

local function balanceFiliaHairpin(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst.components.inventoryitem.keepondeath = true

	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")
	end

	inst.components.characterspecific:SetOwner("filia")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("This thing smells of fighting games.")
	
end


if ModBalancingEnabled() then

	if KnownModIndex:IsModEnabled("workshop-398833909") then
		if filiaBalanced then
			AddPrefabPostInit("filia", balanceFiliaStats)
			AddPrefabPostInit("hairpin", balanceFiliaHairpin)
			LogHelper.printInfo("Balancing Filia")
		else
			LogHelper.printInfo("Ignoring Filia")
		end
	end
	
end