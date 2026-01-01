-- Beltalowda Data Collector
-- Central coordinator for all data collection modules

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.collector = Beltalowda.data.collector or {}

-- Create local alias
local DataCollector = Beltalowda.data.collector

-- Module state
DataCollector.state = {
    initialized = false,
    collectors = {}
}

--[[
    Initialize the data collector coordinator
]]--
function DataCollector.Initialize()
    if DataCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] DataCollector: Initializing coordinator")
    
    DataCollector.state.initialized = true
end

--[[
    Register a data collector module
    @param collectorName string - Name of the collector
    @param collectorModule table - The collector module with Initialize function
]]--
function DataCollector.RegisterCollector(collectorName, collectorModule)
    if not collectorModule or type(collectorModule.Initialize) ~= "function" then
        d("[Beltalowda] DataCollector: Invalid collector module: " .. tostring(collectorName))
        return false
    end
    
    DataCollector.state.collectors[collectorName] = collectorModule
    return true
end

--[[
    Get player data
    @param unitTag string - The unit tag (default: "player")
    @return table - Player data from all collectors
]]--
function DataCollector.GetPlayerData(unitTag)
    unitTag = unitTag or "player"
    
    local data = {
        unitTag = unitTag,
        timestamp = GetGameTimeMilliseconds()
    }
    
    -- Stub: Will be populated by collectors in future phases
    return data
end

--[[
    Get group data
    @return table - Data for all group members
]]--
function DataCollector.GetGroupData()
    local groupData = {}
    
    -- Stub: Will iterate through group members in future phases
    
    return groupData
end
