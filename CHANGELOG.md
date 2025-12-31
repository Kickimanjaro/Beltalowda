# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

## [0.3.16] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Added delegation function for GetRoAvailableSounds
  - Added delegation function `BeltalowdaOverview.GetRoAvailableSounds()` in `ResourceOverview.lua`
  - Ultimates menu GetMenu() calls this function at line 359 during menu initialization
  - Delegation function forwards calls to `Beltalowda.features.ultimates.GetRoAvailableSounds()`
  - Error was: "function expected instead of nil" at `Base/Features/Ultimates.lua:359`

## [0.3.15] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Added delegation function for GetRoAvailableUltimateSortingModes
  - Added delegation function `BeltalowdaOverview.GetRoAvailableUltimateSortingModes()` in `ResourceOverview.lua`
  - Ultimates menu GetMenu() calls this function at line 246 during menu initialization
  - Delegation function forwards calls to `Beltalowda.features.ultimates.GetRoAvailableUltimateSortingModes()`
  - Error was: "function expected instead of nil" at `Base/Features/Ultimates.lua:246`

## [0.3.14] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Added delegation function for GetRoAvailableDisplayModes
  - Ultimates menu GetMenu() calls this function which was moved to wrapper in v0.3.9
  - Error was: "function expected instead of nil" at `Base/Features/Ultimates.lua:88`

## [0.3.13] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Added BeltalowdaOverview alias to Ultimates.lua
  - GetMenu() function referenced BeltalowdaOverview functions but alias was missing
  - Added `local BeltalowdaOverview = BeltalowdaGroup.ro` to match pattern in ResourceOverview.lua
  - Error was: "attempt to index a nil value" at `Base/Features/Ultimates.lua:36`

## [0.3.12] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Restored GetRoAvailableGroupsGroups to ResourceOverview.lua  
  - Function is internal utility called during initialization before Ultimates wrapper loads
  - Moved implementation back to ResourceOverview.lua where it belongs
  - Ultimates wrapper now has delegation stub calling back to ResourceOverview implementation
  - Error was: "function expected instead of nil" at `Base/Group/ResourceOverview.lua:598`

## [0.3.11] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Resolved missing delegation function causing initialization failure in v0.3.10
  - Added delegation function `BeltalowdaOverview.GetRoAvailableGroupsGroups()` in `ResourceOverview.lua`
  - `ResourceOverview.lua` line 598 calls this function which was moved to Ultimates wrapper in v0.3.9
  - Delegation function now forwards calls to `Beltalowda.features.ultimates.GetRoAvailableGroupsGroups()`
  - Error was: "function expected instead of nil" at `Base/Group/ResourceOverview.lua:598`
  - Addon now loads correctly with visual elements and settings menu accessible

## [0.3.10] - 2025-12-31

### Fixed
- **Critical Bug Fix** - Resolved syntax errors preventing addon from loading in v0.3.9
  - Removed extra `end` statement at line 2714 in ResourceOverview.lua (after "--menu interactions" comment)
  - Added missing `end` statement for SetRoSpacing function in Ultimates.lua (line 1011)
  - Fixed cascading errors in en.lua and Group.lua caused by syntax issues

## [0.3.9] - 2025-12-31

### Changed
- **Phase 2 - Ultimates Complete**: Moved menu functions to Ultimates.lua wrapper
  - Moved `GetMenu()` and 143 getter/setter functions from ResourceOverview.lua (989 lines total)
  - Core implementation (Initialize, GetDefaults, event handlers, UI) remains in ResourceOverview.lua
  - Menu functions now in `Beltalowda.features.ultimates` namespace while delegating to `BeltalowdaOverview.*` internals
  - Applied consistent delegation pattern from previous modules
  - **Phase 2 COMPLETE**: All four modules now have menu functions extracted to wrapper files
    - Positioning.lua: 9 functions moved
    - Synergies.lua: 18 functions moved
    - AttackTimers.lua: 23 functions moved  
    - Ultimates.lua: 143 functions moved (largest module)

## [0.3.8] - 2025-12-30

### Fixed
- **Critical Bug Fix** - Resolved UI error preventing addon from loading in v0.3.7
  - Added delegation function `BeltalowdaDt.GetMenu()` in `DetonationTracker.lua`
  - `Group.lua` line 78 calls `BeltalowdaGroup.dt.GetMenu()` which was removed in v0.3.7
  - Delegation function now forwards calls to new wrapper location `Beltalowda.features.attackTimers.GetMenu()`
  - Maintains backward compatibility while preserving Phase 2 refactoring benefits
  - Error was: "function expected instead of nil" at `Base/Group/Group.lua:78`

## [0.3.7] - 2025-12-30

### Changed
- **Phase 2 - AttackTimers Complete** - Moved menu functions to AttackTimers.lua wrapper
  - Moved `GetMenu()` function from `DetonationTracker.lua` to `AttackTimers.lua`
  - Moved 23 getter/setter functions to wrapper (enabled, position, PvP, mode, size, smooth transition, 12 color pickers)
  - Removed 273 lines from DetonationTracker.lua (menu functions only)
  - Core implementation (Initialize, GetDefaults, event handlers, UI) remains in DetonationTracker.lua
  - Menu functions now reference `BeltalowdaAttackTimers.*` while delegating to `BeltalowdaDT.*` internals
  - Applied lessons from Positioning and Synergies (direct variable updates + explicit SetControlVisibility calls)

## [0.3.6] - 2025-12-30

### Changed
- **Phase 2 - Synergies Complete** - Moved menu functions to Synergies.lua wrapper
  - Moved `GetMenu()` function from `SynergyOverview.lua` to `Synergies.lua`
  - Moved 18 getter/setter functions to wrapper (enabled, colors, display modes, synergy toggles, etc.)
  - Removed 392 lines from SynergyOverview.lua (menu functions only)
  - Core implementation (Initialize, GetDefaults, event handlers, UI) remains in SynergyOverview.lua
  - Menu functions now reference `BeltalowdaSynergies.*` while still delegating to `BeltalowdaSO.*` internals
  - Applied lessons from Positioning: direct variable updates + explicit SetControlVisibility calls

## [0.3.5] - 2025-12-30

### Fixed
- **Positioning Module** - Fixed UI element not disappearing immediately when disabled
  - Root cause: `SetEnabled()` has initialization guard that can prevent `SetControlVisibility()` from being called
  - Solution: `SetRtEnabled()` now explicitly calls `SetControlVisibility()` after updating settings
  - UI now hides immediately when feature is disabled, no /reloadui required
  - Follows pattern: update saved var → call core function → ensure UI updates

## [0.3.4] - 2025-12-30

### Changed
- **DEVELOPMENT.md Enhanced** - Strengthened AI agent guidance to prevent repeat mistakes
  - Added prominent "MANDATORY PREREQUISITE" header at top of file
  - Enhanced troubleshooting section with context about previous violations
  - Made it clearer that defensive nil checks violate established guidelines
  - This addresses recurring issue where AI agents ignored troubleshooting philosophy
  - v0.3.3 serves as reminder of importance of following DEVELOPMENT.md guidelines

### Meta
- **Process Improvement** - v0.3.3 documented the bug fix cycle that violated DEVELOPMENT.md
  - Initial fix added defensive nil checks (wrong approach per guidelines)
  - Corrected fix found root cause and removed defensive checks (right approach)
  - This version increment ensures context is preserved for future reference

## [0.3.3] - 2025-12-30

### Fixed
- **Positioning Module** - Fixed "Enabled" toggle not functioning in settings menu
  - Root cause: `SetEnabled()` has initialization guards that can block menu updates
  - Fix: `SetRtEnabled()` now updates `rtVars.enabled` directly before calling `SetEnabled()`
  - This ensures menu changes persist even if `state.initialized` check fails
  - Follows pattern of other working setters (PvP Only, Position Fixed)
  - Removed unnecessary defensive nil checks per DEVELOPMENT.md guidelines

## [0.3.2] - 2025-12-30

### Changed
- **Positioning Module Refactor (Phase 2)** - Moved menu functions to wrapper file
  - Moved `GetMenu()` function from `RapidTracker.lua` to `Positioning.lua` wrapper
  - Moved all getter/setter menu functions to `Positioning.lua` (9 functions total)
  - Core implementation (`Initialize()`, `GetDefaults()`, event handlers) remains in `RapidTracker.lua`
  - Menu now references `BeltalowdaPositioning.*` functions while still delegating to `BeltalowdaRT.*` internals
  - Maintains full backward compatibility with Phase 1 architecture

## [0.3.1] - 2025-12-30

### Added
- **Modular Feature Architecture (Phase 1)** - Created wrapper files for better code organization
  - New `Base/Features/` directory containing modular feature wrappers
  - Created `Ultimates.lua` wrapper for ultimate tracking and resource bars (wraps ResourceOverview)
  - Created `Synergies.lua` wrapper for synergy availability tracking (wraps SynergyOverview)
  - Created `Positioning.lua` wrapper for expedition buff tracking (wraps RapidTracker)
  - Created `AttackTimers.lua` wrapper for detonation/shalk timer tracking (wraps DetonationTracker)
  - New `Beltalowda.features.*` namespace provides clearer organization while maintaining backward compatibility
  - All original functionality preserved through delegation pattern

### Changed
- **Menu Integration** - Updated menu to use new modular feature namespaces
  - Menu now references `Beltalowda.features.ultimates`, `synergies`, `positioning`, and `attackTimers`
  - Added safe nil checks for graceful handling of missing modules
  - Original `BeltalowdaGroup.ro`, `BeltalowdaGroup.rt`, `BeltalowdaGroup.dt`, and `BeltalowdaToolbox.so` namespaces still functional

## [0.2.3] - 2025-12-30

### Changed
- **Code Documentation** - Added descriptive comments to Group.lua Initialize(), GetDefaults(), and GetMenu() functions
  - Each module initialization now has inline comments explaining its purpose
  - Clarifies abbreviations: crown, ai, ftcv, ftcw, ftca, ftcb, dbo, rt, ro, hdm, po, dt, gb, isdp
  - Improves code maintainability and developer onboarding

## [0.2.2] - 2025-12-30

### Changed
- **Ultimate Tracker Refinement** - Simplified New Hotness Ultimate Tracking to use only the unified view
  - Removed Swimlanes View submenu from settings
  - Removed swimlanes-related language strings from all language files
  - Streamlined the ultimate tracking configuration for better user experience

## [0.2.1] - 2025-12-30

### Fixed
- **UI Visibility and Positioning** - Fixed critical visibility bugs across multiple modules
  - Rapids Overview, Synergy Prevention now stay visible in cursor mode (persistent trackers)
  - Debuff Overview (Proxy/Shalks/Detonation timers) properly hides/shows based on PvP settings
  - Potion Overview visibility corrected for PvP-only toggle
  - All tracking windows now visible when position is unlocked (for repositioning with mouse)
  - PvP-only toggle now properly reveals elements when toggled OFF in non-PvP zones
- **Visibility Logic Standardization** - Established consistent patterns for UI visibility across modules:
  - Always show if `positionLocked == false` (enables cursor-mode repositioning)
  - Properly evaluate PvP restrictions even when toggled off
  - Combat-contextual displays (Debuff/Potion Overview) hide in menus when locked

## [0.2.0] - 2025-12-30

### Added
- **"New Hotness" Feature Section** - Dedicated menu area for actively developed/featured content
  - New Hotness header with prominent orange color formatting
  - Organized location for cutting-edge addon features
  - Placeholder submenus for future positioning assistance features

### Changed
- **Settings Menu Reorganization** - Major restructuring for improved feature discovery
  - Moved Ultimate Tracker (both Unified View and Swimlanes View) from Group to New Hotness
  - Moved Synergy Overview from Toolbox to New Hotness
  - Moved Synergy Prevention from Toolbox to New Hotness
  - Moved Rapid Overview from Group to New Hotness (end position)
  - Added descriptive text to Ultimate Tracker submenus explaining view differences
  - Added descriptive text to Synergy Overview explaining real-time tracking functionality
  - Added descriptive text to Synergy Prevention explaining role-based synergy blocking
  - Added roadmap documentation to Positioning Assistance placeholder (Follow the Crown, Compass, Speeder)

### Removed
- Feedback and donation buttons from settings menu (UI cleanup)
- Synergy Tracking placeholder submenu (redundant after consolidating features)

## [0.1.1] - 2025-12-30

### Added
- **Customizable Ultimate Selection** - Players can now click on ultimate icons to select which ultimates to track
  - Click personal ultimate icon to choose custom ultimate for display
  - Click any group ultimate slot to customize what's tracked in that position
  - Context menus list all 41 available ultimates from game skill lines
  - Selections persist across addon reloads via saved variables

### Changed
- Ultimate tracking from placeholder system to fully functional customization

## [0.1.0] - 2025-12-30

### Added
- Basic addon structure following ESOUI.com standards
- Core initialization and event handling
- Saved variables support
- Compatible with ESO API versions 101047 and 101048
- **Comprehensive Ultimate Tracking System** (ported from RDK addon)
  - Tracks all 41 ultimate abilities (class, weapon, guild, and world skill lines)
  - Real-time group member ultimate percentage monitoring
  - Lightweight party chat-based networking for ultimate broadcasting
  - **RdK-style GUI Display** with 4 windows:
    - **Client Ultimate**: Player's own ultimate icon with color feedback
    - **Group Ultimates**: Row of 12 configurable ultimate trackers with counts
    - **Ultimate Overview**: Compact window showing key ultimate counts
    - **Player Blocks**: Main display with color-coded bars for all group members
  - **Addon Settings Integration**: LibAddonMenu-2.0 GUI settings panel
    - Configure which windows to display
    - Toggle ultimate broadcasting
    - Access via ESO Menu > Settings > Addons > Beltalowda
  - Slash commands: `/bultimate`, `/bultimateinfo`, `/bultui [blocks|client|group|overview]`, `/bbroadcast`
  - Comprehensive documentation in ULTIMATE_TRACKING.md
- Base utility modules:
  - `Base/Util/Ultimates.lua` - Ultimate ability definitions and management
  - `Base/Util/Group.lua` - Group member tracking and monitoring
  - `Base/Util/Networking.lua` - Party chat networking protocol
  - `UI/UltimateDisplay.lua` - Comprehensive RdK-style GUI display
  - `BeltalowdaMenu.lua` - LibAddonMenu settings integration

### Dependencies
- LibAddonMenu-2.0 (>=34) - Required for addon settings menu
