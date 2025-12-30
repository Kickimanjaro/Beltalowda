-- Beltalowda Ultimate Display
-- GUI for displaying group member ultimates
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
UltimateDisplay.config.ultimateBarHeight = 30
UltimateDisplay.config.resourceBarHeight = 5

-- State
UltimateDisplay.controls = {}
UltimateDisplay.lastUpdateTime = 0
UltimateDisplay.enabled = true

function UltimateDisplay.Initialize()
	-- Create the top-level window
	UltimateDisplay.controls.window = wm:CreateTopLevelWindow("BeltalowdaUltimateDisplay")
	local window = UltimateDisplay.controls.window
	
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
	UltimateDisplay.controls.backdrop = backdrop
	
	-- Create title label
	local title = wm:CreateControl(nil, window, CT_LABEL)
	title:SetAnchor(TOP, window, TOP, 0, 5)
	title:SetFont("ZoFontGameBold")
	title:SetText("Group Ultimates")
	title:SetColor(1, 1, 1, 1)
	UltimateDisplay.controls.title = title
	
	-- Create player blocks container
	UltimateDisplay.controls.playerBlocks = {}
	for i = 1, 24 do
		UltimateDisplay.controls.playerBlocks[i] = UltimateDisplay.CreatePlayerBlock(window, i)
	end
	
	-- Register for updates
	EVENT_MANAGER:RegisterForUpdate("BeltalowdaUltimateDisplay", UltimateDisplay.config.updateInterval, function()
		UltimateDisplay.Update()
	end)
	
	-- Hide by default until we're in a group
	window:SetHidden(true)
	
	d("Beltalowda: Ultimate Display UI initialized")
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
	block.background = bg
	
	-- Ultimate progress bar
	local ultimateBar = wm:CreateControl(nil, block, CT_STATUSBAR)
	ultimateBar:SetAnchor(TOPLEFT, block, TOPLEFT, 0, 0)
	ultimateBar:SetDimensions(UltimateDisplay.config.playerBlockWidth, UltimateDisplay.config.ultimateBarHeight)
	ultimateBar:SetMinMax(0, 100)
	ultimateBar:SetValue(0)
	block.ultimateBar = ultimateBar
	
	-- Magicka bar
	local magickaBar = wm:CreateControl(nil, block, CT_STATUSBAR)
	magickaBar:SetAnchor(TOPLEFT, block, TOPLEFT, 0, UltimateDisplay.config.ultimateBarHeight)
	magickaBar:SetDimensions(UltimateDisplay.config.playerBlockWidth, UltimateDisplay.config.resourceBarHeight)
	magickaBar:SetMinMax(0, 100)
	magickaBar:SetValue(100)
	block.magickaBar = magickaBar
	
	-- Stamina bar
	local staminaBar = wm:CreateControl(nil, block, CT_STATUSBAR)
	staminaBar:SetAnchor(TOPLEFT, block, TOPLEFT, 0, UltimateDisplay.config.ultimateBarHeight + UltimateDisplay.config.resourceBarHeight)
	staminaBar:SetDimensions(UltimateDisplay.config.playerBlockWidth, UltimateDisplay.config.resourceBarHeight)
	staminaBar:SetMinMax(0, 100)
	staminaBar:SetValue(100)
	block.staminaBar = staminaBar
	
	-- Player name label
	local nameLabel = wm:CreateControl(nil, block, CT_LABEL)
	nameLabel:SetAnchor(LEFT, block, LEFT, 5, 0)
	nameLabel:SetFont("ZoFontGame")
	nameLabel:SetText("")
	nameLabel:SetColor(1, 1, 1, 1)
	nameLabel:SetDimensionConstraints(0, 0, UltimateDisplay.config.playerBlockWidth - 60, UltimateDisplay.config.ultimateBarHeight)
	nameLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
	nameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	block.nameLabel = nameLabel
	
	-- Ultimate percentage label
	local percentLabel = wm:CreateControl(nil, block, CT_LABEL)
	percentLabel:SetAnchor(RIGHT, block, RIGHT, -5, 0)
	percentLabel:SetFont("ZoFontGameBold")
	percentLabel:SetText("0%")
	percentLabel:SetColor(1, 1, 1, 1)
	percentLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	block.percentLabel = percentLabel
	
	return block
end

function UltimateDisplay.Update()
	if not UltimateDisplay.enabled then
		return
	end
	
	-- Check if in a group
	if not IsUnitGrouped("player") then
		UltimateDisplay.controls.window:SetHidden(true)
		return
	end
	
	-- Show window
	UltimateDisplay.controls.window:SetHidden(false)
	
	-- Get group data
	local groupPlayers = {}
	if Beltalowda.util and Beltalowda.util.group then
		groupPlayers = Beltalowda.util.group.GetAllPlayers()
	end
	
	-- Sort players by name for consistent display
	local sortedPlayers = {}
	for name, data in pairs(groupPlayers) do
		table.insert(sortedPlayers, {name = name, data = data})
	end
	table.sort(sortedPlayers, function(a, b) return a.name < b.name end)
	
	-- Update player blocks
	local blockIndex = 1
	for _, playerInfo in ipairs(sortedPlayers) do
		if blockIndex <= 24 then
			local block = UltimateDisplay.controls.playerBlocks[blockIndex]
			UltimateDisplay.UpdatePlayerBlock(block, playerInfo.name, playerInfo.data)
			block:SetHidden(false)
			blockIndex = blockIndex + 1
		end
	end
	
	-- Hide unused blocks
	for i = blockIndex, 24 do
		UltimateDisplay.controls.playerBlocks[i]:SetHidden(true)
	end
	
	-- Adjust window height based on number of players
	local visibleBlocks = math.min(blockIndex - 1, 24)
	local windowHeight = 30 + visibleBlocks * (UltimateDisplay.config.playerBlockHeight + 2)
	UltimateDisplay.controls.window:SetHeight(math.max(windowHeight, 50))
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
		-- Ready - green
		block.ultimateBar:SetColor(0.3, 0.98, 0.22)
		block.percentLabel:SetColor(0.3, 0.98, 0.22)
	elseif ultimatePercent >= 80 then
		-- Almost ready - yellow
		block.ultimateBar:SetColor(0.9, 0.9, 0.2)
		block.percentLabel:SetColor(0.9, 0.9, 0.2)
	else
		-- Not ready - blue
		block.ultimateBar:SetColor(0.36, 0.54, 0.84)
		block.percentLabel:SetColor(1, 1, 1)
	end
	
	-- Update resource bars (if available)
	-- For now, just set them to 100% since we don't track these yet
	block.magickaBar:SetValue(100)
	block.magickaBar:SetColor(0, 0.07, 0.95)
	block.staminaBar:SetValue(100)
	block.staminaBar:SetColor(0.09, 0.57, 0.20)
end

function UltimateDisplay.SetEnabled(enabled)
	UltimateDisplay.enabled = enabled
	if not enabled then
		UltimateDisplay.controls.window:SetHidden(true)
	end
end

function UltimateDisplay.ToggleDisplay()
	UltimateDisplay.enabled = not UltimateDisplay.enabled
	if UltimateDisplay.enabled then
		d("Beltalowda: Ultimate display enabled")
		UltimateDisplay.Update()
	else
		d("Beltalowda: Ultimate display disabled")
		UltimateDisplay.controls.window:SetHidden(true)
	end
end
