# LibGroupBroadcast Implementation Guide for Beltalowda

This document provides comprehensive guidance on using LibGroupBroadcast for Beltalowda's group data sharing requirements.

## Table of Contents

1. [Current Implementation Status](#current-implementation-status)
2. [LibGroupBroadcast Overview](#libgroupbroadcast-overview)
3. [ID Reservation Requirements](#id-reservation-requirements)
4. [Recommended Protocol Design](#recommended-protocol-design)
5. [Implementation Examples](#implementation-examples)
6. [Migration from Current System](#migration-from-current-system)
7. [Best Practices](#best-practices)

---

## Current Implementation Status

### What We Already Have

Beltalowda **already uses LibGroupBroadcast** and has implemented several protocols:

**Current Protocols (from `Base/Util/Networking.lua`):**
- **Protocol ID 102 (LEGACY)**: BeltalowdaLegacyProtocol - General purpose messaging
- **Protocol ID 103 (ADMIN)**: BeltalowdaAdminProtocol - Admin requests/responses
- **Protocol ID 104 (VERSION)**: BeltalowdaVersionProtocol - Version information exchange
- **Protocol ID 105 (HEARTBEAT)**: BeltalowdaHeartbeatProtocol - Regular status updates
- **Protocol ID 106 (SYNERGY)**: BeltalowdaSynergyProtocol - Synergy tracking
- **Protocol ID 107 (HPDMG)**: BeltalowdaHpDmgProtocol - HP and damage tracking

**Current Message IDs (also in Networking.lua):**
```lua
MESSAGE_ID_HP = 60
MESSAGE_ID_DMG = 50
MESSAGE_ID_BOOM = 190
MESSAGE_ID_SYNERGY = 110
MESSAGE_ID_ROLE = 109
MESSAGE_ID_VERSION_INFORMATION = 189
MESSAGE_ID_VERSION_REQUEST = 188
MESSAGE_ID_ADMIN_REQUEST = 170
MESSAGE_ID_ADMIN_RESPONSE_* = 161-169
MESSAGE_ID_ADMIN_REQUEST_EQUIPMENT_INFORMATION = 140
MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_* = 135-139
MESSAGE_ID_ADMIN_RESPONSE_CHAMPION_INFORMATION = 134
MESSAGE_ID_ADMIN_RESPONSE_STATS_INFORMATION = 133
MESSAGE_ID_ADMIN_RESPONSE_SKILLS_INFORMATION = 132
```

### Current Data Sharing

The addon currently tracks and shares:
- ✅ **Ultimate percentages** (via HEARTBEAT protocol)
- ✅ **HP and Damage** (via HPDMG protocol)
- ✅ **Synergies** (via SYNERGY protocol)
- ✅ **Equipment information** (via ADMIN protocol)
- ✅ **Champion points** (via ADMIN protocol)
- ✅ **Stats** (via ADMIN protocol)
- ✅ **Skills** (via ADMIN protocol)

### What Needs Enhancement

Based on the issue requirements, we need to improve tracking for:
- ⚠️ **Current Resources**: Already tracked but could use enhanced protocol
- ⚠️ **Current Location**: Partially implemented, needs dedicated protocol
- ⚠️ **Equipped Gear**: Currently via admin protocol, could be enhanced
- ⚠️ **Slotted Abilities**: Currently via skills admin response, needs real-time updates
- ❌ **Active Effects/Buffs**: Not comprehensively tracked yet

---

## LibGroupBroadcast Overview

### What is LibGroupBroadcast?

LibGroupBroadcast is the standard library for group data sharing in ESO addons. It replaced the deprecated LibGroupSocket and LibDataShare libraries. Since ESO Update 45 (U45), ESO added official API support for group data sharing, which LibGroupBroadcast leverages.

### Key Features

- **Automatic bandwidth management**: Throttles messages to prevent spam
- **Protocol Inspector UI**: Debug tool to monitor data flow
- **Data Usage Tracking**: Monitor bandwidth consumption per protocol
- **Combat-aware**: Can prioritize or deprioritize messages during combat
- **Queue management**: Replaces queued messages when configured

### How It Works

1. **Handler Registration**: Each addon registers a handler with a unique name
2. **Protocol Declaration**: Define protocols with unique IDs and field structures
3. **Field Definitions**: Specify what data types each protocol sends
4. **Data Transmission**: Send structured data that gets serialized and broadcast
5. **Data Reception**: Receive callbacks when data arrives from group members

---

## ID Reservation Requirements

### Why Reserve IDs?

Protocol IDs must be globally unique across **all ESO addons** to prevent conflicts. The ESO addon community maintains a central registry.

### How to Reserve IDs

1. **Visit the Registry**: https://wiki.esoui.com/LibGroupBroadcast_IDs
2. **Check Existing IDs**: Ensure your desired IDs aren't already taken
3. **Add Your Reservation**: Edit the wiki page to add your addon and IDs
4. **Use Descriptive Names**: Make it clear what your addon/protocol does

### Current Beltalowda IDs

Based on the code analysis, Beltalowda uses:
- **Protocol IDs**: 102-107 (6 protocols currently in use)
- **Message IDs**: Various byte values (50, 60, 109, 110, 132-140, 161-170, 188-190)

**Status**: ⚠️ **These IDs should be formally registered on the wiki if not already done**

### Recommended ID Block Reservation

For future expansion, I recommend reserving:
- **Protocol IDs**: 102-120 (14 additional slots for new protocols)
- **Handler Name**: "Beltalowda" (already in use)
- **Description**: "Beltalowda - Group PvP coordination addon"

**Example Wiki Entry:**
```
| Beltalowda | Kickimanjaro | 102-120 | Various protocols for PvP group coordination |
```

---

## Recommended Protocol Design

### Protocol Architecture Philosophy

Rather than using a single monolithic protocol, I recommend **specialized protocols** for different data types:

**Advantages:**
- Better bandwidth management (can set different priorities)
- Easier debugging (protocol inspector shows clear separation)
- Combat-awareness (critical data during combat, non-critical out of combat)
- Message replacement (update-in-place for frequently changing data)

### Proposed New/Enhanced Protocols

#### 1. Resources Protocol (Enhanced HEARTBEAT)
**Protocol ID**: 105 (existing)  
**Name**: BeltalowdaHeartbeatProtocol  
**Purpose**: Real-time resource tracking  
**Combat Relevant**: Yes  
**Replace Queued**: Yes

**Fields:**
```lua
- ultimate (numeric, 0-100) - Ultimate percentage
- health (numeric, 0-100) - Health percentage  
- magicka (numeric, 0-100) - Magicka percentage
- stamina (numeric, 0-100) - Stamina percentage
- isDead (flag) - Player death status
- isInCombat (flag) - Combat state
```

**Update Frequency**: 500ms (twice per second)

#### 2. Position Protocol (New)
**Protocol ID**: 108 (new)  
**Name**: BeltalowdaPositionProtocol  
**Purpose**: Location tracking for "Follow the Crown" features  
**Combat Relevant**: Yes  
**Replace Queued**: Yes

**Fields:**
```lua
- zoneId (numeric) - Current zone ID
- x (numeric) - X coordinate (encoded as integer)
- y (numeric) - Y coordinate (encoded as integer)
- heading (numeric) - Player facing direction (0-360)
```

**Update Frequency**: 1000ms (once per second)

**Encoding Note**: Since LibGroupBroadcast uses numeric fields efficiently, coordinates can be multiplied by 1000 and sent as integers to preserve precision while keeping data compact.

#### 3. Equipment Protocol (Enhanced)
**Protocol ID**: 109 (new, replacing admin flow)  
**Name**: BeltalowdaEquipmentProtocol  
**Purpose**: Track equipped gear for monster set cooldown tracking  
**Combat Relevant**: No  
**Replace Queued**: Yes

**Design Consideration**: Equipment data is large. Rather than sending all slots, consider:

**Option A - Full Snapshot (Recommended)**
Send complete equipment when it changes:
```lua
- timestamp (numeric) - When equipment was captured
- headSetId (numeric) - Head item set ID
- shoulderSetId (numeric) - Shoulder item set ID
- chestSetId (numeric) - Chest item set ID
- handsSetId (numeric) - Hands item set ID
- legsSetId (numeric) - Legs item set ID
- feetSetId (numeric) - Feet item set ID
- waistSetId (numeric) - Waist item set ID
- neckSetId (numeric) - Neck item set ID
- ring1SetId (numeric) - Ring 1 item set ID
- ring2SetId (numeric) - Ring 2 item set ID
- weapon1MainSetId (numeric) - Main hand weapon set ID
- weapon1OffSetId (numeric) - Off hand weapon set ID
```

**Option B - Monster Set Only (Lighter)**
Only track head/shoulder for monster sets:
```lua
- timestamp (numeric)
- monsterSetId (numeric) - Which monster set (enum/lookup table)
- hasMonsterSet (flag) - Whether player has a monster set equipped
```

**Update Frequency**: On equipment change only (event-driven)

#### 4. Abilities Protocol (New)
**Protocol ID**: 110 (new)  
**Name**: BeltalowdaAbilitiesProtocol  
**Purpose**: Track slotted abilities for smart ultimate tracking  
**Combat Relevant**: No  
**Replace Queued**: Yes

**Fields - Bar 1:**
```lua
- bar1Slot1 (numeric) - Ability ID
- bar1Slot2 (numeric) - Ability ID
- bar1Slot3 (numeric) - Ability ID
- bar1Slot4 (numeric) - Ability ID
- bar1Slot5 (numeric) - Ability ID
- bar1Ultimate (numeric) - Ultimate ability ID
```

**Fields - Bar 2:**
```lua
- bar2Slot1 (numeric) - Ability ID
- bar2Slot2 (numeric) - Ability ID
- bar2Slot3 (numeric) - Ability ID
- bar2Slot4 (numeric) - Ability ID
- bar2Slot5 (numeric) - Ability ID
- bar2Ultimate (numeric) - Ultimate ability ID
```

**Additional:**
```lua
- activeBar (numeric) - Which bar is currently active (1 or 2)
- timestamp (numeric) - When abilities were captured
```

**Update Frequency**: On ability slot change or bar swap

**Note**: This enables the "Volendrung" scenario from the issue - detecting when a player picks up the hammer and tracking Ruinous Cyclone temporarily.

#### 5. Active Effects Protocol (New)
**Protocol ID**: 111 (new)  
**Name**: BeltalowdaActiveEffectsProtocol  
**Purpose**: Track relevant buffs/debuffs for attack timers, rapids, etc.  
**Combat Relevant**: Yes  
**Replace Queued**: Yes

**Design Challenge**: There can be dozens of active effects. Sending all would be too much data.

**Recommended Approach - Tracked Effects List:**

Create a predefined list of effects we care about (similar to tracked ultimates):
```lua
TRACKED_EFFECTS = {
    [40224] = "Rapids", -- Major Expedition
    [88401] = "Plaguebreak", -- Plague Carrier
    [115252] = "Echoing Vigor", -- HoT
    -- ... more effects
}
```

**Fields (Bit Array Approach):**
```lua
- effects1 (numeric) - Bits 0-23 (which tracked effects are active)
- effects2 (numeric) - Bits 24-47 (additional effects)
- effects3 (numeric) - Bits 48-71 (additional effects)
- timestamp (numeric) - When captured
```

Each bit represents whether a specific tracked effect is active. This is extremely bandwidth-efficient.

**Alternative (Simple List):**
```lua
- activeEffect1 (numeric) - Ability ID of first tracked effect
- activeEffect2 (numeric) - Ability ID of second tracked effect
- activeEffect3 (numeric) - Ability ID of third tracked effect
...
- activeEffect8 (numeric) - Ability ID of eighth tracked effect
- effectCount (numeric) - How many effects are actually set (1-8)
```

**Update Frequency**: 500ms during combat, 2000ms out of combat

---

## Implementation Examples

### Example 1: Position Protocol Implementation

```lua
-- In Networking.lua, add to Initialize():

BeltalowdaNetworking.protocols.position = BeltalowdaNetworking.LGB:DeclareProtocol(
    BeltalowdaNetworking.protocolTypes.POSITION, 
    "BeltalowdaPositionProtocol"
)

-- Add fields
BeltalowdaNetworking.protocols.position:AddField(LGB.CreateNumericField("zoneId"))
BeltalowdaNetworking.protocols.position:AddField(LGB.CreateNumericField("x"))
BeltalowdaNetworking.protocols.position:AddField(LGB.CreateNumericField("y"))
BeltalowdaNetworking.protocols.position:AddField(LGB.CreateNumericField("heading"))

-- Set data handler
BeltalowdaNetworking.protocols.position:OnData(BeltalowdaNetworking.LgbPositionOnData)

-- Finalize
BeltalowdaNetworking.protocols.position:Finalize({
    isRelevantInCombat = true,
    replaceQueuedMessages = true
})
```

### Example 2: Sending Position Data

```lua
function BeltalowdaNetworking.SendPositionUpdate()
    if not BeltalowdaNetworking.state.initialized then
        return
    end
    
    if BeltalowdaNetworking.netVars.enabled == true then
        -- Get player position
        local zoneId = GetZoneId(GetUnitZoneIndex("player"))
        local x, y = GetMapPlayerPosition("player")
        local heading = GetPlayerCameraHeading()
        
        -- Convert to integers for transmission (preserve precision)
        local xInt = math.floor(x * 1000000)
        local yInt = math.floor(y * 1000000)
        local headingInt = math.floor(heading * 1000)
        
        -- Send via protocol
        BeltalowdaNetworking.protocols.position:Send({
            zoneId = zoneId,
            x = xInt,
            y = yInt,
            heading = headingInt
        })
    end
end
```

### Example 3: Receiving Position Data

```lua
function BeltalowdaNetworking.LgbPositionOnData(unitTag, data)
    -- Convert back from integers
    local x = data.x / 1000000
    local y = data.y / 1000000
    local heading = data.heading / 1000
    
    -- Store in player data structure
    local playerData = BeltalowdaNetworking.GetPlayerData(unitTag)
    if playerData then
        playerData.position = {
            zoneId = data.zoneId,
            x = x,
            y = y,
            heading = heading,
            timestamp = GetGameTimeMilliseconds()
        }
        
        -- Trigger any "Follow the Crown" logic
        if BeltalowdaGroup.ftc then
            BeltalowdaGroup.ftc.OnPositionUpdate(unitTag, playerData.position)
        end
    end
end
```

### Example 4: Equipment Protocol with Monster Set Detection

```lua
-- Protocol declaration
BeltalowdaNetworking.protocols.equipment = BeltalowdaNetworking.LGB:DeclareProtocol(
    BeltalowdaNetworking.protocolTypes.EQUIPMENT,
    "BeltalowdaEquipmentProtocol"
)

BeltalowdaNetworking.protocols.equipment:AddField(LGB.CreateNumericField("timestamp"))
BeltalowdaNetworking.protocols.equipment:AddField(LGB.CreateNumericField("headSetId"))
BeltalowdaNetworking.protocols.equipment:AddField(LGB.CreateNumericField("shoulderSetId"))
BeltalowdaNetworking.protocols.equipment:AddField(LGB.CreateFlagField("hasMonsterSet"))

BeltalowdaNetworking.protocols.equipment:OnData(BeltalowdaNetworking.LgbEquipmentOnData)

BeltalowdaNetworking.protocols.equipment:Finalize({
    isRelevantInCombat = false,
    replaceQueuedMessages = true
})

-- Send equipment data
function BeltalowdaNetworking.SendEquipmentUpdate()
    if not BeltalowdaNetworking.state.initialized or not BeltalowdaNetworking.netVars.enabled then
        return
    end
    
    -- Get equipped item set IDs
    local headSetId = GetItemLinkSetInfo(GetItemLink(BAG_WORN, EQUIP_SLOT_HEAD))
    local shoulderSetId = GetItemLinkSetInfo(GetItemLink(BAG_WORN, EQUIP_SLOT_SHOULDERS))
    
    -- Determine if it's a monster set (head and shoulder from same set)
    local hasMonsterSet = (headSetId ~= nil and shoulderSetId ~= nil and headSetId == shoulderSetId)
    
    BeltalowdaNetworking.protocols.equipment:Send({
        timestamp = GetGameTimeMilliseconds(),
        headSetId = headSetId or 0,
        shoulderSetId = shoulderSetId or 0,
        hasMonsterSet = hasMonsterSet
    })
end

-- Receive equipment data
function BeltalowdaNetworking.LgbEquipmentOnData(unitTag, data)
    local playerData = BeltalowdaNetworking.GetPlayerData(unitTag)
    if playerData then
        playerData.equipment = {
            timestamp = data.timestamp,
            headSetId = data.headSetId,
            shoulderSetId = data.shoulderSetId,
            hasMonsterSet = data.hasMonsterSet,
            monsterSetId = data.hasMonsterSet and data.headSetId or nil
        }
        
        -- Trigger monster set cooldown tracking if applicable
        if data.hasMonsterSet and BeltalowdaGroup.monsterSets then
            BeltalowdaGroup.monsterSets.OnPlayerMonsterSetUpdate(unitTag, data.headSetId)
        end
    end
end
```

### Example 5: Abilities Protocol for Smart Ultimate Tracking

```lua
-- Protocol declaration
BeltalowdaNetworking.protocols.abilities = BeltalowdaNetworking.LGB:DeclareProtocol(
    BeltalowdaNetworking.protocolTypes.ABILITIES,
    "BeltalowdaAbilitiesProtocol"
)

-- Bar 1 abilities
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Slot1"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Slot2"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Slot3"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Slot4"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Slot5"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar1Ultimate"))

-- Bar 2 abilities
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Slot1"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Slot2"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Slot3"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Slot4"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Slot5"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("bar2Ultimate"))

-- Active bar and timestamp
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("activeBar"))
BeltalowdaNetworking.protocols.abilities:AddField(LGB.CreateNumericField("timestamp"))

BeltalowdaNetworking.protocols.abilities:OnData(BeltalowdaNetworking.LgbAbilitiesOnData)

BeltalowdaNetworking.protocols.abilities:Finalize({
    isRelevantInCombat = false,
    replaceQueuedMessages = true
})

-- Send abilities data
function BeltalowdaNetworking.SendAbilitiesUpdate()
    if not BeltalowdaNetworking.state.initialized or not BeltalowdaNetworking.netVars.enabled then
        return
    end
    
    local activeHotbar = GetActiveHotbarCategory()
    local activeBar = (activeHotbar == HOTBAR_CATEGORY_BACKUP) and 2 or 1
    
    -- Get bar 1 abilities
    local bar1Abilities = {}
    for i = 1, 6 do
        local slotId = i + 2  -- Slots 3-8 on bar 1
        local abilityId = GetSlotBoundId(slotId, HOTBAR_CATEGORY_PRIMARY)
        bar1Abilities[i] = abilityId
    end
    
    -- Get bar 2 abilities
    local bar2Abilities = {}
    for i = 1, 6 do
        local slotId = i + 2  -- Slots 3-8 on bar 2
        local abilityId = GetSlotBoundId(slotId, HOTBAR_CATEGORY_BACKUP)
        bar2Abilities[i] = abilityId
    end
    
    BeltalowdaNetworking.protocols.abilities:Send({
        bar1Slot1 = bar1Abilities[1],
        bar1Slot2 = bar1Abilities[2],
        bar1Slot3 = bar1Abilities[3],
        bar1Slot4 = bar1Abilities[4],
        bar1Slot5 = bar1Abilities[5],
        bar1Ultimate = bar1Abilities[6],
        bar2Slot1 = bar2Abilities[1],
        bar2Slot2 = bar2Abilities[2],
        bar2Slot3 = bar2Abilities[3],
        bar2Slot4 = bar2Abilities[4],
        bar2Slot5 = bar2Abilities[5],
        bar2Ultimate = bar2Abilities[6],
        activeBar = activeBar,
        timestamp = GetGameTimeMilliseconds()
    })
end

-- Receive abilities data
function BeltalowdaNetworking.LgbAbilitiesOnData(unitTag, data)
    local playerData = BeltalowdaNetworking.GetPlayerData(unitTag)
    if playerData then
        playerData.abilities = {
            bar1 = {
                data.bar1Slot1, data.bar1Slot2, data.bar1Slot3,
                data.bar1Slot4, data.bar1Slot5, data.bar1Ultimate
            },
            bar2 = {
                data.bar2Slot1, data.bar2Slot2, data.bar2Slot3,
                data.bar2Slot4, data.bar2Slot5, data.bar2Ultimate
            },
            activeBar = data.activeBar,
            timestamp = data.timestamp
        }
        
        -- Determine active ultimate
        local activeUltimate = (data.activeBar == 1) and data.bar1Ultimate or data.bar2Ultimate
        
        -- Update ultimate tracking (handles Volendrung scenario)
        if BeltalowdaUltimates then
            BeltalowdaUltimates.OnPlayerUltimateChange(unitTag, activeUltimate)
        end
    end
end
```

---

## Migration from Current System

### Current 4-Byte Message System

The existing code uses a 4-byte message encoding system:
```lua
message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
```

This packs all data into a single 24-bit integer, which is then decoded on receipt. While functional, this approach is:
- ❌ Hard to extend with new fields
- ❌ Difficult to debug
- ❌ Requires careful bit manipulation
- ❌ Limited to ~16 million distinct message combinations

### Migration Strategy

**Phase 1: Keep Existing System (Backward Compatible)**
- Don't break existing LEGACY, ADMIN, VERSION, etc. protocols
- These are working and already deployed
- Keep supporting them for existing features

**Phase 2: New Features Use New Protocols**
- Position tracking → New Position Protocol
- Enhanced abilities → New Abilities Protocol
- Active effects → New Active Effects Protocol

**Phase 3: Gradual Migration (Optional)**
- Over time, deprecate old protocols
- Move features to new structured protocols
- Eventually remove old 4-byte encoding

**Backward Compatibility:**
```lua
-- Support both old and new simultaneously
function BeltalowdaNetworking.Initialize()
    -- ... existing protocols stay ...
    
    -- New protocols added
    if BeltalowdaNetworking.config.useNewProtocols then
        BeltalowdaNetworking.InitializeNewProtocols()
    end
end
```

---

## Best Practices

### 1. Bandwidth Management

**DO:**
- ✅ Use `replaceQueuedMessages = true` for frequently updated data
- ✅ Set `isRelevantInCombat` appropriately
- ✅ Throttle updates (don't send every frame)
- ✅ Only send data when it changes significantly

**DON'T:**
- ❌ Send updates every frame
- ❌ Send huge payloads (> 20 fields per protocol)
- ❌ Send non-critical data during combat
- ❌ Broadcast when not in a group

### 2. Protocol Design

**DO:**
- ✅ Create separate protocols for different data categories
- ✅ Use numeric fields for most data (more efficient)
- ✅ Use flag fields for booleans
- ✅ Include timestamps for data freshness
- ✅ Document what each field represents

**DON'T:**
- ❌ Create one giant protocol with 50+ fields
- ❌ Mix unrelated data in one protocol
- ❌ Use string fields (very inefficient)
- ❌ Forget to finalize protocols

### 3. Data Validation

**DO:**
- ✅ Validate received data before using it
- ✅ Handle missing/nil values gracefully
- ✅ Check timestamps to ignore stale data
- ✅ Sanity check numeric ranges

**Example:**
```lua
function BeltalowdaNetworking.LgbPositionOnData(unitTag, data)
    -- Validate data exists
    if not data or not data.x or not data.y then
        return
    end
    
    -- Validate ranges
    if data.x < 0 or data.x > 1000000 or data.y < 0 or data.y > 1000000 then
        return  -- Invalid coordinates
    end
    
    -- Process valid data
    -- ...
end
```

### 4. Testing

**DO:**
- ✅ Use the Protocol Inspector (in-game addon settings)
- ✅ Test with multiple group members
- ✅ Test during combat (check performance)
- ✅ Test with slow networks
- ✅ Monitor data usage UI

**Protocol Inspector Access:**
1. Open ESO Settings
2. Go to Add-ons
3. Find LibGroupBroadcast section
4. Enable "Protocol Inspector"
5. See all protocols and their data flow

### 5. Error Handling

**DO:**
- ✅ Wrap protocol initialization in pcall (already done in current code)
- ✅ Check if LibGroupBroadcast is loaded
- ✅ Gracefully degrade if networking fails
- ✅ Log errors to help users debug

**Example from existing code:**
```lua
if not LGB then
    d("Beltalowda: LibGroupBroadcast not found! Networking features will be disabled.")
    BeltalowdaNetworking.state.initialized = false
    return
end
```

---

## Recommended ID Reservation

### Summary Table

| Protocol ID | Protocol Name | Purpose | Combat Relevant | Replace Queued |
|------------|---------------|---------|-----------------|----------------|
| 102 | BeltalowdaLegacyProtocol | Legacy messages | Yes | No |
| 103 | BeltalowdaAdminProtocol | Admin commands | No | No |
| 104 | BeltalowdaVersionProtocol | Version sync | No | No |
| 105 | BeltalowdaHeartbeatProtocol | Resources & ultimate | Yes | Yes |
| 106 | BeltalowdaSynergyProtocol | Synergy tracking | Yes | No |
| 107 | BeltalowdaHpDmgProtocol | HP & damage | Yes | No |
| **108** | **BeltalowdaPositionProtocol** | **Location tracking** | **Yes** | **Yes** |
| **109** | **BeltalowdaEquipmentProtocol** | **Gear & sets** | **No** | **Yes** |
| **110** | **BeltalowdaAbilitiesProtocol** | **Slotted abilities** | **No** | **Yes** |
| **111** | **BeltalowdaActiveEffectsProtocol** | **Buffs & debuffs** | **Yes** | **Yes** |
| 112-120 | *Reserved for future use* | Expansion | TBD | TBD |

### Wiki Registration Template

```
Beltalowda | Kickimanjaro | 102-120 | Group PvP coordination addon
  102 - Legacy protocol (general messages)
  103 - Admin protocol (commands & config)
  104 - Version protocol (addon version sync)
  105 - Heartbeat protocol (resources & ultimate tracking)
  106 - Synergy protocol (synergy usage tracking)
  107 - HP/Damage protocol (health & damage meter)
  108 - Position protocol (location & "Follow the Crown")
  109 - Equipment protocol (gear & monster sets)
  110 - Abilities protocol (slotted abilities & bar swap)
  111 - Active Effects protocol (buffs, debuffs, status effects)
  112-120 - Reserved for future expansion
```

---

## Next Steps

### Immediate Actions

1. **Register IDs on Wiki**
   - Visit https://wiki.esoui.com/LibGroupBroadcast_IDs
   - Add Beltalowda reservation for IDs 102-120
   - Document each protocol's purpose

2. **Enhance HEARTBEAT Protocol**
   - Add health, magicka, stamina fields
   - Add isDead, isInCombat flags
   - Already has ultimate percentage

3. **Implement Position Protocol**
   - Create Protocol ID 108
   - Add zone, x, y, heading fields
   - Hook into existing "Follow the Crown" features

### Future Enhancements

4. **Add Equipment Protocol**
   - Create Protocol ID 109
   - Track monster sets for cooldown coordination
   - Send only on equipment change (event-driven)

5. **Add Abilities Protocol**
   - Create Protocol ID 110
   - Enable "smart" ultimate tracking
   - Handle Volendrung and other temporary weapons

6. **Add Active Effects Protocol**
   - Create Protocol ID 111
   - Create curated list of tracked effects
   - Use bit array for efficiency
   - Enable attack timer and buff tracking features

### Testing Plan

1. Test each new protocol individually
2. Monitor bandwidth usage via Protocol Inspector
3. Test in various group sizes (2, 4, 12, 24 players)
4. Test during heavy combat (performance check)
5. Test backward compatibility with old versions

---

## Conclusion

Beltalowda is already successfully using LibGroupBroadcast for several features. The framework is in place and working well. 

**Key Takeaways:**

1. ✅ **Already Using LGB**: Six protocols are implemented and functional
2. ⚠️ **Need ID Registration**: Should formally register 102-120 on the wiki
3. 🚀 **Enhancement Path**: Clear roadmap for new protocols (Position, Equipment, Abilities, Effects)
4. 📊 **Structured Data**: Moving from byte-packing to structured protocols improves maintainability
5. 🔄 **Backward Compatible**: Can add new protocols without breaking existing features

The recommended approach is to:
- Keep existing protocols working (don't break what works)
- Add new structured protocols for enhanced features
- Register all IDs on the LibGroupBroadcast wiki
- Follow the implementation examples in this guide

This positions Beltalowda to deliver all the requested features (resources, location, gear, abilities, effects) while maintaining performance and compatibility.

---

## References

- **LibGroupBroadcast Wiki**: https://wiki.esoui.com/LibGroupBroadcast_IDs
- **LibGroupBroadcast Download**: https://www.esoui.com/downloads/info1337-LibGroupBroadcastformerlyLibGroupSocket.html
- **GitHub Repository**: https://github.com/sirinsidiator/ESO-LibGroupBroadcast
- **ESO API Documentation**: https://wiki.esoui.com/API

---

**Document Version**: 1.0  
**Last Updated**: 2025-12-31  
**Author**: GitHub Copilot  
**Addon**: Beltalowda by @Kickimanjaro
