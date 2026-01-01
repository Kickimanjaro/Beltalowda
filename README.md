# Beltalowda - Fresh Start

This branch contains a clean slate for the Beltalowda project with a reorganized structure.

## Repository Structure

```
/
├── .copilot-responses/    # AI-generated documentation and checkpoint files
├── docs/                  # Architecture and planning documents
├── old-docs/              # Historical documentation
├── Beltalowda.lua         # Main addon implementation
├── Beltalowda.txt         # Addon manifest with dependencies
├── CHANGELOG.md           # Version history and changes
├── LICENSE                # Project license
├── README.md              # This file, lol
└── copilot-instructions.md # AI agent guidelines
```

## Documentation

- **docs/** - Contains 7 architecture and planning documents for the new development approach
- **old-docs/** - Contains historical documentation files moved from the previous structure

## Purpose

This project is an ESO addon for group PvP coordination. Current status:
- **Phase 0 Complete**: Library integration and foundation (v0.1.0)
- **Phase 2 Complete**: LibGroupBroadcast integration
- Planning documentation preserved in docs/
- Historical documentation archived in old-docs/
- Clean structure for incremental development

## Required Libraries

Beltalowda requires the following libraries to function. All must be installed from ESOUI.com:

### Core Dependencies
- **LibAsync** (v3.1.1+) - Asynchronous operations
- **LibGroupBroadcast** (v91+) - Network communication
- **LibAddonMenu-2.0** (v41+) - Settings UI

### Data Libraries
- **[LibGroupCombatStats](https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html)** (v6+) - **REQUIRED** for ultimate tracking
- **[LibSetDetection](https://www.esoui.com/downloads/info3338-LibSetDetection.html)** (v4+) - **REQUIRED** for equipment tracking

**Without these libraries, the addon will not load.**

### Optional Libraries
- **LibCombat** (v84+) - Currently unused, reserved for future features

## Installation

1. Download and install required libraries from the links above
2. Install Beltalowda
3. Restart ESO
4. Verify all libraries loaded at character select screen

## Available Commands

Beltalowda provides comprehensive slash commands for debugging and testing network functionality:

### Basic Test Commands
- `/btlwdata help` - Show all available commands and testing tips
- `/btlwdata status` - Quick overview of group status and data availability  
- `/btlwdata group` - Display detailed data for all group members
- `/btlwdata ults` - Display ultimate data with ability names and percentages
- `/btlwdata equip` - Display equipment/set data for group members

### Diagnostic Commands
- `/btlwdata libapi` - Check library API availability and methods (troubleshooting)

**Testing**: See `.copilot-responses/NETWORK_FOUNDATION_TESTING_GUIDE.md` for comprehensive testing procedures and expected outputs.

**Note**: These are addon-provided commands, not library commands. The addon must be loaded for these commands to work.

See CHANGELOG.md for detailed version history.
