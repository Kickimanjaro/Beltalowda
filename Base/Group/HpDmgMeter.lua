-- Beltalowda Hp Damage Meter
-- By @s0rdrak (PC / EU)

Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.hdm = BeltalowdaGroup.hdm or {}
local BeltalowdaHdm = BeltalowdaGroup.hdm
BeltalowdaGroup.dbo = BeltalowdaGroup.dbo or {}
local BeltalowdaDbo = BeltalowdaGroup.dbo
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem


BeltalowdaHdm.constants = BeltalowdaHdm.constants or {}
BeltalowdaHdm.constants.TLW_HPDMG_METER_NAME = "Beltalowda.group.hdm.hdm_TLW"
BeltalowdaHdm.constants.LABEL_VALUE_FORMAT = "%d (%.2f%%)"
BeltalowdaHdm.constants.LABEL_VALUE_FORMAT_2 = "%d (0%.2f%%)"

BeltalowdaHdm.constants.viewModes = {}
BeltalowdaHdm.constants.VIEWMODE_BOTH = 1
BeltalowdaHdm.constants.VIEWMODE_HEALING = 2
BeltalowdaHdm.constants.VIEWMODE_DAMAGE = 3
BeltalowdaHdm.constants.VIEWMODE_BOTH_ON_TOP = 4

BeltalowdaHdm.constants.size = {}
BeltalowdaHdm.constants.size.SMALL = 1
BeltalowdaHdm.constants.size.BIG = 2

BeltalowdaHdm.PREFIX = "HDM"

BeltalowdaHdm.callbackName = Beltalowda.addonName .. "HpDmgMeter"
BeltalowdaHdm.hpCallbackName = Beltalowda.addonName .. "HpDmgMeterHpSendLoop"
BeltalowdaHdm.dmgCallbackName = Beltalowda.addonName .. "HpDmgMeterDmgSendLoop"
BeltalowdaHdm.uiCallbackName = Beltalowda.addonName .. "HpDmgMeterUILoop"
BeltalowdaHdm.updateCallbackName = Beltalowda.addonName .. "HpDmgMeterMessageUpdateLoop"

BeltalowdaHdm.controls = {}

BeltalowdaHdm.config = {}
BeltalowdaHdm.config.isClampedToScreen = true
BeltalowdaHdm.config.sizes = {}
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL] = {}
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width = 500
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height = 450
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing = 30
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].fontSize = 15
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG] = {}
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].width = 750
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].height = 720
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].spacing = 60
BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].fontSize = 24
BeltalowdaHdm.config.invalidUpdateInterval = 100 --This value shouldn't be used by Group.lua. Yet in case of a bug or later changes, this value is defined
BeltalowdaHdm.config.buffUpdateInterval = 100
--BeltalowdaHdm.config.titleFont = "$(BOLD_FONT)|$(KB_20)soft-shadow-thick"
BeltalowdaHdm.config.titleFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, 20, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
BeltalowdaHdm.config.backgroundEven = 0.4
BeltalowdaHdm.config.backgroundOdd = 0.2

BeltalowdaHdm.state = {}
BeltalowdaHdm.state.initialized = false
BeltalowdaHdm.state.registredConsumers = false
BeltalowdaHdm.state.registredGroupConsumer = false
BeltalowdaHdm.state.foreground = true
BeltalowdaHdm.state.registredActiveConsumers = false
BeltalowdaHdm.state.activeLayerIndex = 1

BeltalowdaHdm.state.meter = {}
BeltalowdaHdm.state.meter.damage = 0
BeltalowdaHdm.state.meter.healing = 0
BeltalowdaHdm.state.meter.lastDamageMessage = nil
BeltalowdaHdm.state.meter.lastHpMessage = nil

BeltalowdaHdm.state.delayedLoopStarting = false
BeltalowdaHdm.state.delayedLoopStarted = false
BeltalowdaHdm.state.hpDmgUpdateInterval = 3000 --5000 previously
BeltalowdaHdm.state.delayInterval = 1000
BeltalowdaHdm.state.delayCount = 0

BeltalowdaHdm.state.uiUpdateInterval = 500
BeltalowdaHdm.state.messageUpdateInterval = 100

local wm = WINDOW_MANAGER

function BeltalowdaHdm.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaHdm.callbackName, BeltalowdaHdm.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_HDM_RESET_METER", BeltalowdaHdm.constants.RESET_COUNTER)
	
	BeltalowdaHdm.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaHdm.SetHdmPositionLocked)
	BeltalowdaHdm.AdjustAutoClearEnabled()
	
	BeltalowdaHdm.state.initialized = true
	BeltalowdaHdm.SetEnabled(BeltalowdaHdm.hdmVars.enabled)
end

function BeltalowdaHdm.SetTlwLocation()
	BeltalowdaHdm.controls.hdmTLW:ClearAnchors()
	if BeltalowdaHdm.hdmVars.location == nil then
		BeltalowdaHdm.controls.hdmTLW:SetAnchor(CENTER, GuiRoot, CENTER, 250, -150)
	else
		BeltalowdaHdm.controls.hdmTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaHdm.hdmVars.location.x, BeltalowdaHdm.hdmVars.location.y)
	end
end

function BeltalowdaHdm.CreateUI()
	BeltalowdaHdm.controls.hdmTLW = wm:CreateTopLevelWindow(BeltalowdaHdm.constants.TLW_HPDMG_METER_NAME)
	
	BeltalowdaHdm.SetTlwLocation()
		
	BeltalowdaHdm.controls.hdmTLW:SetClampedToScreen(BeltalowdaHdm.config.isClampedToScreen)
	BeltalowdaHdm.controls.hdmTLW:SetDrawLayer(0)
	BeltalowdaHdm.controls.hdmTLW:SetDrawLevel(0)
	BeltalowdaHdm.controls.hdmTLW:SetHandler("OnMoveStop", BeltalowdaHdm.SaveHdmWindowLocation)
	BeltalowdaHdm.controls.hdmTLW:SetDimensions(BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width + BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height)
	
	BeltalowdaHdm.controls.hdmTLW.rootControl = wm:CreateControl(nil, BeltalowdaHdm.controls.hdmTLW, CT_CONTROL)
	local rootControl = BeltalowdaHdm.controls.hdmTLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width + BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaHdm.controls.hdmTLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width + BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	
	rootControl.damageControl = BeltalowdaHdm.CreateUserControl(rootControl, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width / 2, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height, 0, BeltalowdaHdm.constants.TITLE_DAMAGE)
	rootControl.healingControl = BeltalowdaHdm.CreateUserControl(rootControl, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width / 2, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width / 2 + BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing, BeltalowdaHdm.constants.TITLE_HEALING)
	
	BeltalowdaHdm.SetPositionLocked(BeltalowdaHdm.hdmVars.positionLocked)
	BeltalowdaHdm.AdjustControlSize()
	BeltalowdaHdm.SetControlVisibility()
end

function BeltalowdaHdm.CreateUserControl(parent, controlWidth, controlHeight, widthOffset, text)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(controlWidth, controlHeight)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, widthOffset, 0)
	local width = controlWidth
	local height = math.floor((controlHeight - 30) / 24)
	control.title = wm:CreateControl(nil, control, CT_LABEL)
	control.title:SetDimensions(width, 20)
	control.title:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.title:SetFont(BeltalowdaHdm.config.titleFont)
	control.title:SetText(text)
	control.title:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	control.title:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	local playerFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	control.playerBlocks = {}
	for i = 1, 24 do
		control.playerBlocks[i] = {}
		control.playerBlocks[i].nameBackdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.playerBlocks[i].nameBackdrop:SetDimensions(width / 2, height)
		control.playerBlocks[i].nameBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 30 + (i - 1) * height)
		control.playerBlocks[i].nameBackdrop:SetCenterColor(0, 0, 0, 0.0)
		control.playerBlocks[i].nameBackdrop:SetEdgeColor(0, 0, 0, 0.0)
		
		control.playerBlocks[i].name = wm:CreateControl(nil, control, CT_LABEL)
		control.playerBlocks[i].name:SetDimensions(width / 2, height)
		control.playerBlocks[i].name:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 30 + (i - 1) * height)
		control.playerBlocks[i].name:SetFont(playerFont)
		control.playerBlocks[i].name:SetText("")
		control.playerBlocks[i].name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		
		control.playerBlocks[i].valueBackdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.playerBlocks[i].valueBackdrop:SetDimensions(width / 2, height)
		control.playerBlocks[i].valueBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, width / 2, 30 + (i - 1) * height)
		control.playerBlocks[i].valueBackdrop:SetCenterColor(0, 0, 0, 0.0)
		control.playerBlocks[i].valueBackdrop:SetEdgeColor(0, 0, 0, 0.0)
		
		control.playerBlocks[i].value = wm:CreateControl(nil, control, CT_LABEL)
		control.playerBlocks[i].value:SetDimensions(width / 2, height)
		control.playerBlocks[i].value:SetAnchor(TOPLEFT, control, TOPLEFT, width / 2, 30 + (i - 1) * height)
		control.playerBlocks[i].value:SetFont(playerFont)
		control.playerBlocks[i].value:SetText("")
		control.playerBlocks[i].value:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.playerBlocks[i].value:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
	end
	return control
end

function BeltalowdaHdm.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.positionLocked = true
	defaults.pvpOnly = true
	defaults.windowEnabled = false
	defaults.aliveColor = {}
	defaults.aliveColor.r = 1
	defaults.aliveColor.g = 1
	defaults.aliveColor.b = 1
	defaults.deadColor = {}
	defaults.deadColor.r = 1
	defaults.deadColor.g = 0
	defaults.deadColor.b = 0
	defaults.backgroundColor = {}
	defaults.backgroundColor.healer = {}
	defaults.backgroundColor.healer.r = 0.2
	defaults.backgroundColor.healer.g = 0.2
	defaults.backgroundColor.healer.b = 0.76
	defaults.backgroundColor.dd = {}
	defaults.backgroundColor.dd.r = 0.76
	defaults.backgroundColor.dd.g = 0.2
	defaults.backgroundColor.dd.b = 0.2
	defaults.backgroundColor.tank = {}
	defaults.backgroundColor.tank.r = 0.3
	defaults.backgroundColor.tank.g = 0.3
	defaults.backgroundColor.tank.b = 0.3
	defaults.backgroundColor.applicant = {}
	defaults.backgroundColor.applicant.r = 0.05
	defaults.backgroundColor.applicant.g = 0.1
	defaults.backgroundColor.applicant.b = 1.0
	defaults.viewMode = BeltalowdaHdm.constants.VIEWMODE_BOTH
	defaults.size = BeltalowdaHdm.constants.size.SMALL
	
	defaults.autoClear = true
	defaults.useAlpha = true
	defaults.useColors = true
	defaults.highlightApplicant = true
	
	return defaults
end

--[[
function BeltalowdaHdm.SetEnabled(value)
	if BeltalowdaHdm.state.initialized == true and value ~= nil then
		BeltalowdaHdm.hdmVars.enabled = value
		if value == true then
			if BeltalowdaHdm.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaHdm.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaHdm.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaHdm.OnPlayerActivated)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_COMBAT_EVENT, BeltalowdaHdm.OnCombatEvent)
				BeltalowdaUtilGroup.AddFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_HP_DMG, BeltalowdaHdm.config.invalidUpdateInterval)
				BeltalowdaUtilGroup.AddFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaHdm.config.buffUpdateInterval)
				--BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaHdm.callbackName, BeltalowdaHdm.HandleRawNetworkMessage)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.hpCallbackName, BeltalowdaHdm.state.hpDmgUpdateInterval, BeltalowdaHdm.HpUpdateLoop)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.uiCallbackName, BeltalowdaHdm.state.uiUpdateInterval, BeltalowdaHdm.UiLoop)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.updateCallbackName, BeltalowdaHdm.state.messageUpdateInterval, BeltalowdaHdm.MessageUpdateLoop)
			end
			if BeltalowdaHdm.state.delayedLoopStarted == false and BeltalowdaHdm.state.delayedLoopStarting == false then
				BeltalowdaHdm.state.delayedLoopStarting = true
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.callbackName, BeltalowdaHdm.state.delayInterval, BeltalowdaHdm.StartDmgLoop)
			end
			BeltalowdaHdm.state.registredConsumers = true
		else
			if BeltalowdaHdm.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_POPPED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_PLAYER_ACTIVATED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_COMBAT_EVENT)
				BeltalowdaUtilGroup.RemoveFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_HP_DMG)
				BeltalowdaUtilGroup.RemoveFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
				--BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaHdm.callbackName)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.hpCallbackName)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.uiCallbackName)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.updateCallbackName)
			end
			if BeltalowdaHdm.state.delayedLoopStarted == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.dmgCallbackName)
			end
			if BeltalowdaHdm.state.delayedLoopStarting == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.callbackName)
				BeltalowdaHdm.state.delayedLoopStarting = false
			end
			BeltalowdaHdm.state.registredConsumers = false
		end
		BeltalowdaHdm.SetControlVisibility()
	end
end
]]

function BeltalowdaHdm.SetEnabled(value)
	if BeltalowdaHdm.state.initialized == true and value ~= nil then
		BeltalowdaHdm.hdmVars.enabled = value
		if value == true then
			if BeltalowdaHdm.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaHdm.OnPlayerActivated)
				
			end
			BeltalowdaHdm.state.registredConsumers = true
		else
			if BeltalowdaHdm.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaHdm.state.registredConsumers = false
		end
		BeltalowdaHdm.OnPlayerActivated()
	end
end

function BeltalowdaHdm.SetPositionLocked(value)
	BeltalowdaHdm.hdmVars.positionLocked = value
	BeltalowdaHdm.controls.hdmTLW:SetMovable(not value)
	BeltalowdaHdm.controls.hdmTLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaHdm.controls.hdmTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaHdm.controls.hdmTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaHdm.controls.hdmTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaHdm.controls.hdmTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaHdm.SetControlVisibility()
	local enabled = BeltalowdaHdm.hdmVars.enabled
	local windowEnabled = BeltalowdaHdm.hdmVars.windowEnabled
	local pvpOnly = BeltalowdaHdm.hdmVars.pvpOnly
	local setHidden = true
	if enabled ~= nil and windowEnabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			if windowEnabled == true then
				setHidden = false
			end
		end
	end
	if setHidden == false then
		if BeltalowdaHdm.state.foreground == false then
			BeltalowdaHdm.controls.hdmTLW:SetHidden(BeltalowdaHdm.state.activeLayerIndex > 2)
		else
			BeltalowdaHdm.controls.hdmTLW:SetHidden(false)
		end
	else
		BeltalowdaHdm.controls.hdmTLW:SetHidden(setHidden)
	end
end

function BeltalowdaHdm.CopyPlayersIncludingTotals(oldPlayers, stat)
	local players = {}
	local total = 0
	if players ~= nil then
		for i = 1, #oldPlayers do
			players[i] = oldPlayers[i]
			if oldPlayers[i].meter ~= nil and oldPlayers[i].meter[stat] ~= nil then
				total = total + oldPlayers[i].meter[stat]
			end
		end
	end
	return players, total
end

function BeltalowdaHdm.ComparePlayers(playerA, playerB, stat)
	--d(playerA.meter)
	--d(playerB.meter)
	--d(stat)
	--d("----")
	if playerA.meter == nil or playerA.meter[stat] == nil or
	   playerB.meter == nil or playerB.meter[stat] == nil then
	
		if (playerA.meter == nil or playerA.meter[stat] == nil) and 
		   (playerB.meter ~= nil and playerB.meter[stat] ~= nil) then
			return false
		elseif (playerA.meter ~= nil and playerA.meter[stat] ~= nil) and 
		   (playerB.meter == nil or playerB.meter[stat] == nil) then
			return true
		else
			return playerA.charName < playerB.charName
		end
		
	end
	
	if playerA.meter[stat] < playerB.meter[stat] then
		return false
	elseif playerA.meter[stat] > playerB.meter[stat] then
		return true
	else
		return playerA.charName < playerB.charName
	end
end

function BeltalowdaHdm.ComparePlayersByDamage(playerA, playerB)
	return BeltalowdaHdm.ComparePlayers(playerA, playerB, "damage")
end

function BeltalowdaHdm.ComparePlayersByHealing(playerA, playerB)
	return BeltalowdaHdm.ComparePlayers(playerA, playerB, "healing")
end

function BeltalowdaHdm.AdjustControlSize()
	BeltalowdaHdm.AdjustViewMode()
	local sizeIncrease = BeltalowdaHdm.hdmVars.size - BeltalowdaHdm.constants.size.SMALL
	local width = (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].width - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width) * sizeIncrease) / 2
	--local width = BeltalowdaHdm.config.sizes[BeltalowdaHdm.hdmVars.size].width / 2
	local height = math.floor(((BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].height - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height) * sizeIncrease) - 30) / 24)
	local playerFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].fontSize + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].fontSize - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].fontSize) * sizeIncrease), BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local rootControl = BeltalowdaHdm.controls.hdmTLW.rootControl
	local controls = {rootControl.healingControl, rootControl.damageControl}
	for j = 1, #controls do
		local control = controls[j]
		control.title:SetDimensions(width, 20)
		for i = 1, 24 do
			control.playerBlocks[i].nameBackdrop:SetDimensions(width / 2, height)
			control.playerBlocks[i].nameBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 30 + (i - 1) * height)
			
			control.playerBlocks[i].name:SetDimensions(width / 2, height)
			control.playerBlocks[i].name:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 30 + (i - 1) * height)
			control.playerBlocks[i].name:SetFont(playerFont)

			control.playerBlocks[i].valueBackdrop:SetDimensions(width / 2, height)
			control.playerBlocks[i].valueBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, width / 2, 30 + (i - 1) * height)

			control.playerBlocks[i].value:SetDimensions(width / 2, height)
			control.playerBlocks[i].value:SetAnchor(TOPLEFT, control, TOPLEFT, width / 2, 30 + (i - 1) * height)
			control.playerBlocks[i].value:SetFont(playerFont)
		end
	end
end

function BeltalowdaHdm.GetCurrentSingleControlHeight(players)
	local sizeIncrease = BeltalowdaHdm.hdmVars.size - BeltalowdaHdm.constants.size.SMALL
	local height = (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].height - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height) * sizeIncrease)
	if players ~= nil then
		height = 30 + math.floor(((BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].height - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height) * sizeIncrease) - 30) / 24) * #players
	end
	return height
end

function BeltalowdaHdm.AdjustViewMode()
	local rootControl = BeltalowdaHdm.controls.hdmTLW.rootControl
	local sizeIncrease = BeltalowdaHdm.hdmVars.size - BeltalowdaHdm.constants.size.SMALL
	local width = (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].width - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].width) * sizeIncrease)
	local height = (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].height - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].height) * sizeIncrease)
	local spacing = (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing + (BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.BIG].spacing - BeltalowdaHdm.config.sizes[BeltalowdaHdm.constants.size.SMALL].spacing) * sizeIncrease)
	if BeltalowdaHdm.hdmVars.viewMode == BeltalowdaHdm.constants.VIEWMODE_BOTH then
		BeltalowdaHdm.controls.hdmTLW:SetDimensions(width + spacing, height)
		rootControl:SetDimensions(width, height)
		rootControl.movableBackdrop:SetDimensions(width + spacing, height)
		rootControl.damageControl:ClearAnchors()
		rootControl.damageControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
		rootControl.damageControl:SetHidden(false)
		rootControl.healingControl:ClearAnchors()
		rootControl.healingControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, width / 2 + spacing, 0)
		rootControl.healingControl:SetHidden(false)
		if BeltalowdaHdm.state.registredGroupConsumer == true then
			BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaHdm.callbackName)
			BeltalowdaHdm.state.registredGroupConsumer = false
		end
	elseif BeltalowdaHdm.hdmVars.viewMode == BeltalowdaHdm.constants.VIEWMODE_BOTH_ON_TOP then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		height = BeltalowdaHdm.GetCurrentSingleControlHeight(players)
		BeltalowdaHdm.controls.hdmTLW:SetDimensions(width / 2, height * 2 + spacing)
		rootControl:SetDimensions(width / 2, height * 2 + spacing)
		rootControl.movableBackdrop:SetDimensions(width / 2, height * 2 + spacing)
		rootControl.damageControl:ClearAnchors()
		rootControl.damageControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
		rootControl.damageControl:SetHidden(false)
		rootControl.healingControl:ClearAnchors()
		rootControl.healingControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, height + spacing)
		rootControl.healingControl:SetHidden(false)
		if BeltalowdaHdm.state.registredGroupConsumer == false then
			BeltalowdaUtilGroup.AddGroupChangedCallback(BeltalowdaHdm.callbackName, BeltalowdaHdm.AdjustViewMode)
			BeltalowdaHdm.state.registredGroupConsumer = true
		end
	else
		BeltalowdaHdm.controls.hdmTLW:SetDimensions(width / 2, height)
		rootControl:SetDimensions(width / 2, height)
		rootControl.movableBackdrop:SetDimensions(width / 2, height)
		rootControl.damageControl:SetHidden(true)
		rootControl.damageControl:ClearAnchors()
		rootControl.damageControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
		rootControl.healingControl:SetHidden(true)
		rootControl.healingControl:ClearAnchors()
		rootControl.healingControl:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
		if BeltalowdaHdm.hdmVars.viewMode == BeltalowdaHdm.constants.VIEWMODE_HEALING then
			rootControl.healingControl:SetHidden(false)
		elseif BeltalowdaHdm.hdmVars.viewMode == BeltalowdaHdm.constants.VIEWMODE_DAMAGE then
			rootControl.damageControl:SetHidden(false)
		end
		if BeltalowdaHdm.state.registredGroupConsumer == true then
			BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaHdm.callbackName)
			BeltalowdaHdm.state.registredGroupConsumer = false
		end
	end
end

function BeltalowdaHdm.GetPlayerDebuffs()
	return BeltalowdaDbo.GetPlayerDebuffs()
end

function BeltalowdaHdm.AdjustAutoClearEnabled()
	BeltalowdaUtilGroup.SetHdmAutoClearEnabled(BeltalowdaHdm.hdmVars.autoClear)
end

function BeltalowdaGroup.hdm.SlashCmd(param)
	--d(param)
	if #param == 2 then
		if param[2] == "clear" then
			BeltalowdaHdm.OnKeyBinding()
			return
		end
	end
	BeltalowdaChat.SendChatMessage(Beltalowda.config.constants.CMD_TEXT_MENU, BeltalowdaHdm.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL)
end

function BeltalowdaHdm.RegisterSpecificCombatEvent(name, sourceType, targetType, resultType, callback)
	EVENT_MANAGER:RegisterForEvent(name, EVENT_COMBAT_EVENT, callback)
	--[[
	if targetType ~= nil then
		EVENT_MANAGER:AddFilterForEvent(name, EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, targetType)
	end
	EVENT_MANAGER:AddFilterForEvent(name, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, sourceType)
	EVENT_MANAGER:AddFilterForEvent(name, EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, resultType)
	]]
	
	if targetType ~= nil then
		EVENT_MANAGER:AddFilterForEvent(name, EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, targetType, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, sourceType, REGISTER_FILTER_COMBAT_RESULT, resultType)
	else
		EVENT_MANAGER:AddFilterForEvent(name, EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, sourceType, REGISTER_FILTER_COMBAT_RESULT, resultType)
	end
	
end

function BeltalowdaHdm.RegisterCombatEvents()
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "1"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "2"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_CRITICAL_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "3"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_DOT_TICK, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "4"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_DOT_TICK_CRITICAL, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "5"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_DAMAGE_SHIELDED, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "6"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_BLOCKED_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "7"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "8"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_CRITICAL_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "9"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_DOT_TICK, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "10"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_DOT_TICK_CRITICAL, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "11"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_DAMAGE_SHIELDED, BeltalowdaHdm.OnCombatEventDamage)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "12"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_BLOCKED_DAMAGE, BeltalowdaHdm.OnCombatEventDamage)
	
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "13"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_HEAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "14"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_CRITICAL_HEAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "15"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_HOT_TICK, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "16"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_HOT_TICK_CRITICAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "17"), COMBAT_UNIT_TYPE_PLAYER, nil, ACTION_RESULT_HEAL_ABSORBED, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "18"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_HEAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "19"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_CRITICAL_HEAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "20"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_HOT_TICK, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "21"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_HOT_TICK_CRITICAL, BeltalowdaHdm.OnCombatEventHealing)
	BeltalowdaHdm.RegisterSpecificCombatEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "22"), COMBAT_UNIT_TYPE_PLAYER_PET, nil, ACTION_RESULT_HEAL_ABSORBED, BeltalowdaHdm.OnCombatEventHealing)
end

function BeltalowdaHdm.UnregisterCombatEvents()
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "1"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "2"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "3"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "4"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "5"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "6"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "7"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "8"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "9"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "10"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "11"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "12"), EVENT_COMBAT_EVENT)
	
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "13"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "14"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "15"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "16"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "17"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "18"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "19"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "20"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "21"), EVENT_COMBAT_EVENT)
	EVENT_MANAGER:UnregisterForEvent(string.format("%s.%s", BeltalowdaHdm.callbackName, "22"), EVENT_COMBAT_EVENT)
end

--callbacks
function BeltalowdaHdm.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaHdm.hdmVars = currentProfile.group.hdm
		if BeltalowdaHdm.state.initialized == true then
			BeltalowdaHdm.SetControlVisibility()
			BeltalowdaHdm.SetPositionLocked(BeltalowdaHdm.hdmVars.positionLocked)
			BeltalowdaHdm.SetTlwLocation()
			BeltalowdaHdm.AdjustControlSize()
			BeltalowdaHdm.AdjustAutoClearEnabled()
		end
		BeltalowdaHdm.SetEnabled(BeltalowdaHdm.hdmVars.enabled)
		
	end
end

function BeltalowdaHdm.SaveHdmWindowLocation()
	if BeltalowdaHdm.hdmVars.positionLocked == false then
		BeltalowdaHdm.hdmVars.location = BeltalowdaHdm.hdmVars.location or {}
		BeltalowdaHdm.hdmVars.location.x = BeltalowdaHdm.controls.hdmTLW:GetLeft()
		BeltalowdaHdm.hdmVars.location.y = BeltalowdaHdm.controls.hdmTLW:GetTop()
	end
end

function BeltalowdaHdm.OnPlayerActivated(eventCode, initial)
	if BeltalowdaHdm.hdmVars.enabled == true and (BeltalowdaHdm.hdmVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaHdm.hdmVars.pvpOnly == false) then
		--d("register")
		if BeltalowdaHdm.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaHdm.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaHdm.SetForegroundVisibility)
			
			BeltalowdaHdm.RegisterCombatEvents()
			--EVENT_MANAGER:RegisterForEvent(BeltalowdaHdm.callbackName, EVENT_COMBAT_EVENT, BeltalowdaHdm.OnCombatEvent)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_HP_DMG, BeltalowdaHdm.config.invalidUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaHdm.config.buffUpdateInterval)
			--BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaHdm.callbackName, BeltalowdaHdm.HandleRawNetworkMessage)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.hpCallbackName, BeltalowdaHdm.state.hpDmgUpdateInterval, BeltalowdaHdm.HpUpdateLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.uiCallbackName, BeltalowdaHdm.state.uiUpdateInterval, BeltalowdaHdm.UiLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.updateCallbackName, BeltalowdaHdm.state.messageUpdateInterval, BeltalowdaHdm.MessageUpdateLoop)
			
			BeltalowdaHdm.state.registredActiveConsumers = true
		end
		if BeltalowdaHdm.state.delayedLoopStarted == false and BeltalowdaHdm.state.delayedLoopStarting == false then
			BeltalowdaHdm.state.delayedLoopStarting = true
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.callbackName, BeltalowdaHdm.state.delayInterval, BeltalowdaHdm.StartDmgLoop)
		end
	else
		--d("unregister")
		if BeltalowdaHdm.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_ACTION_LAYER_PUSHED)
			
			BeltalowdaHdm.UnregisterCombatEvents()
			--EVENT_MANAGER:UnregisterForEvent(BeltalowdaHdm.callbackName, EVENT_COMBAT_EVENT)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_HP_DMG)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaHdm.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			--BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaHdm.callbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.hpCallbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.uiCallbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.updateCallbackName)
			
			BeltalowdaHdm.state.registredActiveConsumers = false
		end
		if BeltalowdaHdm.state.delayedLoopStarting == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.callbackName)
			BeltalowdaHdm.state.delayedLoopStarting = false
		end
	end
	BeltalowdaHdm.SetControlVisibility()
end

function BeltalowdaHdm.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaHdm.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaHdm.state.foreground = false
	end
	--hack?
	BeltalowdaHdm.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaHdm.SetControlVisibility()
end

function BeltalowdaHdm.OnCombatEventHealing(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, bLog, sourceUnitId, targetUnitId, abilityId)
	--d("----------------")
	--d("healing")
	--d(sourceType)
	--d(targetType)
	--d(result)
	if sourceName ~= targetName and hitValue > 0 then
		local unit = BeltalowdaUtilGroup.GetUnitFromRawCharName(targetName)
		if unit ~= nil then
			BeltalowdaHdm.state.meter.healing = BeltalowdaHdm.state.meter.healing + hitValue
			--d("----------------")
			--d("new: " .. sourceType)
			--d("new: " .. targetType)
			--d("new: " .. result)
		end
	end
end

function BeltalowdaHdm.OnCombatEventDamage(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, bLog, sourceUnitId, targetUnitId, abilityId)
	--d("----------------")
	--d("damage")
	--d("new: " .. sourceType)
	--d("new: " .. targetType)
	--d("new: " .. result)
	if targetType == COMBAT_UNIT_TYPE_OTHER and sourceName ~= targetName and hitValue > 0 then
		--d("----------------")
		--d("damage")
		--d("new: " .. sourceType)
		--d("new: " .. targetType)
		--d("new: " .. result)
		BeltalowdaHdm.state.meter.damage = BeltalowdaHdm.state.meter.damage + hitValue
	end
end

function BeltalowdaHdm.OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, bLog, sourceUnitId, targetUnitId, abilityId)
	if eventCode == EVENT_COMBAT_EVENT then
		--d(targetName)
		if sourceType == COMBAT_UNIT_TYPE_PLAYER or sourceType == COMBAT_UNIT_TYPE_PLAYER_PET then
			--Damage dealt
			--d("----")
			--d(result)
			--d(hitValue)
			if targetType == COMBAT_UNIT_TYPE_OTHER  
			and (result == ACTION_RESULT_DAMAGE or result == ACTION_RESULT_CRITICAL_DAMAGE 
			or   result == ACTION_RESULT_DOT_TICK or result == ACTION_RESULT_DOT_TICK_CRITICAL
			or   result == ACTION_RESULT_DAMAGE_SHIELDED or result == ACTION_RESULT_BLOCKED_DAMAGE
			) and sourceName ~= targetName and hitValue > 0 then
				--and targetType == COMBAT_UNIT_TYPE_PLAYER
				BeltalowdaHdm.state.meter.damage = BeltalowdaHdm.state.meter.damage + hitValue
				--d("----------------")
				--d("old: " .. sourceType)
				--d("old: " .. targetType)
				--d("old: " .. result)
				--d("old: " .. hitValue)
			end
			
			--Healing caused
			if (result == ACTION_RESULT_HEAL or result == ACTION_RESULT_CRITICAL_HEAL or result == ACTION_RESULT_HOT_TICK or result == ACTION_RESULT_HOT_TICK_CRITICAL or result == ACTION_RESULT_HEAL_ABSORBED) and
			   sourceName ~= targetName and hitValue > 0 then
			   --d("hv2: " .. hitValue)
				--d(targetName)
				local unit = BeltalowdaUtilGroup.GetUnitFromRawCharName(targetName)
				--d(unitTag)
				if unit ~= nil then
					local current, maximum, effectiveMax = GetUnitPower(unit.unitTag, POWERTYPE_HEALTH)
					--d("vals: " .. current .. ", " .. maximum .. ", " .. effectiveMax)
					--if unit.unitTag == "group3" then
					--	d("combat health: " .. unit.lastKnownHealth)
					--	d("combat hit: " .. hitValue)
					--end
					--if unit.lastKnownHealth ~= maximum and unit.lastKnownHealth ~= current then
					-- yes right, fuck ZOS and their API changes. Fucking working around their bugs fixing things and they break it by fixing it.
					-- getting zos'ed all day long
					--	current = unit.lastKnownHealth
					--	local dif = maximum - current
					--	if hitValue < dif then
					--		dif = hitValue
					--	end
						--d(dif)
						BeltalowdaHdm.state.meter.healing = BeltalowdaHdm.state.meter.healing + hitValue
					--end
					--d("----------------")
					--d("old: " .. sourceType)
					--d("old: " .. targetType)
					--d("old: " .. result)
					--d("old: " .. hitValue)
				end
			end
		end
	end
end

function BeltalowdaHdm.StartDmgLoop()
	if BeltalowdaHdm.state.delayCount == 1 then
		BeltalowdaHdm.state.delayedLoopStarting = false
		BeltalowdaHdm.state.delayedLoopStarted = true
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaHdm.callbackName)
		EVENT_MANAGER:RegisterForUpdate(BeltalowdaHdm.dmgCallbackName, BeltalowdaHdm.state.hpDmgUpdateInterval, BeltalowdaHdm.DmgUpdateLoop)
	else
		BeltalowdaHdm.state.delayCount = BeltalowdaHdm.state.delayCount + 1
	end
end

function BeltalowdaHdm.MessageUpdateLoop()
	if BeltalowdaHdm.hdmVars.pvpOnly == false or (BeltalowdaHdm.hdmVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		if BeltalowdaHdm.state.meter.lastDamageMessage ~= nil and BeltalowdaHdm.state.meter.lastDamageMessage.sent == false then
			local message = BeltalowdaHdm.state.meter.lastDamageMessage
			local damage = BeltalowdaNetworking.DecodeInt24(message.b1, message.b2, message.b3)
			
			local damageValue = BeltalowdaHdm.state.meter.damage
			damage = BeltalowdaMath.Int24ToArray(damage)
			damage[22] = 0
			damage[23] = 0
			damage[24] = 0
			damage = BeltalowdaMath.ArrayToInt24(damage)
			damageValue = damageValue + damage
			if damageValue > 2097151 then
				damageValue = 2097151
			end
			damageValue = BeltalowdaMath.Int24ToArray(damageValue)
			local debuffs = BeltalowdaHdm.GetPlayerDebuffs()
			if debuffs > 7 then
				debuffs = 7
			end
			debuffs = BeltalowdaMath.DecodeBitArrayHelper(debuffs)
			damageValue[22] = debuffs[1]
			damageValue[23] = debuffs[2]
			damageValue[24] = debuffs[3]
			damageValue = BeltalowdaMath.ArrayToInt24(damageValue)
			
			
			BeltalowdaHdm.state.meter.damage = 0
			--Ignore the fact that this value could exceed 24bit => 16'777'215 but this should be hardly the case and therefore for simplicity ignored.
			--Ignore the fact that it is only 2097151 now
			message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeInt24(damageValue)
		end
		
		if BeltalowdaHdm.state.meter.lastHpMessage ~= nil and BeltalowdaHdm.state.meter.lastHpMessage.sent == false then
			local message = BeltalowdaHdm.state.meter.lastHpMessage
			local healing = BeltalowdaNetworking.DecodeInt24(message.b1, message.b2, message.b3)
			
			local healingValue = BeltalowdaHdm.state.meter.healing
			healing = BeltalowdaMath.Int24ToArray(healing)
			healing[22] = 0
			healing[23] = 0
			healing[24] = 0
			healing = BeltalowdaMath.ArrayToInt24(healing)
			healingValue = healingValue + healing
			if healingValue > 2097151 then
				healingValue = 2097151
			end
			healingValue = BeltalowdaMath.Int24ToArray(healingValue)
			local debuffs = BeltalowdaHdm.GetPlayerDebuffs()
			if debuffs > 7 then
				debuffs = 7
			end
			debuffs = BeltalowdaMath.DecodeBitArrayHelper(debuffs)
			healingValue[22] = debuffs[1]
			healingValue[23] = debuffs[2]
			healingValue[24] = debuffs[3]
			healingValue = BeltalowdaMath.ArrayToInt24(healingValue)
			
			BeltalowdaHdm.state.meter.healing = 0
			--Ignore the fact that this value could exceed 24bit => 16'777'215 but this should be hardly the case and therefore for simplicity ignored.
			message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeInt24(healingValue)
		end
	end
end

function BeltalowdaHdm.UiLoop()
	if BeltalowdaHdm.hdmVars.pvpOnly == false or (BeltalowdaHdm.hdmVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		local damageControl = BeltalowdaHdm.controls.hdmTLW.rootControl.damageControl.playerBlocks
		local healingControl = BeltalowdaHdm.controls.hdmTLW.rootControl.healingControl.playerBlocks
		if players ~= nil then
			local damageList, totalDamage = BeltalowdaHdm.CopyPlayersIncludingTotals(players, "damage")
			local healingList, totalHealing = BeltalowdaHdm.CopyPlayersIncludingTotals(players, "healing")
			--d(totalDamage)
			
			table.sort(damageList, BeltalowdaHdm.ComparePlayersByDamage)
			table.sort(healingList, BeltalowdaHdm.ComparePlayersByHealing)
			for i = 1, #damageList do
				--Dmg
				
				if damageList[i].meter ~= nil and damageList[i].meter.damage ~= nil then
					local isDps, isHealer, isTank = GetGroupMemberRoles(damageList[i].unitTag)
					local alpha = BeltalowdaHdm.config.backgroundEven
					if BeltalowdaHdm.hdmVars.useAlpha == true then
						if i % 2 == 1 then
							alpha = BeltalowdaHdm.config.backgroundOdd
						end
					end
					local color = {r = 0, g = 0, b = 0}
					if BeltalowdaHdm.hdmVars.useColors == true then
						if isDps == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.dd
						elseif isHealer == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.healer
						elseif isTank == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.tank
						end
					end
					if BeltalowdaHdm.hdmVars.highlightApplicant == true then
						if damageList[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT then
							color = BeltalowdaHdm.hdmVars.backgroundColor.applicant
						end
					end
					damageControl[i].nameBackdrop:SetCenterColor(color.r, color.g, color.b, alpha)
					damageControl[i].nameBackdrop:SetEdgeColor(color.r, color.g, color.b,0)
					damageControl[i].valueBackdrop:SetCenterColor(color.r, color.g, color.b, alpha)
					damageControl[i].valueBackdrop:SetEdgeColor(color.r, color.g, color.b,0)
					
					damageControl[i].name:SetText(damageList[i].name)
					local damagePercent = 100 / (totalDamage / damageList[i].meter.damage)
					if damageList[i].meter.damage == 0 then
						damagePercent = 0
					end
					local formatString = BeltalowdaHdm.constants.LABEL_VALUE_FORMAT
					if damagePercent < 10 then
						formatString = BeltalowdaHdm.constants.LABEL_VALUE_FORMAT_2
					end
					damageControl[i].value:SetText(string.format(formatString, damageList[i].meter.damage, damagePercent))
					if IsUnitDead(damageList[i].unitTag) == true then
						damageControl[i].name:SetColor(BeltalowdaHdm.hdmVars.deadColor.r, BeltalowdaHdm.hdmVars.deadColor.g, BeltalowdaHdm.hdmVars.deadColor.b)
						damageControl[i].value:SetColor(BeltalowdaHdm.hdmVars.deadColor.r, BeltalowdaHdm.hdmVars.deadColor.g, BeltalowdaHdm.hdmVars.deadColor.b)
					else
						damageControl[i].name:SetColor(BeltalowdaHdm.hdmVars.aliveColor.r, BeltalowdaHdm.hdmVars.aliveColor.g, BeltalowdaHdm.hdmVars.aliveColor.b)
						damageControl[i].value:SetColor(BeltalowdaHdm.hdmVars.aliveColor.r, BeltalowdaHdm.hdmVars.aliveColor.g, BeltalowdaHdm.hdmVars.aliveColor.b)
					end
				else
					damageControl[i].name:SetText("")
					damageControl[i].value:SetText("")
				end
				--Hp
				if healingList[i].meter ~= nil and healingList[i].meter.healing ~= nil then
					local isDps, isHealer, isTank = GetGroupMemberRoles(healingList[i].unitTag)
					local alpha = BeltalowdaHdm.config.backgroundEven
					if BeltalowdaHdm.hdmVars.useAlpha == true then
						if i % 2 == 1 then
							alpha = BeltalowdaHdm.config.backgroundOdd
						end
					end
					local color = {r = 0, g = 0, b = 0}
					if BeltalowdaHdm.hdmVars.useColors == true then
						if isDps == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.dd
						elseif isHealer == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.healer
						elseif isTank == true then
							color = BeltalowdaHdm.hdmVars.backgroundColor.tank
						end
					end
					if BeltalowdaHdm.hdmVars.highlightApplicant == true then
						if healingList[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT then
							color = BeltalowdaHdm.hdmVars.backgroundColor.applicant
						end
					end
					healingControl[i].nameBackdrop:SetCenterColor(color.r, color.g, color.b, alpha)
					healingControl[i].nameBackdrop:SetEdgeColor(color.r, color.g, color.b,0)
					healingControl[i].valueBackdrop:SetCenterColor(color.r, color.g, color.b, alpha)
					healingControl[i].valueBackdrop:SetEdgeColor(color.r, color.g, color.b,0)
					
					healingControl[i].name:SetText(healingList[i].name)
					local healingPercent = 100 / (totalHealing / healingList[i].meter.healing)
					if healingList[i].meter.healing == 0 then
						healingPercent = 0
					end
					local formatString = BeltalowdaHdm.constants.LABEL_VALUE_FORMAT
					if healingPercent < 10 then
						formatString = BeltalowdaHdm.constants.LABEL_VALUE_FORMAT_2
					end
					healingControl[i].value:SetText(string.format(formatString, healingList[i].meter.healing, healingPercent))
					if IsUnitDead(healingList[i].unitTag) == true then
						healingControl[i].name:SetColor(BeltalowdaHdm.hdmVars.deadColor.r, BeltalowdaHdm.hdmVars.deadColor.g, BeltalowdaHdm.hdmVars.deadColor.b)
						healingControl[i].value:SetColor(BeltalowdaHdm.hdmVars.deadColor.r, BeltalowdaHdm.hdmVars.deadColor.g, BeltalowdaHdm.hdmVars.deadColor.b)
					else
						healingControl[i].name:SetColor(BeltalowdaHdm.hdmVars.aliveColor.r, BeltalowdaHdm.hdmVars.aliveColor.g, BeltalowdaHdm.hdmVars.aliveColor.b)
						healingControl[i].value:SetColor(BeltalowdaHdm.hdmVars.aliveColor.r, BeltalowdaHdm.hdmVars.aliveColor.g, BeltalowdaHdm.hdmVars.aliveColor.b)
					end
				else
					healingControl[i].name:SetText("")
					healingControl[i].value:SetText("")
				end
			end
			for i = #damageList + 1, 24 do
				damageControl[i].name:SetText("")
				damageControl[i].value:SetText("")
				damageControl[i].nameBackdrop:SetCenterColor(0,0,0,0)
				damageControl[i].nameBackdrop:SetEdgeColor(0,0,0,0)
				damageControl[i].valueBackdrop:SetCenterColor(0,0,0,0)
				damageControl[i].valueBackdrop:SetEdgeColor(0,0,0,0)
				healingControl[i].name:SetText("")
				healingControl[i].value:SetText("")
				healingControl[i].nameBackdrop:SetCenterColor(0,0,0,0)
				healingControl[i].nameBackdrop:SetEdgeColor(0,0,0,0)
				healingControl[i].valueBackdrop:SetCenterColor(0,0,0,0)
				healingControl[i].valueBackdrop:SetEdgeColor(0,0,0,0)
			end
		else
			for i = 1, 24 do
				damageControl[i].name:SetText("")
				damageControl[i].value:SetText("")
				damageControl[i].nameBackdrop:SetCenterColor(0,0,0,0)
				damageControl[i].nameBackdrop:SetEdgeColor(0,0,0,0)
				damageControl[i].valueBackdrop:SetCenterColor(0,0,0,0)
				damageControl[i].valueBackdrop:SetEdgeColor(0,0,0,0)
				healingControl[i].name:SetText("")
				healingControl[i].value:SetText("")
				healingControl[i].nameBackdrop:SetCenterColor(0,0,0,0)
				healingControl[i].nameBackdrop:SetEdgeColor(0,0,0,0)
				healingControl[i].valueBackdrop:SetCenterColor(0,0,0,0)
				healingControl[i].valueBackdrop:SetEdgeColor(0,0,0,0)
			end
		end
	end
end

function BeltalowdaHdm.HpUpdateLoop()
	if BeltalowdaHdm.hdmVars.pvpOnly == false or (BeltalowdaHdm.hdmVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		--d("hp loop")
		if BeltalowdaHdm.state.meter.lastHpMessage == nil or BeltalowdaHdm.state.meter.lastHpMessage.sent == true then
			if BeltalowdaHdm.state.meter.healing > 0 then
				local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_HP
				
				local healValue = BeltalowdaHdm.state.meter.healing
				if healValue > 2097151 then
					healValue = 2097151
				end
				healValue = BeltalowdaMath.Int24ToArray(healValue)
				local debuffs = BeltalowdaHdm.GetPlayerDebuffs()
				if debuffs > 7 then
					debuffs = 7
				end
				debuffs = BeltalowdaMath.DecodeBitArrayHelper(debuffs)
				healValue[22] = debuffs[1]
				healValue[23] = debuffs[2]
				healValue[24] = debuffs[3]
				healValue = BeltalowdaMath.ArrayToInt24(healValue)
				
				message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeInt24(healValue)
				BeltalowdaHdm.state.meter.healing = 0
				message.sent = false
				BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
				BeltalowdaHdm.state.meter.lastHpMessage = message
			else
				BeltalowdaHdm.state.meter.lastHpMessage = nil
			end
		end
	end
end

function BeltalowdaHdm.DmgUpdateLoop()
	if BeltalowdaHdm.hdmVars.pvpOnly == false or (BeltalowdaHdm.hdmVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		--d("dmg loop")
		if BeltalowdaHdm.state.meter.lastDamageMessage == nil or BeltalowdaHdm.state.meter.lastDamageMessage.sent == true then
			if BeltalowdaHdm.state.meter.damage > 0 then
				local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_DMG
				
				local damageValue = BeltalowdaHdm.state.meter.damage
				if damageValue > 2097151 then
					damageValue = 2097151
				end
				damageValue = BeltalowdaMath.Int24ToArray(damageValue)
				local debuffs = BeltalowdaHdm.GetPlayerDebuffs()
				if debuffs > 7 then
					debuffs = 7
				end
				debuffs = BeltalowdaMath.DecodeBitArrayHelper(debuffs)
				damageValue[22] = debuffs[1]
				damageValue[23] = debuffs[2]
				damageValue[24] = debuffs[3]
				damageValue = BeltalowdaMath.ArrayToInt24(damageValue)
				
				message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeInt24(damageValue)
				BeltalowdaHdm.state.meter.damage = 0
				message.sent = false
				BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
				BeltalowdaHdm.state.meter.lastDamageMessage = message
			else
				BeltalowdaHdm.state.meter.lastDamageMessage = nil
			end
		end
	end
end

function BeltalowdaHdm.OnKeyBinding()
	BeltalowdaUtilGroup.ClearDamageHealingMeter()
end

--menu interactions
function BeltalowdaHdm.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.HDM_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_ENABLED,
					getFunc = BeltalowdaHdm.GetHdmEnabled,
					setFunc = BeltalowdaHdm.SetHdmEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_POSITION_FIXED,
					getFunc = BeltalowdaHdm.GetHdmPositionLocked,
					setFunc = BeltalowdaHdm.SetHdmPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_PVP_ONLY,
					getFunc = BeltalowdaHdm.GetHdmPvpOnly,
					setFunc = BeltalowdaHdm.SetHdmPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_WINDOW_ENABLED,
					getFunc = BeltalowdaHdm.GetHdmWindowEnabled,
					setFunc = BeltalowdaHdm.SetHdmWindowEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_USING_ALPHA,
					getFunc = BeltalowdaHdm.GetHdmUsingAlphaEnabled,
					setFunc = BeltalowdaHdm.SetHdmUsingAlphaEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_USING_COLORS,
					getFunc = BeltalowdaHdm.GetHdmUsingColorsEnabled,
					setFunc = BeltalowdaHdm.SetHdmUsingColorsEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_USING_HIGHLIGHT_APPLICANT,
					getFunc = BeltalowdaHdm.GetHdmUsingApplicantHighlightEnabled,
					setFunc = BeltalowdaHdm.SetHdmUsingApplicantHighlightEnabled
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.HDM_AUTO_RESET,
					getFunc = BeltalowdaHdm.GetHdmAutoReset,
					setFunc = BeltalowdaHdm.SetHdmAutoReset
				},
				[9] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.HDM_SELECTED_VIEWMODE,
					choices = BeltalowdaHdm.GetHdmAvailableViewModes(),
					getFunc = BeltalowdaHdm.GetHdmSelectedViewMode,
					setFunc = BeltalowdaHdm.SetHdmSelectedViewMode,
					width = "full"
				},
				[10] = {
					type = "slider",
					name = BeltalowdaMenu.constants.HDM_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaHdm.GetHdmSelectedSize,
					setFunc = BeltalowdaHdm.SetHdmSelectedSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_ALIVE_COLOR,
					getFunc = BeltalowdaHdm.GetHdmAliveColor,
					setFunc = BeltalowdaHdm.SetHdmAliveColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_DEAD_COLOR,
					getFunc = BeltalowdaHdm.GetHdmDeadColor,
					setFunc = BeltalowdaHdm.SetHdmDeadColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_HEALER,
					getFunc = BeltalowdaHdm.GetHdmHealerColor,
					setFunc = BeltalowdaHdm.SetHdmHealerColor,
					width = "full"
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_DD,
					getFunc = BeltalowdaHdm.GetHdmDDColor,
					setFunc = BeltalowdaHdm.SetHdmDDColor,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_TANK,
					getFunc = BeltalowdaHdm.GetHdmTankColor,
					setFunc = BeltalowdaHdm.SetHdmTankColor,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_APPLICANT,
					getFunc = BeltalowdaHdm.GetHdmApplicantColor,
					setFunc = BeltalowdaHdm.SetHdmApplicantColor,
					width = "full"
				},
			}
		}
	}
	return menu
end

function BeltalowdaHdm.GetHdmEnabled()
	return BeltalowdaHdm.hdmVars.enabled
end

function BeltalowdaHdm.SetHdmEnabled(value)
	BeltalowdaHdm.SetEnabled(value)
end

function BeltalowdaHdm.GetHdmPositionLocked()
	return BeltalowdaHdm.hdmVars.positionLocked
end

function BeltalowdaHdm.SetHdmPositionLocked(value)
	BeltalowdaHdm.SetPositionLocked(value)
end

function BeltalowdaHdm.GetHdmPvpOnly()
	return BeltalowdaHdm.hdmVars.pvpOnly
end

function BeltalowdaHdm.SetHdmPvpOnly(value)
	BeltalowdaHdm.hdmVars.pvpOnly = value
	BeltalowdaHdm.SetControlVisibility()
end

function BeltalowdaHdm.GetHdmWindowEnabled()
	return BeltalowdaHdm.hdmVars.windowEnabled
end

function BeltalowdaHdm.SetHdmWindowEnabled(value)
	BeltalowdaHdm.hdmVars.windowEnabled = value
	BeltalowdaHdm.SetControlVisibility()
end

function BeltalowdaHdm.GetHdmUsingAlphaEnabled()
	return BeltalowdaHdm.hdmVars.useAlpha
end

function BeltalowdaHdm.SetHdmUsingAlphaEnabled(value)
	BeltalowdaHdm.hdmVars.useAlpha = value
end

function BeltalowdaHdm.GetHdmUsingColorsEnabled()
	return BeltalowdaHdm.hdmVars.useColors
end

function BeltalowdaHdm.SetHdmUsingColorsEnabled(value)
	BeltalowdaHdm.hdmVars.useColors = value
end

function BeltalowdaHdm.GetHdmUsingApplicantHighlightEnabled()
	return BeltalowdaHdm.hdmVars.highlightApplicant
end

function BeltalowdaHdm.SetHdmUsingApplicantHighlightEnabled(value)
	BeltalowdaHdm.hdmVars.highlightApplicant = value
end

function BeltalowdaHdm.GetHdmAutoReset()
	return BeltalowdaHdm.hdmVars.autoClear
end

function BeltalowdaHdm.SetHdmAutoReset(value)
	BeltalowdaHdm.hdmVars.autoClear = value
	BeltalowdaHdm.AdjustAutoClearEnabled()
end

function BeltalowdaHdm.GetHdmAvailableViewModes()
	return BeltalowdaHdm.constants.viewModes
end

function BeltalowdaHdm.GetHdmSelectedViewMode()
	return BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.hdmVars.viewMode]
end

function BeltalowdaHdm.SetHdmSelectedViewMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaHdm.constants.viewModes do
			if BeltalowdaHdm.constants.viewModes[i] == value then
				BeltalowdaHdm.hdmVars.viewMode = i
			end
		end
	end
	BeltalowdaHdm.AdjustViewMode()
end

function BeltalowdaHdm.GetHdmSelectedSize()
	return BeltalowdaHdm.hdmVars.size
end

function BeltalowdaHdm.SetHdmSelectedSize(value)
	if value ~= nil and value >= BeltalowdaHdm.constants.size.SMALL and value <= BeltalowdaHdm.constants.size.BIG then
		BeltalowdaHdm.hdmVars.size = value
		BeltalowdaHdm.AdjustControlSize()
	end
end

function BeltalowdaHdm.GetHdmAliveColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.aliveColor)
end

function BeltalowdaHdm.SetHdmAliveColor(r, g, b)
	BeltalowdaHdm.hdmVars.aliveColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaHdm.GetHdmDeadColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.deadColor)
end

function BeltalowdaHdm.SetHdmDeadColor(r, g, b)
	BeltalowdaHdm.hdmVars.deadColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaHdm.GetHdmHealerColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.backgroundColor.healer)
end

function BeltalowdaHdm.SetHdmHealerColor(r, g, b)
	BeltalowdaHdm.hdmVars.backgroundColor.healer = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaHdm.GetHdmDDColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.backgroundColor.dd)
end

function BeltalowdaHdm.SetHdmDDColor(r, g, b)
	BeltalowdaHdm.hdmVars.backgroundColor.dd = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaHdm.GetHdmTankColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.backgroundColor.tank)
end

function BeltalowdaHdm.SetHdmTankColor(r, g, b)
	BeltalowdaHdm.hdmVars.backgroundColor.tank = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaHdm.GetHdmApplicantColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaHdm.hdmVars.backgroundColor.applicant)
end

function BeltalowdaHdm.SetHdmApplicantColor(r, g, b)
	BeltalowdaHdm.hdmVars.backgroundColor.applicant = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end