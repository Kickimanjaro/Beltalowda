-- Beltalowda Debuff Overview
-- By @s0rdrak (PC / EU)

Beltalowda.group = Beltalowda.group or {}
Beltalowda.group.dbo = Beltalowda.group.dbo or {}
local BeltalowdaDbo = Beltalowda.group.dbo
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group

BeltalowdaDbo.constants = BeltalowdaDbo.constants or {}
BeltalowdaDbo.constants.TLW_NAME = "Beltalowda.group.dbo.TLW"

BeltalowdaDbo.constants.size = {}
BeltalowdaDbo.constants.size.SMALL = 1
BeltalowdaDbo.constants.size.BIG = 2

BeltalowdaDbo.callbackName = Beltalowda.addonName .. "DebuffOverview"

BeltalowdaDbo.config = {}
BeltalowdaDbo.config.updateInterval = 100
BeltalowdaDbo.config.isClampedToScreen = true
BeltalowdaDbo.config.sizes = {}
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL] = {}
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight = 3
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth = 10
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth = 85
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth = 20
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].width = BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].windowWidth = 2 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].width + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height = 10
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].windowHeight = 12 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height + 11 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].fontSize = 12
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG] = {}
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingHeight = 6
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingWidth = 20
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].textWidth = 170
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].debuffWidth = 40
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].width = BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].textWidth + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].debuffWidth
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].windowWidth = 2 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].width + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingWidth
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].height = 20
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].windowHeight = 12 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].height + 11 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingHeight
BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].fontSize = 24

BeltalowdaDbo.state = {}
BeltalowdaDbo.state.initialized = false
BeltalowdaDbo.state.foreground = true
BeltalowdaDbo.state.registredConsumers = false
BeltalowdaDbo.state.registredActiveConsumers = false
BeltalowdaDbo.state.activeLayerIndex = 1
BeltalowdaDbo.state.colors = {}



BeltalowdaDbo.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaDbo.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaDbo.callbackName, BeltalowdaDbo.OnProfileChanged)
	
	BeltalowdaDbo.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaDbo.SetDboPositionLocked)
	
	BeltalowdaDbo.state.initialized = true
	BeltalowdaDbo.SetEnabled(BeltalowdaDbo.dboVars.enabled)
	BeltalowdaDbo.CalculateColors()
	BeltalowdaDbo.SetMovable(not BeltalowdaDbo.dboVars.positionLocked)
	BeltalowdaDbo.AdjustSize()
	
end

function BeltalowdaDbo.CreatePlayerDebuffControl(parent, offsetHeight, offsetWidth, height, labelWidth, countWidth, font)
	local playerDebuffControl = wm:CreateControl(nil, parent, CT_CONTROL)
	playerDebuffControl:SetAnchor(TOPLEFT, parent, TOPLEFT, offsetWidth, offsetHeight)
	playerDebuffControl:SetDimensions(labelWidth + countWidth, height)
	playerDebuffControl:SetHidden(true)
	
	playerDebuffControl.playerLabel = wm:CreateControl(nil, playerDebuffControl, CT_LABEL)
	playerDebuffControl.playerLabel:SetDimensions(labelWidth, height)
	playerDebuffControl.playerLabel:SetAnchor(TOPLEFT, playerDebuffControl, TOPLEFT, 0, 0)
	playerDebuffControl.playerLabel:SetFont(font)
	playerDebuffControl.playerLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT) 
	playerDebuffControl.playerLabel:SetText("")
	
	
	playerDebuffControl.debuffLabel = wm:CreateControl(nil, playerDebuffControl, CT_LABEL)
	playerDebuffControl.debuffLabel:SetDimensions(countWidth, height)
	playerDebuffControl.debuffLabel:SetAnchor(TOPLEFT, playerDebuffControl, TOPLEFT, labelWidth, 0)
	playerDebuffControl.debuffLabel:SetFont(font)
	playerDebuffControl.debuffLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER) 
	playerDebuffControl.debuffLabel:SetText("")
	
	return playerDebuffControl
end

function BeltalowdaDbo.SetTlwLocation()
	BeltalowdaDbo.controls.TLW:ClearAnchors()
	if BeltalowdaDbo.dboVars.debuffLocation == nil then
		BeltalowdaDbo.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 250, 0)
	else
		BeltalowdaDbo.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaDbo.dboVars.debuffLocation.x, BeltalowdaDbo.dboVars.debuffLocation.y)
	end
end

function BeltalowdaDbo.CreateUI()
	local height = 12 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height + 11 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight
	local width = (2 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth) + (2 * BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth) + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaDbo.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaDbo.constants.TLW_NAME)
	
	BeltalowdaDbo.SetTlwLocation()

		
	BeltalowdaDbo.controls.TLW:SetClampedToScreen(BeltalowdaDbo.config.isClampedToScreen)
	BeltalowdaDbo.controls.TLW:SetDrawLayer(0)
	BeltalowdaDbo.controls.TLW:SetDrawLevel(0)
	BeltalowdaDbo.controls.TLW:SetHandler("OnMoveStop", BeltalowdaDbo.SaveWindowLocation)
	BeltalowdaDbo.controls.TLW:SetDimensions(width, height)
	BeltalowdaDbo.controls.TLW:SetHidden(not BeltalowdaDbo.dboVars.enabled)
	
	BeltalowdaDbo.controls.tlwControl = wm:CreateControl(nil, BeltalowdaDbo.controls.TLW, CT_CONTROL)
	BeltalowdaDbo.controls.tlwControl:SetDimensions(width, height)
	BeltalowdaDbo.controls.tlwControl:SetAnchor(TOPLEFT, BeltalowdaDbo.controls.TLW, TOPLEFT, 0, 0)
	
	BeltalowdaDbo.controls.tlwControl.movableBackdrop = wm:CreateControl(nil, BeltalowdaDbo.controls.tlwControl, CT_BACKDROP)
	
	BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetAnchor(TOPLEFT, BeltalowdaDbo.controls.tlwControl, TOPLEFT, 0, 0)
	BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetDimensions(width, height)
	
	BeltalowdaDbo.controls.tlwControl.playerDebuffControls = {}
	
	for i = 1, 24 do
		local offset = 0
		if i > 12 then
			offset = BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth
		end
		local itemIndex = i - 1
		if itemIndex > 11 then
			itemIndex = itemIndex - 12
		end
		BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i] = BeltalowdaDbo.CreatePlayerDebuffControl(BeltalowdaDbo.controls.tlwControl, itemIndex * (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height + BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight), offset, BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height, BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth, BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth, font)
	end
end

function BeltalowdaDbo.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvponly = true
	defaults.criticalAmount = 3
	defaults.colors = {}
	defaults.colors.okay = {}
	defaults.colors.okay.r = 0
	defaults.colors.okay.g = 1
	defaults.colors.okay.b = 0
	defaults.colors.critical = {}
	defaults.colors.critical.r = 1
	defaults.colors.critical.g = 0
	defaults.colors.critical.b = 0
	defaults.colors.notOkay = {}
	defaults.colors.notOkay.r = 1
	defaults.colors.notOkay.g = 1
	defaults.colors.notOkay.b = 0
	defaults.colors.outOfRange = {}
	defaults.colors.outOfRange.r = 1
	defaults.colors.outOfRange.g = 1
	defaults.colors.outOfRange.b = 1
	defaults.positionLocked = true
	defaults.size = BeltalowdaDbo.constants.size.SMALL
	return defaults
end

function BeltalowdaDbo.SetEnabled(value)
	if BeltalowdaDbo.state.initialized == true and value ~= nil then
		BeltalowdaDbo.dboVars.enabled = value
		if value == true then
			if BeltalowdaDbo.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaDbo.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaDbo.OnPlayerActivated)
				
			end
			BeltalowdaDbo.state.registredConsumers = true
		else
			if BeltalowdaDbo.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaDbo.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaDbo.state.registredConsumers = false
		end
		BeltalowdaDbo.OnPlayerActivated()
	end
end

function BeltalowdaDbo.SetControlVisibility()
	local enabled = BeltalowdaDbo.dboVars.enabled
	local pvpOnly = BeltalowdaDbo.dboVars.pvponly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaDbo.state.foreground == false then
			BeltalowdaDbo.controls.TLW:SetHidden(BeltalowdaDbo.state.activeLayerIndex > 2)
		else
			BeltalowdaDbo.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaDbo.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaDbo.GetColorTone(r1, r2, distance)
	local d = BeltalowdaDbo.dboVars.criticalAmount - 1
	local color = r1
	
	local delta = r2 - r1
	
	if delta > 0 then
		color = r1 + delta * (distance / d)
	elseif delta < 0 then
		color = r2 - delta * (d - (distance)) / d
	end
	return color
end

function BeltalowdaDbo.SetBackdropColors()
	if BeltalowdaDbo.dboVars.positionLocked == false then
		BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetCenterColor(0, 0, 0, 0.0)
		BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetEdgeColor(0, 0, 0, 0.0)	
	end
end

function BeltalowdaDbo.SetMovable(isMovable)
	BeltalowdaDbo.dboVars.positionLocked = not isMovable
	BeltalowdaDbo.controls.TLW:SetMovable(isMovable)
	BeltalowdaDbo.controls.TLW:SetMouseEnabled(isMovable)
	BeltalowdaDbo.SetBackdropColors()
end

function BeltalowdaDbo.CalculateColors()
	--r1 = okay, r2 = ciritical
	BeltalowdaDbo.state.colors[1] = {}
	BeltalowdaDbo.state.colors[1].r = BeltalowdaDbo.dboVars.colors.okay.r
	BeltalowdaDbo.state.colors[1].g = BeltalowdaDbo.dboVars.colors.okay.g
	BeltalowdaDbo.state.colors[1].b = BeltalowdaDbo.dboVars.colors.okay.b
	for i = 2, 11 do
		BeltalowdaDbo.state.colors[i] = {}
		BeltalowdaDbo.state.colors[i].r = BeltalowdaDbo.GetColorTone(BeltalowdaDbo.dboVars.colors.notOkay.r, BeltalowdaDbo.dboVars.colors.critical.r, i - 2)
		BeltalowdaDbo.state.colors[i].g = BeltalowdaDbo.GetColorTone(BeltalowdaDbo.dboVars.colors.notOkay.g, BeltalowdaDbo.dboVars.colors.critical.g, i - 2)
		BeltalowdaDbo.state.colors[i].b = BeltalowdaDbo.GetColorTone(BeltalowdaDbo.dboVars.colors.notOkay.b, BeltalowdaDbo.dboVars.colors.critical.b, i - 2)
	end
end

function BeltalowdaDbo.GetPlayerDebuffs()
	local debuffs = 0
	local players = BeltalowdaGroup.GetGroupInformation()
	if players ~= nil then
		for i = 1, #players do
			if players[i].isPlayer == true then
				local buffs = players[i].buffs
				if buffs ~= nil and buffs.numPurgableBuffs ~= nil then
					debuffs = buffs.numPurgableBuffs
					--d("Player Debuffs")
					--d(debuffs)
				end
				break
			end
		end
	end
	return debuffs
end

function BeltalowdaDbo.AdjustSize()
	local sizeIncrease = BeltalowdaDbo.dboVars.size - BeltalowdaDbo.constants.size.SMALL
	local spacingHeight = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingHeight - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingHeight) * sizeIncrease)
	local spacingWidth = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].spacingWidth - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].spacingWidth) * sizeIncrease)
	local textWidth = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].textWidth - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].textWidth) * sizeIncrease)
	local debuffWidth = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].debuffWidth - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].debuffWidth) * sizeIncrease)
	local width = textWidth + debuffWidth
	local windowWidth = 2 * width + spacingWidth
	local height = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].height - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].height) * sizeIncrease)
	local windowHeight = 12 * height + 11 * spacingHeight
	local fontSize = (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].fontSize + (BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.BIG].fontSize - BeltalowdaDbo.config.sizes[BeltalowdaDbo.constants.size.SMALL].fontSize) * sizeIncrease)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)

	
	BeltalowdaDbo.controls.TLW:SetDimensions(windowWidth, windowHeight)
	BeltalowdaDbo.controls.tlwControl:SetDimensions(windowWidth, windowHeight)
	BeltalowdaDbo.controls.tlwControl.movableBackdrop:SetDimensions(windowWidth, windowHeight)
	
	
	local playerDebuffControls = BeltalowdaDbo.controls.tlwControl.playerDebuffControls
	
	for i = 1, #playerDebuffControls do
		local offset = 0
		if i > 12 then
			offset = textWidth + debuffWidth + spacingWidth
		end
		local itemIndex = i - 1
		if itemIndex > 11 then
			itemIndex = itemIndex - 12
		end
		
		playerDebuffControls[i]:ClearAnchors()
		playerDebuffControls[i]:SetAnchor(TOPLEFT, BeltalowdaDbo.controls.tlwControl, TOPLEFT, offset, itemIndex * (height + spacingHeight))
		playerDebuffControls[i]:SetDimensions(textWidth + debuffWidth, height)
		
		
		playerDebuffControls[i].playerLabel:SetDimensions(textWidth, height)
		playerDebuffControls[i].playerLabel:SetFont(font)
		
		
		playerDebuffControls[i].debuffLabel:SetDimensions(debuffWidth, height)
		playerDebuffControls[i].debuffLabel:ClearAnchors()
		playerDebuffControls[i].debuffLabel:SetAnchor(TOPLEFT, playerDebuffControls[i], TOPLEFT, textWidth, 0)
		playerDebuffControls[i].debuffLabel:SetFont(font)
		
	end
end

--callbacks
function BeltalowdaDbo.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		--BeltalowdaDbo.SetEnabled(false)
		BeltalowdaDbo.dboVars = currentProfile.group.dbo
		if BeltalowdaDbo.state.initialized == true then
			BeltalowdaDbo.CalculateColors()
			BeltalowdaDbo.SetMovable(not BeltalowdaDbo.dboVars.positionLocked)
			BeltalowdaDbo.SetTlwLocation()
			BeltalowdaDbo.AdjustSize()
			--BeltalowdaDbo.OnPlayerActivated()
		end
		BeltalowdaDbo.SetEnabled(BeltalowdaDbo.dboVars.enabled)
		
	end
end

function BeltalowdaDbo.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaDbo.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaDbo.state.foreground = false
	end
	--hack?
	BeltalowdaDbo.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaDbo.SetControlVisibility()
end

function BeltalowdaDbo.OnPlayerActivated(eventCode, initial)
	if BeltalowdaDbo.dboVars.enabled == true and (BeltalowdaDbo.dboVars.pvponly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaDbo.dboVars.pvponly == false) then
		if BeltalowdaDbo.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaDbo.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaDbo.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaDbo.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaDbo.SetForegroundVisibility)
			BeltalowdaGroup.AddFeature(BeltalowdaDbo.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaDbo.config.updateInterval)
			BeltalowdaGroup.AddFeature(BeltalowdaDbo.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaDbo.config.updateInterval)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaDbo.callbackName, BeltalowdaDbo.config.updateInterval, BeltalowdaDbo.OnUpdate)
			BeltalowdaDbo.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaDbo.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaDbo.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaDbo.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaGroup.RemoveFeature(BeltalowdaDbo.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaGroup.RemoveFeature(BeltalowdaDbo.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaDbo.callbackName)
			BeltalowdaDbo.state.registredActiveConsumers = false
		end
	end
	BeltalowdaDbo.SetControlVisibility()
end

function BeltalowdaDbo.OnUpdate()
	--d("DBO onUpdate")
	if BeltalowdaDbo.dboVars.enabled then
		local pvpZone = BeltalowdaUtil.IsInPvPArea()
		if BeltalowdaDbo.dboVars.pvponly == true and pvpZone == true or BeltalowdaDbo.dboVars.pvponly == false then
			local players = BeltalowdaGroup.GetGroupInformation()
			--temp = players
			if players ~= nil then

				for i = 1, #players do
					local buffs = players[i].buffs
					if buffs ~= nil and buffs.numPurgableBuffs ~= nil then
						local colorIndex = buffs.numPurgableBuffs
						colorIndex = colorIndex + 1
						if colorIndex < 1 then
							colorIndex = 1
						elseif colorIndex > 11 then
							colorIndex = 11
						end
						local distance =  players[i].distances.fromPlayer
						if distance == nil then
							distance = 0
						end
						if distance > 18 then
							BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].playerLabel:SetColor(BeltalowdaDbo.dboVars.colors.outOfRange.r, BeltalowdaDbo.dboVars.colors.outOfRange.g, BeltalowdaDbo.dboVars.colors.outOfRange.b)
							BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetColor(BeltalowdaDbo.dboVars.colors.outOfRange.r, BeltalowdaDbo.dboVars.colors.outOfRange.g, BeltalowdaDbo.dboVars.colors.outOfRange.b)
						else
							BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].playerLabel:SetColor(BeltalowdaDbo.state.colors[colorIndex].r, BeltalowdaDbo.state.colors[colorIndex].g, BeltalowdaDbo.state.colors[colorIndex].b)
							BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetColor(BeltalowdaDbo.state.colors[colorIndex].r, BeltalowdaDbo.state.colors[colorIndex].g, BeltalowdaDbo.state.colors[colorIndex].b)
						end
						if players[i].isPlayer == true then
							BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetText(players[i].buffs.numPurgableBuffs)
							--d("DBO")
							--d(players[i].buffs.numPurgableBuffs)
						else
							--d("DBO")
							--d(players[i].buffs.numPurgableBuffs)
							if players[i].buffs.numPurgableBuffs > 6 then
								BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetText("6+")
							else
								BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetText(players[i].buffs.numPurgableBuffs)
							end
						end
						BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].playerLabel:SetText(players[i].name)
						BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i]:SetHidden(false)
					end
				end
				for i = #players + 1, 24 do
					BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i]:SetHidden(true)
					BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].playerLabel:SetText("")
					BeltalowdaDbo.controls.tlwControl.playerDebuffControls[i].debuffLabel:SetText("")
				end
				
				--if BeltalowdaDbo.state.foreground == true then
				--	BeltalowdaDbo.controls.TLW:SetHidden(false)
				--end
			end
		else
			--BeltalowdaDbo.controls.TLW:SetHidden(true)
		end
	else
		--BeltalowdaDbo.controls.TLW:SetHidden(true)
	end
end

function BeltalowdaDbo.SaveWindowLocation()
	if BeltalowdaDbo.dboVars.positionLocked == false then
		BeltalowdaDbo.dboVars.debuffLocation = BeltalowdaDbo.dboVars.debuffLocation or {}
		BeltalowdaDbo.dboVars.debuffLocation.x = BeltalowdaDbo.controls.TLW:GetLeft()
		BeltalowdaDbo.dboVars.debuffLocation.y = BeltalowdaDbo.controls.TLW:GetTop()
	end
end

--menu interaction
function BeltalowdaDbo.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.DBO_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = BeltalowdaMenu.constants.DBO_DESCRIPTION
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DBO_ENABLED,
					getFunc = BeltalowdaDbo.GetDboEnabled,
					setFunc = BeltalowdaDbo.SetDboEnabled
				},				
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DBO_PVP_ONLY,
					getFunc = BeltalowdaDbo.GetDboPvpOnly,
					setFunc = BeltalowdaDbo.SetDboPvpOnly,
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DBO_POSITION_FIXED,
					getFunc = BeltalowdaDbo.GetDboPositionLocked,
					setFunc = BeltalowdaDbo.SetDboPositionLocked,
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.DBO_CRITICAL_AMOUNT,
					min = 1,
					max = 10,
					step = 1,
					getFunc = BeltalowdaDbo.GetDboCriticalAmount,
					setFunc = BeltalowdaDbo.SetDboCriticalAmount,
					width = "full",
					default = 3
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.DBO_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaDbo.GetDboSize,
					setFunc = BeltalowdaDbo.SetDboSelectedSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DBO_COLOR_OKAY,
					getFunc = BeltalowdaDbo.GetDboColorOkay,
					setFunc = BeltalowdaDbo.SetDboColorOkay,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DBO_COLOR_NOT_OKAY,
					getFunc = BeltalowdaDbo.GetDboColorNotOkay,
					setFunc = BeltalowdaDbo.SetDboColorNotOkay,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DBO_COLOR_CRITICAL,
					getFunc = BeltalowdaDbo.GetDboColorCritical,
					setFunc = BeltalowdaDbo.SetDboColorCritical,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DBO_COLOR_OUT_OF_RANGE,
					getFunc = BeltalowdaDbo.GetDboColorOutOfRange,
					setFunc = BeltalowdaDbo.SetDboColorOutOfRange,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaDbo.GetDboEnabled()
	return BeltalowdaDbo.dboVars.enabled
end

function BeltalowdaDbo.SetDboEnabled(value)
	BeltalowdaDbo.SetEnabled(value)
end

function BeltalowdaDbo.GetDboPvpOnly()
	return BeltalowdaDbo.dboVars.pvponly
end

function BeltalowdaDbo.SetDboPvpOnly(value)
	BeltalowdaDbo.dboVars.pvponly = value
	BeltalowdaDbo.SetEnabled(BeltalowdaDbo.dboVars.enabled)
end

function BeltalowdaDbo.GetDboPositionLocked()
	return BeltalowdaDbo.dboVars.positionLocked
end

function BeltalowdaDbo.SetDboPositionLocked(value)
	BeltalowdaDbo.SetMovable(not value)
end

function BeltalowdaDbo.GetDboCriticalAmount()
	return BeltalowdaDbo.dboVars.criticalAmount
end

function BeltalowdaDbo.SetDboCriticalAmount(value)
	BeltalowdaDbo.dboVars.criticalAmount = value
	BeltalowdaDbo.CalculateColors()
end

function BeltalowdaDbo.GetDboSize()
	return BeltalowdaDbo.dboVars.size
end

function BeltalowdaDbo.SetDboSelectedSize(value)
	BeltalowdaDbo.dboVars.size = value
	BeltalowdaDbo.AdjustSize()
end

function BeltalowdaDbo.GetDboColorOkay()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDbo.dboVars.colors.okay)
end

function BeltalowdaDbo.SetDboColorOkay(r, g, b)
	BeltalowdaDbo.dboVars.colors.okay = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDbo.CalculateColors()
end

function BeltalowdaDbo.GetDboColorNotOkay()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDbo.dboVars.colors.notOkay)
end

function BeltalowdaDbo.SetDboColorNotOkay(r, g, b)
	BeltalowdaDbo.dboVars.colors.notOkay = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDbo.CalculateColors()
end

function BeltalowdaDbo.GetDboColorCritical()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDbo.dboVars.colors.critical)
end

function BeltalowdaDbo.SetDboColorCritical(r, g, b)
	BeltalowdaDbo.dboVars.colors.critical = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDbo.CalculateColors()
end

function BeltalowdaDbo.GetDboColorOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDbo.dboVars.colors.outOfRange)
end

function BeltalowdaDbo.SetDboColorOutOfRange(r, g, b)
	BeltalowdaDbo.dboVars.colors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDbo.CalculateColors()
end