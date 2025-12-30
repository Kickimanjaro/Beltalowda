# Monster Helm Item Set Tracking (Wishlist Feature)

**Status:** Wishlist / Foundation Only  
**Implementation:** Infrastructure created, full functionality pending

## Overview

This feature will track Monster Helm Item Sets equipped by group members, similar to how Ultimate Tracking and Synergy Tracking currently work. The infrastructure has been created as a foundation for future development.

## Purpose

Monster Sets provide powerful effects in PvP that can be coordinated among group members. Tracking these sets allows for:
- Better coordination of healing/support sets (Earthgore, Symphony of Blades)
- Awareness of defensive cooldowns (Bloodspawn)
- Coordination of damage windows (Balorgh, Ozezan)

## Tracked Monster Sets

### 1. Earthgore (Healing/Support)
- **Type:** Healing/Support
- **Effect:** Cleanses and heals group members under 50% health
- **Cooldown:** 35 seconds
- **Duration:** 6 seconds
- **Group Impact:** Yes - affects all nearby allies
- **Tracking Goal:** Show when the cleanse is available vs on cooldown

### 2. Symphony of Blades (Group Resource Restore)
- **Type:** Support
- **Effect:** Restores 570 primary resource per second for 6 seconds to group members under 50% resource when healed by wearer
- **Cooldown:** 18 seconds per target
- **Duration:** 6 seconds
- **Group Impact:** Yes - buffs group members
- **Tracking Goal:** Per-target cooldown tracking
- **Special Note:** Cannot target the wearer

### 3. Ozezan the Inferno
- **Type:** Damage
- **Effect:** Fire damage proc
- **Cooldown:** 10 seconds
- **Group Impact:** No
- **Tracking Goal:** Damage proc availability

### 4. Bloodspawn (Tank/Self Buff)
- **Type:** Tank
- **Effect:** Provides Ultimate and Physical/Spell Resistance for 5 seconds (6% chance on taking damage)
- **Cooldown:** 5 seconds
- **Duration:** 5 seconds
- **Group Impact:** No - self only
- **Tracking Goal:** Show when the tank's proc is available
- **Special Note:** Proc chance makes this probabilistic

### 5. Balorgh (Ultimate Scaling)
- **Type:** Damage
- **Effect:** 
  - Weapon/Spell Damage equal to Ultimate consumed
  - Physical/Spell Penetration equal to 23× Ultimate consumed
  - Lasts 12 seconds
- **Cooldown:** Tied to ultimate usage
- **Duration:** 12 seconds
- **Group Impact:** No
- **Tracking Goal:** Show ultimate status and buff values when active
- **Special Notes:** 
  - Displays ultimate charge state
  - Shows damage/penetration values when buff is active

## Implementation Status

### ✅ Completed (Infrastructure)
- [x] Module structure created (`Base/Group/MonsterSetTracker.lua`)
- [x] Monster Set data structures defined
- [x] Constants for all 5 sets established
- [x] Placeholder functions for:
  - Equipment scanning
  - Set detection
  - Cooldown tracking
  - Network broadcasting
  - Data reception
- [x] Settings menu integration (disabled by default)
- [x] Documentation created

### ⏳ Pending (Future Development)
- [ ] Actual item ID verification from in-game data
- [ ] Equipment change event handlers
- [ ] Buff/debuff event tracking to detect set procs
- [ ] Network protocol implementation
- [ ] UI creation and rendering
- [ ] Icon assets for each monster set
- [ ] Per-target cooldown tracking for Symphony of Blades
- [ ] Ultimate integration for Balorgh tracking
- [ ] Testing in PvP scenarios
- [ ] LibSets integration (optional enhancement)

## Design Considerations

### Similar to Ultimate/Synergy Tracking
The Monster Set Tracker follows the same architectural patterns as Ultimate and Synergy tracking:

1. **Detection:** Scan player equipment and monitor changes
2. **Broadcasting:** Share equipped sets with group via networking
3. **State Tracking:** Monitor proc/cooldown status via buff events
4. **UI Display:** Visual indicators similar to ultimate icons
5. **Cooldown Timers:** Visual countdown similar to synergy cooldowns

### Networking Strategy
Similar to `Ultimates.lua` and `SynergyOverview.lua`:
- Broadcast equipped sets when changed
- Broadcast proc events to group
- Receive and track group member data
- Use existing networking infrastructure (PREFIX: "MST")

### UI Mockup Concept
```
┌─ Monster Sets ──────────────┐
│ [🛡️ Earthgore]      Ready    │  <- PlayerOne
│ [⚔️ Balorgh]        15s (CD) │  <- PlayerTwo  
│ [💧 Symphony]       Ready    │  <- PlayerThree
└─────────────────────────────┘
```

Or integrated with existing tracking:
```
[Earthgore: 2] [Symphony: 1] [Bloodspawn: 1]
```

## LibSets Integration (Optional)

The [LibSets library by Baertram](https://www.esoui.com/downloads/info2241-LibSetsAllsetitemsingamepreview.luaAPIexcelsheet.html) could be used to:
- Automatically detect set names from item links
- Get accurate set bonuses and cooldowns
- Reduce manual maintenance of set data

This would be added as an optional dependency if implemented.

## Configuration

Settings available in the addon menu under "Monster Set Tracker (Wishlist)":

- **Enable Monster Set Tracking** - Master toggle (disabled by default)
- **PvP Only** - Only track in PvP areas
- **Individual Set Toggles:**
  - Track Earthgore
  - Track Symphony of Blades
  - Track Ozezan the Inferno
  - Track Bloodspawn
  - Track Balorgh

## Future Expansion

Once the core 5 sets are implemented, the system is designed to easily add more sets:

### Potential Additional Sets
- **Healing/Support:** Sentinel of Rkugamz, Troll King, Nightflame
- **Damage:** Valkyn Skoria, Maw of the Infernal, Kra'gh
- **Tank/Utility:** Engine Guardian, Lord Warden, Pirate Skeleton
- **PvP Specific:** Any meta sets that emerge

### Extensibility
The `monsterSets` table structure allows easy addition of new sets:
```lua
BeltalowdaMST.monsterSets[NEW_SET_ID] = {
    id = NEW_SET_ID,
    name = "Set Name",
    headItemId = ITEM_ID,
    cooldown = COOLDOWN_SECONDS,
    duration = DURATION_SECONDS,
    type = "healing|damage|tank|support",
    affectsGroup = true|false,
    description = "Effect description",
    iconPath = "path/to/icon.dds",
}
```

## Development Notes

### Item ID Discovery
Item IDs need to be verified in-game using:
```lua
/script d(GetItemLink(BAG_WORN, EQUIP_SLOT_HEAD))
```

### Set Detection Logic
The complete detection requires:
1. Check head slot item link
2. Check shoulder slot item link
3. Parse item IDs from links
4. Verify both pieces are from same set
5. Check if it's a tracked monster set

### Buff Event Tracking
Set procs are detected via:
- `EVENT_EFFECT_CHANGED` with `buffType == BUFF_EFFECT_TYPE_BUFF`
- Match ability IDs to known set proc IDs
- Track timestamps for cooldown calculation

## Testing Checklist (When Implemented)

- [ ] Correctly detects when player equips/unequips tracked sets
- [ ] Broadcasts set changes to group
- [ ] Receives and displays group member sets
- [ ] Accurately tracks cooldowns for each set
- [ ] UI displays correctly in combat
- [ ] PvP-only toggle works properly
- [ ] Doesn't cause performance issues in large groups
- [ ] Works with all 5 initial sets
- [ ] Proper integration with existing UI systems

## References

- [UESP Monster Helm Sets](https://en.uesp.net/wiki/Online:Monster_Helm_Sets)
- [LibSets by Baertram](https://www.esoui.com/downloads/info2241-LibSetsAllsetitemsingamepreview.luaAPIexcelsheet.html)
- Existing addon systems: `Base/Util/Ultimates.lua`, `Base/Toolbox/SynergyOverview.lua`
