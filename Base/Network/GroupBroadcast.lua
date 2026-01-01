-- Beltalowda Group Broadcast
-- LibGroupBroadcast integration layer for subscribing to existing libraries
-- Phase 2: Integration with LibGroupCombatStats and LibSetDetection

Beltalowda = Beltalowda or {}
Beltalowda.network = Beltalowda.network or {}

local BeltalowdaNetwork = Beltalowda.network
local LGB = LibGroupBroadcast
local LGCS = LibGroupCombatStats
local LSD = LibSetDetection

-- Message IDs (reserved 220-229 for future custom protocols)
BeltalowdaNetwork.MESSAGE_IDS = {
    -- Reserved for future use (officially registered on LibGroupBroadcast wiki)
    -- CUSTOM_220 = 220,
    -- CUSTOM_221 = 221,
    -- ... through 229
}

-- External library message IDs (for reference only - subscriptions handled by libraries)
BeltalowdaNetwork.EXTERNAL_IDS = {
    -- LibGroupCombatStats
    ULTIMATE_TYPE = 20,    -- Ultimate ability ID + cost
    ULTIMATE_VALUE = 21,   -- Current ultimate points (0-500)
    DPS = 22,              -- Current DPS + overall damage
    HPS = 23,              -- Current HPS + overall heal
    
    -- LibSetDetection  
    EQUIPMENT = 40,        -- Equipped set pieces (all 14 slots)
}

-- Group data structure: stores data for all group members
-- Format: groupData[unitTag] = { ultimate = {...}, equipment = {...}, ... }
BeltalowdaNetwork.groupData = {}

--[[
    Initialize the network layer
    - Subscribe to LibGroupCombatStats broadcasts
    - Subscribe to LibSetDetection broadcasts
    Returns: success (boolean)
]]--
function BeltalowdaNetwork.Initialize()
    -- Check if required libraries are available
    if not LGB then
        d("[Beltalowda] LibGroupBroadcast not available. Network features disabled.")
        return false
    end
    
    if not LGCS then
        d("[Beltalowda] LibGroupCombatStats not available. Ultimate tracking limited.")
        -- Not fatal - continue with limited functionality
    else
        d("[Beltalowda] LibGroupCombatStats found - subscribing to ultimate data")
        BeltalowdaNetwork.SubscribeToUltimateData()
    end
    
    if not LSD then
        d("[Beltalowda] LibSetDetection not available. Equipment tracking disabled.")
        -- Not fatal - continue with limited functionality
    else
        d("[Beltalowda] LibSetDetection found - subscribing to equipment data")
        BeltalowdaNetwork.SubscribeToEquipmentData()
    end
    
    -- Register for group change events to clean up data
    EVENT_MANAGER:RegisterForEvent(
        "BeltalowdaNetwork_GroupUpdate", 
        EVENT_GROUP_MEMBER_LEFT, 
        BeltalowdaNetwork.OnGroupMemberLeft
    )
    
    d("[Beltalowda] Network layer initialized")
    return true
end

--[[
    Subscribe to LibGroupCombatStats ultimate broadcasts
    IDs 20-21: Ultimate Type and Value
    
    NOTE: This implementation assumes LibGroupCombatStats provides a callback-based API.
    The actual API may differ - this may need adjustment after consulting library source.
]]--
function BeltalowdaNetwork.SubscribeToUltimateData()
    if not LGCS then return end
    
    -- Attempt to register callbacks for ultimate data
    -- The API below is based on common LibGroupBroadcast library patterns
    -- If this fails, we'll need to consult the actual library documentation
    
    local success, err = pcall(function()
        -- Try to register callback for ultimate type changes (ID 20)
        if LGCS.RegisterCallback then
            LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_TYPE_CHANGED or "UltimateTypeChanged", 
                function(unitTag, abilityId, cost)
                    BeltalowdaNetwork.OnUltimateTypeReceived(unitTag, abilityId, cost)
                end)
            
            -- Try to register callback for ultimate value changes (ID 21)
            LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_VALUE_CHANGED or "UltimateValueChanged", 
                function(unitTag, current, max)
                    BeltalowdaNetwork.OnUltimateValueReceived(unitTag, current, max)
                end)
                
            d("[Beltalowda] Subscribed to LibGroupCombatStats ultimate data")
        else
            d("[Beltalowda] Warning: LibGroupCombatStats API differs from expected. Manual integration needed.")
        end
    end)
    
    if not success then
        d("[Beltalowda] Error subscribing to LibGroupCombatStats: " .. tostring(err))
        d("[Beltalowda] Ultimate tracking may require manual integration. See library documentation.")
    end
end

--[[
    Subscribe to LibSetDetection equipment broadcasts
    ID 40: Equipment sets
    
    NOTE: This implementation assumes LibSetDetection provides a callback-based API.
    The actual API may differ - this may need adjustment after consulting library source.
]]--
function BeltalowdaNetwork.SubscribeToEquipmentData()
    if not LSD then return end
    
    -- Attempt to register callback for equipment data
    local success, err = pcall(function()
        if LSD.RegisterCallback then
            LSD:RegisterCallback(LSD.EVENT_EQUIPPED_SETS_CHANGED or "EquippedSetsChanged", 
                function(unitTag, sets)
                    BeltalowdaNetwork.OnEquipmentReceived(unitTag, sets)
                end)
                
            d("[Beltalowda] Subscribed to LibSetDetection equipment data")
        else
            d("[Beltalowda] Warning: LibSetDetection API differs from expected. Manual integration needed.")
        end
    end)
    
    if not success then
        d("[Beltalowda] Error subscribing to LibSetDetection: " .. tostring(err))
        d("[Beltalowda] Equipment tracking may require manual integration. See library documentation.")
    end
end

--[[
    Handle ultimate type data received from LibGroupCombatStats
    @param unitTag: Unit tag of the player (e.g., "group1")
    @param abilityId: The ultimate ability ID
    @param cost: The ultimate cost
]]--
function BeltalowdaNetwork.OnUltimateTypeReceived(unitTag, abilityId, cost)
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[unitTag] = BeltalowdaNetwork.groupData[unitTag] or {}
    BeltalowdaNetwork.groupData[unitTag].ultimate = BeltalowdaNetwork.groupData[unitTag].ultimate or {}
    
    -- Store ultimate type data
    BeltalowdaNetwork.groupData[unitTag].ultimate.abilityId = abilityId
    BeltalowdaNetwork.groupData[unitTag].ultimate.cost = cost
    
    -- Trigger callback for modules that need this data
    BeltalowdaNetwork.OnDataChanged("ultimateType", unitTag)
end

--[[
    Handle ultimate value data received from LibGroupCombatStats
    @param unitTag: Unit tag of the player
    @param current: Current ultimate points
    @param max: Maximum ultimate points
]]--
function BeltalowdaNetwork.OnUltimateValueReceived(unitTag, current, max)
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[unitTag] = BeltalowdaNetwork.groupData[unitTag] or {}
    BeltalowdaNetwork.groupData[unitTag].ultimate = BeltalowdaNetwork.groupData[unitTag].ultimate or {}
    
    -- Store ultimate value data
    BeltalowdaNetwork.groupData[unitTag].ultimate.current = current
    BeltalowdaNetwork.groupData[unitTag].ultimate.max = max
    BeltalowdaNetwork.groupData[unitTag].ultimate.percent = (max > 0) and (current / max * 100) or 0
    
    -- Trigger callback for modules that need this data
    BeltalowdaNetwork.OnDataChanged("ultimateValue", unitTag)
end

--[[
    Handle equipment data received from LibSetDetection
    @param unitTag: Unit tag of the player
    @param sets: Table of equipped set data
]]--
function BeltalowdaNetwork.OnEquipmentReceived(unitTag, sets)
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[unitTag] = BeltalowdaNetwork.groupData[unitTag] or {}
    
    -- Store equipment data
    BeltalowdaNetwork.groupData[unitTag].equipment = sets
    
    -- Trigger callback for modules that need this data
    BeltalowdaNetwork.OnDataChanged("equipment", unitTag)
end

--[[
    Callback when data changes - can be extended for UI updates
    @param dataType: Type of data that changed ("ultimateType", "ultimateValue", "equipment")
    @param unitTag: Unit tag of the player whose data changed
]]--
function BeltalowdaNetwork.OnDataChanged(dataType, unitTag)
    -- Placeholder for future module integration
    -- Future modules can hook into this to update UI, etc.
    -- d("[Beltalowda] Data changed: " .. dataType .. " for " .. (GetUnitName(unitTag) or "unknown"))
end

--[[
    Handle group member leaving
    Clean up their data from our tracking
]]--
function BeltalowdaNetwork.OnGroupMemberLeft(eventCode, characterName, reason, wasLocalPlayer)
    -- Find and remove data for this player
    for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
        if GetUnitName(unitTag) == characterName then
            BeltalowdaNetwork.groupData[unitTag] = nil
            d("[Beltalowda] Removed data for " .. characterName)
            break
        end
    end
end

--[[
    Get group data for a specific player
    @param unitTag: Unit tag of the player (e.g., "group1", "player")
    @return: Data table or nil
]]--
function BeltalowdaNetwork.GetGroupData(unitTag)
    return BeltalowdaNetwork.groupData[unitTag]
end

--[[
    Get ultimate data for a specific player
    @param unitTag: Unit tag of the player
    @return: Ultimate data table or nil
]]--
function BeltalowdaNetwork.GetUltimateData(unitTag)
    local data = BeltalowdaNetwork.groupData[unitTag]
    return data and data.ultimate
end

--[[
    Get equipment data for a specific player
    @param unitTag: Unit tag of the player
    @return: Equipment data table or nil
]]--
function BeltalowdaNetwork.GetEquipmentData(unitTag)
    local data = BeltalowdaNetwork.groupData[unitTag]
    return data and data.equipment
end

--[[
    Get all group data
    @return: Full groupData table
]]--
function BeltalowdaNetwork.GetAllGroupData()
    return BeltalowdaNetwork.groupData
end

--[[
    Debug: Print group data to chat
]]--
function BeltalowdaNetwork.DebugPrintGroupData()
    d("=== Beltalowda Group Data ===")
    
    local groupSize = GetGroupSize()
    if groupSize == 0 then
        d("Not in a group")
        return
    end
    
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        local data = BeltalowdaNetwork.groupData[unitTag]
        
        d("--- " .. name .. " (" .. unitTag .. ") ---")
        
        if data then
            if data.ultimate then
                local ult = data.ultimate
                d(string.format("  Ultimate: %s (%d cost)", 
                    ult.abilityId or "Unknown", 
                    ult.cost or 0))
                d(string.format("  Value: %d/%d (%.1f%%)", 
                    ult.current or 0, 
                    ult.max or 0, 
                    ult.percent or 0))
            end
            
            if data.equipment then
                d("  Equipment: " .. tostring(#data.equipment or 0) .. " sets tracked")
            end
        else
            d("  No data available")
        end
    end
end

-- Debug slash commands
SLASH_COMMANDS["/btlwdata"] = function(args)
    if args == "group" then
        BeltalowdaNetwork.DebugPrintGroupData()
    elseif args == "ults" then
        d("=== Group Ultimates ===")
        for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
            if data.ultimate then
                local ult = data.ultimate
                d(string.format("%s: %d/%d (%.1f%%) - Ability %s", 
                    GetUnitName(unitTag), 
                    ult.current or 0, 
                    ult.max or 0, 
                    ult.percent or 0,
                    ult.abilityId or "Unknown"))
            end
        end
    elseif args == "equip" then
        d("=== Group Equipment ===")
        for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
            if data.equipment then
                d(GetUnitName(unitTag) .. ": " .. tostring(#data.equipment or 0) .. " sets")
            end
        end
    elseif args == "libapi" then
        d("=== Library API Status ===")
        d("LibGroupCombatStats: " .. tostring(LGCS ~= nil))
        if LGCS then
            d("  Has RegisterCallback: " .. tostring(LGCS.RegisterCallback ~= nil))
            d("  EVENT_ULTIMATE_TYPE_CHANGED: " .. tostring(LGCS.EVENT_ULTIMATE_TYPE_CHANGED))
            d("  EVENT_ULTIMATE_VALUE_CHANGED: " .. tostring(LGCS.EVENT_ULTIMATE_VALUE_CHANGED))
        end
        d("LibSetDetection: " .. tostring(LSD ~= nil))
        if LSD then
            d("  Has RegisterCallback: " .. tostring(LSD.RegisterCallback ~= nil))
            d("  EVENT_EQUIPPED_SETS_CHANGED: " .. tostring(LSD.EVENT_EQUIPPED_SETS_CHANGED))
        end
    else
        d("Beltalowda Data Commands:")
        d("  /btlwdata group - Show all group data")
        d("  /btlwdata ults - Show group ultimates")
        d("  /btlwdata equip - Show group equipment")
        d("  /btlwdata libapi - Show library API status")
    end
end
