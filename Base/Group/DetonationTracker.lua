-- Beltalowda Detonation Tracker
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.dt = BeltalowdaGroup.dt or {}
local BeltalowdaDt = BeltalowdaGroup.dt
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

BeltalowdaDt.constants = BeltalowdaDt.constants or {}
BeltalowdaDt.constants.TLW = "Beltalowda.group.dt.tlw"

BeltalowdaDt.constants.size = {}
BeltalowdaDt.constants.size.SMALL = 1
BeltalowdaDt.constants.size.BIG = 2

BeltalowdaDt.constants.modes = {}
BeltalowdaDt.constants.MODE_BOTH = 1
BeltalowdaDt.constants.MODE_DETONATION = 2
BeltalowdaDt.constants.MODE_SHALK = 3

BeltalowdaDt.constants.TYPE_DETONATION = 1
BeltalowdaDt.constants.TYPE_SUBTERRANEAN_ASSAULT = 2
BeltalowdaDt.constants.TYPE_DEEP_FRISSURE = 3

BeltalowdaDt.callbackName = Beltalowda.addonName .. "DetonationTracker"

BeltalowdaDt.config = {}
BeltalowdaDt.config.updateInterval = 100
BeltalowdaDt.config.isClampedToScreen = false
BeltalowdaDt.config.sizes = {}
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL] = {}
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].width = 150
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].blockHeight = 20
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].height = 200
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].fontSize = 15
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG] = {}
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].width = 300
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].blockHeight = 40
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].height = 400
BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].fontSize = 30

BeltalowdaDt.state = {}
BeltalowdaDt.state.initialized = false
BeltalowdaDt.state.foreground = true
BeltalowdaDt.state.registredConsumers = false
BeltalowdaDt.state.activeLayerIndex = 1
BeltalowdaDt.state.registredActiveConsumers = false
BeltalowdaDt.state.width = BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].width
BeltalowdaDt.state.blockHeight = BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].blockHeight
BeltalowdaDt.state.height = BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].height
BeltalowdaDt.state.fontSize = BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].fontSize
BeltalowdaDt.state.font = nil

BeltalowdaDt.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaDt.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaDt.callbackName, BeltalowdaDt.OnProfileChanged)
	
	BeltalowdaDt.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaDt.SetDtPositionLocked)
	
	BeltalowdaDt.state.initialized = true
	BeltalowdaDt.SetEnabled(BeltalowdaDt.dtVars.enabled)
end

function BeltalowdaDt.SetTlwLocation()
	BeltalowdaDt.controls.TLW:ClearAnchors()
	if BeltalowdaDt.dtVars.location == nil then
		BeltalowdaDt.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -125, -125)
	else
		BeltalowdaDt.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaDt.dtVars.location.x, BeltalowdaDt.dtVars.location.y)
	end
end

function BeltalowdaDt.CreateUI()
	BeltalowdaDt.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaDt.constants.TLW)
	
	BeltalowdaDt.SetTlwLocation()

		
	BeltalowdaDt.controls.TLW:SetClampedToScreen(BeltalowdaDt.config.isClampedToScreen)
	BeltalowdaDt.controls.TLW:SetHandler("OnMoveStop", BeltalowdaDt.SaveWindowLocation)
	BeltalowdaDt.controls.TLW:SetDimensions(BeltalowdaDt.state.width, BeltalowdaDt.state.height)
	
	BeltalowdaDt.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaDt.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaDt.controls.TLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaDt.state.width, BeltalowdaDt.state.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaDt.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaDt.state.width, BeltalowdaDt.state.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.playerBlocks = BeltalowdaDt.CreatePlayerBlocks(rootControl, BeltalowdaDt.state.width, BeltalowdaDt.state.blockHeight)
	BeltalowdaDt.controls.TLW:SetHidden(true)
	BeltalowdaDt.AdjustMode()
	BeltalowdaDt.AdjustSize()
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.CreatePlayerBlock(parent, width, blockHeight, font)
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

function BeltalowdaDt.CreatePlayerBlocks(parent, width, blockHeight)
	local playerBlocks = {}
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, blockHeight - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaDt.state.font = font
	
	for i = 1, 24 do
		playerBlocks[i] = BeltalowdaDt.CreatePlayerBlock(parent, width, blockHeight, font)
		playerBlocks[i]:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, (i - 1) * blockHeight)
		
	end
	
	return playerBlocks
end

function BeltalowdaDt.GetDefaults()
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
	defaults.size = BeltalowdaDt.constants.size.SMALL
	defaults.mode = BeltalowdaDt.constants.MODE_BOTH
	defaults.smoothTransition = true
	return defaults
end

function BeltalowdaDt.AdjustSize()
	local sizeIncrease = BeltalowdaDt.dtVars.size - BeltalowdaDt.constants.size.SMALL
	local height = (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].height + (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].height - BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].height) * sizeIncrease)
	local width = (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].width + (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].width - BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].width) * sizeIncrease)
	local blockHeight = (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].blockHeight + (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].blockHeight - BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].blockHeight) * sizeIncrease)
	local fontSize = (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].fontSize + (BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.BIG].fontSize - BeltalowdaDt.config.sizes[BeltalowdaDt.constants.size.SMALL].fontSize) * sizeIncrease)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaDt.state.width = width
	BeltalowdaDt.state.blockHeight = blockHeight
	BeltalowdaDt.state.height = height
	BeltalowdaDt.state.fontSize = fontSize
	BeltalowdaDt.state.font = font
	local rootControl = BeltalowdaDt.controls.TLW.rootControl
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
	BeltalowdaDt.controls.TLW:SetDimensions(width, height)
	BeltalowdaDt.controls.TLW.rootControl:SetDimensions(width, height)
	BeltalowdaDt.controls.TLW.rootControl.movableBackdrop:SetDimensions(width, height)
end

function BeltalowdaDt.AdjustMode()
	
	
	
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.AdjustColors()
	local playerBlocks = BeltalowdaDt.controls.TLW.rootControl.playerBlocks
	for i = 1, #playerBlocks do
		if BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_DETONATION then
			playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.detonation.fontColor.r, BeltalowdaDt.dtVars.detonation.fontColor.g, BeltalowdaDt.dtVars.detonation.fontColor.b)
			playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.detonation.fontColor.r, BeltalowdaDt.dtVars.detonation.fontColor.g, BeltalowdaDt.dtVars.detonation.fontColor.b)
			playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.detonation.progressColor.r, BeltalowdaDt.dtVars.detonation.progressColor.g, BeltalowdaDt.dtVars.detonation.progressColor.b)
		end
	end
end

function BeltalowdaDt.SetEnabled(value)
	if BeltalowdaDt.state.initialized == true and value ~= nil then
		BeltalowdaDt.dtVars.enabled = value
		if value == true then
			if BeltalowdaDt.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaDt.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaDt.OnPlayerActivated)
				
			end
			BeltalowdaDt.state.registredConsumers = true
		else
			if BeltalowdaDt.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaDt.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaDt.state.registredConsumers = false
		end
		BeltalowdaDt.OnPlayerActivated()
	end
end

function BeltalowdaDt.SetControlVisibility()
	local enabled = BeltalowdaDt.dtVars.enabled
	local pvpOnly = BeltalowdaDt.dtVars.pvpOnly
	local setHidden = true
	
	-- Check if we should enable based on detector settings
	if not BeltalowdaDt.ShouldEnableDetonationTracker() then
		setHidden = true
	elseif enabled ~= nil and pvpOnly ~= nil then
		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	
	if setHidden == false then
		if BeltalowdaDt.state.foreground == false then
			BeltalowdaDt.controls.TLW:SetHidden(BeltalowdaDt.state.activeLayerIndex > 2)
		else
			BeltalowdaDt.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaDt.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaDt.SetPositionLocked(value)
	BeltalowdaDt.dtVars.positionLocked = value
	BeltalowdaDt.controls.TLW:SetMovable(not value)
	BeltalowdaDt.controls.TLW:SetMouseEnabled(not value)
	
	if value == true then
		BeltalowdaDt.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaDt.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaDt.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaDt.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaDt.ComparePlayersByDetonationUptime(playerA, playerB)
	if playerA.buffs.specialInformation.proximityDetonation.remaining < playerB.buffs.specialInformation.proximityDetonation.remaining  then
		return false
	elseif playerA.buffs.specialInformation.proximityDetonation.remaining > playerB.buffs.specialInformation.proximityDetonation.remaining  then
		return true
	else
		return playerA.name < playerB.name
	end
end

function BeltalowdaDt.ComparePlayersByShalkUptime(playerA, playerB)
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

function BeltalowdaDt.ComparePlayersByDetonationShalkUptime(playerA, playerB)
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

function BeltalowdaDt.GetSortedDetonationPlayerList(players)
	local detosOnly = {}
	local timeStamp = GetGameTimeMilliseconds() / 1000
	for i = 1, #players do
		if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
			players[i].buffs.specialInformation.proximityDetonation.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
			table.insert(detosOnly, players[i])
		end
	end
	table.sort(detosOnly, BeltalowdaDt.ComparePlayersByDetonationUptime)
	return detosOnly
end

function BeltalowdaDt.GetSortedList(players)
	local displayItems = {}
	local timeStamp = GetGameTimeMilliseconds() / 1000
	if BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_BOTH then
		local localPlayers = {}
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaDt.constants.TYPE_DETONATION
				localPlayer.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.proximityDetonation.started
				localPlayer.ending = players[i].buffs.specialInformation.proximityDetonation.ending
				table.insert(displayItems, localPlayer)
			end
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.subterraneanAssault ~= nil and players[i].buffs.specialInformation.subterraneanAssault.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaDt.constants.TYPE_SUBTERRANEAN_ASSAULT
				localPlayer.remaining = players[i].buffs.specialInformation.subterraneanAssault.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.subterraneanAssault.started
				localPlayer.ending = players[i].buffs.specialInformation.subterraneanAssault.ending
				localPlayer.waveTwo = players[i].buffs.specialInformation.subterraneanAssault.waveTwo
				table.insert(displayItems, localPlayer)
				--d("assault")
			elseif players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.deepFissure ~= nil and players[i].buffs.specialInformation.deepFissure.active == true then
				local localPlayer = {}
				localPlayer.buff = BeltalowdaDt.constants.TYPE_DEEP_FRISSURE
				localPlayer.remaining = players[i].buffs.specialInformation.deepFissure.ending - timeStamp
				localPlayer.name =  players[i].name
				localPlayer.started = players[i].buffs.specialInformation.deepFissure.started
				localPlayer.ending = players[i].buffs.specialInformation.deepFissure.ending
				localPlayer.waveTwo = players[i].buffs.specialInformation.deepFissure.waveTwo
				table.insert(displayItems, localPlayer)
				--d("deep")
			end
		end
		table.sort(displayItems, BeltalowdaDt.ComparePlayersByDetonationShalkUptime)
	elseif BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_DETONATION then
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.proximityDetonation ~= nil and players[i].buffs.specialInformation.proximityDetonation.active == true then
				players[i].buffs.specialInformation.proximityDetonation.remaining = players[i].buffs.specialInformation.proximityDetonation.ending - timeStamp
				table.insert(displayItems, players[i])
			end
		end
		table.sort(displayItems, BeltalowdaDt.ComparePlayersByDetonationUptime)
	elseif BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_SHALK then
		for i = 1, #players do
			if players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.subterraneanAssault ~= nil and players[i].buffs.specialInformation.subterraneanAssault.active == true then
				players[i].buffs.specialInformation.subterraneanAssault.remaining = players[i].buffs.specialInformation.subterraneanAssault.ending - timeStamp
				table.insert(displayItems, players[i])
			elseif players[i] ~= nil and players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.deepFissure ~= nil and players[i].buffs.specialInformation.deepFissure.active == true then
				players[i].buffs.specialInformation.deepFissure.remaining = players[i].buffs.specialInformation.deepFissure.ending - timeStamp
				table.insert(displayItems, players[i])
			end
		end
		table.sort(displayItems, BeltalowdaDt.ComparePlayersByShalkUptime)
	end
	return displayItems
end

--callbacks
function BeltalowdaDt.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaDt.dtVars = currentProfile.group.dt
		if BeltalowdaDt.state.initialized == true then
			BeltalowdaDt.SetControlVisibility()
			BeltalowdaDt.AdjustMode()
			BeltalowdaDt.AdjustSize()
			BeltalowdaDt.AdjustColors()
			BeltalowdaDt.SetPositionLocked(BeltalowdaDt.dtVars.positionLocked)
			BeltalowdaDt.SetTlwLocation()
		end
		BeltalowdaDt.SetEnabled(BeltalowdaDt.dtVars.enabled)
		
	end
end

-- Check if detonation tracker should be enabled based on detector settings
function BeltalowdaDt.ShouldEnableDetonationTracker()
	local detector = Beltalowda.addOnIntegration.detector
	if detector and detector.ShouldEnableBuiltIn and detector.detectorVars then
		local addonType = detector.constants.ADDON_TYPE_BOMB_TIMER
		local mode = detector.detectorVars.bombTimerMode
		return detector.ShouldEnableBuiltIn(addonType, mode)
	end
	
	-- Default behavior if detector not available
	return true
end

function BeltalowdaDt.SaveWindowLocation()
	if BeltalowdaDt.dtVars.positionLocked == false then
		BeltalowdaDt.dtVars.location = BeltalowdaDt.dtVars.location or {}
		BeltalowdaDt.dtVars.location.x = BeltalowdaDt.controls.TLW:GetLeft()
		BeltalowdaDt.dtVars.location.y = BeltalowdaDt.controls.TLW:GetTop()
	end
end

function BeltalowdaDt.OnPlayerActivated(eventCode, initial)
	--d(BeltalowdaDt.dtVars.enabled)
	if BeltalowdaDt.dtVars.enabled == true and (BeltalowdaDt.dtVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaDt.dtVars.pvpOnly == false) then
		--d("register")
		if BeltalowdaDt.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaDt.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaDt.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaDt.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaDt.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaDt.callbackName, BeltalowdaDt.config.updateInterval, BeltalowdaDt.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaDt.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaDt.config.updateInterval)
			BeltalowdaDt.state.registredActiveConsumers = true
		end
	else
		--d("unregister")
		if BeltalowdaDt.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaDt.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaDt.callbackName, EVENT_ACTION_LAYER_PUSHED)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaDt.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaDt.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaDt.state.registredActiveConsumers = false
		end
	end
	BeltalowdaDt.SetControlVisibility()
end

function BeltalowdaDt.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaDt.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaDt.state.foreground = false
	end
	--hack?
	BeltalowdaDt.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaDt.SetControlVisibility()
end

function BeltalowdaDt.UiLoop()
	--d("dt")
	if BeltalowdaDt.dtVars.pvpOnly == false or (BeltalowdaDt.dtVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		--d("dt")
		if players ~= nil then
			--players = BeltalowdaDt.GetSortedDetonationPlayerList(players)
			players = BeltalowdaDt.GetSortedList(players)
			local playerBlocks = BeltalowdaDt.controls.TLW.rootControl.playerBlocks
			if BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_BOTH then
				for i = 1, #players do
					local timespan = players[i].remaining
					local percent = 0.0
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaDt.CreatePlayerBlock(BeltalowdaDt.controls.TLW.rootControl, BeltalowdaDt.state.width, BeltalowdaDt.state.blockHeight, BeltalowdaDt.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaDt.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaDt.state.blockHeight)
					end
					if timespan < 0 then
						timespan = 0
					end
					if players[i].buff == BeltalowdaDt.constants.TYPE_DETONATION then
						playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.detonation.fontColor.r, BeltalowdaDt.dtVars.detonation.fontColor.g, BeltalowdaDt.dtVars.detonation.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.detonation.fontColor.r, BeltalowdaDt.dtVars.detonation.fontColor.g, BeltalowdaDt.dtVars.detonation.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.detonation.progressColor.r, BeltalowdaDt.dtVars.detonation.progressColor.g, BeltalowdaDt.dtVars.detonation.progressColor.b)
						percent = players[i].remaining / (players[i].ending - players[i].started) * 100
					elseif players[i].buff == BeltalowdaDt.constants.TYPE_SUBTERRANEAN_ASSAULT then
						if players[i].waveTwo == false then
							playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.progressColor.r, BeltalowdaDt.dtVars.subterraneanAssault.progressColor.g, BeltalowdaDt.dtVars.subterraneanAssault.progressColor.b)
							--d(players[i].remaining)
						else
							playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault2.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.subterraneanAssault2.progressColor.r, BeltalowdaDt.dtVars.subterraneanAssault2.progressColor.g, BeltalowdaDt.dtVars.subterraneanAssault2.progressColor.b)
						end
						percent = players[i].remaining / (players[i].ending - players[i].started + 5) * 100
						--d("assault")
					elseif players[i].buff == BeltalowdaDt.constants.TYPE_DEEP_FRISSURE then
						if players[i].waveTwo == false then
							playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.deepFissure.fontColor.r, BeltalowdaDt.dtVars.deepFissure.fontColor.g, BeltalowdaDt.dtVars.deepFissure.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.deepFissure.fontColor.r, BeltalowdaDt.dtVars.deepFissure.fontColor.g, BeltalowdaDt.dtVars.deepFissure.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.deepFissure.progressColor.r, BeltalowdaDt.dtVars.deepFissure.progressColor.g, BeltalowdaDt.dtVars.deepFissure.progressColor.b)
							percent = players[i].remaining / (players[i].ending - players[i].started + 5) * 100
						else
							playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.deepFissure2.fontColor.r, BeltalowdaDt.dtVars.deepFissure2.fontColor.g, BeltalowdaDt.dtVars.deepFissure2.fontColor.b)
							playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.deepFissure2.fontColor.r, BeltalowdaDt.dtVars.deepFissure2.fontColor.g, BeltalowdaDt.dtVars.deepFissure2.fontColor.b)
							playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.deepFissure2.progressColor.r, BeltalowdaDt.dtVars.deepFissure2.progressColor.g, BeltalowdaDt.dtVars.deepFissure2.progressColor.b)
							percent = players[i].remaining / (players[i].ending - players[i].started + 2) * 100
						end
						
						--d("deep")
					end
					playerBlocks[i]:SetHidden(false)
					playerBlocks[i].timeLabel:SetText(string.format("%.1f", timespan))
					playerBlocks[i].nameLabel:SetText(players[i].name)
					ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, percent, 100, not BeltalowdaDt.dtVars.smoothTransition)
				end
			elseif BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_DETONATION then
				for i = 1, #players do
					local timespan = players[i].buffs.specialInformation.proximityDetonation.remaining
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaDt.CreatePlayerBlock(BeltalowdaDt.controls.TLW.rootControl, BeltalowdaDt.state.width, BeltalowdaDt.state.blockHeight, BeltalowdaDt.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaDt.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaDt.state.blockHeight)
					end
					if timespan < 0 then
						timespan = 0
					end
					
					playerBlocks[i]:SetHidden(false)
					playerBlocks[i].timeLabel:SetText(string.format("%.1f", timespan))
					playerBlocks[i].nameLabel:SetText(players[i].name)
					ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.proximityDetonation.remaining / (players[i].buffs.specialInformation.proximityDetonation.ending - players[i].buffs.specialInformation.proximityDetonation.started) * 100, 100, not BeltalowdaDt.dtVars.smoothTransition)
				end
			elseif BeltalowdaDt.dtVars.mode == BeltalowdaDt.constants.MODE_SHALK then
				for i = 1, #players do
					local timespan = 0
					if playerBlocks[i] == nil then
						playerBlocks[i] = BeltalowdaDt.CreatePlayerBlock(BeltalowdaDt.controls.TLW.rootControl, BeltalowdaDt.state.width, BeltalowdaDt.state.blockHeight, BeltalowdaDt.state.font)
						playerBlocks[i]:SetAnchor(TOPLEFT, BeltalowdaDt.controls.TLW.rootControl, TOPLEFT, 0, (i - 1) * BeltalowdaDt.state.blockHeight)
					end
					if players[i].buffs.specialInformation.subterraneanAssault.active == true then
						timespan = players[i].buffs.specialInformation.subterraneanAssault.remaining
						playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.fontColor.r, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.g, BeltalowdaDt.dtVars.subterraneanAssault.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.subterraneanAssault.progressColor.r, BeltalowdaDt.dtVars.subterraneanAssault.progressColor.g, BeltalowdaDt.dtVars.subterraneanAssault.progressColor.b)
						ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.subterraneanAssault.remaining / (players[i].buffs.specialInformation.subterraneanAssault.ending - players[i].buffs.specialInformation.subterraneanAssault.started) * 100, 100, not BeltalowdaDt.dtVars.smoothTransition)
						--playerBlocks[i].progress:SetValue(players[i].buffs.specialInformation.subterraneanAssault.remaining / (players[i].buffs.specialInformation.subterraneanAssault.ending - players[i].buffs.specialInformation.subterraneanAssault.started) * 100)
					elseif players[i].buffs.specialInformation.deepFissure.active == true then
						timespan = players[i].buffs.specialInformation.deepFissure.remaining
						playerBlocks[i].timeLabel:SetColor(BeltalowdaDt.dtVars.deepFissure.fontColor.r, BeltalowdaDt.dtVars.deepFissure.fontColor.g, BeltalowdaDt.dtVars.deepFissure.fontColor.b)
						playerBlocks[i].nameLabel:SetColor(BeltalowdaDt.dtVars.deepFissure.fontColor.r, BeltalowdaDt.dtVars.deepFissure.fontColor.g, BeltalowdaDt.dtVars.deepFissure.fontColor.b)
						playerBlocks[i].progress:SetColor(BeltalowdaDt.dtVars.deepFissure.progressColor.r, BeltalowdaDt.dtVars.deepFissure.progressColor.g, BeltalowdaDt.dtVars.deepFissure.progressColor.b)
						ZO_StatusBar_SmoothTransition(playerBlocks[i].progress, players[i].buffs.specialInformation.deepFissure.remaining / (players[i].buffs.specialInformation.deepFissure.ending - players[i].buffs.specialInformation.deepFissure.started) * 100, 100, not BeltalowdaDt.dtVars.smoothTransition)
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
function BeltalowdaDt.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.DT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_ENABLED,
					getFunc = BeltalowdaDt.GetDtEnabled,
					setFunc = BeltalowdaDt.SetDtEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_POSITION_FIXED,
					getFunc = BeltalowdaDt.GetDtPositionLocked,
					setFunc = BeltalowdaDt.SetDtPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_PVP_ONLY,
					getFunc = BeltalowdaDt.GetDtPvpOnly,
					setFunc = BeltalowdaDt.SetDtPvpOnly
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.DT_MODE,
					choices = BeltalowdaDt.GetDtAvailableModes(),
					getFunc = BeltalowdaDt.GetDtSelectedMode,
					setFunc = BeltalowdaDt.SetDtSelectedMode,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.DT_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaDt.GetDtSelectedSize,
					setFunc = BeltalowdaDt.SetDtSelectedSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION,
					getFunc = BeltalowdaDt.GetDtSmoothTransition,
					setFunc = BeltalowdaDt.SetDtSmoothTransition
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION,
					getFunc = BeltalowdaDt.GetDtDetonationFontColor,
					setFunc = BeltalowdaDt.SetDtDetonationFontColor,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION,
					getFunc = BeltalowdaDt.GetDtDetonationProgressColor,
					setFunc = BeltalowdaDt.SetDtDetonationProgressColor,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaDt.GetDtSubterraneanAssaultFontColor,
					setFunc = BeltalowdaDt.SetDtSubterraneanAssaultFontColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaDt.GetDtSubterraneanAssaultProgressColor,
					setFunc = BeltalowdaDt.SetDtSubterraneanAssaultProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaDt.GetDtSubterraneanAssault2FontColor,
					setFunc = BeltalowdaDt.SetDtSubterraneanAssault2FontColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaDt.GetDtSubterraneanAssault2ProgressColor,
					setFunc = BeltalowdaDt.SetDtSubterraneanAssault2ProgressColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaDt.GetDtDeepFissureFontColor,
					setFunc = BeltalowdaDt.SetDtDeepFissureFontColor,
					width = "full"
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaDt.GetDtDeepFissureProgressColor,
					setFunc = BeltalowdaDt.SetDtDeepFissureProgressColor,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaDt.GetDtDeepFissure2FontColor,
					setFunc = BeltalowdaDt.SetDtDeepFissure2FontColor,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaDt.GetDtDeepFissure2ProgressColor,
					setFunc = BeltalowdaDt.SetDtDeepFissure2ProgressColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaDt.GetDtEnabled()
	return BeltalowdaDt.dtVars.enabled
end

function BeltalowdaDt.SetDtEnabled(value)
	BeltalowdaDt.SetEnabled(value)
end

function BeltalowdaDt.GetDtPositionLocked()
	return BeltalowdaDt.dtVars.positionLocked
end

function BeltalowdaDt.SetDtPositionLocked(value)
	BeltalowdaDt.SetPositionLocked(value)
end

function BeltalowdaDt.GetDtPvpOnly()
	return BeltalowdaDt.dtVars.pvpOnly
end

function BeltalowdaDt.SetDtPvpOnly(value)
	BeltalowdaDt.dtVars.pvpOnly = value
	BeltalowdaDt.SetEnabled(BeltalowdaDt.dtVars.enabled)
end

function BeltalowdaDt.GetDtAvailableModes()
	return BeltalowdaDt.constants.modes
end

function BeltalowdaDt.GetDtSelectedMode()
	return BeltalowdaDt.constants.modes[BeltalowdaDt.dtVars.mode]
end

function BeltalowdaDt.SetDtSelectedMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaDt.constants.modes do
			if BeltalowdaDt.constants.modes[i] == value then
				BeltalowdaDt.dtVars.mode = i
				BeltalowdaDt.AdjustMode()
			end
		end
	end
end

function BeltalowdaDt.GetDtSelectedSize()
	return BeltalowdaDt.dtVars.size
end

function BeltalowdaDt.SetDtSelectedSize(value)
	if value ~= nil and value >= BeltalowdaDt.constants.size.SMALL and value <= BeltalowdaDt.constants.size.BIG then
		BeltalowdaDt.dtVars.size = value
		BeltalowdaDt.AdjustSize()
	end
end

function BeltalowdaDt.GetDtSmoothTransition()
	return BeltalowdaDt.dtVars.smoothTransition
end

function BeltalowdaDt.SetDtSmoothTransition(value)
	BeltalowdaDt.dtVars.smoothTransition = value
end

function BeltalowdaDt.GetDtDetonationFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.detonation.fontColor)
end

function BeltalowdaDt.SetDtDetonationFontColor(r, g, b)
	BeltalowdaDt.dtVars.detonation.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtDetonationProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.detonation.progressColor)
end

function BeltalowdaDt.SetDtDetonationProgressColor(r, g, b)
	BeltalowdaDt.dtVars.detonation.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtSubterraneanAssaultFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.subterraneanAssault.fontColor)
end

function BeltalowdaDt.SetDtSubterraneanAssaultFontColor(r, g, b)
	BeltalowdaDt.dtVars.subterraneanAssault.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtSubterraneanAssaultProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.subterraneanAssault.progressColor)
end

function BeltalowdaDt.SetDtSubterraneanAssaultProgressColor(r, g, b)
	BeltalowdaDt.dtVars.subterraneanAssault.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtSubterraneanAssault2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.subterraneanAssault2.fontColor)
end

function BeltalowdaDt.SetDtSubterraneanAssault2FontColor(r, g, b)
	BeltalowdaDt.dtVars.subterraneanAssault2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtSubterraneanAssault2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.subterraneanAssault2.progressColor)
end

function BeltalowdaDt.SetDtSubterraneanAssault2ProgressColor(r, g, b)
	BeltalowdaDt.dtVars.subterraneanAssault2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtDeepFissureFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.deepFissure.fontColor)
end

function BeltalowdaDt.SetDtDeepFissureFontColor(r, g, b)
	BeltalowdaDt.dtVars.deepFissure.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtDeepFissureProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.deepFissure.progressColor)
end

function BeltalowdaDt.SetDtDeepFissureProgressColor(r, g, b)
	BeltalowdaDt.dtVars.deepFissure.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtDeepFissure2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.deepFissure2.fontColor)
end

function BeltalowdaDt.SetDtDeepFissure2FontColor(r, g, b)
	BeltalowdaDt.dtVars.deepFissure2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end

function BeltalowdaDt.GetDtDeepFissure2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDt.dtVars.deepFissure2.progressColor)
end

function BeltalowdaDt.SetDtDeepFissure2ProgressColor(r, g, b)
	BeltalowdaDt.dtVars.deepFissure2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDt.AdjustColors()
end