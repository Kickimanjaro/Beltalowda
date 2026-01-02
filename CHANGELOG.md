# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

## [0.3.0] - 2026-01-02

### Added
- **LibDebugLogger Integration (Issue #44)**
  - Added LibDebugLogger>=2.0 as optional dependency for advanced logging
  - Created `Base/Util/Logger.lua` wrapper module (395 lines) with graceful fallback to `d()` when LibDebugLogger not installed
  - Implemented 5 debug levels: ERROR (default), WARN, INFO, DEBUG, VERBOSE
  - Module-specific loggers for Network, Ultimates, Equipment, and General modules
  - 200-entry log limit with automatic rotation
  - Non-persistent VERBOSE mode that resets to configured level after `/reloadui`
  - Timestamp support for all log entries
  - In-memory session log storage

- **Enhanced Slash Commands**
  - `/btlwdata debug <module> <level>` - Set debug level for specific module
  - `/btlwdata debug all <level>` - Set all modules to same level
  - `/btlwdata log show [module] [count]` - Show last N log entries (default: 20)
  - `/btlwdata log clear` - Clear current session log
  - `/btlwdata log levels` - Show current debug levels for all modules
  - `/btlwdata log export` - Show SavedVariables file path for log export

- **Documentation**
  - Created `docs/DEBUGGING_GUIDE.md` (413 lines) with comprehensive debugging instructions
  - Includes usage examples for all debug levels
  - Common troubleshooting scenarios with step-by-step solutions
  - LibDebugLogger integration guide
  - Best practices for development, testing, and bug reporting

- **Settings Menu Integration**
  - Created `BeltalowdaSettings.lua` with LibAddonMenu-2.0 integration
  - Added "Debugging & Diagnostics" section in settings
  - Master "Enable Debug Logging" toggle
  - "Default Debug Level" dropdown (ERROR, WARN, INFO, DEBUG, VERBOSE)
  - Module-specific level controls in submenu:
    - Network Module
    - Ultimate Tracking
    - Equipment Tracking
    - General / Core
  - "Max Log Entries" slider (50-500, default 200)
  - "Reset VERBOSE on Reload" checkbox (default ON)
  - "Show Debug Commands" button for quick reference
  - Settings persist in SavedVariables
  - Accessible via `/btlwsettings` or ESO Settings → Add-Ons → Beltalowda

### Changed
- **Network Module Logging Migration**
  - Replaced verbose debug output in `Base/Network/GroupBroadcast.lua` with logger calls
  - Initialization messages now use `logger:Info()`
  - Ultimate data reception uses `logger:Debug()`
  - Ultimate storage confirmation uses `logger:Verbose()`
  - Debug output in `/btlwdata ults` now conditional on DEBUG level
  - User-facing command output (e.g., `/btlwdata` commands) still uses `d()` for visibility
  - Critical initialization errors remain visible to users via `d()`

- **Logger Initialization**
  - Logger now initializes early in `Beltalowda.lua` (after SavedVariables, before modules)
  - Network module creates logger instance during initialization
  - Configuration loaded from and saved to `BeltalowdaVars.logging`

## [0.2.1] - 2026-01-01

### Fixed
- Add enhanced debugging to track unitTag type and key storage in groupData
- Add debug logging to show all keys stored in groupData table to diagnose data persistence issues
- Help identify if data is being stored under wrong key type or lost after storage

## [0.2.0] - 2026-01-01

### Fixed
- **CRITICAL FIX**: Fixed LibGroupCombatStats callback signature - callbacks receive `(eventId, unitTag, data)` not `(unitTag, data)`
- This was causing data to be stored with eventId as the key instead of unitTag
- Ultimate data now correctly stores in groupData table and displays in `/btlwdata ults` command for all group members

## [0.1.9] - 2026-01-01

### Fixed
- **CRITICAL FIX**: Fixed ultimate data storage - data was being received but not stored into ultimate table
- Changed from generic `pairs()` loop to explicit field-by-field storage from LGCS data
- Fixed percentage calculation to use `data.value` instead of `ult.current` (which wasn't set yet)
- Ultimate data should now properly persist and display in `/btlwdata ults` command

## [0.1.8] - 2026-01-01

### Fixed
- Add comprehensive debug logging to `/btlwdata ults` to show exact ultimate table field contents
- Help diagnose why ultimate data shows as received in OnUltimateDataReceived but not displayed

## [0.1.7] - 2026-01-01

### Fixed
- Improved ultimate data display check - now validates that actual data fields exist before attempting to display
- Added fallback checks for both original (`id`, `value`) and normalized (`abilityId`, `current`) field names in display
- Re-added debug logging to OnUltimateDataReceived to diagnose event firing and data reception
- Better handling of empty ultimate data tables

### Changed
- Version bump to 0.1.7 for easier in-game verification

## [0.1.6] - 2026-01-01

### Fixed
- **CRITICAL FIX**: Normalized LGCS field names (`id` → `abilityId`, `value` → `current`) for proper ultimate display
- Removed verbose debug logging now that data structure is confirmed
- `/btlwdata ults` now correctly displays ultimate data for all group members
- Ultimate tracking fully functional with LibGroupCombatStats

## [0.1.5] - 2026-01-01

### Fixed
- Fixed `/btlwdata ults` to display all group members even when ultimate data is pending
- Enhanced debug logging in `OnUltimateDataReceived()` to show actual LGCS data structure
- Improved handling of different LGCS field names (value vs current)
- Better user feedback when ultimate data hasn't synced yet
- Now stores all fields from LGCS data table instead of only expected field names

## [0.1.0] - 2026-01-01

### Added
- **Phase 0: Foundation - Library integration**
  - Created `Beltalowda.txt` manifest with external library dependencies
  - Created `Beltalowda.lua` main initialization file (97 lines)
  - Integrated LibAsync>=3.1.1 for asynchronous operations
  - Integrated LibGroupBroadcast>=91 for network communication
  - Integrated LibAddonMenu-2.0>=41 for settings UI
  - Integrated LibSetDetection>=4 for equipment tracking
  - Implemented library availability checks with clear error messages
  - Added event handlers for ADD_ON_LOADED and PLAYER_ACTIVATED
  - Initialized SavedVariables structure (BeltalowdaVars.version)
  - Created `.copilot-responses/` directory for AI-generated documentation
  - Added `.gitignore` for editor files

- **Phase 2: LibGroupBroadcast Integration** (Implementation Complete)
  - Added LibGroupCombatStats>=6 dependency for ultimate tracking
  - Created `Base/Network/GroupBroadcast.lua` network integration layer (340 lines)
  - Implemented subscription to LibGroupCombatStats ultimate broadcasts (IDs 20-21)
  - Implemented subscription to LibSetDetection equipment broadcasts (ID 40)
  - Created group data structure for storing received data from group members
  - Reserved message IDs 220-229 for future custom protocols
  - Added comprehensive error handling with `pcall()` protection
  - Implemented debug commands: `/btlwdata group`, `/btlwdata ults`, `/btlwdata equip`, `/btlwdata libapi`
  - Added automatic cleanup of departed player data (EVENT_GROUP_MEMBER_LEFT)
  - Created data accessor functions for modules
  - Documented implementation in `.copilot-responses/PHASE2_IMPLEMENTATION_NOTES.md`
  - Created completion summary in `.copilot-responses/PHASE2_COMPLETE.md`

### Changed
- **Architectural Decision**: Use existing well-maintained libraries instead of custom infrastructure
  - No custom data collector modules needed
  - No custom network protocol implementation needed
  - Can proceed directly to feature implementation
  - Libraries handle infrastructure concerns (data collection, networking, UI framework)

### Documentation
- Created `.copilot-responses/PHASE0_COMPLETE.md` documenting architectural decisions
- Created `.copilot-responses/PHASE2_IMPLEMENTATION_NOTES.md` with testing guide
- Created `.copilot-responses/PHASE2_COMPLETE.md` with completion summary
- Updated `copilot-instructions.md` with documentation placement guidelines for AI agents
- Established that AI-generated documentation files should be in `.copilot-responses/` directory

### Testing Required
- Phase 2 requires in-game testing to verify library API compatibility
- Use `/btlwdata libapi` to inspect library APIs in ESO
- Form group to test data synchronization
- May require API adjustment based on actual library implementations

## [0.1.2] - 2026-01-01

### Fixed
- **Fixed LibGroupCombatStats callback signatures**
  - All LGCS events use `callback(unitTag, data)` signature with data as a table
  - Reverted to using `EVENT_PLAYER_ULT_UPDATE` and `EVENT_GROUP_ULT_UPDATE`
  - Removed incorrect separate TYPE/VALUE handlers
  - Added comprehensive debug logging to show data structure received from library
  - Should now properly receive and store ultimate data

## [0.1.1] - 2026-01-01

### Added
- **Added temporary debug logging to TYPE and VALUE event handlers**
  - Logs parameters received in `OnUltimateTypeReceived()` and `OnUltimateValueReceived()`
  - Helps diagnose why ultimate data fields remain nil
  - Shows exact values being passed by LibGroupCombatStats events

### Fixed
- **Fixed LibGroupCombatStats event registration to use correct API**
  - Library uses separate TYPE and VALUE events, not combined UPDATE events
  - Now registers for `EVENT_PLAYER_ULT_TYPE_UPDATE` and `EVENT_PLAYER_ULT_VALUE_UPDATE`
  - Now registers for `EVENT_GROUP_ULT_TYPE_UPDATE` and `EVENT_GROUP_ULT_VALUE_UPDATE`
  - Added separate handlers: `OnUltimateTypeReceived()` for ability ID/cost, `OnUltimateValueReceived()` for current/max
  - Ultimate data fields (abilityId, cost, current, max, percent) should now populate correctly

### Changed
- **Removed verbose debug logging from ultimate data handler**
  - Debug messages were making chat difficult to read
  - Kept only warning messages for error conditions
  - Normal operation is now silent

### Added
- **Added `/btlwdata raw` command for detailed troubleshooting**
  - Shows raw data dump including unitTag mappings
  - Displays all stored data for each group member
  - Helps diagnose unit tag vs player name issues
  - Lists all unitTags in storage for verification

### Fixed
- **Fixed variable shadowing bug in `/btlwdata ults` command**
  - Variable `name` was being shadowed by ability name lookup in `DebugUltimateData()`
  - This caused only one group member's ultimate to display instead of all members
  - Renamed inner variable to `abilityNameResult` to prevent shadowing
  - Now correctly displays ultimate data for all group members who have LibGroupCombatStats
