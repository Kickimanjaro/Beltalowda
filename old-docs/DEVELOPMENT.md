# Development Guidelines for Beltalowda

---

# 🚨 MANDATORY PREREQUISITE FOR ALL AI AGENTS 🚨

**STOP! READ THIS ENTIRE FILE BEFORE MAKING ANY CODE CHANGES!**

This file contains **critical troubleshooting patterns** and **ESO-specific development practices** that you **MUST** follow. 

⚠️ **IMPORTANT SECTIONS YOU MUST READ:**
1. **[ESO Addon Best Practices](#eso-addon-development-best-practices)** - Required namespace patterns
2. **[Troubleshooting Philosophy](#troubleshooting-philosophy)** - DO NOT add defensive nil checks
3. **[Version Management](#version-management--changelog)** - How to update versions properly

**Failure to follow these guidelines will result in broken code that must be reverted.**

---

## Overview

This document provides guidelines for developing and maintaining Beltalowda. It covers version management, changelog updates, code organization, and other best practices.

## ESO Addon Development Best Practices

**⚠️ CRITICAL FOR AI AGENTS - READ BEFORE ANY CODE CHANGES ⚠️**

Before making any code changes to this addon, **you MUST read and understand** the patterns documented in:

📖 **[ESO_ADDON_BEST_PRACTICES.md](ESO_ADDON_BEST_PRACTICES.md)**

This document covers critical ESO addon development patterns including:
- **Namespace initialization with `or {}`** - Required for multi-file addons to prevent overwriting
- **Local alias patterns** - Performance optimization for table lookups
- **Module organization** - How to structure namespaces across files
- **File header templates** - Proper initialization in every file

### Key Principles

1. **Always use `TableName = TableName or {}`** when initializing namespaces
2. **Create local aliases** at the top of each file for performance
3. **Follow the established namespace hierarchy** (`Beltalowda.module.submodule`)
4. **Never assume a namespace exists** - always initialize with `or {}`
5. **Understand multi-file safety** - your file isn't the only one touching these tables

### Example from This Codebase

```lua
-- Initialize namespace (safe for multi-file use)
Beltalowda.group = Beltalowda.group or {}
BeltalowdaGroup.ro = BeltalowdaGroup.ro or {}

-- Create local alias (performance)
local BeltalowdaOverview = BeltalowdaGroup.ro

-- Now use the local alias
BeltalowdaOverview.Initialize = function()
    -- Implementation
end
```

**Failing to follow these patterns will break the addon.** ESO addons are not like typical Lua applications - they have specific requirements for multi-file namespace management.

## Version Management & Changelog

### When to Update Version

Update the version when:
- Adding new features
- Fixing bugs
- Making significant changes to existing features
- Reorganizing UI or settings

### How to Update Version

When incrementing the version number, you **MUST**:

#### 1. Update Version in TWO Files

**File 1: `Beltalowda.txt`** (addon manifest)
- Locate line: `## Version: X.X.X`
- Update to new version

**File 2: `Beltalowda.lua`** (main script)
- Locate line: `Beltalowda.versionString = "X.X.X"`
- Update to new version

#### 2. Update CHANGELOG.md

Add a new entry at the top of the file (before other versions):

```markdown
## [NEW_VERSION] - YYYY-MM-DD

### Added
- Feature 1 description
- Feature 2 description

### Changed
- Change 1 description
- Change 2 description

### Fixed
- Bug fix 1 description
- Bug fix 2 description

### Removed
- Removed item 1 description
```

#### 3. Follow Keep a Changelog Format

Guidelines:
- Use standard sections: **Added**, **Changed**, **Fixed**, **Removed**
- Only include sections with content (no empty sections)
- Write in past tense, third person
- Be descriptive but concise
- Group related changes together
- Include context about WHY changes were made when not obvious

### Example Workflow

```
User: "Let's increment to version 0.2.5"

Steps:
1. Update Beltalowda.txt: ## Version: 0.2.5
2. Update Beltalowda.lua: Beltalowda.versionString = "0.2.5"
3. Add comprehensive CHANGELOG.md entry documenting:
   - All new features added in this version
   - What was refactored/reorganized
   - What bugs were fixed
   - What was removed
4. Include date and proper formatting
```

## Code Organization

### Directory Structure

```
Beltalowda/
├── Base/                    # Core functionality modules
│   ├── Compass/            # Compass features
│   ├── ClassRole/          # Class/role-based features
│   ├── Toolbox/            # Utility features (Synergy, Buffs, etc)
│   ├── Group/              # Group tracking (Ultimate, Debuff, Potion, Rapid)
│   ├── Profile/            # Profile management
│   ├── Configuration/      # Config import/export
│   ├── Admin/              # Admin utilities
│   ├── Util/               # Utilities (Ultimates, Group, Networking)
│   └── AddOnIntegration/   # Integration with other addons
├── UI/                      # User interface components
├── Lang/                    # Localization files (en.lua, de.lua, fr.lua)
├── Lib/                     # Third-party libraries
├── Art/                     # Image assets (DDS files)
├── BeltalowdaMenu.lua       # Settings menu integration
├── Beltalowda.lua           # Main addon file
└── Beltalowda.txt           # Addon manifest
```

### Adding New Features

1. **Create in appropriate Base subdirectory** based on category
2. **Follow naming conventions**: `FeatureName.lua` for main file
3. **Use consistent module structure**:
   ```lua
   Beltalowda.feature = Beltalowda.feature or {}
   local BeltalowdaFeature = Beltalowda.feature
   
   BeltalowdaFeature.constants = {}
   BeltalowdaFeature.state = {}
   BeltalowdaFeature.config = {}
   
   function BeltalowdaFeature.Initialize()
       -- initialization code
   end
   ```
4. **Add settings menu integration** in `BeltalowdaMenu.lua` if user-configurable
5. **Add localization strings** in `Lang/en.lua`, `Lang/de.lua`, `Lang/fr.lua`
6. **Document in appropriate README** if creating new subsystem

## UI Visibility Patterns

### Persistent Tracking Windows

These features should **always be visible** when enabled (even in cursor mode):
- Ultimate Tracker (ResourceOverview)
- Synergy Overview
- Synergy Prevention
- Rapid Overview

**Code Pattern:**
```lua
function Module.SetControlVisibility()
    local enabled = Module.vars.enabled
    local positionLocked = Module.vars.positionLocked
    local setHidden = true
    
    -- Always show if position is unlocked (for repositioning)
    if positionLocked == false then
        setHidden = false
    elseif enabled == true and pvpCheck == true then
        setHidden = false
    end
    
    Module.controls.TLW:SetHidden(setHidden)
end
```

### Combat Contextual Displays

These features may **hide in cursor mode** when position is locked:
- Debuff Overview (Proxy/Shalks timers)
- Potion Overview
- Compasses
- Buff/Food alerts

**Code Pattern:**
```lua
function Module.SetControlVisibility()
    local enabled = Module.vars.enabled
    local positionLocked = Module.vars.positionLocked
    local setHidden = true
    
    -- Always show if position is unlocked
    if positionLocked == false then
        setHidden = false
    elseif enabled == true and pvpCheck == true then
        setHidden = false
    end
    
    if setHidden == false then
        -- Only hide in cursor mode if position is locked
        if Module.state.foreground == false and positionLocked == true then
            Module.controls.TLW:SetHidden(Module.state.activeLayerIndex > 2)
        else
            Module.controls.TLW:SetHidden(false)
        end
    else
        Module.controls.TLW:SetHidden(setHidden)
    end
end
```

### PvP Toggle Logic

Proper PvP visibility should handle:
- PvP OFF → show if enabled
- PvP ON in PvP zone → show if enabled
- PvP ON in non-PvP zone → hide

```lua
if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
    setHidden = false
end
```

## Localization

### Adding Localized Strings

When adding UI text:

1. **Add to all language files** (required):
   - `Lang/en.lua` (English)
   - `Lang/de.lua` (German)
   - `Lang/fr.lua` (French)

2. **Follow naming convention**: `CONSTANT_NAME_PATTERN`

3. **Example**:
   ```lua
   -- Lang/en.lua
   BeltalowdaLang.NEW_FEATURE_HEADER = "|cFF8174New Feature|r"
   BeltalowdaLang.NEW_FEATURE_DESC = "This feature does amazing things"
   ```

## Event Handling

### Common Patterns

**Player Activation:**
```lua
function Module.OnPlayerActivated(eventCode, initial)
    if Module.vars.enabled then
        -- Register for events
        -- Add features to group tracker
    else
        -- Unregister from events
        -- Remove features from group tracker
    end
    Module.SetControlVisibility()
end
```

**Foreground Visibility (cursor mode):**
```lua
function Module.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
    if eventCode == EVENT_ACTION_LAYER_POPPED then
        Module.state.foreground = true
    elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
        Module.state.foreground = false
    end
    Module.state.activeLayerIndex = activeLayerIndex
    Module.SetControlVisibility()
end
```

## Testing Checklist

Before incrementing version:

- [ ] Feature works in PvE zones
- [ ] Feature works in PvP zones
- [ ] PvP-only toggle properly shows/hides
- [ ] Position lock/unlock works
- [ ] Window visible in cursor mode when unlocked
- [ ] Window hidden/shown correctly in combat mode
- [ ] Settings menu displays correctly
- [ ] All localized strings present (en, de, fr)
- [ ] No console errors when loading addon
- [ ] No console errors when toggling features on/off

## Troubleshooting Philosophy

---

# ⚠️ MANDATORY READING FOR ALL AI AGENTS ⚠️

**This section is REQUIRED reading before making ANY bug fixes or code changes.**

**Context:** AI agents have previously violated these guidelines by adding defensive nil checks instead of finding root causes, leading to wasted time and code reverts. This pattern has occurred multiple times and must not be repeated.

---

### When Things Break After Code Changes

**⚠️ STOP AND THINK BEFORE ADDING DEFENSIVE CHECKS ⚠️**

If you've made changes (like removing a feature) and errors appear:

#### ❌ DON'T: Add Defensive Nil Checks Everywhere
```lua
-- BAD: Treating symptoms, not the root cause
if BeltalowdaOverview.roVars then
    if BeltalowdaOverview.roVars.groups then
        if BeltalowdaOverview.GetRoAvailableGroupsGroups then
            -- Now do the actual work
        end
    end
end
```

This approach:
- Masks the real problem
- Creates cascading errors
- Makes code harder to maintain
- Can cause UI elements to disappear silently

#### ✅ DO: Find and Fix the Root Cause

**Step-by-step approach:**

1. **Understand what you removed**
   - Did you delete initialization code?
   - Did you remove required function definitions?
   - Did you break if/end statement balance?

2. **Compare with reference implementation** (RDK)
   - Look at the same file in `/home/kick/rdk/`
   - Identify what structural differences exist
   - Focus on initialization and function definitions

3. **Make ONE targeted fix**
   - Address the specific missing piece
   - Don't add defensive checks around it
   - If the reference code doesn't have nil checks, you probably don't need them

4. **Test in ESO immediately**
   - Don't make multiple changes without testing
   - If your fix creates new errors, you're fixing the wrong thing
   - Revert and try again

5. **Use version control**
   - Commit working states frequently
   - Don't hesitate to `git reset --hard` when things spiral
   - It's faster to start over than fix cascading errors

### Real Example: The Swimlane Removal Issue

**What happened:**
- Removed swimlane feature code (~20 lines)
- Got "function expected instead of nil" error
- Started adding defensive nil checks
- Created more errors across 5+ files
- UI elements disappeared
- Had to reset everything

**What we should have done:**
1. Read the error: "GetRoAvailableGroupsGroups is nil"
2. Search RDK for that function definition
3. Realize it was removed with swimlane code
4. Check if it's actually needed or if calls to it should be removed
5. Make ONE change: either restore the function or remove the calls
6. Test in ESO

**Key insight:** The RDK reference implementation exists for a reason. Use it.

## Common Issues & Solutions

### Issue: UI disappears in cursor mode
**Solution:** Check if `positionLocked == false` check is at top of visibility logic

### Issue: PvP toggle doesn't show items
**Solution:** Ensure PvP condition checks both sides: `pvpOnly == false OR (pvpOnly == true AND IsInPvPArea())`

### Issue: Events not firing
**Solution:** Confirm events registered in `OnPlayerActivated` and unregistered in the else clause

### Issue: Settings don't persist
**Solution:** Verify saved variables are registered in `Beltalowda.txt` and defaults set in config structure

### Issue: Error after removing code
**Solution:** Compare with RDK reference implementation to identify what's actually missing - don't add defensive nil checks

## Release Process

1. **Update version numbers** in `Beltalowda.txt` and `Beltalowda.lua`
2. **Update CHANGELOG.md** with comprehensive entry
3. **Test thoroughly** using checklist above
4. **Commit to git** with clear message: `Version bump: X.X.X - [brief description]`
5. **Create git tag** if managing releases
6. **Upload to ESOUI** if distributing

## Resources

- [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) - Changelog format standard
- [Pride Versioning](https://pridever.org/) - Version numbering scheme
- [ESOUI Addon Standards](https://esoui.com/) - ESO addon guidelines
- ESO API Documentation: In-game `/esoui` command
