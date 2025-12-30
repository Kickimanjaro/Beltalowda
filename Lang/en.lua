-- Beltalowda - Language - en
-- By @s0rdrak (PC / EU)

local Beltalowda = _G['Beltalowda']
local BeltalowdaMenu = Beltalowda.menu
local BeltalowdaGroup = Beltalowda.group
local BeltalowdaCrown = BeltalowdaGroup.crown
local BeltalowdaAI = BeltalowdaGroup.ai
local BeltalowdaFtcv = BeltalowdaGroup.ftcv
local BeltalowdaFtcw = BeltalowdaGroup.ftcw
local BeltalowdaBeam = BeltalowdaGroup.ftcb
local BeltalowdaOverview = BeltalowdaGroup.ro
local BeltalowdaGBeam = BeltalowdaGroup.gb
local BeltalowdaHdm = BeltalowdaGroup.hdm
local BeltalowdaDt = BeltalowdaGroup.dt
local BeltalowdaIsdp = BeltalowdaGroup.isdp
local BeltalowdaCompass = Beltalowda.compass
local BeltalowdaYacs = BeltalowdaCompass.yacs
local BeltalowdaSC = BeltalowdaCompass.sc
local BeltalowdaUtil = Beltalowda.util
local BeltalowdaUtilUI = BeltalowdaUtil.ui
local BeltalowdaUltimates = BeltalowdaUtil.ultimates
local BeltalowdaNetworking = BeltalowdaUtil.networking
local BeltalowdaUtilGroup = BeltalowdaUtil.group
local BeltalowdaVersioning = BeltalowdaUtil.versioning
local BeltalowdaGMenu = BeltalowdaUtil.groupMenu
local BeltalowdaBeams = BeltalowdaUtil.beams
local BeltalowdaToolbox = Beltalowda.toolbox
local BeltalowdaSm = BeltalowdaToolbox.sm
local BeltalowdaRecharger = BeltalowdaToolbox.recharger
local BeltalowdaBft = BeltalowdaToolbox.bft
local BeltalowdaSiege = BeltalowdaToolbox.siege
local BeltalowdaCL = BeltalowdaToolbox.cl
local BeltalowdaEnhance = BeltalowdaToolbox.enhancements
local BeltalowdaRespawner = BeltalowdaToolbox.respawner
local BeltalowdaSP = BeltalowdaToolbox.sp
local BeltalowdaSO = BeltalowdaToolbox.so
local BeltalowdaAdmin = Beltalowda.admin
local BeltalowdaConfig = Beltalowda.cfg

Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.slashCmd .. " menu: opens the configuration menu"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." admin: opens the admin interface"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." config: opens the configuration import / export interface"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." hdm clear: Resets the Healing Damage Meter"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n/ai: enable auto invite (e.g. /ai beltalowda) - turn off with /ai"

--Tool
Beltalowda.constants = Beltalowda.constants or {}
Beltalowda.constants.MISSING_LIBRARIES = "Beltalowda is missing the following libraries: "

--Menu Constants
--Profile
BeltalowdaMenu.constants = BeltalowdaMenu.constants or {}
BeltalowdaMenu.constants.PROFILE_HEADER = "Profile Settings"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE = "Selected Profile"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE_TOOLTIP = "Select the profile you want to use"
BeltalowdaMenu.constants.PROFILE_NEW_PROFILE = "New Profile"
BeltalowdaMenu.constants.PROFILE_ADD_PROFILE = "Add"
BeltalowdaMenu.constants.PROFILE_CLONE_PROFILE = "Copy"
BeltalowdaMenu.constants.PROFILE_REMOVE_PROFILE = "Remove"
BeltalowdaMenu.constants.PROFILE_EXISTS = "|cFF0000The profile already exists. Please use another name|r"
BeltalowdaMenu.constants.PROFILE_CANT_REMOVE_DEFAULT = "|cFF0000This profile can't be removed|r"

--Fixed Components
BeltalowdaMenu.constants.POSITION_FIXED_SET = "Set Position Fixed"
BeltalowdaMenu.constants.POSITION_FIXED_UNSET = "Unset Position Fixed"

--Donate
BeltalowdaMenu.constants.FEEDBACK = "Feedback"
BeltalowdaMenu.constants.FEEDBACK_STRING = "Please provide your feedback through the official ESO forums or ESOUI. I won't be able to respond to your in-game mails."
BeltalowdaMenu.constants.DONATE = "Donate"
BeltalowdaMenu.constants.DONATE_5K = "Donate 5'000 gold"
BeltalowdaMenu.constants.DONATE_50K = "Donate 50'000 gold"
BeltalowdaMenu.constants.DONATE_SERVER_ERROR = "Thank you for trying to donate something. Unfortunately, we are playing on different servers."
BeltalowdaMenu.constants.DONATE_MAIL_SUBJECT = "Beltalowda Donation"

--Group
BeltalowdaMenu.constants.GROUP_HEADER = "|cFF8174Group Settings|r"

--Crown
BeltalowdaMenu.constants.CROWN_HEADER = "|c4592FFCrown|r"
BeltalowdaMenu.constants.CROWN_CHK_GROUP_CROWN_ENABLED = "Custom crown activated"
BeltalowdaMenu.constants.CROWN_SELECTED_MODE = "Crown Mode"
BeltalowdaMenu.constants.CROWN_MODE = {}
BeltalowdaMenu.constants.CROWN_MODE[1] = "Pin"
BeltalowdaMenu.constants.CROWN_SELECTED_CROWN = "Selected Crown"
BeltalowdaMenu.constants.CROWN_SIZE = "Size"
BeltalowdaMenu.constants.CROWN_WARNING = "|cFF0000Only 1 AddOn can implement this functionality. If two AddOns are using this functionality, the game will crash!|r"
BeltalowdaMenu.constants.CROWN_PVP_ONLY = "PvP Only"

--Auto Invite
BeltalowdaMenu.constants.AI_HEADER = "|c4592FFAuto Invite|r"
BeltalowdaMenu.constants.AI_ENABLED = "Enabled"
BeltalowdaMenu.constants.AI_INVITE_TEXT = "Invite String"
BeltalowdaMenu.constants.AI_GROUP_SIZE = "Max Group Size"
BeltalowdaMenu.constants.AI_PVP_CHECK = "PvP Only"
BeltalowdaMenu.constants.AI_SEND_CHAT_MESSAGES = "Send Chat Messages"
BeltalowdaMenu.constants.AI_AUTO_KICK = "Auto Kick"
BeltalowdaMenu.constants.AI_AUTO_KICK_TIME = "Auto Kick Interval"
BeltalowdaMenu.constants.AI_CHAT = "Allowed Chats"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS = "Player Restrictions"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_TOOLTIP = "Defines to who the auto invite is restricted."
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD = "Guild"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD_FRIEND = "Guild and Friends"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_FRIEND = "Friends"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD = "Specific Guild"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD_FRIEND = "Specific Guild and Friends"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_NONE = "None"
BeltalowdaMenu.constants.AI_SHOW_MEMBER_LEFT = "Show all leave messages"

--Follow The Crown Visual
BeltalowdaMenu.constants.FTCV_HEADER = "|c4592FFFollow The Crown (Arrow)|r"
BeltalowdaMenu.constants.FTCV_ENABLED = "Enabled"
BeltalowdaMenu.constants.FTCV_MODE = "Mode"
BeltalowdaMenu.constants.FTCV_COLOR_MODE = "Color Mode"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_ORIENTATION = "Orientation (Front, Side, Behind)"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_DISTANCE = "Distance (Close, Far)"
BeltalowdaMenu.constants.FTCV_COLOR_FRONT = "Color 1 (Front / Close)"
BeltalowdaMenu.constants.FTCV_COLOR_SIDE = "Color 2 (Side)"
BeltalowdaMenu.constants.FTCV_COLOR_BACK = "Color 3 (Behind / Far)"
BeltalowdaMenu.constants.FTCV_OPACITY_CLOSE = "Distance Opacity Close"
BeltalowdaMenu.constants.FTCV_OPACITY_FAR = "Distance Opacity Far"
BeltalowdaMenu.constants.FTCV_SIZE_CLOSE = "Size Close"
BeltalowdaMenu.constants.FTCV_SIZE_FAR = "Size Far"
BeltalowdaMenu.constants.FTCV_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCV_MODE_RETICLE = "Reticle"
BeltalowdaMenu.constants.FTCV_MODE_FIXED = "Fixed"
BeltalowdaMenu.constants.FTCV_POSITION = "Position"
BeltalowdaMenu.constants.FTCV_MAX_DISTANCE = "Maximum Allowed Distance"
BeltalowdaMenu.constants.FTCV_MIN_DISTANCE = "Minimum Distance"
BeltalowdaMenu.constants.FTCV_TEXTURES = "Texture"

--Follow The Crown Warnings
BeltalowdaMenu.constants.FTCW_HEADER = "|c4592FFFollow The Crown (Warnings)|r"
BeltalowdaMenu.constants.FTCW_ENABLED = "Enabled"
BeltalowdaMenu.constants.FTCW_WARNINGS_ENABLED = "Warnings Enabled"
BeltalowdaMenu.constants.FTCW_DISTANCE_ENABLED = "Distance Enabled"
BeltalowdaMenu.constants.FTCW_DISTANCE_BACKDROP_ENABLED = "Distance Background Enabled"
BeltalowdaMenu.constants.FTCW_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.FTCW_DISTANCE = "Maximum Allowed Distance"
BeltalowdaMenu.constants.FTCW_IGNORE_DISTANCE = "Distance Deactivation"
BeltalowdaMenu.constants.FTCW_WARNING_COLOR = "Warning Color"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_NORMAL = "Distance Color Normal"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_ALERT = "Distance Color Alert"
BeltalowdaMenu.constants.FTCW_PVP_ONLY = "PvP Only"

--Follow The Crown Audio
BeltalowdaMenu.constants.FTCA_HEADER = "|c4592FFFollow The Crown (Audio)|r"
BeltalowdaMenu.constants.FTCA_ENABLED = "Enabled"
BeltalowdaMenu.constants.FTCA_DISTANCE = "Maximum Allowed Distance"
BeltalowdaMenu.constants.FTCA_IGNORE_DISTANCE = "Distance Deactivation"
BeltalowdaMenu.constants.FTCA_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCA_UNMOUNTED_ONLY = "Only Without Mount"
BeltalowdaMenu.constants.FTCA_SOUND = "Audio"
BeltalowdaMenu.constants.FTCA_INTERVAL = "Interval"
BeltalowdaMenu.constants.FTCA_THRESHOLD = "Threshold"

--Follow The Crown Beam
BeltalowdaMenu.constants.FTCB_HEADER = "|c4592FFFollow The Crown (Beam)|r"
BeltalowdaMenu.constants.FTCB_WARNING = "|cFF0000SubSampling Quality has to be set to High. Otherwise this module won't work.|r"
BeltalowdaMenu.constants.FTCB_ENABLED = "Enabled"
BeltalowdaMenu.constants.FTCB_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCB_SELECTED_BEAM = "Selected Beam"
BeltalowdaMenu.constants.FTCB_COLOR = "Color"

--Debuff Overview
BeltalowdaMenu.constants.DBO_HEADER = "|c4592FFDebuff Overview|r"
BeltalowdaMenu.constants.DBO_ENABLED = "Enabled"
BeltalowdaMenu.constants.DBO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.DBO_CRITICAL_AMOUNT = "Critical Amount Of Debuffs"
BeltalowdaMenu.constants.DBO_COLOR_OKAY = "Color Okay [0]"
BeltalowdaMenu.constants.DBO_COLOR_NOT_OKAY = "Color Not Okay  [1]"
BeltalowdaMenu.constants.DBO_COLOR_CRITICAL = " Color Critical"
BeltalowdaMenu.constants.DBO_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.DBO_COLOR_OUT_OF_RANGE = "Color Out Of Range"
BeltalowdaMenu.constants.DBO_DESCRIPTION = "This module requires the map pins of other modules (Resource Overview, Synergy Overview, Healing Damage Meter). To get the best results, activate the Resource Overview."
BeltalowdaMenu.constants.DBO_SIZE = "Size"

--Rapid Tracker
BeltalowdaMenu.constants.RT_HEADER = "|c4592FFRapid Overview|r"
BeltalowdaMenu.constants.RT_ENABLED = "Enabled"
BeltalowdaMenu.constants.RT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.RT_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.RT_COLOR_LABEL_IN_RANGE = "Color Name In Range"
BeltalowdaMenu.constants.RT_COLOR_LABEL_NOT_IN_RANGE = "Color Name Out Of Range"
BeltalowdaMenu.constants.RT_COLOR_LABEL_OUT_OF_RANGE = "Color Name AFK"
BeltalowdaMenu.constants.RT_COLOR_RAPID_ON = "Color Rapid Active"
BeltalowdaMenu.constants.RT_COLOR_RAPID_OFF = "Color Rapid Inactive"

--Resource Overview
BeltalowdaMenu.constants.RO_HEADER_ULTIMATES = "|c4592FFResource Overview (Combined)|r"
BeltalowdaMenu.constants.RO_ENABLED = "Enabled"
BeltalowdaMenu.constants.RO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.RO_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED = "Ultimate Group Overview Enabled"
BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED = "Client Window Enabled"
BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED = "Group Window Enabled"
BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES = "Display Stamina / Magicka"
BeltalowdaMenu.constants.RO_DISPLAYED_ULTIMATES = "Displayed Number of Ultimates"
BeltalowdaMenu.constants.RO_COLOR_BACKGROUND = "Resource Background Color"
BeltalowdaMenu.constants.RO_COLOR_MAGICKA = "Resource Magicka Color"
BeltalowdaMenu.constants.RO_COLOR_STAMINA = "Resource Stamina Color"
BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE = "Resource Out Of Range Color"
BeltalowdaMenu.constants.RO_COLOR_DEAD = "Resource Dead Color"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL = "Resource Not Full Color"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL = "Resource Full Color"
BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL = "Resource Label Color \"Full\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL = "Resource Label Color \"Not Full\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP = "Resource Label Color \"Group\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT = "Announcement Color"
BeltalowdaMenu.constants.RO_ANNOUNCEMENT_SIZE = "Announcement Size"
BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED = "In Combat State Enabled"
BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR = "In Combat Color"
BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR = "Out Of Combat Color"
BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED = "In Stealth State Enabled"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED = "Ultimate Groups Enabled"
BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE = "Order Mode"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_DESTRO = "Destruction Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_STORM = "Storm Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NORTHERNSTORM = "Northern Storm Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_PERMAFROST = "Permafrost Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE = "Negate Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_OFFENSIVE = "Negate Off Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_COUNTER = "Negate Counter Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NOVA = "Nova Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE = "Display Mode"
BeltalowdaMenu.constants.RO_MAX_DISTANCE = "Max Distance"
BeltalowdaMenu.constants.RO_SOUND_ENABLED = "Sound Enabled"
BeltalowdaMenu.constants.RO_SELECTED_SOUND = "Selected Sound"
BeltalowdaMenu.constants.RO_HEADER_GROUPS = "|c4592FFResource Overview (Split)|r"
BeltalowdaMenu.constants.RO_GROUPS_ENABLED = "Groups Enabled"
BeltalowdaMenu.constants.RO_GROUPS_MODE = "Mode"
BeltalowdaMenu.constants.RO_GROUPS_1_NAME = "Group 1 Name"
BeltalowdaMenu.constants.RO_GROUPS_2_NAME = "Group 2 Name"
BeltalowdaMenu.constants.RO_GROUPS_3_NAME = "Group 3 Name"
BeltalowdaMenu.constants.RO_GROUPS_4_NAME = "Group 4 Name"
BeltalowdaMenu.constants.RO_GROUPS_5_NAME = "Group 5 Name"
BeltalowdaMenu.constants.RO_GROUPS_1_ENABLED = "Group 1 Enabled"
BeltalowdaMenu.constants.RO_GROUPS_2_ENABLED = "Group 2 Enabled"
BeltalowdaMenu.constants.RO_GROUPS_3_ENABLED = "Group 3 Enabled"
BeltalowdaMenu.constants.RO_GROUPS_4_ENABLED = "Group 4 Enabled"
BeltalowdaMenu.constants.RO_GROUPS_5_ENABLED = "Group 5 Enabled"
BeltalowdaMenu.constants.RO_GROUPS_1_DEFAULT = "Damage"
BeltalowdaMenu.constants.RO_GROUPS_2_DEFAULT = "Support"
BeltalowdaMenu.constants.RO_GROUPS_3_DEFAULT = "Heal"
BeltalowdaMenu.constants.RO_GROUPS_4_DEFAULT = "Synergy"
BeltalowdaMenu.constants.RO_GROUPS_5_DEFAULT = "Undefined"
BeltalowdaMenu.constants.RO_GROUPS_PRIORITY = " Priority:"
BeltalowdaMenu.constants.RO_GROUPS_GROUP = " Group:"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_OUT_OF_COMBAT = "Border Out Of Combat"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_IN_COMBAT = "Border In Combat"
BeltalowdaMenu.constants.RO_SIZE = "Size"
BeltalowdaMenu.constants.RO_SPACING = "Spacing"
BeltalowdaMenu.constants.RO_SHARED_SETTING = "This resource overview setting (Combined / Split) is shared. Changing the value will change the value in both modules. Disable the modules functionality by adjusting other (windows) settings."

--HP Damage Meter
BeltalowdaMenu.constants.HDM_HEADER = "|c4592FFHealing Damage Meter|r"
BeltalowdaMenu.constants.HDM_ENABLED = "Enabled"
BeltalowdaMenu.constants.HDM_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.HDM_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.HDM_WINDOW_ENABLED = "Window Enabled"
BeltalowdaMenu.constants.HDM_USING_ALPHA = "Using Alpha"
BeltalowdaMenu.constants.HDM_USING_COLORS = "Background Colors"
BeltalowdaMenu.constants.HDM_USING_HIGHLIGHT_APPLICANT = "Applicant Highlight"
BeltalowdaMenu.constants.HDM_AUTO_RESET = "Reset Counter Out Of Combat"
BeltalowdaMenu.constants.HDM_SELECTED_VIEWMODE = "Selected Mode"
BeltalowdaMenu.constants.HDM_ALIVE_COLOR = "Color Alive"
BeltalowdaMenu.constants.HDM_DEAD_COLOR = "Color Dead"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_HEALER = "Background Color Healer"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_DD = "Background Color DD"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_TANK = "Background Color Tank"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_APPLICANT = "Background Color Applicant"
BeltalowdaMenu.constants.HDM_SIZE = "Size"

--Potion Overview
BeltalowdaMenu.constants.PO_HEADER = "|c4592FFPotion Overview|r"
BeltalowdaMenu.constants.PO_ENABLED = "Enabled"
BeltalowdaMenu.constants.PO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.PO_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_NO_IMMOVABLE = "Background Color No Immovable"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_FULL = "Background Color Immovable Full"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_LOW = "Background Color Immovable Low"
BeltalowdaMenu.constants.PO_COLOR_PROGRESS_IMMOVABLE = "Progress Color Immovable"
-- U30+ Change (Temporary Fix)
--[[
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Progress Color Potion (Crafted)"
BeltalowdaMenu.constants.PO_COLOR_CROWN_PROGRESS_POTION = "Progress Color Potion (Crown)"
BeltalowdaMenu.constants.PO_COLOR_NON_CRAFTED_PROGRESS_POTION = "Progress Color Potion (Non Crafted)"
BeltalowdaMenu.constants.PO_COLOR_ALLIANCE_PROGRESS_POTION = "Progress Color Potion (Alliance)"
]]
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Progress Color Potion"
BeltalowdaMenu.constants.PO_COLOR_LABEL_IMMOVABLE = "Immovable Label Color"
BeltalowdaMenu.constants.PO_COLOR_LABEL_POTION = "Potion Label Color"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_IMMOVABLE = "Immovable Backdrop Color"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_POTION = "Potion Backdrop Color"
BeltalowdaMenu.constants.PO_SOUND_ENABLED = "Sound Enabled"
BeltalowdaMenu.constants.PO_SELECTED_SOUND = "Selected Sound"

--Detonation Tracker
BeltalowdaMenu.constants.DT_HEADER = "|c4592FFDetonation / Shalk Tracker|r"
BeltalowdaMenu.constants.DT_ENABLED = "Enabled"
BeltalowdaMenu.constants.DT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.DT_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION = "Detonation: Font Color"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION = "Detonation: Progress Color"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT = "Sub Assault: Font Color"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT = "Sub Assault: Progress Color"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2 = "Sub Assault 2: Font Color"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2 = "Sub Assault 2: Progress Color"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE = "Deep Fissure: Font Color"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE = "Deep Fissure: Progress Color"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2 = "Deep Fissure 2: Font Color"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2 = "Deep Fissure 2: Progress Color"
BeltalowdaMenu.constants.DT_SIZE = "Size"
BeltalowdaMenu.constants.DT_MODE = "Mode"
BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION = "Smooth Transition"

--Group Beams
BeltalowdaMenu.constants.GB_HEADER = "|c4592FFGroup Beams|r"
BeltalowdaMenu.constants.GB_DESCRIPTION = "The beam of the player depends on the role that has been assigned. The role can be assigned by the group leader or by the player."
BeltalowdaMenu.constants.GB_ENABLED = "Enabled"
BeltalowdaMenu.constants.GB_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.GB_HIDE_WHEN_DEAD = "Hide When Dead"
BeltalowdaMenu.constants.GB_SIZE = "Size"
BeltalowdaMenu.constants.GB_SELECTED_BEAM = "Selected Beam"
BeltalowdaMenu.constants.GB_ROLE_RAPID_ENABLED = "Rapid Enabled"
BeltalowdaMenu.constants.GB_ROLE_RAPID_COLOR = "Rapid Color"
BeltalowdaMenu.constants.GB_ROLE_PURGE_ENABLED = "Purge Enabled"
BeltalowdaMenu.constants.GB_ROLE_PURGE_COLOR = "Purge Color"
BeltalowdaMenu.constants.GB_ROLE_HEAL_ENABLED = "Heal Enabled"
BeltalowdaMenu.constants.GB_ROLE_HEAL_COLOR = "Heal Color"
BeltalowdaMenu.constants.GB_ROLE_DD_ENABLED = "DD Enabled"
BeltalowdaMenu.constants.GB_ROLE_DD_COLOR = "DD Color"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_ENABLED = "Synergy Enabled"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_COLOR = "Synergy Color"
BeltalowdaMenu.constants.GB_ROLE_CC_ENABLED = "CC Enabled"
BeltalowdaMenu.constants.GB_ROLE_CC_COLOR = "CC Color"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_ENABLED = "Support Enabled"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_COLOR = "Support Color"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_ENABLED = "Undefined Enabled"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_COLOR = "Undefined Color"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_ENABLED = "Applicant Enabled"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_COLOR = "Applicant Color"

--I See Dead People
BeltalowdaMenu.constants.ISDP_HEADER = "|c4592FFI See Dead People|r"
BeltalowdaMenu.constants.ISDP_ENABLED = "Enabled"
BeltalowdaMenu.constants.ISDP_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.ISDP_SIZE = "Size"
BeltalowdaMenu.constants.ISDP_SELECTED_BEAM = "Selected Beam"
BeltalowdaMenu.constants.ISDP_COLOR_DEAD = "Dead Color"
BeltalowdaMenu.constants.ISDP_COLOR_BEING_RESURRECTED = "Being Resurrected Color"
BeltalowdaMenu.constants.ISDP_COLOR_RESURRECTED = "Resurrected Color"

--Compass
BeltalowdaMenu.constants.COMPASS_HEADER = "|cFF8174Compass Settings|r"
--YACS
BeltalowdaMenu.constants.YACS_HEADER = "|c4592FFYet Another Compass|r"
BeltalowdaMenu.constants.YACS_CHK_ADDON_ENABLED = "Enabled"
BeltalowdaMenu.constants.YACS_CHK_PVP = "Enabled in PVP"
BeltalowdaMenu.constants.YACS_CHK_PVE = "Enabled in PVE"
BeltalowdaMenu.constants.YACS_CHK_COMBAT = "Enabled in Combat"
BeltalowdaMenu.constants.YACS_CHK_MOVABLE = "Movable Compass"
BeltalowdaMenu.constants.YACS_COLOR_COMPASS = "Compass Color"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE = "Compass Size"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE_TOOLTIPE = "Sets the size of the compass."
BeltalowdaMenu.constants.YACS_COMPASS_STYLE = "Style"
BeltalowdaMenu.constants.YACS_COMPASS_STYLE_TOOLTIP = "Select the compass style you prefer."
BeltalowdaMenu.constants.YACS_RESTORE_DEFAULTS = "Restore Defaults"

--SC
BeltalowdaMenu.constants.COMPASS_SC_HEADER = "|c4592FFSimple Compass|r"
BeltalowdaMenu.constants.COMPASS_SC_ENABLED = "Enabled"
BeltalowdaMenu.constants.COMPASS_SC_PVP = "Enabled in PVP"
BeltalowdaMenu.constants.COMPASS_SC_PVE = "Enabled in PVE"
BeltalowdaMenu.constants.COMPASS_SC_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_BACKDROP = "Background Color"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_NORTH = "Color North"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_SOUTH = "Color South"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_WEST = "Color West"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_EAST = "Color East"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_OTHERS = "Color Others"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_MARKERS = "Color Markers"

--Toolbox
BeltalowdaMenu.constants.TOOLBOX_HEADER = "|cFF8174Toolbox Settings|r"
--Siege Merchant
BeltalowdaMenu.constants.SM_HEADER = "|c4592FFSiege Merchant|r"
BeltalowdaMenu.constants.SM_ENABLED = "Enabled"
BeltalowdaMenu.constants.SM_SEND_CHAT_MESSAGES = "Send Chat Messages"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_WALL = "Keep Wall Masonry Repair Kit"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_DOOR = "Keep Door Woodwork Repair Kit"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_SIEGE = "Siege Repair Kit"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_FIRE = "Fire Ballista"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_STONE = "Ballista"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_LIGHTNING = "Lightning Ballista"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_FIRE = "Firepot Trebuchet"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_STONE = "Stone Trebuchet"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_ICE = "Iceball Trebuchet"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_MEATBAG = "Meatbag Catapult"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_OIL = "Oil Catapult"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_SCATTERSHOT = "Scattershot Catapult"
BeltalowdaMenu.constants.SM_ITEM_OIL = "Flaming Oil"
BeltalowdaMenu.constants.SM_ITEM_CAMP = "Forward Camp"
BeltalowdaMenu.constants.SM_ITEM_RAM = "Battering Ram"
BeltalowdaMenu.constants.SM_ITEM_KEEP_RECALL = "Keep Recall Stone"
BeltalowdaMenu.constants.SM_ITEM_DESTRUCTIBLE_REPAIR = "Bridge / Milegate Repair Kit"
BeltalowdaMenu.constants.SM_MIN = "Minimum"
BeltalowdaMenu.constants.SM_MAX = "Maximum"
BeltalowdaMenu.constants.SM_PAYMENT_OPTIONS = "Payment Options"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_ALL = "Cyrodiil Repair Kit"
BeltalowdaMenu.constants.SM_ITEM_POT_RED = "Alliance Health Draught"
BeltalowdaMenu.constants.SM_ITEM_POT_GREEN = "Alliance Battle Draught"
BeltalowdaMenu.constants.SM_ITEM_POT_BLUE = "Alliance Spell Draught"

--Recharger
BeltalowdaMenu.constants.RECHARGER_HEADER = "|c4592FFRecharger|r"
BeltalowdaMenu.constants.RECHARGER_ENABLED = "Enabled"
BeltalowdaMenu.constants.RECHARGER_SEND_CHAT_MESSAGES = "Send Chat Messages"
BeltalowdaMenu.constants.RECHARGER_PERCENT = "Minimum Recharge Percentage"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_WARNING = "No Soul Gems Alert"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_WARNING = "Soon Out Of Soul Gems Alert"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_SLIDER = "Soul Gems Threshold"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_LOGIN_WARNING = "Soul Gems Login Alert"
BeltalowdaMenu.constants.RECHARGER_INTERVAL = "Check Interval"

--Keep Claimer
BeltalowdaMenu.constants.KC_HEADER = "|c4592FFKeep Claimer|r"
BeltalowdaMenu.constants.KC_ENABLED = "Enabled"
BeltalowdaMenu.constants.KC_GUILD_1 = "Priority 1"
BeltalowdaMenu.constants.KC_GUILD_2 = "Priority 2"
BeltalowdaMenu.constants.KC_GUILD_3 = "Priority 3"
BeltalowdaMenu.constants.KC_GUILD_4 = "Priority 4"
BeltalowdaMenu.constants.KC_GUILD_5 = "Priority 5"
BeltalowdaMenu.constants.KC_CLAIM_KEEPS = "Claim Keeps"
BeltalowdaMenu.constants.KC_CLAIM_OUTPOSTS = "Claim Outposts"
BeltalowdaMenu.constants.KC_CLAIM_RESOURCES = "Claim Resources"

--Buff Food Tracker
BeltalowdaMenu.constants.BFT_HEADER = "|c4592FFBuff Food Tracker|r"
BeltalowdaMenu.constants.BFT_ENABLED = "Enabled"
BeltalowdaMenu.constants.BFT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.BFT_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.BFT_SIZE = "Warning Size"
BeltalowdaMenu.constants.BFT_COLOR = "Warning Color"
BeltalowdaMenu.constants.BFT_SOUND_ENABLED = "Sound Enabled"
BeltalowdaMenu.constants.BFT_SELECTED_SOUND = "Selected Sound"
BeltalowdaMenu.constants.BFT_WARNING_TIMER = "Warning Timer"

--Cyrodiil Log
BeltalowdaMenu.constants.CL_HEADER = "|c4592FFCyrodiil Log|r"
BeltalowdaMenu.constants.CL_ENABLED = "Enabled"
BeltalowdaMenu.constants.CL_GUILD_CLAIM_ENABLED = "Guild Claim Messages"
BeltalowdaMenu.constants.CL_GUILD_LOST_ENABLED = "Guild Lost Messages"
BeltalowdaMenu.constants.CL_UA_ENABLED = "Under Attack Messages"
BeltalowdaMenu.constants.CL_UA_LOST_ENABLED = "Under Attack Status Lost Messages"
BeltalowdaMenu.constants.CL_KEEP_ALLIANCE_CHANGED_ENABLED = "Owning Alliance Changed Messages"
BeltalowdaMenu.constants.CL_TICK_DEFENSE = "Defense Tick Messages"
BeltalowdaMenu.constants.CL_TICK_OFFENSE = "Offense Tick Messages"
BeltalowdaMenu.constants.CL_SCROLL_NOTIFICATIONS = "Scroll Messages"
BeltalowdaMenu.constants.CL_EMPEROR_ENABLED = "Emperor Messages"
BeltalowdaMenu.constants.CL_QUEST_ENABLED = "Quest Messages"
BeltalowdaMenu.constants.CL_BATTLEGROUND_ENABLED = "Battleground Messages"
BeltalowdaMenu.constants.CL_DAEDRIC_ARTIFACT_ENABLED = "Daedric Artifacte Messages"

--Cyrodiil Status
BeltalowdaMenu.constants.CS_HEADER = "|c4592FFCyrodiil Status|r"
BeltalowdaMenu.constants.CS_ENABLED = "Enabled"
BeltalowdaMenu.constants.CS_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.CS_HIDE_ON_WORLDMAP = "Hide on World Map"
BeltalowdaMenu.constants.CS_SHOW_FLAGS = "Show Flags"
BeltalowdaMenu.constants.CS_SHOW_SIEGES = "Show Sieges"
BeltalowdaMenu.constants.CS_SHOW_OWNER_CHANGES = "Show Keep Flip Timers"
BeltalowdaMenu.constants.CS_SHOW_ACTION_TIMERS = "Show Action Timers"
BeltalowdaMenu.constants.CS_COLOR_DEFAULT = "Default Color"
BeltalowdaMenu.constants.CS_COLOR_COOLDOWN = "Cooldown Color"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_POSITIVE = "Positive Flag Flip Color"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_NEGATIVE = "Negative Flag Flip Color"
BeltalowdaMenu.constants.CS_SHOW_KEEPS = "Show Keeps"
BeltalowdaMenu.constants.CS_SHOW_OUTPOSTS = "Show Outposts"
BeltalowdaMenu.constants.CS_SHOW_RESOURCES = "Show Resources"
BeltalowdaMenu.constants.CS_SHOW_VILLAGES = "Show Towns"
BeltalowdaMenu.constants.CS_SHOW_TEMPLES = "Show Temples"
BeltalowdaMenu.constants.CS_SHOW_DESTRUCTIBLES = "Show Destructibles"

--Enhancements
BeltalowdaMenu.constants.ENHANCE_HEADER = "|c4592FFEnhancements|r"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_ENABLED = "Quest Tracker Disabled"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_PVP_ONLY = "Quest Tracker PvP Only"
BeltalowdaMenu.constants.ENHANCE_COMPASS_TWEAKS_ENABLED = "Compass Enhancements Enabled"
BeltalowdaMenu.constants.ENHANCE_COMPASS_PVP_ONLY = "Compass PvP Only"
BeltalowdaMenu.constants.ENHANCE_COMPASS_HIDDEN = "Compass Hidden"
BeltalowdaMenu.constants.ENHANCE_COMPASS_WIDTH = "Compass Width"
BeltalowdaMenu.constants.ENHANCE_ALERTS_TWEAKS_ENABLED = "Alerts Enhancements Enabled"
BeltalowdaMenu.constants.ENHANCE_ALERTS_PVP_ONLY = "Alerts PvP Only"
BeltalowdaMenu.constants.ENHANCE_ALERTS_HIDDEN = "Alerts Hidden"
BeltalowdaMenu.constants.ENHANCE_ALERTS_POSITION = "Alerts Position"
BeltalowdaMenu.constants.ENHANCE_ALERTS_COLOR = "Alerts Color"
BeltalowdaMenu.constants.ENHANCE_RESPAWN_TIMER_ENABLED = "Respawn Timer Enabled"

--Respawner
BeltalowdaMenu.constants.RESPAWNER_HEADER = "|c4592FFRespawner|r"
BeltalowdaMenu.constants.RESPAWNER_ENABLED = "Enabled"
BeltalowdaMenu.constants.RESPAWNER_RESTRICTED_PORT = "Restricted Range"

--Camp Preview
BeltalowdaMenu.constants.CP_HEADER = "|c4592FFCamp Preview|r"
BeltalowdaMenu.constants.CP_ENABLED = "Enabled"

--Synergy Prevention
BeltalowdaMenu.constants.SP_HEADER = "|c4592FFSynergy Prevention|r"
BeltalowdaMenu.constants.SP_ENABLED = "Enabled"
BeltalowdaMenu.constants.SP_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.SP_WINDOW_ENABLED = "Window Enabled"
BeltalowdaMenu.constants.SP_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.SP_MODE = "Mode"
BeltalowdaMenu.constants.SP_MAX_DISTANCE = "Maximum Distance"
BeltalowdaMenu.constants.SP_SYNERGY_COMBUSTION_SHARD = "Prevent Combustion / Shards"
BeltalowdaMenu.constants.SP_SYNERGY_TALONS = "Prevent Talons"
BeltalowdaMenu.constants.SP_SYNERGY_NOVA = "Prevent Nova"
BeltalowdaMenu.constants.SP_SYNERGY_BLOOD_ALTAR = "Prevent Altar"
BeltalowdaMenu.constants.SP_SYNERGY_STANDARD = "Prevent Standard"
BeltalowdaMenu.constants.SP_SYNERGY_PURGE = "Prevent Ritual"
BeltalowdaMenu.constants.SP_SYNERGY_BONE_SHIELD = "Prevent Bone Shield"
BeltalowdaMenu.constants.SP_SYNERGY_FLOOD_CONDUIT = "Prevent Conduit"
BeltalowdaMenu.constants.SP_SYNERGY_ATRONACH = "Prevent Atronach"
BeltalowdaMenu.constants.SP_SYNERGY_TRAPPING_WEBS = "Prevent Trapping Webs"
BeltalowdaMenu.constants.SP_SYNERGY_RADIATE = "Prevent Radiate"
BeltalowdaMenu.constants.SP_SYNERGY_CONSUMING_DARKNESS = "Prevent Consuming Darkness"
BeltalowdaMenu.constants.SP_SYNERGY_SOUL_LEECH = "Prevent Soul Leech"
BeltalowdaMenu.constants.SP_SYNERGY_WARDEN_HEALING = "Prevent Healing Seed"
BeltalowdaMenu.constants.SP_SYNERGY_GRAVE_ROBBER = "Prevent Grave Robber"
BeltalowdaMenu.constants.SP_SYNERGY_PURE_AGONY = "Prevent Pure Agony"
BeltalowdaMenu.constants.SP_SYNERGY_ICY_ESCAPE = "Prevent Icy Escape"
BeltalowdaMenu.constants.SP_SYNERGY_SANGUINE_BURST = "Prevent Sanguine Burst"
BeltalowdaMenu.constants.SP_SYNERGY_HEED_THE_CALL = "Prevent Heed the Call"
BeltalowdaMenu.constants.SP_SYNERGY_URSUS = "Prevent Ursus's Blessing"
BeltalowdaMenu.constants.SP_SYNERGY_GRYPHON = "Prevent Gryphon's Reprisal"
BeltalowdaMenu.constants.SP_SYNERGY_RUNEBREAK = "Prevent Runebreak"
BeltalowdaMenu.constants.SP_SYNERGY_PASSAGE = "Prevent Passage"

--Synergy Overview
BeltalowdaMenu.constants.SO_HEADER = "|c4592FFSynergy Overview|r"
BeltalowdaMenu.constants.SO_ENABLED = "Enabled"
BeltalowdaMenu.constants.SO_WINDOW_ENABLED = "Window Enabled"
BeltalowdaMenu.constants.SO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.SO_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.SO_DISPLAY_MODE = "Display Mode"
BeltalowdaMenu.constants.SO_TABLE_MODE = "Table Mode"
BeltalowdaMenu.constants.SO_SIZE = "Size"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP = "Synergy Backdrop Color"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS = "Synergy Progress Color"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY = "Synergy Color"
BeltalowdaMenu.constants.SO_COLOR_BACKGROUND = "Background Color"
BeltalowdaMenu.constants.SO_COLOR_TEXT = "Text Color"
BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD = "Show Combustion / Shards"
BeltalowdaMenu.constants.SO_SYNERGY_TALONS = "Show Talons"
BeltalowdaMenu.constants.SO_SYNERGY_NOVA = "Show Nova"
BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR = "Show Altar"
BeltalowdaMenu.constants.SO_SYNERGY_STANDARD = "Show Standard"
BeltalowdaMenu.constants.SO_SYNERGY_PURGE = "Show Ritual"
BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD = "Show Bone Shield"
BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT = "Show Conduit"
BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH = "Show Atronach"
BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS = "Show Trapping Webs"
BeltalowdaMenu.constants.SO_SYNERGY_RADIATE = "Show Radiate"
BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS = "Show Consuming Darkness"
BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH = "Show Soul Leech"
BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING = "Show Healing Seed"
BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER = "Show Grave Robber"
BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY = "Show Pure Agony"
BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE = "Show Icy Escape"
BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST = "Show Sanguine Burst"
BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL = "Show Heed the Call"
BeltalowdaMenu.constants.SO_SYNERGY_URSUS = "Show Ursus's Blessing"
BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON = "Show Gryphon's Reprisal"
BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK = "Show Runebreak"
BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE = "Show Passage"
BeltalowdaMenu.constants.SO_REDUCED_SPACING = "Reduced Spacing"

--Role Assignment
BeltalowdaMenu.constants.RA_HEADER = "|c4592FFRole Assignment|r"
BeltalowdaMenu.constants.RA_ENABLED = "Enabled"
BeltalowdaMenu.constants.RA_OVERRIDE_ALLOWED = "Override Allowed"
BeltalowdaMenu.constants.RA_ROLE = "Character Role"

--Campaign Joiner
BeltalowdaMenu.constants.CAJ_HEADER = "|c4592FFCampaign Auto Join|r"
BeltalowdaMenu.constants.CAJ_ENABLED = "Enabled"

--AvA Messages
BeltalowdaMenu.constants.AM_HEADER = "|c4592FFAvA Messages|r"
BeltalowdaMenu.constants.AM_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.AM_CORONATE_EMPEROR = "Coronate Emperor Messages"
BeltalowdaMenu.constants.AM_DEPOSE_EMPEROR = "Depose Emperor Messages"
BeltalowdaMenu.constants.AM_KEEP_GATE = "Keep Gate Messages"
BeltalowdaMenu.constants.AM_ARTIFACT_CONTROL = "Artifact Messages"
BeltalowdaMenu.constants.AM_REVENGE_KILL = "Revenge Kill Messages"
BeltalowdaMenu.constants.AM_AVENGE_KILL = "Avenge Kill Messages"
BeltalowdaMenu.constants.AM_QUEST_ADDED = "Quest Added Messages"
BeltalowdaMenu.constants.AM_QUEST_COMPLETE = "Quest Completed Messages"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_COUNTER_CHANGED = "Quest Counter Changed Messages"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_CHANGED = "Quest Condition Messages"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED = "Daedric Artifact Spawned Messages"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED = "Daedric Artifact State Messages"

--Util
BeltalowdaMenu.constants.UTIL_HEADER = "|cFF8174Util Settings|r"

--Util Networking
BeltalowdaMenu.constants.NET_HEADER = "|c4592FFNetworking|r"
BeltalowdaMenu.constants.NET_ENABLED = "Enabled"
BeltalowdaMenu.constants.NET_URGENT_MODE = "Urgent Mode"
BeltalowdaMenu.constants.NET_INTERVAL = "Update Interval"

--Util Group
BeltalowdaMenu.constants.UTIL_GROUP_HEADER = "|c4592FFGroup|r"
BeltalowdaMenu.constants.UTIL_GROUP_DISPLAY_TYPE = "Display Type"

--Util Alliance Color
BeltalowdaMenu.constants.AC_HEADER = "|c4592FFAlliance Colors|r"
BeltalowdaMenu.constants.AC_DC_COLOR = "DC Color"
BeltalowdaMenu.constants.AC_EP_COLOR = "EP Color"
BeltalowdaMenu.constants.AC_AD_COLOR = "AD Color"
BeltalowdaMenu.constants.AC_NO_ALLIANCE_COLOR = "No Alliance Color"

--Chat System
BeltalowdaMenu.constants.CHAT_HEADER = "|c4592FFChat System|r"
BeltalowdaMenu.constants.CHAT_ENABLED = "Enabled"
BeltalowdaMenu.constants.CHAT_SELECTED_TAB = "Selected Tab"
BeltalowdaMenu.constants.CHAT_REFRESH = "Refresh"
BeltalowdaMenu.constants.CHAT_WARNINGS_ONLY = "Show Warnings"
BeltalowdaMenu.constants.CHAT_DEBUG_ONLY = "Show Debug"
BeltalowdaMenu.constants.CHAT_NORMAL_ONLY = "Show Normal"
BeltalowdaMenu.constants.CHAT_PREFIX_ENABLED = "Prefix Enabled"
BeltalowdaMenu.constants.CHAT_RDK_PREFIX_ENABLED = "Beltalowda Prefix Enabled"
BeltalowdaMenu.constants.CHAT_COLOR_PREFIX = "Prefix Color"
BeltalowdaMenu.constants.CHAT_COLOR_BODY = "Body Color"
BeltalowdaMenu.constants.CHAT_COLOR_WARNING = "Warning Color"
BeltalowdaMenu.constants.CHAT_COLOR_DEBUG = "Debug Color"
BeltalowdaMenu.constants.CHAT_COLOR_PLAYER = "Player Color"
BeltalowdaMenu.constants.CHAT_ADD_TIMESTAMP = "Add Timestamp"
BeltalowdaMenu.constants.CHAT_HIDE_SECONDS = "Hide Timestamp Seconds"
BeltalowdaMenu.constants.CHAT_COLOR_TIMESTAMP = "Timestamp Color"

--Class Role
BeltalowdaMenu.constants.CR_HEADER = "|cFF8174Class / Role|r"

--BG Templar Heal
BeltalowdaMenu.constants.CRBG_TPHEAL_HEADER = "|c4592FFTemplar Healer (Group)|r"
BeltalowdaMenu.constants.CRBG_TPHEAL_ENABLED = "Enabled"
BeltalowdaMenu.constants.CRBG_TPHEAL_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.CRBG_TPHEAL_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_DAMAGE = "Progress Damage"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_DAMAGE = "Label Damage"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_HEALING = "Progress Healing"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_HEALING = "Label Healing"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_RECOVERY = "Progress Recovery"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_RECOVERY = "Label Recovery"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_COOLDOWN = "Label Cooldown"

--AddOn Integration
BeltalowdaMenu.constants.ADDON_INTEGRATION_HEADER = "|cFF8174AddOn Integration Settings|r"
--Miats Pvp Alerts
BeltalowdaMenu.constants.MPAI_HEADER = "|c4592FFMiat Pvp Alerts|r"
BeltalowdaMenu.constants.MPAI_ENABLED = "Clear After Login (Enabled)"
BeltalowdaMenu.constants.MPAI_ONPLAYERACTIVATION = "Clear After Loading Screen"
BeltalowdaMenu.constants.MPAI_CLEAR_VARS = "Clear Vars"

--Admin
BeltalowdaMenu.constants.ADMIN_HEADER = "|cFF8174Admin Settings|r"
--Group Share
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_HEADER = "|c4592FFGroup Share|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ENABLED = "Enabled"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_WARNING = "|cFF0000Enabling this will allow ranks 1 to 3 of any of your guilds to query the allowed configurations|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CLIENT_CONFIGURATION = "Allow Client Configuration"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_ADDON_CONFIGURATION = "Allow AddOn Configuration"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_STATS = "Allow Stats"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_SKILLS = "Allow Skills"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_EQUIPMENT = "Allow Equipment"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CP = "Allow CP"

--Base
--Crown
BeltalowdaCrown.constants = BeltalowdaCrown.constants or {}
BeltalowdaCrown.constants.PAPA_CROWN_DETECTED = "Papa Crown has been detected. Crown Settings aren't applied."
BeltalowdaCrown.constants.SANCTS_ULTIMATE_ORGANIZER_DETECTED = "Sancts Ultimate Organizer has been detected. Crown Settings aren't applied."
BeltalowdaCrown.constants.CROWN_OF_CYRODIIL_DETECTED = "Crown of Cyrodiil has been detected. Crown Settings aren't applied."
BeltalowdaCrown.config.crowns[1].name = "Crown: Standard"
BeltalowdaCrown.config.crowns[2].name = "Arrow: White"
BeltalowdaCrown.config.crowns[3].name = "Arrow: Blue"
BeltalowdaCrown.config.crowns[4].name = "Arrow: Light Blue"
BeltalowdaCrown.config.crowns[5].name = "Arrow: Yellow"
BeltalowdaCrown.config.crowns[6].name = "Arrow: Light Green"
BeltalowdaCrown.config.crowns[7].name = "Arrow: Red"
BeltalowdaCrown.config.crowns[8].name = "Arrow: Pink"
BeltalowdaCrown.config.crowns[9].name = "Crown: White"
BeltalowdaCrown.config.crowns[10].name = "Beltalowda: White"

--Auto Invite
BeltalowdaAI.constants = BeltalowdaAI.constants or {}
BeltalowdaAI.constants.AI_MENU_NAME = "Auto Invite"
BeltalowdaAI.constants.AI_ENABLED = "Enabled"
BeltalowdaAI.constants.AI_INVITE_TEXT = "Invite String"
BeltalowdaAI.constants.AI_SENT_INVITE_TO = "Sent invite to|c%s%s|c%s.|r"
BeltalowdaAI.constants.AI_NOT_LEADER_SEND_TO = "Invitation has not been sent to|r |c%s%s|c%s. You don't have the crown.|r"
BeltalowdaAI.constants.AI_FULL_GROUP = "No invitation has been sent. The group is already full."
BeltalowdaAI.constants.AI_REQUIREMENTS_NOT_MET = "Invitation has not been sent to|r |c%s%s |c%s. The requirements aren't fulfilled.|r"
BeltalowdaAI.constants.AI_AUTO_KICK_MESSAGE = "Group member|r |c%s%s|r |c%swill be removed from the group.|r"
BeltalowdaAI.constants.TOGGLE_AI = "Toggle Auto Invite"
BeltalowdaAI.constants.AI_ENABLED_TRUE = "Auto Invite activated."
BeltalowdaAI.constants.AI_ENABLED_FALSE = "Auto Invite deactivated."
BeltalowdaAI.constants.AI_MEMBER_LEFT = "Member|r |c%s%s|r |c%shas left the group."

--Follow The Crown Visual
BeltalowdaFtcv.textures[1].name = "Arrow 1"
BeltalowdaFtcv.textures[2].name = "Arrow 2"
BeltalowdaFtcv.textures[3].name = "Arrow 3"
BeltalowdaFtcv.textures[4].name = "Arrow 4"
BeltalowdaFtcv.textures[5].name = "Arrow 5"
BeltalowdaFtcv.textures[6].name = "Arrow 6"
BeltalowdaFtcv.textures[7].name = "Arrow 7"
BeltalowdaFtcv.textures[8].name = "Arrow 8"

--Follow The Crown Warnings
BeltalowdaFtcw.constants = BeltalowdaFtcw.constants or {}
BeltalowdaFtcw.constants.FTCW_MAX_DISTANCE ="Maximum Distance Reached!!!"

--Resource Overview
BeltalowdaOverview.config.ultimateModes = BeltalowdaOverview.config.ultimateModes or {}
--BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_GROUP] = "Group Assignment"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS] = "Readiness"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME] = "Name"
BeltalowdaOverview.constants.BOOM = "BOOM"
BeltalowdaOverview.constants.TOGGLE_BOOM = "Send BOOM"
BeltalowdaOverview.constants.IDENENTIFIER_DESTRUCTION = "Destro"
BeltalowdaOverview.constants.IDENENTIFIER_STORM = "Storm"
BeltalowdaOverview.constants.IDENENTIFIER_NEGATE = "Neg."
BeltalowdaOverview.constants.IDENENTIFIER_NOVA = "Nova"
BeltalowdaOverview.config.groupsModes = BeltalowdaOverview.config.groupsModes or {}
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME] = "Priority - Name"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT] = "Priority - Percent"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PERCENT] = "Percent"
BeltalowdaOverview.config.displayModes = BeltalowdaOverview.config.displayModes or {}
BeltalowdaOverview.config.displayModes[BeltalowdaOverview.constants.displayModes.CLASSIC] = "Classic"
BeltalowdaOverview.config.displayModes[BeltalowdaOverview.constants.displayModes.SWIMLANES] = "Swimlanes"

--Healing / Damage Meter
BeltalowdaHdm.constants = BeltalowdaHdm.constants or {}
BeltalowdaHdm.constants.TITLE_HEALING = "Healing"
BeltalowdaHdm.constants.TITLE_DAMAGE = "Damage"
BeltalowdaHdm.constants.viewModes = BeltalowdaHdm.constants.viewModes or {}
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH] = "Both"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_HEALING] = "Healing"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_DAMAGE] = "Damage"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH_ON_TOP] = "Both (Vertically)"
BeltalowdaHdm.constants.RESET_COUNTER = "Reset Counter"

--Detonation Tracker
BeltalowdaDt.constants.modes = BeltalowdaDt.constants.modes or {}
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_BOTH] = "Both"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_DETONATION] = "Detonation"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_SHALK] = "Shalk"

--I See Dead People
BeltalowdaIsdp.constants = BeltalowdaIsdp.constants or {}
BeltalowdaIsdp.constants.BEAM_SKULL_USING_BUFFER = "Skull"
BeltalowdaIsdp.constants.BEAM_SKULL_NOT_USING_BUFFER = "Skull (w/o Buffer)"

--Compass
--YACS
BeltalowdaYacs.compasses[1].name = "Standard"
BeltalowdaYacs.compasses[2].name = "Fat North"
BeltalowdaYacs.compasses[3].name = "Thin Lines"
BeltalowdaYacs.compasses[4].name = "Fancy Underline North "
BeltalowdaYacs.compasses[5].name = "Fat Underline North"
BeltalowdaYacs.compasses[6].name = "Gribouillis"
BeltalowdaYacs.compasses[7].name = "Circled 1"
BeltalowdaYacs.compasses[8].name = "Circled 2"
BeltalowdaYacs.compasses[9].name = "Diamond 1"
BeltalowdaYacs.compasses[10].name = "Diamond 2"
BeltalowdaYacs.compasses[11].name = "Dots 1"
BeltalowdaYacs.compasses[12].name = "Dots 2"
BeltalowdaYacs.compasses[13].name = "ELetters 1"
BeltalowdaYacs.compasses[14].name = "ELetters 2"
BeltalowdaYacs.compasses[15].name = "Full Arrow 1"
BeltalowdaYacs.compasses[16].name = "Full Arrow 2"
BeltalowdaYacs.compasses[17].name = "Needle 1"
BeltalowdaYacs.compasses[18].name = "Needle 2"
BeltalowdaYacs.compasses[19].name = "Small Arrow 1"
BeltalowdaYacs.compasses[20].name = "Small Arrow 2"
BeltalowdaYacs.compasses[21].name = "Compass Fr. 1"
BeltalowdaYacs.compasses[22].name = "Compass Fr. 2"
BeltalowdaYacs.compasses[23].name = "Compass Fr. 3"
BeltalowdaYacs.compasses[24].name = "Compass Fr. 4"
BeltalowdaYacs.config.constants.TOGGLE_YACS = "Toggle Compass"

--SC
BeltalowdaSC.constants = BeltalowdaSC.constants or {}
BeltalowdaSC.constants.NORTH = "N"
BeltalowdaSC.constants.NORTH_EAST = "NE"
BeltalowdaSC.constants.EAST = "E"
BeltalowdaSC.constants.SOUTH_EAST = "SE"
BeltalowdaSC.constants.SOUTH = "S"
BeltalowdaSC.constants.SOUTH_WEST = "SW"
BeltalowdaSC.constants.WEST = "W"
BeltalowdaSC.constants.NORTH_WEST = "NW"

--Toolbox
--Siege Merchant
BeltalowdaSm.paymentOptions = BeltalowdaSm.paymentOptions or {}
BeltalowdaSm.paymentOptions[1] = "Only AP"
BeltalowdaSm.paymentOptions[2] = "Only Gold"
BeltalowdaSm.paymentOptions[3] = "First AP, Then Gold"
BeltalowdaSm.paymentOptions[4] = "First Gold, Then AP"
BeltalowdaSm.constants = BeltalowdaSm.constants or {}
BeltalowdaSm.constants.ERROR_UNKNOWN = "An unknown error occurred."
BeltalowdaSm.constants.ERROR_UNKNOWN_PAYMENT_OPTION = "Unkown payment option has been selected."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD = "Not enough gold present to buy more items."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP = "Not enough AP present to buy more items."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP_OR_GOLD = "Not enough AP or gold present to buy more items."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_INVENTORY_SLOTS = "Not enough inventory slots available to buy more items."
BeltalowdaSm.constants.SUCCESS_MESSAGE = "Purchase completed."

--Recharger
BeltalowdaRecharger.constants = BeltalowdaRecharger.constants or {}
BeltalowdaRecharger.constants.MESSAGE_SUCCESS = "%s (%d%%) has been recharged."
BeltalowdaRecharger.constants.MESSAGE_WARNING_LOW_SOULGEMS = "Less than %d soul gems are available."
BeltalowdaRecharger.constants.MESSAGE_WARNING_NO_SOULGEMS = "No more soul gems are left."

--Buff Food Tracking
BeltalowdaBft.constants = BeltalowdaBft.constants or {}
BeltalowdaBft.constants.BUFF_FOOD_STRING = "Buff Food: %s"

--Siege
BeltalowdaSiege.constants = BeltalowdaSiege.constants or {}
BeltalowdaSiege.constants.TOGGLE_SIEGE = "|c4592FFBeltalowda: Toggle View|r"

--Cyrodiil Log
BeltalowdaCL.constants = BeltalowdaCL.constants or {}
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_CLAIM = "%s|c%s claimed %s|c%s for %s"
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_LOST = "%s|c%s lost %s"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA = "%s|c%s is under siege"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA_LOST = "%s|c%s is not under siege anymore"
BeltalowdaCL.constants.MESSAGE_KEEP_OWNER_CHANGED = "%s|c%s belongs to %s"
BeltalowdaCL.constants.MESSAGE_TICK_DEFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gained for defending %s"
BeltalowdaCL.constants.MESSAGE_TICK_OFFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gained for capturing %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_PICKED_UP = "%s|c%s has picked up the %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_DROPPED = "%s|c%s has dropped the %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED = "%s|c%s has returned the %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED_BY_TIMER = "%s|c%s has been returned"
BeltalowdaCL.constants.MESSAGE_SCROLL_CAPTURED = "%s|c%s has captured %s|c%s at %s"
BeltalowdaCL.constants.MESSAGE_EMPEROR_CORONATED = "%s|c%s has been crowned emperor"
BeltalowdaCL.constants.MESSAGE_EMPEROR_DEPOSED = "%s|c%s has been deposed as emperor"
BeltalowdaCL.constants.MESSAGE_QUEST_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gained for completing a quest"
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gained for completing the battleground"
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_MEDAL_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gained for getting a medal"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_SPAWNED = "|c%s%s has spawned"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_REVEALED = "|c%s%s has been revealed"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DROPPED = "|c%s%s has been dropped by %s|c%s"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_TAKEN = "|c%s%s has been taken by %s|c%s"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DESPAWNED = "|c%s%s has returned to oblivion"

--Respawner
BeltalowdaRespawner.constants = BeltalowdaRespawner.constants or {}
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_CAMP = "Respawn at Camp"
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_KEEP = "Respawn at Keep"
BeltalowdaRespawner.constants.RESPAWN_CAMP = "Camp"
BeltalowdaRespawner.constants.RESPAWN_KEEP = "Keep"

--Synergy Prevention - /script for i = 1, 500000 do if GetAbilityName(i) == "" then d(i) end end
BeltalowdaSP.constants = BeltalowdaSP.constants or {}
BeltalowdaSP.constants.ON = "ON"
BeltalowdaSP.constants.OFF = "OFF"
BeltalowdaSP.constants.KEYBINDING = "Toggle Synergy Prevention"
BeltalowdaSP.constants.SYNERGY_COMBUSTION = "Combustion" -- 3463, 26319, 29424 .. 
BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION = "Healing Combustion" -- 63507, 63511 .. 
BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED = "Blessed Shards" -- 26832, 94973 ..
BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY = "Holy Shards" -- 95922, 95925 .. 
BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST = "Blood Feast" -- 41963, 41964 .. 
BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL = "Blood Funnel" -- 39500, 39501 ..
BeltalowdaSP.constants.SYNERGY_SUPERNOVA = "Supernova" -- 31538, 31540
BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH = "Gravity Crush" -- 31603, 31604 .. 
BeltalowdaSP.constants.SYNERGY_SHACKLE = "Shackle" -- 32905, 32910 ..
BeltalowdaSP.constants.SYNERGY_PURIFY = "Purify" -- 22260, 22269 ..
BeltalowdaSP.constants.SYNERGY_BONE_WALL = "Bone Wall" -- 39377, 39379 ..
BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE = "Spinal Surge" -- 42194, 42195 ..
BeltalowdaSP.constants.SYNERGY_IGNITE = "Ignite" -- 10805, 10809 ..
BeltalowdaSP.constants.SYNERGY_RADIATE = "Radiate" -- 41838, 41839 .. 
BeltalowdaSP.constants.SYNERGY_CONDUIT = "Conduit" -- 23196, 136046
BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS = "Spawn Broodling" -- 39429, 39430 ..
BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS = "Black Widow" -- 41994, 41996
BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA = "Arachnophobia" -- 18111, 18116 ..
BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH = "Hidden Refresh" -- 37729, 37730 ..
BeltalowdaSP.constants.SYNERGY_SOUL_LEECH = "Soul Leech" -- 25169, 25170 ..
BeltalowdaSP.constants.SYNERGY_HARVEST = "Harvest" -- 85572, 85576 ..
BeltalowdaSP.constants.SYNERGY_ATRONACH = "Charged Lightning" -- 48076, 102310, 102321 ..
BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER = "Grave Robber" -- 115548, 115567 ..
BeltalowdaSP.constants.SYNERGY_PURE_AGONY = "Pure Agony" -- 118604, 118606 ..
BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE = "Icy Escape" -- 88884, 110370 ...
BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST = "Sanguine Burst" -- 141920, 142305
BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL = "Heed the Call" -- 142712, 142775, 142780
BeltalowdaSP.constants.SYNERGY_URSUS = "Shield of Ursus" --111437
--BeltalowdaSP.constants.blacklist = BeltalowdaSP.constants.blacklist or {}
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_COMBUSTION] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_SUPERNOVA] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_SHACKLE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_IGNITE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_RADIATE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_CONDUIT] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_PURE_AGONY] = true
BeltalowdaSP.constants.MODES = BeltalowdaSP.constants.MODES or {}
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_ALL] = "All"
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_IF_SYNERGY_ROLE] = "Synergy Role"

--Synergy Overview
BeltalowdaSO.constants.DISPLAY_MODES = BeltalowdaSO.constants.DISPLAY_MODES or {}
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_ALL] = "All"
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_SYNERGY] = "Synergy Role"
BeltalowdaSO.constants.TABLE_MODES = BeltalowdaSO.constants.TABLE_MODES or {}
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_FULL] = "Full"
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_REDUCED] = "Reduced"

--util
--util
BeltalowdaUtil.constants = BeltalowdaUtil.constants or {}
BeltalowdaUtil.constants.G1 = "Guild 1"
BeltalowdaUtil.constants.O1 = "Officer 1"
BeltalowdaUtil.constants.G2 = "Guild 2"
BeltalowdaUtil.constants.O2 = "Officer 2"
BeltalowdaUtil.constants.G3 = "Guild 3"
BeltalowdaUtil.constants.O3 = "Officer 3"
BeltalowdaUtil.constants.G4 = "Guild 4"
BeltalowdaUtil.constants.O4 = "Officer 4"
BeltalowdaUtil.constants.G5 = "Guild 5"
BeltalowdaUtil.constants.O5 = "Officer 5"
BeltalowdaUtil.constants.EMOTE = "Emote"
BeltalowdaUtil.constants.SAY = "Say"
BeltalowdaUtil.constants.YELL = "Yell"
BeltalowdaUtil.constants.GROUP = "Group"
BeltalowdaUtil.constants.TELL = "Tell"
BeltalowdaUtil.constants.ZONE = "Zone"
BeltalowdaUtil.constants.ENZONE = "Zone - English"
BeltalowdaUtil.constants.FRZONE = "Zone - French"
BeltalowdaUtil.constants.DEZONE = "Zone - German"
BeltalowdaUtil.constants.JPZONE = "Zone - Japan"

--ui
BeltalowdaUtilUI.constants = BeltalowdaUtilUI.constants or {}
BeltalowdaUtilUI.constants.ON = "ON"
BeltalowdaUtilUI.constants.OFF = "OFF"

--Ultimates
BeltalowdaUltimates.constants = BeltalowdaUltimates.constants or {}
BeltalowdaUltimates.constants.NEGATE = "Sorcerer - Negate"
BeltalowdaUltimates.constants.NEGATE_OFFENSIVE = "Sorcerer - Negate Offensive"
BeltalowdaUltimates.constants.NEGATE_COUNTER = "Sorcerer - Negate Counter"
BeltalowdaUltimates.constants.ATRONACH = "Sorcerer - Atronach"
BeltalowdaUltimates.constants.OVERLOAD = "Sorcerer - Overload"
BeltalowdaUltimates.constants.SWEEP = "Templar - Sweep"
BeltalowdaUltimates.constants.NOVA = "Templar - Nova"
BeltalowdaUltimates.constants.T_HEAL = "Templar - Healing Ultimate"
BeltalowdaUltimates.constants.STANDARD = "Dragonknight - Standard"
BeltalowdaUltimates.constants.LEAP = "Dragonknight - Dragon Leap"
BeltalowdaUltimates.constants.MAGMA = "Dragonknight - Magma Armor"
BeltalowdaUltimates.constants.STROKE = "Nightblade - Death Stroke"
BeltalowdaUltimates.constants.DARKNESS = "Nightblade - Consuming Darkness"
BeltalowdaUltimates.constants.SOUL = "Nightblade - Soul Shred"
BeltalowdaUltimates.constants.SOUL_SIPHON = "Nightblade - Soul Siphon"
BeltalowdaUltimates.constants.SOUL_TETHER = "Nightblade - Soul Tether"
BeltalowdaUltimates.constants.STORM = "Warden - Storm"
BeltalowdaUltimates.constants.NORTHERN_STORM = "Warden - Northern Storm"
BeltalowdaUltimates.constants.PERMAFROST = "Warden - Permafrost"
BeltalowdaUltimates.constants.W_HEAL = "Warden - Healing Ultimate"
BeltalowdaUltimates.constants.GUARDIAN = "Warden - Guardian"
BeltalowdaUltimates.constants.COLOSSUS = "Necromancer - Colossus"
BeltalowdaUltimates.constants.GOLIATH = "Necromancer - Goliath"
BeltalowdaUltimates.constants.REANIMATE = "Necromancer - Reanimate"
BeltalowdaUltimates.constants.UNBLINKING_EYE = "Arcanist - Unblinking Eye"
BeltalowdaUltimates.constants.GIBBERING_SHIELD = "Arcanist - Gibbering Shield"
BeltalowdaUltimates.constants.VITALIZING_GLYPHIC = "Arcanist - Vitalizing Glyphic"
BeltalowdaUltimates.constants.DESTRUCTION = "Weapon - Destruction Staff"
BeltalowdaUltimates.constants.RESTORATION = "Weapon - Restoration Staff"
BeltalowdaUltimates.constants.TWO_HANDED = "Weapon - Two Handed"
BeltalowdaUltimates.constants.SHIELD = "Weapon - One Handed and Shield"
BeltalowdaUltimates.constants.DUAL_WIELD = "Weapon - Dual Wield"
BeltalowdaUltimates.constants.BOW = "Weapon - Bow"
BeltalowdaUltimates.constants.SOUL_MAGIC = "World - Soul Strike"
BeltalowdaUltimates.constants.WEREWOLF = "World (Werewolf) - Werewolf"
BeltalowdaUltimates.constants.VAMPIRE = "World (Vampire) - Bat Swarm"
BeltalowdaUltimates.constants.MAGES = "Guild (Mages) - Meteor"
BeltalowdaUltimates.constants.FIGHTERS = "Guild (Fighters) - Dawnbreaker"
BeltalowdaUltimates.constants.PSIJIC = "Guild (Psijic) - Undo"
BeltalowdaUltimates.constants.ALLIANCE_SUPPORT = "Alliance War (Support) - Barrier"
BeltalowdaUltimates.constants.ALLIANCE_ASSAULT = "Alliance War (Assault) - War Horn"

--Networking
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.DIRECT] = "Direct"
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.CRITICAL] = "Queue (Critical)"

--Util Group
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_CHAR_NAME] = "By Name"
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_DISPLAY_NAME] = "By @Account"

BeltalowdaUtilGroup.constants.ROLE_RAPID = "Rapid"
BeltalowdaUtilGroup.constants.ROLE_PURGE = "Purge"
BeltalowdaUtilGroup.constants.ROLE_HEAL = "Healer"
BeltalowdaUtilGroup.constants.ROLE_DD = "DD"
BeltalowdaUtilGroup.constants.ROLE_SYNERGY = "Synergy"
BeltalowdaUtilGroup.constants.ROLE_CC = "CC"
BeltalowdaUtilGroup.constants.ROLE_SUPPORT = "Support"
BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER = "Undefined"
BeltalowdaUtilGroup.constants.ROLE_APPLICANT = "Applicant"

--Util Versioning
BeltalowdaVersioning.constants = BeltalowdaVersioning.constants or {}
BeltalowdaVersioning.constants.CLIENT_OUT_OF_DATE = "|cFF0000[Beltalowda] Client version is out of date|r"

--Util Enhancements
BeltalowdaEnhance.constants = BeltalowdaEnhance.constants or {}
BeltalowdaEnhance.constants.positionNames = BeltalowdaEnhance.constants.positionNames or {}
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPRIGHT] = "Top Right"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMRIGHT] = "Bottom Right"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPLEFT] = "Top Left"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMLEFT] = "Bottom Left"
BeltalowdaEnhance.constants.CAMP_RESPAWN = "Camp : "

--Util Group Menu
BeltalowdaGMenu.constants = BeltalowdaGMenu.constants or {}
BeltalowdaGMenu.constants.BG_LEADER_ADD_CROWN = "Mark as Crown"
BeltalowdaGMenu.constants.BG_LEADER_REMOVE_CROWN = "Remove Crown"
BeltalowdaGMenu.constants.ROLE_MENU_ENTRY = "Role"
BeltalowdaGMenu.constants.ROLE_SUBMENU_SET = "Set"
BeltalowdaGMenu.constants.ROLE_SUBMENU_REMOVE = "Remove"
BeltalowdaGMenu.constants.ROLE_SUBMENU_RAPID = BeltalowdaUtilGroup.constants.ROLE_RAPID
BeltalowdaGMenu.constants.ROLE_SUBMENU_PURGE = BeltalowdaUtilGroup.constants.ROLE_PURGE
BeltalowdaGMenu.constants.ROLE_SUBMENU_HEAL = BeltalowdaUtilGroup.constants.ROLE_HEAL
BeltalowdaGMenu.constants.ROLE_SUBMENU_DD = BeltalowdaUtilGroup.constants.ROLE_DD
BeltalowdaGMenu.constants.ROLE_SUBMENU_SYNERGY = BeltalowdaUtilGroup.constants.ROLE_SYNERGY
BeltalowdaGMenu.constants.ROLE_SUBMENU_CC = BeltalowdaUtilGroup.constants.ROLE_CC
BeltalowdaGMenu.constants.ROLE_SUBMENU_SUPPORT = BeltalowdaUtilGroup.constants.ROLE_SUPPORT
BeltalowdaGMenu.constants.ROLE_SUBMENU_PLACEHOLDER = BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER
BeltalowdaGMenu.constants.ROLE_SUBMENU_APPLICANT = BeltalowdaUtilGroup.constants.ROLE_APPLICANT

--Util Beams
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].name = "Beam 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].name = "Beam 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].name = "Beam 3"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].name = "Beam 4"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].name = "Circle 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].name = "Circle 1 (w/o Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].name = "Circle 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].name = "Circle 2 (w/o Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].name = "Arrows 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].name = "Arrows 2"

--Admin [General]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.TOGGLE_ADMIN = "Toggle Admin Interface"
BeltalowdaAdmin.constants.HEADER_TITLE = "Admin"
BeltalowdaAdmin.constants.PLAYERS_ALL = "All"
--Admin UI [Player]
BeltalowdaAdmin.constants.player = BeltalowdaAdmin.constants.player or {}
BeltalowdaAdmin.constants.player.REQUEST_ALL = "Request All"
BeltalowdaAdmin.constants.player.REQUEST_VERSION = "Request Version"
BeltalowdaAdmin.constants.player.REQUEST_CLIENT_CONFIGURATION = "Request Client Configuration"
BeltalowdaAdmin.constants.player.REQUEST_ADDON_CONFIGURATION = "Request AddOn Configuration"
BeltalowdaAdmin.constants.player.REQUEST_EQUIPMENT_INFORMATION = "Request Equipment Information"
BeltalowdaAdmin.constants.player.REQUEST_STATS_INFORMATION = "Request Stats Information"
BeltalowdaAdmin.constants.player.REQUEST_MUNDUS_INFORMATION = "Request Mundus Information"
BeltalowdaAdmin.constants.player.REQUEST_SKILLS_INFORMATION = "Request Skill Information"
BeltalowdaAdmin.constants.player.REQUEST_QUICKSLOTS_INFORMATION = "Request Quickslot Information"
BeltalowdaAdmin.constants.player.REQUEST_CHAMPION_INFORMATION = "Request CP Information"
--Admin UI [Config]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.defaults = BeltalowdaAdmin.constants.defaults or {}
BeltalowdaAdmin.constants.defaults.ENABLED = "On"
BeltalowdaAdmin.constants.defaults.DISABLED = "Off"
BeltalowdaAdmin.constants.defaults.UNDEFINED = "N/A"
BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE = "-"
BeltalowdaAdmin.constants.defaults.UNDEFINED_VERSION = "N/A (Version)"
BeltalowdaAdmin.constants.defaults.viewModes = BeltalowdaAdmin.constants.defaults.viewModes or {}
BeltalowdaAdmin.constants.defaults.viewModes[0] = "Windowed"
BeltalowdaAdmin.constants.defaults.viewModes[1] = "Windowed (Fullscreen)"
BeltalowdaAdmin.constants.defaults.viewModes[2] = "Fullscreen"
BeltalowdaAdmin.constants.defaults.qualitySelection = BeltalowdaAdmin.constants.defaults.qualitySelection or {}
BeltalowdaAdmin.constants.defaults.qualitySelection[0] = "Off"
BeltalowdaAdmin.constants.defaults.qualitySelection[1] = "Low"
BeltalowdaAdmin.constants.defaults.qualitySelection[2] = "Medium"
BeltalowdaAdmin.constants.defaults.qualitySelection[3] = "High"
BeltalowdaAdmin.constants.defaults.qualitySelection[4] = "Ultra"
BeltalowdaAdmin.constants.defaults.graphicPresets = BeltalowdaAdmin.constants.defaults.graphicPresets or {}
BeltalowdaAdmin.constants.defaults.graphicPresets[0] = "Minumum"
BeltalowdaAdmin.constants.defaults.graphicPresets[1] = "Low"
BeltalowdaAdmin.constants.defaults.graphicPresets[2] = "Medium"
BeltalowdaAdmin.constants.defaults.graphicPresets[3] = "High"
BeltalowdaAdmin.constants.defaults.graphicPresets[4] = "Ultra-High"
BeltalowdaAdmin.constants.defaults.graphicPresets[7] = "Custom"
BeltalowdaAdmin.constants.config = BeltalowdaAdmin.constants.config or {}
BeltalowdaAdmin.constants.config.PLAYER_TITLE = "Player Information"
BeltalowdaAdmin.constants.config.PLAYER_DISPLAYNAME_STRING = "Display Name: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_CHARNAME_STRING = "Character Name: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_VERSION_STRING = "Version: |c%s%s.%s.%s|r"
BeltalowdaAdmin.constants.config.CLIENT_TITLE = "Client Information"
BeltalowdaAdmin.constants.config.CLIENT_AOE_SUBTITLE = "AOE"
BeltalowdaAdmin.constants.config.CLIENT_AOE_TELLS_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENABLED_STRING = "Custom Colors Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_FRIENDLY_BRIGHTNESS = "Friendly Brightness: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENEMY_BRIGHTNESS = "Enemy Brightness: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_SUBTITLE = "Sound"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_AUDIO_VOLUME = "Audio Volume: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SFX_AUDIO_VOLUME = "SFX Volume: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_UI_AUDIO_VOLUME = "UI Volume: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBTITLE = "Graphics"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_RESOLUTION_STRING = "Resolution: |c%s%sx%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_WINDOW_MODE_STRING = "Display Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VSYNC_STRING = "Vertical Sync: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ANTI_ALIASING_STRING = "Anti-Aliasing: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_AMBIENT_STRING = "Ambient Occlusion: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_BLOOM_STRING = "Bloom: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DEPTH_OF_FIELD_STRING = "Depth of Field: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DISTORTION_STRING = "Distortion: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUNLIGHT_STRING = "Sunlight Rays: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ALLY_EFFECTS_STRING = "Additional Ally Effects: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VIEW_DISTANCE_STRING = "View Distance: ~|c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_SUPRESSION_DISTANCE_STRING = "Particle Supression Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_MAXIMUM_STRING = "Maximum Particle Systems: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_REFLECTION_QUALITY_STRING = "Water Reflection Quality: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SHADOW_QUALITY_STRING = "Shadow Quality: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBSAMPLING_QUALITY_STRING = "SubSampling Quality: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_GRAPHIC_PRESETS_STRING = "Graphics Quality: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_TITLE = "AddOn Configuration"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SUBTITLE = "Crown"
BeltalowdaAdmin.constants.config.ADDON_CROWN_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SIZE_STRING = "Size: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SELECTED_CROWN_STRING = "Selected Crown: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SUBTITLE = "Follow The Crown (Visual)"
BeltalowdaAdmin.constants.config.ADDON_FTCV_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_FAR_STRING = "Size Far: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_CLOSE_STRING = "Size Close: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MIN_DISTANCE_STRING = "Minimum Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MAX_DISTANCE_STRING = "Maximum Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_FAR_STRING = "Opacity Far: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_CLOSE_STRING = "Opacity Close: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_SUBTITLE = "Follow The Crown (Warnings)"
BeltalowdaAdmin.constants.config.ADDON_FTCW_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_DISTANCE_ENABLED_STRING = "Distance Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_WARNINGS_ENABLED_STRING = "Warnings Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_MAX_DISTANCE_STRING = "Maximum Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_SUBTITLE = "Follow The Crown (Audio)"
BeltalowdaAdmin.constants.config.ADDON_FTCA_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_MAX_DISTANCE_STRING = "Maximum Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_INTERVAL_STRING = "Interval: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_THRESHOLD_STRING = "Threshold: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SUBTITLE = "Follow The Crown (Beam)"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SELECTED_BEAM_STRING = "Selected Beam: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ALPHA_STRING = "Alpha: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DBO_SUBTITLE = "Debuff Overview"
BeltalowdaAdmin.constants.config.ADDON_DBO_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RT_SUBTITLE = "Rapid Overview"
BeltalowdaAdmin.constants.config.ADDON_RT_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SUBTITLE = "Resource Overview"
BeltalowdaAdmin.constants.config.ADDON_RO_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_ULTIMATE_OVERVIEW_ENABLED_STRING = "Ultimate Group Overview Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_CLIENT_GROUP_ENABLED_STRING = "Client Window Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_ULTIMATE_ENABLED_STRING = "Group Window Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SHOW_SOFT_RESOURCES_STRING = "Stamina / Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SOUND_ENABLED_STRING = "Sound Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_MAX_DISTANCE_STRING = "Maximum Distance: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_DESTRO_STRING = "Group Size Destro: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_STORM_STRING = "Group Size Storm: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NORTHERNSTORM_STRING = "Group Size Northern Storm: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_PERMAFROST_STRING = "Group Size Permafrost: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_STRING = "Group Size Negate: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_OFFENSIVE_STRING = "Group Size Negate Offensive: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_COUNTER_STRING = "Group Size Negate Counter: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NOVA_STRING = "Group Size Nova: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUPS_ENABLED_STRING = "Groups Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_SUBTITLE = "Health Damage Meter"
BeltalowdaAdmin.constants.config.ADDON_HDM_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_WINDOW_ENABLED_STRING = "Window Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_VIEW_MODE_STRING = "Selected Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SUBTITLE = "Potion Overview"
BeltalowdaAdmin.constants.config.ADDON_PO_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SOUND_ENABLED_STRING = "Sound Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DT_SUBTITLE = "Detonation Tracker"
BeltalowdaAdmin.constants.config.ADDON_DT_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_GB_SUBTITLE = "Group Beams"
BeltalowdaAdmin.constants.config.ADDON_GB_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_ISDP_SUBTITLE = "I See Dead People"
BeltalowdaAdmin.constants.config.ADDON_ISDP_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_SUBTITLE = "Yet Another Compass"
BeltalowdaAdmin.constants.config.ADDON_YACS_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_PVP_ENABLED_STRING = "Enabled in PVP: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_COMBAT_ENABLED_STRING = "Enabled in Combat: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SC_SUBTITLE = "Simple Compass"
BeltalowdaAdmin.constants.config.ADDON_SC_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SM_SUBTITLE = "Siege Merchant"
BeltalowdaAdmin.constants.config.ADDON_SM_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_SUBTITLE = "Recharger"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_KC_SUBTITLE = "Keep Claimer"
BeltalowdaAdmin.constants.config.ADDON_KC_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SUBTITLE = "Buff Food Tracker"
BeltalowdaAdmin.constants.config.ADDON_BFT_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SOUND_ENABLED_STRING = "Sound Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SIZE_STRING = "Size: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CL_SUBTITLE = "Cyrodiil Log"
BeltalowdaAdmin.constants.config.ADDON_CL_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CS_SUBTITLE = "Cyrodiil Status"
BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_SUBTITLE = "Respawner"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAMP_SUBTITLE = "Camp Preview"
BeltalowdaAdmin.constants.config.ADDON_CAMP_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_SUBTITLE = "Synergy Prevention"
BeltalowdaAdmin.constants.config.ADDON_SP_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_MODE_STRING = "Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING = "%s: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_SUBTITLE = "Synergy Overview"
BeltalowdaAdmin.constants.config.ADDON_SO_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_TABLE_MODE_STRING = "Table Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_DISPLAY_MODE_STRING = "Display Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_SUBTITLE = "Role Assignment"
BeltalowdaAdmin.constants.config.ADDON_RA_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_ALLOW_OVERRIDE_STRING = "Allow Override: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAJ_SUBTITLE = "Campaign Auto Join"
BeltalowdaAdmin.constants.config.ADDON_CAJ_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_SUBTITLE = "CR - BG - Templar Healer (BG)"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_ENABLED_STRING = "Enabled: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_TITLE = "Stats"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_STRING = "Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_STRING = "Health: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_STRING = "Stamina: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_RECOVERY_STRING = "Magicka Recovery: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_RECOVERY_STRING = "Health Recovery: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_RECOVERY_STRING = "Stamina Recovery: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_DAMAGE_STRING = "Spell Damage: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_DAMAGE_STRING = "Weapon Damage: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_PENETRATION_STRING = "Spell Penetration: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_PENETRATION_STRING = "Weapon Penetration: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_CRITICAL_STRING = "Spell Critical: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_CRITICAL_STRING = "Weapon Critical: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_RESISTANCE_STRING = "Spell Resistance: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_PHYSICAL_RESISTANCE_STRING = "Physical Resistance: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_CRITICAL_RESISTANCE_STRING = "Critical Resistance: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_TITLE = "Mundus"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_1_STRING = "Mundus Stone 1: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_2_STRING = "Mundus Stone 2: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_FILTER = "Boon: "
BeltalowdaAdmin.constants.config.CHAMPION_TITLE = "Champion Points"
BeltalowdaAdmin.constants.config.SKILLS_TITLE = "Skills"
BeltalowdaAdmin.constants.config.EQUIPMENT_TITLE = "Equipment"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_REQUEST = "Request Item"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_LINK_IN_CHAT = "Link in Chat"
BeltalowdaAdmin.constants.config.QUICKSLOT_TITLE = "Quickslots"

--Config
BeltalowdaConfig.constants = BeltalowdaConfig.constants or {}
BeltalowdaConfig.constants.TOGGLE_CONFIG = "Toggle Configuration Interface"
BeltalowdaConfig.constants.HEADER_TITLE = "Configuration Import / Export"
BeltalowdaConfig.constants.TAB_IMPORT_TITLE = "Import"
BeltalowdaConfig.constants.TAB_EXPORT_TITLE = "Export"
BeltalowdaConfig.constants.EXPORT_SELECT_ALL = "Select All"
BeltalowdaConfig.constants.EXPORT_PROFILE = "Profile"
BeltalowdaConfig.constants.EXPORT_STRING_LENGTH_ERROR = "The configuration string is too long. Please report this issue!"
BeltalowdaConfig.constants.IMPORT_PROFILE = "New Profile Name"
BeltalowdaConfig.constants.IMPORT = "Import"
BeltalowdaConfig.constants.IMPORT_STATUS = "Status: "
BeltalowdaConfig.constants.IMPORT_ADD_ALL = "Add all values (e.g. Window Positions)"
BeltalowdaConfig.constants.IMPORT_STATUS_STARTED = "Import started"
BeltalowdaConfig.constants.IMPORT_STATUS_FAILED = "Import failed"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED = "Import finished"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED_DIFFERENT_VERSION = "Import finished (different versions may lead to inconsistencies)"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_INVALID_NAME = "Import failed - Invalid Profile Name"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_DUPLICATE = "Import failed - Duplicate Profile Name"
BeltalowdaConfig.constants.IMPORT_STATUS_NO_CONTENT = "Import failed - No Content"
BeltalowdaConfig.constants.IMPORT_CONFIG_LINE_COUNT = "Config Lines: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON = "Import failed at line %s. Reason: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_NIL = "Nil value"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_BOOLEAN = "Boolean expected"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER = "Number expected"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID = "Invalid type"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID = "Layer1 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_2_INVALID = "Layer2 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_2_INVALID = "Layer1 or Layer2 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_X_INVALID = "LayerX invalid"