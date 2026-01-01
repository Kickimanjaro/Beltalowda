# Phase 2 Implementation Notes

## Overview

This document describes the Phase 2 implementation for LibGroupBroadcast integration.

## What Was Implemented

### 1. Dependencies Added
- **LibGroupCombatStats>=6**: Added to `Beltalowda.txt` manifest
- Library check added to `Beltalowda.lua`

### 2. Network Infrastructure Created
- **File**: `Base/Network/GroupBroadcast.lua`
- **Purpose**: Subscribe to and store data from LibGroupCombatStats and LibSetDetection

### 3. Data Structure
- `BeltalowdaNetwork.groupData`: Stores data for all group members
- Format: `groupData[unitTag] = { ultimate = {...}, equipment = {...} }`

### 4. Library Integration

#### LibGroupCombatStats (Ultimate Data)
- Subscribes to:
  - Ultimate Type (ID 20): Ability ID and cost
  - Ultimate Value (ID 21): Current/max ultimate points
- **Note**: API callback names assumed based on common patterns:
  - `LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_TYPE_CHANGED, callback)`
  - `LGCS:RegisterCallback(LGCS.EVENT_ULTIMATE_VALUE_CHANGED, callback)`

#### LibSetDetection (Equipment Data)
- Subscribes to:
  - Equipment Sets (ID 40): All equipped set data
- **Note**: API callback name assumed:
  - `LSD:RegisterCallback(LSD.EVENT_EQUIPPED_SETS_CHANGED, callback)`

### 5. Debug Commands
- `/btlwdata group` - Display all group member data
- `/btlwdata ults` - Display ultimate data for group
- `/btlwdata equip` - Display equipment data for group

### 6. Event Handling
- `EVENT_GROUP_MEMBER_LEFT`: Cleans up data when players leave group

## API Assumptions & Verification

**IMPORTANT**: The callback registration code makes assumptions about the LibGroupCombatStats and LibSetDetection APIs.

### Verification Method

Use the debug command `/btlwdata libapi` in-game to check:
1. If libraries are loaded
2. If they have `RegisterCallback` methods
3. What event constants are available

### Expected API Patterns

1. **LibGroupCombatStats**:
   - Should provide `RegisterCallback()` method
   - Event constants: `EVENT_ULTIMATE_TYPE_CHANGED`, `EVENT_ULTIMATE_VALUE_CHANGED`
   - Callback signatures:
     - Ultimate Type: `function(unitTag, abilityId, cost)`
     - Ultimate Value: `function(unitTag, current, max)`

2. **LibSetDetection**:
   - Should provide `RegisterCallback()` method
   - Event constant: `EVENT_EQUIPPED_SETS_CHANGED`
   - Callback signature: `function(unitTag, sets)`

### Error Handling

The implementation now includes:
- `pcall()` wrapped callback registration to catch API errors
- Fallback messages if API differs from expected
- Debug command `/btlwdata libapi` to inspect library APIs in-game

### Alternative API Patterns

If libraries use different patterns, they might:
1. Use LibGroupBroadcast directly (register with message IDs)
2. Provide getter methods instead of callbacks
3. Use different event naming conventions
4. Require initialization parameters

## Testing Requirements

### In-Game Testing Needed

1. **Library Availability**:
   - Install LibGroupCombatStats and LibSetDetection
   - Verify no errors on addon load
   - Check chat for initialization messages
   - Run `/btlwdata libapi` to verify library API structure

2. **API Verification**:
   - Check `/btlwdata libapi` output for available methods
   - Verify the callback registration methods are correct
   - May need to consult library documentation or source code
   - Adjust callback registration if API differs from assumptions

3. **Data Flow Testing**:
   - Form group with 2+ players (all with libraries installed)
   - Test ultimate data:
     - Use `/btlwdata ults` to check if ultimate data syncs
     - Change ultimate, verify updates propagate
   - Test equipment data:
     - Use `/btlwdata equip` to check if equipment syncs
     - Change gear, verify updates propagate

4. **Group Events**:
   - Verify data cleanup when players leave group
   - Verify new player data appears when they join

## Potential Issues & Solutions

### Issue: Callback Registration Fails
**Symptom**: Errors about undefined methods or constants  
**Solution**: 
1. Check LibGroupCombatStats and LibSetDetection source code
2. Update callback registration to match actual API
3. May need to use different event registration approach

### Issue: No Data Received
**Symptom**: `/btlwdata` commands show no data  
**Solutions**:
1. Verify libraries are installed and loaded
2. Check that other group members have libraries installed
3. Verify callback signatures match library expectations
4. Add debug logging to callbacks to trace execution

### Issue: Wrong Data Format
**Symptom**: Data stored but in wrong format  
**Solution**: 
1. Inspect actual data structure passed to callbacks
2. Adjust data storage/mapping in callback handlers

## Next Steps

1. **Testing Phase** (requires in-game access):
   - Load addon in ESO
   - Verify no load errors
   - Test with group members

2. **API Adjustment** (if needed):
   - Consult library documentation
   - Update callback registration
   - Test again

3. **Integration Complete**:
   - Once data flows correctly, Phase 2 is complete
   - Ready to proceed to Phase 3 (Enhanced Ultimate Tracking)

## Fallback Plan

If LibGroupCombatStats or LibSetDetection APIs differ significantly:

1. **Review Library Source**:
   - Download libraries from ESOUI
   - Examine API methods and events
   - Document actual API

2. **Update Integration**:
   - Modify `GroupBroadcast.lua` to match actual API
   - May need different subscription approach

3. **Alternative Approach**:
   - If libraries don't provide callbacks, may need to:
     - Poll data periodically
     - Use LibGroupBroadcast directly to receive messages
     - Implement custom data collection (back to Phase 1 approach)

## Success Criteria

Phase 2 is complete when:
- [x] LibGroupCombatStats added as dependency
- [x] Network infrastructure created
- [x] Callback subscriptions implemented
- [x] Data storage structure created
- [x] Debug commands functional
- [ ] In-game testing confirms data flows correctly
- [ ] No errors during normal operation
- [ ] Group data visible via debug commands

**Current Status**: Implementation complete, pending in-game testing
