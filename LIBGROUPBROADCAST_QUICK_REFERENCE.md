# LibGroupBroadcast Quick Reference for Beltalowda

> **TL;DR**: Beltalowda already uses LibGroupBroadcast successfully. This is a quick reference for developers.

## 📋 Current Status

✅ **6 Protocols Active** (IDs 102-107)  
⚠️ **Need to Register** IDs 102-120 on [LibGroupBroadcast Wiki](https://wiki.esoui.com/LibGroupBroadcast_IDs)  
🚀 **4 New Protocols Designed** for enhanced features (IDs 108-111)

## 🎯 Quick Answers

### What is LibGroupBroadcast?
The standard ESO library for sharing data between group members' addons. Think of it as a messaging system where each addon can broadcast structured data to the group.

### Do we need to request IDs?
**Yes**, but it's simple:
1. Visit https://wiki.esoui.com/LibGroupBroadcast_IDs
2. Add your addon name and ID range to the list
3. That's it - no approval process, just reserve your space

### What IDs should we reserve?
**102-120** (19 protocol IDs total)
- 102-107: Already in use
- 108-111: Designed for new features
- 112-120: Reserved for future expansion

## 🔧 Existing Protocols

| ID  | Name | What It Does | Combat? | Replaces? |
|-----|------|-------------|---------|-----------|
| 102 | Legacy | General messages | Yes | No |
| 103 | Admin | Admin commands | No | No |
| 104 | Version | Version sync | No | No |
| 105 | Heartbeat | Resources & ultimate % | Yes | Yes |
| 106 | Synergy | Synergy tracking | Yes | No |
| 107 | HpDmg | Health & damage | Yes | No |

## 🆕 Proposed New Protocols

| ID  | Name | What It Does | Why We Need It |
|-----|------|-------------|----------------|
| 108 | Position | X/Y coords + heading | "Follow the Crown" feature |
| 109 | Equipment | Equipped gear sets | Monster set cooldown tracking |
| 110 | Abilities | Slotted abilities | Smart ultimate tracking (Volendrung case) |
| 111 | Active Effects | Buffs/debuffs | Attack timers, Rapids tracking, Plaguebreak detection |

## 💡 Key Features from Issue

The issue asked for tracking these 5 things:

1. **Current Resources** (Health, Magicka, Stamina, Ultimate)
   - ✅ **Already Tracked**: Protocol 105 (Heartbeat) tracks ultimate
   - 🔨 **Enhancement Needed**: Add health, magicka, stamina fields

2. **Current Location**
   - ❌ **Not Yet Implemented**
   - 🆕 **Solution**: New Protocol 108 (Position)

3. **Equipped Gear**
   - ⚠️ **Partially Implemented**: Via admin protocol (on request only)
   - 🆕 **Solution**: New Protocol 109 (Equipment) for real-time tracking

4. **Slotted Abilities**
   - ⚠️ **Partially Implemented**: Via admin protocol (on request only)
   - 🆕 **Solution**: New Protocol 110 (Abilities) for real-time tracking
   - 🎯 **Enables**: Detecting when someone picks up Volendrung and auto-tracking Ruinous Cyclone

5. **Current Active Effects**
   - ❌ **Not Yet Implemented**
   - 🆕 **Solution**: New Protocol 111 (Active Effects)
   - 🎯 **Enables**: Attack timers, Rapids tracking, Plaguebreak detection

## 📝 Implementation Checklist

### Immediate (Must Do)
- [ ] Register IDs 102-120 on the LibGroupBroadcast wiki
- [ ] Enhance Protocol 105 (Heartbeat) to include health, magicka, stamina

### High Priority (Core Features)
- [ ] Implement Protocol 108 (Position) for location tracking
- [ ] Implement Protocol 110 (Abilities) for smart ultimate tracking

### Medium Priority (Nice to Have)
- [ ] Implement Protocol 109 (Equipment) for monster set tracking
- [ ] Implement Protocol 111 (Active Effects) for buff/debuff tracking

### Testing
- [ ] Test each protocol with 2-person group
- [ ] Test with 12-person group (Cyrodiil)
- [ ] Test during combat (performance check)
- [ ] Use Protocol Inspector to verify data flow

## 🚀 How to Add a New Protocol

**5-Step Process:**

```lua
-- 1. Define protocol ID constant
BeltalowdaNetworking.protocolTypes.POSITION = 108

-- 2. Declare protocol
local protocol = LGB:DeclareProtocol(108, "BeltalowdaPositionProtocol")

-- 3. Add fields
protocol:AddField(LGB.CreateNumericField("x"))
protocol:AddField(LGB.CreateNumericField("y"))

-- 4. Set data handler
protocol:OnData(function(unitTag, data)
    -- Handle received data
    d("Received position from " .. unitTag .. ": " .. data.x .. ", " .. data.y)
end)

-- 5. Finalize
protocol:Finalize({
    isRelevantInCombat = true,
    replaceQueuedMessages = true
})
```

**To Send Data:**
```lua
protocol:Send({ x = 100, y = 200 })
```

## 🎓 Best Practices

### DO ✅
- Use `replaceQueuedMessages = true` for frequently updated data (position, resources)
- Set `isRelevantInCombat` based on whether data matters in combat
- Throttle updates (don't send every frame)
- Only send when data changes significantly
- Validate received data before using it

### DON'T ❌
- Send updates every frame (causes lag)
- Send huge payloads (> 20 fields)
- Send non-critical data during combat
- Broadcast when not in a group
- Forget to check if LibGroupBroadcast is loaded

## 📊 Bandwidth Guidelines

| Data Type | Update Frequency | Combat Relevant | Replace Queued |
|-----------|------------------|-----------------|----------------|
| Resources | 500ms (2/sec) | Yes | Yes |
| Position | 1000ms (1/sec) | Yes | Yes |
| Equipment | On change only | No | Yes |
| Abilities | On change only | No | Yes |
| Effects | 500ms combat, 2s out | Yes | Yes |

## 🔍 Debugging Tools

**Protocol Inspector** (In-Game):
1. Open ESO Settings
2. Go to Add-ons
3. Find LibGroupBroadcast section
4. Enable "Protocol Inspector"
5. See real-time data flow for all protocols

**Useful Commands:**
```lua
-- Check if LibGroupBroadcast is loaded
/script d(LibGroupBroadcast ~= nil)

-- See all registered protocols
/script for k,v in pairs(LibGroupBroadcast.protocols) do d(k) end
```

## 📚 More Information

- **Full Guide**: See `LIBGROUPBROADCAST_GUIDE.md` in this repo
- **LibGroupBroadcast Wiki**: https://wiki.esoui.com/LibGroupBroadcast_IDs
- **Download**: https://www.esoui.com/downloads/info1337-LibGroupBroadcastformerlyLibGroupSocket.html
- **Source Code**: https://github.com/sirinsidiator/ESO-LibGroupBroadcast

## 🎯 Issue Resolution

The original issue asked for guidance on LibGroupBroadcast usage. Here's the summary:

**Question**: Should we use LibGroupBroadcast? Do we need dedicated IDs?

**Answer**: 
- ✅ **Already using it** - 6 protocols implemented and working
- ✅ **Yes, need IDs** - Should register 102-120 on wiki
- ✅ **Clear path forward** - 4 new protocols designed for requested features
- ✅ **Implementation ready** - Code examples provided in full guide

**What to do next**:
1. Register IDs on wiki (5 minutes)
2. Review full guide for implementation details
3. Implement protocols based on priority
4. Test with group members

---

**Last Updated**: 2025-12-31  
**See Also**: `LIBGROUPBROADCAST_GUIDE.md` for detailed implementation
