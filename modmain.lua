--[[ 初始化GLOBAL > ]]
GLOBAL.setmetatable(env,{__index = function(_, k)
	return GLOBAL.rawget(GLOBAL,k)
end})
--<

--[[ 初始化多语言 > ]]
local function LIMBO(tbl)
	tbl["zhr"] = tbl["zh"]
	return tbl[TUNING.LUOXIAOHEI_LANGUAGE] or tbl[1]
end
--<

--[[ table检查实用函数 > ]]
local function IsInTable(tbl, value)
	for k, v in pairs(tbl) do
		if v == value then
			return true;
		end
	end
	return false;
end
--<

--[[ mod检查实用函数 > ]]
local function isModEnabled(mod)
	local list = ModManager and ModManager.enabledmods
	if not list then
		return false
	end
	return IsInTable(list, mod)
end
--<

--[[ TUNING常量表 > ]]
TUNING.LUOXIAOHEI_SE = GetModConfigData("luoxiaohei_se")
TUNING.LUOXIAOHEI_VOICE = GetModConfigData("luoxiaohei_voice")
TUNING.LUOXIAOHEI_SWORD_ATK = 50
TUNING.LUOXIAOHEI_SWORD_USES = 300
TUNING.LUOXIAOHEI_SWORD_SPD_MULT = 0.7
TUNING.LUOXIAOHEI_EXT_RANGE = 8
TUNING.LUOXIAOHEI_EXT_SPEED = 20
TUNING.LUOXIAOHEI_REPAIR_TIME = 20
-- TUNING.LUOXIAOHEI_WATCH_NIGHT_VISION = GetModConfigData("watch_night_vision")
-- TUNING.LUOXIAOHEI_STRENGTH = GetModConfigData("strength")	-- <读取配置

TUNING.LUOXIAOHEI_BASEMENT_COMPATIBLE = isModEnabled("workshop-1349799880")
TUNING.LUOXIAOHEI_LANGUAGE = LOC.GetLocaleCode()
-- if TUNING.LUOXIAOHEI_STRENGTH == "op" then
-- 	TUNING.LUOXIAOHEI_HUNGER = 300
-- 	TUNING.LUOXIAOHEI_SANITY = 300
-- 	TUNING.LUOXIAOHEI_HEALTH = 300
-- 	TUNING.LUOXIAOHEI_DAMAGE = 2
-- elseif TUNING.LUOXIAOHEI_STRENGTH == "easy" then
-- 	TUNING.LUOXIAOHEI_HUNGER = 120
-- 	TUNING.LUOXIAOHEI_SANITY = 300
-- 	TUNING.LUOXIAOHEI_HEALTH = 200
-- 	TUNING.LUOXIAOHEI_DAMAGE = 1.2
-- elseif TUNING.LUOXIAOHEI_STRENGTH == "hard" then
-- 	TUNING.LUOXIAOHEI_HUNGER = 90
-- 	TUNING.LUOXIAOHEI_SANITY = 200
-- 	TUNING.LUOXIAOHEI_HEALTH = 120
-- 	TUNING.LUOXIAOHEI_DAMAGE = 0.9
-- elseif TUNING.LUOXIAOHEI_STRENGTH == "lunatic" then
-- 	TUNING.LUOXIAOHEI_HUNGER = 80
-- 	TUNING.LUOXIAOHEI_SANITY = 150
-- 	TUNING.LUOXIAOHEI_HEALTH = 100
-- 	TUNING.LUOXIAOHEI_DAMAGE = 0.75
-- else
TUNING.LUOXIAOHEI_HUNGER = 100
TUNING.LUOXIAOHEI_SANITY = 250
TUNING.LUOXIAOHEI_HEALTH = 150
--	TUNING.LUOXIAOHEI_DAMAGE = 1
-- end	-- <设定强度
TUNING.LUOXIAOHEI_AMULET_DAPPERNESS = 6.8 / 60
--<

--[[ prefab文件及材质加载 > ]]
PrefabFiles = {
	"luoxiaohei",
	"luoxiaohei_none",
	"luoxiaohei_sword",
	"oriron_shard",
	"catsplash_fx",
}
Assets = {
	Asset( "IMAGE", "images/saveslot_portraits/luoxiaohei.tex" ),
	Asset( "ATLAS", "images/saveslot_portraits/luoxiaohei.xml" ),

	Asset( "IMAGE", "images/selectscreen_portraits/luoxiaohei.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/luoxiaohei.xml" ),

	Asset( "IMAGE", "images/selectscreen_portraits/luoxiaohei_silho.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/luoxiaohei_silho.xml" ),

	Asset( "IMAGE", "bigportraits/luoxiaohei.tex" ),
	Asset( "ATLAS", "bigportraits/luoxiaohei.xml" ),

	Asset( "IMAGE", "bigportraits/luoxiaohei_none.tex" ),
	Asset( "ATLAS", "bigportraits/luoxiaohei_none.xml" ),

	Asset( "IMAGE", "images/map_icons/luoxiaohei.tex" ),
	Asset( "ATLAS", "images/map_icons/luoxiaohei.xml" ),

	Asset( "IMAGE", "images/map_icons/luoxiaohei_sword.tex" ),
	Asset( "ATLAS", "images/map_icons/luoxiaohei_sword.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_luoxiaohei.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_luoxiaohei.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_luoxiaohei.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_ghost_luoxiaohei.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_luoxiaohei.tex" ),
	Asset( "ATLAS", "images/avatars/self_inspect_luoxiaohei.xml" ),

	Asset( "IMAGE", "images/names_luoxiaohei.tex" ),
	Asset( "ATLAS", "images/names_luoxiaohei.xml" ),

	Asset( "IMAGE", "images/names_gold_luoxiaohei.tex" ),
	Asset( "ATLAS", "images/names_gold_luoxiaohei.xml" ),

	Asset( "ANIM", "anim/luoxiaohei.zip" ),
	Asset( "ANIM", "anim/ghost_luoxiaohei_build.zip" ),

	Asset( "SOUND", "sound/luoxiaohei.fsb" ),
	Asset( "SOUNDPACKAGE", "sound/luoxiaohei.fev" ),
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.luoxiaohei_sword = {	-- <初始物品
	atlas = "images/inventoryimages/luoxiaohei_sword.xml",
	image = "luoxiaohei_sword.tex",
}
AddMinimapAtlas("images/map_icons/luoxiaohei.xml")	-- <小地图
AddMinimapAtlas("images/map_icons/luoxiaohei_sword.xml")
--<


--[[ STRING常量表 > ]]
STRINGS.NAMES.LUOXIAOHEI = LIMBO({"Luo Xiaohei", ["zh"] = "罗小黑"})
STRINGS.CHARACTER_TITLES.luoxiaohei = LIMBO({"Elfin Black Cat", ["zh"] = "妖精小黑猫"})
STRINGS.CHARACTER_NAMES.luoxiaohei = STRINGS.NAMES.LUOXIAOHEI
STRINGS.CHARACTER_DESCRIPTIONS.luoxiaohei = LIMBO({"*Elfin\n*Cat Transformation \n*Metal Manipulation", ["zh"] = "*妖精\n*变化为猫猫形态\n*驭金之力"})
STRINGS.CHARACTER_QUOTES.luoxiaohei = LIMBO({"\"I'm Xiaohei, an elfin.\"", ["zh"] = "\"我叫小黑，是个妖精。\""})
STRINGS.SKIN_NAMES.luoxiaohei_none = STRINGS.NAMES.LUOXIAOHEI
STRINGS.LUOXIAOHEI_MISC = {
	SWORD_REFUSED = LIMBO({"I can't hold this.", ["zh"] = "我拿不动。"}),
}
require "desc"
-- local speeches = {
-- 	["zh"] = function() return require "speech_zh" end,
-- 	["zhr"] = function() return require "speech_zh" end,
-- }
-- local spf = speeches[TUNING.LUOXIAOHEI_LANGUAGE]
-- STRINGS.CHARACTERS.IZAYOI = spf and spf() or require "speech"	-- TODO: English?
STRINGS.CHARACTERS.LUOXIAOHEI = require "speech_zh"

STRINGS.NAMES.LUOXIAOHEI_SWORD = LIMBO({"Iron Sword", ["zh"] = "镔铁大剑",})
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LUOXIAOHEI_SWORD = LIMBO({"A heavy huge weapon.", ["zh"] = "又大又沉的武器。"})
STRINGS.RECIPE_DESC.LUOXIAOHEI_SWORD = LIMBO({"I have to fight now.", ["zh"] = "我现在必须战斗才行。"})

STRINGS.NAMES.ORIRON_SHARD = LIMBO({"Oriron Shard", ["zh"] = "异铁碎片",})
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ORIRON_SHARD = LIMBO({"Some shards that never seen before.", ["zh"] = "从来没见过的碎片。"})
STRINGS.RECIPE_DESC.ORIRON_SHARD = LIMBO({"It feels like iron, so maybe I can...", ["zh"] = "里面好像有铁，也许我可以……"})
--<

--[[ 添加人物 > ]]
local skin_modes = {
	{
		type = "ghost_skin",
		anim_bank = "ghost",
		idle_anim = "idle",
		scale = 0.75,
		offset = { 0, -25 }
	},
}
AddModCharacter("luoxiaohei", "MALE", skin_modes)
--<

--[[ 加载制作配方 > ]]
local myrecipemap = {
	luoxiaohei_sword = {recipe =  {Ingredient("oriron_shard", 12), Ingredient("rope", 1), Ingredient(CHARACTER_INGREDIENT.SANITY, 20)}, amount = nil},
	oriron_shard = {recipe =  {Ingredient("moonrocknugget", 3), Ingredient(CHARACTER_INGREDIENT.SANITY, 15)}, amount = 6},
}

local AddRecipeX = AddRecipe2 ~= nil and AddRecipe2 or function(name, ingredients, tech, config, filters)
	return AddRecipe(name, ingredients, config.tab, tech, config, config.min_spacing, config.nounlock, config.numtogive, config.builder_tag, config.atlas, config.image, config.testfn, config.product, config.build_mode, config.build_distance)
end	-- <配方兼容模式

AddRecipeX("luoxiaohei_sword", myrecipemap.luoxiaohei_sword.recipe, TECH.NONE,
{
	tab = RECIPETABS.WAR,
	numtogive = myrecipemap.luoxiaohei_sword.amount,
	builder_tag = "luoxiaohei_skiller",
	atlas = "images/inventoryimages/luoxiaohei_sword.xml",
	image = "luoxiaohei_sword.tex"
}, {"CHARACTER", "WEAPONS"})
AddRecipeX("oriron_shard", myrecipemap.oriron_shard.recipe, TECH.NONE,
{
	tab = RECIPETABS.REFINE,
	numtogive = myrecipemap.oriron_shard.amount,
	builder_tag = "luoxiaohei_skiller",
	atlas = "images/inventoryimages/oriron_shard.xml",
	image = "oriron_shard.tex"
}, {"CHARACTER", "REFINE"})
--<

local characterName = "luoxiaohei"

--[[ 增补Whisper > ]]
local function CancelSay(self)
	if self.task ~= nil then
		scheduler:KillTask(self.task)
		self.task = nil
		if self.widget ~= nil then
			self.widget:Kill()
			self.widget = nil
		end
		if self.donetalkingfn ~= nil then
			self.donetalkingfn(self.inst)
		end
		self.inst:PushEvent("donetalking")
	end
end

local function getDistance(p1, p2)
	local x1, x2, y1, y2, z1, z2
	if p1 and p1:IsValid() and p1:HasTag("player") and not p1:HasTag("playerghost") and p1.components.health and not p1.components.health:IsDead() then
		x1, y1, z1 = p1.Transform:GetWorldPosition()
	else
		return nil
	end
	if p2 and p2:IsValid() and p2:HasTag("player") and not p2:HasTag("playerghost") and p2.components.health and not p2.components.health:IsDead() then
		x2, y2, z2 = p2.Transform:GetWorldPosition()
	else
		return nil
	end
	local dist = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
	return dist or nil
end

local function GetTableRemovedValues(tbl, value)
	local newtbl
	for k, v in pairs(tbl) do
		local validvalue = true
		if type(value) == "table" then
			for k2, v2 in pairs(value) do
				if v2 == v then
					validvalue = false
					break
				end
			end
		elseif value == v then
			validvalue = false
		end
		if validvalue then
			table.insert(newtbl, v)
		end
	end
	return newtbl
end

local FollowText = require "widgets/followtext"

local event_whisper = EventHandler("onwhisper", function(inst, data)
	if inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("notalking") then
		if not inst:HasTag("mime") then
			inst.sg:GoToState("whisper", data.noanim)
		elseif not inst.components.inventory:IsHeavyLifting() then
			--Don't do it even if mounted!
			inst.sg:GoToState("mime")
		end
	end
end)

local state_whisper = State {
	name = "whisper",
	tags = { "idle", "talking" },
	onenter = function(inst, noanim)
		if not noanim then
			inst.AnimState:PlayAnimation(
				inst.components.inventory:IsHeavyLifting() and
				not inst.components.rider:IsRiding() and
				"heavy_dial_loop" or
				"dial_loop",
				true)
		end
		inst.sg:SetTimeout(1.5 + math.random() * .5)
	end,
	ontimeout = function(inst)
		inst.sg:GoToState("idle")
	end,
	events =
	{

		EventHandler("donetalking", function(inst)
			inst.sg:GoToState("idle")
		end),
	},
	onexit = function(inst)
	end,
}

AddStategraphEvent("wilson", event_whisper)
AddStategraphState("wilson", state_whisper)

AddComponentPostInit("talker", function(self)
	local function whisperfn(self, script, nobroadcast, colour)
		local player = ThePlayer
		if (not self.disablefollowtext) and self.widget == nil and player ~= nil and player.HUD ~= nil then
			self.widget = player.HUD:AddChild(FollowText(self.font or TALKINGFONT, self.fontsize or 35))
			self.widget:SetHUD(player.HUD.inst)
		end
		if self.widget ~= nil then
			self.widget.symbol = self.symbol
			self.widget:SetOffset(self.offset_fn ~= nil and self.offset_fn(self.inst) or self.offset or DEFAULT_OFFSET)
			self.widget:SetTarget(self.inst)
			if colour ~= nil then
				self.widget.text:SetColour(unpack(colour))
			elseif self.colour ~= nil then
				self.widget.text:SetColour(self.colour.x, self.colour.y, self.colour.z, 1)
			end
		end
		for i, line in ipairs(script) do
			if line.message ~= nil then
				local display_message = GetSpecialCharacterPostProcess(self.inst.prefab, self.mod_str_fn ~= nil and self.mod_str_fn(line.message) or line.message)
				if not nobroadcast then
					TheNet:Talker(line.message, self.inst.entity)
				end
				if self.widget ~= nil then
					self.widget.text:SetString(display_message)
				end
				if self.onwhisperfn ~= nil then
					self.onwhisperfn(self.inst, { noanim = line.noanim, message = display_message })
				end
				self.inst:PushEvent("onwhisper", { noanim = line.noanim })
			elseif self.widget ~= nil then
				self.widget:Hide()
			end
			Sleep(self.lineduration or 2.5)
			if not self.inst:IsValid() or (self.widget ~= nil and not self.widget.inst:IsValid()) then
				return
			end
		end
		if self.widget ~= nil then
			self.widget:Kill()
			self.widget = nil
		end
		if self.donetalkingfn ~= nil then
			self.donetalkingfn(self.inst)
		end
		self.inst:PushEvent("donetalking")
		self.task = nil
	end
	self.Whisper = function(self, script, time, noanim, force, nobroadcast, colour)
		if TheWorld.ismastersim then
			if not force
				and (self.ignoring ~= nil or
					(self.inst.components.health ~= nil and self.inst.components.health:IsDead() and self.inst.components.revivablecorpse == nil) or
					(self.inst.components.sleeper ~= nil and self.inst.components.sleeper:IsAsleep())) then
				return
			elseif self.onwhisper ~= nil then
				self.onwhisper(self.inst, script)
			end
		elseif not force then
			if self.inst:HasTag("ignoretalking") then
				return
			elseif self.inst.components.revivablecorpse == nil then
				local health = self.inst.replica.health
				if health ~= nil and health:IsDead() then
					return
				end
			end
		end
		CancelSay(self)

		local lines = type(script) == "string" and { Line(script, noanim) } or script
		if lines ~= nil then
			self.task = self.inst:StartThread(function() whisperfn(self, lines, nobroadcast, colour) end)
		end
	end
end)
--<

--[[ 改写检查 > ]]
ACTIONS.LOOKAT.fn = function(act)
	local targ = act.target or act.invobject
	if targ ~= nil and targ.prefab ~= nil and targ.components.inspectable ~= nil then
		local desc = targ.components.inspectable:GetDescription(act.doer)
		if desc ~= nil then
			if act.doer.components.playercontroller == nil or
				not act.doer.components.playercontroller.directwalking then
				act.doer.components.locomotor:Stop()
			end
			act.doer:PushEvent("oninspect", {tgt = targ, desc = desc})
			if act.doer.components.talker ~= nil then
				if act.doer.examineoverride ~= nil and IsInTable(act.doer.examineoverride, targ.prefab) then
					act.doer.components.talker:Whisper(desc, 2.5, targ.components.inspectable.noanim)
				else
					act.doer.components.talker:Say(desc, 2.5, targ.components.inspectable.noanim)
				end
			end
			return true
		end
	end
end
--<

--[[ inventory函数增补 > ]]
AddComponentPostInit("inventory", function(self)
	self.FindItemByName = function(self, pf)
		for k, v in pairs(self.itemslots) do
			if v.prefab == pf then
				return v
			end
		end
		for k, v in pairs(self.equipslots) do
			if v.prefab == pf then
				return v
			end
		end
		if self.activeitem and self.activeitem.prefab == pf then
			return self.activeitem
		end
		local overflow = self:GetOverflowContainer()
		return overflow ~= nil and overflow:FindItemByName(pf) or nil
	end

	self.CalcDamageAbsorption = function(self, damage, attacker, weapon)
		--check resistance and specialised armor
		local absorbers = {}
		for k, v in pairs(self.equipslots) do
			if v.components.resistance ~= nil and
				v.components.resistance:HasResistance(attacker, weapon) and
				v.components.resistance:ShouldResistDamage() then
				v.components.resistance:ResistDamage(damage)
				return 0
			elseif v.components.armor ~= nil then
				absorbers[v.components.armor] = v.components.armor:GetAbsorption(attacker, weapon)
			end
		end
	
		local absorbed_percent = 0
		local total_absorption = 0
		for armor, amt in pairs(absorbers) do
			absorbed_percent = math.max(amt, absorbed_percent)
			total_absorption = total_absorption + amt
		end
	
		return damage * absorbed_percent
	end
	
end)
--<

-- --[[ sanity函数增补 > ]]
-- AddComponentPostInit("sanity", function(self)
-- 	self.SetSanityMonitoringFn = function(self, fn)
-- 		self.updatemonfn = fn
-- 	end
-- 	local pOnUpdate = self.OnUpdate
-- 	self.OnUpdate = function(self, dt)
-- 		pOnUpdate(self, dt)
-- 		self.updatemonfn(self)
-- 	end	
-- end)
-- --<

--[[ 见习执行者相关代码 > ]]
AddComponentPostInit("health", function(self)
	local pDoDelta = self.DoDelta
	self.DoDelta = function(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
		if amount < 0 and afflicter and afflicter.components.combat and
				afflicter.components.combat.mercinessfn and afflicter.components.combat.mercinessfn(afflicter, self.inst) and
				amount + self.currenthealth <= 0 then
			amount = 1 - self.currenthealth
		end
		return pDoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
	end
	local pSetCurrentHealth = self.SetCurrentHealth
	self.SetCurrentHealth = function(self, amount)
		pSetCurrentHealth(self, amount)
		if self.currenthealth <= 1 then
			self.inst:AddTag("fragile")
		else
			self.inst:RemoveTag("fragile")
		end
	end
	local pSetMaxHealth = self.SetMaxHealth
	self.SetMaxHealth = function(self, amount)
		pSetMaxHealth(self, amount)
		if self.currenthealth <= 1 then
			self.inst:AddTag("fragile")
		else
			self.inst:RemoveTag("fragile")
		end
	end
	local pSetVal = self.SetVal
	self.SetVal = function(self, amount)
		pSetVal(self, amount)
		if self.currenthealth <= 1 then
			self.inst:AddTag("fragile")
		else
			self.inst:RemoveTag("fragile")
		end
	end
end)
--<

--[[ 碎金为刃相关代码 > ]]
AddAction("LUOXIAOHEI_SKILL", LIMBO({"From Ore to Blade", ["zh"] = "碎金为刃"}), function(act)
	-- if act.doer.components.combat and act.target.components.target and
	-- 		act.doer.components.inventory  then
	-- 	local weapon = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	-- 	if weapon and weapon.components.weapon and weapon:HasTag("magic_throwable") then
	-- 		weapon.components.weapon:MagicThrow(act.doer, act.target)
	-- 	end
	-- end
	act.doer:PushEvent("luoxiaohei_skill_switch")
	return true
end)

AddComponentAction("INVENTORY", "weapon", function(inst, doer, actions, right, ...)
	-- print(inst, doer, actions, right, ...)
	-- for k, v in pairs(actions) do
	-- 	print(k, v)
	-- 	for k2, v2 in pairs(actions) do
	-- 		print(k2, v2)
	-- 	end
	
	-- end
	-- if right then
		-- print(inst.replica.weapon, doer.prefab, doer.replica.inventory, doer.replica.sanity)
		-- if inst.replica.weapon and doer.prefab == "luoxiaohei" then
		if doer.prefab == "luoxiaohei" then
			local weapon = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			-- print(weapon, doer.replica.sanity:IsInsane())
			if weapon == inst and not doer.replica.sanity:IsInsane() then
				table.insert(actions, ACTIONS.LUOXIAOHEI_SKILL)
			end
		end
	-- end
end
)
local luoxiaohei_showoff = State{
	name = "luoxiaohei_showoff",
	tags = { "showoff" },

	onenter = function(inst)
		local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if not equip then
			inst.AnimState:OverrideSymbol("swap_object", "", "")
			inst.AnimState:Show("ARM_carry")
			inst.AnimState:Hide("ARM_normal")
		end
		inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("dumbbell_mighty_pre")
		inst.AnimState:PushAnimation("dumbbell_mighty_loop", false)
		-- inst.AnimState:PushAnimation(equip and "dumbbell_mighty_pst" or "item_in", false)
	end,

	timeline =
	{
		TimeEvent(3 * FRAMES, function(inst)
			inst:PerformBufferedAction()
			local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if not equip then
				inst.AnimState:OverrideSymbol("swap_object", "", "")
				inst.AnimState:Show("ARM_carry")
				inst.AnimState:Hide("ARM_normal")
			end
			inst.AnimState:PushAnimation(equip and "dumbbell_mighty_pst" or "item_in", false)
		end),
	},

	events =
	{
		EventHandler("animqueueover", function(inst)
			if inst.AnimState:AnimDone() then
				local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				if not equip then
					inst.AnimState:OverrideSymbol("swap_object", "", "")
					inst.AnimState:Hide("ARM_carry")
					inst.AnimState:Show("ARM_normal")
				end
				inst.sg:GoToState("idle")
			end
		end),
	},
}
local luoxiaohei_showoffc = State
{
	name = "luoxiaohei_showoff",
	tags = { "showoff" },

	onenter = function(inst)
		local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if not equip then
			inst.AnimState:OverrideSymbol("swap_object", "", "")
			inst.AnimState:Show("ARM_carry")
			inst.AnimState:Hide("ARM_normal")
		end
		-- inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("dumbbell_mighty_pre")
		inst.AnimState:PushAnimation("dumbbell_mighty_loop", false)
		-- inst.AnimState:PushAnimation("dumbbell_mighty_pst", false)
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(2)
		
	end,

	onupdate = function(inst)
		if inst.bufferedaction == nil then
			local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if not equip then
				inst.AnimState:OverrideSymbol("swap_object", "", "")
				inst.AnimState:Hide("ARM_carry")
				inst.AnimState:Show("ARM_normal")
			end
			inst.AnimState:PushAnimation(equip and "dumbbell_mighty_pst" or "item_in", false)
			inst.sg:GoToState("idle", true)
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if not equip then
			inst.AnimState:OverrideSymbol("swap_object", "", "")
			inst.AnimState:Hide("ARM_carry")
			inst.AnimState:Show("ARM_normal")
		end
		inst.AnimState:PushAnimation(equip and "dumbbell_mighty_pst" or "item_in", false)
		inst.sg:GoToState("idle", true)
	end,
}
AddStategraphState("wilson", luoxiaohei_showoff)
AddStategraphState("wilson_client", luoxiaohei_showoffc)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.LUOXIAOHEI_SKILL, function(inst, action)
	-- print("++++A++++")
	-- print(inst:HasTag("luoxiaohei_skill_on"))
	return inst:HasTag("luoxiaohei_skill_on") and "doequippedaction" or "luoxiaohei_showoff"
end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.LUOXIAOHEI_SKILL, function(inst, action)
	-- print("++++A++++")
	-- print(inst:HasTag("luoxiaohei_skill_on"))
	return inst:HasTag("luoxiaohei_skill_on") and "doequippedaction" or "luoxiaohei_showoffc"
end))
--<

--[[ 大剑祭起相关代码 > ]]
local mt_action = AddAction("MAGICTHROW", LIMBO({"Wield and throw", ["zh"] = "祭起"}), function(act)
	-- print("T0")
	if act.doer.components.combat and act.target.components.combat and
			act.doer.components.inventory  then
		-- print("T0.1")
		local weapon = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if weapon and weapon.components.weapon and weapon:HasTag("magic_throwable") then
			-- print("T0.5")
			weapon.components.weapon:MagicThrow(act.doer, act.target)
		end
	end
	return true
end)
mt_action.customarrivecheck = function(inst, dest)
	local weapon = inst and inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if weapon and weapon.components.weapon and weapon.components.weapon.mt_params then
		local x, _, z = inst.Transform:GetWorldPosition()
		local x2, _, z2 = dest:GetPoint()
		return math.sqrt(distsq(x, z, x2, z2)) <= weapon.components.weapon.mt_params.atkrange
	end
	return math.sqrt(distsq(x, z, x2, z2)) <= inst.components.combat:GetHitRange()
end

AddComponentAction("SCENE", "combat", function(inst, doer, actions, right, ...)
	-- print(inst, doer, actions, right, ...)
	if right and doer ~= inst and not (
		not TheNet:GetPVPEnabled() and inst:HasTag("player") or doer.replica.teamworker and doer.replica.teamworker:Identify(inst)
	) then
		-- if doer.replica.combat and doer.replica.inventory then
		-- print(doer.replica.inventory)
		local weapon = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		-- print(weapon, weapon.replica.weapon, weapon:HasTag("magic_throwable"), doer:HasTag(weapon.prefab.."_caster"))
		if weapon and weapon:HasTag("magic_throwable") and doer:HasTag(weapon.prefab.."_caster") then
			table.insert(actions, ACTIONS.MAGICTHROW)
		end
		-- end
	end
end
)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.MAGICTHROW, "luoxiaohei_showoff"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.MAGICTHROW, "luoxiaohei_showoffc"))

AddComponentPostInit("weapon", function(self)
	self.MagicThrow = function(self, caster, target)
		-- print("ST1")
		local owner = self.inst.components.inventoryitem:GetGrandOwner()
		if owner and owner.components.inventory then
			owner.components.inventory:DropItem(self.inst)
		elseif owner and owner.components.container then
			owner.components.container:DropItem(self.inst)
		end
		self.inst.AnimState:PlayAnimation("spin_loop_m", true)
		self.inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
		local dest = target:GetPosition()
		local direction = (dest - self.inst:GetPosition()):GetNormalized()
		local angle = math.acos(direction:Dot(Vector3(1, 0, 0))) / DEGREES
		self.inst.Transform:SetRotation(angle)
		self.inst:FacePoint(dest)
		if self.inst.Physics ~= nil and self.inst.Physics:IsActive() then
			local x, y, z = self.inst.Transform:GetWorldPosition()
			self.inst.Physics:Teleport(x, .1, z)
	
			x, y, z = self.inst.Transform:GetWorldPosition()
			local x1, y1, z1 = target.Transform:GetWorldPosition()
			local angle = math.atan2(z1 - z, x1 - x) + (math.random() * 20 - 10) * DEGREES
			local speed = 1 + math.random() * 2
			self.inst.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
			self.inst.last_y = y
		end
		self.inst.mt_task = self.inst:DoPeriodicTask(FRAMES, function(inst)
			if inst.Physics ~= nil and inst.Physics:IsActive() then
				local _, y, _ = inst.Transform:GetWorldPosition()
				if inst.last_y < y then
					inst.last_y = y
					return
				elseif inst.last_y - y < 1 then
					return
				end
			end
			if inst.components.projectile then
				inst.components.projectile:Throw(caster, target, caster)
			elseif self.mt_params ~= nil then
				inst:AddComponent("projectile")
				inst.components.projectile:SetSpeed(self.mt_params.speed)
				inst.components.projectile:SetRange(self.mt_params.range)
				inst.components.projectile:SetHoming(self.mt_params.homing)
				inst.components.projectile:SetOnThrownFn(function(inst, owner, ...)
					self.mt_params.onthrown(inst, caster, ...)
				end)
				-- inst.components.projectile:SetOnThrownFn(self.mt_params.onthrown)
				inst.components.projectile:SetOnHitFn(function(inst, owner, ...)
					self.mt_params.onhit(inst, caster, ...)
					inst:DoTaskInTime(FRAMES, function(inst)
						inst:RemoveComponent("projectile")
					end)
				end)
				inst.components.projectile:SetOnMissFn(function(inst, owner, ...)
					self.mt_params.onmiss(inst, caster, ...)
					inst:DoTaskInTime(FRAMES, function(inst)
						inst:RemoveComponent("projectile")
					end)
				end)
				inst.components.projectile:Throw(caster, target, caster)
			end
			inst.mt_task:Cancel()
			inst.mt_task = nil
		end)
	end
	self.SetMagicThrowParams = function(self, params)
		if params == nil then
			self.mt_params = nil
			return
		end
		self.mt_params = {
			speed = params and params.speed or nil,
			range = params and params.range or nil,
			atkrange = params and params.atkrange or nil,
			homing = params and params.homing or true,
			onthrown = params and params.onthrown or nil,
			onhit = params and params.onhit or nil,
			onmiss = params and params.onmiss or nil,
		}
	end
end)
--<

--[[ 战斗系统注入 > ]]
local ah = ActionHandler(ACTIONS.ATTACK, function(inst, action)
	inst.sg.mem.localchainattack = not action.forced or nil
	if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
		local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
		return (weapon == nil and "attack")
			or (weapon:HasTag("blowdart") and "blowdart")
			or (weapon:HasTag("mgun") and "mgun")	-- compatibility
			or inst.components.combat:GetExtAction(action.target)
			or (weapon:HasTag("slingshot") and "slingshot_shoot")
			or (weapon:HasTag("thrown") and "throw")
			or (weapon:HasTag("propweapon") and "attack_prop_pre")
			or (weapon:HasTag("multithruster") and "multithrust_pre")
			or (weapon:HasTag("helmsplitter") and "helmsplitter_pre")
			or "attack"
	end
end)
local ahc = ActionHandler(ACTIONS.ATTACK, function(inst, action)
	if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.replica.health:IsDead()) then
		local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if equip == nil then
			return "attack"
		end
		local inventoryitem = equip.replica.inventoryitem
		return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
			or (equip:HasTag("blowdart") and "blowdart")
			or (equip:HasTag("mgun") and "mgun")	-- compatibility
			or inst.replica.combat:GetExtActionC(action.target)
			or (equip:HasTag("slingshot") and "slingshot_shoot")
			or (equip:HasTag("thrown") and "throw")
			or (equip:HasTag("propweapon") and "attack_prop_pre")
			or "attack"
	end

end)
AddStategraphActionHandler("wilson", ah)
AddStategraphActionHandler("wilson_client", ahc)

AddComponentPostInit("combat", function(self)
	self.SetLordExtRange = function(self, range)	-- Can be a function
		self.lordextrange = range
		self.inst._lordextrange:set(range)
	end

	self.SetExtAction = function(self, act)	-- Can be a function
		self.extaction = act
	end

	self.SetLordProjectile = function(self, proj)	-- Can be a function
		self.lordprojectile = proj
	end

	self.SetCanLordExtFn = function(self, fn)		-- True if not set
		self.canlordextfn = fn
	end

	self.SetMercinessFn = function(self, fn)
		self.mercinessfn = fn
	end

	self.SetOnLordExtAttackFn = function(self, fn)
		self.onlordextattackfn = fn
	end

	self.GetExtAction = function(self, target)
		return FunctionOrValue(self.extaction, self.inst, target)
	end

	self.GetLordExtRange = function(self)
		return FunctionOrValue(self.lordextrange, self.inst)
	end

	self.GetLordProjectile = function(self)
		return FunctionOrValue(self.lordprojectile, self.inst)
	end

	self.CanLordExtAttack = function(self)
		return self.canlordextfn and self.canlordextfn(self.inst) or false
	end

	local pDoAttack = self.DoAttack
	self.DoAttack = function(self, targ, weapon, projectile, stimuli, instancemult, second)
		if not second and not (weapon and weapon:HasTag("lord_projectile")) then
			self.inst:PushEvent("ontryattack", { target = targ, weapon = weapon, projectile = projectile, stimuli = stimuli })
		end
		if weapon and weapon:HasTag("lord_projectile") or self.lordextrange == nil or self.lordprojectile == nil or not self:CanLordExtAttack() then
			return pDoAttack(self, targ, weapon, projectile, stimuli, instancemult)
		end
		if targ == nil then
			targ = self.target
		end
		local proj = self:GetLordProjectile()
		local extrange = self:GetLordExtRange()
		if distsq(targ:GetPosition(), self.inst:GetPosition()) <= self.attackrange * self.attackrange then
			return pDoAttack(self, targ, weapon, projectile, stimuli, instancemult)
		end
		local projentity = SpawnPrefab(proj)
		projentity.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
		if self.onlordextattackfn then
			self.onlordextattackfn(self.inst)
		end
		projentity.components.projectile:Throw(self.inst, targ)
	end

	local pCalcAttackRangeSq = self.CalcAttackRangeSq
	self.CalcAttackRangeSq = function(self, target, orig)
		if orig or self.lordextrange == nil or self.lordprojectile == nil or not self:CanLordExtAttack() then
			return pCalcAttackRangeSq(self, target)
		end
		local range = (target or self.target):GetPhysicsRadius(0) + self:GetLordExtRange()
		return range * range
	end
	local pIsValidTarget = self.IsValidTarget
	self.IsValidTarget = function(self, target)
		if target and target:HasTag("fragile") and self.mercinessfn and self.mercinessfn(self.inst, target) then
			return false
		end
		return pIsValidTarget(self, target)
	end
	local pCanHitTarget = self.CanHitTarget
	self.CanHitTarget = function(self, target, weapon)
		if target and target:HasTag("fragile") and self.mercinessfn and self.mercinessfn(self.inst, target) then
			return false
		end
		return pCanHitTarget(self, target, weapon)
	end
end)

AddClassPostConstruct("components/combat_replica", function(self)
	local pGetAttackRangeWithWeapon = self.GetAttackRangeWithWeapon
	self.GetAttackRangeWithWeapon = function(self, orig)
		if orig then
			return pGetAttackRangeWithWeapon(self)
		end
		return math.max(pGetAttackRangeWithWeapon(self), self.inst._lordextrange and self.inst._lordextrange:value() or 0)
	end
	self.CanLordExtAttackC = function(self)
		return self._canlordextfn and self._canlordextfn(self.inst) or true
	end
	self.GetExtActionC = function(self, target)
		return FunctionOrValue(self._extaction, self.inst, target)
	end
	local pCanTarget = self.CanTarget
	self.CanTarget = function(self, target)
		if target and target:HasTag("fragile") and self._mercinessfn and self._mercinessfn(self.inst, target) then
			return false
		end
		return pCanTarget(self, target)
	end
	local pIsValidTarget = self.IsValidTarget
	self.IsValidTarget = function(self, target)
		if target and target:HasTag("fragile") and self._mercinessfn and self._mercinessfn(self.inst, target) then
			return false
		end
		return pIsValidTarget(self, target)
	end
	local pCanHitTarget = self.CanHitTarget
	self.CanHitTarget = function(self, target)
		if target and target:HasTag("fragile") and self._mercinessfn and self._mercinessfn(self.inst, target) then
			return false
		end
		return pCanHitTarget(self, target)
	end
	local pCanBeAttacked = self.CanBeAttacked
	self.CanBeAttacked = function(self, attacker)
		if self.inst and attacker and attacker.replica.combat and self.inst:HasTag("fragile") and
				attacker.replica.combat._mercinessfn and attacker.replica.combat._mercinessfn(attacker, self.inst) then
			return false
		end
		return pCanBeAttacked(self, attacker)
	end
end)

-- 目前别无选择使用这种注入方式，待改进
AddClassPostConstruct("components/combat_replica", function(self)
	if self.inst and self.inst.prefab == characterName then
		self._canlordextfn = function(inst)
			local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			return weapon and weapon.prefab == "luoxiaohei_sword"
		end
		self._extaction = function(inst, target)
			local r = inst.replica.combat:GetAttackRangeWithWeapon()
			local ro = inst.replica.combat:GetAttackRangeWithWeapon(true)
			if inst.replica.combat:CanLordExtAttackC() and
					distsq(target:GetPosition(), inst:GetPosition()) <= r * r and
					distsq(target:GetPosition(), inst:GetPosition()) > ro * ro then
				return "throw"
			end
			return nil
		end
		self._mercinessfn = function(inst, target)	-- <智慧生物排除
			return target and target:IsValid() and not target:HasTag("INLIMBO") and target ~= inst and
			not target:HasTag("wall") and
			target.replica.combat and target.replica.health and
			(TUNING.LUOXIAOHEI_MERCY_ALL and true or target:HasTag("character"))
		end
	end
end)
--<