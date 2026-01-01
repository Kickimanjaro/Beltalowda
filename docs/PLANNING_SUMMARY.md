# Beltalowda Enhancement Planning - Summary

## Overview

This document provides a high-level summary of the comprehensive planning created for enhancing Beltalowda with advanced group coordination features.

**Created**: 2026-01-01  
**For**: Issue #13 - Wishlist: See if Copilot can assist in creating a draft for starting from scratch  
**Purpose**: Provide concrete plan, answer questions, and guide AI agent development

---

## Important Notes

**Documentation Maintenance**:
- These planning documents are the **source of truth** for implementation
- Update relevant docs when plans change during development
- Reference specific sections when delegating tasks to AI agents
- Use checkpoints (IMPLEMENTATION_CHECKPOINTS.md) to verify work before proceeding
- Keep docs synced with actual implementation

**For Future Development**:
- Planning docs live in `/docs/` directory
- Update in parallel with code changes when architecture shifts
- Use git history to track evolution of planning decisions
- Document rationale for deviations from original plan

---

## Planning Documents Created

### 1. ARCHITECTURE_PLAN.md
**Purpose**: Overall system architecture and design

**Key Sections**:
- Current state analysis (what we have vs what we need)
- Proposed enhanced architecture (modular data collection)
- Core data collection layer (6 collector modules)
- Network layer (LibGroupBroadcast integration)
- Feature modules (Ultimate, Synergy, Attack, QoL)
- UI architecture and menu organization
- SavedVariables strategy
- Dependency analysis (LibGroupBroadcast, LibSets)
- Implementation phases (12 phases, 26 weeks)
- Risk mitigation
- Success criteria

**Size**: 29KB, comprehensive technical design

---

### 2. LIBGROUPBROADCAST_INTEGRATION.md
**Purpose**: Detailed guide for LibGroupBroadcast integration

**Key Sections**:
- What is LibGroupBroadcast and why use it?
- Current state in Beltalowda (already a dependency!)
- **Existing library research** (LibGroupCombatStats, LibSetDetection, LibGroupResources)
- **Hybrid integration strategy** (reuse existing + custom for gaps)
- **ZOS policy analysis** (PvP addon concerns and risk mitigation)
- Comparison: Party chat vs LibGroupBroadcast
- Updated message ID allocation (5 custom protocols instead of 8)
- Message formats for each data type
- Broadcasting strategy (frequency tiers, compression)
- Testing strategy
- Migration from party chat
- Performance considerations
- Common issues and solutions

**Size**: 25KB+, implementation guide with community best practices

**Major Update**: Recommends using LibGroupCombatStats (ultimate tracking) and LibSetDetection (equipment sharing) instead of building custom implementations. Reduces from 8 custom protocols to 5.

---

### 3. LIBSETS_INTEGRATION.md
**Purpose**: Detailed guide for LibSets integration

**Key Sections**:
- What is LibSets and its capabilities
- Dependencies (LibAsync, LibDebugLogger)
- Installation steps
- LibSets capabilities (set detection, piece counts, etc.)
- Implementation for Beltalowda (EquipmentCollector)
- Monster set cooldown tracking
- Role detection based on equipment
- Broadcasting equipment data
- UI display (equipment summary, cooldown display)
- Use cases (role assignment, set coordination, proc tracking)
- Testing and performance considerations
- Known limitations

**Size**: 20KB, integration guide

---

### 4. SAVEDVARIABLES_GUIDE.md
**Purpose**: Comprehensive guide to SavedVariables system

**Key Sections**:
- What are SavedVariables?
- Two storage scopes (per-character, account-wide)
- Current Beltalowda implementation (profile system)
- Proposed enhanced structure (with new features)
- Accessing SavedVariables (profile-based access)
- Default values and version migrations
- Best practices (defaults, validation, meaningful keys)
- Data size considerations
- Debugging SavedVariables
- Common pitfalls (forgetting defaults, version changes, etc.)

**Size**: 20KB, technical reference

---

### 5. DEVELOPMENT_ROADMAP.md
**Purpose**: Week-by-week development plan

**Key Sections**:
- Current state (what we have, what we need)
- Phase 0: Foundation (Weeks 1-2)
  - Library integration (LibSets, LibAsync)
  - Module stubs creation
- Phase 1: Data Collection (Weeks 3-4)
  - Resource, state, ability, equipment collectors
- Phase 2: LibGroupBroadcast Integration (Weeks 5-6)
  - Network foundation
  - Resource and state broadcasting
- Phase 3: Enhanced Ultimate Tracking (Weeks 7-8)
  - Ultimate ability detection
  - Dynamic ultimates, priority system
- Phase 4: Equipment Tracking (Weeks 9-10)
  - Equipment broadcasting
  - Monster sets, role detection
- Phase 5: Position Tracking (Weeks 11-12)
  - Position broadcasting
  - Follow the Crown enhancements
- Phase 6: Ability & Effect Tracking (Weeks 13-14)
  - Full ability bar tracking
  - Active effect tracking
- Phase 7: Synergy Tracking (Weeks 15-16)
  - Synergy module implementation
  - UI and polish
- Phase 8: Attack Coordination (Weeks 17-18)
  - Bomb/shalk timers
  - Attack UI and integration
- Phase 9: UI Polish & Settings (Weeks 19-20)
  - Settings menu reorganization
  - UI presets and customization
- Phase 10: PvP QoL Refinement (Weeks 21-22)
  - Enhance existing QoL features
  - Unified QoL menu
- Phase 11: Performance & Optimization (Weeks 23-24)
  - Performance profiling
  - Memory and UI optimization
- Phase 12: Testing & Documentation (Weeks 25-26)
  - Integration testing
  - Documentation and release prep
- Post-release roadmap (v1.1, v1.2, v2.0)
- Risk management
- Success metrics

**Size**: 28KB, detailed timeline

---

### 6. IMPLEMENTATION_CHECKPOINTS.md
**Purpose**: In-game testing checkpoints for each phase

**Key Sections**:
- Purpose and philosophy (test early, test often)
- 30+ detailed checkpoints across all 12 phases
- Each checkpoint includes:
  - When to test
  - How to test (exact commands and steps)
  - Expected results
  - What to do if problems occur
  - Success criteria
- Covers:
  - Phase 0: Foundation (library installation, module structure)
  - Phase 1: Data Collection (resources, state, abilities, equipment)
  - Phase 2: LibGroupBroadcast (2-player, 4-player, multi-player)
  - Phase 3: Enhanced Ultimates (detection, Volendrung, priority, intensity)
  - Phase 4: Equipment (broadcasting, monster sets, role detection)
  - Phase 5: Position (broadcasting, Follow the Crown)
  - Phase 6: Abilities & Effects (full bar, effect filtering)
  - Phase 7: Synergy (detection, UI)
  - Phase 8: Attack Coordination (bomb timer, shalk timer, unified UI)
  - Phase 9: UI & Settings (menu review, presets)
  - Phase 10: QoL (restock, queue helper, log helper)
  - Phase 11: Performance (baseline, post-optimization)
  - Phase 12: Testing (full feature test, stress test, docs review)
- Final release readiness checkpoint

**Size**: 37KB, testing guide

---

## Questions Answered

### Q: Understanding LibGroupBroadcast
**Answer**: See LIBGROUPBROADCAST_INTEGRATION.md

**Summary**:
- LibGroupBroadcast is already a dependency in Beltalowda
- Far superior to party chat for data sharing
- Larger payloads (512 bytes vs ~100 chars)
- Reliable delivery with acknowledgment
- Designed for addon data (binary protocol)
- Need to request message ID block (220-229)
- Already using some IDs (50, 60, 109, 110, 167-170, 188-190)
- No additional dependencies (standalone library)

### Q: Understanding LibSets
**Answer**: See LIBSETS_INTEGRATION.md

**Summary**:
- LibSets provides comprehensive item set data
- Requires LibAsync (download from ESOUI) and LibDebugLogger (already have)
- Enables:
  - Set identification from equipped items
  - Role detection (tank/healer/DPS by gear)
  - Monster set cooldown tracking
  - Set coordination across group
- Integration involves adding to Lib/ folder and updating manifest
- EquipmentCollector module will handle data collection

### Q: Dependent Libraries
**Answer**: See ARCHITECTURE_PLAN.md, Dependency Analysis section + LIBGROUPBROADCAST_INTEGRATION.md

**Complete Dependency Tree**:
```
Already Have:
- LibAddonMenu-2.0 (settings)
- LibMapPins, LibMapPing, LibGPS (positioning)
- Lib3D (3D rendering) - **DEPRECATED, remove**
- LibFoodDrinkBuff (tracking) - May remove
- LibPotionBuff (tracking) - **DEPRECATED/BROKEN, remove**
- LibCustomMenu (menus)
- LibGroupBroadcast (data sharing)
- LibDebugLogger (debugging)

Need to Add:
- **LibGroupCombatStats** (ultimate tracking - from Hodor Reflexes)
- **LibSetDetection** (equipment set sharing - replaces our custom implementation)
- LibSets (local set detection)
- LibAsync (dependency of LibSets)

Community Best Practice:
- Reuse existing LibGroupBroadcast libraries instead of reinventing
- Reduces redundant network traffic
- Proven in production (Hodor Reflexes uses LibGroupCombatStats)
```

**Major Architecture Change**: Instead of building custom protocols for ultimates and equipment, we'll use existing libraries (LibGroupCombatStats and LibSetDetection). This reduces development scope and follows community best practices.

### Q: SavedVariables Usage
**Answer**: See SAVEDVARIABLES_GUIDE.md

**Summary**:
- Two scopes: account-wide and per-character
- Beltalowda uses profile system (account-wide profiles, per-char selection)
- Account-wide: UI positions, tracked ultimates, shared settings
- Per-character: selected ultimate, role, last position
- Enhanced structure adds: data collection settings, ultimate tracking enhancements, synergy tracking, attack coordination, QoL features, broadcasting preferences
- Migrations handle version upgrades
- Always provide defaults to avoid nil errors

### Q: File Structure
**Answer**: See ARCHITECTURE_PLAN.md, Core Data Collection Layer section

**Proposed Clean Structure**:
```
Base/Data/              # New: Data collection modules
├── DataCollector.lua
├── ResourceCollector.lua
├── PositionCollector.lua
├── AbilityCollector.lua
├── EquipmentCollector.lua
├── StateCollector.lua
└── PreferencesCollector.lua

Base/Network/           # New: Network layer
└── GroupBroadcast.lua

Base/Features/          # New: Feature modules
├── UltimateTracking/
│   ├── UltimateTracker.lua
│   ├── UltimateUI.lua
│   └── UltimateCoordination.lua
├── SynergyTracking/
│   ├── SynergyTracker.lua
│   ├── SynergyUI.lua
│   └── SynergyCooldowns.lua
├── AttackCoordination/
│   ├── BombTimer.lua
│   ├── ShalkTimer.lua
│   ├── SynergyTimer.lua
│   └── AttackUI.lua
└── QualityOfLife/
    ├── Restock.lua
    ├── QueueHelper.lua
    ├── LogHelper.lua
    └── InviteAssistant.lua

Base/Group/            # Existing: Keep and enhance
Base/Toolbox/          # Existing: Some moved to QoL
Base/Compass/          # Existing: Keep
Base/Util/             # Existing: Keep and enhance
```

### Q: Implementation Order / What to Build First
**Answer**: See DEVELOPMENT_ROADMAP.md

**Order Rationale**:
1. **Phase 0: Foundation** - Don't break anything, set up infrastructure, **research existing libraries (Week 2)**
2. **Phase 1: Data Collection** - Collect data locally first (no networking complexity)
3. **Phase 2: LibGroupBroadcast** - Share basic data once collection works, **use hybrid approach (existing libs + custom)**
4. **Phases 3-8: Features** - Build features incrementally on data foundation
5. **Phases 9-10: Polish** - Refine once features work
6. **Phase 11: Optimize** - Performance tuning near end
7. **Phase 12: Test & Document** - Final validation

**Why This Order**:
- Week 2 research prevents reinventing the wheel
- Data collection first avoids dependency on networking
- Can test locally with debug commands
- Hybrid approach reduces development scope (use LibGroupCombatStats & LibSetDetection)
- Each phase builds on previous
- Regular checkpoints prevent getting "too far ahead"
- Features depend on data layer, so data layer first
- Optimization near end when you know what needs optimizing

### Q: Regular In-Game Checkpoints
**Answer**: See IMPLEMENTATION_CHECKPOINTS.md

**Summary**:
- 30+ detailed checkpoints across all phases
- Each checkpoint is in-game testable with specific commands
- Example checkpoints:
  - Phase 0.1: Verify libraries loaded (`/script d(LibSets ~= nil)`)
  - Phase 1.1: Test resource tracking (`/btlwdata resources`)
  - Phase 2.2: Test 2-player sync (`/btlwdata group`)
  - Phase 8.1: Test bomb timer accuracy (cast proxy det, verify 8s)
- Every checkpoint has:
  - Exact test steps
  - Expected results
  - Troubleshooting if fails
  - Success criteria before proceeding
- Prevents building on broken foundation

### Q: ZOS Policy on PvP Addons
**Answer**: See LIBGROUPBROADCAST_INTEGRATION.md, "ZOS Policy Concerns" section

**Summary**:
- **Concern**: ZOS staff warned against "real-time aid to help min/max battle" in PvP
- **Community Fear**: Losing LibGroupBroadcast if PvP addons cross policy lines
- **Our Assessment**: Beltalowda is a **coordination tool**, not automation
- **Key Distinction**:
  - ❌ Prohibited: Automated combat decisions, invisible attack warnings, instant reactions
  - ✅ Permitted: Information display, group coordination, player awareness
- **Comparison**: 
  - Hodor Reflexes (PvE): Ultimate coordination, DPS/HPS stats - **Accepted by ZOS**
  - Bomb Timers (PvP): Coordinated damage timing - **Multiple addons exist**
  - Beltalowda (PvP): Same coordination level as Hodor Reflexes - **Defensible**
- **Risk Mitigation**:
  - Focus on information display, not automation
  - Avoid instant reaction triggers
  - Model after accepted PvE addons
  - Be transparent about functionality
- **Verdict**: Proceed with caution. Features planned are coordination tools comparable to existing accepted addons. Goal is to make group coordination accessible to all players, not create unfair automation advantage.

---

## Next Steps for AI Agent Development

### Immediate Actions (Human)
1. Review all planning documents
2. Decide on starting phase (recommend Phase 0)
3. Approve overall approach
4. Request LibGroupBroadcast message IDs if approved

### Phase 0: Foundation (First AI Agent Task)
**Goal**: Set up infrastructure without breaking existing features

**Instructions for AI Agent**:
```
Task: Complete Phase 0 of Beltalowda enhancement

Context:
- Review ARCHITECTURE_PLAN.md sections: "Proposed Enhanced Architecture" and "Phase 0"
- Review LIBSETS_INTEGRATION.md section: "Installation Steps"
- Review DEVELOPMENT_ROADMAP.md section: "Phase 0"
- Review IMPLEMENTATION_CHECKPOINTS.md sections: "Checkpoint 0.1" and "Checkpoint 0.2"

Deliverables:
1. Download LibSets and LibAsync, place in Lib/ folder
2. Update Beltalowda.txt manifest with new dependencies
3. Update Beltalowda.lua library check function
4. **RESEARCH**: Test LibGroupCombatStats, LibSetDetection, LibGroupResources
   - Document capabilities and gaps
   - Decide which to integrate vs build custom
   - Update LIBGROUPBROADCAST_INTEGRATION.md with findings
5. Create Base/Data/ directory with stub collector modules
6. Create Base/Network/ directory with stub GroupBroadcast.lua
7. All modules initialized with proper namespaces (using 'or {}' pattern)
8. Update Beltalowda.txt to load new files (including researched libraries if beneficial)
9. Test using Checkpoint 0.1, 0.1b, and 0.2 procedures

Success Criteria:
- All checkpoints pass
- No existing features broken
- No errors when loading addon

Constraints:
- Follow ESO_ADDON_BEST_PRACTICES.md patterns
- Use namespace 'or {}' pattern everywhere
- Don't implement functionality yet, just structure
- Test after each change
```

### Subsequent Phases
Each phase follows same pattern:
1. Review relevant sections in planning docs
2. Implement according to DEVELOPMENT_ROADMAP.md
3. Test using IMPLEMENTATION_CHECKPOINTS.md
4. Only proceed if checkpoints pass

---

## Key Takeaways

### What Makes This Plan Good

**1. Builds on Existing Foundation**
- Doesn't throw away working RdK code
- Enhances, doesn't replace
- Maintains compatibility

**2. Modular Design**
- Clean separation of concerns
- Data collection separate from features
- Features independent of each other
- Easy to enable/disable features

**3. Incremental Development**
- 26 weeks broken into 12 phases
- Each phase builds on previous
- Regular testing checkpoints
- Can stop/resume at any phase

**4. Comprehensive Planning**
- Architecture documented
- Integration guides for libraries
- SavedVariables structure defined
- Testing procedures detailed
- Risk mitigation planned

**5. User-Focused**
- Settings menu reorganized for clarity
- UI presets for quick setup (Damage/Support/Lead for PvP roles)
- Quality of life features enhanced
- Documentation for end users

### Potential Concerns

**1. Scope**
- 26 weeks is ambitious
- Many features to implement
- Mitigation: Phased approach allows early release of core features

**2. Testing**
- Requires multiple players for full testing
- Mitigation: Debug commands for solo testing, recruit testers early

**3. LibGroupBroadcast IDs**
- Need official assignment
- Mitigation: Can use temporary high IDs (200+) while waiting

**4. Performance**
- 12-player groups with lots of data sharing
- Mitigation: Optimization phase (11), throttling, batching

**5. Maintenance**
- Large feature set means more maintenance
- Mitigation: Modular design, good documentation

---

## Files Included

1. `docs/ARCHITECTURE_PLAN.md` (29KB)
2. `docs/LIBGROUPBROADCAST_INTEGRATION.md` (22KB)
3. `docs/LIBSETS_INTEGRATION.md` (20KB)
4. `docs/SAVEDVARIABLES_GUIDE.md` (20KB)
5. `docs/DEVELOPMENT_ROADMAP.md` (28KB)
6. `docs/IMPLEMENTATION_CHECKPOINTS.md` (37KB)
7. `docs/PLANNING_SUMMARY.md` (this file)

**Total Documentation**: ~156KB of comprehensive planning

---

## Feedback and Next Steps

**For Kick (Repository Owner)**:
1. Review planning documents
2. Provide feedback on approach
3. Approve/modify scope
4. Decide on starting phase
5. Assign to AI agent or begin implementation

**For AI Agents**:
1. Read all planning documents before starting
2. Follow phased approach in DEVELOPMENT_ROADMAP.md
3. Test using IMPLEMENTATION_CHECKPOINTS.md after each change
4. Don't skip ahead - complete each phase before next
5. Ask questions if planning is unclear

**For Future Reference**:
- These docs are the source of truth for implementation
- Update docs if plans change
- Reference specific sections when delegating to AI agents
- Use checkpoints to verify work before proceeding

---

## Conclusion

This planning package provides everything needed to enhance Beltalowda from its current RdK-derived state to a comprehensive group coordination platform. The modular architecture, phased development, and detailed testing checkpoints ensure quality and stability throughout the 26-week journey.

**Ready to begin**: Phase 0, Week 1, Library Integration

**End goal**: The best group PvP coordination addon for ESO 🎯
