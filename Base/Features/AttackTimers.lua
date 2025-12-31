-- Beltalowda Attack Timers Tracker
-- By @Kickimanjaro
-- Fully self-contained module for tracking Detonation and Shalk attack timers
-- Migrated from AttackTimers.lua in Phase 3 Milestone 4

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
Beltalowda.features.attackTimers = Beltalowda.features.attackTimers or {}
local BeltalowdaAttackTimers = Beltalowda.features.attackTimers
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

BeltalowdaAttackTimers.constants = BeltalowdaAttackTimers.constants or {}
BeltalowdaAttackTimers.constants.TLW = "Beltalowda.features.attackTimers.tlw"

BeltalowdaAttackTimers.constants.size = {}
BeltalowdaAttackTimers.constants.size.SMALL = 1
BeltalowdaAttackTimers.constants.size.BIG = 2

BeltalowdaAttackTimers.constants.modes = {}
BeltalowdaAttackTimers.constants.MODE_BOTH = 1
BeltalowdaAttackTimers.constants.MODE_DETONATION = 2
BeltalowdaAttackTimers.constants.MODE_SHALK = 3

BeltalowdaAttackTimers.constants.TYPE_DETONATION = 1
BeltalowdaAttackTimers.constants.TYPE_SUBTERRANEAN_ASSAULT = 2
BeltalowdaAttackTimers.constants.TYPE_DEEP_FRISSURE = 3

BeltalowdaAttackTimers.callbackName = Beltalowda.addonName .. "AttackTimers"

BeltalowdaAttackTimers.config = {}
BeltalowdaAttackTimers.config.updateInterval = 100
BeltalowdaAttackTimers.config.isClampedToScreen = false
BeltalowdaAttackTimers.config.sizes = {}
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL] = {}
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].width = 150
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].blockHeight = 20
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].height = 200
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].fontSize = 15
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG] = {}
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].width = 300
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].blockHeight = 40
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].height = 400
BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].fontSize = 30

BeltalowdaAttackTimers.state = {}
BeltalowdaAttackTimers.state.initialized = false
BeltalowdaAttackTimers.state.foreground = true
BeltalowdaAttackTimers.state.registredConsumers = false
BeltalowdaAttackTimers.state.activeLayerIndex = 1
BeltalowdaAttackTimers.state.registredActiveConsumers = false
BeltalowdaAttackTimers.state.width = BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].width
BeltalowdaAttackTimers.state.blockHeight = BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].blockHeight
BeltalowdaAttackTimers.state.height = BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].height
BeltalowdaAttackTimers.state.fontSize = BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].fontSize
BeltalowdaAttackTimers.state.font = nil

BeltalowdaAttackTimers.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaAttackTimers.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaAttackTimers.callbackName, BeltalowdaAttackTimers.OnProfileChanged)
	
	BeltalowdaAttackTimers.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaAttackTimers.SetDtPositionLocked)
	
	BeltalowdaAttackTimers.state.initialized = true
	BeltalowdaAttackTimers.SetEnabled(BeltalowdaAttackTimers.vars.enabled)
end

function BeltalowdaAttackTimers.SetTlwLocation()
	BeltalowdaAttackTimers.controls.TLW:ClearAnchors()
	if BeltalowdaAttackTimers.vars.location == nil then
		BeltalowdaAttackTimers.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -125, -125)
	else
		BeltalowdaAttackTimers.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaAttackTimers.vars.location.x, BeltalowdaAttackTimers.vars.location.y)
	end
end

function BeltalowdaAttackTimers.CreateUI()
	BeltalowdaAttackTimers.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaAttackTimers.constants.TLW)
	
	BeltalowdaAttackTimers.SetTlwLocation()

		
	BeltalowdaAttackTimers.controls.TLW:SetClampedToScreen(BeltalowdaAttackTimers.config.isClampedToScreen)
	BeltalowdaAttackTimers.controls.TLW:SetHandler("OnMoveStop", BeltalowdaAttackTimers.SaveWindowLocation)
	BeltalowdaAttackTimers.controls.TLW:SetDimensions(BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.height)
	
	BeltalowdaAttackTimers.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaAttackTimers.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaAttackTimers.controls.TLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaAttackTimers.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.playerBlocks = BeltalowdaAttackTimers.CreatePlayerBlocks(rootControl, BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.blockHeight)
	BeltalowdaAttackTimers.controls.TLW:SetHidden(true)
	BeltalowdaAttackTimers.AdjustMode()
	BeltalowdaAttackTimers.AdjustSize()
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.CreatePlayerBlock(parent, width, blockHeight, font)
	local playerBlock = wm:CreateControl(nil, parent, CT_CONTROL)
	--playerBlock:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, (i - 1) * blockHeight)
	playerBlock:SetDimensions(width, blockHeight)
	playerBlock:SetHidden(true)
	
	playerBlock.edge = wm:CreateControl(nil, playerBlock, CT_BACKDROP)
	playerBlock.edge:SetAnchor(TOPLEFT, playerBlock, TOPLEFT, 0, 0)
	playerBlock.edge:SetDimensions(width, blockHeight)
	playerBlock.edge:SetEdgeTexture(nil, 2, 2, 2, 0)
	playerBlock.edge:SetCenterColor(0, 0, 0, 0)
	playerBlock.edge:SetEdgeColor(0, 0, 0, 1)
		
	playerBlock.progress = wm:CreateControl(nil, playerBlock, CT_STATUSBAR)
	playerBlock.progress:SetAnchor(CENTER, playerBlock, CENTER, 0, 0)
	playerBlock.progress:SetDimensions(width - 4, blockHeight - 4)
	playerBlock.progress:SetMinMax(0, 100)
	playerBlock.progress:SetValue(0)
	
	playerBlock.timeLabel = wm:CreateControl(nil, playerBlock, CT_LABEL)
	playerBlock.timeLabel:SetAnchor(CENTER, playerBlock, CENTER, 0, 0)
	playerBlock.timeLabel:SetFont(font)
	playerBlock.timeLabel:SetWrapMode(ELLIPSIS)
	playerBlock.timeLabel:SetDimensions(width - 6, blockHeight)
	playerBlock.timeLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	playerBlock.timeLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	playerBlock.nameLabel = wm:CreateControl(nil, playerBlock, CT_LABEL)
	playerBlock.nameLabel:SetAnchor(CENTER, playerBlock, CENTER, 0, 0)
	playerBlock.nameLabel:SetFont(font)
	playerBlock.nameLabel:SetWrapMode(ELLIPSIS)
	playerBlock.nameLabel:SetDimensions(width - 50, blockHeight)
	playerBlock.nameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	playerBlock.nameLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	return playerBlock
end

function BeltalowdaAttackTimers.CreatePlayerBlocks(parent, width, blockHeight)
	local playerBlocks = {}
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, blockHeight - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaAttackTimers.state.font = font
	
	for i = 1, 24 do
		playerBlocks[i] = BeltalowdaAttackTimers.CreatePlayerBlock(parent, width, blockHeight, font)
		playerBlocks[i]:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, (i - 1) * blockHeight)
		
	end
	
	return playerBlocks
end

function BeltalowdaAttackTimers.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.detonation = {}
	defaults.detonation.fontColor = {}
	defaults.detonation.fontColor.r = 1
	defaults.detonation.fontColor.g = 1
	defaults.detonation.fontColor.b = 1
	defaults.detonation.progressColor = {}
	defaults.detonation.progressColor.r = 0.578125
	defaults.detonation.progressColor.g = 0.2890625
	defaults.detonation.progressColor.b = 0.640625
	defaults.subterraneanAssault = {}
	defaults.subterraneanAssault.fontColor = {}
	defaults.subterraneanAssault.fontColor.r = 1
	defaults.subterraneanAssault.fontColor.g = 1
	defaults.subterraneanAssault.fontColor.b = 1
	defaults.subterraneanAssault.progressColor = {}
	defaults.subterraneanAssault.progressColor.r = 0.1
	defaults.subterraneanAssault.progressColor.g = 0.95
	defaults.subterraneanAssault.progressColor.b = 0.1
	defaults.subterraneanAssault2 = {}
	defaults.subterraneanAssault2.fontColor = {}
	defaults.subterraneanAssault2.fontColor.r = 1
	defaults.subterraneanAssault2.fontColor.g = 1
	defaults.subterraneanAssault2.fontColor.b = 1
	defaults.subterraneanAssault2.progressColor = {}
	defaults.subterraneanAssault2.progressColor.r = 1
	defaults.subterraneanAssault2.progressColor.g = 0.8
	defaults.subterraneanAssault2.progressColor.b = 0.1
	defaults.deepFissure = {}
	defaults.deepFissure.fontColor = {}
	defaults.deepFissure.fontColor.r = 1
	defaults.deepFissure.fontColor.g = 1
	defaults.deepFissure.fontColor.b = 1
	defaults.deepFissure.progressColor = {}
	defaults.deepFissure.progressColor.r = 0.2890625
	defaults.deepFissure.progressColor.g = 0.2890625
	defaults.deepFissure.progressColor.b = 0.95
	defaults.deepFissure2 = {}
	defaults.deepFissure2.fontColor = {}
	defaults.deepFissure2.fontColor.r = 1
	defaults.deepFissure2.fontColor.g = 1
	defaults.deepFissure2.fontColor.b = 1
	defaults.deepFissure2.progressColor = {}
	defaults.deepFissure2.progressColor.r = 0.0890625
	defaults.deepFissure2.progressColor.g = 0.0
	defaults.deepFissure2.progressColor.b = 1.00
	defaults.size = BeltalowdaAttackTimers.constants.size.SMALL
	defaults.mode = BeltalowdaAttackTimers.constants.MODE_BOTH
	defaults.smoothTransition = true
	return defaults
end

function BeltalowdaAttackTimers.AdjustSize()
	local sizeIncrease = BeltalowdaAttackTimers.vars.size - BeltalowdaAttackTimers.constants.size.SMALL
	local height = (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].height + (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].height - BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].height) * sizeIncrease)
	local width = (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].width + (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].width - BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].width) * sizeIncrease)
	local blockHeight = (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].blockHeight + (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].blockHeight - BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].blockHeight) * sizeIncrease)
	local fontSize = (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].fontSize + (BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.BIG].fontSize - BeltalowdaAttackTimers.config.sizes[BeltalowdaAttackTimers.constants.size.SMALL].fontSize) * sizeIncrease)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaAttackTimers.state.width = width
	BeltalowdaAttackTimers.state.blockHeight = blockHeight
	BeltalowdaAttackTimers.state.height = height
	BeltalowdaAttackTimers.state.fontSize = fontSize
	BeltalowdaAttackTimers.state.font = font
	local rootControl = BeltalowdaAttackTimers.controls.TLW.rootControl
	local playerBlocks = rootControl.playerBlocks
	for i = 1, #playerBlocks do
		playerBlocks[i]:ClearAnchors()
		playerBlocks[i]:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, (i - 1) * blockHeight)
		playerBlocks[i]:SetDimensions(width, blockHeight)
		playerBlocks[i]:SetHidden(true)
		
		playerBlocks[i].edge:SetDimensions(width, blockHeight)
			
		playerBlocks[i].progress:SetDimensions(width - 4, blockHeight - 4)
		
		playerBlocks[i].timeLabel:SetFont(font)
		playerBlocks[i].timeLabel:SetDimensions(width - 6, blockHeight)
		
		playerBlocks[i].nameLabel:SetFont(font)
		playerBlocks[i].nameLabel:SetDimensions(width - 50, blockHeight)
	end
	BeltalowdaAttackTimers.controls.TLW:SetDimensions(width, height)
	BeltalowdaAttackTimers.controls.TLW.rootControl:SetDimensions(width, height)
	BeltalowdaAttackTimers.controls.TLW.rootControl.movableBackdrop:SetDimensions(width, height)
end

function BeltalowdaAttackTimers.AdjustMode()
	
	
	
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.AdjustColors()
	local playerBlocks = BeltalowdaAttackTimers.controls.TLW.rootControl.playerBlocks
	for i = 1, #playerBlocks do
		if BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_DETONATION then
			playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.detonation.fontColor.r, BeltalowdaAttackTimers.vars.detonation.fontColor.g, BeltalowdaAttackTimers.vars.detonation.fontColor.b)
			playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.detonation.fontColor.r, BeltalowdaAttackTimers.vars.detonation.fontColor.g, BeltalowdaAttackTimers.vars.detonation.fontColor.b)
			playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.detonation.progressColor.r, BeltalowdaAttackTimers.vars.detonation.progressColor.g, BeltalowdaAttackTimers.vars.detonation.progressColor.b)
		end
	end
end

function BeltalowdaAttackTimers.SetEnabled(value)
	if BeltalowdaAttackTimers.state.initialized == true and value ~= nil then
		BeltalowdaAttackTimers.vars.enabled = value
		if value == true then
			if BeltalowdaAttackTimers.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaAttackTimers.OnPlayerActivated)
				
			end
			BeltalowdaAttackTimers.state.registredConsumers = true
		else
			if BeltalowdaAttackTimers.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaAttackTimers.state.registredConsumers = false
		end
		BeltalowdaAttackTimers.OnPlayerActivated()
	end
end

function BeltalowdaAttackTimers.SetControlVisibility()
	local enabled = BeltalowdaAttackTimers.vars.enabled
	local pvpOnly = BeltalowdaAttackTimers.vars.pvpOnly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaAttackTimers.state.foreground == false then
			BeltalowdaAttackTimers.controls.TLW:SetHidden(BeltalowdaAttackTimers.state.activeLayerIndex > 2)
		else
			BeltalowdaAttackTimers.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaAttackTimers.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaAttackTimers.SetPositionLocked(value)
	BeltalowdaAttackTimers.vars.positionLocked = value
	BeltalowdaAttackTimers.controls.TLW:SetMovable(not value)
	BeltalowdaAttackTimers.controls.TLW:SetMouseEnabled(not value)
	
	if value == true then
		BeltalowdaAttackTimers.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaAttackTimers.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaAttackTimers.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaAttackTimers.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaAttackTimers.ComparePlayersByDetonationUptime(playerA, playerB)
	if playerA.buffs.specialInformation.proximityDetonation.remaining < playerB.buffs.specialInformation.proximityDetonation.remaining  then
		return false
	elseif playerA.buffs.specialInformation.proximityDetonation.remaining > playerB.buffs.specialInformation.proximityDetonation.remaining  then
		return true
	else
		return playerA.name < playerB.name
	end
end

function BeltalowdaAttackTimers.ComparePlayersByShalkUptime(playerA, playerB)
	local remainingA = nil
	local remainingB = nil
	if playerA.buffs.specialInformation.subterraneanAssault.active == true then
		remainingA = playerA.buffs.specialInformation.subterraneanAssault.remaining
	elseif playerA.buffs.specialInformation.deepFissure.active == true then
		remainingA = playerA.buffs.specialInformation.deepFissure.remaining
	end
	if playerB.buffs.specialInformation.subterraneanAssault.active == true then
		remainingB = playerB.buffs.specialInformation.subterraneanAssault.remaining
	elseif playerB.buffs.specialInformation.deepFissure.active == true then
		remainingB = playerB.buffs.specialInformation.deepFissure.remaining
	end
	if remainingA < remainingB then
		return false
	elseif remainingA > remainingB then
		return true
	else
		return playerA.name < playerB.name
	end
end

function BeltalowdaAttackTimers.ComparePlayersByDetonationShalkUptime(playerA, playerB)
	if playerA.remaining < playerB.remaining then
		return false
	elseif playerA.remaining > playerB.remaining then
		return true
	else
		if playerA.name ~= playerB.name then
			return playerA.name < playerB.name
		else
			return playerA.buff < playerB.buff
		end
	end
end

function BeltalowdaAttackTimers.GetSortedDetonationPlayerList(players)
	local detosOnly = {}
	local timeStamp = GetGameTimeMilliseconds() / 1000
	for i = 1, #players do
		if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
			players[i].buffs.specialInformation.proximityDetonation.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
			table.insert(detosOnly, players[i])
		end
	end
	table.sort(detosOnly, BeltalowdaAttackTimers.ComparePlayersByDetonationUptime)
	return detosOnly
end

function BeltalowdaAttackTimers.GetSortedList(players)
	local displayItems = {}
	local timeStamp = GetGameTimeMilliseconds() / 1000
	if BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_BOTH then
		local localPlayers = {}
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaAttackTimers.constants.TYPE_DETONATION
				localPlayer.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.proximityDetonation.started
				localPlayer.ending = players[i].buffs.specialInformation.proximityDetonation.ending
				table.insert(displayItems, localPlayer)
			end
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.subterraneanAssault ~= nil and players[i].buffs.specialInformation.subterraneanAssault.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaAttackTimers.constants.TYPE_SUBTERRANEAN_ASSAULT
				localPlayer.remaining = players[i].buffs.specialInformation.subterraneanAssault.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.subterraneanAssault.started
				localPlayer.ending = players[i].buffs.specialInformation.subterraneanAssault.ending
				localPlayer.waveTwo = players[i].buffs.specialInformation.subterraneanAssault.waveTwo
				table.insert(displayItems, localPlayer)
				--d("assault")
			elseif players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.deepFissure ~= nil and players[i].buffs.specialInformation.deepFissure.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaAttackTimers.constants.TYPE_DEEP_FRISSURE
				localPlayer.remaining = players[i].buffs.specialInformation.deepFissure.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.deepFissure.started
				localPlayer.ending = players[i].buffs.specialInformation.deepFissure.ending
				localPlayer.waveTwo = players[i].buffs.specialInformation.deepFissure.waveTwo
				table.insert(displayItems, localPlayer)
				--d("deep")
			end
		end
		table.sort(displayItems, BeltalowdaAttackTimers.ComparePlayersByDetonationShalkUptime)
	elseif BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_DETONATION then
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
				players[i].buffs.specialInformation.proximityDetonation.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
				table.insert(displayItems, players[i])
			end
		end
		table.sort(displayItems, BeltalowdaAttackTimers.ComparePlayersByDetonationUptime)
	elseif BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_SHALK then
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.subterraneanAssault ~= nil and players[i].buffs.specialInformation.subterraneanAssault.active == true then
				players[i].buffs.specialInformation.subterraneanAssault.remaining = players[i].buffs.specialInformation.subterraneanAssault.ending - timeStamp
				table.insert(displayItems, players[i])
			elseif players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.deepFissure ~= nil and players[i].buffs.specialInformation.deepFissure.active == true then
				players[i].buffs.specialInformation.deepFissure.remaining = players[i].buffs.specialInformation.deepFissure.ending - timeStamp
				table.insert(displayItems, players[i])
			end
		end
		table.sort(displayItems, BeltalowdaAttackTimers.ComparePlayersByShalkUptime)
	end
	return displayItems
end

--callbacks
function BeltalowdaAttackTimers.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaAttackTimers.vars = currentProfile.group.dt
		if BeltalowdaAttackTimers.state.initialized == true then
			BeltalowdaAttackTimers.SetControlVisibility()
			BeltalowdaAttackTimers.AdjustMode()
			BeltalowdaAttackTimers.AdjustSize()
			BeltalowdaAttackTimers.AdjustColors()
			BeltalowdaAttackTimers.SetPositionLocked(BeltalowdaAttackTimers.vars.positionLocked)
			BeltalowdaAttackTimers.SetTlwLocation()
		end
		BeltalowdaAttackTimers.SetEnabled(BeltalowdaAttackTimers.vars.enabled)
		
	end
end

function BeltalowdaAttackTimers.SaveWindowLocation()
	if BeltalowdaAttackTimers.vars.positionLocked == false then
		BeltalowdaAttackTimers.vars.location = BeltalowdaAttackTimers.vars.location or {}
		BeltalowdaAttackTimers.vars.location.x = BeltalowdaAttackTimers.controls.TLW:GetLeft()
		BeltalowdaAttackTimers.vars.location.y = BeltalowdaAttackTimers.controls.TLW:GetTop()
	end
end

function BeltalowdaAttackTimers.OnPlayerActivated(eventCode, initial)
	--d(BeltalowdaAttackTimers.vars.enabled)
	if BeltalowdaAttackTimers.vars.enabled == true and (BeltalowdaAttackTimers.vars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaAttackTimers.vars.pvpOnly == false) then
		--d("register")
		if BeltalowdaAttackTimers.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaAttackTimers.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaAttackTimers.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaAttackTimers.callbackName, BeltalowdaAttackTimers.config.updateInterval, BeltalowdaAttackTimers.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaAttackTimers.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaAttackTimers.config.updateInterval)
			BeltalowdaAttackTimers.state.registredActiveConsumers = true
		end
	else
		--d("unregister")
		if BeltalowdaAttackTimers.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaAttackTimers.callbackName, EVENT_ACTION_LAYER_PUSHED)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaAttackTimers.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaAttackTimers.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaAttackTimers.state.registredActiveConsumers = false
		end
	end
	BeltalowdaAttackTimers.SetControlVisibility()
end

function BeltalowdaAttackTimers.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaAttackTimers.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaAttackTimers.state.foreground = false
	end
	--hack?
	BeltalowdaAttackTimers.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaAttackTimers.SetControlVisibility()
end

function BeltalowdaAttackTimers.UiLoop()
	--d("dt")
	if BeltalowdaAttackTimers.vars.pvpOnly == false or (BeltalowdaAttackTimers.vars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		--d("dt")
		if players ~= nil then
			--players = BeltalowdaAttackTimers.GetSortedDetonationPlayerList(players)
			players = BeltalowdaAttackTimers.GetSortedList(players)
			local playerBlocks = BeltalowdaAttackTimers.controls.TLW.rootControl.playerBlocks
			if BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_BOTH then
				for i = 1, #players do
					local timespan = players[i].remaining
					local percent = 0.0
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaAttackTimers.CreatePlayerBlock(BeltalowdaAttackTimers.controls.TLW.rootControl, BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.blockHeight, BeltalowdaAttackTimers.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaAttackTimers.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaAttackTimers.state.blockHeight)
					end
					if timespan < 0 then
						timespan = 0
					end
					if players[i].buff == BeltalowdaAttackTimers.constants.TYPE_DETONATION then
						playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.detonation.fontColor.r, BeltalowdaAttackTimers.vars.detonation.fontColor.g, BeltalowdaAttackTimers.vars.detonation.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.detonation.fontColor.r, BeltalowdaAttackTimers.vars.detonation.fontColor.g, BeltalowdaAttackTimers.vars.detonation.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.detonation.progressColor.r, BeltalowdaAttackTimers.vars.detonation.progressColor.g, BeltalowdaAttackTimers.vars.detonation.progressColor.b)
						percent = players[i].remaining / (players[i].ending - players[i].started) * 100
					elseif players[i].buff == BeltalowdaAttackTimers.constants.TYPE_SUBTERRANEAN_ASSAULT then
						if players[i].waveTwo == false then
							playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.b)
							--d(players[i].remaining)
						else
							playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault2.progressColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault2.progressColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault2.progressColor.b)
						end
						percent = players[i].remaining / (players[i].ending - players[i].started + 5) * 100
						--d("assault")
					elseif players[i].buff == BeltalowdaAttackTimers.constants.TYPE_DEEP_FRISSURE then
						if players[i].waveTwo == false then
							playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.deepFissure.progressColor.r, BeltalowdaAttackTimers.vars.deepFissure.progressColor.g, BeltalowdaAttackTimers.vars.deepFissure.progressColor.b)
							percent = players[i].remaining / (players[i].ending - players[i].started + 5) * 100
						else
							playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure2.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure2.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure2.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure2.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure2.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure2.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.deepFissure2.progressColor.r, BeltalowdaAttackTimers.vars.deepFissure2.progressColor.g, BeltalowdaAttackTimers.vars.deepFissure2.progressColor.b)
							percent = players[i].remaining / (players[i].ending - players[i].started + 2) * 100
						end
						
						--d("deep")
					end
					playerBlocks[i]:SetHidden(false)
					playerBlocks[i].timeLabel:SetText(string.format("%.1f", timespan))
					playerBlocks[i].nameLabel:SetText(players[i].name)
					ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, percent, 100, not BeltalowdaAttackTimers.vars.smoothTransition)
				end
			elseif BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_DETONATION then
				for i = 1, #players do
					local timespan = players[i].buffs.specialInformation.proximityDetonation.remaining
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaAttackTimers.CreatePlayerBlock(BeltalowdaAttackTimers.controls.TLW.rootControl, BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.blockHeight, BeltalowdaAttackTimers.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaAttackTimers.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaAttackTimers.state.blockHeight)
					end
					if timespan < 0 then
						timespan = 0
					end
					
					playerBlocks[i]:SetHidden(false)
					playerBlocks[i].timeLabel:SetText(string.format("%.1f", timespan))
					playerBlocks[i].nameLabel:SetText(players[i].name)
					ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.proximityDetonation.remaining / (players[i].buffs.specialInformation.proximityDetonation.ending - players[i].buffs.specialInformation.proximityDetonation.started) * 100, 100, not BeltalowdaAttackTimers.vars.smoothTransition)
				end
			elseif BeltalowdaAttackTimers.vars.mode == BeltalowdaAttackTimers.constants.MODE_SHALK then
				for i = 1, #players do
					local timespan = 0
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaAttackTimers.CreatePlayerBlock(BeltalowdaAttackTimers.controls.TLW.rootControl, BeltalowdaAttackTimers.state.width, BeltalowdaAttackTimers.state.blockHeight, BeltalowdaAttackTimers.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaAttackTimers.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaAttackTimers.state.blockHeight)
					end
					if players[i].buffs.specialInformation.subterraneanAssault.active == true then
						timespan = players[i].buffs.specialInformation.subterraneanAssault.remaining
						playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.r, BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.g, BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor.b)
						ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.subterraneanAssault.remaining / (players[i].buffs.specialInformation.subterraneanAssault.ending - players[i].buffs.specialInformation.subterraneanAssault.started) * 100, 100, not BeltalowdaAttackTimers.vars.smoothTransition)
						--playerBlocks[i].progress:SetValue(players[i].buffs.specialInformation.subterraneanAssault.remaining / (players[i].buffs.specialInformation.subterraneanAssault.ending - players[i].buffs.specialInformation.subterraneanAssault.started) * 100)
					elseif players[i].buffs.specialInformation.deepFissure.active == true then
						timespan = players[i].buffs.specialInformation.deepFissure.remaining
						playerBlocks[i].timeLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaAttackTimers.vars.deepFissure.fontColor.r, BeltalowdaAttackTimers.vars.deepFissure.fontColor.g, BeltalowdaAttackTimers.vars.deepFissure.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaAttackTimers.vars.deepFissure.progressColor.r, BeltalowdaAttackTimers.vars.deepFissure.progressColor.g, BeltalowdaAttackTimers.vars.deepFissure.progressColor.b)
						ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.deepFissure.remaining / (players[i].buffs.specialInformation.deepFissure.ending - players[i].buffs.specialInformation.deepFissure.started) * 100, 100, not BeltalowdaAttackTimers.vars.smoothTransition)
					end
					if timespan < 0 then
						timespan = 0
					end
					
					playerBlocks[i]:SetHidden(false)
					playerBlocks[i].timeLabel:SetText(string.format("%.1f", timespan))
					playerBlocks[i].nameLabel:SetText(players[i].name)
					
				end
			end
			for i = #players + 1, #playerBlocks do
				playerBlocks[i]:SetHidden(true)
			end
		end
	end
end

--menu interaction

-- Note: Menu functions (GetMenu and all Get*/Set* functions) have been moved to
-- Base/Features/AttackTimers.lua as part of Phase 2 refactoring.
-- Core implementation remains here.
-- Delegation function maintained for backward compatibility with Group.lua

function BeltalowdaAttackTimers.GetMenu()
	-- Delegate to new wrapper location
	if Beltalowda and Beltalowda.features and Beltalowda.features.attackTimers and Beltalowda.features.attackTimers.GetMenu then
		return Beltalowda.features.attackTimers.GetMenu()
	end
	return {}
end

-- ============================================================================
-- MENU FUNCTIONS (Phase 2 Migration - Now integrated)
-- ============================================================================

function BeltalowdaAttackTimers.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.DT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_ENABLED,
					getFunc = BeltalowdaAttackTimers.GetDtEnabled,
					setFunc = BeltalowdaAttackTimers.SetDtEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_POSITION_FIXED,
					getFunc = BeltalowdaAttackTimers.GetDtPositionLocked,
					setFunc = BeltalowdaAttackTimers.SetDtPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_PVP_ONLY,
					getFunc = BeltalowdaAttackTimers.GetDtPvpOnly,
					setFunc = BeltalowdaAttackTimers.SetDtPvpOnly
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.DT_MODE,
					choices = BeltalowdaAttackTimers.GetDtAvailableModes(),
					getFunc = BeltalowdaAttackTimers.GetDtSelectedMode,
					setFunc = BeltalowdaAttackTimers.SetDtSelectedMode,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.DT_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaAttackTimers.GetDtSelectedSize,
					setFunc = BeltalowdaAttackTimers.SetDtSelectedSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION,
					getFunc = BeltalowdaAttackTimers.GetDtSmoothTransition,
					setFunc = BeltalowdaAttackTimers.SetDtSmoothTransition
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION,
					getFunc = BeltalowdaAttackTimers.GetDtDetonationFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDetonationFontColor,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION,
					getFunc = BeltalowdaAttackTimers.GetDtDetonationProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDetonationProgressColor,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssaultFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssaultFontColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssaultProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssaultProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssault2FontColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssault2FontColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssault2ProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssault2ProgressColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissureFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissureFontColor,
					width = "full"
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissureProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissureProgressColor,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissure2FontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissure2FontColor,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissure2ProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissure2ProgressColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaAttackTimers.GetDtEnabled()
	return BeltalowdaAttackTimers.vars.enabled
end

function BeltalowdaAttackTimers.SetDtEnabled(value)
	-- Update saved variable directly (menu needs immediate update)
	BeltalowdaAttackTimers.vars.enabled = value
	-- Call core function for event handling
	BeltalowdaAttackTimers.SetEnabled(value)
	-- Ensure visibility updates immediately
	if BeltalowdaAttackTimers.SetControlVisibility then
		BeltalowdaAttackTimers.SetControlVisibility()
	end
end

function BeltalowdaAttackTimers.GetDtPositionLocked()
	return BeltalowdaAttackTimers.vars.positionLocked
end

function BeltalowdaAttackTimers.SetDtPositionLocked(value)
	BeltalowdaAttackTimers.SetPositionLocked(value)
end

function BeltalowdaAttackTimers.GetDtPvpOnly()
	return BeltalowdaAttackTimers.vars.pvpOnly
end

function BeltalowdaAttackTimers.SetDtPvpOnly(value)
	BeltalowdaAttackTimers.vars.pvpOnly = value
	BeltalowdaAttackTimers.SetEnabled(BeltalowdaAttackTimers.vars.enabled)
end

function BeltalowdaAttackTimers.GetDtAvailableModes()
	return BeltalowdaAttackTimers.constants.modes
end

function BeltalowdaAttackTimers.GetDtSelectedMode()
	return BeltalowdaAttackTimers.constants.modes[BeltalowdaAttackTimers.vars.mode]
end

function BeltalowdaAttackTimers.SetDtSelectedMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaAttackTimers.constants.modes do
			if BeltalowdaAttackTimers.constants.modes[i] == value then
				BeltalowdaAttackTimers.vars.mode = i
				BeltalowdaAttackTimers.AdjustMode()
			end
		end
	end
end

function BeltalowdaAttackTimers.GetDtSelectedSize()
	return BeltalowdaAttackTimers.vars.size
end

function BeltalowdaAttackTimers.SetDtSelectedSize(value)
	if value ~= nil and value >= BeltalowdaAttackTimers.constants.size.SMALL and value <= BeltalowdaAttackTimers.constants.size.BIG then
		BeltalowdaAttackTimers.vars.size = value
		BeltalowdaAttackTimers.AdjustSize()
	end
end

function BeltalowdaAttackTimers.GetDtSmoothTransition()
	return BeltalowdaAttackTimers.vars.smoothTransition
end

function BeltalowdaAttackTimers.SetDtSmoothTransition(value)
	BeltalowdaAttackTimers.vars.smoothTransition = value
end

function BeltalowdaAttackTimers.GetDtDetonationFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.detonation.fontColor)
end

function BeltalowdaAttackTimers.SetDtDetonationFontColor(r, g, b)
	BeltalowdaAttackTimers.vars.detonation.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDetonationProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.detonation.progressColor)
end

function BeltalowdaAttackTimers.SetDtDetonationProgressColor(r, g, b)
	BeltalowdaAttackTimers.vars.detonation.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssaultFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssaultFontColor(r, g, b)
	BeltalowdaAttackTimers.vars.subterraneanAssault.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssaultProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssaultProgressColor(r, g, b)
	BeltalowdaAttackTimers.vars.subterraneanAssault.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssault2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssault2FontColor(r, g, b)
	BeltalowdaAttackTimers.vars.subterraneanAssault2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssault2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.subterraneanAssault2.progressColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssault2ProgressColor(r, g, b)
	BeltalowdaAttackTimers.vars.subterraneanAssault2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissureFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.deepFissure.fontColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissureFontColor(r, g, b)
	BeltalowdaAttackTimers.vars.deepFissure.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissureProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.deepFissure.progressColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissureProgressColor(r, g, b)
	BeltalowdaAttackTimers.vars.deepFissure.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissure2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.deepFissure2.fontColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissure2FontColor(r, g, b)
	BeltalowdaAttackTimers.vars.deepFissure2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissure2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAttackTimers.vars.deepFissure2.progressColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissure2ProgressColor(r, g, b)
	BeltalowdaAttackTimers.vars.deepFissure2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAttackTimers.AdjustColors()
end

-- Note: Phase 2 - Menu functions now in wrapper, core logic still in DetonationTracker.
