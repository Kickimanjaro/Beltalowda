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
                local equipCount = (type(data.equipment) == "table") and #data.equipment or 0
                d("  Equipment: " .. tostring(equipCount) .. " sets tracked")
            end
        else
            d("  No data available")
        end
    end
end

--[[
    Debug command: Display group member count and status
]]--
function BeltalowdaNetwork.DebugGroupStatus()
    local groupSize = GetGroupSize()
    
    d("=== Beltalowda Group Status ===")
    d("Group Size: " .. groupSize)
    
    if groupSize == 0 then
        d("Not in a group. Form a group to test network functionality.")
        d("Tip: Both you and group members need LibGroupCombatStats and LibSetDetection installed")
        return
    end
    
    d("Group Members:")
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        local hasData = BeltalowdaNetwork.groupData[unitTag] ~= nil
        local hasUlt = hasData and BeltalowdaNetwork.groupData[unitTag].ultimate ~= nil
        local hasEquip = hasData and BeltalowdaNetwork.groupData[unitTag].equipment ~= nil
        
        d(string.format("  [%d] %s (%s)", i, name, unitTag))
        d(string.format("      Data: %s | Ultimate: %s | Equipment: %s",
            hasData and "YES" or "NO",
            hasUlt and "YES" or "NO",
            hasEquip and "YES" or "NO"))
    end
    
    d("")
    d("Tip: Use '/btlwdata ults' to see ultimate details")
    d("Tip: Use '/btlwdata equip' to see equipment details")
end

--[[
    Debug command: Display detailed ultimate information
]]--
function BeltalowdaNetwork.DebugUltimateData()
    d("=== Group Ultimate Details ===")
    
    local groupSize = GetGroupSize()
    if groupSize == 0 then
        d("Not in a group")
        return
    end
    
    local foundData = false
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        local data = BeltalowdaNetwork.groupData[unitTag]
        
        if data and data.ultimate then
            foundData = true
            local ult = data.ultimate
            local abilityName = ult.abilityId and GetAbilityName(ult.abilityId) or "Unknown"
            
            d(string.format("[%d] %s", i, name))
            d(string.format("    Ability: %s (ID: %s)", 
                abilityName, 
                tostring(ult.abilityId or "?")))
            d(string.format("    Cost: %d", ult.cost or 0))
            d(string.format("    Current: %d / %d (%.1f%%)", 
                ult.current or 0, 
                ult.max or 0, 
                ult.percent or 0))
            
            -- Show ready status
            if ult.percent and ult.percent >= 100 then
                d("    Status: READY!")
            elseif ult.percent and ult.percent >= 75 then
                d("    Status: Almost ready")
            else
                d("    Status: Building...")
            end
        end
    end
    
    if not foundData then
        d("No ultimate data received yet")
        d("Note: Requires LibGroupCombatStats installed on all group members")
        d("Try using an ability or waiting for combat to trigger data sync")
    end
end

--[[
    Debug command: Display detailed equipment information
]]--
function BeltalowdaNetwork.DebugEquipmentData()
    d("=== Group Equipment Details ===")
    
    local groupSize = GetGroupSize()
    if groupSize == 0 then
        d("Not in a group")
        return
    end
    
    local foundData = false
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        local data = BeltalowdaNetwork.groupData[unitTag]
        
        if data and data.equipment then
            foundData = true
            d(string.format("[%d] %s", i, name))
            
            -- Display equipment data based on its structure
            -- Note: The actual structure depends on LibSetDetection's API
            if type(data.equipment) == "table" then
                -- Count and display in a single iteration
                local count = 0
                local displayLines = {}
                for k, v in pairs(data.equipment) do
                    count = count + 1
                    if type(v) == "table" then
                        table.insert(displayLines, string.format("    Set: %s", tostring(k)))
                    else
                        table.insert(displayLines, string.format("    %s: %s", tostring(k), tostring(v)))
                    end
                end
                
                d(string.format("    Equipment entries: %d", count))
                for _, line in ipairs(displayLines) do
                    d(line)
                end
            else
                d(string.format("    Equipment data: %s", tostring(data.equipment)))
            end
        end
    end
    
    if not foundData then
        d("No equipment data received yet")
        d("Note: Requires LibSetDetection installed on all group members")
        d("Try changing equipment to trigger data sync")
    end
end

-- Debug slash commands
SLASH_COMMANDS["/btlwdata"] = function(args)
    if args == "status" then
        BeltalowdaNetwork.DebugGroupStatus()
    elseif args == "group" then
        BeltalowdaNetwork.DebugPrintGroupData()
    elseif args == "ults" then
        BeltalowdaNetwork.DebugUltimateData()
    elseif args == "equip" then
        BeltalowdaNetwork.DebugEquipmentData()
    elseif args == "libapi" then
        d("=== Library API Status ===")
        d("LibGroupBroadcast: " .. tostring(LGB ~= nil))
        if LGB then
            d("  Loaded and available")
            -- Try to check for common API methods
            if type(LGB) == "table" then
                d("  Type: table (object)")
                d("  Has Send method: " .. tostring(type(LGB.Send) == "function"))
                d("  Has RegisterForMessage method: " .. tostring(type(LGB.RegisterForMessage) == "function"))
            end
        end
        d("")
        d("LibGroupCombatStats: " .. tostring(LGCS ~= nil))
        if LGCS then
            d("  Has RegisterCallback: " .. tostring(type(LGCS.RegisterCallback) == "function"))
            d("  EVENT_ULTIMATE_TYPE_CHANGED: " .. tostring(LGCS.EVENT_ULTIMATE_TYPE_CHANGED or "nil"))
            d("  EVENT_ULTIMATE_VALUE_CHANGED: " .. tostring(LGCS.EVENT_ULTIMATE_VALUE_CHANGED or "nil"))
            -- Check for other possible API methods
            if type(LGCS) == "table" then
                d("  Type: table (object)")
                for k, v in pairs(LGCS) do
                    if type(v) == "function" and k ~= "RegisterCallback" then
                        d("  Has method: " .. tostring(k))
                    end
                end
            end
        end
        d("")
        d("LibSetDetection: " .. tostring(LSD ~= nil))
        if LSD then
            d("  Has RegisterCallback: " .. tostring(type(LSD.RegisterCallback) == "function"))
            d("  EVENT_EQUIPPED_SETS_CHANGED: " .. tostring(LSD.EVENT_EQUIPPED_SETS_CHANGED or "nil"))
            if type(LSD) == "table" then
                d("  Type: table (object)")
                for k, v in pairs(LSD) do
                    if type(v) == "function" and k ~= "RegisterCallback" then
                        d("  Has method: " .. tostring(k))
                    end
                end
            end
        end
        d("")
        d("Note: If libraries show 'nil', they are not installed")
        d("Install from ESOUI.com to enable full functionality")
    elseif args == "help" or args == "" or args == nil then
        d("=== Beltalowda Network Foundation Test Commands ===")
        d("")
        d("Basic Commands:")
        d("  /btlwdata status  - Show group status and data availability")
        d("  /btlwdata group   - Show all group member data (detailed)")
        d("  /btlwdata ults    - Show ultimate data for all group members")
        d("  /btlwdata equip   - Show equipment data for all group members")
        d("")
        d("Diagnostic Commands:")
        d("  /btlwdata libapi  - Check library API availability")
        d("  /btlwdata help    - Show this help message")
        d("")
        d("Testing Tips:")
        d("  1. Form a group with at least one other player")
        d("  2. Ensure all members have LibGroupCombatStats installed")
        d("  3. Ensure all members have LibSetDetection installed")
        d("  4. Use abilities to trigger ultimate data updates")
        d("  5. Change equipment to trigger equipment data updates")
        d("")
        d("Troubleshooting:")
        d("  - If no data shows: Check '/btlwdata libapi'")
        d("  - If libraries missing: Install from ESOUI.com")
        d("  - If data not syncing: Ensure group members have libraries")
    else
        d("Unknown command: " .. tostring(args))
        d("Type '/btlwdata help' for available commands")
    end
end
