local assets =
{
	Asset( "SOUND", "sound/luoxiaohei.fsb" ),
	Asset( "SOUNDPACKAGE", "sound/luoxiaohei.fev" ),
}

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.IZAYOI = {
	"luoxiaohei_sword",
}

local luoxiaohei_extra_repairables = {
	"goldenaxe",
	"goldenpickaxe",
	"goldenshovel",
	"golden_farm_hoe",
}

local function IsInTable(tbl, value)
	for k, v in pairs(tbl) do
		if v == value then
			return true;
		end
	end
	return false;
end

local function enablenv(inst)
	inst.components.playervision:ForceNightVision(true)
	inst.components.playervision:SetCustomCCTable({
		day = "images/colour_cubes/day05_cc.tex",
		dusk = "images/colour_cubes/dusk03_cc.tex",
		night = "images/colour_cubes/lunacy_regular_cc.tex",
		full_moon = "images/colour_cubes/purple_moon_cc.tex",
	})
end
local function disablenv(inst)
	inst.components.playervision:ForceNightVision(false)
	inst.components.playervision:SetCustomCCTable(nil)
end
local function isinbasement(vinst)
	local x, y, z = vinst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 20, { "basement_part", "alt_tile" })
	for k, v in pairs(ents) do
		if v and v.prefab == "basement" then
			return true
		end
	end
end	-- <地窖MOD兼容
local function checknv(inst, phase)
	if inst:HasTag("watch_equipped") and TUNING.LUOXIAOHEI_WATCH_NIGHT_VISION and (TheWorld:HasTag("cave") or isinbasement(inst) or TheWorld.state.phase == "night") then
		inst:DoTaskInTime(phase and 0.6 or FRAMES, function()
			enablenv(inst)
		end)
	else
		inst:DoTaskInTime(phase and 0.6 or FRAMES, function()
			disablenv(inst)
		end)
	end
end	-- <夜视
local function updatenv(inst)
	checknv(inst, true)
end

local MakePlayerCharacter = require "prefabs/player_common"
return MakePlayerCharacter("luoxiaohei", {}, {},
function(inst)
	inst.MiniMapEntity:SetIcon( "luoxiaohei.tex" )
	inst:AddTag("luoxiaohei_skiller")
	inst:AddTag("metal_manipulator")
	-- if TUNING.LUOXIAOHEI_VOICE > 0 then	-- <语音
	-- 	inst.hurtsoundoverride = "luoxiaohei/voice/hurt"
	-- 	inst.deathsoundoverride = "luoxiaohei/voice/death_voice"
	-- end
	inst:WatchWorldState("phase", updatenv)
	if TUNING.LUOXIAOHEI_BASEMENT_COMPATIBLE then
		inst:DoPeriodicTask(1, function()
			checknv(inst)
		end)	-- >
	end
	inst._lordextrange = net_float(inst.GUID, "combat._extrange")
end,
function(inst)
	inst.soundsname = "wilson"
	-- if TUNING.LUOXIAOHEI_VOICE > 0 then
	-- 	inst.examineoverride = {	-- 被注释的尚未添加对应语音
	-- 	}	-- >
	-- end

	inst.components.health:SetMaxHealth(TUNING.LUOXIAOHEI_HEALTH)	-- <三围
	inst.components.hunger:SetMax(TUNING.LUOXIAOHEI_HUNGER)
	inst.components.sanity:SetMax(TUNING.LUOXIAOHEI_SANITY)	-- >
	inst.components.hunger.hungerrate = 2 * TUNING.WILSON_HUNGER_RATE
	inst.components.sanity.neg_aura_mult = 0.5

	-- inst.components.sanity:SetSanityMonitoringFn(function(self)
	-- 	if self:IsInsane() then
	-- 		if inst:HasTag("luoxiaohei_sword_caster") then
	-- 			inst:RemoveTag("luoxiaohei_sword_caster")
	-- 		end
	-- 	else
	-- 		inst:AddTag("luoxiaohei_sword_caster")
	-- 	end
	-- end)

	inst.components.combat:SetLordExtRange(TUNING.LUOXIAOHEI_EXT_RANGE)
	inst.components.combat:SetLordProjectile(function(inst)
		return inst:HasTag("luoxiaohei_skill_on") and "luoxiaohei_irondart_s" or "luoxiaohei_irondart"
	end)
	inst.components.combat:SetCanLordExtFn(function(inst)
		local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		return weapon and weapon.prefab == "luoxiaohei_sword"
	end)
	inst.components.combat:SetOnLordExtAttackFn(function(inst)
		local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if weapon and weapon.components.finiteuses then
			-- weapon.components.finiteuses:Use(inst:HasTag("luoxiaohei_skill_on") and 6 or 3)
			weapon.components.finiteuses:Use(3)
			-- print(weapon.components.finiteuses:GetUses())
		end
	end)
	inst.components.combat:SetMercinessFn(function(inst, target)
		return target and target:IsValid() and not target:HasTag("INLIMBO") and target ~= inst and
			not target:HasTag("wall") and
			target.components.combat and target.components.health and
			(TUNING.LUOXIAOHEI_MERCY_ALL and true or target:HasTag("character"))	-- 智慧生物排除
	end)
	inst.components.combat:SetKeepTargetFunction(function(inst, target)
		return not (inst.components.combat.mercinessfn(inst, target) and
				target.components.health and target.components.health.currenthealth <= 1 )
	end)
	inst.components.combat:SetExtAction(function(inst, target)
		local dsq = distsq(target:GetPosition(), inst:GetPosition())
		local r1 = inst.components.combat:CalcAttackRangeSq(target, true)
		local r2 = inst.components.combat:CalcAttackRangeSq(target)
		if inst.components.combat:CanLordExtAttack() and dsq > r1 and dsq <= r2 then
			return "throw"
		end
		return nil
	end)
	inst.components.combat.customdamagemultfn = function(inst, target, weapon, multiplier, mount)
		return (inst:HasTag("luoxiaohei_skill_on") and 1.7 or 1) *
		((target:HasTag("chess") or target:HasTag("archive_centipede") or target.prefab == "wx78") and 2 or 1)
	end
	inst.components.combat.bonusdamagefn = function(attacker, target, damage, weapon)
		if inst:HasTag("luoxiaohei_skill_on") and target.components.health and target.components.health:GetPercent() < 0.5 then
			if target.components.inventory ~= nil then
				return damage - target.components.inventory:CalcDamageAbsorption(damage, attacker, weapon) * 0.5
			end
		end
		return 0
	end
	inst:ListenForEvent("onhitother", function(inst, data)
		if data.target:HasTag("chess") or data.target.prefab == "archive_centipede" or data.target.prefab == "wx78" then
			local regen = math.floor(data.damage / 20)
			for _, v in pairs(inst.components.inventory:FindItems(function(item)
				return (item:HasTag("metal") or IsInTable(luoxiaohei_extra_repairables, item.prefab)) and item.components.finiteuses
			end)) do
				if v.components.finiteuses:GetPercent() < 1 then
					v.components.finiteuses:Use(-1 * regen)
					break
				end
			end
	
		end
	end)
	inst:ListenForEvent("ontryattack", function(inst, data)
		if inst:HasTag("luoxiaohei_skill_on") then
			local extratgt = FindEntity(inst, TUNING.LUOXIAOHEI_EXT_RANGE, function(ent, inst)
				return ent and ent:IsValid() and ent ~= data.target and
				ent.components.combat and ent.components.health and
				(ent.components.combat:TargetIs(inst) or (ent:HasTag("hostile") and ent:HasTag("monster"))) and
				not ent.components.health:IsDead() and not (ent:HasTag("shadow") and not inst:HasTag("crazy")) and
				distsq(ent:GetPosition(), inst:GetPosition()) >= distsq(data.target:GetPosition(), inst:GetPosition()) and
				not (inst.components.combat.mercinessfn(inst, ent) and ent.components.health.currentvalue <= 1)
			end, nil, { "companion", "wall", "INLIMBO", "FX", "playerghost", "invisible" })
			if not extratgt then
				return
			end
			inst:DoTaskInTime(FRAMES * 1, function()
				inst.components.combat:DoAttack(extratgt, data.weapon, data.projectile, data.stimuli, nil, true)	
			end)
		end
	end)
	inst:ListenForEvent("sanitydelta", function(inst, data)
		-- local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		-- if equip and equip.prefab == "luoxiaohei_sword" then
		-- 	if inst.components.sanity:IsInsane() then
		-- 		equip:AddTag("inuse")
		-- 	else
		-- 		equip:RemoveTag("inuse")
		-- 	end
		-- end
		if inst.components.sanity:IsInsane() then
			if inst:HasTag("luoxiaohei_sword_caster") then
				inst:RemoveTag("luoxiaohei_sword_caster")
			end
			inst:PushEvent("luoxiaohei_skill_switch", {forced = false})
		else
			inst:AddTag("luoxiaohei_sword_caster")
		end

	end)

	inst.components.sanity.custom_rate_fn = function(inst)
		return inst:HasTag("luoxiaohei_skill_on") and -1.5 or 0
	end

	inst:ListenForEvent("luoxiaohei_skill_switch", function(inst, data)
		-- print("====B====")
		local skill_on = not inst:HasTag("luoxiaohei_skill_on")
		if data and data.forced ~= nil then
			skill_on = data.forced
		end
		if skill_on then
			if not inst:HasTag("luoxiaohei_skill_on") then
				inst:AddTag("luoxiaohei_skill_on")
			end
			inst.SoundEmitter:PlaySound("luoxiaohei/se/skill_on", nil, TUNING.LUOXIAOHEI_SE * 0.3)
			inst.SoundEmitter:KillSound("luoxiaohei_attack")
			inst.SoundEmitter:PlaySound("luoxiaohei/voice/attack", "luoxiaohei_attack", TUNING.LUOXIAOHEI_VOICE)
			inst.AnimState:SetHaunted(true)
		else
			inst:RemoveTag("luoxiaohei_skill_on")
			if not inst:HasTag("spawnprotection") then
				inst.AnimState:SetHaunted(false)
			end
		end
		-- if owner.luoxiaohei_skill_task == nil then
		-- 	local tpf = FRAMES / TheSim:GetTickTime()
		-- 	owner.luoxiaohei_skill_task = owner:DoPeriodicTask(FRAMES, function()
		-- 		if math.floor(GetTick() % (20 * tpf)) == 0 then
		-- 			owner.components.sanity:DoDelta(-1)
		-- 		end
		-- 		if not owner:HasTag("luoxiaohei_skill_on") then
		-- 			owner:AddTag("luoxiaohei_skill_on")
		-- 			owner.SoundEmitter:PlaySound("luoxiaohei/se/skill_on", nil, TUNING.LUOXIAOHEI_SE * 0.3)
		-- 			owner.SoundEmitter:KillSound("luoxiaohei_attack")
		-- 			owner.SoundEmitter:PlaySound("luoxiaohei/voice/attack", "luoxiaohei_attack", TUNING.LUOXIAOHEI_VOICE)
		-- 			owner.AnimState:SetHaunted(true)
		-- 		end
		-- 		if owner.components.health:IsDead() or owner.components.sanity:IsInsane() then
		-- 			owner:RemoveTag("luoxiaohei_skill_on")
		-- 			if not owner:HasTag("spawnprotection") then
		-- 				owner.AnimState:SetHaunted(false)
		-- 			end
		-- 			owner.luoxiaohei_skill_task:Cancel()
		-- 			owner.luoxiaohei_skill_task = nil
		-- 		end
		-- 	end)
		-- else
		-- 	owner:RemoveTag("luoxiaohei_skill_on")
		-- 	if not owner:HasTag("spawnprotection") then
		-- 		owner.AnimState:SetHaunted(false)
		-- 	end
		-- 	owner.luoxiaohei_skill_task:Cancel()
		-- 	owner.luoxiaohei_skill_task = nil
		-- end
		-- inst:DoTaskInTime(FRAMES, function()
		-- 	inst.components.useableitem:StopUsingItem()
		-- end)
		-- onequip(inst, owner)

	end)
	inst:DoPeriodicTask(TUNING.LUOXIAOHEI_REPAIR_TIME, function(inst)
		for _, v in pairs(inst.components.inventory:FindItems(function(item)
			return (item:HasTag("metal") or IsInTable(luoxiaohei_extra_repairables, item.prefab)) and item.components.finiteuses
		end)) do
			if v.components.finiteuses:GetPercent() < 1 then
				v.components.finiteuses:Use(-1)
				break
			end
		end
	end)
	if TUNING.LUOXIAOHEI_VOICE > 0 then
		-- inst:ListenForEvent("startattack", function(inst)
		-- 	if not (inst.components.combat:GetWeapon() and inst.components.combat:GetWeapon():HasTag("nobattlecry")) then
		-- 		inst.SoundEmitter:KillSound("luoxiaohei_attack")
		-- 		inst.SoundEmitter:PlaySound("luoxiaohei/voice/attack", "luoxiaohei_attack", TUNING.LUOXIAOHEI_VOICE)
		-- 	end
		-- end)
		inst:ListenForEvent("oninspect", function(inst, data)
			if data.tgt and data.tgt:HasTag("player") then
				inst.SoundEmitter:KillSound("luoxiaohei_inspect")
				inst.SoundEmitter:PlaySound("luoxiaohei/voice/characters/"..data.tgt.prefab, "luoxiaohei_inspect", TUNING.LUOXIAOHEI_VOICE)
			end
		end)	-- >
	end

	inst.skeleton_prefab = nil

end, TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.LUOXIAOHEI)
