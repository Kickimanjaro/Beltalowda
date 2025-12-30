-- Beltalowda Follow The Crown Warnings
-- By @s0rdrak (PC / EU)

Beltalowda.group.ftcw = Beltalowda.group.ftcw or {}
local BeltalowdaFtcw = Beltalowda.group.ftcw
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util or {}
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group


BeltalowdaFtcw.callbackName = Beltalowda.addonName .. "FollowTheCrownWarnings"

local wm = GetWindowManager()

BeltalowdaFtcw.config = {}
BeltalowdaFtcw.config.isClampedToScreen = true
BeltalowdaFtcw.config.initialMeterOffset = 100
BeltalowdaFtcw.config.updateInterval = 100
BeltalowdaFtcw.config.fontDistance = "$(BOLD_FONT)|$(KB_20)soft-shadow-thick"
BeltalowdaFtcw.config.fontWarning = "$(BOLD_FONT)|$(KB_40)soft-shadow-thick"

BeltalowdaFtcw.controls = {}

BeltalowdaFtcw.constants = {}
BeltalowdaFtcw.constants.TLW_METER_NAME = "BeltalowdaGroupFtcwMeterTLW"
BeltalowdaFtcw.constants.TLW_WARNING_NAME = "BeltalowdaGroupFtcwWarningTLW"

BeltalowdaFtcw.state = {}
BeltalowdaFtcw.state.initialized = false
BeltalowdaFtcw.state.registeredConsumer = false
BeltalowdaFtcw.state.registredActiveConsumers = false
BeltalowdaFtcw.state.activeLayerIndex = 1


function BeltalowdaFtcw.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaFtcw.callbackName, BeltalowdaFtcw.OnProfileChanged)
	--Meter Display
	BeltalowdaFtcw.controls.TLW_Meter = wm:CreateTopLevelWindow(BeltalowdaFtcw.constants.TLW_RETICLE_NAME)
	BeltalowdaFtcw.controls.TLW_Meter:SetDimensions(100, 40)

		
	BeltalowdaFtcw.controls.TLW_Meter:SetClampedToScreen(BeltalowdaFtcw.config.isClampedToScreen)
	BeltalowdaFtcw.controls.TLW_Meter:SetDrawLayer(0)
	BeltalowdaFtcw.controls.TLW_Meter:SetDrawLevel(0)
	BeltalowdaFtcw.controls.TLW_Meter:SetHandler("OnMoveStop", BeltalowdaFtcw.SaveWindowLocation)
	
	BeltalowdaFtcw.controls.meter = wm:CreateControl(nil, BeltalowdaFtcw.controls.TLW_Meter, CT_CONTROL)
	BeltalowdaFtcw.controls.meter:SetDimensions(100, 40)
	BeltalowdaFtcw.controls.meter:SetAnchor(TOPLEFT, BeltalowdaFtcw.controls.TLW_Meter, TOPLEFT, 0, 0)
	
	BeltalowdaFtcw.controls.meter.movableBackdrop = wm:CreateControl(nil, BeltalowdaFtcw.controls.meter, CT_BACKDROP)
	
	BeltalowdaFtcw.controls.meter.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaFtcw.controls.meter, TOPLEFT, 0, 0)
	BeltalowdaFtcw.controls.meter.movableBackdrop:SetDimensions(100, 40)

		
	
	BeltalowdaFtcw.controls.meter.label = wm:CreateControl(nil, BeltalowdaFtcw.controls.meter.movableBackdrop, CT_LABEL)
	BeltalowdaFtcw.controls.meter.label:SetDimensions(80, 26)
	BeltalowdaFtcw.controls.meter.label:SetAnchor(CENTER, BeltalowdaFtcw.controls.meter, CENTER, 0, 0)
	BeltalowdaFtcw.controls.meter.label:SetFont(BeltalowdaFtcw.config.fontDistance)
	BeltalowdaFtcw.controls.meter.label:SetText("")
	BeltalowdaFtcw.controls.meter.label:SetHorizontalAlignment(TEXT_ALIGN_CENTER) 
	BeltalowdaFtcw.controls.meter.label:SetColor(BeltalowdaFtcw.ftcwVars.distanceColor.r, BeltalowdaFtcw.ftcwVars.distanceColor.g, BeltalowdaFtcw.ftcwVars.distanceColor.b)
	
	
	
	--Warning Display
	BeltalowdaFtcw.controls.TLW_Warning = wm:CreateTopLevelWindow(BeltalowdaFtcw.constants.TLW_WARNING_NAME)
	BeltalowdaFtcw.controls.TLW_Warning:SetDimensions(600, 60)

		
	BeltalowdaFtcw.controls.TLW_Warning:SetClampedToScreen(BeltalowdaFtcw.config.isClampedToScreen)
	BeltalowdaFtcw.controls.TLW_Warning:SetDrawLayer(0)
	BeltalowdaFtcw.controls.TLW_Warning:SetDrawLevel(0)
	BeltalowdaFtcw.controls.TLW_Warning:SetHandler("OnMoveStop", BeltalowdaFtcw.SaveWindowLocation)
	
	BeltalowdaFtcw.controls.warning = wm:CreateControl(nil, BeltalowdaFtcw.controls.TLW_Warning, CT_CONTROL)
	BeltalowdaFtcw.controls.warning:SetDimensions(600, 60)
	BeltalowdaFtcw.controls.warning:SetAnchor(TOPLEFT, BeltalowdaFtcw.controls.TLW_Warning, TOPLEFT, 0, 0)
	
	BeltalowdaFtcw.controls.warning.movableBackdrop = wm:CreateControl(nil, BeltalowdaFtcw.controls.warning, CT_BACKDROP)
	
	BeltalowdaFtcw.controls.warning.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaFtcw.controls.warning, TOPLEFT, 0, 0)
	BeltalowdaFtcw.controls.warning.movableBackdrop:SetDimensions(600, 60)

	

	BeltalowdaFtcw.controls.warning.label = wm:CreateControl(nil, BeltalowdaFtcw.controls.warning.movableBackdrop, CT_LABEL)
	BeltalowdaFtcw.controls.warning.label:SetDimensions(580, 46)
	BeltalowdaFtcw.controls.warning.label:SetAnchor(CENTER, BeltalowdaFtcw.controls.warning, CENTER, 0, 0)
	BeltalowdaFtcw.controls.warning.label:SetFont(BeltalowdaFtcw.config.fontWarning)
	BeltalowdaFtcw.controls.warning.label:SetHorizontalAlignment(TEXT_ALIGN_CENTER) 
	BeltalowdaFtcw.controls.warning.label:SetText("")
	BeltalowdaFtcw.controls.warning.label:SetColor(BeltalowdaFtcw.ftcwVars.warningColor.r, BeltalowdaFtcw.ftcwVars.warningColor.g, BeltalowdaFtcw.ftcwVars.warningColor.b)
	
	BeltalowdaFtcw.SetTlwLocation()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaFtcw.SetFtcwPositionLocked)
	
	BeltalowdaFtcw.state.initialized = true
	BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
	BeltalowdaFtcw.SetMovable(not BeltalowdaFtcw.ftcwVars.positionLocked)
end

function BeltalowdaFtcw.SetTlwLocation()
	BeltalowdaFtcw.controls.TLW_Meter:ClearAnchors()
	if BeltalowdaFtcw.ftcwVars.distanceLocation == nil then
		BeltalowdaFtcw.controls.TLW_Meter:SetAnchor(CENTER, GuiRoot, CENTER, 0, 150)
	else
		BeltalowdaFtcw.controls.TLW_Meter:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaFtcw.ftcwVars.distanceLocation.x, BeltalowdaFtcw.ftcwVars.distanceLocation.y)
	end
	BeltalowdaFtcw.controls.TLW_Warning:ClearAnchors()
	if BeltalowdaFtcw.ftcwVars.warningLocation == nil then
		BeltalowdaFtcw.controls.TLW_Warning:SetAnchor(CENTER, GuiRoot, CENTER, 250, -250)
	else
		BeltalowdaFtcw.controls.TLW_Warning:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaFtcw.ftcwVars.warningLocation.x, BeltalowdaFtcw.ftcwVars.warningLocation.y)
	end
end

function BeltalowdaFtcw.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.distanceEnabled = true
	defaults.distanceBackdropEnabled = true
	defaults.warningsEnabled = true
	defaults.positionLocked = true
	defaults.warningColor = {}
	defaults.warningColor.r = 1
	defaults.warningColor.g = 0
	defaults.warningColor.b = 0
	defaults.distanceColor = {}
	defaults.distanceColor.r = 0
	defaults.distanceColor.g = 0
	defaults.distanceColor.b = 0
	defaults.distanceAlertColor = {}
	defaults.distanceAlertColor.r = 1
	defaults.distanceAlertColor.g = 0
	defaults.distanceAlertColor.b = 0
	defaults.maxDistance = 10
	defaults.ignoreDistance = 100
	defaults.pvpOnly = true
	return defaults
end

function BeltalowdaFtcw.SetEnabled(value)
	if BeltalowdaFtcw.state.initialized == true and value ~= nil then
		BeltalowdaFtcw.ftcwVars.enabled = value
		if value == true then
			if BeltalowdaFtcw.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcw.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaFtcw.OnPlayerActivated)
				
			end
			BeltalowdaFtcw.state.registredConsumers = true
		else
			if BeltalowdaFtcw.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcw.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaFtcw.state.registredConsumers = false
		end
		BeltalowdaFtcw.OnPlayerActivated()
	end
end

function BeltalowdaFtcw.SetBackdropColors()
	if BeltalowdaFtcw.ftcwVars.positionLocked == false then
		BeltalowdaFtcw.controls.meter.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaFtcw.controls.meter.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaFtcw.controls.warning.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaFtcw.controls.warning.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		if IsUnitGrouped("player") == true and BeltalowdaGroup.IsPlayerGroupLeader() == false then
			if BeltalowdaFtcw.ftcwVars.distanceBackdropEnabled == true and ( BeltalowdaFtcw.ftcwVars.pvpOnly == false or (BeltalowdaFtcw.ftcwVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()))then
				BeltalowdaFtcw.controls.meter.movableBackdrop:SetCenterColor(0.1, 0.1, 0.1, 0.3)
				BeltalowdaFtcw.controls.meter.movableBackdrop:SetEdgeColor(0.1, 0.1, 0.1, 0.0)
			else
				BeltalowdaFtcw.controls.meter.movableBackdrop:SetCenterColor(0.0, 0.0, 0.0, 0.0)
				BeltalowdaFtcw.controls.meter.movableBackdrop:SetEdgeColor(0.0, 0.0, 0.0, 0.0)
			end
		else
			BeltalowdaFtcw.controls.meter.movableBackdrop:SetCenterColor(0.0, 0.0, 0.0, 0.0)
			BeltalowdaFtcw.controls.meter.movableBackdrop:SetEdgeColor(0.0, 0.0, 0.0, 0.0)
		end
		BeltalowdaFtcw.controls.warning.movableBackdrop:SetCenterColor(0, 0, 0, 0.0)
		BeltalowdaFtcw.controls.warning.movableBackdrop:SetEdgeColor(0, 0, 0, 0.0)	
	end
end

function BeltalowdaFtcw.SetMovable(isMovable)
	BeltalowdaFtcw.ftcwVars.positionLocked = not isMovable
	BeltalowdaFtcw.controls.TLW_Meter:SetMovable(isMovable)
	BeltalowdaFtcw.controls.TLW_Meter:SetMouseEnabled(isMovable)
	BeltalowdaFtcw.controls.TLW_Warning:SetMovable(isMovable)
	BeltalowdaFtcw.controls.TLW_Warning:SetMouseEnabled(isMovable)
	BeltalowdaFtcw.SetBackdropColors()
end

function BeltalowdaFtcw.SetControlVisibility()
	local enabled = BeltalowdaFtcw.ftcwVars.enabled
	local pvpOnly = BeltalowdaFtcw.ftcwVars.pvpOnly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaFtcw.state.foreground == false then
			BeltalowdaFtcw.controls.TLW_Meter:SetHidden(BeltalowdaFtcw.state.activeLayerIndex > 2)
			BeltalowdaFtcw.controls.TLW_Warning:SetHidden(BeltalowdaFtcw.state.activeLayerIndex > 2)
		else
			BeltalowdaFtcw.controls.TLW_Meter:SetHidden(false)
			BeltalowdaFtcw.controls.TLW_Warning:SetHidden(false)
		end
	else
		BeltalowdaFtcw.controls.TLW_Meter:SetHidden(setHidden)
		BeltalowdaFtcw.controls.TLW_Warning:SetHidden(setHidden)
	end
	if BeltalowdaFtcw.ftcwVars.distanceEnabled == false then
		BeltalowdaFtcw.controls.TLW_Meter:SetHidden(true)
	end
	if BeltalowdaFtcw.ftcwVars.warningsEnabled == false then
		BeltalowdaFtcw.controls.TLW_Warning:SetHidden(true)
	end
end

--callbacks
function BeltalowdaFtcw.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		--BeltalowdaFtcw.SetEnabled(false)
		BeltalowdaFtcw.ftcwVars = currentProfile.group.ftcw
		if BeltalowdaFtcw.controls.meter ~= nil and BeltalowdaFtcw.controls.warning ~= nil then
			BeltalowdaFtcw.controls.meter.label:SetColor(BeltalowdaFtcw.ftcwVars.distanceColor.r, BeltalowdaFtcw.ftcwVars.distanceColor.g, BeltalowdaFtcw.ftcwVars.distanceColor.b)
			BeltalowdaFtcw.controls.warning.label:SetColor(BeltalowdaFtcw.ftcwVars.warningColor.r, BeltalowdaFtcw.ftcwVars.warningColor.g, BeltalowdaFtcw.ftcwVars.warningColor.b)
			BeltalowdaFtcw.SetMovable(not BeltalowdaFtcw.ftcwVars.positionLocked)
			BeltalowdaFtcw.SetTlwLocation()
		end
		
		BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
		
	end
end

function BeltalowdaFtcw.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaFtcw.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaFtcw.state.foreground = false
	end
	--hack?
	BeltalowdaFtcw.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaFtcw.SetControlVisibility()
end

function BeltalowdaFtcw.OnPlayerActivated(eventCode, initial)
	if BeltalowdaFtcw.ftcwVars.enabled == true and (BeltalowdaFtcw.ftcwVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaFtcw.ftcwVars.pvpOnly == false) then
		if BeltalowdaFtcw.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcw.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaFtcw.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcw.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaFtcw.SetForegroundVisibility)
			Beltalowda.util.group.AddFeature(BeltalowdaFtcw.callbackName, Beltalowda.util.group.features.FEATURE_GROUP_LEADER_DISTANCE, BeltalowdaFtcw.config.updateInterval)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaFtcw.callbackName, BeltalowdaFtcw.config.updateInterval, BeltalowdaFtcw.OnUpdate)
			BeltalowdaFtcw.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaFtcw.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcw.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcw.callbackName, EVENT_ACTION_LAYER_PUSHED)
			Beltalowda.util.group.RemoveFeature(BeltalowdaFtcw.callbackName, Beltalowda.util.group.features.FEATURE_GROUP_LEADER_DISTANCE)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaFtcw.callbackName)
			BeltalowdaFtcw.state.registredActiveConsumers = false
		end
	end
	BeltalowdaFtcw.SetControlVisibility()
end

function BeltalowdaFtcw.OnUpdate()
	if IsUnitGrouped("player") == true and BeltalowdaGroup.IsPlayerGroupLeader() == false and ( BeltalowdaFtcw.ftcwVars.pvpOnly == false or (BeltalowdaFtcw.ftcwVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea())) then
		local distance = Beltalowda.util.group.GetLeaderDistance()
		--d(distance)
		if distance ~= nil then
			if distance > BeltalowdaFtcw.ftcwVars.maxDistance and distance < BeltalowdaFtcw.ftcwVars.ignoreDistance then
				BeltalowdaFtcw.controls.warning.label:SetText(BeltalowdaFtcw.constants.FTCW_MAX_DISTANCE)
				BeltalowdaFtcw.controls.meter.label:SetColor(BeltalowdaFtcw.ftcwVars.distanceAlertColor.r, BeltalowdaFtcw.ftcwVars.distanceAlertColor.g, BeltalowdaFtcw.ftcwVars.distanceAlertColor.b)
			else
				BeltalowdaFtcw.controls.warning.label:SetText("")
				BeltalowdaFtcw.controls.meter.label:SetColor(BeltalowdaFtcw.ftcwVars.distanceColor.r, BeltalowdaFtcw.ftcwVars.distanceColor.g, BeltalowdaFtcw.ftcwVars.distanceColor.b)
			end
			local unit = "m"
			if distance >= 1000 then
				distance = distance / 1000
				unit = "km"
			end
			BeltalowdaFtcw.controls.meter.label:SetText(string.format("%.1f %s", distance, unit))
		end
	else
		BeltalowdaFtcw.controls.meter.label:SetText("")
		BeltalowdaFtcw.controls.warning.label:SetText("")
	end
	BeltalowdaFtcw.SetBackdropColors()
end

function BeltalowdaFtcw.SaveWindowLocation()
	if BeltalowdaFtcw.ftcwVars.positionLocked == false then
		BeltalowdaFtcw.ftcwVars.warningLocation = BeltalowdaFtcw.ftcwVars.warningLocation or {}
		BeltalowdaFtcw.ftcwVars.warningLocation.x = BeltalowdaFtcw.controls.TLW_Warning:GetLeft()
		BeltalowdaFtcw.ftcwVars.warningLocation.y = BeltalowdaFtcw.controls.TLW_Warning:GetTop()
		
		BeltalowdaFtcw.ftcwVars.distanceLocation = BeltalowdaFtcw.ftcwVars.distanceLocation or {}
		BeltalowdaFtcw.ftcwVars.distanceLocation.x = BeltalowdaFtcw.controls.TLW_Meter:GetLeft()
		BeltalowdaFtcw.ftcwVars.distanceLocation.y = BeltalowdaFtcw.controls.TLW_Meter:GetTop()
	end
end

--menu interaction
function BeltalowdaFtcw.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.FTCW_HEADER,
			--width = "full",
			controls = {

				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_ENABLED,
					getFunc = BeltalowdaFtcw.GetFtcwEnabled,
					setFunc = BeltalowdaFtcw.SetFtcwEnabled,
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_PVP_ONLY,
					getFunc = BeltalowdaFtcw.GetFtcwPvpOnly,
					setFunc = BeltalowdaFtcw.SetFtcwPvpOnly,
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_WARNINGS_ENABLED,
					getFunc = BeltalowdaFtcw.GetFtcwWarningsEnabled,
					setFunc = BeltalowdaFtcw.SetFtcwWarningsEnabled,
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_DISTANCE_ENABLED,
					getFunc = BeltalowdaFtcw.GetFtcwDistanceEnabled,
					setFunc = BeltalowdaFtcw.SetFtcwDistanceEnabled,
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_DISTANCE_BACKDROP_ENABLED,
					getFunc = BeltalowdaFtcw.GetFtcwDistanceBackdropEnabled,
					setFunc = BeltalowdaFtcw.SetFtcwDistanceBackdropEnabled,
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCW_POSITION_FIXED,
					getFunc = BeltalowdaFtcw.GetFtcwPositionLocked,
					setFunc = BeltalowdaFtcw.SetFtcwPositionLocked,
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCW_DISTANCE,
					min = 0,
					max = 25,
					step = 1,
					getFunc = BeltalowdaFtcw.GetFtcwMaxDistance,
					setFunc = BeltalowdaFtcw.SetFtcwMaxDistance,
					width = "full",
					default = 8
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCW_IGNORE_DISTANCE,
					min = 100,
					max = 1000,
					step = 1,
					getFunc = BeltalowdaFtcw.GetFtcwIgnoreDistance,
					setFunc = BeltalowdaFtcw.SetFtcwIgnoreDistance,
					width = "full",
					default = 100
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCW_WARNING_COLOR,
					getFunc = BeltalowdaFtcw.GetFtcwWarningColor,
					setFunc = BeltalowdaFtcw.SetFtcwWarningColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_NORMAL,
					getFunc = BeltalowdaFtcw.GetFtcwDistanceColor,
					setFunc = BeltalowdaFtcw.SetFtcwDistanceColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_ALERT,
					getFunc = BeltalowdaFtcw.GetFtcwDistanceAlertColor,
					setFunc = BeltalowdaFtcw.SetFtcwDistanceAlertColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaFtcw.GetFtcwEnabled()
	return BeltalowdaFtcw.ftcwVars.enabled
end

function BeltalowdaFtcw.SetFtcwEnabled(value)
	BeltalowdaFtcw.SetEnabled(value)
end

function BeltalowdaFtcw.GetFtcwPvpOnly()
	return BeltalowdaFtcw.ftcwVars.pvpOnly
end

function BeltalowdaFtcw.SetFtcwPvpOnly(value)
	BeltalowdaFtcw.ftcwVars.pvpOnly = value
	BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
end

function BeltalowdaFtcw.GetFtcwWarningsEnabled()
	return BeltalowdaFtcw.ftcwVars.warningsEnabled
end

function BeltalowdaFtcw.SetFtcwWarningsEnabled(value)
	BeltalowdaFtcw.ftcwVars.warningsEnabled = value
	BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
end

function BeltalowdaFtcw.GetFtcwDistanceEnabled()
	return BeltalowdaFtcw.ftcwVars.distanceEnabled
end

function BeltalowdaFtcw.SetFtcwDistanceEnabled(value)
	BeltalowdaFtcw.ftcwVars.distanceEnabled = value
	BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
end

function BeltalowdaFtcw.GetFtcwDistanceBackdropEnabled()
	return BeltalowdaFtcw.ftcwVars.distanceBackdropEnabled
end

function BeltalowdaFtcw.SetFtcwDistanceBackdropEnabled(value)
	BeltalowdaFtcw.ftcwVars.distanceBackdropEnabled = value
	BeltalowdaFtcw.SetEnabled(BeltalowdaFtcw.ftcwVars.enabled)
end

function BeltalowdaFtcw.GetFtcwPositionLocked()
	return BeltalowdaFtcw.ftcwVars.positionLocked
end

function BeltalowdaFtcw.SetFtcwPositionLocked(value)
	BeltalowdaFtcw.SetMovable(not value)
end

function BeltalowdaFtcw.GetFtcwMaxDistance()
	return BeltalowdaFtcw.ftcwVars.maxDistance
end

function BeltalowdaFtcw.SetFtcwMaxDistance(value)
	BeltalowdaFtcw.ftcwVars.maxDistance = value
end

function BeltalowdaFtcw.GetFtcwIgnoreDistance()
	return BeltalowdaFtcw.ftcwVars.ignoreDistance
end

function BeltalowdaFtcw.SetFtcwIgnoreDistance(value)
	BeltalowdaFtcw.ftcwVars.ignoreDistance = value
end

function BeltalowdaFtcw.GetFtcwWarningColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcw.ftcwVars.warningColor)
end

function BeltalowdaFtcw.SetFtcwWarningColor(r, g, b)
	BeltalowdaFtcw.ftcwVars.warningColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaFtcw.controls.warning.label:SetColor(r, g, b)
end

function BeltalowdaFtcw.GetFtcwDistanceColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcw.ftcwVars.distanceColor)
end

function BeltalowdaFtcw.SetFtcwDistanceColor(r, g, b)
	BeltalowdaFtcw.ftcwVars.distanceColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaFtcw.controls.meter.label:SetColor(r, g, b)
end

function BeltalowdaFtcw.GetFtcwDistanceAlertColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcw.ftcwVars.distanceAlertColor)
end

function BeltalowdaFtcw.SetFtcwDistanceAlertColor(r, g, b)
	BeltalowdaFtcw.ftcwVars.distanceAlertColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end



--Follow The Crown Warnings

--[[
function BeltalowdaMenu.GetFtcwWarningColor()
	local color = BeltalowdaFtcw.GetFtcwWarningColor()
	return color.r, color.g, color.b
end

function BeltalowdaMenu.SetFtcwWarningColor(r, g, b, a)
	local color = {}
	color.r = r
	color.g = g
	color.b = b
	BeltalowdaFtcw.SetFtcwWarningColor(color)
end

function BeltalowdaMenu.GetFtcwDistanceColor()
	local color = BeltalowdaFtcw.GetFtcwDistanceColor()
	return color.r, color.g, color.b
end

function BeltalowdaMenu.SetFtcwDistanceColor(r, g, b, a)
	local color = {}
	color.r = r
	color.g = g
	color.b = b
	BeltalowdaFtcw.SetFtcwDistanceColor(color)
end

function BeltalowdaMenu.GetFtcwDistanceAlertColor()
	local color = BeltalowdaFtcw.GetFtcwDistanceAlertColor()
	return color.r, color.g, color.b
end

function BeltalowdaMenu.SetFtcwDistanceAlertColor(r, g, b, a)
	local color = {}
	color.r = r
	color.g = g
	color.b = b
	BeltalowdaFtcw.SetFtcwDistanceAlertColor(color)
end
]]