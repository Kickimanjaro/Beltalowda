-- Beltalowda Addon Detector
-- By @Kickimanjaro
-- Detects and manages integration with external addons

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

Beltalowda.addOnIntegration = Beltalowda.addOnIntegration or {}
Beltalowda.addOnIntegration.detector = Beltalowda.addOnIntegration.detector or {}

local BeltalowdaDetector = Beltalowda.addOnIntegration.detector
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaDetector.callbackName = Beltalowda.addonName .. "AddonDetector"

-- Addon type categories
BeltalowdaDetector.constants = {}
BeltalowdaDetector.constants.PREFIX = "AddonDetector"
BeltalowdaDetector.constants.ADDON_TYPE_CROWN = "crown"
BeltalowdaDetector.constants.ADDON_TYPE_COMPASS = "compass"
BeltalowdaDetector.constants.ADDON_TYPE_BOMB_TIMER = "bomb_timer"
BeltalowdaDetector.constants.ADDON_TYPE_BEAM = "beam"

-- User-friendly display names for addon types
BeltalowdaDetector.constants.ADDON_TYPE_NAMES = {
	["crown"] = "Crown/Leader Markers",
	["compass"] = "Compass Features",
	["bomb_timer"] = "Bomb/Detonation Timers",
	["beam"] = "3D Beams"
}

-- Integration modes
BeltalowdaDetector.constants.MODE_PREFER_EXTERNAL = 1 -- Use external addon if available
BeltalowdaDetector.constants.MODE_PREFER_INTERNAL = 2 -- Use built-in version even if external exists
BeltalowdaDetector.constants.MODE_DISABLE_IF_EXTERNAL = 3 -- Disable built-in if external detected
BeltalowdaDetector.constants.MODE_ALWAYS_USE_INTERNAL = 4 -- Always use built-in, ignore external

BeltalowdaDetector.constants.MODES = {
	[BeltalowdaDetector.constants.MODE_PREFER_EXTERNAL] = "Prefer External Addon",
	[BeltalowdaDetector.constants.MODE_PREFER_INTERNAL] = "Prefer Built-in",
	[BeltalowdaDetector.constants.MODE_DISABLE_IF_EXTERNAL] = "Disable if External Found",
	[BeltalowdaDetector.constants.MODE_ALWAYS_USE_INTERNAL] = "Always Use Built-in"
}

-- Registry of known addons by type
BeltalowdaDetector.registry = {}

-- Crown/Leader marker addons
BeltalowdaDetector.registry[BeltalowdaDetector.constants.ADDON_TYPE_CROWN] = {
	{
		name = "PapaCrown",
		globalVar = "QAddon",
		checkFunc = function() return QAddon ~= nil and QAddon.name == "PapaCrown" end,
		description = "PapaCrown - Custom crown marker addon"
	},
	{
		name = "CrownOfCyrodiil",
		globalVar = "CrownOfCyrodiil",
		checkFunc = function() return CrownOfCyrodiil ~= nil and CrownOfCyrodiil.name == "CrownOfCyrodiil" end,
		description = "Crown of Cyrodiil - Leader marker customization"
	},
	{
		name = "SanctsUltimateOrganiser",
		globalVar = "RO",
		checkFunc = function() return RO ~= nil and RO.name == "SanctsUltimateOrganiser" end,
		description = "Sanct's Ultimate Organiser - Group organization addon"
	}
}

-- Compass addons
BeltalowdaDetector.registry[BeltalowdaDetector.constants.ADDON_TYPE_COMPASS] = {
	{
		name = "LuiExtended",
		globalVar = "LUIE",
		checkFunc = function() return LUIE ~= nil and LUIE.compass ~= nil end,
		description = "LuiExtended - Comprehensive UI addon with compass"
	},
	{
		name = "Azurah",
		globalVar = "Azurah",
		checkFunc = function() return Azurah ~= nil end,
		description = "Azurah - UI customization including compass features"
	}
}

-- Bomb/Detonation timer addons
BeltalowdaDetector.registry[BeltalowdaDetector.constants.ADDON_TYPE_BOMB_TIMER] = {
	{
		name = "BombTimer",
		globalVar = "BombTimer",
		checkFunc = function() return BombTimer ~= nil end,
		description = "BombTimer - Detonation and ability timer tracking",
		settingsAccess = function() 
			-- Access BombTimer settings if available
			if BombTimer and BombTimer.savedVars then
				return BombTimer.savedVars
			end
			return nil
		end
	},
	{
		name = "RdKGroupTool",
		globalVar = "RdK",
		checkFunc = function() return RdK ~= nil and RdK.DetonationTracker ~= nil end,
		description = "RdK Group Tool - Includes detonation tracker"
	}
}

-- Beam addons
BeltalowdaDetector.registry[BeltalowdaDetector.constants.ADDON_TYPE_BEAM] = {
	{
		name = "GroupBeacons",
		globalVar = "GroupBeacons",
		checkFunc = function() return GroupBeacons ~= nil end,
		description = "Group Beacons - 3D beams for group members"
	}
}

-- Detection cache
BeltalowdaDetector.state = {}
BeltalowdaDetector.state.detectionCache = {}
BeltalowdaDetector.state.initialized = false

function BeltalowdaDetector.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaDetector.callbackName, BeltalowdaDetector.OnProfileChanged)
	BeltalowdaDetector.state.initialized = true
	
	-- Perform initial detection
	BeltalowdaDetector.DetectAllAddons()
end

function BeltalowdaDetector.GetDefaults()
	local defaults = {}
	defaults.crownMode = BeltalowdaDetector.constants.MODE_DISABLE_IF_EXTERNAL
	defaults.compassMode = BeltalowdaDetector.constants.MODE_PREFER_INTERNAL
	defaults.bombTimerMode = BeltalowdaDetector.constants.MODE_PREFER_EXTERNAL
	defaults.beamMode = BeltalowdaDetector.constants.MODE_PREFER_INTERNAL
	defaults.notifyOnDetection = true
	return defaults
end

-- Detect a specific addon by checking its global variable
function BeltalowdaDetector.DetectAddon(addonInfo)
	if addonInfo == nil or addonInfo.checkFunc == nil then
		return false
	end
	
	local success, result = pcall(addonInfo.checkFunc)
	return success and result == true
end

-- Detect all addons of a specific type
function BeltalowdaDetector.DetectAddonsByType(addonType)
	if BeltalowdaDetector.registry[addonType] == nil then
		return {}
	end
	
	local detected = {}
	for i, addonInfo in ipairs(BeltalowdaDetector.registry[addonType]) do
		if BeltalowdaDetector.DetectAddon(addonInfo) then
			table.insert(detected, addonInfo)
		end
	end
	
	return detected
end

-- Detect all registered addons and cache results
function BeltalowdaDetector.DetectAllAddons()
	BeltalowdaDetector.state.detectionCache = {}
	
	for addonType, addonList in pairs(BeltalowdaDetector.registry) do
		BeltalowdaDetector.state.detectionCache[addonType] = BeltalowdaDetector.DetectAddonsByType(addonType)
	end
	
	return BeltalowdaDetector.state.detectionCache
end

-- Check if any external addon of a type is detected
function BeltalowdaDetector.HasExternalAddon(addonType)
	if BeltalowdaDetector.state.detectionCache[addonType] == nil then
		BeltalowdaDetector.state.detectionCache[addonType] = BeltalowdaDetector.DetectAddonsByType(addonType)
	end
	
	return #BeltalowdaDetector.state.detectionCache[addonType] > 0
end

-- Get list of detected addons for a type
function BeltalowdaDetector.GetDetectedAddons(addonType)
	if BeltalowdaDetector.state.detectionCache[addonType] == nil then
		BeltalowdaDetector.state.detectionCache[addonType] = BeltalowdaDetector.DetectAddonsByType(addonType)
	end
	
	return BeltalowdaDetector.state.detectionCache[addonType]
end

-- Determine if built-in feature should be enabled based on mode and detection
function BeltalowdaDetector.ShouldEnableBuiltIn(addonType, userMode)
	local hasExternal = BeltalowdaDetector.HasExternalAddon(addonType)
	
	if userMode == BeltalowdaDetector.constants.MODE_ALWAYS_USE_INTERNAL then
		return true
	elseif userMode == BeltalowdaDetector.constants.MODE_DISABLE_IF_EXTERNAL then
		return not hasExternal
	elseif userMode == BeltalowdaDetector.constants.MODE_PREFER_EXTERNAL then
		return not hasExternal
	elseif userMode == BeltalowdaDetector.constants.MODE_PREFER_INTERNAL then
		return true
	end
	
	-- Default: prefer internal
	return true
end

-- Get external addon settings if available
function BeltalowdaDetector.GetExternalAddonSettings(addonType)
	local detected = BeltalowdaDetector.GetDetectedAddons(addonType)
	
	if #detected > 0 and detected[1].settingsAccess ~= nil then
		local success, settings = pcall(detected[1].settingsAccess)
		if success then
			return settings
		end
	end
	
	return nil
end

-- Get a human-readable list of detected addons for display
function BeltalowdaDetector.GetDetectedAddonNames(addonType)
	local detected = BeltalowdaDetector.GetDetectedAddons(addonType)
	local names = {}
	
	for i, addonInfo in ipairs(detected) do
		table.insert(names, addonInfo.name)
	end
	
	return names
end

-- Callbacks
function BeltalowdaDetector.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaDetector.detectorVars = currentProfile.addOnIntegration.detector
		
		-- Re-detect addons when profile changes
		BeltalowdaDetector.DetectAllAddons()
		
		-- Optionally notify user of detected addons
		if BeltalowdaDetector.detectorVars.notifyOnDetection then
			BeltalowdaDetector.NotifyDetectedAddons()
		end
	end
end

-- Notify user of detected addons
function BeltalowdaDetector.NotifyDetectedAddons()
	local hasDetected = false
	local messages = {}
	
	for addonType, detected in pairs(BeltalowdaDetector.state.detectionCache) do
		if #detected > 0 then
			hasDetected = true
			local names = table.concat(BeltalowdaDetector.GetDetectedAddonNames(addonType), ", ")
			local typeName = BeltalowdaDetector.constants.ADDON_TYPE_NAMES[addonType] or addonType
			table.insert(messages, string.format("%s: %s", typeName, names))
		end
	end
	
	if hasDetected then
		BeltalowdaChat.SendChatMessage("External addons detected:", BeltalowdaDetector.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL)
		for _, msg in ipairs(messages) do
			BeltalowdaChat.SendChatMessage("  - " .. msg, BeltalowdaDetector.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL)
		end
	end
end

-- Menu integration
function BeltalowdaDetector.GetMenu()
	local crownDetected = BeltalowdaDetector.GetDetectedAddonNames(BeltalowdaDetector.constants.ADDON_TYPE_CROWN)
	local compassDetected = BeltalowdaDetector.GetDetectedAddonNames(BeltalowdaDetector.constants.ADDON_TYPE_COMPASS)
	local bombTimerDetected = BeltalowdaDetector.GetDetectedAddonNames(BeltalowdaDetector.constants.ADDON_TYPE_BOMB_TIMER)
	local beamDetected = BeltalowdaDetector.GetDetectedAddonNames(BeltalowdaDetector.constants.ADDON_TYPE_BEAM)
	
	local crownText = #crownDetected > 0 and table.concat(crownDetected, ", ") or "None"
	local compassText = #compassDetected > 0 and table.concat(compassDetected, ", ") or "None"
	local bombTimerText = #bombTimerDetected > 0 and table.concat(bombTimerDetected, ", ") or "None"
	local beamText = #beamDetected > 0 and table.concat(beamDetected, ", ") or "None"
	
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.ADDON_DETECTOR_HEADER or "Addon Integration",
			controls = {
				[1] = {
					type = "description",
					text = BeltalowdaMenu.constants.ADDON_DETECTOR_DESC or "Configure how Beltalowda integrates with external addons. When external addons are detected, you can choose to use them or use Beltalowda's built-in features.",
					width = "full"
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_NOTIFY or "Notify on Detection",
					tooltip = "Display a message when external addons are detected",
					getFunc = function() return BeltalowdaDetector.detectorVars.notifyOnDetection end,
					setFunc = function(value) BeltalowdaDetector.detectorVars.notifyOnDetection = value end,
					width = "full"
				},
				[3] = {
					type = "divider",
					width = "full"
				},
				[4] = {
					type = "description",
					text = string.format("Crown Addons Detected: %s", crownText),
					width = "full"
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_CROWN_MODE or "Crown Feature Mode",
					tooltip = "Choose how to handle crown features when external crown addons are detected",
					choices = BeltalowdaDetector.constants.MODES,
					getFunc = function() return BeltalowdaDetector.constants.MODES[BeltalowdaDetector.detectorVars.crownMode] end,
					setFunc = function(value)
						for mode, text in pairs(BeltalowdaDetector.constants.MODES) do
							if text == value then
								BeltalowdaDetector.detectorVars.crownMode = mode
								break
							end
						end
					end,
					width = "full"
				},
				[6] = {
					type = "divider",
					width = "full"
				},
				[7] = {
					type = "description",
					text = string.format("Compass Addons Detected: %s", compassText),
					width = "full"
				},
				[8] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_COMPASS_MODE or "Compass Feature Mode",
					tooltip = "Choose how to handle compass features when external compass addons are detected",
					choices = BeltalowdaDetector.constants.MODES,
					getFunc = function() return BeltalowdaDetector.constants.MODES[BeltalowdaDetector.detectorVars.compassMode] end,
					setFunc = function(value)
						for mode, text in pairs(BeltalowdaDetector.constants.MODES) do
							if text == value then
								BeltalowdaDetector.detectorVars.compassMode = mode
								break
							end
						end
					end,
					width = "full"
				},
				[9] = {
					type = "divider",
					width = "full"
				},
				[10] = {
					type = "description",
					text = string.format("Bomb Timer Addons Detected: %s", bombTimerText),
					width = "full"
				},
				[11] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_BOMB_TIMER_MODE or "Bomb Timer Mode",
					tooltip = "Choose how to handle detonation/bomb timer features when external addons are detected",
					choices = BeltalowdaDetector.constants.MODES,
					getFunc = function() return BeltalowdaDetector.constants.MODES[BeltalowdaDetector.detectorVars.bombTimerMode] end,
					setFunc = function(value)
						for mode, text in pairs(BeltalowdaDetector.constants.MODES) do
							if text == value then
								BeltalowdaDetector.detectorVars.bombTimerMode = mode
								break
							end
						end
					end,
					width = "full"
				},
				[12] = {
					type = "divider",
					width = "full"
				},
				[13] = {
					type = "description",
					text = string.format("Beam Addons Detected: %s", beamText),
					width = "full"
				},
				[14] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_BEAM_MODE or "Beam Feature Mode",
					tooltip = "Choose how to handle beam features when external beam addons are detected",
					choices = BeltalowdaDetector.constants.MODES,
					getFunc = function() return BeltalowdaDetector.constants.MODES[BeltalowdaDetector.detectorVars.beamMode] end,
					setFunc = function(value)
						for mode, text in pairs(BeltalowdaDetector.constants.MODES) do
							if text == value then
								BeltalowdaDetector.detectorVars.beamMode = mode
								break
							end
						end
					end,
					width = "full"
				},
				[15] = {
					type = "button",
					name = BeltalowdaMenu.constants.ADDON_DETECTOR_RESCAN or "Rescan for Addons",
					tooltip = "Re-detect external addons and update the list",
					func = function()
						BeltalowdaDetector.DetectAllAddons()
						BeltalowdaDetector.NotifyDetectedAddons()
						-- Refresh the menu to show updated detection
						if BeltalowdaMenu and BeltalowdaMenu.OpenMenu then
							BeltalowdaMenu.OpenMenu()
						end
					end,
					width = "full"
				}
			}
		}
	}
	
	return menu
end
