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

## Available Commands

Beltalowda provides the following slash commands for debugging and testing:

- `/btlwdata` - Show help with available commands
- `/btlwdata group` - Display all group member data
- `/btlwdata ults` - Display ultimate data for group members  
- `/btlwdata equip` - Display equipment data for group members
- `/btlwdata libapi` - Check library API availability and status

**Note**: These are addon-provided commands, not library commands. The addon must be loaded for these commands to work.

See CHANGELOG.md for detailed version history.
