-- Beltalowda State Collector
-- Tracks player state and availability

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.state = Beltalowda.data.state or {}

-- Create local alias
local StateCollector = Beltalowda.data.state

-- Module state
StateCollector.state = {
    initialized = false,
    inCombat = false,
    isAlive = true,
    isOnline = true,
    isReloading = false,
    role = "DPS"  -- Default role
}

--[[
    Initialize the state collector
]]--
function StateCollector.Initialize()
    if StateCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] StateCollector: Initializing")
    
    -- Register with data collector coordinator
    if Beltalowda.data.collector then
        Beltalowda.data.collector.RegisterCollector("state", StateCollector)
    end
    
    -- Stub: Event registration will be added in Phase 1
    -- EVENT_PLAYER_COMBAT_STATE (combat state)
    -- EVENT_UNIT_DEATH_STATE_CHANGED (death/resurrection)
    -- EVENT_GROUP_MEMBER_CONNECTED_STATUS (online status)
    -- EVENT_ACTION_LAYER_PUSHED/POPPED (UI state)
    
    StateCollector.state.initialized = true
end

--[[
    Get current state data
    @return table - Current player state
]]--
function StateCollector.GetState()
    return {
        inCombat = StateCollector.state.inCombat,
        isAlive = StateCollector.state.isAlive,
        isOnline = StateCollector.state.isOnline,
        isReloading = StateCollector.state.isReloading,
        role = StateCollector.state.role
    }
end

--[[
    Check if player is in combat
    @return boolean - True if in combat
]]--
function StateCollector.IsInCombat()
    return StateCollector.state.inCombat
end

--[[
    Check if player is alive
    @return boolean - True if alive
]]--
function StateCollector.IsAlive()
    return StateCollector.state.isAlive
end
