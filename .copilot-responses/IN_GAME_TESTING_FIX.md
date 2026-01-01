# In-Game Testing Fix - /btlwdata Command Issue

## Problem Statement

During in-game testing of Phase 2 changes (PR #39), users reported that the `/btlwdata libapi` command was not working. The game indicated "not a valid command".

## Root Cause Analysis

The issue was identified in the addon manifest file (`Beltalowda.txt`):

### Before (Broken)
```
## DependsOn: LibAsync>=3.1.1 LibGroupBroadcast>=91 LibAddonMenu-2.0>=41 LibSetDetection>=4 LibCombat>=84 LibGroupCombatStats>=6
```

**Problem**: `LibSetDetection` and `LibGroupCombatStats` were listed as **required dependencies** using `DependsOn`.

In ESO's addon system:
- `DependsOn` = **Hard requirement** - addon will NOT load if dependency is missing
- `OptionalDependsOn` = **Soft requirement** - addon will load even if dependency is missing, but library is used if present

### The Chicken-and-Egg Problem

1. User wants to test if LibGroupCombatStats is installed
2. User runs `/btlwdata libapi` command to check
3. BUT: If LibGroupCombatStats is missing, addon won't load (hard dependency with `DependsOn`)
4. If addon doesn't load, slash commands are never registered
5. Result: "not a valid command" error

### Why This Was Wrong

The code in `Base/Network/GroupBroadcast.lua` already handles missing libraries gracefully:

```lua
if not LGCS then
    d("[Beltalowda] LibGroupCombatStats not available. Ultimate tracking limited.")
    -- Not fatal - continue with limited functionality
else
    d("[Beltalowda] LibGroupCombatStats found - subscribing to ultimate data")
    BeltalowdaNetwork.SubscribeToUltimateData()
end
```

The code was designed to work with **optional** libraries, but the manifest declared them as **required**. This mismatch caused the addon to fail to load when libraries were missing.

## Solution

### After (Fixed)
```
## DependsOn: LibAsync>=3.1.1 LibGroupBroadcast>=91 LibAddonMenu-2.0>=41
## OptionalDependsOn: LibSetDetection>=4 LibCombat>=84 LibGroupCombatStats>=6
```

**Key Change**: Moved LibSetDetection, LibCombat, and LibGroupCombatStats from `DependsOn` to `OptionalDependsOn`. According to ESO addon documentation, `OptionalDependsOn` allows the addon to load even when the libraries are missing.

### Changes Made

1. **Beltalowda.txt** - Moved LibSetDetection, LibCombat, and LibGroupCombatStats to `OptionalDependsOn`
2. **Beltalowda.lua** - Updated library check to only fail on missing required libraries
3. **Base/Network/GroupBroadcast.lua** - Improved error handling
4. **Documentation** - Added clarification that `/btlwdata` is an addon command

### Required vs Optional Libraries

**Required (DependsOn - Must be installed)**:
- `LibAsync>=3.1.1` - Core async operations
- `LibGroupBroadcast>=91` - Network communication foundation
- `LibAddonMenu-2.0>=41` - Settings UI framework

**Optional (OptionalDependsOn - Addon loads without them)**:
- `LibSetDetection>=4` - Equipment tracking (Phase 2 feature)
- `LibCombat>=84` - Combat detection utilities
- `LibGroupCombatStats>=6` - Ultimate tracking (Phase 2 feature)

### Why This Design is Correct

1. **Graceful Degradation**: Addon loads with reduced functionality rather than failing completely
2. **Testability**: Users can run `/btlwdata libapi` to check what's available
3. **User Experience**: Users get warning messages instead of complete failure
4. **Incremental Features**: Phase 2 features work when libraries are present, don't break addon when absent
5. **ESO Standard**: `OptionalDependsOn` is the standard ESO way to declare optional libraries

### Load Order

`OptionalDependsOn` ensures that if the optional libraries are installed, they will load before Beltalowda, allowing proper initialization.

## Verification

After this fix, users should be able to:

1. Load the addon even without LibGroupCombatStats/LibSetDetection **files** installed
2. Run `/btlwdata` command to see help
3. Run `/btlwdata libapi` to check library availability
4. See warning messages for missing optional libraries
5. Install missing libraries if desired to enable full functionality

### Expected Output When Libraries Missing

```
[Beltalowda] Warning: LibSetDetection not found. Equipment tracking will be limited.
[Beltalowda] Warning: LibGroupCombatStats not found. Ultimate tracking will be limited.
[Beltalowda] 0.1.0 loaded successfully
[Beltalowda] LibGroupBroadcast not available. Network features disabled.
```

### Expected Output When Libraries Present

```
[Beltalowda] 0.1.0 loaded successfully
[Beltalowda] LibGroupCombatStats found - subscribing to ultimate data
[Beltalowda] Subscribed to LibGroupCombatStats ultimate data
[Beltalowda] LibSetDetection found - subscribing to equipment data
[Beltalowda] Subscribed to LibSetDetection equipment data
[Beltalowda] Network layer initialized
```

## Answer to User's Question

> "Is this slash command something that we would have had to configure in our addon or is it already provided by LibGroupBroadcast?"

**Answer**: The `/btlwdata` commands are **configured in our addon** (implemented in `Base/Network/GroupBroadcast.lua` lines 306-349). They are NOT provided by LibGroupBroadcast.

LibGroupBroadcast is a **library** that provides networking functionality. It does not provide any slash commands. All slash commands in Beltalowda are implemented by the addon itself.

## Testing Steps

1. **Without Libraries** (to verify fix):
   - Remove/disable LibGroupCombatStats and LibSetDetection
   - Load ESO
   - Verify addon loads successfully
   - Run `/btlwdata` - should show help
   - Run `/btlwdata libapi` - should show library status (all showing as not available)

2. **With Libraries** (to verify full functionality):
   - Install LibGroupCombatStats and LibSetDetection from ESOUI
   - Load ESO
   - Verify addon loads successfully
   - Run `/btlwdata libapi` - should show libraries as available
   - Form group and test data synchronization

## Related Files

- `Beltalowda.txt` - Addon manifest (dependencies)
- `Beltalowda.lua` - Main initialization (library checks)
- `Base/Network/GroupBroadcast.lua` - Network layer (slash commands)
- `CHANGELOG.md` - Version history (documented fix)
- `README.md` - User documentation (command reference)

## Date Fixed

January 1, 2026

## Issue Reference

Based on feedback from in-game testing following PR #39 (LibGroupBroadcast Phase 2 integration).
