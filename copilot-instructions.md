# Copilot Instructions for Beltalowda

## Project Overview

Beltalowda is a group PvP addon for The Elder Scrolls Online (ESO) written in Lua. It provides real-time ultimate tracking, synergy management, and group coordination features for PvP gameplay.

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

## Version Management

When updating versions, you **MUST** update THREE locations:

1. **Beltalowda.txt** - `## Version: X.X.X`
2. **Beltalowda.lua** - `Beltalowda.versionString = "X.X.X"`
3. **CHANGELOG.md** - Add new version entry at top with date

Follow [Keep a Changelog](https://keepachangelog.com/) format with sections: Added, Changed, Fixed, Removed.

## Code Organization

```
Base/                    # Core functionality modules
├── Compass/            # Compass features
├── ClassRole/          # Class/role-based features
├── Toolbox/            # Utility features (Synergy, Buffs, etc)
├── Group/              # Group tracking (Ultimate, Debuff, Potion, Rapid)
├── Profile/            # Profile management
├── Configuration/      # Config import/export
├── Admin/              # Admin utilities
├── Util/               # Utilities (Ultimates, Group, Networking)
└── AddOnIntegration/   # Integration with other addons
UI/                      # User interface components
Lang/                    # Localization (en.lua, de.lua, fr.lua)
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

When adding UI text, update **all three** language files:
- `Lang/en.lua` (English)
- `Lang/de.lua` (German)
- `Lang/fr.lua` (French)

Use constant naming pattern: `CONSTANT_NAME_PATTERN`

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

## Key Principles

1. **Always use `TableName = TableName or {}`** when initializing namespaces
2. **Create local aliases** at the top of each file for performance
3. **Follow the established namespace hierarchy** (`Beltalowda.module.submodule`)
4. **Never assume a namespace exists** - always initialize with `or {}`
5. **Find root causes, not symptoms** - avoid defensive nil checks
6. **Update all language files** when adding UI text
7. **Test in ESO immediately** after changes
8. **Update version in all required files** when releasing
