-- Beltalowda Yet another Compass
-- By @s0rdrak (PC / EU)

Beltalowda.compass = Beltalowda.compass or {}
Beltalowda.compass.yacs = Beltalowda.compass.yacs or {}
local BeltalowdaYacs = Beltalowda.compass.yacs
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaYacs.callbackName = Beltalowda.addonName .. "Yacs"
BeltalowdaYacs.updateInterval = 10

local wm = GetWindowManager()


BeltalowdaYacs.controls = {}

BeltalowdaYacs.constants = BeltalowdaYacs.constants or {}
BeltalowdaYacs.constants.references = BeltalowdaYacs.constants.references or {}
BeltalowdaYacs.constants.references.YACS_CHECKBOX_ENABLE_ADDON = "YACS_ENABLE_ADDON_CHECKBOX_CONTROL"
BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVP = "YACS_CHECKBOX_PVP"
BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVE = "YACS_CHECKBOX_PVE"
BeltalowdaYacs.constants.references.YACS_CHECKBOX_COMBAT = "YACS_CHECKBOX_COMBAT"
BeltalowdaYacs.constants.references.YACS_CHECKBOX_MOVABLE = "YACS_CHECKBOX_MOVABLE"
BeltalowdaYacs.constants.references.YACS_DROPDOWN_COMPASS_STYLES = "YACS_DROPDOWN_COMPASS_STYLE"



BeltalowdaYacs.config = {}
BeltalowdaYacs.config.constants = {}
BeltalowdaYacs.config.constants.TLW_NAME = "Beltalowda_Compass_YACS_TLW"
BeltalowdaYacs.config.constants.COMPASS_NAME = "Beltalowda_Compass_YACS_COMPASS"
BeltalowdaYacs.compasses = {}
BeltalowdaYacs.compasses[1] = {}
BeltalowdaYacs.compasses[1].dds = "Beltalowda/Art/Compasses/Compass.dds"
BeltalowdaYacs.compasses[2] = {}
BeltalowdaYacs.compasses[2].dds = "Beltalowda/Art/Compasses/Default_Fat_N.dds"
BeltalowdaYacs.compasses[3] = {}
BeltalowdaYacs.compasses[3].dds = "Beltalowda/Art/Compasses/Default_Thin_Lines.dds"
BeltalowdaYacs.compasses[4] = {}
BeltalowdaYacs.compasses[4].dds = "Beltalowda/Art/Compasses/Fancy_Underline_N.dds"
BeltalowdaYacs.compasses[5] = {}
BeltalowdaYacs.compasses[5].dds = "Beltalowda/Art/Compasses/Fat_Underline_N.dds"
BeltalowdaYacs.compasses[6] = {}
BeltalowdaYacs.compasses[6].dds = "Beltalowda/Art/Compasses/Scribble.dds"
BeltalowdaYacs.compasses[7] = {}
BeltalowdaYacs.compasses[7].dds = "Beltalowda/Art/Compasses/Circled1.dds"
BeltalowdaYacs.compasses[8] = {}
BeltalowdaYacs.compasses[8].dds = "Beltalowda/Art/Compasses/Circled2.dds"
BeltalowdaYacs.compasses[9] = {}
BeltalowdaYacs.compasses[9].dds = "Beltalowda/Art/Compasses/Diamond1.dds"
BeltalowdaYacs.compasses[10] = {}
BeltalowdaYacs.compasses[10].dds = "Beltalowda/Art/Compasses/Diamond2.dds"
BeltalowdaYacs.compasses[11] = {}
BeltalowdaYacs.compasses[11].dds = "Beltalowda/Art/Compasses/Dots1.dds"
BeltalowdaYacs.compasses[12] = {}
BeltalowdaYacs.compasses[12].dds = "Beltalowda/Art/Compasses/Dots2.dds"
BeltalowdaYacs.compasses[13] = {}
BeltalowdaYacs.compasses[13].dds = "Beltalowda/Art/Compasses/ELetters1.dds"
BeltalowdaYacs.compasses[14] = {}
BeltalowdaYacs.compasses[14].dds = "Beltalowda/Art/Compasses/ELetters2.dds"
BeltalowdaYacs.compasses[15] = {}
BeltalowdaYacs.compasses[15].dds = "Beltalowda/Art/Compasses/FullArrow1.dds"
BeltalowdaYacs.compasses[16] = {}
BeltalowdaYacs.compasses[16].dds = "Beltalowda/Art/Compasses/FullArrow2.dds"
BeltalowdaYacs.compasses[17] = {}
BeltalowdaYacs.compasses[17].dds = "Beltalowda/Art/Compasses/Needle1.dds"
BeltalowdaYacs.compasses[18] = {}
BeltalowdaYacs.compasses[18].dds = "Beltalowda/Art/Compasses/Needle2.dds"
BeltalowdaYacs.compasses[19] = {}
BeltalowdaYacs.compasses[19].dds = "Beltalowda/Art/Compasses/SmallArrow1.dds"
BeltalowdaYacs.compasses[20] = {}
BeltalowdaYacs.compasses[20].dds = "Beltalowda/Art/Compasses/SmallArrow2.dds"
BeltalowdaYacs.compasses[21] = {}
BeltalowdaYacs.compasses[21].dds = "Beltalowda/Art/Compasses/compass_fr1.dds"
BeltalowdaYacs.compasses[22] = {}
BeltalowdaYacs.compasses[22].dds = "Beltalowda/Art/Compasses/compass_fr2.dds"
BeltalowdaYacs.compasses[23] = {}
BeltalowdaYacs.compasses[23].dds = "Beltalowda/Art/Compasses/compass_fr3.dds"
BeltalowdaYacs.compasses[24] = {}
BeltalowdaYacs.compasses[24].dds = "Beltalowda/Art/Compasses/compass_fr4.dds"
BeltalowdaYacs.config.isClampedToScreen = true
BeltalowdaYacs.config.backdropColor = {}
BeltalowdaYacs.config.backdropColor.r = 0.1
BeltalowdaYacs.config.backdropColor.g = 0.1
BeltalowdaYacs.config.backdropColor.b = 0.1
BeltalowdaYacs.config.backdropColor.a = 0.4


BeltalowdaYacs.state = {}
BeltalowdaYacs.state.foreground = true
BeltalowdaYacs.state.initialized = false
BeltalowdaYacs.state.registredConsumers = false
BeltalowdaYacs.state.activeLayerIndex = 1
BeltalowdaYacs.state.registredActiveConsumers = false

function BeltalowdaYacs.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaYacs.callbackName, BeltalowdaYacs.OnProfileChanged)
	
	if BeltalowdaYacs.yacsVars.compassStyle == nil or BeltalowdaYacs.yacsVars.compassStyle == 0 or BeltalowdaYacs.yacsVars.compassStyle > #BeltalowdaYacs.compasses then
		BeltalowdaYacs.yacsVars.compassStyle = 1
	end
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_YETANOTHERCOMPASS_OPEN", BeltalowdaYacs.config.constants.TOGGLE_YACS)
	
	BeltalowdaYacs.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaYacs.config.constants.TLW_NAME)
	BeltalowdaYacs.controls.TLW:SetDimensions(BeltalowdaYacs.yacsVars.size, BeltalowdaYacs.yacsVars.size)
	
		
	BeltalowdaYacs.controls.TLW:SetClampedToScreen(BeltalowdaYacs.config.isClampedToScreen)
	BeltalowdaYacs.controls.TLW:SetDrawLayer(0)
	BeltalowdaYacs.controls.TLW:SetDrawLevel(0)
	BeltalowdaYacs.controls.TLW:SetHandler("OnMoveStop", BeltalowdaYacs.SaveFrameLocation)
	
	BeltalowdaYacs.controls.compass = wm:CreateControl(BeltalowdaYacs.config.constants.COMPASS_NAME, BeltalowdaYacs.controls.TLW, CT_TEXTURE)
	
	BeltalowdaYacs.controls.compass:SetAnchor(TOPLEFT, BeltalowdaYacs.controls.TLW, TOPLEFT, 0, 0)
	BeltalowdaYacs.controls.compass:SetColor(BeltalowdaYacs.yacsVars.color.r, BeltalowdaYacs.yacsVars.color.g, BeltalowdaYacs.yacsVars.color.b, BeltalowdaYacs.yacsVars.color.a)
	BeltalowdaYacs.AdjustCompassTexture()
		
	
	
	BeltalowdaYacs.controls.movableBackdrop = wm:CreateControl(nil, BeltalowdaYacs.controls.TLW, CT_BACKDROP)
	
	BeltalowdaYacs.controls.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaYacs.controls.TLW, TOPLEFT, 0, 0)
	BeltalowdaYacs.controls.movableBackdrop:SetHidden(not BeltalowdaYacs.yacsVars.movableCompass)
	BeltalowdaYacs.controls.movableBackdrop:SetCenterColor(BeltalowdaYacs.config.backdropColor.r, BeltalowdaYacs.config.backdropColor.g, BeltalowdaYacs.config.backdropColor.b, BeltalowdaYacs.config.backdropColor.a)
	BeltalowdaYacs.controls.movableBackdrop:SetEdgeColor(BeltalowdaYacs.config.backdropColor.r, BeltalowdaYacs.config.backdropColor.g, BeltalowdaYacs.config.backdropColor.b, 0.0)
	
	BeltalowdaYacs.AdjustConfigSpecificUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaYacs.SetPositionLocked)
	
	BeltalowdaYacs.state.initialized = true
	BeltalowdaYacs.SetEnabled(BeltalowdaYacs.yacsVars.enabled)
	
end

function BeltalowdaYacs.SaveFrameLocation()
	if BeltalowdaYacs.yacsVars.movableCompass == true then
		BeltalowdaYacs.yacsVars.centered = false
		BeltalowdaYacs.yacsVars.position.x = BeltalowdaYacs.controls.TLW:GetLeft()
		BeltalowdaYacs.yacsVars.position.y = BeltalowdaYacs.controls.TLW:GetTop()
	end
	
end

function BeltalowdaYacs.ChangeTLWMovability(movable)
	if movable == nil or movable == false then
		BeltalowdaYacs.controls.TLW:SetMovable(false)
		BeltalowdaYacs.controls.TLW:SetMouseEnabled(false)
	else
		BeltalowdaYacs.controls.TLW:SetMovable(true)
		BeltalowdaYacs.controls.TLW:SetMouseEnabled(true)
	end
end

function BeltalowdaYacs.AdjustCompassTexture()
	if BeltalowdaYacs.yacsVars.compassStyle ~= nil and BeltalowdaYacs.yacsVars.compassStyle > 0 and BeltalowdaYacs.yacsVars.compassStyle <= #BeltalowdaYacs.compasses then
		BeltalowdaYacs.controls.compass:SetTexture(BeltalowdaYacs.compasses[BeltalowdaYacs.yacsVars.compassStyle].dds)
	end
end

function BeltalowdaYacs.GetDefaults()
	local defaults = {}
	defaults.color = {}
	defaults.color.r = 0.0
	defaults.color.g = 1.0
	defaults.color.b = 0.25
	defaults.color.a = 1.0
	defaults.size = 160
	defaults.centered = true
	defaults.position = {}
	defaults.position.x = 0
	defaults.position.y = 0
	defaults.enabled = true
	defaults.pvpEnabled = true
	defaults.pveEnabled = true
	defaults.combatEnabled = true
	defaults.movableCompass = false
	defaults.compassStyle = 5
	return defaults
end

function BeltalowdaYacs.AdjustConfigSpecificUI()
	BeltalowdaYacs.controls.TLW:ClearAnchors()
	if BeltalowdaYacs.yacsVars.centered == true then
		BeltalowdaYacs.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	else
		BeltalowdaYacs.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaYacs.yacsVars.position.x, BeltalowdaYacs.yacsVars.position.y)
	end
	BeltalowdaYacs.controls.TLW:SetDimensions(BeltalowdaYacs.yacsVars.size, BeltalowdaYacs.yacsVars.size)
	BeltalowdaYacs.controls.compass:SetDimensions(BeltalowdaYacs.yacsVars.size, BeltalowdaYacs.yacsVars.size)
	BeltalowdaYacs.controls.movableBackdrop:SetDimensions(BeltalowdaYacs.yacsVars.size, BeltalowdaYacs.yacsVars.size)
	
	BeltalowdaYacs.SetMovableState(BeltalowdaYacs.yacsVars.movableCompass)
	BeltalowdaYacs.AdjustCompassTexture()
	BeltalowdaYacs.controls.compass:SetColor(BeltalowdaYacs.yacsVars.color.r, BeltalowdaYacs.yacsVars.color.g, BeltalowdaYacs.yacsVars.color.b, BeltalowdaYacs.yacsVars.color.a)
end

function BeltalowdaYacs.OnKeyBinding()
	BeltalowdaYacs.SetEnabled(not BeltalowdaYacs.yacsVars.enabled)
	BeltalowdaYacs.UpdateYacsState()
end

--[[
SLASH_COMMANDS[BeltalowdaYacs.slashCmd] = function(param)
	d(string.format("%s %s", BeltalowdaYacs.slashCmd, param))
	param = zo_strtrim(param)
	if param == "on" then
		BeltalowdaYacs.SetEnabled(true)
		BeltalowdaYacs.menu.UpdateAddonState()
	elseif param == "off" then
		BeltalowdaYacs.SetEnabled(false)
		BeltalowdaYacs.menu.UpdateAddonState()
	elseif param == "menu" then
		BeltalowdaYacs.menu.OpenMenu()
	else
		d(BeltalowdaYacs.config.constants.CMD_TEXT_ON_OFF)
		d(BeltalowdaYacs.config.constants.CMD_TEXT_MENU)
	end
end
]]
function BeltalowdaYacs.SetPositionLocked(value)
	BeltalowdaYacs.SetMovableState(not value)
end

function BeltalowdaYacs.SetControlVisibility()
	local enabled = BeltalowdaYacs.yacsVars.enabled
	local pvpEnabled = BeltalowdaYacs.yacsVars.pvpEnabled
	local pveEnabled = BeltalowdaYacs.yacsVars.pveEnabled
	local setHidden = true
	if enabled ~= nil and pvpEnabled ~= nil and pveEnabled ~= nil then
		local isInPvPArea = BeltalowdaUtil.IsInPvPArea()
		if enabled == true and ((pvpEnabled == true and isInPvPArea == true) or (pveEnabled == true and isInPvPArea == false)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaYacs.state.foreground == false then
			BeltalowdaYacs.controls.TLW:SetHidden(BeltalowdaYacs.state.activeLayerIndex > 2)
		else
			BeltalowdaYacs.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaYacs.controls.TLW:SetHidden(setHidden)
	end
end

--callbacks
function BeltalowdaYacs.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaYacs.yacsVars = currentProfile.compass.yacs
		BeltalowdaYacs.SetEnabled(BeltalowdaYacs.yacsVars.enabled)
		if BeltalowdaYacs.state.initialized == true then
			BeltalowdaYacs.AdjustConfigSpecificUI()
			
		end
	end
end

function BeltalowdaYacs.OnUpdate()
	local pvpZone = BeltalowdaUtil.IsInPvPArea()
	
	if ((BeltalowdaYacs.yacsVars.pvpEnabled == true and pvpZone == true) or (BeltalowdaYacs.yacsVars.pveEnabled == true and pvpZone == false)) and (BeltalowdaYacs.yacsVars.combatEnabled == true or BeltalowdaYacs.yacsVars.combatEnabled == false and IsUnitInCombat("player") == false ) then
		BeltalowdaYacs.controls.compass:SetHidden(false)
		BeltalowdaYacs.controls.compass:SetTextureRotation(-GetPlayerCameraHeading())
	else
		BeltalowdaYacs.controls.compass:SetHidden(true)
	end
end

function BeltalowdaYacs.OnPlayerActivated(eventCode, initial)
	local isInPvPArea = BeltalowdaUtil.IsInPvPArea()
	if BeltalowdaYacs.yacsVars.enabled and ((BeltalowdaYacs.yacsVars.pvpEnabled == true and isInPvPArea == true) or (BeltalowdaYacs.yacsVars.pveEnabled == true and isInPvPArea == false)) then
		if BeltalowdaYacs.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaYacs.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaYacs.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaYacs.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaYacs.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaYacs.callbackName, BeltalowdaYacs.updateInterval, BeltalowdaYacs.OnUpdate)
			BeltalowdaYacs.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaYacs.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaYacs.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaYacs.callbackName, EVENT_ACTION_LAYER_PUSHED)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaYacs.callbackName)
			BeltalowdaYacs.state.registredActiveConsumers = false
		end
	end
	BeltalowdaYacs.SetControlVisibility()
end

function BeltalowdaYacs.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaYacs.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaYacs.state.foreground = false
	end
	--hack?
	BeltalowdaYacs.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaYacs.SetControlVisibility()
end

--menu interaction
function BeltalowdaYacs.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.YACS_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.YACS_CHK_ADDON_ENABLED,
					getFunc = BeltalowdaYacs.GetEnabled,
					setFunc = BeltalowdaYacs.SetEnabled,
					reference = BeltalowdaYacs.constants.references.YACS_CHECKBOX_ENABLE_ADDON
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.YACS_CHK_PVP,
					getFunc = BeltalowdaYacs.GetPvpState,
					setFunc = BeltalowdaYacs.SetPvpState,
					reference = BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVP
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.YACS_CHK_PVE,
					getFunc = BeltalowdaYacs.GetPveState,
					setFunc = BeltalowdaYacs.SetPveState,
					reference = BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVE
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.YACS_CHK_COMBAT,
					getFunc = BeltalowdaYacs.GetCombatState,
					setFunc = BeltalowdaYacs.SetCombatState,
					reference = BeltalowdaYacs.constants.references.YACS_CHECKBOX_COMBAT
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.YACS_CHK_MOVABLE,
					getFunc = BeltalowdaYacs.GetMovableState,
					setFunc = BeltalowdaYacs.SetMovableState,
					reference = BeltalowdaYacs.constants.references.YACS_CHECKBOX_MOVABLE
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.YACS_COLOR_COMPASS,
					getFunc = BeltalowdaYacs.GetCompassColor,
					setFunc = BeltalowdaYacs.SetCompassColor,
					width = "full"
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.YACS_COMPASS_SIZE,
					tooltip = BeltalowdaMenu.constants.YACS_COMPASS_SIZE_TOOLTIPE,
					min = 10,
					max = 500,
					step = 1,
					getFunc = BeltalowdaYacs.GetCompassSize,
					setFunc = BeltalowdaYacs.SetCompassSize,
					width = "full",
					default = BeltalowdaYacs.GetCompassSize()
				},
				[8] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.YACS_COMPASS_STYLE,
					tooltip = BeltalowdaMenu.constants.YACS_COMPASS_STYLE_TOOLTIP,
					choices = BeltalowdaYacs.GetCompassStyles(),
					getFunc = BeltalowdaYacs.GetCurrentCompassStyle,
					setFunc = BeltalowdaYacs.SetCurrentCompassStyle,
					reference = BeltalowdaYacs.constants.references.YACS_DROPDOWN_COMPASS_STYLES
				},
				[9] = {
					type = "button",
					name = BeltalowdaMenu.constants.YACS_RESTORE_DEFAULTS,
					func = BeltalowdaYacs.RestoreDefaults,
					width = "full"
				}
			}
		},
	}
	return menu
end

function BeltalowdaYacs.SetEnabled(value)
	if BeltalowdaYacs.state.initialized == true then
		BeltalowdaYacs.yacsVars.enabled = value
		
		
		if value == true then
			if BeltalowdaYacs.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaYacs.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaYacs.OnPlayerActivated)
				
			end
			BeltalowdaYacs.state.registredConsumers = true
		else
			if BeltalowdaYacs.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaYacs.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaYacs.state.registredConsumers = false
		end
		BeltalowdaYacs.OnPlayerActivated()
	end
end

function BeltalowdaYacs.GetEnabled()
	return BeltalowdaYacs.yacsVars.enabled
end

function BeltalowdaYacs.GetPvpState()
	return BeltalowdaYacs.yacsVars.pvpEnabled
end

function BeltalowdaYacs.SetPvpState(value)
	BeltalowdaYacs.yacsVars.pvpEnabled = value
	BeltalowdaYacs.SetEnabled(BeltalowdaYacs.yacsVars.enabled)
end

function BeltalowdaYacs.GetPveState()
	return BeltalowdaYacs.yacsVars.pveEnabled
end

function BeltalowdaYacs.SetPveState(value)
	BeltalowdaYacs.yacsVars.pveEnabled = value
	BeltalowdaYacs.SetEnabled(BeltalowdaYacs.yacsVars.enabled)
end

function BeltalowdaYacs.GetCombatState()
	return BeltalowdaYacs.yacsVars.combatEnabled
end

function BeltalowdaYacs.SetCombatState(value)
	BeltalowdaYacs.yacsVars.combatEnabled = value
end

function BeltalowdaYacs.SetCompassColor(r, g, b, a)
	BeltalowdaYacs.yacsVars.color = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaYacs.controls.compass:SetColor(r, g, b, a)
end

function BeltalowdaYacs.GetCompassColor()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaYacs.yacsVars.color)
end

function BeltalowdaYacs.SetCompassSize(size)
	BeltalowdaYacs.yacsVars.size = size
	BeltalowdaYacs.AdjustConfigSpecificUI()
end

function BeltalowdaYacs.GetCompassSize()
	return BeltalowdaYacs.yacsVars.size
end

function BeltalowdaYacs.GetCurrentCompassStyle()
	return BeltalowdaYacs.compasses[BeltalowdaYacs.yacsVars.compassStyle].name
end

function BeltalowdaYacs.SetCurrentCompassStyle(style)
	local id = 0
	for i = 1, #BeltalowdaYacs.compasses do
		if style == BeltalowdaYacs.compasses[i].name then
			id = i
			break
		end
	end
	BeltalowdaYacs.yacsVars.compassStyle = id
	BeltalowdaYacs.AdjustCompassTexture()
end

function BeltalowdaYacs.GetCompassStyles()
	local compassNames = {}
	for i = 1, #BeltalowdaYacs.compasses do
		compassNames[i] = BeltalowdaYacs.compasses[i].name
	end
	return compassNames
end

function BeltalowdaYacs.GetMovableState()
	return BeltalowdaYacs.yacsVars.movableCompass
end

function BeltalowdaYacs.SetMovableState(value)
	BeltalowdaYacs.yacsVars.movableCompass = value
	BeltalowdaYacs.ChangeTLWMovability(value)
	BeltalowdaYacs.controls.movableBackdrop:SetHidden(not BeltalowdaYacs.yacsVars.movableCompass)
end

function BeltalowdaYacs.RestoreDefaults()
	local defaults = BeltalowdaYacs.GetDefaults()
	for key, value in pairs(defaults) do
		BeltalowdaYacs.yacsVars[key] = value
	end
	 
	BeltalowdaYacs.controls.movableBackdrop:SetHidden(not BeltalowdaYacs.yacsVars.movableCompass)
	
	BeltalowdaYacs.AdjustConfigSpecificUI()

	BeltalowdaYacs.UpdateYacsState()
	--BeltalowdaYacs.SetEnabled(BeltalowdaYacs.yacsVars.enabled)
end

function BeltalowdaYacs.UpdateYacsState()
	BeltalowdaMenu.UpdateCheckbox(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_CHECKBOX_ENABLE_ADDON))
	BeltalowdaMenu.UpdateCheckbox(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVP))
	BeltalowdaMenu.UpdateCheckbox(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_CHECKBOX_PVE))
	BeltalowdaMenu.UpdateCheckbox(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_CHECKBOX_COMBAT))
	BeltalowdaMenu.UpdateCheckbox(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_CHECKBOX_MOVABLE))
	BeltalowdaMenu.UpdateControl(wm:GetControlByName(BeltalowdaYacs.constants.references.YACS_DROPDOWN_COMPASS_STYLES))
end