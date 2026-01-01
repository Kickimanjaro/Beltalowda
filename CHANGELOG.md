# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

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

## [Unreleased]

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

### Added
- **Enhanced debugging capabilities for troubleshooting ultimate data**
  - Added `/btlwdata debug` command to show registration status, event constants, and data storage
  - Enhanced `/btlwdata libapi` to show all event constants and methods from LibGroupCombatStats
  - Added debug logging in `OnUltimateDataReceived()` to trace when events fire and what data is received
  - Debug logs will show data structure to help identify API mismatches

### Fixed
- **Corrected LibGroupCombatStats and LibSetDetection API integration**
  - Fixed LibGroupCombatStats integration to use proper API: `RegisterAddon()` and `RegisterForEvent()`
  - Fixed event registration to use `EVENT_GROUP_ULT_UPDATE` and `EVENT_PLAYER_ULT_UPDATE` instead of incorrect callback approach
  - Fixed LibSetDetection integration to use `RegisterAddon()` and `GetSetsForGroupMember()` for on-demand queries
  - Simplified ultimate data handling to use single callback for all ultimate updates
  - Updated equipment display to query data on-demand instead of caching
  - Added proper error handling and registration success messages
  - Ultimate data should now properly appear when using `/btlwdata ults` command

### Changed
- **Made LibGroupCombatStats and LibSetDetection required dependencies**
  - Moved from `OptionalDependsOn` to `DependsOn` in manifest
  - Phase 2 network foundation cannot function without these libraries
  - Addon will now fail to load with clear error message if libraries are missing
  - Users should install both libraries from ESOUI.com before using addon
  - LibCombat remains optional (currently unused)

### Fixed
- Made LibGroupCombatStats, LibSetDetection, and LibCombat optional dependencies
  - Changed from `DependsOn` to `OptionalDependsOn` in manifest
  - Allows addon to load even when these libraries are not installed
  - Enables testing with `/btlwdata libapi` command to check library availability
  - Libraries enhance functionality when present but are not required for addon to load
- Fixed operator precedence issue in `/btlwdata equip` command
- Improved error handling in `/btlwdata libapi` command to handle nil values gracefully
- Updated library check to only fail on missing required libraries (LibAsync, LibGroupBroadcast, LibAddonMenu2)
- Added warning messages for missing optional libraries

### Planned
- Phase 1: Local data collection (equipment tracking, synergy detection)
- Ultimate tracking system
- Equipment awareness features
- Settings UI implementation
