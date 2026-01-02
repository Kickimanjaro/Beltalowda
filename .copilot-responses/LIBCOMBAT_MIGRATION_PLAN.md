# Implementation Plan: Remove LibGroupCombatStats, Use LibCombat

## Executive Summary

This plan details how to remove LibGroupCombatStats and implement group ultimate tracking using LibCombat plus custom network broadcasting via LibGroupBroadcast.

**Warning**: This is a significant architectural change that requires substantial custom implementation to replace functionality that LibGroupCombatStats provides out-of-the-box.

---

## Current State

### Dependencies
- LibAsync (required)
- LibGroupBroadcast (required) - Network layer
- LibAddonMenu-2.0 (required) - Settings UI
- **LibGroupCombatStats (required)** ← TO BE REMOVED
- LibSetDetection (required) - Equipment tracking
- LibCombat (optional) ← TO BE MADE REQUIRED

### Current Ultimate Tracking Flow

```
1. LibGroupCombatStats collects local ultimate data (via LibCombat)
2. LibGroupCombatStats broadcasts to group (via LibGroupBroadcast)
3. LibGroupCombatStats receives data from other players
4. LibGroupCombatStats triggers callbacks to Beltalowda
5. Beltalowda displays ultimate data
```

**What we get for free from LibGroupCombatStats:**
- ✅ Automatic local ultimate data collection
- ✅ Network encoding/decoding
- ✅ Broadcast scheduling and throttling
- ✅ Group member tracking
- ✅ Event callbacks when data changes
- ✅ Error handling and retry logic
- ✅ Battle-tested reliability

---

## Proposed Architecture

### New Dependencies
- LibAsync (required)
- LibGroupBroadcast (required) - Network layer
- LibAddonMenu-2.0 (required) - Settings UI
- **LibCombat (required)** ← Changed from optional
- LibSetDetection (required) - Equipment tracking

### New Ultimate Tracking Flow

```
1. LibCombat provides combat event callbacks
2. Beltalowda hooks into combat events
3. Beltalowda tracks ultimate changes locally
4. Beltalowda broadcasts ultimate data (custom protocol)
5. Beltalowda receives broadcasts from other players
6. Beltalowda decodes and stores group data
7. Beltalowda displays ultimate data
```

**What we need to implement ourselves:**
- ❌ Ultimate data collection from combat events
- ❌ Network message encoding/decoding
- ❌ Broadcast scheduling and throttling
- ❌ Group member tracking
- ❌ Message protocol design
- ❌ Error handling and retry logic
- ❌ Testing and debugging

---

## Implementation Steps

### Phase 1: LibCombat Integration (Ultimate Collection)

**Goal**: Use LibCombat to track local player ultimate data

#### 1.1: Create UltimateCollector Module

**File**: `Base/Combat/UltimateCollector.lua`

```lua
-- Beltalowda Ultimate Collector
-- Uses LibCombat to track local player ultimate state

Beltalowda = Beltalowda or {}
Beltalowda.ultimateCollector = {}

local UltCollector = Beltalowda.ultimateCollector
local LC = LibCombat

-- Current ultimate state
UltCollector.currentState = {
    abilityId = nil,      -- Slotted ultimate ability ID
    cost = 0,             -- Ultimate cost
    current = 0,          -- Current ultimate points (0-500)
    max = 500,            -- Max ultimate points
    percent = 0,          -- Percentage (0-100)
    lastUpdate = 0        -- Timestamp of last update
}

-- Callbacks to trigger when ultimate changes
UltCollector.callbacks = {}

--[[
    Initialize the ultimate collector
]]--
function UltCollector.Initialize()
    if not LC then
        d("[Beltalowda] ERROR: LibCombat not available. Ultimate tracking disabled.")
        return false
    end
    
    -- Register for combat events via LibCombat
    -- Note: LibCombat provides EVENT_COMBAT_EVENT callback
    LC:RegisterCallback(LC.EVENT_COMBAT_EVENT, UltCollector.OnCombatEvent)
    
    -- Register for ability slot changes
    EVENT_MANAGER:RegisterForEvent(
        "Beltalowda_UltimateSlotChanged",
        EVENT_ACTION_SLOT_UPDATED,
        UltCollector.OnActionSlotUpdated
    )
    
    -- Register for power updates (ultimate resource)
    EVENT_MANAGER:RegisterForEvent(
        "Beltalowda_PowerUpdate",
        EVENT_POWER_UPDATE,
        UltCollector.OnPowerUpdate
    )
    
    -- Initial scan
    UltCollector.ScanCurrentUltimate()
    
    return true
end

--[[
    Scan current ultimate state
]]--
function UltCollector.ScanCurrentUltimate()
    -- Get slotted ultimate (slot 8 on current bar)
    local slotType, abilityId = GetSlotType(8)
    
    if slotType == ACTION_TYPE_ABILITY then
        UltCollector.currentState.abilityId = abilityId
        
        -- Get ultimate cost
        local cost = GetSlotTextureName(8) -- This is a placeholder, need correct API
        UltCollector.currentState.cost = cost or 0
    end
    
    -- Get current ultimate value
    local current, max = GetUnitPower("player", POWERTYPE_ULTIMATE)
    UltCollector.currentState.current = current
    UltCollector.currentState.max = max
    UltCollector.currentState.percent = (current / max) * 100
    UltCollector.currentState.lastUpdate = GetGameTimeMilliseconds()
end

--[[
    Handle combat events from LibCombat
]]--
function UltCollector.OnCombatEvent(eventData)
    -- LibCombat provides detailed combat event data
    -- We need to filter for ultimate-related events
    
    -- Check if ultimate was used
    if eventData.abilityId == UltCollector.currentState.abilityId then
        -- Ultimate was cast, update state
        UltCollector.ScanCurrentUltimate()
        UltCollector.TriggerCallbacks()
    end
end

--[[
    Handle action slot updates (bar swap, ability change)
]]--
function UltCollector.OnActionSlotUpdated(eventCode, slotNum)
    if slotNum == ACTION_BAR_ULTIMATE_SLOT_INDEX + 1 then
        -- Ultimate slot changed
        UltCollector.ScanCurrentUltimate()
        UltCollector.TriggerCallbacks()
    end
end

--[[
    Handle power updates (ultimate resource changes)
]]--
function UltCollector.OnPowerUpdate(eventCode, unitTag, powerIndex, powerType, powerValue, powerMax)
    if unitTag == "player" and powerType == POWERTYPE_ULTIMATE then
        UltCollector.currentState.current = powerValue
        UltCollector.currentState.max = powerMax
        UltCollector.currentState.percent = (powerValue / powerMax) * 100
        UltCollector.currentState.lastUpdate = GetGameTimeMilliseconds()
        
        UltCollector.TriggerCallbacks()
    end
end

--[[
    Register callback for ultimate changes
]]--
function UltCollector.RegisterCallback(callback)
    table.insert(UltCollector.callbacks, callback)
end

--[[
    Trigger all registered callbacks
]]--
function UltCollector.TriggerCallbacks()
    for _, callback in ipairs(UltCollector.callbacks) do
        callback(UltCollector.currentState)
    end
end

--[[
    Get current ultimate state
]]--
function UltCollector.GetCurrentState()
    return UltCollector.currentState
end
```

**Add to manifest** (`Beltalowda.txt`):
```
# Combat tracking
Base/Combat/UltimateCollector.lua
```

#### 1.2: Update Dependencies

**File**: `Beltalowda.txt`

Change:
```lua
## DependsOn: LibAsync>=3.1.1 LibGroupBroadcast>=91 LibAddonMenu-2.0>=41 LibGroupCombatStats>=6 LibSetDetection>=4
## OptionalDependsOn: LibCombat>=84 LibDebugLogger>=2.0
```

To:
```lua
## DependsOn: LibAsync>=3.1.1 LibGroupBroadcast>=91 LibAddonMenu-2.0>=41 LibCombat>=84 LibSetDetection>=4
## OptionalDependsOn: LibDebugLogger>=2.0
```

**File**: `Beltalowda.lua`

Remove LibGroupCombatStats check:
```lua
-- Remove lines 38-41
if not LibGroupCombatStats then
    loaded = false
    table.insert(missingLibs, "LibGroupCombatStats")
end
```

Add LibCombat check:
```lua
-- Change lines 43-45 from optional to required
if not LibCombat then
    loaded = false
    table.insert(missingLibs, "LibCombat")
end
```

---

### Phase 2: Custom Network Broadcasting

**Goal**: Implement custom LibGroupBroadcast protocol for ultimate data

#### 2.1: Reserve Message IDs

We have IDs 220-229 reserved. Let's use:
- **Message ID 220**: Ultimate broadcast (contains all ultimate data)

#### 2.2: Implement Broadcasting

**File**: `Base/Network/GroupBroadcast.lua`

Add custom message IDs:
```lua
BeltalowdaNetwork.MESSAGE_IDS = {
    ULTIMATE_DATA = 220,  -- Ultimate state broadcast
}
```

Add broadcasting function:
```lua
--[[
    Broadcast our ultimate data to the group
    @param state: Ultimate state table from UltimateCollector
]]--
function BeltalowdaNetwork.BroadcastUltimateData(state)
    if not LGB then return end
    
    -- Encode ultimate data into compact format
    -- Format: abilityId(4 bytes) | cost(2 bytes) | current(2 bytes) | max(2 bytes)
    local data = {
        state.abilityId or 0,
        state.cost or 0,
        state.current or 0,
        state.max or 500
    }
    
    -- Send via LibGroupBroadcast
    LGB:Send(BeltalowdaNetwork.MESSAGE_IDS.ULTIMATE_DATA, unpack(data))
    
    if logger then
        logger:Verbose("Broadcasted ultimate data", 
            "id=" .. tostring(state.abilityId),
            "current=" .. tostring(state.current),
            "max=" .. tostring(state.max))
    end
end

--[[
    Handle received ultimate data from group members
    @param sender: Unit tag of sender (e.g., "group1")
    @param data: Encoded ultimate data
]]--
function BeltalowdaNetwork.OnUltimateDataReceived(sender, abilityId, cost, current, max)
    -- Initialize player data if not exists
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].ultimate = BeltalowdaNetwork.groupData[sender].ultimate or {}
    
    -- Store received ultimate data
    local ult = BeltalowdaNetwork.groupData[sender].ultimate
    ult.abilityId = abilityId
    ult.id = abilityId  -- Alias for compatibility
    ult.cost = cost
    ult.current = current
    ult.value = current  -- Alias for compatibility
    ult.max = max
    ult.percent = (current / max) * 100
    
    if logger then
        logger:Debug("Ultimate data received from", sender,
            "id=" .. tostring(abilityId),
            "current=" .. tostring(current),
            "max=" .. tostring(max))
    end
    
    -- Trigger callback for modules that need this data
    BeltalowdaNetwork.OnDataChanged("ultimate", sender)
end

--[[
    Register for LibGroupBroadcast messages
]]--
function BeltalowdaNetwork.RegisterBroadcastHandlers()
    if not LGB then return end
    
    -- Register for ultimate data messages
    LGB:RegisterForMessage(
        BeltalowdaNetwork.MESSAGE_IDS.ULTIMATE_DATA,
        function(sender, abilityId, cost, current, max)
            BeltalowdaNetwork.OnUltimateDataReceived(sender, abilityId, cost, current, max)
        end
    )
    
    if logger then
        logger:Info("Registered for custom ultimate broadcasts (ID 220)")
    end
end
```

#### 2.3: Connect UltimateCollector to Broadcasting

Add to `Initialize()` function:
```lua
function BeltalowdaNetwork.Initialize()
    -- ... existing code ...
    
    -- Initialize ultimate collector
    if Beltalowda.ultimateCollector and Beltalowda.ultimateCollector.Initialize then
        Beltalowda.ultimateCollector.Initialize()
        
        -- Register callback to broadcast when our ultimate changes
        Beltalowda.ultimateCollector.RegisterCallback(function(state)
            BeltalowdaNetwork.BroadcastUltimateData(state)
        end)
    end
    
    -- Register for custom broadcast messages
    BeltalowdaNetwork.RegisterBroadcastHandlers()
    
    -- ... rest of initialization ...
end
```

#### 2.4: Remove LibGroupCombatStats Code

Remove from `Base/Network/GroupBroadcast.lua`:
- Line 10: `local LGCS = LibGroupCombatStats`
- Lines 26-30: External IDs for LibGroupCombatStats
- Line 41: `BeltalowdaNetwork.lgcsInstance = nil`
- Lines 63-71: LibGroupCombatStats availability check
- Lines 97-142: `SubscribeToUltimateData()` function
- All references to `LGCS` and `lgcsInstance`

---

### Phase 3: Broadcast Throttling and Scheduling

**Goal**: Prevent network spam, implement smart broadcasting

#### 3.1: Add Throttling Logic

```lua
-- Broadcast throttling configuration
BeltalowdaNetwork.broadcastConfig = {
    ultimateThrottleMs = 1000,  -- Minimum 1 second between broadcasts
    lastBroadcastTime = 0,
    pendingBroadcast = false
}

--[[
    Throttled broadcast function
]]--
function BeltalowdaNetwork.BroadcastUltimateDataThrottled(state)
    local now = GetGameTimeMilliseconds()
    local timeSinceLastBroadcast = now - BeltalowdaNetwork.broadcastConfig.lastBroadcastTime
    
    if timeSinceLastBroadcast >= BeltalowdaNetwork.broadcastConfig.ultimateThrottleMs then
        -- Enough time has passed, broadcast now
        BeltalowdaNetwork.BroadcastUltimateData(state)
        BeltalowdaNetwork.broadcastConfig.lastBroadcastTime = now
        BeltalowdaNetwork.broadcastConfig.pendingBroadcast = false
    else
        -- Too soon, schedule for later
        if not BeltalowdaNetwork.broadcastConfig.pendingBroadcast then
            BeltalowdaNetwork.broadcastConfig.pendingBroadcast = true
            
            local delay = BeltalowdaNetwork.broadcastConfig.ultimateThrottleMs - timeSinceLastBroadcast
            zo_callLater(function()
                if BeltalowdaNetwork.broadcastConfig.pendingBroadcast then
                    local currentState = Beltalowda.ultimateCollector.GetCurrentState()
                    BeltalowdaNetwork.BroadcastUltimateData(currentState)
                    BeltalowdaNetwork.broadcastConfig.lastBroadcastTime = GetGameTimeMilliseconds()
                    BeltalowdaNetwork.broadcastConfig.pendingBroadcast = false
                end
            end, delay)
        end
    end
end
```

Update callback registration to use throttled version:
```lua
Beltalowda.ultimateCollector.RegisterCallback(function(state)
    BeltalowdaNetwork.BroadcastUltimateDataThrottled(state)
end)
```

---

### Phase 4: Testing and Validation

#### 4.1: Unit Tests

Create test file: `tests/UltimateTracking_Tests.lua`

```lua
-- Test ultimate collection
function TestUltimateCollection()
    -- Mock player ultimate state
    -- Verify UltimateCollector tracks changes
    -- Verify callbacks trigger
end

-- Test broadcasting
function TestBroadcasting()
    -- Mock ultimate state changes
    -- Verify messages sent via LibGroupBroadcast
    -- Verify correct encoding
end

-- Test receiving
function TestReceiving()
    -- Mock incoming broadcasts
    -- Verify decoding
    -- Verify groupData population
end

-- Test throttling
function TestThrottling()
    -- Rapid ultimate changes
    -- Verify broadcasts throttled to max 1/second
    -- Verify pending broadcasts eventually sent
end
```

#### 4.2: Integration Tests

In-game testing checklist:
- [ ] Solo: Ultimate percentage updates correctly
- [ ] Solo: Ultimate ability detection works
- [ ] Solo: Bar swap updates ultimate
- [ ] Group: See own ultimate in groupData
- [ ] Group: Receive other players' ultimate data
- [ ] Group: `/btlwdata ults` shows all group members
- [ ] Combat: Real-time updates during fights
- [ ] Performance: No lag with 12-player groups

---

## Comparison: Before vs After

### Code Complexity

**Before (with LibGroupCombatStats)**:
- Lines of custom ultimate code: ~0
- Network protocol code: ~0
- Total implementation: ~50 lines (just subscription)

**After (with LibCombat)**:
- Ultimate collector module: ~200 lines
- Network protocol code: ~150 lines
- Throttling logic: ~50 lines
- Total implementation: ~400 lines

**Maintenance Factor**: 8x more code to maintain

### Features

| Feature | LibGroupCombatStats | Custom (LibCombat) |
|---------|---------------------|-------------------|
| Ultimate tracking | ✅ Built-in | ⚠️ Custom implementation |
| Group broadcasting | ✅ Built-in | ⚠️ Custom implementation |
| Network encoding | ✅ Optimized | ⚠️ Manual encoding |
| Throttling | ✅ Built-in | ⚠️ Custom implementation |
| Error handling | ✅ Battle-tested | ⚠️ Need to build |
| DPS tracking | ✅ Bonus feature | ❌ Not available |
| HPS tracking | ✅ Bonus feature | ❌ Not available |

### Reliability

**LibGroupCombatStats**:
- ✅ Used by HodorReflexes (production addon)
- ✅ Thousands of users
- ✅ Community maintained
- ✅ Bug fixes from upstream

**Custom Implementation**:
- ❌ Untested in production
- ❌ Single addon usage
- ❌ Maintenance burden on us
- ❌ Need to fix our own bugs

---

## Risks and Considerations

### Technical Risks

1. **Combat Event Coverage**
   - LibCombat may not fire events for all ultimate changes
   - Need fallback polling mechanism

2. **Network Protocol**
   - Custom encoding may have bugs
   - Message loss without retry logic
   - Need versioning for future changes

3. **Performance**
   - Broadcasting overhead in large groups
   - Need to optimize message frequency
   - Potential for network spam

4. **Edge Cases**
   - Dynamic ultimates (Volendrung)
   - Werewolf transformations
   - Ability bar swaps
   - Zone changes

### Maintenance Risks

1. **ESO API Changes**
   - Game updates may break our code
   - No upstream fixes available
   - Need to monitor patch notes

2. **Bug Reports**
   - Users will report ultimate tracking issues
   - Debugging custom protocol is complex
   - No community support

3. **Feature Parity**
   - LibGroupCombatStats updates add features
   - We miss out on improvements
   - Need to manually keep up

---

## Estimated Effort

### Development Time

- Phase 1 (UltimateCollector): 8-12 hours
- Phase 2 (Broadcasting): 6-8 hours
- Phase 3 (Throttling): 4-6 hours
- Phase 4 (Testing): 8-12 hours
- **Total**: 26-38 hours

### Ongoing Maintenance

- Bug fixes: 2-4 hours/month
- ESO API updates: 4-8 hours/quarter
- Feature enhancements: Variable
- **Yearly**: 30-60 hours

---

## Alternative: Hybrid Approach

### Keep LibCombat Optional, Add Features

Instead of replacing LibGroupCombatStats, we could:

1. **Keep LibGroupCombatStats** (group ultimate tracking)
2. **Add LibCombat** (personal combat analysis)
3. **Implement new features**:
   - Personal DPS tracking
   - Damage breakdown
   - Ability rotation analysis
   - Combat logs

This gives us:
- ✅ Best of both worlds
- ✅ Reliable group tracking (LGCS)
- ✅ Advanced personal features (LibCombat)
- ✅ Less risk
- ✅ Less maintenance

---

## Recommendation

Despite the request to remove LibGroupCombatStats, I must provide an honest assessment:

### If We Proceed with Removal

**Pros**:
- One less required dependency
- Full control over ultimate tracking
- Learning experience

**Cons**:
- 400+ lines of custom code to write
- 26-38 hours development time
- 30-60 hours/year maintenance
- Higher bug risk
- No DPS/HPS features
- Reinventing the wheel

### If We Keep LibGroupCombatStats

**Pros**:
- Battle-tested reliability
- Zero additional code
- Community maintenance
- Bonus DPS/HPS features
- Proven in production

**Cons**:
- One additional dependency
- Less control over internals

---

## Next Steps (If Proceeding)

If you'd like to proceed with removing LibGroupCombatStats:

1. **Review this plan** - Ensure you understand the scope
2. **Approve implementation** - Confirm you want to proceed
3. **Start with Phase 1** - Implement UltimateCollector
4. **Test thoroughly** - Validate each phase
5. **Monitor closely** - Watch for bugs in production

If you'd like to reconsider:

1. **Keep LibGroupCombatStats** - Continue current implementation
2. **Add LibCombat features** - Personal combat analysis
3. **Document decision** - Update architecture docs

---

**Prepared**: 2026-01-02  
**Status**: Awaiting approval to proceed  
**Estimated Effort**: 26-38 hours development + ongoing maintenance
