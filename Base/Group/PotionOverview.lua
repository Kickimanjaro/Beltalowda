-- Beltalowda Potion Overview
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.po = BeltalowdaGroup.po or {}
local BeltalowdaPo = BeltalowdaGroup.po
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.sound = BeltalowdaUtil.sound or {}
local BeltalowdaSound = BeltalowdaUtil.sound
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

BeltalowdaPo.constants = BeltalowdaPo.constants or {}
BeltalowdaPo.constants.TLW_OVERVIEW = "Beltalowda.group.po.tlw_overview"

BeltalowdaPo.constants.COOLDOWN = 45

BeltalowdaPo.callbackName = Beltalowda.addonName .. "PotionOverview"

BeltalowdaPo.config = {}
BeltalowdaPo.config.updateInterval = 100
BeltalowdaPo.config.overview = {}
BeltalowdaPo.config.overview.isClampedToScreen = true
BeltalowdaPo.config.overview.progresswidth = 100
BeltalowdaPo.config.overview.width = 120
BeltalowdaPo.config.overview.potionProgressHeight = 12
BeltalowdaPo.config.overview.potionImmovableHeight = 12
BeltalowdaPo.config.overview.height = 24

BeltalowdaPo.state = {}
BeltalowdaPo.state.initialized = false
BeltalowdaPo.state.foreground = true
BeltalowdaPo.state.registredConsumers = false
BeltalowdaPo.state.soundPlayed = false
BeltalowdaPo.state.registredActiveConsumers = false
BeltalowdaPo.state.activeLayerIndex = 1

BeltalowdaPo.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaPo.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaPo.callbackName, BeltalowdaPo.OnProfileChanged)
	
	BeltalowdaPo.CreateUI()
	
	BeltalowdaPo.state.sounds = BeltalowdaSound.GetRestrictedSounds()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaPo.SetPoPositionLocked)
	
	BeltalowdaPo.state.initialized = true
	BeltalowdaPo.SetEnabled(BeltalowdaPo.poVars.enabled)
end

function BeltalowdaPo.SetTlwLocation()
	BeltalowdaPo.controls.overviewTLW:ClearAnchors()
	if BeltalowdaPo.poVars.overview.location == nil then
		BeltalowdaPo.controls.overviewTLW:SetAnchor(CENTER, GuiRoot, CENTER, 125, 125)
	else
		BeltalowdaPo.controls.overviewTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaPo.poVars.overview.location.x, BeltalowdaPo.poVars.overview.location.y)
	end
end

function BeltalowdaPo.CreateUI()

	BeltalowdaPo.controls.overviewTLW = wm:CreateTopLevelWindow(BeltalowdaPo.constants.TLW_OVERVIEW)
	
	BeltalowdaPo.SetTlwLocation()
		
	BeltalowdaPo.controls.overviewTLW:SetClampedToScreen(BeltalowdaPo.config.overview.isClampedToScreen)
	--BeltalowdaPo.controls.overviewTLW:SetDrawLayer(0)
	--BeltalowdaPo.controls.overviewTLW:SetDrawLevel(0)
	BeltalowdaPo.controls.overviewTLW:SetHandler("OnMoveStop", BeltalowdaPo.SaveOverviewWindowLocation)
	BeltalowdaPo.controls.overviewTLW:SetDimensions(BeltalowdaPo.config.overview.width, BeltalowdaPo.config.overview.height * 24)
	
	BeltalowdaPo.controls.overviewTLW.rootControl = wm:CreateControl(nil, BeltalowdaPo.controls.overviewTLW, CT_CONTROL)
	
	local rootControl = BeltalowdaPo.controls.overviewTLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaPo.config.overview.width, BeltalowdaPo.config.overview.height * 24)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaPo.controls.overviewTLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaPo.config.overview.width, BeltalowdaPo.config.overview.height * 24)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.playerBlocks = BeltalowdaPo.CreatePlayerBlocks(rootControl, BeltalowdaPo.config.overview.width, BeltalowdaPo.config.overview.progresswidth, BeltalowdaPo.config.overview.height, BeltalowdaPo.config.overview.potionProgressHeight, BeltalowdaPo.config.overview.potionImmovableHeight)
	
	BeltalowdaPo.SetProgressColors()
	BeltalowdaPo.SetPositionLocked(BeltalowdaPo.poVars.positionLocked)
	BeltalowdaPo.SetControlVisibility()
end

function BeltalowdaPo.CreatePlayerBlocks(parent, width, progressWidth, height, potionHeight, immovableHeight)
	local playerBlocks = {}
	if parent ~= nil and width ~= nil and progressWidth ~= nil and height ~= nil and potionHeight ~= nil and immovableHeight ~= nil then
		for i = 1, 24 do
			playerBlocks[i] = wm:CreateControl(nil, parent, CT_CONTROL)
			playerBlocks[i]:SetDimensions(width, height)
			playerBlocks[i]:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, (i - 1) * height)
			playerBlocks[i]:SetHidden(true)
			
			playerBlocks[i].backdrop = wm:CreateControl(nil, playerBlocks[i], CT_BACKDROP)
			playerBlocks[i].backdrop:SetAnchor(TOPLEFT, playerBlocks[i], TOPLEFT, 0, 0)
			playerBlocks[i].backdrop:SetDimensions(width, height)
			playerBlocks[i].backdrop:SetEdgeColor(0,0,0,0)
			
			playerBlocks[i].potionBackdrop = wm:CreateControl(nil, playerBlocks[i], CT_BACKDROP)
			playerBlocks[i].potionBackdrop:SetAnchor(TOPLEFT, playerBlocks[i], TOPLEFT, (width - progressWidth) / 2, (height - potionHeight - immovableHeight) / 2)
			playerBlocks[i].potionBackdrop:SetDimensions(progressWidth, potionHeight)
			playerBlocks[i].potionBackdrop:SetEdgeColor(0,0,0,0)
			playerBlocks[i].potionBackdrop:SetAlpha(1)
			
			playerBlocks[i].potionProgress = wm:CreateControl(nil, playerBlocks[i], CT_STATUSBAR)
			playerBlocks[i].potionProgress:SetAnchor(TOPLEFT, playerBlocks[i], TOPLEFT, (width - progressWidth) / 2, (height - potionHeight - immovableHeight) / 2)
			playerBlocks[i].potionProgress:SetDimensions(progressWidth, potionHeight)
			playerBlocks[i].potionProgress:SetMinMax(0, 100)
			playerBlocks[i].potionProgress:SetValue(0)
			
			local potionFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, potionHeight - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
			playerBlocks[i].potionLabel = wm:CreateControl(nil, playerBlocks[i].potionProgress, CT_LABEL)
			playerBlocks[i].potionLabel:SetAnchor(TOPLEFT, playerBlocks[i].potionProgress, TOPLEFT, 0, 0)
			playerBlocks[i].potionLabel:SetFont(potionFont)
			playerBlocks[i].potionLabel:SetWrapMode(ELLIPSIS)
			playerBlocks[i].potionLabel:SetDimensions(progressWidth, potionHeight)
			playerBlocks[i].potionLabel:SetText("")
			playerBlocks[i].potionLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
			--playerBlocks[i].potionLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			
			playerBlocks[i].immovableBackdrop = wm:CreateControl(nil, playerBlocks[i], CT_BACKDROP)
			playerBlocks[i].immovableBackdrop:SetAnchor(TOPLEFT, playerBlocks[i], TOPLEFT, (width - progressWidth) / 2, (height - potionHeight - immovableHeight) / 2 + potionHeight)
			playerBlocks[i].immovableBackdrop:SetDimensions(progressWidth, immovableHeight)
			playerBlocks[i].immovableBackdrop:SetEdgeColor(0,0,0,0)
			playerBlocks[i].immovableBackdrop:SetAlpha(1)
			
			playerBlocks[i].immovableProgress = wm:CreateControl(nil, playerBlocks[i], CT_STATUSBAR)
			playerBlocks[i].immovableProgress:SetAnchor(TOPLEFT, playerBlocks[i], TOPLEFT, (width - progressWidth) / 2, (height - potionHeight - immovableHeight) / 2 + potionHeight)
			playerBlocks[i].immovableProgress:SetDimensions(progressWidth, immovableHeight)
			playerBlocks[i].immovableProgress:SetMinMax(0, 100)
			playerBlocks[i].immovableProgress:SetValue(0)
			
			local immovableFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, immovableHeight - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
			playerBlocks[i].immovableLabel = wm:CreateControl(nil, playerBlocks[i].immovableProgress, CT_LABEL)
			playerBlocks[i].immovableLabel:SetAnchor(TOPLEFT, playerBlocks[i].immovableProgress, TOPLEFT, 0, 0)
			playerBlocks[i].immovableLabel:SetFont(immovableFont)
			playerBlocks[i].immovableLabel:SetWrapMode(ELLIPSIS)
			playerBlocks[i].immovableLabel:SetDimensions(progressWidth, immovableHeight)
			playerBlocks[i].immovableLabel:SetText("")
			playerBlocks[i].immovableLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
			--playerBlocks[i].immovableLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			
		end
	end
	return playerBlocks
end

function BeltalowdaPo.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.overview = {}
	defaults.overview.noImmovableColor = {}
	defaults.overview.noImmovableColor.r = 1
	defaults.overview.noImmovableColor.g = 0.23
	defaults.overview.noImmovableColor.b = 0.23
	defaults.overview.noImmovableColor.a = 0.6
	defaults.overview.immovableColorFull = {}
	defaults.overview.immovableColorFull.r = 0
	defaults.overview.immovableColorFull.g = 1
	defaults.overview.immovableColorFull.b = 0
	defaults.overview.immovableColorFull.a = 0.6
	defaults.overview.immovableColorLow = {}
	defaults.overview.immovableColorLow.r = 1
	defaults.overview.immovableColorLow.g = 0.5
	defaults.overview.immovableColorLow.b = 0.2
	defaults.overview.immovableColorLow.a = 0.6
	defaults.overview.immovableProgressColor = {}
	defaults.overview.immovableProgressColor.r = 0.2
	defaults.overview.immovableProgressColor.g = 1
	defaults.overview.immovableProgressColor.b = 0.2
	defaults.overview.potionCraftedProgressColor = {}
	defaults.overview.potionCraftedProgressColor.r = 0.2
	defaults.overview.potionCraftedProgressColor.g = 0.2
	defaults.overview.potionCraftedProgressColor.b = 1
	defaults.overview.potionCrownProgressColor = {}
	defaults.overview.potionCrownProgressColor.r = 1
	defaults.overview.potionCrownProgressColor.g = 0
	defaults.overview.potionCrownProgressColor.b = 1
	defaults.overview.potionNonCraftedProgressColor = {}
	defaults.overview.potionNonCraftedProgressColor.r = 1
	defaults.overview.potionNonCraftedProgressColor.g = 0
	defaults.overview.potionNonCraftedProgressColor.b = 0
	defaults.overview.potionAllianceProgressColor = {}
	defaults.overview.potionAllianceProgressColor.r = 1
	defaults.overview.potionAllianceProgressColor.g = 1
	defaults.overview.potionAllianceProgressColor.b = 0
	defaults.overview.immovableLabelColor = {}
	defaults.overview.immovableLabelColor.r = 1
	defaults.overview.immovableLabelColor.g = 1
	defaults.overview.immovableLabelColor.b = 1
	defaults.overview.potionLabelColor = {}
	defaults.overview.potionLabelColor.r = 1
	defaults.overview.potionLabelColor.g = 1
	defaults.overview.potionLabelColor.b = 1
	defaults.overview.immovableBackdrop = {}
	defaults.overview.immovableBackdrop.r = 0
	defaults.overview.immovableBackdrop.g = 0
	defaults.overview.immovableBackdrop.b = 0
	defaults.overview.potionBackdrop = {}
	defaults.overview.potionBackdrop.r = 0
	defaults.overview.potionBackdrop.g = 0
	defaults.overview.potionBackdrop.b = 0
	defaults.soundEnabled = true
	defaults.selectedSound = "BG_CA_AreaCaptured_Moved"
	return defaults
end

function BeltalowdaPo.SetProgressColors()
	local playerBlocks = BeltalowdaPo.controls.overviewTLW.rootControl.playerBlocks
	for i = 1, 24 do
		playerBlocks[i].immovableProgress:SetColor(BeltalowdaPo.poVars.overview.immovableProgressColor.r, BeltalowdaPo.poVars.overview.immovableProgressColor.g, BeltalowdaPo.poVars.overview.immovableProgressColor.b, 1)
		playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionCraftedProgressColor.r, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.g, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.b, 1)
		playerBlocks[i].potionLabel:SetColor(BeltalowdaPo.poVars.overview.potionLabelColor.r, BeltalowdaPo.poVars.overview.potionLabelColor.g, BeltalowdaPo.poVars.overview.potionLabelColor.b, 1)
		playerBlocks[i].immovableLabel:SetColor(BeltalowdaPo.poVars.overview.immovableLabelColor.r, BeltalowdaPo.poVars.overview.immovableLabelColor.g, BeltalowdaPo.poVars.overview.immovableLabelColor.b, 1)
		playerBlocks[i].potionBackdrop:SetCenterColor(BeltalowdaPo.poVars.overview.potionBackdrop.r, BeltalowdaPo.poVars.overview.potionBackdrop.g, BeltalowdaPo.poVars.overview.potionBackdrop.b ,0.75)
		playerBlocks[i].immovableBackdrop:SetCenterColor(BeltalowdaPo.poVars.overview.immovableBackdrop.r, BeltalowdaPo.poVars.overview.immovableBackdrop.g, BeltalowdaPo.poVars.overview.immovableBackdrop.b, 0.75)
		
	end
end

function BeltalowdaPo.SetEnabled(value)
	if BeltalowdaPo.state.initialized == true and value ~= nil then
		BeltalowdaPo.poVars.enabled = value
		if value == true then
			if BeltalowdaPo.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaPo.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaPo.OnPlayerActivated)
				
			end
			BeltalowdaPo.state.registredConsumers = true
		else
			if BeltalowdaPo.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaPo.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaPo.state.registredConsumers = false
		end
		BeltalowdaPo.OnPlayerActivated()
	end
end

function BeltalowdaPo.SetControlVisibility()
	local enabled = BeltalowdaPo.poVars.enabled
	local pvpOnly = BeltalowdaPo.poVars.pvpOnly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaPo.state.foreground == false then
			BeltalowdaPo.controls.overviewTLW:SetHidden(BeltalowdaPo.state.activeLayerIndex > 2)
		else
			BeltalowdaPo.controls.overviewTLW:SetHidden(false)
		end
	else
		BeltalowdaPo.controls.overviewTLW:SetHidden(setHidden)
	end
end

function BeltalowdaPo.SetPositionLocked(value)
	BeltalowdaPo.poVars.positionLocked = value
	BeltalowdaPo.controls.overviewTLW:SetMovable(not value)
	BeltalowdaPo.controls.overviewTLW:SetMouseEnabled(not value)
	
	if value == true then
		BeltalowdaPo.controls.overviewTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaPo.controls.overviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaPo.controls.overviewTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaPo.controls.overviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaPo.GetDistanceColorTone(r1, r2, minValue, maxValue, distance)
	local d = maxValue - minValue
	local color = r1
	
	local delta = r2 - r1
	
	if delta > 0 then
		color = r1 + delta * ((distance - minValue) / d)
	elseif delta < 0 then
		color = r2 - delta * (d - (distance - minValue)) / d
	end
	return color
end

--callbacks
function BeltalowdaPo.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaPo.poVars = currentProfile.group.po
		if BeltalowdaPo.state.initialized == true then
			BeltalowdaPo.SetPositionLocked(BeltalowdaPo.poVars.positionLocked)
			BeltalowdaPo.SetControlVisibility()
			BeltalowdaPo.SetProgressColors()
			BeltalowdaPo.SetTlwLocation()
		end
		BeltalowdaPo.SetEnabled(BeltalowdaPo.poVars.enabled)
		
	end
end

function BeltalowdaPo.SaveOverviewWindowLocation()
	if BeltalowdaPo.poVars.positionLocked == false then
		BeltalowdaPo.poVars.overview.location = BeltalowdaPo.poVars.overview.location or {}
		BeltalowdaPo.poVars.overview.location.x = BeltalowdaPo.controls.overviewTLW:GetLeft()
		BeltalowdaPo.poVars.overview.location.y = BeltalowdaPo.controls.overviewTLW:GetTop()
	end
end

function BeltalowdaPo.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaPo.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaPo.state.foreground = false
	end
	--hack?
	BeltalowdaPo.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaPo.SetControlVisibility()
end

function BeltalowdaPo.OnPlayerActivated(eventCode, initial)
	if BeltalowdaPo.poVars.enabled == true and (BeltalowdaPo.poVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaPo.poVars.pvpOnly == false) then
		--d("register")
		if BeltalowdaPo.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaPo.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaPo.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaPo.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaPo.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaPo.callbackName, BeltalowdaPo.config.updateInterval, BeltalowdaPo.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaPo.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaPo.config.updateInterval)
			BeltalowdaPo.state.registredActiveConsumers = true
		end
	else
		--d("unregister")
		if BeltalowdaPo.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaPo.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaPo.callbackName, EVENT_ACTION_LAYER_PUSHED)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaPo.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaPo.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaPo.state.registredActiveConsumers = false
		end
	end
	BeltalowdaPo.SetControlVisibility()
end

function BeltalowdaPo.UiLoop()
	if BeltalowdaPo.poVars.pvpOnly == false or (BeltalowdaPo.poVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		local playerBlocks = BeltalowdaPo.controls.overviewTLW.rootControl.playerBlocks
		local timeStamp = GetGameTimeMilliseconds() / 1000
		if players ~= nil then
			for i = 1, #players do
				playerBlocks[i]:SetHidden(false)
				playerBlocks[i].potionLabel:SetText(players[i].name)
				if players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.potion ~= nil and players[i].buffs.specialInformation.potion.started ~= nil and players[i].buffs.specialInformation.potion.started + BeltalowdaPo.constants.COOLDOWN > timeStamp then
					--d("potted")
					if players[i].isLeader == true and BeltalowdaPo.poVars.soundEnabled == true and BeltalowdaPo.state.soundPlayed == false then
						BeltalowdaSound.PlaySoundByName(BeltalowdaPo.poVars.selectedSound)
						BeltalowdaPo.state.soundPlayed = true
					end
					local potion = players[i].buffs.specialInformation.potion
					-- U30+ Change (Temporary Fix)
					--[[
					if potion.type == BeltalowdaUtilGroup.constants.potionTypes.CRAFTED then
						playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionCraftedProgressColor.r, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.g, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.b, 1)
					elseif potion.type == BeltalowdaUtilGroup.constants.potionTypes.CROWN then
						playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionCrownProgressColor.r, BeltalowdaPo.poVars.overview.potionCrownProgressColor.g, BeltalowdaPo.poVars.overview.potionCrownProgressColor.b, 1)
					elseif potion.type == BeltalowdaUtilGroup.constants.potionTypes.NON_CRAFTED then
						playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionNonCraftedProgressColor.r, BeltalowdaPo.poVars.overview.potionNonCraftedProgressColor.g, BeltalowdaPo.poVars.overview.potionNonCraftedProgressColor.b, 1)
					elseif potion.type == BeltalowdaUtilGroup.constants.potionTypes.ALLIANCE then
						playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionAllianceProgressColor.r, BeltalowdaPo.poVars.overview.potionAllianceProgressColor.g, BeltalowdaPo.poVars.overview.potionAllianceProgressColor.b, 1)
					end
					]]
					playerBlocks[i].potionProgress:SetColor(BeltalowdaPo.poVars.overview.potionCraftedProgressColor.r, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.g, BeltalowdaPo.poVars.overview.potionCraftedProgressColor.b, 1)
					
					playerBlocks[i].potionProgress:SetValue(100 - (timeStamp - potion.started) / BeltalowdaPo.constants.COOLDOWN * 100)
					if potion.immovableStart ~= nil and potion.immovableEnd ~= nil then
						local percent = 100 - (timeStamp - potion.immovableStart) / (potion.immovableEnd - potion.immovableStart) * 100
						playerBlocks[i].immovableProgress:SetValue(percent)
						playerBlocks[i].immovableLabel:SetText(string.format("%.1f",potion.immovableEnd - timeStamp))
						local color = {}
						color.r = BeltalowdaPo.GetDistanceColorTone(BeltalowdaPo.poVars.overview.immovableColorLow.r, BeltalowdaPo.poVars.overview.immovableColorFull.r, 0, 100, percent)
						color.g = BeltalowdaPo.GetDistanceColorTone(BeltalowdaPo.poVars.overview.immovableColorLow.g, BeltalowdaPo.poVars.overview.immovableColorFull.g, 0, 100, percent)
						color.b = BeltalowdaPo.GetDistanceColorTone(BeltalowdaPo.poVars.overview.immovableColorLow.b, BeltalowdaPo.poVars.overview.immovableColorFull.b, 0, 100, percent)
						color.a = BeltalowdaPo.GetDistanceColorTone(BeltalowdaPo.poVars.overview.immovableColorLow.a, BeltalowdaPo.poVars.overview.immovableColorFull.a, 0, 100, percent)
						playerBlocks[i].backdrop:SetCenterColor(color.r, color.g, color.b, color.a)
					else
						playerBlocks[i].immovableProgress:SetValue(0)
						playerBlocks[i].immovableLabel:SetText("")
						playerBlocks[i].backdrop:SetCenterColor(BeltalowdaPo.poVars.overview.noImmovableColor.r, BeltalowdaPo.poVars.overview.noImmovableColor.g, BeltalowdaPo.poVars.overview.noImmovableColor.b, BeltalowdaPo.poVars.overview.noImmovableColor.a)
					end
				else
					if players[i].isLeader == true then
						BeltalowdaPo.state.soundPlayed = false
					end
					playerBlocks[i].potionProgress:SetValue(0)
					playerBlocks[i].immovableProgress:SetValue(0)
					playerBlocks[i].immovableLabel:SetText("")
					playerBlocks[i].backdrop:SetCenterColor(BeltalowdaPo.poVars.overview.noImmovableColor.r, BeltalowdaPo.poVars.overview.noImmovableColor.g, BeltalowdaPo.poVars.overview.noImmovableColor.b, BeltalowdaPo.poVars.overview.noImmovableColor.a)
				end
			end
			for i = #players + 1, 24 do
				playerBlocks[i]:SetHidden(true)
			end
		else
			for i = 1, 24 do
				playerBlocks[i]:SetHidden(true)
			end
		end
		--BeltalowdaPo.SetControlVisibility()
	end
end

--menu interaction
function BeltalowdaPo.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.PO_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.PO_ENABLED,
					getFunc = BeltalowdaPo.GetPoEnabled,
					setFunc = BeltalowdaPo.SetPoEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.PO_POSITION_FIXED,
					getFunc = BeltalowdaPo.GetPoPositionLocked,
					setFunc = BeltalowdaPo.SetPoPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.PO_PVP_ONLY,
					getFunc = BeltalowdaPo.GetPoPvpOnly,
					setFunc = BeltalowdaPo.SetPoPvpOnly
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_NO_IMMOVABLE,
					getFunc = BeltalowdaPo.GetPoBgColorNoImmovable,
					setFunc = BeltalowdaPo.SetPoBgColorNoImmovable,
					width = "full"
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_FULL,
					getFunc = BeltalowdaPo.GetPoBgColorImmovableFull,
					setFunc = BeltalowdaPo.SetPoBgColorImmovableFull,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_LOW,
					getFunc = BeltalowdaPo.GetPoBgColorImmovableLow,
					setFunc = BeltalowdaPo.SetPoBgColorImmovableLow,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_PROGRESS_IMMOVABLE,
					getFunc = BeltalowdaPo.GetPoProgressColorImmovable,
					setFunc = BeltalowdaPo.SetPoProgressColorImmovable,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION,
					getFunc = BeltalowdaPo.GetPoCraftedProgressColorPotion,
					setFunc = BeltalowdaPo.SetPoCraftedProgressColorPotion,
					width = "full"
				},
				-- U30+ Change (Temporary Fix)
				--[[
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_CROWN_PROGRESS_POTION,
					getFunc = BeltalowdaPo.GetPoCrownProgressColorPotion,
					setFunc = BeltalowdaPo.SetPoCrownProgressColorPotion,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_NON_CRAFTED_PROGRESS_POTION,
					getFunc = BeltalowdaPo.GetPoNonCraftedProgressColorPotion,
					setFunc = BeltalowdaPo.SetPoNonCraftedProgressColorPotion,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_ALLIANCE_PROGRESS_POTION,
					getFunc = BeltalowdaPo.GetPoAllianceProgressColorPotion,
					setFunc = BeltalowdaPo.SetPoAllianceProgressColorPotion,
					width = "full"
				},
				]]
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_LABEL_IMMOVABLE,
					getFunc = BeltalowdaPo.GetPoProgressLabelColorImmovable,
					setFunc = BeltalowdaPo.SetPoProgressLabelColorImmovable,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_LABEL_POTION,
					getFunc = BeltalowdaPo.GetPoProgressLabelColorPotion,
					setFunc = BeltalowdaPo.SetPoProgressLabelColorPotion,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_BACKDROP_IMMOVABLE,
					getFunc = BeltalowdaPo.GetPoProgressBackdropColorImmovable,
					setFunc = BeltalowdaPo.SetPoProgressBackdropColorImmovable,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.PO_COLOR_BACKDROP_POTION,
					getFunc = BeltalowdaPo.GetPoProgressBackdropColorPotion,
					setFunc = BeltalowdaPo.SetPoProgressBackdropColorPotion,
					width = "full"
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.PO_SOUND_ENABLED,
					getFunc = BeltalowdaPo.GetPoSoundEnabled,
					setFunc = BeltalowdaPo.SetPoSoundEnabled
				},
				[14] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.PO_SELECTED_SOUND,
					choices = BeltalowdaPo.GetPoAvailableSounds(),
					getFunc = BeltalowdaPo.GetPoSelectedSound,
					setFunc = BeltalowdaPo.SetPoSelectedSound,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaPo.GetPoEnabled()
	return BeltalowdaPo.poVars.enabled
end

function BeltalowdaPo.SetPoEnabled(value)
	BeltalowdaPo.SetEnabled(value)
end

function BeltalowdaPo.GetPoPositionLocked()
	return BeltalowdaPo.poVars.positionLocked
end

function BeltalowdaPo.SetPoPositionLocked(value)
	BeltalowdaPo.SetPositionLocked(value)
end

function BeltalowdaPo.GetPoPvpOnly()
	return BeltalowdaPo.poVars.pvpOnly
end

function BeltalowdaPo.SetPoPvpOnly(value)
	BeltalowdaPo.poVars.pvpOnly = value
	BeltalowdaPo.SetControlVisibility()
end

function BeltalowdaPo.GetPoBgColorNoImmovable()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaPo.poVars.overview.noImmovableColor)
end

function BeltalowdaPo.SetPoBgColorNoImmovable(r, g, b, a)
	BeltalowdaPo.poVars.overview.noImmovableColor = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

function BeltalowdaPo.GetPoBgColorImmovableFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaPo.poVars.overview.immovableColorFull)
end

function BeltalowdaPo.SetPoBgColorImmovableFull(r, g, b, a)
	BeltalowdaPo.poVars.overview.immovableColorFull = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

function BeltalowdaPo.GetPoBgColorImmovableLow()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaPo.poVars.overview.immovableColorLow)
end

function BeltalowdaPo.SetPoBgColorImmovableLow(r, g, b, a)
	BeltalowdaPo.poVars.overview.immovableColorLow = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

function BeltalowdaPo.GetPoProgressColorImmovable()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.immovableProgressColor)
end

function BeltalowdaPo.SetPoProgressColorImmovable(r, g, b)
	BeltalowdaPo.poVars.overview.immovableProgressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoCraftedProgressColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionCraftedProgressColor)
end

function BeltalowdaPo.SetPoCraftedProgressColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionCraftedProgressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoCrownProgressColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionCrownProgressColor)
end

function BeltalowdaPo.SetPoCrownProgressColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionCrownProgressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoNonCraftedProgressColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionNonCraftedProgressColor)
end

function BeltalowdaPo.SetPoNonCraftedProgressColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionNonCraftedProgressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoAllianceProgressColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionAllianceProgressColor)
end

function BeltalowdaPo.SetPoAllianceProgressColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionAllianceProgressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoProgressLabelColorImmovable()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.immovableLabelColor)
end

function BeltalowdaPo.SetPoProgressLabelColorImmovable(r, g, b)
	BeltalowdaPo.poVars.overview.immovableLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoProgressLabelColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionLabelColor)
end

function BeltalowdaPo.SetPoProgressLabelColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoProgressBackdropColorImmovable()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.immovableBackdrop)
end

function BeltalowdaPo.SetPoProgressBackdropColorImmovable(r, g, b)
	BeltalowdaPo.poVars.overview.immovableBackdrop = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoProgressBackdropColorPotion()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaPo.poVars.overview.potionBackdrop)
end

function BeltalowdaPo.SetPoProgressBackdropColorPotion(r, g, b)
	BeltalowdaPo.poVars.overview.potionBackdrop = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaPo.SetProgressColors()
end

function BeltalowdaPo.GetPoSoundEnabled()
	return BeltalowdaPo.poVars.soundEnabled
end

function BeltalowdaPo.SetPoSoundEnabled(value)
	BeltalowdaPo.poVars.soundEnabled = value
end

function BeltalowdaPo.GetPoAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaPo.state.sounds do
		sounds[i] = BeltalowdaPo.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaPo.GetPoSelectedSound()
	return BeltalowdaPo.poVars.selectedSound
end

function BeltalowdaPo.SetPoSelectedSound(value)
	if value ~= nil then
		BeltalowdaPo.poVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end
