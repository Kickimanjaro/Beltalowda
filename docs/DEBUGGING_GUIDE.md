# Beltalowda Debugging Guide

This guide explains how to use Beltalowda's integrated logging and debugging features to troubleshoot issues and understand addon behavior.

## Table of Contents
- [Quick Start](#quick-start)
- [Debug Levels](#debug-levels)
- [Setting Debug Levels](#setting-debug-levels)
- [Viewing Logs](#viewing-logs)
- [LibDebugLogger Integration](#libdebuglogger-integration)
- [Common Troubleshooting Scenarios](#common-troubleshooting-scenarios)

## Quick Start

### Enabling Debug Logging

1. **Using Slash Commands:**
   ```
   /btlwdata debug Network DEBUG
   /btlwdata debug all INFO
   ```

2. **Using Settings Menu:**
   - Open ESO Settings
   - Navigate to Add-Ons → Beltalowda
   - Find "Debugging & Diagnostics" section
   - Set debug levels for each module

### Viewing Logs

```
/btlwdata log show          # Show last 20 log entries
/btlwdata log show Network  # Show Network module logs only
/btlwdata log levels        # Show current debug levels
```

## Debug Levels

Beltalowda uses 5 debug levels, from least to most verbose:

### 1. ERROR (Default)
- **When to use:** Normal operation
- **What you'll see:** Only critical failures that prevent functionality
- **Example messages:**
  - "Failed to register for LGCS events"
  - "LibGroupBroadcast not available"

### 2. WARN
- **When to use:** When investigating potential issues
- **What you'll see:** Warnings about unusual conditions
- **Example messages:**
  - "GetAbilityName returned nil for abilityId"
  - "Group member data not available yet"

### 3. INFO
- **When to use:** Monitoring addon initialization and major milestones
- **What you'll see:** Important events and successful operations
- **Example messages:**
  - "LibGroupCombatStats initialized successfully"
  - "Network layer initialized"
  - "LibSetDetection found - registering addon"

### 4. DEBUG
- **When to use:** Active troubleshooting of specific issues
- **What you'll see:** Normal debugging output with detailed information
- **Example messages:**
  - "Ultimate type received: player, id=12345, cost=250"
  - "Processing group member: @PlayerName"

### 5. VERBOSE
- **When to use:** Deep debugging of complex issues
- **What you'll see:** Extremely detailed trace logging
- **Example messages:**
  - "Raw event data: {id=12345, value=100, max=500}"
  - "Stored ultimate data under key 'group1'"
- **Special behavior:** Automatically resets to configured level after `/reloadui`

## Setting Debug Levels

### Using Slash Commands

Set level for a specific module:
```
/btlwdata debug Network VERBOSE
/btlwdata debug Ultimates DEBUG
/btlwdata debug Equipment INFO
/btlwdata debug General WARN
```

Set all modules to the same level:
```
/btlwdata debug all DEBUG
```

Available modules:
- **Network** - Group communication and data synchronization
- **Ultimates** - Ultimate tracking and display
- **Equipment** - Equipment and set detection
- **General** - Core addon functionality

### Using Settings Menu

1. Open ESO Settings → Add-Ons → Beltalowda
2. Scroll to "Debugging & Diagnostics" section
3. Enable "Enable Debug Logging" checkbox (master switch)
4. Set "Default Debug Level" (applies to all modules)
5. Expand "Module-Specific Levels" for per-module control
6. Adjust "Max Log Entries" slider (50-500, default 200)
7. Toggle "Reset VERBOSE on reload" (recommended: ON)

### Configuration Persistence

- Debug levels are saved in `SavedVariables/Beltalowda.lua`
- Settings persist across sessions
- VERBOSE mode resets to configured level on `/reloadui` (by default)

## Viewing Logs

### Show Recent Logs

Show last 20 entries:
```
/btlwdata log show
```

Show last N entries (up to log limit):
```
/btlwdata log show 50
```

Filter by module:
```
/btlwdata log show Network
/btlwdata log show Network 30
```

### Check Current Configuration

View all module levels:
```
/btlwdata log levels
```

Example output:
```
=== Current Debug Levels ===
  Network: DEBUG
  Ultimates: INFO
  Equipment: ERROR
  General: ERROR

Max log entries: 200
VERBOSE reset on reload: ON
```

### Clear Logs

Clear session log (in-memory):
```
/btlwdata log clear
```

Note: Logs are automatically rotated when they exceed the configured maximum (default: 200 entries).

### Export Logs

Get SavedVariables file path:
```
/btlwdata log export
```

**File Locations:**
- **Windows:** `Documents\Elder Scrolls Online\live\SavedVariables\Beltalowda.lua`
- **Mac:** `Documents/Elder Scrolls Online/live/SavedVariables/Beltalowda.lua`

## LibDebugLogger Integration

### What is LibDebugLogger?

LibDebugLogger is an optional library that provides advanced logging features:
- Persistent log storage
- Advanced filtering and search
- Export to external tools
- Minimal performance impact

### Installing LibDebugLogger

1. Download from [ESOUI.com](https://www.esoui.com/downloads/info2275-LibDebugLogger.html)
2. Extract to `Documents\Elder Scrolls Online\live\AddOns\`
3. Restart ESO
4. Beltalowda will automatically detect and use it

### Using LibDebugLogger

When LibDebugLogger is installed:
- All Beltalowda logs are sent to LibDebugLogger
- Use LibDebugLogger's UI to view and filter logs
- Logs persist across sessions and `/reloadui`
- Export logs for bug reports or analysis

When LibDebugLogger is NOT installed:
- Logs use fallback mode (output to chat)
- Only ERROR and WARN messages appear in chat
- Session logs stored in-memory (cleared on `/reloadui`)
- Use `/btlwdata log show` to view in-memory logs

### Checking LibDebugLogger Status

```
/btlwdata log export
```

This command will tell you:
- Whether LibDebugLogger is installed
- Where to find logs
- How to access SavedVariables

## Common Troubleshooting Scenarios

### Scenario 1: Group Data Not Syncing

**Problem:** `/btlwdata ults` shows "No data available yet"

**Debug Steps:**
1. Enable Network module debugging:
   ```
   /btlwdata debug Network DEBUG
   ```

2. Use an ability to trigger ultimate update

3. Check if events are being received:
   ```
   /btlwdata log show Network
   ```

4. Look for messages like:
   - "Ultimate type received" - Good! Events are working
   - No messages - Events not firing, check library installation

5. Verify libraries are loaded:
   ```
   /btlwdata libapi
   ```

**Expected Result:** You should see DEBUG messages when ultimate data is received.

### Scenario 2: Investigating Performance Issues

**Problem:** Addon seems slow or laggy

**Debug Steps:**
1. Check current log levels:
   ```
   /btlwdata log levels
   ```

2. If any module is set to VERBOSE, reduce it:
   ```
   /btlwdata debug all ERROR
   ```

3. Enable only INFO level to monitor major operations:
   ```
   /btlwdata debug all INFO
   ```

4. Monitor log size:
   ```
   /btlwdata log levels  # Check "Max log entries"
   ```

**Expected Result:** VERBOSE mode can generate many log entries. Reducing verbosity improves performance.

### Scenario 3: Ultimate Tracking Not Working

**Problem:** Ultimates not displaying correctly

**Debug Steps:**
1. Enable Ultimates module debugging:
   ```
   /btlwdata debug Ultimates DEBUG
   /btlwdata debug Network DEBUG
   ```

2. Check raw ultimate data:
   ```
   /btlwdata ults
   ```

3. Look for debug messages in logs:
   ```
   /btlwdata log show
   ```

4. Verify LGCS is working:
   ```
   /btlwdata debug
   ```

**Expected Result:** DEBUG logs show ultimate data being received and processed.

### Scenario 4: Preparing a Bug Report

**Problem:** Need to provide logs for a bug report

**Steps:**
1. Set relevant modules to DEBUG or VERBOSE:
   ```
   /btlwdata debug all DEBUG
   ```

2. Reproduce the issue

3. Export logs:
   - If LibDebugLogger is installed: Use LibDebugLogger's export
   - If not: Copy output from `/btlwdata log show 100`

4. Include configuration:
   ```
   /btlwdata log levels
   ```

5. Include library status:
   ```
   /btlwdata libapi
   ```

6. Share SavedVariables file (if requested):
   - Location shown in `/btlwdata log export`

### Scenario 5: VERBOSE Mode Stuck After Testing

**Problem:** Chat is flooded with debug messages after testing

**Quick Fix:**
```
/btlwdata debug all ERROR
```

**Permanent Fix:**
1. Ensure "Reset VERBOSE on reload" is enabled in settings
2. Do `/reloadui`
3. VERBOSE will reset to configured level

## Best Practices

### During Development/Testing
- Use DEBUG or VERBOSE for active troubleshooting
- Clear logs between tests: `/btlwdata log clear`
- Enable VERBOSE reset to prevent chat spam after reload

### During Normal Play
- Keep all modules at ERROR (default)
- Enable INFO only if monitoring initialization
- Install LibDebugLogger to capture errors without chat spam

### When Reporting Bugs
- Enable DEBUG for relevant modules
- Reproduce the issue
- Capture logs immediately
- Include output from `/btlwdata log levels` and `/btlwdata libapi`

### Performance Considerations
- VERBOSE mode generates many log entries
- Large log buffers (>200) can use more memory
- DEBUG mode has minimal impact
- ERROR/WARN have negligible impact

## Advanced Tips

### Temporary VERBOSE Mode
Enable VERBOSE just for investigation, and it will auto-reset:
```
/btlwdata debug Network VERBOSE
# ... do your testing ...
/reloadui
# Network is now back to configured level (e.g., ERROR)
```

### Filtering Logs by Module
When debugging a specific feature:
```
/btlwdata debug Network DEBUG
/btlwdata debug all ERROR      # Set others to ERROR
/btlwdata log show Network     # Only see Network logs
```

### Watching Live Logs
For real-time monitoring with LibDebugLogger:
1. Open LibDebugLogger viewer
2. Filter to "Beltalowda"
3. Enable auto-scroll
4. Set desired log level

### Log Rotation Management
Adjust log buffer size based on needs:
- Small buffer (50): Low memory, good for targeted debugging
- Medium buffer (200): Default, good balance
- Large buffer (500): Captures more history, uses more memory

Change in settings menu or by editing SavedVariables directly.

## Support

If you're still experiencing issues after debugging:
1. Collect logs using steps in "Preparing a Bug Report"
2. Post in addon discussion on ESOUI.com
3. Include ESO version and addon version
4. Include list of other installed addons (if relevant)

Remember: Good logs make troubleshooting much easier! When in doubt, enable DEBUG mode and capture logs before reporting issues.
