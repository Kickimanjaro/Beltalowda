-- Beltalowda Cyrodiil Status
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.cs = BeltalowdaTB.cs or {}
local BeltalowdaCS = BeltalowdaTB.cs
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.allianceColor = BeltalowdaUtil.allianceColor or {}
local BeltalowdaAC = BeltalowdaUtil.allianceColor
BeltalowdaUtil.cyrodiil = BeltalowdaUtil.cyrodiil or {}
local BeltalowdaCyro = BeltalowdaUtil.cyrodiil


BeltalowdaCS.callbackName = Beltalowda.addonName .. "CyrodiilStatus"

BeltalowdaCS.config = {}
BeltalowdaCS.config.isClampedToScreen = true
BeltalowdaCS.config.imageWidth = 30
BeltalowdaCS.config.nameWidth = 150
BeltalowdaCS.config.flagWidth = 40
BeltalowdaCS.config.flagHeight = 8
BeltalowdaCS.config.flagFlipWidth = 20
BeltalowdaCS.config.underAttackForWidth = 50
BeltalowdaCS.config.width = 375
BeltalowdaCS.config.siegeWidth = 20
BeltalowdaCS.config.entryHeight = 30
BeltalowdaCS.config.height = BeltalowdaCS.config.entryHeight * 10
BeltalowdaCS.config.backdropAlphaOdd = 0.25
BeltalowdaCS.config.backdropAlphaEven = 0.15
BeltalowdaCS.config.flagBackdropColor = {}
BeltalowdaCS.config.flagBackdropColor.r = 0.1
BeltalowdaCS.config.flagBackdropColor.g = 0.1
BeltalowdaCS.config.flagBackdropColor.b = 0.1

BeltalowdaCS.constants = BeltalowdaCS.constants or {}
BeltalowdaCS.constants.PREFIX = "CS"
BeltalowdaCS.constants.TLW = "Beltalowda.toolbox.cs.tlw"
BeltalowdaCS.constants.textures = {}
BeltalowdaCS.constants.textures.TEXTURE_KEEP = "/esoui/art/mappins/ava_largekeep_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_OUTPOST = "/esoui/art/mappins/ava_outpost_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_VILLAGE = "/esoui/art/mappins/ava_town_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_TEMPLE = "/esoui/art/icons/mapkey/mapkey_temple.dds"
BeltalowdaCS.constants.textures.TEXTURE_DESTRUCTIBLE_BRDIGE = ""
BeltalowdaCS.constants.textures.TEXTURE_DESTRUCTIBLE_GATE = ""
BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_MINE = "/esoui/art/compass/ava_mine_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_FARM = "/esoui/art/compass/ava_farm_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_LUMBER = "/esoui/art/compass/ava_lumbermill_neutral.dds"
BeltalowdaCS.constants.textures.TEXTURE_BRIDGE_PASSABLE = "/esoui/art/mappins/ava_bridge_passable.dds"
BeltalowdaCS.constants.textures.TEXTURE_BRIDGE_NOT_PASSABLE = "/esoui/art/mappins/ava_bridge_not_passable.dds"
BeltalowdaCS.constants.textures.TEXTURE_MILEGATE_PASSABLE = "/esoui/art/mappins/ava_milegate_passable.dds"
BeltalowdaCS.constants.textures.TEXTURE_MILEGATE_NOT_PASSABLE = "/esoui/art/mappins/ava_milegate_not_passable.dds"

BeltalowdaCS.state = {}
BeltalowdaCS.state.initialized = false
BeltalowdaCS.state.foreground = true
BeltalowdaCS.state.registredConsumers = false
BeltalowdaCS.state.registredCyrodiilConsumers = false
BeltalowdaCS.state.activeLayerIndex = 1
BeltalowdaCS.state.visibleControls = {}

BeltalowdaCS.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaCS.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaCS.callbackName, BeltalowdaCS.OnProfileChanged)
	
	BeltalowdaCS.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaCS.SetCsPositionLocked)
	
	BeltalowdaCS.AdjustDisplayedComponents()
	BeltalowdaCS.state.initialized = true
	BeltalowdaCS.SetEnabled(BeltalowdaCS.csVars.enabled)
	BeltalowdaCS.SetPositionLocked(BeltalowdaCS.csVars.positionLocked)
	--BeltalowdaCS.SetControlVisibility()
end

function BeltalowdaCS.SetTlwLocation()
	BeltalowdaCS.controls.TLW:ClearAnchors()
	if BeltalowdaCS.csVars.location == nil then
		BeltalowdaCS.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 250, -250)
	else
		BeltalowdaCS.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaCS.csVars.location.x, BeltalowdaCS.csVars.location.y)
	end
end

function BeltalowdaCS.CreateUI()
	BeltalowdaCS.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaCS.constants.TLW)
	
	BeltalowdaCS.SetTlwLocation()
	
		
	BeltalowdaCS.controls.TLW:SetClampedToScreen(BeltalowdaCS.config.isClampedToScreen)
	BeltalowdaCS.controls.TLW:SetHandler("OnMoveStop", BeltalowdaCS.SaveWindowLocation)
	BeltalowdaCS.controls.TLW:SetDimensions(BeltalowdaCS.config.width, BeltalowdaCS.config.height)
	
	BeltalowdaCS.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaCS.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaCS.controls.TLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaCS.config.width, BeltalowdaCS.config.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaCS.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaCS.config.width, BeltalowdaCS.config.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	BeltalowdaCS.state.visibleControls = BeltalowdaCS.CreateDefaultList(rootControl)
	for i = 1, #BeltalowdaCS.state.visibleControls do
		BeltalowdaCS.state.visibleControls[i]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaCS.config.entryHeight * (i - 1))
	end
end

function BeltalowdaCS.CreateDefaultList(parent)
	local entries = {}
	for i = 1, 10 do
		local entry = BeltalowdaCS.CreateEntryControl(parent)
		
		table.insert(entries, entry)
	end
	return entries
end

function BeltalowdaCS.CreateEntryControl(parent)
	local controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaCS.config.entryHeight - 12, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	--d(controlFont)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(BeltalowdaCS.config.width, BeltalowdaCS.config.entryHeight)
	control:SetHidden(true)
	
	control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.backdrop:SetDimensions(BeltalowdaCS.config.width, BeltalowdaCS.config.entryHeight)
	control.backdrop:SetDrawLayer(0)
	
	control.uaImage = wm:CreateControl(nil, control, CT_TEXTURE)
	control.uaImage:SetAnchor(TOPLEFT, control, TOPLEFT, -1, -1)
	control.uaImage:SetDimensions(BeltalowdaCS.config.imageWidth + 2, BeltalowdaCS.config.entryHeight + 2)
	control.uaImage:SetTexture("/esoui/art/mappins/ava_attackburst_64.dds")
	control.uaImage:SetHidden(true)
	control.uaImage:SetDrawLayer(1)
	
	control.image = wm:CreateControl(nil, control, CT_TEXTURE)
	control.image:SetAnchor(TOPLEFT, control, TOPLEFT, -2, -2)
	control.image:SetDimensions(BeltalowdaCS.config.imageWidth + 4, BeltalowdaCS.config.entryHeight + 4)
	control.image:SetDrawLayer(2)
	
	control.name = wm:CreateControl(nil, control, CT_LABEL)
	control.name:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4, 0) 
	control.name:SetDimensions(BeltalowdaCS.config.nameWidth, BeltalowdaCS.config.entryHeight)
	control.name:SetFont(controlFont)
	control.name:SetWrapMode(ELLIPSIS)
	control.name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	control.progress = wm:CreateControl(nil, control, CT_CONTROL)
	control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth, 0)
	control.progress:SetDimensions(BeltalowdaCS.config.flagWidth, BeltalowdaCS.config.entryHeight)
	
	control.progress.bar1 = BeltalowdaCS.CreateProgressBar(control.progress)
	control.progress.bar2 = BeltalowdaCS.CreateProgressBar(control.progress)
	control.progress.bar3 = BeltalowdaCS.CreateProgressBar(control.progress)
	
	control.adSiege = wm:CreateControl(nil, control, CT_LABEL)
	control.adSiege:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth + BeltalowdaCS.config.flagWidth, 0) 
	control.adSiege:SetDimensions(BeltalowdaCS.config.siegeWidth, BeltalowdaCS.config.entryHeight)
	control.adSiege:SetFont(controlFont)
	control.adSiege:SetWrapMode(ELLIPSIS)
	control.adSiege:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.adSiege:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	control.epSiege = wm:CreateControl(nil, control, CT_LABEL)
	control.epSiege:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth + BeltalowdaCS.config.flagWidth + BeltalowdaCS.config.siegeWidth, 0) 
	control.epSiege:SetDimensions(BeltalowdaCS.config.siegeWidth, BeltalowdaCS.config.entryHeight)
	control.epSiege:SetFont(controlFont)
	control.epSiege:SetWrapMode(ELLIPSIS)
	control.epSiege:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.epSiege:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	control.dcSiege = wm:CreateControl(nil, control, CT_LABEL)
	control.dcSiege:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth + BeltalowdaCS.config.flagWidth + BeltalowdaCS.config.siegeWidth * 2, 0) 
	control.dcSiege:SetDimensions(BeltalowdaCS.config.siegeWidth, BeltalowdaCS.config.entryHeight)
	control.dcSiege:SetFont(controlFont)
	control.dcSiege:SetWrapMode(ELLIPSIS)
	control.dcSiege:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.dcSiege:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	control.flipStatus = wm:CreateControl(nil, control, CT_LABEL)
	control.flipStatus:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth + BeltalowdaCS.config.flagWidth + BeltalowdaCS.config.siegeWidth * 3 + 10, 0) 
	control.flipStatus:SetDimensions(BeltalowdaCS.config.flagFlipWidth, BeltalowdaCS.config.entryHeight)
	control.flipStatus:SetFont(controlFont)
	control.flipStatus:SetWrapMode(ELLIPSIS)
	control.flipStatus:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.flipStatus:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
	
	control.underAttackFor = wm:CreateControl(nil, control, CT_LABEL)
	control.underAttackFor:SetAnchor(TOPRIGHT, control, TOPRIGHT, 0, 0) 
	control.underAttackFor:SetDimensions(BeltalowdaCS.config.underAttackForWidth, BeltalowdaCS.config.entryHeight)
	control.underAttackFor:SetFont(controlFont)
	control.underAttackFor:SetWrapMode(ELLIPSIS)
	control.underAttackFor:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	control.underAttackFor:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
	--control.underAttackFor:SetText("00:00")
	
	return control
end

function BeltalowdaCS.CreateProgressBar(parent)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(BeltalowdaCS.config.flagWidth, BeltalowdaCS.config.flagHeight)
	control:SetHidden(true)
	
	control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.backdrop:SetDimensions(BeltalowdaCS.config.flagWidth, BeltalowdaCS.config.flagHeight)
	control.backdrop:SetEdgeColor(0, 0, 0, 0)
	control.backdrop:SetCenterColor(BeltalowdaCS.config.flagBackdropColor.r, BeltalowdaCS.config.flagBackdropColor.g, BeltalowdaCS.config.flagBackdropColor.b, 1)
	
	control.progress = wm:CreateControl(nil, control, CT_STATUSBAR)
	control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, 1, 1)
	control.progress:SetDimensions(BeltalowdaCS.config.flagWidth - 2, BeltalowdaCS.config.flagHeight - 2)
	control.progress:SetMinMax(0, 100)
	control.progress:SetValue(0)
	return control
end

function BeltalowdaCS.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.positionLocked = false
	defaults.showKeeps = true
	defaults.showResources = true
	defaults.showOutposts = true
	defaults.showVillages = true
	defaults.showTemples = true
	defaults.showDestructibles = true
	defaults.defaultColor = {}
	defaults.defaultColor.r = 1
	defaults.defaultColor.g = 1
	defaults.defaultColor.b = 1
	defaults.cooldownColor = {}
	defaults.cooldownColor.r = 0
	defaults.cooldownColor.g = 1
	defaults.cooldownColor.b = 0
	defaults.flipsAtPositiveColor = {}
	defaults.flipsAtPositiveColor.r = 0
	defaults.flipsAtPositiveColor.g = 1
	defaults.flipsAtPositiveColor.b = 0
	defaults.flipsAtNegativeColor = {}
	defaults.flipsAtNegativeColor.r = 1
	defaults.flipsAtNegativeColor.g = 0
	defaults.flipsAtNegativeColor.b = 0
	defaults.hideOnWorldMap = false
	defaults.showFlags = true
	defaults.showSieges = true
	defaults.showOwnerChanges = true
	defaults.showActionTimers = true
	return defaults
end

function BeltalowdaCS.SetEnabled(value)
	if BeltalowdaCS.state.initialized == true and value ~= nil then
		BeltalowdaCS.csVars.enabled = value
		if value == true then
			if BeltalowdaCS.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaCS.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaCS.OnPlayerActivated)
			end
			BeltalowdaCS.state.registredConsumers = true
			
		else
			if BeltalowdaCS.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaCS.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaCS.state.registredConsumers = false
		end
		BeltalowdaCS.OnPlayerActivated()
	end
end

function BeltalowdaCS.SetPositionLocked(value)
	BeltalowdaCS.csVars.positionLocked = value
	
	BeltalowdaCS.controls.TLW:SetMovable(not value)
	BeltalowdaCS.controls.TLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaCS.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaCS.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaCS.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaCS.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaCS.SetControlVisibility()
	local enabled = BeltalowdaCS.csVars.enabled
	local setHidden = true
	if enabled ~= nil and enabled == true and BeltalowdaUtil.IsInCyrodiil() == true then
		setHidden = false
	end
	if setHidden == false then
		if BeltalowdaCS.csVars.hideOnWorldMap == false and SCENE_MANAGER ~= nil and SCENE_MANAGER.currentScene ~= nil and SCENE_MANAGER.currentScene.name == "worldMap" then
			BeltalowdaCS.controls.TLW:SetHidden(false)
		elseif BeltalowdaCS.state.foreground == false then
			BeltalowdaCS.controls.TLW:SetHidden(BeltalowdaCS.state.activeLayerIndex > 2)
		else
			BeltalowdaCS.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaCS.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaCS.GetTextureAndOffsetForItem(keepType, rType, isPassable)
	if keepType == KEEPTYPE_KEEP then
		return BeltalowdaCS.constants.textures.TEXTURE_KEEP, 3
	elseif keepType == KEEPTYPE_OUTPOST then
		return BeltalowdaCS.constants.textures.TEXTURE_OUTPOST, 3
	elseif keepType == KEEPTYPE_RESOURCE then
		if rType == BeltalowdaCyro.constants.resourceType.FARM then
			return BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_FARM, -1
		elseif rType == BeltalowdaCyro.constants.resourceType.MINE then
			return BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_MINE, -1
		elseif rType == BeltalowdaCyro.constants.resourceType.LUMBER then
			return BeltalowdaCS.constants.textures.TEXTURE_RESOURCE_LUMBER, -1
		end
	elseif keepType == KEEPTYPE_TOWN then
		return BeltalowdaCS.constants.textures.TEXTURE_VILLAGE, 2
	elseif keepType == KEEPTYPE_ARTIFACT_KEEP then
		return BeltalowdaCS.constants.textures.TEXTURE_TEMPLE, -2
	elseif keepType == KEEPTYPE_BRIDGE then
		if isPassable == true then
			return BeltalowdaCS.constants.textures.TEXTURE_BRIDGE_PASSABLE, -2
		else
			return BeltalowdaCS.constants.textures.TEXTURE_BRIDGE_NOT_PASSABLE, -2
		end
	elseif keepType == KEEPTYPE_MILEGATE then
		if isPassable == true then
			return BeltalowdaCS.constants.textures.TEXTURE_MILEGATE_PASSABLE, -2
		else
			return BeltalowdaCS.constants.textures.TEXTURE_MILEGATE_NOT_PASSABLE, -2
		end
	end
	return "", 0
end

function BeltalowdaCS.SetSiegeWeapons(control, weapons)
	if weapons ~= nil and weapons > 0 then
		control:SetText(weapons)
	else
		control:SetText("")
	end
end

function BeltalowdaCS.FormatUnderAttackTime(underAttackFor)
	if underAttackFor ~= nil or underAttackFor == 0 then
		local minutes = string.format("%d", underAttackFor / 60)
		local seconds = underAttackFor - minutes * 60
		if seconds > 0 and seconds < 10 then
			return string.format("%d:0%d", minutes, seconds)
		elseif seconds == 0 then
			return string.format("%d:00", minutes)
		else
			return string.format("%d:%d", minutes, seconds)
		end
	else
		return ""
	end
end

function BeltalowdaCS.UpdateEntries(itemsOfInterest)
	--d(#itemsOfInterest)
	local adColor = BeltalowdaAC.GetColorForAlliance(ALLIANCE_ALDMERI_DOMINION)
	local epColor = BeltalowdaAC.GetColorForAlliance(ALLIANCE_EBONHEART_PACT)
	local dcColor = BeltalowdaAC.GetColorForAlliance(ALLIANCE_DAGGERFALL_COVENANT)
	local index = 1
	for i = 1, #itemsOfInterest do
		
		local itemOfInterest = itemsOfInterest[i]
		local showItem = false
		if itemOfInterest.keepType == KEEPTYPE_KEEP and BeltalowdaCS.csVars.showKeeps == true then
			showItem = true
		elseif itemOfInterest.keepType == KEEPTYPE_OUTPOST and BeltalowdaCS.csVars.showOutposts == true then
			showItem = true
		elseif itemOfInterest.keepType == KEEPTYPE_RESOURCE and BeltalowdaCS.csVars.showResources == true then
			showItem = true
		elseif itemOfInterest.keepType == KEEPTYPE_TOWN and BeltalowdaCS.csVars.showVillages == true then
			showItem = true
		elseif itemOfInterest.keepType == KEEPTYPE_ARTIFACT_KEEP and BeltalowdaCS.csVars.showTemples == true then
			showItem = true
		elseif (itemOfInterest.keepType == KEEPTYPE_BRIDGE or itemOfInterest.keepType == KEEPTYPE_MILEGATE) and BeltalowdaCS.csVars.showDestructibles == true then
			showItem = true
		end
		
		if showItem == true then
			local control = BeltalowdaCS.state.visibleControls[index]
			control:ClearAnchors()
			control:SetAnchor(TOPLEFT, BeltalowdaCS.controls.TLW.rootControl, TOPLEFT, 0, BeltalowdaCS.config.entryHeight * (index - 1))
			control:SetHidden(false)
			local ac = BeltalowdaAC.GetColorForAlliance(itemOfInterest.owningAlliance)
			--d(ac)
			--d("---")
			if index % 2 == 0 then
				control.backdrop:SetCenterColor(ac.r, ac.g, ac.b, BeltalowdaCS.config.backdropAlphaEven)
			else
				control.backdrop:SetCenterColor(ac.r, ac.g, ac.b, BeltalowdaCS.config.backdropAlphaOdd)
			end
			control.backdrop:SetEdgeColor(0,0,0,0)
			if itemOfInterest.isUnderAttack == true then
				control.backdrop:SetHidden(false)
				control.uaImage:SetHidden(false)
				control.image:SetHidden(false)
			else
				control.backdrop:SetHidden(false)
				control.uaImage:SetHidden(true)
				control.image:SetHidden(false)
			end
			local texture, offset = BeltalowdaCS.GetTextureAndOffsetForItem(itemOfInterest.keepType, itemOfInterest.rType, itemOfInterest.isPassable)
			control.image:SetTexture(texture)
			control.image:ClearAnchors()
			control.image:SetAnchor(TOPLEFT, control, TOPLEFT, -offset, -offset)
			control.image:SetDimensions(BeltalowdaCS.config.imageWidth + offset * 2, BeltalowdaCS.config.entryHeight + offset * 2)
			control.image:SetColor(ac.r, ac.g, ac.b, 1)
			control.name:SetColor(ac.r, ac.g, ac.b, 1)
			control.name:SetText(itemOfInterest.name)
			if BeltalowdaCS.csVars.showSieges == true then
				if itemOfInterest.siegeWeapons ~= nil then
					BeltalowdaCS.SetSiegeWeapons(control.adSiege, itemOfInterest.siegeWeapons.AD)
					BeltalowdaCS.SetSiegeWeapons(control.epSiege, itemOfInterest.siegeWeapons.EP)
					BeltalowdaCS.SetSiegeWeapons(control.dcSiege, itemOfInterest.siegeWeapons.DC)
					control.adSiege:SetColor(adColor.r, adColor.g, adColor.b, 1)
					control.epSiege:SetColor(epColor.r, epColor.g, epColor.b, 1)
					control.dcSiege:SetColor(dcColor.r, dcColor.g, dcColor.b, 1)
				else
					control.adSiege:SetText("")
					control.epSiege:SetText("")
					control.dcSiege:SetText("")
				end
			end
			if BeltalowdaCS.csVars.showActionTimers == true then
				local underAttackFor = itemOfInterest.underAttackFor
				control.underAttackFor:SetText(BeltalowdaCS.FormatUnderAttackTime(underAttackFor / 1000))
				if itemOfInterest.isCoolingDown == true then
					control.underAttackFor:SetColor(BeltalowdaCS.csVars.cooldownColor.r, BeltalowdaCS.csVars.cooldownColor.g, BeltalowdaCS.csVars.cooldownColor.b,1)
				else
					control.underAttackFor:SetColor(BeltalowdaCS.csVars.defaultColor.r, BeltalowdaCS.csVars.defaultColor.g, BeltalowdaCS.csVars.defaultColor.b,1)
				end
			end
			local objectives = itemOfInterest.objectives
			if BeltalowdaCS.csVars.showFlags == true then
				
				control.progress.bar1:ClearAnchors()
				control.progress.bar2:ClearAnchors()
				control.progress.bar3:ClearAnchors()
				if itemOfInterest.keepType == KEEPTYPE_KEEP or itemOfInterest.keepType == KEEPTYPE_OUTPOST then
					control.progress.bar1:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 2 - BeltalowdaCS.config.flagHeight - 1)
					control.progress.bar2:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 2 + 1)
					
					control.progress.bar1:SetHidden(false)
					control.progress.bar2:SetHidden(false)
					control.progress.bar3:SetHidden(true)
					
					if objectives ~= nil and objectives[1] ~= nil and objectives[2] ~= nil then
						control.progress.bar1.progress:SetValue(objectives[1].state)
						control.progress.bar2.progress:SetValue(objectives[2].state)
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[1].holdingAlliance)))
						control.progress.bar2.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[2].holdingAlliance)))
					else
						control.progress.bar1.progress:SetValue(100)
						control.progress.bar2.progress:SetValue(100)
						BeltalowdaChat.SendChatMessage("Objectives are nil", BeltalowdaCS.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
						control.progress.bar2.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
					end

					
				elseif itemOfInterest.keepType == KEEPTYPE_TOWN then
					control.progress.bar1:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 6 - BeltalowdaCS.config.flagHeight / 2)
					control.progress.bar2:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 6 * 3 - BeltalowdaCS.config.flagHeight / 2)
					control.progress.bar3:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 6 * 5 - BeltalowdaCS.config.flagHeight / 2)
				
					control.progress.bar1:SetHidden(false)
					control.progress.bar2:SetHidden(false)
					control.progress.bar3:SetHidden(false)
					
					if objectives ~= nil then
						control.progress.bar1.progress:SetValue(objectives[1].state)
						control.progress.bar2.progress:SetValue(objectives[2].state)
						control.progress.bar3.progress:SetValue(objectives[3].state)
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[1].holdingAlliance)))
						control.progress.bar2.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[2].holdingAlliance)))
						control.progress.bar3.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[3].holdingAlliance)))
					else
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
						control.progress.bar2.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
						control.progress.bar3.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
					end
					
					
				elseif itemOfInterest.keepType == KEEPTYPE_RESOURCE then
					control.progress.bar1:SetAnchor(TOPLEFT, control.progress, TOPLEFT, 0, BeltalowdaCS.config.entryHeight / 2 - BeltalowdaCS.config.flagHeight / 2)
				
					control.progress.bar1:SetHidden(false)
					control.progress.bar2:SetHidden(true)
					control.progress.bar3:SetHidden(true)
					
					if objectives ~= nil then
						control.progress.bar1.progress:SetValue(objectives[1].state)
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(objectives[1].holdingAlliance)))
					else
						control.progress.bar1.progress:SetColor(BeltalowdaUtil.ColorRgbToParams(BeltalowdaAC.GetColorForAlliance(0)))
					end
					
					
				else
					control.progress.bar1:SetHidden(true)
					control.progress.bar2:SetHidden(true)
					control.progress.bar3:SetHidden(true)
				end
			end
			if BeltalowdaCS.csVars.showOwnerChanges == true then
				if itemOfInterest.flipsAt ~= nil then
					local flipsIn = math.floor((itemOfInterest.flipsAt - GetGameTimeMilliseconds()) / 1000)
					if flipsIn >= 0 then
						control.flipStatus:SetText(flipsIn)
						if objectives ~= nil and objectives[1].holdingAlliance == GetUnitAlliance("player") then
							control.flipStatus:SetColor(BeltalowdaCS.csVars.flipsAtPositiveColor.r, BeltalowdaCS.csVars.flipsAtPositiveColor.g, BeltalowdaCS.csVars.flipsAtPositiveColor.b)
						else
							control.flipStatus:SetColor(BeltalowdaCS.csVars.flipsAtNegativeColor.r, BeltalowdaCS.csVars.flipsAtNegativeColor.g, BeltalowdaCS.csVars.flipsAtNegativeColor.b)
						end
					else
						control.flipStatus:SetText("")
					end
				else
					control.flipStatus:SetText("")
				end
			end
			index = index + 1
		end
		
	end
	for i = index, #BeltalowdaCS.state.visibleControls do
		BeltalowdaCS.state.visibleControls[i]:SetHidden(true)
	end
end

function BeltalowdaCS.AdjustDisplayedComponents()
	local globalWidth = BeltalowdaCS.config.width
	for i = 1, #BeltalowdaCS.state.visibleControls do
		local offset = BeltalowdaCS.config.imageWidth + 4 + BeltalowdaCS.config.nameWidth
		local control = BeltalowdaCS.state.visibleControls[i]
		local progress = control.progress
		progress:ClearAnchors()
		if BeltalowdaCS.csVars.showFlags == true then
			progress:SetHidden(false)
			progress:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.flagWidth
		else
			progress:SetHidden(true)
		end
		local adSiege = control.adSiege
		local epSiege = control.epSiege
		local dcSiege = control.dcSiege
		adSiege:ClearAnchors()
		epSiege:ClearAnchors()
		dcSiege:ClearAnchors()
		if BeltalowdaCS.csVars.showSieges == true then
			adSiege:SetHidden(false)
			adSiege:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.siegeWidth
			epSiege:SetHidden(false)
			epSiege:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.siegeWidth
			dcSiege:SetHidden(false)
			dcSiege:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.siegeWidth
		else
			adSiege:SetHidden(true)
			epSiege:SetHidden(true)
			dcSiege:SetHidden(true)
		end
		offset = offset + 10
		local flipStatus = control.flipStatus
		flipStatus:ClearAnchors()
		if BeltalowdaCS.csVars.showOwnerChanges == true then
			
			flipStatus:SetHidden(false)
			flipStatus:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.flagFlipWidth
		else
			flipStatus:SetHidden(true)
		end
		offset = offset + 10
		local underAttackFor = control.underAttackFor
		--underAttackFor:ClearAnchors()
		if BeltalowdaCS.csVars.showActionTimers == true then
			underAttackFor:SetHidden(false)
			--underAttackFor:SetAnchor(TOPLEFT, control, TOPLEFT, offset, 0)
			offset = offset + BeltalowdaCS.config.underAttackForWidth
		else
			underAttackFor:SetHidden(true)
		end
		globalWidth = offset
		control:SetDimensions(globalWidth, BeltalowdaCS.config.entryHeight)
		control.backdrop:SetDimensions(globalWidth, BeltalowdaCS.config.entryHeight)
	end
	BeltalowdaCS.controls.TLW:SetDimensions(globalWidth, BeltalowdaCS.config.height)
	BeltalowdaCS.controls.TLW.rootControl.movableBackdrop:SetDimensions(globalWidth, BeltalowdaCS.config.height)
end

--callbacks
function BeltalowdaCS.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaCS.csVars = currentProfile.toolbox.cs
		BeltalowdaCS.SetEnabled(BeltalowdaCS.csVars.enabled)
		if BeltalowdaCS.state.initialized == true then
			BeltalowdaCS.SetPositionLocked(BeltalowdaCS.csVars.positionLocked)
			BeltalowdaCS.SetTlwLocation()
			BeltalowdaCS.AdjustDisplayedComponents()
		end
	end
end

function BeltalowdaCS.SaveWindowLocation()
	if BeltalowdaCS.csVars.positionLocked == false then
		BeltalowdaCS.csVars.location = BeltalowdaCS.csVars.location or {}
		BeltalowdaCS.csVars.location.x = BeltalowdaCS.controls.TLW:GetLeft()
		BeltalowdaCS.csVars.location.y = BeltalowdaCS.controls.TLW:GetTop()
	end
end

function BeltalowdaCS.OnPlayerActivated(eventCode, initial)
	if BeltalowdaCS.csVars.enabled == true and BeltalowdaUtil.IsInCyrodiil() == true then
		if BeltalowdaCS.state.registredCyrodiilConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCS.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaCS.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCS.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaCS.SetForegroundVisibility)
			BeltalowdaCyro.AddConsumer(BeltalowdaCS.callbackName, BeltalowdaCS.OnUiUpdate, nil)
			BeltalowdaCS.state.registredCyrodiilConsumers = true
		end
	else
		if BeltalowdaCS.state.registredCyrodiilConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCS.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCS.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaCyro.RemoveConsumer(BeltalowdaCS.callbackName)
			BeltalowdaCS.state.registredCyrodiilConsumers = false
		end
	end
	BeltalowdaCS.SetControlVisibility()
end

function BeltalowdaCS.OnUiUpdate(itemsOfInterest)
	if itemsOfInterest ~= nil then
		if #itemsOfInterest > #BeltalowdaCS.state.visibleControls then
			for i = #BeltalowdaCS.state.visibleControls + 1, #itemsOfInterest do
				local control = BeltalowdaCS.CreateEntryControl(BeltalowdaCS.controls.TLW.rootControl)
				control:ClearAnchors()
				control:SetAnchor(TOPLEFT, BeltalowdaCS.controls.TLW.rootControl, TOPLEFT, 0, BeltalowdaCS.config.entryHeight * (#BeltalowdaCS.state.visibleControls + i - 1))
				control:SetHidden(false)
				table.insert(BeltalowdaCS.state.visibleControls, control)
			end
			BeltalowdaCS.AdjustDisplayedComponents()
		else
			for i = #itemsOfInterest + 1, #BeltalowdaCS.state.visibleControls do
				BeltalowdaCS.state.visibleControls[i]:SetHidden(true)
			end
		end
		BeltalowdaCS.UpdateEntries(itemsOfInterest)
	else
		for i = 1, #BeltalowdaCS.state.visibleControls do
			BeltalowdaCS.state.visibleControls[i]:SetHidden(true)
		end
	end
end

function BeltalowdaCS.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaCS.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaCS.state.foreground = false
	end
	--hack?
	BeltalowdaCS.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaCS.SetControlVisibility()
end

--menu interactions
function BeltalowdaCS.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CS_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_ENABLED,
					getFunc = BeltalowdaCS.GetCsEnabled,
					setFunc = BeltalowdaCS.SetCsEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_POSITION_FIXED,
					getFunc = BeltalowdaCS.GetCsPositionLocked,
					setFunc = BeltalowdaCS.SetCsPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_HIDE_ON_WORLDMAP,
					getFunc = BeltalowdaCS.GetCsHideOnWorldMap,
					setFunc = BeltalowdaCS.SetCsHideOnWorldMap
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_FLAGS,
					getFunc = BeltalowdaCS.GetCsShowFlagsEnabled,
					setFunc = BeltalowdaCS.SetCsShowFlagsEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_SIEGES,
					getFunc = BeltalowdaCS.GetCsShowSiegesEnabled,
					setFunc = BeltalowdaCS.SetCsShowSiegesEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_OWNER_CHANGES,
					getFunc = BeltalowdaCS.GetCsShowOwnerChangesEnabled,
					setFunc = BeltalowdaCS.SetCsShowOwnerChangesEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_ACTION_TIMERS,
					getFunc = BeltalowdaCS.GetCsShowActionTimersEnabled,
					setFunc = BeltalowdaCS.SetCsShowActionTimersEnabled
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CS_COLOR_DEFAULT,
					getFunc = BeltalowdaCS.GetCsDefaultColor,
					setFunc = BeltalowdaCS.SetCsDefaultColor,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CS_COLOR_COOLDOWN,
					getFunc = BeltalowdaCS.GetCsCooldownColor,
					setFunc = BeltalowdaCS.SetCsCooldownColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CS_COLOR_FLIPS_POSITIVE,
					getFunc = BeltalowdaCS.GetCsFlipsAtPositiveColor,
					setFunc = BeltalowdaCS.SetCsFlipsAtPositiveColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CS_COLOR_FLIPS_NEGATIVE,
					getFunc = BeltalowdaCS.GetCsFlipsAtNegativeColor,
					setFunc = BeltalowdaCS.SetCsFlipsAtNegativeColor,
					width = "full"
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_KEEPS,
					getFunc = BeltalowdaCS.GetCsShowKeeps,
					setFunc = BeltalowdaCS.SetCsShowKeeps
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_OUTPOSTS,
					getFunc = BeltalowdaCS.GetCsShowOutposts,
					setFunc = BeltalowdaCS.SetCsShowOutposts
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_RESOURCES,
					getFunc = BeltalowdaCS.GetCsShowResources,
					setFunc = BeltalowdaCS.SetCsShowResources
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_VILLAGES,
					getFunc = BeltalowdaCS.GetCsShowVillages,
					setFunc = BeltalowdaCS.SetCsShowVillages
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_TEMPLES,
					getFunc = BeltalowdaCS.GetCsShowTemples,
					setFunc = BeltalowdaCS.SetCsShowTemples
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CS_SHOW_DESTRUCTIBLES,
					getFunc = BeltalowdaCS.GetCsShowDestructibles,
					setFunc = BeltalowdaCS.SetCsShowDestructibles
				}
			}
		}
	}
	return menu
end

function BeltalowdaCS.GetCsEnabled()
	return BeltalowdaCS.csVars.enabled
end

function BeltalowdaCS.SetCsEnabled(value)
	BeltalowdaCS.SetEnabled(value)
end

function BeltalowdaCS.GetCsPositionLocked()
	return BeltalowdaCS.csVars.positionLocked
end

function BeltalowdaCS.SetCsPositionLocked(value)
	BeltalowdaCS.SetPositionLocked(value)
end

function BeltalowdaCS.GetCsHideOnWorldMap()
	return BeltalowdaCS.csVars.hideOnWorldMap
end

function BeltalowdaCS.SetCsHideOnWorldMap(value)
	BeltalowdaCS.csVars.hideOnWorldMap = value
end

function BeltalowdaCS.GetCsShowFlagsEnabled()
	return BeltalowdaCS.csVars.showFlags
end

function BeltalowdaCS.SetCsShowFlagsEnabled(value)
	BeltalowdaCS.csVars.showFlags = value
	BeltalowdaCS.AdjustDisplayedComponents()
end

function BeltalowdaCS.GetCsShowSiegesEnabled()
	return BeltalowdaCS.csVars.showSieges
end

function BeltalowdaCS.SetCsShowSiegesEnabled(value)
	BeltalowdaCS.csVars.showSieges = value
	BeltalowdaCS.AdjustDisplayedComponents()
end

function BeltalowdaCS.GetCsShowOwnerChangesEnabled()
	return BeltalowdaCS.csVars.showOwnerChanges
end

function BeltalowdaCS.SetCsShowOwnerChangesEnabled(value)
	BeltalowdaCS.csVars.showOwnerChanges = value
	BeltalowdaCS.AdjustDisplayedComponents()
end

function BeltalowdaCS.GetCsShowActionTimersEnabled()
	return BeltalowdaCS.csVars.showActionTimers
end

function BeltalowdaCS.SetCsShowActionTimersEnabled(value)
	BeltalowdaCS.csVars.showActionTimers = value
	BeltalowdaCS.AdjustDisplayedComponents()
end

function BeltalowdaCS.GetCsDefaultColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaCS.csVars.defaultColor)
end

function BeltalowdaCS.SetCsDefaultColor(r, g, b)
	BeltalowdaCS.csVars.defaultColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaCS.GetCsCooldownColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaCS.csVars.cooldownColor)
end

function BeltalowdaCS.SetCsCooldownColor(r, g, b)
	BeltalowdaCS.csVars.cooldownColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaCS.GetCsFlipsAtPositiveColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaCS.csVars.flipsAtPositiveColor)
end

function BeltalowdaCS.SetCsFlipsAtPositiveColor(r, g, b)
	BeltalowdaCS.csVars.flipsAtPositiveColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaCS.GetCsFlipsAtNegativeColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaCS.csVars.flipsAtNegativeColor)
end

function BeltalowdaCS.SetCsFlipsAtNegativeColor(r, g, b)
	BeltalowdaCS.csVars.flipsAtNegativeColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaCS.GetCsShowKeeps()
	return BeltalowdaCS.csVars.showKeeps
end

function BeltalowdaCS.SetCsShowKeeps(value)
	BeltalowdaCS.csVars.showKeeps = value
end

function BeltalowdaCS.GetCsShowOutposts()
	return BeltalowdaCS.csVars.showOutposts
end

function BeltalowdaCS.SetCsShowOutposts(value)
	BeltalowdaCS.csVars.showOutposts = value
end

function BeltalowdaCS.GetCsShowResources()
	return BeltalowdaCS.csVars.showResources
end

function BeltalowdaCS.SetCsShowResources(value)
	BeltalowdaCS.csVars.showResources = value
end

function BeltalowdaCS.GetCsShowVillages()
	return BeltalowdaCS.csVars.showVillages
end

function BeltalowdaCS.SetCsShowVillages(value)
	BeltalowdaCS.csVars.showVillages = value
end

function BeltalowdaCS.GetCsShowTemples()
	return BeltalowdaCS.csVars.showTemples
end

function BeltalowdaCS.SetCsShowTemples(value)
	BeltalowdaCS.csVars.showTemples = value
end

function BeltalowdaCS.GetCsShowDestructibles()
	return BeltalowdaCS.csVars.showDestructibles
end

function BeltalowdaCS.SetCsShowDestructibles(value)
	BeltalowdaCS.csVars.showDestructibles = value
end