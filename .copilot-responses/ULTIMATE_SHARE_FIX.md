# Group Ultimate Share Fix - Implementation Summary

## Issue Addressed
Fixed issue #22: "Phase 2: LibGroupBroadcast Integration (Weeks 5-6)" - Enable group ultimate share using LibGroupCombatStats and LibSetDetection libraries.

## Problem
The `/btlwdata ults` command was not displaying ultimate data from group members. The previous implementation was using incorrect API patterns:
- Used non-existent `RegisterCallback` method instead of proper `RegisterAddon` + `RegisterForEvent`
- Assumed callback-based approach for LibSetDetection instead of query-based approach
- Did not properly store library instances for future API calls

## Solution Implemented

### 1. LibGroupCombatStats Integration (Lines 88-129)
**Correct API Pattern:**
```lua
-- Register addon first
lgcsInstance = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})

-- Then register for events on the instance
lgcsInstance:RegisterForEvent(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE, callback)
lgcsInstance:RegisterForEvent(LibGroupCombatStats.EVENT_PLAYER_ULT_UPDATE, callback)
```

**What Changed:**
- Added proper addon registration with `RegisterAddon("Beltalowda", {"ULT"})`
- Store returned instance in `BeltalowdaNetwork.lgcsInstance`
- Register for both `EVENT_GROUP_ULT_UPDATE` and `EVENT_PLAYER_ULT_UPDATE`
- All event callbacks route to unified `OnUltimateDataReceived()` function
- Added warning messages when events are not available

### 2. LibSetDetection Integration (Lines 132-153)
**Correct API Pattern:**
```lua
-- Register addon
lsdInstance = LibSetDetection:RegisterAddon("Beltalowda")

-- Query data on-demand when needed
sets = lsdInstance:GetSetsForGroupMember(unitTag)
```

**What Changed:**
- Added proper addon registration with `RegisterAddon("Beltalowda")`
- Store returned instance in `BeltalowdaNetwork.lsdInstance`
- Changed from callback-based to query-based approach
- Equipment data is now queried on-demand in `DebugEquipmentData()` function

### 3. Unified Data Handler (Lines 155-193)
**What Changed:**
- Consolidated `OnUltimateTypeReceived` and `OnUltimateValueReceived` into single `OnUltimateDataReceived`
- Function accepts full data object from LibGroupCombatStats
- Safely extracts: `abilityId`, `cost`, `current`, `max`
- Calculates percentage: `(current / max) * 100`
- Stores all data in `BeltalowdaNetwork.groupData[unitTag].ultimate`

### 4. Enhanced Error Handling
**Defensive Programming:**
- Protected `GetAbilityName()` calls with nil checks and empty string validation
- Protected `GetItemSetName()` calls with type checking and fallbacks
- Wrapped `GetSetsForGroupMember()` in pcall to catch API errors
- Fixed variable name collision (renamed local `name` to `itemSetName`)
- Added warnings when event constants are not available

### 5. Updated Debug Commands
All debug commands properly work with new data structure:
- `/btlwdata status` - Shows group members and data availability
- `/btlwdata group` - Shows detailed data for all members
- `/btlwdata ults` - **NOW WORKS** - Shows ultimate abilities and percentages
- `/btlwdata equip` - **NOW WORKS** - Queries and shows equipment sets
- `/btlwdata libapi` - Shows library API availability for troubleshooting

## Files Changed
- `Base/Network/GroupBroadcast.lua` - Complete API integration rewrite
- `CHANGELOG.md` - Documented the fix

## Testing Required

### Prerequisites
1. Install LibGroupCombatStats v6+ from ESOUI.com
2. Install LibSetDetection v4+ from ESOUI.com
3. Both libraries must be enabled at character select screen
4. Form a group with at least one other player who also has these libraries

### In-Game Testing Steps

#### Test 1: Verify Library Registration
```
/btlwdata libapi
```
**Expected Output:**
- LibGroupCombatStats: true
- LibSetDetection: true
- Both should show as registered and available

#### Test 2: Check Group Status
```
/btlwdata status
```
**Expected Output:**
- Shows group size
- Lists all group members
- Indicates data availability for each member

#### Test 3: View Ultimate Data (PRIMARY FIX)
```
/btlwdata ults
```
**Expected Output (when in combat or after using abilities):**
```
=== Group Ultimate Details ===
[1] YourCharacterName
    Ability: [Ability Name] (ID: [number])
    Cost: [number]
    Current: [number] / [number] ([percentage]%)
    Status: READY! / Almost ready / Building...
[2] GroupMemberName
    Ability: [Ability Name] (ID: [number])
    Cost: [number]
    Current: [number] / [number] ([percentage]%)
    Status: [status]
```

**Note:** If no data shows initially:
- Data syncs during combat or when using abilities
- All group members must have LibGroupCombatStats installed
- Try entering combat or using an ultimate ability to trigger sync

#### Test 4: View Equipment Data
```
/btlwdata equip
```
**Expected Output:**
```
=== Group Equipment Details ===
[1] YourCharacterName
    [Set Name]: 5 pieces
    [Set Name]: 5 pieces
[2] GroupMemberName
    [Set Name]: 5 pieces
```

**Note:** 
- All group members must have LibSetDetection installed
- Data may take a moment to sync
- Try changing equipment to trigger a data update

### Troubleshooting

#### "No ultimate data received yet"
1. Verify all group members have LibGroupCombatStats installed
2. Enter combat to trigger ultimate data sync
3. Use an ability to generate combat events
4. Check `/btlwdata libapi` to verify library is loaded

#### "LibSetDetection not registered"
1. Verify LibSetDetection is installed and enabled
2. Restart ESO if library was just installed
3. Check addon dependencies in AddOns menu

#### Library API errors
1. Use `/btlwdata libapi` to check which methods are available
2. Ensure library versions meet minimum requirements (v6+ for LGCS, v4+ for LSD)
3. Try `/reloadui` to reinitialize libraries

## Success Criteria
✅ `/btlwdata ults` command displays ultimate data with ability names and percentages
✅ `/btlwdata equip` command displays equipped sets for group members
✅ Data updates in real-time during combat
✅ No Lua errors in chat
✅ Addon loads successfully with all libraries present

## Technical Notes

### Why This Approach?
- **Battle-tested libraries**: LibGroupCombatStats is used by popular addons like Hodor Reflexes
- **Zero custom protocols**: No need to implement custom message IDs (220-229 reserved for future)
- **Efficient networking**: Libraries handle all group broadcast optimizations
- **Reduced complexity**: No stubs, no custom data collectors, just direct integration

### Library Message IDs (Reference Only)
These IDs are used internally by the libraries - we don't send custom messages:
- **20**: Ultimate Type (ability ID + cost) - LibGroupCombatStats
- **21**: Ultimate Value (current/max) - LibGroupCombatStats
- **40**: Equipment Sets - LibSetDetection

### Future Expansion
Message IDs 220-229 are reserved for custom Beltalowda protocols if needed in future phases.
