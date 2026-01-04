# Beltalowda UI Framework - Testing Guide

## Overview

This guide provides comprehensive testing procedures for the Phase 4 UI framework implementation. Use this to validate that all features work correctly before finalizing Week 10.

## Prerequisites

### Required Libraries
Ensure all dependencies are installed:
- ✅ LibAsync >= 3.1.1
- ✅ LibGroupBroadcast >= 91
- ✅ LibAddonMenu-2.0 >= 41
- ✅ LibGroupCombatStats >= 6
- ✅ LibSetDetection >= 4

### Optional Libraries
- LibDebugLogger >= 2.0 (for enhanced debugging)

### Test Environment
- ESO client with addon development enabled
- At least one alt account or friend for group testing
- Access to Cyrodiil or any PvP area (optional, but recommended)

## Test Plan

### Phase 1: Solo Installation Testing

#### Test 1.1: Addon Loads Without Errors

**Steps:**
1. Install Beltalowda 0.4.0
2. Launch ESO
3. At character select, check for addon load errors
4. Log in to a character
5. Watch chat for initialization messages

**Expected Results:**
```
[Beltalowda] Loading GroupBroadcast.lua...
[Beltalowda] 0.4.0 loaded successfully
[Beltalowda] Player activated (initial: true)
[Beltalowda] Initializing Group Ultimate Display UI
[Beltalowda] Group Ultimate Display UI initialized
[Beltalowda] Initializing Client Ultimate Selector
[Beltalowda] Client Ultimate Selector initialized
```

**Pass Criteria:**
- ✅ No Lua errors in chat
- ✅ All initialization messages appear
- ✅ No error dialog boxes

#### Test 1.2: UI Windows Visible

**Steps:**
1. After loading into game world, look for UI windows
2. Check top-left area for Group Ultimate Display
3. Check for Client Ultimate Selector box

**Expected Results:**
- Group Ultimate Display visible with 12 ultimate icon columns
- Client Ultimate Selector visible as single icon box
- Windows have semi-transparent backgrounds (unlocked state)

**Pass Criteria:**
- ✅ Both windows visible
- ✅ Windows positioned on screen
- ✅ No graphical glitches or missing textures

#### Test 1.3: Slash Commands Work

**Steps:**
1. Type `/btlwui` in chat (no arguments)
2. Verify help text appears
3. Test each command:
   - `/btlwui toggle` - UI should hide/show
   - `/btlwui lock` - Backgrounds should hide/show
   - `/btlwui refresh` - Should show "Display refreshed" message

**Expected Results:**
- Help text displays all available commands
- Toggle command hides/shows UI
- Lock command toggles movable state
- Refresh command works without errors

**Pass Criteria:**
- ✅ All commands execute without errors
- ✅ UI responds correctly to each command
- ✅ Feedback messages appear in chat

#### Test 1.4: Settings Menu Integration

**Steps:**
1. Type `/btlwsettings`
2. Navigate to "User Interface" section
3. Test each setting:
   - Toggle "Enable Group Ultimate Display"
   - Toggle "Enable Client Ultimate Selector"
   - Toggle "Lock UI Windows"
   - Adjust "UI Scale" slider
   - Adjust "UI Opacity" slider

**Expected Results:**
- Settings menu opens without errors
- All UI controls visible and functional
- Changes apply immediately to UI
- Settings persist after `/reloadui`

**Pass Criteria:**
- ✅ Settings menu opens
- ✅ All controls functional
- ✅ Changes apply in real-time
- ✅ Settings saved to SavedVariables

### Phase 2: Solo Functionality Testing

#### Test 2.1: Client Ultimate Selector - Ultimate Detection

**Steps:**
1. Ensure you have an ultimate slotted on front bar
2. Observe Client Ultimate Selector icon
3. Swap to back bar (if different ultimate slotted)
4. Click the selector icon

**Expected Results:**
- Selector shows your front bar ultimate icon
- Clicking cycles between front bar and back bar ultimates
- Ultimate name appears in chat
- Icon updates immediately

**Pass Criteria:**
- ✅ Correct ultimate icon displayed
- ✅ Click cycles between ultimates
- ✅ Chat feedback shows ultimate name
- ✅ No errors when clicking

#### Test 2.2: Client Ultimate Selector - Tooltip

**Steps:**
1. Hover mouse over Client Ultimate Selector icon
2. Verify tooltip appears
3. Check tooltip content
4. Move mouse away

**Expected Results:**
- Tooltip appears on hover
- Shows ultimate name
- Shows ultimate cost
- Shows "Click to cycle ultimates" text
- Tooltip disappears when mouse moves away

**Pass Criteria:**
- ✅ Tooltip displays
- ✅ Information is correct
- ✅ Tooltip hides properly

#### Test 2.3: Client Ultimate Selector - Drag and Reposition

**Steps:**
1. Ensure UI is unlocked (`/btlwui lock` if needed)
2. Click and drag Client Ultimate Selector
3. Move to different screen position
4. Release mouse
5. Type `/reloadui`
6. Verify position persisted

**Expected Results:**
- Window drags smoothly
- Position updates when released
- Position saves to SavedVariables
- Position persists after reload

**Pass Criteria:**
- ✅ Window is draggable when unlocked
- ✅ Window not draggable when locked
- ✅ Position saves correctly
- ✅ Position persists after reload

#### Test 2.4: Group Ultimate Display - Window Controls

**Steps:**
1. Unlock UI
2. Drag Group Ultimate Display to new position
3. Lock UI
4. Try to drag (should not move)
5. Reload UI
6. Verify position persisted

**Expected Results:**
- Window moves when unlocked
- Window does not move when locked
- Position saves and persists

**Pass Criteria:**
- ✅ Drag works when unlocked
- ✅ Drag blocked when locked
- ✅ Position saves correctly

#### Test 2.5: Group Ultimate Display - Scale and Opacity

**Steps:**
1. Open settings: `/btlwsettings`
2. Set UI Scale to 0.5
3. Verify UI shrinks
4. Set UI Scale to 2.0
5. Verify UI grows
6. Set UI Opacity to 0.3
7. Verify UI becomes more transparent
8. Reset to defaults (Scale: 1.0, Opacity: 1.0)

**Expected Results:**
- Scale changes affect window size
- Opacity changes affect transparency
- Changes apply immediately
- UI remains functional at all scales/opacities

**Pass Criteria:**
- ✅ Scale control works
- ✅ Opacity control works
- ✅ No visual glitches at extreme values
- ✅ UI remains usable

### Phase 3: Group Testing

**Note:** This phase requires at least one other player with the addon installed.

#### Test 3.1: Group Formation and Data Sync

**Steps:**
1. Form a group with another player
2. Both players use abilities to generate ultimate
3. Check Group Ultimate Display for group member data
4. Use `/btlwdata status` to verify data sync

**Expected Results:**
- Group member appears in UI
- Ultimate data syncs from LibGroupCombatStats
- Player block shows group index, name, and ultimate percentage
- Color coding reflects ultimate charge level

**Pass Criteria:**
- ✅ Group member visible in UI
- ✅ Ultimate percentage displays correctly
- ✅ Color coding works (gray→orange→yellow→green)
- ✅ No Lua errors during sync

#### Test 3.2: Multi-Player Testing

**Steps:**
1. Form a group with 4+ players (if possible)
2. All players use various ultimates
3. Observe player blocks stacking beneath ultimate icons
4. Verify each player shows in correct ultimate column

**Expected Results:**
- Multiple player blocks stack vertically
- Each player appears under their slotted ultimate
- No overlapping or layout issues
- All group indices display correctly

**Pass Criteria:**
- ✅ Player blocks stack correctly
- ✅ No layout glitches
- ✅ Group indices accurate
- ✅ Performance acceptable

#### Test 3.3: Ultimate Change Detection

**Steps:**
1. In a group, change your slotted ultimate
2. Observe if UI updates
3. Use Client Ultimate Selector to change selection
4. Verify visual feedback

**Expected Results:**
- UI detects ultimate changes
- Display updates when ultimates change
- Client selector updates immediately
- Chat feedback shows changes

**Pass Criteria:**
- ✅ Ultimate changes detected
- ✅ UI updates correctly
- ✅ No errors during updates

#### Test 3.4: Group Member Leave/Join

**Steps:**
1. Have a group member leave
2. Verify their player block disappears
3. Have them rejoin
4. Verify their player block reappears

**Expected Results:**
- Player block removes when member leaves
- Display updates automatically
- Player block adds when member rejoins
- No orphaned blocks or errors

**Pass Criteria:**
- ✅ Blocks removed on leave
- ✅ Blocks added on join
- ✅ No orphaned data
- ✅ No errors

### Phase 4: Keybind Testing

#### Test 4.1: Configure Keybinds

**Steps:**
1. Open ESO Controls settings
2. Navigate to "Beltalowda" section
3. Bind a key to "Toggle Group Ultimate Display"
4. Bind a key to "Toggle Client Ultimate Selector"
5. Bind a key to "Toggle UI Lock"
6. Bind a key to "Cycle Selected Ultimate"

**Expected Results:**
- Beltalowda category appears in controls
- All keybind options visible
- Keys can be assigned
- No conflicts with existing binds

**Pass Criteria:**
- ✅ Category exists
- ✅ All keybinds present
- ✅ Can assign keys
- ✅ Assignments save

#### Test 4.2: Execute Keybinds

**Steps:**
1. Press key for "Toggle Group Ultimate Display"
2. Verify UI hides/shows
3. Press key for "Toggle Client Ultimate Selector"
4. Verify selector hides/shows
5. Press key for "Toggle UI Lock"
6. Verify lock state changes
7. Press key for "Cycle Selected Ultimate"
8. Verify ultimate cycles

**Expected Results:**
- All keybinds execute actions
- UI responds correctly
- No errors or lag
- Feedback in chat where appropriate

**Pass Criteria:**
- ✅ All keybinds work
- ✅ Actions execute correctly
- ✅ No errors
- ✅ Responsive performance

### Phase 5: Stress Testing

#### Test 5.1: Large Group (12 Players)

**Steps:**
1. Form largest possible group (12 players ideally)
2. All players use various ultimates
3. Observe Group Ultimate Display
4. Monitor FPS and performance

**Expected Results:**
- All 12 players visible
- Player blocks distribute across ultimate columns
- No performance degradation
- UI remains responsive

**Pass Criteria:**
- ✅ Handles 12 players
- ✅ No visual glitches
- ✅ FPS impact < 5%
- ✅ No errors or crashes

#### Test 5.2: Extended Session

**Steps:**
1. Keep addon running for 30+ minutes
2. Actively use ultimates
3. Change group composition
4. Monitor for memory leaks or errors

**Expected Results:**
- Addon runs stably
- No memory leaks
- No accumulated errors
- Performance remains consistent

**Pass Criteria:**
- ✅ No crashes
- ✅ Memory usage stable
- ✅ No error accumulation
- ✅ Performance consistent

### Phase 6: Edge Cases and Error Handling

#### Test 6.1: No Group

**Steps:**
1. Leave all groups
2. Verify UI still works
3. Only player's own data should show

**Expected Results:**
- UI remains visible
- No errors
- Only shows player data (if any)

**Pass Criteria:**
- ✅ No errors when solo
- ✅ UI functional
- ✅ Graceful handling

#### Test 6.2: No Ultimate Slotted

**Steps:**
1. Unslot your ultimate
2. Observe Client Ultimate Selector
3. Try clicking selector

**Expected Results:**
- Selector shows default icon
- Click provides feedback message
- No errors

**Pass Criteria:**
- ✅ No errors
- ✅ Handles missing ultimate gracefully
- ✅ User feedback provided

#### Test 6.3: SavedVariables Corruption

**Steps:**
1. Exit game
2. Edit SavedVariables to have invalid data
3. Launch game
4. Verify addon recovers

**Expected Results:**
- Addon loads despite bad data
- Resets to defaults
- User notified of reset (optional)

**Pass Criteria:**
- ✅ Addon loads
- ✅ No crashes
- ✅ Defaults restored

## Debug Commands for Testing

Use these commands during testing:

```
/btlwdata status    - Check data sync status
/btlwdata ults      - View ultimate data for all group members
/btlwdata raw       - Raw data dump for troubleshooting
/btlwui toggle      - Toggle UI visibility
/btlwui lock        - Toggle UI lock
/btlwui refresh     - Force UI refresh
/btlwsettings       - Open settings menu
```

## Debugging Tips

### Enable Debug Logging

```
/btlwdata debug Network DEBUG
/btlwdata debug Ultimates DEBUG
```

### View Recent Logs

```
/btlwdata log show
/btlwdata log show Network 50
```

### Check LibGroupCombatStats

```
/btlwdata libapi
```

## Known Issues to Document

During testing, document any issues found:

1. **Visual Issues**: Layout problems, overlapping, missing textures
2. **Performance Issues**: FPS drops, lag, memory usage
3. **Data Issues**: Sync failures, incorrect values, stale data
4. **Usability Issues**: Confusing behavior, missing feedback, unclear UI

## Success Criteria

Phase 4 is complete when:

- ✅ All Solo Installation tests pass
- ✅ All Solo Functionality tests pass
- ✅ Basic Group Testing passes (2+ players)
- ✅ Keybinds functional
- ✅ No critical bugs or crashes
- ✅ Performance acceptable (< 5% FPS impact)
- ✅ User documentation complete and accurate

## Next Steps (Week 10)

After testing completes:

1. Document all findings
2. Fix critical bugs
3. Implement broadcasting of selected ultimate
4. Add any missing features from issue requirements
5. Final polish and refinement
6. Update documentation based on test results

## Test Report Template

```
# Beltalowda UI Test Report - v0.4.0

**Tester:** [Your Name]
**Date:** [Date]
**Environment:** [ESO version, OS, addons installed]

## Test Results Summary
- Solo Installation: [PASS/FAIL]
- Solo Functionality: [PASS/FAIL]
- Group Testing: [PASS/FAIL]
- Keybind Testing: [PASS/FAIL]
- Stress Testing: [PASS/FAIL]
- Edge Cases: [PASS/FAIL]

## Issues Found
1. [Issue description]
   - Severity: [Critical/High/Medium/Low]
   - Steps to reproduce: [...]
   - Expected: [...]
   - Actual: [...]

## Performance Notes
- FPS Impact: [X%]
- Memory Usage: [X MB]
- Group Size Tested: [X players]
- Session Duration: [X minutes]

## Recommendations
[Any suggestions for improvements]

## Screenshots
[Attach relevant screenshots]
```
