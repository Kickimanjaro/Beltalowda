-- Beltalowda Group Broadcast
-- LibGroupBroadcast integration layer for subscribing to existing libraries
-- Phase 2: Integration with LibGroupCombatStats and LibSetDetection

d("[Beltalowda] Loading GroupBroadcast.lua...")

Beltalowda = Beltalowda or {}
Beltalowda.network = Beltalowda.network or {}

local BeltalowdaNetwork = Beltalowda.network
-- Don't capture libraries as locals - check globals directly to avoid nil capture issues
-- Libraries may load in unpredictable order, so capturing them as locals at file load time
-- can result in nil values even though they're listed as dependencies
-- local LGB = LibGroupBroadcast
-- local LGCS = LibGroupCombatStats
-- local LSD = LibSetDetection

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
    d("[Beltalowda] INIT: BeltalowdaNetwork.Initialize() called")
    
    -- Initialize logger if not already done
    if not logger and Beltalowda.Logger and Beltalowda.Logger.CreateModuleLogger then
        logger = Beltalowda.Logger.CreateModuleLogger("Network")
    end
    
    -- Check if required libraries are available
    -- Note: These are now required dependencies in manifest, so this check is defensive
    if not LibGroupBroadcast then
        d("[Beltalowda] ERROR: LibGroupBroadcast not available. Network features disabled.")
        return false
    end
    
    if not LibGroupCombatStats then
        d("[Beltalowda] ERROR: LibGroupCombatStats not available. This should not happen (required dependency).")
        return false
    else
        if logger then
            logger:Info("LibGroupCombatStats found - registering addon")
        end
        BeltalowdaNetwork.SubscribeToUltimateData()
    end
    
    -- Check LibSetDetection availability with diagnostics
    d("[Beltalowda] INIT: Checking LibSetDetection availability...")
    d("[Beltalowda] INIT: LibSetDetection type=" .. type(LibSetDetection))
    d("[Beltalowda] INIT: LibSetDetection nil=" .. tostring(LibSetDetection == nil))
    
    if not LibSetDetection then
        d("[Beltalowda] ERROR: LibSetDetection not available. This should not happen (required dependency).")
        return false
    else
        d("[Beltalowda] INIT: LibSetDetection found!")
        d("[Beltalowda] INIT: About to call SubscribeToEquipmentData, function type=" .. type(BeltalowdaNetwork.SubscribeToEquipmentData))
        if logger then
            logger:Info("LibSetDetection found - registering addon")
        end
        
        -- Call with explicit error handling to catch any issues
        local success, err = pcall(BeltalowdaNetwork.SubscribeToEquipmentData)
        if not success then
            d("[Beltalowda] ERROR calling SubscribeToEquipmentData: " .. tostring(err))
            if logger then
                logger:Error("Error calling SubscribeToEquipmentData", tostring(err))
            end
        else
            d("[Beltalowda] SubscribeToEquipmentData call completed")
        end
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
    if not LibGroupCombatStats then return end
    
    local success, err = pcall(function()
        -- Register our addon with LibGroupCombatStats
        -- RegisterAddon returns an instance object if successful
        BeltalowdaNetwork.lgcsInstance = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})
        
        if not BeltalowdaNetwork.lgcsInstance then
            d("[Beltalowda] Warning: Failed to register with LibGroupCombatStats")
            return
        end
        
        -- LibGroupCombatStats callback signature: function(data)
        -- The callback receives only the data table with fields: unitTag, id, cost, value, max
        -- The unitTag is INSIDE the data table, not a separate parameter
        
        -- Register for player ultimate updates
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LibGroupCombatStats.EVENT_PLAYER_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LibGroupCombatStats.EVENT_PLAYER_ULT_UPDATE, 
                function(unitTag, data)
                    -- Debug: Log what we actually received
                    if logger then
                        logger:Debug("LGCS PLAYER callback received", "unitTag type=" .. type(unitTag), 
                            "unitTag=" .. tostring(unitTag),
                            "data type=" .. type(data))
                    end
                    
                    -- LGCS passes unitTag as first param (string), data as second param (table)
                    if unitTag and data and type(unitTag) == "string" and type(data) == "table" then
                        BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                    elseif logger then
                        logger:Warn("LGCS PLAYER callback received invalid params", 
                            "unitTag type=" .. type(unitTag), "data type=" .. type(data))
                    end
                end)
            d("[Beltalowda] Registered for PLAYER ultimate updates (EVENT_PLAYER_ULT_UPDATE)")
        end
        
        -- Register for group ultimate updates
        if BeltalowdaNetwork.lgcsInstance.RegisterForEvent and LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE then
            BeltalowdaNetwork.lgcsInstance:RegisterForEvent(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE, 
                function(unitTag, data)
                    -- Debug: Log what we actually received
                    if logger then
                        logger:Debug("LGCS GROUP callback received", "unitTag type=" .. type(unitTag),
                            "unitTag=" .. tostring(unitTag),
                            "data type=" .. type(data))
                    end
                    
                    -- LGCS passes unitTag as first param (string), data as second param (table)
                    if unitTag and data and type(unitTag) == "string" and type(data) == "table" then
                        BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
                    elseif logger then
                        logger:Warn("LGCS GROUP callback received invalid params",
                            "unitTag type=" .. type(unitTag), "data type=" .. type(data))
                    end
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
    Subscribe to LibSetDetection equipment change events
    
    LibSetDetection provides LSD_EVENT_SET_CHANGE event via EVENT_MANAGER.
    Event callback signature: function(setId, changeType, unitTag, localPlayer, activeType)
    
    Also provides GetSets(unitTag) to query current equipment.
]]--
function BeltalowdaNetwork.SubscribeToEquipmentData()
    d("[Beltalowda] SubscribeToEquipmentData called")
    
    if not LibSetDetection then 
        d("[Beltalowda] LibSetDetection not available - equipment tracking disabled")
        if logger then
            logger:Info("LibSetDetection not available - equipment tracking disabled")
        end
        return 
    end
    
    d("[Beltalowda] LibSetDetection found - checking for LSD_EVENT_SET_CHANGE...")
    d("[Beltalowda] LSD_EVENT_SET_CHANGE type: " .. type(LSD_EVENT_SET_CHANGE))
    d("[Beltalowda] LibSetDetection.GetSets type: " .. type(LibSetDetection.GetSets))
    
    if logger then
        logger:Info("LibSetDetection found - registering for LSD_EVENT_SET_CHANGE")
    end
    
    local success, err = pcall(function()
        -- Register for equipment change events using EVENT_MANAGER
        if LSD_EVENT_SET_CHANGE then
            d("[Beltalowda] Registering for LSD_EVENT_SET_CHANGE event...")
            
            EVENT_MANAGER:RegisterForEvent(
                "BeltalowdaNetwork_SetChange",
                LSD_EVENT_SET_CHANGE,
                function(eventCode, setId, changeType, unitTag, localPlayer, activeType)
                    d(string.format("[Beltalowda] LSD_EVENT_SET_CHANGE fired! setId=%d, changeType=%d, unitTag=%s, localPlayer=%s, activeType=%d",
                        setId, changeType, unitTag, tostring(localPlayer), activeType))
                    
                    if logger then
                        logger:Debug("LSD_EVENT_SET_CHANGE received",
                            string.format("setId=%d, changeType=%d, unitTag=%s", setId, changeType, unitTag))
                    end
                    
                    -- Call handler with set change data
                    BeltalowdaNetwork.OnEquipmentSetChanged(setId, changeType, unitTag, localPlayer, activeType)
                end
            )
            
            d("[Beltalowda] LSD_EVENT_SET_CHANGE registered successfully")
            if logger then
                logger:Info("Successfully registered for LSD_EVENT_SET_CHANGE")
            end
        else
            d("[Beltalowda] LSD_EVENT_SET_CHANGE not defined - LibSetDetection may not be loaded")
            if logger then
                logger:Warn("LSD_EVENT_SET_CHANGE not available")
            end
        end
        
        -- Try to get initial equipment data using GetSets
        if LibSetDetection.GetSets then
            d("[Beltalowda] Calling GetSets('player')...")
            local initialSets = LibSetDetection:GetSets("player")
            d("[Beltalowda] GetSets returned type=" .. type(initialSets) .. ", nil=" .. tostring(initialSets == nil))
            
            if initialSets then
                if logger then
                    logger:Debug("Got initial equipment data from GetSets", "type=" .. type(initialSets))
                end
                d("[Beltalowda] Calling OnEquipmentDataReceived with initial sets")
                BeltalowdaNetwork.OnEquipmentDataReceived("player", initialSets)
            else
                d("[Beltalowda] GetSets returned nil")
            end
        else
            d("[Beltalowda] LibSetDetection.GetSets is not a function")
        end
    end)
    
    if not success then
        d("[Beltalowda] ERROR in SubscribeToEquipmentData: " .. tostring(err))
        if logger then
            logger:Error("Error registering with LibSetDetection", tostring(err))
        end
    else
        d("[Beltalowda] SubscribeToEquipmentData completed successfully")
    end
end

--[[
    Handle combined ultimate data (main handler)
    @param unitTag: Unit tag of the player (e.g., "group1", "player")
    @param data: Ultimate data table from LGCS
]]--
function BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
    if not data or type(data) ~= "table" then 
        if logger then
            logger:Warn("OnUltimateDataReceived called with invalid data", "unitTag=" .. tostring(unitTag), "dataType=" .. type(data))
        end
        return 
    end
    
    -- Normalize unitTag: LGCS sends "player" but we need group tags for consistency
    -- When in a group, convert "player" to the appropriate group tag
    local normalizedTag = unitTag
    if unitTag == "player" then
        -- Find player's group tag if in a group
        local groupSize = GetGroupSize()
        if groupSize > 0 then
            for i = 1, groupSize do
                local groupTag = GetGroupUnitTagByIndex(i)
                if GetUnitName(groupTag) == GetUnitName("player") then
                    normalizedTag = groupTag
                    break
                end
            end
        end
    end
    
    -- DEBUG: Capture raw data samples to SavedVariables for easier analysis
    -- Keep only the last 10 samples to avoid bloat
    if BeltalowdaVars and BeltalowdaVars.debug then
        BeltalowdaVars.debug.lgcsDataSamples = BeltalowdaVars.debug.lgcsDataSamples or {}
        
        -- Deep copy the data table to SavedVariables
        local dataCopy = {}
        for k, v in pairs(data) do
            dataCopy[k] = v
        end
        
        table.insert(BeltalowdaVars.debug.lgcsDataSamples, {
            timestamp = GetTimeStamp(),
            unitTag = unitTag,
            data = dataCopy
        })
        
        -- Keep only last 10 samples
        while #BeltalowdaVars.debug.lgcsDataSamples > 10 do
            table.remove(BeltalowdaVars.debug.lgcsDataSamples, 1)
        end
    end
    
    -- DEBUG: Dump all fields in the data table to logs
    if logger then
        local fieldList = {}
        for k, v in pairs(data) do
            table.insert(fieldList, k .. "=" .. tostring(v) .. "(" .. type(v) .. ")")
        end
        logger:Debug("LGCS data table fields:", table.concat(fieldList, ", "))
        
        if normalizedTag ~= unitTag then
            logger:Debug("Normalized unitTag", "from=" .. unitTag, "to=" .. normalizedTag)
        end
    end
    
    -- Initialize player data if not exists (use normalized tag)
    BeltalowdaNetwork.groupData[normalizedTag] = BeltalowdaNetwork.groupData[normalizedTag] or {}
    BeltalowdaNetwork.groupData[normalizedTag].ultimate = BeltalowdaNetwork.groupData[normalizedTag].ultimate or {}
    
    -- Store all ultimate data from LGCS (use normalized tag)
    local ult = BeltalowdaNetwork.groupData[normalizedTag].ultimate
    
    -- LGCS actual fields discovered via SavedVariables data capture:
    -- - ult1ID, ult2ID: ability IDs for both bars
    -- - ult1Cost, ult2Cost: ultimate costs for both bars
    -- - ultValue: current ultimate resource value
    -- - ultActivatedSetID: which ultimate is active (0 = bar 1, non-zero = bar 2)
    
    -- Determine which ultimate is active and store its data
    local activeUltId = data.ultActivatedSetID == 0 and data.ult1ID or data.ult2ID
    local activeUltCost = data.ultActivatedSetID == 0 and data.ult1Cost or data.ult2Cost
    
    -- Store original LGCS fields
    ult.ult1ID = data.ult1ID
    ult.ult2ID = data.ult2ID
    ult.ult1Cost = data.ult1Cost
    ult.ult2Cost = data.ult2Cost
    ult.ultValue = data.ultValue
    ult.ultActivatedSetID = data.ultActivatedSetID
    
    -- Normalize to standard fields for display compatibility
    ult.abilityId = activeUltId
    ult.cost = activeUltCost
    ult.current = data.ultValue
    ult.value = data.ultValue -- Alias for compatibility
    ult.max = activeUltCost -- Max is the cost needed to cast
    
    -- Calculate percentage
    if activeUltCost and activeUltCost > 0 and data.ultValue then
        ult.percent = (data.ultValue / activeUltCost) * 100
    else
        ult.percent = 0
    end
    
    if logger then
        logger:Info("Ultimate data received!", "unitTag=" .. tostring(normalizedTag), 
            "abilityId=" .. tostring(activeUltId), 
            "value=" .. tostring(data.ultValue) .. "/" .. tostring(activeUltCost))
        logger:Info("Stored ultimate data", "unitTag=" .. tostring(normalizedTag), 
            "abilityId=" .. tostring(ult.abilityId), 
            "percent=" .. string.format("%.0f%%", ult.percent))
        logger:Verbose("Stored ultimate data under key", normalizedTag)
    end
    
    -- Trigger callback for modules that need this data (use normalized tag)
    BeltalowdaNetwork.OnDataChanged("ultimate", normalizedTag)
end

--[[
    Handle individual set change event from LibSetDetection
    @param setId: The set ID that changed
    @param changeType: LSD_CHANGE_TYPE (activated, deactivated, changed)
    @param unitTag: Unit tag of the player
    @param localPlayer: true if this is the local player
    @param activeType: LSD_ACTIVE_TYPE (frontbar, backbar, dualbar, none)
]]--
function BeltalowdaNetwork.OnEquipmentSetChanged(setId, changeType, unitTag, localPlayer, activeType)
    if logger then
        logger:Debug("Equipment set changed",
            string.format("setId=%d, changeType=%d, unitTag=%s, localPlayer=%s, activeType=%d",
                setId, changeType, unitTag, tostring(localPlayer), activeType))
    end
    
    -- Normalize unitTag (convert "player" to appropriate group tag when in a group)
    local normalizedTag = unitTag
    if unitTag == "player" then
        -- Find player's group tag if in a group
        local groupSize = GetGroupSize()
        if groupSize > 0 then
            for i = 1, groupSize do
                local groupTag = GetGroupUnitTagByIndex(i)
                if GetUnitName(groupTag) == GetUnitName("player") then
                    normalizedTag = groupTag
                    break
                end
            end
        end
    end
    
    -- Capture event to SavedVariables for analysis
    if BeltalowdaVars and BeltalowdaVars.debug then
        BeltalowdaVars.debug.lsdEventSamples = BeltalowdaVars.debug.lsdEventSamples or {}
        table.insert(BeltalowdaVars.debug.lsdEventSamples, {
            timestamp = GetTimeStamp(),
            setId = setId,
            changeType = changeType,
            unitTag = unitTag,
            normalizedTag = normalizedTag,
            localPlayer = localPlayer,
            activeType = activeType
        })
        
        -- Keep only last 20 samples
        while #BeltalowdaVars.debug.lsdEventSamples > 20 do
            table.remove(BeltalowdaVars.debug.lsdEventSamples, 1)
        end
    end
    
    -- Query current equipment using GetSets to get full picture
    if LibSetDetection and LibSetDetection.GetSets then
        local currentSets = LibSetDetection:GetSets(unitTag)
        if currentSets then
            BeltalowdaNetwork.OnEquipmentDataReceived(unitTag, currentSets)
        end
    end
end

--[[
    Handle equipment data from LibSetDetection
    @param unitTag: Unit tag of the player (e.g., "group1", "player")
    @param data: Equipment data table from LSD (result of GetSets call)
]]--
function BeltalowdaNetwork.OnEquipmentDataReceived(unitTag, data)
    d("[Beltalowda] OnEquipmentDataReceived called! unitTag=" .. tostring(unitTag) .. ", dataType=" .. type(data))
    
    if not data or type(data) ~= "table" then
        d("[Beltalowda] Invalid data in OnEquipmentDataReceived - returning")
        if logger then
            logger:Warn("OnEquipmentDataReceived called with invalid data", "unitTag=" .. tostring(unitTag), "dataType=" .. type(data))
        end
        return
    end
    
    d("[Beltalowda] Equipment data table received, processing...")
    
    -- Normalize unitTag (convert "player" to appropriate group tag when in a group)
    local normalizedTag = unitTag
    if IsUnitGrouped("player") and unitTag == "player" then
        local groupIndex = GetGroupIndexByUnitTag("player")
        if groupIndex then
            normalizedTag = GetGroupUnitTagByIndex(groupIndex)
            if not normalizedTag or normalizedTag == "" then
                normalizedTag = unitTag
            end
        end
    end
    
    d("[Beltalowda] Normalized tag: from=" .. unitTag .. " to=" .. normalizedTag)
    
    -- Capture raw data sample to SavedVariables for structure discovery
    if BeltalowdaVars and BeltalowdaVars.debug then
        d("[Beltalowda] Saving equipment data sample to SavedVariables...")
        BeltalowdaVars.debug.lsdDataSamples = BeltalowdaVars.debug.lsdDataSamples or {}
        table.insert(BeltalowdaVars.debug.lsdDataSamples, {
            timestamp = GetTimeStamp(),
            unitTag = unitTag,
            data = data
        })
        
        d("[Beltalowda] Equipment sample saved. Total samples: " .. #BeltalowdaVars.debug.lsdDataSamples)
        
        -- Keep only last 10 samples
        while #BeltalowdaVars.debug.lsdDataSamples > 10 do
            table.remove(BeltalowdaVars.debug.lsdDataSamples, 1)
        end
    else
        d("[Beltalowda] BeltalowdaVars.debug not available - cannot save sample")
    end
    
    -- DEBUG: Dump all fields in the data table to logs
    if logger then
        local fieldList = {}
        for k, v in pairs(data) do
            table.insert(fieldList, k .. "=" .. tostring(v) .. "(" .. type(v) .. ")")
        end
        logger:Debug("LSD data table fields:", table.concat(fieldList, ", "))
        
        if normalizedTag ~= unitTag then
            logger:Debug("Normalized unitTag", "from=" .. unitTag, "to=" .. normalizedTag)
        end
    end
    
    -- Initialize player data if not exists (use normalized tag)
    BeltalowdaNetwork.groupData[normalizedTag] = BeltalowdaNetwork.groupData[normalizedTag] or {}
    BeltalowdaNetwork.groupData[normalizedTag].equipment = BeltalowdaNetwork.groupData[normalizedTag].equipment or {}
    
    -- Store equipment data from LSD
    -- Field structure will be discovered via SavedVariables data capture
    -- For now, store the raw data table
    BeltalowdaNetwork.groupData[normalizedTag].equipment.rawData = data
    
    if logger then
        logger:Info("Equipment data received!", "unitTag=" .. tostring(normalizedTag))
        logger:Verbose("Stored equipment data under key", normalizedTag)
    end
    
    -- Trigger callback for modules that need this data (use normalized tag)
    BeltalowdaNetwork.OnDataChanged("equipment", normalizedTag)
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
    Helper: Get ability name safely with fallback
    @param abilityId: Ability ID number
    @return: Ability name string or "Unknown"
]]--
local function GetAbilityNameSafe(abilityId)
    if not abilityId then
        return "Unknown"
    end
    
    local abilityName = GetAbilityName(abilityId)
    if abilityName and abilityName ~= "" then
        return abilityName
    end
    
    return "Unknown"
end

--[[
    Helper: Get set name safely with fallback
    @param setId: Set ID (number or other type)
    @return: Set name string
]]--
local function GetSetNameSafe(setId)
    if type(setId) == "number" then
        local setName = GetItemSetName(setId)
        if setName and setName ~= "" then
            return setName
        end
        return "Set #" .. setId
    end
    return tostring(setId)
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
            -- Display ultimate data if available
            if data.ultimate and data.ultimate.abilityId then
                local ult = data.ultimate
                local abilityId = ult.abilityId
                local abilityName = GetAbilityNameSafe(abilityId)
                
                local current = ult.current or ult.value or 0
                local max = ult.max or 0
                local percent = ult.percent or 0
                
                d(string.format("  Ultimate: %s (ID: %s, cost: %d)", 
                    abilityName,
                    tostring(abilityId or "?"), 
                    ult.cost or 0))
                d(string.format("  Value: %d/%d (%.1f%%)", 
                    current, 
                    max, 
                    percent))
            else
                d("  Ultimate: No data yet")
            end
            
            -- Display equipment data if available
            if BeltalowdaNetwork.lsdInstance then
                local success, sets = pcall(function()
                    return BeltalowdaNetwork.lsdInstance:GetSetsForGroupMember(unitTag)
                end)
                
                if success and sets and type(sets) == "table" then
                    local hasData = false
                    for setId, pieces in pairs(sets) do
                        if not hasData then
                            d("  Equipment:")
                            hasData = true
                        end
                        
                        local setName = GetSetNameSafe(setId)
                        d(string.format("    %s: %d pieces", setName, pieces))
                    end
                    
                    if not hasData then
                        d("  Equipment: No sets detected")
                    end
                else
                    d("  Equipment: No data yet")
                end
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
            if data.ultimate and data.ultimate.abilityId then
                local ult = data.ultimate
                local current = ult.current or ult.value or 0
                local max = ult.max or 0
                local percent = ult.percent or 0
                
                local abilityId = ult.abilityId
                local abilityName = GetAbilityNameSafe(abilityId)
                
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
            if data.ultimate and data.ultimate.abilityId then
                local ult = data.ultimate
                
                local abilityId = ult.abilityId
                local abilityName = GetAbilityNameSafe(abilityId)
                
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
                    local setName = GetSetNameSafe(setId)
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
    -- Wrap in pcall to catch and display any errors
    local success, err = pcall(function()
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
        
        if LibGroupCombatStats then
            d("LibGroupCombatStats Events:")
            d("  EVENT_GROUP_ULT_UPDATE: " .. tostring(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE))
            d("  EVENT_PLAYER_ULT_UPDATE: " .. tostring(LibGroupCombatStats.EVENT_PLAYER_ULT_UPDATE))
            d("  RegisterAddon method: " .. tostring(type(LibGroupCombatStats.RegisterAddon) == "function"))
            
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
        d("LibGroupBroadcast: " .. tostring(LibGroupBroadcast ~= nil))
        if LibGroupBroadcast then
            d("  Loaded and available")
            -- Try to check for common API methods
            if type(LibGroupBroadcast) == "table" then
                d("  Type: table (object)")
                d("  Has Send method: " .. tostring(type(LibGroupBroadcast.Send) == "function"))
                d("  Has RegisterForMessage method: " .. tostring(type(LibGroupBroadcast.RegisterForMessage) == "function"))
            end
        end
        d("")
        d("LibGroupCombatStats: " .. tostring(LibGroupCombatStats ~= nil))
        if LibGroupCombatStats then
            d("  Has RegisterAddon: " .. tostring(type(LibGroupCombatStats.RegisterAddon) == "function"))
            d("  EVENT_GROUP_ULT_UPDATE: " .. tostring(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE))
            d("  EVENT_PLAYER_ULT_UPDATE: " .. tostring(LibGroupCombatStats.EVENT_PLAYER_ULT_UPDATE))
            
            -- Check for other possible API methods and events
            if type(LibGroupCombatStats) == "table" then
                d("  Type: table (object)")
                d("  Available methods:")
                for k, v in pairs(LibGroupCombatStats) do
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
    end)
    
    if not success then
        d("[Beltalowda] ERROR executing command:")
        d(tostring(err))
        d("Please report this error with steps to reproduce")
    end
end

d("[Beltalowda] GroupBroadcast.lua loaded successfully")
