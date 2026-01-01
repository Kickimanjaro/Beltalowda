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

## [Unreleased]

### Planned
- Phase 1: Local data collection (equipment tracking, synergy detection)
- Ultimate tracking system
- Equipment awareness features
- Settings UI implementation
