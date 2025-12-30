-- Beltalowda Enhancements
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.enhancements = BeltalowdaTB.enhancements or {}
local BeltalowdaEnhance = BeltalowdaTB.enhancements
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaEnhance.callbackName = Beltalowda.addonName .. "Enhancements"
BeltalowdaEnhance.questTrackerCallbackName = Beltalowda.addonName .. "EnhancementsQuestTracker"
BeltalowdaEnhance.compassCallbackName = Beltalowda.addonName .. "EnhancementsCompass"
BeltalowdaEnhance.alertsCallbackName = Beltalowda.addonName .. "EnhancementsAlerts"
BeltalowdaEnhance.respawnTimerCallbackName = Beltalowda.addonName .. "EnhancementsRespawnTimer"
BeltalowdaEnhance.respawnTimerUpdateLoopName = Beltalowda.addonName .. "EnhancementsRespawnTimerLoop"

BeltalowdaEnhance.constants = {}
BeltalowdaEnhance.constants.TOPRIGHT = 1
BeltalowdaEnhance.constants.BOTTOMRIGHT = 2
BeltalowdaEnhance.constants.TOPLEFT = 3
BeltalowdaEnhance.constants.BOTTOMLEFT = 4
BeltalowdaEnhance.constants.positionNames = {}
BeltalowdaEnhance.constants.PREFIX = "Enhancements"

BeltalowdaEnhance.state = {}
BeltalowdaEnhance.state.initialized = false
BeltalowdaEnhance.state.initCodeRun = false
BeltalowdaEnhance.state.questTracker = {}
BeltalowdaEnhance.state.compass = {}
BeltalowdaEnhance.state.compass.registeredConsumers = false
BeltalowdaEnhance.state.alerts = {}
BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_RIGHT
BeltalowdaEnhance.state.respawnTimer = {}
BeltalowdaEnhance.state.respawnTimer.hookedTimer = false
BeltalowdaEnhance.state.respawnTimerText = ""
BeltalowdaEnhance.state.refreshRate = 100
BeltalowdaEnhance.state.origFunc = nil
BeltalowdaEnhance.state.failedAlertHooks = 0 

function BeltalowdaEnhance.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaEnhance.callbackName, BeltalowdaEnhance.OnProfileChanged)
		
	--BeltalowdaEnhance.OnInitialize()
	EVENT_MANAGER:RegisterForEvent(BeltalowdaEnhance.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaEnhance.OnInitialize)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaEnhance.questTrackerCallbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaEnhance.OnQuestTrackerPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaEnhance.compassCallbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaEnhance.OnCompassPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaEnhance.respawnTimerCallbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaEnhance.OnRespawnTimerPlayerActivated)
	
	BeltalowdaEnhance.state.initialized = true
	BeltalowdaEnhance.InitializeEnhancements()
end

function BeltalowdaEnhance.InitializeEnhancements()
	BeltalowdaEnhance.OnQuestTrackerPlayerActivated()
	BeltalowdaEnhance.OnRespawnTimerPlayerActivated()
end


function BeltalowdaEnhance.GetDefaults()
	local defaults = {}
	defaults.questTracker = {}
	defaults.questTracker.disabled = true
	defaults.questTracker.pvpOnly = true
	defaults.compass = {}
	defaults.compass.tweaksEnabled = false
	defaults.compass.pvpOnly = true
	defaults.compass.hidden = false
	defaults.compass.width = 672
	defaults.alerts = {}
	defaults.alerts.tweaksEnabled = false
	defaults.alerts.pvpOnly = true
	defaults.alerts.hidden = false
	defaults.alerts.position = BeltalowdaEnhance.constants.TOPRIGHT
	defaults.alerts.color = {}
	defaults.alerts.color.r = 1
	defaults.alerts.color.g = 1
	defaults.alerts.color.b = 1
	defaults.respawnTimer = {}
	defaults.respawnTimer.enabled = true
	return defaults
end

function BeltalowdaEnhance.HookAlerts()
	if ALERT_MESSAGES ~= nil and ALERT_MESSAGES.alerts ~= nil then
		BeltalowdaUtil.ParameterPreHook(BeltalowdaEnhance.alertsCallbackName, ALERT_MESSAGES.alerts, "SetupItem", BeltalowdaEnhance.HookedZOSetupItemFunction)
	else
		BeltalowdaEnhance.state.failedAlertHooks = BeltalowdaEnhance.state.failedAlertHooks + 1
		if BeltalowdaEnhance.state.failedAlertHooks <= 5 then
			zo_callLater(BeltalowdaEnhance.HookAlerts, 1000)
		end
	end
end

function BeltalowdaEnhance.AdjustAlerts()
	local anchor = TOPRIGHT
	local pushDirection = FCB_PUSH_DIRECTION_DOWN
	local hidden = false
	local color = {r = 1, g = 1, b = 1, a = 1}
	if BeltalowdaEnhance.eVars.alerts.tweaksEnabled == true and (BeltalowdaEnhance.eVars.alerts.pvpOnly == false or (BeltalowdaEnhance.eVars.alerts.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaEnhance.eVars.alerts.position == BeltalowdaEnhance.constants.TOPRIGHT then
			BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_RIGHT
			anchor = TOPRIGHT
			pushDirection = FCB_PUSH_DIRECTION_DOWN
		elseif BeltalowdaEnhance.eVars.alerts.position == BeltalowdaEnhance.constants.BOTTOMRIGHT then
			BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_RIGHT
			anchor = BOTTOMRIGHT
			pushDirection = -1
		elseif BeltalowdaEnhance.eVars.alerts.position == BeltalowdaEnhance.constants.TOPLEFT then
			BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_LEFT
			anchor = TOPLEFT
			pushDirection = FCB_PUSH_DIRECTION_DOWN
		elseif BeltalowdaEnhance.eVars.alerts.position == BeltalowdaEnhance.constants.BOTTOMLEFT then
			BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_LEFT
			anchor = BOTTOMLEFT
			pushDirection = -1
		end
		if BeltalowdaEnhance.eVars.alerts.hidden == true then
			hidden = true
		end
		BeltalowdaEnhance.state.alerts.color = BeltalowdaEnhance.eVars.alerts.color
	else
		BeltalowdaEnhance.state.alerts.allignment = TEXT_ALIGN_RIGHT
		BeltalowdaEnhance.state.alerts.color = color
	end
	
	
	ZO_AlertTextNotification:SetHidden(hidden)
	if ALERT_MESSAGES ~= nil and ALERT_MESSAGES.alerts ~= nil then
		local fadingControlBuffer = ALERT_MESSAGES.alerts
		if fadingControlBuffer.anchor ~= nil and fadingControlBuffer.anchor.data ~= nil then
			fadingControlBuffer.anchor.data[1] = anchor
		end
		if fadingControlBuffer.SetPushDirection ~= nil and type(fadingControlBuffer.SetPushDirection) == "function" then
			fadingControlBuffer:SetPushDirection(pushDirection)
		end
	end
	
	
	--ALERT_MESSAGES.alerts.anchor.data[1]= BOTTOMRIGHT
	--ZO_AlertTextNotification:GetChild().fadingControlBuffer.anchor.data[1] = anchor
	
	--ALERT_MESSAGES.alerts:SetPushDirection(-1)
	--ZO_AlertTextNotification:GetChild().fadingControlBuffer:SetPushDirection(pushDirection)

end

function BeltalowdaEnhance.HookedZOSetupItemFunction(control, hasHeader, item, templateName, setupFn, pools, parent, offsetY, isHeader)
	BeltalowdaChat.SendChatMessage("ALERT_MESSAGES:SetupItem:Outer Hook", BeltalowdaEnhance.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	local hookedFn = function(ctrl, data)
		item.color.r = BeltalowdaEnhance.state.alerts.color.r
		item.color.g = BeltalowdaEnhance.state.alerts.color.g
		item.color.b = BeltalowdaEnhance.state.alerts.color.b
		ctrl:SetHorizontalAlignment(BeltalowdaEnhance.state.alerts.allignment)
		BeltalowdaChat.SendChatMessage("ALERT_MESSAGES:SetupItem:Inner Hook", BeltalowdaEnhance.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		return setupFn(ctrl, data)
	end
	return control, hasHeader, item, templateName, hookedFn, pools, parent, offsetY, isHeader
end

function BeltalowdaEnhance.RespawnTimerHook(--[[currentTime]])
	--d("hooked")
	if IsInCyrodiil() == true and BeltalowdaEnhance.eVars.respawnTimer.enabled == true then
		local respawnTime = GetNextForwardCampRespawnTime()
		--currentTime = currentTime * 1000
		local seconds = (respawnTime - GetGameTimeMilliseconds()) / 1000
		if seconds < 0 then
			respawnTime = "-"
		else
			respawnTime = ZO_FormatTimeAsDecimalWhenBelowThreshold(seconds)
		end
		

		if IsInGamepadPreferredMode() then
			local data =
			{
				data1HeaderText = SI_MAP_FORWARD_CAMP_RESPAWN_COOLDOWN,
				data1Text = respawnTime
			}
			GAMEPAD_GENERIC_FOOTER:Refresh(data)
		else
			ZO_WorldMapRespawnTimerValue:SetText(respawnTime)
			
			ZO_WorldMapRespawnTimer:SetHidden(false)
		end
	else
		ZO_WorldMapRespawnTimer:SetHidden(true)
	end
	--[[replace above with ZO_WorldMapRespawnTimer:SetHidden(false) ? -gamepad?]]
end

--callbacks
function BeltalowdaEnhance.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaEnhance.eVars = currentProfile.toolbox.enhancements
		BeltalowdaEnhance.InitializeEnhancements()
		if BeltalowdaEnhance.state.initialized == true then
			BeltalowdaEnhance.OnCompassPlayerActivated()
			BeltalowdaEnhance.AdjustAlerts()
		end
	end
end

function BeltalowdaEnhance.OnQuestTrackerPlayerActivated()
	if BeltalowdaEnhance.eVars.questTracker.disabled == true and (BeltalowdaEnhance.eVars.questTracker.pvpOnly == false or (BeltalowdaEnhance.eVars.questTracker.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if ZO_FocusedQuestTrackerPanel ~= nil then
			ZO_FocusedQuestTrackerPanel:SetHidden(true)
		end
	else
		if ZO_FocusedQuestTrackerPanel ~= nil then
			ZO_FocusedQuestTrackerPanel:SetHidden(false)
		end
	end
	
end

function BeltalowdaEnhance.OnCompassPlayerActivated()
	if BeltalowdaEnhance.state.initCodeRun == false then
		BeltalowdaEnhance.OnInitialize()
	end
	if BeltalowdaEnhance.eVars.compass.tweaksEnabled == true and (BeltalowdaEnhance.eVars.compass.pvpOnly == false or (BeltalowdaEnhance.eVars.compass.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		COMPASS_FRAME.control:SetHidden(BeltalowdaEnhance.eVars.compass.hidden)
		COMPASS.control:GetNamedChild("Container"):SetHidden(BeltalowdaEnhance.eVars.compass.hidden)
		COMPASS.centerOverPinLabel:SetText("")
		for index, item in pairs({"Left", "Center", "Right"}) do
			local control = COMPASS_FRAME.control:GetNamedChild(item)
			if control then 
				control:SetHidden(BeltalowdaEnhance.eVars.compass.hidden) 
			end
		end
		local cWidth, cHeight = COMPASS_FRAME.control:GetDimensions()
		zo_callLater(function()
			COMPASS_FRAME.control:SetDimensions(BeltalowdaEnhance.eVars.compass.width, cHeight)
		end, 10)
	else
		COMPASS_FRAME.control:SetHidden(false)
		COMPASS.control:GetNamedChild("Container"):SetHidden(false)
		for index, item in pairs({"Left", "Center", "Right"}) do
			local control = COMPASS_FRAME.control:GetNamedChild(item)
			if control then 
				control:SetHidden(false) 
			end
		end
		zo_callLater(function()
			COMPASS_FRAME.control:SetDimensions(BeltalowdaEnhance.state.compass.width, BeltalowdaEnhance.state.compass.height)
		end, 10)
	end
end

function BeltalowdaEnhance.OnRespawnTimerPlayerActivated()
	--d("respawn activated")
	if IsInCyrodiil() == true and BeltalowdaEnhance.eVars.respawnTimer.enabled == true then
		if BeltalowdaEnhance.state.respawnTimer.hookedTimer == false then
			--d("hooking")
			BeltalowdaEnhance.state.respawnTimerText = ZO_WorldMapRespawnTimerStat:GetText()
			BeltalowdaEnhance.state.origFunc = ZO_WorldMap_RefreshRespawnTimer
			ZO_WorldMap_RefreshRespawnTimer = function(currentTime) end
			ZO_WorldMapRespawnTimerStat:SetText(BeltalowdaEnhance.constants.CAMP_RESPAWN)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaEnhance.respawnTimerUpdateLoopName, BeltalowdaEnhance.state.refreshRate, BeltalowdaEnhance.RespawnTimerHook)
			--BeltalowdaUtil.PostHook(BeltalowdaEnhance.respawnTimerCallbackName, nil, "ZO_WorldMap_RefreshRespawnTimer", BeltalowdaEnhance.RespawnTimerHook)
			BeltalowdaEnhance.state.respawnTimer.hookedTimer = true
			
		end
	else
		if BeltalowdaEnhance.state.respawnTimer.hookedTimer == true then
			--d("removing hook")
			ZO_WorldMapRespawnTimerStat:SetText(BeltalowdaEnhance.state.respawnTimerText)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaEnhance.respawnTimerUpdateLoopName)
			ZO_WorldMap_RefreshRespawnTimer = BeltalowdaEnhance.state.origFunc
			--BeltalowdaUtil.RemovePostHook(BeltalowdaEnhance.respawnTimerCallbackName)
			BeltalowdaEnhance.state.respawnTimer.hookedTimer = false
			ZO_WorldMapRespawnTimer:SetHidden(true)
		end
	end
end

function BeltalowdaEnhance.OnInitialize()
	BeltalowdaEnhance.state.compass.width, BeltalowdaEnhance.state.compass.height = COMPASS_FRAME.control:GetDimensions()
	BeltalowdaEnhance.HookAlerts()
	BeltalowdaEnhance.AdjustAlerts()
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaEnhance.callbackName, EVENT_PLAYER_ACTIVATED)
	BeltalowdaEnhance.state.initCodeRun = true
end

--menu interactions
function BeltalowdaEnhance.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.ENHANCE_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_ENABLED,
					getFunc = BeltalowdaEnhance.GetEnhanceQuestTrackerDisabled,
					setFunc = BeltalowdaEnhance.SetEnhanceQuestTrackerDisabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_PVP_ONLY,
					getFunc = BeltalowdaEnhance.GetEnhanceQuestTrackerPvpOnly,
					setFunc = BeltalowdaEnhance.SetEnhanceQuestTrackerPvpOnly
				},
				[3] = {
					type = "divider",
					width = "full"
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_COMPASS_TWEAKS_ENABLED,
					getFunc = BeltalowdaEnhance.GetEnhanceCompassTweaksEnabled,
					setFunc = BeltalowdaEnhance.SetEnhanceCompassTweaksEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_COMPASS_PVP_ONLY,
					getFunc = BeltalowdaEnhance.GetEnhanceCompassPvpOnly,
					setFunc = BeltalowdaEnhance.SetEnhanceCompassPvpOnly
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_COMPASS_HIDDEN,
					getFunc = BeltalowdaEnhance.GetEnhanceCompassHidden,
					setFunc = BeltalowdaEnhance.SetEnhanceCompassHidden
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.ENHANCE_COMPASS_WIDTH,
					min = 10,
					max = 1800,
					step = 1,
					getFunc = BeltalowdaEnhance.GetEnhanceCompassWidth,
					setFunc = BeltalowdaEnhance.SetEnhanceCompassWidth,
					width = "full",
					default = 672
				},
				[8] = {
					type = "divider",
					width = "full"
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_ALERTS_TWEAKS_ENABLED,
					getFunc = BeltalowdaEnhance.GetEnhanceAlertsTweaksEnabled,
					setFunc = BeltalowdaEnhance.SetEnhanceAlertsTweaksEnabled
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_ALERTS_PVP_ONLY,
					getFunc = BeltalowdaEnhance.GetEnhanceAlertsPvpOnly,
					setFunc = BeltalowdaEnhance.SetEnhanceAlertsPvpOnly
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_ALERTS_HIDDEN,
					getFunc = BeltalowdaEnhance.GetEnhanceAlertsHidden,
					setFunc = BeltalowdaEnhance.SetEnhanceAlertsHidden
				},
				[12] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ENHANCE_ALERTS_POSITION,
					choices = BeltalowdaEnhance.GetEnhanceAlertsPositionValues(),
					choicesValues = BeltalowdaEnhance.GetEnhanceAlertsPositionValueChoises(),
					getFunc = BeltalowdaEnhance.GetEnhanceAlertsSelectedPosition,
					setFunc = BeltalowdaEnhance.SetEnhanceAlertsSelectedPosition
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.ENHANCE_ALERTS_COLOR,
					getFunc = BeltalowdaEnhance.GetEnhanceAlertsColor,
					setFunc = BeltalowdaEnhance.SetEnhanceAlertsColor,
					width = "full"
				},
				[14] = {
					type = "divider",
					width = "full"
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ENHANCE_RESPAWN_TIMER_ENABLED,
					getFunc = BeltalowdaEnhance.GetEnhanceRespawnTimerEnabled,
					setFunc = BeltalowdaEnhance.SetEnhanceRespawnTimerEnabled
				}
			}
		}
	}
	return menu
end

function BeltalowdaEnhance.GetEnhanceQuestTrackerDisabled()
	return BeltalowdaEnhance.eVars.questTracker.disabled
end

function BeltalowdaEnhance.SetEnhanceQuestTrackerDisabled(value)
	BeltalowdaEnhance.eVars.questTracker.disabled = value
	BeltalowdaEnhance.OnQuestTrackerPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceQuestTrackerPvpOnly()
	return BeltalowdaEnhance.eVars.questTracker.pvpOnly
end

function BeltalowdaEnhance.SetEnhanceQuestTrackerPvpOnly(value)
	BeltalowdaEnhance.eVars.questTracker.pvpOnly = value
	BeltalowdaEnhance.OnQuestTrackerPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceCompassTweaksEnabled()
	return BeltalowdaEnhance.eVars.compass.tweaksEnabled
end

function BeltalowdaEnhance.SetEnhanceCompassTweaksEnabled(value)
	BeltalowdaEnhance.eVars.compass.tweaksEnabled = value
	BeltalowdaEnhance.OnCompassPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceCompassPvpOnly()
	return BeltalowdaEnhance.eVars.compass.pvpOnly
end

function BeltalowdaEnhance.SetEnhanceCompassPvpOnly(value)
	BeltalowdaEnhance.eVars.compass.pvpOnly = value
	BeltalowdaEnhance.OnCompassPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceCompassHidden()
	return BeltalowdaEnhance.eVars.compass.hidden
end

function BeltalowdaEnhance.SetEnhanceCompassHidden(value)
	BeltalowdaEnhance.eVars.compass.hidden = value
	BeltalowdaEnhance.OnCompassPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceCompassWidth()
	return BeltalowdaEnhance.eVars.compass.width
end

function BeltalowdaEnhance.SetEnhanceCompassWidth(value)
	BeltalowdaEnhance.eVars.compass.width = value
	BeltalowdaEnhance.OnCompassPlayerActivated()
end

function BeltalowdaEnhance.GetEnhanceAlertsTweaksEnabled()
	return BeltalowdaEnhance.eVars.alerts.tweaksEnabled
end

function BeltalowdaEnhance.SetEnhanceAlertsTweaksEnabled(value)
	BeltalowdaEnhance.eVars.alerts.tweaksEnabled = value
	BeltalowdaEnhance.AdjustAlerts()
end

function BeltalowdaEnhance.GetEnhanceAlertsPvpOnly()
	return BeltalowdaEnhance.eVars.alerts.pvpOnly
end

function BeltalowdaEnhance.SetEnhanceAlertsPvpOnly(value)
	BeltalowdaEnhance.eVars.alerts.pvpOnly = value
	BeltalowdaEnhance.AdjustAlerts()
end

function BeltalowdaEnhance.GetEnhanceAlertsHidden()
	return BeltalowdaEnhance.eVars.alerts.hidden
end

function BeltalowdaEnhance.SetEnhanceAlertsHidden(value)
	BeltalowdaEnhance.eVars.alerts.hidden = value
	BeltalowdaEnhance.AdjustAlerts()
end

function BeltalowdaEnhance.GetEnhanceAlertsPositionValues()
	local values = {}
	BeltalowdaEnhance.constants.positionNames = BeltalowdaEnhance.constants.positionNames or {}
	values[1] = BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPRIGHT]
	values[2] = BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMRIGHT]
	values[3] = BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPLEFT]
	values[4] = BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMLEFT]
	return values
end

function BeltalowdaEnhance.GetEnhanceAlertsPositionValueChoises()
	local choices = {}
	choices[1] = BeltalowdaEnhance.constants.TOPRIGHT
	choices[2] = BeltalowdaEnhance.constants.BOTTOMRIGHT
	choices[3] = BeltalowdaEnhance.constants.TOPLEFT
	choices[4] = BeltalowdaEnhance.constants.BOTTOMLEFT
	return choices
end

function BeltalowdaEnhance.GetEnhanceAlertsSelectedPosition()
	return BeltalowdaEnhance.eVars.alerts.position
end

function BeltalowdaEnhance.SetEnhanceAlertsSelectedPosition(value)
	BeltalowdaEnhance.eVars.alerts.position = value
	BeltalowdaEnhance.AdjustAlerts()
end

function BeltalowdaEnhance.GetEnhanceAlertsColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaEnhance.eVars.alerts.color)
end

function BeltalowdaEnhance.SetEnhanceAlertsColor(r, g, b)
	BeltalowdaEnhance.eVars.alerts.color = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaEnhance.AdjustAlerts()
end

function BeltalowdaEnhance.GetEnhanceRespawnTimerEnabled()
	return BeltalowdaEnhance.eVars.respawnTimer.enabled
end

function BeltalowdaEnhance.SetEnhanceRespawnTimerEnabled(value)
	BeltalowdaEnhance.eVars.respawnTimer.enabled = value
	BeltalowdaEnhance.OnRespawnTimerPlayerActivated()
end