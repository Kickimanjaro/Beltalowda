-- Beltalowda Group Broadcast
-- Network layer for LibGroupBroadcast integration

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.network = Beltalowda.network or {}

-- Create local alias
local GroupBroadcast = Beltalowda.network

-- Module state
GroupBroadcast.state = {
    initialized = false,
    groupData = {}  -- Data received from other group members
}

-- Message ID constants (Reserved IDs: 220-229)
-- See docs/DEVELOPMENT_ROADMAP.md for full allocation details
GroupBroadcast.MESSAGE_IDS = {
    RESOURCES = 220,        -- Resource packet (Health, Magicka, Stamina, Ultimate %)
    ULTIMATE = 221,         -- Ultimate details (ability ID, cost, ready status)
    POSITION = 222,         -- Position packet (X, Y, Zone)
    ABILITIES = 223,        -- Ability bar packet (10 ability IDs)
    EQUIPMENT_1 = 224,      -- Equipment packet (set IDs, part 1)
    EQUIPMENT_2 = 225,      -- Equipment packet (set IDs, part 2)
    STATE = 226,            -- State packet (combat, alive, online status)
    EFFECTS = 227,          -- Active effects (critical buffs/debuffs)
    RESERVED_1 = 228,       -- Reserved for future features
    RESERVED_2 = 229        -- Reserved for future features
}

--[[
    Initialize the network layer
]]--
function GroupBroadcast.Initialize()
    if GroupBroadcast.state.initialized then
        return
    end
    
    d("[Beltalowda] GroupBroadcast: Initializing network layer")
    
    -- Stub: LibGroupBroadcast integration will be added in Phase 2
    -- This will include:
    -- - Message handler registration
    -- - Encode/decode functions
    -- - Send/receive infrastructure
    -- - Group data structure management
    
    GroupBroadcast.state.initialized = true
end

--[[
    Send resource data to group
    @param resources table - Resource data to broadcast
]]--
function GroupBroadcast.SendResources(resources)
    -- Stub: Will encode and send resources in Phase 2
end

--[[
    Send position data to group
    @param position table - Position data to broadcast
]]--
function GroupBroadcast.SendPosition(position)
    -- Stub: Will encode and send position in Phase 5
end

--[[
    Send equipment data to group
    @param equipment table - Equipment data to broadcast
]]--
function GroupBroadcast.SendEquipment(equipment)
    -- Stub: Will encode and send equipment in Phase 4
end

--[[
    Send state data to group
    @param state table - State data to broadcast
]]--
function GroupBroadcast.SendState(state)
    -- Stub: Will encode and send state in Phase 2
end

--[[
    Get group data
    @return table - Data from all group members
]]--
function GroupBroadcast.GetGroupData()
    return GroupBroadcast.state.groupData
end

--[[
    Get data for a specific unit
    @param unitTag string - The unit tag
    @return table - Data for the specified unit
]]--
function GroupBroadcast.GetUnitData(unitTag)
    return GroupBroadcast.state.groupData[unitTag]
end
