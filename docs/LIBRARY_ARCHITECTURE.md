# Library Architecture Decision: LibGroupCombatStats vs LibCombat

## Executive Summary

**Decision**: Continue using **LibGroupCombatStats** as a required dependency. LibCombat is NOT needed and would NOT replace LibGroupCombatStats.

**Reasoning**: LibCombat alone cannot provide group ultimate tracking. LibGroupCombatStats is specifically designed for group coordination and is the correct library for Beltalowda's needs.

---

## Background

During review of [Issue #22](https://github.com/Kickimanjaro/Beltalowda/issues/22) and [PR #43](https://github.com/Kickimanjaro/Beltalowda/pull/43), questions arose about:
1. Difficulties receiving expected data from LibGroupCombatStats
2. Whether LibCombat could replace LibGroupCombatStats

The debugging issues have been resolved (callback signature fixes in v0.2.0), and this document addresses the library selection question.

---

## Library Comparison

### LibCombat (v84+)

**Purpose**: Low-level combat event data collection for individual players

**Capabilities**:
- ✅ Tracks your own character's combat events
- ✅ Provides callbacks for damage, healing, ability usage
- ✅ Detailed combat log data (granular analysis)
- ✅ Foundation library used by Combat Metrics
- ❌ **Does NOT track other group members**
- ❌ **Does NOT broadcast or receive network data**
- ❌ **Does NOT provide group ultimate tracking**

**Use Cases**:
- Combat metrics and DPS parsers
- Personal combat analysis
- Detailed fight logs
- Foundation for other libraries (like LibGroupCombatStats)

**Example Addons**: Combat Metrics

---

### LibGroupCombatStats (v6+)

**Purpose**: High-level group statistics with network synchronization

**Capabilities**:
- ✅ Tracks group member combat statistics
- ✅ Broadcasts DPS, HPS, and ULT data across the group
- ✅ Network synchronization via LibGroupBroadcast
- ✅ Event callbacks for group stat updates
- ✅ Efficient encoding for minimal network usage
- ✅ Specifically designed for group coordination
- ✅ **Provides exactly what Beltalowda needs**

**Dependencies**:
- LibCombat (for local data collection)
- LibGroupBroadcast (for network transmission)

**Use Cases**:
- Group ultimate coordination
- Raid DPS/HPS tracking
- Group performance monitoring
- PvP/PvE group tools

**Example Addons**: HodorReflexes, Beltalowda

---

## Beltalowda's Requirements

Beltalowda is a **group PvP coordination addon** with the following data needs:

| Requirement | LibCombat | LibGroupCombatStats | Verdict |
|-------------|-----------|---------------------|---------|
| Track own ultimate | ✅ Yes | ✅ Yes | Both work |
| Track group ultimates | ❌ **No** | ✅ **Yes** | **LGCS required** |
| Network broadcasting | ❌ **No** | ✅ **Yes** | **LGCS required** |
| Ultimate ability ID | ❌ No | ✅ Yes (ID 20) | **LGCS required** |
| Ultimate value (0-500) | ❌ No | ✅ Yes (ID 21) | **LGCS required** |
| Real-time group updates | ❌ **No** | ✅ **Yes** | **LGCS required** |

**Conclusion**: LibCombat alone cannot meet Beltalowda's requirements.

---

## Technical Details

### LibGroupCombatStats Architecture

```
┌─────────────────────────────────────────────────┐
│              Beltalowda Addon                   │
│  (Registers for ULT events via LGCS)           │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│         LibGroupCombatStats                     │
│  • Aggregates local combat data                │
│  • Broadcasts to group via LibGroupBroadcast   │
│  • Receives data from other group members      │
│  • Triggers callbacks on updates               │
└────────────┬──────────────────┬─────────────────┘
             │                  │
             ▼                  ▼
┌────────────────────┐  ┌──────────────────────┐
│    LibCombat       │  │ LibGroupBroadcast    │
│ (Local data)       │  │ (Network layer)      │
│ • Damage events    │  │ • Group messages     │
│ • Healing events   │  │ • Efficient encoding │
│ • Ability usage    │  │ • ZOS Broadcast API  │
└────────────────────┘  └──────────────────────┘
```

### What LibGroupCombatStats Provides

Beltalowda uses LibGroupCombatStats to receive:

1. **Ultimate Type (ID 20)**:
   - Ability ID of slotted ultimate
   - Ultimate cost
   - Updates when player changes ultimate

2. **Ultimate Value (ID 21)**:
   - Current ultimate points (0-500)
   - Maximum ultimate points
   - Real-time updates during combat

3. **DPS/HPS (IDs 22-23)** (optional):
   - Could be used for future features
   - Currently unused by Beltalowda

### Current Integration

From `Base/Network/GroupBroadcast.lua`:

```lua
-- Register addon with LibGroupCombatStats
lgcsInstance = LibGroupCombatStats.RegisterAddon("Beltalowda", {"ULT"})

-- Register for ultimate update events
lgcsInstance:RegisterForEvent(LibGroupCombatStats.EVENT_GROUP_ULT_UPDATE, 
    function(eventId, unitTag, data)
        -- data contains: id, cost, value, max
        BeltalowdaNetwork.OnUltimateDataReceived(unitTag, data)
    end)
```

This provides:
- ✅ Automatic tracking of all group members
- ✅ Network synchronization (no custom broadcast needed)
- ✅ Event callbacks when data changes
- ✅ Efficient data encoding
- ✅ Battle-tested reliability (used by HodorReflexes)

---

## Why Not Use LibCombat?

### What Would Be Required

If we removed LibGroupCombatStats and tried to use LibCombat alone:

1. **Manual Data Collection** ✗
   - Hook into combat events for ultimate changes
   - Track ability bar changes
   - Calculate ultimate percentages

2. **Custom Network Broadcasting** ✗
   - Implement custom LibGroupBroadcast protocol
   - Reserve and register message IDs (220-229)
   - Encode/decode ultimate data
   - Handle network errors and retries

3. **Group Member Tracking** ✗
   - Cannot see other players' combat events
   - Would need to broadcast our data and receive theirs
   - Essentially reimplementing LibGroupCombatStats

4. **Maintenance Burden** ✗
   - Custom code to maintain
   - Potential bugs in encoding/decoding
   - No benefit over using existing library

### The Reality

**LibCombat cannot provide group ultimate data** because:
- It only tracks YOUR character's combat events
- It has no access to other group members' data
- It has no network broadcasting capabilities
- The ESO API doesn't expose other players' combat events

LibGroupCombatStats works because:
- Each player runs LibGroupCombatStats
- Each instance uses LibCombat to track local data
- Each instance broadcasts via LibGroupBroadcast
- All instances receive and aggregate the group data

---

## Decision Matrix

| Approach | Pros | Cons | Verdict |
|----------|------|------|---------|
| **Use LibGroupCombatStats** | ✅ Works out of the box<br>✅ Battle-tested<br>✅ Zero custom code<br>✅ Group sync built-in<br>✅ Active maintenance | Requires dependency | ✅ **CORRECT CHOICE** |
| **Use LibCombat alone** | Fewer dependencies? | ❌ Cannot track group data<br>❌ No network sync<br>❌ Would need custom broadcast<br>❌ Essentially rebuilding LGCS | ❌ **IMPOSSIBLE** |
| **Build custom solution** | Full control? | ❌ Reinventing the wheel<br>❌ High maintenance<br>❌ Potential bugs<br>❌ No benefit | ❌ **NOT RECOMMENDED** |

---

## Recommendation

### ✅ KEEP: LibGroupCombatStats (Required)

**Status**: Currently required dependency (correct)

**Reason**: Provides exactly what Beltalowda needs:
- Group ultimate tracking
- Network synchronization
- Event-based updates
- Battle-tested reliability

**Action**: No change needed

---

### 📝 CLARIFY: LibCombat (Currently Optional)

**Status**: Listed as optional dependency in Beltalowda.txt

**Current State**: 
```lua
## OptionalDependsOn: LibCombat>=84 LibDebugLogger>=2.0
```

**Actual Usage**: Not directly used by Beltalowda

**Clarification Needed**:
- LibCombat is a dependency OF LibGroupCombatStats
- Users installing LibGroupCombatStats will get LibCombat automatically
- We don't need to list it as our dependency

**Recommendation**: 
- Keep it as optional for documentation purposes
- Update README to clarify it's for future raw combat data features
- Note that it's automatically included via LibGroupCombatStats

---

## Future Considerations

### Potential Use Cases for LibCombat

While not needed for current functionality, LibCombat could be useful for:

1. **Combat Analysis** (Future Phase):
   - Detailed damage breakdowns
   - Ability rotation analysis
   - Personal performance metrics

2. **Advanced Features** (Future):
   - Detecting specific ability casts
   - Timing windows for combos
   - Personal DPS tracking

3. **Debugging**:
   - Detailed combat logs
   - Ability usage verification
   - Performance diagnostics

These features would be additions to Beltalowda, not replacements for LibGroupCombatStats.

---

## References

### Documentation
- [LibGroupCombatStats on ESOUI](https://www.esoui.com/downloads/info4024-LibGroupCombatStats.html)
- [LibGroupCombatStats GitHub](https://github.com/m00nyONE/LibGroupCombatStats)
- [LibCombat on ESOUI](https://www.esoui.com/downloads/info2528-LibCombat.html)
- [LibCombat GitHub](https://github.com/Solinur/LibCombat)

### Example Addons
- **HodorReflexes**: Uses LibGroupCombatStats for raid coordination
- **Combat Metrics**: Uses LibCombat for detailed combat analysis

### Related Beltalowda Issues
- [Issue #22](https://github.com/Kickimanjaro/Beltalowda/issues/22): Phase 2 LibGroupBroadcast Integration
- [PR #43](https://github.com/Kickimanjaro/Beltalowda/pull/43): Ultimate tracking implementation
- CHANGELOG v0.2.0: Fixed LibGroupCombatStats callback signatures

---

## Conclusion

**LibGroupCombatStats is the correct and only viable choice** for Beltalowda's group ultimate tracking needs. LibCombat alone cannot provide group data and would require essentially rebuilding LibGroupCombatStats from scratch.

The current implementation is correct, and the recent debugging issues (resolved in v0.2.0) were due to callback signature errors, not architectural problems.

**No changes to library dependencies are recommended.**

---

*Last Updated*: 2026-01-02  
*Author*: GitHub Copilot (via evaluation request)  
*Status*: Final Recommendation
