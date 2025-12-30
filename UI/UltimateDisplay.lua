-- Beltalowda Ultimate Display
-- GUI for displaying group member ultimates (comprehensive RdK-style features)
-- Author: @Kickimanjaro

Beltalowda = Beltalowda or {}
Beltalowda.UI = Beltalowda.UI or {}
Beltalowda.UI.UltimateDisplay = Beltalowda.UI.UltimateDisplay or {}

local UltimateDisplay = Beltalowda.UI.UltimateDisplay
local wm = WINDOW_MANAGER

-- Configuration
UltimateDisplay.config = {}
UltimateDisplay.config.updateInterval = 100 -- Update UI every 100ms
UltimateDisplay.config.playerBlockWidth = 200
UltimateDisplay.config.playerBlockHeight = 40
UltimateDisplay.config.maxGroupSize = 24
UltimateDisplay.config.ultiIconSize = 50
UltimateDisplay.config.ultiIconOffset = 12
UltimateDisplay.config.maxTrackedUltimates = 12
UltimateDisplay.config.overviewWidth = 160
UltimateDisplay.config.overviewBlockHeight = 30

-- State
UltimateDisplay.controls = {}
UltimateDisplay.lastUpdateTime = 0
UltimateDisplay.enabled = true
UltimateDisplay.trackedUltimates = {1, 15, 13, 5, 7, 17} -- Default: Negate, Destruction, Storm, Nova, Standard, Storm (by ultimate ID)

-- Saved variables
UltimateDisplay.savedVars = {}

function UltimateDisplay.Initialize()
	-- Load saved variables
	UltimateDisplay.savedVars = ZO_SavedVars:NewAccountWide(
		"BeltalowdaSavedVariables",
		1,
		"UltimateDisplay",
		{
			trackedUltimates = {1, 15, 13, 5, 7, 17},
			playerUltimateId = 1,
			showPlayerBlocks = true,
			showClientUltimate = true,
			showGroupUltimates = true,
			showUltimateOverview = false,
		}
	)
	
	UltimateDisplay.trackedUltimates = UltimateDisplay.savedVars.trackedUltimates
	
	-- Create all UI windows
	UltimateDisplay.CreateClientUltimateWindow()
	UltimateDisplay.CreateGroupUltimatesWindow()
	UltimateDisplay.CreateUltimateOverviewWindow()
	UltimateDisplay.CreatePlayerBlocksWindow()
	
	-- Start the update timer
	UltimateDisplay.StartUpdateTimer()
	
	d("Beltalowda: Ultimate Display UI initialized (RdK-style)")
end

function UltimateDisplay.CreateClientUltimateWindow()
	-- Create top-level window for player's own ultimate
	local window = wm:CreateTopLevelWindow("BeltalowdaClientUltimate")
	window:SetClampedToScreen(true)
	window:SetMovable(true)
	window:SetMouseEnabled(true)
	window:SetDimensions(UltimateDisplay.config.ultiIconSize + UltimateDisplay.config.ultiIconOffset * 2,
	                     UltimateDisplay.config.ultiIconSize + UltimateDisplay.config.ultiIconOffset * 2)
	window:SetAnchor(CENTER, GuiRoot, CENTER, 300, -200)
	
	-- Create backdrop (transparent)
	local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
	backdrop:SetAnchorFill(window)
	backdrop:SetCenterColor(0, 0, 0, 0)
	backdrop:SetEdgeColor(0, 0, 0, 0)
	
	-- Create ultimate button
	local button = wm:CreateControl(nil, window, CT_BUTTON)
	button:SetAnchor(CENTER, window, CENTER, 0, 0)
	button:SetDimensions(UltimateDisplay.config.ultiIconSize, UltimateDisplay.config.ultiIconSize)
	button:SetNormalTexture("/esoui/art/actionbar/abilityframe64_up.dds")
	button:SetPressedTexture("/esoui/art/actionbar/abilityframe64_down.dds")
	button:SetMouseOverTexture("EsoUI/Art/ActionBar/actionBar_mouseOver.dds")
	button:SetHandler("OnClicked", function() UltimateDisplay.ShowClientUltimateMenu() end)
	
	-- Create icon texture
	local texture = wm:CreateControl(nil, window, CT_TEXTURE)
	texture:SetAnchor(CENTER, button, CENTER, 0, 0)
	texture:SetDimensions(UltimateDisplay.config.ultiIconSize - 4, UltimateDisplay.config.ultiIconSize - 4)
	texture:SetTexture("/esoui/art/icons/icon_missing.dds")
	
	UltimateDisplay.controls.clientUltimate = {
		window = window,
		button = button,
		texture = texture
	}
	
	window:SetHidden(not UltimateDisplay.savedVars.showClientUltimate)
end

function UltimateDisplay.CreateGroupUltimatesWindow()
	-- Create top-level window for tracked group ultimates
	local iconSize = UltimateDisplay.config.ultiIconSize
	local offset = UltimateDisplay.config.ultiIconOffset
	local numIcons = UltimateDisplay.config.maxTrackedUltimates
	
	local window = wm:CreateTopLevelWindow("BeltalowdaGroupUltimates")
	window:SetClampedToScreen(true)
	window:SetMovable(true)
	window:SetMouseEnabled(true)
	window:SetDimensions(iconSize * numIcons + offset * 2, iconSize + offset * 2)
	window:SetAnchor(TOP, GuiRoot, TOP, 0, 100)
	
	-- Create backdrop (transparent)
	local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
	backdrop:SetAnchorFill(window)
	backdrop:SetCenterColor(0, 0, 0, 0)
	backdrop:SetEdgeColor(0, 0, 0, 0)
	
	-- Create ultimate selector buttons
	local selectors = {}
	for i = 1, numIcons do
		local xOffset = offset + (iconSize * (i - 1))
		
		-- Create button
		local button = wm:CreateControl(nil, window, CT_BUTTON)
		button:SetAnchor(TOPLEFT, window, TOPLEFT, xOffset, offset)
		button:SetDimensions(iconSize, iconSize)
		button:SetNormalTexture("/esoui/art/actionbar/abilityframe64_up.dds")
		button:SetPressedTexture("/esoui/art/actionbar/abilityframe64_down.dds")
		button:SetMouseOverTexture("EsoUI/Art/ActionBar/actionBar_mouseOver.dds")
		button:SetHandler("OnClicked", function() UltimateDisplay.ShowGroupUltimateMenu(i) end)
		
		-- Create icon texture
		local texture = wm:CreateControl(nil, window, CT_TEXTURE)
		texture:SetAnchor(CENTER, button, CENTER, 0, 0)
		texture:SetDimensions(iconSize - 4, iconSize - 4)
		texture:SetTexture("/esoui/art/icons/icon_missing.dds")
		
		-- Create count label
		local label = wm:CreateControl(nil, window, CT_LABEL)
		label:SetAnchor(BOTTOM, button, BOTTOM, 0, -2)
		label:SetFont("ZoFontGameBold")
		label:SetText("0")
		label:SetColor(1, 1, 1, 1)
		
		selectors[i] = {
			button = button,
			texture = texture,
			label = label,
			ultimateId = UltimateDisplay.trackedUltimates[i] or 1
		}
	end
	
	UltimateDisplay.controls.groupUltimates = {
		window = window,
		selectors = selectors
	}
	
	window:SetHidden(not UltimateDisplay.savedVars.showGroupUltimates)
end

function UltimateDisplay.CreateUltimateOverviewWindow()
	-- Create compact overview window showing counts of specific ultimates
	local width = UltimateDisplay.config.overviewWidth
	local blockHeight = UltimateDisplay.config.overviewBlockHeight
	
	local window = wm:CreateTopLevelWindow("BeltalowdaUltimateOverview")
	window:SetClampedToScreen(true)
	window:SetMovable(true)
	window:SetMouseEnabled(true)
	window:SetDimensions(width, blockHeight * 4)
	window:SetAnchor(CENTER, GuiRoot, CENTER, -400, 0)
	
	-- Create backdrop
	local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
	backdrop:SetAnchorFill(window)
	backdrop:SetCenterColor(0.1, 0.1, 0.1, 0.8)
	backdrop:SetEdgeColor(0.3, 0.3, 0.3, 1)
	backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
	
	-- Create labels for key ultimates
	local labels = {}
	local ultimateTypes = {
		{name = "Destro", key = "destruction"},
		{name = "Storm", key = "storm"},
		{name = "Neg.", key = "negate"},
		{name = "Nova", key = "nova"}
	}
	
	for i, ult in ipairs(ultimateTypes) do
		local label = wm:CreateControl(nil, window, CT_LABEL)
		label:SetAnchor(TOPLEFT, window, TOPLEFT, 5, (i - 1) * blockHeight)
		label:SetFont("ZoFontGameBold")
		label:SetText(string.format("0/0 %s:", ult.name))
		label:SetColor(1, 1, 1, 1)
		label:SetDimensions(width - 10, blockHeight)
		labels[ult.key] = label
	end
	
	UltimateDisplay.controls.ultimateOverview = {
		window = window,
		labels = labels
	}
	
	window:SetHidden(not UltimateDisplay.savedVars.showUltimateOverview)
end

function UltimateDisplay.CreatePlayerBlocksWindow()
	-- Create the main player blocks window
	local window = wm:CreateTopLevelWindow("BeltalowdaPlayerBlocks")
	window:SetClampedToScreen(true)
	window:SetMovable(true)
	window:SetMouseEnabled(true)
	window:SetDimensions(UltimateDisplay.config.playerBlockWidth, 400)
	window:SetAnchor(CENTER, GuiRoot, CENTER, -300, 0)
	
	-- Create backdrop
	local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
	backdrop:SetAnchorFill(window)
	backdrop:SetCenterColor(0.1, 0.1, 0.1, 0.8)
	backdrop:SetEdgeColor(0.3, 0.3, 0.3, 1)
	backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
	
	-- Create title label
	local title = wm:CreateControl(nil, window, CT_LABEL)
	title:SetAnchor(TOP, window, TOP, 0, 5)
	title:SetFont("ZoFontGameBold")
	title:SetText("Group Ultimates")
	title:SetColor(1, 1, 1, 1)
	
	-- Create player blocks
	local playerBlocks = {}
	for i = 1, UltimateDisplay.config.maxGroupSize do
		playerBlocks[i] = UltimateDisplay.CreatePlayerBlock(window, i)
	end
	
	UltimateDisplay.controls.playerBlocks = {
		window = window,
		title = title,
		blocks = playerBlocks
	}
	
	window:SetHidden(not UltimateDisplay.savedVars.showPlayerBlocks)
end

function UltimateDisplay.CreatePlayerBlock(parent, index)
	local yOffset = 30 + (index - 1) * (UltimateDisplay.config.playerBlockHeight + 2)
	
	-- Container control
	local block = wm:CreateControl(nil, parent, CT_CONTROL)
	block:SetDimensions(UltimateDisplay.config.playerBlockWidth, UltimateDisplay.config.playerBlockHeight)
	block:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, yOffset)
	block:SetHidden(true)
	
	-- Background
	local bg = wm:CreateControl(nil, block, CT_BACKDROP)
	bg:SetAnchorFill(block)
	bg:SetCenterColor(0.15, 0.15, 0.15, 0.9)
	bg:SetEdgeColor(0.2, 0.2, 0.2, 1)
	bg:SetEdgeTexture(nil, 1, 1, 1, 0)
	
	-- Ultimate progress bar
	local ultimateBar = wm:CreateControl(nil, block, CT_STATUSBAR)
	ultimateBar:SetAnchor(TOPLEFT, block, TOPLEFT, 0, 0)
	ultimateBar:SetDimensions(UltimateDisplay.config.playerBlockWidth, UltimateDisplay.config.playerBlockHeight)
	ultimateBar:SetMinMax(0, 100)
	ultimateBar:SetValue(0)
	
	-- Player name label
	local nameLabel = wm:CreateControl(nil, block, CT_LABEL)
	nameLabel:SetAnchor(LEFT, block, LEFT, 5, 0)
	nameLabel:SetFont("ZoFontGame")
	nameLabel:SetText("")
	nameLabel:SetColor(1, 1, 1, 1)
	nameLabel:SetDimensionConstraints(0, 0, UltimateDisplay.config.playerBlockWidth - 60, UltimateDisplay.config.playerBlockHeight)
	nameLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
	nameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	-- Ultimate percentage label
	local percentLabel = wm:CreateControl(nil, block, CT_LABEL)
	percentLabel:SetAnchor(RIGHT, block, RIGHT, -5, 0)
	percentLabel:SetFont("ZoFontGameBold")
	percentLabel:SetText("0%")
	percentLabel:SetColor(1, 1, 1, 1)
	percentLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	return {
		control = block,
		background = bg,
		ultimateBar = ultimateBar,
		nameLabel = nameLabel,
		percentLabel = percentLabel
	}
end

function UltimateDisplay.Update()
	-- Check if in a group
	local inGroup = IsUnitGrouped("player")
	
	-- Update player blocks
	if UltimateDisplay.controls.playerBlocks and UltimateDisplay.savedVars.showPlayerBlocks then
		if not inGroup then
			UltimateDisplay.controls.playerBlocks.window:SetHidden(true)
		else
			UltimateDisplay.controls.playerBlocks.window:SetHidden(false)
			UltimateDisplay.UpdatePlayerBlocks()
		end
	end
	
	-- Update client ultimate
	if UltimateDisplay.controls.clientUltimate and UltimateDisplay.savedVars.showClientUltimate then
		UltimateDisplay.UpdateClientUltimate()
	end
	
	-- Update group ultimates
	if UltimateDisplay.controls.groupUltimates and UltimateDisplay.savedVars.showGroupUltimates then
		UltimateDisplay.UpdateGroupUltimates()
	end
	
	-- Update ultimate overview
	if UltimateDisplay.controls.ultimateOverview and UltimateDisplay.savedVars.showUltimateOverview then
		if not inGroup then
			UltimateDisplay.controls.ultimateOverview.window:SetHidden(true)
		else
			UltimateDisplay.controls.ultimateOverview.window:SetHidden(false)
			UltimateDisplay.UpdateUltimateOverview()
		end
	end
end

function UltimateDisplay.UpdatePlayerBlocks()
	-- Get group data
	local groupPlayers = {}
	if Beltalowda.util and Beltalowda.util.group then
		groupPlayers = Beltalowda.util.group.GetAllPlayers()
	end
	
	-- Sort players by name
	local sortedPlayers = {}
	for name, data in pairs(groupPlayers) do
		table.insert(sortedPlayers, {name = name, data = data})
	end
	table.sort(sortedPlayers, function(a, b) return a.name < b.name end)
	
	-- Update blocks
	local blockIndex = 1
	for _, playerInfo in ipairs(sortedPlayers) do
		if blockIndex <= UltimateDisplay.config.maxGroupSize then
			local block = UltimateDisplay.controls.playerBlocks.blocks[blockIndex]
			UltimateDisplay.UpdatePlayerBlock(block, playerInfo.name, playerInfo.data)
			block.control:SetHidden(false)
			blockIndex = blockIndex + 1
		end
	end
	
	-- Hide unused blocks
	for i = blockIndex, UltimateDisplay.config.maxGroupSize do
		UltimateDisplay.controls.playerBlocks.blocks[i].control:SetHidden(true)
	end
	
	-- Adjust window height
	local visibleBlocks = math.min(blockIndex - 1, UltimateDisplay.config.maxGroupSize)
	local windowHeight = 30 + visibleBlocks * (UltimateDisplay.config.playerBlockHeight + 2)
	UltimateDisplay.controls.playerBlocks.window:SetHeight(math.max(windowHeight, 50))
end

function UltimateDisplay.UpdatePlayerBlock(block, name, data)
	if not block or not name or not data then
		return
	end
	
	-- Update name
	block.nameLabel:SetText(name)
	
	-- Update ultimate percentage
	local ultimatePercent = data.ultimatePercent or 0
	block.percentLabel:SetText(string.format("%d%%", ultimatePercent))
	block.ultimateBar:SetValue(ultimatePercent)
	
	-- Color the ultimate bar based on readiness
	if ultimatePercent >= 100 then
		block.ultimateBar:SetColor(0.3, 0.98, 0.22)
		block.percentLabel:SetColor(0.3, 0.98, 0.22)
	elseif ultimatePercent >= 80 then
		block.ultimateBar:SetColor(0.9, 0.9, 0.2)
		block.percentLabel:SetColor(0.9, 0.9, 0.2)
	else
		block.ultimateBar:SetColor(0.36, 0.54, 0.84)
		block.percentLabel:SetColor(1, 1, 1)
	end
end

function UltimateDisplay.UpdateClientUltimate()
	-- Update player's own ultimate icon
	local playerPower = GetUnitPower("player", POWERTYPE_ULTIMATE)
	local playerPowerMax = GetUnitPowerMax("player", POWERTYPE_ULTIMATE)
	local playerPercent = 0
	if playerPowerMax > 0 then
		playerPercent = math.floor((playerPower / playerPowerMax) * 100)
	end
	
	-- Get ultimate data
	local ultimates = Beltalowda.util and Beltalowda.util.ultimates and Beltalowda.util.ultimates.ultimates
	if ultimates and UltimateDisplay.savedVars.playerUltimateId then
		local ultIndex = UltimateDisplay.savedVars.playerUltimateId
		if ultIndex > 0 and ultIndex <= #ultimates then
			local ult = ultimates[ultIndex]
			if ult and ult.icon then
				UltimateDisplay.controls.clientUltimate.texture:SetTexture(ult.icon)
			end
		end
	end
	
	-- Color based on readiness
	if playerPercent >= 100 then
		UltimateDisplay.controls.clientUltimate.texture:SetColor(0.3, 0.98, 0.22)
	else
		UltimateDisplay.controls.clientUltimate.texture:SetColor(1, 1, 1)
	end
end

function UltimateDisplay.UpdateGroupUltimates()
	-- Update the group ultimate selector icons with counts
	local groupPlayers = {}
	if Beltalowda.util and Beltalowda.util.group then
		groupPlayers = Beltalowda.util.group.GetAllPlayers()
	end
	
	local ultimates = Beltalowda.util and Beltalowda.util.ultimates and Beltalowda.util.ultimates.ultimates
	if not ultimates then return end
	
	-- Count ready ultimates for each tracked type
	for i, selector in ipairs(UltimateDisplay.controls.groupUltimates.selectors) do
		local ultId = UltimateDisplay.trackedUltimates[i] or 1
		local ultIndex = ultId
		
		-- Find the ultimate by ID
		for j = 1, #ultimates do
			if ultimates[j].id == ultId then
				ultIndex = j
				break
			end
		end
		
		if ultIndex > 0 and ultIndex <= #ultimates then
			local ult = ultimates[ultIndex]
			if ult and ult.icon then
				selector.texture:SetTexture(ult.icon)
			end
		end
		
		-- TODO: Count ready ultimates of this specific type
		-- Currently we don't track which ultimate each player has slotted,
		-- so for now we just count all ready ultimates
		-- Future enhancement: integrate with ESO's GetSlotBoundId() or similar
		local readyCount = 0
		for name, data in pairs(groupPlayers) do
			if data.ultimatePercent and data.ultimatePercent >= 100 then
				readyCount = readyCount + 1
			end
		end
		
		selector.label:SetText(tostring(readyCount))
	end
end

function UltimateDisplay.UpdateUltimateOverview()
	-- Update the compact overview with specific ultimate counts
	local groupPlayers = {}
	if Beltalowda.util and Beltalowda.util.group then
		groupPlayers = Beltalowda.util.group.GetAllPlayers()
	end
	
	-- TODO: Count ready vs total for specific ultimate types
	-- Currently we don't track which ultimate each player has slotted,
	-- so we show generic counts for all ultimates
	-- Future enhancement: integrate ultimate detection to show type-specific counts
	local totalPlayers = 0
	local readyPlayers = 0
	
	for name, data in pairs(groupPlayers) do
		totalPlayers = totalPlayers + 1
		if data.ultimatePercent and data.ultimatePercent >= 100 then
			readyPlayers = readyPlayers + 1
		end
	end
	
	-- Update labels (showing same counts for all types until we can detect specific ultimates)
	local labels = UltimateDisplay.controls.ultimateOverview.labels
	if labels.destruction then
		labels.destruction:SetText(string.format("%d/%d Destro:", readyPlayers, totalPlayers))
	end
	if labels.storm then
		labels.storm:SetText(string.format("%d/%d Storm:", readyPlayers, totalPlayers))
	end
	if labels.negate then
		labels.negate:SetText(string.format("%d/%d Neg.:", readyPlayers, totalPlayers))
	end
	if labels.nova then
		labels.nova:SetText(string.format("%d/%d Nova:", readyPlayers, totalPlayers))
	end
end

function UltimateDisplay.ShowClientUltimateMenu()
	-- TODO: Show context menu to select ultimate
	d("Click to select your ultimate (feature coming soon)")
end

function UltimateDisplay.ShowGroupUltimateMenu(index)
	-- TODO: Show context menu to select ultimate to track
	d("Click to select ultimate to track at position " .. index .. " (feature coming soon)")
end

function UltimateDisplay.StartUpdateTimer()
	EVENT_MANAGER:RegisterForUpdate("BeltalowdaUltimateDisplay", UltimateDisplay.config.updateInterval, function()
		UltimateDisplay.Update()
	end)
end

function UltimateDisplay.StopUpdateTimer()
	EVENT_MANAGER:UnregisterForUpdate("BeltalowdaUltimateDisplay")
end

function UltimateDisplay.SetEnabled(enabled)
	UltimateDisplay.enabled = enabled
	if enabled then
		UltimateDisplay.StartUpdateTimer()
	else
		UltimateDisplay.StopUpdateTimer()
		-- Hide all windows
		if UltimateDisplay.controls.playerBlocks then
			UltimateDisplay.controls.playerBlocks.window:SetHidden(true)
		end
		if UltimateDisplay.controls.clientUltimate then
			UltimateDisplay.controls.clientUltimate.window:SetHidden(true)
		end
		if UltimateDisplay.controls.groupUltimates then
			UltimateDisplay.controls.groupUltimates.window:SetHidden(true)
		end
		if UltimateDisplay.controls.ultimateOverview then
			UltimateDisplay.controls.ultimateOverview.window:SetHidden(true)
		end
	end
end

function UltimateDisplay.ToggleDisplay()
	UltimateDisplay.enabled = not UltimateDisplay.enabled
	if UltimateDisplay.enabled then
		d("Beltalowda: Ultimate display enabled")
		UltimateDisplay.StartUpdateTimer()
		UltimateDisplay.Update()
	else
		d("Beltalowda: Ultimate display disabled")
		UltimateDisplay.SetEnabled(false)
	end
end

-- Individual window toggle commands
function UltimateDisplay.TogglePlayerBlocks()
	UltimateDisplay.savedVars.showPlayerBlocks = not UltimateDisplay.savedVars.showPlayerBlocks
	if UltimateDisplay.controls.playerBlocks then
		UltimateDisplay.controls.playerBlocks.window:SetHidden(not UltimateDisplay.savedVars.showPlayerBlocks)
	end
	d("Beltalowda: Player blocks " .. (UltimateDisplay.savedVars.showPlayerBlocks and "shown" or "hidden"))
end

function UltimateDisplay.ToggleClientUltimate()
	UltimateDisplay.savedVars.showClientUltimate = not UltimateDisplay.savedVars.showClientUltimate
	if UltimateDisplay.controls.clientUltimate then
		UltimateDisplay.controls.clientUltimate.window:SetHidden(not UltimateDisplay.savedVars.showClientUltimate)
	end
	d("Beltalowda: Client ultimate " .. (UltimateDisplay.savedVars.showClientUltimate and "shown" or "hidden"))
end

function UltimateDisplay.ToggleGroupUltimates()
	UltimateDisplay.savedVars.showGroupUltimates = not UltimateDisplay.savedVars.showGroupUltimates
	if UltimateDisplay.controls.groupUltimates then
		UltimateDisplay.controls.groupUltimates.window:SetHidden(not UltimateDisplay.savedVars.showGroupUltimates)
	end
	d("Beltalowda: Group ultimates " .. (UltimateDisplay.savedVars.showGroupUltimates and "shown" or "hidden"))
end

function UltimateDisplay.ToggleUltimateOverview()
	UltimateDisplay.savedVars.showUltimateOverview = not UltimateDisplay.savedVars.showUltimateOverview
	if UltimateDisplay.controls.ultimateOverview then
		UltimateDisplay.controls.ultimateOverview.window:SetHidden(not UltimateDisplay.savedVars.showUltimateOverview)
	end
	d("Beltalowda: Ultimate overview " .. (UltimateDisplay.savedVars.showUltimateOverview and "shown" or "hidden"))
end
