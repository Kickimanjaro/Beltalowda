# Network Foundation Testing Guide

## Overview

This guide provides comprehensive instructions for testing the Phase 2 LibGroupBroadcast integration in Beltalowda. The network foundation enables group members to share ultimate and equipment data via well-established ESO addon libraries.

## What Changed from Original Plan

### ❌ OUTDATED References in Issue Description

The original issue description referenced approaches that have been superseded:

1. **"GroupBroadcast stubs"** - No longer needed
   - **Old plan**: Create stub implementations to be filled in later
   - **Current implementation**: Direct integration with existing libraries (no stubs)

2. **"ID allocation"** - Not needed for MVP
   - **Old plan**: Request and implement custom message IDs (220-229)
   - **Current implementation**: Using existing library message IDs (20, 21, 40)
   - **Status**: IDs 220-229 reserved for future expansion but NOT used in current implementation

3. **"Resource broadcasting"** - Changed approach
   - **Old plan**: Create custom protocol to broadcast health, magicka, stamina, ultimate
   - **Current implementation**: Subscribe to LibGroupCombatStats for ultimate data only
   - **Rationale**: Health/magicka/stamina already shown in default UI; only ultimate needed

4. **"Group data structure"** - Simplified
   - **Old plan**: Complex custom data collection modules
   - **Current implementation**: Simple data storage for library-provided data

### ✅ CURRENT Implementation

**What we're actually using:**
- **LibGroupCombatStats** (Message IDs 20, 21) - For ultimate tracking
- **LibSetDetection** (Message ID 40) - For equipment tracking  
- **Direct subscription model** - No custom protocols, no stubs, no custom IDs needed
- **Zero custom message protocols** - 100% reliance on existing libraries

**Benefits:**
- Reduced development time (no need to build custom infrastructure)
- Better compatibility (shared protocols with other addons)
- Battle-tested code (libraries used by popular addons like Hodor Reflexes)
- Reduced network traffic (no redundant custom protocols)

## Prerequisites

### Required Libraries (Must Have)
These libraries are **required** for the addon to load:
- ✅ **LibAsync** (v3.1.1+) - Already installed as dependency
- ✅ **LibGroupBroadcast** (v91+) - Already installed as dependency
- ✅ **LibAddonMenu-2.0** (v41+) - Already installed as dependency

### Required Data Libraries (Must Install)
These libraries are **required** for network features to work:
- ❗ **LibGroupCombatStats** (v6+) - **REQUIRED** for ultimate tracking
- ❗ **LibSetDetection** (v4+) - **REQUIRED** for equipment tracking

### Optional Libraries
- ℹ️ **LibCombat** (v84+) - Currently unused but available for future features

**Without LibGroupCombatStats and LibSetDetection, the addon will not load.**

**Installation:**
1. Download from [ESOUI.com](https://www.esoui.com):
   - [LibGroupCombatStats](https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html)
   - [LibSetDetection](https://www.esoui.com/downloads/info3338-LibSetDetection.html)
2. Extract to `Documents/Elder Scrolls Online/live/AddOns/`
3. Restart ESO if already running
4. Enable in AddOns menu at character select

## Test Commands Reference

Beltalowda provides comprehensive slash commands for testing network functionality:

### Basic Test Commands

#### `/btlwdata help`
**Purpose**: Show all available commands and testing tips

**Usage**:
```
/btlwdata help
/btlwdata
```

**Output**: Full command reference and troubleshooting tips

---

#### `/btlwdata status`
**Purpose**: Quick overview of group status and data availability

**Usage**:
```
/btlwdata status
```

**Expected Output** (when in a 3-player group):
```
=== Beltalowda Group Status ===
Group Size: 3
Group Members:
  [1] PlayerName1 (player)
      Data: YES | Ultimate: YES | Equipment: YES
  [2] PlayerName2 (group1)
      Data: YES | Ultimate: YES | Equipment: NO
  [3] PlayerName3 (group2)
      Data: NO | Ultimate: NO | Equipment: NO

Tip: Use '/btlwdata ults' to see ultimate details
Tip: Use '/btlwdata equip' to see equipment details
```

**Interpretation**:
- `Data: YES` = Received at least some data from this player
- `Ultimate: YES` = Received ultimate data (LibGroupCombatStats working)
- `Equipment: YES` = Received equipment data (LibSetDetection working)
- `Data: NO` = No data received (player may not have libraries installed)

---

#### `/btlwdata group`
**Purpose**: Show all available data for all group members (most detailed)

**Usage**:
```
/btlwdata group
```

**Expected Output**:
```
=== Beltalowda Group Data ===
--- PlayerName1 (player) ---
  Ultimate: 123456 (250 cost)
  Value: 250/500 (50.0%)
  Equipment: 5 sets tracked
--- PlayerName2 (group1) ---
  Ultimate: 789012 (200 cost)
  Value: 200/500 (40.0%)
  No data available
--- PlayerName3 (group2) ---
  No data available
```

---

#### `/btlwdata ults`
**Purpose**: Show detailed ultimate information for all group members

**Usage**:
```
/btlwdata ults
```

**Expected Output**:
```
=== Group Ultimate Details ===
[1] PlayerName1
    Ability: Proximity Detonation (ID: 40012)
    Cost: 250
    Current: 250 / 500 (50.0%)
    Status: Building...
[2] PlayerName2
    Ability: Dawnbreaker (ID: 40161)
    Cost: 125
    Current: 500 / 500 (100.0%)
    Status: READY!
```

**Interpretation**:
- **Ability name** comes from ESO's `GetAbilityName()` API
- **ID** is the ultimate ability ID from LibGroupCombatStats
- **Cost** is the ultimate cost (125, 200, 250, or 500)
- **Current/Max** show ultimate points (always out of max, usually 500)
- **Status** indicates readiness:
  - `READY!` = 100%+ (can cast)
  - `Almost ready` = 75-99%
  - `Building...` = <75%

---

#### `/btlwdata equip`
**Purpose**: Show equipment/set data for all group members

**Usage**:
```
/btlwdata equip
```

**Expected Output** (structure depends on LibSetDetection API):
```
=== Group Equipment Details ===
[1] PlayerName1
    Equipment entries: 3
    Set: Clever Alchemist
    Set: New Moon Acolyte
    Set: Balorgh
[2] PlayerName2
    Equipment entries: 2
    Set: Velidreth
    Set: Rallying Cry
```

**Note**: Equipment data structure may vary depending on LibSetDetection's actual API implementation. The test command will adapt to display whatever structure is received.

---

### Diagnostic Commands

#### `/btlwdata libapi`
**Purpose**: Check which libraries are installed and available

**Usage**:
```
/btlwdata libapi
```

**Expected Output** (all libraries installed):
```
=== Library API Status ===
LibGroupBroadcast: true
  Loaded and available
  Type: table (object)
  Has Send method: true
  Has RegisterForMessage method: true

LibGroupCombatStats: true
  Has RegisterCallback: true
  EVENT_ULTIMATE_TYPE_CHANGED: nil
  EVENT_ULTIMATE_VALUE_CHANGED: nil
  Type: table (object)
  Has method: GetUltimateType
  Has method: GetUltimateValue

LibSetDetection: true
  Has RegisterCallback: true
  EVENT_EQUIPPED_SETS_CHANGED: nil
  Type: table (object)
  Has method: GetEquippedSets

Note: If libraries show 'nil', they are not installed
Install from ESOUI.com to enable full functionality
```

**Interpretation**:
- `true` = Library is installed and loaded
- `false` or `nil` = Library is not installed
- `Has RegisterCallback: true` = Callback API available (expected)
- `EVENT_*: nil` = Event constant not defined (may use different API)
- Method list shows available API functions

**Troubleshooting**: If libraries show `nil`, they are not installed. See Prerequisites section.

---

## Testing Procedures

### Test 1: Solo Verification (No Group Required)

**Purpose**: Verify addon loads without errors and libraries are detected

**Steps**:
1. Load ESO with Beltalowda enabled
2. At character select, verify addon shows in AddOns list
3. Enter game with any character
4. Watch chat for load messages:
   - Should see: `[Beltalowda] 0.1.0 loaded successfully`
   - Should see: `[Beltalowda] Network layer initialized`
5. Run `/btlwdata libapi` to check library status
6. Run `/btlwdata status` (should show "Not in a group")

**Expected Results**:
- ✅ No error messages in chat
- ✅ Load confirmation messages appear
- ✅ `/btlwdata libapi` shows libraries as available (if installed)
- ✅ `/btlwdata status` responds correctly

**If Test Fails**:
- Check for error messages in chat
- Verify all required libraries are installed
- Check `/esoui/Logs/` for Lua errors
- Verify addon is enabled at character select

---

### Test 2: Two-Player Basic Sync

**Purpose**: Verify data syncs between two players

**Prerequisites**:
- Two accounts/characters
- Both have LibGroupCombatStats installed
- Both have LibSetDetection installed
- Both have Beltalowda enabled

**Steps**:
1. **Character A**: Invite Character B to group
2. **Character B**: Accept group invite
3. **Both**: Run `/btlwdata status`
   - Should see each other in group list
4. **Character A**: Run `/btlwdata ults`
   - Should see ultimate data for both players
5. **Character B**: Use any ability (to trigger ultimate data update)
6. **Character A**: Run `/btlwdata ults` again
   - Should see updated ultimate percentage for Character B
7. **Both**: Change equipped gear
8. **Both**: Run `/btlwdata equip`
   - Should see equipment data for both players

**Expected Results**:
- ✅ Both players appear in `/btlwdata status`
- ✅ Ultimate data shows for both players
- ✅ Ultimate updates when abilities are used
- ✅ Equipment data shows for both players
- ✅ Equipment updates when gear is changed

**If Test Fails**:
- Verify both players have libraries installed: `/btlwdata libapi`
- Check for "Data: NO" in `/btlwdata status` (indicates library missing)
- Try combat to trigger more data updates
- Verify both players are using compatible library versions

---

### Test 3: Multi-Player Group (4+ Players)

**Purpose**: Verify network scales to larger groups

**Prerequisites**:
- 4+ players in group
- All have LibGroupCombatStats installed (for ultimate data)
- All have LibSetDetection installed (for equipment data)

**Steps**:
1. Form group with 4+ players
2. Run `/btlwdata status` to verify all players detected
3. Run `/btlwdata ults` to see all ultimates
4. Have each player use abilities
5. Run `/btlwdata ults` again to see updates
6. Run `/btlwdata equip` to verify equipment data

**Expected Results**:
- ✅ All group members show in `/btlwdata status`
- ✅ Ultimate data for all members (if they have library)
- ✅ Equipment data for all members (if they have library)
- ✅ Data updates in real-time as players use abilities
- ✅ No performance degradation with larger group

**Metrics**:
- FPS impact: Should be negligible (<1% drop)
- Memory usage: Check with `/script d(collectgarbage("count"))` before/after
- Update latency: Updates should appear within 1-2 seconds

---

### Test 4: Group Member Leave/Join

**Purpose**: Verify cleanup when players leave group

**Steps**:
1. Form group with 3+ players
2. Run `/btlwdata status` - note all players
3. Have one player leave group
4. Run `/btlwdata status` again
   - Player should be removed from list
5. Invite player back
6. Run `/btlwdata status` again
   - Player should reappear (may need data update trigger)

**Expected Results**:
- ✅ Departed players removed from data
- ✅ Rejoining players added back to data
- ✅ No memory leaks (data properly cleaned up)
- ✅ No errors when players leave/join

---

### Test 5: Library API Compatibility Check

**Purpose**: Verify our API assumptions match actual library implementation

**Prerequisites**: 
- LibGroupCombatStats installed
- LibSetDetection installed
- In a group with at least one other player who has the libraries

**Steps**:
1. Run `/btlwdata libapi` to check API methods available
2. Compare output to expected API in `GroupBroadcast.lua`:
   - LibGroupCombatStats should have `RegisterCallback`
   - LibSetDetection should have `RegisterCallback`
3. Check chat for warning messages like:
   - `[Beltalowda] Warning: LibGroupCombatStats API differs from expected`
   - `[Beltalowda] Error subscribing to LibGroupCombatStats: <error>`
4. If warnings appear, note the actual API methods shown in `/btlwdata libapi`

**Expected Results**:
- ✅ No warning messages about API mismatches
- ✅ `RegisterCallback` method exists on both libraries
- ✅ Data successfully syncs between group members

**If API Differs**:
1. Note the actual API methods shown by `/btlwdata libapi`
2. Check library source code or documentation
3. Update `GroupBroadcast.lua` to use correct API
4. Test again

**Common API Variations**:
- Event names may differ (e.g., `"UltimateChanged"` vs `EVENT_ULTIMATE_CHANGED`)
- Callback signature may differ (e.g., different parameter order)
- Some libraries may use polling instead of callbacks

---

### Test 6: Error Handling (Missing Libraries)

**Purpose**: Verify addon handles missing optional libraries gracefully

**Steps**:
1. **Disable LibGroupCombatStats** (remove from AddOns folder temporarily)
2. Load ESO and enter game
3. Watch for warning message:
   - Should see: `[Beltalowda] Warning: LibGroupCombatStats not found. Ultimate tracking will be limited.`
4. Run `/btlwdata libapi`
   - Should show `LibGroupCombatStats: false`
5. Run `/btlwdata ults`
   - Should show "No ultimate data received yet" with helpful message
6. **Re-enable library** and reload
7. Verify functionality restored

**Expected Results**:
- ✅ Addon loads successfully without optional libraries
- ✅ Clear warning messages explain what's missing
- ✅ No Lua errors or crashes
- ✅ Functionality restored when libraries added back

---

## Troubleshooting

### No Data Shows for Group Members

**Symptoms**: `/btlwdata status` shows "Data: NO" for some/all group members

**Possible Causes**:
1. Group member doesn't have LibGroupCombatStats installed
2. Group member doesn't have LibSetDetection installed
3. Libraries not loaded yet (try after combat)
4. Library versions incompatible

**Solutions**:
1. Have all group members run `/btlwdata libapi` to check their libraries
2. Ensure all members install required libraries from ESOUI.com
3. Try using abilities or changing equipment to trigger data sync
4. Verify all members are using compatible library versions

---

### Ultimate Data Not Updating

**Symptoms**: `/btlwdata ults` shows stale or missing data

**Possible Causes**:
1. LibGroupCombatStats not installed on group member
2. Ultimate hasn't been used recently
3. API mismatch (callback not firing)

**Solutions**:
1. Have player use any ability to trigger ultimate update
2. Check `/btlwdata libapi` for API availability
3. Look for warning messages about API mismatches in chat
4. Enter combat to trigger more frequent updates

---

### Equipment Data Missing

**Symptoms**: `/btlwdata equip` shows no data

**Possible Causes**:
1. LibSetDetection not installed on group member
2. Player has no sets equipped (all non-set gear)
3. API mismatch (callback not firing)

**Solutions**:
1. Verify LibSetDetection installed: `/btlwdata libapi`
2. Have player change equipment to trigger sync
3. Check for warning messages about LibSetDetection API

---

### Library API Mismatch Warnings

**Symptoms**: Chat shows warnings like:
```
[Beltalowda] Warning: LibGroupCombatStats API differs from expected. Manual integration needed.
```

**Cause**: Our API assumptions don't match actual library implementation

**Solutions**:
1. Run `/btlwdata libapi` to see actual API methods
2. Check library documentation or source code
3. Update `GroupBroadcast.lua` callback registration to match actual API
4. Report to developer with API details from `/btlwdata libapi` output

---

## Expected vs Actual Library APIs

### LibGroupCombatStats

**Expected API** (from our implementation):
```lua
LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_TYPE_CHANGED, function(unitTag, abilityId, cost) end)
LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_VALUE_CHANGED, function(unitTag, current, max) end)
```

**Actual API**: To be determined via in-game testing with `/btlwdata libapi`

**If Different**:
- Note the actual method names from `/btlwdata libapi` output
- Update lines 93-104 in `GroupBroadcast.lua` accordingly
- May need to use different event names or callback signatures

---

### LibSetDetection

**Expected API** (from our implementation):
```lua
LSD:RegisterCallback(LSD.EVENT_EQUIPPED_SETS_CHANGED, function(unitTag, sets) end)
```

**Actual API**: To be determined via in-game testing with `/btlwdata libapi`

**If Different**:
- Note the actual method names from `/btlwdata libapi` output  
- Update lines 128-139 in `GroupBroadcast.lua` accordingly
- May need to use different event names or callback signatures

---

## Success Criteria

Network foundation testing is **COMPLETE** when:

- [ ] All test commands work without errors
- [ ] Data syncs between 2+ players in group
- [ ] Ultimate data updates when abilities are used
- [ ] Equipment data updates when gear changes
- [ ] Players leaving/joining group handled correctly
- [ ] Missing libraries handled gracefully with warnings
- [ ] No Lua errors during any test scenario
- [ ] Library APIs verified (or adjusted if needed)
- [ ] Performance acceptable (no FPS drops, no memory leaks)

---

## Next Steps After Testing

Once network foundation testing is complete:

1. **Document API Findings**:
   - Note actual library APIs in testing report
   - Update code if APIs differ from expectations
   - Document any API adjustments made

2. **Report Results**:
   - Create testing summary document
   - Include `/btlwdata libapi` outputs
   - Note any issues or adjustments needed

3. **Proceed to Phase 3** (if testing successful):
   - Enhanced ultimate tracking
   - Ultimate ability detection
   - Dynamic ultimate support (Volendrung)
   - Priority system for cast order

---

## Additional Resources

- **LibGroupCombatStats**: https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html
- **LibSetDetection**: https://www.esoui.com/downloads/info3338-LibSetDetection.html
- **LibGroupBroadcast Wiki**: https://wiki.esoui.com/How_to_share_data_within_groups
- **Implementation Notes**: `.copilot-responses/PHASE2_IMPLEMENTATION_NOTES.md`
- **Phase 2 Complete**: `.copilot-responses/PHASE2_COMPLETE.md`

---

## Summary

The network foundation is **IMPLEMENTED** and ready for testing. This guide provides comprehensive test procedures to validate:

1. ✅ Libraries load correctly
2. ✅ Data syncs between group members  
3. ✅ Ultimate tracking works
4. ✅ Equipment tracking works
5. ✅ Error handling is robust
6. ✅ APIs match our assumptions (or can be adjusted)

Use the test commands (`/btlwdata status`, `/btlwdata ults`, `/btlwdata equip`, `/btlwdata libapi`) to verify each aspect of the network foundation.

**Good luck testing!** 🚀
