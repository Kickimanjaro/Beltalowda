# Troubleshooting Guide: Ultimate Data Not Displaying

## Issue
The `/btlwdata ults` command shows "No ultimate data received yet" even when in a group.

## Diagnostic Steps

Follow these steps **in order** to identify the root cause:

### Step 1: Verify Library Installation

Run this command in-game:
```
/btlwdata libapi
```

**Expected Output:**
```
=== Library API Status ===
LibGroupBroadcast: true
  ...
LibGroupCombatStats: true
  Has RegisterAddon: true
  EVENT_GROUP_ULT_UPDATE: [some number]
  EVENT_PLAYER_ULT_UPDATE: [some number]
  Type: table (object)
  Available methods:
    RegisterAddon
    [other methods]
```

**❌ If LibGroupCombatStats shows "false" or "nil":**
- LibGroupCombatStats is NOT installed
- Download from: https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html
- Install to: `Documents/Elder Scrolls Online/live/AddOns/`
- Restart ESO and enable in AddOns menu

**❌ If EVENT_GROUP_ULT_UPDATE or EVENT_PLAYER_ULT_UPDATE show "nil":**
- The library version may be incompatible
- Ensure you have LibGroupCombatStats v6+
- Check for library updates on ESOUI

### Step 2: Check Registration Status

Run this command in-game:
```
/btlwdata debug
```

**Expected Output:**
```
=== Beltalowda Debug Info ===

Registration Status:
  LGCS Instance: true
  LSD Instance: true

LibGroupCombatStats Events:
  EVENT_GROUP_ULT_UPDATE: [number]
  EVENT_PLAYER_ULT_UPDATE: [number]
  RegisterAddon method: true
  Instance type: table
  Instance.RegisterForEvent: true

Group Data Storage:
  [list of unit tags if data received]
  Total entries: [number]
```

**❌ If "LGCS Instance: false":**
- Registration failed during addon initialization
- Check chat log for error messages when addon loaded
- Look for "[Beltalowda] Warning: Failed to register with LibGroupCombatStats"
- May indicate API incompatibility with your library version

**❌ If "Instance.RegisterForEvent: false":**
- The RegisterAddon call succeeded but returned wrong object type
- This indicates a fundamental API mismatch
- Report this with your LibGroupCombatStats version number

**❌ If "Total entries: 0" after being in group for a while:**
- Events are not firing OR
- Event callbacks are not being called OR
- Data structure from events doesn't match expected format

### Step 3: Test Event Firing

The addon now includes debug logging in `OnUltimateDataReceived()`. When you:
1. Enter combat
2. Use an ability
3. Build ultimate

You should see in chat:
```
[Beltalowda] Ultimate data received for [unitTag]
[Beltalowda] Data type: table
  abilityId = [number]
  cost = [number]
  current = [number]
  max = [number]
```

**❌ If you see NO messages at all:**
- Events are not firing
- Possible causes:
  1. Event constants are wrong (check Step 1)
  2. RegisterForEvent call failed silently
  3. Other group members don't have LibGroupCombatStats
  4. Library version incompatibility

**❌ If you see messages but different data structure:**
- The data format has changed in newer library versions
- Report the actual data structure you see
- Code may need adjustment for different field names

### Step 4: Verify Group Member Library Status

The library requires **ALL** group members to have LibGroupCombatStats installed:

```
/btlwdata status
```

**Expected Output:**
```
=== Beltalowda Group Status ===
Group Size: [number]
Group Members:
  [1] YourName (player)
      Data: YES | Ultimate: YES
  [2] OtherPlayer (group1)
      Data: YES | Ultimate: YES
```

**❌ If group members show "Data: NO":**
- That group member doesn't have LibGroupCombatStats installed
- OR they have it but it's not enabled
- OR library versions are incompatible

**Note:** You will only receive ultimate data from group members who also have LibGroupCombatStats installed and running.

## Common Issues and Solutions

### Issue: "Warning: Failed to register with LibGroupCombatStats"
**Cause:** RegisterAddon returned nil
**Solution:** 
- Check LibGroupCombatStats version (need v6+)
- Ensure library is properly loaded (check at character select)
- Try `/reloadui` to reinitialize

### Issue: "Warning: EVENT_GROUP_ULT_UPDATE not available"
**Cause:** The event constant doesn't exist in the library
**Solution:**
- Library version is too old or API changed
- Check what events ARE available with `/btlwdata libapi`
- May need to use different event name based on actual library version

### Issue: Events fire but data is nil
**Cause:** Event signature changed or callback parameters wrong
**Solution:**
- Check debug output for actual parameters received
- May need to adjust callback function signature

### Issue: Data structure different than expected
**Cause:** Library API changed field names
**Solution:**
- Use `/btlwdata debug` and look at actual field names in data
- Common variations:
  - `abilityId` vs `ability` vs `id`
  - `current` vs `value` vs `points`
  - `max` vs `maxValue` vs `maximum`

## Reporting the Issue

If ultimate data still doesn't work after following all steps, provide this information:

1. **Library Versions:**
   - LibGroupCombatStats version: [from ESOUI or AddOns menu]
   - LibGroupBroadcast version: [from ESOUI or AddOns menu]

2. **Output from diagnostic commands:**
   ```
   /btlwdata libapi
   [paste full output]
   
   /btlwdata debug
   [paste full output]
   ```

3. **Debug log output:**
   - What you see in chat when entering combat
   - Any [Beltalowda] messages that appear

4. **Group status:**
   ```
   /btlwdata status
   [paste output]
   ```

5. **Screenshots:**
   - Character select screen showing LibGroupCombatStats enabled
   - In-game chat showing diagnostic output
   - Result of `/btlwdata ults` command

## Expected Behavior When Working

When everything is working correctly:

1. **On addon load:**
   ```
   [Beltalowda] LibGroupCombatStats found - registering addon
   [Beltalowda] Registered for GROUP ultimate updates
   [Beltalowda] Registered for PLAYER ultimate updates
   [Beltalowda] Successfully registered with LibGroupCombatStats
   ```

2. **During combat (debug output):**
   ```
   [Beltalowda] Ultimate data received for player
   [Beltalowda] Data type: table
     abilityId = 123456
     cost = 250
     current = 150
     max = 500
   ```

3. **Using /btlwdata ults:**
   ```
   === Group Ultimate Details ===
   [1] YourName
       Ability: [Ability Name] (ID: 123456)
       Cost: 250
       Current: 150 / 500 (30.0%)
       Status: Building...
   ```

## Next Steps

Based on diagnostic output, the code may need adjustments for:
- Different event constant names
- Different data structure format
- Different callback signature
- Alternative API methods (e.g., polling instead of events)
