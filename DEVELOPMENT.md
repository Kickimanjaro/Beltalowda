# Development Guidelines for Beltalowda

## Overview

This document provides guidelines for developing and maintaining Beltalowda. It covers version management, changelog updates, code organization, and other best practices.

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

## Common Issues & Solutions

### Issue: UI disappears in cursor mode
**Solution:** Check if `positionLocked == false` check is at top of visibility logic

### Issue: PvP toggle doesn't show items
**Solution:** Ensure PvP condition checks both sides: `pvpOnly == false OR (pvpOnly == true AND IsInPvPArea())`

### Issue: Events not firing
**Solution:** Confirm events registered in `OnPlayerActivated` and unregistered in the else clause

### Issue: Settings don't persist
**Solution:** Verify saved variables are registered in `Beltalowda.txt` and defaults set in config structure

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
