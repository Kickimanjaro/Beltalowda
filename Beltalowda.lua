--[[
    Beltalowda - Group PvP Addon for Elder Scrolls Online
    Author: @Kickimanjaro
    Version: 1.0.0
]]--

Beltalowda = Beltalowda or {}
Beltalowda.name = "Beltalowda"
Beltalowda.version = "1.0.0"

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

-- Register for addon loaded event
local function OnAddOnLoaded(event, addonName)
    if addonName == Beltalowda.name then
        Beltalowda:Initialize()
        EVENT_MANAGER:UnregisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED)
    end
end

EVENT_MANAGER:RegisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
