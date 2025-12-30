-- Beltalowda Yet another Compass
-- By @s0rdrak (PC / EU)

Beltalowda.compass = Beltalowda.compass or {}
Beltalowda.compass.sc = Beltalowda.compass.sc or {}
local BeltalowdaSC = Beltalowda.compass.sc
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaSC.callbackName = Beltalowda.addonName .. "CompassSC"


BeltalowdaSC.controls = {}

BeltalowdaSC.constants = BeltalowdaSC.constants or {}
BeltalowdaSC.constants.TLW_NAME = "Beltalowda.compass.sc.TLW"
BeltalowdaSC.constants.DIRECTION_NAME_NORTH = "north"
BeltalowdaSC.constants.DIRECTION_NAME_NORTH_EAST = "northEast"
BeltalowdaSC.constants.DIRECTION_NAME_EAST = "east"
BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_EAST = "southEast"
BeltalowdaSC.constants.DIRECTION_NAME_SOUTH = "south"
BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_WEST = "southWest"
BeltalowdaSC.constants.DIRECTION_NAME_WEST = "west"
BeltalowdaSC.constants.DIRECTION_NAME_NORTH_WEST = "northWest"

BeltalowdaSC.constants.PREFIX = "SC"

BeltalowdaSC.state = {}
BeltalowdaSC.state.initialized = false
BeltalowdaSC.state.registredConsumers = false
BeltalowdaSC.state.foreground = true
BeltalowdaSC.state.activeLayerIndex = 1
BeltalowdaSC.state.registredActiveConsumers = false
BeltalowdaSC.state.calc = {}

BeltalowdaSC.config = {}
BeltalowdaSC.config.isClampedToScreen = true
BeltalowdaSC.config.width = 300
BeltalowdaSC.config.height = 50
BeltalowdaSC.config.updateInterval = 10
BeltalowdaSC.config.borderAlpha = 0.1
BeltalowdaSC.config.anchorOffset = 35 --20
BeltalowdaSC.config.markerOffset = BeltalowdaSC.config.width / 3 * 1.1 --1.25
BeltalowdaSC.config.labelWidth = 75
BeltalowdaSC.config.markerSize = 15

local wm = GetWindowManager()


function BeltalowdaSC.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaSC.callbackName, BeltalowdaSC.OnProfileChanged)
	
	BeltalowdaSC.CreateUI()
	BeltalowdaSC.AdjustColors()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaSC.SetScPositionLocked)
	
	BeltalowdaSC.state.initialized = true
	BeltalowdaSC.SetEnabled(BeltalowdaSC.scVars.enabled)
	BeltalowdaSC.SetPositionLocked(BeltalowdaSC.scVars.positionLocked)
	
end

function BeltalowdaSC.CreateUI()
	BeltalowdaSC.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaSC.constants.TLW_NAME)
	
	BeltalowdaSC.SetTlwLocation()
	
	BeltalowdaSC.controls.TLW:SetClampedToScreen(BeltalowdaSC.config.isClampedToScreen)
	BeltalowdaSC.controls.TLW:SetHandler("OnMoveStop", BeltalowdaSC.SaveWindowLocation)
	BeltalowdaSC.controls.TLW:SetDimensions(BeltalowdaSC.config.width, BeltalowdaSC.config.height)
	
	BeltalowdaSC.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaSC.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaSC.controls.TLW.rootControl
	
	
	rootControl:SetDimensions(BeltalowdaSC.config.width, BeltalowdaSC.config.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaSC.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaSC.config.width, BeltalowdaSC.config.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.backdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	rootControl.backdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.backdrop:SetDimensions(BeltalowdaSC.config.width, BeltalowdaSC.config.height)
	
	rootControl.backdrop:SetCenterColor(BeltalowdaSC.scVars.colors.backdrop.r, BeltalowdaSC.scVars.colors.backdrop.g, BeltalowdaSC.scVars.colors.backdrop.b, BeltalowdaSC.scVars.colors.backdrop.a)
	local borderAlpha = BeltalowdaSC.scVars.colors.backdrop.a + BeltalowdaSC.config.borderAlpha
	if borderAlpha > 1.0 then
		borderAlpha = 1.0
	end
	rootControl.backdrop:SetEdgeColor(BeltalowdaSC.scVars.colors.backdrop.r, BeltalowdaSC.scVars.colors.backdrop.g, BeltalowdaSC.scVars.colors.backdrop.b, borderAlpha)
	rootControl.backdrop:SetEdgeTexture(nil, 2, 2, 2, 0)
	
	rootControl.compass = wm:CreateControl(nil, rootControl, CT_CONTROL)
	rootControl.compass:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.compass:SetDimensions(0, 0)
	--rootControl.compass:SetDimensions(BeltalowdaSC.config.width * 4, BeltalowdaSC.config.height)
	
	rootControl.compass.anchors = {}
	rootControl.compass.directions = {}
	rootControl.compass.directions.all = {}
	rootControl.compass.directions.north = {}
	rootControl.compass.directions.south = {}
	rootControl.compass.directions.west = {}
	rootControl.compass.directions.east = {}
	rootControl.compass.directions.others = {}
	
	local directions = {}
	directions[1] = {name = BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_WEST, category = "others", label = BeltalowdaSC.constants.SOUTH_WEST}
	directions[2] = {name = BeltalowdaSC.constants.DIRECTION_NAME_WEST, category = "west", label = BeltalowdaSC.constants.WEST}
	directions[3] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH_WEST, category = "others", label = BeltalowdaSC.constants.NORTH_WEST}
	directions[4] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH, category = "north", label = BeltalowdaSC.constants.NORTH}
	directions[5] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH_EAST, category = "others", label = BeltalowdaSC.constants.NORTH_EAST}
	directions[6] = {name = BeltalowdaSC.constants.DIRECTION_NAME_EAST, category = "east", label = BeltalowdaSC.constants.EAST}
	directions[7] = {name = BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_EAST, category = "others", label = BeltalowdaSC.constants.SOUTH_EAST}
	directions[8] = {name = BeltalowdaSC.constants.DIRECTION_NAME_SOUTH, category = "south", label = BeltalowdaSC.constants.SOUTH}
	directions[9] = {name = BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_WEST, category = "others", label = BeltalowdaSC.constants.SOUTH_WEST}
	directions[10] = {name = BeltalowdaSC.constants.DIRECTION_NAME_WEST, category = "west", label = BeltalowdaSC.constants.WEST}
	directions[11] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH_WEST, category = "others", label = BeltalowdaSC.constants.NORTH_WEST}
	directions[12] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH, category = "north", label = BeltalowdaSC.constants.NORTH}
	directions[13] = {name = BeltalowdaSC.constants.DIRECTION_NAME_NORTH_EAST, category = "others", label = BeltalowdaSC.constants.NORTH_EAST}
	directions[14] = {name = BeltalowdaSC.constants.DIRECTION_NAME_EAST, category = "east", label = BeltalowdaSC.constants.EAST}
	directions[15] = {name = BeltalowdaSC.constants.DIRECTION_NAME_SOUTH_EAST, category = "others", label = BeltalowdaSC.constants.SOUTH_EAST}
	
	BeltalowdaSC.state.calc.nToNLength = 8 * BeltalowdaSC.config.markerOffset
	BeltalowdaSC.state.calc.ticks = BeltalowdaSC.state.calc.nToNLength / (math.pi * 2)
	BeltalowdaSC.state.calc.nOffset = -(BeltalowdaSC.config.anchorOffset + BeltalowdaSC.config.markerOffset * 3) + BeltalowdaSC.config.width / 2 - BeltalowdaSC.state.calc.nToNLength
	BeltalowdaSC.state.calc.visibleDistance = 2 * (BeltalowdaSC.config.width / 2 - BeltalowdaSC.config.anchorOffset)
	
	local offset = BeltalowdaSC.config.anchorOffset
	font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaSC.config.height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	for i = 1, #directions do
		rootControl.compass.anchors[i] = wm:CreateControl(nil, rootControl.compass, CT_CONTROL)
		rootControl.compass.anchors[i]:SetAnchor(TOPLEFT, rootControl.compass, TOPLEFT, offset, 0)
		rootControl.compass.anchors[i]:SetDimensions(0, 0)
		rootControl.compass.anchors[i].visibleOffsetEnd = -offset + BeltalowdaSC.config.anchorOffset + BeltalowdaSC.state.calc.visibleDistance
		rootControl.compass.anchors[i].visibleOffsetBegin = -offset + BeltalowdaSC.config.anchorOffset
		
		local label = wm:CreateControl(nil, rootControl.compass.anchors[i], CT_LABEL)
		label:SetFont(font)
		label:SetWrapMode(ELLIPSIS)
		label:SetAnchor(TOP, rootControl.compass.anchors[i], TOP, 0, 0)
		label:SetDimensions(BeltalowdaSC.config.labelWidth, BeltalowdaSC.config.height)
		label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
		label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		
		label.directionName = directions[i].name
		label:SetText(directions[i].label)
		table.insert(rootControl.compass.directions[directions[i].category], label)
		table.insert(rootControl.compass.directions.all, label)
		
		offset = offset + BeltalowdaSC.config.markerOffset
	end
	rootControl.compass.marker1 = wm:CreateControl(nil, rootControl, CT_TEXTURE)
	rootControl.compass.marker1:SetAnchor(TOP, rootControl, TOP, 0, 1)
	rootControl.compass.marker1:SetDimensions(BeltalowdaSC.config.markerSize, BeltalowdaSC.config.markerSize)
	rootControl.compass.marker1:SetTexture("Beltalowda/Art/Compasses/SimpleCompass/MarkerTop.dds")
	rootControl.compass.marker1:SetColor(BeltalowdaSC.scVars.colors.markers.r, BeltalowdaSC.scVars.colors.markers.g, BeltalowdaSC.scVars.colors.markers.b, BeltalowdaSC.scVars.colors.markers.a)
	
	rootControl.compass.marker2 = wm:CreateControl(nil, rootControl, CT_TEXTURE)
	rootControl.compass.marker2:SetAnchor(BOTTOM, rootControl, BOTTOM, 0, 0)
	rootControl.compass.marker2:SetDimensions(BeltalowdaSC.config.markerSize, BeltalowdaSC.config.markerSize)
	rootControl.compass.marker2:SetTexture("Beltalowda/Art/Compasses/SimpleCompass/MarkerBottom.dds")
	rootControl.compass.marker2:SetColor(BeltalowdaSC.scVars.colors.markers.r, BeltalowdaSC.scVars.colors.markers.g, BeltalowdaSC.scVars.colors.markers.b, BeltalowdaSC.scVars.colors.markers.a)
end

function BeltalowdaSC.SetTlwLocation()
	if BeltalowdaSC.scVars.location == nil then
		BeltalowdaSC.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, -125)
	else
		BeltalowdaSC.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaSC.scVars.location.x, BeltalowdaSC.scVars.location.y)
	end
end

function BeltalowdaSC.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvpEnabled = true
	defaults.pveEnabled = true
	defaults.positionLocked = true
	defaults.colors = {}
	defaults.colors.backdrop = {}
	defaults.colors.backdrop.r = 0.1
	defaults.colors.backdrop.g = 0.1
	defaults.colors.backdrop.b = 0.1
	defaults.colors.backdrop.a = 0.2
	defaults.colors.north = {}
	defaults.colors.north.r = 0.8
	defaults.colors.north.g = 0.86
	defaults.colors.north.b = 0.74
	defaults.colors.north.a = 1.0
	defaults.colors.south = {}
	defaults.colors.south.r = 0.8
	defaults.colors.south.g = 0.86
	defaults.colors.south.b = 0.74
	defaults.colors.south.a = 1.0
	defaults.colors.west = {}
	defaults.colors.west.r = 0.8
	defaults.colors.west.g = 0.86
	defaults.colors.west.b = 0.74
	defaults.colors.west.a = 1.0
	defaults.colors.east = {}
	defaults.colors.east.r = 0.8
	defaults.colors.east.g = 0.86
	defaults.colors.east.b = 0.74
	defaults.colors.east.a = 1.0
	defaults.colors.others = {}
	defaults.colors.others.r = 0.92
	defaults.colors.others.g = 0.37
	defaults.colors.others.b = 0.0
	defaults.colors.others.a = 0.8
	defaults.colors.markers = {}
	defaults.colors.markers.r = 0.94
	defaults.colors.markers.g = 0.24
	defaults.colors.markers.b = 0.24
	defaults.colors.markers.a = 0.5
	return defaults
end

function BeltalowdaSC.SetEnabled(enabled)
	if BeltalowdaSC.state.initialized == true and enabled ~= nil then
		BeltalowdaSC.scVars.enabled = enabled
		if enabled == true then
			if BeltalowdaSC.state.registredConsumers == false then
				--EVENT_MANAGER:RegisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaSC.SetForegroundVisibility)
				--EVENT_MANAGER:RegisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaSC.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSC.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaSC.OnPlayerActivated)
			end
			BeltalowdaSC.state.registredConsumers = true
		else
			if BeltalowdaSC.state.registredConsumers == true then
				--EVENT_MANAGER:UnregisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_POPPED)
				--EVENT_MANAGER:UnregisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSC.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaSC.state.registredConsumers = false
			BeltalowdaSC.SetControlVisibility()
		end
		BeltalowdaSC.OnPlayerActivated()
	end

end

function BeltalowdaSC.SetControlVisibility()
	local enabled = BeltalowdaSC.scVars.enabled
	local isInPvp = BeltalowdaUtil.IsInPvPArea()
	local setHidden = true
	if enabled ~= nil and enabled == true and ((BeltalowdaSC.scVars.pvpEnabled == true and isInPvp == true) or (BeltalowdaSC.scVars.pveEnabled == true and isInPvp == false)) then
		setHidden = false
	end
	if setHidden == false then
		if BeltalowdaSC.state.foreground == false then
			BeltalowdaSC.controls.TLW:SetHidden(BeltalowdaSC.state.activeLayerIndex > 2)
		else
			BeltalowdaSC.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaSC.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaSC.SetPositionLocked(value)
	BeltalowdaSC.scVars.positionLocked = value
	
	BeltalowdaSC.controls.TLW:SetMovable(not value)
	BeltalowdaSC.controls.TLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaSC.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSC.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaSC.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSC.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaSC.AdjustColors()
	local controls = BeltalowdaSC.controls.TLW.rootControl.compass.directions.all
	for i = 1, #controls do
		local color = BeltalowdaSC.scVars.colors.others
		if controls[i].directionName == BeltalowdaSC.constants.DIRECTION_NAME_NORTH then
			color = BeltalowdaSC.scVars.colors.north
		elseif controls[i].directionName == BeltalowdaSC.constants.DIRECTION_NAME_EAST then
			color = BeltalowdaSC.scVars.colors.east
		elseif controls[i].directionName == BeltalowdaSC.constants.DIRECTION_NAME_SOUTH then
			color = BeltalowdaSC.scVars.colors.south
		elseif controls[i].directionName == BeltalowdaSC.constants.DIRECTION_NAME_WEST then
			color = BeltalowdaSC.scVars.colors.west
		end
		controls[i]:SetColor(color.r, color.g, color.b, color.a)
	end
	BeltalowdaSC.controls.TLW.rootControl.backdrop:SetCenterColor(BeltalowdaSC.scVars.colors.backdrop.r, BeltalowdaSC.scVars.colors.backdrop.g, BeltalowdaSC.scVars.colors.backdrop.b, BeltalowdaSC.scVars.colors.backdrop.a)
	local borderAlpha = BeltalowdaSC.scVars.colors.backdrop.a + BeltalowdaSC.config.borderAlpha
	if borderAlpha > 1.0 then
		borderAlpha = 1.0
	end
	BeltalowdaSC.controls.TLW.rootControl.backdrop:SetEdgeColor(BeltalowdaSC.scVars.colors.backdrop.r, BeltalowdaSC.scVars.colors.backdrop.g, BeltalowdaSC.scVars.colors.backdrop.b, borderAlpha)
	BeltalowdaSC.controls.TLW.rootControl.backdrop:SetEdgeTexture(nil, 2, 2, 2, 0)
	BeltalowdaSC.controls.TLW.rootControl.compass.marker1:SetColor(BeltalowdaSC.scVars.colors.markers.r, BeltalowdaSC.scVars.colors.markers.g, BeltalowdaSC.scVars.colors.markers.b, BeltalowdaSC.scVars.colors.markers.a)
	BeltalowdaSC.controls.TLW.rootControl.compass.marker2:SetColor(BeltalowdaSC.scVars.colors.markers.r, BeltalowdaSC.scVars.colors.markers.g, BeltalowdaSC.scVars.colors.markers.b, BeltalowdaSC.scVars.colors.markers.a)
end

--callbacks
function BeltalowdaSC.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaSC.scVars = currentProfile.compass.sc
		BeltalowdaSC.SetEnabled(BeltalowdaSC.scVars.enabled)
		if BeltalowdaSC.state.initialized == true then
			BeltalowdaSC.SetPositionLocked(BeltalowdaSC.scVars.positionLocked)
			BeltalowdaSC.AdjustColors()
		end
	end
end

function BeltalowdaSC.SaveWindowLocation()
	if BeltalowdaSC.scVars.positionLocked == false then
		BeltalowdaSC.scVars.location = BeltalowdaSC.scVars.location or {}
		BeltalowdaSC.scVars.location.x = BeltalowdaSC.controls.TLW:GetLeft()
		BeltalowdaSC.scVars.location.y = BeltalowdaSC.controls.TLW:GetTop()
	end
end

function BeltalowdaSC.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaSC.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaSC.state.foreground = false
	end
	BeltalowdaSC.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaSC.SetControlVisibility()
end

function BeltalowdaSC.OnPlayerActivated(eventCode, initial)
	local isInPvp = BeltalowdaUtil.IsInPvPArea()
	if BeltalowdaSC.scVars.enabled == true and ((BeltalowdaSC.scVars.pvpEnabled == true and isInPvp == true) or (BeltalowdaSC.scVars.pveEnabled == true and isInPvp == false)) then
		if BeltalowdaSC.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaSC.callbackName, BeltalowdaSC.config.updateInterval, BeltalowdaSC.UiLoop)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaSC.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaSC.SetForegroundVisibility)
			BeltalowdaSC.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaSC.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaSC.callbackName)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSC.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaSC.state.registredActiveConsumers = false
		end
	end
	BeltalowdaSC.SetControlVisibility()
end

function BeltalowdaSC.UiLoop()
	if BeltalowdaSC.scVars.enabled == true then
		local rootControl = BeltalowdaSC.controls.TLW.rootControl
		local compass = rootControl.compass
		local anchors = compass.anchors
		local offset = BeltalowdaSC.state.calc.nOffset + (BeltalowdaSC.state.calc.ticks * GetPlayerCameraHeading())
		compass:ClearAnchors()
		compass:SetAnchor(TOPLEFT, rootControl, TOPLEFT, offset, 0)
		for i = 1, #anchors do
			if anchors[i].visibleOffsetBegin < offset and anchors[i].visibleOffsetEnd > offset then
				anchors[i]:SetHidden(false)
			else
				anchors[i]:SetHidden(true)
			end
		end
	else
		BeltalowdaChat.SendChatMessage("UI Loop: Not enabled!", BeltalowdaSC.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	end
end

--menu interaction
function BeltalowdaSC.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.COMPASS_SC_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.COMPASS_SC_ENABLED,
					getFunc = BeltalowdaSC.GetCsEnabled,
					setFunc = BeltalowdaSC.SetCsEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.COMPASS_SC_PVP,
					getFunc = BeltalowdaSC.GetCsPvpEnabled,
					setFunc = BeltalowdaSC.SetCsPvpEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.COMPASS_SC_PVE,
					getFunc = BeltalowdaSC.GetCsPveEnabled,
					setFunc = BeltalowdaSC.SetCsPveEnabled
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.COMPASS_SC_POSITION_FIXED,
					getFunc = BeltalowdaSC.GetScPositionLocked,
					setFunc = BeltalowdaSC.SetScPositionLocked
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_BACKDROP,
					getFunc = BeltalowdaSC.GetScColorBackdrop,
					setFunc = BeltalowdaSC.SetScColorBackdrop,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_NORTH,
					getFunc = BeltalowdaSC.GetScColorNorth,
					setFunc = BeltalowdaSC.SetScColorNorth,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_SOUTH,
					getFunc = BeltalowdaSC.GetScColorSouth,
					setFunc = BeltalowdaSC.SetScColorSouth,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_WEST,
					getFunc = BeltalowdaSC.GetScColorWest,
					setFunc = BeltalowdaSC.SetScColorWest,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_EAST,
					getFunc = BeltalowdaSC.GetScColorEast,
					setFunc = BeltalowdaSC.SetScColorEast,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_OTHERS,
					getFunc = BeltalowdaSC.GetScColorOthers,
					setFunc = BeltalowdaSC.SetScColorOthers,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.COMPASS_SC_COLOR_MARKERS,
					getFunc = BeltalowdaSC.GetScColorMarkers,
					setFunc = BeltalowdaSC.SetScColorMarkers,
					width = "full"
				},
			}
		},
	}
	return menu
end

function BeltalowdaSC.GetCsEnabled()
	return BeltalowdaSC.scVars.enabled
end

function BeltalowdaSC.SetCsEnabled(value)
	BeltalowdaSC.SetEnabled(value)
end

function BeltalowdaSC.GetCsPvpEnabled()
	return BeltalowdaSC.scVars.pvpEnabled
end

function BeltalowdaSC.SetCsPvpEnabled(value)
	BeltalowdaSC.scVars.pvpEnabled = value
end

function BeltalowdaSC.GetCsPveEnabled()
	return BeltalowdaSC.scVars.pveEnabled
end

function BeltalowdaSC.SetCsPveEnabled(value)
	BeltalowdaSC.scVars.pveEnabled = value
end

function BeltalowdaSC.GetScPositionLocked()
	return BeltalowdaSC.scVars.positionLocked
end

function BeltalowdaSC.SetScPositionLocked(value)
	BeltalowdaSC.SetPositionLocked(value)
end

function BeltalowdaSC.GetScColorBackdrop()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.backdrop)
end

function BeltalowdaSC.SetScColorBackdrop(r, g, b, a)
	BeltalowdaSC.scVars.colors.backdrop = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorNorth()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.north)
end

function BeltalowdaSC.SetScColorNorth(r, g, b, a)
	BeltalowdaSC.scVars.colors.north = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorSouth()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.south)
end

function BeltalowdaSC.SetScColorSouth(r, g, b, a)
	BeltalowdaSC.scVars.colors.south = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorWest()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.west)
end

function BeltalowdaSC.SetScColorWest(r, g, b, a)
	BeltalowdaSC.scVars.colors.west = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorEast()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.east)
end

function BeltalowdaSC.SetScColorEast(r, g, b, a)
	BeltalowdaSC.scVars.colors.east = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorOthers()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.others)
end

function BeltalowdaSC.SetScColorOthers(r, g, b, a)
	BeltalowdaSC.scVars.colors.others = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end

function BeltalowdaSC.GetScColorMarkers()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSC.scVars.colors.markers)
end

function BeltalowdaSC.SetScColorMarkers(r, g, b, a)
	BeltalowdaSC.scVars.colors.markers = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSC.AdjustColors()
end