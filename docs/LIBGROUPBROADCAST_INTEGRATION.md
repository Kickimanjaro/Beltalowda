# LibGroupBroadcast Integration Guide

## Overview

This document provides detailed guidance on integrating LibGroupBroadcast into Beltalowda based on the context from issue #12 and the official LibGroupBroadcast documentation.

## What is LibGroupBroadcast?

LibGroupBroadcast (formerly LibGroupSocket) is a specialized library for The Elder Scrolls Online that enables efficient data sharing between group members. It was specifically designed to overcome the limitations of using ESO's chat system for addon data transmission.

### Key Resources

- **ESOUI Page**: https://www.esoui.com/downloads/info1337-LibGroupBroadcastformerlyLibGroupSocket.html
- **Wiki - How to Share Data**: https://wiki.esoui.com/How_to_share_data_within_groups
- **Wiki - Message IDs**: https://wiki.esoui.com/LibGroupBroadcast_IDs
- **Forum Thread**: https://www.esoui.com/forums/showthread.php?p=51017

## Current State in Beltalowda

### Already Integrated!

Good news: LibGroupBroadcast is **already declared as a dependency** in `Beltalowda.txt`:

```
## DependsOn: LibMapPins-1.0>=10041 LibMapPing>=1240 LibGPS>=73 LibAddonMenu-2.0>=39 Lib3D>=312 LibFoodDrinkBuff>=18 LibPotionBuff>=3 LibCustomMenu>=730 LibGroupBroadcast>=91
```

### Current Usage

The file `Base/Util/Networking.lua` already references LibGroupBroadcast:

```lua
local LGB = LibGroupBroadcast

-- Check if LibGroupBroadcast is available
if not LGB then
    d("Beltalowda: LibGroupBroadcast not found! Networking features will be disabled.")
    d("Beltalowda: Please ensure LibGroupBroadcast is installed and loaded.")
end
```

### Currently Allocated Message IDs

From `Base/Util/Networking.lua`, Beltalowda is already using these message IDs:

- **60**: HP data
- **50**: Damage data
- **190**: Boom/Detonation data
- **110**: Synergy data
- **109**: Role assignment
- **189**: Version information
- **188**: Version request
- **170**: Admin request
- **169**: Admin response (addon configuration 1)
- **168**: Admin response (addon configuration 2)
- **167**: Admin response (addon configuration 3)

**Total Currently Used**: 11 message IDs

## Why LibGroupBroadcast Instead of Party Chat?

### Limitations of Party Chat

The current ultimate tracking implementation uses party chat (`CHAT_CATEGORY_PARTY`) for broadcasting:

**Problems**:
1. **Character Limit**: Chat messages limited to ~100 characters
2. **Rate Limiting**: ESO throttles chat messages to prevent spam
3. **Visibility**: Messages appear in chat history (must be filtered)
4. **Unreliability**: Can be blocked by chat filters or player settings
5. **Inefficiency**: Text-based encoding is verbose
6. **No Acknowledgment**: Can't confirm message delivery

### Benefits of LibGroupBroadcast

**Advantages**:
1. **Binary Protocol**: Efficient data encoding
2. **Large Payloads**: Up to 512 bytes per message
3. **Reliable**: Built-in acknowledgment and retry logic
4. **Invisible**: Doesn't clutter chat
5. **Multiple Channels**: Use different message IDs for different data types
6. **Group-Specific**: Only group members receive messages
7. **Optimized**: Designed specifically for addon data sharing

### Performance Comparison

| Feature | Party Chat | LibGroupBroadcast |
|---------|-----------|------------------|
| Max Message Size | ~100 chars | 512 bytes |
| Encoding | Text string | Binary |
| Rate Limit | Strict | Generous |
| Visibility | Chat window | Invisible |
| Delivery Confirmation | No | Yes |
| Group Scaling | Poor | Excellent |

**Verdict**: LibGroupBroadcast is significantly better for all data sharing beyond simple text messages.

## Requesting Message IDs

### Why Request a Block?

The LibGroupBroadcast maintainer tracks all message IDs to prevent conflicts between addons. Each addon should request a dedicated block of IDs.

### How to Request

**Forum Process**:
1. Create a post on the ESOUI forums in the LibGroupBroadcast thread
2. Specify your addon name (Beltalowda)
3. Request a block size (recommend 20 IDs for future expansion)
4. Provide a brief description of what each ID will be used for
5. Maintainer will assign a block and update the wiki

**Our Request Template**:

```
Addon: Beltalowda
Author: @Kickimanjaro
Requested IDs: 200-219 (20 IDs)

Purpose: Enhanced group PvP coordination addon with comprehensive data sharing

Planned Usage:
- 200: Resource packet (Health, Magicka, Stamina, Ultimate %)
- 201: Ultimate details (ability ID, cost, ready status)
- 202: Position packet (X, Y, Zone)
- 203: Ability bar packet (10 ability IDs)
- 204: Equipment packet (set IDs, part 1)
- 205: Equipment packet (set IDs, part 2)
- 206: State packet (combat, alive, online status)
- 207: Active effects (critical buffs/debuffs)
- 208: Keybind sync (coordinated ability casting)
- 209: Role assignment (tank/healer/DPS)
- 210-214: Reserved for future features
- 215-219: Reserved for experimental features

Note: Currently using IDs 50, 60, 109, 110, 167-170, 188-190 
(registered under RdK Group Tool, same codebase)
```

### Alternative: Use High IDs Temporarily

If we can't get official IDs immediately, we can use IDs in the 200+ range which are unlikely to conflict. However, this should be temporary until official assignment.

## Implementation Strategy

### Phase 1: Core Integration (Foundation)

**File**: `Base/Network/GroupBroadcast.lua` (new file)

```lua
-- Beltalowda Group Broadcast
-- LibGroupBroadcast integration layer

Beltalowda = Beltalowda or {}
Beltalowda.network = Beltalowda.network or {}
local BeltalowdaNetwork = Beltalowda.network

local LGB = LibGroupBroadcast

-- Message IDs (200-219 block, pending official assignment)
BeltalowdaNetwork.MESSAGE_IDS = {
    RESOURCES = 200,
    ULTIMATE_DETAILS = 201,
    POSITION = 202,
    ABILITIES = 203,
    EQUIPMENT_1 = 204,
    EQUIPMENT_2 = 205,
    STATE = 206,
    ACTIVE_EFFECTS = 207,
    KEYBIND_SYNC = 208,
    ROLE = 209,
}

-- Message handlers (registered for each ID)
BeltalowdaNetwork.handlers = {}

function BeltalowdaNetwork.Initialize()
    if not LGB then
        d("Beltalowda: LibGroupBroadcast not available. Data sharing disabled.")
        return false
    end
    
    -- Register message handlers
    for name, id in pairs(BeltalowdaNetwork.MESSAGE_IDS) do
        local handler = BeltalowdaNetwork.handlers[name]
        if handler then
            LGB:RegisterForMessage(id, handler)
        end
    end
    
    return true
end

function BeltalowdaNetwork.SendMessage(messageId, data)
    if not LGB then return false end
    
    -- Encode data to string (LGB expects string)
    local encoded = BeltalowdaNetwork.EncodeData(data)
    
    -- Send via LibGroupBroadcast
    LGB:Send(messageId, encoded)
    return true
end

function BeltalowdaNetwork.EncodeData(data)
    -- Simple encoding strategy: concatenate with delimiters
    -- For more complex data, use more sophisticated encoding
    if type(data) == "table" then
        return table.concat(data, "|")
    end
    return tostring(data)
end

function BeltalowdaNetwork.DecodeData(encoded, format)
    -- Decode based on expected format
    -- format = "numbers", "strings", etc.
    if format == "numbers" then
        local parts = {zo_strsplit("|", encoded)}
        for i, v in ipairs(parts) do
            parts[i] = tonumber(v) or 0
        end
        return parts
    end
    
    -- Default: split by delimiter
    return {zo_strsplit("|", encoded)}
end
```

### Phase 2: Resource Broadcasting

**Message Format** (ID 200):
```
health|maxHealth|magicka|maxMagicka|stamina|maxStamina|ultimate|maxUltimate
```

**Example**:
```lua
function BeltalowdaNetwork.SendResources(health, maxHealth, magicka, maxMagicka, stamina, maxStamina, ultimate, maxUltimate)
    local data = {
        health, maxHealth,
        magicka, maxMagicka,
        stamina, maxStamina,
        ultimate, maxUltimate
    }
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.RESOURCES, data)
end

function BeltalowdaNetwork.handlers.RESOURCES(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    -- Store in group data structure
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].health = data[1]
    BeltalowdaNetwork.groupData[sender].maxHealth = data[2]
    BeltalowdaNetwork.groupData[sender].magicka = data[3]
    BeltalowdaNetwork.groupData[sender].maxMagicka = data[4]
    BeltalowdaNetwork.groupData[sender].stamina = data[5]
    BeltalowdaNetwork.groupData[sender].maxStamina = data[6]
    BeltalowdaNetwork.groupData[sender].ultimate = data[7]
    BeltalowdaNetwork.groupData[sender].maxUltimate = data[8]
    
    -- Trigger UI update
    BeltalowdaNetwork.OnDataChanged("resources", sender)
end
```

### Phase 3: Ultimate Details Broadcasting

**Message Format** (ID 201):
```
abilityId|cost|isReady
```

**Example**:
```lua
function BeltalowdaNetwork.SendUltimateDetails(abilityId, cost, isReady)
    local data = {
        abilityId,
        cost,
        isReady and 1 or 0
    }
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.ULTIMATE_DETAILS, data)
end

function BeltalowdaNetwork.handlers.ULTIMATE_DETAILS(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].ultimateAbilityId = data[1]
    BeltalowdaNetwork.groupData[sender].ultimateCost = data[2]
    BeltalowdaNetwork.groupData[sender].ultimateReady = (data[3] == 1)
    
    BeltalowdaNetwork.OnDataChanged("ultimate", sender)
end
```

### Phase 4: Position Broadcasting

**Message Format** (ID 202):
```
x|y|zoneId
```

**Example**:
```lua
function BeltalowdaNetwork.SendPosition(x, y, zoneId)
    -- Encode coordinates with precision (6 decimal places)
    local data = {
        math.floor(x * 1000000),
        math.floor(y * 1000000),
        zoneId
    }
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.POSITION, data)
end

function BeltalowdaNetwork.handlers.POSITION(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].x = data[1] / 1000000
    BeltalowdaNetwork.groupData[sender].y = data[2] / 1000000
    BeltalowdaNetwork.groupData[sender].zone = data[3]
    
    BeltalowdaNetwork.OnDataChanged("position", sender)
end
```

### Phase 5: Ability Bar Broadcasting

**Message Format** (ID 203):
```
slot1Id|slot2Id|...|slot10Id
```

**Example**:
```lua
function BeltalowdaNetwork.SendAbilityBar(abilityIds)
    -- abilityIds is array of 10 ability IDs (5 per bar)
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.ABILITIES, abilityIds)
end

function BeltalowdaNetwork.handlers.ABILITIES(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].abilities = data
    
    BeltalowdaNetwork.OnDataChanged("abilities", sender)
end
```

### Phase 6: Equipment Broadcasting

**Message Format** (IDs 204-205):
Two messages needed due to 14 equipment slots:

```
Message 204: head|shoulders|chest|waist|hands|legs|feet
Message 205: neck|ring1|ring2|mainHand|offHand|backup1|backup2
```

**Example**:
```lua
function BeltalowdaNetwork.SendEquipment(setIds)
    -- setIds is array of 14 set IDs (0 if no set)
    local part1 = {setIds[1], setIds[2], setIds[3], setIds[4], setIds[5], setIds[6], setIds[7]}
    local part2 = {setIds[8], setIds[9], setIds[10], setIds[11], setIds[12], setIds[13], setIds[14]}
    
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.EQUIPMENT_1, part1)
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.EQUIPMENT_2, part2)
end

function BeltalowdaNetwork.handlers.EQUIPMENT_1(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].equipment = BeltalowdaNetwork.groupData[sender].equipment or {}
    for i = 1, 7 do
        BeltalowdaNetwork.groupData[sender].equipment[i] = data[i]
    end
end

function BeltalowdaNetwork.handlers.EQUIPMENT_2(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].equipment = BeltalowdaNetwork.groupData[sender].equipment or {}
    for i = 1, 7 do
        BeltalowdaNetwork.groupData[sender].equipment[i + 7] = data[i]
    end
    
    -- Both parts received, trigger update
    BeltalowdaNetwork.OnDataChanged("equipment", sender)
end
```

### Phase 7: State Broadcasting

**Message Format** (ID 206):
```
flags
```

Where flags is a bit-packed number:
- Bit 0: In combat (1 = yes, 0 = no)
- Bit 1: Alive (1 = alive, 0 = dead)
- Bit 2: Online (1 = online, 0 = offline)
- Bit 3: In reload (1 = loading, 0 = ready)
- Bit 4-7: Reserved for future use

**Example**:
```lua
function BeltalowdaNetwork.SendState(inCombat, isAlive, isOnline, inReload)
    local flags = 0
    if inCombat then flags = flags + 1 end
    if isAlive then flags = flags + 2 end
    if isOnline then flags = flags + 4 end
    if inReload then flags = flags + 8 end
    
    BeltalowdaNetwork.SendMessage(BeltalowdaNetwork.MESSAGE_IDS.STATE, {flags})
end

function BeltalowdaNetwork.handlers.STATE(sender, message)
    local data = BeltalowdaNetwork.DecodeData(message, "numbers")
    local flags = data[1]
    
    BeltalowdaNetwork.groupData[sender] = BeltalowdaNetwork.groupData[sender] or {}
    BeltalowdaNetwork.groupData[sender].inCombat = (flags % 2) == 1
    BeltalowdaNetwork.groupData[sender].isAlive = (math.floor(flags / 2) % 2) == 1
    BeltalowdaNetwork.groupData[sender].isOnline = (math.floor(flags / 4) % 2) == 1
    BeltalowdaNetwork.groupData[sender].inReload = (math.floor(flags / 8) % 2) == 1
    
    BeltalowdaNetwork.OnDataChanged("state", sender)
end
```

## Broadcasting Strategy

### Update Frequencies

Different data types require different update frequencies:

| Data Type | Frequency | Trigger |
|-----------|-----------|---------|
| Resources | 500ms | >5% change or throttled |
| Ultimate Details | 2000ms | Ability change or 100% |
| Position | 100ms | Always (if following crown) |
| Abilities | Event | Skill bar swap or change |
| Equipment | Event | Item equipped/unequipped |
| State | 500ms | State change or throttled |
| Active Effects | 1000ms | Effect change (filtered) |

### Throttling Implementation

```lua
BeltalowdaNetwork.lastSent = {}

function BeltalowdaNetwork.ShouldSend(messageType, data)
    local now = GetGameTimeMilliseconds()
    local last = BeltalowdaNetwork.lastSent[messageType] or 0
    local interval = BeltalowdaNetwork.intervals[messageType] or 1000
    
    -- Check if enough time has passed
    if (now - last) < interval then
        return false
    end
    
    -- Check if data has changed significantly
    if BeltalowdaNetwork.HasSignificantChange(messageType, data) then
        BeltalowdaNetwork.lastSent[messageType] = now
        return true
    end
    
    return false
end
```

### Data Compression

For larger payloads, implement compression:

1. **Reference Tables**: Store common ability/set IDs in lookup tables, send index instead of full ID
2. **Delta Encoding**: Send only changes since last update
3. **Bit Packing**: Pack multiple boolean flags into single bytes
4. **Abbreviated Names**: Use short codes for common values

**Example Reference Table**:
```lua
-- Instead of sending full ability ID (6 digits)
-- Send index (1-2 digits) into common ability table
BeltalowdaNetwork.commonAbilities = {
    [1] = 123456,  -- Proximity Detonation
    [2] = 123457,  -- Subterranean Assault
    [3] = 123458,  -- Negate Magic
    -- ... etc
}
```

## Testing Strategy

### Unit Testing (Without Group)

```lua
-- Test encoding/decoding
function TestEncodeDecodeResources()
    local data = {1000, 2000, 1500, 2500, 1200, 2200, 250, 500}
    local encoded = BeltalowdaNetwork.EncodeData(data)
    local decoded = BeltalowdaNetwork.DecodeData(encoded, "numbers")
    
    for i = 1, #data do
        assert(data[i] == decoded[i], "Data mismatch at index " .. i)
    end
end
```

### Integration Testing (With Group)

1. **Two Player Test**:
   - Form group with alt account
   - Verify data syncs between characters
   - Test all message types

2. **Twelve Player Test**:
   - Full group in Cyrodiil
   - Monitor performance (FPS, memory)
   - Verify all data accurate under combat load

3. **Stress Test**:
   - Rapid data changes (swap gear, bars, etc.)
   - Zone transitions
   - Combat entry/exit
   - Death/resurrection
   - Disconnect/reconnect

### Debug Commands

```lua
-- View received data for specific player
SLASH_COMMANDS["/btlwdata"] = function(args)
    local unitTag = args or "player"
    local data = BeltalowdaNetwork.groupData[unitTag]
    if data then
        d("=== Data for " .. unitTag .. " ===")
        d("Resources: H=" .. (data.health or 0) .. "/" .. (data.maxHealth or 0))
        d("            M=" .. (data.magicka or 0) .. "/" .. (data.maxMagicka or 0))
        d("            S=" .. (data.stamina or 0) .. "/" .. (data.maxStamina or 0))
        d("            U=" .. (data.ultimate or 0) .. "/" .. (data.maxUltimate or 0))
        d("Position: " .. (data.x or 0) .. ", " .. (data.y or 0) .. " Zone=" .. (data.zone or 0))
        d("State: Combat=" .. tostring(data.inCombat) .. " Alive=" .. tostring(data.isAlive))
    else
        d("No data for " .. unitTag)
    end
end
```

## Migration from Party Chat

### Gradual Transition

To avoid breaking existing features during migration:

1. **Phase 1**: Implement LibGroupBroadcast alongside party chat
2. **Phase 2**: Add toggle to use either method (default: LGB)
3. **Phase 3**: Monitor for issues, gather feedback
4. **Phase 4**: Remove party chat code once LGB proven stable

### Fallback Mechanism

```lua
function BeltalowdaNetwork.Send(messageId, data)
    if BeltalowdaNetwork.useLGB and LGB then
        -- Use LibGroupBroadcast
        return BeltalowdaNetwork.SendViaLGB(messageId, data)
    else
        -- Fallback to party chat
        return BeltalowdaNetwork.SendViaPartyChat(data)
    end
end
```

## Performance Considerations

### Message Batching

Instead of sending each update immediately, batch updates:

```lua
BeltalowdaNetwork.pendingMessages = {}

function BeltalowdaNetwork.QueueMessage(messageId, data)
    BeltalowdaNetwork.pendingMessages[messageId] = data
end

function BeltalowdaNetwork.FlushMessages()
    for messageId, data in pairs(BeltalowdaNetwork.pendingMessages) do
        BeltalowdaNetwork.SendMessage(messageId, data)
    end
    BeltalowdaNetwork.pendingMessages = {}
end

-- Flush every 100ms
EVENT_MANAGER:RegisterForUpdate("BeltalowdaNetworkFlush", 100, BeltalowdaNetwork.FlushMessages)
```

### Memory Management

```lua
function BeltalowdaNetwork.CleanupOfflinePlayers()
    local groupSize = GetGroupSize()
    
    -- Remove data for players no longer in group
    for unitTag, data in pairs(BeltalowdaNetwork.groupData) do
        local stillInGroup = false
        for i = 1, groupSize do
            if GetUnitName(GetGroupUnitTagByIndex(i)) == GetUnitName(unitTag) then
                stillInGroup = true
                break
            end
        end
        
        if not stillInGroup then
            BeltalowdaNetwork.groupData[unitTag] = nil
        end
    end
end
```

## Common Issues & Solutions

### Issue: Messages Not Received

**Possible Causes**:
1. LibGroupBroadcast not installed
2. Message ID conflict with another addon
3. Recipient not in group
4. Message exceeds size limit (512 bytes)

**Solution**:
```lua
-- Add debug logging
function BeltalowdaNetwork.SendMessage(messageId, data)
    if not LGB then
        d("LGB not available")
        return false
    end
    
    local encoded = BeltalowdaNetwork.EncodeData(data)
    if #encoded > 512 then
        d("Message too large: " .. #encoded .. " bytes")
        return false
    end
    
    LGB:Send(messageId, encoded)
    d("Sent message " .. messageId .. ": " .. encoded)
    return true
end
```

### Issue: Performance Degradation

**Possible Causes**:
1. Too frequent updates
2. Not throttling messages
3. Too much data per message

**Solution**:
- Implement proper throttling (see above)
- Batch updates
- Use delta encoding (send only changes)

### Issue: Data Desynchronization

**Possible Causes**:
1. Messages arriving out of order
2. Packet loss (no retry)
3. Encoding/decoding errors

**Solution**:
- Add sequence numbers to messages
- Implement checksums for validation
- Log all encode/decode operations for debugging

## Conclusion

LibGroupBroadcast is the superior solution for data sharing in Beltalowda. Key takeaways:

1. **Already Integrated**: LibGroupBroadcast is already a dependency, just needs full implementation
2. **Request IDs**: Get official message ID block (200-219 recommended)
3. **Phased Approach**: Implement one message type at a time
4. **Keep Fallback**: Maintain party chat as emergency fallback during transition
5. **Test Thoroughly**: Extensive testing with real groups before full rollout

**Next Steps**:
1. Request official message ID block
2. Implement base GroupBroadcast.lua infrastructure
3. Migrate resource broadcasting to LGB (Phase 1)
4. Incrementally add other data types
5. Remove party chat fallback once stable
