# Implementation Checkpoints Guide

## Purpose

This document provides detailed in-game testing checkpoints for each phase of Beltalowda development. Each checkpoint ensures that implementation is working correctly before moving to the next phase.

**Philosophy**: Test early, test often, don't move forward with broken code.

---

## Phase 0: Foundation

### Checkpoint 0.1: Libraries Installed

**When**: After adding LibSets and LibAsync

**How to Test**:
1. Launch ESO
2. Log in to any character
3. Open chat console with `/`
4. Run: `/script d(LibSets ~= nil)`
   - Should see: `true`
5. Run: `/script d(LibAsync ~= nil)`
   - Should see: `true`
6. Check for error messages in chat
   - Should see: No errors related to Beltalowda

**Expected Results**:
- ✅ No addon load errors
- ✅ LibSets available
- ✅ LibAsync available
- ✅ All existing features still work

**If Problems**:
- Check `Lib/LibSets/` folder structure
- Check `Lib/LibAsync/` folder structure
- Verify manifest DependsOn line
- Check load order in manifest

**Success Criteria**: All libraries load, no errors, can proceed to module stubs

---

### Checkpoint 0.1b: Existing Library Research ✅ COMPLETE - REVISED

**When**: After researching LibGroupCombatStats, LibSetDetection, and LibGroupResources

**Research Method**: Web research + analysis of ESOUI documentation, GitHub repos, and community forums

**🎉 MAJOR UPDATE - REVISED** (based on user feedback):
- Original finding: 2 custom protocols needed (Health+Resources, Position)
- **Revised finding: ZERO custom protocols needed for MVP** 🎉

**User Feedback Incorporated** (@Kickimanjaro - Comment #3703725424):
1. ❌ Health tracking NOT needed - game UI already shows it (original assessment was incorrect)
2. ✅ Position tracking - can use LibGPS locally (no group broadcast needed initially)
3. 💡 May not need ANY custom protocols at all - **CONFIRMED** ✅

**Research Tasks Completed**:
1. **LibGroupCombatStats**: ✅
   - Provides: Ultimate Type (ID 20), Ultimate Value (ID 21), DPS (ID 22), HPS (ID 23)
   - Used by: Hodor Reflexes (battle-tested in production)
   - Coverage: 100% of ultimate tracking needs
   - **Decision: ADOPT** ✅

2. **LibSetDetection**: ✅
   - Provides: Equipped set pieces (ID 40) for all 14 equipment slots
   - Used by: Currently Equipped, DebuffTracker, YANP
   - Coverage: 100% of equipment tracking needs
   - **Decision: ADOPT** ✅

3. **LibGPS**: ✅ (Already have from Phase 0)
   - Provides: Local position tracking (X, Y coordinates)
   - Coverage: 100% of local position needs
   - **Decision: USE FOR LOCAL FEATURES** ✅
   - No LibGroupBroadcast protocol needed initially

4. **LibGroupResources**: ✅
   - Provides: Magicka (ID 11), Stamina (ID 10)
   - ~~Missing: Health (CRITICAL for PvP)~~
   - **REVISED**: Health NOT needed (user feedback - game UI shows it)
   - Coverage: Partial resource tracking but not valuable alone
   - **Decision: SKIP** ⚠️

5. **LibGroupPotionCooldowns**: ✅
   - Provides: Potion cooldown tracking (ID 26)
   - Coverage: Optional Tier 2 feature
   - **Decision: OPTIONAL** - Add later if needed ⚪

**Decision Matrix - REVISED**:
- ✅ LibGroupCombatStats: **USE** - Covers 100% of ultimate needs
- ✅ LibSetDetection: **USE** - Covers 100% of equipment needs, no conflicts with LibSets
- ✅ LibGPS: **USE** - Covers local position needs (already have)
- ⚠️ LibGroupResources: **DON'T USE** - Not valuable without Health requirement
- ⚪ LibGroupPotionCooldowns: **OPTIONAL** - Add later if potion tracking becomes priority

**Research Findings - REVISED**:
- **Minimum data needed**: **3 critical types** (Ultimate %, Ultimate ID, Equipment) - REVISED from 5
  - ~~Health removed~~ - Game UI already shows it
  - ~~Position demoted~~ - Can use LibGPS locally
- **Library coverage**: **100% of critical needs** (3/3) 🎉 - UP from 60%
- **Custom protocols needed**: **ZERO for MVP** 🎉 - DOWN from 2
- **Efficiency gain**: Reduced from 8 custom protocols → 0 needed (**100% reduction**) 🎉🎉🎉

**Deliverables**:
- ✅ All libraries researched via web search
- ✅ Documentation of capabilities and gaps
- ✅ Decision made on which to integrate
- ✅ Updated LIBGROUPBROADCAST_INTEGRATION.md with findings
- ✅ Created comprehensive research document: `.copilot-responses/CHECKPOINT_0.1b_RESEARCH.md` (original)
- ✅ Created revised research document: `.copilot-responses/CHECKPOINT_0.1b_REVISED.md` (updated) ⭐
- ✅ User feedback incorporated - **NO custom protocols needed!**

**Success Criteria**: ✅ Clear understanding of existing libraries, informed decision on custom vs reuse - **100% library coverage achieved**

---

### Checkpoint 0.2: Module Structure Created ⏭️ SKIPPED

**Status**: SKIPPED - Not needed based on Checkpoint 0.1b findings

**Rationale**: 
Research from Checkpoint 0.1b revealed that existing libraries (LibGroupCombatStats for ultimates, LibSetDetection for equipment) provide 100% coverage of critical data needs. No custom data collection modules or stubs are required for MVP. We will integrate directly with existing libraries instead of building custom collection infrastructure.

**What was skipped**:
- Creating Base/Data/ directory with collector stub files
- Creating Base/Network/ directory with GroupBroadcast stub
- Creating custom data collection namespaces
- Module stub initialization

**Alternative approach**:
- Use LibGroupCombatStats directly for ultimate data (IDs 20, 21, 22, 23)
- Use LibSetDetection directly for equipment data (ID 40)
- Use LibGPS locally for position (no broadcast initially)
- Reserved IDs 220-229 available if custom protocols needed later

**Next Step**: Proceed directly to Phase 2 (LibGroupBroadcast Integration)

---

## Phase 1: Data Collection ⏭️ SKIPPED

**Status**: PHASE SKIPPED - Not needed based on Checkpoint 0.1b findings

**Rationale**: 
The research completed in Checkpoint 0.1b revealed that existing LibGroupBroadcast libraries provide complete coverage:
- **LibGroupCombatStats**: Ultimate Type (ID 20), Ultimate Value (ID 21), DPS (ID 22), HPS (ID 23)
- **LibSetDetection**: Equipped set pieces (ID 40) for all 14 equipment slots
- **LibGPS**: Local position tracking (already installed, no broadcast needed initially)
- **LibGroupResources**: Stamina (ID 10), Magicka (ID 11) - Optional, not critical

**Coverage**: 100% of critical MVP needs are met by existing libraries.

**What was skipped**:
- ❌ Checkpoint 1.1: Resource Collection (ResourceCollector.lua not needed)
- ❌ Checkpoint 1.2: State Collection (StateCollector.lua not needed)
- ❌ Checkpoint 1.3: Ability Collection (AbilityCollector.lua not needed)
- ❌ Checkpoint 1.4: Equipment Collection (EquipmentCollector.lua not needed)

**Alternative approach**:
Instead of building custom data collection modules, we will:
1. Subscribe to LibGroupCombatStats for ultimate data from group members
2. Subscribe to LibSetDetection for equipment data from group members
3. Use LibGPS locally for position features (Follow the Crown, etc.)
4. Use native ESO API for any additional local data needs

**Custom protocols reserved**: IDs 220-229 available for future enhancements if needed (e.g., Volendrung detection, special mechanics).

**Next Step**: Proceed directly to Phase 2 (LibGroupBroadcast Integration) where we'll integrate with existing libraries.

---

## Phase 2: LibGroupBroadcast Integration

### Checkpoint 2.1: Network Infrastructure

**When**: After implementing GroupBroadcast.lua base structure

**How to Test**:
1. Launch ESO, log in
2. Run: `/script d(Beltalowda.network.MESSAGE_IDS)`
3. Should see table of message IDs
4. Run: `/script d(LibGroupBroadcast ~= nil)`
5. Should see: `true`

**Test Scenarios**:
1. **Library Available**:
   - Verify LibGroupBroadcast loaded
   - Check initialization success

2. **Message Handler Registration**:
   - Run: `/script d(Beltalowda.network.handlers)`
   - Should see handler table

**Expected Results**:
- ✅ LibGroupBroadcast available
- ✅ Message IDs defined
- ✅ Handlers registered
- ✅ Encode/decode functions work

**Simple Encode/Decode Test**:
```lua
/script local data = {100, 200, 300}
/script local encoded = Beltalowda.network.EncodeData(data)
/script local decoded = Beltalowda.network.DecodeData(encoded, "numbers")
/script d(decoded[1] == 100 and decoded[2] == 200 and decoded[3] == 300)
```
Should see: `true`

**Success Criteria**: Network infrastructure functional, ready for broadcasting

---

### Checkpoint 2.2: Resource Broadcasting (2 Players)

**When**: After implementing resource broadcasting

**Requirements**:
- 2 players with Beltalowda installed
- Both in same group
- Both in same zone

**How to Test**:

**Player 1**:
1. Form group
2. Invite Player 2
3. Run: `/btlwdata group`
4. Should see Player 2's resources

**Player 2**:
1. Join group
2. Run: `/btlwdata group`
3. Should see Player 1's resources

**Test Scenarios**:
1. **Initial Sync**:
   - Form group
   - Wait 2 seconds
   - Both players check `/btlwdata group`
   - Should see each other's resources

2. **Resource Changes**:
   - Player 1 enters combat
   - Uses abilities (reduces resources)
   - Player 2 runs: `/btlwdata group`
   - Should see Player 1's reduced resources

3. **Ultimate Changes**:
   - Player 1 gains ultimate to 100%
   - Player 2 runs: `/btlwdata group`
   - Should see Player 1 at 100%

4. **Disconnection**:
   - Player 2 logs out
   - Player 1 runs: `/btlwdata group`
   - Should remove Player 2's data after timeout

**Expected Results**:
- ✅ Resources sync within 1 second
- ✅ Updates propagate to all group members
- ✅ Disconnected players cleaned up
- ✅ No errors in chat

**If Problems**:
- Check LibGroupBroadcast:Send() calls
- Verify handler receiving messages
- Check sender identification
- Verify data storage per player
- Check group roster tracking

**Success Criteria**: 2-player resource sync working perfectly

---

### Checkpoint 2.3: State Broadcasting (2 Players)

**When**: After implementing state broadcasting

**Requirements**: Same as 2.2 (2 players, grouped)

**How to Test**:

**Player 1 & 2**:
1. Form group
2. Run: `/btlwdata group state`

**Test Scenarios**:
1. **Combat State Sync**:
   - Player 1 enters combat
   - Player 2 runs: `/btlwdata group state`
   - Should show: `[Player1]: Combat: true`
   - Player 1 exits combat
   - Should show: `Combat: false`

2. **Death State Sync**:
   - Player 1 dies
   - Player 2 runs: `/btlwdata group state`
   - Should show: `[Player1]: Alive: false`
   - Player 1 resurrects
   - Should show: `Alive: true`

3. **Bit Packing Verification**:
   - Run: `/script d(Beltalowda.network.DecodeStateFlags(15))`
   - Should show: all flags true (binary 1111 = 15)

**Expected Results**:
- ✅ Combat state syncs instantly
- ✅ Death state syncs within 1 second
- ✅ All state flags accurate
- ✅ Bit packing/unpacking works

**Success Criteria**: State broadcasting functional, ready to scale up

---

### Checkpoint 2.4: Multi-Player Test (4+ Players)

**When**: After 2-player tests pass

**Requirements**:
- 4+ players with addon
- All in same group
- All in same zone

**How to Test**:
1. Form 4-player group
2. All players run: `/btlwdata group`
3. Should see all 4 players' data

**Test Scenarios**:
1. **Full Group Sync**:
   - Verify all players see each other
   - Check resources for all players
   - Check state for all players

2. **Performance Test**:
   - All players enter combat
   - Use abilities rapidly
   - Monitor FPS
   - Check for lag or stuttering

3. **Broadcasting Load**:
   - All players spam abilities
   - Verify no message loss
   - Check update frequency

**Expected Results**:
- ✅ All players sync correctly
- ✅ FPS impact < 5%
- ✅ No lag or stuttering
- ✅ Updates within 1 second

**Performance Metrics**:
```lua
/script local fps = GetFramerate()
/script d("FPS: " .. fps)
```
Record before and after forming group.

**Success Criteria**: 4+ player sync works with acceptable performance

**End of Phase 2**: LibGroupBroadcast fully functional, ready for feature enhancements

---

## Phase 3: Enhanced Ultimate Tracking

### Checkpoint 3.1: Ultimate Ability Detection

**When**: After implementing ultimate ability ID detection and broadcasting

**How to Test**:
1. Launch ESO, log in
2. Run: `/btlwult`
3. Should see:
   ```
   === Group Ultimates ===
   [Player1]: Destruction Staff: Eye of the Storm (45%)
   [Player2]: Sorcerer: Negate Magic (100%) [READY]
   [Player3]: Templar: Crescent Sweep (78%)
   ```

**Test Scenarios**:
1. **Ultimate Type Display**:
   - Verify ultimate name is correct
   - Check ultimate percentage
   - Verify [READY] marker at 100%

2. **Ultimate Swap**:
   - Change slotted ultimate
   - Bar swap to new ultimate
   - Run: `/btlwult`
   - Should show new ultimate

3. **Group Ultimates Window**:
   - Open Ultimate Display UI
   - Check "Group Ultimates" window
   - Should show type-specific counts:
     ```
     [Destro Icon]: 2
     [Negate Icon]: 1
     [Nova Icon]: 0
     ...
     ```

**Expected Results**:
- ✅ Specific ultimate detected
- ✅ Ultimate name displayed correctly
- ✅ Type-specific counts accurate
- ✅ Group Ultimates window updated

**If Problems**:
- Check ultimate ability ID detection
- Verify ultimate database lookup
- Check broadcasting of ability ID
- Verify UI update logic

**Success Criteria**: Ultimate types tracked and displayed accurately

---

### Checkpoint 3.2: Volendrung Detection

**When**: After implementing dynamic ultimate addition

**Requirements**:
- Access to Volendrung in Cyrodiil (artifact spawn)
- OR - Use debug mode to simulate

**How to Test**:

**Option A: Real Volendrung**:
1. Go to Cyrodiil
2. Find Volendrung spawn
3. Pick up Volendrung
4. Run: `/btlwult`
5. Should show: `Volendrung: Ruinous Cyclone` added to tracker

**Option B: Debug Simulation**:
```lua
/script Beltalowda.ultimateTracking.SimulateVolendrung(true)
```

**Test Scenarios**:
1. **Volendrung Pickup**:
   - Pick up weapon
   - Verify Ruinous Cyclone added to tracker
   - Check Group Ultimates window shows new icon

2. **Volendrung Drop**:
   - Drop weapon (swap bars or timeout)
   - Verify Ruinous Cyclone removed from tracker
   - Check original ultimate restored

**Expected Results**:
- ✅ Volendrung detected on pickup
- ✅ Ruinous Cyclone added to tracker
- ✅ UI updates to show new ultimate
- ✅ Original ultimate restored on drop

**If Problems**:
- Check ability bar detection
- Verify Volendrung ability ID
- Check dynamic ultimate logic
- Verify cleanup on drop

**Success Criteria**: Dynamic ultimates work (Volendrung as proof of concept)

---

### Checkpoint 3.3: Priority System

**When**: After implementing priority system

**Requirements**: 3+ players with same ultimate type

**How to Test**:
1. Form group with 3 players
2. All slot same ultimate (e.g., Negate Magic)
3. All gain ultimate to 100%
4. Run: `/btlwult`

**Expected Display**:
```
=== Ultimate Priority (Negate Magic) ===
1. [Player1] - NEXT TO CAST
2. [Player2] - Ready
3. [Player3] - Ready
```

**Test Scenarios**:
1. **Priority Order**:
   - Verify consistent ordering
   - Check UI shows priority numbers

2. **Priority Visual**:
   - Player 1 should have different color/effect
   - Player 2 & 3 normal green (ready)

3. **Priority Rotation**:
   - Player 1 casts ultimate (goes to 0%)
   - Run: `/btlwult`
   - Player 2 should now be "NEXT TO CAST"

**Expected Results**:
- ✅ Priority order consistent
- ✅ Visual indicators clear
- ✅ Rotation works when ultimate cast
- ✅ Configurable in settings

**Success Criteria**: Priority system functional and useful for coordination

---

### Checkpoint 3.4: Intensity Reminder

**When**: After implementing intensity reminder effect

**How to Test**:
1. Launch ESO, log in
2. Gain ultimate to 100%
3. Wait 5 seconds (configurable)
4. Should see visual effect on ultimate icon

**Test Scenarios**:
1. **Effect Activation**:
   - Reach 100% ultimate
   - Don't cast for 5 seconds
   - Should see pulsing/glowing effect

2. **Effect Clear**:
   - Cast ultimate
   - Effect should disappear

3. **Settings Toggle**:
   - Open settings menu
   - Toggle intensity reminder off
   - Reach 100% ultimate
   - Should see no effect

**Expected Results**:
- ✅ Effect visible at 100% + delay
- ✅ Effect clears on cast
- ✅ Toggle in settings works
- ✅ Effect not annoying

**Success Criteria**: Intensity reminder helps players remember to cast ultimates

**End of Phase 3**: Ultimate tracking fully enhanced, all features functional

---

## Phase 4: Equipment Tracking

### Checkpoint 4.1: Equipment Broadcasting (2 Players)

**When**: After implementing equipment broadcasting

**Requirements**: 2 players, grouped

**How to Test**:

**Player 1**:
1. Run: `/btlwdata groupequip`
2. Should see Player 2's equipped sets

**Player 2**:
1. Change equipment (unequip, re-equip)
2. Player 1 runs: `/btlwdata groupequip`
3. Should see updated equipment

**Test Scenarios**:
1. **Full Equipment Sync**:
   - Verify all 14 slots tracked
   - Check set IDs transmitted
   - Verify 2-message broadcast (IDs 204-205)

2. **Equipment Change**:
   - Player 2 swaps armor piece
   - Player 1 sees update within 2 seconds
   - Verify piece counts updated

**Expected Results**:
- ✅ All equipment slots tracked
- ✅ Set IDs transmitted correctly
- ✅ Updates sync within 2 seconds
- ✅ No data loss

**Success Criteria**: Equipment fully tracked and broadcast

---

### Checkpoint 4.2: Monster Set Cooldowns

**When**: After implementing monster set cooldown tracking

**Requirements**: Player with monster set equipped

**How to Test**:
1. Equip monster set (e.g., Selene, Kra'gh)
2. Trigger monster set proc (attack enemy)
3. Run: `/btlwmonster`

**Expected Display**:
```
=== Monster Set Cooldowns ===
Selene: 3.2s remaining
Kra'gh: Ready
```

**Test Scenarios**:
1. **Cooldown Start**:
   - Proc monster set
   - Verify cooldown starts
   - Check timer accuracy

2. **Cooldown End**:
   - Wait for cooldown
   - Run: `/btlwmonster`
   - Should show "Ready"

3. **Group Sync**:
   - Form group
   - Player 1 procs monster set
   - Player 2 runs: `/btlwmonster group`
   - Should see Player 1's cooldown

**Expected Results**:
- ✅ Cooldown detected on proc
- ✅ Timer counts down accurately
- ✅ "Ready" shows when available
- ✅ Syncs to group

**Success Criteria**: Monster set cooldowns tracked accurately

---

### Checkpoint 4.3: Role Detection

**When**: After implementing enhanced role detection

**How to Test**:
1. Equip full tank set (5 pieces Ebon Armory)
2. Run: `/btlwdata role`
3. Should show: `Detected Role: Tank`

**Test Scenarios**:
1. **Tank Detection**:
   - Equip Ebon Armory (5pc)
   - Should detect: Tank

2. **Healer Detection**:
   - Equip Spell Power Cure (5pc)
   - Should detect: Healer

3. **DPS Detection**:
   - Equip Relequen (5pc)
   - Should detect: DPS

4. **Manual Override**:
   - Set role to "Tank" in settings
   - Equip DPS set
   - Should still show: Tank (overridden)

**Expected Results**:
- ✅ Tank sets detected correctly
- ✅ Healer sets detected correctly
- ✅ DPS sets detected correctly
- ✅ Manual override works

**Success Criteria**: Role detection accurate and useful

**End of Phase 4**: Equipment tracking complete, role detection functional

---

## Phase 5: Position Tracking

### Checkpoint 5.1: Position Broadcasting (2 Players)

**When**: After implementing position broadcasting

**Requirements**: 2 players, same zone, grouped

**How to Test**:

**Player 1 & 2**:
1. Stand far apart (different sides of zone)
2. Run: `/btlwdata grouppos`

**Expected Display**:
```
=== Group Positions ===
[Player1]: Zone=23, X=0.5, Y=0.3, Distance from Crown: 0m
[Player2]: Zone=23, X=0.6, Y=0.4, Distance from Crown: 45m
```

**Test Scenarios**:
1. **Position Sync**:
   - Verify coordinates displayed
   - Check zone ID correct
   - Verify distance calculation

2. **Movement Tracking**:
   - Player 2 moves
   - Player 1 runs: `/btlwdata grouppos`
   - Should see updated coordinates

3. **Update Frequency**:
   - Check position updates at ~100ms
   - Verify smooth tracking

**Expected Results**:
- ✅ Positions sync correctly
- ✅ Coordinates accurate
- ✅ Distance calculations correct
- ✅ Smooth updates (100ms)

**Success Criteria**: Position tracking accurate and performant

---

### Checkpoint 5.2: Enhanced Follow the Crown

**When**: After enhancing Follow the Crown with position data

**Requirements**: 2+ players, grouped, crown designated

**How to Test**:
1. Form group
2. Designate crown (Player 1)
3. Player 2 moves away from crown
4. Check Follow the Crown UI

**Test Scenarios**:
1. **Distance Indicator**:
   - Stand near crown (<10m)
   - Should show: GREEN indicator (in range)
   - Move far from crown (>50m)
   - Should show: RED indicator (out of range)

2. **Direction Arrow**:
   - Move to different position relative to crown
   - Arrow should point toward crown
   - Verify accuracy

3. **Range Warning**:
   - Move >50m from crown
   - Should see warning: "Out of range of Crown"

**Expected Results**:
- ✅ Distance indicator accurate
- ✅ Direction arrow points correctly
- ✅ Range warning appears appropriately
- ✅ Visual feedback clear

**Success Criteria**: Enhanced Follow the Crown helps players stay with group

**End of Phase 5**: Position tracking integrated, Follow the Crown enhanced

---

## Phase 6: Ability & Effect Tracking

### Checkpoint 6.1: Full Ability Bar Sync (2 Players)

**When**: After implementing full ability bar broadcasting

**Requirements**: 2 players, grouped

**How to Test**:

**Player 1**:
1. Run: `/btlwdata groupabilities`
2. Should see Player 2's full skill bars

**Player 2**:
1. Swap skill bar (weapon swap)
2. Player 1 runs: `/btlwdata groupabilities`
3. Should see updated bar

**Expected Display**:
```
=== [Player2] Skill Bars ===
Front Bar:
  1: Subterranean Assault
  2: Surprise Attack
  ...
  8: Soul Tether (Ultimate)
  
Back Bar:
  1: Resolving Vigor
  ...
  8: Soul Tether (Ultimate)
```

**Test Scenarios**:
1. **Full Bar Display**:
   - Verify all 10 abilities shown
   - Check both bars accurate

2. **Bar Swap Detection**:
   - Player 2 swaps bar
   - Player 1 sees update
   - Active bar highlighted

3. **Ability Change**:
   - Player 2 changes ability
   - Player 1 sees new ability

**Expected Results**:
- ✅ All 10 abilities transmitted
- ✅ Bar swaps detected
- ✅ Updates sync quickly
- ✅ Ability names correct

**Success Criteria**: Full skill bar tracking functional

---

### Checkpoint 6.2: Active Effect Filtering

**When**: After implementing active effect tracking and filtering

**How to Test**:
1. Apply various buffs
2. Run: `/btlwdata effects`

**Expected Display (only important effects)**:
```
=== Active Effects ===
Major Prophecy: 23s
Rally: 15s
Potion Buff: 45s
NOT SHOWN: Mundus Stone (filtered)
NOT SHOWN: Vampire Stage 2 (filtered)
```

**Test Scenarios**:
1. **Important Effects**:
   - Food buff: Should show
   - Potion buff: Should show
   - Major/Minor buffs: Should show
   - Rally/Vigor: Should show

2. **Filtered Effects**:
   - Mundus stone: Should NOT show
   - Vampire/Werewolf: Should NOT show
   - Passive effects: Should NOT show

3. **Group Sync**:
   - Player 1 has Rally active
   - Player 2 runs: `/btlwdata groupeffects`
   - Should see Player 1's Rally

**Expected Results**:
- ✅ Important effects tracked
- ✅ Unimportant effects filtered
- ✅ Duration accurate
- ✅ Group sync working

**Success Criteria**: Effect tracking useful, not spammy

**End of Phase 6**: Full ability and effect tracking complete

---

## Phase 7: Synergy Tracking

### Checkpoint 7.1: Synergy Detection

**When**: After implementing synergy detection and cooldowns

**How to Test**:
1. Activate a synergy (e.g., from Necrotic Orb)
2. Run: `/btlwsynergy`

**Expected Display**:
```
=== Synergy Cooldowns ===
Combustion Synergy: 18s remaining
Bone Shield: Ready
```

**Test Scenarios**:
1. **Synergy Activation**:
   - Activate synergy
   - Verify 20s cooldown starts
   - Check countdown accuracy

2. **Multiple Synergies**:
   - Activate different synergies
   - Each should have independent cooldown

3. **Cooldown Expiry**:
   - Wait 20 seconds
   - Run: `/btlwsynergy`
   - Should show "Ready"

**Expected Results**:
- ✅ Synergy activation detected
- ✅ 20s cooldown accurate
- ✅ Independent cooldowns work
- ✅ Cooldown expiry detected

**Success Criteria**: Synergy cooldown tracking functional

---

### Checkpoint 7.2: Synergy UI

**When**: After implementing synergy UI window

**How to Test**:
1. Launch ESO, log in
2. Open Synergy Tracking UI
3. Activate various synergies

**Test Scenarios**:
1. **UI Display**:
   - Window shows tracked synergies
   - Progress bars for cooldowns
   - Color coding (green=ready, yellow=cooldown)

2. **Real-time Updates**:
   - Activate synergy
   - UI updates immediately
   - Progress bar counts down smoothly

3. **Group Display**:
   - Form group
   - Player 2 activates synergy
   - Player 1's UI shows cooldown

**Expected Results**:
- ✅ UI displays correctly
- ✅ Real-time updates smooth
- ✅ Group synergies shown
- ✅ Visual feedback clear

**Success Criteria**: Synergy UI useful for group coordination

**End of Phase 7**: Synergy tracking complete

---

## Phase 8: Attack Coordination

### Checkpoint 8.1: Proximity Detonation Timer

**When**: After implementing bomb timer

**How to Test**:
1. Slot Proximity Detonation
2. Cast ability
3. Should see 8-second countdown timer

**Test Scenarios**:
1. **Timer Start**:
   - Cast proxy det
   - Timer starts at 8.0s
   - Counts down smoothly

2. **Timer Accuracy**:
   - Time actual detonation
   - Should be exactly 8 seconds
   - Verify +/- 0.1s accuracy

3. **Multiple Casters**:
   - Form group
   - Multiple players cast proxy det
   - Each should show separate timer

4. **Visual Display**:
   - Timer shows clearly
   - Highlights "optimal window"
   - Color coded (green->yellow->red)

**Expected Results**:
- ✅ Timer starts on cast
- ✅ 8-second countdown accurate
- ✅ Multiple timers tracked
- ✅ Visual display clear

**Success Criteria**: Bomb timer accurate and useful

---

### Checkpoint 8.2: Subterranean Assault Timer

**When**: After implementing shalk timer

**How to Test**:
1. Slot Subterranean Assault (or Deep Fissure)
2. Cast ability
3. Should see 3-second countdown timer

**Test Scenarios**:
1. **Timer Start**:
   - Cast ability
   - Timer starts at 3.0s
   - Counts down smoothly

2. **Timer Accuracy**:
   - Time actual shalks emerging
   - Should be exactly 3 seconds
   - Verify +/- 0.1s accuracy

3. **Coordinated Timing**:
   - Multiple players cast shalks
   - UI shows all timers
   - Highlights optimal "shalk window"

**Expected Results**:
- ✅ Timer starts on cast
- ✅ 3-second countdown accurate
- ✅ Multiple timers work
- ✅ Coordination window clear

**Success Criteria**: Shalk timer enables coordinated damage

---

### Checkpoint 8.3: Unified Attack UI

**When**: After implementing unified attack coordination UI

**Requirements**: Group with multiple DPS

**How to Test**:
1. Form group with 3+ DPS
2. Coordinate attack (proxy + shalks)
3. Check Attack Coordination window

**Expected Display**:
- Timeline showing all abilities
- Proxy det timers (8s)
- Shalk timers (3s)
- Optimal "bomb window" highlighted
- Per-player ability icons

**Test Scenarios**:
1. **Coordinated Attack**:
   - Leader calls "bomb in 5"
   - Multiple players cast proxy det
   - 5 seconds later, cast shalks
   - UI should show aligned timers

2. **Sound Alerts**:
   - Enable sound alerts
   - Set alert to 1s before optimal
   - Should hear alert at right time

3. **Visual Feedback**:
   - Check timeline display
   - Verify optimal window highlighted
   - Check per-player icons

**Expected Results**:
- ✅ Timeline shows all abilities
- ✅ Optimal window clear
- ✅ Sound alerts timely
- ✅ Visual feedback excellent

**Success Criteria**: Attack coordination UI enables effective group damage

**End of Phase 8**: Attack coordination complete

---

## Phase 9: UI Polish & Settings

### Checkpoint 9.1: Settings Menu Review

**When**: After reorganizing settings menu

**How to Test**:
1. Open Beltalowda settings
2. Review all sections

**Expected Organization**:
```
Beltalowda Settings
├── Profile Management
├── Fixed Component Positioning
├── Core Features
│   ├── Ultimate Tracking
│   ├── Synergy Tracking
│   ├── Attack Coordination
│   └── Resource Display
├── Group Positioning
│   ├── Follow the Crown
│   ├── Compass
│   └── Group Beams
├── PvP Quality of Life
│   ├── Restock Assistant
│   ├── Queue Helper
│   ├── Log Helper
│   └── Invite Assistant
├── ... (existing sections)
```

**Test Scenarios**:
1. **Navigation**:
   - Open each section
   - Verify logical organization
   - Check tooltips present

2. **Settings Changes**:
   - Toggle features on/off
   - Change values
   - Verify changes apply

3. **Tooltips**:
   - Hover over each setting
   - Should see helpful tooltip
   - Tooltips accurate and clear

**Expected Results**:
- ✅ Menu organized logically
- ✅ All settings accessible
- ✅ Tooltips helpful
- ✅ Changes apply correctly

**Success Criteria**: Settings menu intuitive and complete

---

### Checkpoint 9.2: UI Presets

**When**: After implementing UI presets

**How to Test**:
1. Open Beltalowda settings
2. Find "UI Presets" section
3. Apply each preset

**Test Scenarios**:
1. **Damage Preset**:
   - Click "Apply Damage Preset"
   - Should enable:
     - Ultimate tracking (for damage ults)
     - Attack coordination (bomb/shalk)
     - Minimal resource overview
   - Verify UI positions optimized for DPS role

2. **Support Preset**:
   - Click "Apply Support Preset"
   - Should enable:
     - Ultimate tracking (for healing/support ults)
     - Synergy tracking
     - Resource overview (health priority)
   - Verify UI positions optimized for support/healing role

3. **Lead Preset**:
   - Click "Apply Lead Preset"
   - Should enable:
     - Ultimate tracking (for crown/coordination ults)
     - Resource overview (for group health)
     - Follow the Crown features
     - Group positioning tools
   - Verify UI positions optimized for leading/crown role

**Expected Results**:
- ✅ Presets apply correctly
- ✅ Settings change as expected
- ✅ UI positions appropriate for PvP role (Damage/Support/Lead)
- ✅ Quick and convenient

**Success Criteria**: UI presets make setup easy for new users

**End of Phase 9**: UI polished and settings complete

---

## Phase 10: PvP QoL Refinement

### Checkpoint 10.1: Restock Enhancement

**When**: After enhancing restock feature

**Requirements**: Access to siege merchant in Cyrodiil

**How to Test**:
1. Go to siege merchant
2. Configure restock list
3. Open merchant

**Test Scenarios**:
1. **Auto-Restock**:
   - Set: Stone Trebs = 20
   - Have: 10 Stone Trebs
   - Open siege merchant
   - Should auto-purchase 10 more

2. **Gold Warning**:
   - Set gold warning = 10,000
   - Set item that costs > 10k total
   - Open merchant
   - Should see warning before purchase

3. **Multi-Loadout**:
   - Create loadout "Offensive" (trebs, ballistas)
   - Create loadout "Defensive" (oils, meatbags)
   - Switch between loadouts
   - Verify correct items restocked

**Expected Results**:
- ✅ Auto-restock works correctly
- ✅ Gold warning appears appropriately
- ✅ Multi-loadout system functional
- ✅ UI improved and clear

**Success Criteria**: Restock feature reliable and convenient

---

### Checkpoint 10.2: Queue Helper

**When**: After enhancing queue helper

**Requirements**: Access to campaign queue

**How to Test**:
1. Configure queue helper
2. Queue for campaign
3. Wait for prompt

**Test Scenarios**:
1. **Auto-Accept**:
   - Enable auto-accept
   - Set delay = 2 seconds
   - Queue for campaign
   - When prompt appears, should auto-accept after 2s

2. **Campaign Priority**:
   - Set: Gray Host = Priority 1
   - Set: Blackreach = Priority 2
   - Queue for both
   - If both pop, should accept higher priority

3. **Queue Position**:
   - While in queue, run: `/btlwqueue`
   - Should show position in queue

**Expected Results**:
- ✅ Auto-accept works with delay
- ✅ Priority system works
- ✅ Queue position displayed
- ✅ Configurable and reliable

**Success Criteria**: Queue helper saves time and hassle

---

### Checkpoint 10.3: Log Helper

**When**: After implementing log helper auto-toggle

**Requirements**: Combat log addon (if used)

**How to Test**:
1. Configure log helper
2. Enter long combat

**Test Scenarios**:
1. **Auto-Toggle**:
   - Set max duration = 5 minutes
   - Enter combat
   - Combat log starts
   - At 5 minutes, should auto-toggle off and restart

2. **Size Warning**:
   - Set size warning = 50MB
   - Combat log reaches 50MB
   - Should see warning

**Expected Results**:
- ✅ Auto-toggle works correctly
- ✅ Size warning appears
- ✅ No log corruption
- ✅ Configurable thresholds

**Success Criteria**: Log helper prevents log corruption

**End of Phase 10**: QoL features refined and reliable

---

## Phase 11: Performance & Optimization

### Checkpoint 11.1: Performance Baseline

**When**: Before optimization work

**How to Test**:
1. Form 12-player group
2. Enter Cyrodiil combat
3. Record metrics

**Metrics to Record**:
```lua
/script local fps = GetFramerate()
/script d("FPS: " .. fps)

/script local mem = collectgarbage("count")
/script d("Memory: " .. mem .. " KB")
```

**Test Scenarios**:
1. **Solo** (no group):
   - Record FPS
   - Record memory

2. **Group** (12 players):
   - Record FPS
   - Record memory

3. **Combat** (heavy combat):
   - Record FPS during fight
   - Record memory during fight

**Baseline Goals**:
- Solo FPS: 60+
- Group FPS: 57+ (< 5% drop)
- Combat FPS: 54+ (< 10% drop)
- Memory: < 50MB

**Success Criteria**: Establish baseline for optimization

---

### Checkpoint 11.2: Post-Optimization Verification

**When**: After optimization work complete

**How to Test**: Same as 11.1, compare metrics

**Expected Improvements**:
- FPS impact reduced
- Memory usage reduced
- Smoother updates
- No stuttering

**Specific Tests**:
1. **Message Batching**:
   - Enable debug: `/script Beltalowda.network.debugBatching = true`
   - Verify messages batched
   - Check batch size reasonable

2. **Update Throttling**:
   - Verify updates not spamming
   - Check throttle intervals respected

3. **Caching**:
   - Verify set names cached
   - Verify ability info cached
   - Check cache hits vs misses

**Expected Results**:
- ✅ FPS impact < 5%
- ✅ Memory < 50MB
- ✅ No stuttering
- ✅ Smooth performance

**Success Criteria**: Performance targets met

**End of Phase 11**: Addon optimized and performant

---

## Phase 12: Testing & Documentation

### Checkpoint 12.1: Full Feature Test

**When**: Before release

**Test Matrix**:

| Feature | Solo | 2-Player | 4-Player | 12-Player |
|---------|------|----------|----------|-----------|
| Ultimate Tracking | ✅ | ✅ | ✅ | ✅ |
| Synergy Tracking | ✅ | ✅ | ✅ | ✅ |
| Attack Coordination | ✅ | ✅ | ✅ | ✅ |
| Equipment Tracking | ✅ | ✅ | ✅ | ✅ |
| Position Tracking | - | ✅ | ✅ | ✅ |
| Restock | ✅ | - | - | - |
| Queue Helper | ✅ | - | - | - |
| Log Helper | ✅ | - | - | - |
| Invite Assistant | ✅ | - | - | - |

**For Each Feature**:
- Test enable/disable
- Test all settings
- Test edge cases
- Verify no errors

**Success Criteria**: All features pass all tests

---

### Checkpoint 12.2: Stress Test

**When**: Before release

**Requirements**:
- 12-player group
- Cyrodiil
- Heavy combat (large group fight)

**How to Test**:
1. Form 12-player group
2. Enter large fight (50+ players)
3. Fight for 30+ minutes
4. Monitor for issues

**What to Monitor**:
- FPS (should stay > 54)
- Memory (should stay < 50MB)
- Errors (should be none)
- Data sync (should be accurate)
- UI responsiveness (should be smooth)

**Failure Conditions**:
- FPS drops > 10%
- Memory exceeds 50MB
- Any errors in chat
- Data desync
- UI freezing/stuttering

**Expected Results**:
- ✅ Sustained good performance
- ✅ No errors
- ✅ Data accurate
- ✅ UI responsive

**Success Criteria**: Addon stable under stress

---

### Checkpoint 12.3: Documentation Review

**When**: Before release

**Documents to Review**:
1. User Guide
2. Settings Guide
3. Troubleshooting Guide
4. FAQ
5. Video Tutorials

**Review Criteria**:
- Accurate
- Complete
- Clear
- Up-to-date
- Well-organized

**User Testing**:
- Give docs to 3+ new users
- Ask them to set up addon
- Note any confusion
- Update docs accordingly

**Success Criteria**: Documentation enables successful setup and use

---

### Final Checkpoint: Release Readiness

**All Checkpoints Passed**:
- ✅ Phase 0: Foundation
- ✅ Phase 1: Data Collection
- ✅ Phase 2: LibGroupBroadcast
- ✅ Phase 3: Enhanced Ultimates
- ✅ Phase 4: Equipment Tracking
- ✅ Phase 5: Position Tracking
- ✅ Phase 6: Abilities & Effects
- ✅ Phase 7: Synergy Tracking
- ✅ Phase 8: Attack Coordination
- ✅ Phase 9: UI Polish
- ✅ Phase 10: QoL Refinement
- ✅ Phase 11: Performance
- ✅ Phase 12: Testing & Docs

**Release Criteria Met**:
- ✅ All features functional
- ✅ Performance acceptable
- ✅ No critical bugs
- ✅ Documentation complete
- ✅ User testing successful

**Ready for Release**: 🎉

---

## Checkpoint Summary

This guide provides 30+ detailed checkpoints across 12 phases of development. Each checkpoint ensures quality and stability before proceeding.

**Key Principles**:
1. Test early, test often
2. Don't skip checkpoints
3. Fix issues before moving forward
4. Document what you test
5. Get user feedback

**Using This Guide**:
- Follow checkpoints in order
- Check off each as completed
- Document any issues found
- Don't proceed if checkpoint fails
- Return to this guide frequently

**Next Steps**: Begin Phase 0, Checkpoint 0.1
