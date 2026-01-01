-- Beltalowda Resource Collector
-- Tracks player resources (Health, Magicka, Stamina, Ultimate)

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.resources = Beltalowda.data.resources or {}

-- Create local alias
local ResourceCollector = Beltalowda.data.resources

-- Module state
ResourceCollector.state = {
    initialized = false,
    health = 0,
    maxHealth = 0,
    magicka = 0,
    maxMagicka = 0,
    stamina = 0,
    maxStamina = 0,
    ultimate = 0,
    maxUltimate = 0
}

--[[
    Initialize the resource collector
]]--
function ResourceCollector.Initialize()
    if ResourceCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] ResourceCollector: Initializing")
    
    -- Register with data collector coordinator
    if Beltalowda.data.collector then
        Beltalowda.data.collector.RegisterCollector("resources", ResourceCollector)
    end
    
    -- Stub: Event registration will be added in Phase 1
    -- EVENT_POWER_UPDATE
    -- EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED
    
    ResourceCollector.state.initialized = true
end

--[[
    Get current resource data
    @return table - Current resources
]]--
function ResourceCollector.GetResources()
    return {
        health = ResourceCollector.state.health,
        maxHealth = ResourceCollector.state.maxHealth,
        magicka = ResourceCollector.state.magicka,
        maxMagicka = ResourceCollector.state.maxMagicka,
        stamina = ResourceCollector.state.stamina,
        maxStamina = ResourceCollector.state.maxStamina,
        ultimate = ResourceCollector.state.ultimate,
        maxUltimate = ResourceCollector.state.maxUltimate
    }
end
