# Beltalowda
ESO Group PvP Addon

## Description

Beltalowda is a group PvP addon for Elder Scrolls Online designed to enhance group coordination and combat effectiveness.

## Features

### Ultimate Tracking
- Real-time tracking of ultimate abilities for all group members
- Network broadcasting of ultimate percentages via party chat
- 41 tracked ultimates covering all classes, weapons, guilds, and world skill lines
- In-game testing commands for verification
- **Visual GUI Display** - Color-coded bars showing ultimate readiness for each group member

### GUI Display

The Ultimate Display window provides a real-time visual representation of your group's ultimate status:

```
┌─ Group Ultimates ────────┐
│ PlayerOne        [100%]  │  <- Green bar (ready)
│ PlayerTwo        [ 85%]  │  <- Yellow bar (almost ready)
│ PlayerThree      [ 45%]  │  <- Blue bar (building)
│ YourCharacter    [ 67%]  │  <- Blue bar (building)
└──────────────────────────┘
```

**Features:**
- Color-coded progress bars
- Real-time updates (100ms refresh)
- Automatic height adjustment based on group size
- Movable/draggable window
- Auto-shows when in group, hides when solo

See [ULTIMATE_TRACKING.md](ULTIMATE_TRACKING.md) for detailed documentation and testing instructions.

## Development

This addon follows ESOUI.com standards and is compatible with the Minion app distribution platform.

### Structure
- `Beltalowda.txt` - Addon manifest file
- `Beltalowda.lua` - Main addon logic
- `Lang/` - Localization files
- `Base/Util/` - Utility modules (Ultimates, Group, Networking)
- `UI/` - User interface components
- `Art/` - Art assets and textures

## Version History

See [CHANGELOG.md](CHANGELOG.md) for version history.
