-- Beltalowda Synergies Tracker
-- By @Kickimanjaro
-- Wrapper for SynergyOverview functionality
-- This module tracks synergy availability across the group

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.synergies = Beltalowda.features.synergies or {}

-- Create local aliases (performance)
local BeltalowdaSynergies = Beltalowda.features.synergies
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaToolbox = Beltalowda.toolbox
BeltalowdaToolbox.so = BeltalowdaToolbox.so or {}
local BeltalowdaSO = BeltalowdaToolbox.so
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

-- Core functions still delegated to SynergyOverview
function BeltalowdaSynergies.Initialize()
	-- Delegate to original implementation
	if BeltalowdaSO.Initialize then
		BeltalowdaSO.Initialize()
	end
end

function BeltalowdaSynergies.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaSO.GetDefaults then
		return BeltalowdaSO.GetDefaults()
	end
	return {}
end

-- Phase 2: Menu functions moved here
function BeltalowdaSynergies.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.SO_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = "Tracks and displays available synergies from your group members in real-time. Shows which synergies are currently active and ready to be triggered (like Orbs, Shards, Blood Altar, etc.). Helps you quickly identify synergy opportunities during combat, especially useful for players in synergy-focused roles who need to maintain high resource generation or healing through synergy activation.",
					width = "full",
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_ENABLED,
					getFunc = BeltalowdaSynergies.GetSoEnabled,
					setFunc = BeltalowdaSynergies.SetSoEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_WINDOW_ENABLED,
					getFunc = BeltalowdaSynergies.GetSoWindowEnabled,
					setFunc = BeltalowdaSynergies.SetSoWindowEnabled
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_PVP_ONLY,
					getFunc = BeltalowdaSynergies.GetSoPvpOnly,
					setFunc = BeltalowdaSynergies.SetSoPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_POSITION_FIXED,
					getFunc = BeltalowdaSynergies.GetSoPositionLocked,
					setFunc = BeltalowdaSynergies.SetSoPositionLocked
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_TABLE_MODE,
					choices = BeltalowdaSynergies.GetSoTableModes(),
					getFunc = BeltalowdaSynergies.GetSoTableMode,
					setFunc = BeltalowdaSynergies.SetSoTableMode
				},
				[6] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_DISPLAY_MODE,
					choices = BeltalowdaSynergies.GetSoDisplayModes(),
					getFunc = BeltalowdaSynergies.GetSoDisplayMode,
					setFunc = BeltalowdaSynergies.SetSoDisplayMode
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SO_REDUCED_SPACING,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSynergies.GetSoReducedSpacing,
					setFunc = BeltalowdaSynergies.SetSoReducedSpacing,
					width = "full",
					decimals = 0,
					default = 0
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SO_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaSynergies.GetSoSize,
					setFunc = BeltalowdaSynergies.SetSoSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP,
					getFunc = BeltalowdaSynergies.GetSoSynergyBackdropColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyBackdropColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS,
					getFunc = BeltalowdaSynergies.GetSoSynergyProgressColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY,
					getFunc = BeltalowdaSynergies.GetSoSynergyColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_BACKGROUND,
					getFunc = BeltalowdaSynergies.GetSoBackgroundColor,
					setFunc = BeltalowdaSynergies.SetSoBackgroundColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_TEXT,
					getFunc = BeltalowdaSynergies.GetSoTextColor,
					setFunc = BeltalowdaSynergies.SetSoTextColor,
					width = "full"
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(1) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(1, value) end
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TALONS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(2) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(2, value) end
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_NOVA,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(3) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(3, value) end
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(4) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(4, value) end
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_STANDARD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(5) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(5, value) end
				},
				[19] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURGE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(6) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(6, value) end
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(7) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(7, value) end
				},
				[21] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(8) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(8, value) end
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(9) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(9, value) end
				},
				[23] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(10) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(10, value) end
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RADIATE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(11) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(11, value) end
				},
				[25] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(12) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(12, value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(13) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(13, value) end
				},
				[27] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(14) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(14, value) end
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(15) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(15, value) end
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(16) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(16, value) end
				},
				[30] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(17) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(17, value) end
				},
				[31] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(18) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(18, value) end
				},
				[32] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(19) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(19, value) end
				},
				[33] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_URSUS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(20) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(20, value) end
				},
				[34] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(21) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(21, value) end
				},
				[35] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(22) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(22, value) end
				},
				[36] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(23) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(23, value) end
				}
			}
		}
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaSynergies.GetSoEnabled()
	return BeltalowdaSO.soVars.enabled
end

function BeltalowdaSynergies.SetSoEnabled(value)
	BeltalowdaSO.soVars.enabled = value
	BeltalowdaSO.SetEnabled(value, BeltalowdaSO.soVars.windowEnabled)
	BeltalowdaSO.AdjustSynergyDisplay()
	if BeltalowdaSO.SetControlVisibility then
		BeltalowdaSO.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoWindowEnabled()
	return BeltalowdaSO.soVars.windowEnabled
end

function BeltalowdaSynergies.SetSoWindowEnabled(value)
	BeltalowdaSO.soVars.windowEnabled = value
	BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, value)
	BeltalowdaSO.AdjustSynergyDisplay()
	if BeltalowdaSO.SetControlVisibility then
		BeltalowdaSO.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoPositionLocked()
	return BeltalowdaSO.soVars.positionLocked
end

function BeltalowdaSynergies.SetSoPositionLocked(value)
	BeltalowdaSO.SetPositionLocked(value)
end

function BeltalowdaSynergies.GetSoPvpOnly()
	return BeltalowdaSO.soVars.pvpOnly
end

function BeltalowdaSynergies.SetSoPvpOnly(value)
	BeltalowdaSO.soVars.pvpOnly = value
	BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, BeltalowdaSO.soVars.windowEnabled)
	BeltalowdaSO.SetControlVisibility()
end

function BeltalowdaSynergies.GetSoSynergyBackdropColor()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSO.soVars.synergyBackdropColor)
end

function BeltalowdaSynergies.SetSoSynergyBackdropColor(r, g, b, a)
	BeltalowdaSO.soVars.synergyBackdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoSynergyProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.progressColor)
end

function BeltalowdaSynergies.SetSoSynergyProgressColor(r, g, b)
	BeltalowdaSO.soVars.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoTableModes()
	return BeltalowdaSO.constants.TABLE_MODES
end

function BeltalowdaSynergies.GetSoTableMode()
	return BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.soVars.tableMode]
end

function BeltalowdaSynergies.SetSoTableMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSO.constants.TABLE_MODES do
			if BeltalowdaSO.constants.TABLE_MODES[i] == value then
				BeltalowdaSO.soVars.tableMode = i
			end
		end
		BeltalowdaSO.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoDisplayModes()
	return BeltalowdaSO.constants.DISPLAY_MODES
end

function BeltalowdaSynergies.GetSoDisplayMode()
	return BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.soVars.displayMode]
end

function BeltalowdaSynergies.SetSoDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSO.constants.DISPLAY_MODES do
			if BeltalowdaSO.constants.DISPLAY_MODES[i] == value then
				BeltalowdaSO.soVars.displayMode = i
			end
		end
	end
end

function BeltalowdaSynergies.GetSoReducedSpacing()
	return BeltalowdaSO.soVars.spacing
end

function BeltalowdaSynergies.SetSoReducedSpacing(value)
	BeltalowdaSO.soVars.spacing = value
	BeltalowdaSO.AdjustSize()
end

function BeltalowdaSynergies.GetSoSize()
	return BeltalowdaSO.soVars.size
end

function BeltalowdaSynergies.SetSoSize(value)
	if value ~= nil and value >= BeltalowdaSO.constants.size.SMALL and value <= BeltalowdaSO.constants.size.BIG then
		BeltalowdaSO.soVars.size = value
		BeltalowdaSO.AdjustSize()
	end
end

function BeltalowdaSynergies.GetSoSynergyColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.synergyColor)
end

function BeltalowdaSynergies.SetSoSynergyColor(r, g, b)
	BeltalowdaSO.soVars.synergyColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSynergies.GetSoBackgroundColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.backgroundColor)
end

function BeltalowdaSynergies.SetSoBackgroundColor(r, g, b)
	BeltalowdaSO.soVars.backgroundColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSynergies.GetSoTextColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.textColor)
end

function BeltalowdaSynergies.SetSoTextColor(r, g, b)
	BeltalowdaSO.soVars.textColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoSynergyEnabled(index)
	return BeltalowdaSO.soVars.synergyVisibility[index]
end

function BeltalowdaSynergies.SetSoSynergyEnabled(index, value)
	BeltalowdaSO.soVars.synergyVisibility[index] = value
	BeltalowdaSO.AdjustSynergyDisplay()
end

-- Note: Phase 2 - Menu functions now in wrapper, core logic still in SynergyOverview.
