# Beltalowda Ultimate Tracking

This document describes the ultimate tracking feature ported from the RDK addon.

## Features

- **Ultimate Tracking**: Monitors ultimate ability status for player and group members
- **Network Broadcasting**: Shares ultimate percentages with group members via party chat
- **41 Tracked Ultimates**: All class, weapon, guild, and world ultimates are recognized

## Testing In-Game

### Installation

1. Copy the Beltalowda folder to your ESO AddOns directory:
   - Windows: `Documents\Elder Scrolls Online\live\AddOns\`
   - Mac: `~/Documents/Elder Scrolls Online/live/AddOns/`

2. Launch Elder Scrolls Online

3. In the character select screen, enable the Beltalowda addon

### Slash Commands

Once in-game, you can use these commands to test ultimate tracking:

- **`/bultimate`** - Display your ultimate and all group members' ultimate percentages
  - Shows your current ultimate percentage and power
  - Lists all group members with their ultimate percentages
  - Indicates when ultimates are ready with [READY] marker

- **`/bultimateinfo`** - View information about tracked ultimates
  - Lists the first 10 tracked ultimate abilities
  - Shows ultimate name and cost for each

- **`/bbroadcast <on|off>`** - Toggle ultimate broadcasting
  - `on` - Enable broadcasting your ultimate to group members (enabled by default)
  - `off` - Disable broadcasting

### Testing Group Features

To test the group ultimate tracking and networking:

1. Form a group with at least one other player who also has Beltalowda installed
2. Both players should have broadcasting enabled (default)
3. Use `/bultimate` to see both players' ultimate percentages
4. Build your ultimate ability and watch the percentages update
5. When ultimate reaches 100%, it will show [READY] indicator

### How It Works

1. **Local Tracking**: The addon monitors the `EVENT_POWER_UPDATE` event to track ultimate power changes
2. **Network Broadcasting**: When your ultimate changes by 5% or more (or reaches 0% or 100%), it broadcasts via party chat
3. **Network Receiving**: Messages from other group members are received and parsed to update their ultimate status
4. **Display**: The `/bultimate` command shows real-time ultimate percentages for all group members

## Technical Details

### Files Added

- `Base/Util/Ultimates.lua` - Ultimate ability definitions (41 ultimates total)
- `Base/Util/Group.lua` - Group member tracking and ultimate monitoring
- `Base/Util/Networking.lua` - Lightweight party chat-based networking

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
