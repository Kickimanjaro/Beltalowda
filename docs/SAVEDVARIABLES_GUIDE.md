# SavedVariables Guide for Beltalowda

## Overview

This document explains how ESO's SavedVariables system works and how Beltalowda uses it to store player preferences, UI positions, and feature settings.

## What are SavedVariables?

SavedVariables are ESO's mechanism for addons to persist data between game sessions. Data is stored in:
- **Windows**: `Documents\Elder Scrolls Online\live\SavedVariables\`
- **Mac**: `~/Documents/Elder Scrolls Online/live/SavedVariables/`

Each addon gets its own file, e.g., `Beltalowda.lua` containing all saved data.

## Two Storage Scopes

ESO provides two types of SavedVariables:

### 1. Per-Character Storage
**Created with**: `ZO_SavedVars:New()`

**Use for**:
- Character-specific settings
- Different preferences per character
- Character-specific keybinds

**Example**:
```lua
local charVars = ZO_SavedVars:New("BeltalowdaVars", 1, nil, defaults)
-- Stored at: SavedVariables/Beltalowda.lua
-- Key: Default/EU Megaserver/CharacterName
```

### 2. Account-Wide Storage  
**Created with**: `ZO_SavedVars:NewAccountWide()`

**Use for**:
- Settings shared across all characters
- UI positions (same for all chars)
- Tracked ultimates list
- Profile system

**Example**:
```lua
local accVars = ZO_SavedVars:NewAccountWide("BeltalowdaVars", 1, nil, defaults)
-- Stored at: SavedVariables/Beltalowda.lua
-- Key: Default/$AccountName
```

## Current Beltalowda Implementation

### Existing Structure

From `Beltalowda.lua`:

```lua
-- Character-specific
local charVars = ZO_SavedVars:New("BeltalowdaVars", Beltalowda.version, nil, Beltalowda.default.character)

-- Account-wide
local accVars = ZO_SavedVars:NewAccountWide("BeltalowdaVars", Beltalowda.version, nil, Beltalowda.default.profiles)

-- Not directly accessed
Beltalowda.vars.acc = accVars
Beltalowda.vars.char = charVars
```

### Profile System

Beltalowda uses a **profile-based system**:
- Multiple profiles can be created (e.g., "PvP", "PvE", "Healer")
- Each character selects which profile to use
- Profiles are account-wide, selection is per-character

**Current profile structure**:
```lua
profiles = {
    [1] = {
        name = "Default",
        ui = { ... },
        group = { ... },
        compass = { ... },
        toolbox = { ... },
        classRole = { ... },
        addOnIntegration = { ... },
        util = { ... },
        admin = { ... },
        cfg = { ... },
    },
    [2] = {
        name = "PvP",
        -- Same structure
    }
}
```

## Proposed Enhanced Structure

### Account-Wide Variables

```lua
BeltalowdaVars = {
    version = 1,  -- For migrations
    
    -- Profile system (existing)
    profiles = {
        [1] = {
            name = "Default",
            
            -- Existing modules (unchanged)
            ui = { ... },
            group = { ... },
            compass = { ... },
            toolbox = { ... },
            classRole = { ... },
            addOnIntegration = { ... },
            util = { ... },
            admin = { ... },
            cfg = { ... },
            
            -- NEW: Enhanced features
            data = {
                -- Data collection settings
                resources = {
                    enabled = true,
                    broadcastEnabled = true,
                    updateInterval = 500,  -- ms
                },
                
                position = {
                    enabled = true,
                    broadcastEnabled = true,
                    updateInterval = 100,  -- ms
                },
                
                abilities = {
                    enabled = true,
                    broadcastEnabled = true,
                    trackFullBar = true,  -- vs just ultimate
                    filterEffects = true,  -- Only broadcast relevant effects
                },
                
                equipment = {
                    enabled = true,
                    broadcastEnabled = true,
                    trackMonsterSets = true,
                    autoDetectRole = true,
                },
                
                state = {
                    enabled = true,
                    broadcastEnabled = true,
                    updateInterval = 500,  -- ms
                },
            },
            
            -- NEW: Ultimate tracking enhancements
            ultimateTracking = {
                enabled = true,
                
                -- UI Windows
                showClientUltimate = true,
                showGroupUltimates = true,
                showUltimateOverview = true,
                showPlayerBlocks = true,
                
                -- Window positions (account-wide, same across characters)
                positions = {
                    clientUltimate = { x = 100, y = 100 },
                    groupUltimates = { x = 200, y = 100 },
                    ultimateOverview = { x = 300, y = 100 },
                    playerBlocks = { x = 400, y = 100 },
                },
                
                -- Tracked ultimates (12 slots)
                trackedUltimates = {
                    [1] = 123456,  -- Destruction Staff: Eye of the Storm
                    [2] = 123457,  -- Sorcerer: Negate Magic
                    [3] = 123458,  -- Sorcerer: Storm Atronach
                    [4] = 123459,  -- Templar: Crescent Sweep
                    [5] = 123460,  -- Templar: Solar Prison
                    [6] = 123461,  -- Nightblade: Soul Tether
                    [7] = 123462,  -- Dragonknight: Standard of Might
                    [8] = 123463,  -- Restoration Staff: Panacea
                    [9] = 0,       -- Empty slot
                    [10] = 0,
                    [11] = 0,
                    [12] = 0,
                },
                
                -- Features
                prioritySystem = true,  -- Show cast order
                intensityReminder = true,  -- Visual effect when holding ult
                dynamicAbilities = true,  -- Auto-add Volendrung, etc.
                showUltimateTypes = true,  -- Type-specific counts vs total
                
                -- Broadcasting
                broadcastUltimate = true,
                broadcastAbilityId = true,  -- Share which ult is slotted
                updateThreshold = 5,  -- Broadcast on 5% change
            },
            
            -- NEW: Synergy tracking
            synergyTracking = {
                enabled = true,
                showAvailability = true,
                showCooldowns = true,
                showProgress = true,
                
                -- Window position
                position = { x = 500, y = 100 },
                
                -- Tracked synergies (configurable list)
                trackedSynergies = {
                    [1] = 234567,  -- Conduit
                    [2] = 234568,  -- Shackle
                    [3] = 234569,  -- Blood Altar
                    -- ... etc
                },
                
                broadcastUsage = true,
            },
            
            -- NEW: Attack coordination
            attackCoordination = {
                enabled = true,
                showBombTimers = true,
                showShalkTimers = true,
                showSynergyTimers = true,
                
                -- Window position
                position = { x = 600, y = 100 },
                
                -- Sound alerts
                soundAlerts = true,
                soundVolume = 0.5,
                alertTiming = 1000,  -- Alert 1s before optimal window
                
                -- Tracked abilities
                trackProximity = true,
                trackSubterranean = true,
                trackInnerRage = true,
                trackRunebreak = true,
                trackLightningFlood = true,
            },
            
            -- NEW: Quality of Life features
            qolFeatures = {
                -- Restock (siege merchant)
                restock = {
                    enabled = true,
                    items = {
                        -- itemId = quantity to maintain
                        [345678] = 20,  -- Stone Trebs
                        [345679] = 20,  -- Fire Ballista
                        [345680] = 100, -- Repair Kits
                    },
                    autoRestock = true,
                    goldWarning = 10000,  -- Warn if purchase > 10k
                },
                
                -- Queue Helper (campaign auto-join)
                queueHelper = {
                    enabled = true,
                    autoAccept = true,
                    acceptDelay = 1000,  -- Wait 1s before accepting
                    campaigns = {
                        ["Gray Host"] = 1,  -- Priority 1 (highest)
                        ["Blackreach"] = 2,
                    },
                },
                
                -- Log Helper (combat log automation)
                logHelper = {
                    enabled = true,
                    autoToggle = true,
                    maxDuration = 300,  -- 5 minutes
                    sizeWarning = 50,  -- Warn at 50MB
                },
                
                -- Invite Assistant (auto-invite)
                inviteAssistant = {
                    enabled = true,
                    triggers = {
                        [1] = "x",  -- Type "x" in chat for invite
                        [2] = "inv",
                    },
                    channels = {
                        zone = true,
                        guild1 = true,
                        guild2 = false,
                        whisper = true,
                    },
                    responseMessage = "Invited! Welcome to the group.",
                },
            },
            
            -- Broadcasting preferences
            broadcasting = {
                enabled = true,
                sendResources = true,
                sendPosition = true,
                sendAbilities = true,
                sendEquipment = true,
                sendState = true,
                
                -- Bandwidth management
                updateInterval = 100,  -- ms (global minimum)
                batchUpdates = true,  -- Batch multiple updates
            },
        },
    },
    
    -- Active profile per character (char name -> profile index)
    characterProfiles = {
        ["CharacterName1"] = 1,  -- Uses profile #1
        ["CharacterName2"] = 2,  -- Uses profile #2
    },
}
```

### Per-Character Variables

```lua
BeltalowdaVars_Character = {
    version = 1,
    
    -- Character-specific ultimate selection
    primaryUltimate = 123456,  -- Ability ID
    
    -- Character-specific role (overrides auto-detection)
    role = "DPS",  -- "Tank", "Healer", "DPS"
    roleOverride = false,  -- If true, don't auto-detect
    
    -- Last known position (for respawn assistance)
    lastPosition = {
        x = 0.5,
        y = 0.5,
        zone = 23,
        timestamp = 1234567890,
    },
    
    -- Last known equipment (for change detection)
    lastEquipment = {
        [1] = 123,  -- Head set ID
        [2] = 123,  -- Shoulders set ID
        -- ... etc
    },
    
    -- Character keybinds (if different from account-wide)
    keybinds = {
        ultimateCast = "KEY_R",
        syncAttack = "KEY_G",
        -- ... etc
    },
    
    -- Statistics (optional, for nerds)
    stats = {
        ultimatesCast = 0,
        synergiesUsed = 0,
        bombsThrown = 0,
        shalksLanded = 0,
        sessionsPlayed = 0,
    },
}
```

## Accessing SavedVariables

### Profile-Based Access

Beltalowda uses a profile system. To access settings:

```lua
-- Get current profile
local profile = Beltalowda.profile.GetProfile()

-- Access ultimate tracking settings
local ultSettings = profile.ultimateTracking
if ultSettings.enabled then
    -- Ultimate tracking is enabled
end

-- Modify settings
ultSettings.showClientUltimate = false
-- Changes are automatically saved
```

### Direct Access (Not Recommended)

While you can access `Beltalowda.vars.acc` and `Beltalowda.vars.char` directly, it's better to use the profile system:

```lua
-- BAD: Direct access
local enabled = Beltalowda.vars.acc.profiles[1].ultimateTracking.enabled

-- GOOD: Profile system
local profile = Beltalowda.profile.GetProfile()
local enabled = profile.ultimateTracking.enabled
```

## Default Values

Always provide defaults for new settings to avoid nil errors:

```lua
-- In module's GetDefaults() function
function BeltalowdaUltimateTracking.GetDefaults()
    return {
        enabled = true,
        showClientUltimate = true,
        showGroupUltimates = true,
        showUltimateOverview = true,
        showPlayerBlocks = true,
        trackedUltimates = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        },
        prioritySystem = true,
        intensityReminder = true,
        dynamicAbilities = true,
        broadcastUltimate = true,
        broadcastAbilityId = true,
        updateThreshold = 5,
        positions = {
            clientUltimate = { x = 100, y = 100 },
            groupUltimates = { x = 200, y = 100 },
            ultimateOverview = { x = 300, y = 100 },
            playerBlocks = { x = 400, y = 100 },
        },
    }
end
```

## Version Migrations

When adding new settings, handle version migrations:

```lua
-- In Beltalowda.util.versioning.InitializeFixes()
function Beltalowda.util.versioning.InitializeFixes(accVars, charVars)
    local version = accVars.version or 0
    
    if version < 2 then
        -- Migration to version 2: Add ultimate tracking enhancements
        for _, profile in ipairs(accVars.profiles) do
            if not profile.ultimateTracking then
                profile.ultimateTracking = BeltalowdaUltimateTracking.GetDefaults()
            end
        end
        accVars.version = 2
    end
    
    if version < 3 then
        -- Migration to version 3: Add synergy tracking
        for _, profile in ipairs(accVars.profiles) do
            if not profile.synergyTracking then
                profile.synergyTracking = BeltalowdaSynergyTracking.GetDefaults()
            end
        end
        accVars.version = 3
    end
    
    -- ... more migrations as needed
end
```

## Best Practices

### 1. Use Defaults for All Settings

```lua
-- Always provide defaults
local defaults = {
    enabled = true,
    value = 100,
}

local vars = ZO_SavedVars:New("MyAddon", 1, nil, defaults)
```

### 2. Populate Missing Fields

Use `Beltalowda.PopulateWithDefaults()` to fill in missing fields:

```lua
function Beltalowda.PopulateWithDefaults(orig, defaults)
    if orig ~= nil and type(orig) == "table" then
        for key, value in pairs(defaults) do
            if orig[key] == nil then
                orig[key] = defaults[key]
            elseif type(orig[key]) == "table" and type(defaults[key]) == "table" then
                Beltalowda.PopulateWithDefaults(orig[key], defaults[key])
            end
        end
    end
end
```

### 3. Avoid Direct Modification

Don't modify SavedVariables directly. Use setter functions:

```lua
-- BAD
Beltalowda.vars.acc.profiles[1].ultimateTracking.enabled = false

-- GOOD
function BeltalowdaUltimateTracking.SetEnabled(enabled)
    local profile = Beltalowda.profile.GetProfile()
    profile.ultimateTracking.enabled = enabled
    BeltalowdaUltimateTracking.OnSettingsChanged()
end
```

### 4. Validate Settings

Validate settings on load:

```lua
function BeltalowdaUltimateTracking.ValidateSettings(settings)
    -- Ensure update threshold is reasonable
    if settings.updateThreshold < 1 then
        settings.updateThreshold = 1
    end
    if settings.updateThreshold > 100 then
        settings.updateThreshold = 100
    end
    
    -- Ensure positions are on screen
    local screenWidth, screenHeight = GuiRoot:GetDimensions()
    if settings.positions.clientUltimate.x < 0 or 
       settings.positions.clientUltimate.x > screenWidth then
        settings.positions.clientUltimate.x = 100
    end
    -- ... etc
end
```

### 5. Use Meaningful Keys

Use descriptive keys, not abbreviations:

```lua
-- BAD
{
    en = true,
    shw = true,
    pos = { x = 0, y = 0 },
}

-- GOOD
{
    enabled = true,
    showUI = true,
    position = { x = 0, y = 0 },
}
```

## Data Size Considerations

SavedVariables files can get large. Optimize storage:

### 1. Don't Store Computed Values

```lua
-- BAD: Storing computed values
{
    health = 1000,
    maxHealth = 2000,
    healthPercent = 50,  -- Can be computed!
}

-- GOOD: Store only raw values
{
    health = 1000,
    maxHealth = 2000,
}
```

### 2. Use Compact Formats

```lua
-- BAD: Verbose
{
    trackedUltimates = {
        {id = 123456, enabled = true},
        {id = 123457, enabled = true},
    }
}

-- GOOD: Compact (just IDs, 0 = empty)
{
    trackedUltimates = {123456, 123457, 0, 0, ...}
}
```

### 3. Clear Old Data

Periodically clean up:

```lua
function BeltalowdaUltimateTracking.CleanupOldData()
    local profile = Beltalowda.profile.GetProfile()
    
    -- Remove inactive tracked ultimates
    for i, ultId in ipairs(profile.ultimateTracking.trackedUltimates) do
        if ultId > 0 and not BeltalowdaUltimates.IsValidUltimate(ultId) then
            profile.ultimateTracking.trackedUltimates[i] = 0
        end
    end
end
```

## Debugging SavedVariables

### View Saved Data

```lua
SLASH_COMMANDS["/btlwdumpsettings"] = function()
    local profile = Beltalowda.profile.GetProfile()
    d("=== Current Profile Settings ===")
    d(profile)
end
```

### Reset to Defaults

```lua
SLASH_COMMANDS["/btlwreset"] = function(module)
    if module == "ultimate" then
        local profile = Beltalowda.profile.GetProfile()
        profile.ultimateTracking = BeltalowdaUltimateTracking.GetDefaults()
        d("Ultimate tracking settings reset to defaults")
    end
end
```

### Check File Location

```lua
SLASH_COMMANDS["/btlwsavepath"] = function()
    local path = "Documents\\Elder Scrolls Online\\live\\SavedVariables\\Beltalowda.lua"
    d("Saved to: " .. path)
end
```

## SavedVariables File Format

The actual file is Lua code:

```lua
BeltalowdaVars =
{
    ["version"] = 1,
    ["profiles"] =
    {
        [1] =
        {
            ["name"] = "Default",
            ["ultimateTracking"] =
            {
                ["enabled"] = true,
                ["showClientUltimate"] = true,
                -- ... etc
            },
        },
    },
}
```

**Important**: This file is auto-generated. Don't edit it manually (game must be closed to edit safely).

## Common Pitfalls

### 1. Forgetting Defaults

```lua
-- Without defaults, settings may be nil on first run
local vars = ZO_SavedVars:New("MyAddon", 1, nil, {})  -- BAD
local enabled = vars.enabled  -- nil!

-- Always provide defaults
local defaults = { enabled = true }
local vars = ZO_SavedVars:New("MyAddon", 1, nil, defaults)
local enabled = vars.enabled  -- true
```

### 2. Version Number Changes

```lua
-- Changing version number resets all settings!
local vars = ZO_SavedVars:New("MyAddon", 1, nil, defaults)  -- v1
-- Later...
local vars = ZO_SavedVars:New("MyAddon", 2, nil, defaults)  -- v2 - RESET!

-- Use migrations instead (see above)
```

### 3. Direct Table Assignment

```lua
-- This creates a reference, not a copy
local mySettings = profile.ultimateTracking
mySettings.enabled = false  -- Modifies SavedVariables immediately

-- To create a copy:
local mySettings = {}
for k, v in pairs(profile.ultimateTracking) do
    mySettings[k] = v
end
```

## Conclusion

SavedVariables are essential for persisting Beltalowda settings across sessions. Key points:

1. **Two Scopes**: Use account-wide for shared settings, per-character for character-specific
2. **Profile System**: Beltalowda uses profiles for flexibility
3. **Defaults**: Always provide default values
4. **Migrations**: Handle version upgrades gracefully
5. **Validation**: Validate settings on load
6. **Optimization**: Keep data compact and remove old data

**Best Practice**: Use the profile system and module-specific getter/setter functions rather than direct SavedVariables access.

**Next Steps**:
1. Define defaults for all new features
2. Add migration code for existing users
3. Implement validation for settings
4. Create debug commands for viewing/resetting settings
