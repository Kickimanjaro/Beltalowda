-- RdK Group Rapid Tracker
-- By @s0rdrak (PC / EU)

Beltalowda.group.rt = Beltalowda.group.rt or {}
local BeltalowdaRt = Beltalowda.group.rt
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group

BeltalowdaRt.constants = BeltalowdaRt.constants or {}
BeltalowdaRt.constants.TLW_NAME = "Beltalowda.group.tr.TLW"

BeltalowdaRt.callbackName = Beltalowda.addonName .. "RapidTracker"

BeltalowdaRt.config = {}
BeltalowdaRt.config.updateInterval = 100
BeltalowdaRt.config.isClampedToScreen = true
BeltalowdaRt.config.font = "ZoFontGameSmall"

BeltalowdaRt.state = {}
BeltalowdaRt.state.initialized = false
BeltalowdaRt.state.foreground = true
BeltalowdaRt.state.registeredConsumer = false
BeltalowdaRt.state.registredActiveConsumers = false
BeltalowdaRt.state.activeLayerIndex = 1

BeltalowdaRt.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaRt.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaRt.callbackName, BeltalowdaRt.OnProfileChanged)
	
	BeltalowdaRt.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaRt.SetRtPositionLocked)
	
	BeltalowdaRt.state.initialized = true
	BeltalowdaRt.AdjustColors()
	BeltalowdaRt.SetEnabled(BeltalowdaRt.rtVars.enabled)
	BeltalowdaRt.SetMovable(not BeltalowdaRt.rtVars.positionLocked)

	--EVENT_MANAGER:RegisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaRt.SetVisible)
	--EVENT_MANAGER:RegisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaRt.SetVisible)

end

function BeltalowdaRt.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvponly = true
	defaults.colors = {}
	defaults.colors.inRange = {}
	defaults.colors.inRange.r = 0
	defaults.colors.inRange.g = 1
	defaults.colors.inRange.b = 0
	defaults.colors.outOfRange = {}
	defaults.colors.outOfRange.r = 1
	defaults.colors.outOfRange.g = 1
	defaults.colors.outOfRange.b = 1
	defaults.colors.notInRange = {}
	defaults.colors.notInRange.r = 1
	defaults.colors.notInRange.g = 0
	defaults.colors.notInRange.b = 0
	defaults.colors.rapidOn = {}
	defaults.colors.rapidOn.r = 0
	defaults.colors.rapidOn.g = 1
	defaults.colors.rapidOn.b = 0
	defaults.colors.rapidOff = {}
	defaults.colors.rapidOff.r = 1
	defaults.colors.rapidOff.g = 0
	defaults.colors.rapidOff.b = 0
	defaults.positionLocked = true
	return defaults
end

function BeltalowdaRt.SetEnabled(value)
	if BeltalowdaRt.state.initialized == true and value ~= nil then
		BeltalowdaRt.rtVars.enabled = value
		if value == true then
			if BeltalowdaRt.state.registeredConsumer == false then

				EVENT_MANAGER:RegisterForEvent(BeltalowdaRt.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaRt.OnPlayerActivated)
				
				BeltalowdaRt.state.registeredConsumer = true
			end
		else
			if BeltalowdaRt.state.registeredConsumer == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaRt.callbackName, EVENT_PLAYER_ACTIVATED)
				
				BeltalowdaRt.state.registeredConsumer = false
			end
		end
		BeltalowdaRt.OnPlayerActivated()
	end
end

function BeltalowdaRt.CreatePlayerControl(parent, offsetHeight, offsetWidth, height, labelWidth, countWidth)
	local playerControl = wm:CreateControl(nil, parent, CT_CONTROL)
	playerControl:SetAnchor(TOPLEFT, parent, TOPLEFT, offsetWidth, offsetHeight)
	playerControl:SetDimensions(labelWidth + countWidth, height)
	playerControl:SetHidden(true)
	
	playerControl.playerLabel = wm:CreateControl(nil, playerControl, CT_LABEL)
	playerControl.playerLabel:SetDimensions(labelWidth, height)
	playerControl.playerLabel:SetAnchor(TOPLEFT, playerControl, TOPLEFT, 0, 0)
	playerControl.playerLabel:SetFont(BeltalowdaRt.config.font)
	playerControl.playerLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT) 
	playerControl.playerLabel:SetText("")
	
	
	playerControl.majorExpeditionStatus = wm:CreateControl(nil, playerControl, CT_BACKDROP)
	playerControl.majorExpeditionStatus:SetDimensions(countWidth, height)
	playerControl.majorExpeditionStatus:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth, 3)
	
	playerControl.majorExpeditionStatusbar = wm:CreateControl(nil, playerControl, CT_STATUSBAR)
	playerControl.majorExpeditionStatusbar:SetDimensions(countWidth, height)
	playerControl.majorExpeditionStatusbar:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth, 3)
	playerControl.majorExpeditionStatusbar:SetMinMax(0, 100)
	playerControl.majorExpeditionStatusbar:SetValue(0)
	
	playerControl.minorExpeditionStatus = wm:CreateControl(nil, playerControl, CT_BACKDROP)
	playerControl.minorExpeditionStatus:SetDimensions(countWidth, height)
	playerControl.minorExpeditionStatus:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 1 + (2 * 1), 3)
	
	playerControl.minorExpeditionStatusbar = wm:CreateControl(nil, playerControl, CT_STATUSBAR)
	playerControl.minorExpeditionStatusbar:SetDimensions(countWidth, height)
	playerControl.minorExpeditionStatusbar:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 1 + (2 * 1), 3)
	playerControl.minorExpeditionStatusbar:SetMinMax(0, 100)
	playerControl.minorExpeditionStatusbar:SetValue(0)
	
	--[[
	playerControl.rapidManeuverStatus = wm:CreateControl(nil, playerControl, CT_BACKDROP)
	playerControl.rapidManeuverStatus:SetDimensions(countWidth, height)
	playerControl.rapidManeuverStatus:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 2 + (2 * 2), 3)
	
	playerControl.rapidManeuverStatusbar = wm:CreateControl(nil, playerControl, CT_STATUSBAR)
	playerControl.rapidManeuverStatusbar:SetDimensions(countWidth, height)
	playerControl.rapidManeuverStatusbar:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 2 + (2 * 2), 3)
	playerControl.rapidManeuverStatusbar:SetMinMax(0, 100)
	playerControl.rapidManeuverStatusbar:SetValue(0)
	
	playerControl.chargingManeuverMinorStatus = wm:CreateControl(nil, playerControl, CT_BACKDROP)
	playerControl.chargingManeuverMinorStatus:SetDimensions(countWidth, height)
	playerControl.chargingManeuverMinorStatus:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 3 + (2 * 3), 3)
	
	playerControl.chargingManeuverMinorStatusbar = wm:CreateControl(nil, playerControl, CT_STATUSBAR)
	playerControl.chargingManeuverMinorStatusbar:SetDimensions(countWidth, height)
	playerControl.chargingManeuverMinorStatusbar:SetAnchor(TOPLEFT, playerControl, TOPLEFT, labelWidth + countWidth * 3 + (2 * 3), 3)
	playerControl.chargingManeuverMinorStatusbar:SetMinMax(0, 100)
	playerControl.chargingManeuverMinorStatusbar:SetValue(0)
	]]
	return playerControl
end

function BeltalowdaRt.SetTlwLocation()
	BeltalowdaRt.controls.TLW:ClearAnchors()
	if BeltalowdaRt.rtVars.location == nil then
		BeltalowdaRt.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 250, 150)
	else
		BeltalowdaRt.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaRt.rtVars.location.x, BeltalowdaRt.rtVars.location.y)
	end
end

function BeltalowdaRt.CreateUI()
	local height = 12 * 10 + 11 * 3
	local width = (2 * 85) + (4 * 20) + 10 + (3 * 2)
	BeltalowdaRt.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaRt.constants.TLW_NAME)
	
	BeltalowdaRt.SetTlwLocation()
	
		
	BeltalowdaRt.controls.TLW:SetClampedToScreen(BeltalowdaRt.config.isClampedToScreen)
	BeltalowdaRt.controls.TLW:SetDrawLayer(0)
	BeltalowdaRt.controls.TLW:SetDrawLevel(0)
	BeltalowdaRt.controls.TLW:SetHandler("OnMoveStop", BeltalowdaRt.SaveWindowLocation)
	BeltalowdaRt.controls.TLW:SetDimensions(width, height)
	BeltalowdaRt.controls.TLW:SetHidden(not BeltalowdaRt.rtVars.enabled)
	
	BeltalowdaRt.controls.tlwControl = wm:CreateControl(nil, BeltalowdaRt.controls.TLW, CT_CONTROL)
	BeltalowdaRt.controls.tlwControl:SetDimensions(width, height)
	BeltalowdaRt.controls.tlwControl:SetAnchor(TOPLEFT, BeltalowdaRt.controls.TLW, TOPLEFT, 0, 0)
	
	BeltalowdaRt.controls.tlwControl.movableBackdrop = wm:CreateControl(nil, BeltalowdaRt.controls.tlwControl, CT_BACKDROP)
	
	BeltalowdaRt.controls.tlwControl.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaRt.controls.tlwControl, TOPLEFT, 0, 0)
	BeltalowdaRt.controls.tlwControl.movableBackdrop:SetDimensions(width, height)
	
	BeltalowdaRt.controls.tlwControl.playerControls = {}
	
	for i = 1, 24 do
		local offset = 0
		if i > 12 then
			offset = 141
		end
		local itemIndex = i - 1
		if itemIndex > 11 then
			itemIndex = itemIndex - 12
		end
		BeltalowdaRt.controls.tlwControl.playerControls[i] = BeltalowdaRt.CreatePlayerControl(BeltalowdaRt.controls.tlwControl.movableBackdrop, itemIndex * (10 + 3), offset, 10, 85, 20)
	end
end

function BeltalowdaRt.AdjustColors()
	for i = 1, #BeltalowdaRt.controls.tlwControl.playerControls do
		BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		--[[
		BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		]]
		BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatusbar:SetColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatusbar:SetColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		--[[
		BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatusbar:SetColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatusbar:SetColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		]]
	end
end

function BeltalowdaRt.SetMovable(isMovable)
	BeltalowdaRt.rtVars.positionLocked = not isMovable
	BeltalowdaRt.controls.TLW:SetMovable(isMovable)
	BeltalowdaRt.controls.TLW:SetMouseEnabled(isMovable)
	BeltalowdaRt.SetBackdropColors()
end


function BeltalowdaRt.SetBackdropColors()
	if BeltalowdaRt.rtVars.positionLocked == false then
		BeltalowdaRt.controls.tlwControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaRt.controls.tlwControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaRt.controls.tlwControl.movableBackdrop:SetCenterColor(0, 0, 0, 0.0)
		BeltalowdaRt.controls.tlwControl.movableBackdrop:SetEdgeColor(0, 0, 0, 0.0)	
	end
end

function BeltalowdaRt.AdjustRapidControl(control, buff, currentTime)
	
	if buff.active == true then
		local uptimeLeft = buff.ending - currentTime
		if uptimeLeft < 0 then
			uptimeLeft = 0
		end
		--d(buffUp)
		--control:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		--control:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOn.r, BeltalowdaRt.rtVars.colors.rapidOn.g, BeltalowdaRt.rtVars.colors.rapidOn.b)
		control:SetValue(uptimeLeft / buff.uptime * 100)
		--d(control:GetValue())
	else
		--control:SetCenterColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		--control:SetEdgeColor(BeltalowdaRt.rtVars.colors.rapidOff.r, BeltalowdaRt.rtVars.colors.rapidOff.g, BeltalowdaRt.rtVars.colors.rapidOff.b)
		control:SetValue(0)
	end

end

function BeltalowdaRt.SetControlVisibility()
	local enabled = BeltalowdaRt.rtVars.enabled
	local pvpOnly = BeltalowdaRt.rtVars.pvponly
	local positionLocked = BeltalowdaRt.rtVars.positionLocked
	local setHidden = true
	
	-- Always show if position is unlocked (moving elements)
	if positionLocked == false then
		setHidden = false
	elseif enabled ~= nil and pvpOnly ~= nil then
		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	BeltalowdaRt.controls.TLW:SetHidden(setHidden)
end

--callbacks
function BeltalowdaRt.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaRt.rtVars = currentProfile.group.rt
		if BeltalowdaRt.state.initialized == true then
			BeltalowdaRt.SetMovable(not BeltalowdaRt.rtVars.positionLocked)
			BeltalowdaRt.SetTlwLocation()
			BeltalowdaRt.AdjustColors()
		end
		BeltalowdaRt.SetEnabled(BeltalowdaRt.rtVars.enabled)
		
	end
end

function BeltalowdaRt.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaRt.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaRt.state.foreground = false
	end
	--hack?
	BeltalowdaRt.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaRt.SetControlVisibility()
end

function BeltalowdaRt.OnPlayerActivated(eventCode, initial)
	if BeltalowdaRt.rtVars.enabled == true and (BeltalowdaRt.rtVars.pvponly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaRt.rtVars.pvponly == false) then
		if BeltalowdaRt.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaRt.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaRt.SetForegroundVisibility)
			BeltalowdaGroup.AddFeature(BeltalowdaRt.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaRt.config.updateInterval)
			BeltalowdaGroup.AddFeature(BeltalowdaRt.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaRt.config.updateInterval)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaRt.callbackName, BeltalowdaRt.config.updateInterval, BeltalowdaRt.OnUpdate)
			
			BeltalowdaRt.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaRt.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaRt.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaGroup.RemoveFeature(BeltalowdaRt.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaGroup.RemoveFeature(BeltalowdaRt.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRt.callbackName)
			
			BeltalowdaRt.state.registredActiveConsumers = false
		end
	end
	BeltalowdaRt.SetControlVisibility()
end

function BeltalowdaRt.OnUpdate()
	
	if BeltalowdaRt.rtVars.enabled then
		local pvpZone = BeltalowdaUtil.IsInPvPArea()
		if BeltalowdaRt.rtVars.pvponly == true and pvpZone == true or BeltalowdaRt.rtVars.pvponly == false then
			local players = BeltalowdaGroup.GetGroupInformation()
			local currentTime = GetGameTimeMilliseconds() / 1000
			--temp = players
			if players ~= nil then

				for i = 1, #players do
					local buffs = players[i].buffs
					if buffs ~= nil and buffs.specialInformation ~= nil then
						BeltalowdaRt.AdjustRapidControl(BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatusbar, buffs.specialInformation.majorExpeditionOn, currentTime)
						BeltalowdaRt.AdjustRapidControl(BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatusbar, buffs.specialInformation.minorExpeditionOn, currentTime)
						--[[
						BeltalowdaRt.AdjustRapidControl(BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatusbar, buffs.specialInformation.rapidManeuverOn, currentTime)
						BeltalowdaRt.AdjustRapidControl(BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatusbar, buffs.specialInformation.chargingManeuverMinorOn, currentTime)
						]]
						
					end
					
					local distance = players[i].distances.fromPlayer
					if distance == nil then
						distance = 0
					end
					if distance <= 20 then
						BeltalowdaRt.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaRt.rtVars.colors.inRange.r, BeltalowdaRt.rtVars.colors.inRange.g, BeltalowdaRt.rtVars.colors.inRange.b)
					elseif distance > 20 and distance < 100 then
						BeltalowdaRt.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaRt.rtVars.colors.notInRange.r, BeltalowdaRt.rtVars.colors.notInRange.g, BeltalowdaRt.rtVars.colors.notInRange.b)
					else
						BeltalowdaRt.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b)
						--BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b)
						--BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b)
					end
					BeltalowdaRt.controls.tlwControl.playerControls[i].playerLabel:SetText(players[i].name)
					BeltalowdaRt.controls.tlwControl.playerControls[i]:SetHidden(false)
				end
				for i = #players + 1, 24 do
					BeltalowdaRt.controls.tlwControl.playerControls[i]:SetHidden(true)
					BeltalowdaRt.controls.tlwControl.playerControls[i].playerLabel:SetText("")
					--BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetCenterColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
					--BeltalowdaRt.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetEdgeColor(BeltalowdaRt.rtVars.colors.outOfRange.r, BeltalowdaRt.rtVars.colors.outOfRange.g, BeltalowdaRt.rtVars.colors.outOfRange.b, 0)
				end
				
				if BeltalowdaRt.state.foreground == true then
					BeltalowdaRt.controls.TLW:SetHidden(false)
				end
			end
		else
			BeltalowdaRt.controls.TLW:SetHidden(true)
		end
	else
		BeltalowdaRt.controls.TLW:SetHidden(true)
	end
end

--[[
function BeltalowdaRt.SetVisible(eventCode, layerIndex, activeLayerIndex)
	local pvpZone = BeltalowdaUtil.IsInPvPArea()
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaRt.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaRt.state.foreground = false
	end
	if BeltalowdaRt.rtVars.enabled == true and (BeltalowdaRt.rtVars.pvponly == true and pvpZone == true or BeltalowdaRt.rtVars.pvponly == false) then
		BeltalowdaRt.controls.TLW:SetHidden(activeLayerIndex > 2)
	else
		BeltalowdaRt.controls.TLW:SetHidden(true)
	end
end
]]

function BeltalowdaRt.SaveWindowLocation()
	if BeltalowdaRt.rtVars.positionLocked == false then
		BeltalowdaRt.rtVars.location = BeltalowdaRt.rtVars.location or {}
		BeltalowdaRt.rtVars.location.x = BeltalowdaRt.controls.TLW:GetLeft()
		BeltalowdaRt.rtVars.location.y = BeltalowdaRt.controls.TLW:GetTop()
	end
end

-- Note: Menu functions (GetMenu and all Get*/Set* functions) have been moved to
-- Base/Features/Positioning.lua as part of Phase 2 refactoring.
-- Core implementation remains here.
