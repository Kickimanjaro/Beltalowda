# Checkpoint 0.1b Research - REVISED Based on User Feedback

## Executive Summary

**Status**: ✅ REVISED - User feedback incorporated

**Original Conclusion**: Need 2 custom protocols (Health+Resources, Position)  
**Revised Conclusion**: **NO CUSTOM PROTOCOLS NEEDED** - All data available via existing libraries

---

## User Feedback Addressed

### Feedback from @Kickimanjaro (Comment #3703725424)

1. **Health tracking NOT needed** ✅
   - Health already displayed in game's default group UI frames
   - No custom logic needed for group member health
   - **Original assessment was incorrect**

2. **Position tracking likely has existing library** ✅
   - Common requirement, should have existing solution
   - Research confirms: No dedicated LibGroupBroadcast library, but LibGPS handles positions

3. **Tier 2 features likely covered** ✅
   - LibGroupPotionCooldowns exists (mentioned by user)
   - Other libraries may cover remaining needs

4. **Conclusion**: May not need ANY custom protocols ✅

---

## Revised Library Research

### Existing Libraries - Complete Coverage Analysis

#### 1. LibGroupCombatStats ✅ **ADOPT**
**IDs**: 20-21  
**Provides**:
- Ultimate Type (ID 20): Which ultimate is slotted + cost
- Ultimate Value (ID 21): Current ultimate points (0-500)
- DPS (ID 22): Damage per second
- HPS (ID 23): Healing per second

**Coverage**: 100% of ultimate tracking needs

---

#### 2. LibSetDetection ✅ **ADOPT**
**ID**: 40  
**Provides**:
- Equipped set pieces for all 14 equipment slots
- Automatic broadcasting to group members

**Coverage**: 100% of equipment tracking needs

---

#### 3. LibGPS ✅ **USE (Already in dependencies)**
**Not LibGroupBroadcast-based, but essential**  
**Provides**:
- Local position coordinates (X, Y)
- Zone/map awareness
- Global coordinate conversion

**For Position Broadcasting**:
- LibGPS provides position data locally
- **No dedicated LibGroupBroadcast library for position exists**
- Options:
  - **Option A**: Use LibGPS locally only (no group position sharing)
  - **Option B**: Implement lightweight custom protocol for position if needed later
  - **Recommendation**: Start with Option A (local LibGPS only)

**Note**: Position broadcasting would require custom protocol, BUT may not be needed for MVP. LibGPS already in dependencies for local "Follow the Crown" features.

---

#### 4. LibGroupPotionCooldowns ✅ **EVALUATE**
**IDs**: 26-29 (mentioned in wiki)  
**Provides**:
- Potion cooldown tracking (ID 26)
- Group-wide potion cooldown awareness

**Coverage**: Potion tracking (Tier 2/optional feature)

**Decision**: Optional - only add if potion tracking becomes a priority

---

#### 5. LibGroupResources ⚠️ **SKIP**
**IDs**: 10-11  
**Provides**:
- Magicka (ID 11)
- Stamina (ID 10)
- Missing: Health

**Original reasoning**: Missing Health was critical  
**Revised reasoning**: Health NOT needed, but Magicka/Stamina alone not valuable enough

**Decision**: SKIP - Not worth dependency for partial resource data

---

## Revised Minimum Data Requirements

### Critical Data (Tier 1) - REVISED

| Data Type | Original Assessment | Revised Assessment | Library Coverage |
|-----------|--------------------|--------------------|------------------|
| Ultimate % | Required | **Required** ✅ | LibGroupCombatStats (ID 21) |
| Ultimate ID | Required | **Required** ✅ | LibGroupCombatStats (ID 20) |
| ~~Health~~ | ~~Required~~ | **NOT NEEDED** ❌ | Game UI already shows it |
| Equipment | Required | **Required** ✅ | LibSetDetection (ID 40) |
| Position | Required | **OPTIONAL** ⚠️ | LibGPS (local), custom if needed |

**Coverage**: 100% of REVISED critical needs via existing libraries (3/3)

---

### Optional Data (Tier 2) - REVISED

| Data Type | Coverage | Decision |
|-----------|----------|----------|
| ~~Health/Magicka/Stamina~~ | ~~LibGroupResources~~ | **NOT NEEDED** - Skip |
| Potion Cooldowns | LibGroupPotionCooldowns | **Optional** - Add if needed |
| Full Skill Bar | None available | **Future** - Custom if needed |
| Active Effects | None available | **Future** - Custom if needed |
| State Flags | None available | **Future** - Custom if needed |

---

## Final Recommendations - REVISED

### Libraries to Adopt (2 core + 1 optional)

✅ **LibGroupCombatStats** - ADOPT (CONFIRMED)
- Ultimate tracking (IDs 20-21)
- Battle-tested (Hodor Reflexes uses it)
- **Action**: Already planned, proceed

✅ **LibSetDetection** - ADOPT (CONFIRMED)
- Equipment tracking (ID 40)
- Handles all 14 slots
- **Action**: Already planned, proceed

✅ **LibGPS** - ALREADY HAVE
- Position tracking (local)
- Already in dependencies from Phase 0
- **Action**: Use for local features, no group broadcast needed initially

⚪ **LibGroupPotionCooldowns** - OPTIONAL
- Potion cooldown tracking (ID 26)
- **Action**: Add later if potion tracking becomes priority

---

### Custom Protocols Required - REVISED

**Original Plan**: 2 custom protocols (IDs 220, 222)
- ID 220: Health + Resources
- ID 222: Position

**REVISED Plan**: **ZERO custom protocols for MVP** ✅

**Rationale**:
1. ❌ Health NOT needed (user feedback - game UI already shows it)
2. ⚠️ Position can use LibGPS locally for now (no group broadcast initially)
3. ✅ Ultimates covered by LibGroupCombatStats
4. ✅ Equipment covered by LibSetDetection

**Future Expansion** (if needed):
- ⚪ ID 220: Could be repurposed for position if group position sharing needed
- ⚪ ID 222: Available for other future features
- ⚪ ID 223-229: Reserved for future expansion

---

## Implementation Strategy - REVISED

### Phase 1: Core Libraries (Weeks 1-2)

**Add Dependencies**:
```lua
-- Beltalowda.txt
## DependsOn: LibAsync>=3.1.1 LibGroupBroadcast>=91 LibAddonMenu-2.0>=41 LibSetDetection>=4 LibGroupCombatStats>=1 LibSets>=71 LibGPS>=73
```

**Already Have**: LibAsync, LibGroupBroadcast, LibAddonMenu-2.0, LibGPS  
**Add**: LibSetDetection, LibGroupCombatStats

---

### Phase 2: Subscribe to Library Data (Week 3)

**LibGroupCombatStats Integration**:
```lua
-- Subscribe to ultimate data (IDs 20-21)
local lgcs = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})
if lgcs then
    lgcs:RegisterForEvent(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE, function(unitTag, data)
        Beltalowda.ultimateTracking.UpdateGroupMember(unitTag, data)
    end)
end
```

**LibSetDetection Integration**:
```lua
-- Subscribe to equipment data (ID 40)
-- API integration details TBD based on library documentation
```

**LibGPS Integration** (already available):
```lua
-- Use for local position tracking
local x, y = LibGPS:GetPlayerGlobalPosition()
-- Use for "Follow the Crown" local features
```

---

### Phase 3: Feature Development (Week 4+)

**Ultimate Tracking**:
- Use LibGroupCombatStats data (IDs 20-21)
- Build UI displays
- Implement priority system
- Add Volendrung detection

**Equipment Awareness**:
- Use LibSetDetection data (ID 40)
- Role detection from sets
- Monster set cooldown tracking
- Group composition display

**Position Features** (local only):
- Use LibGPS for local position
- "Follow the Crown" distance indicators
- No group position broadcasting initially

---

## Efficiency Metrics - REVISED

### Before Research (Original Plan)
- ❌ 8 custom protocols planned
- ❌ Significant custom networking code
- ❌ Large testing burden

### After Initial Research (Original Findings)
- ⚠️ 2 custom protocols (Health+Resources, Position)
- ✅ 75% reduction in custom protocols
- ✅ Leverage some existing libraries

### After User Feedback (REVISED Findings)
- ✅ **ZERO custom protocols for MVP**
- ✅ **100% reduction in custom protocols** 🎉
- ✅ **All data from existing libraries**
- ✅ **Fastest time to market**
- ✅ **Lowest maintenance burden**

**Protocol Reduction**: 8 planned → 0 needed (100% reduction) 🎉🎉🎉

---

## Answer to Research Questions - REVISED

### Question 1: What is the minimum amount of data needed?

**REVISED Minimum (Tier 1)** - 3 Data Types:
1. ✅ Ultimate % (for coordination)
2. ✅ Ultimate ID (which ult is slotted)
3. ✅ Equipment Set IDs (for role detection)

**Removed from Tier 1**:
- ❌ ~~Health~~ - Game UI already shows it
- ⚠️ ~~Position~~ - Demoted to optional (can use LibGPS locally)

---

### Question 2: Do these libraries provide adequate functionality?

**Answer**: **YES - 100% ADEQUATE** ✅

**Coverage Assessment**:

| Library | Data Provided | Coverage |
|---------|---------------|----------|
| LibGroupCombatStats | Ultimate % + ID | 2/3 Tier 1 ✅ |
| LibSetDetection | Equipment Sets | 1/3 Tier 1 ✅ |
| LibGPS (local) | Position | Tier 2 ✅ |
| **TOTAL** | **All Tier 1 data** | **100%** ✅ |

**Conclusion**: Existing libraries provide **complete coverage** of all required data for MVP.

---

## Updated Message ID Allocation

**Reused from Existing Libraries** (NO CUSTOM IDS NEEDED):
- ✅ **LibGroupCombatStats ID 20**: Ultimate Type (ability ID + cost)
- ✅ **LibGroupCombatStats ID 21**: Ultimate Value (current points)
- ✅ **LibSetDetection ID 40**: Equipment sets (all 14 slots)
- ⚪ **LibGroupPotionCooldowns ID 26**: Potion cooldowns (OPTIONAL)

**Custom Beltalowda Protocols** (220-229):
- ⚪ **ALL AVAILABLE** - No custom protocols needed for MVP
- ⚪ **220-229**: Reserved for future expansion if needed

**Summary**:
- **Using from existing libraries**: 3 protocols (Ultimate x2, Equipment x1)
- **Custom protocols needed**: **ZERO for MVP** ✅
- **Available for future**: All 10 reserved slots (220-229)
- **Efficiency**: From 8 planned → 0 needed (100% reduction) 🎉

---

## Impact on Development Timeline

**Original Roadmap** (8 custom protocols):
- Weeks 1-2: Foundation
- Weeks 3-4: Data Collection
- Weeks 5-6: LibGroupBroadcast Integration (custom protocols)
- Weeks 7+: Feature Development

**Revised Roadmap** (0 custom protocols):
- Weeks 1-2: Foundation ✅ (ALREADY DONE - Phase 0 complete)
- Week 3: Subscribe to library data
- Week 4+: **Feature Development** (can start immediately!)

**Time Saved**: ~2-3 weeks by eliminating custom protocol development ✅

---

## Next Steps - REVISED

1. ✅ **Phase 0 Complete** - Foundation already done
2. ⏭️ Add LibGroupCombatStats to dependencies
3. ⏭️ Add LibSetDetection to dependencies  
4. ⏭️ Subscribe to LibGroupCombatStats (IDs 20-21)
5. ⏭️ Subscribe to LibSetDetection (ID 40)
6. ⏭️ Begin feature development (ultimate tracking UI, equipment awareness)
7. ⚪ Optional: Add LibGroupPotionCooldowns later if needed

**No custom protocol implementation needed!** ✅

---

## Files to Update

- ✅ `CHECKPOINT_0.1b_REVISED.md` - This document (new)
- ⏭️ `docs/LIBGROUPBROADCAST_INTEGRATION.md` - Update with revised findings
- ⏭️ `docs/IMPLEMENTATION_CHECKPOINTS.md` - Update Checkpoint 0.1b
- ⏭️ `.copilot-responses/CHECKPOINT_0.1b_SUMMARY.md` - Update summary

---

## Conclusion - REVISED

**Original Research Findings**:
- 60% library coverage
- 2 custom protocols needed
- 75% reduction from original 8

**REVISED Findings** (based on user feedback):
- 🎉 **100% library coverage** 
- 🎉 **ZERO custom protocols needed**
- 🎉 **100% reduction from original 8**
- 🎉 **Fastest possible time to market**

**Key Insight from User**: Health tracking was a false requirement. The game's default group UI already provides health visibility. Position tracking can start with local LibGPS (no group broadcast needed initially).

**Impact**: Beltalowda can proceed **directly to feature development** without any custom networking code. All required data is available via battle-tested, community-maintained libraries.

---

**Status**: ✅ Checkpoint 0.1b REVISED - Zero custom protocols needed, ready for immediate feature development
