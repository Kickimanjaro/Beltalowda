# Beltalowda Enhanced Architecture Plan

## Executive Summary

This document outlines a comprehensive plan to enhance Beltalowda with advanced group data tracking and sharing capabilities, leveraging LibGroupBroadcast for efficient data synchronization and LibSets for equipment-dependent tracking.

## Current State Analysis

### Existing Features (RdK-derived)
- **Ultimate Tracking**: Basic ultimate percentage tracking via party chat
- **Resource Overview**: Visual display of group member ultimates
- **Synergy Overview**: Tracking synergy cooldowns
- **Rapid Tracker**: Expedition buff tracking
- **Debuff Overview**: Group debuff monitoring (proxy/shalks timers)
- **Potion Overview**: Buff duration tracking
- **Follow the Crown**: Visual assistance for group positioning
- **Auto Invite**: Automated group invitation system

### Current Technical Stack
- **Libraries in Use**:
  - LibAddonMenu-2.0 (settings UI)
  - LibGPS (positioning)
  - Lib3D (3D rendering for visual effects)
  - LibMapPing (map coordination)
  - LibCustomMenu (context menus)
  - LibFoodDrinkBuff (food/drink tracking)
  - LibPotionBuff (potion tracking)
  - **LibGroupBroadcast** (already declared as dependency!)

### Current Limitations
1. **Simple Networking**: Ultimate tracking uses party chat messages instead of LibGroupBroadcast's full capabilities
2. **Limited Data Sharing**: Only ultimate percentages are currently broadcast
3. **No Equipment Tracking**: Cannot track equipped gear or sets
4. **Basic Ability Detection**: Limited to ultimate abilities, not full skill bar
5. **No Position Sharing**: While LibGPS is available, position data isn't shared with group

## Proposed Enhanced Architecture

### Core Data Collection Layer

A new modular system for collecting and managing player state data:

```
Base/Data/
├── DataCollector.lua          # Main data collection coordinator
├── ResourceCollector.lua      # Health, Magicka, Stamina, Ultimate
├── PositionCollector.lua      # Player position via LibGPS
├── AbilityCollector.lua       # Skill bar abilities and active effects
├── EquipmentCollector.lua     # Equipped gear via LibSets
├── StateCollector.lua         # Combat state, alive/dead, online status
└── PreferencesCollector.lua   # Player settings and keybinds
```

#### DataCollector (Coordinator)
**Purpose**: Central coordinator for all data collection modules

**Responsibilities**:
- Initialize all collector modules
- Register for relevant events
- Coordinate data updates
- Provide unified interface for data access
- Manage data update intervals (throttling)

**Key Functions**:
```lua
function DataCollector.Initialize()
function DataCollector.RegisterCollector(collectorModule)
function DataCollector.GetPlayerData(unitTag)
function DataCollector.GetGroupData()
```

#### ResourceCollector
**Purpose**: Track all player resources

**Data Tracked**:
- Current/Max Health
- Current/Max Magicka  
- Current/Max Stamina
- Current/Max Ultimate
- Ultimate cost (for percentage calculation)
- Ultimate ability ID (which ult is slotted)

**Events Used**:
- `EVENT_POWER_UPDATE` (all resource changes)
- `EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED` (shield values)

**Update Frequency**: Real-time with 5% threshold for broadcasting

#### PositionCollector
**Purpose**: Track player position for group coordination

**Data Tracked**:
- Global X, Y coordinates (via LibGPS)
- Zone ID
- Distance from group leader
- Distance from other group members
- In range of camp (for resurrection)

**Events Used**:
- `EVENT_PLAYER_ACTIVATED` (zone changes)
- Periodic updates (100ms for smooth position tracking)

**Integration**: Uses existing LibGPS library

#### AbilityCollector
**Purpose**: Track player abilities and active effects

**Data Tracked**:
- **Skill Bar Abilities** (10 total: 5 per bar):
  - Ability ID
  - Ability name
  - Icon
  - Is ultimate? (slot 8)
- **Active Effects** (buffs/debuffs):
  - Effect ID
  - Effect name
  - Duration remaining
  - Stack count
  - Is relevant for group? (configurable filter)

**Events Used**:
- `EVENT_ACTION_SLOT_UPDATED` (skill bar changes)
- `EVENT_EFFECT_CHANGED` (buff/debuff application)
- `EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED` (visual effects)

**Special Cases**:
- Volendrung detection (weapon pickup)
- Synergy availability
- Major/Minor buff tracking

#### EquipmentCollector
**Purpose**: Track equipped gear for set-dependent features

**Data Tracked**:
- Equipped item set IDs (via LibSets)
- Set names (localized)
- Active set bonuses (5-piece, 2-piece counts)
- Monster set cooldown status
- Proc set cooldowns

**Integration**: 
- Uses **LibSets** for set identification
- Tracks 14 equipment slots
- Detects set bonus activation

**Events Used**:
- `EVENT_INVENTORY_SINGLE_SLOT_UPDATE` (gear changes)
- `EVENT_EFFECT_CHANGED` (set proc effects)

**Use Cases**:
- Monster set cooldown tracking
- Proc set coordination
- Role detection based on gear (tank/healer/DPS sets)

#### StateCollector
**Purpose**: Track player state and availability

**Data Tracked**:
- In combat status
- Alive/Dead/Reincarnating
- Online/Offline/Disconnected
- In reload UI (loading screen)
- In range of forward camp
- AFK status
- Group role (tank/healer/DPS)
- Champion Points allocation (for advanced analysis)

**Events Used**:
- `EVENT_PLAYER_COMBAT_STATE` (combat state)
- `EVENT_UNIT_DEATH_STATE_CHANGED` (death/resurrection)
- `EVENT_GROUP_MEMBER_CONNECTED_STATUS` (online status)
- `EVENT_ACTION_LAYER_PUSHED/POPPED` (UI state)

#### PreferencesCollector
**Purpose**: Store player-specific addon settings

**Data Tracked**:
- Primary ultimate selection
- Role preference (for auto-assignment)
- Keybind configurations
- UI preferences (for coordinated UI across group)
- Broadcasting preferences

**Storage**: SavedVariables (per-character and account-wide)

---

### Network Layer (LibGroupBroadcast Integration)

**File**: `Base/Network/GroupBroadcast.lua`

#### LibGroupBroadcast Benefits Over Party Chat

**Current (Party Chat)**:
- ❌ Limited to ~100 characters per message
- ❌ Throttled by ESO's chat rate limits
- ❌ Messages visible in chat history (must be filtered)
- ❌ Can be blocked by player chat settings
- ❌ Inefficient for complex data structures

**With LibGroupBroadcast**:
- ✅ Efficient binary protocol
- ✅ Larger data payloads (up to 512 bytes per message)
- ✅ Reliable delivery with acknowledgment
- ✅ Multiple message channels (IDs)
- ✅ Designed specifically for addon data sharing
- ✅ Better performance in large groups (12+ players)

#### Message ID Allocation Strategy

LibGroupBroadcast requires unique message IDs for each addon/feature. Based on issue #12 context and current usage in Networking.lua:

**Already Allocated IDs** (from Networking.lua):
- 60: HP data
- 50: Damage data
- 190: Boom/Detonation
- 110: Synergy
- 109: Role
- 189: Version info
- 188: Version request
- 170: Admin request
- 169-167: Admin responses

**Proposed New ID Block** (request from LibGroupBroadcast maintainer):
We should request IDs **200-219** (20 IDs) for comprehensive data sharing:

- **200**: Resource packet (Health, Magicka, Stamina, Ultimate %)
- **201**: Ultimate details (ability ID, cost, ready status)
- **202**: Position packet (X, Y, Zone)
- **203**: Ability bar packet (10 ability IDs)
- **204**: Equipment packet (set IDs, part 1)
- **205**: Equipment packet (set IDs, part 2)
- **206**: State packet (combat, alive, online status)
- **207**: Active effects (critical buffs/debuffs)
- **208**: Keybind sync (coordinated ability casting)
- **209**: Role assignment (tank/healer/DPS)
- **210-214**: Reserved for future features
- **215-219**: Reserved for experimental features

#### Data Broadcasting Strategy

**Frequency Tiers**:

1. **High Frequency (100ms)**: Real-time critical data
   - Position updates (for follow crown)
   - Resource changes (>5% change)
   - Combat state changes

2. **Medium Frequency (500ms)**: Important but less volatile
   - Active effects (buffs/debuffs)
   - Ultimate ability readiness
   - State changes (combat, alive/dead)

3. **Low Frequency (2000ms)**: Static or slow-changing data
   - Equipment changes
   - Ability bar changes
   - Role assignments

4. **On-Demand**: Event-triggered only
   - Keybind actions
   - Version information
   - Admin commands

**Data Compression**:
- Use bit-packing for boolean flags
- Delta compression for resources (send only changes)
- Reference tables for ability/set IDs (send index, not full name)

---

### Feature Modules (Modular Design)

Each feature is self-contained with clear dependencies on data collectors:

```
Base/Features/
├── UltimateTracking/
│   ├── UltimateTracker.lua        # Main ultimate tracking logic
│   ├── UltimateUI.lua             # Visual displays (bars, icons)
│   └── UltimateCoordination.lua   # Priority system, rotation
│
├── SynergyTracking/
│   ├── SynergyTracker.lua         # Synergy availability tracking
│   ├── SynergyUI.lua              # Visual displays
│   └── SynergyCooldowns.lua       # Cooldown management
│
├── AttackCoordination/
│   ├── BombTimer.lua              # Proxy det coordination
│   ├── ShalkTimer.lua             # Subterranean assault timing
│   ├── SynergyTimer.lua           # Inner rage, runebreak timing
│   └── AttackUI.lua               # Unified visual display
│
└── QualityOfLife/
    ├── Restock.lua                # Auto-restock from siege merchant
    ├── QueueHelper.lua            # Auto-accept campaign queue
    ├── LogHelper.lua              # Combat log toggle automation
    └── InviteAssistant.lua        # Advanced auto-invite (already exists)
```

#### Feature: Ultimate Tracking (Enhanced)

**Current Implementation**: `Base/Group/ResourceOverview.lua`

**Enhancements Needed**:

1. **Specific Ultimate Detection**:
   - Use AbilityCollector to detect slotted ultimate (slot 8)
   - Track which ultimate each player has equipped
   - Display type-specific counts (not just total ready)

2. **Dynamic Ultimate Addition**:
   - Detect Volendrung pickup (special weapon)
   - Temporarily add Ruinous Cyclone to tracker
   - Remove when weapon is dropped
   - Apply to other special abilities (siege weapons, etc.)

3. **Priority System**:
   - Configurable cast order for same ultimate type
   - Visual indicators for "next to cast"
   - Rotation suggestions based on cooldown timing

4. **Enhanced UI**:
   - Keep existing 4 windows (Client, Group, Overview, Blocks)
   - Add per-ultimate-type counts in Group Ultimates window
   - Color-code priority order
   - Add "intensity" effect for held ultimates (reminder to cast)

**Data Dependencies**:
- ResourceCollector: Ultimate percentage
- AbilityCollector: Ultimate ability ID (slot 8)
- StateCollector: Combat status, alive/dead
- GroupBroadcast: Sync data to all group members

#### Feature: Synergy Tracking

**Similar to Ultimate Tracking but for Synergies**:

**Tracked Synergies**:
- Class synergies (Conduit, Shackle, Healing Seed, etc.)
- World synergies (Blood Altar, Bone Shield, etc.)
- Dungeon/Trial specific synergies

**Cooldown Tracking**:
- Individual synergy cooldowns (20 seconds)
- Visual progress bars
- Availability indicators

**Data Dependencies**:
- AbilityCollector: Active synergies from effects
- StateCollector: Synergy activation events
- GroupBroadcast: Share synergy usage with group

#### Feature: Attack Coordination

**Current Implementation**: `Base/Group/DetonationTracker.lua` (partial)

**Enhancements**:

1. **Ability Timers**:
   - Proximity Detonation: 8 second fuse
   - Subterranean Assault / Deep Fissure: 3 second delay
   - Track per-player cast times
   - Show unified "bomb window" countdown

2. **Synergy Coordination**:
   - Inner Rage: 12 second debuff
   - Runebreak: Instant pull synergy
   - Lightning Flood: Synergy for damage
   - Coordinate timing with bomb window

3. **Visual Display**:
   - Timeline showing all casts
   - Highlight coordinated damage window
   - Per-player ability icons with timers
   - Sound alerts for optimal timing

**Data Dependencies**:
- AbilityCollector: Detect ability casts
- StateCollector: Combat status
- GroupBroadcast: Share cast timing

#### Feature: PvP Quality of Life

##### 1. Restock (Siege Merchant)

**Based on**: `Base/Toolbox/SiegeMerchant.lua` (already exists!)

**Current State**: Already implemented as "RdK Merchant Assistant"

**Enhancement Opportunities**:
- Improved UI for configuration
- Multiple item lists (different loadouts)
- Gold warning before purchase
- Integration with inventory tracking

##### 2. Queue Helper (Campaign Auto-Join)

**Based on**: `Base/Toolbox/CampaignAutoJoin.lua` (already exists!)

**Current State**: Already implemented

**Enhancement Opportunities**:
- Configurable delay before auto-accept
- Campaign preference list
- Queue position tracking

##### 3. Log Helper

**Based on**: `Base/Toolbox/CyrodiilLog.lua` (already exists!)

**Current State**: Already has log management

**Enhancement Opportunities**:
- Auto-toggle based on combat duration
- Warning before max log size
- Integration with combat state

##### 4. Invite Assistant

**Based on**: `Base/Group/AutoInvite.lua` (already exists!)

**Current State**: Already implemented

**Enhancement Opportunities**:
- Multi-string support
- Guild-specific strings
- Whisper response automation

**Note**: Most PvP QoL features already exist! Just need refinement and better menu organization.

---

### UI Architecture

**Display Philosophy**:
- Persistent tracking windows (Ultimate, Synergy) always visible when enabled
- Contextual displays (Bomb timers) appear only in combat
- All windows independently movable and lockable
- Unified visual style across all features

**Window Management**:
```lua
Base/UI/
├── WindowManager.lua      # Unified window positioning system
├── UltimateWindows.lua    # Ultimate tracking displays (existing)
├── SynergyWindows.lua     # Synergy tracking displays
├── AttackWindows.lua      # Attack coordination displays
└── QoLWindows.lua         # Quality of life feature UIs
```

**Settings Menu Organization**:
```
Beltalowda Settings
├── Profile Management (existing)
├── Fixed Component Positioning (existing)
├── [NEW SECTION] Core Features
│   ├── Ultimate Tracking
│   ├── Synergy Tracking
│   ├── Attack Coordination
│   └── Resource Display
├── [NEW SECTION] Group Positioning
│   ├── Follow the Crown (existing features)
│   ├── Compass (existing features)
│   └── Group Beams (existing features)
├── [NEW SECTION] PvP Quality of Life
│   ├── Restock Assistant (existing)
│   ├── Queue Helper (existing)
│   ├── Log Helper (existing)
│   └── Invite Assistant (existing)
├── Group Features (existing, reorganized)
├── Compass (existing)
├── Toolbox (existing, some moved to QoL)
├── Utilities (existing)
├── Class Roles (existing)
├── AddOn Integration (existing)
└── Admin (existing)
```

---

### SavedVariables Strategy

**Two-Tier Storage**:

1. **Account-Wide** (`BeltalowdaVars`, account-wide):
   - UI positions (shared across characters)
   - Window visibility preferences
   - Tracked ultimate lists (same for all chars)
   - Role assignments per character
   - Keybind preferences

2. **Per-Character** (`BeltalowdaVars`, character-specific):
   - Current selected ultimate
   - Character-specific role
   - Equipment loadout preferences
   - Last known position
   - Character keybinds (if different from account)

**Data Structure** (addition to existing):
```lua
BeltalowdaVars = {
    version = 1,
    
    -- Account-wide
    profiles = {
        [1] = {
            -- Existing profile data
            
            -- NEW: Enhanced feature settings
            ultimateTracking = {
                enabled = true,
                showClientUltimate = true,
                showGroupUltimates = true,
                showUltimateOverview = true,
                showPlayerBlocks = true,
                trackedUltimates = { ... },  -- List of 12 ultimate IDs
                prioritySystem = true,
                intensityReminder = true,
                dynamicAbilities = true,  -- Volendrung, etc.
            },
            
            synergyTracking = {
                enabled = true,
                showAvailability = true,
                showCooldowns = true,
                trackedSynergies = { ... },
            },
            
            attackCoordination = {
                enabled = true,
                showBombTimers = true,
                showShalkTimers = true,
                showSynergyTimers = true,
                soundAlerts = true,
            },
            
            qolFeatures = {
                restock = { enabled = true, items = { ... } },
                queueHelper = { enabled = true, autoAccept = true },
                logHelper = { enabled = true, maxDuration = 300 },
                inviteAssistant = { enabled = true, triggers = { ... } },
            },
            
            broadcasting = {
                enabled = true,
                sendResources = true,
                sendPosition = true,
                sendAbilities = true,
                sendEquipment = true,
                sendState = true,
            },
        }
    },
    
    -- Per-character
    characters = {
        ["CharacterName"] = {
            primaryUltimate = 123456,  -- Ability ID
            role = "DPS",
            equipment = { ... },
            lastPosition = { x = 0, y = 0, zone = 23 },
        }
    }
}
```

**Migration Strategy**:
- Detect old version in `Beltalowda.util.versioning.InitializeFixes()`
- Auto-populate new fields with sensible defaults
- Preserve existing settings
- One-time migration per version bump

---

## Dependency Analysis

### LibGroupBroadcast Dependencies

**LibGroupBroadcast itself requires**:
- None! It's a standalone library

**What we already have**:
- LibGroupBroadcast is already listed in `Beltalowda.txt` dependencies: `LibGroupBroadcast>=91`
- Code already checks for LGB existence in `Networking.lua`

**What we need to do**:
1. Request message ID block (200-219) from maintainer
2. Implement full data broadcasting (currently only uses existing IDs)
3. Expand message handling beyond current simple types

### LibSets Dependencies

**LibSets requires**:
- **LibAsync** (for asynchronous data loading)
- **LibDebugLogger** (already have it! `Lib/LibDebugLogger`)

**What we need**:
1. Add LibSets to `Lib/` directory
2. Add LibAsync to `Lib/` directory  
3. Update `Beltalowda.txt` to include new dependencies:
   ```
   ## DependsOn: ... LibSets>=71 LibAsync>=2
   ```

**LibSets Capabilities**:
- Get set ID from item link
- Get set name (localized)
- Get set bonuses (2-piece, 3-piece, etc.)
- Detect set piece count equipped
- Access set metadata (type, quality, etc.)

**LibSets Data**:
- Contains data for all item sets in ESO
- German and English localizations included
- Regularly updated for new sets

**Usage Example**:
```lua
local LibSets = LibSets
local setId = LibSets:GetItemLinkSetId(itemLink)
local setName = LibSets:GetSetName(setId)
local setType = LibSets:GetSetType(setId)
```

### Complete Dependency Tree

```
Beltalowda
├── LibAddonMenu-2.0 (settings UI) [HAVE]
├── LibMapPins-1.0 (map markers) [HAVE]
├── LibMapPing (map coordination) [HAVE]
├── LibGPS (positioning) [HAVE]
├── Lib3D (3D rendering) [HAVE]
├── LibFoodDrinkBuff (food tracking) [HAVE]
├── LibPotionBuff (potion tracking) [HAVE]
├── LibCustomMenu (context menus) [HAVE]
├── LibGroupBroadcast (data sharing) [HAVE]
│   └── (no dependencies)
├── LibSets (equipment detection) [NEED]
│   ├── LibAsync [NEED]
│   └── LibDebugLogger [HAVE]
└── LibDebugLogger (debug logging) [HAVE]
```

**New Libraries Needed**:
1. **LibSets** - Download from https://github.com/Baertram/LibSets
2. **LibAsync** - Download from ESOUI (dependency of LibSets)

---

## Implementation Order (Phased Approach)

### Phase 0: Foundation (Week 1-2)
**Goal**: Set up infrastructure without breaking existing features

**Tasks**:
1. Add LibSets and LibAsync to project
2. Update manifest dependencies
3. Create empty collector modules (stubs)
4. Test that addon still loads and existing features work

**Testing Checkpoint**: Load addon in-game, verify no errors, all existing features functional

---

### Phase 1: Data Collection (Week 3-4)
**Goal**: Collect all player data locally (no broadcasting yet)

**Tasks**:
1. Implement ResourceCollector
2. Implement StateCollector
3. Implement AbilityCollector (basic)
4. Create debug slash commands to view collected data
5. Add SavedVariables structure for new features

**Testing Checkpoint**: 
- Use `/btlwdata resources` to see health/magicka/stamina/ultimate
- Use `/btlwdata state` to see combat/alive/online status
- Use `/btlwdata abilities` to see skill bar

---

### Phase 2: LibGroupBroadcast Integration (Week 5-6)
**Goal**: Share basic data with group members

**Tasks**:
1. Request message ID block from LibGroupBroadcast maintainer
2. Implement GroupBroadcast.lua with new message handlers
3. Broadcast resource data (ID 200)
4. Broadcast state data (ID 206)
5. Receive and store data from other group members
6. Create debug commands to view received data

**Testing Checkpoint**:
- Form group with 2+ players with addon
- Verify resource data syncs between players
- Use `/btlwdata group` to see all group members' data

---

### Phase 3: Enhanced Ultimate Tracking (Week 7-8)
**Goal**: Improve existing ultimate tracking with new data

**Tasks**:
1. Detect slotted ultimate via AbilityCollector
2. Broadcast ultimate ability ID (ID 201)
3. Update Ultimate Overview to show type-specific counts
4. Implement dynamic ultimate addition (Volendrung)
5. Add priority system for same-ultimate coordination
6. Add intensity reminder visual effect

**Testing Checkpoint**:
- Verify ultimate type displays correctly for each player
- Test Volendrung pickup (if available)
- Verify priority order in group ultimates window

---

### Phase 4: Equipment Tracking (Week 9-10)
**Goal**: Track equipped gear and sets

**Tasks**:
1. Implement EquipmentCollector with LibSets
2. Broadcast equipment data (IDs 204-205)
3. Create debug display for equipped sets
4. Add monster set cooldown tracking
5. Implement role detection based on gear

**Testing Checkpoint**:
- Use `/btlwdata equipment` to see your sets
- Use `/btlwdata group equipment` to see group member sets
- Verify monster set cooldowns

---

### Phase 5: Position Tracking (Week 11-12)
**Goal**: Share player positions for coordination

**Tasks**:
1. Implement PositionCollector
2. Broadcast position data (ID 202)
3. Calculate distances between group members
4. Enhance Follow the Crown with position data
5. Add range indicators to Ultimate Display

**Testing Checkpoint**:
- Verify positions sync in group
- Test distance calculations
- Verify "in range" indicators

---

### Phase 6: Ability & Effect Tracking (Week 13-14)
**Goal**: Track skill bars and active effects

**Tasks**:
1. Complete AbilityCollector (full skill bar)
2. Implement active effect tracking (buffs/debuffs)
3. Broadcast ability bar data (ID 203)
4. Broadcast active effects (ID 207)
5. Create filter system for relevant effects

**Testing Checkpoint**:
- Verify skill bar syncs when changed
- Verify important buffs appear for group members
- Test effect filtering

---

### Phase 7: Synergy Tracking (Week 15-16)
**Goal**: Implement enhanced synergy tracking

**Tasks**:
1. Create SynergyTracker module
2. Implement cooldown tracking
3. Create SynergyUI displays
4. Broadcast synergy usage (ID 110, already allocated!)
5. Add settings menu integration

**Testing Checkpoint**:
- Verify synergy availability shows for group
- Test cooldown tracking (20 second standard)
- Verify UI displays correctly

---

### Phase 8: Attack Coordination (Week 17-18)
**Goal**: Implement bomb/shalk/synergy timers

**Tasks**:
1. Enhance DetonationTracker (already exists)
2. Create BombTimer, ShalkTimer modules
3. Create unified AttackUI display
4. Integrate with AbilityCollector for cast detection
5. Add sound alerts for optimal timing

**Testing Checkpoint**:
- Test proxy detonation timer accuracy
- Test subterranean assault timer
- Verify group coordination display

---

### Phase 9: UI Polish & Settings (Week 19-20)
**Goal**: Refine UI and settings menu

**Tasks**:
1. Reorganize settings menu (new sections)
2. Add comprehensive tooltips
3. Implement all customization options
4. Create UI presets (healer, DPS, tank)
5. Polish visual effects and animations

**Testing Checkpoint**:
- Review all settings menu options
- Test all toggles and customizations
- Verify UI presets work correctly

---

### Phase 10: PvP QoL Refinement (Week 21-22)
**Goal**: Improve existing QoL features

**Tasks**:
1. Enhance Restock with better UI
2. Improve Queue Helper configurability
3. Add Log Helper auto-toggle feature
4. Enhance Invite Assistant multi-string support
5. Create unified QoL settings submenu

**Testing Checkpoint**:
- Test restock with siege merchant
- Test queue auto-accept
- Test log helper toggle
- Test invite assistant triggers

---

### Phase 11: Performance & Optimization (Week 23-24)
**Goal**: Optimize for large groups and combat performance

**Tasks**:
1. Profile update frequencies
2. Implement data caching strategies
3. Optimize LibGroupBroadcast usage (batching)
4. Reduce memory allocations
5. Optimize UI update loops

**Testing Checkpoint**:
- Test with 12-player group in combat
- Monitor frame rate impact
- Check memory usage
- Verify no lag spikes

---

### Phase 12: Testing & Documentation (Week 25-26)
**Goal**: Comprehensive testing and user documentation

**Tasks**:
1. In-game testing with full group
2. Edge case testing (disconnects, zone changes)
3. Create user guide documentation
4. Record video demonstrations
5. Prepare for release (ESOUI upload)

**Testing Checkpoint**:
- Full feature test with 12-player group
- PvP stress test in Cyrodiil
- Trial stress test (if applicable)
- Review all documentation

---

## Risk Mitigation

### Technical Risks

**Risk**: LibGroupBroadcast message ID conflicts
- **Mitigation**: Request dedicated ID block early
- **Fallback**: Use existing high IDs (200+) which are unlikely to conflict

**Risk**: LibSets compatibility issues
- **Mitigation**: Test with latest LibSets version
- **Fallback**: Implement manual set detection (less reliable)

**Risk**: Performance impact with 12+ players
- **Mitigation**: Aggressive optimization in Phase 11
- **Fallback**: Reduce update frequencies, make features optional

**Risk**: Breaking existing features during refactor
- **Mitigation**: Phased approach, checkpoint testing
- **Fallback**: Git version control, easy rollback

### Process Risks

**Risk**: Scope creep (too many features)
- **Mitigation**: Stick to defined phases, defer nice-to-haves
- **Fallback**: Release in phases (v1.0, v1.1, etc.)

**Risk**: Testing difficulty (need multiple players)
- **Mitigation**: Use alt accounts, recruit testers early
- **Fallback**: Implement robust debug/simulation modes

**Risk**: Breaking changes to ESO API
- **Mitigation**: Monitor ESO patch notes, use stable APIs
- **Fallback**: Maintain compatibility layer for API changes

---

## Success Criteria

### Functional Requirements
- [ ] All data collectors functioning and collecting accurate data
- [ ] LibGroupBroadcast successfully sharing data in 12-player groups
- [ ] Enhanced ultimate tracking shows specific ultimate types
- [ ] Equipment tracking correctly identifies sets via LibSets
- [ ] Position tracking enables effective "follow crown" coordination
- [ ] Attack coordination timers are accurate to within 100ms
- [ ] All existing features continue to work without regression

### Performance Requirements
- [ ] No more than 5% FPS impact in 12-player combat
- [ ] Data updates within 200ms of actual changes
- [ ] Memory usage under 50MB total
- [ ] No UI stuttering or lag spikes

### Usability Requirements
- [ ] Settings menu organized and intuitive
- [ ] All windows independently movable and lockable
- [ ] Visual feedback for all important events
- [ ] No console errors during normal operation
- [ ] Compatible with existing ESO addons (no conflicts)

---

## Conclusion

This architecture plan provides a comprehensive, phased approach to enhancing Beltalowda with advanced group coordination features. The modular design ensures:

1. **Maintainability**: Clear separation of concerns
2. **Testability**: Incremental checkpoints at each phase
3. **Flexibility**: Features can be enabled/disabled independently
4. **Performance**: Optimized data collection and broadcasting
5. **Compatibility**: Builds on existing RdK foundation

The 26-week timeline allows for thorough development and testing while maintaining the quality and stability users expect from a PvP addon.

**Next Steps**: Proceed to implementation starting with Phase 0 (Foundation).
