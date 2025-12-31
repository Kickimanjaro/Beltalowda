-- Beltalowda Positioning Assistance
-- By @Kickimanjaro
-- Wrapper for RapidTracker functionality
-- This module tracks Expedition buffs (Major/Minor) for speed coordination

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.positioning = Beltalowda.features.positioning or {}

-- Create local aliases (performance)
local BeltalowdaPositioning = Beltalowda.features.positioning
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.rt = BeltalowdaGroup.rt or {}
local BeltalowdaRT = BeltalowdaGroup.rt
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

-- Core functions still delegated to RapidTracker
function BeltalowdaPositioning.Initialize()
	-- Delegate to original implementation
	if BeltalowdaRT.Initialize then
		BeltalowdaRT.Initialize()
	end
end

function BeltalowdaPositioning.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaRT.GetDefaults then
		return BeltalowdaRT.GetDefaults()
	end
	return {}
end

-- Phase 2: Menu functions moved here
function BeltalowdaPositioning.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_ENABLED,
					getFunc = BeltalowdaPositioning.GetRtEnabled,
					setFunc = BeltalowdaPositioning.SetRtEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_PVP_ONLY,
					getFunc = BeltalowdaPositioning.GetRtPvpOnly,
					setFunc = BeltalowdaPositioning.SetRtPvpOnly,
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RT_POSITION_FIXED,
					getFunc = BeltalowdaPositioning.GetRtPositionLocked,
					setFunc = BeltalowdaPositioning.SetRtPositionLocked,
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_IN_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelInRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelInRange,
					width = "full"
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_NOT_IN_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelNotInRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelNotInRange,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_LABEL_OUT_OF_RANGE,
					getFunc = BeltalowdaPositioning.GetRtColorLabelOutOfRange,
					setFunc = BeltalowdaPositioning.SetRtColorLabelOutOfRange,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_RAPID_ON,
					getFunc = BeltalowdaPositioning.GetRtColorRapidOn,
					setFunc = BeltalowdaPositioning.SetRtColorRapidOn,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RT_COLOR_RAPID_OFF,
					getFunc = BeltalowdaPositioning.GetRtColorRapidOff,
					setFunc = BeltalowdaPositioning.SetRtColorRapidOff,
					width = "full"
				},
			}		
		},
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaPositioning.GetRtEnabled()
	if BeltalowdaRT.rtVars then
		return BeltalowdaRT.rtVars.enabled
	end
	return false
end

function BeltalowdaPositioning.SetRtEnabled(value)
	-- Update the saved variable directly (like other setters)
	if BeltalowdaRT.rtVars then
		BeltalowdaRT.rtVars.enabled = value
	end
	-- Also call the core SetEnabled to trigger event registration/unregistration
	if BeltalowdaRT.SetEnabled then
		BeltalowdaRT.SetEnabled(value)
	end
end

function BeltalowdaPositioning.GetRtPvpOnly()
	return BeltalowdaRT.rtVars.pvponly
end

function BeltalowdaPositioning.SetRtPvpOnly(value)
	BeltalowdaRT.rtVars.pvponly = value
end

function BeltalowdaPositioning.GetRtPositionLocked()
	return BeltalowdaRT.rtVars.positionLocked
end

function BeltalowdaPositioning.SetRtPositionLocked(value)
	BeltalowdaRT.SetMovable(not value)
end

function BeltalowdaPositioning.GetRtColorLabelInRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaRT.rtVars.colors.inRange)
end

function BeltalowdaPositioning.SetRtColorLabelInRange(r, g, b)
	BeltalowdaRT.rtVars.colors.inRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorLabelNotInRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaRT.rtVars.colors.notInRange)
end

function BeltalowdaPositioning.SetRtColorLabelNotInRange(r, g, b)
	BeltalowdaRT.rtVars.colors.notInRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorLabelOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaRT.rtVars.colors.outOfRange)
end

function BeltalowdaPositioning.SetRtColorLabelOutOfRange(r, g, b)
	BeltalowdaRT.rtVars.colors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaPositioning.GetRtColorRapidOn()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaRT.rtVars.colors.rapidOn)
end

function BeltalowdaPositioning.SetRtColorRapidOn(r, g, b)
	BeltalowdaRT.rtVars.colors.rapidOn = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaRT.AdjustColors()
end

function BeltalowdaPositioning.GetRtColorRapidOff()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaRT.rtVars.colors.rapidOff)
end

function BeltalowdaPositioning.SetRtColorRapidOff(r, g, b)
	BeltalowdaRT.rtVars.colors.rapidOff = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaRT.AdjustColors()
end

-- Note: Phase 2 - Menu functions now in wrapper, core logic still in RapidTracker.
