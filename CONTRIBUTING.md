# Beltalowda - ESO Addon Development Guide

## Overview

Beltalowda is an Elder Scrolls Online addon designed for group PvP coordination. This guide provides information for developers who want to understand or contribute to the addon.

## Addon Standards

This addon follows the standards set by ESOUI.com and is designed for easy integration with distribution platforms including:
- ESOUI.com website
- Minion App for addon management

## File Structure

### Core Files

- **Beltalowda.txt** - Addon manifest file (required by ESO)
  - Contains metadata: Title, Author, Version, API Version, Dependencies, SavedVariables
  - Lists all files to be loaded by the addon in the correct order
  
- **Beltalowda.lua** - Main addon logic
  - Addon initialization
  - Event handling
  - Core functionality

- **bindings.xml** - Keybinding definitions (optional)
  - Custom keybindings for addon functions

### Directory Structure

- **Lang/** - Localization files
  - `en.lua` - English language strings
  - Additional language files can be added as needed

- **Art/** - Art assets and textures
  - Icons, textures, UI elements
  - Recommended format: DDS for performance

- **UI/** - User interface components
  - XML layout files
  - Lua UI scripts
  - UI component modules

## ESO API Compatibility

Current supported API versions:
- **101047** - Current live version (as of August 2025)
- **101048** - Development/PTS version

The APIVersion in the manifest should be updated when new ESO updates are released. Check ESOUI.com or the official forums for the latest API versions.

## Saved Variables

The addon uses account-wide saved variables for persistent settings:
- Variable name: `BeltalowdaSavedVariables`
- Scope: Account-wide (settings persist across all characters)
- Version: 1 (for migration support)

## Development Workflow

### Adding New Features

1. Create feature-specific Lua files in appropriate directories
2. Add the files to `Beltalowda.txt` in the correct load order
3. Update version number in both `Beltalowda.txt` and `Beltalowda.lua`
4. Document changes in `CHANGELOG.md`

### Localization

To add support for a new language:
1. Create a new file in `Lang/` (e.g., `de.lua` for German)
2. Copy the string structure from `en.lua`
3. Translate all string values
4. Add the file to `Beltalowda.txt` before `Beltalowda.lua`

### Testing

Test the addon in-game:
1. Copy the addon folder to ESO's AddOns directory
2. Launch ESO
3. Enable the addon in the Add-Ons menu
4. Use `/reloadui` to reload after making changes

## Distribution

### ESOUI.com

The addon can be uploaded to ESOUI.com for distribution. The manifest file format ensures compatibility with their upload system.

### Minion App

The Minion app automatically detects and installs addons from ESOUI.com. No special configuration is needed for Minion compatibility.

## Code Style

- Use 4 spaces for indentation
- Follow ESO API naming conventions
- Prefix addon-specific functions and variables with the addon name
- Use descriptive variable and function names
- Comment complex logic

## Resources

- [ESOUI.com](https://www.esoui.com/) - Addon hosting and community
- [ESOUI Wiki](https://wiki.esoui.com/) - API documentation
- [UESP ESO API](https://esoapi.uesp.net/) - API version reference
- [ESO Forums](https://forums.elderscrollsonline.com/) - Official forums

## License

All rights reserved.
