-- Beltalowda - Group PvP Coordination Addon
-- Main initialization file

-- Initialize main namespace
Beltalowda = Beltalowda or {}

-- Version information
Beltalowda.name = "Beltalowda"
Beltalowda.version = "0.1.0"
Beltalowda.author = "Kickimanjaro"

-- Local reference
local Beltalowda = Beltalowda

--[[
    Check if required libraries are loaded
    Returns: loaded (boolean), missingLibs (table of strings)
]]--
function Beltalowda.AreLibrariesLoaded()
    local loaded = true
    local missingLibs = {}
    if not LibAsync then
        loaded = false
        table.insert(missingLibs, "LibAsync")
    end
    if not LibGroupBroadcast then
        loaded = false
        table.insert(missingLibs, "LibGroupBroadcast")
    end
    if not LibAddonMenu2 then
        loaded = false
        table.insert(missingLibs, "LibAddonMenu2")
    end
    if not LibSetDetection then
        loaded = false
        table.insert(missingLibs, "LibSetDetection")
    end
    return loaded, missingLibs
end

--[[
    Initialize all addon modules
]]--
function Beltalowda.Initialize()
    -- Check library dependencies
    local libsLoaded, missingLibs = Beltalowda.AreLibrariesLoaded()
    
    if not libsLoaded then
        d("[Beltalowda] ERROR! Missing required libraries:")
        for _, libName in ipairs(missingLibs) do
            d("  - " .. libName)
        end
        d("[Beltalowda] Addon will not function properly.")
        return false
    end
    
    d("[Beltalowda] " .. Beltalowda.version .. " loaded successfully")
    
    -- Initialize data collection layer
    if Beltalowda.data then
        if Beltalowda.data.collector and Beltalowda.data.collector.Initialize then
            Beltalowda.data.collector.Initialize()
        end
        if Beltalowda.data.resources and Beltalowda.data.resources.Initialize then
            Beltalowda.data.resources.Initialize()
        end
        if Beltalowda.data.position and Beltalowda.data.position.Initialize then
            Beltalowda.data.position.Initialize()
        end
        if Beltalowda.data.abilities and Beltalowda.data.abilities.Initialize then
            Beltalowda.data.abilities.Initialize()
        end
        if Beltalowda.data.equipment and Beltalowda.data.equipment.Initialize then
            Beltalowda.data.equipment.Initialize()
        end
        if Beltalowda.data.state and Beltalowda.data.state.Initialize then
            Beltalowda.data.state.Initialize()
        end
    end
    
    -- Initialize network layer
    if Beltalowda.network and Beltalowda.network.Initialize then
        Beltalowda.network.Initialize()
    end
    
    d("[Beltalowda] All modules initialized")
    
    return true
end

--[[
    Event handler for addon loaded
]]--
function Beltalowda.OnAddOnLoaded(eventCode, addonName)
    if addonName ~= Beltalowda.name then
        return
    end
    
    -- Unregister this event - only need to load once
    EVENT_MANAGER:UnregisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED)
    
    -- Initialize SavedVariables
    BeltalowdaVars = BeltalowdaVars or {}
    BeltalowdaVars.version = BeltalowdaVars.version or Beltalowda.version
    
    -- Initialize the addon
    Beltalowda.Initialize()
end

--[[
    Event handler for player activated (entering world)
]]--
function Beltalowda.OnPlayerActivated(eventCode, initial)
    -- This fires when the player enters the world
    -- Used for initializing features that require the player to be fully loaded
    d("[Beltalowda] Player activated (initial: " .. tostring(initial) .. ")")
end

-- Register for addon loaded event
EVENT_MANAGER:RegisterForEvent(Beltalowda.name, EVENT_ADD_ON_LOADED, Beltalowda.OnAddOnLoaded)

-- Register for player activated event
EVENT_MANAGER:RegisterForEvent(Beltalowda.name, EVENT_PLAYER_ACTIVATED, Beltalowda.OnPlayerActivated)
