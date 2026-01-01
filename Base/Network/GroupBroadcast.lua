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

-- Store registered library instances
BeltalowdaNetwork.lgcsInstance = nil
BeltalowdaNetwork.lsdInstance = nil

--[[
    Initialize the network layer
    - Subscribe to LibGroupCombatStats broadcasts
    - Subscribe to LibSetDetection broadcasts
    Returns: success (boolean)
]]--
function BeltalowdaNetwork.Initialize()
    -- Check if required libraries are available
    -- Note: These are now required dependencies in manifest, so this check is defensive
    if not LGB then
        d("[Beltalowda] ERROR: LibGroupBroadcast not available. Network features disabled.")
        return false
    end
    
    if not LGCS then
        d("[Beltalowda] ERROR: LibGroupCombatStats not available. This should not happen (required dependency).")
        return false
    else
        d("[Beltalowda] LibGroupCombatStats found - registering addon")
        BeltalowdaNetwork.SubscribeToUltimateData()
    end
    
    if not LSD then
        d("[Beltalowda] ERROR: LibSetDetection not available. This should not happen (required dependency).")
        return false
    else
        d("[Beltalowda] LibSetDetection found - registering addon")
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
    
    LibGroupCombatStats requires calling RegisterAddon first, then registering for events.
    We track ultimate ("ULT") data for all group members.
]]--
function BeltalowdaNetwork.SubscribeToUltimateData()
    if not LGCS then return end
    
    local success, err = pcall(function()
        -- Register our addon with LibGroupCombatStats
        -- RegisterAddon returns an instance object if successful
        BeltalowdaNetwork.lgcsInstance = LGCS.RegisterAddon("Beltalowda", {"ULT"})
        
        if not BeltalowdaNetwork.lgcsInstance then
            d("[Beltalowda] Warning: Failed to register with LibGroupCombatStats")
            return
        end
        
        -- Register for group ultimate update events
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LGCS.EVENT_GROUP_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LGCS.EVENT_GROUP_ULT_UPDATE, 
                function(unitTag, data)
                    BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                end)
            d("[Beltalowda] Registered for GROUP ultimate updates")
        else
            d("[Beltalowda] Warning: EVENT_GROUP_ULT_UPDATE not available")
        end
        
        -- Register for player ultimate update events
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LGCS.EVENT_PLAYER_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LGCS.EVENT_PLAYER_ULT_UPDATE, 
                function(unitTag, data)
                    BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                end)
            d("[Beltalowda] Registered for PLAYER ultimate updates")
        else
            d("[Beltalowda] Warning: EVENT_PLAYER_ULT_UPDATE not available")
        end
        
        d("[Beltalowda] Successfully registered with LibGroupCombatStats")
    end)
    
    if not success then
        d("[Beltalowda] Error registering with LibGroupCombatStats: " .. tostring(err))
    end
end

--[[
    Subscribe to LibSetDetection equipment broadcasts
    
    LibSetDetection requires calling RegisterAddon first, then we can query set data.
]]--
function BeltalowdaNetwork.SubscribeToEquipmentData()
    if not LSD then return end
    
    local success, err = pcall(function()
        -- Register our addon with LibSetDetection
        BeltalowdaNetwork.lsdInstance = LSD:RegisterAddon("Beltalowda")
        
        if not BeltalowdaNetwork.lsdInstance then
            d("[Beltalowda] Warning: Failed to register with LibSetDetection")
            return
        end
        
        d("[Beltalowda] Successfully registered with LibSetDetection")
        
        -- Note: LibSetDetection doesn't use callbacks for continuous updates
        -- We'll query set data on-demand when displaying equipment info
    end)
    
    if not success then
        d("[Beltalowda] Error registering with LibSetDetection: " .. tostring(err))
    end
end

--[[
    Handle ultimate data received from LibGroupCombatStats
    @param unitTag: Unit tag of the player (e.g., "group1", "player")
    @param data: Ultimate data from LGCS (contains ability ID, cost, current, max, etc.)
]]--
function BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
    -- Debug logging to verify event is firing
    d("[Beltalowda] Ultimate data received for " .. tostring(unitTag))
    
    if not data then 
        d("[Beltalowda] Warning: data is nil for " .. tostring(unitTag))
        return 
    end
    
    -- Debug log the data structure
    if type(data) == "table" then
        d("[Beltalowda] Data type: table")
        for k, v in pairs(data) do
            d(string.format("  %s = %s", tostring(k), tostring(v)))
        end
    else
        d("[Beltalowda] Data type: " .. type(data) .. ", value: " .. tostring(data))
    end
    
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[unitTag] = BeltalowdaNetwork.groupData[unitTag] or {}
    BeltalowdaNetwork.groupData[unitTag].ultimate = BeltalowdaNetwork.groupData[unitTag].ultimate or {}
    
    -- Store all ultimate data from LGCS
    local ult = BeltalowdaNetwork.groupData[unitTag].ultimate
    
    -- LGCS provides: abilityId, cost, current, max (values may vary based on library version)
    if data.abilityId then
        ult.abilityId = data.abilityId
    end
    if data.cost then
        ult.cost = data.cost
    end
    if data.current then
        ult.current = data.current
    end
    if data.max then
        ult.max = data.max
    end
    
    -- Calculate percentage
    if ult.max and ult.max > 0 and ult.current then
        ult.percent = (ult.current / ult.max) * 100
    else
        ult.percent = 0
    end
    
    -- Trigger callback for modules that need this data
    BeltalowdaNetwork.OnDataChanged("ultimate", unitTag)
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
                -- Safely get ability name with fallback
                local abilityName = "Unknown"
                if ult.abilityId then
                    local abilityNameResult = GetAbilityName(ult.abilityId)
                    if abilityNameResult and abilityNameResult ~= "" then
                        abilityName = abilityNameResult
                    end
                end
                d(string.format("  Ultimate: %s (ID: %s, cost: %d)", 
                    abilityName,
                    tostring(ult.abilityId or "?"), 
                    ult.cost or 0))
                d(string.format("  Value: %d/%d (%.1f%%)", 
                    ult.current or 0, 
                    ult.max or 0, 
                    ult.percent or 0))
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
        
        d(string.format("  [%d] %s (%s)", i, name, unitTag))
        d(string.format("      Data: %s | Ultimate: %s",
            hasData and "YES" or "NO",
            hasUlt and "YES" or "NO"))
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
            -- Safely get ability name with fallback
            local abilityName = "Unknown"
            if ult.abilityId then
                local name = GetAbilityName(ult.abilityId)
                if name and name ~= "" then
                    abilityName = name
                end
            end
            
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
    
    if not BeltalowdaNetwork.lsdInstance then
        d("LibSetDetection not registered - cannot retrieve equipment data")
        return
    end
    
    local foundData = false
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        
        -- Query equipment data from LibSetDetection with error protection
        local success, sets = pcall(function()
            return BeltalowdaNetwork.lsdInstance:GetSetsForGroupMember(unitTag)
        end)
        
        if not success then
            d(string.format("[%d] %s - Error retrieving equipment data", i, name))
        elseif sets and type(sets) == "table" then
            local hasData = false
            for k, v in pairs(sets) do
                hasData = true
                break
            end
            
            if hasData then
                foundData = true
                d(string.format("[%d] %s", i, name))
                
                -- Display set data: setId -> piece count
                for setId, pieces in pairs(sets) do
                    -- Safely get set name with fallback
                    local setName = "Unknown Set"
                    if type(setId) == "number" then
                        local itemSetName = GetItemSetName(setId)
                        if itemSetName and itemSetName ~= "" then
                            setName = itemSetName
                        else
                            setName = "Set #" .. setId
                        end
                    else
                        setName = tostring(setId)
                    end
                    d(string.format("    %s: %d pieces", setName, pieces))
                end
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
    elseif args == "debug" then
        d("=== Beltalowda Debug Info ===")
        d("")
        d("Registration Status:")
        d("  LGCS Instance: " .. tostring(BeltalowdaNetwork.lgcsInstance ~= nil))
        d("  LSD Instance: " .. tostring(BeltalowdaNetwork.lsdInstance ~= nil))
        d("")
        
        if LGCS then
            d("LibGroupCombatStats Events:")
            d("  EVENT_GROUP_ULT_UPDATE: " .. tostring(LGCS.EVENT_GROUP_ULT_UPDATE))
            d("  EVENT_PLAYER_ULT_UPDATE: " .. tostring(LGCS.EVENT_PLAYER_ULT_UPDATE))
            d("  RegisterAddon method: " .. tostring(type(LGCS.RegisterAddon) == "function"))
            
            if BeltalowdaNetwork.lgcsInstance then
                d("  Instance type: " .. type(BeltalowdaNetwork.lgcsInstance))
                d("  Instance.RegisterForEvent: " .. tostring(type(BeltalowdaNetwork.lgcsInstance.RegisterForEvent) == "function"))
            end
        end
        d("")
        
        d("Group Data Storage:")
        local count = 0
        for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
            count = count + 1
            d(string.format("  %s: %s", unitTag, data.ultimate and "Has Ultimate Data" or "No Ultimate Data"))
        end
        d("  Total entries: " .. count)
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
            d("  Has RegisterAddon: " .. tostring(type(LGCS.RegisterAddon) == "function"))
            d("  EVENT_GROUP_ULT_UPDATE: " .. tostring(LGCS.EVENT_GROUP_ULT_UPDATE))
            d("  EVENT_PLAYER_ULT_UPDATE: " .. tostring(LGCS.EVENT_PLAYER_ULT_UPDATE))
            
            -- Check for other possible API methods and events
            if type(LGCS) == "table" then
                d("  Type: table (object)")
                d("  Available methods:")
                for k, v in pairs(LGCS) do
                    if type(v) == "function" then
                        d("    " .. tostring(k))
                    elseif type(k) == "string" and k:match("^EVENT_") then
                        d("    " .. tostring(k) .. " = " .. tostring(v))
                    end
                end
            end
        end
        d("")
        d("LibSetDetection: " .. tostring(LSD ~= nil))
        if LSD then
            d("  Has RegisterAddon: " .. tostring(type(LSD.RegisterAddon) == "function"))
            if type(LSD) == "table" then
                d("  Type: table (object)")
                for k, v in pairs(LSD) do
                    if type(v) == "function" then
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
        d("  /btlwdata debug   - Show detailed debug info (registration, events, data)")
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
