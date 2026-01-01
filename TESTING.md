# Phase 0 Testing Guide

This guide provides instructions for testing the Phase 0 Foundation implementation in The Elder Scrolls Online.

## Installation

1. **Copy addon to ESO directory**:
   ```
   Copy the entire Beltalowda folder to:
   Documents/Elder Scrolls Online/live/AddOns/
   ```

2. **Verify directory structure**:
   ```
   AddOns/Beltalowda/
   ├── Beltalowda.txt
   ├── Beltalowda.lua
   ├── Base/
   └── Lib/
   ```

## In-Game Testing

### 1. Load the Game

Launch ESO and log in to a character.

### 2. Verify Addon Loaded

Open the chat console and check for load messages:

**Expected Messages**:
```
[Beltalowda] 0.1.0 loaded successfully
[Beltalowda] DataCollector: Initializing coordinator
[Beltalowda] ResourceCollector: Initializing
[Beltalowda] PositionCollector: Initializing
[Beltalowda] AbilityCollector: Initializing
[Beltalowda] EquipmentCollector: Initializing
[Beltalowda] StateCollector: Initializing
[Beltalowda] GroupBroadcast: Initializing network layer
[Beltalowda] All modules initialized
[Beltalowda] Player activated (initial: true)
```

### 3. Check Addon Status

Press `/` to open chat and run these commands:

```lua
/script d(Beltalowda ~= nil)
```
**Expected**: `true`

```lua
/script d(Beltalowda.version)
```
**Expected**: `0.1.0`

### 4. Verify Libraries Loaded

```lua
/script d(LibStub ~= nil)
```
**Expected**: `true`

```lua
/script d(LibAsync ~= nil)
```
**Expected**: `true` (stub implementation)

```lua
/script d(LibSets ~= nil)
```
**Expected**: `true` (stub implementation)

### 5. Verify Modules Initialized

```lua
/script d(Beltalowda.data ~= nil)
```
**Expected**: `true`

```lua
/script d(Beltalowda.data.collector ~= nil)
```
**Expected**: `true`

```lua
/script d(Beltalowda.network ~= nil)
```
**Expected**: `true`

### 6. Check Individual Collectors

```lua
/script d(Beltalowda.data.resources.state.initialized)
```
**Expected**: `true`

```lua
/script d(Beltalowda.data.equipment.state.initialized)
```
**Expected**: `true` (or `nil` if LibSets stub doesn't load properly)

```lua
/script d(Beltalowda.data.state.state.initialized)
```
**Expected**: `true`

### 7. Test Data Access Functions

```lua
/script d(Beltalowda.data.resources.GetResources())
```
**Expected**: Table with zero values (stubs don't collect real data yet)

```lua
/script d(Beltalowda.data.state.GetState())
```
**Expected**: Table with default state values

### 8. Check SavedVariables

```lua
/script d(BeltalowdaVars)
```
**Expected**: Table with `version = "0.1.0"`

## Expected Behavior

### ✅ Success Indicators

1. **No Lua Errors**: No red error text in chat
2. **Load Messages**: All "Initializing" messages appear
3. **Modules Present**: All namespace checks return `true`
4. **Functions Callable**: GetResources() and other functions work
5. **SavedVariables**: BeltalowdaVars exists

### ❌ Failure Indicators

1. **Lua Errors**: Red error messages appear
2. **Missing Library**: "Missing required libraries" message
3. **Nil References**: Namespace checks return `nil`
4. **No Load Message**: No "[Beltalowda] loaded" message

## Troubleshooting

### Issue: Addon Not Loading

**Check**:
1. Beltalowda.txt is in the correct directory
2. AddOns are enabled in ESO settings
3. No typos in file names

**Solution**:
- Verify folder structure matches installation guide
- Check ESO AddOns menu (Settings > AddOns)
- Reload UI: `/reloadui`

### Issue: Missing Library Errors

**Check**:
1. LibStub is installed (should be in base game or other addons)
2. Lib folders exist in Beltalowda/Lib/

**Solution**:
- Install LibStub if missing (usually included with other addons)
- Verify LibAsync and LibSets stub folders exist

### Issue: Module Not Initializing

**Check**:
1. Look for specific error messages
2. Check which module failed to initialize

**Solution**:
- Look for typos in file names
- Verify manifest (Beltalowda.txt) lists all files
- Check for Lua syntax errors in the module file

## Phase 0 Completion Checklist

- [ ] Addon loads without errors
- [ ] All initialization messages appear
- [ ] Beltalowda namespace exists
- [ ] LibAsync stub loaded
- [ ] LibSets stub loaded
- [ ] All 6 data collectors initialized
- [ ] Network layer initialized
- [ ] SavedVariables created
- [ ] No Lua errors in console

## Next Steps After Testing

If all tests pass:

1. ✅ **Phase 0 Complete**: Foundation is solid
2. 📋 **Week 2 Research**: Investigate LibGroupCombatStats, LibSetDetection, LibGroupResources
3. 🔨 **Phase 1 Ready**: Begin implementing actual data collection

If tests fail:

1. 🔍 **Debug**: Use troubleshooting guide above
2. 📝 **Report**: Note specific errors and which tests failed
3. 🛠️ **Fix**: Address issues before proceeding to Phase 1

## Debug Commands (Future)

These commands will be implemented in Phase 1:

```lua
/btlwdata resources  -- Show resource data (Phase 1)
/btlwdata state      -- Show state data (Phase 1)
/btlwdata abilities  -- Show ability data (Phase 1/6)
/btlwdata equipment  -- Show equipment data (Phase 4)
/btlwdata group      -- Show group data (Phase 2)
```

## Notes

- **Stub Libraries**: Current LibAsync and LibSets are minimal stubs
- **No Functionality**: Collectors don't gather real data yet (Phase 1)
- **No Broadcasting**: Network layer is stub only (Phase 2)
- **No UI**: No visual elements yet (Phase 3+)

This is **infrastructure only** - the foundation for future features.

---

**Testing Phase**: Phase 0 Foundation  
**Expected Result**: Clean load, no errors, all modules initialized  
**Next Phase**: Phase 1 - Data Collection (Weeks 3-4)
