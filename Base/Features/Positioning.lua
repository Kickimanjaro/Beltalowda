-- Beltalowda Positioning Assistance
-- By @Kickimanjaro
-- Fully self-contained module for tracking Expedition buffs for speed coordination
-- Migrated from Positioning.lua in Phase 3 Milestone 2

Beltalowda.features.positioning = Beltalowda.features.positioning or {}
local BeltalowdaPositioning = Beltalowda.features.positioning
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group

BeltalowdaPositioning.constants = BeltalowdaPositioning.constants or {}
BeltalowdaPositioning.constants.TLW_NAME = "Beltalowda.features.positioning.TLW"

BeltalowdaPositioning.callbackName = Beltalowda.addonName .. "Positioning"

BeltalowdaPositioning.config = {}
BeltalowdaPositioning.config.updateInterval = 100
BeltalowdaPositioning.config.isClampedToScreen = true
BeltalowdaPositioning.config.font = "ZoFontGameSmall"

BeltalowdaPositioning.state = {}
BeltalowdaPositioning.state.initialized = false
BeltalowdaPositioning.state.foreground = true
BeltalowdaPositioning.state.registeredConsumer = false
BeltalowdaPositioning.state.registredActiveConsumers = false
BeltalowdaPositioning.state.activeLayerIndex = 1

BeltalowdaPositioning.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaPositioning.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaPositioning.callbackName, BeltalowdaPositioning.OnProfileChanged)
	
	BeltalowdaPositioning.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaPositioning.SetRtPositionLocked)
	
	BeltalowdaPositioning.state.initialized = true
	BeltalowdaPositioning.AdjustColors()
	BeltalowdaPositioning.SetEnabled(BeltalowdaPositioning.vars.enabled)
	BeltalowdaPositioning.SetMovable(not BeltalowdaPositioning.vars.positionLocked)

	--EVENT_MANAGER:RegisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaPositioning.SetVisible)
	--EVENT_MANAGER:RegisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaPositioning.SetVisible)

end

function BeltalowdaPositioning.GetDefaults()
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

function BeltalowdaPositioning.SetEnabled(value)
	if BeltalowdaPositioning.state.initialized == true and value ~= nil then
		BeltalowdaPositioning.vars.enabled = value
		if value == true then
			if BeltalowdaPositioning.state.registeredConsumer == false then

				EVENT_MANAGER:RegisterForEvent(BeltalowdaPositioning.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaPositioning.OnPlayerActivated)
				
				BeltalowdaPositioning.state.registeredConsumer = true
			end
		else
			if BeltalowdaPositioning.state.registeredConsumer == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaPositioning.callbackName, EVENT_PLAYER_ACTIVATED)
				
				BeltalowdaPositioning.state.registeredConsumer = false
			end
		end
		BeltalowdaPositioning.OnPlayerActivated()
	end
end

function BeltalowdaPositioning.CreatePlayerControl(parent, offsetHeight, offsetWidth, height, labelWidth, countWidth)
	local playerControl = wm:CreateControl(nil, parent, CT_CONTROL)
	playerControl:SetAnchor(TOPLEFT, parent, TOPLEFT, offsetWidth, offsetHeight)
	playerControl:SetDimensions(labelWidth + countWidth, height)
	playerControl:SetHidden(true)
	
	playerControl.playerLabel = wm:CreateControl(nil, playerControl, CT_LABEL)
	playerControl.playerLabel:SetDimensions(labelWidth, height)
	playerControl.playerLabel:SetAnchor(TOPLEFT, playerControl, TOPLEFT, 0, 0)
	playerControl.playerLabel:SetFont(BeltalowdaPositioning.config.font)
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

function BeltalowdaPositioning.SetTlwLocation()
	BeltalowdaPositioning.controls.TLW:ClearAnchors()
	if BeltalowdaPositioning.vars.location == nil then
		BeltalowdaPositioning.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 250, 150)
	else
		BeltalowdaPositioning.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaPositioning.vars.location.x, BeltalowdaPositioning.vars.location.y)
	end
end

function BeltalowdaPositioning.CreateUI()
	local height = 12 * 10 + 11 * 3
	local width = (2 * 85) + (4 * 20) + 10 + (3 * 2)
	BeltalowdaPositioning.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaPositioning.constants.TLW_NAME)
	
	BeltalowdaPositioning.SetTlwLocation()
	
		
	BeltalowdaPositioning.controls.TLW:SetClampedToScreen(BeltalowdaPositioning.config.isClampedToScreen)
	BeltalowdaPositioning.controls.TLW:SetDrawLayer(0)
	BeltalowdaPositioning.controls.TLW:SetDrawLevel(0)
	BeltalowdaPositioning.controls.TLW:SetHandler("OnMoveStop", BeltalowdaPositioning.SaveWindowLocation)
	BeltalowdaPositioning.controls.TLW:SetDimensions(width, height)
	BeltalowdaPositioning.controls.TLW:SetHidden(not BeltalowdaPositioning.vars.enabled)
	
	BeltalowdaPositioning.controls.tlwControl = wm:CreateControl(nil, BeltalowdaPositioning.controls.TLW, CT_CONTROL)
	BeltalowdaPositioning.controls.tlwControl:SetDimensions(width, height)
	BeltalowdaPositioning.controls.tlwControl:SetAnchor(TOPLEFT, BeltalowdaPositioning.controls.TLW, TOPLEFT, 0, 0)
	
	BeltalowdaPositioning.controls.tlwControl.movableBackdrop = wm:CreateControl(nil, BeltalowdaPositioning.controls.tlwControl, CT_BACKDROP)
	
	BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaPositioning.controls.tlwControl, TOPLEFT, 0, 0)
	BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetDimensions(width, height)
	
	BeltalowdaPositioning.controls.tlwControl.playerControls = {}
	
	for i = 1, 24 do
		local offset = 0
		if i > 12 then
			offset = 141
		end
		local itemIndex = i - 1
		if itemIndex > 11 then
			itemIndex = itemIndex - 12
		end
		BeltalowdaPositioning.controls.tlwControl.playerControls[i] = BeltalowdaPositioning.CreatePlayerControl(BeltalowdaPositioning.controls.tlwControl.movableBackdrop, itemIndex * (10 + 3), offset, 10, 85, 20)
	end
end

function BeltalowdaPositioning.AdjustColors()
	for i = 1, #BeltalowdaPositioning.controls.tlwControl.playerControls do
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		--[[
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		]]
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatusbar:SetColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatusbar:SetColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		--[[
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatusbar:SetColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatusbar:SetColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		]]
	end
end

function BeltalowdaPositioning.SetMovable(isMovable)
	BeltalowdaPositioning.vars.positionLocked = not isMovable
	BeltalowdaPositioning.controls.TLW:SetMovable(isMovable)
	BeltalowdaPositioning.controls.TLW:SetMouseEnabled(isMovable)
	BeltalowdaPositioning.SetBackdropColors()
end


function BeltalowdaPositioning.SetBackdropColors()
	if BeltalowdaPositioning.vars.positionLocked == false then
		BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetCenterColor(0, 0, 0, 0.0)
		BeltalowdaPositioning.controls.tlwControl.movableBackdrop:SetEdgeColor(0, 0, 0, 0.0)	
	end
end

function BeltalowdaPositioning.AdjustRapidControl(control, buff, currentTime)
	
	if buff.active == true then
		local uptimeLeft = buff.ending - currentTime
		if uptimeLeft < 0 then
			uptimeLeft = 0
		end
		--d(buffUp)
		--control:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		--control:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOn.r, BeltalowdaPositioning.vars.colors.rapidOn.g, BeltalowdaPositioning.vars.colors.rapidOn.b)
		control:SetValue(uptimeLeft / buff.uptime * 100)
		--d(control:GetValue())
	else
		--control:SetCenterColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		--control:SetEdgeColor(BeltalowdaPositioning.vars.colors.rapidOff.r, BeltalowdaPositioning.vars.colors.rapidOff.g, BeltalowdaPositioning.vars.colors.rapidOff.b)
		control:SetValue(0)
	end

end

function BeltalowdaPositioning.SetControlVisibility()
	local enabled = BeltalowdaPositioning.vars.enabled
	local pvpOnly = BeltalowdaPositioning.vars.pvponly
	local positionLocked = BeltalowdaPositioning.vars.positionLocked
	local setHidden = true
	
	-- Always show if position is unlocked (moving elements)
	if positionLocked == false then
		setHidden = false
	elseif enabled ~= nil and pvpOnly ~= nil then
		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	BeltalowdaPositioning.controls.TLW:SetHidden(setHidden)
end

--callbacks
function BeltalowdaPositioning.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaPositioning.vars = currentProfile.group.rt
		if BeltalowdaPositioning.state.initialized == true then
			BeltalowdaPositioning.SetMovable(not BeltalowdaPositioning.vars.positionLocked)
			BeltalowdaPositioning.SetTlwLocation()
			BeltalowdaPositioning.AdjustColors()
		end
		BeltalowdaPositioning.SetEnabled(BeltalowdaPositioning.vars.enabled)
		
	end
end

function BeltalowdaPositioning.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaPositioning.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaPositioning.state.foreground = false
	end
	--hack?
	BeltalowdaPositioning.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaPositioning.SetControlVisibility()
end

function BeltalowdaPositioning.OnPlayerActivated(eventCode, initial)
	if BeltalowdaPositioning.vars.enabled == true and (BeltalowdaPositioning.vars.pvponly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaPositioning.vars.pvponly == false) then
		if BeltalowdaPositioning.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaPositioning.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaPositioning.SetForegroundVisibility)
			BeltalowdaGroup.AddFeature(BeltalowdaPositioning.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaPositioning.config.updateInterval)
			BeltalowdaGroup.AddFeature(BeltalowdaPositioning.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaPositioning.config.updateInterval)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaPositioning.callbackName, BeltalowdaPositioning.config.updateInterval, BeltalowdaPositioning.OnUpdate)
			
			BeltalowdaPositioning.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaPositioning.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaPositioning.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaGroup.RemoveFeature(BeltalowdaPositioning.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaGroup.RemoveFeature(BeltalowdaPositioning.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaPositioning.callbackName)
			
			BeltalowdaPositioning.state.registredActiveConsumers = false
		end
	end
	BeltalowdaPositioning.SetControlVisibility()
end

function BeltalowdaPositioning.OnUpdate()
	
	if BeltalowdaPositioning.vars.enabled then
		local pvpZone = BeltalowdaUtil.IsInPvPArea()
		if BeltalowdaPositioning.vars.pvponly == true and pvpZone == true or BeltalowdaPositioning.vars.pvponly == false then
			local players = BeltalowdaGroup.GetGroupInformation()
			local currentTime = GetGameTimeMilliseconds() / 1000
			--temp = players
			if players ~= nil then

				for i = 1, #players do
					local buffs = players[i].buffs
					if buffs ~= nil and buffs.specialInformation ~= nil then
						BeltalowdaPositioning.AdjustRapidControl(BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatusbar, buffs.specialInformation.majorExpeditionOn, currentTime)
						BeltalowdaPositioning.AdjustRapidControl(BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatusbar, buffs.specialInformation.minorExpeditionOn, currentTime)
						--[[
						BeltalowdaPositioning.AdjustRapidControl(BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatusbar, buffs.specialInformation.rapidManeuverOn, currentTime)
						BeltalowdaPositioning.AdjustRapidControl(BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatusbar, buffs.specialInformation.chargingManeuverMinorOn, currentTime)
						]]
						
					end
					
					local distance = players[i].distances.fromPlayer
					if distance == nil then
						distance = 0
					end
					if distance <= 20 then
						BeltalowdaPositioning.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaPositioning.vars.colors.inRange.r, BeltalowdaPositioning.vars.colors.inRange.g, BeltalowdaPositioning.vars.colors.inRange.b)
					elseif distance > 20 and distance < 100 then
						BeltalowdaPositioning.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaPositioning.vars.colors.notInRange.r, BeltalowdaPositioning.vars.colors.notInRange.g, BeltalowdaPositioning.vars.colors.notInRange.b)
					else
						BeltalowdaPositioning.controls.tlwControl.playerControls[i].playerLabel:SetColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b)
						--BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b)
						--BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b)
					end
					BeltalowdaPositioning.controls.tlwControl.playerControls[i].playerLabel:SetText(players[i].name)
					BeltalowdaPositioning.controls.tlwControl.playerControls[i]:SetHidden(false)
				end
				for i = #players + 1, 24 do
					BeltalowdaPositioning.controls.tlwControl.playerControls[i]:SetHidden(true)
					BeltalowdaPositioning.controls.tlwControl.playerControls[i].playerLabel:SetText("")
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].majorExpeditionStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].minorExpeditionStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].rapidManeuverStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetCenterColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
					--BeltalowdaPositioning.controls.tlwControl.playerControls[i].chargingManeuverMinorStatus:SetEdgeColor(BeltalowdaPositioning.vars.colors.outOfRange.r, BeltalowdaPositioning.vars.colors.outOfRange.g, BeltalowdaPositioning.vars.colors.outOfRange.b, 0)
				end
				
				if BeltalowdaPositioning.state.foreground == true then
					BeltalowdaPositioning.controls.TLW:SetHidden(false)
				end
			end
		else
			BeltalowdaPositioning.controls.TLW:SetHidden(true)
		end
	else
		BeltalowdaPositioning.controls.TLW:SetHidden(true)
	end
end

--[[
function BeltalowdaPositioning.SetVisible(eventCode, layerIndex, activeLayerIndex)
	local pvpZone = BeltalowdaUtil.IsInPvPArea()
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaPositioning.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaPositioning.state.foreground = false
	end
	if BeltalowdaPositioning.vars.enabled == true and (BeltalowdaPositioning.vars.pvponly == true and pvpZone == true or BeltalowdaPositioning.vars.pvponly == false) then
		BeltalowdaPositioning.controls.TLW:SetHidden(activeLayerIndex > 2)
	else
		BeltalowdaPositioning.controls.TLW:SetHidden(true)
	end
end
]]

function BeltalowdaPositioning.SaveWindowLocation()
	if BeltalowdaPositioning.vars.positionLocked == false then
		BeltalowdaPositioning.vars.location = BeltalowdaPositioning.vars.location or {}
		BeltalowdaPositioning.vars.location.x = BeltalowdaPositioning.controls.TLW:GetLeft()
		BeltalowdaPositioning.vars.location.y = BeltalowdaPositioning.controls.TLW:GetTop()
	end
end

-- Note: Menu functions (GetMenu and all Get*/Set* functions) have been moved to

-- ============================================================================
-- MENU FUNCTIONS (Phase 2 Migration - Now integrated)
-- ============================================================================

function BeltalowdaPositioning.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_ENABLED,
					getFunc = BeltalowdaPositioning.GetRtEnabled,
					setFunc = BeltalowdaPositioning.SetRtEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_PVP_ONLY,
					getFunc = BeltalowdaPositioning.GetRtPvpOnly,
					setFunc = BeltalowdaPositioning.SetRtPvpOnly,
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_POSITION_FIXED,
					getFunc = BeltalowdaPositioning.GetRtPositionLocked,
					setFunc = BeltalowdaPositioning.SetRtPositionLocked,
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_IN_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelInRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelInRange,
					width = "full"
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_NOT_IN_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelNotInRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelNotInRange,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_OUT_OF_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelOutOfRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelOutOfRange,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_RAPID_ON,
					getFunc = BeltalowdaPositioning.GetRtColorRapidOn,
					setFunc = BeltalowdaPositioning.SetRtColorRapidOn,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_RAPID_OFF,
					getFunc = BeltalowdaPositioning.GetRtColorRapidOff,
					setFunc = BeltalowdaPositioning.SetRtColorRapidOff,
					width = "full"
				},
			}		
		},
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaPositioning.GetRtEnabled()
	return BeltalowdaPositioning.vars.enabled
end

function BeltalowdaPositioning.SetRtEnabled(value)
	-- Directly update rtVars first (menu needs immediate update)
	BeltalowdaPositioning.vars.enabled = value
	-- Then call SetEnabled to handle event registration/unregistration
	BeltalowdaRT.SetEnabled(value)
	-- Ensure visibility is updated immediately (in case SetEnabled's guards prevent it)
	if BeltalowdaRT.SetControlVisibility then
		BeltalowdaRT.SetControlVisibility()
	end
end

function BeltalowdaPositioning.GetRtPvpOnly()
	return BeltalowdaPositioning.vars.pvponly
end

function BeltalowdaPositioning.SetRtPvpOnly(value)
	BeltalowdaPositioning.vars.pvponly = value
end

function BeltalowdaPositioning.GetRtPositionLocked()
	return BeltalowdaPositioning.vars.positionLocked
end

function BeltalowdaPositioning.SetRtPositionLocked(value)
	BeltalowdaRT.SetMovable(not value)
end

function BeltalowdaPositioning.GetRtColorLabelInRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPositioning.vars.colors.inRange)
end

function BeltalowdaPositioning.SetRtColorLabelInRange(r, g, b)
	BeltalowdaPositioning.vars.colors.inRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorLabelNotInRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPositioning.vars.colors.notInRange)
end

function BeltalowdaPositioning.SetRtColorLabelNotInRange(r, g, b)
	BeltalowdaPositioning.vars.colors.notInRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorLabelOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPositioning.vars.colors.outOfRange)
end

function BeltalowdaPositioning.SetRtColorLabelOutOfRange(r, g, b)
	BeltalowdaPositioning.vars.colors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorRapidOn()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPositioning.vars.colors.rapidOn)
end

function BeltalowdaPositioning.SetRtColorRapidOn(r, g, b)
	BeltalowdaPositioning.vars.colors.rapidOn = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPositioning.AdjustColors()
end

function BeltalowdaPositioning.GetRtColorRapidOff()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPositioning.vars.colors.rapidOff)
end

function BeltalowdaPositioning.SetRtColorRapidOff(r, g, b)
	BeltalowdaPositioning.vars.colors.rapidOff = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPositioning.AdjustColors()
end


-- Note: Fully self-contained module as of Phase 3 Milestone 2
-- Saved variables still reference currentProfile.group.rt for backward compatibility
