-- Beltalowda Attack Timers
-- By @Kickimanjaro
-- Wrapper for DetonationTracker functionality
-- This module tracks Detonation and Shalk (Subterranean Assault/Deep Fissure) timers

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.attackTimers = Beltalowda.features.attackTimers or {}

-- Create local aliases (performance)
local BeltalowdaAttackTimers = Beltalowda.features.attackTimers
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.dt = BeltalowdaGroup.dt or {}
local BeltalowdaDT = BeltalowdaGroup.dt
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

-- Core functions still delegated to DetonationTracker
function BeltalowdaAttackTimers.Initialize()
	-- Delegate to original implementation
	if BeltalowdaDT.Initialize then
		BeltalowdaDT.Initialize()
	end
end

function BeltalowdaAttackTimers.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaDT.GetDefaults then
		return BeltalowdaDT.GetDefaults()
	end
	return {}
end

-- Phase 2: Menu functions moved here
function BeltalowdaAttackTimers.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.DT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_ENABLED,
					getFunc = BeltalowdaAttackTimers.GetDtEnabled,
					setFunc = BeltalowdaAttackTimers.SetDtEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_POSITION_FIXED,
					getFunc = BeltalowdaAttackTimers.GetDtPositionLocked,
					setFunc = BeltalowdaAttackTimers.SetDtPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_PVP_ONLY,
					getFunc = BeltalowdaAttackTimers.GetDtPvpOnly,
					setFunc = BeltalowdaAttackTimers.SetDtPvpOnly
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.DT_MODE,
					choices = BeltalowdaAttackTimers.GetDtAvailableModes(),
					getFunc = BeltalowdaAttackTimers.GetDtSelectedMode,
					setFunc = BeltalowdaAttackTimers.SetDtSelectedMode,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.DT_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaAttackTimers.GetDtSelectedSize,
					setFunc = BeltalowdaAttackTimers.SetDtSelectedSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION,
					getFunc = BeltalowdaAttackTimers.GetDtSmoothTransition,
					setFunc = BeltalowdaAttackTimers.SetDtSmoothTransition
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION,
					getFunc = BeltalowdaAttackTimers.GetDtDetonationFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDetonationFontColor,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION,
					getFunc = BeltalowdaAttackTimers.GetDtDetonationProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDetonationProgressColor,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssaultFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssaultFontColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssaultProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssaultProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssault2FontColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssault2FontColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2,
					getFunc = BeltalowdaAttackTimers.GetDtSubterraneanAssault2ProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtSubterraneanAssault2ProgressColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissureFontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissureFontColor,
					width = "full"
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissureProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissureProgressColor,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissure2FontColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissure2FontColor,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2,
					getFunc = BeltalowdaAttackTimers.GetDtDeepFissure2ProgressColor,
					setFunc = BeltalowdaAttackTimers.SetDtDeepFissure2ProgressColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaAttackTimers.GetDtEnabled()
	return BeltalowdaDT.dtVars.enabled
end

function BeltalowdaAttackTimers.SetDtEnabled(value)
	-- Update saved variable directly (menu needs immediate update)
	BeltalowdaDT.dtVars.enabled = value
	-- Call core function for event handling
	BeltalowdaDT.SetEnabled(value)
	-- Ensure visibility updates immediately
	if BeltalowdaDT.SetControlVisibility then
		BeltalowdaDT.SetControlVisibility()
	end
end

function BeltalowdaAttackTimers.GetDtPositionLocked()
	return BeltalowdaDT.dtVars.positionLocked
end

function BeltalowdaAttackTimers.SetDtPositionLocked(value)
	BeltalowdaDT.SetPositionLocked(value)
end

function BeltalowdaAttackTimers.GetDtPvpOnly()
	return BeltalowdaDT.dtVars.pvpOnly
end

function BeltalowdaAttackTimers.SetDtPvpOnly(value)
	BeltalowdaDT.dtVars.pvpOnly = value
	BeltalowdaDT.SetEnabled(BeltalowdaDT.dtVars.enabled)
end

function BeltalowdaAttackTimers.GetDtAvailableModes()
	return BeltalowdaDT.constants.modes
end

function BeltalowdaAttackTimers.GetDtSelectedMode()
	return BeltalowdaDT.constants.modes[BeltalowdaDT.dtVars.mode]
end

function BeltalowdaAttackTimers.SetDtSelectedMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaDT.constants.modes do
			if BeltalowdaDT.constants.modes[i] == value then
				BeltalowdaDT.dtVars.mode = i
				BeltalowdaDT.AdjustMode()
			end
		end
	end
end

function BeltalowdaAttackTimers.GetDtSelectedSize()
	return BeltalowdaDT.dtVars.size
end

function BeltalowdaAttackTimers.SetDtSelectedSize(value)
	if value ~= nil and value >= BeltalowdaDT.constants.size.SMALL and value <= BeltalowdaDT.constants.size.BIG then
		BeltalowdaDT.dtVars.size = value
		BeltalowdaDT.AdjustSize()
	end
end

function BeltalowdaAttackTimers.GetDtSmoothTransition()
	return BeltalowdaDT.dtVars.smoothTransition
end

function BeltalowdaAttackTimers.SetDtSmoothTransition(value)
	BeltalowdaDT.dtVars.smoothTransition = value
end

function BeltalowdaAttackTimers.GetDtDetonationFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.detonation.fontColor)
end

function BeltalowdaAttackTimers.SetDtDetonationFontColor(r, g, b)
	BeltalowdaDT.dtVars.detonation.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDetonationProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.detonation.progressColor)
end

function BeltalowdaAttackTimers.SetDtDetonationProgressColor(r, g, b)
	BeltalowdaDT.dtVars.detonation.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssaultFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.subterraneanAssault.fontColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssaultFontColor(r, g, b)
	BeltalowdaDT.dtVars.subterraneanAssault.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssaultProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.subterraneanAssault.progressColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssaultProgressColor(r, g, b)
	BeltalowdaDT.dtVars.subterraneanAssault.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssault2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.subterraneanAssault2.fontColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssault2FontColor(r, g, b)
	BeltalowdaDT.dtVars.subterraneanAssault2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtSubterraneanAssault2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.subterraneanAssault2.progressColor)
end

function BeltalowdaAttackTimers.SetDtSubterraneanAssault2ProgressColor(r, g, b)
	BeltalowdaDT.dtVars.subterraneanAssault2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissureFontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.deepFissure.fontColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissureFontColor(r, g, b)
	BeltalowdaDT.dtVars.deepFissure.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissureProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.deepFissure.progressColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissureProgressColor(r, g, b)
	BeltalowdaDT.dtVars.deepFissure.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissure2FontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.deepFissure2.fontColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissure2FontColor(r, g, b)
	BeltalowdaDT.dtVars.deepFissure2.fontColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

function BeltalowdaAttackTimers.GetDtDeepFissure2ProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaDT.dtVars.deepFissure2.progressColor)
end

function BeltalowdaAttackTimers.SetDtDeepFissure2ProgressColor(r, g, b)
	BeltalowdaDT.dtVars.deepFissure2.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaDT.AdjustColors()
end

-- Note: Phase 2 - Menu functions now in wrapper, core logic still in DetonationTracker.
