# Library Installation Guide

This document explains how to install the required libraries for Beltalowda.

## Current Status (Phase 0)

The repository currently includes **stub implementations** of LibAsync and LibSets in the `Lib/` directory. These stubs allow the addon to load and be tested, but provide minimal functionality.

## Required Libraries

### 1. LibStub
**Status**: Should be provided by ESO addon framework
**Purpose**: Library management system used by ESO addon ecosystem

### 2. LibAsync (>=2.8)
**Current**: Stub implementation in `Lib/LibAsync/`
**Download**: https://www.esoui.com/ (search for "LibAsync")
**Author**: sirinsidiator
**Purpose**: Asynchronous task management library

**Installation**:
1. Download LibAsync from ESOUI
2. Replace `Lib/LibAsync/` directory with the downloaded version
3. Verify the manifest file (LibAsync.txt) exists

### 3. LibSets (>=71)
**Current**: Stub implementation in `Lib/LibSets/`
**Download**: 
- https://www.esoui.com/downloads/info2241-LibSets.html
- https://github.com/Baertram/LibSets

**Author**: Baertram
**Purpose**: Item set detection and information
**Dependencies**: LibAsync

**Installation**:
1. Download LibSets from ESOUI or GitHub
2. Replace `Lib/LibSets/` directory with the downloaded version
3. Verify the manifest file (LibSets.txt) exists

## Week 2 Research Tasks

As part of Phase 0 Week 2, research these existing LibGroupBroadcast libraries:

### LibGroupCombatStats
**Purpose**: Ultimate Type/Value, DPS, HPS tracking
**Message IDs**: 20 (Ultimate Type), 21 (Ultimate Value)
**Status**: To be researched in Week 2

**Research Questions**:
- What ultimate data does it provide?
- Can we reuse this instead of custom ultimate tracking?
- What are the protocol details?

### LibSetDetection
**Purpose**: Equipment set sharing
**Message ID**: 40
**Status**: To be researched in Week 2

**Research Questions**:
- What set data does it broadcast?
- Can we reuse this instead of custom equipment broadcasting?
- How does it integrate with LibSets?

### LibGroupResources
**Purpose**: Stamina and Magicka resource tracking
**Message IDs**: 10 (Stamina), 11 (Magicka)
**Status**: To be researched in Week 2

**Research Questions**:
- What resource data does it provide?
- Can we reuse this instead of custom resource tracking?
- Does it also track health and ultimate?

## Integration Strategy

After Week 2 research, we will decide:
1. Which libraries to use vs. custom implementation
2. Update dependencies in Beltalowda.txt if needed
3. Update DEVELOPMENT_ROADMAP.md with findings
4. Proceed to Phase 1 with informed implementation plan

## Testing Library Installation

To verify libraries are loaded correctly:

1. Load addon in ESO
2. Open chat console (usually `/`)
3. Type: `/script d(LibAsync ~= nil)` - should print "true"
4. Type: `/script d(LibSets ~= nil)` - should print "true"
5. Check for any error messages when addon loads

## Notes

- Stub implementations will work for Phase 0 testing
- Full libraries are required for Phase 4 (Equipment Tracking) and beyond
- Always check ESOUI for the latest library versions
- Update Beltalowda.txt dependencies if library versions change
