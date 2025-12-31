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

-- ============================================================================
-- Constants and Configuration - MUST be initialized early before Lang files load
-- ============================================================================

BeltalowdaUltimates.constants = BeltalowdaUltimates.constants or {}
BeltalowdaUltimates.constants.TLW_CLIENT_ULTIMATE_NAME = "Beltalowda.group.ro.client_ultimate_TLW"
BeltalowdaUltimates.constants.TLW_GROUP_ULTIMATES_NAME = "Beltalowda.group.ro.group_ultimates_TLW"
BeltalowdaUltimates.constants.TLW_GROUP_ASSIGNMENT_NAME = "Beltalowda.group.ro.group_assignment_TLW"
BeltalowdaUltimates.constants.TLW_ULTIMATE_OVERVIEW_NAME = "Beltalowda.group.ro.ultimate_overview_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP = {}
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[1] = "Beltalowda.group.ro.groups_group_1_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[2] = "Beltalowda.group.ro.groups_group_2_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[3] = "Beltalowda.group.ro.groups_group_3_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[4] = "Beltalowda.group.ro.groups_group_4_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[5] = "Beltalowda.group.ro.groups_group_5_TLW"
BeltalowdaUltimates.constants.TLW_GROUPS_EMPTY = "Beltalowda.group.ro.groups_group_EMPTY"

BeltalowdaUltimates.constants.groupsModes = {}
BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_NAME = 1
BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_PERCENT = 2
BeltalowdaUltimates.constants.groupsModes.MODE_PERCENT = 3

BeltalowdaUltimates.constants.ultimateModes = {}
BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_READINESS = 1
BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_NAME = 2
BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_GROUP = 3

BeltalowdaUltimates.constants.displayModes = {}
BeltalowdaUltimates.constants.displayModes.CLASSIC = 1
BeltalowdaUltimates.constants.displayModes.SWIMLANES = 2

BeltalowdaUltimates.constants.OFFLINE_TRESHOLD = 30000

BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING = "%d/%d %s:"

BeltalowdaUltimates.constants.references = BeltalowdaUltimates.constants.references or {}
BeltalowdaUltimates.constants.references.GROUPS_DROPDOWN = "Beltalowda.group.ro.groups.assignment."

BeltalowdaUltimates.constants.size = {}
BeltalowdaUltimates.constants.size.SMALL = 1
BeltalowdaUltimates.constants.size.BIG = 2

-- Will be set by Lang files, initialize here to avoid nil errors
BeltalowdaUltimates.constants.BOOM = "BOOM"
BeltalowdaUltimates.constants.TOGGLE_BOOM = "Send BOOM"

BeltalowdaUltimates.callbackName = Beltalowda.addonName .. "ResourceOverview"
BeltalowdaUltimates.uiCallbackName = Beltalowda.addonName .. "ResourceOverviewUI"
BeltalowdaUltimates.groupsUiCallbackName = Beltalowda.addonName .. "ResourceOverviewGroupsUI"
BeltalowdaUltimates.networkingCallbackName = Beltalowda.addonName .. "ResourceOverviewNetworking"
BeltalowdaUltimates.messageCallbackName = Beltalowda.addonName .. "ResourceOverviewMessageUpdate"

BeltalowdaUltimates.config = BeltalowdaUltimates.config or {}
BeltalowdaUltimates.config.networkUpdateInterval = 500
BeltalowdaUltimates.config.messageUpdateInterval = 1000
BeltalowdaUltimates.config.uiUpdateInterval = 100
BeltalowdaUltimates.config.groupsUiUpdateInterval = 100
BeltalowdaUltimates.config.buffUpdateInterval = 100
BeltalowdaUltimates.config.clientUltimate = {}
BeltalowdaUltimates.config.clientUltimate.isClampedToScreen = true
BeltalowdaUltimates.config.groupUltimates = {}
BeltalowdaUltimates.config.groupUltimates.isClampedToScreen = true
BeltalowdaUltimates.config.ultimateModes = BeltalowdaUltimates.config.ultimateModes or {}

-- Initialize sizes configuration
BeltalowdaUltimates.config.sizes = {}
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL] = {}
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset = 12
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth = 50
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight = 50
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth = 50
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight = 25
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight = 5
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight = 5
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth = 10
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].fontSize = 13
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio = 1.0
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].border = 2
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG] = {}
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].offset = 12
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconWidth = 70
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight = 70
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth = 70
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockHeight = 35
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockStaminaHeight = 7
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockMagickaHeight = 7
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockGroupWidth = 15
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].fontSize = 18
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].spacingRatio = 1.3
BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].border = 3

-- Initialize swimLane sizes configuration  
BeltalowdaUltimates.config.swimLaneSizes = {}
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL] = {}
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].offset = 12
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth = 20
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight = 20
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth = 75
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight = 25
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight = 5
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight = 5
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth = 10
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizePlayer = 13
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizeHeader = 16
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio = 1.0
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG] = {}
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].offset = 12
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].ultiIconWidth = 40
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight = 40
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth = 150
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockHeight = 35
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockStaminaHeight = 7
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockMagickaHeight = 7
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockGroupWidth = 20
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].fontSizePlayer = 26
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].fontSizeHeader = 36
BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].spacingRatio = 2.0

-- ============================================================================
-- Phase 2: Menu functions moved to wrapper, still delegate to original implementation
-- ============================================================================

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
					getFunc = BeltalowdaUltimates.GetRoEnabled,
					setFunc = BeltalowdaUltimates.SetRoEnabled,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_POSITION_FIXED,
					getFunc = BeltalowdaUltimates.GetRoPositionLocked,
					setFunc = BeltalowdaUltimates.SetRoPositionLocked,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_PVP_ONLY,
					getFunc = BeltalowdaUltimates.GetRoPvpOnly,
					setFunc = BeltalowdaUltimates.SetRoPvpOnly,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoUltimateOverviewEnabled,
					setFunc = BeltalowdaUltimates.SetRoUltimateOverviewEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoClientUltimateEnabled,
					setFunc = BeltalowdaUltimates.SetRoClientUltimateEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoGroupUltimatesEnabled,
					setFunc = BeltalowdaUltimates.SetRoGroupUltimatesEnabled
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES,
					getFunc = BeltalowdaUltimates.GetRoShowSoftResources,
					setFunc = BeltalowdaUltimates.SetRoShowSoftResources
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoGroupUltimatesGroupsEnabled,
					setFunc = BeltalowdaUltimates.SetRoGroupUltimatesGroupsEnabled
				},
				[10] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE,
					choices = BeltalowdaUltimates.GetRoAvailableDisplayModes(),
					getFunc = BeltalowdaUltimates.GetRoAvailableDisplayMode,
					setFunc = BeltalowdaUltimates.SetRoAvailableDisplayMode,
					width = "full"
				},
				[11] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_SPACING,
					min = 0,
					max = 200,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoSpacing,
					setFunc = BeltalowdaUltimates.SetRoSpacing,
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
					getFunc = BeltalowdaUltimates.GetRoSize,
					setFunc = BeltalowdaUltimates.SetRoSize,
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
					getFunc = BeltalowdaUltimates.GetRoDisplayUltimates,
					setFunc = BeltalowdaUltimates.SetRoDisplayUltimates,
					width = "full",
					default = 6
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_BACKGROUND,
					getFunc = BeltalowdaUltimates.GetRoColorBackground,
					setFunc = BeltalowdaUltimates.SetRoColorBackground,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_MAGICKA,
					getFunc = BeltalowdaUltimates.GetRoColorMagicka,
					setFunc = BeltalowdaUltimates.SetRoColorMagicka,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_STAMINA,
					getFunc = BeltalowdaUltimates.GetRoColorStamina,
					setFunc = BeltalowdaUltimates.SetRoColorStamina,
					width = "full"
				},
				[17] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE,
					getFunc = BeltalowdaUltimates.GetRoColorOutOfRange,
					setFunc = BeltalowdaUltimates.SetRoColorOutOfRange,
					width = "full"
				},
				[18] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_DEAD,
					getFunc = BeltalowdaUltimates.GetRoColorDead,
					setFunc = BeltalowdaUltimates.SetRoColorDead,
					width = "full"
				},
				[19] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL,
					getFunc = BeltalowdaUltimates.GetRoColorProgressNotFull,
					setFunc = BeltalowdaUltimates.SetRoColorProgressNotFull,
					width = "full"
				},
				[20] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL,
					getFunc = BeltalowdaUltimates.GetRoColorProgressFull,
					setFunc = BeltalowdaUltimates.SetRoColorProgressFull,
					width = "full"
				},
				[21] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL,
					getFunc = BeltalowdaUltimates.GetRoColorLabelFull,
					setFunc = BeltalowdaUltimates.SetRoColorLabelFull,
					width = "full"
				},
				[22] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL,
					getFunc = BeltalowdaUltimates.GetRoColorLabelNotFull,
					setFunc = BeltalowdaUltimates.SetRoColorLabelNotFull,
					width = "full"
				},
				[23] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP,
					getFunc = BeltalowdaUltimates.GetRoColorLabelGroup,
					setFunc = BeltalowdaUltimates.SetRoColorLabelGroup,
					width = "full"
				},
				[24] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT,
					getFunc = BeltalowdaUltimates.GetRoColorLabelAnnouncement,
					setFunc = BeltalowdaUltimates.SetRoColorLabelAnnouncement,
					width = "full"
				},
				[25] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ANNOUNCEMENT_SIZE,
					min = 32,
					max = 64,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoAnnouncementSize,
					setFunc = BeltalowdaUltimates.SetRoAnnouncementSize,
					width = "full",
					default = 50
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoInCombatEnabled,
					setFunc = BeltalowdaUltimates.SetRoInCombatEnabled
				},
				[27] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR,
					getFunc = BeltalowdaUltimates.GetRoInCombatColor,
					setFunc = BeltalowdaUltimates.SetRoInCombatColor,
					width = "full"
				},
				[28] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR,
					getFunc = BeltalowdaUltimates.GetRoOutOfCombatColor,
					setFunc = BeltalowdaUltimates.SetRoOutOfCombatColor,
					width = "full"
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoCombinedInStealthEnabled,
					setFunc = BeltalowdaUltimates.SetRoCombinedInStealthEnabled
				},
				[30] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE,
					choices = BeltalowdaUltimates.GetRoAvailableUltimateSortingModes(),
					getFunc = BeltalowdaUltimates.GetRoSelectedUltimateSortingMode,
					setFunc = BeltalowdaUltimates.SetRoSelectedUltimateSortingMode,
					width = "full"
				},
				[31] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_DESTRO,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeDestro,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeDestro,
					width = "full",
					default = 2
				},
				[32] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_STORM,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeStorm,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeStorm,
					width = "full",
					default = 1
				},
				[33] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NORTHERNSTORM,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeNorthernStorm,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeNorthernStorm,
					width = "full",
					default = 1
				},
				[34] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_PERMAFROST,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizePermafrost,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizePermafrost,
					width = "full",
					default = 1
				},
				[35] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeNegate,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeNegate,
					width = "full",
					default = 2
				},
				[36] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_OFFENSIVE,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeNegateOffensive,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeNegateOffensive,
					width = "full",
					default = 2
				},
				[37] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_COUNTER,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeNegateCounter,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeNegateCounter,
					width = "full",
					default = 2
				},
				[38] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NOVA,
					min = 0,
					max = 24,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoUltimateGroupSizeNova,
					setFunc = BeltalowdaUltimates.SetRoUltimateGroupSizeNova,
					width = "full",
					default = 2
				},
				[39] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_MAX_DISTANCE,
					min = 1,
					max = 50,
					step = 1,
					getFunc = BeltalowdaUltimates.GetRoMaxDistance,
					setFunc = BeltalowdaUltimates.SetRoMaxDistance,
					width = "full",
					default = 50
				},
				[40] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SOUND_ENABLED,
					getFunc = BeltalowdaUltimates.GetRoSoundEnabled,
					setFunc = BeltalowdaUltimates.SetRoSoundEnabled
				},
				[41] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_SELECTED_SOUND,
					choices = BeltalowdaUltimates.GetRoAvailableSounds(),
					getFunc = BeltalowdaUltimates.GetRoSelectedSound,
					setFunc = BeltalowdaUltimates.SetRoSelectedSound,
					width = "full"
				},
			},
		}
	}
	
	return menu
end


function BeltalowdaUltimates.GetRoEnabled()
	return BeltalowdaGroup.ro.roVars.enabled
end

function BeltalowdaUltimates.SetRoEnabled(value)
	BeltalowdaUltimates.SetEnabled(value)
end

function BeltalowdaUltimates.GetRoPositionLocked()
	return BeltalowdaGroup.ro.roVars.positionLocked
end

function BeltalowdaUltimates.SetRoPositionLocked(value)
	BeltalowdaUltimates.SetPositionLocked(value)
end

function BeltalowdaUltimates.GetRoPvpOnly()
	return BeltalowdaGroup.ro.roVars.pvpOnly
end

function BeltalowdaUltimates.SetRoPvpOnly(value)
	BeltalowdaGroup.ro.roVars.pvpOnly = value
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
end

function BeltalowdaUltimates.GetRoUltimateOverviewEnabled()
	return BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled
end

function BeltalowdaUltimates.SetRoUltimateOverviewEnabled(value)
	BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled = value
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
end

function BeltalowdaUltimates.GetRoClientUltimateEnabled()
	return BeltalowdaGroup.ro.roVars.clientUltimateSettings.enabled
end

function BeltalowdaUltimates.SetRoClientUltimateEnabled(value)
	BeltalowdaGroup.ro.roVars.clientUltimateSettings.enabled = value
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
end

function BeltalowdaUltimates.GetRoGroupUltimatesEnabled()
	return BeltalowdaGroup.ro.roVars.groupUltimatesSettings.enabled
end

function BeltalowdaUltimates.SetRoGroupUltimatesEnabled(value)
	BeltalowdaGroup.ro.roVars.groupUltimatesSettings.enabled = value
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
end

function BeltalowdaUltimates.GetRoShowSoftResources()
	return BeltalowdaGroup.ro.roVars.showSoftResources
end

function BeltalowdaUltimates.SetRoShowSoftResources(value)
	BeltalowdaGroup.ro.roVars.showSoftResources = value
	--BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
	BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaUltimates.GetRoGroupUltimatesGroupsEnabled()
	return BeltalowdaGroup.ro.roVars.ultimates.enabled
end

function BeltalowdaUltimates.SetRoGroupUltimatesGroupsEnabled(value)
	BeltalowdaGroup.ro.roVars.ultimates.enabled = value
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
end

function BeltalowdaUltimates.GetRoAvailableDisplayModes()
	return BeltalowdaUltimates.config.displayModes
end

function BeltalowdaUltimates.GetRoAvailableDisplayMode()
	return BeltalowdaUltimates.config.displayModes[BeltalowdaGroup.ro.roVars.displayMode]
end

function BeltalowdaUltimates.SetRoAvailableDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaUltimates.config.displayModes do
			if BeltalowdaUltimates.config.displayModes[i] == value then
				BeltalowdaGroup.ro.roVars.displayMode = i
			end
		end
		BeltalowdaUltimates.AdjustDisplayMode()
	end
end

function BeltalowdaUltimates.GetRoDisplayUltimates()
	return BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates
end

function BeltalowdaUltimates.SetRoDisplayUltimates(value)
	BeltalowdaUltimates.SetDisplayedUltimates(value)
end

function BeltalowdaUltimates.GetRoColorBackground()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground)
end

function BeltalowdaUltimates.SetRoColorBackground(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorMagicka()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.magicka)
end

function BeltalowdaUltimates.SetRoColorMagicka(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.magicka = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaUltimates.AdjustColors()
end
	
function BeltalowdaUltimates.GetRoColorStamina()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.stamina)
end

function BeltalowdaUltimates.SetRoColorStamina(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.stamina = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaUltimates.AdjustColors()
end

function BeltalowdaUltimates.GetRoColorOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.outOfRange)
end

function BeltalowdaUltimates.SetRoColorOutOfRange(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorDead()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.dead)
end

function BeltalowdaUltimates.SetRoColorDead(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.dead = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorProgressNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.progressNotFull)
end

function BeltalowdaUltimates.SetRoColorProgressNotFull(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.progressNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorProgressFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.progressFull)
end

function BeltalowdaUltimates.SetRoColorProgressFull(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.progressFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelFull)
end

function BeltalowdaUltimates.SetRoColorLabelFull(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelNotFull)
end

function BeltalowdaUltimates.SetRoColorLabelNotFull(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelGroup()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelGroup)
end

function BeltalowdaUltimates.SetRoColorLabelGroup(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.labelGroup = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoColorLabelAnnouncement()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.assignmentColor)
end

function BeltalowdaUltimates.SetRoColorLabelAnnouncement(r, g, b)
	BeltalowdaGroup.ro.roVars.assignmentColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetColor(r, g, b, 1)
end

function BeltalowdaUltimates.GetRoAnnouncementSize()
	return BeltalowdaGroup.ro.roVars.assignmentSize
end

function BeltalowdaUltimates.SetRoAnnouncementSize(value)
	BeltalowdaGroup.ro.roVars.assignmentSize = value
	BeltalowdaUltimates.AdjustAssignmentControlSize()
end

function BeltalowdaUltimates.GetRoInCombatEnabled()
	return BeltalowdaGroup.ro.roVars.playerBlockColors.inCombatEnabled
end

function BeltalowdaUltimates.SetRoInCombatEnabled(value)
	BeltalowdaGroup.ro.roVars.playerBlockColors.inCombatEnabled = value
	BeltalowdaUltimates.AdjustInCombatSettings()
end

function BeltalowdaUltimates.GetRoInCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.borderInCombat)
end

function BeltalowdaUltimates.SetRoInCombatColor(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoOutOfCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat)
end

function BeltalowdaUltimates.SetRoOutOfCombatColor(r, g, b)
	BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoCombinedInStealthEnabled()
	return BeltalowdaGroup.ro.roVars.combinedInStealthEnabled
end

function BeltalowdaUltimates.SetRoCombinedInStealthEnabled(value)
	BeltalowdaGroup.ro.roVars.combinedInStealthEnabled = value
end

function BeltalowdaUltimates.GetRoAvailableUltimateSortingModes()
	return BeltalowdaUltimates.config.ultimateModes
end

function BeltalowdaUltimates.GetRoSelectedUltimateSortingMode()
	return BeltalowdaUltimates.config.ultimateModes[BeltalowdaGroup.ro.roVars.ultimates.sortingMode]
end

function BeltalowdaUltimates.SetRoSelectedUltimateSortingMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaUltimates.config.ultimateModes do
			if BeltalowdaUltimates.config.ultimateModes[i] == value then
				BeltalowdaGroup.ro.roVars.ultimates.sortingMode = i
			end
		end
	end
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeDestro()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeDestro
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeDestro(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeDestro = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeStorm()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeStorm
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeStorm(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeStorm = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNorthernStorm()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeNorthernStorm
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNorthernStorm(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeNorthernStorm = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizePermafrost()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizePermafrost
end

function BeltalowdaUltimates.SetRoUltimateGroupSizePermafrost(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizePermafrost = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegate()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegate
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegate(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegate = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegateOffensive()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateOffensive
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegateOffensive(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateOffensive = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNegateCounter()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateCounter
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNegateCounter(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateCounter = value
end

function BeltalowdaUltimates.GetRoUltimateGroupSizeNova()
	return BeltalowdaGroup.ro.roVars.ultimates.groupSizeNova
end

function BeltalowdaUltimates.SetRoUltimateGroupSizeNova(value)
	BeltalowdaGroup.ro.roVars.ultimates.groupSizeNova = value
end

function BeltalowdaUltimates.GetRoMaxDistance()
	return BeltalowdaGroup.ro.roVars.ultimates.maxDistance
end

function BeltalowdaUltimates.SetRoMaxDistance(value)
	BeltalowdaGroup.ro.roVars.ultimates.maxDistance = value
end

function BeltalowdaUltimates.GetRoSoundEnabled()
	return BeltalowdaGroup.ro.roVars.soundEnabled
end

function BeltalowdaUltimates.SetRoSoundEnabled(value)
	BeltalowdaGroup.ro.roVars.soundEnabled = value
end

function BeltalowdaUltimates.GetRoAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaUltimates.state.sounds do
		sounds[i] = BeltalowdaUltimates.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaUltimates.GetRoSelectedSound()
	return BeltalowdaGroup.ro.roVars.selectedSound
end

function BeltalowdaUltimates.SetRoSelectedSound(value)
	if value ~= nil then
		BeltalowdaGroup.ro.roVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end

function BeltalowdaUltimates.GetRoGroupsEnabled()
	return BeltalowdaGroup.ro.roVars.groups.enabled
end

function BeltalowdaUltimates.SetRoGroupsEnabled(value)
	BeltalowdaUltimates.SetGroupsEnabled(value)
end

function BeltalowdaUltimates.GetRoGroups1Enabled()
	return BeltalowdaGroup.ro.roVars.groups.group1.enabled
end

function BeltalowdaUltimates.SetRoGroups1Enabled(value)
	BeltalowdaGroup.ro.roVars.groups.group1.enabled = value
	BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups1Name()
	return BeltalowdaGroup.ro.roVars.groups.group1.name
end

function BeltalowdaUltimates.SetRoGroups1Name(value)
	BeltalowdaGroup.ro.roVars.groups.group1.name = value
	BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups2Enabled()
	return BeltalowdaGroup.ro.roVars.groups.group2.enabled
end

function BeltalowdaUltimates.SetRoGroups2Enabled(value)
	BeltalowdaGroup.ro.roVars.groups.group2.enabled = value
	BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups2Name()
	return BeltalowdaGroup.ro.roVars.groups.group2.name
end

function BeltalowdaUltimates.SetRoGroups2Name(value)
	BeltalowdaGroup.ro.roVars.groups.group2.name = value
	BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups3Enabled()
	return BeltalowdaGroup.ro.roVars.groups.group3.enabled
end

function BeltalowdaUltimates.SetRoGroups3Enabled(value)
	BeltalowdaGroup.ro.roVars.groups.group3.enabled = value
	BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups3Name()
	return BeltalowdaGroup.ro.roVars.groups.group3.name
end

function BeltalowdaUltimates.SetRoGroups3Name(value)
	BeltalowdaGroup.ro.roVars.groups.group3.name = value
	BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups4Enabled()
	return BeltalowdaGroup.ro.roVars.groups.group4.enabled
end

function BeltalowdaUltimates.SetRoGroups4Enabled(value)
	BeltalowdaGroup.ro.roVars.groups.group4.enabled = value
	BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups4Name()
	return BeltalowdaGroup.ro.roVars.groups.group4.name
end

function BeltalowdaUltimates.SetRoGroups4Name(value)
	BeltalowdaGroup.ro.roVars.groups.group4.name = value
	BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoGroups5Enabled()
	return BeltalowdaGroup.ro.roVars.groups.group5.enabled
end

function BeltalowdaUltimates.SetRoGroups5Enabled(value)
	BeltalowdaGroup.ro.roVars.groups.group5.enabled = value
	BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
end

function BeltalowdaUltimates.GetRoGroups5Name()
	return BeltalowdaGroup.ro.roVars.groups.group5.name
end

function BeltalowdaUltimates.SetRoGroups5Name(value)
	BeltalowdaGroup.ro.roVars.groups.group5.name = value
	BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaUltimates.GetRoAvailableGroupsGroups()
	-- Delegate to internal function in ResourceOverview
	return BeltalowdaUltimates.GetRoAvailableGroupsGroups()
end

function BeltalowdaUltimates.GetRoSelectedGroupsGroup(index)
	return BeltalowdaUltimates.GetGroupNameFromIndex(BeltalowdaGroup.ro.roVars.groups.ultimateGroups[index].group)
end

function BeltalowdaUltimates.SetRoSelectedGroupsGroup(index, value)
	if value ~= nil then
		value = BeltalowdaUltimates.GetGroupIndexFromName(value)
		BeltalowdaGroup.ro.roVars.groups.ultimateGroups[index].group = value
		BeltalowdaUltimates.AdjustGroupsGroups()
	end
end

function BeltalowdaUltimates.GetRoGroupsGroupPriority(index)
	return BeltalowdaGroup.ro.roVars.groups.ultimateGroups[index].priority
end

function BeltalowdaUltimates.SetRoGroupsGroupPriority(index, value)
	BeltalowdaGroup.ro.roVars.groups.ultimateGroups[index].priority = value
	BeltalowdaUltimates.AdjustGroupsGroups()
end


function BeltalowdaUltimates.GetRoGroupsAvailableModes()
	return BeltalowdaUltimates.config.groupsModes
end

function BeltalowdaUltimates.GetRoGroupsAvailableMode()
	return BeltalowdaUltimates.config.groupsModes[BeltalowdaGroup.ro.roVars.groups.mode]
end

function BeltalowdaUltimates.SetRoGroupsAvailableMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaUltimates.config.groupsModes do
			if value == BeltalowdaUltimates.config.groupsModes[i] then
				BeltalowdaGroup.ro.roVars.groups.mode = i
				break
			end
		end
		BeltalowdaUltimates.AdjustGroupsGroups()
	end
end

function BeltalowdaUltimates.GetRoGroupsShowSoftResources()
	return BeltalowdaGroup.ro.roVars.groups.showSoftResources
end

function BeltalowdaUltimates.SetRoGroupsShowSoftResources(value)
	BeltalowdaGroup.ro.roVars.groups.showSoftResources = value
	BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaUltimates.GetRoSplitInStealthEnabled()
	return BeltalowdaGroup.ro.roVars.splitInStealthEnabled
end

function BeltalowdaUltimates.SetRoSplitInStealthEnabled(value)
	BeltalowdaGroup.ro.roVars.splitInStealthEnabled = value
end

function BeltalowdaUltimates.GetRoGroupsColorBackground()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.backdropColor)
end

function BeltalowdaUltimates.SetRoGroupsColorBackground(r, g, b, a)
	BeltalowdaGroup.ro.roVars.groups.backdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaUltimates.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorMagicka()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.magicka)
end

function BeltalowdaUltimates.SetRoGroupsColorMagicka(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.magicka = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaUltimates.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorStamina()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.stamina)
end

function BeltalowdaUltimates.SetRoGroupsColorStamina(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.stamina = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaUltimates.AdjustGroupsColor()
end

function BeltalowdaUltimates.GetRoGroupsColorOutOfRange()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.outOfRange)
end

function BeltalowdaUltimates.SetRoGroupsColorOutOfRange(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.outOfRange = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorDead()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.dead)
end

function BeltalowdaUltimates.SetRoGroupsColorDead(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.dead = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorProgressNotFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.progressNotFull)
end

function BeltalowdaUltimates.SetRoGroupsColorProgressNotFull(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.progressNotFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorProgressFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGroup.ro.roVars.groups.progressFull)
end

function BeltalowdaUltimates.SetRoGroupsColorProgressFull(r, g ,b, a)
	BeltalowdaGroup.ro.roVars.groups.progressFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaUltimates.GetRoGroupsColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.groups.labelFull)
end

function BeltalowdaUltimates.SetRoGroupsColorLabelFull(r, g ,b)
	BeltalowdaGroup.ro.roVars.groups.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.groups.labelNotFull)
end

function BeltalowdaUltimates.SetRoGroupsColorLabelNotFull(r, g ,b)
	BeltalowdaGroup.ro.roVars.groups.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorEdgeOutOfCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat)
end

function BeltalowdaUltimates.SetRoGroupsColorEdgeOutOfCombat(r, g ,b)
	BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsColorEdgeInCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaGroup.ro.roVars.groups.borderInCombat)
end

function BeltalowdaUltimates.SetRoGroupsColorEdgeInCombat(r, g ,b)
	BeltalowdaGroup.ro.roVars.groups.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaUltimates.GetRoGroupsMaxDistance()
	return BeltalowdaGroup.ro.roVars.groups.maxDistance
end

function BeltalowdaUltimates.SetRoGroupsMaxDistance(value)
	BeltalowdaGroup.ro.roVars.groups.maxDistance = value
end

function BeltalowdaUltimates.GetRoSize()
	return BeltalowdaGroup.ro.roVars.size
end

function BeltalowdaUltimates.SetRoSize(value)
	BeltalowdaGroup.ro.roVars.size = value
	BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaUltimates.GetRoGroupsSize()
	return BeltalowdaGroup.ro.roVars.groups.size
end

function BeltalowdaUltimates.SetRoGroupsSize(value)
	BeltalowdaGroup.ro.roVars.groups.size = value
	BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaUltimates.GetRoSpacing()
	return BeltalowdaGroup.ro.roVars.spacing
end

function BeltalowdaUltimates.SetRoSpacing(value)
	BeltalowdaGroup.ro.roVars.spacing = value
	BeltalowdaUltimates.AdjustSize()
end


-- ============================================================================
-- Phase 3 Migration: Core Implementation  
-- Migrated from ResourceOverview.lua
-- ============================================================================

-- Additional namespace setup for implementation
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaGroup.dbo = BeltalowdaGroup.dbo or {}
local BeltalowdaDbo = BeltalowdaGroup.dbo
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.sound = BeltalowdaUtil.sound or {}
local BeltalowdaSound = BeltalowdaUtil.sound
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math

-- State and controls
BeltalowdaUltimates.state = {}
BeltalowdaUltimates.state.running = false
BeltalowdaUltimates.state.initialized = false
BeltalowdaUltimates.state.groupSize = 0
BeltalowdaUltimates.state.ultimates = {}
BeltalowdaUltimates.state.ultimateAvailable = {}
BeltalowdaUltimates.state.sounds = {}
BeltalowdaUltimates.state.networkInformation = {}
BeltalowdaUltimates.state.groupsData = {}
BeltalowdaUltimates.state.buffs = {}
BeltalowdaUltimates.state.selectedClientUltimate = 0
BeltalowdaUltimates.state.selectedGroupUltimate = 0
BeltalowdaUltimates.state.previousActiveGroupSize = 0

BeltalowdaUltimates.controls = {}
BeltalowdaUltimates.controls.client = {}
BeltalowdaUltimates.controls.groups = {}
BeltalowdaUltimates.controls.groupUltimates = {}
BeltalowdaUltimates.controls.ultimateOverview = {}
BeltalowdaUltimates.controls.groupAssignments = {}

-- ============================================================================

function BeltalowdaUltimates.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaUltimates.callbackName, BeltalowdaUltimates.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_RESOURCEOVERVIEW_BOOM", BeltalowdaUltimates.constants.TOGGLE_BOOM)
	BeltalowdaUltimates.state.sounds = BeltalowdaSound.GetRestrictedSounds()
	
	BeltalowdaUltimates.CreateDefaultUI()
	BeltalowdaUltimates.CreateGroupsUI()
	--[[
		Finalisation
	]]
	BeltalowdaUltimates.SetTlwLocation()
	BeltalowdaUltimates.SetPositionLocked(BeltalowdaGroup.ro.roVars.positionLocked)
	BeltalowdaUltimates.SetDisplayedUltimates(BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates)
	BeltalowdaUltimates.SetControlVisibility()
	BeltalowdaUltimates.AdjustGroupsShowSoftResources()
	BeltalowdaUltimates.AdjustGroupsColor()
	BeltalowdaUltimates.AdjustInCombatSettings()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaUltimates.SetRoPositionLocked)
		
	BeltalowdaUltimates.state.initialized = true
	BeltalowdaUltimates.InitializeControlSettings()
end

function BeltalowdaUltimates.InitializeControlSettings()
	--BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
	BeltalowdaUltimates.AdjustColors()
	BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
	BeltalowdaUltimates.AdjustGroupNames()

	BeltalowdaUltimates.AdjustSize()
	BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
end

function BeltalowdaUltimates.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.ultimateOverviewSettings = {}
	defaults.ultimateOverviewSettings.enabled = false
	
	defaults.clientUltimateSettings = {}
	defaults.clientUltimateSettings.enabled = true
	
	defaults.size = BeltalowdaUltimates.constants.size.SMALL
	
	defaults.groupUltimatesSettings = {}
	defaults.groupUltimatesSettings.enabled = true
	defaults.groupUltimatesSettings.displayedUltimates = 6
	defaults.groupUltimatesSettings.ultimates = {}
	defaults.groupUltimatesSettings.ultimates[1] = 15
	defaults.groupUltimatesSettings.ultimates[2] = 1
	defaults.groupUltimatesSettings.ultimates[3] = 13
	defaults.groupUltimatesSettings.ultimates[4] = 24
	defaults.groupUltimatesSettings.ultimates[5] = 6
	defaults.groupUltimatesSettings.ultimates[6] = 12
	defaults.groupUltimatesSettings.ultimates[7] = 5
	defaults.groupUltimatesSettings.ultimates[8] = 7
	defaults.groupUltimatesSettings.ultimates[9] = 14
	defaults.groupUltimatesSettings.ultimates[10] = 16
	defaults.groupUltimatesSettings.ultimates[11] = 8
	defaults.groupUltimatesSettings.ultimates[12] = 27
	defaults.spacing = 0
	
	defaults.groupAssignmentSettings = {}
	
	defaults.playerBlockColors = {}
	defaults.playerBlockColors.defaultBackground = {}
	defaults.playerBlockColors.defaultBackground.r = 0.23828125
	defaults.playerBlockColors.defaultBackground.g = 0.23828125
	defaults.playerBlockColors.defaultBackground.b = 0.23828125
	defaults.playerBlockColors.magicka = {}
	defaults.playerBlockColors.magicka.r = 0.0
	defaults.playerBlockColors.magicka.g = 0.0703125
	defaults.playerBlockColors.magicka.b = 0.9453125
	defaults.playerBlockColors.stamina = {}
	defaults.playerBlockColors.stamina.r = 0.0859375
	defaults.playerBlockColors.stamina.g = 0.5703125
	defaults.playerBlockColors.stamina.b = 0.1953125
	defaults.playerBlockColors.outOfRange = {}
	defaults.playerBlockColors.outOfRange.r = 0.23828125
	defaults.playerBlockColors.outOfRange.g = 0.23828125
	defaults.playerBlockColors.outOfRange.b = 0.23828125
	defaults.playerBlockColors.dead = {}
	defaults.playerBlockColors.dead.r = 1.0
	defaults.playerBlockColors.dead.g = 0.0
	defaults.playerBlockColors.dead.b = 0.0
	defaults.playerBlockColors.progressNotFull = {}
	defaults.playerBlockColors.progressNotFull.r = 0.359375
	defaults.playerBlockColors.progressNotFull.g = 0.54296875
	defaults.playerBlockColors.progressNotFull.b = 0.84375
	defaults.playerBlockColors.progressFull = {}
	defaults.playerBlockColors.progressFull.r = 0.30078125
	defaults.playerBlockColors.progressFull.g = 0.98046875
	defaults.playerBlockColors.progressFull.b = 0.22265625
	defaults.playerBlockColors.labelFull = {}
	defaults.playerBlockColors.labelFull.r = 0.8046875
	defaults.playerBlockColors.labelFull.g = 0.015625
	defaults.playerBlockColors.labelFull.b = 0.015625
	defaults.playerBlockColors.labelNotFull = {}
	defaults.playerBlockColors.labelNotFull.r = 0.28515625
	defaults.playerBlockColors.labelNotFull.g = 0.8828125
	defaults.playerBlockColors.labelNotFull.b = 0.02734375
	defaults.playerBlockColors.labelGroup = {}
	defaults.playerBlockColors.labelGroup.r = 0.8046875
	defaults.playerBlockColors.labelGroup.g = 0.015625
	defaults.playerBlockColors.labelGroup.b = 0.015625
	defaults.playerBlockColors.borderOutOfCombat = {}
	defaults.playerBlockColors.borderOutOfCombat.r = 0.0
	defaults.playerBlockColors.borderOutOfCombat.g = 0.0
	defaults.playerBlockColors.borderOutOfCombat.b = 0.0
	defaults.playerBlockColors.borderInCombat = {}
	defaults.playerBlockColors.borderInCombat.r = 1.0
	defaults.playerBlockColors.borderInCombat.g = 0.0
	defaults.playerBlockColors.borderInCombat.b = 0.0
	defaults.playerBlockColors.inCombatEnabled = false

	
	defaults.assignmentColor = {}
	defaults.assignmentColor.r = 0
	defaults.assignmentColor.g = 0
	defaults.assignmentColor.b = 1
	
	defaults.assignmentSize = 50
	
	defaults.displayMode = BeltalowdaUltimates.constants.displayModes.CLASSIC
	
	defaults.ultimates = {}
	defaults.ultimates.enabled = true
	defaults.ultimates.sortingMode = BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_READINESS
	defaults.ultimates.groupSizeDestro = 2
	defaults.ultimates.groupSizeStorm = 1
	defaults.ultimates.groupSizeNorthernStorm = 1
	defaults.ultimates.groupSizePermafrost = 1
	defaults.ultimates.groupSizeNegate = 1
	defaults.ultimates.groupSizeNegateOffensive = 1
	defaults.ultimates.groupSizeNegateCounter = 1
	defaults.ultimates.groupSizeNova = 1	
	defaults.ultimates.maxDistance = 25
	
	defaults.showSoftResources = true
	defaults.soundEnabled = true
	defaults.selectedSound = "CrownCrates_Purchased_With_Gems"
	
	defaults.groups = {}
	defaults.groups.enabled = false
	defaults.groups.mode = BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_NAME
	defaults.groups.group1 = {}
	defaults.groups.group1.name = BeltalowdaMenu.constants.RO_GROUPS_1_DEFAULT -- Damage
	defaults.groups.group1.enabled = true
	defaults.groups.group2 = {}
	defaults.groups.group2.name = BeltalowdaMenu.constants.RO_GROUPS_2_DEFAULT -- Support
	defaults.groups.group2.enabled = true
	defaults.groups.group3 = {}
	defaults.groups.group3.name = BeltalowdaMenu.constants.RO_GROUPS_3_DEFAULT -- Healing
	defaults.groups.group3.enabled = true
	defaults.groups.group4 = {}
	defaults.groups.group4.name = BeltalowdaMenu.constants.RO_GROUPS_4_DEFAULT -- Synergies
	defaults.groups.group4.enabled = true
	defaults.groups.group5 = {}
	defaults.groups.group5.name = BeltalowdaMenu.constants.RO_GROUPS_5_DEFAULT -- Undefined
	defaults.groups.group5.enabled = false
	
	
	defaults.groups.ultimateGroups = {}
	defaults.groups.ultimateGroups[1] = {} 
	defaults.groups.ultimateGroups[1].group = 2
	defaults.groups.ultimateGroups[1].priority = 2
	defaults.groups.ultimateGroups[2]  = {}
	defaults.groups.ultimateGroups[2].group = 2
	defaults.groups.ultimateGroups[2].priority = 3
	defaults.groups.ultimateGroups[3]  = {}
	defaults.groups.ultimateGroups[3].group = 2
	defaults.groups.ultimateGroups[3].priority = 4
	defaults.groups.ultimateGroups[4]  = {}
	defaults.groups.ultimateGroups[4].group = 1
	defaults.groups.ultimateGroups[4].priority = 30
	defaults.groups.ultimateGroups[5]  = {}
	defaults.groups.ultimateGroups[5].group = 1
	defaults.groups.ultimateGroups[5].priority = 30
	defaults.groups.ultimateGroups[6]  = {}
	defaults.groups.ultimateGroups[6].group = 1
	defaults.groups.ultimateGroups[6].priority = 30
	defaults.groups.ultimateGroups[7]  = {}
	defaults.groups.ultimateGroups[7].group = 4
	defaults.groups.ultimateGroups[7].priority = 1
	defaults.groups.ultimateGroups[8]  = {}
	defaults.groups.ultimateGroups[8].group = 3
	defaults.groups.ultimateGroups[8].priority = 1
	defaults.groups.ultimateGroups[9] = {}
	defaults.groups.ultimateGroups[9].group = 4
	defaults.groups.ultimateGroups[9].priority = 2
	defaults.groups.ultimateGroups[10] = {}
	defaults.groups.ultimateGroups[10].group = 1
	defaults.groups.ultimateGroups[10].priority = 30
	defaults.groups.ultimateGroups[11] = {}
	defaults.groups.ultimateGroups[11].group = 2
	defaults.groups.ultimateGroups[11].priority = 30
	defaults.groups.ultimateGroups[12] = {}
	defaults.groups.ultimateGroups[12].group = 1
	defaults.groups.ultimateGroups[12].priority = 30
	defaults.groups.ultimateGroups[13] = {}
	defaults.groups.ultimateGroups[13].group = 1
	defaults.groups.ultimateGroups[13].priority = 30
	defaults.groups.ultimateGroups[14] = {}
	defaults.groups.ultimateGroups[14].group = 1
	defaults.groups.ultimateGroups[14].priority = 5
	defaults.groups.ultimateGroups[15] = {}
	defaults.groups.ultimateGroups[15].group = 3
	defaults.groups.ultimateGroups[15].priority = 3
	defaults.groups.ultimateGroups[16] = {}
	defaults.groups.ultimateGroups[16].group = 1
	defaults.groups.ultimateGroups[16].priority = 6
	defaults.groups.ultimateGroups[17] = {}
	defaults.groups.ultimateGroups[17].group = 1
	defaults.groups.ultimateGroups[17].priority = 2
	defaults.groups.ultimateGroups[18] = {}
	defaults.groups.ultimateGroups[18].group = 1
	defaults.groups.ultimateGroups[18].priority = 3
	defaults.groups.ultimateGroups[19] = {}
	defaults.groups.ultimateGroups[19].group = 1
	defaults.groups.ultimateGroups[19].priority = 4
	defaults.groups.ultimateGroups[20] = {}
	defaults.groups.ultimateGroups[20].group = 3
	defaults.groups.ultimateGroups[20].priority = 2
	defaults.groups.ultimateGroups[21] = {}
	defaults.groups.ultimateGroups[21].group = 1
	defaults.groups.ultimateGroups[21].priority = 30
	defaults.groups.ultimateGroups[22] = {}
	defaults.groups.ultimateGroups[22].group = 1
	defaults.groups.ultimateGroups[22].priority = 7
	defaults.groups.ultimateGroups[23] = {}
	defaults.groups.ultimateGroups[23].group = 1
	defaults.groups.ultimateGroups[23].priority = 8
	defaults.groups.ultimateGroups[24] = {}
	defaults.groups.ultimateGroups[24].group = 2
	defaults.groups.ultimateGroups[24].priority = 1
	
	defaults.groups.ultimateGroups[25] = {}
	defaults.groups.ultimateGroups[25].group = 1
	defaults.groups.ultimateGroups[25].priority = 20
	defaults.groups.ultimateGroups[26] = {}
	defaults.groups.ultimateGroups[26].group = 3
	defaults.groups.ultimateGroups[26].priority = 20
	defaults.groups.ultimateGroups[27] = {}
	defaults.groups.ultimateGroups[27].group = 3
	defaults.groups.ultimateGroups[27].priority = 30
	
	
	defaults.groups.ultimateGroups[28] = {}
	defaults.groups.ultimateGroups[28].group = 1
	defaults.groups.ultimateGroups[28].priority = 1
	defaults.groups.ultimateGroups[29] = {}
	defaults.groups.ultimateGroups[29].group = 3
	defaults.groups.ultimateGroups[29].priority = 30
	defaults.groups.ultimateGroups[30] = {}
	defaults.groups.ultimateGroups[30].group = 1
	defaults.groups.ultimateGroups[30].priority = 30
	defaults.groups.ultimateGroups[31] = {}
	defaults.groups.ultimateGroups[31].group = 2
	defaults.groups.ultimateGroups[31].priority = 30
	defaults.groups.ultimateGroups[32] = {}
	defaults.groups.ultimateGroups[32].group = 1
	defaults.groups.ultimateGroups[32].priority = 30
	defaults.groups.ultimateGroups[33] = {}
	defaults.groups.ultimateGroups[33].group = 1
	defaults.groups.ultimateGroups[33].priority = 30
	defaults.groups.ultimateGroups[34] = {}
	defaults.groups.ultimateGroups[34].group = 1
	defaults.groups.ultimateGroups[34].priority = 30
	defaults.groups.ultimateGroups[35] = {}
	defaults.groups.ultimateGroups[35].group = 1
	defaults.groups.ultimateGroups[35].priority = 30
	defaults.groups.ultimateGroups[36] = {}
	defaults.groups.ultimateGroups[36].group = 1
	defaults.groups.ultimateGroups[36].priority = 30
	defaults.groups.ultimateGroups[37] = {}
	defaults.groups.ultimateGroups[37].group = 1
	defaults.groups.ultimateGroups[37].priority = 9
	defaults.groups.ultimateGroups[38] = {}
	defaults.groups.ultimateGroups[38].group = 1
	defaults.groups.ultimateGroups[38].priority = 10
	defaults.groups.ultimateGroups[39] = {}
	defaults.groups.ultimateGroups[39].group = 2
	defaults.groups.ultimateGroups[39].priority = 30
	defaults.groups.ultimateGroups[40] = {}
	defaults.groups.ultimateGroups[40].group = 2
	defaults.groups.ultimateGroups[40].priority = 30
	defaults.groups.ultimateGroups[41] = {}
	defaults.groups.ultimateGroups[41].group = 2
	defaults.groups.ultimateGroups[41].priority = 30
	
	defaults.groups.showSoftResources = true
	defaults.groups.size = BeltalowdaUltimates.constants.size.SMALL
	defaults.groups.maxDistance = 25
	defaults.groups.backdropColor = {}
	defaults.groups.backdropColor.r = 0.2
	defaults.groups.backdropColor.g = 0.2
	defaults.groups.backdropColor.b = 0.2
	defaults.groups.backdropColor.a = 0.5
	defaults.groups.progressNotFull = {}
	defaults.groups.progressNotFull.r = 0.8
	defaults.groups.progressNotFull.g = 0.1
	defaults.groups.progressNotFull.b = 0.1
	defaults.groups.progressNotFull.a = 0.8
	defaults.groups.progressFull = {}
	defaults.groups.progressFull.r = 0.1
	defaults.groups.progressFull.g = 0.8
	defaults.groups.progressFull.b = 0.1
	defaults.groups.progressFull.a = 0.8
	defaults.groups.labelFull = {}
	defaults.groups.labelFull.r = 0.8046875
	defaults.groups.labelFull.g = 0.015625
	defaults.groups.labelFull.b = 0.015625
	defaults.groups.labelNotFull = {}
	defaults.groups.labelNotFull.r = 0.28515625
	defaults.groups.labelNotFull.g = 0.8828125
	defaults.groups.labelNotFull.b = 0.02734375
	defaults.groups.magicka = {}
	defaults.groups.magicka.r = 0.0
	defaults.groups.magicka.g = 0.0703125
	defaults.groups.magicka.b = 0.9453125
	defaults.groups.magicka.a = 0.8
	defaults.groups.stamina = {}
	defaults.groups.stamina.r = 0.0859375
	defaults.groups.stamina.g = 0.5703125
	defaults.groups.stamina.b = 0.1953125
	defaults.groups.stamina.a = 0.8
	defaults.groups.outOfRange = {}
	defaults.groups.outOfRange.r = 0.23828125
	defaults.groups.outOfRange.g = 0.23828125
	defaults.groups.outOfRange.b = 0.23828125
	defaults.groups.outOfRange.a = 0.8
	defaults.groups.dead = {}
	defaults.groups.dead.r = 1.0
	defaults.groups.dead.g = 0.0
	defaults.groups.dead.b = 0.0
	defaults.groups.dead.a = 0.8
	defaults.groups.borderOutOfCombat = {}
	defaults.groups.borderOutOfCombat.r = 0.0
	defaults.groups.borderOutOfCombat.g = 0.0
	defaults.groups.borderOutOfCombat.b = 0.0
	defaults.groups.borderInCombat = {}
	defaults.groups.borderInCombat.r = 1.0
	defaults.groups.borderInCombat.g = 0.0
	defaults.groups.borderInCombat.b = 0.0
	
	defaults.combinedInStealthEnabled = false
	defaults.splitInStealthEnabled = false
	
	return defaults
end

function BeltalowdaUltimates.SetEnabled(value)
	if BeltalowdaUltimates.state.initialized == true and value ~= nil then
		BeltalowdaGroup.ro.roVars.enabled = value
		if value == true then
			if BeltalowdaUltimates.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaUltimates.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaUltimates.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaUltimates.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaUltimates.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaUltimates.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaUltimates.OnPlayerActivated)

			end
			BeltalowdaUltimates.state.registredConsumers = true
		else
			if BeltalowdaUltimates.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaUltimates.callbackName, EVENT_ACTION_LAYER_POPPED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaUltimates.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaUltimates.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaUltimates.state.registredConsumers = false
		end
		BeltalowdaUltimates.OnPlayerActivated()
		--BeltalowdaUltimates.SetGroupsEnabled(BeltalowdaGroup.ro.roVars.groups.enabled)
	end
end

function BeltalowdaUltimates.SetGroupsEnabled(value)
	if BeltalowdaUltimates.state.initialized == true and value ~= nil then
		BeltalowdaGroup.ro.roVars.groups.enabled = value
		BeltalowdaUltimates.OnPlayerActivated()
	end
end

function BeltalowdaUltimates.AdjustGroupNames()
	local state = BeltalowdaUltimates.GetRoAvailableGroupsGroups()
	for i = 1, #BeltalowdaUltimates.state.references do
		local control = GetWindowManager():GetControlByName(BeltalowdaUltimates.state.references[i])
		if control ~= nil then
			control:UpdateChoices(state)
		end
	end
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		BeltalowdaUltimates.controls.groupsTLW[i].rootControl.caption:SetText(BeltalowdaGroup.ro.roVars.groups["group" .. i].name)
	end
end

function BeltalowdaUltimates.SetTlwLocation()
	BeltalowdaUltimates.controls.clientUltimateTLW:ClearAnchors()
	if BeltalowdaGroup.ro.roVars.clientUltimateSettings.location == nil then
		BeltalowdaUltimates.controls.clientUltimateTLW:SetAnchor(CENTER, GuiRoot, CENTER, -250, -150)
	else
		BeltalowdaUltimates.controls.clientUltimateTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaGroup.ro.roVars.clientUltimateSettings.location.x, BeltalowdaGroup.ro.roVars.clientUltimateSettings.location.y)
	end
	BeltalowdaUltimates.controls.groupUltimatesTLW:ClearAnchors()
	if BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location == nil then
		BeltalowdaUltimates.controls.groupUltimatesTLW:SetAnchor(CENTER, GuiRoot, CENTER, 125, -150)
	else
		BeltalowdaUltimates.controls.groupUltimatesTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location.x, BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location.y)
	end
	BeltalowdaUltimates.controls.ultimateOverviewTLW:ClearAnchors()
	if BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location == nil then
		BeltalowdaUltimates.controls.ultimateOverviewTLW:SetAnchor(CENTER, GuiRoot, CENTER, 150, 0)
	else
		BeltalowdaUltimates.controls.ultimateOverviewTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location.x, BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location.y)
	end
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		BeltalowdaUltimates.controls.groupsTLW[i]:ClearAnchors()
		if BeltalowdaGroup.ro.roVars.groups.location == nil or BeltalowdaGroup.ro.roVars.groups.location[i] == nil then
			BeltalowdaUltimates.controls.groupsTLW[i]:SetAnchor(CENTER, GuiRoot, CENTER, -150, -150)
		else
			BeltalowdaUltimates.controls.groupsTLW[i]:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaGroup.ro.roVars.groups.location[i].x, BeltalowdaGroup.ro.roVars.groups.location[i].y)
		end
	end
	
end

function BeltalowdaUltimates.CreateDefaultUI()
	--[[
		Client Ultimate
	]]
	BeltalowdaUltimates.controls.clientUltimateTLW = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_CLIENT_ULTIMATE_NAME)
	
			
	BeltalowdaUltimates.controls.clientUltimateTLW:SetClampedToScreen(BeltalowdaUltimates.config.clientUltimate.isClampedToScreen)
	BeltalowdaUltimates.controls.clientUltimateTLW:SetDrawLayer(0)
	BeltalowdaUltimates.controls.clientUltimateTLW:SetDrawLevel(0)
	BeltalowdaUltimates.controls.clientUltimateTLW:SetHandler("OnMoveStop", BeltalowdaUltimates.SaveClientUltimateWindowLocation)
	BeltalowdaUltimates.controls.clientUltimateTLW:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	
	BeltalowdaUltimates.controls.clientUltimateTLW.rootControl = wm:CreateControl(nil, BeltalowdaUltimates.controls.clientUltimateTLW, CT_CONTROL)
	local clientRootControl = BeltalowdaUltimates.controls.clientUltimateTLW.rootControl
	
	clientRootControl:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	clientRootControl:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.clientUltimateTLW, TOPLEFT, 0, 0)
	
	clientRootControl.movableBackdrop = wm:CreateControl(nil, clientRootControl, CT_BACKDROP)
	
	clientRootControl.movableBackdrop:SetAnchor(TOPLEFT, clientRootControl, TOPLEFT, 0, 0)
	clientRootControl.movableBackdrop:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	
	clientRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	clientRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	clientRootControl.ultimateSelector = BeltalowdaUltimates.CreateUltimateSelectorControl(clientRootControl, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset, BeltalowdaUltimates.config.clientUltimate.isClampedToScreen, BeltalowdaUltimates.SetClientUltimate)
	
	local selectedIndex = 1
	if BeltalowdaUltimates.charVars.ro ~= nil then
		selectedIndex = BeltalowdaUltimates.GetUltimateIndexFromUltimateId(BeltalowdaUltimates.charVars.ro.selectedUltimateId)
		if selectedIndex == nil then
			selectedIndex = 1
		end
	end
	BeltalowdaUltimates.SetClientUltimate(clientRootControl.ultimateSelector, selectedIndex)
	--[[
		Group Ultimates
	]]
	BeltalowdaUltimates.controls.groupUltimatesTLW = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_GROUP_ULTIMATES_NAME)
		
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetClampedToScreen(BeltalowdaUltimates.config.groupUltimates.isClampedToScreen)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetDrawLayer(0)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetDrawLevel(0)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetHandler("OnMoveStop", BeltalowdaUltimates.SaveGroupUltimatesWindowLocation)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	
	
	BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl = wm:CreateControl(nil, BeltalowdaUltimates.controls.groupUltimatesTLW, CT_CONTROL)
	local groupsRootControl = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl
	
	groupsRootControl:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	groupsRootControl:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupUltimatesTLW, TOPLEFT, 0, 0)
	
	groupsRootControl.movableBackdrop = wm:CreateControl(nil, groupsRootControl, CT_BACKDROP)
	
	groupsRootControl.movableBackdrop:SetAnchor(TOPLEFT, groupsRootControl, TOPLEFT, 0, 0)
	groupsRootControl.movableBackdrop:SetDimensions(BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
	
	groupsRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	groupsRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	groupsRootControl.ultimateSelector = {}
	for i = 1, 12 do
		groupsRootControl.ultimateSelector[i] = BeltalowdaUltimates.CreateUltimateSelectorControl(groupsRootControl, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth * (i - 1)), BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset, BeltalowdaUltimates.config.groupUltimates.isClampedToScreen, BeltalowdaUltimates.SetGroupUltimate)
		groupsRootControl.ultimateSelector[i].controlIndex = i
		groupsRootControl.ultimateSelector[i].label = wm:CreateControl(nil, groupsRootControl.ultimateSelector[i], CT_LABEL)
		groupsRootControl.ultimateSelector[i].label:SetHidden(true)
		groupsRootControl.ultimateSelector[i].label:SetText("")
		groupsRootControl.ultimateSelector[i].label:SetWrapMode(ELLIPSIS)
		groupsRootControl.ultimateSelector[i].label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
		BeltalowdaUltimates.SetGroupUltimate(groupsRootControl.ultimateSelector[i], BeltalowdaUltimates.GetUltimateIndexFromUltimateId(BeltalowdaGroup.ro.roVars.groupUltimatesSettings.ultimates[i]))
	end
	
	--[[
		Group Selector Player Blocks
	]]
	groupsRootControl.playerBlocks = {}
	for i = 1, 24 do
		groupsRootControl.playerBlocks[i] = BeltalowdaUltimates.CreatePlayerBlock(groupsRootControl, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight)
	end
	
	
	--[[
		Group Assignment Window
	]]
	BeltalowdaUltimates.controls.groupAssignmentTLW = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_GROUP_ASSIGNMENT_NAME)
	
	if BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location == nil then
		BeltalowdaUltimates.controls.groupAssignmentTLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	else
		BeltalowdaUltimates.controls.groupAssignmentTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location.x, BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location.y)
	end
		
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetClampedToScreen(BeltalowdaUltimates.config.groupAssignments.isClampedToScreen)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetDrawLayer(0)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetDrawLevel(0)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetHandler("OnMoveStop", BeltalowdaUltimates.SaveGroupAssignmentWindowLocation)
		
	BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl = wm:CreateControl(nil, BeltalowdaUltimates.controls.groupAssignmentTLW, CT_CONTROL)
	local assignmentRootControl = BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl
	
	
	assignmentRootControl:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupAssignmentTLW, TOPLEFT, 0, 0)
	
	assignmentRootControl.movableBackdrop = wm:CreateControl(nil, assignmentRootControl, CT_BACKDROP)
	
	assignmentRootControl.movableBackdrop:SetAnchor(TOPLEFT, assignmentRootControl, TOPLEFT, 0, 0)
		
	assignmentRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	assignmentRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	assignmentRootControl.label = wm:CreateControl(nil, assignmentRootControl, CT_LABEL)
	assignmentRootControl.label:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	assignmentRootControl.label:SetWrapMode(ELLIPSIS)
	
	
	assignmentRootControl.label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	assignmentRootControl.label:SetColor(BeltalowdaGroup.ro.roVars.assignmentColor.r, BeltalowdaGroup.ro.roVars.assignmentColor.g, BeltalowdaGroup.ro.roVars.assignmentColor.b, 1)
	BeltalowdaUltimates.AdjustAssignmentControlSize()
	
	--[[
		Group Overview Window
	]]
	BeltalowdaUltimates.controls.ultimateOverviewTLW = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_ULTIMATE_OVERVIEW_NAME)

	
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetClampedToScreen(BeltalowdaUltimates.config.ultimateOverview.isClampedToScreen)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetDrawLayer(0)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetDrawLevel(0)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetHandler("OnMoveStop", BeltalowdaUltimates.SaveUltimateOverviewLocation)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetDimensions(BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].height)
	
	BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl = wm:CreateControl(nil, BeltalowdaUltimates.controls.ultimateOverviewTLW, CT_CONTROL)
	
	local ultimateOverviewControl = BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl
	ultimateOverviewControl:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.ultimateOverviewTLW, TOPLEFT, 0, 0)
	ultimateOverviewControl:SetDimensions(BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].height)
	
	ultimateOverviewControl.movableBackdrop = wm:CreateControl(nil, ultimateOverviewControl, CT_BACKDROP)
	ultimateOverviewControl.movableBackdrop:SetDimensions(BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].height)
	ultimateOverviewControl.movableBackdrop:SetAnchor(TOPLEFT, ultimateOverviewControl, TOPLEFT, 0, 0)
		
	ultimateOverviewControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	ultimateOverviewControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	ultimateOverviewControl.destructionLabel = BeltalowdaUltimates.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight, 0, BeltalowdaUltimates.constants.IDENENTIFIER_DESTRUCTION)
	ultimateOverviewControl.stormLabel = BeltalowdaUltimates.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight, BeltalowdaUltimates.constants.IDENENTIFIER_STORM)
	ultimateOverviewControl.negateLabel = BeltalowdaUltimates.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight * 2, BeltalowdaUltimates.constants.IDENENTIFIER_NEGATE)
	ultimateOverviewControl.novaLabel = BeltalowdaUltimates.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight, BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight * 3, BeltalowdaUltimates.constants.IDENENTIFIER_NOVA)
		
	
end

function BeltalowdaUltimates.CreateUltimateOverviewLabel(parent, width, height, offset, text)
	local control = wm:CreateControl(nil, parent, CT_LABEL)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, offset)
	control:SetFont(BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK))
	control:SetWrapMode(ELLIPSIS)
	control:SetDimensions(width - 20, height)
	control:SetText(string.format(BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING, 0, 0, text))
	control.currentBoomLabel = wm:CreateControl(nil, parent, CT_LABEL)
	control.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, width - 20, offset)
	control.currentBoomLabel:SetFont(BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK))
	control.currentBoomLabel:SetWrapMode(ELLIPSIS)
	control.currentBoomLabel:SetDimensions(20, height)
	control.currentBoomLabel:SetText("0")
	return control
end

function BeltalowdaUltimates.CreateUltimateSelectorControl(parent, width, height, offsetX, offsetY, isClampedToScreen, clickFunction)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(width, height)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, offsetX, offsetY)
	control:SetClampedToScreen(isClampedToScreen)
	control.clickFunction = clickFunction
	
	control.button = wm:CreateControl(nil, control, CT_BUTTON)
	local button = control.button
	button:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	button:SetDimensions(width, height)
	button:SetNormalTexture("/esoui/art/actionbar/abilityframe64_up.dds")
	button:SetPressedTexture("/esoui/art/actionbar/abilityframe64_down.dds")
	button:SetMouseOverTexture("EsoUI/Art/ActionBar/actionBar_mouseOver.dds")
	button:SetHandler("OnClicked", function () BeltalowdaUltimates.ShowUltimateControlOptions(control) end)
	button:SetDrawTier(1)
	
	control.texture = wm:CreateControl(nil, parent, CT_TEXTURE)
	local texture = control.texture
	texture:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 2)
	texture:SetDimensions(width - 4, height - 4)
	texture:SetTexture("/esoui/art/icons/icon_missing.dds")
	texture:SetDrawTier(0)
	return control
end

function BeltalowdaUltimates.CreatePlayerBlock(parent, width, height, blockGroupWidth, blockMagickaHeight, blockStaminaHeight)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(width, height)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)
	
	control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.backdrop:SetDimensions(width, height)
	control.backdrop:SetDrawTier(0)
	control.backdrop:SetCenterColor(BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.r, BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.g, BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.b, 0.8)
	control.backdrop:SetEdgeColor(0,0,0,0)
	
	control.ultimateProgress = wm:CreateControl(nil, control, CT_STATUSBAR)
	control.ultimateProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.ultimateProgress:SetDimensions(width, height - blockMagickaHeight - blockStaminaHeight)
	control.ultimateProgress:SetMinMax(0, 100)
	control.ultimateProgress:SetValue(0)
	control.ultimateProgress:SetDrawTier(1)
	
	control.magickaProgress = wm:CreateControl(nil, control, CT_STATUSBAR)
	control.magickaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, height - blockMagickaHeight - blockStaminaHeight)
	control.magickaProgress:SetDimensions(width, blockMagickaHeight)
	control.magickaProgress:SetMinMax(0, 100)
	control.magickaProgress:SetValue(0)
	control.magickaProgress:SetDrawTier(3)
	
	control.staminaProgress = wm:CreateControl(nil, control, CT_STATUSBAR)
	control.staminaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, height - blockStaminaHeight)
	control.staminaProgress:SetDimensions(width, blockStaminaHeight)
	control.staminaProgress:SetMinMax(0, 100)
	control.staminaProgress:SetValue(0)
	control.staminaProgress:SetDrawTier(1)
	
	control.labelName = wm:CreateControl(nil, control, CT_LABEL)
	control.labelName:SetAnchor(TOPLEFT, control, TOPLEFT, blockGroupWidth, 0)
	control.labelName:SetFont(BeltalowdaUltimates.config.font)
	control.labelName:SetWrapMode(ELLIPSIS)
	control.labelName:SetDimensions(width - blockGroupWidth - 2, height - blockMagickaHeight - blockStaminaHeight - 4)
	control.labelName:SetText("")
	control.labelName:SetDrawTier(2)
	control.labelName:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.labelGroup = wm:CreateControl(nil, control, CT_LABEL)
	control.labelGroup:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 0)
	control.labelGroup:SetFont(BeltalowdaUltimates.config.font)
	control.labelGroup:SetWrapMode(ELLIPSIS)
	control.labelGroup:SetDimensions(blockGroupWidth - 4, height - blockMagickaHeight - blockStaminaHeight - 4)
	control.labelGroup:SetText("")
	control.labelGroup:SetDrawTier(2)
	control.labelGroup:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.frontdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.frontdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.frontdrop:SetDimensions(width, height)
	control.frontdrop:SetDrawTier(2)
	control.frontdrop:SetEdgeColor(0,0,0,0)
	
	control.border = wm:CreateControl(nil, control, CT_BACKDROP)
	control.border:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.border:SetDimensions(width, height)
	control.border:SetEdgeTexture(nil, 1, 1, BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].border, 0)
	control.border:SetCenterColor(0, 0, 0, 0)
	control.border:SetEdgeColor(BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat.r, BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat.g, BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat.b, 1)
	control.border:SetDrawTier(2)
	control.border:SetHidden(true)
	
	control:SetHidden(true)
	return control
end

function BeltalowdaUltimates.CreateGroupsUI()
	BeltalowdaUltimates.controls.groupsTLW = {}
	BeltalowdaUltimates.controls.groupsEntries = {}
	for i = 1, 5 do
		local tlw = BeltalowdaUltimates.CreateGroupsGroupWindow(i)
		table.insert(BeltalowdaUltimates.controls.groupsTLW, tlw)
	end
	BeltalowdaUltimates.controls.groupsEmptyTLW = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_GROUPS_EMPTY)
	BeltalowdaUltimates.controls.groupsEmptyTLW:SetDimensions(0,0)
	BeltalowdaUltimates.controls.groupsEmptyTLW:SetHidden(true)
	for i = 1, 24 do
		local entry = BeltalowdaUltimates.CreateGroupsEntryControl(BeltalowdaUltimates.controls.groupsEmptyTLW)
		table.insert(BeltalowdaUltimates.controls.groupsEntries, entry)
	end
end

function BeltalowdaUltimates.CreateGroupsGroupWindow(index)
	local captionFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].captionFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)

	local tlw = wm:CreateTopLevelWindow(BeltalowdaUltimates.constants.TLW_GROUPS_GROUP[index])
	
	tlw:SetClampedToScreen(BeltalowdaUltimates.config.groups.isClampedToScreen)
	tlw:SetDrawLayer(0)
	tlw:SetDrawLevel(0)
	tlw:SetHandler("OnMoveStop", BeltalowdaUltimates.SaveGroupsGroupWindowLocation)
	tlw:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].height)
	
	tlw.rootControl = wm:CreateControl(nil, tlw, CT_CONTROL)
	local rootControl = tlw.rootControl
	
	rootControl:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].height)
	rootControl:SetAnchor(TOPLEFT, tlw, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].width, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.caption = wm:CreateControl(nil, rootControl, CT_LABEL)
	rootControl.caption:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 2, 0)
	rootControl.caption:SetFont(captionFont)
	rootControl.caption:SetWrapMode(ELLIPSIS)
	rootControl.caption:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight)
	rootControl.caption:SetText("")
	rootControl.caption:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	rootControl.caption:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	return tlw
end

function BeltalowdaUltimates.CreateGroupsEntryControl(parent)
	if parent ~= nil then
		local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithResources, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local control = wm:CreateControl(nil, parent, CT_CONTROL)
		
		control:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight)
		control:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)
		
		control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.backdrop:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight)
		control.backdrop:SetCenterColor(1, 0, 0, 0.0)
		control.backdrop:SetEdgeColor(1, 0, 0, 0.0)
	
		control.edge = wm:CreateControl(nil, control, CT_BACKDROP)
		control.edge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.edge:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight)
		control.edge:SetEdgeTexture(nil, 1, 1, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].edgeSize, 0)
		control.edge:SetCenterColor(0, 0, 0, 0)
		control.edge:SetEdgeColor(BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat.r, BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat.g, BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat.b, 1)
		
		control.progress = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 2, 2)
		control.progress:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 4)
		control.progress:SetMinMax(0, 100)
		control.progress:SetValue(0)
		
		control.softBackdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.softBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 2, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight * 2 - 2)
		control.softBackdrop:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight * 2)
		control.softBackdrop:SetCenterColor(1, 0, 0, 0.0)
		control.softBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		
		control.magicka = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.magicka:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 2, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight * 2 - 2)
		control.magicka:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight)
		control.magicka:SetMinMax(0, 100)
		control.magicka:SetValue(0)
		
		control.stamina = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.stamina:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 2, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight - 2)
		control.stamina:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight)
		control.stamina:SetMinMax(0, 100)
		control.stamina:SetValue(0)
		
		control.name = wm:CreateControl(nil, control, CT_LABEL)
		control.name:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups.entryHeight, 0)
		control.name:SetFont(font)
		control.name:SetWrapMode(ELLIPSIS)
		control.name:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryPercentWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 4)
		control.name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		
		control.percent = wm:CreateControl(nil, control, CT_LABEL)
		control.percent:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryPercentWidth) - 2, 0)
		control.percent:SetFont(font)
		control.percent:SetWrapMode(ELLIPSIS)
		control.percent:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryPercentWidth, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 4)
		control.percent:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.percent:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
		
		control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
		control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 2)
		control.texture:SetDimensions(BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 4, BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight - 4)

		
		return control
	end
	
	return nil
end

function BeltalowdaUltimates.SetClientUltimate(control, ultimateIndex)
	if ultimateIndex ~= nil and control ~= nil then
		local ultimates = BeltalowdaUltimates.ultimates
		if ultimateIndex > 0 and ultimateIndex <= #ultimates then
			BeltalowdaUltimates.charVars.ro.selectedUltimateId = ultimates[ultimateIndex].id
			BeltalowdaUltimates.state.selectedClientUltimate = ultimates[ultimateIndex]
			control.texture:SetTexture(ultimates[ultimateIndex].icon)
			if ultimates[ultimateIndex].iconColor == nil then
				control.texture:SetColor(1,1,1)
			else
				control.texture:SetColor(ultimates[ultimateIndex].iconColor.r, ultimates[ultimateIndex].iconColor.g, ultimates[ultimateIndex].iconColor.b)
			end
		end
	end
end

function BeltalowdaUltimates.SetGroupUltimate(control, ultimateIndex)
	if ultimateIndex ~= nil and control ~= nil and control.label ~= nil then
		local ultimates = BeltalowdaUltimates.ultimates
		if ultimateIndex > 0 and ultimateIndex <= #ultimates then
			local controlIndex = control.controlIndex
			BeltalowdaGroup.ro.roVars.groupUltimatesSettings.ultimates[controlIndex] = ultimates[ultimateIndex].id
			control.texture:SetTexture(ultimates[ultimateIndex].icon)
			control.label:SetText(ultimates[ultimateIndex].name)
			if ultimates[ultimateIndex].iconColor == nil then
				control.texture:SetColor(1,1,1)
			else
				control.texture:SetColor(ultimates[ultimateIndex].iconColor.r, ultimates[ultimateIndex].iconColor.g, ultimates[ultimateIndex].iconColor.b)
			end
		end
	end
end

function BeltalowdaUltimates.SetPositionLocked(value)
	BeltalowdaGroup.ro.roVars.positionLocked = value
	BeltalowdaUltimates.controls.clientUltimateTLW:SetMovable(not value)
	BeltalowdaUltimates.controls.clientUltimateTLW:SetMouseEnabled(not value)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetMovable(not value)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetMouseEnabled(not value)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetMovable(not value)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetMouseEnabled(not value)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetMovable(not value)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetMouseEnabled(not value)
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		BeltalowdaUltimates.controls.groupsTLW[i]:SetMovable(not value)
		BeltalowdaUltimates.controls.groupsTLW[i]:SetMouseEnabled(not value)
	end
	if value == true then
		BeltalowdaUltimates.controls.clientUltimateTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.clientUltimateTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetCenterColor(0.2, 0.2, 0.2, 0.4)
		BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
			BeltalowdaUltimates.controls.groupsTLW[i].rootControl.movableBackdrop:SetCenterColor(1, 0.0, 0.0, 0.0)
			BeltalowdaUltimates.controls.groupsTLW[i].rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		end
	else
		BeltalowdaUltimates.controls.clientUltimateTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaUltimates.controls.clientUltimateTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
			BeltalowdaUltimates.controls.groupsTLW[i].rootControl.movableBackdrop:SetCenterColor(1, 0.0, 0.0, 0.5)
			BeltalowdaUltimates.controls.groupsTLW[i].rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		end
	end
end

function BeltalowdaUltimates.AdjustInCombatSettings()
	local playerBlocks = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.playerBlocks
	for i = 1, #playerBlocks do
		playerBlocks[i].border:SetHidden(not BeltalowdaGroup.ro.roVars.playerBlockColors.inCombatEnabled)
		--d(not BeltalowdaGroup.ro.roVars.playerBlockColors.inCombatEnabled)
	end
end

function BeltalowdaUltimates.SetDisplayedUltimates(value)
	if value ~= nil and value > 0 and value <= 12 then
		local sizeIncrease = BeltalowdaGroup.ro.roVars.size - BeltalowdaUltimates.constants.size.SMALL
		local ultiIconWidth = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconWidth - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
		local offset = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].offset - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset) * sizeIncrease)
		local ultiIconHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
		
		BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates = value
		local groupsRootControl = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl
		for i = 1, value do
			groupsRootControl.ultimateSelector[i]:SetHidden(false)
			groupsRootControl.ultimateSelector[i].button:SetHidden(false)
			groupsRootControl.ultimateSelector[i].texture:SetHidden(false)
		end
		for i = value + 1, 12 do
			groupsRootControl.ultimateSelector[i]:SetHidden(true)
			groupsRootControl.ultimateSelector[i].button:SetHidden(true)
			groupsRootControl.ultimateSelector[i].texture:SetHidden(true)
		end
		BeltalowdaUltimates.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		if BeltalowdaGroup.ro.roVars.displayMode == BeltalowdaUltimates.constants.displayModes.CLASSIC then
			groupsRootControl:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
			groupsRootControl.movableBackdrop:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + offset * 2)
			BeltalowdaUltimates.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		else
			local playerBlockWidth = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
			local ultiIconHeight = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
			groupsRootControl:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].offset * 2)
			groupsRootControl.movableBackdrop:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + offset * 2)
			BeltalowdaUltimates.controls.groupUltimatesTLW:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaUltimates.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		end
	end
end

function BeltalowdaUltimates.SetControlVisibility()
	local enabled = BeltalowdaGroup.ro.roVars.enabled
	local clientEnabled = BeltalowdaGroup.ro.roVars.clientUltimateSettings.enabled
	local groupEnabled = BeltalowdaGroup.ro.roVars.groupUltimatesSettings.enabled
	local overviewEnabled = BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled
	local pvpOnly = BeltalowdaGroup.ro.roVars.pvpOnly
	local ultimateGroupsEnabled = BeltalowdaGroup.ro.roVars.ultimates.enabled
	local groupsEnabledVal = BeltalowdaGroup.ro.roVars.groups.enabled
	local groupsEnabled = {}
	local setClientHidden = true
	local setGroupHidden = true
	local setAssignmentHidden = true
	local setOverviewHidden = true
	local setGroupsHidden = {}
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		setGroupsHidden[i] = true
		groupsEnabled[i] = BeltalowdaGroup.ro.roVars.groups["group" .. i].enabled
	end
	if enabled ~= nil and clientEnabled ~= nil and groupEnabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) --[[and BeltalowdaUltimates.state.foreground == true]] then
			if clientEnabled == true then
				setClientHidden = false
			end
			if groupEnabled == true then
				setGroupHidden = false
			end
			if overviewEnabled == true and ultimateGroupsEnabled == true then
				setOverviewHidden = false
			end
			if ultimateGroupsEnabled == true then
				setAssignmentHidden = false
			end
			
			if groupsEnabledVal == true then
				for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
					if groupsEnabled[i] == true then
						setGroupsHidden[i] = false
					end
				end
			end
		end
	end
	BeltalowdaUltimates.controls.clientUltimateTLW:SetHidden(setClientHidden)
	BeltalowdaUltimates.controls.groupUltimatesTLW:SetHidden(setGroupHidden)
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetHidden(setAssignmentHidden)
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetHidden(setOverviewHidden)
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		BeltalowdaUltimates.controls.groupsTLW[i]:SetHidden(setGroupsHidden[i])
		--BeltalowdaUltimates.controls.groupsTLW[i]:SetHidden(false)
	end
end

function BeltalowdaUltimates.GetAbilityCost(ultimateId)
	local cost = 0
	local ultimates = BeltalowdaUltimates.ultimates
	for i = 1, #ultimates do
		if ultimateId == ultimates[i].id then
			BeltalowdaUltimates.UpdateAbilityCosts(i)
			cost = ultimates[i].cost
			break
		end
	end
	return cost
end

function BeltalowdaUltimates.GetPlayerDebuffs()
	return BeltalowdaDbo.GetPlayerDebuffs()
end

function BeltalowdaUltimates.GetPlayerResources()	
	local currentStamina, maxStamina = GetUnitPower("player", POWERTYPE_STAMINA)
	local currentMagicka, maxMagicka = GetUnitPower("player", POWERTYPE_MAGICKA)
	local currentUltimate, maxUltimate = GetUnitPower("player", POWERTYPE_ULTIMATE)
	
	local ultimate = math.floor((currentUltimate / BeltalowdaUltimates.GetAbilityCost(BeltalowdaUltimates.charVars.ro.selectedUltimateId)) * 100)
	if ultimate > 100 then
		ultimate = 100
	end
	local magicka = math.floor((currentMagicka / maxMagicka) * 100)
	local stamina = math.floor((currentStamina / maxStamina) * 100)
	local debuffs = BeltalowdaUltimates.GetPlayerDebuffs()
	if debuffs > 7 then
		debuffs = 7
	end
	debuffs = BeltalowdaMath.DecodeBitArrayHelper(debuffs)
	--d(debuffs)
	ultimate = BeltalowdaMath.DecodeBitArrayHelper(ultimate)
	magicka = BeltalowdaMath.DecodeBitArrayHelper(magicka)
	stamina = BeltalowdaMath.DecodeBitArrayHelper(stamina)
	ultimate[8] = debuffs[1]
	magicka[8] = debuffs[2]
	stamina[8] = debuffs[3]
	ultimate = BeltalowdaMath.EncodeBitArrayHelper(ultimate, 0)
	magicka = BeltalowdaMath.EncodeBitArrayHelper(magicka, 0)
	stamina = BeltalowdaMath.EncodeBitArrayHelper(stamina, 0)
	--d("GetPlayerResources")
	--d(ultimate)
	--d(magicka)
	--d(stamina)
	return BeltalowdaUltimates.charVars.ro.selectedUltimateId, ultimate, magicka, stamina
end

function BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
	local playerBlocks = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.playerBlocks
	if playerBlocks ~= nil then
		--BeltalowdaUltimates.AdjustSize()
		local sizeIncrease = BeltalowdaGroup.ro.roVars.size - BeltalowdaUltimates.constants.size.SMALL
		--local playerBlockWidth = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
		local playerBlockHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
		local playerBlockMagickaHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
		local playerBlockStaminaHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
		local playerBlockWidth = BeltalowdaUltimates.state.playerBlockWidth
		for i = 1, #playerBlocks do
			playerBlocks[i].magickaProgress:SetHidden(not BeltalowdaGroup.ro.roVars.showSoftResources)
			playerBlocks[i].staminaProgress:SetHidden(not BeltalowdaGroup.ro.roVars.showSoftResources)
			
			if BeltalowdaGroup.ro.roVars.showSoftResources == true then
				playerBlocks[i].ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight - playerBlockMagickaHeight - playerBlockStaminaHeight)
				
			else
				playerBlocks[i].ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight)
				
			end
		end
		--BeltalowdaUltimates.AdjustSize()
	end
end

function BeltalowdaUltimates.AdjustColors()
	local playerBlocks = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.playerBlocks
	if playerBlocks ~= nil then
		for i = 1, #playerBlocks do
			playerBlocks[i].magickaProgress:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.magicka.r, BeltalowdaGroup.ro.roVars.playerBlockColors.magicka.g, BeltalowdaGroup.ro.roVars.playerBlockColors.magicka.b, 1.0)
			playerBlocks[i].staminaProgress:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.stamina.r, BeltalowdaGroup.ro.roVars.playerBlockColors.stamina.g, BeltalowdaGroup.ro.roVars.playerBlockColors.stamina.b, 1.0)
			playerBlocks[i].backdrop:SetCenterColor(BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.r, BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.g, BeltalowdaGroup.ro.roVars.playerBlockColors.defaultBackground.b, 0.8)
			playerBlocks[i].backdrop:SetEdgeColor(0,0,0,0)
			playerBlocks[i].labelGroup:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelGroup.r, BeltalowdaGroup.ro.roVars.playerBlockColors.labelGroup.g, BeltalowdaGroup.ro.roVars.playerBlockColors.labelGroup.b)
		end
	end
end

function BeltalowdaUltimates.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
	if playerA.resources == nil or playerA.resources.ultimateAssignment == nil or
	   playerB.resources == nil or playerB.resources.ultimateAssignment == nil then
		if (playerA.resources == nil or playerA.resources.ultimateAssignment == nil) and 
		   (playerB.resources ~= nil and playerB.resources.ultimateAssignment ~= nil) then
			return false
		elseif (playerA.resources ~= nil and playerA.resources.ultimateAssignment ~= nil) and 
		   (playerB.resources == nil or playerB.resources.ultimateAssignment == nil) then
			return true
		else
			return BeltalowdaUltimates.ComparePlayersByUltiThenName(playerA, playerB)
		end
	end
	if playerA.resources.ultimateAssignment < playerB.resources.ultimateAssignment then
		return true
	elseif playerA.resources.ultimateAssignment > playerB.resources.ultimateAssignment then
		return false
	else
		return playerA.charName < playerB.charName
	end
end

function BeltalowdaUltimates.SortPlayersByUlti(oldPlayerList)
	local players = {}
	local highestAssignment = 0
	for i = 1, #oldPlayerList do
		players[i] = oldPlayerList[i]
		if players[i].resources ~= nil and players[i].resources.ultimateAssignment ~= nil and players[i].resources.ultimateAssignment > highestAssignment then
			highestAssignment = players[i].resources.ultimateAssignment
		end
		if players[i].resources ~= nil then
			players[i].resources.oldReference = oldPlayerList[i]
		end
	end
	--d("------------------")
	--d(highestAssignment)
	for i = 1, #players do
		if players[i].resources ~= nil and players[i].resources.ultimatePercent == 100 and players[i].resources.ultimateAssignment == nil then
			highestAssignment = highestAssignment + 1
			players[i].resources.ultimateAssignment = highestAssignment
			oldPlayerList[i].resources.ultimateAssignment = highestAssignment
			--d("new assignment")
		elseif players[i].resources.ultimatePercent == nil or players[i].resources.ultimatePercent < 100 then
			players[i].resources.ultimateAssignment = nil
			oldPlayerList[i].resources.ultimateAssignment = nil
			--d("assignment removed")
		end
	end

	table.sort(players, BeltalowdaUltimates.ComparePlayersByUltiAssignmentThenPercent)

	for i = 1, #players do
		if players[i].resources.ultimateAssignment ~= nil then
			players[i].resources.ultimateAssignment = i
			players[i].resources.oldReference.resources.ultimateAssignment = i
		end
	end
	return players
end

function BeltalowdaUltimates.ComparePlayersByUltiThenName(playerA, playerB)
	if playerA.resources == nil or playerA.resources.ultimatePercent == nil or
	   playerB.resources == nil or playerB.resources.ultimatePercent == nil then
	   
		if (playerA.resources == nil or playerA.resources.ultimatePercent == nil) and 
		   (playerB.resources ~= nil and playerB.resources.ultimatePercent ~= nil) then
			return false
		elseif (playerA.resources ~= nil and playerA.resources.ultimatePercent ~= nil) and 
		   (playerB.resources == nil or playerB.resources.ultimatePercent == nil) then
			return true
		else
			if playerA.charName == nil then
				return false
			elseif playerB.charName == nil then
				return true
			else
				return playerA.charName < playerB.charName
			end
		end
	end
	if playerA.resources.ultimatePercent < playerB.resources.ultimatePercent then
		return false
	elseif playerA.resources.ultimatePercent > playerB.resources.ultimatePercent then
		return true
	else
		if playerA.charName == nil then
			return false
		elseif playerB.charName == nil then
			return true
		else
			return playerA.charName < playerB.charName
		end
	end
end

function BeltalowdaUltimates.AdjustPlayerOrder(oldPlayerList)
	local players = {}
	if oldPlayerList ~= Nil then
		--[[
		if BeltalowdaGroup.ro.roVars.ultimates.sortingMode == BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_GROUP then
		
		elseif BeltalowdaGroup.ro.roVars.ultimates.sortingMode == BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_READINESS then
		
		elseif BeltalowdaGroup.ro.roVars.ultimates.sortingMode == BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_NAME then
		]]
		
		if BeltalowdaGroup.ro.roVars.ultimates.sortingMode == BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_NAME then
			for i = 1, #oldPlayerList do
				players[i] = oldPlayerList[i]
			end
			table.sort(players, BeltalowdaUltimates.ComparePlayersByUltiThenName)
		elseif BeltalowdaGroup.ro.roVars.ultimates.sortingMode == BeltalowdaUltimates.constants.ultimateModes.ORDER_BY_READINESS then
			players = BeltalowdaUltimates.SortPlayersByUlti(oldPlayerList)
		end
		--[[end]]
	end
	return players
end

function Beltalowda.IsUltimateDisplayed(ultimateId)
	local isDisplayed = false
	local index = 0
	if ultimateId ~= nil then
		local displayedUltimates = BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates
		local ultimates = BeltalowdaGroup.ro.roVars.groupUltimatesSettings.ultimates
		for i = 1, displayedUltimates do
			if BeltalowdaGroup.ro.roVars.groupUltimatesSettings.ultimates[i] == ultimateId then
				isDisplayed = true
				index = i
				break
			end
		end
	end
	return isDisplayed, index
end

function BeltalowdaUltimates.GetUltimateGroupSize(ultimateId)
	local groupSize = 0
	local ultimateType = nil
	if ultimateId == 1 then --Negate
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegate
		ultimateType = "negate"
	elseif ultimateId == 5 then --Nova
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeNova
		ultimateType = "nova"
	elseif ultimateId == 13 then --Storm
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeStorm
		ultimateType = "storm"
	elseif ultimateId == 15 then --Destro
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeDestro
		ultimateType = "destro"
	elseif ultimateId == 29 then --Negate Offensive
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateOffensive
		ultimateType = "negateOffensive"
	elseif ultimateId == 30 then --Negate Counter
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeNegateCounter
		ultimateType = "negateCounter"
	elseif ultimateId == 35 then --Storm
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizeNorthernStorm
		ultimateType = "northernStorm"
	elseif ultimateId == 36 then --Storm
		groupSize = BeltalowdaGroup.ro.roVars.ultimates.groupSizePermafrost
		ultimateType = "permafrost"
	end
	return groupSize, ultimateType
end

function BeltalowdaUltimates.SendBoom()
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_BOOM
	local array = BeltalowdaUltimates.GetGroupUltiArray()
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(array)
	message.sent = false
	
	local send = false
	for i = 1, #array do
		if array[i] == 1 then
			send = true
			break
		end
	end
	if send == true then
		--local mode = BeltalowdaNetworking.GetUrgentMode()
		--[[if mode == BeltalowdaNetworking.constants.urgentMode.DIRECT then
			local messageSent = BeltalowdaNetworking.SendUrgentMessage(message)
			if messageSent == false then
				--retry
				zo_callLater(BeltalowdaUltimates.SendBoom, 500)
			end
		elseif mode == BeltalowdaNetworking.constants.urgentMode.CRITICAL then]]
		if BeltalowdaUltimates.state.lastUrgentMessage == nil or BeltalowdaUltimates.state.lastUrgentMessage.sent == true then
			BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.CRITICAL)
			BeltalowdaUltimates.state.lastUrgentMessage = message
		else
			BeltalowdaUltimates.state.lastUrgentMessage.b1 = message.b1
			BeltalowdaUltimates.state.lastUrgentMessage.b2 = message.b2
			BeltalowdaUltimates.state.lastUrgentMessage.b3 = message.b3
		end
		--end
	end
	array = nil
	BeltalowdaUltimates.state.lastBoom = GetGameTimeMilliseconds()
end

function BeltalowdaUltimates.GetGroupUltiArray()
	local array = {}
	local index = 1
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	
	if players ~= nil then
		
		for i = 1, 24 do
			if players[i] == nil then
				array[i] = 0
			else
				local resources = players[i].resources
				if resources.ultiGroup == 1 then
					array[i] = 1
				else
					array[i] = 0
				end
			end
		end
	else
		for i = 1, 24 do 
			array[i] = 0
		end
	end
	return array
end

function BeltalowdaUltimates.IndexUltiGroup(unitTag, groupId)
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	if players ~= nil then
		for i = 1, #players do
			if players[i].unitTag == unitTag then
				players[i].resources.ultiGroup = groupId
			end
		end
	end
end

function BeltalowdaUltimates.AdjustAssignmentControlSize()
	local assignmentRootControl = BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl
	BeltalowdaUltimates.controls.groupAssignmentTLW:SetDimensions(BeltalowdaGroup.ro.roVars.assignmentSize * 2.5, BeltalowdaGroup.ro.roVars.assignmentSize)
	assignmentRootControl:SetDimensions(BeltalowdaGroup.ro.roVars.assignmentSize * 2.5, BeltalowdaGroup.ro.roVars.assignmentSize)
	assignmentRootControl.movableBackdrop:SetDimensions(BeltalowdaGroup.ro.roVars.assignmentSize * 2.5, BeltalowdaGroup.ro.roVars.assignmentSize)
	assignmentRootControl.label:SetDimensions(BeltalowdaGroup.ro.roVars.assignmentSize * 2.5, BeltalowdaGroup.ro.roVars.assignmentSize)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaGroup.ro.roVars.assignmentSize - 10, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	assignmentRootControl.label:SetFont(font)
end

function BeltalowdaUltimates.GetGroupNameFromIndex(index)
	if index == nil or index == 0 then
		return "-"
	else
		return BeltalowdaGroup.ro.roVars.groups["group" .. (index)].name
	end
end

function BeltalowdaUltimates.GetGroupIndexFromName(value)
	if value == "-" then
		return 0
	else
		for i = 1, 5 do
			if BeltalowdaGroup.ro.roVars.groups["group" .. (i)].name == value then
				return i
			end
		end
	end
	return 0
end

function BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityName(playerA, playerB)
	if playerA.resources == nil or playerA.resources.ultimateId == nil or
	   playerB.resources == nil or playerB.resources.ultimateId == nil then
	   
		if (playerA.resources == nil or playerA.resources.ultimateId == nil) and 
		   (playerB.resources ~= nil and playerB.resources.ultimateId ~= nil) then
			return false
		elseif (playerA.resources ~= nil and playerA.resources.ultimateId ~= nil) and 
		   (playerB.resources == nil or playerB.resources.ultimateId == nil) then
			return true
		else
			if playerA.name == nil then
				return false
			elseif playerB.name == nil then
				return true
			else
				return playerA.name < playerB.name
			end
		end
	end
	local config = BeltalowdaGroup.ro.roVars.groups.ultimateGroups
	local priorityA = config[BeltalowdaUltimates.GetUltimateIndexFromUltimateId(playerA.resources.ultimateId)].priority
	local priorityB = config[BeltalowdaUltimates.GetUltimateIndexFromUltimateId(playerB.resources.ultimateId)].priority
	if  priorityA > priorityB then
		return false
	elseif priorityA < priorityB then
		return true
	else
		if playerA.resources.ultimateId > playerB.resources.ultimateId then
			return false
		elseif playerA.resources.ultimateId < playerB.resources.ultimateId then
			return true
		else
			if playerA.name == nil then
				return false
			elseif playerB.name == nil then
				return true
			else
				return playerA.name < playerB.name
			end
		end
	end
end

function BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityPercent(playerA, playerB)
		if playerA.resources == nil or playerA.resources.ultimateId == nil or
	   playerB.resources == nil or playerB.resources.ultimateId == nil then
	   
		if (playerA.resources == nil or playerA.resources.ultimateId == nil) and 
		   (playerB.resources ~= nil and playerB.resources.ultimateId ~= nil) then
			return false
		elseif (playerA.resources ~= nil and playerA.resources.ultimateId ~= nil) and 
		   (playerB.resources == nil or playerB.resources.ultimateId == nil) then
			return true
		else
			if playerA.name == nil then
				return false
			elseif playerB.name == nil then
				return true
			else
				return playerA.name < playerB.name
			end
		end
	end
	local config = BeltalowdaGroup.ro.roVars.groups.ultimateGroups
	local priorityA = config[BeltalowdaUltimates.GetUltimateIndexFromUltimateId(playerA.resources.ultimateId)].priority
	local priorityB = config[BeltalowdaUltimates.GetUltimateIndexFromUltimateId(playerB.resources.ultimateId)].priority
	if  priorityA > priorityB then
		return false
	elseif priorityA < priorityB then
		return true
	else
		if playerA.resources.ultimateId > playerB.resources.ultimateId then
			return false
		elseif playerA.resources.ultimateId < playerB.resources.ultimateId then
			return true
		else
			return BeltalowdaUltimates.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
		end
		--return BeltalowdaUltimates.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
	end
end

function BeltalowdaUtilGroup.SortPlayersByGroupsModePercent(playerA, playerB)
	return BeltalowdaUltimates.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
end

function BeltalowdaUltimates.AdjustGroupsShowSoftResources()
	local entries = BeltalowdaUltimates.controls.groupsEntries
	local setHidden = BeltalowdaGroup.ro.roVars.groups.showSoftResources
	local sizeIncrease = BeltalowdaGroup.ro.roVars.groups.size - BeltalowdaUltimates.constants.size.SMALL
	local entryWidth = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth) * sizeIncrease)
	local entryHeight = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight) * sizeIncrease)
	local softHeight = 0
	local fontSize = 0
	local edgeSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].edgeSize + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].edgeSize - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].edgeSize) * sizeIncrease)
	if setHidden == true then
		softHeight = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].softHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight) * sizeIncrease)
		fontSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithResources + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].fontSizeWithResources - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithResources) * sizeIncrease)
	else
		fontSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithoutResources + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].fontSizeWithoutResources - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithoutResources) * sizeIncrease)
	end
	
	for i = 1, #entries do
		entries[i].magicka:SetHidden(not setHidden)
		entries[i].stamina:SetHidden(not setHidden)
		entries[i].softBackdrop:SetHidden(not setHidden)
		local font = nil
		if setHidden == true then
			entries[i].progress:SetDimensions(entryWidth - entryHeight, entryHeight - edgeSize * 2 - softHeight * 2)
			font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		else
			entries[i].progress:SetDimensions(entryWidth - entryHeight, entryHeight - edgeSize * 2)
			font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		end
		entries[i].name:SetFont(font)
		entries[i].percent:SetFont(font)
	end
end

function BeltalowdaUltimates.AdjustGroupsColor()
	local entries = BeltalowdaUltimates.controls.groupsEntries
	local bgColor = BeltalowdaGroup.ro.roVars.groups.backdropColor
	local magickaColor = BeltalowdaGroup.ro.roVars.groups.magicka
	local staminaColor = BeltalowdaGroup.ro.roVars.groups.stamina
	for	i = 1, #entries do
		entries[i].backdrop:SetCenterColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
		entries[i].softBackdrop:SetCenterColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
		entries[i].magicka:SetColor(magickaColor.r, magickaColor.g, magickaColor.b, magickaColor.a)
		entries[i].stamina:SetColor(staminaColor.r, staminaColor.g, staminaColor.b, staminaColor.a)
	end
end

function BeltalowdaUltimates.SortGroupsPlayersByUlti(oldPlayerList)
	local players = {}
	local highestAssignment = 0
	for i = 1, #oldPlayerList do
		players[i] = oldPlayerList[i]
		if players[i].resources ~= nil and players[i].resources.ultimateAssignment ~= nil and players[i].resources.ultimateAssignment > highestAssignment then
			highestAssignment = players[i].resources.ultimateAssignment
		end
		if players[i].resources ~= nil then
			players[i].resources.oldReference = oldPlayerList[i]
		end
	end
	--d("------------------")
	--d(highestAssignment)
	for i = 1, #players do
		if players[i].resources ~= nil and players[i].resources.ultimatePercent == 100 and players[i].resources.ultimateAssignment == nil then
			highestAssignment = highestAssignment + 1
			players[i].resources.ultimateAssignment = highestAssignment
			oldPlayerList[i].resources.ultimateAssignment = highestAssignment
			--d("new assignment")
		elseif players[i].resources.ultimatePercent == nil or players[i].resources.ultimatePercent < 100 then
			players[i].resources.ultimateAssignment = nil
			oldPlayerList[i].resources.ultimateAssignment = nil
			--d("assignment removed")
		end
	end
	if BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_PERCENT then
		table.sort(players, BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityPercent)
	elseif BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PERCENT then
		table.sort(players, BeltalowdaUtilGroup.SortPlayersByGroupsModePercent)
	end
	for i = 1, #players do
		if players[i].resources.ultimateAssignment ~= nil then
			players[i].resources.ultimateAssignment = i
			players[i].resources.oldReference.resources.ultimateAssignment = i
		end
	end
	return players
end

function BeltalowdaUtilGroup.SortPlayersForGroupEntries(oldPlayerList)
	local players = nil
	if oldPlayerList ~= nil then
		players = {}
		for i = 1, #oldPlayerList do
			players[i] = oldPlayerList[i]
		end
		if BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_NAME then
			table.sort(players, BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityName)
		elseif BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_PERCENT then
			players = BeltalowdaUltimates.SortGroupsPlayersByUlti(oldPlayerList)
		elseif BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PERCENT then
			players = BeltalowdaUltimates.SortGroupsPlayersByUlti(oldPlayerList)
		end
	end	
	return players
end

function BeltalowdaUltimates.AdjustGroupsGroups()
	--d("adjust groups groups")
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	if players ~= nil then
		players = BeltalowdaUtilGroup.SortPlayersForGroupEntries(players)
		local currentIndex = {}
		for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
			currentIndex[i] = 1
		end
		local config = BeltalowdaGroup.ro.roVars.groups.ultimateGroups
		
		for i = 1, #players do
			if players[i].resources.ultimateId ~= nil then
				local ultimateIndex = BeltalowdaUltimates.GetUltimateIndexFromUltimateId(players[i].resources.ultimateId)
				local groupId = config[ultimateIndex].group
				if groupId ~= nil and groupId ~= 0 then
					local entry = BeltalowdaUltimates.controls.groupsEntries[i]
					entry:ClearAnchors()
					local heightOffset = currentIndex[groupId] * (BeltalowdaUltimates.state.groupsEntryHeight + 2)
					entry:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupsTLW[groupId].rootControl,TOPLEFT, 0, heightOffset)
					entry:SetParent(BeltalowdaUltimates.controls.groupsTLW[groupId].rootControl)
					currentIndex[groupId] = currentIndex[groupId] + 1
					entry.charName = players[i].charName
					entry.displayName = players[i].displayName
					entry.unitTag = players[i].unitTag
					entry.name:SetText(players[i].name)
					entry.texture:SetTexture(BeltalowdaUltimates.ultimates[ultimateIndex].icon)
					if BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_PERCENT or BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PERCENT then
						if players[i].resources ~= nil and players[i].resources.ultimatePercent ~= nil then
							entry.percent:SetText(string.format("%s %%", players[i].resources.ultimatePercent))
							entry.progress:SetValue(players[i].resources.ultimatePercent)
						else
							entry.progress:SetValue(0)
						end
						local progressColor = { r = BeltalowdaGroup.ro.roVars.groups.progressFull.r, g = BeltalowdaGroup.ro.roVars.groups.progressFull.g, b = BeltalowdaGroup.ro.roVars.groups.progressFull.b, a = BeltalowdaGroup.ro.roVars.groups.progressFull.a}
						if IsUnitDead(players[i].unitTag) == true then
							progressColor.r = BeltalowdaGroup.ro.roVars.groups.dead.r
							progressColor.g = BeltalowdaGroup.ro.roVars.groups.dead.g
							progressColor.b = BeltalowdaGroup.ro.roVars.groups.dead.b
							progressColor.a = BeltalowdaGroup.ro.roVars.groups.dead.a
						elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaGroup.ro.roVars.groups.maxDistance < players[i].distances.fromLeader then
							progressColor.r = BeltalowdaGroup.ro.roVars.groups.outOfRange.r
							progressColor.g = BeltalowdaGroup.ro.roVars.groups.outOfRange.g
							progressColor.b = BeltalowdaGroup.ro.roVars.groups.outOfRange.b
							progressColor.a = BeltalowdaGroup.ro.roVars.groups.outOfRange.a
						elseif players[i].resources.ultimatePercent ~= 100 then
							progressColor.r = BeltalowdaGroup.ro.roVars.groups.progressNotFull.r
							progressColor.g = BeltalowdaGroup.ro.roVars.groups.progressNotFull.g
							progressColor.b = BeltalowdaGroup.ro.roVars.groups.progressNotFull.b
							progressColor.a = BeltalowdaGroup.ro.roVars.groups.progressNotFull.a
						end
						local labelColor = {r = BeltalowdaGroup.ro.roVars.groups.labelFull.r, g = BeltalowdaGroup.ro.roVars.groups.labelFull.g, b = BeltalowdaGroup.ro.roVars.groups.labelFull.b}
						if players[i].resources.ultimatePercent ~= 100 then
							labelColor.r = BeltalowdaGroup.ro.roVars.groups.labelNotFull.r
							labelColor.g = BeltalowdaGroup.ro.roVars.groups.labelNotFull.g
							labelColor.b = BeltalowdaGroup.ro.roVars.groups.labelNotFull.b
						end
						entry.progress:SetColor(progressColor.r, progressColor.g, progressColor.b, progressColor.a)
						entry.name:SetColor(labelColor.r, labelColor.g, labelColor.b)
						entry.percent:SetColor(labelColor.r, labelColor.g, labelColor.b)
						local edgeColor = BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat
						if players[i].isInCombat == true then
							edgeColor = BeltalowdaGroup.ro.roVars.groups.borderInCombat
						end
						entry.edge:SetEdgeColor(edgeColor.r, edgeColor.g, edgeColor.b, 1)
						if BeltalowdaGroup.ro.roVars.groups.showSoftResources == true then
							entry.magicka:SetValue(players[i].resources.magickaPercent)
							entry.stamina:SetValue(players[i].resources.staminaPercent)
						end
					end
				else
					BeltalowdaUltimates.controls.groupsEntries[i]:ClearAnchors()
					BeltalowdaUltimates.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
					BeltalowdaUltimates.controls.groupsEntries[i]:SetParent(BeltalowdaUltimates.controls.groupsEmptyTLW)
				end
			else
				BeltalowdaUltimates.controls.groupsEntries[i]:ClearAnchors()
				BeltalowdaUltimates.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
				BeltalowdaUltimates.controls.groupsEntries[i]:SetParent(BeltalowdaUltimates.controls.groupsEmptyTLW)
			end
		end
		for i = #players + 1, 24 do
			BeltalowdaUltimates.controls.groupsEntries[i]:ClearAnchors()
			BeltalowdaUltimates.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
			BeltalowdaUltimates.controls.groupsEntries[i]:SetParent(BeltalowdaUltimates.controls.groupsEmptyTLW)
		end
	else
		for i = 1, #BeltalowdaUltimates.controls.groupsEntries do
			BeltalowdaUltimates.controls.groupsEntries[i]:ClearAnchors()
			BeltalowdaUltimates.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaUltimates.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
			BeltalowdaUltimates.controls.groupsEntries[i]:SetParent(BeltalowdaUltimates.controls.groupsEmptyTLW)
		end
	end
end

function BeltalowdaUltimates.AdjustDisplayMode()
	BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaUltimates.AdjustSize()
	--Primary Mode Configuration
	local sizeIncrease = BeltalowdaGroup.ro.roVars.size - BeltalowdaUltimates.constants.size.SMALL
	local playerBlockWidth = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
	local playerBlockHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
	local ultiIconHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
	local offset = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].offset - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].offset) * sizeIncrease)
	local ultiIconWidth = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].ultiIconWidth - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
	BeltalowdaUltimates.state.playerBlockWidth = playerBlockWidth
	BeltalowdaUltimates.state.playerBlockHeight = playerBlockHeight
	BeltalowdaUltimates.state.ultiIconHeight = ultiIconHeight
	BeltalowdaUltimates.state.offset = offset
	local blockMagickaHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
	local blockStaminaHeight = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
	local playerBlockGroupWidth = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].playerBlockGroupWidth - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth) * sizeIncrease)
	local ultimateFontSize = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].fontSize + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].fontSize - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].fontSize) * sizeIncrease)
	local ultimateFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local ultimateFontStealth = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	local spacing = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].spacingRatio - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio) * sizeIncrease) * BeltalowdaGroup.ro.roVars.spacing
	BeltalowdaUltimates.state.spacing = spacing
	local border = (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].border + (BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.BIG].border - BeltalowdaUltimates.config.sizes[BeltalowdaUltimates.constants.size.SMALL].border) * sizeIncrease)

	BeltalowdaUltimates.state.cominedFontNormal = ultimateFont
	BeltalowdaUltimates.state.cominedFontStealth = ultimateFontStealth
	
	--Client
	BeltalowdaUltimates.controls.clientUltimateTLW:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	local clientRootControl = BeltalowdaUltimates.controls.clientUltimateTLW.rootControl
	
	clientRootControl:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	clientRootControl.movableBackdrop:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	
	clientRootControl.ultimateSelector:SetDimensions(ultiIconWidth, ultiIconHeight)
	clientRootControl.ultimateSelector:ClearAnchors()
	clientRootControl.ultimateSelector:SetAnchor(TOPLEFT, clientRootControl, TOPLEFT, offset, offset)
	
	clientRootControl.ultimateSelector:SetDimensions(ultiIconWidth, ultiIconHeight)
	
	clientRootControl.ultimateSelector.button:SetDimensions(ultiIconWidth, ultiIconHeight)
	clientRootControl.ultimateSelector.texture:SetDimensions(ultiIconWidth - 4, ultiIconHeight - 4)
	
	if BeltalowdaGroup.ro.roVars.displayMode == BeltalowdaUltimates.constants.displayModes.CLASSIC then
		--Group Ultimates
		BeltalowdaUltimates.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * 12 + offset * 2, ultiIconHeight + offset * 2)
		local groupsRootControl = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl
		
		
		
		groupsRootControl:SetDimensions(ultiIconWidth * 12 + offset * 2, ultiIconHeight + offset * 2)

		groupsRootControl.movableBackdrop:SetDimensions(ultiIconWidth * 12 + offset * 2, ultiIconHeight + offset * 2)
		
		
		for i = 1, 12 do
			
			groupsRootControl.ultimateSelector[i].label:SetHidden(true)
			groupsRootControl.ultimateSelector[i]:SetDimensions(ultiIconWidth, ultiIconHeight)
			groupsRootControl.ultimateSelector[i]:ClearAnchors()
			groupsRootControl.ultimateSelector[i]:SetAnchor(TOPLEFT, groupsRootControl, TOPLEFT, offset + (ultiIconWidth * (i - 1)) + spacing * (i - 1), offset)
			
			groupsRootControl.ultimateSelector[i]:SetDimensions(ultiIconWidth, ultiIconHeight)
			
			groupsRootControl.ultimateSelector[i].button:SetDimensions(ultiIconWidth, ultiIconHeight)
			groupsRootControl.ultimateSelector[i].texture:SetDimensions(ultiIconWidth - 4, ultiIconHeight - 4)
			groupsRootControl.ultimateSelector[i].texture:SetAnchor(TOPLEFT, groupsRootControl.ultimateSelector[i], TOPLEFT, 2, 2)
		end
		
		--Group Selector Player Blocks
		for i = 1, 24 do
			
			local control = groupsRootControl.playerBlocks[i]
			control:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.backdrop:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
			
			control.magickaProgress:ClearAnchors()
			control.magickaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
			control.magickaProgress:SetDimensions(playerBlockWidth, blockMagickaHeight)
			
			control.staminaProgress:ClearAnchors()
			control.staminaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, playerBlockHeight - blockStaminaHeight)
			control.staminaProgress:SetDimensions(playerBlockWidth, blockStaminaHeight)
			
			control.labelName:ClearAnchors()
			control.labelName:SetAnchor(TOPLEFT, control, TOPLEFT, playerBlockGroupWidth, 0)
			control.labelName:SetFont(ultimateFont)
			control.labelName:SetWrapMode(ELLIPSIS)
			if BeltalowdaGroup.ro.roVars.showSoftResources == true then
				control.labelName:SetDimensions(playerBlockWidth - playerBlockGroupWidth - 2, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
				control.labelGroup:SetDimensions(playerBlockGroupWidth, playerBlockHeight - blockMagickaHeight - blockStaminaHeight - 2)
			else
				control.labelName:SetDimensions(playerBlockWidth - playerBlockGroupWidth - 2, playerBlockHeight)
				control.labelGroup:SetDimensions(playerBlockGroupWidth, playerBlockHeight - 2)
			end
			
			control.labelGroup:ClearAnchors()
			control.labelGroup:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 0)
			control.labelGroup:SetFont(ultimateFont)
			--control.labelGroup:SetDimensions(playerBlockGroupWidth - 4, playerBlockHeight - blockMagickaHeight - blockStaminaHeight - 4)
			
			control.frontdrop:SetDimensions(playerBlockWidth, playerBlockHeight)
			
			control.border:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.border:SetEdgeTexture(nil, 1, 1, border, 0)
		end
	elseif BeltalowdaGroup.ro.roVars.displayMode == BeltalowdaUltimates.constants.displayModes.SWIMLANES then
		local sizeIncrease = BeltalowdaGroup.ro.roVars.size - BeltalowdaUltimates.constants.size.SMALL
		local playerBlockWidth = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockWidth - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
		local playerBlockHeight = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockHeight - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
		local ultiIconHeight = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].ultiIconHeight - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
		local offset = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].offset + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].offset - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].offset) * sizeIncrease)
		local ultiIconWidth = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].ultiIconWidth - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
		BeltalowdaUltimates.state.playerBlockWidth = playerBlockWidth
		BeltalowdaUltimates.state.playerBlockHeight = playerBlockHeight
		BeltalowdaUltimates.state.ultiIconHeight = ultiIconHeight
		BeltalowdaUltimates.state.offset = offset
		local blockMagickaHeight = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
		local blockStaminaHeight = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
		local playerBlockGroupWidth = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].playerBlockGroupWidth - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].playerBlockGroupWidth) * sizeIncrease)
		local ultimateFontSizePlayer = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizePlayer + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].fontSizePlayer - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizePlayer) * sizeIncrease)
		local ultimateFontPlayer = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSizePlayer, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local ultimateFontSizeHeader = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizeHeader + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].fontSizeHeader - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].fontSizeHeader) * sizeIncrease)
		local ultimateFontHeader = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSizeHeader, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local spacing = (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio + (BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.BIG].spacingRatio - BeltalowdaUltimates.config.swimLaneSizes[BeltalowdaUltimates.constants.size.SMALL].spacingRatio) * sizeIncrease) * BeltalowdaGroup.ro.roVars.spacing
		BeltalowdaUltimates.state.spacing = spacing
	
	
		local groupsRootControl = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl
		
		groupsRootControl:SetDimensions(playerBlockWidth * 12 + offset * 2, ultiIconHeight + offset * 2)

		groupsRootControl.movableBackdrop:SetDimensions(playerBlockWidth * 12 + offset * 2, ultiIconHeight + offset * 2)
		
		for i = 1, 12 do
			groupsRootControl.ultimateSelector[i].label:SetHidden(false)
			groupsRootControl.ultimateSelector[i].label:ClearAnchors()
			groupsRootControl.ultimateSelector[i].label:SetAnchor(TOPLEFT, groupsRootControl.ultimateSelector[i], TOPLEFT, ultiIconWidth, 0)
			groupsRootControl.ultimateSelector[i].label:SetFont(ultimateFontHeader)
			groupsRootControl.ultimateSelector[i].label:SetDimensions(playerBlockWidth - ultiIconWidth, ultiIconHeight)
			
			groupsRootControl.ultimateSelector[i]:SetDimensions(ultiIconWidth, ultiIconHeight)
			groupsRootControl.ultimateSelector[i]:ClearAnchors()
			groupsRootControl.ultimateSelector[i]:SetAnchor(TOPLEFT, groupsRootControl, TOPLEFT, offset + (playerBlockWidth * (i - 1)) + spacing * (i - 1), offset)
			
			groupsRootControl.ultimateSelector[i].button:SetDimensions(ultiIconWidth, ultiIconHeight)
			groupsRootControl.ultimateSelector[i].texture:SetDimensions(ultiIconWidth - 2 * sizeIncrease, ultiIconHeight - 2 * sizeIncrease)
			groupsRootControl.ultimateSelector[i].texture:SetAnchor(TOPLEFT, groupsRootControl.ultimateSelector[i], TOPLEFT, 1 * sizeIncrease, 1 * sizeIncrease)
		end
		
		--Group Selector Player Blocks
		for i = 1, 24 do
			
			local control = groupsRootControl.playerBlocks[i]
			control:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.backdrop:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
			
			control.magickaProgress:ClearAnchors()
			control.magickaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
			control.magickaProgress:SetDimensions(playerBlockWidth, blockMagickaHeight)
			
			control.staminaProgress:ClearAnchors()
			control.staminaProgress:SetAnchor(TOPLEFT, control, TOPLEFT, 0, playerBlockHeight - blockStaminaHeight)
			control.staminaProgress:SetDimensions(playerBlockWidth, blockStaminaHeight)
			
			control.labelName:ClearAnchors()
			control.labelName:SetAnchor(TOPLEFT, control, TOPLEFT, playerBlockGroupWidth, 0)
			control.labelName:SetFont(ultimateFont)
			control.labelName:SetWrapMode(ELLIPSIS)
			if BeltalowdaGroup.ro.roVars.showSoftResources == true then
				control.labelName:SetDimensions(playerBlockWidth - playerBlockGroupWidth - 2, playerBlockHeight - blockMagickaHeight - blockStaminaHeight)
				control.labelGroup:SetDimensions(playerBlockGroupWidth, playerBlockHeight - blockMagickaHeight - blockStaminaHeight - 2)
			else
				control.labelName:SetDimensions(playerBlockWidth - playerBlockGroupWidth - 2, playerBlockHeight)
				control.labelGroup:SetDimensions(playerBlockGroupWidth, playerBlockHeight - 2)
			end
			--control.labelName:SetDimensions(playerBlockWidth - playerBlockGroupWidth - 2, playerBlockHeight - blockMagickaHeight - blockStaminaHeight - 4)
			
			control.labelGroup:ClearAnchors()
			control.labelGroup:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 0)
			control.labelGroup:SetFont(ultimateFont)
			--control.labelGroup:SetDimensions(playerBlockGroupWidth - 4, playerBlockHeight - blockMagickaHeight - blockStaminaHeight - 4)
			
			control.frontdrop:SetDimensions(playerBlockWidth, playerBlockHeight)
			
			control.border:SetDimensions(playerBlockWidth, playerBlockHeight)
			control.border:SetEdgeTexture(nil, 1, 1, border, 0)
		end
	end
	
	--Group Overview Window
	local assignmentWidth = (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width + (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.BIG].width - BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].width) * sizeIncrease)
	local assignmentHeight = (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].height + (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.BIG].height - BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].height) * sizeIncrease)
	local assignmentBlockHeight = (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight + (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.BIG].blockHeight - BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].blockHeight) * sizeIncrease)
	local assignmentFontSize = (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].fontSize + (BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.BIG].fontSize - BeltalowdaUltimates.config.ultimateOverview[BeltalowdaUltimates.constants.size.SMALL].fontSize) * sizeIncrease)
	local assignmentFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, assignmentFontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	
	
	
	BeltalowdaUltimates.controls.ultimateOverviewTLW:SetDimensions(assignmentWidth, assignmentHeight)

	local ultimateOverviewControl = BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl
	
	ultimateOverviewControl:SetDimensions(assignmentWidth, assignmentHeight)
	
	ultimateOverviewControl.movableBackdrop:SetDimensions(assignmentWidth, assignmentHeight)
	
	ultimateOverviewControl.destructionLabel:ClearAnchors()
	ultimateOverviewControl.destructionLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, 0)
	ultimateOverviewControl.destructionLabel:SetFont(assignmentFont)
	ultimateOverviewControl.destructionLabel:SetDimensions(assignmentWidth - 20, height)
	
	ultimateOverviewControl.destructionLabel.currentBoomLabel:ClearAnchors()
	ultimateOverviewControl.destructionLabel.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, assignmentWidth - 20, 0)
	ultimateOverviewControl.destructionLabel.currentBoomLabel:SetFont(assignmentFont)
	ultimateOverviewControl.destructionLabel.currentBoomLabel:SetDimensions(20, assignmentHeight)
	
	ultimateOverviewControl.stormLabel:ClearAnchors()
	ultimateOverviewControl.stormLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, assignmentBlockHeight)
	ultimateOverviewControl.stormLabel:SetFont(assignmentFont)
	ultimateOverviewControl.stormLabel:SetDimensions(assignmentWidth - 20, height)
	
	ultimateOverviewControl.stormLabel.currentBoomLabel:ClearAnchors()
	ultimateOverviewControl.stormLabel.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, assignmentWidth - 20, assignmentBlockHeight)
	ultimateOverviewControl.stormLabel.currentBoomLabel:SetFont(assignmentFont)
	ultimateOverviewControl.stormLabel.currentBoomLabel:SetDimensions(20, assignmentHeight)
	
	ultimateOverviewControl.negateLabel:ClearAnchors()
	ultimateOverviewControl.negateLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, assignmentBlockHeight * 2)
	ultimateOverviewControl.negateLabel:SetFont(assignmentFont)
	ultimateOverviewControl.negateLabel:SetDimensions(assignmentWidth - 20, height)
	
	ultimateOverviewControl.negateLabel.currentBoomLabel:ClearAnchors()
	ultimateOverviewControl.negateLabel.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, assignmentWidth - 20, assignmentBlockHeight * 2)
	ultimateOverviewControl.negateLabel.currentBoomLabel:SetFont(assignmentFont)
	ultimateOverviewControl.negateLabel.currentBoomLabel:SetDimensions(20, assignmentHeight)
	
	ultimateOverviewControl.novaLabel:ClearAnchors()
	ultimateOverviewControl.novaLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, assignmentBlockHeight * 3)
	ultimateOverviewControl.novaLabel:SetFont(assignmentFont)
	ultimateOverviewControl.novaLabel:SetDimensions(assignmentWidth - 20, height)
	
	ultimateOverviewControl.novaLabel.currentBoomLabel:ClearAnchors()
	ultimateOverviewControl.novaLabel.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, assignmentWidth - 20, assignmentBlockHeight * 3)
	ultimateOverviewControl.novaLabel.currentBoomLabel:SetFont(assignmentFont)
	ultimateOverviewControl.novaLabel.currentBoomLabel:SetDimensions(20, assignmentHeight)
	
	
	
	
	BeltalowdaUltimates.SetDisplayedUltimates(BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates)
	BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
	BeltalowdaUltimates.UiLoop()
	
	
	--Groups Window Configuration
	BeltalowdaUltimates.AdjustGroupsShowSoftResources()
	
	
	local sizeIncrease = BeltalowdaGroup.ro.roVars.groups.size - BeltalowdaUltimates.constants.size.SMALL
	local width = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].width + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].width - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].width) * sizeIncrease)
	local height = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].height + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].height - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].height) * sizeIncrease)
	local entryWidth = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].entryWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryWidth) * sizeIncrease)
	local entryHeight = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].entryHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryHeight) * sizeIncrease)
	local edgeSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].edgeSize + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].edgeSize - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].edgeSize) * sizeIncrease)
	local captionFontSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].captionFontSize + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].captionFontSize - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].captionFontSize) * sizeIncrease)
	local softHeight = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].softHeight - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].softHeight) * sizeIncrease)
	local entryPercentWidth = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryPercentWidth + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].entryPercentWidth - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].entryPercentWidth) * sizeIncrease)
	BeltalowdaUltimates.state.groupsEntryHeight = entryHeight
	
	local setHidden = BeltalowdaGroup.ro.roVars.groups.showSoftResources
	local fontSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithResources + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].fontSizeWithResources - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithResources) * sizeIncrease)
	if setHidden == false then
		fontSize = (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithoutResources + (BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.BIG].fontSizeWithoutResources - BeltalowdaUltimates.config.groups[BeltalowdaUltimates.constants.size.SMALL].fontSizeWithoutResources) * sizeIncrease)
	end
	local fontNormal = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local fontStealth = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	
	BeltalowdaUltimates.state.splitFontNormal = fontNormal
	BeltalowdaUltimates.state.splitFontStealth = fontStealth
	
	local captionFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, captionFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	
	for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
		BeltalowdaUltimates.controls.groupsTLW[i].rootControl.caption:SetFont(captionFont)
		BeltalowdaUltimates.controls.groupsTLW[i].rootControl.caption:SetDimensions(entryWidth, entryHeight)
		BeltalowdaUltimates.controls.groupsTLW[i]:SetDimensions(width, height)
		BeltalowdaUltimates.controls.groupsTLW[i].rootControl:SetDimensions(width, height)
		BeltalowdaUltimates.controls.groupsTLW[i].rootControl.movableBackdrop:SetDimensions(width, height)
	end
	
	for i = 1, #BeltalowdaUltimates.controls.groupsEntries do
		local control = BeltalowdaUltimates.controls.groupsEntries[i]
		
		control:SetDimensions(entryWidth, RentryHeight)
		
		control.backdrop:SetDimensions(entryWidth, entryHeight)

	
		control.edge:SetDimensions(entryWidth, entryHeight)
		control.edge:SetEdgeTexture(nil, 1, 1, edgeSize, 0)
		
		control.progress:ClearAnchors()
		control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight - edgeSize, 2)
		control.progress:SetDimensions(entryWidth - entryHeight, entryHeight - edgeSize * 2)
		
		control.softBackdrop:ClearAnchors()
		control.softBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight - 2, entryHeight - softHeight * 2 - edgeSize)
		control.softBackdrop:SetDimensions(entryWidth - entryHeight, softHeight * 2)
		
		control.magicka:ClearAnchors()
		control.magicka:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight - edgeSize, entryHeight - softHeight * 2 - edgeSize)
		control.magicka:SetDimensions(entryWidth - entryHeight, softHeight)

		control.stamina:ClearAnchors()
		control.stamina:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight - edgeSize, entryHeight - softHeight - edgeSize)
		control.stamina:SetDimensions(entryWidth - entryHeight, softHeight)

		
		control.name:ClearAnchors()
		control.name:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight, edgeSize)
		if setHidden == false then
			control.name:SetDimensions(entryWidth - entryHeight - entryPercentWidth - edgeSize, entryHeight - edgeSize * 2)
		else
			control.name:SetDimensions(entryWidth - entryHeight - entryPercentWidth - edgeSize, entryHeight - edgeSize * 2 - softHeight * 1.5)
		end
		
		control.percent:ClearAnchors()
		control.percent:SetAnchor(TOPLEFT, control, TOPLEFT, entryHeight + (entryWidth - entryHeight - entryPercentWidth) - edgeSize, edgeSize)
		if setHidden == false then
			control.percent:SetDimensions(entryPercentWidth, entryHeight - edgeSize * 2)
		else
			control.percent:SetDimensions(entryPercentWidth, entryHeight - edgeSize * 2 - softHeight * 1.5)
		end
		
		control.texture:ClearAnchors()
		control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, edgeSize, edgeSize)
		control.texture:SetDimensions(entryHeight - edgeSize * 2, entryHeight - edgeSize * 2)

	end
	BeltalowdaUltimates.AdjustGroupsGroups()
end

--callbacks
function BeltalowdaUltimates.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaGroup.ro.roVars = currentProfile.group.ro
		BeltalowdaUltimates.SetEnabled(BeltalowdaGroup.ro.roVars.enabled)
		BeltalowdaUltimates.charVars = Beltalowda.profile.GetCharacterVars()
		BeltalowdaUltimates.charVars.ro = BeltalowdaUltimates.charVars.ro or {}
		if BeltalowdaUltimates.state.initialized == true then
			BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetColor(BeltalowdaGroup.ro.roVars.assignmentColor.r, BeltalowdaGroup.ro.roVars.assignmentColor.g, BeltalowdaGroup.ro.roVars.assignmentColor.b, 1)
			BeltalowdaUltimates.AdjustSize()
			BeltalowdaUltimates.AdjustAssignmentControlSize()
			BeltalowdaUltimates.AdjustColors()
			BeltalowdaUltimates.AdjustStaminaMagickaBarVisibility()
			BeltalowdaUltimates.SetControlVisibility()
			BeltalowdaUltimates.SetTlwLocation()
			BeltalowdaUltimates.SetDisplayedUltimates(BeltalowdaGroup.ro.roVars.groupUltimatesSettings.displayedUltimates)
			BeltalowdaUltimates.AdjustGroupNames()
			BeltalowdaUltimates.AdjustGroupsShowSoftResources()
			BeltalowdaUltimates.AdjustGroupsColor()
			BeltalowdaUltimates.SetPositionLocked(BeltalowdaGroup.ro.roVars.positionLocked)
			BeltalowdaUltimates.AdjustInCombatSettings()
			
		end
	end
end

function BeltalowdaUltimates.SaveClientUltimateWindowLocation()
	if BeltalowdaGroup.ro.roVars.positionLocked == false then
		BeltalowdaGroup.ro.roVars.clientUltimateSettings.location = BeltalowdaGroup.ro.roVars.clientUltimateSettings.location or {}
		BeltalowdaGroup.ro.roVars.clientUltimateSettings.location.x = BeltalowdaUltimates.controls.clientUltimateTLW:GetLeft()
		BeltalowdaGroup.ro.roVars.clientUltimateSettings.location.y = BeltalowdaUltimates.controls.clientUltimateTLW:GetTop()
	end
end

function BeltalowdaUltimates.SaveGroupUltimatesWindowLocation()
	if BeltalowdaGroup.ro.roVars.positionLocked == false then
		BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location = BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location or {}
		BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location.x = BeltalowdaUltimates.controls.groupUltimatesTLW:GetLeft()
		BeltalowdaGroup.ro.roVars.groupUltimatesSettings.location.y = BeltalowdaUltimates.controls.groupUltimatesTLW:GetTop()
	end
end

function BeltalowdaUltimates.SaveGroupAssignmentWindowLocation()
	if BeltalowdaGroup.ro.roVars.positionLocked == false then
		BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location = BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location or {}
		BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location.x = BeltalowdaUltimates.controls.groupAssignmentTLW:GetLeft()
		BeltalowdaGroup.ro.roVars.groupAssignmentSettings.location.y = BeltalowdaUltimates.controls.groupAssignmentTLW:GetTop()
	end
end

function BeltalowdaUltimates.SaveUltimateOverviewLocation()
	if BeltalowdaGroup.ro.roVars.positionLocked == false then
		BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location = BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location or {}
		BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location.x = BeltalowdaUltimates.controls.ultimateOverviewTLW:GetLeft()
		BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.location.y = BeltalowdaUltimates.controls.ultimateOverviewTLW:GetTop()
	end
end

function BeltalowdaUltimates.SaveGroupsGroupWindowLocation()
	if BeltalowdaGroup.ro.roVars.positionLocked == false then
		BeltalowdaGroup.ro.roVars.groups.location = BeltalowdaGroup.ro.roVars.groups.location or {}
		for i = 1, #BeltalowdaUltimates.controls.groupsTLW do
			BeltalowdaGroup.ro.roVars.groups.location[i] = BeltalowdaGroup.ro.roVars.groups.location[i] or {}
			BeltalowdaGroup.ro.roVars.groups.location[i].x = BeltalowdaUltimates.controls.groupsTLW[i]:GetLeft()
			BeltalowdaGroup.ro.roVars.groups.location[i].y = BeltalowdaUltimates.controls.groupsTLW[i]:GetTop()
		end
	end
end

function BeltalowdaUltimates.OnPlayerActivated(eventCode, initial)
	if BeltalowdaGroup.ro.roVars.enabled == true and (BeltalowdaGroup.ro.roVars.pvpOnly == false or (BeltalowdaGroup.ro.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaUltimates.state.registredGlobalConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaUltimates.networkingCallbackName, BeltalowdaUltimates.config.networkUpdateInterval, BeltalowdaUltimates.MessageUpdateLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaUltimates.messageCallbackName, BeltalowdaUltimates.config.messageUpdateInterval, BeltalowdaUltimates.NetworkLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE, BeltalowdaUltimates.config.uiUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_RESOURCES, BeltalowdaUltimates.config.uiUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaUltimates.config.buffUpdateInterval)
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaUltimates.callbackName, BeltalowdaUltimates.HandleRawNetworkMessage)
			BeltalowdaUltimates.state.registredGlobalConsumers = true
		end
		if BeltalowdaGroup.ro.roVars.groupUltimatesSettings.enabled == true or
		   BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled == true or
		   BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
			if BeltalowdaUltimates.state.registredActiveConsumers == false then
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaUltimates.uiCallbackName, BeltalowdaUltimates.config.uiUpdateInterval, BeltalowdaUltimates.UiLoop)
				BeltalowdaUltimates.state.registredActiveConsumers = true
			end
		else
			if BeltalowdaUltimates.state.registredActiveConsumers == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.uiCallbackName)
				BeltalowdaUltimates.state.registredActiveConsumers = false
			end
		end
		if BeltalowdaGroup.ro.roVars.groups.enabled == true then
			if BeltalowdaUltimates.state.registredGroupsConsumers == false then
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaUltimates.groupsUiCallbackName, BeltalowdaUltimates.config.groupsUiUpdateInterval, BeltalowdaUltimates.GroupsUiLoop)
				BeltalowdaUtilGroup.AddGroupChangedCallback(BeltalowdaUltimates.callbackName, BeltalowdaUltimates.AdjustGroupsGroups)
				BeltalowdaUtilGroup.AddUltimatesChangedCallback(BeltalowdaUltimates.callbackName, BeltalowdaUltimates.AdjustGroupsGroups)
				BeltalowdaUltimates.state.registredGroupsConsumers = true
			end
			BeltalowdaUltimates.AdjustGroupsGroups()
		else
			if BeltalowdaUltimates.state.registredGroupsConsumers == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.groupsUiCallbackName)
				BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaUltimates.callbackName)
				BeltalowdaUtilGroup.RemoveUltimatesChangedCallback(BeltalowdaUltimates.callbackName)
				BeltalowdaUltimates.state.registredGroupsConsumers = false
			end
		end
	else
		if BeltalowdaUltimates.state.registredGlobalConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.networkingCallbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.messageCallbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_RESOURCES)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaUltimates.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaUltimates.callbackName)
			BeltalowdaUltimates.state.registredGlobalConsumers = false
		end
		if BeltalowdaUltimates.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.uiCallbackName)
			BeltalowdaUltimates.state.registredActiveConsumers = false
		end
		if BeltalowdaUltimates.state.registredGroupsConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaUltimates.groupsUiCallbackName)
			BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaUltimates.callbackName)
			BeltalowdaUtilGroup.RemoveUltimatesChangedCallback(BeltalowdaUltimates.callbackName)
			BeltalowdaUltimates.state.registredGroupsConsumers = false
		end
	end
	BeltalowdaUltimates.SetControlVisibility()
end

function BeltalowdaUltimates.ShowUltimateControlOptions(control)
	if control ~= nil then
		ClearMenu()
		local ultimates = BeltalowdaUltimates.ultimates
		for i = 1, #ultimates do
			AddCustomMenuItem(ultimates[i].name, function() 
				if control.clickFunction ~= nil and type(control.clickFunction) == "function" then
					control.clickFunction(control, i)
				end
			end)
		end
		ShowMenu(control)
	end
end
	
function BeltalowdaUltimates.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaUltimates.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaUltimates.state.foreground = false
	end
	BeltalowdaUltimates.SetControlVisibility()
end

function BeltalowdaUltimates.UiLoop()
	--d("normal ui loop")
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	local playerBlocks = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl.playerBlocks
	if BeltalowdaGroup.ro.roVars.pvpOnly == false or (BeltalowdaGroup.ro.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then

		
		
		if players ~= nil then
			if playerBlocks ~= nil then
				--Update Ultimates
				local rootControl = BeltalowdaUltimates.controls.groupUltimatesTLW.rootControl
				players = BeltalowdaUltimates.AdjustPlayerOrder(players)
				BeltalowdaUltimates.state.groupUltimateStacks = {}
				BeltalowdaUltimates.state.groupUltimateAssignments = {}
				local gameTime = GetGameTimeMilliseconds()
				local groupUltimatesReady = {}
				groupUltimatesReady.destro = 0
				groupUltimatesReady.storm = 0
				groupUltimatesReady.northernStorm = 0
				groupUltimatesReady.permafrost = 0
				groupUltimatesReady.negate = 0
				groupUltimatesReady.negateOffensive = 0
				groupUltimatesReady.negateCounter = 0
				groupUltimatesReady.nova = 0
				local groupUltimatesInRange = {}
				groupUltimatesInRange.destro = 0
				groupUltimatesInRange.storm = 0
				groupUltimatesInRange.northernStorm = 0
				groupUltimatesInRange.permafrost = 0
				groupUltimatesInRange.negate = 0
				groupUltimatesInRange.negateOffensive = 0
				groupUltimatesInRange.negateCounter = 0
				groupUltimatesInRange.nova = 0

				for i = 1, #players do
					
					local resources = players[i].resources
					local isDisplayed, index = Beltalowda.IsUltimateDisplayed(resources.ultimateId)
					if isDisplayed == true and players[i].isOnline == true and BeltalowdaUltimates.constants.OFFLINE_TRESHOLD + players[i].resources.lastPing > gameTime then
						if BeltalowdaGroup.ro.roVars.groupUltimatesSettings.enabled == true then
							playerBlocks[i]:SetHidden(false)
							local stack = BeltalowdaUltimates.state.groupUltimateStacks[resources.ultimateId]
							if stack == nil then
								stack = 0
							end
							
							playerBlocks[i].ultimateProgress:SetValue(resources.ultimatePercent)
							playerBlocks[i].magickaProgress:SetValue(resources.magickaPercent)
							playerBlocks[i].staminaProgress:SetValue(resources.staminaPercent)
							-- To change the font when a player is in stealth
							if BeltalowdaGroup.ro.roVars.combinedInStealthEnabled == true then
								if players[i].isInStealth > 0 then
									playerBlocks[i].labelName:SetFont(BeltalowdaUltimates.state.cominedFontStealth)
								else
									playerBlocks[i].labelName:SetFont(BeltalowdaUltimates.state.cominedFontNormal)
								end
							else
								playerBlocks[i].labelName:SetFont(BeltalowdaUltimates.state.cominedFontNormal)
							end
							
							playerBlocks[i].labelName:SetText(players[i].name)
							playerBlocks[i]:ClearAnchors()
							playerBlocks[i]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, (index - 1) * BeltalowdaUltimates.state.playerBlockWidth + BeltalowdaUltimates.state.offset + BeltalowdaUltimates.state.spacing * (index - 1), stack * BeltalowdaUltimates.state.playerBlockHeight + BeltalowdaUltimates.state.ultiIconHeight + BeltalowdaUltimates.state.offset)
							stack = stack + 1
							BeltalowdaUltimates.state.groupUltimateStacks[resources.ultimateId] = stack
							
							if IsUnitDead(players[i].unitTag) == true then
								playerBlocks[i].frontdrop:SetHidden(false)
								playerBlocks[i].frontdrop:SetCenterColor(BeltalowdaGroup.ro.roVars.playerBlockColors.dead.r, BeltalowdaGroup.ro.roVars.playerBlockColors.dead.g, BeltalowdaGroup.ro.roVars.playerBlockColors.dead.b, 0.6)
							elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaGroup.ro.roVars.ultimates.maxDistance < players[i].distances.fromLeader then
								playerBlocks[i].frontdrop:SetHidden(false)
								playerBlocks[i].frontdrop:SetCenterColor(BeltalowdaGroup.ro.roVars.playerBlockColors.outOfRange.r, BeltalowdaGroup.ro.roVars.playerBlockColors.outOfRange.g, BeltalowdaGroup.ro.roVars.playerBlockColors.outOfRange.b, 0.8)
							else
								playerBlocks[i].frontdrop:SetHidden(true)
							end
						end
					else
						playerBlocks[i]:SetHidden(true)
					end
					if BeltalowdaGroup.ro.roVars.playerBlockColors.inCombatEnabled == true then
						local borderColor = BeltalowdaGroup.ro.roVars.playerBlockColors.borderOutOfCombat
						if players[i].isInCombat == true then
							borderColor = BeltalowdaGroup.ro.roVars.playerBlockColors.borderInCombat
						end
						playerBlocks[i].border:SetEdgeColor(borderColor.r, borderColor.g, borderColor.b, 1)
					end
					if resources.ultimatePercent == nil or resources.ultimatePercent < 100 then
						playerBlocks[i].ultimateProgress:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.progressNotFull.r, BeltalowdaGroup.ro.roVars.playerBlockColors.progressNotFull.g, BeltalowdaGroup.ro.roVars.playerBlockColors.progressNotFull.b)
						playerBlocks[i].labelName:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelNotFull.r, BeltalowdaGroup.ro.roVars.playerBlockColors.labelNotFull.g, BeltalowdaGroup.ro.roVars.playerBlockColors.labelNotFull.b)
						playerBlocks[i].labelGroup:SetText("")
						--BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetText("")
						BeltalowdaUltimates.IndexUltiGroup(players[i].unitTag, 0)
					else
						local groupIndex = 0
						local groupSize, ultimateType = BeltalowdaUltimates.GetUltimateGroupSize(resources.ultimateId)
						if ultimateType ~= nil then
							groupUltimatesReady[ultimateType] = groupUltimatesReady[ultimateType] + 1
						end
						if groupSize > 0 and IsUnitDead(players[i].unitTag) == false and players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaGroup.ro.roVars.ultimates.maxDistance >= players[i].distances.fromLeader and players[i].isOnline == true then 
							local assignment = BeltalowdaUltimates.state.groupUltimateAssignments[resources.ultimateId]
							if assignment == nil then
								assignment = 0
							end
							assignment = assignment + 1
							groupIndex = (assignment - (assignment % groupSize)) / groupSize
							if assignment % groupSize ~= 0 then
								groupIndex = groupIndex + 1
							end
							BeltalowdaUltimates.state.groupUltimateAssignments[resources.ultimateId] = assignment
							if ultimateType ~= nil then
								groupUltimatesInRange[ultimateType] = groupUltimatesInRange[ultimateType] + 1
							end
						end
						if groupIndex == 0 then
							playerBlocks[i].labelGroup:SetText("")
						elseif BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
							playerBlocks[i].labelGroup:SetText(groupIndex)
						else
							playerBlocks[i].labelGroup:SetText("")
						end
						BeltalowdaUltimates.IndexUltiGroup(players[i].unitTag, groupIndex)
						
						playerBlocks[i].ultimateProgress:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.progressFull.r, BeltalowdaGroup.ro.roVars.playerBlockColors.progressFull.g, BeltalowdaGroup.ro.roVars.playerBlockColors.progressFull.b)
						playerBlocks[i].labelName:SetColor(BeltalowdaGroup.ro.roVars.playerBlockColors.labelFull.r, BeltalowdaGroup.ro.roVars.playerBlockColors.labelFull.g, BeltalowdaGroup.ro.roVars.playerBlockColors.labelFull.b)
						
					end
					if players[i].displayName == GetUnitDisplayName("player") and players[i].charName == GetUnitName("player") then
						--d(groupIndex)
						local groupIndex = players[i].resources.ultiGroup
						if BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
							if groupIndex == 0 then
								if BeltalowdaUltimates.state.useUltimateCommandReceived == true and
								   BeltalowdaUltimates.state.useUltimateCommandTimeStamp + 3000 > GetGameTimeMilliseconds() then
									BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetText(BeltalowdaUltimates.constants.BOOM)
								else
									BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetText("")
									BeltalowdaUltimates.state.useUltimateCommandReceived = false
								end
							else
								if BeltalowdaUltimates.state.useUltimateCommandReceived == true and
								   BeltalowdaUltimates.state.useUltimateCommandTimeStamp + 3000 > GetGameTimeMilliseconds() then
									BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetText(BeltalowdaUltimates.constants.BOOM)
									--BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetHidden(false) --Bug Fix 1.12.0? failed
								else
									BeltalowdaUltimates.controls.groupAssignmentTLW.rootControl.label:SetText(groupIndex)
									BeltalowdaUltimates.state.useUltimateCommandReceived = false
								end
							end
						end
					end
				end
				for i = #players + 1, 24 do
					playerBlocks[i]:SetHidden(true)
				end
				--Update Overview
				if BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled == true and BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
					local ultimateOverviewControl = BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl
					ultimateOverviewControl.destructionLabel:SetText(string.format(string.format(BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.destro, groupUltimatesReady.destro, BeltalowdaUltimates.constants.IDENENTIFIER_DESTRUCTION)))
					ultimateOverviewControl.stormLabel:SetText(string.format(string.format(BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.storm + groupUltimatesInRange.northernStorm + groupUltimatesInRange.permafrost, groupUltimatesReady.storm + groupUltimatesReady.northernStorm + groupUltimatesReady.permafrost, BeltalowdaUltimates.constants.IDENENTIFIER_STORM)))
					ultimateOverviewControl.negateLabel:SetText(string.format(string.format(BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.negate + groupUltimatesInRange.negateOffensive + groupUltimatesInRange.negateCounter, groupUltimatesReady.negate + groupUltimatesReady.negateOffensive + groupUltimatesReady.negateCounter, BeltalowdaUltimates.constants.IDENENTIFIER_NEGATE)))
					ultimateOverviewControl.novaLabel:SetText(string.format(string.format(BeltalowdaUltimates.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.nova, groupUltimatesReady.nova, BeltalowdaUltimates.constants.IDENENTIFIER_NOVA)))
					if BeltalowdaUltimates.state.sentUltimateCommandTimeStamp + 3000 <= GetGameTimeMilliseconds() then
						ultimateOverviewControl.destructionLabel.currentBoomLabel:SetText("0")
						ultimateOverviewControl.stormLabel.currentBoomLabel:SetText("0")
						ultimateOverviewControl.negateLabel.currentBoomLabel:SetText("0")
						ultimateOverviewControl.novaLabel.currentBoomLabel:SetText("0")
					end
				end
			end
		else
			if playerBlocks ~= nil then
				for i = 1, #playerBlocks do
					playerBlocks[i]:SetHidden(true)
				end
			end
		end
	else
		if players ~= nil and playerBlocks ~= nil then
			for i = 1, #playerBlocks do
				playerBlocks[i]:SetHidden(true)
			end
		end
	end
end

function BeltalowdaUltimates.GroupsUiLoop()
	--d("groups ui loop")
	if BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_PERCENT or BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PERCENT then
		BeltalowdaUltimates.AdjustGroupsGroups()
	elseif BeltalowdaGroup.ro.roVars.groups.mode == BeltalowdaUltimates.constants.groupsModes.MODE_PRIORITY_NAME then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			local entries = BeltalowdaUltimates.controls.groupsEntries
			for i = 1, #players do
				if players[i].resources ~= nil and players[i].resources.ultimatePercent ~= nil then
					for j = 1, #entries do
						if players[i].charName == entries[j].charName and players[i].charName == entries[j].charName then
							if players[i].resources ~= nil and players[i].resources.ultimatePercent ~= nil then
								entries[j].percent:SetText(string.format("%s %%", players[i].resources.ultimatePercent))
								entries[j].progress:SetValue(players[i].resources.ultimatePercent)
							else
								entries[j].progress:SetValue(0)
							end
							local progressColor = { r = BeltalowdaGroup.ro.roVars.groups.progressFull.r, g = BeltalowdaGroup.ro.roVars.groups.progressFull.g, b = BeltalowdaGroup.ro.roVars.groups.progressFull.b, a = BeltalowdaGroup.ro.roVars.groups.progressFull.a}
							if IsUnitDead(players[i].unitTag) == true then
								progressColor.r = BeltalowdaGroup.ro.roVars.groups.dead.r
								progressColor.g = BeltalowdaGroup.ro.roVars.groups.dead.g
								progressColor.b = BeltalowdaGroup.ro.roVars.groups.dead.b
								progressColor.a = BeltalowdaGroup.ro.roVars.groups.dead.a
							elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaGroup.ro.roVars.groups.maxDistance < players[i].distances.fromLeader then
								progressColor.r = BeltalowdaGroup.ro.roVars.groups.outOfRange.r
								progressColor.g = BeltalowdaGroup.ro.roVars.groups.outOfRange.g
								progressColor.b = BeltalowdaGroup.ro.roVars.groups.outOfRange.b
								progressColor.a = BeltalowdaGroup.ro.roVars.groups.outOfRange.a
							elseif players[i].resources.ultimatePercent ~= 100 then
								progressColor.r = BeltalowdaGroup.ro.roVars.groups.progressNotFull.r
								progressColor.g = BeltalowdaGroup.ro.roVars.groups.progressNotFull.g
								progressColor.b = BeltalowdaGroup.ro.roVars.groups.progressNotFull.b
								progressColor.a = BeltalowdaGroup.ro.roVars.groups.progressNotFull.a
							end
							local labelColor = {r = BeltalowdaGroup.ro.roVars.groups.labelFull.r, g = BeltalowdaGroup.ro.roVars.groups.labelFull.g, b = BeltalowdaGroup.ro.roVars.groups.labelFull.b}
							if players[i].resources.ultimatePercent ~= 100 then
								labelColor.r = BeltalowdaGroup.ro.roVars.groups.labelNotFull.r
								labelColor.g = BeltalowdaGroup.ro.roVars.groups.labelNotFull.g
								labelColor.b = BeltalowdaGroup.ro.roVars.groups.labelNotFull.b
							end
							entries[j].progress:SetColor(progressColor.r, progressColor.g, progressColor.b, progressColor.a)
							entries[j].name:SetColor(labelColor.r, labelColor.g, labelColor.b)
							entries[j].percent:SetColor(labelColor.r, labelColor.g, labelColor.b)
							local edgeColor = BeltalowdaGroup.ro.roVars.groups.borderOutOfCombat
							if players[i].isInCombat == true then
								edgeColor = BeltalowdaGroup.ro.roVars.groups.borderInCombat
							end
							entries[j].edge:SetEdgeColor(edgeColor.r, edgeColor.g, edgeColor.b, 1)
							if BeltalowdaGroup.ro.roVars.groups.showSoftResources == true then
								entries[j].magicka:SetValue(players[i].resources.magickaPercent)
								entries[j].stamina:SetValue(players[i].resources.staminaPercent)
							end
							-- Adjust Font if in stealth
							local font = BeltalowdaUltimates.state.splitFontNormal
							if BeltalowdaGroup.ro.roVars.splitInStealthEnabled == true and players[i].isInStealth > 0 then
								font = BeltalowdaUltimates.state.splitFontStealth
							end
							entries[j].name:SetFont(font)
							entries[j].percent:SetFont(font)
						end
					end
				end
			end
		end
	end
end

function BeltalowdaUltimates.HandleRawNetworkMessage(message)
	if message ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_BOOM and BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
		--d("booom received")
		--d(message)
		if BeltalowdaUtilGroup.IsUnitGroupLeader(message.pingTag) or GetGroupSize() == 0 then
			local array = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
			local players = BeltalowdaUtilGroup.GetGroupInformation()
			--d(array)
			local sendBoom = false
			if GetGroupSize() == 0 and array[1] == 1 then
				sendBoom = true
			else
				
				if players ~= nil then
					for i = 1, #players do 
						if players[i].displayName == GetUnitDisplayName("player") and
						   players[i].charName == GetUnitName("player") then
							if array[i] == 1 then
								sendBoom = true
								break
							end
						end
					end
				end
			end
			
			if sendBoom == true then
				--d(message)
				BeltalowdaUltimates.state.useUltimateCommandReceived = true
				BeltalowdaUltimates.state.useUltimateCommandTimeStamp = GetGameTimeMilliseconds()
				if BeltalowdaGroup.ro.roVars.soundEnabled == true then
					--d(BeltalowdaGroup.ro.roVars.selectedSound)
					BeltalowdaSound.PlaySoundByName(BeltalowdaGroup.ro.roVars.selectedSound)
				end
			end
			if BeltalowdaGroup.ro.roVars.ultimateOverviewSettings.enabled == true and players ~= nil then
				BeltalowdaUltimates.state.sentUltimateCommandTimeStamp = GetGameTimeMilliseconds()
				local boom = {}
				boom.destro = 0
				boom.storm = 0
				boom.northernStorm = 0
				boom.permafrost = 0
				boom.negate = 0
				boom.negateOffensive = 0
				boom.negateCounter = 0
				boom.nova = 0
				
				for i = 1, #players do
					if array[i] == 1 then
						local size, ultimateType = BeltalowdaUltimates.GetUltimateGroupSize(players[i].resources.ultimateId)
						if ultimateType ~= nil then
							boom[ultimateType] = boom[ultimateType] + 1
						end
					end
				end
				
				local ultimateOverviewControl = BeltalowdaUltimates.controls.ultimateOverviewTLW.rootControl
				ultimateOverviewControl.destructionLabel.currentBoomLabel:SetText(boom.destro)
				ultimateOverviewControl.stormLabel.currentBoomLabel:SetText(boom.storm + boom.northernStorm + boom.permafrost)
				ultimateOverviewControl.negateLabel.currentBoomLabel:SetText(boom.negate + boom.negateOffensive + boom.negateCounter)
				ultimateOverviewControl.novaLabel.currentBoomLabel:SetText(boom.nova)
			end
			
		end
	end
end

function BeltalowdaUltimates.NetworkLoop()
	if BeltalowdaGroup.ro.roVars.pvpOnly == false or (BeltalowdaGroup.ro.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local message = BeltalowdaUltimates.state.lastMessage
		local sendMessage = false
		if message == nil or message.sent == true then
			message = {}
			message.sent = false
			sendMessage = true
		end
		
		message.b0, message.b1, message.b2, message.b3 = BeltalowdaUltimates.GetPlayerResources()
		
		if sendMessage == true then
			BeltalowdaNetworking.SendHeartbeatMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
		end
		BeltalowdaUltimates.state.lastMessage = message
	end
end

function BeltalowdaUltimates.MessageUpdateLoop()
	if BeltalowdaGroup.ro.roVars.pvpOnly == false or (BeltalowdaGroup.ro.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local message = BeltalowdaUltimates.state.lastMessage
		if message ~= nil and message.sent == false then
			message.b0, message.b1, message.b2, message.b3 = BeltalowdaUltimates.GetPlayerResources()
		end
	end
end

function BeltalowdaUltimates.OnBoomKeyBinding()
	if (BeltalowdaUtilGroup.IsPlayerGroupLeader() == true or GetGroupSize() == 0) and GetGameTimeMilliseconds() > BeltalowdaUltimates.state.lastBoom + 1000 and BeltalowdaGroup.ro.roVars.ultimates.enabled == true then
		BeltalowdaUltimates.SendBoom()
		--d("sending boom")
	end
end

-- Internal utility function - used during initialization before wrapper is loaded
function BeltalowdaUltimates.GetRoAvailableGroupsGroups()
	local groups = {}
	table.insert(groups, "-")
	table.insert(groups, BeltalowdaGroup.ro.roVars.groups.group1.name)
	table.insert(groups, BeltalowdaGroup.ro.roVars.groups.group2.name)
	table.insert(groups, BeltalowdaGroup.ro.roVars.groups.group3.name)
	table.insert(groups, BeltalowdaGroup.ro.roVars.groups.group4.name)
	table.insert(groups, BeltalowdaGroup.ro.roVars.groups.group5.name)
	return groups
end

-- Delegation function - forwards to wrapper location
function BeltalowdaUltimates.GetRoAvailableDisplayModes()
	if Beltalowda and Beltalowda.features and Beltalowda.features.ultimates and Beltalowda.features.ultimates.GetRoAvailableDisplayModes then
		return Beltalowda.features.ultimates.GetRoAvailableDisplayModes()
	end
	return {}
end

-- Delegation function - forwards to wrapper location
function BeltalowdaUltimates.GetRoAvailableUltimateSortingModes()
	if Beltalowda and Beltalowda.features and Beltalowda.features.ultimates and Beltalowda.features.ultimates.GetRoAvailableUltimateSortingModes then
		return Beltalowda.features.ultimates.GetRoAvailableUltimateSortingModes()
	end
	return {}
end

-- Delegation function - forwards to wrapper location
function BeltalowdaUltimates.GetRoAvailableSounds()
	if Beltalowda and Beltalowda.features and Beltalowda.features.ultimates and Beltalowda.features.ultimates.GetRoAvailableSounds then
		return Beltalowda.features.ultimates.GetRoAvailableSounds()
	end
	return {}
end

--menu interactions