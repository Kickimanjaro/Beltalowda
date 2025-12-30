# Addon Interoperability Guide

## Overview

Beltalowda includes a comprehensive addon detection and integration system that allows it to work harmoniously with other ESO addons. This system detects when external addons with similar functionality are installed and provides users with options for how to handle the overlap.

## How It Works

### Addon Detection

The Addon Detector (`Base/AddOnIntegration/AddonDetector.lua`) automatically scans for known external addons when Beltalowda loads. It categorizes addons into types:

- **Crown Addons**: Modify the group leader crown icon
- **Compass Addons**: Add compass/navigation features
- **Bomb Timer Addons**: Track detonation/ability timers
- **Beam Addons**: Add 3D beams for group members

### Integration Modes

For each addon type, users can choose one of four integration modes:

1. **Prefer External Addon**: Use the external addon if detected; fall back to built-in if not
2. **Prefer Built-in**: Always use Beltalowda's built-in features, even if external detected
3. **Disable if External Found**: Automatically disable built-in feature when external addon detected
4. **Always Use Built-in**: Ignore external addons and always use Beltalowda's features

### Default Behavior

By default, Beltalowda uses these settings:

- **Crown Features**: Disable if external found (prevents conflicts)
- **Compass Features**: Prefer built-in (users can still use both)
- **Bomb Timer Features**: Prefer external (respects existing BombTimer installations)
- **Beam Features**: Prefer built-in (users can still use both)

## Supported External Addons

### Crown/Leader Marker Addons

- **PapaCrown** - Custom crown marker addon
- **Crown of Cyrodiil** - Leader marker customization
- **Sanct's Ultimate Organiser** - Group organization addon

### Compass Addons

- **LuiExtended** - Comprehensive UI addon with compass
- **Azurah** - UI customization including compass features

### Bomb/Detonation Timer Addons

- **BombTimer** - Detonation and ability timer tracking
- **RdK Group Tool** - Includes detonation tracker

### Beam Addons

- **Group Beacons** - 3D beams for group members

## Configuration

### Via Settings Menu

1. Open Beltalowda settings: `/beltalowda menu`
2. Navigate to **AddOn Integration Settings** > **Addon Detection & Integration**
3. Configure mode for each addon type
4. Enable/disable notifications when external addons are detected

### Detecting New Addons

Click the **"Rescan for Addons"** button in the settings menu to re-detect external addons after installing or removing other addons.

## For Addon Developers

### Integrating Your Addon

If you're developing an addon with similar functionality, you can integrate with Beltalowda's detection system:

1. **Register Your Addon**: Add your addon to the registry in `AddonDetector.lua`
2. **Provide Settings Access**: Optionally implement a `settingsAccess` function to allow Beltalowda to read your addon's settings
3. **Test Detection**: Ensure your addon's global variables are properly exposed

### Example Registration

```lua
BeltalowdaDetector.registry[BeltalowdaDetector.constants.ADDON_TYPE_CROWN] = {
	{
		name = "YourAddonName",
		globalVar = "YourAddonGlobal",
		checkFunc = function() return YourAddonGlobal ~= nil and YourAddonGlobal.version ~= nil end,
		description = "Your Addon - Description",
		settingsAccess = function()
			if YourAddonGlobal and YourAddonGlobal.settings then
				return YourAddonGlobal.settings
			end
			return nil
		end
	}
}
```

### Best Practices

1. **Expose a unique global variable** for your addon (e.g., `MyAddon = {}`)
2. **Include version information** in your global for validation
3. **Document your settings structure** if you want other addons to read them
4. **Test with Beltalowda** to ensure proper detection and integration

## User Guide

### Problem Statement

As an addon user, you may want features from multiple addons. For example:

- You want Beltalowda's ultimate tracking **AND** custom crown markers from another addon
- You already use BombTimer and don't want duplicate timers
- You want to try Beltalowda's compass but keep your existing compass addon

### Solution Approach

Beltalowda's interoperability system lets you:

1. **Detect conflicts early**: Get notified when similar addons are detected
2. **Choose your preference**: Decide which addon handles which feature
3. **Avoid duplicates**: Prevent multiple addons from doing the same thing
4. **Use best of both**: Combine features from different addons safely

### Example Scenarios

#### Scenario 1: You Have BombTimer Installed

**What happens:**
- Beltalowda detects BombTimer on load
- By default, sets mode to "Prefer External"
- Beltalowda's detonation tracker remains disabled
- You use BombTimer's existing settings and display

**To change:**
- Go to settings and change Bomb Timer Mode to "Prefer Built-in"
- Beltalowda will use its built-in detonation tracker instead

#### Scenario 2: You Have PapaCrown Installed

**What happens:**
- Beltalowda detects PapaCrown on load
- By default, sets mode to "Disable if External Found"
- Beltalowda's crown customization is disabled
- PapaCrown handles all crown modifications

**To change:**
- Go to settings and change Crown Feature Mode to "Always Use Built-in"
- Beltalowda will override PapaCrown (may cause conflicts)

#### Scenario 3: You Want Both Compasses

**What happens:**
- Beltalowda detects LuiExtended compass
- By default, sets mode to "Prefer Built-in"
- Both compasses can be used simultaneously
- Each has its own toggle in settings

**To change:**
- Disable one compass manually in its respective settings
- Or change mode to "Disable if External Found" to auto-disable Beltalowda's

## Technical Implementation

### Detection Process

1. **On Addon Load**: `AddonDetector.Initialize()` is called
2. **Scan Registry**: All registered addons are checked via their `checkFunc`
3. **Cache Results**: Detection results are stored in `state.detectionCache`
4. **Apply Settings**: Each feature module checks `ShouldEnableBuiltIn()` before activating

### Feature Integration

Each feature module (Crown, Compass, etc.) now includes:

```lua
function Feature.ShouldEnableFeature()
	local detector = Beltalowda.addOnIntegration.detector
	if detector and detector.ShouldEnableBuiltIn then
		local mode = detector.detectorVars.featureMode
		return detector.ShouldEnableBuiltIn(addonType, mode)
	end
	-- Fallback to old behavior
	return true
end
```

### Settings Sharing (Future Enhancement)

While not yet implemented, the system is designed to support reading settings from external addons:

```lua
local externalSettings = BeltalowdaDetector.GetExternalAddonSettings(addonType)
if externalSettings then
	-- Use external addon's settings instead of built-in
	BeltalowdaFeature.ApplyExternalSettings(externalSettings)
end
```

## Future Enhancements

### Planned Features

1. **Settings Import**: Automatically import settings from detected addons
2. **Feature Forwarding**: Forward feature calls to external addons when preferred
3. **Unified UI**: Show combined settings from multiple addons in one menu
4. **Smart Defaults**: Learn user preferences based on installed addons
5. **Addon Recommendations**: Suggest compatible addons based on enabled features

### Community Contributions

We welcome contributions to expand the detection registry! If you know of addons that should be detected, please submit a pull request or issue on GitHub.

## Troubleshooting

### External Addon Not Detected

1. Verify the addon is loaded (check in ESO addon list)
2. Click "Rescan for Addons" in Beltalowda settings
3. Check if the addon exposes expected global variables
4. Report missing addons on GitHub for inclusion in registry

### Features Not Disabling

1. Check your integration mode settings
2. Some features may require UI reload to apply changes
3. Ensure you've saved settings after changing modes
4. Try "/reloadui" to force a full reload

### Both Addons Running Same Feature

1. This is expected if mode is set to "Prefer Built-in" or "Always Use Built-in"
2. Change mode to "Disable if External Found" to prevent duplication
3. Alternatively, disable the feature in one addon's settings manually

## Support

For issues, questions, or feature requests related to addon interoperability:

- GitHub: [Kickimanjaro/Beltalowda](https://github.com/Kickimanjaro/Beltalowda)
- ESOUI: [Beltalowda Addon Page](https://www.esoui.com/)

## Credits

The addon interoperability system was designed to address community feedback about feature overlap and the desire to use multiple addons together harmoniously.

Special thanks to the developers of:
- RdK Group Tool (original ultimate tracking inspiration)
- BombTimer (detonation tracking reference)
- All other addon developers in the ESO community
