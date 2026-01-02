-- Beltalowda Group Broadcast
-- LibGroupBroadcast integration layer for subscribing to existing libraries
-- Phase 2: Integration with LibGroupCombatStats and LibSetDetection

Beltalowda = Beltalowda or {}
Beltalowda.network = Beltalowda.network or {}

local BeltalowdaNetwork = Beltalowda.network
local LGB = LibGroupBroadcast
local LGCS = LibGroupCombatStats
local LSD = LibSetDetection

-- Create logger instance for Network module
local logger = nil

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
    -- Initialize logger if not already done
    if not logger and Beltalowda.Logger and Beltalowda.Logger.CreateModuleLogger then
        logger = Beltalowda.Logger.CreateModuleLogger("Network")
    end
    
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
        if logger then
            logger:Info("LibGroupCombatStats found - registering addon")
        end
        BeltalowdaNetwork.SubscribeToUltimateData()
    end
    
    if not LSD then
        d("[Beltalowda] ERROR: LibSetDetection not available. This should not happen (required dependency).")
        return false
    else
        if logger then
            logger:Info("LibSetDetection found - registering addon")
        end
        BeltalowdaNetwork.SubscribeToEquipmentData()
    end
    
    -- Register for group change events to clean up data
    EVENT_MANAGER:RegisterForEvent(
        "BeltalowdaNetwork_GroupUpdate", 
        EVENT_GROUP_MEMBER_LEFT, 
        BeltalowdaNetwork.OnGroupMemberLeft
    )
    
    if logger then
        logger:Info("Network layer initialized")
    end
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
        
        -- LibGroupCombatStats events use callback signature: function(eventId, unitTag, data)
        -- The first parameter is the event ID constant, second is unitTag, third is data
        
        -- Register for player ultimate updates
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LGCS.EVENT_PLAYER_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LGCS.EVENT_PLAYER_ULT_UPDATE, 
                function(eventId, unitTag, data)
                    BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                end)
            d("[Beltalowda] Registered for PLAYER ultimate updates (EVENT_PLAYER_ULT_UPDATE)")
        end
        
        -- Register for group ultimate updates
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LGCS.EVENT_GROUP_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LGCS.EVENT_GROUP_ULT_UPDATE, 
                function(eventId, unitTag, data)
                    BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                end)
            d("[Beltalowda] Registered for GROUP ultimate updates (EVENT_GROUP_ULT_UPDATE)")
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
    Handle combined ultimate data (main handler)
    @param unitTag: Unit tag of the player (e.g., "group1", "player")
    @param data: Ultimate data table from LGCS
]]--
function BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
    if not data or type(data) ~= "table" then 
        return 
    end
    
    if logger then
        logger:Debug("Ultimate type received", unitTag, "id=" .. tostring(data.id), "cost=" .. tostring(data.cost), "value=" .. tostring(data.value), "max=" .. tostring(data.max))
    end
    
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[unitTag] = BeltalowdaNetwork.groupData[unitTag] or {}
    BeltalowdaNetwork.groupData[unitTag].ultimate = BeltalowdaNetwork.groupData[unitTag].ultimate or {}
    
    -- Store all ultimate data from LGCS
    local ult = BeltalowdaNetwork.groupData[unitTag].ultimate
    
    -- LGCS sends data with fields: id, cost, value, max
    -- Store original fields first
    if data.id then ult.id = data.id end
    if data.cost then ult.cost = data.cost end
    if data.value then ult.value = data.value end
    if data.max then ult.max = data.max end
    
    -- Normalize field names for consistent access
    -- LGCS uses "id" for abilityId and "value" for current
    if data.id then
        ult.abilityId = data.id
    end
    if data.value then
        ult.current = data.value
    end
    
    -- Calculate percentage if we have the right fields
    if data.max and data.max > 0 and data.value then
        ult.percent = (data.value / data.max) * 100
    else
        ult.percent = 0
    end
    
    if logger then
        logger:Verbose("Stored ultimate data under key", unitTag)
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
    
    -- Debug: Show all keys in groupData
    d("DEBUG: Keys stored in groupData:")
    local keyCount = 0
    for key, value in pairs(BeltalowdaNetwork.groupData) do
        keyCount = keyCount + 1
        d(string.format("  Key: '%s' (type: %s), hasUltimate: %s", 
            tostring(key), type(key), (value.ultimate ~= nil) and "YES" or "NO"))
    end
    d(string.format("Total keys in groupData: %d", keyCount))
    
    if groupSize == 0 then
        d("Not in a group. Form a group to test network functionality.")
        d("Tip: Both you and group members need LibGroupCombatStats and LibSetDetection installed")
        return
    end
    
    d("Group Members:")
    for i = 1, groupSize do
        local unitTag = GetGroupUnitTagByIndex(i)
        local name = GetUnitName(unitTag)
        local data = BeltalowdaNetwork.groupData[unitTag]
        
        -- Format ultimate status
        local ultStatus = "NO"
        local equipStatus = "NO"
        
        if data then
            if data.ultimate and (data.ultimate.abilityId or data.ultimate.id) then
                local ult = data.ultimate
                local current = ult.current or ult.value or 0
                local max = ult.max or 0
                local percent = ult.percent or 0
                
                -- Get ability name safely
                local abilityName = "Unknown"
                local abilityId = ult.abilityId or ult.id
                if abilityId then
                    local abilityNameResult = GetAbilityName(abilityId)
                    if abilityNameResult and abilityNameResult ~= "" then
                        abilityName = abilityNameResult
                    end
                end
                
                ultStatus = string.format("%s (%.0f%%)", abilityName, percent)
            end
            
            -- Query equipment data from LibSetDetection
            if BeltalowdaNetwork.lsdInstance then
                local success, sets = pcall(function()
                    return BeltalowdaNetwork.lsdInstance:GetSetsForGroupMember(unitTag)
                end)
                
                if success and sets and type(sets) == "table" then
                    local setCount = 0
                    for _ in pairs(sets) do
                        setCount = setCount + 1
                    end
                    if setCount > 0 then
                        equipStatus = string.format("%d sets", setCount)
                    end
                end
            end
        end
        
        d(string.format("[%d] %s (%s)", i, name, unitTag))
        d(string.format("    Data: %s  Ultimate: %s  Equipment: %s",
            data and "YES" or "NO",
            ultStatus,
            equipStatus))
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
    
    local foundData = false
    
    -- Iterate through all stored data (includes "player" and all group members)
    for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
        -- Check if we have any data at all for this unit
        if data then
            foundData = true
            local name = GetUnitName(unitTag) or "Unknown"
            
            d(string.format("[%s] %s", unitTag, name))
            
            -- Debug: Show what's in data.ultimate (only at DEBUG level or higher)
            if logger and Beltalowda.Logger.GetModuleLevel("Network") >= Beltalowda.Logger.Levels.DEBUG then
                if data.ultimate then
                    logger:Debug("ultimate table exists", "id=" .. tostring(data.ultimate.id), "abilityId=" .. tostring(data.ultimate.abilityId),
                        "value=" .. tostring(data.ultimate.value), "current=" .. tostring(data.ultimate.current),
                        "max=" .. tostring(data.ultimate.max), "cost=" .. tostring(data.ultimate.cost))
                else
                    logger:Debug("data.ultimate is nil")
                end
            end
            
            -- Check if we have ultimate data with actual values
            if data.ultimate and (data.ultimate.abilityId or data.ultimate.id or data.ultimate.current or data.ultimate.value or data.ultimate.max) then
                local ult = data.ultimate
                
                -- Safely get ability name with fallback
                local abilityName = "Unknown"
                local abilityId = ult.abilityId or ult.id
                if abilityId then
                    local abilityNameResult = GetAbilityName(abilityId)
                    if abilityNameResult and abilityNameResult ~= "" then
                        abilityName = abilityNameResult
                    end
                end
                
                local current = ult.current or ult.value or 0
                local max = ult.max or 0
                local percent = ult.percent or 0
                
                d(string.format("    Ability: %s (ID: %s)", 
                    abilityName, 
                    tostring(abilityId or "?")))
                d(string.format("    Cost: %d", ult.cost or 0))
                d(string.format("    Current: %d / %d (%.1f%%)", 
                    current, 
                    max, 
                    percent))
                
                -- Show ready status
                if percent >= 100 then
                    d("    Status: READY!")
                elseif percent >= 75 then
                    d("    Status: Almost ready")
                else
                    d("    Status: Building...")
                end
            else
                d("    Ultimate: No data yet (waiting for combat activity)")
            end
        end
    end
    
    if not foundData then
        d("No group members tracked yet")
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
    -- Parse command and arguments
    local cmd, arg1, arg2 = string.match(args, "^(%S+)%s*(%S*)%s*(%S*)$")
    if not cmd then
        cmd = args
    end
    
    if cmd == "status" then
        BeltalowdaNetwork.DebugGroupStatus()
    elseif cmd == "group" then
        BeltalowdaNetwork.DebugPrintGroupData()
    elseif cmd == "ults" then
        BeltalowdaNetwork.DebugUltimateData()
    elseif cmd == "equip" then
        BeltalowdaNetwork.DebugEquipmentData()
    elseif cmd == "raw" then
        d("=== Raw Group Data Dump ===")
        d("")
        
        local groupSize = GetGroupSize()
        if groupSize == 0 then
            d("Not in a group")
            return
        end
        
        d("Group Size: " .. groupSize)
        d("")
        
        for i = 1, groupSize do
            local unitTag = GetGroupUnitTagByIndex(i)
            local name = GetUnitName(unitTag)
            local data = BeltalowdaNetwork.groupData[unitTag]
            
            d(string.format("[%d] unitTag=%s, name=%s", i, unitTag, name))
            
            if data then
                d("  Has data entry: YES")
                if data.ultimate then
                    d("  Ultimate data:")
                    for k, v in pairs(data.ultimate) do
                        d(string.format("    %s = %s", tostring(k), tostring(v)))
                    end
                else
                    d("  Ultimate data: NONE")
                end
            else
                d("  Has data entry: NO")
                d("  This means no events have been received for this unit")
            end
            d("")
        end
        
        d("All stored unitTags:")
        for unitTag, _ in pairs(BeltalowdaNetwork.groupData) do
            d("  " .. unitTag)
        end
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
    elseif cmd == "debug" and arg1 ~= "" then
        -- /btlwdata debug <module> <level>
        -- /btlwdata debug all <level>
        if not Beltalowda.Logger then
            d("[Beltalowda] Logger system not initialized")
            return
        end
        
        local moduleName = arg1
        local levelName = arg2
        
        if levelName == "" then
            d("[Beltalowda] Usage: /btlwdata debug <module> <level>")
            d("  Example: /btlwdata debug Network DEBUG")
            d("  Modules: Network, Ultimates, Equipment, General, all")
            d("  Levels: ERROR, WARN, INFO, DEBUG, VERBOSE")
            return
        end
        
        local level = Beltalowda.Logger.ParseLevel(levelName)
        if not level then
            d("[Beltalowda] Invalid level: " .. levelName)
            d("  Valid levels: ERROR, WARN, INFO, DEBUG, VERBOSE")
            return
        end
        
        Beltalowda.Logger.SetModuleLevel(moduleName, level)
        if moduleName == "all" then
            d(string.format("[Beltalowda] Set all modules to %s", levelName))
        else
            d(string.format("[Beltalowda] Set %s to %s", moduleName, levelName))
        end
    elseif cmd == "log" then
        -- /btlwdata log show [module] [count]
        -- /btlwdata log clear
        -- /btlwdata log levels
        -- /btlwdata log export
        if not Beltalowda.Logger then
            d("[Beltalowda] Logger system not initialized")
            return
        end
        
        if arg1 == "show" then
            local moduleName = arg2 ~= "" and arg2 or nil
            local count = 20  -- Default to last 20 entries
            
            local entries = Beltalowda.Logger.GetSessionLog(moduleName, count)
            
            if #entries == 0 then
                d("[Beltalowda] No log entries found")
                return
            end
            
            d("=== Beltalowda Session Log ===")
            if moduleName then
                d("Module: " .. moduleName)
            end
            d(string.format("Showing last %d entries:", #entries))
            d("")
            
            for i = #entries, 1, -1 do
                local entry = entries[i]
                local timestamp = Beltalowda.Logger.FormatTimestamp(entry.timestamp)
                d(string.format("[%s] %s", timestamp, entry.message))
            end
        elseif arg1 == "clear" then
            Beltalowda.Logger.ClearSessionLog()
            d("[Beltalowda] Session log cleared")
        elseif arg1 == "levels" then
            d("=== Current Debug Levels ===")
            for module, config in pairs(Beltalowda.Logger.moduleConfig) do
                local levelName = Beltalowda.Logger.LevelNames[config.level] or "UNKNOWN"
                d(string.format("  %s: %s", module, levelName))
            end
            d("")
            d("Max log entries: " .. tostring(Beltalowda.Logger.maxLogEntries))
            d("VERBOSE reset on reload: " .. (Beltalowda.Logger.verboseModeResetOnReload and "ON" or "OFF"))
        elseif arg1 == "export" then
            if Beltalowda.Logger.hasLibDebugLogger then
                d("[Beltalowda] LibDebugLogger is installed")
                d("Logs are stored in LibDebugLogger's own storage")
                d("Use LibDebugLogger's export features to access logs")
            else
                d("[Beltalowda] LibDebugLogger not installed")
                d("Session logs are in-memory only and will be lost on /reloadui")
                d("To persist logs, install LibDebugLogger from ESOUI.com")
            end
            d("")
            d("SavedVariables file location:")
            d("  Windows: Documents\\Elder Scrolls Online\\live\\SavedVariables\\Beltalowda.lua")
            d("  Mac: Documents/Elder Scrolls Online/live/SavedVariables/Beltalowda.lua")
        else
            d("[Beltalowda] Usage:")
            d("  /btlwdata log show [module] [count] - Show last N log entries")
            d("  /btlwdata log clear                 - Clear session log")
            d("  /btlwdata log levels                - Show current debug levels")
            d("  /btlwdata log export                - Show SavedVariables file path")
        end
    elseif args == "help" or args == "" or args == nil then
        d("=== Beltalowda Network Foundation Test Commands ===")
        d("")
        d("Basic Commands:")
        d("  /btlwdata status  - Show group status and data availability")
        d("  /btlwdata group   - Show all group member data (detailed)")
        d("  /btlwdata ults    - Show ultimate data for all group members")
        d("  /btlwdata equip   - Show equipment data for all group members")
        d("")
        d("Debug Level Commands:")
        d("  /btlwdata debug <module> <level>  - Set debug level for module")
        d("  /btlwdata debug all <level>       - Set all modules to level")
        d("    Modules: Network, Ultimates, Equipment, General, all")
        d("    Levels: ERROR, WARN, INFO, DEBUG, VERBOSE")
        d("")
        d("Log Management:")
        d("  /btlwdata log show [module] [count] - Show last N log entries")
        d("  /btlwdata log clear                 - Clear session log")
        d("  /btlwdata log levels                - Show current debug levels")
        d("  /btlwdata log export                - Show SavedVariables file path")
        d("")
        d("Diagnostic Commands:")
        d("  /btlwdata libapi  - Check library API availability")
        d("  /btlwdata debug   - Show detailed debug info (registration, events, data)")
        d("  /btlwdata raw     - Show raw data dump (for troubleshooting unit tags)")
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
