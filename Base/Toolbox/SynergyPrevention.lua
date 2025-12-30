-- Beltalowda Synergy Prevention
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
Beltalowda.toolbox.sp = Beltalowda.toolbox.sp or {}
local BeltalowdaSP = Beltalowda.toolbox.sp
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
Beltalowda.toolbox.so = Beltalowda.toolbox.so or {}
local BeltalowdaSO = Beltalowda.toolbox.so
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group

BeltalowdaSP.callbackName = Beltalowda.addonName .. "ToolboxSynergyPrevention"

BeltalowdaSP.constants = {}
BeltalowdaSP.constants.TLW = "Beltalowda.toolbox.sp.tlw"
BeltalowdaSP.constants.blacklist = {}
BeltalowdaSP.constants.MODE_BLOCK_ALL = 1
BeltalowdaSP.constants.MODE_BLOCK_IF_SYNERGY_ROLE = 2

BeltalowdaSP.constants.SYNERGY_ID = {}
BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD = 1
BeltalowdaSP.constants.SYNERGY_ID.TALONS = 2
BeltalowdaSP.constants.SYNERGY_ID.NOVA = 3
BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR = 4
BeltalowdaSP.constants.SYNERGY_ID.STANDARD = 5
BeltalowdaSP.constants.SYNERGY_ID.PURGE = 6
BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD = 7
BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT = 8
BeltalowdaSP.constants.SYNERGY_ID.ATRONACH = 9
BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS = 10
BeltalowdaSP.constants.SYNERGY_ID.RADIATE = 11
BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS = 12
BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH = 13
BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING = 14
BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER = 15
BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY = 16
BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE = 17
BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST = 18
BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL = 19
BeltalowdaSP.constants.SYNERGY_ID.URSUS = 20
BeltalowdaSP.constants.SYNERGY_ID.GRYPHON = 21
BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK = 22
BeltalowdaSP.constants.SYNERGY_ID.PASSAGE = 23

local BLACKLIST = {}

BeltalowdaSP.controls = {}

BeltalowdaSP.config = {}
BeltalowdaSP.config.width = 100
BeltalowdaSP.config.height = 35
BeltalowdaSP.config.isClampedToScreen = true
BeltalowdaSP.config.onColor = {}
BeltalowdaSP.config.onColor.r = 0
BeltalowdaSP.config.onColor.g = 1
BeltalowdaSP.config.onColor.b = 0
BeltalowdaSP.config.offColor = {}
BeltalowdaSP.config.offColor.r = 1
BeltalowdaSP.config.offColor.g = 0
BeltalowdaSP.config.offColor.b = 0
BeltalowdaSP.config.updateInterval = 100
BeltalowdaSP.config.defaultTexture = "/esoui/art/treeicons/gamepad/gp_tutorial_idexicon_synergy.dds"

BeltalowdaSP.state = {}
BeltalowdaSP.state.initialized = false
BeltalowdaSP.state.registredConsumers = false
BeltalowdaSP.state.foreground = true
BeltalowdaSP.state.activeLayerIndex = 1
BeltalowdaSP.state.registredActiveConsumers = false
BeltalowdaSP.state.synergyNameList = {}
BeltalowdaSP.state.blacklist = {}

local BLACKLIST = BeltalowdaSP.state.blacklist

local wm = WINDOW_MANAGER

function BeltalowdaSP.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaSP.callbackName, BeltalowdaSP.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_SP_TOGGLE", BeltalowdaSP.constants.KEYBINDING)
	BeltalowdaSP.InitializeSynergyStrings()
	BeltalowdaSP.CreateUI()
	BeltalowdaSP.CreateSynergyIdNameList()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaSP.SetSpPositionLocked)
	BeltalowdaSP.AdjustBlacklist()
	
	BeltalowdaSP.state.initialized = true
	BeltalowdaSP.SetEnabled(BeltalowdaSP.spVars.enabled, BeltalowdaSP.spVars.windowEnabled)
	BeltalowdaSP.SetPositionLocked(BeltalowdaSP.spVars.positionLocked)
end

function BeltalowdaSP.InitializeSynergyStrings()
	--/script local data = Beltalowda.toolbox.sp.constants for key, value in pairs(testVar) do if data[key] == testVar[key] then d(data[key] .. " - OK") else d(data[key] .. " - NOK => " .. testVar[key]) end end
	--[[
	testVar = {}
	testVar.SYNERGY_COMBUSTION = zo_strformat("<<1>>", GetAbilityName(3463)) -- 3463, 26319, 29424 .. 
	testVar.SYNERGY_HEALING_COMBUSTION = zo_strformat("<<1>>", GetAbilityName(63507)) -- 63507, 63511 .. 
	testVar.SYNERGY_SHARDS_BLESSED = zo_strformat("<<1>>", GetAbilityName(26832)) -- 26832, 94973 ..
	testVar.SYNERGY_SHARDS_HOLY = zo_strformat("<<1>>", GetAbilityName(95922)) -- 95922, 95925 .. 
	testVar.SYNERGY_BLOOD_FEAST = zo_strformat("<<1>>", GetAbilityName(41963)) -- 41963, 41964 .. 
	testVar.SYNERGY_BLOOD_FUNNEL = zo_strformat("<<1>>", GetAbilityName(39500)) -- 39500, 39501 ..
	testVar.SYNERGY_SUPERNOVA = zo_strformat("<<1>>", GetAbilityName(31538)) -- 31538, 31540
	testVar.SYNERGY_GRAVITY_CRUSH = zo_strformat("<<1>>", GetAbilityName(31603)) -- 31603, 31604 .. 
	testVar.SYNERGY_SHACKLE = zo_strformat("<<1>>", GetAbilityName(32905)) -- 32905, 32910 ..
	testVar.SYNERGY_PURIFY = zo_strformat("<<1>>", GetAbilityName(22260)) -- 22260, 22269 ..
	testVar.SYNERGY_BONE_WALL = zo_strformat("<<1>>", GetAbilityName(39377)) -- 39377, 39379 ..
	testVar.SYNERGY_SPINAL_SURGE = zo_strformat("<<1>>", GetAbilityName(42194)) -- 42194, 42195 ..
	testVar.SYNERGY_IGNITE = zo_strformat("<<1>>", GetAbilityName(10805)) -- 10805, 10809 ..
	testVar.SYNERGY_RADIATE = zo_strformat("<<1>>", GetAbilityName(41838)) -- 41838, 41839 .. 
	testVar.SYNERGY_CONDUIT = zo_strformat("<<1>>", GetAbilityName(23196)) -- 23196, 136046
	testVar.SYNERGY_SPAWN_BROODLINGS = zo_strformat("<<1>>", GetAbilityName(103218)) -- 39429, 39430 ..
	testVar.SYNERGY_BLACK_WIDOWS = zo_strformat("<<1>>", GetAbilityName(41994)) -- 41994, 41996
	testVar.SYNERGY_ARACHNOPHOBIA = zo_strformat("<<1>>", GetAbilityName(18111)) -- 18111, 18116 ..
	testVar.SYNERGY_HIDDEN_REFRESH = zo_strformat("<<1>>", GetAbilityName(37729)) -- 37729, 37730 ..
	testVar.SYNERGY_SOUL_LEECH = zo_strformat("<<1>>", GetAbilityName(25169)) -- 25169, 25170 ..
	testVar.SYNERGY_HARVEST = zo_strformat("<<1>>", GetAbilityName(85572)) -- 85572, 85576 ..
	testVar.SYNERGY_ATRONACH = zo_strformat("<<1>>", GetAbilityName(48076)) -- 48076, 102310, 102321 ..
	testVar.SYNERGY_GRAVE_ROBBER = zo_strformat("<<1>>", GetAbilityName(115548)) -- 115548, 115567 ..
	testVar.SYNERGY_PURE_AGONY = zo_strformat("<<1>>", GetAbilityName(118604)) -- 118604, 118606 ..
	testVar.SYNERGY_ICY_ESCAPE = zo_strformat("<<1>>", GetAbilityName(88884)) -- 88884, 110370 ...
	testVar.SYNERGY_SANGUINE_BURST = zo_strformat("<<1>>", GetAbilityName(141920)) -- 141920, 142305
	testVar.SYNERGY_HEED_THE_CALL = zo_strformat("<<1>>", GetAbilityName(142712)) -- 142712, 142775, 142780
	testVar.SYNERGY_URSUS = zo_strformat("<<1>>", GetAbilityName(111437)) -- 111437
	]]
	BeltalowdaSP.constants.SYNERGY_COMBUSTION = zo_strformat("<<1>>", GetAbilityName(3463))
	BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION = zo_strformat("<<1>>", GetAbilityName(63507)) 
	BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED = zo_strformat("<<1>>", GetAbilityName(26832))
	BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY = zo_strformat("<<1>>", GetAbilityName(95922))
	BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST = zo_strformat("<<1>>", GetAbilityName(41963)) 
	BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL = zo_strformat("<<1>>", GetAbilityName(39500))
	BeltalowdaSP.constants.SYNERGY_SUPERNOVA = zo_strformat("<<1>>", GetAbilityName(31538))
	BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH = zo_strformat("<<1>>", GetAbilityName(31603))
	BeltalowdaSP.constants.SYNERGY_SHACKLE = zo_strformat("<<1>>", GetAbilityName(32905))
	BeltalowdaSP.constants.SYNERGY_PURIFY = zo_strformat("<<1>>", GetAbilityName(22269))
	BeltalowdaSP.constants.SYNERGY_BONE_WALL = zo_strformat("<<1>>", GetAbilityName(39377))
	BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE = zo_strformat("<<1>>", GetAbilityName(42194))
	BeltalowdaSP.constants.SYNERGY_IGNITE = zo_strformat("<<1>>", GetAbilityName(10805))
	BeltalowdaSP.constants.SYNERGY_RADIATE = zo_strformat("<<1>>", GetAbilityName(41838))
	BeltalowdaSP.constants.SYNERGY_CONDUIT = zo_strformat("<<1>>", GetAbilityName(23196))
	BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS = zo_strformat("<<1>>", GetAbilityName(103218))
	BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS = zo_strformat("<<1>>", GetAbilityName(41994))
	BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA = zo_strformat("<<1>>", GetAbilityName(18111))
	BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH = zo_strformat("<<1>>", GetAbilityName(37729))
	BeltalowdaSP.constants.SYNERGY_SOUL_LEECH = zo_strformat("<<1>>", GetAbilityName(25169))
	BeltalowdaSP.constants.SYNERGY_HARVEST = zo_strformat("<<1>>", GetAbilityName(85572))
	BeltalowdaSP.constants.SYNERGY_ATRONACH = zo_strformat("<<1>>", GetAbilityName(48076))
	BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER = zo_strformat("<<1>>", GetAbilityName(115548))
	BeltalowdaSP.constants.SYNERGY_PURE_AGONY = zo_strformat("<<1>>", GetAbilityName(118604))
	BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE = zo_strformat("<<1>>", GetAbilityName(88884))
	BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST = zo_strformat("<<1>>", GetAbilityName(141920))
	BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL = zo_strformat("<<1>>", GetAbilityName(142712))
	BeltalowdaSP.constants.SYNERGY_URSUS = zo_strformat("<<1>>", GetAbilityName(111437))
	BeltalowdaSP.constants.SYNERGY_GRYPHON = zo_strformat("<<1>>", GetAbilityName(167041))
	BeltalowdaSP.constants.SYNERGY_RUNEBREAK = zo_strformat("<<1>>", GetAbilityName(191080))
	BeltalowdaSP.constants.SYNERGY_PASSAGE = zo_strformat("<<1>>", GetAbilityName(190399))
	
	
	
	
	--Passage sucks...
	BeltalowdaSP.constants.SYNERGY_PASSAGE = BeltalowdaSP.constants.SYNERGY_PASSAGE:gsub(" ",""):gsub("Between",""):gsub("Worlds",""):gsub("zwischen",""):gsub("Welten",""):gsub("entre",""):gsub("les",""):gsub("mondes","")
end

function BeltalowdaSP.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.windowEnabled = true
	defaults.positionLocked = true
	defaults.pvpOnly = true
	defaults.mode = BeltalowdaSP.constants.MODE_BLOCK_ALL
	defaults.maxDistance = 15
	defaults.blacklist = {}
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TALONS] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.NOVA] = true
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.STANDARD] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURGE] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.ATRONACH] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.RADIATE] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.URSUS] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.GRYPHON] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK] = false
	defaults.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PASSAGE] = false
	return defaults
end

function BeltalowdaSP.SetTlwLocation()
	if BeltalowdaSP.spVars.location == nil then
		BeltalowdaSP.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -250, -250)
	else
		BeltalowdaSP.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaSP.spVars.location.x, BeltalowdaSP.spVars.location.y)
	end
end

function BeltalowdaSP.CreateUI()
	BeltalowdaSP.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaSP.constants.TLW)
	
	
	BeltalowdaSP.SetTlwLocation()
		
	BeltalowdaSP.controls.TLW:SetClampedToScreen(BeltalowdaSP.config.isClampedToScreen)
	BeltalowdaSP.controls.TLW:SetHandler("OnMoveStop", BeltalowdaSP.SaveWindowLocation)
	BeltalowdaSP.controls.TLW:SetDimensions(BeltalowdaSP.config.width, BeltalowdaSP.config.height)
	
	BeltalowdaSP.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaSP.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaSP.controls.TLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaSP.config.width, BeltalowdaSP.config.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaSP.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaSP.config.width, BeltalowdaSP.config.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	local controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaSP.config.height - 8, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	rootControl.status = wm:CreateControl(nil, rootControl, CT_LABEL)
	rootControl.status:SetAnchor(TOPLEFT, rootControl, TOPLEFT, BeltalowdaSP.config.height, 0)
	rootControl.status:SetDimensions(BeltalowdaSP.config.width - BeltalowdaSP.config.height, BeltalowdaSP.config.height)
	rootControl.status:SetFont(controlFont)
	rootControl.status:SetWrapMode(ELLIPSIS)
	rootControl.status:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	rootControl.status:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	rootControl.texture = wm:CreateControl(nil, rootControl, CT_TEXTURE)
	rootControl.texture:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 1, 1)
	rootControl.texture:SetDimensions(BeltalowdaSP.config.height - 2, BeltalowdaSP.config.height - 2)
	rootControl.texture:SetTexture(BeltalowdaSP.config.defaultTexture)
end

function BeltalowdaSP.SetEnabled(enabled, windowEnabled)
	if BeltalowdaSP.state.initialized == true and enabled ~= nil and windowEnabled ~= nil then
		BeltalowdaSP.spVars.enabled = enabled
		BeltalowdaSP.spVars.windowEnabled = windowEnabled
		if enabled == true or windowEnabled == true then
			if BeltalowdaSP.state.registredConsumers == false then
				BeltalowdaUtilGroup.AddFeature(BeltalowdaSP.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaSP.config.updateInterval)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSP.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaSP.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSP.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaSP.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSP.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaSP.OnPlayerActivated)
			end
			BeltalowdaSP.state.registredConsumers = true
		else
			if BeltalowdaSP.state.registredConsumers == true then
				BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSP.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSP.callbackName, EVENT_ACTION_LAYER_POPPED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSP.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSP.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaSP.state.registredConsumers = false
			BeltalowdaSP.SetControlVisibility()
		end
		BeltalowdaSP.OnPlayerActivated()
		if enabled == true then
			BeltalowdaSP.controls.TLW.rootControl.status:SetText(BeltalowdaSP.constants.ON)
			BeltalowdaSP.controls.TLW.rootControl.status:SetColor(BeltalowdaSP.config.onColor.r, BeltalowdaSP.config.onColor.g, BeltalowdaSP.config.onColor.b, 1)
		else
			BeltalowdaSP.controls.TLW.rootControl.status:SetText(BeltalowdaSP.constants.OFF)
			BeltalowdaSP.controls.TLW.rootControl.status:SetColor(BeltalowdaSP.config.offColor.r, BeltalowdaSP.config.offColor.g, BeltalowdaSP.config.offColor.b, 1)
		end
	end
end


function BeltalowdaSP.SetPositionLocked(value)
	BeltalowdaSP.spVars.positionLocked = value
	
	BeltalowdaSP.controls.TLW:SetMovable(not value)
	BeltalowdaSP.controls.TLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaSP.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSP.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaSP.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSP.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaSP.SetControlVisibility()
	local enabled = BeltalowdaSP.spVars.windowEnabled
	local setHidden = true
	if enabled ~= nil and enabled == true and (BeltalowdaSP.spVars.pvpOnly == false or (BeltalowdaSP.spVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		setHidden = false
	end
	if setHidden == false then
		if BeltalowdaSP.state.foreground == false then
			BeltalowdaSP.controls.TLW:SetHidden(BeltalowdaSP.state.activeLayerIndex > 2)
		else
			BeltalowdaSP.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaSP.controls.TLW:SetHidden(setHidden)
	end
	--d(setHidden)
end


function BeltalowdaSP.CreateSynergyIdNameList()
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_COMBUSTION] = BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION] = BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED] = BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY] = BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST] = BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL] = BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SUPERNOVA] = BeltalowdaSP.constants.SYNERGY_ID.NOVA
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH] = BeltalowdaSP.constants.SYNERGY_ID.NOVA
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SHACKLE] = BeltalowdaSP.constants.SYNERGY_ID.STANDARD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_PURIFY] = BeltalowdaSP.constants.SYNERGY_ID.PURGE
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_BONE_WALL] = BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE] = BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_IGNITE] = BeltalowdaSP.constants.SYNERGY_ID.TALONS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_RADIATE] = BeltalowdaSP.constants.SYNERGY_ID.RADIATE
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_CONDUIT] = BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS] = BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS] = BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA] = BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH] = BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SOUL_LEECH] = BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_HARVEST] = BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_ATRONACH] = BeltalowdaSP.constants.SYNERGY_ID.ATRONACH
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER] = BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_PURE_AGONY] = BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE] = BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST] = BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL] = BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_URSUS] = BeltalowdaSP.constants.SYNERGY_ID.URSUS
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_GRYPHON] = BeltalowdaSP.constants.SYNERGY_ID.GRYPHON
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_RUNEBREAK] = BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK
	BeltalowdaSP.state.synergyNameList[BeltalowdaSP.constants.SYNERGY_PASSAGE] = BeltalowdaSP.constants.SYNERGY_ID.PASSAGE
end


function BeltalowdaSP.GetSynergyIdForName(synergyName)
	return BeltalowdaSP.state.synergyNameList[synergyName]
end

function BeltalowdaSP.IsSynergyFreeForUse(synergyName)
	--d(synergyName)
	local enabled = BeltalowdaSO.soVars.enabled
	--d(synergyName)
	if enabled ~= nil and enabled == true and (BeltalowdaSO.soVars.pvpOnly == false or (BeltalowdaSO.soVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BLACKLIST[synergyName] ~= true then
			--d("not blacklisted")
			return true
		else
			--d("---")
			--d("on blacklist")
			local synergyId = BeltalowdaSP.GetSynergyIdForName(synergyName)
			--d(synergyId)
			if synergyId ~= nil then
				--d("synergy known")
				if synergyId == BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE then
					return false
				end
				local freeForUse = true
				local players = BeltalowdaUtilGroup.GetGroupInformation()
				if players ~= nil then
					for i = 1, #players do
						local player = players[i]
						--d("checking player")
						if player.role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY and player.synergies[synergyId] == nil then
							--d("player found - synergy not in use")
							if player.isPlayer == false and player.distances ~= nil and player.distances.fromPlayer ~= nil and player.distances.fromPlayer <= BeltalowdaSP.spVars.maxDistance then
								freeForUse = false
							end
						end
					end
				end
				return freeForUse
			end
			return true
		end
	else
		return true
	end
end

function BeltalowdaSP.AdjustBlacklist()
	BeltalowdaSP.state.blacklist = {}
	BLACKLIST = BeltalowdaSP.state.blacklist
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_COMBUSTION] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TALONS] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_IGNITE] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.NOVA] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SUPERNOVA] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.STANDARD] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SHACKLE] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURGE] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_PURIFY] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_BONE_WALL] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_CONDUIT] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.ATRONACH] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_ATRONACH] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS] = true
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.RADIATE] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_RADIATE] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SOUL_LEECH] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_HARVEST] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_PURE_AGONY] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.URSUS] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_URSUS] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.GRYPHON] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_GRYPHON] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_RUNEBREAK] = true
	end
	if BeltalowdaSP.spVars.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PASSAGE] == true then
		BLACKLIST[BeltalowdaSP.constants.SYNERGY_PASSAGE] = true
	end
end

--callbacks
function BeltalowdaSP.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaSP.spVars = currentProfile.toolbox.sp
		if BeltalowdaSP.state.initialized == true then
			BeltalowdaSP.SetPositionLocked(BeltalowdaSP.spVars.positionLocked)
			BeltalowdaSP.SetControlVisibility()
			BeltalowdaSP.SetTlwLocation()
			BeltalowdaSP.AdjustBlacklist()
		end
	end
end

function BeltalowdaSP.SaveWindowLocation()
	if BeltalowdaSP.spVars.positionLocked == false then
		BeltalowdaSP.spVars.location = BeltalowdaSP.spVars.location or {}
		BeltalowdaSP.spVars.location.x = BeltalowdaSP.controls.TLW:GetLeft()
		BeltalowdaSP.spVars.location.y = BeltalowdaSP.controls.TLW:GetTop()
	end
end

--/script Beltalowda.util.AddConditionalPreHook("test", SYNERGY, "OnSynergyAbilityChanged", function() local name, _ = GetSynergyInfo() if name ~= nil then d(name) end return true end)
function BeltalowdaSP.OnPlayerActivated(eventCode, initial)
	if BeltalowdaSP.spVars.enabled == true and (BeltalowdaSP.spVars.pvpOnly == false or (BeltalowdaSP.spVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaSP.state.registredActiveConsumers == false then
			BeltalowdaUtil.AddConditionalPreHook(BeltalowdaSP.callbackName, SYNERGY, "OnSynergyAbilityChanged", BeltalowdaSP.OnSynergyAbilityChangedHook)
			BeltalowdaSP.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaSP.state.registredActiveConsumers == true then
			BeltalowdaUtil.RemoveConditionalPreHook(BeltalowdaSP.callbackName)
			BeltalowdaSP.state.registredActiveConsumers = false
		end
	end
	BeltalowdaSP.SetControlVisibility()
end

function BeltalowdaSP.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaSP.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaSP.state.foreground = false
	end
	--hack?
	BeltalowdaSP.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaSP.SetControlVisibility()
end

function BeltalowdaSP.OnKeyBinding()
	BeltalowdaSP.SetEnabled(not BeltalowdaSP.spVars.enabled, BeltalowdaSP.spVars.windowEnabled)
end

function BeltalowdaSP.OnSynergyAbilityChangedHook()
	--d("yay")
	local name, texture = GetSynergyInfo()
	name = zo_strformat("<<1>>", name)
	if texture ~= nil then
		BeltalowdaSP.controls.TLW.rootControl.texture:SetTexture(texture)
		--d(texture)
		--d(name)
	else
		BeltalowdaSP.controls.TLW.rootControl.texture:SetTexture(BeltalowdaSP.config.defaultTexture)
	end
	if name ~= nil and BeltalowdaSP.spVars.mode == BeltalowdaSP.constants.MODE_BLOCK_ALL and BLACKLIST[name] == true then
		return false
	elseif name ~= nil and BeltalowdaSP.spVars.mode == BeltalowdaSP.constants.MODE_BLOCK_IF_SYNERGY_ROLE and BeltalowdaSP.IsSynergyFreeForUse(name) == false then
		return false
	else
		return true
	end
end

--menu interaction
function BeltalowdaSP.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.SP_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_ENABLED,
					getFunc = BeltalowdaSP.GetSpEnabled,
					setFunc = BeltalowdaSP.SetSpEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_WINDOW_ENABLED,
					getFunc = BeltalowdaSP.GetSpWindowEnabled,
					setFunc = BeltalowdaSP.SetSpWindowEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_PVP_ONLY,
					getFunc = BeltalowdaSP.GetSpPvpOnly,
					setFunc = BeltalowdaSP.SetSpPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_POSITION_FIXED,
					getFunc = BeltalowdaSP.GetSpPositionLocked,
					setFunc = BeltalowdaSP.SetSpPositionLocked
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SP_MODE,
					choices = BeltalowdaSP.GetSpModes(),
					getFunc = BeltalowdaSP.GetSpMode,
					setFunc = BeltalowdaSP.SetSpMode
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SP_MAX_DISTANCE,
					min = 1,
					max = 50,
					step = 1,
					getFunc = BeltalowdaSP.GetSpMaxDistance,
					setFunc = BeltalowdaSP.SetSpMaxDistance,
					width = "full",
					default = 25
				},
				[7] = {
					type = "divider",
					width = "full"
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_COMBUSTION_SHARD,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD, value) end
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_TALONS,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.TALONS) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.TALONS, value) end
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_NOVA,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.NOVA) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.NOVA, value) end
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_BLOOD_ALTAR,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR, value) end
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_STANDARD,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.STANDARD) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.STANDARD, value) end
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_PURGE,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PURGE) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PURGE, value) end
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_BONE_SHIELD,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD, value) end
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_FLOOD_CONDUIT,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT, value) end
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_ATRONACH,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.ATRONACH) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.ATRONACH, value) end
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_TRAPPING_WEBS,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS, value) end
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_RADIATE,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.RADIATE) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.RADIATE, value) end
				},
				[19] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_CONSUMING_DARKNESS,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS, value) end
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_SOUL_LEECH,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH, value) end
				},
				[21] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_WARDEN_HEALING,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING, value) end
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_GRAVE_ROBBER,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER, value) end
				},
				[23] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_PURE_AGONY,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY, value) end
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_ICY_ESCAPE,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.ICY_ESCAPE, value) end
				},
				[25] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_SANGUINE_BURST,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.SANGUINE_BURST, value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_HEED_THE_CALL,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.HEED_THE_CALL, value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_URSUS,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.URSUS) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.URSUS, value) end
				},
				[27] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_GRYPHON,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.GRYPHON) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.GRYPHON, value) end
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_RUNEBREAK,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.RUNEBREAK, value) end
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SP_SYNERGY_PASSAGE,
					getFunc = function() return BeltalowdaSP.GetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PASSAGE) end,
					setFunc = function(value) return BeltalowdaSP.SetSpPreventSynergy(BeltalowdaSP.constants.SYNERGY_ID.PASSAGE, value) end
				},
			}
		}
	}
	return menu
end

function BeltalowdaSP.GetSpEnabled()
	return BeltalowdaSP.spVars.enabled
end

function BeltalowdaSP.SetSpEnabled(value)
	BeltalowdaSP.SetEnabled(value, BeltalowdaSP.spVars.windowEnabled)
end

function BeltalowdaSP.GetSpPositionLocked()
	return BeltalowdaSP.spVars.positionLocked
end

function BeltalowdaSP.SetSpPositionLocked(value)
	BeltalowdaSP.SetPositionLocked(value)
end

function BeltalowdaSP.GetSpPvpOnly()
	return BeltalowdaSP.spVars.pvpOnly
end

function BeltalowdaSP.SetSpPvpOnly(value)
	BeltalowdaSP.spVars.pvpOnly = value
	BeltalowdaSP.OnPlayerActivated()
end

function BeltalowdaSP.GetSpWindowEnabled()
	return BeltalowdaSP.spVars.windowEnabled
end

function BeltalowdaSP.SetSpWindowEnabled(value)
	BeltalowdaSP.SetEnabled(BeltalowdaSP.spVars.enabled, value)
end

function BeltalowdaSP.GetSpModes()
	return BeltalowdaSP.constants.MODES
end

function BeltalowdaSP.GetSpMode()
	return BeltalowdaSP.constants.MODES[BeltalowdaSP.spVars.mode]
end

function BeltalowdaSP.SetSpMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSP.constants.MODES do
			if BeltalowdaSP.constants.MODES[i] == value then
				BeltalowdaSP.spVars.mode = i
			end
		end
	end
end

function BeltalowdaSP.GetSpMaxDistance()
	return BeltalowdaSP.spVars.maxDistance
end

function BeltalowdaSP.SetSpMaxDistance(value)
	BeltalowdaSP.spVars.maxDistance = value
end

function BeltalowdaSP.GetSpPreventSynergy(index)
	return BeltalowdaSP.spVars.blacklist[index]
end

function BeltalowdaSP.SetSpPreventSynergy(index, value)
	BeltalowdaSP.spVars.blacklist[index] = value
	BeltalowdaSP.AdjustBlacklist()
end