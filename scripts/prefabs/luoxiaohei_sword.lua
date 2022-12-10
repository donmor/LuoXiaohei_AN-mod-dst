local assets =
{
	Asset("ANIM", "anim/luoxiaohei_sword.zip"),
	Asset("ANIM", "anim/luoxiaohei_sword_swap.zip"),
	Asset( "IMAGE", "images/inventoryimages/luoxiaohei_sword.tex" ),
	Asset( "ATLAS", "images/inventoryimages/luoxiaohei_sword.xml" ),
	Asset( "SOUND", "sound/luoxiaohei.fsb" ),
	Asset( "SOUNDPACKAGE", "sound/luoxiaohei.fev" ),
}

local function OnThrown(inst, owner, target)
	if target ~= owner then
		inst.SoundEmitter:PlaySound("luoxiaohei/se/"..(inst.skilled and "throw_s_pre" or "throw_pre"), nil, TUNING.LUOXIAOHEI_SE)
	end
	inst.AnimState:PlayAnimation(inst.skilled and "spin_loop_s" or "spin_loop", true)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst:DoPeriodicTask(FRAMES * 3, function(inst)
		if inst.components.projectile:IsThrown() and inst.components.projectile.speed < TUNING.LUOXIAOHEI_EXT_SPEED then
			inst.components.projectile:SetSpeed(inst.components.projectile.speed + 1)
			inst.Physics:SetMotorVel(inst.components.projectile.speed, 0, 0)
		end
	end)
end

local function OnHit(inst, owner, target)
	if target ~= nil and target:IsValid() then
		SpawnPrefab("impact").Transform:SetPosition(target:GetPosition():Get())
	end
	inst.SoundEmitter:PlaySound("luoxiaohei/se/"..(inst.skilled and "throw_s_pst" or "throw_pst"), nil, TUNING.LUOXIAOHEI_SE)
	inst.entity:Hide()
end

local function OnMiss(inst, owner, target)
	inst.components.projectile:Stop()
	inst.entity:Hide()
end

local function onequip(inst, owner)
	if owner.prefab == "wes" or owner.prefab == "wolfgang" and owner.strength == "whimpy" then
		inst:DoTaskInTime(0.1, function()
			owner.components.inventory:DropItem(inst, true)
		end)
		return
	end
	owner.AnimState:OverrideSymbol("swap_object", "luoxiaohei_sword_swap", "luoxiaohei_sword_swap")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	if owner.prefab == "luoxiaohei" and not owner.components.sanity:IsInsane() then
		inst:RemoveTag("inuse")
		inst:AddTag("nosteal")
		inst.components.equippable.walkspeedmult = nil
		owner.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD)
		if owner.prefab ~= "wurt" then
			owner:AddTag("stronggrip")
		end
	elseif owner:HasTag("metal_manipulator") then
		inst:AddTag("inuse")
		inst:AddTag("nosteal")
		inst.components.equippable.walkspeedmult = nil
		owner.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD)
		if owner.prefab ~= "wurt" then
			owner:AddTag("stronggrip")
		end
	elseif owner.prefab == "wolfgang" and owner.strength == "mighty" then
		inst:AddTag("inuse")
		inst:RemoveTag("nosteal")
		inst.components.equippable.walkspeedmult = nil
		owner.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD * 1.11)
		if owner.prefab ~= "wurt" then
			owner:RemoveTag("stronggrip")
		end
	else
		inst:AddTag("inuse")
		inst:RemoveTag("nosteal")
		inst.components.equippable.walkspeedmult = TUNING.LUOXIAOHEI_SWORD_SPD_MULT
		owner.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD * 1.67)
		if owner.prefab ~= "wurt" then
			owner:RemoveTag("stronggrip")
		end
	end
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
	inst:AddTag("inuse")
	inst:RemoveTag("nosteal")
	inst.components.equippable.walkspeedmult = TUNING.LUOXIAOHEI_SWORD_SPD_MULT
	owner.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD)
	if owner.prefab ~= "wurt" then
		owner:RemoveTag("stronggrip")
	end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("luoxiaohei_sword")
	inst.AnimState:SetBuild("luoxiaohei_sword")
	inst.AnimState:PlayAnimation("idle")

	inst.MiniMapEntity:SetIcon("luoxiaohei_sword.tex")

	inst:AddTag("sharp")
	inst:AddTag("pointy")
    inst:AddTag("weapon")
    inst:AddTag("metal")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/luoxiaohei_sword.xml"
	inst.components.inventoryitem.imagename = "luoxiaohei_sword"
	inst.components.inventoryitem:SetSinks(true)

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.walkspeedmult = TUNING.LUOXIAOHEI_SWORD_SPD_MULT

	inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.LUOXIAOHEI_SWORD_USES)
    inst.components.finiteuses:SetUses(TUNING.LUOXIAOHEI_SWORD_USES)

    inst.components.finiteuses:SetOnFinished(inst.Remove)

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(function(inst, attacker, target)
		return TUNING.LUOXIAOHEI_SWORD_ATK *
		(0.5 + inst.components.finiteuses:GetPercent() * 0.5) *
		(attacker:HasTag("metal_manipulator") and 1 or attacker.prefab == "wolfgang" and attacker.strength == "mighty" and 1.2 or 0.8)
	end)
	inst.components.weapon:SetOnAttack(function()
		local owner = inst.components.inventoryitem:GetGrandOwner()
		if not owner then
			return
		end
		inst.SoundEmitter:PlaySound("luoxiaohei/se/"..(owner:HasTag("luoxiaohei_skill_on") and "sword_s_pre" or "sword_pre"), nil, TUNING.LUOXIAOHEI_SE)
		inst.SoundEmitter:PlaySound("luoxiaohei/se/"..(owner:HasTag("luoxiaohei_skill_on") and "sword_s_pst" or "sword_pst"), nil, TUNING.LUOXIAOHEI_SE)
	end)

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(function(inst)
		local owner = inst.components.inventoryitem:GetGrandOwner()
		if not owner or owner.prefab ~= "luoxiaohei" then
			return
		end
		if owner.luoxiaohei_skill_task == nil then
			local tpf = FRAMES / TheSim:GetTickTime()
			owner.luoxiaohei_skill_task = owner:DoPeriodicTask(FRAMES, function()
				if math.floor(GetTick() % (20 * tpf)) == 0 then
					owner.components.sanity:DoDelta(-1)
				end
				if not owner:HasTag("luoxiaohei_skill_on") then
					owner:AddTag("luoxiaohei_skill_on")
					owner.SoundEmitter:PlaySound("luoxiaohei/se/skill_on", nil, TUNING.LUOXIAOHEI_SE * 0.3)
					owner.SoundEmitter:KillSound("luoxiaohei_attack")
					owner.SoundEmitter:PlaySound("luoxiaohei/voice/attack", "luoxiaohei_attack", TUNING.LUOXIAOHEI_VOICE)
					owner.AnimState:SetHaunted(true)
				end
				if owner.components.health:IsDead() or owner.components.sanity:IsInsane() then
					owner:RemoveTag("luoxiaohei_skill_on")
					if not owner:HasTag("spawnprotection") then
						owner.AnimState:SetHaunted(false)
					end
					owner.luoxiaohei_skill_task:Cancel()
					owner.luoxiaohei_skill_task = nil
				end
			end)
		else
			owner:RemoveTag("luoxiaohei_skill_on")
			if not owner:HasTag("spawnprotection") then
				owner.AnimState:SetHaunted(false)
			end
			owner.luoxiaohei_skill_task:Cancel()
			owner.luoxiaohei_skill_task = nil
		end
		inst:DoTaskInTime(FRAMES, function()
			inst.components.useableitem:StopUsingItem()
		end)
		onequip(inst, owner)
	end)

	MakeHauntable(inst)

	return inst
end

local function dart_common(skilled)
	local inst = CreateEntity()

	inst.skilled = skilled

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("luoxiaohei_sword")
	inst.AnimState:SetBuild("luoxiaohei_sword")
	inst.AnimState:PlayAnimation("spin_loop")

	inst:AddTag("sharp")
	inst:AddTag("pointy")
    inst:AddTag("weapon")
	inst:AddTag("waterproofer")
	inst:AddTag("projectile")
	inst:AddTag("thrown")
	inst:AddTag("metal")
	inst:AddTag("lord_projectile")

	RemovePhysicsColliders(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("waterproofer")

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(function(inst, attacker, target)
		return TUNING.LUOXIAOHEI_SWORD_ATK * (skilled and 1 or 0.8)
	end)

	inst:AddComponent("projectile")
	inst.components.projectile:SetSpeed(TUNING.LUOXIAOHEI_EXT_SPEED / 2)
	inst.components.projectile:SetRange(200)
	inst.components.projectile:SetHoming(true)
	inst.components.projectile:SetOnThrownFn(OnThrown)
	inst.components.projectile:SetOnHitFn(OnHit)
	inst.components.projectile:SetOnMissFn(OnMiss)

	inst:DoTaskInTime(10, function(inst)
		inst:Remove()
	end)

	return inst
end

local function dartfn()
	local inst = dart_common(false)
	return inst
end

local function dartfn_s()
	local inst = dart_common(true)
	return inst
end

return Prefab("luoxiaohei_sword", fn, assets),
		Prefab("luoxiaohei_irondart", dartfn, assets),
		Prefab("luoxiaohei_irondart_s", dartfn_s, assets)
