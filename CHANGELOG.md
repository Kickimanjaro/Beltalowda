# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

## [0.1.0] - 2025-12-30

### Added
- Initial release of Beltalowda addon (Pride Versioning)
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
  - Slash commands: `/bultimate`, `/bultimateinfo`, `/bultui [blocks|client|group|overview]`, `/bbroadcast`
  - Comprehensive documentation in ULTIMATE_TRACKING.md
- Base utility modules:
  - `Base/Util/Ultimates.lua` - Ultimate ability definitions and management
  - `Base/Util/Group.lua` - Group member tracking and monitoring
  - `Base/Util/Networking.lua` - Party chat networking protocol
  - `UI/UltimateDisplay.lua` - Comprehensive RdK-style GUI display
