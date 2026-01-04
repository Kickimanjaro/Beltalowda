-- Beltalowda Client Ultimate Selector
-- Draggable selector box where player chooses which ultimate to report to group
-- Inspired by RdK's clientUltimateTLW design

Beltalowda = Beltalowda or {}
Beltalowda.UI = Beltalowda.UI or {}
Beltalowda.UI.ClientUltimateSelector = Beltalowda.UI.ClientUltimateSelector or {}

local CUS = Beltalowda.UI.ClientUltimateSelector
local wm = WINDOW_MANAGER

-- Constants
CUS.ICON_SIZE = 64
CUS.OFFSET = 4

-- Controls
CUS.controls = {
    window = nil,
    icon = nil,
    backdrop = nil,
}

-- Settings
CUS.settings = {
    enabled = true,
    locked = false,
    positionX = 300,
    positionY = 100,
    selectedUltimateId = 0,
    selectedIndex = 1,
}

-- Available ultimates for selection (player's slotted ultimates)
CUS.availableUltimates = {
    -- Will be populated from player's actual slotted ultimates
    -- For now, just track what's selected
}

--[[
    Initialize the Client Ultimate Selector
]]--
function CUS.Initialize()
    -- Load settings
    CUS.LoadSettings()
    
    -- Create selector window
    CUS.CreateWindow()
    
    -- Apply settings
    CUS.ApplySettings()
    
    -- Detect player's slotted ultimates
    CUS.DetectPlayerUltimates()
    
    -- Register for events
    CUS.RegisterForEvents()
    
    return true
end

--[[
    Load settings from SavedVariables
]]--
function CUS.LoadSettings()
    -- Initialize BeltalowdaVars if it doesn't exist yet
    BeltalowdaVars = BeltalowdaVars or {}
    BeltalowdaVars.ui = BeltalowdaVars.ui or {}
    BeltalowdaVars.ui.clientUltimateSelector = BeltalowdaVars.ui.clientUltimateSelector or {}
    
    local saved = BeltalowdaVars.ui.clientUltimateSelector
    
    CUS.settings.enabled = (saved.enabled ~= nil) and saved.enabled or true
    CUS.settings.locked = (saved.locked ~= nil) and saved.locked or false
    CUS.settings.positionX = saved.positionX or 300
    CUS.settings.positionY = saved.positionY or 100
    CUS.settings.selectedUltimateId = saved.selectedUltimateId or 0
    CUS.settings.selectedIndex = saved.selectedIndex or 1
end

--[[
    Save settings to SavedVariables
]]--
function CUS.SaveSettings()
    -- Ensure BeltalowdaVars exists
    BeltalowdaVars = BeltalowdaVars or {}
    BeltalowdaVars.ui = BeltalowdaVars.ui or {}
    
    BeltalowdaVars.ui.clientUltimateSelector = {
        enabled = CUS.settings.enabled,
        locked = CUS.settings.locked,
        positionX = CUS.settings.positionX,
        positionY = CUS.settings.positionY,
        selectedUltimateId = CUS.settings.selectedUltimateId,
        selectedIndex = CUS.settings.selectedIndex,
    }
end

--[[
    Create the selector window
]]--
function CUS.CreateWindow()
    local window = wm:CreateTopLevelWindow("BeltalowdaClientUltimateSelector")
    window:SetClampedToScreen(true)
    window:SetDrawLayer(DL_BACKGROUND)
    window:SetDrawLevel(1)
    window:SetMovable(not CUS.settings.locked)
    window:SetMouseEnabled(true)
    window:SetHidden(not CUS.settings.enabled)
    
    local width = CUS.ICON_SIZE + (CUS.OFFSET * 2)
    local height = CUS.ICON_SIZE + (CUS.OFFSET * 2)
    window:SetDimensions(width, height)
    
    -- Position
    window:ClearAnchors()
    window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, CUS.settings.positionX, CUS.settings.positionY)
    
    -- Handle movement
    window:SetHandler("OnMoveStop", function()
        CUS.OnWindowMoved()
    end)
    
    -- Create backdrop
    local backdrop = wm:CreateControl(nil, window, CT_BACKDROP)
    backdrop:SetAnchor(TOPLEFT, window, TOPLEFT, 0, 0)
    backdrop:SetDimensions(width, height)
    backdrop:SetCenterColor(0.1, 0.1, 0.1, 0.8)
    backdrop:SetEdgeColor(0.5, 0.5, 0.5, 1)
    backdrop:SetEdgeTexture(nil, 1, 1, 2, 0)
    backdrop:SetHidden(CUS.settings.locked)
    
    -- Create icon
    local icon = wm:CreateControl(nil, window, CT_TEXTURE)
    icon:SetAnchor(CENTER, window, CENTER, 0, 0)
    icon:SetDimensions(CUS.ICON_SIZE, CUS.ICON_SIZE)
    icon:SetTexture("/esoui/art/icons/ability_default.dds")
    icon:SetMouseEnabled(true)
    
    -- Click to cycle through ultimates
    icon:SetHandler("OnMouseUp", function(control, button, upInside)
        if upInside and button == MOUSE_BUTTON_INDEX_LEFT then
            CUS.CycleUltimate()
        end
    end)
    
    -- Tooltip
    icon:SetHandler("OnMouseEnter", function(control)
        CUS.ShowTooltip(control)
    end)
    
    icon:SetHandler("OnMouseExit", function(control)
        ClearTooltip(InformationTooltip)
    end)
    
    CUS.controls.window = window
    CUS.controls.icon = icon
    CUS.controls.backdrop = backdrop
end

--[[
    Apply settings to window
]]--
function CUS.ApplySettings()
    local window = CUS.controls.window
    if not window then return end
    
    window:SetHidden(not CUS.settings.enabled)
    window:SetMovable(not CUS.settings.locked)
    
    if CUS.controls.backdrop then
        CUS.controls.backdrop:SetHidden(CUS.settings.locked)
    end
    
    -- Update position
    window:ClearAnchors()
    window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, CUS.settings.positionX, CUS.settings.positionY)
    
    -- Update icon
    CUS.UpdateIcon()
end

--[[
    Handle window movement
]]--
function CUS.OnWindowMoved()
    local window = CUS.controls.window
    if not window then return end
    
    local _, point, _, _, offsetX, offsetY = window:GetAnchor(0)
    CUS.settings.positionX = offsetX
    CUS.settings.positionY = offsetY
    
    CUS.SaveSettings()
end

--[[
    Detect player's currently slotted ultimates (front bar and back bar)
]]--
function CUS.DetectPlayerUltimates()
    CUS.availableUltimates = {}
    
    -- Check both action bars (front bar = 0, back bar = 1)
    -- Slot 8 is always the ultimate slot in ESO
    for hotbarCategory = 0, 1 do
        local slotId = 8 -- Ultimate slot is always slot 8
        local abilityId = GetSlotBoundId(slotId, hotbarCategory)
        
        if abilityId and abilityId > 0 then
            -- Slot 8 is always ultimate, so if there's an ability here, it's an ultimate
            table.insert(CUS.availableUltimates, {
                id = abilityId,
                hotbar = hotbarCategory,
            })
        end
    end
    
    -- If we have ultimates and none selected, select the first one
    if #CUS.availableUltimates > 0 and CUS.settings.selectedUltimateId == 0 then
        CUS.settings.selectedIndex = 1
        CUS.settings.selectedUltimateId = CUS.availableUltimates[1].id
        CUS.SaveSettings()
    end
    
    -- Update icon
    CUS.UpdateIcon()
end

--[[
    Cycle to next ultimate
]]--
function CUS.CycleUltimate()
    if #CUS.availableUltimates == 0 then
        -- No ultimates detected
        return
    end
    
    -- Cycle to next index
    local oldIndex = CUS.settings.selectedIndex
    CUS.settings.selectedIndex = CUS.settings.selectedIndex + 1
    if CUS.settings.selectedIndex > #CUS.availableUltimates then
        CUS.settings.selectedIndex = 1
    end
    
    -- Update selected ultimate ID
    CUS.settings.selectedUltimateId = CUS.availableUltimates[CUS.settings.selectedIndex].id
    
    -- Update icon
    CUS.UpdateIcon()
    
    -- Save
    CUS.SaveSettings()
    
    -- Broadcast to group (placeholder - will be implemented with LibGroupBroadcast)
    CUS.BroadcastSelection()
end

--[[
    Update icon texture
]]--
function CUS.UpdateIcon()
    if not CUS.controls.icon then return end
    
    if CUS.settings.selectedUltimateId and CUS.settings.selectedUltimateId > 0 then
        local iconPath = GetAbilityIcon(CUS.settings.selectedUltimateId)
        if iconPath and iconPath ~= "" then
            CUS.controls.icon:SetTexture(iconPath)
        else
            CUS.controls.icon:SetTexture("/esoui/art/icons/ability_default.dds")
        end
    else
        CUS.controls.icon:SetTexture("/esoui/art/icons/ability_default.dds")
    end
end

--[[
    Show tooltip with ultimate info
]]--
function CUS.ShowTooltip(control)
    if CUS.settings.selectedUltimateId and CUS.settings.selectedUltimateId > 0 then
        InitializeTooltip(InformationTooltip, control, BOTTOM, 0, 0, TOP)
        
        local abilityName = GetAbilityName(CUS.settings.selectedUltimateId)
        local cost = GetAbilityCost(CUS.settings.selectedUltimateId)
        
        InformationTooltip:AddLine(abilityName, "", 1, 1, 1)
        InformationTooltip:AddLine(string.format("Cost: %d", cost), "", 0.8, 0.8, 0.8)
        InformationTooltip:AddLine("", "", 1, 1, 1)
        InformationTooltip:AddLine("Click to cycle ultimates", "", 0.6, 0.6, 0.6)
    end
end

--[[
    Broadcast selected ultimate to group
    This is a placeholder - actual implementation will use LibGroupBroadcast
]]--
function CUS.BroadcastSelection()
    -- For Phase 4, this just stores locally
    -- Phase 5+ will implement actual broadcasting via custom protocol
    
    -- Store in local player data for immediate UI feedback
    if Beltalowda.UI and Beltalowda.UI.GroupUltimateDisplay then
        local playerData = Beltalowda.UI.GroupUltimateDisplay.playerData
        playerData["player"] = {
            selectedUltimateId = CUS.settings.selectedUltimateId,
        }
    end
end

--[[
    Register for events
]]--
function CUS.RegisterForEvents()
    -- Re-detect ultimates when abilities change
    EVENT_MANAGER:RegisterForEvent("BeltalowdaClientUltimateSelector", EVENT_ACTION_SLOTS_FULL_UPDATE, function()
        CUS.DetectPlayerUltimates()
    end)
    
    -- Re-detect on bar swap
    EVENT_MANAGER:RegisterForEvent("BeltalowdaClientUltimateSelector", EVENT_ACTION_SLOT_ABILITY_SLOTTED, function()
        CUS.DetectPlayerUltimates()
    end)
end

--[[
    Toggle visibility
]]--
function CUS.Toggle()
    CUS.settings.enabled = not CUS.settings.enabled
    CUS.ApplySettings()
    CUS.SaveSettings()
    
    if CUS.settings.enabled then
        d("[Beltalowda] Client Ultimate Selector enabled")
    else
        d("[Beltalowda] Client Ultimate Selector disabled")
    end
end

--[[
    Toggle lock
]]--
function CUS.ToggleLock()
    CUS.settings.locked = not CUS.settings.locked
    CUS.ApplySettings()
    CUS.SaveSettings()
    
    if CUS.settings.locked then
        d("[Beltalowda] Client Ultimate Selector locked")
    else
        d("[Beltalowda] Client Ultimate Selector unlocked (drag to reposition)")
    end
end

--[[
    Get currently selected ultimate ID
]]--
function CUS.GetSelectedUltimateId()
    return CUS.settings.selectedUltimateId
end

return CUS
