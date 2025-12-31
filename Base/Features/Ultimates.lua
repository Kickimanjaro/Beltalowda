-- Beltalowda Ultimates Tracker
-- By @Kickimanjaro
-- Wrapper for ResourceOverview functionality focused on Ultimate tracking
-- This module tracks group members' ultimate abilities and resources (stamina/magicka)

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.ultimates = Beltalowda.features.ultimates or {}
Beltalowda.menu = Beltalowda.menu or {}

-- Create local aliases (performance)
local BeltalowdaUltimates = Beltalowda.features.ultimates
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.ro = BeltalowdaGroup.ro or {}
local BeltalowdaRO = BeltalowdaGroup.ro
local BeltalowdaOverview = BeltalowdaGroup.ro  -- Alias for original namespace

-- Phase 2: Menu functions moved to wrapper, still delegate to original implementation

function BeltalowdaUltimates.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RO_HEADER_ULTIMATES,
			controls = {
				[1] = {
					type = "description",
					text = "Displays all group members' ultimate abilities in a single, combined view. Shows each player's ultimate percentage, readiness status, and resource levels (stamina/magicka). Perfect for raid leaders who want a quick overview of the entire group's ultimate availability at a glance. The compact display makes it easy to coordinate ultimate usage during combat.",
					width = "full",
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ENABLED,
					getFunc = BeltalowdaOverview.GetRoEnabled,
					setFunc = BeltalowdaOverview.SetRoEnabled,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_POSITION_FIXED,
					getFunc = BeltalowdaOverview.GetRoPositionLocked,
					setFunc = BeltalowdaOverview.SetRoPositionLocked,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_PVP_ONLY,
					getFunc = BeltalowdaOverview.GetRoPvpOnly,
					setFunc = BeltalowdaOverview.SetRoPvpOnly,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED,
					getFunc = BeltalowdaOverview.GetRoUltimateOverviewEnabled,
					setFunc = BeltalowdaOverview.SetRoUltimateOverviewEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED,
					getFunc = BeltalowdaOverview.GetRoClientUltimateEnabled,
					setFunc = BeltalowdaOverview.SetRoClientUltimateEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroupUltimatesEnabled,
					setFunc = BeltalowdaOverview.SetRoGroupUltimatesEnabled
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES,
					getFunc = BeltalowdaOverview.GetRoShowSoftResources,
					setFunc = BeltalowdaOverview.SetRoShowSoftResources
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroupUltimatesGroupsEnabled,
					setFunc = BeltalowdaOverview.SetRoGroupUltimatesGroupsEnabled
				},
				[10] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE,
					choices = BeltalowdaOverview.GetRoAvailableDisplayModes(),
					getFunc = BeltalowdaOverview.GetRoAvailableDisplayMode,
					setFunc = BeltalowdaOverview.SetRoAvailableDisplayMode,
					width = "full"
				},
				[11] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_SPACING,
					min = 0,
					max = 200,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoSpacing,
					setFunc = BeltalowdaOverview.SetRoSpacing,
					width = "full",
					decimals = 0,
					default = 0
				},
				[12] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaOverview.GetRoSize,
					setFunc = BeltalowdaOverview.SetRoSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[13] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_DISPLAYED_ULTIMATES,
					min = 1,
					max = 12,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoDisplayUltimates,
					setFunc = BeltalowdaOverview.SetRoDisplayUltimates,
					width = "full",
					default = 6
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_BACKGROUND,
					getFunc = BeltalowdaOverview.GetRoColorBackground,
					setFunc = BeltalowdaOverview.SetRoColorBackground,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_MAGICKA,
					getFunc = BeltalowdaOverview.GetRoColorMagicka,
					setFunc = BeltalowdaOverview.SetRoColorMagicka,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_STAMINA,
					getFunc = BeltalowdaOverview.GetRoColorStamina,
					setFunc = BeltalowdaOverview.SetRoColorStamina,
					width = "full"
				},
				[17] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE,
					getFunc = BeltalowdaOverview.GetRoColorOutOfRange,
					setFunc = BeltalowdaOverview.SetRoColorOutOfRange,
					width = "full"
				},
				[18] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_DEAD,
					getFunc = BeltalowdaOverview.GetRoColorDead,
					setFunc = BeltalowdaOverview.SetRoColorDead,
					width = "full"
				},
				[19] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoColorProgressNotFull,
					setFunc = BeltalowdaOverview.SetRoColorProgressNotFull,
					width = "full"
				},
				[20] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL,
					getFunc = BeltalowdaOverview.GetRoColorProgressFull,
					setFunc = BeltalowdaOverview.SetRoColorProgressFull,
					width = "full"
				},
				[21] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL,
					getFunc = BeltalowdaOverview.GetRoColorLabelFull,
					setFunc = BeltalowdaOverview.SetRoColorLabelFull,
					width = "full"
				},
				[22] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoColorLabelNotFull,
					setFunc = BeltalowdaOverview.SetRoColorLabelNotFull,
					width = "full"
				},
				[23] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP,
					getFunc = BeltalowdaOverview.GetRoColorLabelGroup,
					setFunc = BeltalowdaOverview.SetRoColorLabelGroup,
					width = "full"
				},
				[24] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT,
					getFunc = BeltalowdaOverview.GetRoColorLabelAnnouncement,
					setFunc = BeltalowdaOverview.SetRoColorLabelAnnouncement,
					width = "full"
				},
				[25] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ANNOUNCEMENT_SIZE,
					min = 32,
					max = 64,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoAnnouncementSize,
					setFunc = BeltalowdaOverview.SetRoAnnouncementSize,
					width = "full",
					default = 50
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED,
					getFunc = BeltalowdaOverview.GetRoInCombatEnabled,
					setFunc = BeltalowdaOverview.SetRoInCombatEnabled
				},
				[27] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR,
					getFunc = BeltalowdaOverview.GetRoInCombatColor,
					setFunc = BeltalowdaOverview.SetRoInCombatColor,
					width = "full"
				},
				[28] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR,
					getFunc = BeltalowdaOverview.GetRoOutOfCombatColor,
					setFunc = BeltalowdaOverview.SetRoOutOfCombatColor,
					width = "full"
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED,
					getFunc = BeltalowdaOverview.GetRoCombinedInStealthEnabled,
					setFunc = BeltalowdaOverview.SetRoCombinedInStealthEnabled
				},
				[30] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE,
					choices = BeltalowdaOverview.GetRoAvailableUltimateSortingModes(),
					getFunc = BeltalowdaOverview.GetRoSelectedUltimateSortingMode,
					setFunc = BeltalowdaOverview.SetRoSelectedUltimateSortingMode,
					width = "full"
				},
				[31] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_DESTRO,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeDestro,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeDestro,
					width = "full",
					default = 2
				},
				[32] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_STORM,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeStorm,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeStorm,
					width = "full",
					default = 1
				},
				[33] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NORTHERNSTORM,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeNorthernStorm,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeNorthernStorm,
					width = "full",
					default = 1
				},
				[34] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_PERMAFROST,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizePermafrost,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizePermafrost,
					width = "full",
					default = 1
				},
				[35] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeNegate,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeNegate,
					width = "full",
					default = 2
				},
				[36] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_OFFENSIVE,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeNegateOffensive,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeNegateOffensive,
					width = "full",
					default = 2
				},
				[37] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_COUNTER,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeNegateCounter,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeNegateCounter,
					width = "full",
					default = 2
				},
				[38] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NOVA,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoUltimateGroupSizeNova,
					setFunc = BeltalowdaOverview.SetRoUltimateGroupSizeNova,
					width = "full",
					default = 2
				},
				[39] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_MAX_DISTANCE,
					min = 1,
					max = 50,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoMaxDistance,
					setFunc = BeltalowdaOverview.SetRoMaxDistance,
					width = "full",
					default = 50
				},
				[40] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SOUND_ENABLED,
					getFunc = BeltalowdaOverview.GetRoSoundEnabled,
					setFunc = BeltalowdaOverview.SetRoSoundEnabled
				},
				[41] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_SELECTED_SOUND,
					choices = BeltalowdaOverview.GetRoAvailableSounds(),
					getFunc = BeltalowdaOverview.GetRoSelectedSound,
					setFunc = BeltalowdaOverview.SetRoSelectedSound,
					width = "full"
				},
			},
		}
	}
	
	return menu
end


function BeltalowdaUltimates.GetRoEnabled()
	return BeltalowdaOverview.roVars.enabled
end

function BeltalowdaUltimates.SetRoEnabled(value)
	BeltalowdaOverview.SetEnabled(value)
end

function BeltalowdaUltimates.GetRoPositionLocked()
	return BeltalowdaOverview.roVars.positionLocked
end

function BeltalowdaUltimates.SetRoPositionLocked(value)
	BeltalowdaOverview.SetPositionLocked(value)
end

function BeltalowdaUltimates.GetRoPvpOnly()
	return BeltalowdaOverview.roVars.pvpOnly
end

function BeltalowdaUltimates.SetRoPvpOnly(value)
	BeltalowdaOverview.roVars.pvpOnly = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaUltimates.GetRoUltimateOverviewEnabled()
	return BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled
end

function BeltalowdaUltimates.SetRoUltimateOverviewEnabled(value)
	BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaUltimates.GetRoClientUltimateEnabled()
	return BeltalowdaOverview.roVars.clientUltimateSettings.enabled
end

function BeltalowdaUltimates.SetRoClientUltimateEnabled(value)
	BeltalowdaOverview.roVars.clientUltimateSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaUltimates.GetRoGroupUltimatesEnabled()
	return BeltalowdaOverview.roVars.groupUltimatesSettings.enabled
end

function BeltalowdaUltimates.SetRoGroupUltimatesEnabled(value)
	BeltalowdaOverview.roVars.groupUltimatesSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaUltimates.GetRoShowSoftResources()
	return BeltalowdaOverview.roVars.showSoftResources
end

function BeltalowdaUltimates.SetRoShowSoftResources(value)
	BeltalowdaOverview.roVars.showSoftResources = value
	--BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaUltimates.GetRoGroupUltimatesGroupsEnabled()
	return BeltalowdaOverview.roVars.ultimates.enabled
end

function BeltalowdaUltimates.SetRoGroupUltimatesGroupsEnabled(value)
	BeltalowdaOverview.roVars.ultimates.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaUltimates.GetRoAvailableDisplayModes()
	return BeltalowdaOverview.config.displayModes
end

function BeltalowdaUltimates.GetRoAvailableDisplayMode()
	return BeltalowdaOverview.config.displayModes[BeltalowdaOverview.roVars.displayMode]
end

function BeltalowdaUltimates.SetRoAvailableDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaOverview.config.displayModes do
			if BeltalowdaOverview.config.displayModes[i] == value then
				BeltalowdaOverview.roVars.displayMode = i
			end
		end
		BeltalowdaOverview.AdjustDisplayMode()
	end
end

function BeltalowdaUltimates.GetRoDisplayUltimates()
	return BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates
end

function BeltalowdaUltimates.SetRoDisplayUltimates(value)
	BeltalowdaOverview.SetDisplayedUltimates(value)
end

function BeltalowdaUltimates.GetRoColorBackground()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.defaultBackground)
end

function BeltalowdaUltimates.SetRoColorBackground(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.defaultBackground = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorMagicka()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.magicka)
end

function BeltalowdaUltimates.SetRoColorMagicka(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.magicka = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.AdjustColors()
end
	
function BeltalowdaUltimates.GetRoColorStamina()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.stamina)
end

function BeltalowdaUltimates.SetRoColorStamina(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.stamina = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.AdjustColors()
end

function BeltalowdaUltimates.GetRoColorOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.outOfRange)
end

function BeltalowdaUltimates.SetRoColorOutOfRange(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorDead()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.dead)
end

function BeltalowdaUltimates.SetRoColorDead(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.dead = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorProgressNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.progressNotFull)
end

function BeltalowdaUltimates.SetRoColorProgressNotFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.progressNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorProgressFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.progressFull)
end

function BeltalowdaUltimates.SetRoColorProgressFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.progressFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelFull)
end

function BeltalowdaUltimates.SetRoColorLabelFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelNotFull)
end

function BeltalowdaUltimates.SetRoColorLabelNotFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelGroup()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelGroup)
end

function BeltalowdaUltimates.SetRoColorLabelGroup(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelGroup = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelAnnouncement()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.assignmentColor)
end

function BeltalowdaUltimates.SetRoColorLabelAnnouncement(r, g, b)
	BeltalowdaOverview.roVars.assignmentColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetColor(r, g, b, 1)
end

function BeltalowdaUltimates.GetRoAnnouncementSize()
	return BeltalowdaOverview.roVars.assignmentSize
end

function BeltalowdaUltimates.SetRoAnnouncementSize(value)
	BeltalowdaOverview.roVars.assignmentSize = value
	BeltalowdaOverview.AdjustAssignmentControlSize()
end

function BeltalowdaUltimates.GetRoInCombatEnabled()
	return BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled
end

function BeltalowdaUltimates.SetRoInCombatEnabled(value)
	BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled = value
	BeltalowdaOverview.AdjustInCombatSettings()
end

function BeltalowdaUltimates.GetRoInCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.borderInCombat)
end

function BeltalowdaUltimates.SetRoInCombatColor(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoOutOfCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat)
end

function BeltalowdaUltimates.SetRoOutOfCombatColor(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoCombinedInStealthEnabled()
	return BeltalowdaOverview.roVars.combinedInStealthEnabled
end

function BeltalowdaUltimates.SetRoCombinedInStealthEnabled(value)
	BeltalowdaOverview.roVars.combinedInStealthEnabled = value
end

function BeltalowdaUltimates.GetRoAvailableUltimateSortingModes()
	return BeltalowdaOverview.config.ultimateModes
end

function BeltalowdaUltimates.GetRoSelectedUltimateSortingMode()
	return BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.roVars.ultimates.sortingMode]
end

function BeltalowdaUltimates.SetRoSelectedUltimateSortingMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaOverview.config.ultimateModes do
			if BeltalowdaOverview.config.ultimateModes[i] == value then
				BeltalowdaOverview.roVars.ultimates.sortingMode = i
			end
		end
	end
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeDestro()
	return BeltalowdaOverview.roVars.ultimates.groupSizeDestro
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeDestro(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeDestro = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeStorm()
	return BeltalowdaOverview.roVars.ultimates.groupSizeStorm
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeStorm(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeStorm = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNorthernStorm()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNorthernStorm
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNorthernStorm(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNorthernStorm = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizePermafrost()
	return BeltalowdaOverview.roVars.ultimates.groupSizePermafrost
end

function BeltalowdaUltimates.SetRoUltimateGroupSizePermafrost(value)
	BeltalowdaOverview.roVars.ultimates.groupSizePermafrost = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegate()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegate
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegate(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegate = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegateOffensive()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegateOffensive
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegateOffensive(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegateOffensive = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegateCounter()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegateCounter
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegateCounter(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegateCounter = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNova()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNova
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNova(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNova = value
end

function BeltalowdaUltimates.GetRoMaxDistance()
	return BeltalowdaOverview.roVars.ultimates.maxDistance
end

function BeltalowdaUltimates.SetRoMaxDistance(value)
	BeltalowdaOverview.roVars.ultimates.maxDistance = value
end

function BeltalowdaUltimates.GetRoSoundEnabled()
	return BeltalowdaOverview.roVars.soundEnabled
end

function BeltalowdaUltimates.SetRoSoundEnabled(value)
	BeltalowdaOverview.roVars.soundEnabled = value
end

function BeltalowdaUltimates.GetRoAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaOverview.state.sounds do
		sounds[i] = BeltalowdaOverview.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaUltimates.GetRoSelectedSound()
	return BeltalowdaOverview.roVars.selectedSound
end

function BeltalowdaUltimates.SetRoSelectedSound(value)
	if value ~= nil then
		BeltalowdaOverview.roVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end

function BeltalowdaUltimates.GetRoGroupsEnabled()
	return BeltalowdaOverview.roVars.groups.enabled
end

function BeltalowdaUltimates.SetRoGroupsEnabled(value)
	BeltalowdaOverview.SetGroupsEnabled(value)
end

function BeltalowdaUltimates.GetRoGroups1Enabled()
	return BeltalowdaOverview.roVars.groups.group1.enabled
end

function BeltalowdaUltimates.SetRoGroups1Enabled(value)
	BeltalowdaOverview.roVars.groups.group1.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups1Name()
	return BeltalowdaOverview.roVars.groups.group1.name
end

function BeltalowdaUltimates.SetRoGroups1Name(value)
	BeltalowdaOverview.roVars.groups.group1.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups2Enabled()
	return BeltalowdaOverview.roVars.groups.group2.enabled
end

function BeltalowdaUltimates.SetRoGroups2Enabled(value)
	BeltalowdaOverview.roVars.groups.group2.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups2Name()
	return BeltalowdaOverview.roVars.groups.group2.name
end

function BeltalowdaUltimates.SetRoGroups2Name(value)
	BeltalowdaOverview.roVars.groups.group2.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups3Enabled()
	return BeltalowdaOverview.roVars.groups.group3.enabled
end

function BeltalowdaUltimates.SetRoGroups3Enabled(value)
	BeltalowdaOverview.roVars.groups.group3.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups3Name()
	return BeltalowdaOverview.roVars.groups.group3.name
end

function BeltalowdaUltimates.SetRoGroups3Name(value)
	BeltalowdaOverview.roVars.groups.group3.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups4Enabled()
	return BeltalowdaOverview.roVars.groups.group4.enabled
end

function BeltalowdaUltimates.SetRoGroups4Enabled(value)
	BeltalowdaOverview.roVars.groups.group4.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups4Name()
	return BeltalowdaOverview.roVars.groups.group4.name
end

function BeltalowdaUltimates.SetRoGroups4Name(value)
	BeltalowdaOverview.roVars.groups.group4.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups5Enabled()
	return BeltalowdaOverview.roVars.groups.group5.enabled
end

function BeltalowdaUltimates.SetRoGroups5Enabled(value)
	BeltalowdaOverview.roVars.groups.group5.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups5Name()
	return BeltalowdaOverview.roVars.groups.group5.name
end

function BeltalowdaUltimates.SetRoGroups5Name(value)
	BeltalowdaOverview.roVars.groups.group5.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoAvailableGroupsGroups()
	-- Delegate to internal function in ResourceOverview
	return BeltalowdaOverview.GetRoAvailableGroupsGroups()
end

function BeltalowdaUltimates.GetRoSelectedGroupsGroup(index)
	return BeltalowdaOverview.GetGroupNameFromIndex(BeltalowdaOverview.roVars.groups.ultimateGroups[index].group)
end

function BeltalowdaUltimates.SetRoSelectedGroupsGroup(index, value)
	if value ~= nil then
		value = BeltalowdaOverview.GetGroupIndexFromName(value)
		BeltalowdaOverview.roVars.groups.ultimateGroups[index].group = value
		BeltalowdaOverview.AdjustGroupsGroups()
	end
end

function BeltalowdaUltimates.GetRoGroupsGroupPriority(index)
	return BeltalowdaOverview.roVars.groups.ultimateGroups[index].priority
end

function BeltalowdaUltimates.SetRoGroupsGroupPriority(index, value)
	BeltalowdaOverview.roVars.groups.ultimateGroups[index].priority = value
	BeltalowdaOverview.AdjustGroupsGroups()
end


function BeltalowdaUltimates.GetRoGroupsAvailableModes()
	return BeltalowdaOverview.config.groupsModes
end

function BeltalowdaUltimates.GetRoGroupsAvailableMode()
	return BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.roVars.groups.mode]
end

function BeltalowdaUltimates.SetRoGroupsAvailableMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaOverview.config.groupsModes do
			if value == BeltalowdaOverview.config.groupsModes[i] then
				BeltalowdaOverview.roVars.groups.mode = i
				break
			end
		end
		BeltalowdaOverview.AdjustGroupsGroups()
	end
end

function BeltalowdaUltimates.GetRoGroupsShowSoftResources()
	return BeltalowdaOverview.roVars.groups.showSoftResources
end

function BeltalowdaUltimates.SetRoGroupsShowSoftResources(value)
	BeltalowdaOverview.roVars.groups.showSoftResources = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaUltimates.GetRoSplitInStealthEnabled()
	return BeltalowdaOverview.roVars.splitInStealthEnabled
end

function BeltalowdaUltimates.SetRoSplitInStealthEnabled(value)
	BeltalowdaOverview.roVars.splitInStealthEnabled = value
end

function BeltalowdaUltimates.GetRoGroupsColorBackground()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.backdropColor)
end

function BeltalowdaUltimates.SetRoGroupsColorBackground(r, g, b, a)
	BeltalowdaOverview.roVars.groups.backdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorMagicka()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.magicka)
end

function BeltalowdaUltimates.SetRoGroupsColorMagicka(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.magicka = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorStamina()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.stamina)
end

function BeltalowdaUltimates.SetRoGroupsColorStamina(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.stamina = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorOutOfRange()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.outOfRange)
end

function BeltalowdaUltimates.SetRoGroupsColorOutOfRange(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.outOfRange = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorDead()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.dead)
end

function BeltalowdaUltimates.SetRoGroupsColorDead(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.dead = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorProgressNotFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.progressNotFull)
end

function BeltalowdaUltimates.SetRoGroupsColorProgressNotFull(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.progressNotFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorProgressFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.progressFull)
end

function BeltalowdaUltimates.SetRoGroupsColorProgressFull(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.progressFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.labelFull)
end

function BeltalowdaUltimates.SetRoGroupsColorLabelFull(r, g ,b)
	BeltalowdaOverview.roVars.groups.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.labelNotFull)
end

function BeltalowdaUltimates.SetRoGroupsColorLabelNotFull(r, g ,b)
	BeltalowdaOverview.roVars.groups.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorEdgeOutOfCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.borderOutOfCombat)
end

function BeltalowdaUltimates.SetRoGroupsColorEdgeOutOfCombat(r, g ,b)
	BeltalowdaOverview.roVars.groups.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorEdgeInCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.borderInCombat)
end

function BeltalowdaUltimates.SetRoGroupsColorEdgeInCombat(r, g ,b)
	BeltalowdaOverview.roVars.groups.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsMaxDistance()
	return BeltalowdaOverview.roVars.groups.maxDistance
end

function BeltalowdaUltimates.SetRoGroupsMaxDistance(value)
	BeltalowdaOverview.roVars.groups.maxDistance = value
end

function BeltalowdaUltimates.GetRoSize()
	return BeltalowdaOverview.roVars.size
end

function BeltalowdaUltimates.SetRoSize(value)
	BeltalowdaOverview.roVars.size = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaUltimates.GetRoGroupsSize()
	return BeltalowdaOverview.roVars.groups.size
end

function BeltalowdaUltimates.SetRoGroupsSize(value)
	BeltalowdaOverview.roVars.groups.size = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaUltimates.GetRoSpacing()
	return BeltalowdaOverview.roVars.spacing
end

function BeltalowdaUltimates.SetRoSpacing(value)
	BeltalowdaOverview.roVars.spacing = value
	BeltalowdaOverview.AdjustSize()
end
