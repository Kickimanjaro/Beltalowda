-- Beltalowda Position Collector
-- Tracks player position for group coordination

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.position = Beltalowda.data.position or {}

-- Create local alias
local PositionCollector = Beltalowda.data.position

-- Module state
PositionCollector.state = {
    initialized = false,
    x = 0,
    y = 0,
    zoneId = 0
}

--[[
    Initialize the position collector
]]--
function PositionCollector.Initialize()
    if PositionCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] PositionCollector: Initializing")
    
    -- Register with data collector coordinator
    if Beltalowda.data.collector then
        Beltalowda.data.collector.RegisterCollector("position", PositionCollector)
    end
    
    -- Stub: Event registration and LibGPS integration will be added in Phase 5
    -- EVENT_PLAYER_ACTIVATED (zone changes)
    -- Periodic updates (100ms for smooth position tracking)
    
    PositionCollector.state.initialized = true
end

--[[
    Get current position data
    @return table - Current position
]]--
function PositionCollector.GetPosition()
    return {
        x = PositionCollector.state.x,
        y = PositionCollector.state.y,
        zoneId = PositionCollector.state.zoneId
    }
end
