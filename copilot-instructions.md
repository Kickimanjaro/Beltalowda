# Copilot Instructions for Beltalowda

## Project Overview

Beltalowda is a greenfield group PvP addon for The Elder Scrolls Online (ESO) written in Lua, currently being built from planning documents in `docs/`. The addon will provide real-time ultimate tracking, synergy management, and group coordination features for PvP gameplay. 

**Reference Implementation:** The Kickimanjaro/RdK repository serves as a reference implementation of similar functionality. RdK was originally created by @Parnax and is used here as a guide and inspiration for understanding ESO addon patterns and group coordination features.

## Critical ESO Addon Patterns

### Namespace Initialization (REQUIRED)

ESO addons are multi-file Lua applications that require specific namespace patterns:

**Always use the `or {}` pattern:**
```lua
-- Initialize namespace (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.feature = Beltalowda.feature or {}

-- Create local alias for performance
local BeltalowdaFeature = Beltalowda.feature
```

**Why this matters:**
- Multiple files may initialize the same namespace
- Without `or {}`, later files would overwrite earlier ones
- Local aliases improve performance (faster than table lookups)
- This is NOT standard Lua - it's ESO addon specific

### File Header Template

Every file should start with:
```lua
-- Initialize required namespaces
Beltalowda = Beltalowda or {}
Beltalowda.module = Beltalowda.module or {}

-- Create local aliases
local BeltalowdaModule = Beltalowda.module

-- Module implementation
BeltalowdaModule.Initialize = function()
    -- Code here
end
```

## Future Patterns

### Version Management

**Note:** These files don't exist yet but will need to follow this pattern when created.

When updating versions, you **MUST** update THREE locations:

1. **Beltalowda.txt** - `## Version: X.X.X`
2. **Beltalowda.lua** - `Beltalowda.versionString = "X.X.X"`
3. **CHANGELOG.md** - Add new version entry at top with date

Follow [Keep a Changelog](https://keepachangelog.com/) format with sections: Added, Changed, Fixed, Removed.

## Reference Implementation (RdK)

**RdK** (Kickimanjaro/RdK) is a similar ESO addon with related functionality that serves as a reference implementation for Beltalowda.

**How to use RdK as reference:**
- RdK demonstrates ESO API patterns and implementation approaches
- When planning docs mention "RdK does X", it means "reference this pattern from RdK"
- RdK is NOT Beltalowda's codebase - it's a reference only
- Use RdK to understand how similar features were implemented in practice

**What to reference from RdK:**
- ESO event handling patterns
- LibGroupBroadcast integration approaches
- UI layout and control structures
- Namespace organization patterns
- SavedVariables data structures

## Code Organization

**Current State:**
The repository currently contains only:
- `docs/` - Planning and architecture documents
- `old-docs/` - Historical documentation from previous implementation
- `copilot-instructions.md` - This file
- `LICENSE` - License file
- `README.md` - Project overview

**Planned Structure:**
See `docs/ARCHITECTURE_PLAN.md` for the complete folder structure we're building towards. The architecture includes:
- `Base/` - Core functionality modules (Data collectors, utilities, integrations)
- `UI/` - User interface components
- `Lang/` - Localization files (to be added later)

**Reference Structure (from RdK):**
The folder structure comments in planning documents show how RdK organized similar functionality. This is for reference only - Beltalowda may organize differently based on the architecture plan.
```
# Example RdK organization (reference only):
Base/Compass/            # Compass features
Base/ClassRole/          # Class/role-based features
Base/Toolbox/            # Utility features (Synergy, Buffs, etc)
Base/Group/              # Group tracking (Ultimate, Debuff, Potion, Rapid)
```

## Troubleshooting Philosophy

**⚠️ DO NOT add defensive nil checks without finding the root cause**

❌ **Bad approach:**
```lua
if table and table.field and table.field.function then
    table.field.function()
end
```

✅ **Correct approach:**
1. Understand what was removed/changed
2. Find the missing initialization or function definition
3. Make ONE targeted fix
4. Test immediately in ESO
5. Use git reset if things spiral - don't cascade fixes

**When code breaks after changes:**
- Compare with reference implementation if available
- Look for missing function definitions
- Check for unbalanced if/end statements
- Verify namespace initialization

## UI Visibility Patterns

### Persistent Tracking Windows
Features like Ultimate Tracker should always be visible when enabled:

```lua
function Module.SetControlVisibility()
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
Features like Debuff Overview may hide in cursor mode:

```lua
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
```

## Localization

**Current State:** Beltalowda is starting without separate localization files. All UI text will be defined directly in the code in English initially.

**Future Implementation:**
When localization is added later, create language files and update all of them with new UI text:
- `Lang/en.lua` (English - extract existing strings here)
- `Lang/de.lua` (German - translate strings)
- `Lang/fr.lua` (French - translate strings)

Use constant naming pattern: `CONSTANT_NAME_PATTERN`

**Reference:** RdK supported multiple languages via separate Lang/ files, but Beltalowda will start with hardcoded English strings and can add proper localization infrastructure later if needed.

## Event Handling Patterns

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

**Note:** This checklist is for future use when features are implemented.

Before committing changes:
- [ ] Feature works in PvE zones
- [ ] Feature works in PvP zones
- [ ] PvP-only toggle properly shows/hides
- [ ] Position lock/unlock works
- [ ] Window visible in cursor mode when unlocked
- [ ] Settings menu displays correctly
- [ ] All localized strings present (en, de, fr)
- [ ] No console errors when loading addon
- [ ] No console errors when toggling features

## Planning Documentation

**Location**: `/docs/` directory contains comprehensive planning documents

**CRITICAL:** These planning docs are the PRIMARY source of truth. They describe what we're BUILDING (not what currently exists). The RdK repository is available as a reference for similar implementations.

**Key Documents**:
- `ARCHITECTURE_PLAN.md` - Overall system design and architecture
- `LIBGROUPBROADCAST_INTEGRATION.md` - Network layer integration strategy
- `LIBSETS_INTEGRATION.md` - Equipment tracking implementation
- `SAVEDVARIABLES_GUIDE.md` - Data persistence patterns
- `DEVELOPMENT_ROADMAP.md` - 12-phase implementation plan (26 weeks)
- `IMPLEMENTATION_CHECKPOINTS.md` - 30+ in-game test procedures
- `PLANNING_SUMMARY.md` - Executive overview and quick reference

**Implementation Guidance**:
1. **Planning docs first** - Always start with the planning documents to understand what to build
2. **RdK patterns second** - Reference RdK for ESO API patterns and implementation approaches
3. **RdK is reference only** - RdK is NOT Beltalowda's codebase, it's a similar addon to learn from
4. **When docs mention RdK** - Treat it as "look at RdK for how they solved this problem"

**Documentation Maintenance Rules**:
1. **Planning docs are source of truth** - implementation should match the plan
2. **Update docs when plans change** - don't let them drift from reality
3. **Reference specific sections** when asking AI agents to implement features
4. **Use checkpoints** from IMPLEMENTATION_CHECKPOINTS.md to verify work
5. **Document deviations** - if you deviate from the plan, update the plan with rationale

**When to Update Planning Docs**:
- Architecture changes (new modules, different approach)
- Library integration changes (adding/removing dependencies)
- Feature scope changes (adding/removing features)
- Implementation order changes (phase reordering)
- Major design decisions (different UI approach, different data structure)

## Key Principles

1. **Always use `TableName = TableName or {}`** when initializing namespaces
2. **Create local aliases** at the top of each file for performance
3. **Follow the established namespace hierarchy** (`Beltalowda.module.submodule`)
4. **Never assume a namespace exists** - always initialize with `or {}`
5. **Find root causes, not symptoms** - avoid defensive nil checks
6. **Plan for localization** when adding UI text (starting English-only)
7. **Test in ESO immediately** after changes
8. **Update version in all required files** when releasing (future)
9. **"If we don't need it, don't store it"** - minimize SavedVariables data collection
10. **Follow planning docs first** - then reference RdK for implementation patterns
