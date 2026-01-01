# LibSets Integration Guide

## Status Update

**Current Approach (Revised)**: After research in Checkpoint 0.1b, we determined that **LibSetDetection** (an existing LibGroupBroadcast library) provides 100% coverage for broadcasting equipment data to group members. 

**This means**:
- ✅ **LibSets**: Still needed for **local** set identification and role detection
- ✅ **LibSetDetection**: Use for **group broadcasting** of equipment data (ID 40)
- ❌ **Custom EquipmentCollector**: No longer needed - use LibSetDetection instead

**This guide remains relevant for**:
- Installing LibSets for local set identification
- Understanding LibSets capabilities
- Local equipment tracking and role detection
- Reference for future custom features

**For network sharing**: See LIBGROUPBROADCAST_INTEGRATION.md for LibSetDetection details.

---

## Overview

This document explains how to integrate LibSets into Beltalowda for tracking equipped gear and item sets **locally**. LibSets provides comprehensive data about all item sets in The Elder Scrolls Online.

## What is LibSets?

LibSets is a library that provides:
- Set identification from item links
- Set names (localized in multiple languages)
- Set bonuses and piece requirements
- Set metadata (type, quality, etc.)
- Comprehensive database of all ESO item sets

### Resources

- **ESOUI Page**: https://www.esoui.com/downloads/info2241-LibSets.html
- **GitHub Repository**: https://github.com/Baertram/LibSets
- **Set Data Spreadsheet**: https://github.com/Baertram/LibSets/blob/LibSets-reworked/LibSets/Data/LibSets_SetData.xlsm

## Dependencies

LibSets has two dependencies:

### 1. LibAsync
**Purpose**: Asynchronous data loading to prevent UI freezes

**Download**: Available on ESOUI.com
- Search for "LibAsync" on https://www.esoui.com/

**Why Needed**: LibSets loads large set databases asynchronously to avoid blocking the main thread

### 2. LibDebugLogger
**Purpose**: Debug logging (optional but recommended)

**Already Have**: Beltalowda already includes LibDebugLogger in `Lib/LibDebugLogger/`

## Installation Steps

### Step 1: Download Libraries

1. **Download LibSets**:
   - Go to https://github.com/Baertram/LibSets
   - Download the latest release
   - Extract to `Lib/LibSets/` directory

2. **Download LibAsync**:
   - Search on https://www.esoui.com/ for "LibAsync"
   - Download the latest version
   - Extract to `Lib/LibAsync/` directory

### Step 2: Update Manifest

Update `Beltalowda.txt` to include new dependencies:

**Current**:
```
## DependsOn: LibMapPins-1.0>=10041 LibMapPing>=1240 LibGPS>=73 LibAddonMenu-2.0>=39 Lib3D>=312 LibFoodDrinkBuff>=18 LibPotionBuff>=3 LibCustomMenu>=730 LibGroupBroadcast>=91
```

**Updated**:
```
## DependsOn: LibMapPins-1.0>=10041 LibMapPing>=1240 LibGPS>=73 LibAddonMenu-2.0>=39 Lib3D>=312 LibFoodDrinkBuff>=18 LibPotionBuff>=3 LibCustomMenu>=730 LibGroupBroadcast>=91 LibSets>=71 LibAsync>=2
```

### Step 3: Verify Installation

Add to `Beltalowda.lua` in the `AreLibrariesLoaded()` function:

```lua
function Beltalowda.AreLibrariesLoaded()
    local loaded = true
    local missingLibs = {}
    
    -- ... existing library checks ...
    
    -- NEW: Check for LibSets
    if LibSets == nil then
        loaded = false
        table.insert(missingLibs, "LibSets")
    end
    
    -- NEW: Check for LibAsync
    if LibAsync == nil then
        loaded = false
        table.insert(missingLibs, "LibAsync")
    end
    
    return loaded, missingLibs
end
```

## LibSets Capabilities

### Basic Set Information

```lua
local LibSets = LibSets

-- Get set ID from item link
local itemLink = GetItemLink(BAG_WORN, EQUIP_SLOT_HEAD)
local setId = LibSets:GetItemLinkSetId(itemLink)

-- Get set name (localized)
local setName = LibSets:GetSetName(setId)

-- Get set type (e.g., overland, dungeon, trial, crafted)
local setType = LibSets:GetSetType(setId)

-- Get set bonuses
local bonuses = LibSets:GetSetBonuses(setId)
-- bonuses = {
--   [1] = { pieces = 2, bonus = "Max Health +1096" },
--   [2] = { pieces = 3, bonus = "Max Stamina +1096" },
--   [3] = { pieces = 4, bonus = "Weapon Damage +129" },
--   [4] = { pieces = 5, bonus = "When you deal damage, 50% chance to deal 1000 Physical Damage" }
-- }
```

### Set Detection

```lua
-- Check if item is part of a set
local itemLink = GetItemLink(BAG_WORN, EQUIP_SLOT_CHEST)
if LibSets:IsSetItem(itemLink) then
    local setId = LibSets:GetItemLinkSetId(itemLink)
    d("Wearing set: " .. LibSets:GetSetName(setId))
end
```

### Set Piece Count

```lua
-- Count how many pieces of a set are equipped
function GetEquippedSetPieceCount(setId)
    local count = 0
    
    -- Check all equipment slots
    local slots = {
        EQUIP_SLOT_HEAD,
        EQUIP_SLOT_SHOULDERS,
        EQUIP_SLOT_CHEST,
        EQUIP_SLOT_WAIST,
        EQUIP_SLOT_HAND,
        EQUIP_SLOT_LEGS,
        EQUIP_SLOT_FEET,
        EQUIP_SLOT_NECK,
        EQUIP_SLOT_RING1,
        EQUIP_SLOT_RING2,
        EQUIP_SLOT_MAIN_HAND,
        EQUIP_SLOT_OFF_HAND,
        EQUIP_SLOT_BACKUP_MAIN,
        EQUIP_SLOT_BACKUP_OFF,
    }
    
    for _, slot in ipairs(slots) do
        local itemLink = GetItemLink(BAG_WORN, slot)
        local itemSetId = LibSets:GetItemLinkSetId(itemLink)
        if itemSetId == setId then
            count = count + 1
        end
    end
    
    return count
end
```

### Active Sets

```lua
-- Get all equipped sets
function GetAllEquippedSets()
    local sets = {}
    
    local slots = {
        EQUIP_SLOT_HEAD, EQUIP_SLOT_SHOULDERS, EQUIP_SLOT_CHEST,
        EQUIP_SLOT_WAIST, EQUIP_SLOT_HAND, EQUIP_SLOT_LEGS, EQUIP_SLOT_FEET,
        EQUIP_SLOT_NECK, EQUIP_SLOT_RING1, EQUIP_SLOT_RING2,
        EQUIP_SLOT_MAIN_HAND, EQUIP_SLOT_OFF_HAND,
        EQUIP_SLOT_BACKUP_MAIN, EQUIP_SLOT_BACKUP_OFF
    }
    
    for _, slot in ipairs(slots) do
        local itemLink = GetItemLink(BAG_WORN, slot)
        if itemLink and itemLink ~= "" then
            local setId = LibSets:GetItemLinkSetId(itemLink)
            if setId and setId > 0 then
                sets[setId] = (sets[setId] or 0) + 1
            end
        end
    end
    
    return sets
end

-- Example output:
-- {
--   [123] = 5,  -- 5 pieces of set ID 123
--   [456] = 5,  -- 5 pieces of set ID 456
--   [789] = 2,  -- 2 pieces of set ID 789 (monster set)
-- }
```

## Implementation for Beltalowda

### EquipmentCollector Module

Create `Base/Data/EquipmentCollector.lua`:

```lua
-- Beltalowda Equipment Collector
-- Tracks equipped gear using LibSets

Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.equipment = Beltalowda.data.equipment or {}

local BeltalowdaEquipment = Beltalowda.data.equipment
local LibSets = LibSets

BeltalowdaEquipment.state = {}
BeltalowdaEquipment.state.equippedSets = {}
BeltalowdaEquipment.state.equipmentSlots = {}

-- Equipment slot constants
BeltalowdaEquipment.SLOTS = {
    EQUIP_SLOT_HEAD,
    EQUIP_SLOT_SHOULDERS,
    EQUIP_SLOT_CHEST,
    EQUIP_SLOT_WAIST,
    EQUIP_SLOT_HAND,
    EQUIP_SLOT_LEGS,
    EQUIP_SLOT_FEET,
    EQUIP_SLOT_NECK,
    EQUIP_SLOT_RING1,
    EQUIP_SLOT_RING2,
    EQUIP_SLOT_MAIN_HAND,
    EQUIP_SLOT_OFF_HAND,
    EQUIP_SLOT_BACKUP_MAIN,
    EQUIP_SLOT_BACKUP_OFF,
}

function BeltalowdaEquipment.Initialize()
    if not LibSets then
        d("Beltalowda: LibSets not available. Equipment tracking disabled.")
        return false
    end
    
    -- Initial scan of equipped items
    BeltalowdaEquipment.ScanEquipment()
    
    -- Register for equipment changes
    EVENT_MANAGER:RegisterForEvent(
        "BeltalowdaEquipmentCollector",
        EVENT_INVENTORY_SINGLE_SLOT_UPDATE,
        BeltalowdaEquipment.OnInventorySlotUpdate
    )
    
    return true
end

function BeltalowdaEquipment.ScanEquipment()
    BeltalowdaEquipment.state.equipmentSlots = {}
    BeltalowdaEquipment.state.equippedSets = {}
    
    for i, slot in ipairs(BeltalowdaEquipment.SLOTS) do
        local itemLink = GetItemLink(BAG_WORN, slot)
        if itemLink and itemLink ~= "" then
            local setId = LibSets:GetItemLinkSetId(itemLink)
            
            BeltalowdaEquipment.state.equipmentSlots[i] = {
                slot = slot,
                itemLink = itemLink,
                setId = setId,
                setName = setId and LibSets:GetSetName(setId) or nil
            }
            
            -- Count set pieces
            if setId and setId > 0 then
                BeltalowdaEquipment.state.equippedSets[setId] = 
                    (BeltalowdaEquipment.state.equippedSets[setId] or 0) + 1
            end
        end
    end
end

function BeltalowdaEquipment.OnInventorySlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- Only care about equipped items
    if bagId == BAG_WORN then
        BeltalowdaEquipment.ScanEquipment()
        
        -- Notify other systems of equipment change
        BeltalowdaEquipment.OnEquipmentChanged()
    end
end

function BeltalowdaEquipment.OnEquipmentChanged()
    -- Broadcast equipment to group
    if Beltalowda.network and Beltalowda.network.SendEquipment then
        local setIds = {}
        for i, slotData in ipairs(BeltalowdaEquipment.state.equipmentSlots) do
            setIds[i] = slotData.setId or 0
        end
        Beltalowda.network.SendEquipment(setIds)
    end
    
    -- Update role detection
    if BeltalowdaEquipment.DetectRole then
        BeltalowdaEquipment.DetectRole()
    end
end

function BeltalowdaEquipment.GetEquippedSets()
    return BeltalowdaEquipment.state.equippedSets
end

function BeltalowdaEquipment.GetSetPieceCount(setId)
    return BeltalowdaEquipment.state.equippedSets[setId] or 0
end

function BeltalowdaEquipment.IsSetActive(setId, requiredPieces)
    requiredPieces = requiredPieces or 5
    return BeltalowdaEquipment.GetSetPieceCount(setId) >= requiredPieces
end
```

### Monster Set Cooldown Tracking

Many monster sets (2-piece sets from veteran dungeons) have cooldowns. Track these:

```lua
-- Monster set IDs with cooldowns
BeltalowdaEquipment.MONSTER_SETS = {
    [123] = {
        name = "Selene",
        cooldown = 4000,  -- 4 seconds in milliseconds
        buffId = 12345,   -- Ability ID of the proc
    },
    [124] = {
        name = "Kra'gh",
        cooldown = 4000,
        buffId = 12346,
    },
    -- Add more monster sets
}

BeltalowdaEquipment.monsterSetCooldowns = {}

function BeltalowdaEquipment.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType)
    if unitTag ~= "player" then return end
    
    -- Check if this is a monster set proc
    for setId, setData in pairs(BeltalowdaEquipment.MONSTER_SETS) do
        if abilityId == setData.buffId then
            if changeType == EFFECT_RESULT_GAINED then
                -- Monster set proc activated, start cooldown
                local now = GetGameTimeMilliseconds()
                BeltalowdaEquipment.monsterSetCooldowns[setId] = {
                    startTime = now,
                    endTime = now + setData.cooldown,
                    remaining = setData.cooldown
                }
            end
        end
    end
end

function BeltalowdaEquipment.GetMonsterSetCooldown(setId)
    local cooldownData = BeltalowdaEquipment.monsterSetCooldowns[setId]
    if not cooldownData then return 0 end
    
    local now = GetGameTimeMilliseconds()
    if now >= cooldownData.endTime then
        -- Cooldown finished
        BeltalowdaEquipment.monsterSetCooldowns[setId] = nil
        return 0
    end
    
    return cooldownData.endTime - now
end

function BeltalowdaEquipment.IsMonsterSetReady(setId)
    return BeltalowdaEquipment.GetMonsterSetCooldown(setId) == 0
end
```

### Role Detection Based on Equipment

Detect player role based on equipped sets (PvP roles: Damage, Support, Lead):

**Note on PvP Role Structure**: ESO PvP uses different roles than traditional MMO structure:
- **Damage**: Primary damage dealers (replaces traditional "DPS")
- **Support**: Healers, buff providers, utility (replaces traditional "Healer", includes some traditional support functions)
- **Lead**: Crown/puller role, coordinates group movement and enemy positioning (replaces traditional "Tank" in PvP context)

**Advanced Roles** (for specialized tracking in casual zerg groups):
- **Puller**: Traditionally part of Lead role, focuses on enemy positioning (Rush of Agony, Dark Convergence, Void Bash)
- **Rapids**: Mobility buff provider (now integrated into Support with 12-player cap)
- **Purger**: Debuff removal specialist (now integrated into Support with 12-player cap)
- **Negater**: Ultimate-specific role for Negate Magic (casual groups may have dedicated Negate/Barrier trackers)

**Group Size Context**:
- **Ballgroups** (12 players): Highly optimized composition, multi-role players, focus on Damage/Support/Lead
- **Zerg Groups** (multiple 12-player groups): More casual, may have single-purpose roles like dedicated Barrier/Negate trackers
- **Addon Design**: Primary support for ballgroups (Damage/Support/Lead), but Lead role UI provides awareness for zerg group coordination

```lua
-- Lead sets (Pull/Crown sets for group coordination)
BeltalowdaEquipment.LEAD_SETS = {
    [123] = true,  -- Rush of Agony (pull set)
    [124] = true,  -- Dark Convergence (pull set)
    [125] = true,  -- Void Bash (pull set)
    -- Add more lead/pull sets
}

-- Support sets (Healer/Support role)
BeltalowdaEquipment.SUPPORT_SETS = {
    [126] = true,  -- Spell Power Cure
    [127] = true,  -- Worm's Raiment
    [128] = true,  -- Transmutation
    -- Add more support sets
}

-- Damage sets (DPS role - many options)
BeltalowdaEquipment.DAMAGE_SETS = {
    [129] = true,  -- Plaguebreak
    [130] = true,  -- Vicious Death
    [131] = true,  -- Crafty Alfiq
    -- Add more damage sets
}

function BeltalowdaEquipment.DetectRole()
    local equippedSets = BeltalowdaEquipment.GetEquippedSets()
    
    local leadScore = 0
    local supportScore = 0
    local damageScore = 0
    
    for setId, count in pairs(equippedSets) do
        if count >= 5 then  -- Full set bonus active
            if BeltalowdaEquipment.LEAD_SETS[setId] then
                leadScore = leadScore + 1
            end
            if BeltalowdaEquipment.SUPPORT_SETS[setId] then
                supportScore = supportScore + 1
            end
            if BeltalowdaEquipment.DAMAGE_SETS[setId] then
                damageScore = damageScore + 1
            end
        end
    end
    
    -- Determine role based on highest score
    local role = "Damage"  -- Default
    if leadScore > supportScore and leadScore > damageScore then
        role = "Lead"
    elseif supportScore > leadScore and supportScore > damageScore then
        role = "Support"
    end
    
    BeltalowdaEquipment.state.detectedRole = role
    return role
end
```

## Broadcasting Equipment Data

### Data Format

Since equipment tracking involves 14 slots, split into two messages (see LibGroupBroadcast guide):

**Message 1** (ID 204): Armor slots (7 items)
```
headSetId|shouldersSetId|chestSetId|waistSetId|handsSetId|legsSetId|feetSetId
```

**Message 2** (ID 205): Jewelry and weapons (7 items)
```
neckSetId|ring1SetId|ring2SetId|mainHandSetId|offHandSetId|backup1SetId|backup2SetId
```

### Broadcasting Implementation

```lua
function BeltalowdaEquipment.BroadcastEquipment()
    local setIds = {}
    
    for i, slotData in ipairs(BeltalowdaEquipment.state.equipmentSlots) do
        setIds[i] = slotData.setId or 0
    end
    
    -- Send via network layer
    if Beltalowda.network then
        Beltalowda.network.SendEquipment(setIds)
    end
end

-- Throttle broadcasts to avoid spam
BeltalowdaEquipment.lastBroadcast = 0
BeltalowdaEquipment.BROADCAST_THROTTLE = 2000  -- 2 seconds

function BeltalowdaEquipment.OnEquipmentChanged()
    local now = GetGameTimeMilliseconds()
    
    if (now - BeltalowdaEquipment.lastBroadcast) < BeltalowdaEquipment.BROADCAST_THROTTLE then
        -- Too soon, skip broadcast
        return
    end
    
    BeltalowdaEquipment.BroadcastEquipment()
    BeltalowdaEquipment.lastBroadcast = now
end
```

## UI Display

### Equipment Summary Window

Display equipped sets for group members:

```lua
-- Create UI showing group member equipment
function BeltalowdaEquipment.CreateEquipmentUI()
    -- Window showing:
    -- PlayerName: SetName1 (5), SetName2 (5), SetName3 (2)
    -- For each group member
    
    -- Useful for:
    -- - Seeing who has what sets
    -- - Coordinating set bonuses (e.g., multiple Ebon Armory tanks)
    -- - Identifying roles without asking
end
```

### Monster Set Cooldown Display

Show monster set cooldowns for group:

```lua
-- Visual indicator of monster set cooldowns
-- Similar to ultimate tracking but for set procs
-- Shows countdown timer and ready status
```

## Use Cases in Beltalowda

### 1. Enhanced Role Assignment

Automatically detect and assign roles based on equipped sets:

```lua
function BeltalowdaEquipment.AutoAssignRole()
    local role = BeltalowdaEquipment.DetectRole()
    
    -- Broadcast role to group
    if Beltalowda.network then
        Beltalowda.network.SendRole(role)
    end
    
    -- Update UI based on role
    if Beltalowda.ui then
        Beltalowda.ui.UpdateRoleDisplay(role)
    end
end
```

### 2. Set Bonus Coordination

Track group set bonuses:

```lua
function BeltalowdaEquipment.GetGroupSetCounts()
    -- Count how many group members have each set active
    local groupSets = {}
    
    for unitTag, data in pairs(Beltalowda.network.groupData) do
        if data.equipment then
            local sets = {}
            for _, setId in ipairs(data.equipment) do
                if setId > 0 then
                    sets[setId] = (sets[setId] or 0) + 1
                end
            end
            
            for setId, count in pairs(sets) do
                if count >= 5 then  -- Full set
                    groupSets[setId] = (groupSets[setId] or 0) + 1
                end
            end
        end
    end
    
    return groupSets
end

-- Example: Check if enough players have Ebon Armory for buff stacking
local groupSets = BeltalowdaEquipment.GetGroupSetCounts()
local ebonCount = groupSets[123] or 0  -- Ebon Armory set ID
if ebonCount >= 2 then
    d("Good Ebon coverage: " .. ebonCount .. " tanks")
end
```

### 3. Monster Set Cooldown Coordination

Show when monster sets are ready across the group:

```lua
-- "Monster Set Overview" window
-- Similar to Ultimate Overview
-- Shows cooldown timers for important monster sets
function BeltalowdaEquipment.UpdateMonsterSetUI()
    for unitTag, data in pairs(Beltalowda.network.groupData) do
        if data.monsterSetCooldowns then
            -- Display cooldown bars for each player's monster sets
        end
    end
end
```

### 4. Proc Set Tracking

Track proc-based sets for coordination:

```lua
-- Useful for sets like:
-- - Earthgore (support/healer - AoE heal proc)
-- - Black Gem Monstrosity (damage - monster set proc)
-- - Selene's (damage - monster set proc)
-- - Rush of Agony (lead - pull proc with cooldown tracking)
-- - Dark Convergence (lead - pull proc with cooldown tracking)
-- Show when procs are active for group coordination
```

## Testing Equipment Tracking

### Test Commands

```lua
SLASH_COMMANDS["/btlwequip"] = function()
    d("=== Equipped Sets ===")
    local sets = BeltalowdaEquipment.GetEquippedSets()
    for setId, count in pairs(sets) do
        local setName = LibSets:GetSetName(setId)
        d(setName .. ": " .. count .. " pieces")
    end
    
    d("Detected Role: " .. (BeltalowdaEquipment.state.detectedRole or "Unknown"))
end

SLASH_COMMANDS["/btlwmonster"] = function()
    d("=== Monster Set Cooldowns ===")
    for setId, cooldownData in pairs(BeltalowdaEquipment.monsterSetCooldowns) do
        local setData = BeltalowdaEquipment.MONSTER_SETS[setId]
        local remaining = BeltalowdaEquipment.GetMonsterSetCooldown(setId)
        if remaining > 0 then
            d(setData.name .. ": " .. (remaining / 1000) .. "s remaining")
        else
            d(setData.name .. ": Ready")
        end
    end
end
```

### Test Scenarios

1. **Equip Different Sets**: Equip various armor pieces, verify detection
2. **Bar Swap**: Swap weapons, verify weapon set detection
3. **Monster Set Proc**: Trigger monster set, verify cooldown tracking
4. **Role Changes**: Change from DPS to tank sets, verify role detection
5. **Group Sync**: Form group, verify equipment broadcasts to other players

## Performance Considerations

### Caching

Cache set names to avoid repeated lookups:

```lua
BeltalowdaEquipment.setNameCache = {}

function BeltalowdaEquipment.GetSetName(setId)
    if not BeltalowdaEquipment.setNameCache[setId] then
        BeltalowdaEquipment.setNameCache[setId] = LibSets:GetSetName(setId)
    end
    return BeltalowdaEquipment.setNameCache[setId]
end
```

### Event Throttling

Don't rescan equipment on every inventory update:

```lua
BeltalowdaEquipment.rescanScheduled = false

function BeltalowdaEquipment.OnInventorySlotUpdate(eventCode, bagId, slotId, ...)
    if bagId == BAG_WORN and not BeltalowdaEquipment.rescanScheduled then
        BeltalowdaEquipment.rescanScheduled = true
        zo_callLater(function()
            BeltalowdaEquipment.ScanEquipment()
            BeltalowdaEquipment.rescanScheduled = false
        end, 100)  -- Delay 100ms to batch multiple changes
    end
end
```

## Known Limitations

1. **Set ID Stability**: Set IDs may change between ESO patches (rare but possible)
2. **New Sets**: LibSets must be updated when new sets are added to ESO
3. **Proc Detection**: Some set procs don't have easily detectable buff IDs
4. **Dynamic Sets**: Sets with variable effects are harder to track

## Conclusion

LibSets integration enables powerful equipment-based features in Beltalowda:

1. **Automatic Role Detection**: Identify tanks/healers/DPS by gear
2. **Set Coordination**: Track group set bonuses
3. **Monster Set Cooldowns**: Show when important procs are ready
4. **Smart Tracking**: Adapt UI based on equipped sets

**Key Points**:
- LibSets requires LibAsync and LibDebugLogger
- Track 14 equipment slots for comprehensive coverage
- Broadcast equipment changes to group via LibGroupBroadcast
- Use set data for role detection and coordination
- Cache set names for performance

**Next Steps**:
1. Install LibSets and LibAsync
2. Update manifest dependencies
3. Implement EquipmentCollector module
4. Add equipment broadcasting
5. Create equipment UI displays
