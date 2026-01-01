# Beltalowda Development Roadmap

## Executive Summary

This roadmap outlines the complete development plan for enhancing Beltalowda from its current state (RdK-based PvP addon) to a comprehensive group coordination platform with advanced data tracking, sharing, and visualization capabilities.

**Timeline**: 26 weeks (6 months)  
**Approach**: Phased, incremental development with regular testing checkpoints  
**Philosophy**: Build on existing foundation, don't break working features

---

## Current State (Starting Point)

### ✅ What We Have

**Core Infrastructure**:
- ✅ ESO addon structure (manifest, initialization, profile system)
- ✅ LibAddonMenu-2.0 integration (settings UI)
- ✅ Profile-based configuration system
- ✅ SavedVariables for persistence
- ✅ LibGroupBroadcast declared as dependency (but underutilized)

**Existing Features** (from RdK):
- ✅ Ultimate tracking (basic, via party chat)
- ✅ Resource overview UI (player blocks, client ult, group ults, overview)
- ✅ Synergy overview
- ✅ Rapid tracker (expedition buff)
- ✅ Debuff overview (proxy/shalk timers)
- ✅ Potion overview
- ✅ Follow the Crown (visual, audio, warnings, beam)
- ✅ Group beams
- ✅ Auto-invite system
- ✅ Siege merchant restock
- ✅ Campaign auto-join
- ✅ Cyrodiil log management
- ✅ HP/Damage meter
- ✅ Various compasses and UI enhancements

### ❌ What We Need

**Infrastructure**:
- ❌ Data collection layer (modular collectors)
- ❌ Full LibGroupBroadcast integration (beyond basic usage)
- ❌ LibSets integration (equipment tracking)
- ❌ LibAsync (dependency of LibSets)
- ❌ Centralized network layer
- ❌ Enhanced SavedVariables structure

**Enhanced Features**:
- ❌ Specific ultimate detection (which ult is slotted)
- ❌ Dynamic ultimate addition (Volendrung, etc.)
- ❌ Priority system for ultimates
- ❌ Equipment tracking and role detection
- ❌ Position sharing
- ❌ Full skill bar tracking
- ❌ Active effect tracking (buffs/debuffs)
- ❌ Enhanced synergy tracking
- ❌ Attack coordination (bomb/shalk/synergy timers)
- ❌ Enhanced QoL features

---

## Phase 0: Foundation (Weeks 1-2)

**Goal**: Set up infrastructure without breaking existing features

### Week 1: Library Integration

**Tasks**:
1. Download and install LibSets
   - Place in `Lib/LibSets/`
   - Verify folder structure matches ESOUI distribution
   
2. Download and install LibAsync
   - Place in `Lib/LibAsync/`
   - Verify dependency requirements
   
3. Update `Beltalowda.txt` manifest
   - Add LibSets>=71 to DependsOn
   - Add LibAsync>=2 to DependsOn
   
4. Update `Beltalowda.lua` library checks
   - Add LibSets availability check
   - Add LibAsync availability check
   - Add informative error messages

**Deliverables**:
- ✅ LibSets installed and loading
- ✅ LibAsync installed and loading
- ✅ Updated manifest
- ✅ Library verification code

**Testing**:
- Load addon in-game
- Verify no missing library errors
- Verify all existing features still work

**Checkpoint**: Checkpoint 0.1 (Library Verification)

---

### Week 2: Research Existing Libraries ✅ COMPLETE - REVISED

**Tasks**:
1. **Research existing LibGroupBroadcast libraries**:
   - ✅ Research **LibGroupCombatStats** (Ultimate Type/Value, DPS, HPS)
   - ✅ Research **LibSetDetection** (Equipment sets)
   - ✅ Research **LibGroupResources** (Stamina, Magicka)
   - ✅ Document which data we can reuse vs need custom protocols
   - ✅ Update dependency list based on findings

2. ~~Create `Base/Data/` directory~~ **SKIPPED** - Not needed
   
3. ~~Create stub files~~ **SKIPPED** - Not needed:
   - ~~`Base/Data/DataCollector.lua`~~
   - ~~`Base/Data/ResourceCollector.lua`~~
   - ~~`Base/Data/PositionCollector.lua`~~
   - ~~`Base/Data/AbilityCollector.lua`~~
   - ~~`Base/Data/EquipmentCollector.lua`~~
   - ~~`Base/Data/StateCollector.lua`~~
   
4. ~~Create network stub~~ **Will be addressed in Phase 2**:
   - ~~`Base/Network/GroupBroadcast.lua`~~
   
5. ~~Update `Beltalowda.txt` to load new files~~ **Not needed**
   
6. ~~Implement basic Initialize() functions~~ **Not needed**
   
7. ~~Update main initialization in `Beltalowda.lua`~~ **Not needed**

**Deliverables**:
- ✅ Research completed on existing libraries
- ✅ Decision made: Use existing libraries (100% coverage) instead of custom protocols
- ❌ ~~All stub files created~~ - SKIPPED, not needed
- ❌ ~~Proper namespace initialization~~ - SKIPPED, not needed
- ❌ ~~Initialize() functions defined~~ - SKIPPED, not needed
- ❌ ~~Integration into main addon initialization~~ - SKIPPED, not needed
- ✅ Reserved IDs 220-229 for future use if needed

**Research Results**:
- **LibGroupCombatStats**: 100% coverage of ultimate tracking (IDs 20, 21, 22, 23)
- **LibSetDetection**: 100% coverage of equipment tracking (ID 40)
- **LibGPS**: Local position tracking (already installed)
- **Decision**: No custom data collection needed for MVP

**Testing**:
- Load addon in-game
- Verify no errors
- Verify all existing features still work
- Test profile system still works

**Checkpoint**: Checkpoint 0.1b (Existing Library Research) ✅ COMPLETE

**Checkpoint**: End of Phase 0
- ✅ All libraries researched
- ✅ Decision made: Use existing libraries instead of custom data collection
- ✅ No existing features broken
- ⏭️ Ready to proceed to Phase 2 (skip Phase 1)

---

## Phase 1: Data Collection ⏭️ SKIPPED

**Status**: PHASE SKIPPED - Not needed based on research findings

**Rationale**: 
Research from Checkpoint 0.1b revealed 100% coverage of critical data needs through existing libraries:
- LibGroupCombatStats: Ultimate tracking (IDs 20, 21, 22, 23)
- LibSetDetection: Equipment tracking (ID 40)
- LibGPS: Local position (already installed)

**Original Goal**: Collect player data locally (no broadcasting yet)

**What was skipped**:

### ~~Week 3: Resource & State Collection~~ SKIPPED

**Tasks**: ❌ Not needed
1. ~~Implement `ResourceCollector.lua`~~ - Use LibGroupCombatStats instead
2. ~~Implement `StateCollector.lua`~~ - Use native ESO API as needed
3. ~~Create debug commands~~ - Use existing library APIs

**Deliverables**: N/A - Using existing libraries

---

### ~~Week 4: Ability & Equipment Collection~~ SKIPPED

**Tasks**: ❌ Not needed
1. ~~Implement `AbilityCollector.lua`~~ - Use LibGroupCombatStats for ultimates
2. ~~Implement `EquipmentCollector.lua`~~ - Use LibSetDetection instead
3. ~~Expand debug commands~~ - Use existing library APIs

**Deliverables**: N/A - Using existing libraries

**Checkpoint**: End of Phase 1 - ⏭️ SKIPPED, proceed to Phase 2
- No custom collectors needed (using existing libraries)
- Ready for LibGroupBroadcast integration in Phase 2

---

## Phase 2: LibGroupBroadcast Integration (Weeks 5-6) ⏩ NEXT PHASE

**Status**: ACTIVE - Next phase to implement

**Goal**: Integrate with existing LibGroupBroadcast libraries (LibGroupCombatStats, LibSetDetection)

**Background**: 
Based on Phase 0 research, we will subscribe to existing library data rather than building custom collection modules. Reserved IDs 220-229 remain available for future custom protocols if needed.

### Week 5: Library Integration & Subscription

**Tasks**:
1. ~~Request message ID block from LibGroupBroadcast maintainer~~ **Already reserved: IDs 220-229**
   - ✅ Reserved on LibGroupBroadcast wiki
   - Available for future custom protocols if needed
   
2. **Integrate LibGroupCombatStats**:
   - Install library (if not already present)
   - Subscribe to ultimate data broadcasts (IDs 20, 21, 22, 23)
   - Store received data in group data structure
   - Map data to Beltalowda's internal format
   
3. **Integrate LibSetDetection**:
   - Install library (if not already present)
   - Subscribe to equipment broadcasts (ID 40)
   - Store received equipment data
   - Map to Beltalowda's internal format
   
4. Create group data structure:
   - Store data per unitTag
   - Update on message receipt from libraries
   - Provide access functions
   - Handle player join/leave

**Deliverables**:
- ✅ LibGroupCombatStats integrated
- ✅ LibSetDetection integrated
- ✅ Group data structure in place
- ✅ Data accessible to UI modules

**Testing**:
- Form group with alt account (both with libraries)
- Verify ultimate data syncs from LibGroupCombatStats
- Verify equipment data syncs from LibSetDetection
- Test with 2+ players

---

### Week 6: Custom Protocol Infrastructure (Optional/Future)

**Tasks**:
1. ~~Implement state broadcasting (ID 226)~~ **DEFERRED**:
   - Reserved for future use if needed
   - Current focus: integrate existing libraries
   
2. Create debug/monitoring tools:
   - Debug command: `/btlwdata group` - Show all group data
   - Monitor data from LibGroupCombatStats
   - Monitor data from LibSetDetection
   
3. Performance testing:
   - Monitor subscription overhead
   - Check data update frequency
   - Verify no conflicts with other addons
   
4. Error handling:
   - Handle missing libraries gracefully
   - Provide fallback behavior
   - Clear error messages for users

**Deliverables**:
- ✅ Debug commands working
- ✅ Performance acceptable
- ✅ Error handling robust
- ✅ Infrastructure ready for custom protocols if needed later

**Testing**:
- Form 4+ player group
- Verify all data syncs across players
- Monitor performance (FPS, memory)
- Test error scenarios (missing libraries)

**Checkpoint**: End of Phase 2
- LibGroupCombatStats integrated for ultimate data
- LibSetDetection integrated for equipment data
- Group data accessible to UI modules
- Ready for enhanced feature development (Phase 3+)
- Tested with multiple players
- Ready to enhance existing features

---

## Phase 3: Enhanced Ultimate Tracking (Weeks 7-8)

**Goal**: Improve existing ultimate tracking with new data

### Week 7: Ultimate Ability Detection

**Tasks**:
1. Detect slotted ultimate:
   - Use AbilityCollector for slot 8
   - Identify ultimate ability ID
   - Match to ultimate database
   
2. Broadcast ultimate details (ID 221):
   - Ultimate ability ID
   - Ultimate cost
   - Ready status (100%)
   
3. Update ResourceOverview to use new data:
   - Show specific ultimate for each player
   - Update Group Ultimates with type-specific counts
   - Keep existing UI structure
   
4. Add debug command:
   - `/btlwult` - Show group ultimate details

**Deliverables**:
- ✅ Ultimate ability ID detection
- ✅ Ultimate details broadcasting
- ✅ ResourceOverview updated
- ✅ Type-specific counts working

**Testing**:
- Verify ultimate type shows correctly
- Change slotted ultimate, verify update
- Form group, verify all ultimates display
- Test with various ultimate types

---

### Week 8: Dynamic Ultimates & Priority

**Tasks**:
1. Implement Volendrung detection:
   - Detect weapon pickup
   - Add Ruinous Cyclone to tracker
   - Remove when dropped
   - Test in Cyrodiil
   
2. Implement priority system:
   - Configurable cast order per ultimate type
   - Visual indicators (numbers, colors)
   - Settings menu integration
   
3. Add intensity reminder:
   - Visual effect when holding 100% ult
   - Configurable enable/disable
   - Pulse or glow effect
   
4. Settings menu updates:
   - Priority system toggle
   - Intensity reminder toggle
   - Dynamic abilities toggle

**Deliverables**:
- ✅ Volendrung detection (if testable)
- ✅ Priority system working
- ✅ Intensity reminder implemented
- ✅ Settings menu updated

**Testing**:
- Test priority system with 3+ players with same ult
- Test intensity reminder at 100%
- Test Volendrung if available
- Test all settings toggles

**Checkpoint**: End of Phase 3
- Ultimate tracking significantly enhanced
- Type-specific counts working
- Dynamic ultimates (Volendrung) supported
- Priority system functional
- Ready for equipment tracking

---

## Phase 4: Equipment Tracking (Weeks 9-10)

**Goal**: Track equipped gear and sets using LibSets

### Week 9: Equipment Broadcasting

**Tasks**:
1. Equipment broadcasting (IDs 224-225):
   - Split into two messages (14 slots)
   - Send on equipment change
   - Throttle to 2 seconds
   - Receive and store
   
2. Group equipment view:
   - Debug command: `/btlwdata groupequip`
   - Show sets for each group member
   - Show piece counts
   
3. Equipment UI concept:
   - Design equipment summary window
   - Show group member sets
   - Implement basic version

**Deliverables**:
- ✅ Equipment broadcasting working
- ✅ Group equipment tracking
- ✅ Basic equipment UI
- ✅ Debug commands updated

**Testing**:
- Form group
- Change equipment
- Verify sync across players
- Test with various set combinations

---

### Week 10: Monster Sets & Role Refinement

**Tasks**:
1. Monster set cooldown tracking:
   - Identify monster set IDs
   - Track proc effects
   - Calculate cooldown remaining
   - Display in UI
   
2. Enhanced role detection:
   - Tank set list
   - Healer set list
   - DPS set list (common ones)
   - Automatic role assignment
   
3. Settings integration:
   - Equipment tracking toggle
   - Role detection toggle
   - Monster set tracking toggle

**Deliverables**:
- ✅ Monster set cooldown tracking
- ✅ Enhanced role detection
- ✅ Role broadcasting
- ✅ Settings menu integration

**Testing**:
- Equip monster sets, verify cooldown tracking
- Test role detection with tank/healer/DPS gear
- Verify role broadcasts to group
- Test role override in settings

**Checkpoint**: End of Phase 4
- Equipment fully tracked and broadcast
- Monster set cooldowns working
- Role detection functional
- Ready for position tracking

---

## Phase 5: Position Tracking (Weeks 11-12)

**Goal**: Share player positions for coordination

### Week 11: Position Broadcasting

**Tasks**:
1. Implement `PositionCollector.lua`:
   - Use LibGPS for coordinates
   - Get global X, Y
   - Get zone ID
   - Update at 100ms
   
2. Position broadcasting (ID 222):
   - Encode position with precision
   - Send every 100ms
   - Receive and store
   
3. Distance calculations:
   - Calculate distance from crown
   - Calculate distance between players
   - Helper functions for range checks

**Deliverables**:
- ✅ Position collection working
- ✅ Position broadcasting functional
- ✅ Distance calculations accurate
- ✅ Group positions tracked

**Testing**:
- Form group
- Move around, verify position updates
- Test distance calculations
- Verify zone transitions

---

### Week 12: Follow Crown Enhancement

**Tasks**:
1. Enhance Follow the Crown features:
   - Add distance indicators
   - Show "out of range" warnings
   - Enhanced visual feedback
   
2. Range indicators on Ultimate Display:
   - Show if player is in range
   - Different colors for in/out of range
   - Configurable range threshold
   
3. Settings menu:
   - Position broadcast toggle
   - Update frequency setting
   - Range threshold setting

**Deliverables**:
- ✅ Enhanced Follow the Crown
- ✅ Range indicators in UI
- ✅ Settings menu updated
- ✅ Position features integrated

**Testing**:
- Test with crown, verify follow indicators
- Test range indicators at various distances
- Verify performance with 12-player group
- Test in Cyrodiil (large zone)

**Checkpoint**: End of Phase 5
- Position sharing working
- Distance calculations accurate
- Follow the Crown enhanced
- Ready for ability tracking

---

## Phase 6: Ability & Effect Tracking (Weeks 13-14)

**Goal**: Track full skill bars and active effects

### Week 13: Full Ability Bar Tracking

**Tasks**:
1. Complete AbilityCollector:
   - Track all 10 abilities (5 per bar)
   - Detect bar swaps
   - Store ability metadata
   
2. Ability bar broadcasting (ID 223):
   - Send 10 ability IDs
   - Send on bar change
   - Receive and store
   
3. Group ability view:
   - Debug command: `/btlwdata groupabilities`
   - Show skill bars for group members
   - Useful for coordination

**Deliverables**:
- ✅ Full ability bar tracking
- ✅ Ability bar broadcasting
- ✅ Group ability view
- ✅ Bar swap detection

**Testing**:
- Swap bars, verify detection
- Change abilities, verify update
- Form group, verify bars sync
- Test with various builds

---

### Week 14: Active Effect Tracking

**Tasks**:
1. Active effect tracking:
   - Track buffs/debuffs
   - Filter relevant effects
   - Store duration, stack count
   
2. Effect broadcasting (ID 227):
   - Send important effects
   - Configurable filter
   - Send on effect change
   
3. Effect filtering system:
   - Define important effects
   - Major/Minor buffs
   - Food/potion buffs
   - Combat-relevant debuffs
   
4. Settings menu:
   - Effect tracking toggle
   - Filter configuration

**Deliverables**:
- ✅ Active effect tracking
- ✅ Effect broadcasting
- ✅ Effect filtering system
- ✅ Settings integration

**Testing**:
- Apply buffs, verify tracking
- Test filter (should not send all effects)
- Verify important effects broadcast
- Test with group

**Checkpoint**: End of Phase 6
- Full ability bars tracked
- Active effects tracked and filtered
- All core data collection complete
- Ready for feature modules

---

## Phase 7: Synergy Tracking (Weeks 15-16)

**Goal**: Implement enhanced synergy tracking

### Week 15: Synergy Module

**Tasks**:
1. Create `Base/Features/SynergyTracking/`:
   - `SynergyTracker.lua`
   - `SynergyUI.lua`
   - `SynergyCooldowns.lua`
   
2. Implement synergy detection:
   - Track synergy activation
   - 20-second cooldown timer
   - Store per-synergy cooldowns
   
3. Synergy broadcasting:
   - Use existing ID 110
   - Share synergy usage
   - Update group cooldowns
   
4. Basic UI:
   - Window showing synergy cooldowns
   - Progress bars for each

**Deliverables**:
- ✅ Synergy tracker module
- ✅ Synergy detection working
- ✅ Broadcasting functional
- ✅ Basic UI implemented

**Testing**:
- Activate synergies, verify detection
- Verify 20s cooldown
- Test with group, verify sync
- Test UI display

---

### Week 16: Synergy UI Polish

**Tasks**:
1. Enhanced synergy UI:
   - Configurable tracked synergies
   - Color-coded availability
   - Sound alerts (optional)
   
2. Settings menu:
   - Synergy tracking toggle
   - Tracked synergies configuration
   - UI position/visibility
   
3. Integration with existing features:
   - Coordinate with ultimate tracking
   - Share UI positioning system

**Deliverables**:
- ✅ Enhanced synergy UI
- ✅ Settings menu complete
- ✅ Integration working
- ✅ Polish and refinement

**Testing**:
- Test with various synergies
- Test configuration options
- Test with full group
- Verify performance

**Checkpoint**: End of Phase 7
- Synergy tracking complete
- UI functional and configurable
- Ready for attack coordination

---

## Phase 8: Attack Coordination (Weeks 17-18)

**Goal**: Implement bomb/shalk/synergy attack timers

### Week 17: Ability Timers

**Tasks**:
1. Create `Base/Features/AttackCoordination/`:
   - `BombTimer.lua` (proximity detonation)
   - `ShalkTimer.lua` (subterranean assault)
   - `SynergyTimer.lua` (inner rage, etc.)
   - `AttackUI.lua`
   
2. Implement bomb timer:
   - Detect proximity detonation cast
   - 8-second fuse timer
   - Visual countdown
   
3. Implement shalk timer:
   - Detect subterranean assault cast
   - 3-second delay timer
   - Visual countdown
   
4. Basic unified UI:
   - Show all timers
   - Highlight "bomb window"

**Deliverables**:
- ✅ Attack coordination modules
- ✅ Bomb timer working
- ✅ Shalk timer working
- ✅ Basic UI functional

**Testing**:
- Cast proxy det, verify timer
- Cast subterranean assault, verify timer
- Test with multiple casters
- Verify timing accuracy

---

### Week 18: Attack UI & Polish

**Tasks**:
1. Enhanced attack UI:
   - Timeline view
   - Per-player ability icons
   - Highlight coordinated windows
   - Sound alerts
   
2. Synergy timer integration:
   - Inner rage (12s debuff)
   - Runebreak synergy
   - Lightning flood synergy
   
3. Settings menu:
   - Attack coordination toggle
   - Individual timer toggles
   - Sound alert configuration
   
4. Integration:
   - Enhance existing DetonationTracker
   - Merge with new implementation

**Deliverables**:
- ✅ Enhanced attack UI
- ✅ Synergy timers integrated
- ✅ Settings menu complete
- ✅ DetonationTracker enhanced

**Testing**:
- Test full attack coordination
- Test with coordinated group
- Verify timing accuracy
- Test sound alerts

**Checkpoint**: End of Phase 8
- Attack coordination complete
- All timers functional
- UI polished
- Ready for UI refinement

---

## Phase 9: UI Polish & Settings (Weeks 19-20)

**Goal**: Refine UI and settings menu organization

### Week 19: Settings Menu Reorganization

**Tasks**:
1. Reorganize settings menu:
   - Create "Core Features" section
   - Create "Group Positioning" section
   - Create "PvP Quality of Life" section
   - Move existing features appropriately
   
2. Add comprehensive tooltips:
   - Explain each setting
   - Provide examples
   - Link to documentation
   
3. Create UI presets:
   - Damage preset (DPS-focused)
   - Support preset (Healer/support-focused)
   - Lead preset (Crown/leader-focused)
   - Quick-apply button

**Deliverables**:
- ✅ Settings menu reorganized
- ✅ Tooltips added
- ✅ UI presets implemented
- ✅ Improved usability

**Testing**:
- Review all settings
- Test all tooltips
- Test presets
- Get user feedback

---

### Week 20: UI Polish

**Tasks**:
1. Visual consistency:
   - Unified color scheme
   - Consistent fonts
   - Matching window styles
   
2. Animation polish:
   - Smooth transitions
   - Intensity effects
   - Progress bar animations
   
3. Customization options:
   - Colors
   - Sizes
   - Fonts
   - Opacity
   
4. Accessibility:
   - High contrast mode
   - Larger text options
   - Simplified layouts

**Deliverables**:
- ✅ Visual consistency achieved
- ✅ Animations polished
- ✅ Customization options added
- ✅ Accessibility features

**Testing**:
- Visual review
- Test all customizations
- Test accessibility features
- Get user feedback

**Checkpoint**: End of Phase 9
- UI polished and consistent
- Settings menu organized
- Customization options available
- Ready for QoL refinement

---

## Phase 10: PvP QoL Refinement (Weeks 21-22)

**Goal**: Improve existing quality of life features

### Week 21: QoL Feature Enhancement

**Tasks**:
1. Restock improvements:
   - Multi-loadout support
   - Gold warning threshold
   - Better UI for configuration
   
2. Queue Helper improvements:
   - Configurable delay
   - Campaign priority list
   - Queue position tracking
   
3. Log Helper improvements:
   - Auto-toggle on long combat
   - Size warning
   - Auto-archive old logs

**Deliverables**:
- ✅ Restock enhanced
- ✅ Queue Helper enhanced
- ✅ Log Helper enhanced
- ✅ Better user experience

**Testing**:
- Test restock at siege merchant
- Test queue auto-accept
- Test log helper in long combat
- Verify all enhancements work

---

### Week 22: QoL Menu & Integration

**Tasks**:
1. Create unified QoL submenu:
   - Restock
   - Queue Helper
   - Log Helper
   - Invite Assistant
   
2. Invite Assistant enhancements:
   - Multi-string support
   - Guild-specific triggers
   - Whisper auto-response
   
3. Settings integration:
   - Organize all QoL settings
   - Clear descriptions
   - Easy enable/disable

**Deliverables**:
- ✅ QoL submenu created
- ✅ Invite Assistant enhanced
- ✅ Settings integrated
- ✅ Documentation updated

**Testing**:
- Test all QoL features
- Review settings menu
- Test in PvP environment
- Get user feedback

**Checkpoint**: End of Phase 10
- All QoL features enhanced
- Unified settings menu
- Ready for optimization

---

## Phase 11: Performance & Optimization (Weeks 23-24)

**Goal**: Optimize for large groups and combat

### Week 23: Performance Profiling

**Tasks**:
1. Profile update frequencies:
   - Measure CPU usage
   - Identify hotspots
   - Optimize frequent operations
   
2. Data caching:
   - Cache set names
   - Cache ability info
   - Cache calculations
   
3. LibGroupBroadcast optimization:
   - Batch messages
   - Reduce redundant sends
   - Optimize encoding

**Deliverables**:
- ✅ Performance profile complete
- ✅ Caching implemented
- ✅ Broadcasting optimized
- ✅ Hotspots addressed

**Testing**:
- Test with 12-player group
- Monitor FPS impact
- Monitor memory usage
- Test in heavy combat

---

### Week 24: Memory & UI Optimization

**Tasks**:
1. Memory optimization:
   - Reduce allocations
   - Cleanup old data
   - Optimize data structures
   
2. UI update optimization:
   - Throttle UI updates
   - Only update visible elements
   - Batch UI changes
   
3. Event handler optimization:
   - Unregister when disabled
   - Efficient event filtering
   - Minimize event handlers

**Deliverables**:
- ✅ Memory optimized
- ✅ UI updates optimized
- ✅ Event handlers optimized
- ✅ Performance targets met

**Testing**:
- 12-player stress test
- Extended combat test
- Memory leak check
- FPS impact measurement

**Checkpoint**: End of Phase 11
- Performance optimized
- Memory usage acceptable
- FPS impact minimal
- Ready for final testing

---

## Phase 12: Testing & Documentation (Weeks 25-26)

**Goal**: Comprehensive testing and documentation

### Week 25: Integration Testing

**Tasks**:
1. Full feature test:
   - Test every feature
   - Test all combinations
   - Test edge cases
   
2. Cyrodiil stress test:
   - 12-player group
   - Heavy combat
   - Extended session
   
3. Bug fixes:
   - Address any issues found
   - Regression testing
   - Final polish

**Deliverables**:
- ✅ All features tested
- ✅ Stress test complete
- ✅ Bugs fixed
- ✅ Quality assured

**Testing**:
- Comprehensive test plan
- Multiple testers
- Various scenarios
- Document all issues

---

### Week 26: Documentation & Release Prep

**Tasks**:
1. User documentation:
   - Feature guide
   - Settings guide
   - Troubleshooting guide
   - FAQ
   
2. Video demonstrations:
   - Feature showcase
   - Setup tutorial
   - Advanced tips
   
3. Release preparation:
   - ESOUI page update
   - Changelog finalization
   - Version number finalization
   - **Update LibGroupBroadcast IDs wiki** with final protocol details
   
4. Post-release support:
   - Forum monitoring
   - Bug reporting process
   - Update plan

**Deliverables**:
- ✅ User documentation complete
- ✅ Videos recorded
- ✅ Release prepared
- ✅ Support plan in place

**Release**:
- Upload to ESOUI
- Post announcements
- Monitor feedback
- Plan updates

**Checkpoint**: End of Phase 12
- All testing complete
- Documentation published
- Ready for release
- Support system ready

---

## Success Metrics

### Functional Requirements Met
- [ ] All data collectors functional
- [ ] LibGroupBroadcast fully integrated
- [ ] LibSets equipment tracking working
- [ ] Enhanced ultimate tracking complete
- [ ] Synergy tracking implemented
- [ ] Attack coordination functional
- [ ] QoL features enhanced
- [ ] All settings configurable

### Performance Requirements Met
- [ ] FPS impact < 5% in 12-player combat
- [ ] Memory usage < 50MB
- [ ] Data updates < 200ms latency
- [ ] No UI stuttering or lag

### Usability Requirements Met
- [ ] Settings menu organized
- [ ] All windows movable/lockable
- [ ] Visual feedback for all events
- [ ] No console errors
- [ ] Compatible with other addons

### Documentation Requirements Met
- [ ] User guide complete
- [ ] API documentation complete
- [ ] Troubleshooting guide complete
- [ ] Video tutorials available

---

## Post-Release Roadmap

### Version 1.1 (Month 7)
- User feedback integration
- Bug fixes
- Minor feature additions
- Performance tuning

### Version 1.2 (Month 8)
- New ultimate tracking options
- Enhanced attack coordination
- Additional QoL features

### Version 2.0 (Month 12)
- Major feature expansion
- UI overhaul
- New data tracking options
- Community requested features

---

## Risk Management

### High Risk Items
1. **LibGroupBroadcast ID allocation**: Mitigate with temporary IDs
2. **Performance with 12 players**: Mitigate with aggressive optimization
3. **Breaking existing features**: Mitigate with careful testing
4. **ESO API changes**: Mitigate with monitoring and quick response

### Medium Risk Items
1. **LibSets compatibility**: Mitigate with version checking
2. **Testing difficulty**: Mitigate with recruit testers early
3. **Scope creep**: Mitigate with strict phase adherence

### Low Risk Items
1. **Documentation**: Low risk, just time-consuming
2. **UI polish**: Low risk, can be iterative
3. **Settings menu**: Low risk, follows existing patterns

---

## Conclusion

This 26-week roadmap provides a structured, incremental approach to enhancing Beltalowda. Each phase builds on the previous, with regular testing checkpoints to ensure quality and stability.

**Key Principles**:
1. Don't break existing features
2. Test frequently
3. Optimize early and often
4. Document as you go
5. Listen to user feedback

**Next Step**: Begin Phase 0, Week 1 - Library Integration

**End Goal**: A comprehensive, performant, user-friendly group PvP addon that sets the standard for ESO group coordination tools.
