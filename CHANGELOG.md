# Changelog

All notable changes to Beltalowda will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Pride Versioning](https://pridever.org/).

## [1.0.0] - 2025-12-30

### Added
- Initial release of Beltalowda addon
- Basic addon structure following ESOUI.com standards
- Core initialization and event handling
- Saved variables support
- Compatible with ESO API versions 101047 and 101048
- **Ultimate Tracking System** (ported from RDK addon)
  - Tracks all 41 ultimate abilities (class, weapon, guild, and world skill lines)
  - Real-time group member ultimate percentage monitoring
  - Lightweight party chat-based networking for ultimate broadcasting
  - Slash commands for testing: `/bultimate`, `/bultimateinfo`, `/bbroadcast`
  - Comprehensive documentation in ULTIMATE_TRACKING.md
- Base utility modules:
  - `Base/Util/Ultimates.lua` - Ultimate ability definitions and management
  - `Base/Util/Group.lua` - Group member tracking and monitoring
  - `Base/Util/Networking.lua` - Party chat networking protocol
