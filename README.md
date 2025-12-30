# Beltalowda
ESO Group PvP Addon

## Description

Beltalowda is a group PvP addon for Elder Scrolls Online designed to enhance group coordination and combat effectiveness.

## Features

### Ultimate Tracking
- Real-time tracking of ultimate abilities for all group members
- Network broadcasting of ultimate percentages via party chat
- 41 tracked ultimates covering all classes, weapons, guilds, and world skill lines
- **Comprehensive RdK-style GUI Display** - Multiple windows for different tracking needs:
  - **Client Ultimate**: Your own ultimate icon with color-coding
  - **Group Ultimates**: Row of 12 trackable ultimate icons with counts
  - **Ultimate Overview**: Compact window showing key ultimate counts
  - **Player Blocks**: Main display with color-coded bars for all group members
- Debug commands available for development and testing

### GUI Display

The Ultimate Display provides multiple RdK-style windows for comprehensive ultimate tracking:

**1. Player Blocks** - Main display showing all group members:
```
┌─ Group Ultimates ────────┐
│ PlayerOne        [100%]  │  <- Green bar (ready)
│ PlayerTwo        [ 85%]  │  <- Yellow bar (almost ready)
│ PlayerThree      [ 45%]  │  <- Blue bar (building)
│ YourCharacter    [ 67%]  │  <- Blue bar (building)
└──────────────────────────┘
```

**2. Group Ultimates** - Row of 12 trackable ultimate icons:
```
[Negate:3] [Destro:5] [Storm:2] [Nova:1] ... (12 total)
```

**3. Client Ultimate** - Your own ultimate icon (changes to green when ready)

**4. Ultimate Overview** - Compact counts for key ultimates:
```
3/8 Destro:
2/8 Storm:
1/8 Neg.:
0/8 Nova:
```

**Features:**
- All windows are movable and independently toggleable
- Real-time updates (100ms refresh)
- Automatic height adjustment based on group size
- Color-coded progress bars
- Settings saved per account

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

## Credits

**Created by:** @Kickimanjaro

**Original Ultimate Tracking System ported from:**
- **RdK Group Tool** by @s0rdrak (PC / EU)
  - Comprehensive ultimate tracking logic
  - Resource overview GUI architecture
  - Context menu-based ultimate selection system
  - Customizable tracked ultimates storage and persistence

## Version History

See [CHANGELOG.md](CHANGELOG.md) for version history.
