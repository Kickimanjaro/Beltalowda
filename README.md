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
- **Phase 2 Complete**: LibGroupBroadcast integration (v0.2.0-0.3.0)
- **Phase 4 Week 9 Complete**: Foundational UI Framework (v0.4.0)
  - Group Ultimate Display with 12 ultimate columns
  - Client Ultimate Selector for manual ultimate selection
  - Draggable, configurable windows with color-coded readiness
  - Real-time updates from LibGroupCombatStats
- Planning documentation preserved in docs/
- Historical documentation archived in old-docs/
- Clean structure for incremental development

## Features (v0.4.0)

### Group Ultimate Display
- Visual tracking of group members' ultimate readiness
- 12 configurable ultimate columns
- Player blocks stacked beneath each ultimate type
- Color-coded status indicators (green=ready, yellow=75%+, orange=50%+, gray=<50%)
- Real-time updates from group data
- Draggable and lockable window
- Configurable scale and opacity

### Client Ultimate Selector
- Separate selector box for choosing your reported ultimate
- Automatic detection of slotted ultimates (front and back bar)
- Click to cycle between available ultimates
- Tooltip with ability details
- Saves your selection across sessions

### Configuration
- Settings menu integration (`/btlwsettings`)
- Keybind support for quick access
- Position and preference persistence
- Debug logging system with multiple levels

See [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for a quick start guide!

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
- **LibCombat** (v84+) - Currently unused, reserved for future raw combat data features
  - Note: LibCombat is automatically included with LibGroupCombatStats (which depends on it)
  - Cannot replace LibGroupCombatStats - see [docs/LIBRARY_ARCHITECTURE.md](docs/LIBRARY_ARCHITECTURE.md) for details
- **LibDebugLogger** (v2.0+) - Enhanced logging persistence (recommended for debugging)

## Installation

1. Download and install required libraries from the links above
2. Install Beltalowda
3. Restart ESO
4. Verify all libraries loaded at character select screen

## Available Commands

Beltalowda provides comprehensive slash commands for UI control, debugging, and network testing:

### UI Commands (NEW in v0.4.0)
- `/btlwui toggle` - Toggle Group Ultimate Display visibility
- `/btlwui lock` - Toggle UI lock/unlock for repositioning
- `/btlwui refresh` - Force refresh the display
- `/btlwui test` - Toggle test mode

### Data and Network Testing

### Basic Test Commands
- `/btlwdata help` - Show all available commands and testing tips
- `/btlwdata status` - Quick overview of group status and data availability  
- `/btlwdata group` - Display detailed data for all group members
- `/btlwdata ults` - Display ultimate data with ability names and percentages
- `/btlwdata equip` - Display equipment/set data for group members

### Debug Level Commands
- `/btlwdata debug <module> <level>` - Set debug level for a specific module
- `/btlwdata debug all <level>` - Set all modules to the same level
  - **Modules**: Network, Ultimates, Equipment, General, all
  - **Levels**: ERROR, WARN, INFO, DEBUG, VERBOSE

### Log Management Commands
- `/btlwdata log show [module] [count]` - Show last N log entries (default: 20)
- `/btlwdata log clear` - Clear current session log
- `/btlwdata log levels` - Show current debug levels for all modules
- `/btlwdata log export` - Show SavedVariables file path for log export

### Settings Commands
- `/btlwsettings` - Open addon settings menu with logging configuration

### Diagnostic Commands
- `/btlwdata libapi` - Check library API availability and methods (troubleshooting)

**UI Guide**: See `docs/UI_GUIDE.md` for comprehensive UI usage instructions and configuration.

**Testing**: See `docs/UI_TESTING_GUIDE.md` for UI testing procedures and validation.

**Debugging Guide**: See `docs/DEBUGGING_GUIDE.md` for comprehensive debugging instructions, troubleshooting scenarios, and best practices.

**Quick Reference**: See `QUICK_REFERENCE.md` for a quick start guide and common commands.

**Note**: These are addon-provided commands, not library commands. The addon must be loaded for these commands to work.

See CHANGELOG.md for detailed version history.
