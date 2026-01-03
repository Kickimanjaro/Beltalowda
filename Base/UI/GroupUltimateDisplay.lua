-- Beltalowda Group Ultimate Display
-- Main UI for displaying group ultimate statuses
-- Inspired by RdK's ResourceOverview design

Beltalowda = Beltalowda or {}
Beltalowda.UI = Beltalowda.UI or {}
Beltalowda.UI.GroupUltimateDisplay = Beltalowda.UI.GroupUltimateDisplay or {}

local GUD = Beltalowda.UI.GroupUltimateDisplay
local wm = WINDOW_MANAGER

-- Constants
GUD.ULTIMATE_ICON_SIZE = 48
GUD.PLAYER_BLOCK_WIDTH = 200
GUD.PLAYER_BLOCK_HEIGHT = 24
GUD.MAX_ULTIMATES = 12
GUD.MAX_PLAYERS_PER_ULTIMATE = 12
GUD.OFFSET = 2

-- Default ultimate abilities to track (can be configured later)
GUD.DEFAULT_ULTIMATES = {
    40223, -- Dawnbreaker
    32958, -- Northern Storm
    40161, -- Standard
    40224, -- Crescent Sweep
    40594, -- Nova
    40382, -- Meteor
    32455, -- Barrier
    32484, -- Veil of Blades
    40215, -- Shooting Star
    32433, -- Aggressive Horn
    40279, -- Practiced Incantation
    40181, -- Colossus
}

-- Controls
GUD.controls = {
    mainWindow = nil,
    ultimateColumns = {},
    playerBlocks = {},
}

-- Settings (will be saved to SavedVariables)
GUD.settings = {
    enabled = true,
    locked = false,
    scale = 1.0,
    opacity = 1.0,
    positionX = 100,
    positionY = 100,
    testMode = false,
    ultimateIds = {},
}

-- Data tracking
GUD.playerData = {} -- Tracks which ultimate each player has selected

--[[
    Initialize the Group Ultimate Display UI
]]--
function GUD.Initialize()
    d("[Beltalowda] Initializing Group Ultimate Display UI")
    
    -- Load settings from SavedVariables
    GUD.LoadSettings()
    
    -- Create main window
    GUD.CreateMainWindow()
    
    -- Create ultimate columns
    GUD.CreateUltimateColumns()
    
    -- Apply saved settings
    GUD.ApplySettings()
    
    -- Register for data updates
    GUD.RegisterForUpdates()
    
    d("[Beltalowda] Group Ultimate Display UI initialized")
    return true
end

--[[
    Load settings from SavedVariables
]]--
function GUD.LoadSettings()
    -- Initialize BeltalowdaVars if it doesn't exist yet
    BeltalowdaVars = BeltalowdaVars or {}
    BeltalowdaVars.ui = BeltalowdaVars.ui or {}
    BeltalowdaVars.ui.groupUltimateDisplay = BeltalowdaVars.ui.groupUltimateDisplay or {}
    
    local saved = BeltalowdaVars.ui.groupUltimateDisplay
    
    -- Load or set defaults
    GUD.settings.enabled = (saved.enabled ~= nil) and saved.enabled or true
    GUD.settings.locked = (saved.locked ~= nil) and saved.locked or false
    GUD.settings.scale = saved.scale or 1.0
    GUD.settings.opacity = saved.opacity or 1.0
    GUD.settings.positionX = saved.positionX or 100
    GUD.settings.positionY = saved.positionY or 100
    GUD.settings.testMode = (saved.testMode ~= nil) and saved.testMode or false
    
    -- Load ultimate IDs or use defaults
    if saved.ultimateIds and #saved.ultimateIds > 0 then
        GUD.settings.ultimateIds = saved.ultimateIds
    else
        GUD.settings.ultimateIds = {}
        for i = 1, GUD.MAX_ULTIMATES do
            GUD.settings.ultimateIds[i] = GUD.DEFAULT_ULTIMATES[i] or 0
        end
    end
end

--[[
    Save settings to SavedVariables
]]--
function GUD.SaveSettings()
    -- Ensure BeltalowdaVars exists
    BeltalowdaVars = BeltalowdaVars or {}
    BeltalowdaVars.ui = BeltalowdaVars.ui or {}
    
    BeltalowdaVars.ui.groupUltimateDisplay = {
        enabled = GUD.settings.enabled,
        locked = GUD.settings.locked,
        scale = GUD.settings.scale,
        opacity = GUD.settings.opacity,
        positionX = GUD.settings.positionX,
        positionY = GUD.settings.positionY,
        testMode = GUD.settings.testMode,
        ultimateIds = GUD.settings.ultimateIds,
    }
end

--[[
    Create main window container
]]--
function GUD.CreateMainWindow()
    local window = wm:CreateTopLevelWindow("BeltalowdaGroupUltimateDisplay")
    window:SetClampedToScreen(true)
    window:SetDrawLayer(DL_BACKGROUND)
    window:SetDrawLevel(0)
    window:SetMovable(not GUD.settings.locked)
    window:SetMouseEnabled(true)
    window:SetHidden(not GUD.settings.enabled)
    
    -- Calculate window dimensions based on ultimate columns
    local width = (GUD.ULTIMATE_ICON_SIZE * GUD.MAX_ULTIMATES) + (GUD.OFFSET * 2)
    local height = GUD.ULTIMATE_ICON_SIZE + (GUD.OFFSET * 2)
    window:SetDimensions(width, height)
    
    -- Position window
    window:ClearAnchors()
    window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, GUD.settings.positionX, GUD.settings.positionY)
    
    -- Handle window movement
    window:SetHandler("OnMoveStop", function()
        GUD.OnWindowMoved()
    end)
    
    -- Create backdrop for visibility when unlocked
    local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
    backdrop:SetAnchor(TOPLEFT, window, TOPLEFT, 0, 0)
    backdrop:SetDimensions(width, height)
    backdrop:SetCenterColor(0, 0, 0, 0.3)
    backdrop:SetEdgeColor(1, 1, 1, 0.5)
    backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
    backdrop:SetHidden(GUD.settings.locked)
    
    window.backdrop = backdrop
    GUD.controls.mainWindow = window
end

--[[
    Create ultimate column displays
]]--
function GUD.CreateUltimateColumns()
    local mainWindow = GUD.controls.mainWindow
    
    for i = 1, GUD.MAX_ULTIMATES do
        local column = GUD.CreateUltimateColumn(mainWindow, i)
        GUD.controls.ultimateColumns[i] = column
    end
end

--[[
    Create a single ultimate column (icon + player blocks beneath)
]]--
function GUD.CreateUltimateColumn(parent, index)
    local column = {}
    
    -- Container for this column
    local container = wm:CreateControl(nil, parent, CT_CONTROL)
    local xOffset = GUD.OFFSET + (GUD.ULTIMATE_ICON_SIZE * (index - 1))
    container:SetAnchor(TOPLEFT, parent, TOPLEFT, xOffset, GUD.OFFSET)
    container:SetDimensions(GUD.ULTIMATE_ICON_SIZE, GUD.ULTIMATE_ICON_SIZE + (GUD.PLAYER_BLOCK_HEIGHT * GUD.MAX_PLAYERS_PER_ULTIMATE))
    
    -- Ultimate icon
    local icon = wm:CreateControl(nil, container, CT_TEXTURE)
    icon:SetAnchor(TOPLEFT, container, TOPLEFT, 0, 0)
    icon:SetDimensions(GUD.ULTIMATE_ICON_SIZE, GUD.ULTIMATE_ICON_SIZE)
    icon:SetTexture("/esoui/art/icons/ability_default.dds")
    
    -- Icon backdrop
    local iconBackdrop = wm:CreateControl(nil, container, CT_BACKDROP)
    iconBackdrop:SetAnchor(TOPLEFT, icon, TOPLEFT, 0, 0)
    iconBackdrop:SetDimensions(GUD.ULTIMATE_ICON_SIZE, GUD.ULTIMATE_ICON_SIZE)
    iconBackdrop:SetCenterColor(0, 0, 0, 0.5)
    iconBackdrop:SetEdgeColor(0.3, 0.3, 0.3, 1)
    iconBackdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
    iconBackdrop:SetDrawLevel(0)
    icon:SetDrawLevel(1)
    
    -- Player blocks (stacked beneath the icon)
    local playerBlocks = {}
    for j = 1, GUD.MAX_PLAYERS_PER_ULTIMATE do
        local block = GUD.CreatePlayerBlock(container, j)
        playerBlocks[j] = block
    end
    
    column.container = container
    column.icon = icon
    column.iconBackdrop = iconBackdrop
    column.playerBlocks = playerBlocks
    column.ultimateId = GUD.settings.ultimateIds[index] or 0
    
    -- Update icon texture based on ultimate ID
    GUD.UpdateUltimateIcon(column)
    
    return column
end

--[[
    Create a player block (name, status bar, group index)
]]--
function GUD.CreatePlayerBlock(parent, index)
    local block = {}
    
    -- Container
    local container = wm:CreateControl(nil, parent, CT_CONTROL)
    local yOffset = GUD.ULTIMATE_ICON_SIZE + (GUD.PLAYER_BLOCK_HEIGHT * (index - 1))
    container:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, yOffset)
    container:SetDimensions(GUD.PLAYER_BLOCK_WIDTH, GUD.PLAYER_BLOCK_HEIGHT)
    container:SetHidden(true) -- Hidden by default until assigned
    
    -- Background
    local backdrop = wm:CreateControl(nil, container, CT_BACKDROP)
    backdrop:SetAnchor(TOPLEFT, container, TOPLEFT, 0, 0)
    backdrop:SetDimensions(GUD.PLAYER_BLOCK_WIDTH, GUD.PLAYER_BLOCK_HEIGHT)
    backdrop:SetCenterColor(0.2, 0.2, 0.2, 0.8)
    backdrop:SetEdgeColor(0, 0, 0, 1)
    backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
    
    -- Ultimate progress bar (shows ultimate percentage)
    local progressBar = wm:CreateControl(nil, container, CT_STATUSBAR)
    progressBar:SetAnchor(TOPLEFT, container, TOPLEFT, 0, 0)
    progressBar:SetDimensions(GUD.PLAYER_BLOCK_WIDTH, GUD.PLAYER_BLOCK_HEIGHT)
    progressBar:SetMinMax(0, 100)
    progressBar:SetValue(0)
    
    -- Progress bar backdrop (color-coded for readiness)
    local barBackdrop = wm:CreateControl(nil, progressBar, CT_BACKDROP)
    barBackdrop:SetAnchor(TOPLEFT, progressBar, TOPLEFT, 0, 0)
    barBackdrop:SetDimensions(GUD.PLAYER_BLOCK_WIDTH, GUD.PLAYER_BLOCK_HEIGHT)
    barBackdrop:SetCenterColor(0.5, 0.5, 0.5, 0.3)
    barBackdrop:SetEdgeColor(0, 0, 0, 0)
    barBackdrop:SetDrawLevel(0)
    
    -- Group index label
    local groupLabel = wm:CreateControl(nil, container, CT_LABEL)
    groupLabel:SetAnchor(LEFT, container, LEFT, 2, 0)
    groupLabel:SetFont("ZoFontGameSmall")
    groupLabel:SetText("")
    groupLabel:SetDimensions(20, GUD.PLAYER_BLOCK_HEIGHT)
    groupLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
    groupLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
    groupLabel:SetColor(1, 1, 1, 1)
    
    -- Player name label
    local nameLabel = wm:CreateControl(nil, container, CT_LABEL)
    nameLabel:SetAnchor(LEFT, groupLabel, RIGHT, 2, 0)
    nameLabel:SetFont("ZoFontGameSmall")
    nameLabel:SetText("")
    nameLabel:SetDimensions(GUD.PLAYER_BLOCK_WIDTH - 24, GUD.PLAYER_BLOCK_HEIGHT)
    nameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
    nameLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
    nameLabel:SetColor(1, 1, 1, 1)
    
    block.container = container
    block.backdrop = backdrop
    block.progressBar = progressBar
    block.barBackdrop = barBackdrop
    block.groupLabel = groupLabel
    block.nameLabel = nameLabel
    block.unitTag = nil
    block.ultimatePercent = 0
    
    return block
end

--[[
    Update ultimate icon texture
]]--
function GUD.UpdateUltimateIcon(column)
    if not column or not column.icon then return end
    
    local abilityId = column.ultimateId
    if abilityId and abilityId > 0 then
        local icon = GetAbilityIcon(abilityId)
        if icon and icon ~= "" then
            column.icon:SetTexture(icon)
        else
            column.icon:SetTexture("/esoui/art/icons/ability_default.dds")
        end
    else
        column.icon:SetTexture("/esoui/art/icons/ability_default.dds")
    end
end

--[[
    Apply settings to UI
]]--
function GUD.ApplySettings()
    local window = GUD.controls.mainWindow
    if not window then return end
    
    -- Apply scale
    window:SetScale(GUD.settings.scale)
    
    -- Apply opacity (alpha)
    window:SetAlpha(GUD.settings.opacity)
    
    -- Apply visibility
    window:SetHidden(not GUD.settings.enabled)
    
    -- Apply lock state
    window:SetMovable(not GUD.settings.locked)
    if window.backdrop then
        window.backdrop:SetHidden(GUD.settings.locked)
    end
    
    -- Update position
    window:ClearAnchors()
    window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, GUD.settings.positionX, GUD.settings.positionY)
end

--[[
    Handle window movement - save position
]]--
function GUD.OnWindowMoved()
    local window = GUD.controls.mainWindow
    if not window then return end
    
    -- Get new position
    local _, point, _, _, offsetX, offsetY = window:GetAnchor(0)
    
    GUD.settings.positionX = offsetX
    GUD.settings.positionY = offsetY
    
    GUD.SaveSettings()
end

--[[
    Register for data updates from network layer
]]--
function GUD.RegisterForUpdates()
    -- Hook into network data change callback
    if Beltalowda.network then
        -- Store the original callback if it exists (it might just be a placeholder)
        local originalCallback = Beltalowda.network.OnDataChanged
        
        Beltalowda.network.OnDataChanged = function(dataType, unitTag)
            -- Call original callback if it was a real function
            if originalCallback and type(originalCallback) == "function" then
                originalCallback(dataType, unitTag)
            end
            
            -- Update UI when ultimate data changes
            if dataType == "ultimate" then
                GUD.OnUltimateDataChanged(unitTag)
            end
        end
        
        d("[Beltalowda] Group Ultimate Display hooked into data change notifications")
    end
    
    -- Also update periodically to catch any changes
    EVENT_MANAGER:RegisterForUpdate("BeltalowdaGroupUltimateDisplay", 1000, function()
        GUD.RefreshDisplay()
    end)
    
    d("[Beltalowda] Group Ultimate Display periodic refresh enabled")
end

--[[
    Handle ultimate data change for a specific unit
]]--
function GUD.OnUltimateDataChanged(unitTag)
    -- Update the display for this player
    GUD.UpdatePlayerDisplay(unitTag)
end

--[[
    Update display for a specific player
]]--
function GUD.UpdatePlayerDisplay(unitTag)
    if not unitTag then return end
    
    -- Get ultimate data for this player
    local ultData = Beltalowda.network and Beltalowda.network.GetUltimateData(unitTag)
    
    if not ultData then
        -- No data yet for this player
        return
    end
    
    if not ultData.abilityId or ultData.abilityId == 0 then
        -- No ultimate ability set
        return
    end
    
    -- Find which ultimate column this player belongs to
    local columnIndex = GUD.FindUltimateColumn(ultData.abilityId)
    if not columnIndex then
        -- This ultimate isn't in our tracked list
        return
    end
    
    local column = GUD.controls.ultimateColumns[columnIndex]
    if not column then return end
    
    -- Find or assign a player block for this player
    local blockIndex = GUD.FindOrAssignPlayerBlock(column, unitTag)
    if not blockIndex then return end
    
    local block = column.playerBlocks[blockIndex]
    if not block then return end
    
    -- Update block display
    local playerName = GetUnitName(unitTag)
    local groupIndex = GUD.GetGroupIndex(unitTag)
    local percent = ultData.percent or 0
    
    block.container:SetHidden(false)
    block.groupLabel:SetText(tostring(groupIndex))
    block.nameLabel:SetText(playerName)
    block.progressBar:SetValue(percent / 100) -- Progress bar expects 0-1, not 0-100
    block.ultimatePercent = percent
    
    -- Color code based on readiness
    GUD.UpdateBlockColor(block, percent)
    
    -- Debug: Log successful update (only occasionally to avoid spam)
    if math.random() < 0.1 then -- 10% chance
        d(string.format("[Beltalowda] Updated player block: %s, ult=%s, %d%%", 
            playerName, GetAbilityName(ultData.abilityId), percent))
    end
end

--[[
    Find which column should display a specific ultimate ability
]]--
function GUD.FindUltimateColumn(abilityId)
    for i = 1, GUD.MAX_ULTIMATES do
        if GUD.settings.ultimateIds[i] == abilityId then
            return i
        end
    end
    return nil
end

--[[
    Find or assign a player block in a column
]]--
function GUD.FindOrAssignPlayerBlock(column, unitTag)
    -- First check if player already has a block
    for i = 1, GUD.MAX_PLAYERS_PER_ULTIMATE do
        local block = column.playerBlocks[i]
        if block.unitTag == unitTag then
            return i
        end
    end
    
    -- Find first empty block
    for i = 1, GUD.MAX_PLAYERS_PER_ULTIMATE do
        local block = column.playerBlocks[i]
        if not block.unitTag then
            block.unitTag = unitTag
            return i
        end
    end
    
    return nil
end

--[[
    Get group index for a unit tag
]]--
function GUD.GetGroupIndex(unitTag)
    if unitTag == "player" then
        return GetGroupIndexByUnitTag("player") or 0
    end
    
    -- Extract group index from unit tag (e.g., "group1" -> 1)
    local index = tonumber(string.match(unitTag, "group(%d+)"))
    return index or 0
end

--[[
    Update block color based on ultimate percentage
]]--
function GUD.UpdateBlockColor(block, percent)
    if not block or not block.barBackdrop then return end
    
    if percent >= 100 then
        -- Ready - green
        block.barBackdrop:SetCenterColor(0, 1, 0, 0.5)
    elseif percent >= 75 then
        -- Almost ready - yellow
        block.barBackdrop:SetCenterColor(1, 1, 0, 0.5)
    elseif percent >= 50 then
        -- Building - orange
        block.barBackdrop:SetCenterColor(1, 0.5, 0, 0.5)
    else
        -- Not ready - red/gray
        block.barBackdrop:SetCenterColor(0.5, 0.5, 0.5, 0.3)
    end
end

--[[
    Refresh entire display (all players, all columns)
]]--
function GUD.RefreshDisplay()
    if not GUD.settings.enabled then return end
    if not Beltalowda.network then return end
    
    -- Clear all player blocks
    GUD.ClearAllPlayerBlocks()
    
    -- Get all group data and update
    local groupSize = GetGroupSize()
    if groupSize == 0 then
        -- Not in group, just show player data
        GUD.UpdatePlayerDisplay("player")
    else
        -- Update all group members
        for i = 1, groupSize do
            local unitTag = GetGroupUnitTagByIndex(i)
            if unitTag then
                GUD.UpdatePlayerDisplay(unitTag)
            end
        end
    end
end

--[[
    Clear all player blocks
]]--
function GUD.ClearAllPlayerBlocks()
    for i = 1, GUD.MAX_ULTIMATES do
        local column = GUD.controls.ultimateColumns[i]
        if column then
            for j = 1, GUD.MAX_PLAYERS_PER_ULTIMATE do
                local block = column.playerBlocks[j]
                if block then
                    block.container:SetHidden(true)
                    block.unitTag = nil
                    block.ultimatePercent = 0
                end
            end
        end
    end
end

--[[
    Toggle UI visibility
]]--
function GUD.Toggle()
    GUD.settings.enabled = not GUD.settings.enabled
    GUD.ApplySettings()
    GUD.SaveSettings()
    
    if GUD.settings.enabled then
        d("[Beltalowda] Group Ultimate Display enabled")
    else
        d("[Beltalowda] Group Ultimate Display disabled")
    end
end

--[[
    Toggle lock/unlock
]]--
function GUD.ToggleLock()
    GUD.settings.locked = not GUD.settings.locked
    GUD.ApplySettings()
    GUD.SaveSettings()
    
    if GUD.settings.locked then
        d("[Beltalowda] Group Ultimate Display locked")
    else
        d("[Beltalowda] Group Ultimate Display unlocked (drag to reposition)")
    end
end

-- Debug commands
SLASH_COMMANDS["/btlwui"] = function(args)
    if args == "toggle" then
        GUD.Toggle()
    elseif args == "lock" then
        GUD.ToggleLock()
    elseif args == "refresh" then
        GUD.RefreshDisplay()
        d("[Beltalowda] Display refreshed")
    elseif args == "test" then
        GUD.settings.testMode = not GUD.settings.testMode
        d("[Beltalowda] Test mode: " .. tostring(GUD.settings.testMode))
    else
        d("=== Beltalowda UI Commands ===")
        d("/btlwui toggle - Toggle UI visibility")
        d("/btlwui lock - Toggle UI lock/unlock")
        d("/btlwui refresh - Refresh display")
        d("/btlwui test - Toggle test mode")
    end
end

return GUD
