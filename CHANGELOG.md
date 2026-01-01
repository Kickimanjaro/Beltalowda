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

### Changed
- **Architectural Decision**: Use existing well-maintained libraries instead of custom infrastructure
  - No custom data collector modules needed
  - No custom network protocol implementation needed
  - Can proceed directly to feature implementation
  - Libraries handle infrastructure concerns (data collection, networking, UI framework)

### Documentation
- Created `.copilot-responses/PHASE0_COMPLETE.md` documenting architectural decisions
- Updated `copilot-instructions.md` with documentation placement guidelines for AI agents
- Established that AI-generated documentation files should be in `.copilot-responses/` directory

## [Unreleased]

### Planned
- Phase 1: Local data collection (equipment tracking, synergy detection)
- Ultimate tracking system
- Equipment awareness features
- Settings UI implementation
