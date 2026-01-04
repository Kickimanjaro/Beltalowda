# Beltalowda UI Framework - User Guide

## Overview

Phase 4 introduces the foundational UI framework for Beltalowda, implementing a visual group ultimate tracking system inspired by the RdK addon. This provides a clear, color-coded display of group members' ultimate readiness and allows players to manually select which ultimate they want to report to the group.

## Components

### 1. Group Ultimate Display

The main tracking window that shows:
- **12 Ultimate Columns**: Each column represents a different ultimate ability type
- **Player Blocks**: Beneath each ultimate icon, player blocks stack vertically showing:
  - Group index number (1-24)
  - Player name
  - Ultimate charge percentage (visual bar)
  - Color-coded readiness status

**Color Coding:**
- **Green** (100%+): Ultimate is ready
- **Yellow** (75-99%): Almost ready
- **Orange** (50-74%): Building
- **Gray** (<50%): Not ready

### 2. Client Ultimate Selector

A separate, draggable window showing a single ultimate icon:
- Displays the currently selected ultimate you want to report to the group
- Click to cycle through your slotted ultimates (front bar and back bar)
- Hover for tooltip with ability details
- Selection is saved and persists across sessions

## Getting Started

### First Time Setup

1. **Enter the game world** - The UI will automatically initialize when you log in
2. **Locate the windows**:
   - Group Ultimate Display: Top-left area (default position)
   - Client Ultimate Selector: Separate draggable box
3. **Unlock the UI** to reposition:
   - Use `/btlwui lock` to unlock
   - Drag windows to desired positions
   - Lock again with `/btlwui lock`

### Slash Commands

#### UI Control
- `/btlwui toggle` - Toggle Group Ultimate Display visibility
- `/btlwui lock` - Toggle UI lock/unlock (for repositioning)
- `/btlwui refresh` - Force refresh the display
- `/btlwui test` - Toggle test mode

#### Settings Menu
- `/btlwsettings` - Open the addon settings menu
  - Enable/disable UI components
  - Adjust scale (0.5x to 2.0x)
  - Adjust opacity (transparency)
  - Lock/unlock windows

### Keybinds

Configure keyboard shortcuts in ESO's Controls settings under "Beltalowda":

- **Toggle Group Ultimate Display** - Show/hide the main tracking window
- **Toggle Client Ultimate Selector** - Show/hide the selector box
- **Toggle UI Lock** - Lock/unlock all windows for repositioning
- **Cycle Selected Ultimate** - Change your reported ultimate

## How It Works

### Ultimate Detection

The addon automatically detects:
1. **Your Slotted Ultimates**: Both front bar and back bar ultimates
2. **Group Members' Ultimates**: Via LibGroupCombatStats data integration
3. **Ultimate Charge**: Real-time percentage for all group members

### Ultimate Selection

1. Click the Client Ultimate Selector to cycle through your available ultimates
2. Your selection is immediately saved
3. In future phases, your selection will be broadcast to the group
4. Other players with the addon will see your selected ultimate

### Display Updates

The Group Ultimate Display updates:
- **Real-time**: When ultimate charge changes (from LibGroupCombatStats)
- **Automatically**: When group members change
- **Periodically**: Every second to catch any missed updates

## Settings

Access via `/btlwsettings` or ESO's Addon Settings menu:

### User Interface Section

- **Enable Group Ultimate Display**: Show/hide the main tracking window
- **Enable Client Ultimate Selector**: Show/hide the selector box
- **Lock UI Windows**: Lock all windows in place (prevents accidental movement)
- **UI Scale**: Adjust size (0.5x to 2.0x, default 1.0x)
- **UI Opacity**: Adjust transparency (0.1 to 1.0, default 1.0)

All settings are automatically saved to SavedVariables and persist across sessions.

## Troubleshooting

### UI Not Visible

1. Check if enabled: `/btlwui toggle`
2. Check settings menu: `/btlwsettings`
3. Ensure you're in the game world (not character select)
4. Try `/reloadui`

### No Ultimate Data Showing

1. Ensure you're in a group
2. Verify LibGroupCombatStats is installed and loaded
3. Use abilities to trigger data sync
4. Check with `/btlwdata status`

### Windows Off-Screen

1. Unlock the UI: `/btlwui lock`
2. Use `/reloadui` - windows will reset to default positions if saved positions are invalid
3. Manually edit SavedVariables if needed

### Performance Issues

1. Reduce UI Scale in settings
2. Lower opacity slightly
3. Check for conflicting addons
4. Verify your system meets ESO's minimum requirements

## Data Integration

The UI integrates with the existing network layer:

- **LibGroupCombatStats**: Provides ultimate charge data for all group members
- **Network Layer**: Handles data synchronization and group management
- **SavedVariables**: Persists all settings and selected ultimates

## Known Limitations (Phase 4)

These will be addressed in future phases:

1. **Manual Selection Only**: You must manually click to select your ultimate
2. **No Automatic Detection**: The addon doesn't auto-detect which ultimate you're using
3. **No Broadcasting Yet**: Your selection isn't yet broadcast to the group (local display only)
4. **No Validation**: No checks to ensure your selected ultimate matches your equipped one
5. **Fixed Ultimate List**: The 12 ultimate columns use a default list (customization coming later)

## Best Practices

### For Group Leaders
1. Keep the Group Ultimate Display visible and unlocked during setup
2. Position it where you can see it during combat
3. Lock it once positioned to prevent accidental movement
4. Use keybinds for quick toggle during combat

### For Group Members
1. Select your ultimate in the Client Ultimate Selector
2. Update your selection when switching builds
3. Keep the selector visible for quick access
4. Communicate your ultimate choice to the group

### For Testing
1. Use `/btlwui test` to enable test mode
2. Use `/btlwdata status` to check data availability
3. Form a group with at least one other player with the addon
4. Use abilities to trigger ultimate charge updates

## Next Steps (Phase 5+)

Future enhancements will include:

- Broadcasting selected ultimate to group via custom protocol
- Automatic ultimate detection from action bars
- Validation of selected vs. equipped ultimates
- Customizable ultimate column configuration
- Enhanced visual effects for ultimate readiness
- Priority system for ultimate coordination
- Attack coordination timers

## Support

- **Documentation**: See `docs/` folder for technical details
- **Debugging**: Use `/btlwdata help` for debug commands
- **Logging**: Configure in `/btlwsettings` under "Debugging & Diagnostics"
- **Issues**: Report bugs via GitHub Issues

## Credits

UI design inspired by [RdK addon](https://github.com/Kickimanjaro/RdK) by Kickimanjaro.
