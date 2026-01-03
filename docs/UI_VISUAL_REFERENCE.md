# Beltalowda UI - Visual Layout Reference

## Overview

This document describes the visual layout of the Beltalowda UI components since screenshots require in-game testing.

## Group Ultimate Display

```
╔═══════════════════════════════════════════════════════════════════════════════╗
║  [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon] [Icon]  ║
║    │      │      │      │      │      │      │      │      │      │      │      │    ║
║    ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼    ║
║  ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐║
║  │ 1  │ │ 3  │ │ 7  │ │    │ │    │ │    │ │    │ │    │ │    │ │    │ │    │ │    │║
║  │Joe │ │Bob │ │Sue │ │    │ │    │ │    │ │    │ │    │ │    │ │    │ │    │ │    │║
║  ├────┤ ├────┤ ├────┤ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘ └────┘║
║  │ 4  │ │ 5  │ │    │                                                                ║
║  │Ann │ │Jim │ │    │                                                                ║
║  ├────┤ ├────┤ └────┘                                                                ║
║  │ 9  │ │    │                                                                       ║
║  │Max │ │    │                                                                       ║
║  └────┘ └────┘                                                                       ║
╚═══════════════════════════════════════════════════════════════════════════════════════╝
```

### Layout Details

**Dimensions:**
- Main window: (48px × 12 columns) + 4px padding = ~580px wide
- Height: 48px for icon row + (24px × 12 player blocks) = ~336px max height
- Default position: Top-left at (100, 100)

**Ultimate Icon Row:**
- 12 columns, each 48×48px
- Each column represents one ultimate type
- Icons show the ultimate ability icon from game data
- Semi-transparent backdrop when unlocked

**Player Blocks:**
- Stack vertically beneath each ultimate icon
- Each block: 200px wide × 24px tall (when shown)
- Hidden by default, only visible when player has that ultimate
- Max 12 players per ultimate column

**Player Block Components:**
```
┌────────────────────────────────────┐
│ 1  PlayerName        [█████░░░░░] │  ← Group index (1-24)
│                       75%          │  ← Ultimate charge percentage
└────────────────────────────────────┘
   ↑                      ↑
 Group #              Progress bar
```

**Color Coding:**
- Background color changes based on ultimate charge:
  - 🟢 Green (RGB: 0, 255, 0): 100%+ ready
  - 🟡 Yellow (RGB: 255, 255, 0): 75-99%
  - 🟠 Orange (RGB: 255, 128, 0): 50-74%
  - ⚪ Gray (RGB: 128, 128, 128): <50%

## Client Ultimate Selector

```
┌──────────┐
│          │
│  [Icon]  │  ← 64×64px ultimate icon
│          │  ← Click to cycle
└──────────┘
```

### Layout Details

**Dimensions:**
- Window: 72×72px (64px icon + 8px padding)
- Default position: (300, 100)
- Semi-transparent backdrop when unlocked

**Interaction:**
- Left-click: Cycle to next ultimate
- Hover: Show tooltip with ability name, cost, instructions
- Drag: Reposition (when unlocked)

**Tooltip Format:**
```
┌─────────────────────────┐
│ Dawnbreaker             │  ← Ability name
│ Cost: 125               │  ← Ultimate cost
│                         │
│ Click to cycle ultimates│  ← Instructions
└─────────────────────────┘
```

## Visual States

### Unlocked State
- Semi-transparent white borders visible around windows
- Windows can be dragged to reposition
- Backdrop visible: rgba(0, 0, 0, 0.3) with rgba(255, 255, 255, 0.5) border

### Locked State
- No visible borders
- Windows cannot be moved
- Cleaner appearance for combat

### Hidden State
- Windows completely invisible
- Still processing data in background
- Can be toggled back with `/btlwui toggle`

## Scale Examples

**Scale 1.0 (Default):**
- Icon size: 48×48px
- Player block: 200×24px
- Selector icon: 64×64px

**Scale 0.5 (Minimum):**
- Icon size: 24×24px
- Player block: 100×12px
- Selector icon: 32×32px

**Scale 2.0 (Maximum):**
- Icon size: 96×96px
- Player block: 400×48px
- Selector icon: 128×128px

## Opacity Examples

**Opacity 1.0 (Default):**
- Fully opaque, solid appearance
- Best for clear visibility

**Opacity 0.5 (Medium):**
- Semi-transparent
- Can see game world through UI
- Useful in combat for peripheral awareness

**Opacity 0.1 (Minimum):**
- Nearly transparent
- Only faint outline visible
- For expert users who need minimal UI

## Real-World Example

**Typical 8-Player Group Display:**

```
Ultimate Layout:
Column 1 (Dawnbreaker):  3 players
Column 2 (Northern Storm): 2 players
Column 3 (Standard): 1 player
Column 4 (Crescent Sweep): 0 players
Column 5 (Nova): 1 player
Column 6 (Meteor): 0 players
Column 7 (Barrier): 1 player
Columns 8-12: 0 players

Visual:
[Dawn] [Storm] [Std]  [Crsc] [Nova] [Mete] [Barr] [Veil] [Star] [Horn] [Prac] [Colo]
  │      │      │       │      │      │      │      │      │      │      │      │
  ▼      ▼      ▼       ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼      ▼
 ┌──┐  ┌──┐   ┌──┐    ┌──┐  ┌──┐   ┌──┐   ┌──┐   ┌──┐   ┌──┐   ┌──┐   ┌──┐   ┌──┐
 │1 │  │3 │   │5 │    │  │  │7 │   │  │   │2 │   │  │   │  │   │  │   │  │   │  │
 │██│  │██│   │░░│    │  │  │█░│   │  │   │██│   │  │   │  │   │  │   │  │   │  │
 ├──┤  ├──┤   └──┘    └──┘  └──┘   └──┘   └──┘   └──┘   └──┘   └──┘   └──┘   └──┘
 │4 │  │6 │
 │██│  │░░│
 ├──┤  └──┘
 │8 │
 │█░│
 └──┘

Legend:
██ = 100% ready (green)
█░ = 75% ready (yellow)
░░ = 50% ready (orange)
Empty = No player with that ultimate
```

## Font and Text

**Font Family:** ZoFontGameSmall (ESO default small font)
**Text Colors:**
- Player name: White (1, 1, 1, 1)
- Group index: White (1, 1, 1, 1)
- Default text: White

**Text Alignment:**
- Group index: Center aligned
- Player name: Left aligned
- Ultimate name (tooltip): Left aligned

## Expected Appearance During Testing

When testing in-game, you should see:

1. **On Load:**
   - Two windows appear (Group Display + Selector)
   - Semi-transparent backgrounds (if unlocked)
   - Default ultimate icons visible

2. **In Solo:**
   - Only your own data visible
   - Client selector shows your slotted ultimate
   - Can cycle between front/back bar ultimates

3. **In Group:**
   - Group members appear as player blocks
   - Blocks stack under relevant ultimate columns
   - Colors update as ultimates charge
   - Real-time updates every 1 second

4. **On Hover:**
   - Client selector shows tooltip
   - Tooltip displays ability name and cost

5. **On Drag:**
   - Window follows mouse cursor
   - Position saves when released
   - Persists after /reloadui

## Performance Expectations

**FPS Impact:** < 5% in 12-player group
**Memory Usage:** ~5-10 MB for UI controls
**Update Frequency:** 1 second refresh cycle
**Network Impact:** None (reads from existing network layer)

## Accessibility Notes

- High contrast colors for readiness states
- Clear visual separation between columns
- Large enough text at default scale (1.0)
- Scale control for vision-impaired users
- Opacity control to reduce visual clutter

## Known Visual Limitations

1. Fixed 12-column layout (cannot be customized yet)
2. Maximum 12 players per ultimate column
3. Player blocks use fixed height (24px at scale 1.0)
4. No scrolling for overflow (blocks hidden if >12 per column)
5. Ultimate icons use game data (quality depends on ability ID)

## Future Visual Enhancements

Planned for later phases:
- Customizable column layout
- Resizable player blocks
- Animations for ultimate ready state
- Intensity effects (glow/pulse when ready)
- Enhanced tooltips with more info
- Priority indicators (numbers/badges)
- Attack coordination timeline view
