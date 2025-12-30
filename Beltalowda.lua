--[[
    Beltalowda - Group PvP Addon for Elder Scrolls Online
    Author: @Kickimanjaro
    Version: 0.1.0
]]--

Beltalowda = Beltalowda or {}
Beltalowda.name = "Beltalowda"
Beltalowda.version = "0.1.0"

-- Saved variables
Beltalowda.savedVariables = {}

-- Initialize addon
function Beltalowda:Initialize()
    -- Load saved variables
    self.savedVariables = ZO_SavedVars:NewAccountWide(
        "BeltalowdaSavedVariables",
        1,
        nil,
        {}
    )
    
    -- Initialize ultimate tracking
    if self.util and self.util.ultimates then
        self.util.ultimates.Initialize()
        d("Beltalowda: Ultimates initialized")
    end
    
    -- Initialize group tracking
    if self.util and self.util.group then
        self.util.group.Initialize()
    end
    
    -- Initialize networking
    if self.util and self.util.networking then
        self.util.networking.Initialize()
        -- Enable broadcasting by default
        self.util.networking.EnableBroadcasting()
    end
    
    -- Initialize UI
    if self.UI and self.UI.UltimateDisplay then
        self.UI.UltimateDisplay.Initialize()
    end
    
    -- Register for events
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, function()
        self:OnPlayerActivated()
    end)
    
    d(GetString(SI_BELTALOWDA_LOADED))
end

-- Called when player is activated
function Beltalowda:OnPlayerActivated()
    -- Player is now fully loaded and can interact with the world
    d(GetString(SI_BELTALOWDA_PLAYER_ACTIVATED))
end

-- Debug/Development Commands
-- These commands provide text-based output for debugging and development purposes
-- The main UI is accessed through the GUI windows (toggle with /bultui)
--
-- Command Naming: ESO addon best practice is to prefix commands with addon name
-- to avoid conflicts. We use "b" (Beltalowda) prefix: /bultimate, /bultui, /bbroadcast
-- This follows the pattern seen in popular addons and minimizes collision risk.

SLASH_COMMANDS["/bultimate"] = function(args)
    -- Debug command: Display ultimate tracking status in chat
    local playerName = GetUnitName("player")
    local playerPower = GetUnitPower("player", POWERTYPE_ULTIMATE)
    local playerPowerMax = GetUnitPowerMax("player", POWERTYPE_ULTIMATE)
    local playerPercent = 0
    if playerPowerMax > 0 then
        playerPercent = math.floor((playerPower / playerPowerMax) * 100)
    end
    
    d(string.format("|c00FF00Beltalowda Ultimate Tracking (Debug)|r"))
    d(string.format("Your Ultimate: %d%% (%d/%d)", playerPercent, playerPower, playerPowerMax))
    
    -- Display group members if in a group
    if IsUnitGrouped("player") then
        local groupPlayers = Beltalowda.util.group.GetAllPlayers()
        local readyCount = Beltalowda.util.group.GetReadyUltimatesCount()
        
        d(string.format("|c00FF00Group Ultimates:|r Ready: %d", readyCount))
        
        for characterName, data in pairs(groupPlayers) do
            local readyIndicator = data.ultimatePercent >= 100 and "|c00FF00[READY]|r" or ""
            d(string.format("  %s: %d%% %s", characterName, data.ultimatePercent or 0, readyIndicator))
        end
    else
        d("|cFFFF00Not in a group|r")
    end
end

SLASH_COMMANDS["/bultimateinfo"] = function(args)
    -- Debug command: Display information about tracked ultimates
    local ultimates = Beltalowda.util.ultimates.ultimates
    if ultimates then
        d(string.format("|c00FF00Beltalowda - Tracked Ultimates (%d total)|r", #ultimates))
        for i = 1, math.min(10, #ultimates) do
            local ult = ultimates[i]
            d(string.format("  %d. %s (Cost: %d)", i, ult.name, ult.cost or 0))
        end
        if #ultimates > 10 then
            d(string.format("  ... and %d more", #ultimates - 10))
        end
    else
        d("|cFF0000Ultimates not initialized|r")
    end
end

SLASH_COMMANDS["/bbroadcast"] = function(args)
    -- Debug command: Toggle ultimate broadcasting
    if args == "on" then
        if Beltalowda.util and Beltalowda.util.networking then
            Beltalowda.util.networking.EnableBroadcasting()
        end
    elseif args == "off" then
        if Beltalowda.util and Beltalowda.util.networking then
            Beltalowda.util.networking.DisableBroadcasting()
        end
    else
        d("|c00FF00Beltalowda Broadcasting (Debug)|r")
        d("Usage: /bbroadcast <on|off>")
        d("  on  - Enable ultimate broadcasting to group")
        d("  off - Disable ultimate broadcasting")
    end
end

SLASH_COMMANDS["/bultui"] = function(args)
    -- Toggle ultimate display UI
    if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
        if args == "blocks" then
            Beltalowda.UI.UltimateDisplay.TogglePlayerBlocks()
        elseif args == "client" then
            Beltalowda.UI.UltimateDisplay.ToggleClientUltimate()
        elseif args == "group" then
            Beltalowda.UI.UltimateDisplay.ToggleGroupUltimates()
        elseif args == "overview" then
            Beltalowda.UI.UltimateDisplay.ToggleUltimateOverview()
        else
            Beltalowda.UI.UltimateDisplay.ToggleDisplay()
        end
    else
        d("|cFF0000Ultimate Display not initialized|r")
    end
end

-- Register for addon loaded event
local function OnAddOnLoaded(event, addonName)
    if addonName == Beltalowda.name then
        Beltalowda:Initialize()
        EVENT_MANAGER:UnregisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED)
    end
end

EVENT_MANAGER:RegisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
