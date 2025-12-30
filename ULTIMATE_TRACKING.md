# Beltalowda Ultimate Tracking

This document describes the comprehensive ultimate tracking feature ported from the RDK addon.

## Features

- **Ultimate Tracking**: Monitors ultimate ability status for player and group members
- **Network Broadcasting**: Shares ultimate percentages with group members via party chat
- **41 Tracked Ultimates**: All class, weapon, guild, and world ultimates are recognized
- **Multiple Display Windows**: RdK-style UI with client ultimate, group ultimates, overview, and player blocks

## Display Windows

### 1. Client Ultimate
Shows your own ultimate ability icon. The icon changes color based on readiness:
- White: Building ultimate
- Green: Ultimate ready (100%)

Toggle with: `/bultui client`

### 2. Group Ultimates
A row of 12 ultimate ability icons you can configure to track. Each shows a count of ready ultimates.
- Displays up to 12 selectable ultimate types
- Shows count of group members with that ultimate ready
- Click icons to select which ultimates to track (coming soon)

Toggle with: `/bultui group`

### 3. Ultimate Overview
Compact window showing counts for key ultimates (Destruction, Storm, Negate, Nova).
- Format: "X/Y Type:" where X = ready, Y = total

Toggle with: `/bultui overview`

### 4. Player Blocks
Main window showing all group members with ultimate bars.
- Color-coded bars: Green (ready), Yellow (almost), Blue (building)
- Real-time updates every 100ms
- Auto-resizes based on group size

Toggle with: `/bultui blocks`

## Testing In-Game

### Installation

1. Copy the Beltalowda folder to your ESO AddOns directory:
   - Windows: `Documents\Elder Scrolls Online\live\AddOns\`
   - Mac: `~/Documents/Elder Scrolls Online/live/AddOns/`

2. Launch Elder Scrolls Online

3. In the character select screen, enable the Beltalowda addon

### Slash Commands

The primary interface is the GUI windows. The following slash commands are available:

**GUI Control Commands:**

- **`/bultui`** - Toggle all Ultimate Display windows on/off
  
- **`/bultui blocks`** - Toggle Player Blocks window (main group ultimate bars)
  
- **`/bultui client`** - Toggle Client Ultimate window (your ultimate icon)
  
- **`/bultui group`** - Toggle Group Ultimates window (row of 12 trackable ultimates)
  
- **`/bultui overview`** - Toggle Ultimate Overview window (compact counts)

**Debug/Development Commands:**

These commands provide text-based output in chat for debugging and development purposes:

- **`/bultimate`** - Display ultimate tracking status in chat (debug)
  - Shows your current ultimate percentage and power
  - Lists all group members with their ultimate percentages
  - Indicates when ultimates are ready with [READY] marker

- **`/bultimateinfo`** - View information about tracked ultimates (debug)
  - Lists the first 10 tracked ultimate abilities
  - Shows ultimate name and cost for each

- **`/bbroadcast <on|off>`** - Toggle ultimate broadcasting (debug)
  - `on` - Enable broadcasting your ultimate to group members (enabled by default)
  - `off` - Disable broadcasting

### Testing Group Features

To test the group ultimate tracking and networking:

1. Form a group with at least one other player who also has Beltalowda installed
2. Both players should have broadcasting enabled (default)
3. Type `/bultui` to open the Ultimate Display UI window
4. The window will show all group members with ultimate bars
5. Build your ultimate ability and watch the bars update in real-time
6. When ultimate reaches 100%, the bar turns green
7. You can drag the window to reposition it on your screen

Alternative text-based display:
1. Use `/bultimate` to see both players' ultimate percentages in chat
2. Build your ultimate ability and run the command again to see updates

### How It Works

1. **Local Tracking**: The addon monitors the `EVENT_POWER_UPDATE` event to track ultimate power changes
2. **Network Broadcasting**: When your ultimate changes by 5% or more (or reaches 0% or 100%), it broadcasts via party chat
3. **Network Receiving**: Messages from other group members are received and parsed to update their ultimate status
4. **UI Display**: The Ultimate Display window shows color-coded bars for each group member
   - **Green bar**: Ultimate ready (100%)
   - **Yellow bar**: Almost ready (80-99%)
   - **Blue bar**: Building ultimate (0-79%)
5. **Real-time Updates**: UI refreshes every 100ms for smooth visual feedback
6. **Text Display**: The `/bultimate` command shows real-time ultimate percentages in chat

## Technical Details

### Files Added

- `Base/Util/Ultimates.lua` - Ultimate ability definitions (41 ultimates total)
- `Base/Util/Group.lua` - Group member tracking and ultimate monitoring
- `Base/Util/Networking.lua` - Lightweight party chat-based networking
- `UI/UltimateDisplay.lua` - Visual GUI display of group member ultimates

### Ultimate Data Structure

Each ultimate includes:
- `name` - Display name (e.g., "Sorcerer - Negate")
- `abilityId` - ESO ability identifier
- `id` - Internal ultimate identifier
- `icon` - Ability icon path (populated at runtime)
- `cost` - Ultimate cost (populated at runtime)
- `iconColor` - Optional color override for specific ultimates

### Broadcasting Protocol

Messages are sent in the format: `BTLWD_ULT:<percent>`
- Messages are filtered from visible chat
- Only sent when in a group
- Throttled to one broadcast every 2 seconds
- Only broadcasts on changes >= 5% (or 0%/100%)

## Known Limitations

- Currently uses party chat for networking (visible in chat logs but filtered from display)
- Does not integrate with heavy networking libraries like LibGroupBroadcast (intentional for minimal dependencies)
- No support for specific ultimate ability detection (only tracks percentage, not which ultimate is slotted)
- Broadcasting is enabled by default and applies to all group members with the addon

## Future Enhancements

Potential improvements for the future:
- Add specific ultimate ability detection (detect which ultimate each player has slotted)
- Add UI display instead of slash command
- Integrate with LibGroupBroadcast for more efficient networking
- Add configuration options for broadcast frequency and threshold
- Track ultimate usage/activation timing
