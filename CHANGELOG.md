# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

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
