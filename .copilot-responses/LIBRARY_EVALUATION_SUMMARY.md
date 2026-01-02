# Library Evaluation Summary: LibGroupCombatStats vs LibCombat

## Executive Summary

**Question**: Can we replace LibGroupCombatStats with LibCombat?

**Answer**: **No** - LibCombat alone cannot provide group ultimate tracking. LibGroupCombatStats is the correct choice and should remain.

---

## Quick Answer

**LibCombat**:
- ❌ Only tracks YOUR OWN combat events
- ❌ Cannot see other group members' data
- ❌ No network broadcasting capabilities
- ✅ Good for personal combat logs (future feature)

**LibGroupCombatStats**:
- ✅ Tracks all group member ultimates
- ✅ Network broadcasting built-in
- ✅ Event callbacks for real-time updates
- ✅ Exactly what Beltalowda needs
- ✅ Battle-tested (used by HodorReflexes)

---

## The Core Issue

**Beltalowda needs to see OTHER players' ultimates**, not just our own.

- LibCombat: "Here's YOUR combat data"
- LibGroupCombatStats: "Here's EVERYONE's combat data (synchronized across the group)"

This is like asking if a thermometer can replace a weather station network. LibCombat is the thermometer (measures your local data), LibGroupCombatStats is the network (shares everyone's data).

---

## Technical Deep Dive

### What LibCombat Provides
```lua
-- LibCombat can tell you:
- YOUR damage dealt
- YOUR healing done  
- YOUR abilities used
- YOUR ultimate percentage

-- LibCombat CANNOT tell you:
✗ Other players' ultimate percentages
✗ Other players' ultimate abilities
✗ Group-wide statistics
✗ Network-synchronized data
```

### What LibGroupCombatStats Provides
```lua
-- LibGroupCombatStats provides:
✓ All group members' ultimate data
✓ Network synchronization (everyone shares)
✓ Event callbacks when data changes
✓ Built on top of LibCombat + LibGroupBroadcast

-- Current Beltalowda integration:
lgcsInstance = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})
lgcsInstance:RegisterForEvent(EVENT_GROUP_ULT_UPDATE, callback)
-- Receives ultimate data from all 12 group members automatically
```

---

## Why the Confusion?

The confusion likely came from:

1. **LibCombat is listed as optional** in our manifest
   - It IS optional for Beltalowda directly
   - But it's required BY LibGroupCombatStats
   - Users get it automatically when they install LibGroupCombatStats

2. **Recent debugging issues** with LibGroupCombatStats
   - These were callback signature bugs (fixed in v0.2.0)
   - Not architectural problems
   - The library itself works great

3. **Similar names** suggesting they might be interchangeable
   - They're not interchangeable
   - LibGroupCombatStats actually DEPENDS ON LibCombat
   - It's a layered architecture, not an either/or choice

---

## The Layered Architecture

```
┌─────────────────────────────────────┐
│         Beltalowda                  │  ← Our addon
└──────────────┬──────────────────────┘
               │ needs group ultimate data
               ▼
┌─────────────────────────────────────┐
│    LibGroupCombatStats              │  ← Aggregates and broadcasts
│  • Collects from LibCombat          │
│  • Broadcasts via LibGroupBroadcast │
│  • Receives from other players      │
└──────┬────────────────────┬─────────┘
       │                    │
       ▼                    ▼
┌─────────────┐    ┌────────────────┐
│ LibCombat   │    │LibGroupBroadcast│  ← Foundation libraries
└─────────────┘    └────────────────┘
```

**You can't skip layers**. We need the aggregation and networking that LibGroupCombatStats provides.

---

## What If We Tried to Replace It?

If we removed LibGroupCombatStats and used only LibCombat:

### ❌ Attempt 1: Direct Usage
```lua
-- Try to get group member's ultimate
local memberUlt = LibCombat.GetUltimate("group1")
-- Result: ERROR - LibCombat has no such function
-- LibCombat only tracks YOUR combat events
```

### ❌ Attempt 2: Manual Broadcasting
```lua
-- OK, let's broadcast our own data...
local myUlt = GetUnitPower("player", POWERTYPE_ULTIMATE)
LibGroupBroadcast.Send(MESSAGE_ID_ULTIMATE, myUlt)

-- But we'd need to:
-- 1. Register custom message IDs (220-229)
-- 2. Implement encode/decode logic
-- 3. Handle all group members
-- 4. Track connection state
-- 5. Handle errors and retries
-- 6. ...we're literally rebuilding LibGroupCombatStats
```

### ✅ Current Solution (Correct)
```lua
-- Just use the library designed for this
lgcs = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})
lgcs:RegisterForEvent(EVENT_GROUP_ULT_UPDATE, OnUltimateReceived)
-- Works perfectly, battle-tested, maintained by community
```

---

## Recommendation

### Keep Current Architecture ✅

**Required Dependencies**:
- LibAsync
- LibGroupBroadcast  
- LibAddonMenu-2.0
- **LibGroupCombatStats** ← Keep this
- LibSetDetection

**Optional Dependencies**:
- **LibCombat** ← Keep as optional (for potential future features)
- LibDebugLogger

**Why**:
1. LibGroupCombatStats is **essential** for group ultimate tracking
2. Current implementation is **correct and working**
3. Recent bugs were **callback signature issues** (now fixed)
4. Battle-tested by **production addons** (HodorReflexes)
5. Zero benefit from replacing it
6. LibCombat alone is **insufficient** for group data

---

## Future Considerations

### When LibCombat Would Be Useful

LibCombat would be beneficial if we add features like:

1. **Personal Combat Analysis**:
   - Detailed DPS breakdown
   - Ability rotation analysis
   - Damage source tracking

2. **Advanced Metrics**:
   - Uptime calculations
   - Buff/debuff tracking
   - Proc rate analysis

3. **Debugging Tools**:
   - Combat event logs
   - Ability cast verification
   - Performance profiling

These would be **additions**, not replacements. We'd use **both** libraries:
- LibGroupCombatStats: Group ultimate coordination
- LibCombat: Personal combat analysis

---

## Documentation Created

New documentation files:

1. **[docs/LIBRARY_ARCHITECTURE.md](../docs/LIBRARY_ARCHITECTURE.md)**
   - Comprehensive technical analysis
   - Detailed comparison tables
   - Architecture diagrams
   - Future considerations

2. **README.md** (updated)
   - Clarified LibCombat's purpose
   - Added reference to architecture doc
   - Noted it's included with LibGroupCombatStats

---

## Next Steps

### Immediate (None Required) ✅
- Current implementation is correct
- No code changes needed
- Documentation completed

### Optional (Future)
- If personal combat metrics are desired, leverage LibCombat
- Could add commands like `/btlwdata dps` using LibCombat data
- Would complement (not replace) LibGroupCombatStats

---

## References

### Issues/PRs Reviewed
- Issue #22: Phase 2 LibGroupBroadcast Integration
- PR #43: Ultimate tracking implementation
- CHANGELOG v0.2.0: Callback signature fixes

### External Resources
- [LibGroupCombatStats on ESOUI](https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html)
- [LibCombat on ESOUI](https://www.esoui.com/downloads/info2528-LibCombat.html)
- [HodorReflexes](https://www.esoui.com/downloads/info2311-HodorReflexes-DPSUltimateShare.html) - Production addon using LibGroupCombatStats

### Web Research
- Confirmed LibCombat only tracks local player data
- Confirmed LibGroupCombatStats required for group sync
- Confirmed HodorReflexes requires LibGroupCombatStats for group features

---

## Conclusion

**LibGroupCombatStats is the correct choice** and should remain as a required dependency. 

The recent debugging issues were implementation bugs (callback signatures), not architectural problems. The library itself is solid, battle-tested, and provides exactly what Beltalowda needs.

**No changes to dependencies are recommended.**

---

*Date*: 2026-01-02  
*Evaluation*: Complete  
*Status*: Keep current architecture  
*Confidence*: Very High (based on extensive research and documentation review)
