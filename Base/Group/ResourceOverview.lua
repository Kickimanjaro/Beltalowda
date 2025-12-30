-- Beltalowda Resource Overview
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.ro = BeltalowdaGroup.ro or {}
local BeltalowdaOverview = BeltalowdaGroup.ro
BeltalowdaGroup.dbo = BeltalowdaGroup.dbo or {}
local BeltalowdaDbo = BeltalowdaGroup.dbo
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.ultimates = BeltalowdaUtil.ultimates or {}
local BeltalowdaUltimates = BeltalowdaUtil.ultimates
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

BeltalowdaOverview.constants = BeltalowdaOverview.constants or {}
BeltalowdaOverview.constants.TLW_CLIENT_ULTIMATE_NAME = "Beltalowda.group.ro.client_ultimate_TLW"
BeltalowdaOverview.constants.TLW_GROUP_ULTIMATES_NAME = "Beltalowda.group.ro.group_ultimates_TLW"
BeltalowdaOverview.constants.TLW_GROUP_ASSIGNMENT_NAME = "Beltalowda.group.ro.group_assignment_TLW"
BeltalowdaOverview.constants.TLW_ULTIMATE_OVERVIEW_NAME = "Beltalowda.group.ro.ultimate_overview_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_GROUP = {}
BeltalowdaOverview.constants.TLW_GROUPS_GROUP[1] = "Beltalowda.group.ro.groups_group_1_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_GROUP[2] = "Beltalowda.group.ro.groups_group_2_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_GROUP[3] = "Beltalowda.group.ro.groups_group_3_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_GROUP[4] = "Beltalowda.group.ro.groups_group_4_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_GROUP[5] = "Beltalowda.group.ro.groups_group_5_TLW"
BeltalowdaOverview.constants.TLW_GROUPS_EMPTY = "Beltalowda.group.ro.groups_group_EMPTY"

BeltalowdaOverview.constants.groupsModes = {}
BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME = 1
BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT = 2
BeltalowdaOverview.constants.groupsModes.MODE_PERCENT = 3

BeltalowdaOverview.constants.ultimateModes = {}
BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS = 1
BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME = 2
BeltalowdaOverview.constants.ultimateModes.ORDER_BY_GROUP = 3

BeltalowdaOverview.constants.displayModes = {}
BeltalowdaOverview.constants.displayModes.CLASSIC = 1
BeltalowdaOverview.constants.displayModes.SWIMLANES = 2

BeltalowdaOverview.constants.OFFLINE_TRESHOLD = 30000

BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING = "%d/%d %s:"

BeltalowdaOverview.constants.references = BeltalowdaOverview.constants.references or {}
BeltalowdaOverview.constants.references.GROUPS_DROPDOWN = "Beltalowda.group.ro.groups.assignment."

BeltalowdaOverview.constants.size = {}
BeltalowdaOverview.constants.size.SMALL = 1
BeltalowdaOverview.constants.size.BIG = 2

BeltalowdaOverview.callbackName = Beltalowda.addonName .. "ResourceOverview"
BeltalowdaOverview.uiCallbackName = Beltalowda.addonName .. "ResourceOverviewUI"
BeltalowdaOverview.groupsUiCallbackName = Beltalowda.addonName .. "ResourceOverviewGroupsUI"
BeltalowdaOverview.networkingCallbackName = Beltalowda.addonName .. "ResourceOverviewNetworking"
BeltalowdaOverview.messageCallbackName = Beltalowda.addonName .. "ResourceOverviewMessageUpdate"

BeltalowdaOverview.config = {}
BeltalowdaOverview.config.networkUpdateInterval = 2000
BeltalowdaOverview.config.messageUpdateInterval = 1000 -- 100
BeltalowdaOverview.config.uiUpdateInterval = 100
BeltalowdaOverview.config.groupsUiUpdateInterval = 100
BeltalowdaOverview.config.buffUpdateInterval = 100
BeltalowdaOverview.config.clientUltimate = {}
BeltalowdaOverview.config.clientUltimate.isClampedToScreen = true
BeltalowdaOverview.config.groupUltimates = {}
BeltalowdaOverview.config.groupUltimates.isClampedToScreen = true
BeltalowdaOverview.config.groupAssignments = {}
BeltalowdaOverview.config.groupAssignments.isClampedToScreen = true
BeltalowdaOverview.config.ultimateOverview = {}
BeltalowdaOverview.config.ultimateOverview.isClampedToScreen = true
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL] = {}
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight = 30
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width = 160
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height = BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight * 4
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].fontSize = 26
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG] = {}
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].blockHeight = 40
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].width = 210
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].height = BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].blockHeight * 4
BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].fontSize = 34
BeltalowdaOverview.config.font = "ZoFontGameSmall"
BeltalowdaOverview.config.sizes = {}
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL] = {}
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset = 12
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth = 50
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight = 50
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight = 25
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight = 5
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight = 5
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth = 10
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].fontSize = 13
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio = 1.0
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].border = 2
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG] = {}
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].offset = 12
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth = 70
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight = 70
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockHeight = 35
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockStaminaHeight = 7
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockMagickaHeight = 7
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockGroupWidth = 15
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].fontSize = 18
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].spacingRatio = 1.3
BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].border = 3
BeltalowdaOverview.config.swimLaneSizes = {}
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL] = {}
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].offset = 12
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth = 20
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight = 20
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth = 75
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight = 25
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight = 5
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight = 5
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth = 10
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizePlayer = 13
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizeHeader = 16
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio = 1.0
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG] = {}
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].offset = 12
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth = 40
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight = 40
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth = 150
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockHeight = 35
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockStaminaHeight = 7
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockMagickaHeight = 7
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockGroupWidth = 20
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].fontSizePlayer = 26
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].fontSizeHeader = 36
BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].spacingRatio = 2.0

BeltalowdaOverview.config.ultimateModes = {}
BeltalowdaOverview.config.groupsModes = {}
BeltalowdaOverview.config.displayModes = {}
BeltalowdaOverview.config.groups = {}
--BeltalowdaOverview.config.groups.width = 175
--BeltalowdaOverview.config.groups.height = 100
--BeltalowdaOverview.config.groups.entryWidth = 175
--BeltalowdaOverview.config.groups.entryHeight = 25
--BeltalowdaOverview.config.groups.entryPercentWidth = 50
--BeltalowdaOverview.config.groups.softHeight = 3
BeltalowdaOverview.config.groups.isClampedToScreen = true
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL] = {}
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width = 175
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height = 100
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth = 175
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight = 25
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth = 50
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight = 3
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].captionFontSize = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 8
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 13
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithoutResources = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 13
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize = 2 --not used and not working properly
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG] = {}
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].width = 225
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].height = 130
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryWidth = 225
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight = 32
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryPercentWidth = 66
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].softHeight = 4
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].captionFontSize = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight - 10
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithResources = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight - 20
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithoutResources = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight - 14
BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].edgeSize = 2 --not used and not working properly

BeltalowdaOverview.state = {}
BeltalowdaOverview.state.initialized = false
BeltalowdaOverview.state.foreground = true
BeltalowdaOverview.state.registredConsumers = false
BeltalowdaOverview.state.registredActiveConsumers = false
BeltalowdaOverview.state.registredGroupsConsumers = false
BeltalowdaOverview.state.registredGlobalConsumers = false
BeltalowdaOverview.state.lastMessage = nil
BeltalowdaOverview.state.groupUltimateStacks = {}
BeltalowdaOverview.state.groupUltimateAssignments = {}
BeltalowdaOverview.state.useUltimateCommandReceived = false
BeltalowdaOverview.state.useUltimateCommandTimeStamp = 0
BeltalowdaOverview.state.sentUltimateCommandTimeStamp = 0
BeltalowdaOverview.state.lastBoom = 0
BeltalowdaOverview.state.lastUrgentMessage = nil
BeltalowdaOverview.state.references = {}
BeltalowdaOverview.state.groupsEntryHeight = BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight
BeltalowdaOverview.state.playerBlockWidth = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth
BeltalowdaOverview.state.playerBlockHeight = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight
BeltalowdaOverview.state.ultiIconHeight = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight
BeltalowdaOverview.state.offset = BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset
BeltalowdaOverview.state.spacing = 0
BeltalowdaOverview.state.cominedFontNormal = nil
BeltalowdaOverview.state.cominedFontStealth = nil
BeltalowdaOverview.state.splitFontNormal = nil
BeltalowdaOverview.state.splitFontStealth = nil

BeltalowdaOverview.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaOverview.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaOverview.callbackName, BeltalowdaOverview.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_RESOURCEOVERVIEW_BOOM", BeltalowdaOverview.constants.TOGGLE_BOOM)
	BeltalowdaOverview.state.sounds = BeltalowdaSound.GetRestrictedSounds()
	
	BeltalowdaOverview.CreateDefaultUI()
	BeltalowdaOverview.CreateGroupsUI()
	--[[
		Finalisation
	]]
	BeltalowdaOverview.SetTlwLocation()
	BeltalowdaOverview.SetPositionLocked(BeltalowdaOverview.roVars.positionLocked)
	BeltalowdaOverview.SetDisplayedUltimates(BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates)
	BeltalowdaOverview.SetControlVisibility()
	BeltalowdaOverview.AdjustGroupsShowSoftResources()
	BeltalowdaOverview.AdjustGroupsColor()
	BeltalowdaOverview.AdjustInCombatSettings()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaOverview.SetRoPositionLocked)
		
	BeltalowdaOverview.state.initialized = true
	BeltalowdaOverview.InitializeControlSettings()
end

function BeltalowdaOverview.InitializeControlSettings()
	--BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
	BeltalowdaOverview.AdjustColors()
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
	BeltalowdaOverview.AdjustGroupNames()

	BeltalowdaOverview.AdjustSize()
	BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
end

function BeltalowdaOverview.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.ultimateOverviewSettings = {}
	defaults.ultimateOverviewSettings.enabled = false
	
	defaults.clientUltimateSettings = {}
	defaults.clientUltimateSettings.enabled = true
	
	defaults.size = BeltalowdaOverview.constants.size.SMALL
	
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
	
	defaults.displayMode = BeltalowdaOverview.constants.displayModes.CLASSIC
	
	defaults.ultimates = {}
	defaults.ultimates.enabled = true
	defaults.ultimates.sortingMode = BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS
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
	defaults.groups.mode = BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME
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
	defaults.groups.size = BeltalowdaOverview.constants.size.SMALL
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

function BeltalowdaOverview.SetEnabled(value)
	if BeltalowdaOverview.state.initialized == true and value ~= nil then
		BeltalowdaOverview.roVars.enabled = value
		if value == true then
			if BeltalowdaOverview.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaOverview.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaOverview.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaOverview.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaOverview.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaOverview.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaOverview.OnPlayerActivated)

			end
			BeltalowdaOverview.state.registredConsumers = true
		else
			if BeltalowdaOverview.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaOverview.callbackName, EVENT_ACTION_LAYER_POPPED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaOverview.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaOverview.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaOverview.state.registredConsumers = false
		end
		BeltalowdaOverview.OnPlayerActivated()
		--BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
	end
end

function BeltalowdaOverview.SetGroupsEnabled(value)
	if BeltalowdaOverview.state.initialized == true and value ~= nil then
		BeltalowdaOverview.roVars.groups.enabled = value
		BeltalowdaOverview.OnPlayerActivated()
	end
end

function BeltalowdaOverview.AdjustGroupNames()
	local state = BeltalowdaOverview.GetRoAvailableGroupsGroups()
	for i = 1, #BeltalowdaOverview.state.references do
		local control = GetWindowManager():GetControlByName(BeltalowdaOverview.state.references[i])
		if control ~= nil then
			control:UpdateChoices(state)
		end
	end
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		BeltalowdaOverview.controls.groupsTLW[i].rootControl.caption:SetText(BeltalowdaOverview.roVars.groups["group" .. i].name)
	end
end

function BeltalowdaOverview.SetTlwLocation()
	BeltalowdaOverview.controls.clientUltimateTLW:ClearAnchors()
	if BeltalowdaOverview.roVars.clientUltimateSettings.location == nil then
		BeltalowdaOverview.controls.clientUltimateTLW:SetAnchor(CENTER, GuiRoot, CENTER, -250, -150)
	else
		BeltalowdaOverview.controls.clientUltimateTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaOverview.roVars.clientUltimateSettings.location.x, BeltalowdaOverview.roVars.clientUltimateSettings.location.y)
	end
	BeltalowdaOverview.controls.groupUltimatesTLW:ClearAnchors()
	if BeltalowdaOverview.roVars.groupUltimatesSettings.location == nil then
		BeltalowdaOverview.controls.groupUltimatesTLW:SetAnchor(CENTER, GuiRoot, CENTER, 125, -150)
	else
		BeltalowdaOverview.controls.groupUltimatesTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaOverview.roVars.groupUltimatesSettings.location.x, BeltalowdaOverview.roVars.groupUltimatesSettings.location.y)
	end
	BeltalowdaOverview.controls.ultimateOverviewTLW:ClearAnchors()
	if BeltalowdaOverview.roVars.ultimateOverviewSettings.location == nil then
		BeltalowdaOverview.controls.ultimateOverviewTLW:SetAnchor(CENTER, GuiRoot, CENTER, 150, 0)
	else
		BeltalowdaOverview.controls.ultimateOverviewTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaOverview.roVars.ultimateOverviewSettings.location.x, BeltalowdaOverview.roVars.ultimateOverviewSettings.location.y)
	end
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		BeltalowdaOverview.controls.groupsTLW[i]:ClearAnchors()
		if BeltalowdaOverview.roVars.groups.location == nil or BeltalowdaOverview.roVars.groups.location[i] == nil then
			BeltalowdaOverview.controls.groupsTLW[i]:SetAnchor(CENTER, GuiRoot, CENTER, -150, -150)
		else
			BeltalowdaOverview.controls.groupsTLW[i]:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaOverview.roVars.groups.location[i].x, BeltalowdaOverview.roVars.groups.location[i].y)
		end
	end
	
end

function BeltalowdaOverview.CreateDefaultUI()
	--[[
		Client Ultimate
	]]
	BeltalowdaOverview.controls.clientUltimateTLW = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_CLIENT_ULTIMATE_NAME)
	
			
	BeltalowdaOverview.controls.clientUltimateTLW:SetClampedToScreen(BeltalowdaOverview.config.clientUltimate.isClampedToScreen)
	BeltalowdaOverview.controls.clientUltimateTLW:SetDrawLayer(0)
	BeltalowdaOverview.controls.clientUltimateTLW:SetDrawLevel(0)
	BeltalowdaOverview.controls.clientUltimateTLW:SetHandler("OnMoveStop", BeltalowdaOverview.SaveClientUltimateWindowLocation)
	BeltalowdaOverview.controls.clientUltimateTLW:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	
	BeltalowdaOverview.controls.clientUltimateTLW.rootControl = wm:CreateControl(nil, BeltalowdaOverview.controls.clientUltimateTLW, CT_CONTROL)
	local clientRootControl = BeltalowdaOverview.controls.clientUltimateTLW.rootControl
	
	clientRootControl:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	clientRootControl:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.clientUltimateTLW, TOPLEFT, 0, 0)
	
	clientRootControl.movableBackdrop = wm:CreateControl(nil, clientRootControl, CT_BACKDROP)
	
	clientRootControl.movableBackdrop:SetAnchor(TOPLEFT, clientRootControl, TOPLEFT, 0, 0)
	clientRootControl.movableBackdrop:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	
	clientRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	clientRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	clientRootControl.ultimateSelector = BeltalowdaOverview.CreateUltimateSelectorControl(clientRootControl, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset, BeltalowdaOverview.config.clientUltimate.isClampedToScreen, BeltalowdaUltimates.SetClientUltimate)
	
	local selectedIndex = 1
	if BeltalowdaOverview.charVars.ro ~= nil then
		selectedIndex = BeltalowdaUltimates.GetUltimateIndexFromUltimateId(BeltalowdaOverview.charVars.ro.selectedUltimateId)
		if selectedIndex == nil then
			selectedIndex = 1
		end
	end
	BeltalowdaUltimates.SetClientUltimate(clientRootControl.ultimateSelector, selectedIndex)
	--[[
		Group Ultimates
	]]
	BeltalowdaOverview.controls.groupUltimatesTLW = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_GROUP_ULTIMATES_NAME)
		
	BeltalowdaOverview.controls.groupUltimatesTLW:SetClampedToScreen(BeltalowdaOverview.config.groupUltimates.isClampedToScreen)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetDrawLayer(0)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetDrawLevel(0)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetHandler("OnMoveStop", BeltalowdaOverview.SaveGroupUltimatesWindowLocation)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	
	
	BeltalowdaOverview.controls.groupUltimatesTLW.rootControl = wm:CreateControl(nil, BeltalowdaOverview.controls.groupUltimatesTLW, CT_CONTROL)
	local groupsRootControl = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl
	
	groupsRootControl:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	groupsRootControl:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupUltimatesTLW, TOPLEFT, 0, 0)
	
	groupsRootControl.movableBackdrop = wm:CreateControl(nil, groupsRootControl, CT_BACKDROP)
	
	groupsRootControl.movableBackdrop:SetAnchor(TOPLEFT, groupsRootControl, TOPLEFT, 0, 0)
	groupsRootControl.movableBackdrop:SetDimensions(BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth * 12 + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
	
	groupsRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	groupsRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	groupsRootControl.ultimateSelector = {}
	for i = 1, 12 do
		groupsRootControl.ultimateSelector[i] = BeltalowdaOverview.CreateUltimateSelectorControl(groupsRootControl, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth * (i - 1)), BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset, BeltalowdaOverview.config.groupUltimates.isClampedToScreen, BeltalowdaUltimates.SetGroupUltimate)
		groupsRootControl.ultimateSelector[i].controlIndex = i
		groupsRootControl.ultimateSelector[i].label = wm:CreateControl(nil, groupsRootControl.ultimateSelector[i], CT_LABEL)
		groupsRootControl.ultimateSelector[i].label:SetHidden(true)
		groupsRootControl.ultimateSelector[i].label:SetText("")
		groupsRootControl.ultimateSelector[i].label:SetWrapMode(ELLIPSIS)
		groupsRootControl.ultimateSelector[i].label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
		BeltalowdaUltimates.SetGroupUltimate(groupsRootControl.ultimateSelector[i], BeltalowdaUltimates.GetUltimateIndexFromUltimateId(BeltalowdaOverview.roVars.groupUltimatesSettings.ultimates[i]))
	end
	
	--[[
		Group Selector Player Blocks
	]]
	groupsRootControl.playerBlocks = {}
	for i = 1, 24 do
		groupsRootControl.playerBlocks[i] = BeltalowdaOverview.CreatePlayerBlock(groupsRootControl, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight)
	end
	
	
	--[[
		Group Assignment Window
	]]
	BeltalowdaOverview.controls.groupAssignmentTLW = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_GROUP_ASSIGNMENT_NAME)
	
	if BeltalowdaOverview.roVars.groupAssignmentSettings.location == nil then
		BeltalowdaOverview.controls.groupAssignmentTLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	else
		BeltalowdaOverview.controls.groupAssignmentTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaOverview.roVars.groupAssignmentSettings.location.x, BeltalowdaOverview.roVars.groupAssignmentSettings.location.y)
	end
		
	BeltalowdaOverview.controls.groupAssignmentTLW:SetClampedToScreen(BeltalowdaOverview.config.groupAssignments.isClampedToScreen)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetDrawLayer(0)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetDrawLevel(0)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetHandler("OnMoveStop", BeltalowdaOverview.SaveGroupAssignmentWindowLocation)
		
	BeltalowdaOverview.controls.groupAssignmentTLW.rootControl = wm:CreateControl(nil, BeltalowdaOverview.controls.groupAssignmentTLW, CT_CONTROL)
	local assignmentRootControl = BeltalowdaOverview.controls.groupAssignmentTLW.rootControl
	
	
	assignmentRootControl:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupAssignmentTLW, TOPLEFT, 0, 0)
	
	assignmentRootControl.movableBackdrop = wm:CreateControl(nil, assignmentRootControl, CT_BACKDROP)
	
	assignmentRootControl.movableBackdrop:SetAnchor(TOPLEFT, assignmentRootControl, TOPLEFT, 0, 0)
		
	assignmentRootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	assignmentRootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	assignmentRootControl.label = wm:CreateControl(nil, assignmentRootControl, CT_LABEL)
	assignmentRootControl.label:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	assignmentRootControl.label:SetWrapMode(ELLIPSIS)
	
	
	assignmentRootControl.label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	assignmentRootControl.label:SetColor(BeltalowdaOverview.roVars.assignmentColor.r, BeltalowdaOverview.roVars.assignmentColor.g, BeltalowdaOverview.roVars.assignmentColor.b, 1)
	BeltalowdaOverview.AdjustAssignmentControlSize()
	
	--[[
		Group Overview Window
	]]
	BeltalowdaOverview.controls.ultimateOverviewTLW = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_ULTIMATE_OVERVIEW_NAME)

	
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetClampedToScreen(BeltalowdaOverview.config.ultimateOverview.isClampedToScreen)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetDrawLayer(0)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetDrawLevel(0)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetHandler("OnMoveStop", BeltalowdaOverview.SaveUltimateOverviewLocation)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetDimensions(BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height)
	
	BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl = wm:CreateControl(nil, BeltalowdaOverview.controls.ultimateOverviewTLW, CT_CONTROL)
	
	local ultimateOverviewControl = BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl
	ultimateOverviewControl:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.ultimateOverviewTLW, TOPLEFT, 0, 0)
	ultimateOverviewControl:SetDimensions(BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height)
	
	ultimateOverviewControl.movableBackdrop = wm:CreateControl(nil, ultimateOverviewControl, CT_BACKDROP)
	ultimateOverviewControl.movableBackdrop:SetDimensions(BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height)
	ultimateOverviewControl.movableBackdrop:SetAnchor(TOPLEFT, ultimateOverviewControl, TOPLEFT, 0, 0)
		
	ultimateOverviewControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	ultimateOverviewControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	ultimateOverviewControl.destructionLabel = BeltalowdaOverview.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight, 0, BeltalowdaOverview.constants.IDENENTIFIER_DESTRUCTION)
	ultimateOverviewControl.stormLabel = BeltalowdaOverview.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight, BeltalowdaOverview.constants.IDENENTIFIER_STORM)
	ultimateOverviewControl.negateLabel = BeltalowdaOverview.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight * 2, BeltalowdaOverview.constants.IDENENTIFIER_NEGATE)
	ultimateOverviewControl.novaLabel = BeltalowdaOverview.CreateUltimateOverviewLabel(ultimateOverviewControl, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight, BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight * 3, BeltalowdaOverview.constants.IDENENTIFIER_NOVA)
		
	
end

function BeltalowdaOverview.CreateUltimateOverviewLabel(parent, width, height, offset, text)
	local control = wm:CreateControl(nil, parent, CT_LABEL)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, 5, offset)
	control:SetFont(BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK))
	control:SetWrapMode(ELLIPSIS)
	control:SetDimensions(width - 20, height)
	control:SetText(string.format(BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING, 0, 0, text))
	control.currentBoomLabel = wm:CreateControl(nil, parent, CT_LABEL)
	control.currentBoomLabel:SetAnchor(TOPLEFT, parent, TOPLEFT, width - 20, offset)
	control.currentBoomLabel:SetFont(BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK))
	control.currentBoomLabel:SetWrapMode(ELLIPSIS)
	control.currentBoomLabel:SetDimensions(20, height)
	control.currentBoomLabel:SetText("0")
	return control
end

function BeltalowdaOverview.CreateUltimateSelectorControl(parent, width, height, offsetX, offsetY, isClampedToScreen, clickFunction)
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
	button:SetHandler("OnClicked", function () BeltalowdaOverview.ShowUltimateControlOptions(control) end)
	button:SetDrawTier(1)
	
	control.texture = wm:CreateControl(nil, parent, CT_TEXTURE)
	local texture = control.texture
	texture:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 2)
	texture:SetDimensions(width - 4, height - 4)
	texture:SetTexture("/esoui/art/icons/icon_missing.dds")
	texture:SetDrawTier(0)
	return control
end

function BeltalowdaOverview.CreatePlayerBlock(parent, width, height, blockGroupWidth, blockMagickaHeight, blockStaminaHeight)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(width, height)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)
	
	control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.backdrop:SetDimensions(width, height)
	control.backdrop:SetDrawTier(0)
	control.backdrop:SetCenterColor(BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.r, BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.g, BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.b, 0.8)
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
	control.labelName:SetFont(BeltalowdaOverview.config.font)
	control.labelName:SetWrapMode(ELLIPSIS)
	control.labelName:SetDimensions(width - blockGroupWidth - 2, height - blockMagickaHeight - blockStaminaHeight - 4)
	control.labelName:SetText("")
	control.labelName:SetDrawTier(2)
	control.labelName:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.labelGroup = wm:CreateControl(nil, control, CT_LABEL)
	control.labelGroup:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 0)
	control.labelGroup:SetFont(BeltalowdaOverview.config.font)
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
	control.border:SetEdgeTexture(nil, 1, 1, BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].border, 0)
	control.border:SetCenterColor(0, 0, 0, 0)
	control.border:SetEdgeColor(BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat.r, BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat.g, BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat.b, 1)
	control.border:SetDrawTier(2)
	control.border:SetHidden(true)
	
	control:SetHidden(true)
	return control
end

function BeltalowdaOverview.CreateGroupsUI()
	BeltalowdaOverview.controls.groupsTLW = {}
	BeltalowdaOverview.controls.groupsEntries = {}
	for i = 1, 5 do
		local tlw = BeltalowdaOverview.CreateGroupsGroupWindow(i)
		table.insert(BeltalowdaOverview.controls.groupsTLW, tlw)
	end
	BeltalowdaOverview.controls.groupsEmptyTLW = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_GROUPS_EMPTY)
	BeltalowdaOverview.controls.groupsEmptyTLW:SetDimensions(0,0)
	BeltalowdaOverview.controls.groupsEmptyTLW:SetHidden(true)
	for i = 1, 24 do
		local entry = BeltalowdaOverview.CreateGroupsEntryControl(BeltalowdaOverview.controls.groupsEmptyTLW)
		table.insert(BeltalowdaOverview.controls.groupsEntries, entry)
	end
end

function BeltalowdaOverview.CreateGroupsGroupWindow(index)
	local captionFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].captionFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)

	local tlw = wm:CreateTopLevelWindow(BeltalowdaOverview.constants.TLW_GROUPS_GROUP[index])
	
	tlw:SetClampedToScreen(BeltalowdaOverview.config.groups.isClampedToScreen)
	tlw:SetDrawLayer(0)
	tlw:SetDrawLevel(0)
	tlw:SetHandler("OnMoveStop", BeltalowdaOverview.SaveGroupsGroupWindowLocation)
	tlw:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height)
	
	tlw.rootControl = wm:CreateControl(nil, tlw, CT_CONTROL)
	local rootControl = tlw.rootControl
	
	rootControl:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height)
	rootControl:SetAnchor(TOPLEFT, tlw, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.caption = wm:CreateControl(nil, rootControl, CT_LABEL)
	rootControl.caption:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 2, 0)
	rootControl.caption:SetFont(captionFont)
	rootControl.caption:SetWrapMode(ELLIPSIS)
	rootControl.caption:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight)
	rootControl.caption:SetText("")
	rootControl.caption:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	rootControl.caption:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	
	return tlw
end

function BeltalowdaOverview.CreateGroupsEntryControl(parent)
	if parent ~= nil then
		local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local control = wm:CreateControl(nil, parent, CT_CONTROL)
		
		control:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight)
		control:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, 0)
		
		control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.backdrop:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight)
		control.backdrop:SetCenterColor(1, 0, 0, 0.0)
		control.backdrop:SetEdgeColor(1, 0, 0, 0.0)
	
		control.edge = wm:CreateControl(nil, control, CT_BACKDROP)
		control.edge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.edge:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight)
		control.edge:SetEdgeTexture(nil, 1, 1, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize, 0)
		control.edge:SetCenterColor(0, 0, 0, 0)
		control.edge:SetEdgeColor(BeltalowdaOverview.roVars.groups.borderOutOfCombat.r, BeltalowdaOverview.roVars.groups.borderOutOfCombat.g, BeltalowdaOverview.roVars.groups.borderOutOfCombat.b, 1)
		
		control.progress = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 2, 2)
		control.progress:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 4)
		control.progress:SetMinMax(0, 100)
		control.progress:SetValue(0)
		
		control.softBackdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.softBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 2, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight * 2 - 2)
		control.softBackdrop:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight * 2)
		control.softBackdrop:SetCenterColor(1, 0, 0, 0.0)
		control.softBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		
		control.magicka = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.magicka:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 2, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight * 2 - 2)
		control.magicka:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight)
		control.magicka:SetMinMax(0, 100)
		control.magicka:SetValue(0)
		
		control.stamina = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.stamina:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 2, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight - 2)
		control.stamina:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight)
		control.stamina:SetMinMax(0, 100)
		control.stamina:SetValue(0)
		
		control.name = wm:CreateControl(nil, control, CT_LABEL)
		control.name:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups.entryHeight, 0)
		control.name:SetFont(font)
		control.name:SetWrapMode(ELLIPSIS)
		control.name:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 4)
		control.name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		
		control.percent = wm:CreateControl(nil, control, CT_LABEL)
		control.percent:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth) - 2, 0)
		control.percent:SetFont(font)
		control.percent:SetWrapMode(ELLIPSIS)
		control.percent:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 4)
		control.percent:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.percent:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
		
		control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
		control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 2)
		control.texture:SetDimensions(BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 4, BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight - 4)

		
		return control
	end
	
	return nil
end

function BeltalowdaUltimates.SetClientUltimate(control, ultimateIndex)
	if ultimateIndex ~= nil and control ~= nil then
		local ultimates = BeltalowdaUltimates.ultimates
		if ultimateIndex > 0 and ultimateIndex <= #ultimates then
			BeltalowdaOverview.charVars.ro.selectedUltimateId = ultimates[ultimateIndex].id
			BeltalowdaOverview.state.selectedClientUltimate = ultimates[ultimateIndex]
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
			BeltalowdaOverview.roVars.groupUltimatesSettings.ultimates[controlIndex] = ultimates[ultimateIndex].id
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

function BeltalowdaOverview.SetPositionLocked(value)
	BeltalowdaOverview.roVars.positionLocked = value
	BeltalowdaOverview.controls.clientUltimateTLW:SetMovable(not value)
	BeltalowdaOverview.controls.clientUltimateTLW:SetMouseEnabled(not value)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetMovable(not value)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetMouseEnabled(not value)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetMovable(not value)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetMouseEnabled(not value)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetMovable(not value)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetMouseEnabled(not value)
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		BeltalowdaOverview.controls.groupsTLW[i]:SetMovable(not value)
		BeltalowdaOverview.controls.groupsTLW[i]:SetMouseEnabled(not value)
	end
	if value == true then
		BeltalowdaOverview.controls.clientUltimateTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.clientUltimateTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetCenterColor(0.2, 0.2, 0.2, 0.4)
		BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		for i = 1, #BeltalowdaOverview.controls.groupsTLW do
			BeltalowdaOverview.controls.groupsTLW[i].rootControl.movableBackdrop:SetCenterColor(1, 0.0, 0.0, 0.0)
			BeltalowdaOverview.controls.groupsTLW[i].rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		end
	else
		BeltalowdaOverview.controls.clientUltimateTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaOverview.controls.clientUltimateTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		for i = 1, #BeltalowdaOverview.controls.groupsTLW do
			BeltalowdaOverview.controls.groupsTLW[i].rootControl.movableBackdrop:SetCenterColor(1, 0.0, 0.0, 0.5)
			BeltalowdaOverview.controls.groupsTLW[i].rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		end
	end
end

function BeltalowdaOverview.AdjustInCombatSettings()
	local playerBlocks = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.playerBlocks
	for i = 1, #playerBlocks do
		playerBlocks[i].border:SetHidden(not BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled)
		--d(not BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled)
	end
end

function BeltalowdaOverview.SetDisplayedUltimates(value)
	if value ~= nil and value > 0 and value <= 12 then
		local sizeIncrease = BeltalowdaOverview.roVars.size - BeltalowdaOverview.constants.size.SMALL
		local ultiIconWidth = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
		local offset = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].offset - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset) * sizeIncrease)
		local ultiIconHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
		
		BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates = value
		local groupsRootControl = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl
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
		BeltalowdaOverview.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		if BeltalowdaOverview.roVars.displayMode == BeltalowdaOverview.constants.displayModes.CLASSIC then
			groupsRootControl:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
			groupsRootControl.movableBackdrop:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + offset * 2)
			BeltalowdaOverview.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		else
			local playerBlockWidth = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
			local ultiIconHeight = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
			groupsRootControl:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].offset * 2)
			groupsRootControl.movableBackdrop:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + offset * 2)
			BeltalowdaOverview.controls.groupUltimatesTLW:SetDimensions(playerBlockWidth * value + offset * 2 + BeltalowdaOverview.state.spacing * (value - 1), ultiIconHeight + offset * 2)
		end
	end
end

function BeltalowdaOverview.SetControlVisibility()
	local enabled = BeltalowdaOverview.roVars.enabled
	local clientEnabled = BeltalowdaOverview.roVars.clientUltimateSettings.enabled
	local groupEnabled = BeltalowdaOverview.roVars.groupUltimatesSettings.enabled
	local overviewEnabled = BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled
	local pvpOnly = BeltalowdaOverview.roVars.pvpOnly
	local ultimateGroupsEnabled = BeltalowdaOverview.roVars.ultimates.enabled
	local groupsEnabledVal = BeltalowdaOverview.roVars.groups.enabled
	local groupsEnabled = {}
	local setClientHidden = true
	local setGroupHidden = true
	local setAssignmentHidden = true
	local setOverviewHidden = true
	local setGroupsHidden = {}
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		setGroupsHidden[i] = true
		groupsEnabled[i] = BeltalowdaOverview.roVars.groups["group" .. i].enabled
	end
	if enabled ~= nil and clientEnabled ~= nil and groupEnabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) --[[and BeltalowdaOverview.state.foreground == true]] then
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
				for i = 1, #BeltalowdaOverview.controls.groupsTLW do
					if groupsEnabled[i] == true then
						setGroupsHidden[i] = false
					end
				end
			end
		end
	end
	BeltalowdaOverview.controls.clientUltimateTLW:SetHidden(setClientHidden)
	BeltalowdaOverview.controls.groupUltimatesTLW:SetHidden(setGroupHidden)
	BeltalowdaOverview.controls.groupAssignmentTLW:SetHidden(setAssignmentHidden)
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetHidden(setOverviewHidden)
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		BeltalowdaOverview.controls.groupsTLW[i]:SetHidden(setGroupsHidden[i])
		--BeltalowdaOverview.controls.groupsTLW[i]:SetHidden(false)
	end
end

function BeltalowdaOverview.GetAbilityCost(ultimateId)
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

function BeltalowdaOverview.GetPlayerDebuffs()
	return BeltalowdaDbo.GetPlayerDebuffs()
end

function BeltalowdaOverview.GetPlayerResources()	
	local currentStamina, maxStamina = GetUnitPower("player", POWERTYPE_STAMINA)
	local currentMagicka, maxMagicka = GetUnitPower("player", POWERTYPE_MAGICKA)
	local currentUltimate, maxUltimate = GetUnitPower("player", POWERTYPE_ULTIMATE)
	
	local ultimate = math.floor((currentUltimate / BeltalowdaOverview.GetAbilityCost(BeltalowdaOverview.charVars.ro.selectedUltimateId)) * 100)
	if ultimate > 100 then
		ultimate = 100
	end
	local magicka = math.floor((currentMagicka / maxMagicka) * 100)
	local stamina = math.floor((currentStamina / maxStamina) * 100)
	local debuffs = BeltalowdaOverview.GetPlayerDebuffs()
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
	return BeltalowdaOverview.charVars.ro.selectedUltimateId, ultimate, magicka, stamina
end

function BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
	local playerBlocks = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.playerBlocks
	if playerBlocks ~= nil then
		--BeltalowdaOverview.AdjustSize()
		local sizeIncrease = BeltalowdaOverview.roVars.size - BeltalowdaOverview.constants.size.SMALL
		--local playerBlockWidth = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
		local playerBlockHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
		local playerBlockMagickaHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
		local playerBlockStaminaHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
		local playerBlockWidth = BeltalowdaOverview.state.playerBlockWidth
		for i = 1, #playerBlocks do
			playerBlocks[i].magickaProgress:SetHidden(not BeltalowdaOverview.roVars.showSoftResources)
			playerBlocks[i].staminaProgress:SetHidden(not BeltalowdaOverview.roVars.showSoftResources)
			
			if BeltalowdaOverview.roVars.showSoftResources == true then
				playerBlocks[i].ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight - playerBlockMagickaHeight - playerBlockStaminaHeight)
				
			else
				playerBlocks[i].ultimateProgress:SetDimensions(playerBlockWidth, playerBlockHeight)
				
			end
		end
		--BeltalowdaOverview.AdjustSize()
	end
end

function BeltalowdaOverview.AdjustColors()
	local playerBlocks = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.playerBlocks
	if playerBlocks ~= nil then
		for i = 1, #playerBlocks do
			playerBlocks[i].magickaProgress:SetColor(BeltalowdaOverview.roVars.playerBlockColors.magicka.r, BeltalowdaOverview.roVars.playerBlockColors.magicka.g, BeltalowdaOverview.roVars.playerBlockColors.magicka.b, 1.0)
			playerBlocks[i].staminaProgress:SetColor(BeltalowdaOverview.roVars.playerBlockColors.stamina.r, BeltalowdaOverview.roVars.playerBlockColors.stamina.g, BeltalowdaOverview.roVars.playerBlockColors.stamina.b, 1.0)
			playerBlocks[i].backdrop:SetCenterColor(BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.r, BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.g, BeltalowdaOverview.roVars.playerBlockColors.defaultBackground.b, 0.8)
			playerBlocks[i].backdrop:SetEdgeColor(0,0,0,0)
			playerBlocks[i].labelGroup:SetColor(BeltalowdaOverview.roVars.playerBlockColors.labelGroup.r, BeltalowdaOverview.roVars.playerBlockColors.labelGroup.g, BeltalowdaOverview.roVars.playerBlockColors.labelGroup.b)
		end
	end
end

function BeltalowdaOverview.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
	if playerA.resources == nil or playerA.resources.ultimateAssignment == nil or
	   playerB.resources == nil or playerB.resources.ultimateAssignment == nil then
		if (playerA.resources == nil or playerA.resources.ultimateAssignment == nil) and 
		   (playerB.resources ~= nil and playerB.resources.ultimateAssignment ~= nil) then
			return false
		elseif (playerA.resources ~= nil and playerA.resources.ultimateAssignment ~= nil) and 
		   (playerB.resources == nil or playerB.resources.ultimateAssignment == nil) then
			return true
		else
			return BeltalowdaOverview.ComparePlayersByUltiThenName(playerA, playerB)
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

function BeltalowdaOverview.SortPlayersByUlti(oldPlayerList)
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

	table.sort(players, BeltalowdaOverview.ComparePlayersByUltiAssignmentThenPercent)

	for i = 1, #players do
		if players[i].resources.ultimateAssignment ~= nil then
			players[i].resources.ultimateAssignment = i
			players[i].resources.oldReference.resources.ultimateAssignment = i
		end
	end
	return players
end

function BeltalowdaOverview.ComparePlayersByUltiThenName(playerA, playerB)
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

function BeltalowdaOverview.AdjustPlayerOrder(oldPlayerList)
	local players = {}
	if oldPlayerList ~= Nil then
		--[[
		if BeltalowdaOverview.roVars.ultimates.sortingMode == BeltalowdaOverview.constants.ultimateModes.ORDER_BY_GROUP then
		
		elseif BeltalowdaOverview.roVars.ultimates.sortingMode == BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS then
		
		elseif BeltalowdaOverview.roVars.ultimates.sortingMode == BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME then
		]]
		
		if BeltalowdaOverview.roVars.ultimates.sortingMode == BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME then
			for i = 1, #oldPlayerList do
				players[i] = oldPlayerList[i]
			end
			table.sort(players, BeltalowdaOverview.ComparePlayersByUltiThenName)
		elseif BeltalowdaOverview.roVars.ultimates.sortingMode == BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS then
			players = BeltalowdaOverview.SortPlayersByUlti(oldPlayerList)
		end
		--[[end]]
	end
	return players
end

function Beltalowda.IsUltimateDisplayed(ultimateId)
	local isDisplayed = false
	local index = 0
	if ultimateId ~= nil then
		local displayedUltimates = BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates
		local ultimates = BeltalowdaOverview.roVars.groupUltimatesSettings.ultimates
		for i = 1, displayedUltimates do
			if BeltalowdaOverview.roVars.groupUltimatesSettings.ultimates[i] == ultimateId then
				isDisplayed = true
				index = i
				break
			end
		end
	end
	return isDisplayed, index
end

function BeltalowdaOverview.GetUltimateGroupSize(ultimateId)
	local groupSize = 0
	local ultimateType = nil
	if ultimateId == 1 then --Negate
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeNegate
		ultimateType = "negate"
	elseif ultimateId == 5 then --Nova
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeNova
		ultimateType = "nova"
	elseif ultimateId == 13 then --Storm
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeStorm
		ultimateType = "storm"
	elseif ultimateId == 15 then --Destro
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeDestro
		ultimateType = "destro"
	elseif ultimateId == 29 then --Negate Offensive
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeNegateOffensive
		ultimateType = "negateOffensive"
	elseif ultimateId == 30 then --Negate Counter
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeNegateCounter
		ultimateType = "negateCounter"
	elseif ultimateId == 35 then --Storm
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizeNorthernStorm
		ultimateType = "northernStorm"
	elseif ultimateId == 36 then --Storm
		groupSize = BeltalowdaOverview.roVars.ultimates.groupSizePermafrost
		ultimateType = "permafrost"
	end
	return groupSize, ultimateType
end

function BeltalowdaOverview.SendBoom()
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_BOOM
	local array = BeltalowdaOverview.GetGroupUltiArray()
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
				zo_callLater(BeltalowdaOverview.SendBoom, 500)
			end
		elseif mode == BeltalowdaNetworking.constants.urgentMode.CRITICAL then]]
		if BeltalowdaOverview.state.lastUrgentMessage == nil or BeltalowdaOverview.state.lastUrgentMessage.sent == true then
			BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.CRITICAL)
			BeltalowdaOverview.state.lastUrgentMessage = message
		else
			BeltalowdaOverview.state.lastUrgentMessage.b1 = message.b1
			BeltalowdaOverview.state.lastUrgentMessage.b2 = message.b2
			BeltalowdaOverview.state.lastUrgentMessage.b3 = message.b3
		end
		--end
	end
	array = nil
	BeltalowdaOverview.state.lastBoom = GetGameTimeMilliseconds()
end

function BeltalowdaOverview.GetGroupUltiArray()
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

function BeltalowdaOverview.IndexUltiGroup(unitTag, groupId)
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	if players ~= nil then
		for i = 1, #players do
			if players[i].unitTag == unitTag then
				players[i].resources.ultiGroup = groupId
			end
		end
	end
end

function BeltalowdaOverview.AdjustAssignmentControlSize()
	local assignmentRootControl = BeltalowdaOverview.controls.groupAssignmentTLW.rootControl
	BeltalowdaOverview.controls.groupAssignmentTLW:SetDimensions(BeltalowdaOverview.roVars.assignmentSize * 2.5, BeltalowdaOverview.roVars.assignmentSize)
	assignmentRootControl:SetDimensions(BeltalowdaOverview.roVars.assignmentSize * 2.5, BeltalowdaOverview.roVars.assignmentSize)
	assignmentRootControl.movableBackdrop:SetDimensions(BeltalowdaOverview.roVars.assignmentSize * 2.5, BeltalowdaOverview.roVars.assignmentSize)
	assignmentRootControl.label:SetDimensions(BeltalowdaOverview.roVars.assignmentSize * 2.5, BeltalowdaOverview.roVars.assignmentSize)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaOverview.roVars.assignmentSize - 10, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	assignmentRootControl.label:SetFont(font)
end

function BeltalowdaOverview.GetGroupNameFromIndex(index)
	if index == nil or index == 0 then
		return "-"
	else
		return BeltalowdaOverview.roVars.groups["group" .. (index)].name
	end
end

function BeltalowdaOverview.GetGroupIndexFromName(value)
	if value == "-" then
		return 0
	else
		for i = 1, 5 do
			if BeltalowdaOverview.roVars.groups["group" .. (i)].name == value then
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
	local config = BeltalowdaOverview.roVars.groups.ultimateGroups
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
	local config = BeltalowdaOverview.roVars.groups.ultimateGroups
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
			return BeltalowdaOverview.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
		end
		--return BeltalowdaOverview.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
	end
end

function BeltalowdaUtilGroup.SortPlayersByGroupsModePercent(playerA, playerB)
	return BeltalowdaOverview.ComparePlayersByUltiAssignmentThenPercent(playerA, playerB)
end

function BeltalowdaOverview.AdjustGroupsShowSoftResources()
	local entries = BeltalowdaOverview.controls.groupsEntries
	local setHidden = BeltalowdaOverview.roVars.groups.showSoftResources
	local sizeIncrease = BeltalowdaOverview.roVars.groups.size - BeltalowdaOverview.constants.size.SMALL
	local entryWidth = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth) * sizeIncrease)
	local entryHeight = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight) * sizeIncrease)
	local softHeight = 0
	local fontSize = 0
	local edgeSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].edgeSize - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize) * sizeIncrease)
	if setHidden == true then
		softHeight = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].softHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight) * sizeIncrease)
		fontSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithResources - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources) * sizeIncrease)
	else
		fontSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithoutResources + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithoutResources - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithoutResources) * sizeIncrease)
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

function BeltalowdaOverview.AdjustGroupsColor()
	local entries = BeltalowdaOverview.controls.groupsEntries
	local bgColor = BeltalowdaOverview.roVars.groups.backdropColor
	local magickaColor = BeltalowdaOverview.roVars.groups.magicka
	local staminaColor = BeltalowdaOverview.roVars.groups.stamina
	for	i = 1, #entries do
		entries[i].backdrop:SetCenterColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
		entries[i].softBackdrop:SetCenterColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
		entries[i].magicka:SetColor(magickaColor.r, magickaColor.g, magickaColor.b, magickaColor.a)
		entries[i].stamina:SetColor(staminaColor.r, staminaColor.g, staminaColor.b, staminaColor.a)
	end
end

function BeltalowdaOverview.SortGroupsPlayersByUlti(oldPlayerList)
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
	if BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT then
		table.sort(players, BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityPercent)
	elseif BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PERCENT then
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
		if BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME then
			table.sort(players, BeltalowdaUtilGroup.SortPlayersByGroupsModePriorityName)
		elseif BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT then
			players = BeltalowdaOverview.SortGroupsPlayersByUlti(oldPlayerList)
		elseif BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PERCENT then
			players = BeltalowdaOverview.SortGroupsPlayersByUlti(oldPlayerList)
		end
	end	
	return players
end

function BeltalowdaOverview.AdjustGroupsGroups()
	--d("adjust groups groups")
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	if players ~= nil then
		players = BeltalowdaUtilGroup.SortPlayersForGroupEntries(players)
		local currentIndex = {}
		for i = 1, #BeltalowdaOverview.controls.groupsTLW do
			currentIndex[i] = 1
		end
		local config = BeltalowdaOverview.roVars.groups.ultimateGroups
		
		for i = 1, #players do
			if players[i].resources.ultimateId ~= nil then
				local ultimateIndex = BeltalowdaUltimates.GetUltimateIndexFromUltimateId(players[i].resources.ultimateId)
				local groupId = config[ultimateIndex].group
				if groupId ~= nil and groupId ~= 0 then
					local entry = BeltalowdaOverview.controls.groupsEntries[i]
					entry:ClearAnchors()
					local heightOffset = currentIndex[groupId] * (BeltalowdaOverview.state.groupsEntryHeight + 2)
					entry:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupsTLW[groupId].rootControl,TOPLEFT, 0, heightOffset)
					entry:SetParent(BeltalowdaOverview.controls.groupsTLW[groupId].rootControl)
					currentIndex[groupId] = currentIndex[groupId] + 1
					entry.charName = players[i].charName
					entry.displayName = players[i].displayName
					entry.unitTag = players[i].unitTag
					entry.name:SetText(players[i].name)
					entry.texture:SetTexture(BeltalowdaUltimates.ultimates[ultimateIndex].icon)
					if BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT or BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PERCENT then
						if players[i].resources ~= nil and players[i].resources.ultimatePercent ~= nil then
							entry.percent:SetText(string.format("%s %%", players[i].resources.ultimatePercent))
							entry.progress:SetValue(players[i].resources.ultimatePercent)
						else
							entry.progress:SetValue(0)
						end
						local progressColor = { r = BeltalowdaOverview.roVars.groups.progressFull.r, g = BeltalowdaOverview.roVars.groups.progressFull.g, b = BeltalowdaOverview.roVars.groups.progressFull.b, a = BeltalowdaOverview.roVars.groups.progressFull.a}
						if IsUnitDead(players[i].unitTag) == true then
							progressColor.r = BeltalowdaOverview.roVars.groups.dead.r
							progressColor.g = BeltalowdaOverview.roVars.groups.dead.g
							progressColor.b = BeltalowdaOverview.roVars.groups.dead.b
							progressColor.a = BeltalowdaOverview.roVars.groups.dead.a
						elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaOverview.roVars.groups.maxDistance < players[i].distances.fromLeader then
							progressColor.r = BeltalowdaOverview.roVars.groups.outOfRange.r
							progressColor.g = BeltalowdaOverview.roVars.groups.outOfRange.g
							progressColor.b = BeltalowdaOverview.roVars.groups.outOfRange.b
							progressColor.a = BeltalowdaOverview.roVars.groups.outOfRange.a
						elseif players[i].resources.ultimatePercent ~= 100 then
							progressColor.r = BeltalowdaOverview.roVars.groups.progressNotFull.r
							progressColor.g = BeltalowdaOverview.roVars.groups.progressNotFull.g
							progressColor.b = BeltalowdaOverview.roVars.groups.progressNotFull.b
							progressColor.a = BeltalowdaOverview.roVars.groups.progressNotFull.a
						end
						local labelColor = {r = BeltalowdaOverview.roVars.groups.labelFull.r, g = BeltalowdaOverview.roVars.groups.labelFull.g, b = BeltalowdaOverview.roVars.groups.labelFull.b}
						if players[i].resources.ultimatePercent ~= 100 then
							labelColor.r = BeltalowdaOverview.roVars.groups.labelNotFull.r
							labelColor.g = BeltalowdaOverview.roVars.groups.labelNotFull.g
							labelColor.b = BeltalowdaOverview.roVars.groups.labelNotFull.b
						end
						entry.progress:SetColor(progressColor.r, progressColor.g, progressColor.b, progressColor.a)
						entry.name:SetColor(labelColor.r, labelColor.g, labelColor.b)
						entry.percent:SetColor(labelColor.r, labelColor.g, labelColor.b)
						local edgeColor = BeltalowdaOverview.roVars.groups.borderOutOfCombat
						if players[i].isInCombat == true then
							edgeColor = BeltalowdaOverview.roVars.groups.borderInCombat
						end
						entry.edge:SetEdgeColor(edgeColor.r, edgeColor.g, edgeColor.b, 1)
						if BeltalowdaOverview.roVars.groups.showSoftResources == true then
							entry.magicka:SetValue(players[i].resources.magickaPercent)
							entry.stamina:SetValue(players[i].resources.staminaPercent)
						end
					end
				else
					BeltalowdaOverview.controls.groupsEntries[i]:ClearAnchors()
					BeltalowdaOverview.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
					BeltalowdaOverview.controls.groupsEntries[i]:SetParent(BeltalowdaOverview.controls.groupsEmptyTLW)
				end
			else
				BeltalowdaOverview.controls.groupsEntries[i]:ClearAnchors()
				BeltalowdaOverview.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
				BeltalowdaOverview.controls.groupsEntries[i]:SetParent(BeltalowdaOverview.controls.groupsEmptyTLW)
			end
		end
		for i = #players + 1, 24 do
			BeltalowdaOverview.controls.groupsEntries[i]:ClearAnchors()
			BeltalowdaOverview.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
			BeltalowdaOverview.controls.groupsEntries[i]:SetParent(BeltalowdaOverview.controls.groupsEmptyTLW)
		end
	else
		for i = 1, #BeltalowdaOverview.controls.groupsEntries do
			BeltalowdaOverview.controls.groupsEntries[i]:ClearAnchors()
			BeltalowdaOverview.controls.groupsEntries[i]:SetAnchor(TOPLEFT, BeltalowdaOverview.controls.groupsEmptyTLW,TOPLEFT, 0, 0)
			BeltalowdaOverview.controls.groupsEntries[i]:SetParent(BeltalowdaOverview.controls.groupsEmptyTLW)
		end
	end
end

function BeltalowdaOverview.AdjustDisplayMode()
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaOverview.AdjustSize()
	--Primary Mode Configuration
	local sizeIncrease = BeltalowdaOverview.roVars.size - BeltalowdaOverview.constants.size.SMALL
	local playerBlockWidth = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
	local playerBlockHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
	local ultiIconHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
	local offset = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].offset - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].offset) * sizeIncrease)
	local ultiIconWidth = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
	BeltalowdaOverview.state.playerBlockWidth = playerBlockWidth
	BeltalowdaOverview.state.playerBlockHeight = playerBlockHeight
	BeltalowdaOverview.state.ultiIconHeight = ultiIconHeight
	BeltalowdaOverview.state.offset = offset
	local blockMagickaHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
	local blockStaminaHeight = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
	local playerBlockGroupWidth = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].playerBlockGroupWidth - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth) * sizeIncrease)
	local ultimateFontSize = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].fontSize + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].fontSize - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].fontSize) * sizeIncrease)
	local ultimateFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local ultimateFontStealth = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	local spacing = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].spacingRatio - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio) * sizeIncrease) * BeltalowdaOverview.roVars.spacing
	BeltalowdaOverview.state.spacing = spacing
	local border = (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].border + (BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.BIG].border - BeltalowdaOverview.config.sizes[BeltalowdaOverview.constants.size.SMALL].border) * sizeIncrease)

	BeltalowdaOverview.state.cominedFontNormal = ultimateFont
	BeltalowdaOverview.state.cominedFontStealth = ultimateFontStealth
	
	--Client
	BeltalowdaOverview.controls.clientUltimateTLW:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	local clientRootControl = BeltalowdaOverview.controls.clientUltimateTLW.rootControl
	
	clientRootControl:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	clientRootControl.movableBackdrop:SetDimensions(ultiIconWidth + offset * 2, ultiIconHeight + offset * 2)
	
	
	clientRootControl.ultimateSelector:SetDimensions(ultiIconWidth, ultiIconHeight)
	clientRootControl.ultimateSelector:ClearAnchors()
	clientRootControl.ultimateSelector:SetAnchor(TOPLEFT, clientRootControl, TOPLEFT, offset, offset)
	
	clientRootControl.ultimateSelector:SetDimensions(ultiIconWidth, ultiIconHeight)
	
	clientRootControl.ultimateSelector.button:SetDimensions(ultiIconWidth, ultiIconHeight)
	clientRootControl.ultimateSelector.texture:SetDimensions(ultiIconWidth - 4, ultiIconHeight - 4)
	
	if BeltalowdaOverview.roVars.displayMode == BeltalowdaOverview.constants.displayModes.CLASSIC then
		--Group Ultimates
		BeltalowdaOverview.controls.groupUltimatesTLW:SetDimensions(ultiIconWidth * 12 + offset * 2, ultiIconHeight + offset * 2)
		local groupsRootControl = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl
		
		
		
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
			if BeltalowdaOverview.roVars.showSoftResources == true then
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
	elseif BeltalowdaOverview.roVars.displayMode == BeltalowdaOverview.constants.displayModes.SWIMLANES then
		local sizeIncrease = BeltalowdaOverview.roVars.size - BeltalowdaOverview.constants.size.SMALL
		local playerBlockWidth = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockWidth - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockWidth) * sizeIncrease)
		local playerBlockHeight = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockHeight - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockHeight) * sizeIncrease)
		local ultiIconHeight = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].ultiIconHeight - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconHeight) * sizeIncrease)
		local offset = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].offset + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].offset - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].offset) * sizeIncrease)
		local ultiIconWidth = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].ultiIconWidth - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].ultiIconWidth) * sizeIncrease)
		BeltalowdaOverview.state.playerBlockWidth = playerBlockWidth
		BeltalowdaOverview.state.playerBlockHeight = playerBlockHeight
		BeltalowdaOverview.state.ultiIconHeight = ultiIconHeight
		BeltalowdaOverview.state.offset = offset
		local blockMagickaHeight = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockMagickaHeight - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockMagickaHeight) * sizeIncrease)
		local blockStaminaHeight = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockStaminaHeight - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockStaminaHeight) * sizeIncrease)
		local playerBlockGroupWidth = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].playerBlockGroupWidth - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].playerBlockGroupWidth) * sizeIncrease)
		local ultimateFontSizePlayer = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizePlayer + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].fontSizePlayer - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizePlayer) * sizeIncrease)
		local ultimateFontPlayer = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSizePlayer, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local ultimateFontSizeHeader = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizeHeader + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].fontSizeHeader - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].fontSizeHeader) * sizeIncrease)
		local ultimateFontHeader = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, ultimateFontSizeHeader, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		local spacing = (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio + (BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.BIG].spacingRatio - BeltalowdaOverview.config.swimLaneSizes[BeltalowdaOverview.constants.size.SMALL].spacingRatio) * sizeIncrease) * BeltalowdaOverview.roVars.spacing
		BeltalowdaOverview.state.spacing = spacing
	
	
		local groupsRootControl = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl
		
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
			if BeltalowdaOverview.roVars.showSoftResources == true then
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
	local assignmentWidth = (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width + (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].width - BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].width) * sizeIncrease)
	local assignmentHeight = (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height + (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].height - BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].height) * sizeIncrease)
	local assignmentBlockHeight = (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight + (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].blockHeight - BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].blockHeight) * sizeIncrease)
	local assignmentFontSize = (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].fontSize + (BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.BIG].fontSize - BeltalowdaOverview.config.ultimateOverview[BeltalowdaOverview.constants.size.SMALL].fontSize) * sizeIncrease)
	local assignmentFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, assignmentFontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK)
	
	
	
	BeltalowdaOverview.controls.ultimateOverviewTLW:SetDimensions(assignmentWidth, assignmentHeight)

	local ultimateOverviewControl = BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl
	
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
	
	
	
	
	BeltalowdaOverview.SetDisplayedUltimates(BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates)
	BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
	BeltalowdaOverview.UiLoop()
	
	
	--Groups Window Configuration
	BeltalowdaOverview.AdjustGroupsShowSoftResources()
	
	
	local sizeIncrease = BeltalowdaOverview.roVars.groups.size - BeltalowdaOverview.constants.size.SMALL
	local width = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].width - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].width) * sizeIncrease)
	local height = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].height - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].height) * sizeIncrease)
	local entryWidth = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryWidth) * sizeIncrease)
	local entryHeight = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryHeight) * sizeIncrease)
	local edgeSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].edgeSize - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].edgeSize) * sizeIncrease)
	local captionFontSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].captionFontSize + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].captionFontSize - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].captionFontSize) * sizeIncrease)
	local softHeight = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].softHeight - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].softHeight) * sizeIncrease)
	local entryPercentWidth = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].entryPercentWidth - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].entryPercentWidth) * sizeIncrease)
	BeltalowdaOverview.state.groupsEntryHeight = entryHeight
	
	local setHidden = BeltalowdaOverview.roVars.groups.showSoftResources
	local fontSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithResources - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithResources) * sizeIncrease)
	if setHidden == false then
		fontSize = (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithoutResources + (BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.BIG].fontSizeWithoutResources - BeltalowdaOverview.config.groups[BeltalowdaOverview.constants.size.SMALL].fontSizeWithoutResources) * sizeIncrease)
	end
	local fontNormal = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local fontStealth = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	
	BeltalowdaOverview.state.splitFontNormal = fontNormal
	BeltalowdaOverview.state.splitFontStealth = fontStealth
	
	local captionFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, captionFontSize, BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE)
	
	for i = 1, #BeltalowdaOverview.controls.groupsTLW do
		BeltalowdaOverview.controls.groupsTLW[i].rootControl.caption:SetFont(captionFont)
		BeltalowdaOverview.controls.groupsTLW[i].rootControl.caption:SetDimensions(entryWidth, entryHeight)
		BeltalowdaOverview.controls.groupsTLW[i]:SetDimensions(width, height)
		BeltalowdaOverview.controls.groupsTLW[i].rootControl:SetDimensions(width, height)
		BeltalowdaOverview.controls.groupsTLW[i].rootControl.movableBackdrop:SetDimensions(width, height)
	end
	
	for i = 1, #BeltalowdaOverview.controls.groupsEntries do
		local control = BeltalowdaOverview.controls.groupsEntries[i]
		
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
	BeltalowdaOverview.AdjustGroupsGroups()
end

--callbacks
function BeltalowdaOverview.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaOverview.roVars = currentProfile.group.ro
		BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
		BeltalowdaOverview.charVars = Beltalowda.profile.GetCharacterVars()
		BeltalowdaOverview.charVars.ro = BeltalowdaOverview.charVars.ro or {}
		if BeltalowdaOverview.state.initialized == true then
			BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetColor(BeltalowdaOverview.roVars.assignmentColor.r, BeltalowdaOverview.roVars.assignmentColor.g, BeltalowdaOverview.roVars.assignmentColor.b, 1)
			BeltalowdaOverview.AdjustSize()
			BeltalowdaOverview.AdjustAssignmentControlSize()
			BeltalowdaOverview.AdjustColors()
			BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
			BeltalowdaOverview.SetControlVisibility()
			BeltalowdaOverview.SetTlwLocation()
			BeltalowdaOverview.SetDisplayedUltimates(BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates)
			BeltalowdaOverview.AdjustGroupNames()
			BeltalowdaOverview.AdjustGroupsShowSoftResources()
			BeltalowdaOverview.AdjustGroupsColor()
			BeltalowdaOverview.SetPositionLocked(BeltalowdaOverview.roVars.positionLocked)
			BeltalowdaOverview.AdjustInCombatSettings()
			
		end
	end
end

function BeltalowdaOverview.SaveClientUltimateWindowLocation()
	if BeltalowdaOverview.roVars.positionLocked == false then
		BeltalowdaOverview.roVars.clientUltimateSettings.location = BeltalowdaOverview.roVars.clientUltimateSettings.location or {}
		BeltalowdaOverview.roVars.clientUltimateSettings.location.x = BeltalowdaOverview.controls.clientUltimateTLW:GetLeft()
		BeltalowdaOverview.roVars.clientUltimateSettings.location.y = BeltalowdaOverview.controls.clientUltimateTLW:GetTop()
	end
end

function BeltalowdaOverview.SaveGroupUltimatesWindowLocation()
	if BeltalowdaOverview.roVars.positionLocked == false then
		BeltalowdaOverview.roVars.groupUltimatesSettings.location = BeltalowdaOverview.roVars.groupUltimatesSettings.location or {}
		BeltalowdaOverview.roVars.groupUltimatesSettings.location.x = BeltalowdaOverview.controls.groupUltimatesTLW:GetLeft()
		BeltalowdaOverview.roVars.groupUltimatesSettings.location.y = BeltalowdaOverview.controls.groupUltimatesTLW:GetTop()
	end
end

function BeltalowdaOverview.SaveGroupAssignmentWindowLocation()
	if BeltalowdaOverview.roVars.positionLocked == false then
		BeltalowdaOverview.roVars.groupAssignmentSettings.location = BeltalowdaOverview.roVars.groupAssignmentSettings.location or {}
		BeltalowdaOverview.roVars.groupAssignmentSettings.location.x = BeltalowdaOverview.controls.groupAssignmentTLW:GetLeft()
		BeltalowdaOverview.roVars.groupAssignmentSettings.location.y = BeltalowdaOverview.controls.groupAssignmentTLW:GetTop()
	end
end

function BeltalowdaOverview.SaveUltimateOverviewLocation()
	if BeltalowdaOverview.roVars.positionLocked == false then
		BeltalowdaOverview.roVars.ultimateOverviewSettings.location = BeltalowdaOverview.roVars.ultimateOverviewSettings.location or {}
		BeltalowdaOverview.roVars.ultimateOverviewSettings.location.x = BeltalowdaOverview.controls.ultimateOverviewTLW:GetLeft()
		BeltalowdaOverview.roVars.ultimateOverviewSettings.location.y = BeltalowdaOverview.controls.ultimateOverviewTLW:GetTop()
	end
end

function BeltalowdaOverview.SaveGroupsGroupWindowLocation()
	if BeltalowdaOverview.roVars.positionLocked == false then
		BeltalowdaOverview.roVars.groups.location = BeltalowdaOverview.roVars.groups.location or {}
		for i = 1, #BeltalowdaOverview.controls.groupsTLW do
			BeltalowdaOverview.roVars.groups.location[i] = BeltalowdaOverview.roVars.groups.location[i] or {}
			BeltalowdaOverview.roVars.groups.location[i].x = BeltalowdaOverview.controls.groupsTLW[i]:GetLeft()
			BeltalowdaOverview.roVars.groups.location[i].y = BeltalowdaOverview.controls.groupsTLW[i]:GetTop()
		end
	end
end

function BeltalowdaOverview.OnPlayerActivated(eventCode, initial)
	if BeltalowdaOverview.roVars.enabled == true and (BeltalowdaOverview.roVars.pvpOnly == false or (BeltalowdaOverview.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaOverview.state.registredGlobalConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaOverview.networkingCallbackName, BeltalowdaOverview.config.networkUpdateInterval, BeltalowdaOverview.MessageUpdateLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaOverview.messageCallbackName, BeltalowdaOverview.config.messageUpdateInterval, BeltalowdaOverview.NetworkLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE, BeltalowdaOverview.config.uiUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_RESOURCES, BeltalowdaOverview.config.uiUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaOverview.config.buffUpdateInterval)
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaOverview.callbackName, BeltalowdaOverview.HandleRawNetworkMessage)
			BeltalowdaOverview.state.registredGlobalConsumers = true
		end
		if BeltalowdaOverview.roVars.groupUltimatesSettings.enabled == true or
		   BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled == true or
		   BeltalowdaOverview.roVars.ultimates.enabled == true then
			if BeltalowdaOverview.state.registredActiveConsumers == false then
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaOverview.uiCallbackName, BeltalowdaOverview.config.uiUpdateInterval, BeltalowdaOverview.UiLoop)
				BeltalowdaOverview.state.registredActiveConsumers = true
			end
		else
			if BeltalowdaOverview.state.registredActiveConsumers == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.uiCallbackName)
				BeltalowdaOverview.state.registredActiveConsumers = false
			end
		end
		if BeltalowdaOverview.roVars.groups.enabled == true then
			if BeltalowdaOverview.state.registredGroupsConsumers == false then
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaOverview.groupsUiCallbackName, BeltalowdaOverview.config.groupsUiUpdateInterval, BeltalowdaOverview.GroupsUiLoop)
				BeltalowdaUtilGroup.AddGroupChangedCallback(BeltalowdaOverview.callbackName, BeltalowdaOverview.AdjustGroupsGroups)
				BeltalowdaUtilGroup.AddUltimatesChangedCallback(BeltalowdaOverview.callbackName, BeltalowdaOverview.AdjustGroupsGroups)
				BeltalowdaOverview.state.registredGroupsConsumers = true
			end
			BeltalowdaOverview.AdjustGroupsGroups()
		else
			if BeltalowdaOverview.state.registredGroupsConsumers == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.groupsUiCallbackName)
				BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaOverview.callbackName)
				BeltalowdaUtilGroup.RemoveUltimatesChangedCallback(BeltalowdaOverview.callbackName)
				BeltalowdaOverview.state.registredGroupsConsumers = false
			end
		end
	else
		if BeltalowdaOverview.state.registredGlobalConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.networkingCallbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.messageCallbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_RESOURCES)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaOverview.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaOverview.callbackName)
			BeltalowdaOverview.state.registredGlobalConsumers = false
		end
		if BeltalowdaOverview.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.uiCallbackName)
			BeltalowdaOverview.state.registredActiveConsumers = false
		end
		if BeltalowdaOverview.state.registredGroupsConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaOverview.groupsUiCallbackName)
			BeltalowdaUtilGroup.RemoveGroupChangedCallback(BeltalowdaOverview.callbackName)
			BeltalowdaUtilGroup.RemoveUltimatesChangedCallback(BeltalowdaOverview.callbackName)
			BeltalowdaOverview.state.registredGroupsConsumers = false
		end
	end
	BeltalowdaOverview.SetControlVisibility()
end

function BeltalowdaOverview.ShowUltimateControlOptions(control)
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
	
function BeltalowdaOverview.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaOverview.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaOverview.state.foreground = false
	end
	BeltalowdaOverview.SetControlVisibility()
end

function BeltalowdaOverview.UiLoop()
	--d("normal ui loop")
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	local playerBlocks = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl.playerBlocks
	if BeltalowdaOverview.roVars.pvpOnly == false or (BeltalowdaOverview.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then

		
		
		if players ~= nil then
			if playerBlocks ~= nil then
				--Update Ultimates
				local rootControl = BeltalowdaOverview.controls.groupUltimatesTLW.rootControl
				players = BeltalowdaOverview.AdjustPlayerOrder(players)
				BeltalowdaOverview.state.groupUltimateStacks = {}
				BeltalowdaOverview.state.groupUltimateAssignments = {}
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
					if isDisplayed == true and players[i].isOnline == true and BeltalowdaOverview.constants.OFFLINE_TRESHOLD + players[i].resources.lastPing > gameTime then
						if BeltalowdaOverview.roVars.groupUltimatesSettings.enabled == true then
							playerBlocks[i]:SetHidden(false)
							local stack = BeltalowdaOverview.state.groupUltimateStacks[resources.ultimateId]
							if stack == nil then
								stack = 0
							end
							
							playerBlocks[i].ultimateProgress:SetValue(resources.ultimatePercent)
							playerBlocks[i].magickaProgress:SetValue(resources.magickaPercent)
							playerBlocks[i].staminaProgress:SetValue(resources.staminaPercent)
							-- To change the font when a player is in stealth
							if BeltalowdaOverview.roVars.combinedInStealthEnabled == true then
								if players[i].isInStealth > 0 then
									playerBlocks[i].labelName:SetFont(BeltalowdaOverview.state.cominedFontStealth)
								else
									playerBlocks[i].labelName:SetFont(BeltalowdaOverview.state.cominedFontNormal)
								end
							else
								playerBlocks[i].labelName:SetFont(BeltalowdaOverview.state.cominedFontNormal)
							end
							
							playerBlocks[i].labelName:SetText(players[i].name)
							playerBlocks[i]:ClearAnchors()
							playerBlocks[i]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, (index - 1) * BeltalowdaOverview.state.playerBlockWidth + BeltalowdaOverview.state.offset + BeltalowdaOverview.state.spacing * (index - 1), stack * BeltalowdaOverview.state.playerBlockHeight + BeltalowdaOverview.state.ultiIconHeight + BeltalowdaOverview.state.offset)
							stack = stack + 1
							BeltalowdaOverview.state.groupUltimateStacks[resources.ultimateId] = stack
							
							if IsUnitDead(players[i].unitTag) == true then
								playerBlocks[i].frontdrop:SetHidden(false)
								playerBlocks[i].frontdrop:SetCenterColor(BeltalowdaOverview.roVars.playerBlockColors.dead.r, BeltalowdaOverview.roVars.playerBlockColors.dead.g, BeltalowdaOverview.roVars.playerBlockColors.dead.b, 0.6)
							elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaOverview.roVars.ultimates.maxDistance < players[i].distances.fromLeader then
								playerBlocks[i].frontdrop:SetHidden(false)
								playerBlocks[i].frontdrop:SetCenterColor(BeltalowdaOverview.roVars.playerBlockColors.outOfRange.r, BeltalowdaOverview.roVars.playerBlockColors.outOfRange.g, BeltalowdaOverview.roVars.playerBlockColors.outOfRange.b, 0.8)
							else
								playerBlocks[i].frontdrop:SetHidden(true)
							end
						end
					else
						playerBlocks[i]:SetHidden(true)
					end
					if BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled == true then
						local borderColor = BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat
						if players[i].isInCombat == true then
							borderColor = BeltalowdaOverview.roVars.playerBlockColors.borderInCombat
						end
						playerBlocks[i].border:SetEdgeColor(borderColor.r, borderColor.g, borderColor.b, 1)
					end
					if resources.ultimatePercent == nil or resources.ultimatePercent < 100 then
						playerBlocks[i].ultimateProgress:SetColor(BeltalowdaOverview.roVars.playerBlockColors.progressNotFull.r, BeltalowdaOverview.roVars.playerBlockColors.progressNotFull.g, BeltalowdaOverview.roVars.playerBlockColors.progressNotFull.b)
						playerBlocks[i].labelName:SetColor(BeltalowdaOverview.roVars.playerBlockColors.labelNotFull.r, BeltalowdaOverview.roVars.playerBlockColors.labelNotFull.g, BeltalowdaOverview.roVars.playerBlockColors.labelNotFull.b)
						playerBlocks[i].labelGroup:SetText("")
						--BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetText("")
						BeltalowdaOverview.IndexUltiGroup(players[i].unitTag, 0)
					else
						local groupIndex = 0
						local groupSize, ultimateType = BeltalowdaOverview.GetUltimateGroupSize(resources.ultimateId)
						if ultimateType ~= nil then
							groupUltimatesReady[ultimateType] = groupUltimatesReady[ultimateType] + 1
						end
						if groupSize > 0 and IsUnitDead(players[i].unitTag) == false and players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaOverview.roVars.ultimates.maxDistance >= players[i].distances.fromLeader and players[i].isOnline == true then 
							local assignment = BeltalowdaOverview.state.groupUltimateAssignments[resources.ultimateId]
							if assignment == nil then
								assignment = 0
							end
							assignment = assignment + 1
							groupIndex = (assignment - (assignment % groupSize)) / groupSize
							if assignment % groupSize ~= 0 then
								groupIndex = groupIndex + 1
							end
							BeltalowdaOverview.state.groupUltimateAssignments[resources.ultimateId] = assignment
							if ultimateType ~= nil then
								groupUltimatesInRange[ultimateType] = groupUltimatesInRange[ultimateType] + 1
							end
						end
						if groupIndex == 0 then
							playerBlocks[i].labelGroup:SetText("")
						elseif BeltalowdaOverview.roVars.ultimates.enabled == true then
							playerBlocks[i].labelGroup:SetText(groupIndex)
						else
							playerBlocks[i].labelGroup:SetText("")
						end
						BeltalowdaOverview.IndexUltiGroup(players[i].unitTag, groupIndex)
						
						playerBlocks[i].ultimateProgress:SetColor(BeltalowdaOverview.roVars.playerBlockColors.progressFull.r, BeltalowdaOverview.roVars.playerBlockColors.progressFull.g, BeltalowdaOverview.roVars.playerBlockColors.progressFull.b)
						playerBlocks[i].labelName:SetColor(BeltalowdaOverview.roVars.playerBlockColors.labelFull.r, BeltalowdaOverview.roVars.playerBlockColors.labelFull.g, BeltalowdaOverview.roVars.playerBlockColors.labelFull.b)
						
					end
					if players[i].displayName == GetUnitDisplayName("player") and players[i].charName == GetUnitName("player") then
						--d(groupIndex)
						local groupIndex = players[i].resources.ultiGroup
						if BeltalowdaOverview.roVars.ultimates.enabled == true then
							if groupIndex == 0 then
								if BeltalowdaOverview.state.useUltimateCommandReceived == true and
								   BeltalowdaOverview.state.useUltimateCommandTimeStamp + 3000 > GetGameTimeMilliseconds() then
									BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetText(BeltalowdaOverview.constants.BOOM)
								else
									BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetText("")
									BeltalowdaOverview.state.useUltimateCommandReceived = false
								end
							else
								if BeltalowdaOverview.state.useUltimateCommandReceived == true and
								   BeltalowdaOverview.state.useUltimateCommandTimeStamp + 3000 > GetGameTimeMilliseconds() then
									BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetText(BeltalowdaOverview.constants.BOOM)
									--BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetHidden(false) --Bug Fix 1.12.0? failed
								else
									BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetText(groupIndex)
									BeltalowdaOverview.state.useUltimateCommandReceived = false
								end
							end
						end
					end
				end
				for i = #players + 1, 24 do
					playerBlocks[i]:SetHidden(true)
				end
				--Update Overview
				if BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled == true and BeltalowdaOverview.roVars.ultimates.enabled == true then
					local ultimateOverviewControl = BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl
					ultimateOverviewControl.destructionLabel:SetText(string.format(string.format(BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.destro, groupUltimatesReady.destro, BeltalowdaOverview.constants.IDENENTIFIER_DESTRUCTION)))
					ultimateOverviewControl.stormLabel:SetText(string.format(string.format(BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.storm + groupUltimatesInRange.northernStorm + groupUltimatesInRange.permafrost, groupUltimatesReady.storm + groupUltimatesReady.northernStorm + groupUltimatesReady.permafrost, BeltalowdaOverview.constants.IDENENTIFIER_STORM)))
					ultimateOverviewControl.negateLabel:SetText(string.format(string.format(BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.negate + groupUltimatesInRange.negateOffensive + groupUltimatesInRange.negateCounter, groupUltimatesReady.negate + groupUltimatesReady.negateOffensive + groupUltimatesReady.negateCounter, BeltalowdaOverview.constants.IDENENTIFIER_NEGATE)))
					ultimateOverviewControl.novaLabel:SetText(string.format(string.format(BeltalowdaOverview.constants.ULTIMATE_OVERVIEW_STRING, groupUltimatesInRange.nova, groupUltimatesReady.nova, BeltalowdaOverview.constants.IDENENTIFIER_NOVA)))
					if BeltalowdaOverview.state.sentUltimateCommandTimeStamp + 3000 <= GetGameTimeMilliseconds() then
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

function BeltalowdaOverview.GroupsUiLoop()
	--d("groups ui loop")
	if BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT or BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PERCENT then
		BeltalowdaOverview.AdjustGroupsGroups()
	elseif BeltalowdaOverview.roVars.groups.mode == BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			local entries = BeltalowdaOverview.controls.groupsEntries
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
							local progressColor = { r = BeltalowdaOverview.roVars.groups.progressFull.r, g = BeltalowdaOverview.roVars.groups.progressFull.g, b = BeltalowdaOverview.roVars.groups.progressFull.b, a = BeltalowdaOverview.roVars.groups.progressFull.a}
							if IsUnitDead(players[i].unitTag) == true then
								progressColor.r = BeltalowdaOverview.roVars.groups.dead.r
								progressColor.g = BeltalowdaOverview.roVars.groups.dead.g
								progressColor.b = BeltalowdaOverview.roVars.groups.dead.b
								progressColor.a = BeltalowdaOverview.roVars.groups.dead.a
							elseif players[i].distances ~= nil and players[i].distances.fromLeader ~= nil and BeltalowdaOverview.roVars.groups.maxDistance < players[i].distances.fromLeader then
								progressColor.r = BeltalowdaOverview.roVars.groups.outOfRange.r
								progressColor.g = BeltalowdaOverview.roVars.groups.outOfRange.g
								progressColor.b = BeltalowdaOverview.roVars.groups.outOfRange.b
								progressColor.a = BeltalowdaOverview.roVars.groups.outOfRange.a
							elseif players[i].resources.ultimatePercent ~= 100 then
								progressColor.r = BeltalowdaOverview.roVars.groups.progressNotFull.r
								progressColor.g = BeltalowdaOverview.roVars.groups.progressNotFull.g
								progressColor.b = BeltalowdaOverview.roVars.groups.progressNotFull.b
								progressColor.a = BeltalowdaOverview.roVars.groups.progressNotFull.a
							end
							local labelColor = {r = BeltalowdaOverview.roVars.groups.labelFull.r, g = BeltalowdaOverview.roVars.groups.labelFull.g, b = BeltalowdaOverview.roVars.groups.labelFull.b}
							if players[i].resources.ultimatePercent ~= 100 then
								labelColor.r = BeltalowdaOverview.roVars.groups.labelNotFull.r
								labelColor.g = BeltalowdaOverview.roVars.groups.labelNotFull.g
								labelColor.b = BeltalowdaOverview.roVars.groups.labelNotFull.b
							end
							entries[j].progress:SetColor(progressColor.r, progressColor.g, progressColor.b, progressColor.a)
							entries[j].name:SetColor(labelColor.r, labelColor.g, labelColor.b)
							entries[j].percent:SetColor(labelColor.r, labelColor.g, labelColor.b)
							local edgeColor = BeltalowdaOverview.roVars.groups.borderOutOfCombat
							if players[i].isInCombat == true then
								edgeColor = BeltalowdaOverview.roVars.groups.borderInCombat
							end
							entries[j].edge:SetEdgeColor(edgeColor.r, edgeColor.g, edgeColor.b, 1)
							if BeltalowdaOverview.roVars.groups.showSoftResources == true then
								entries[j].magicka:SetValue(players[i].resources.magickaPercent)
								entries[j].stamina:SetValue(players[i].resources.staminaPercent)
							end
							-- Adjust Font if in stealth
							local font = BeltalowdaOverview.state.splitFontNormal
							if BeltalowdaOverview.roVars.splitInStealthEnabled == true and players[i].isInStealth > 0 then
								font = BeltalowdaOverview.state.splitFontStealth
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

function BeltalowdaOverview.HandleRawNetworkMessage(message)
	if message ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_BOOM and BeltalowdaOverview.roVars.ultimates.enabled == true then
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
				BeltalowdaOverview.state.useUltimateCommandReceived = true
				BeltalowdaOverview.state.useUltimateCommandTimeStamp = GetGameTimeMilliseconds()
				if BeltalowdaOverview.roVars.soundEnabled == true then
					--d(BeltalowdaOverview.roVars.selectedSound)
					BeltalowdaSound.PlaySoundByName(BeltalowdaOverview.roVars.selectedSound)
				end
			end
			if BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled == true and players ~= nil then
				BeltalowdaOverview.state.sentUltimateCommandTimeStamp = GetGameTimeMilliseconds()
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
						local size, ultimateType = BeltalowdaOverview.GetUltimateGroupSize(players[i].resources.ultimateId)
						if ultimateType ~= nil then
							boom[ultimateType] = boom[ultimateType] + 1
						end
					end
				end
				
				local ultimateOverviewControl = BeltalowdaOverview.controls.ultimateOverviewTLW.rootControl
				ultimateOverviewControl.destructionLabel.currentBoomLabel:SetText(boom.destro)
				ultimateOverviewControl.stormLabel.currentBoomLabel:SetText(boom.storm + boom.northernStorm + boom.permafrost)
				ultimateOverviewControl.negateLabel.currentBoomLabel:SetText(boom.negate + boom.negateOffensive + boom.negateCounter)
				ultimateOverviewControl.novaLabel.currentBoomLabel:SetText(boom.nova)
			end
			
		end
	end
end

function BeltalowdaOverview.NetworkLoop()
	if BeltalowdaOverview.roVars.pvpOnly == false or (BeltalowdaOverview.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local message = BeltalowdaOverview.state.lastMessage
		local sendMessage = false
		if message == nil or message.sent == true then
			message = {}
			message.sent = false
			sendMessage = true
		end
		
		message.b0, message.b1, message.b2, message.b3 = BeltalowdaOverview.GetPlayerResources()
		
		if sendMessage == true then
			BeltalowdaNetworking.SendHeartbeatMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
		end
		BeltalowdaOverview.state.lastMessage = message
	end
end

function BeltalowdaOverview.MessageUpdateLoop()
	if BeltalowdaOverview.roVars.pvpOnly == false or (BeltalowdaOverview.roVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		local message = BeltalowdaOverview.state.lastMessage
		if message ~= nil and message.sent == false then
			message.b0, message.b1, message.b2, message.b3 = BeltalowdaOverview.GetPlayerResources()
		end
	end
end

function BeltalowdaOverview.OnBoomKeyBinding()
	if (BeltalowdaUtilGroup.IsPlayerGroupLeader() == true or GetGroupSize() == 0) and GetGameTimeMilliseconds() > BeltalowdaOverview.state.lastBoom + 1000 and BeltalowdaOverview.roVars.ultimates.enabled == true then
		BeltalowdaOverview.SendBoom()
		--d("sending boom")
	end
end

--menu interactions
function BeltalowdaOverview.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RO_HEADER_ULTIMATES,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ENABLED,
					getFunc = BeltalowdaOverview.GetRoEnabled,
					setFunc = BeltalowdaOverview.SetRoEnabled,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_POSITION_FIXED,
					getFunc = BeltalowdaOverview.GetRoPositionLocked,
					setFunc = BeltalowdaOverview.SetRoPositionLocked,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_PVP_ONLY,
					getFunc = BeltalowdaOverview.GetRoPvpOnly,
					setFunc = BeltalowdaOverview.SetRoPvpOnly,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED,
					getFunc = BeltalowdaOverview.GetRoUltimateOverviewEnabled,
					setFunc = BeltalowdaOverview.SetRoUltimateOverviewEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED,
					getFunc = BeltalowdaOverview.GetRoClientUltimateEnabled,
					setFunc = BeltalowdaOverview.SetRoClientUltimateEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroupUltimatesEnabled,
					setFunc = BeltalowdaOverview.SetRoGroupUltimatesEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES,
					getFunc = BeltalowdaOverview.GetRoShowSoftResources,
					setFunc = BeltalowdaOverview.SetRoShowSoftResources
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroupUltimatesGroupsEnabled,
					setFunc = BeltalowdaOverview.SetRoGroupUltimatesGroupsEnabled
				},
				[9] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE,
					choices = BeltalowdaOverview.GetRoAvailableDisplayModes(),
					getFunc = BeltalowdaOverview.GetRoAvailableDisplayMode,
					setFunc = BeltalowdaOverview.SetRoAvailableDisplayMode,
					width = "full",
					reference = lReference
				},
				[10] = {
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
				[11] = {
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
				[12] = {
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
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_BACKGROUND,
					getFunc = BeltalowdaOverview.GetRoColorBackground,
					setFunc = BeltalowdaOverview.SetRoColorBackground,
					width = "full"
				},
				[14] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_MAGICKA,
					getFunc = BeltalowdaOverview.GetRoColorMagicka,
					setFunc = BeltalowdaOverview.SetRoColorMagicka,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_STAMINA,
					getFunc = BeltalowdaOverview.GetRoColorStamina,
					setFunc = BeltalowdaOverview.SetRoColorStamina,
					width = "full"
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE,
					getFunc = BeltalowdaOverview.GetRoColorOutOfRange,
					setFunc = BeltalowdaOverview.SetRoColorOutOfRange,
					width = "full"
				},
				[17] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_DEAD,
					getFunc = BeltalowdaOverview.GetRoColorDead,
					setFunc = BeltalowdaOverview.SetRoColorDead,
					width = "full"
				},
				[18] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoColorProgressNotFull,
					setFunc = BeltalowdaOverview.SetRoColorProgressNotFull,
					width = "full"
				},
				[19] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL,
					getFunc = BeltalowdaOverview.GetRoColorProgressFull,
					setFunc = BeltalowdaOverview.SetRoColorProgressFull,
					width = "full"
				},
				[20] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL,
					getFunc = BeltalowdaOverview.GetRoColorLabelFull,
					setFunc = BeltalowdaOverview.SetRoColorLabelFull,
					width = "full"
				},
				[21] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoColorLabelNotFull,
					setFunc = BeltalowdaOverview.SetRoColorLabelNotFull,
					width = "full"
				},
				[22] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP,
					getFunc = BeltalowdaOverview.GetRoColorLabelGroup,
					setFunc = BeltalowdaOverview.SetRoColorLabelGroup,
					width = "full"
				},
				[23] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT,
					getFunc = BeltalowdaOverview.GetRoColorLabelAnnouncement,
					setFunc = BeltalowdaOverview.SetRoColorLabelAnnouncement,
					width = "full"
				},
				[24] = {
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
				[25] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED,
					getFunc = BeltalowdaOverview.GetRoInCombatEnabled,
					setFunc = BeltalowdaOverview.SetRoInCombatEnabled
				},
				[26] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR,
					getFunc = BeltalowdaOverview.GetRoInCombatColor,
					setFunc = BeltalowdaOverview.SetRoInCombatColor,
					width = "full"
				},
				[27] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR,
					getFunc = BeltalowdaOverview.GetRoOutOfCombatColor,
					setFunc = BeltalowdaOverview.SetRoOutOfCombatColor,
					width = "full"
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED,
					getFunc = BeltalowdaOverview.GetRoCombinedInStealthEnabled,
					setFunc = BeltalowdaOverview.SetRoCombinedInStealthEnabled
				},
				[29] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE,
					choices = BeltalowdaOverview.GetRoAvailableUltimateSortingModes(),
					getFunc = BeltalowdaOverview.GetRoSelectedUltimateSortingMode,
					setFunc = BeltalowdaOverview.SetRoSelectedUltimateSortingMode,
					width = "full"
				},
				[30] = {
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
				[31] = {
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
				[32] = {
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
				[33] = {
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
				[34] = {
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
				[35] = {
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
				[36] = {
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
				[37] = {
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
				[38] = {
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
				[39] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SOUND_ENABLED,
					getFunc = BeltalowdaOverview.GetRoSoundEnabled,
					setFunc = BeltalowdaOverview.SetRoSoundEnabled
				},
				[40] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_SELECTED_SOUND,
					choices = BeltalowdaOverview.GetRoAvailableSounds(),
					getFunc = BeltalowdaOverview.GetRoSelectedSound,
					setFunc = BeltalowdaOverview.SetRoSelectedSound,
					width = "full"
				},
			},
		},
		[2] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RO_HEADER_GROUPS,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_ENABLED,
					getFunc = BeltalowdaOverview.GetRoEnabled,
					setFunc = BeltalowdaOverview.SetRoEnabled,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_POSITION_FIXED,
					getFunc = BeltalowdaOverview.GetRoPositionLocked,
					setFunc = BeltalowdaOverview.SetRoPositionLocked,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_PVP_ONLY,
					getFunc = BeltalowdaOverview.GetRoPvpOnly,
					setFunc = BeltalowdaOverview.SetRoPvpOnly,
					warning = BeltalowdaMenu.constants.RO_SHARED_SETTING
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroupsEnabled,
					setFunc = BeltalowdaOverview.SetRoGroupsEnabled
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RO_GROUPS_MODE,
					choices = BeltalowdaOverview.GetRoGroupsAvailableModes(),
					getFunc = BeltalowdaOverview.GetRoGroupsAvailableMode,
					setFunc = BeltalowdaOverview.SetRoGroupsAvailableMode,
					width = "full",
					reference = lReference
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaOverview.GetRoGroupsSize,
					setFunc = BeltalowdaOverview.SetRoGroupsSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_1_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroups1Enabled,
					setFunc = BeltalowdaOverview.SetRoGroups1Enabled
				},
				[8] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_1_NAME,
					getFunc = BeltalowdaOverview.GetRoGroups1Name,
					setFunc = BeltalowdaOverview.SetRoGroups1Name,
					isMultiline = false,
					width = "full",
					default = ""
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_2_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroups2Enabled,
					setFunc = BeltalowdaOverview.SetRoGroups2Enabled
				},
				[10] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_2_NAME,
					getFunc = BeltalowdaOverview.GetRoGroups2Name,
					setFunc = BeltalowdaOverview.SetRoGroups2Name,
					isMultiline = false,
					width = "full",
					default = ""
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_3_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroups3Enabled,
					setFunc = BeltalowdaOverview.SetRoGroups3Enabled
				},
				[12] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_3_NAME,
					getFunc = BeltalowdaOverview.GetRoGroups3Name,
					setFunc = BeltalowdaOverview.SetRoGroups3Name,
					isMultiline = false,
					width = "full",
					default = ""
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_4_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroups4Enabled,
					setFunc = BeltalowdaOverview.SetRoGroups4Enabled
				},
				[14] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_4_NAME,
					getFunc = BeltalowdaOverview.GetRoGroups4Name,
					setFunc = BeltalowdaOverview.SetRoGroups4Name,
					isMultiline = false,
					width = "full",
					default = ""
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_5_ENABLED,
					getFunc = BeltalowdaOverview.GetRoGroups5Enabled,
					setFunc = BeltalowdaOverview.SetRoGroups5Enabled
				},
				[16] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.RO_GROUPS_5_NAME,
					getFunc = BeltalowdaOverview.GetRoGroups5Name,
					setFunc = BeltalowdaOverview.SetRoGroups5Name,
					isMultiline = false,
					width = "full",
					default = ""
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES,
					getFunc = BeltalowdaOverview.GetRoGroupsShowSoftResources,
					setFunc = BeltalowdaOverview.SetRoGroupsShowSoftResources
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED,
					getFunc = BeltalowdaOverview.GetRoSplitInStealthEnabled,
					setFunc = BeltalowdaOverview.SetRoSplitInStealthEnabled
				},
				[19] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_BACKGROUND,
					getFunc = BeltalowdaOverview.GetRoGroupsColorBackground,
					setFunc = BeltalowdaOverview.SetRoGroupsColorBackground,
					width = "full"
				},
				[20] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_MAGICKA,
					getFunc = BeltalowdaOverview.GetRoGroupsColorMagicka,
					setFunc = BeltalowdaOverview.SetRoGroupsColorMagicka,
					width = "full"
				},
				[21] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_STAMINA,
					getFunc = BeltalowdaOverview.GetRoGroupsColorStamina,
					setFunc = BeltalowdaOverview.SetRoGroupsColorStamina,
					width = "full"
				},
				[22] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE,
					getFunc = BeltalowdaOverview.GetRoGroupsColorOutOfRange,
					setFunc = BeltalowdaOverview.SetRoGroupsColorOutOfRange,
					width = "full"
				},
				[23] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_DEAD,
					getFunc = BeltalowdaOverview.GetRoGroupsColorDead,
					setFunc = BeltalowdaOverview.SetRoGroupsColorDead,
					width = "full"
				},
				[24] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoGroupsColorProgressNotFull,
					setFunc = BeltalowdaOverview.SetRoGroupsColorProgressNotFull,
					width = "full"
				},
				[25] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL,
					getFunc = BeltalowdaOverview.GetRoGroupsColorProgressFull,
					setFunc = BeltalowdaOverview.SetRoGroupsColorProgressFull,
					width = "full"
				},
				[26] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL,
					getFunc = BeltalowdaOverview.GetRoGroupsColorLabelFull,
					setFunc = BeltalowdaOverview.SetRoGroupsColorLabelFull,
					width = "full"
				},
				[27] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL,
					getFunc = BeltalowdaOverview.GetRoGroupsColorLabelNotFull,
					setFunc = BeltalowdaOverview.SetRoGroupsColorLabelNotFull,
					width = "full"
				},
				[28] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_OUT_OF_COMBAT,
					getFunc = BeltalowdaOverview.GetRoGroupsColorEdgeOutOfCombat,
					setFunc = BeltalowdaOverview.SetRoGroupsColorEdgeOutOfCombat,
					width = "full"
				},
				[29] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_IN_COMBAT,
					getFunc = BeltalowdaOverview.GetRoGroupsColorEdgeInCombat,
					setFunc = BeltalowdaOverview.SetRoGroupsColorEdgeInCombat,
					width = "full"
				},
				[30] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RO_MAX_DISTANCE,
					min = 1,
					max = 50,
					step = 1,
					getFunc = BeltalowdaOverview.GetRoGroupsMaxDistance,
					setFunc = BeltalowdaOverview.SetRoGroupsMaxDistance,
					width = "full",
					default = 25
				},
				[31] = {
					type = "divider",
					width = "full"
				},
			}
		}
	}
	
	for i = 1, #BeltalowdaUltimates.ultimates do
		local lReference = BeltalowdaOverview.constants.references.GROUPS_DROPDOWN .. i
		menu[2].controls[#menu[2].controls + 1] = {
			type = "dropdown",
			name = BeltalowdaUltimates.ultimates[i].name .. BeltalowdaMenu.constants.RO_GROUPS_GROUP,
			choices = BeltalowdaOverview.GetRoAvailableGroupsGroups(),
			getFunc = function() return BeltalowdaOverview.GetRoSelectedGroupsGroup(i) end,
			setFunc = function(value) BeltalowdaOverview.SetRoSelectedGroupsGroup(i, value) end,
			width = "full",
			reference = lReference
		}
		menu[2].controls[#menu[2].controls + 1] = {
			type = "slider",
			name = BeltalowdaUltimates.ultimates[i].name .. BeltalowdaMenu.constants.RO_GROUPS_PRIORITY,
			min = 1,
			max = 30,
			step = 1,
			getFunc = function() return BeltalowdaOverview.GetRoGroupsGroupPriority(i) end,
			setFunc = function(value) BeltalowdaOverview.SetRoGroupsGroupPriority(i, value) end,
			width = "full",
			default = 30
		}
		table.insert(BeltalowdaOverview.state.references, lReference)
	end
	
	return menu
end


function BeltalowdaOverview.GetRoEnabled()
	return BeltalowdaOverview.roVars.enabled
end

function BeltalowdaOverview.SetRoEnabled(value)
	BeltalowdaOverview.SetEnabled(value)
end

function BeltalowdaOverview.GetRoPositionLocked()
	return BeltalowdaOverview.roVars.positionLocked
end

function BeltalowdaOverview.SetRoPositionLocked(value)
	BeltalowdaOverview.SetPositionLocked(value)
end

function BeltalowdaOverview.GetRoPvpOnly()
	return BeltalowdaOverview.roVars.pvpOnly
end

function BeltalowdaOverview.SetRoPvpOnly(value)
	BeltalowdaOverview.roVars.pvpOnly = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaOverview.GetRoUltimateOverviewEnabled()
	return BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled
end

function BeltalowdaOverview.SetRoUltimateOverviewEnabled(value)
	BeltalowdaOverview.roVars.ultimateOverviewSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaOverview.GetRoClientUltimateEnabled()
	return BeltalowdaOverview.roVars.clientUltimateSettings.enabled
end

function BeltalowdaOverview.SetRoClientUltimateEnabled(value)
	BeltalowdaOverview.roVars.clientUltimateSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaOverview.GetRoGroupUltimatesEnabled()
	return BeltalowdaOverview.roVars.groupUltimatesSettings.enabled
end

function BeltalowdaOverview.SetRoGroupUltimatesEnabled(value)
	BeltalowdaOverview.roVars.groupUltimatesSettings.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaOverview.GetRoShowSoftResources()
	return BeltalowdaOverview.roVars.showSoftResources
end

function BeltalowdaOverview.SetRoShowSoftResources(value)
	BeltalowdaOverview.roVars.showSoftResources = value
	--BeltalowdaOverview.AdjustStaminaMagickaBarVisibility()
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaOverview.GetRoGroupUltimatesGroupsEnabled()
	return BeltalowdaOverview.roVars.ultimates.enabled
end

function BeltalowdaOverview.SetRoGroupUltimatesGroupsEnabled(value)
	BeltalowdaOverview.roVars.ultimates.enabled = value
	BeltalowdaOverview.SetEnabled(BeltalowdaOverview.roVars.enabled)
end

function BeltalowdaOverview.GetRoAvailableDisplayModes()
	return BeltalowdaOverview.config.displayModes
end

function BeltalowdaOverview.GetRoAvailableDisplayMode()
	return BeltalowdaOverview.config.displayModes[BeltalowdaOverview.roVars.displayMode]
end

function BeltalowdaOverview.SetRoAvailableDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaOverview.config.displayModes do
			if BeltalowdaOverview.config.displayModes[i] == value then
				BeltalowdaOverview.roVars.displayMode = i
			end
		end
		BeltalowdaOverview.AdjustDisplayMode()
	end
end

function BeltalowdaOverview.GetRoDisplayUltimates()
	return BeltalowdaOverview.roVars.groupUltimatesSettings.displayedUltimates
end

function BeltalowdaOverview.SetRoDisplayUltimates(value)
	BeltalowdaOverview.SetDisplayedUltimates(value)
end

function BeltalowdaOverview.GetRoColorBackground()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.defaultBackground)
end

function BeltalowdaOverview.SetRoColorBackground(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.defaultBackground = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorMagicka()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.magicka)
end

function BeltalowdaOverview.SetRoColorMagicka(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.magicka = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.AdjustColors()
end
	
function BeltalowdaOverview.GetRoColorStamina()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.stamina)
end

function BeltalowdaOverview.SetRoColorStamina(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.stamina = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.AdjustColors()
end

function BeltalowdaOverview.GetRoColorOutOfRange()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.outOfRange)
end

function BeltalowdaOverview.SetRoColorOutOfRange(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.outOfRange = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorDead()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.dead)
end

function BeltalowdaOverview.SetRoColorDead(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.dead = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorProgressNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.progressNotFull)
end

function BeltalowdaOverview.SetRoColorProgressNotFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.progressNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorProgressFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.progressFull)
end

function BeltalowdaOverview.SetRoColorProgressFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.progressFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelFull)
end

function BeltalowdaOverview.SetRoColorLabelFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelNotFull)
end

function BeltalowdaOverview.SetRoColorLabelNotFull(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorLabelGroup()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.labelGroup)
end

function BeltalowdaOverview.SetRoColorLabelGroup(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.labelGroup = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoColorLabelAnnouncement()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.assignmentColor)
end

function BeltalowdaOverview.SetRoColorLabelAnnouncement(r, g, b)
	BeltalowdaOverview.roVars.assignmentColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaOverview.controls.groupAssignmentTLW.rootControl.label:SetColor(r, g, b, 1)
end

function BeltalowdaOverview.GetRoAnnouncementSize()
	return BeltalowdaOverview.roVars.assignmentSize
end

function BeltalowdaOverview.SetRoAnnouncementSize(value)
	BeltalowdaOverview.roVars.assignmentSize = value
	BeltalowdaOverview.AdjustAssignmentControlSize()
end

function BeltalowdaOverview.GetRoInCombatEnabled()
	return BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled
end

function BeltalowdaOverview.SetRoInCombatEnabled(value)
	BeltalowdaOverview.roVars.playerBlockColors.inCombatEnabled = value
	BeltalowdaOverview.AdjustInCombatSettings()
end

function BeltalowdaOverview.GetRoInCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.borderInCombat)
end

function BeltalowdaOverview.SetRoInCombatColor(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoOutOfCombatColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat)
end

function BeltalowdaOverview.SetRoOutOfCombatColor(r, g, b)
	BeltalowdaOverview.roVars.playerBlockColors.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoCombinedInStealthEnabled()
	return BeltalowdaOverview.roVars.combinedInStealthEnabled
end

function BeltalowdaOverview.SetRoCombinedInStealthEnabled(value)
	BeltalowdaOverview.roVars.combinedInStealthEnabled = value
end

function BeltalowdaOverview.GetRoAvailableUltimateSortingModes()
	return BeltalowdaOverview.config.ultimateModes
end

function BeltalowdaOverview.GetRoSelectedUltimateSortingMode()
	return BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.roVars.ultimates.sortingMode]
end

function BeltalowdaOverview.SetRoSelectedUltimateSortingMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaOverview.config.ultimateModes do
			if BeltalowdaOverview.config.ultimateModes[i] == value then
				BeltalowdaOverview.roVars.ultimates.sortingMode = i
			end
		end
	end
end

function BeltalowdaOverview.GetRoUltimateGroupSizeDestro()
	return BeltalowdaOverview.roVars.ultimates.groupSizeDestro
end

function BeltalowdaOverview.SetRoUltimateGroupSizeDestro(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeDestro = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeStorm()
	return BeltalowdaOverview.roVars.ultimates.groupSizeStorm
end

function BeltalowdaOverview.SetRoUltimateGroupSizeStorm(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeStorm = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeNorthernStorm()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNorthernStorm
end

function BeltalowdaOverview.SetRoUltimateGroupSizeNorthernStorm(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNorthernStorm = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizePermafrost()
	return BeltalowdaOverview.roVars.ultimates.groupSizePermafrost
end

function BeltalowdaOverview.SetRoUltimateGroupSizePermafrost(value)
	BeltalowdaOverview.roVars.ultimates.groupSizePermafrost = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeNegate()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegate
end

function BeltalowdaOverview.SetRoUltimateGroupSizeNegate(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegate = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeNegateOffensive()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegateOffensive
end

function BeltalowdaOverview.SetRoUltimateGroupSizeNegateOffensive(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegateOffensive = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeNegateCounter()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNegateCounter
end

function BeltalowdaOverview.SetRoUltimateGroupSizeNegateCounter(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNegateCounter = value
end

function BeltalowdaOverview.GetRoUltimateGroupSizeNova()
	return BeltalowdaOverview.roVars.ultimates.groupSizeNova
end

function BeltalowdaOverview.SetRoUltimateGroupSizeNova(value)
	BeltalowdaOverview.roVars.ultimates.groupSizeNova = value
end

function BeltalowdaOverview.GetRoMaxDistance()
	return BeltalowdaOverview.roVars.ultimates.maxDistance
end

function BeltalowdaOverview.SetRoMaxDistance(value)
	BeltalowdaOverview.roVars.ultimates.maxDistance = value
end

function BeltalowdaOverview.GetRoSoundEnabled()
	return BeltalowdaOverview.roVars.soundEnabled
end

function BeltalowdaOverview.SetRoSoundEnabled(value)
	BeltalowdaOverview.roVars.soundEnabled = value
end

function BeltalowdaOverview.GetRoAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaOverview.state.sounds do
		sounds[i] = BeltalowdaOverview.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaOverview.GetRoSelectedSound()
	return BeltalowdaOverview.roVars.selectedSound
end

function BeltalowdaOverview.SetRoSelectedSound(value)
	if value ~= nil then
		BeltalowdaOverview.roVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end

function BeltalowdaOverview.GetRoGroupsEnabled()
	return BeltalowdaOverview.roVars.groups.enabled
end

function BeltalowdaOverview.SetRoGroupsEnabled(value)
	BeltalowdaOverview.SetGroupsEnabled(value)
end

function BeltalowdaOverview.GetRoGroups1Enabled()
	return BeltalowdaOverview.roVars.groups.group1.enabled
end

function BeltalowdaOverview.SetRoGroups1Enabled(value)
	BeltalowdaOverview.roVars.groups.group1.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaOverview.GetRoGroups1Name()
	return BeltalowdaOverview.roVars.groups.group1.name
end

function BeltalowdaOverview.SetRoGroups1Name(value)
	BeltalowdaOverview.roVars.groups.group1.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaOverview.GetRoGroups2Enabled()
	return BeltalowdaOverview.roVars.groups.group2.enabled
end

function BeltalowdaOverview.SetRoGroups2Enabled(value)
	BeltalowdaOverview.roVars.groups.group2.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaOverview.GetRoGroups2Name()
	return BeltalowdaOverview.roVars.groups.group2.name
end

function BeltalowdaOverview.SetRoGroups2Name(value)
	BeltalowdaOverview.roVars.groups.group2.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaOverview.GetRoGroups3Enabled()
	return BeltalowdaOverview.roVars.groups.group3.enabled
end

function BeltalowdaOverview.SetRoGroups3Enabled(value)
	BeltalowdaOverview.roVars.groups.group3.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaOverview.GetRoGroups3Name()
	return BeltalowdaOverview.roVars.groups.group3.name
end

function BeltalowdaOverview.SetRoGroups3Name(value)
	BeltalowdaOverview.roVars.groups.group3.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaOverview.GetRoGroups4Enabled()
	return BeltalowdaOverview.roVars.groups.group4.enabled
end

function BeltalowdaOverview.SetRoGroups4Enabled(value)
	BeltalowdaOverview.roVars.groups.group4.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaOverview.GetRoGroups4Name()
	return BeltalowdaOverview.roVars.groups.group4.name
end

function BeltalowdaOverview.SetRoGroups4Name(value)
	BeltalowdaOverview.roVars.groups.group4.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaOverview.GetRoGroups5Enabled()
	return BeltalowdaOverview.roVars.groups.group5.enabled
end

function BeltalowdaOverview.SetRoGroups5Enabled(value)
	BeltalowdaOverview.roVars.groups.group5.enabled = value
	BeltalowdaOverview.SetGroupsEnabled(BeltalowdaOverview.roVars.groups.enabled)
end

function BeltalowdaOverview.GetRoGroups5Name()
	return BeltalowdaOverview.roVars.groups.group5.name
end

function BeltalowdaOverview.SetRoGroups5Name(value)
	BeltalowdaOverview.roVars.groups.group5.name = value
	BeltalowdaOverview.AdjustGroupNames()
end

function BeltalowdaOverview.GetRoAvailableGroupsGroups()
	local groups = {}
	table.insert(groups, "-")
	table.insert(groups, BeltalowdaOverview.roVars.groups.group1.name)
	table.insert(groups, BeltalowdaOverview.roVars.groups.group2.name)
	table.insert(groups, BeltalowdaOverview.roVars.groups.group3.name)
	table.insert(groups, BeltalowdaOverview.roVars.groups.group4.name)
	table.insert(groups, BeltalowdaOverview.roVars.groups.group5.name)
	return groups
end

function BeltalowdaOverview.GetRoSelectedGroupsGroup(index)
	return BeltalowdaOverview.GetGroupNameFromIndex(BeltalowdaOverview.roVars.groups.ultimateGroups[index].group)
end

function BeltalowdaOverview.SetRoSelectedGroupsGroup(index, value)
	if value ~= nil then
		value = BeltalowdaOverview.GetGroupIndexFromName(value)
		BeltalowdaOverview.roVars.groups.ultimateGroups[index].group = value
		BeltalowdaOverview.AdjustGroupsGroups()
	end
end

function BeltalowdaOverview.GetRoGroupsGroupPriority(index)
	return BeltalowdaOverview.roVars.groups.ultimateGroups[index].priority
end

function BeltalowdaOverview.SetRoGroupsGroupPriority(index, value)
	BeltalowdaOverview.roVars.groups.ultimateGroups[index].priority = value
	BeltalowdaOverview.AdjustGroupsGroups()
end


function BeltalowdaOverview.GetRoGroupsAvailableModes()
	return BeltalowdaOverview.config.groupsModes
end

function BeltalowdaOverview.GetRoGroupsAvailableMode()
	return BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.roVars.groups.mode]
end

function BeltalowdaOverview.SetRoGroupsAvailableMode(value)
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

function BeltalowdaOverview.GetRoGroupsShowSoftResources()
	return BeltalowdaOverview.roVars.groups.showSoftResources
end

function BeltalowdaOverview.SetRoGroupsShowSoftResources(value)
	BeltalowdaOverview.roVars.groups.showSoftResources = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaOverview.GetRoSplitInStealthEnabled()
	return BeltalowdaOverview.roVars.splitInStealthEnabled
end

function BeltalowdaOverview.SetRoSplitInStealthEnabled(value)
	BeltalowdaOverview.roVars.splitInStealthEnabled = value
end

function BeltalowdaOverview.GetRoGroupsColorBackground()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.backdropColor)
end

function BeltalowdaOverview.SetRoGroupsColorBackground(r, g, b, a)
	BeltalowdaOverview.roVars.groups.backdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaOverview.GetRoGroupsColorMagicka()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.magicka)
end

function BeltalowdaOverview.SetRoGroupsColorMagicka(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.magicka = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaOverview.GetRoGroupsColorStamina()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.stamina)
end

function BeltalowdaOverview.SetRoGroupsColorStamina(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.stamina = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaOverview.AdjustGroupsColor()
end

function BeltalowdaOverview.GetRoGroupsColorOutOfRange()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.outOfRange)
end

function BeltalowdaOverview.SetRoGroupsColorOutOfRange(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.outOfRange = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaOverview.GetRoGroupsColorDead()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.dead)
end

function BeltalowdaOverview.SetRoGroupsColorDead(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.dead = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaOverview.GetRoGroupsColorProgressNotFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.progressNotFull)
end

function BeltalowdaOverview.SetRoGroupsColorProgressNotFull(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.progressNotFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaOverview.GetRoGroupsColorProgressFull()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaOverview.roVars.groups.progressFull)
end

function BeltalowdaOverview.SetRoGroupsColorProgressFull(r, g ,b, a)
	BeltalowdaOverview.roVars.groups.progressFull = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
end

function BeltalowdaOverview.GetRoGroupsColorLabelFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.labelFull)
end

function BeltalowdaOverview.SetRoGroupsColorLabelFull(r, g ,b)
	BeltalowdaOverview.roVars.groups.labelFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoGroupsColorLabelNotFull()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.labelNotFull)
end

function BeltalowdaOverview.SetRoGroupsColorLabelNotFull(r, g ,b)
	BeltalowdaOverview.roVars.groups.labelNotFull = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoGroupsColorEdgeOutOfCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.borderOutOfCombat)
end

function BeltalowdaOverview.SetRoGroupsColorEdgeOutOfCombat(r, g ,b)
	BeltalowdaOverview.roVars.groups.borderOutOfCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoGroupsColorEdgeInCombat()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaOverview.roVars.groups.borderInCombat)
end

function BeltalowdaOverview.SetRoGroupsColorEdgeInCombat(r, g ,b)
	BeltalowdaOverview.roVars.groups.borderInCombat = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaOverview.GetRoGroupsMaxDistance()
	return BeltalowdaOverview.roVars.groups.maxDistance
end

function BeltalowdaOverview.SetRoGroupsMaxDistance(value)
	BeltalowdaOverview.roVars.groups.maxDistance = value
end

function BeltalowdaOverview.GetRoSize()
	return BeltalowdaOverview.roVars.size
end

function BeltalowdaOverview.SetRoSize(value)
	BeltalowdaOverview.roVars.size = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaOverview.GetRoGroupsSize()
	return BeltalowdaOverview.roVars.groups.size
end

function BeltalowdaOverview.SetRoGroupsSize(value)
	BeltalowdaOverview.roVars.groups.size = value
	BeltalowdaOverview.AdjustSize()
end

function BeltalowdaOverview.GetRoSpacing()
	return BeltalowdaOverview.roVars.spacing
end

function BeltalowdaOverview.SetRoSpacing(value)
	BeltalowdaOverview.roVars.spacing = value
	BeltalowdaOverview.AdjustSize()
end