-- Beltalowda Admin
-- By @s0rdrak (PC / EU)

Beltalowda.admin = Beltalowda.admin or {}
local BeltalowdaAdmin = Beltalowda.admin
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.roster = BeltalowdaUtil.roster or {}
local BeltalowdaRoster = BeltalowdaUtil.roster
BeltalowdaUtil.versioning = BeltalowdaUtil.versioning or {}
local BeltalowdaVersioning = BeltalowdaUtil.versioning
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.equipment = BeltalowdaUtil.equipment or {}
local BeltalowdaEquip = BeltalowdaUtil.equipment
BeltalowdaUtil.cp = BeltalowdaUtil.cp or {}
local BeltalowdaCP = BeltalowdaUtil.cp
BeltalowdaUtil.sb = BeltalowdaUtil.sb or {}
local BeltalowdaSB = BeltalowdaUtil.sb
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.beams = BeltalowdaUtil.beams or {}
local BeltalowdaBeams = BeltalowdaUtil.beams
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaToolbox = Beltalowda.toolbox
BeltalowdaToolbox.sp = BeltalowdaToolbox.sp or {}
local BeltalowdaSP = BeltalowdaToolbox.sp


BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.TLW_ADMIN_WINDOW = "Beltalowda.admin.admin_TLW"
BeltalowdaAdmin.constants.HEADER_BACKDROP_NAME = "Beltalowda.admin.admin_TLW_Header_Backdrop"
BeltalowdaAdmin.constants.PLAYER_BACKDROP_NAME = "Beltalowda.admin.admin_TLW_Player_Backdrop"
BeltalowdaAdmin.constants.CONFIG_BACKDROP_NAME = "Beltalowda.admin.admin_TLW_Config_Backdrop"
BeltalowdaAdmin.constants.SCROLL_CONTROL = "Beltalowda.admin.admin_TLW_Config_ScrollBarControl"

BeltalowdaAdmin.constants.requests = {}
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CLIENT_CONFIGURATION = 1
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_ADDON_CONFIGURATION = 2
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_STATS_INFORMATION = 4
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_SKILLS_INFORMATION = 8
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_EQUIPMENT_INFORMATION = 16
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CHAMPION_INFORMATION = 32
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_QUICKSLOT_INFORMATION = 64
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_PLACEHOLDER = 128

BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 1
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 2
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 4
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 8
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 16
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 32
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 64
BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B3_PLACEHOLDER = 128

BeltalowdaAdmin.constants.player = {}
BeltalowdaAdmin.constants.config = {}
BeltalowdaAdmin.constants.equipmentType = {}
BeltalowdaAdmin.constants.equipmentType.ARMOR = 1
BeltalowdaAdmin.constants.equipmentType.WEAPON = 2
BeltalowdaAdmin.constants.equipmentType.ACCESSORIES = 3
BeltalowdaAdmin.constants.equipment = {}
BeltalowdaAdmin.constants.equipment[1] = {}
BeltalowdaAdmin.constants.equipment[1].slotId = 0
BeltalowdaAdmin.constants.equipment[1].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.HEAD
BeltalowdaAdmin.constants.equipment[1].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[1].texture = "esoui/art/characterwindow/gearslot_head.dds"
BeltalowdaAdmin.constants.equipment[2] = {}
BeltalowdaAdmin.constants.equipment[2].slotId = 3
BeltalowdaAdmin.constants.equipment[2].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.SHOULDERS
BeltalowdaAdmin.constants.equipment[2].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[2].texture = "esoui/art/characterwindow/gearslot_shoulders.dds"
BeltalowdaAdmin.constants.equipment[3] = {}
BeltalowdaAdmin.constants.equipment[3].slotId = 2
BeltalowdaAdmin.constants.equipment[3].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.CHEST
BeltalowdaAdmin.constants.equipment[3].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[3].texture = "esoui/art/characterwindow/gearslot_chest.dds"
BeltalowdaAdmin.constants.equipment[4] = {}
BeltalowdaAdmin.constants.equipment[4].slotId = 16
BeltalowdaAdmin.constants.equipment[4].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.HANDS
BeltalowdaAdmin.constants.equipment[4].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[4].texture = "esoui/art/characterwindow/gearslot_hands.dds"
BeltalowdaAdmin.constants.equipment[5] = {}
BeltalowdaAdmin.constants.equipment[5].slotId = 6
BeltalowdaAdmin.constants.equipment[5].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.WAIST
BeltalowdaAdmin.constants.equipment[5].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[5].texture = "esoui/art/characterwindow/gearslot_belt.dds"
BeltalowdaAdmin.constants.equipment[6] = {}
BeltalowdaAdmin.constants.equipment[6].slotId = 8
BeltalowdaAdmin.constants.equipment[6].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.LEGS
BeltalowdaAdmin.constants.equipment[6].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[6].texture = "esoui/art/characterwindow/gearslot_legs.dds"
BeltalowdaAdmin.constants.equipment[7] = {}
BeltalowdaAdmin.constants.equipment[7].slotId = 9
BeltalowdaAdmin.constants.equipment[7].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.FEET
BeltalowdaAdmin.constants.equipment[7].eType = BeltalowdaAdmin.constants.equipmentType.ARMOR
BeltalowdaAdmin.constants.equipment[7].texture = "esoui/art/characterwindow/gearslot_feet.dds"
BeltalowdaAdmin.constants.equipment[8] = {}
BeltalowdaAdmin.constants.equipment[8].slotId = 1
BeltalowdaAdmin.constants.equipment[8].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.NECKLACE
BeltalowdaAdmin.constants.equipment[8].eType = BeltalowdaAdmin.constants.equipmentType.ACCESSORIES
BeltalowdaAdmin.constants.equipment[8].texture = "esoui/art/characterwindow/gearslot_neck.dds"
BeltalowdaAdmin.constants.equipment[9] = {}
BeltalowdaAdmin.constants.equipment[9].slotId = 11
BeltalowdaAdmin.constants.equipment[9].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.RING_1
BeltalowdaAdmin.constants.equipment[9].eType = BeltalowdaAdmin.constants.equipmentType.ACCESSORIES
BeltalowdaAdmin.constants.equipment[9].texture = "esoui/art/characterwindow/gearslot_ring.dds"
BeltalowdaAdmin.constants.equipment[10] = {}
BeltalowdaAdmin.constants.equipment[10].slotId = 12
BeltalowdaAdmin.constants.equipment[10].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.RING_2
BeltalowdaAdmin.constants.equipment[10].eType = BeltalowdaAdmin.constants.equipmentType.ACCESSORIES
BeltalowdaAdmin.constants.equipment[10].texture = "esoui/art/characterwindow/gearslot_ring.dds"
BeltalowdaAdmin.constants.equipment[11] = {}
BeltalowdaAdmin.constants.equipment[11].slotId = 4
BeltalowdaAdmin.constants.equipment[11].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.WEAPON_1_1
BeltalowdaAdmin.constants.equipment[11].eType = BeltalowdaAdmin.constants.equipmentType.WEAPON
BeltalowdaAdmin.constants.equipment[11].texture = "esoui/art/characterwindow/gearslot_mainhand.dds"
BeltalowdaAdmin.constants.equipment[12] = {}
BeltalowdaAdmin.constants.equipment[12].slotId = 5
BeltalowdaAdmin.constants.equipment[12].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.WEAPON_1_2
BeltalowdaAdmin.constants.equipment[12].eType = BeltalowdaAdmin.constants.equipmentType.WEAPON
BeltalowdaAdmin.constants.equipment[12].texture = "esoui/art/characterwindow/gearslot_offhand.dds"
BeltalowdaAdmin.constants.equipment[13] = {}
BeltalowdaAdmin.constants.equipment[13].slotId = 20
BeltalowdaAdmin.constants.equipment[13].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.WEAPON_2_1
BeltalowdaAdmin.constants.equipment[13].eType = BeltalowdaAdmin.constants.equipmentType.WEAPON
BeltalowdaAdmin.constants.equipment[13].texture = "esoui/art/characterwindow/gearslot_mainhand.dds"
BeltalowdaAdmin.constants.equipment[14] = {}
BeltalowdaAdmin.constants.equipment[14].slotId = 21
BeltalowdaAdmin.constants.equipment[14].messagePrefix = BeltalowdaEquip.constants.networking.messagePrefix.WEAPON_2_2
BeltalowdaAdmin.constants.equipment[14].eType = BeltalowdaAdmin.constants.equipmentType.WEAPON
BeltalowdaAdmin.constants.equipment[14].texture = "esoui/art/characterwindow/gearslot_offhand.dds"
--poison at 13 (weapon 4) and 14 (weapon 20)

BeltalowdaAdmin.constants.cpDisciplines = {}
BeltalowdaAdmin.constants.cpDisciplines[1] = {}
BeltalowdaAdmin.constants.cpDisciplines[1].id = 4
BeltalowdaAdmin.constants.cpDisciplines[2] = {}
BeltalowdaAdmin.constants.cpDisciplines[2].id = 1
BeltalowdaAdmin.constants.cpDisciplines[3] = {}
BeltalowdaAdmin.constants.cpDisciplines[3].id = 7
BeltalowdaAdmin.constants.cpDisciplines[4] = {}
BeltalowdaAdmin.constants.cpDisciplines[4].id = 3
BeltalowdaAdmin.constants.cpDisciplines[5] = {}
BeltalowdaAdmin.constants.cpDisciplines[5].id = 9
BeltalowdaAdmin.constants.cpDisciplines[6] = {}
BeltalowdaAdmin.constants.cpDisciplines[6].id = 6
BeltalowdaAdmin.constants.cpDisciplines[7] = {}
BeltalowdaAdmin.constants.cpDisciplines[7].id = 2
BeltalowdaAdmin.constants.cpDisciplines[8] = {}
BeltalowdaAdmin.constants.cpDisciplines[8].id = 8
BeltalowdaAdmin.constants.cpDisciplines[9] = {}
BeltalowdaAdmin.constants.cpDisciplines[9].id = 5


BeltalowdaAdmin.callbackName = Beltalowda.addonName .. "Admin"
BeltalowdaAdmin.requestCallbackName = Beltalowda.addonName .. "AdminRequestCallback"
BeltalowdaAdmin.responseCallbackName = Beltalowda.addonName .. "AdminResponseCallback"

BeltalowdaAdmin.controls = {}

BeltalowdaAdmin.config = {}
BeltalowdaAdmin.config.playerWidth = 200
BeltalowdaAdmin.config.configWidth = 600
BeltalowdaAdmin.config.configOffset = 10
BeltalowdaAdmin.config.width = BeltalowdaAdmin.config.playerWidth + BeltalowdaAdmin.config.configWidth + BeltalowdaAdmin.config.configOffset
BeltalowdaAdmin.config.playerBlockHeight = 20
BeltalowdaAdmin.config.height = BeltalowdaAdmin.config.playerBlockHeight * 25 + 10
BeltalowdaAdmin.config.headerHeight = 33
BeltalowdaAdmin.config.headerOffset = 3
BeltalowdaAdmin.config.isMovable = true
BeltalowdaAdmin.config.isMouseEnabled = true
BeltalowdaAdmin.config.isClampedToScreen = true
BeltalowdaAdmin.config.headerFont = "$(BOLD_FONT)|$(KB_20)soft-shadow-thick"
BeltalowdaAdmin.config.configEntrySize = 20
BeltalowdaAdmin.config.color = {}
BeltalowdaAdmin.config.color.default = {}
BeltalowdaAdmin.config.color.default.r = 0.85
BeltalowdaAdmin.config.color.default.g = 0.83
BeltalowdaAdmin.config.color.default.b = 0.7
BeltalowdaAdmin.config.color.player = {}
BeltalowdaAdmin.config.color.player.r = 0.85
BeltalowdaAdmin.config.color.player.g = 0.83
BeltalowdaAdmin.config.color.player.b = 0.7
BeltalowdaAdmin.config.color.backdrop = {}
BeltalowdaAdmin.config.color.backdrop.r = 0.0
BeltalowdaAdmin.config.color.backdrop.g = 0.0
BeltalowdaAdmin.config.color.backdrop.b = 0.0
BeltalowdaAdmin.config.color.backdrop.a = 0.7
BeltalowdaAdmin.config.color.backdropEdge = {}
BeltalowdaAdmin.config.color.backdropEdge.r = 1.0
BeltalowdaAdmin.config.color.backdropEdge.g = 1.0
BeltalowdaAdmin.config.color.backdropEdge.b = 1.0
BeltalowdaAdmin.config.color.backdropEdge.a = 0.7
BeltalowdaAdmin.config.color.playerEntryColorSelected = {}
BeltalowdaAdmin.config.color.playerEntryColorSelected.r = 0.8
BeltalowdaAdmin.config.color.playerEntryColorSelected.g = 0.6
BeltalowdaAdmin.config.color.playerEntryColorSelected.b = 0.4
BeltalowdaAdmin.config.color.playerEntryColorSelected.a = 0.3
BeltalowdaAdmin.config.color.playerEntryColorSelectedHover = {}
BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.r = 0.4
BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.g = 0.6
BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.b = 1.0
BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.a = 0.7
BeltalowdaAdmin.config.color.playerEntryColorHover = {}
BeltalowdaAdmin.config.color.playerEntryColorHover.r = 0.4
BeltalowdaAdmin.config.color.playerEntryColorHover.g = 0.6
BeltalowdaAdmin.config.color.playerEntryColorHover.b = 1.0
BeltalowdaAdmin.config.color.playerEntryColorHover.a = 0.3
BeltalowdaAdmin.config.color.titleColor = {}
BeltalowdaAdmin.config.color.titleColor.r = 1
BeltalowdaAdmin.config.color.titleColor.g = 0.35
BeltalowdaAdmin.config.color.titleColor.b = 0.35
BeltalowdaAdmin.config.color.subtitleColor = {}
BeltalowdaAdmin.config.color.subtitleColor.r = 0.35
BeltalowdaAdmin.config.color.subtitleColor.g = 0.35
BeltalowdaAdmin.config.color.subtitleColor.b = 1
BeltalowdaAdmin.config.color.equipmentDescription = {}
BeltalowdaAdmin.config.color.equipmentDescription.r = 0.85
BeltalowdaAdmin.config.color.equipmentDescription.g = 0.83
BeltalowdaAdmin.config.color.equipmentDescription.b = 0.7
BeltalowdaAdmin.config.color.equipmentHover = {}
BeltalowdaAdmin.config.color.equipmentHover.r = 0.4
BeltalowdaAdmin.config.color.equipmentHover.g = 0.6
BeltalowdaAdmin.config.color.equipmentHover.b = 1.0
BeltalowdaAdmin.config.color.equipmentHover.a = 0.7
BeltalowdaAdmin.config.color.cpText = {}
BeltalowdaAdmin.config.color.cpText.r = 0.85
BeltalowdaAdmin.config.color.cpText.g = 0.83
BeltalowdaAdmin.config.color.cpText.b = 0.7
BeltalowdaAdmin.config.color.cpValue = {}
BeltalowdaAdmin.config.color.cpValue.r = 1
BeltalowdaAdmin.config.color.cpValue.g = 1
BeltalowdaAdmin.config.color.cpValue.b = 1
BeltalowdaAdmin.config.color.cpRed = {}
BeltalowdaAdmin.config.color.cpRed.r = 0.83203125
BeltalowdaAdmin.config.color.cpRed.g = 0.3515625
BeltalowdaAdmin.config.color.cpRed.b = 0.171875
BeltalowdaAdmin.config.color.cpGreen = {}
BeltalowdaAdmin.config.color.cpGreen.r = 0.5
BeltalowdaAdmin.config.color.cpGreen.g = 0.91796875
BeltalowdaAdmin.config.color.cpGreen.b = 0.5
BeltalowdaAdmin.config.color.cpBlue = {}
BeltalowdaAdmin.config.color.cpBlue.r = 0.5
BeltalowdaAdmin.config.color.cpBlue.g = 0.85546875
BeltalowdaAdmin.config.color.cpBlue.b = 1.0

BeltalowdaAdmin.config.configWindow = {}
BeltalowdaAdmin.config.configWindow.rating = {}
BeltalowdaAdmin.config.configWindow.rating.neutral = "FFFFFF"
BeltalowdaAdmin.config.configWindow.rating.ok = "00FF00"
BeltalowdaAdmin.config.configWindow.rating.fail = "FF0000"
BeltalowdaAdmin.config.configWindow.equipmentValue = "FFFFFF"

BeltalowdaAdmin.state = {}
BeltalowdaAdmin.state.size = 0
BeltalowdaAdmin.state.selectedIndex = 0
BeltalowdaAdmin.state.playerList = {}
BeltalowdaAdmin.state.initialized = false

local wm = WINDOW_MANAGER

function BeltalowdaAdmin.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaAdmin.callbackName, BeltalowdaAdmin.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_ADMIN_OPEN", BeltalowdaAdmin.constants.TOGGLE_ADMIN)
	for i = 1, #BeltalowdaAdmin.constants.equipment do
		BeltalowdaAdmin.constants.equipment[i].name = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(BeltalowdaAdmin.constants.equipment[i].messagePrefix)
	end
	for i = 1, #BeltalowdaAdmin.constants.cpDisciplines do
		BeltalowdaAdmin.constants.cpDisciplines[i].text = BeltalowdaCP.GetDisciplineText(BeltalowdaAdmin.constants.cpDisciplines[i].id)
		BeltalowdaAdmin.constants.cpDisciplines[i].cp = BeltalowdaCP.CreateCPStructureForDiscipline(BeltalowdaAdmin.constants.cpDisciplines[i].id)
	end
	BeltalowdaAdmin.CreateUI()
	BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaAdmin.requestCallbackName, BeltalowdaAdmin.HandleRawAdminNetworkMessage)
	--if BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName("player")) then
	BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaAdmin.responseCallbackName, BeltalowdaGroup.HandleRawAdminNetworkMessage)
	--end
	BeltalowdaAdmin.state.initialized = true
end

function BeltalowdaAdmin.SetTlwLocation()
	if BeltalowdaAdmin.adminVars == nil or BeltalowdaAdmin.adminVars.position == nil then
		BeltalowdaAdmin.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, -BeltalowdaAdmin.config.height / 2)
	else
		BeltalowdaAdmin.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaAdmin.adminVars.position.x , BeltalowdaAdmin.adminVars.position.y)
	end
end

function BeltalowdaAdmin.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.allowClientConfiguration = false
	defaults.allowAddonConfiguration = true
	defaults.allowStats = true
	defaults.allowSkills = true
	defaults.allowEquipment = true
	defaults.allowCp = true
	return defaults
end

function BeltalowdaAdmin.CreateUI()
	--TLW
	BeltalowdaAdmin.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaAdmin.constants.TLW_ADMIN_WINDOW)
	
	BeltalowdaAdmin.controls.TLW:SetDimensions(BeltalowdaAdmin.config.width, BeltalowdaAdmin.config.headerHeight)
	BeltalowdaAdmin.SetTlwLocation()
	
	BeltalowdaAdmin.controls.TLW:SetMovable(BeltalowdaAdmin.config.isMovable)
	BeltalowdaAdmin.controls.TLW:SetMouseEnabled(BeltalowdaAdmin.config.isMouseEnabled)
	
	BeltalowdaAdmin.controls.TLW:SetClampedToScreen(BeltalowdaAdmin.config.isClampedToScreen)
	BeltalowdaAdmin.controls.TLW:SetHandler("OnMoveStop", BeltalowdaAdmin.SaveWindowLocation)
	BeltalowdaAdmin.controls.TLW:SetHidden(true)
	
	--Header
	
	BeltalowdaAdmin.controls.TLW.header= wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW, CT_CONTROL)
	BeltalowdaAdmin.controls.TLW.header:SetDimensions(BeltalowdaAdmin.config.width, BeltalowdaAdmin.config.headerHeight)
	BeltalowdaAdmin.controls.TLW.header:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW, TOPLEFT, 0, 0)
	
	
	BeltalowdaAdmin.controls.TLW.header.label = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.header, CT_LABEL)
	BeltalowdaAdmin.controls.TLW.header.label:SetAnchor(TOP, BeltalowdaAdmin.controls.TLW.header, TOP ,0 , 3)
	BeltalowdaAdmin.controls.TLW.header.label:SetFont(BeltalowdaAdmin.config.headerFont)
	BeltalowdaAdmin.controls.TLW.header.label:SetWrapMode(ELLIPSIS)
	BeltalowdaAdmin.controls.TLW.header.label:SetColor(BeltalowdaAdmin.config.color.default.r, BeltalowdaAdmin.config.color.default.g, BeltalowdaAdmin.config.color.default.b)
	BeltalowdaAdmin.controls.TLW.header.label:SetText(BeltalowdaAdmin.constants.HEADER_TITLE)
		
		
	BeltalowdaAdmin.controls.TLW.header.backdrop = CreateControlFromVirtual(BeltalowdaAdmin.constants.HEADER_BACKDROP_NAME, BeltalowdaAdmin.controls.TLW.header, "ZO_SliderBackdrop")
	BeltalowdaAdmin.controls.TLW.header.backdrop:SetCenterColor(BeltalowdaAdmin.config.color.backdrop.r, BeltalowdaAdmin.config.color.backdrop.g, BeltalowdaAdmin.config.color.backdrop.b, BeltalowdaAdmin.config.color.backdrop.a)
	BeltalowdaAdmin.controls.TLW.header.backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.backdropEdge.r, BeltalowdaAdmin.config.color.backdropEdge.g, BeltalowdaAdmin.config.color.backdropEdge.b, BeltalowdaAdmin.config.color.backdropEdge.a)
		
	BeltalowdaAdmin.controls.TLW.header.button = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.header, CT_BUTTON)
	BeltalowdaAdmin.controls.TLW.header.button:SetAnchor(TOPRIGHT, BeltalowdaAdmin.controls.TLW.header, TOPRIGHT, -3, 7)
	BeltalowdaAdmin.controls.TLW.header.button:SetDimensions(20, 20)
	BeltalowdaAdmin.controls.TLW.header.button:SetNormalTexture("/esoui/art/buttons/decline_up.dds")
	BeltalowdaAdmin.controls.TLW.header.button:SetMouseOverTexture("/esoui/art/buttons/decline_over.dds")
	BeltalowdaAdmin.controls.TLW.header.button:SetHandler("OnClicked", BeltalowdaAdmin.CloseWindow)
	
	
	--Player Window
	
	BeltalowdaAdmin.controls.TLW.player = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW, CT_CONTROL)
	BeltalowdaAdmin.controls.TLW.player:SetDimensions(BeltalowdaAdmin.config.playerWidth, BeltalowdaAdmin.config.height)
	BeltalowdaAdmin.controls.TLW.player:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW, TOPLEFT, 0, BeltalowdaAdmin.config.headerOffset + BeltalowdaAdmin.config.headerHeight)
	
	BeltalowdaAdmin.controls.TLW.player.backdrop = CreateControlFromVirtual(BeltalowdaAdmin.constants.PLAYER_BACKDROP_NAME, BeltalowdaAdmin.controls.TLW.player, "ZO_SliderBackdrop")
	BeltalowdaAdmin.controls.TLW.player.backdrop:SetCenterColor(BeltalowdaAdmin.config.color.backdrop.r, BeltalowdaAdmin.config.color.backdrop.g, BeltalowdaAdmin.config.color.backdrop.b, BeltalowdaAdmin.config.color.backdrop.a)
	BeltalowdaAdmin.controls.TLW.player.backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.backdropEdge.r, BeltalowdaAdmin.config.color.backdropEdge.g, BeltalowdaAdmin.config.color.backdropEdge.b, BeltalowdaAdmin.config.color.backdropEdge.a)
	
	local blockFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.playerBlockHeight - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	BeltalowdaAdmin.controls.TLW.player.blocks = {}
	
	for i = 1, 25 do
		local backdrop = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.player, CT_BACKDROP)
		
		BeltalowdaAdmin.controls.TLW.player.blocks[i] = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.player, CT_BUTTON)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:EnableMouseButton(MOUSE_BUTTON_INDEX_RIGHT, true)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetFont(blockFont)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetMouseEnabled(true)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW.player, TOPLEFT ,5 , 7 + ((i - 1) * BeltalowdaAdmin.config.playerBlockHeight))
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetDimensions(BeltalowdaAdmin.config.playerWidth - 6, BeltalowdaAdmin.config.playerBlockHeight)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetNormalFontColor(BeltalowdaAdmin.config.color.player.r, BeltalowdaAdmin.config.color.player.g, BeltalowdaAdmin.config.color.player.b, 1)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetPressedFontColor(BeltalowdaAdmin.config.color.player.r, BeltalowdaAdmin.config.color.player.g, BeltalowdaAdmin.config.color.player.b, 1)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetMouseOverFontColor(BeltalowdaAdmin.config.color.player.r, BeltalowdaAdmin.config.color.player.g, BeltalowdaAdmin.config.color.player.b, 1)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHandler("OnMouseEnter", function() BeltalowdaAdmin.PlayerEntryOnMouseEnter(i) end)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHandler("OnMouseExit", function() BeltalowdaAdmin.PlayerEntryOnMouseExit(i) end)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHandler("OnClicked", function(idk, button) if button == MOUSE_BUTTON_INDEX_LEFT then BeltalowdaAdmin.PlayerEntryOnClick(i) elseif button == MOUSE_BUTTON_INDEX_RIGHT then BeltalowdaAdmin.PlayerEntryOnClick(i) BeltalowdaAdmin.CreatePlayerContextMenu(i) end end)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetVerticalAlignment(TEXT_ALIGN_TOP)
		BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		--BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetText("test")
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop = backdrop
		
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop:SetAlpha(1)
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW.player, TOPLEFT ,5 , 7 + ((i - 1) * BeltalowdaAdmin.config.playerBlockHeight))
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop:SetDimensions(BeltalowdaAdmin.config.playerWidth - 6, BeltalowdaAdmin.config.playerBlockHeight)
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop:SetCenterColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, 0.0)
		BeltalowdaAdmin.controls.TLW.player.blocks[i].backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, 0.0)	
	end	
	
	BeltalowdaAdmin.controls.TLW.player.blocks[1]:SetText(BeltalowdaAdmin.constants.PLAYERS_ALL)
	
	--Config Window
	
	BeltalowdaAdmin.controls.TLW.config = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW, CT_CONTROL)
	BeltalowdaAdmin.controls.TLW.config:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.height)
	BeltalowdaAdmin.controls.TLW.config:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW, TOPLEFT, BeltalowdaAdmin.config.playerWidth + BeltalowdaAdmin.config.configOffset, BeltalowdaAdmin.config.headerOffset + BeltalowdaAdmin.config.headerHeight)
	
	BeltalowdaAdmin.controls.TLW.config.backdrop = CreateControlFromVirtual(BeltalowdaAdmin.constants.CONFIG_BACKDROP_NAME, BeltalowdaAdmin.controls.TLW.config, "ZO_SliderBackdrop")
	BeltalowdaAdmin.controls.TLW.config.backdrop:SetCenterColor(BeltalowdaAdmin.config.color.backdrop.r, BeltalowdaAdmin.config.color.backdrop.g, BeltalowdaAdmin.config.color.backdrop.b, BeltalowdaAdmin.config.color.backdrop.a)
	BeltalowdaAdmin.controls.TLW.config.backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.backdropEdge.r, BeltalowdaAdmin.config.color.backdropEdge.g, BeltalowdaAdmin.config.color.backdropEdge.b, BeltalowdaAdmin.config.color.backdropEdge.a)
	
	BeltalowdaAdmin.controls.TLW.config.scrollControl = wm:CreateControl(BeltalowdaAdmin.constants.SCROLL_CONTROL, BeltalowdaAdmin.controls.TLW.config, CT_SCROLL)
	BeltalowdaAdmin.controls.TLW.config.scrollControl:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.height - 15)
	BeltalowdaAdmin.controls.TLW.config.scrollControl:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW.config, TOPLEFT, 0, 8)
	BeltalowdaAdmin.controls.TLW.config.scrollControl:SetScrollBounding(SCROLL_BOUNDING_CONTAINED)
	
	
	BeltalowdaAdmin.controls.TLW.config.scrollPanel = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.config.scrollControl, CT_CONTROL)
	
	BeltalowdaAdmin.controls.TLW.config.scrollPanel:SetAnchor(TOPLEFT, BeltalowdaAdmin.controls.TLW.config.scrollControl, TOPLEFT, 0, 0)
	BeltalowdaAdmin.controls.TLW.config.scrollPanel:SetMouseEnabled(true)
	BeltalowdaAdmin.controls.TLW.config.scrollPanel:SetHandler("OnMouseWheel", BeltalowdaAdmin.ConfigPanelOnMouseWheel);
	
	BeltalowdaAdmin.controls.TLW.config.slider = wm:CreateControl(nil, BeltalowdaAdmin.controls.TLW.config, CT_SLIDER)
	BeltalowdaAdmin.controls.TLW.config.slider:SetDimensions(25, BeltalowdaAdmin.config.height)
	BeltalowdaAdmin.controls.TLW.config.slider:SetAnchor(TOPRIGHT, BeltalowdaAdmin.controls.TLW.config, TOPRIGHT, 0, 0)
	BeltalowdaAdmin.controls.TLW.config.slider:SetOrientation(ORIENTATION_VERTICAL)
	BeltalowdaAdmin.controls.TLW.config.slider:SetMouseEnabled(true)
	BeltalowdaAdmin.controls.TLW.config.slider:SetMinMax(0, 100)
	BeltalowdaAdmin.controls.TLW.config.slider:SetThumbTexture("esoui/art/buttons/smoothsliderbutton_up.dds", nil, nil, 25, 50)
	BeltalowdaAdmin.controls.TLW.config.slider:SetValueStep(1)
	BeltalowdaAdmin.controls.TLW.config.slider:SetHandler("OnValueChanged", BeltalowdaAdmin.AdjustConfigSlider)
	
	BeltalowdaAdmin.CreateConfigUI(BeltalowdaAdmin.controls.TLW.config.scrollPanel)
	BeltalowdaAdmin.controls.TLW.config.scrollPanel:SetDimensions(BeltalowdaAdmin.config.configWidth - 10, BeltalowdaAdmin.state.size)
	BeltalowdaAdmin.PopulateConfigPanel(BeltalowdaAdmin.CreateConfigPanelData(0))
end

function BeltalowdaAdmin.CreateConfigUI(rootControl)
	local controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local tempSize = 0
	
	rootControl.player = {}
	rootControl.player.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.PLAYER_TITLE)
	rootControl.player.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.player.displayName, rootControl.player.charName = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.player.version = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	--rootControl.player.version:SetText(string.format(BeltalowdaAdmin.constants.config.PLAYER_VERSION_STRING, BeltalowdaAdmin.config.configWindow.rating.neutral, 0, 0, 0))
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.client = {}
	rootControl.client.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.CLIENT_TITLE)
	rootControl.client.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.client.aoe = {}
	rootControl.client.aoe.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.CLIENT_AOE_SUBTITLE)
	rootControl.client.aoe.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.client.aoe.tellsEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.aoe.customColorsEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.aoe.friendlyBrightness = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.aoe.enemyBrightness = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.client.sound = {}
	rootControl.client.sound.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.CLIENT_SOUND_SUBTITLE)
	rootControl.client.sound.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.client.sound.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.sound.audioVolume = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.sound.uiVolume = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.sound.sfxVolume = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.client.graphics = {}
	rootControl.client.graphics.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBTITLE)
	rootControl.client.graphics.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.client.graphics.resolution = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.windowMode = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.vsync = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.antiAliasing = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.ambient = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.bloom = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.depthOfField = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.distortion = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.sunlight = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.allyEffects = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.viewDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.particleMaximum = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.particleSupress = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.reflectionQuality = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.shadowQuality = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.subSamplingQuality = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.client.graphics.graphicPresets = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon = {}
	rootControl.addon.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_TITLE)
	rootControl.addon.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.crown = {}
	rootControl.addon.crown.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CROWN_SUBTITLE)
	rootControl.addon.crown.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.crown.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.crown.size = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.crown.selectedCrown = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ftcv = {}
	rootControl.addon.ftcv.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_FTCV_SUBTITLE)
	rootControl.addon.ftcv.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ftcv.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.sizeFar = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.sizeClose = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.opacityFar = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.opacityClose = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.minDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcv.maxDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ftcw = {}
	rootControl.addon.ftcw.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_FTCW_SUBTITLE)
	rootControl.addon.ftcw.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ftcw.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcw.distanceEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcw.warningsEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcw.maxDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ftca = {}
	rootControl.addon.ftca.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_FTCA_SUBTITLE)
	rootControl.addon.ftca.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ftca.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftca.maxDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftca.interval = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftca.threshold = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ftcb = {}
	rootControl.addon.ftcb.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_FTCB_SUBTITLE)
	rootControl.addon.ftcb.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ftcb.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcb.selectedBeam = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ftcb.alpha = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.dbo = {}
	rootControl.addon.dbo.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_DBO_SUBTITLE)
	rootControl.addon.dbo.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.dbo.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.rt = {}
	rootControl.addon.rt.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_RT_SUBTITLE)
	rootControl.addon.rt.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.rt.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ro = {}
	rootControl.addon.ro.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_RO_SUBTITLE)
	rootControl.addon.ro.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ro.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.ultimateOverviewEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.clientGroupEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupUltimateEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.showSoftResources = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.soundEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.maxDistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeDestro = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeStorm = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeNorthernStorm = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizePermafrost = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeNegate = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeNegateOffensive = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeNegateCounter = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupSizeNova = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ro.groupsEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.hdm = {}
	rootControl.addon.hdm.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_HDM_SUBTITLE)
	rootControl.addon.hdm.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.hdm.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.hdm.windowEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.hdm.viewMode = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.po = {}
	rootControl.addon.po.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_PO_SUBTITLE)
	rootControl.addon.po.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.po.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.po.soundEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.dt = {}
	rootControl.addon.dt.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_DT_SUBTITLE)
	rootControl.addon.dt.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.dt.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.gb = {}
	rootControl.addon.gb.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_GB_SUBTITLE)
	rootControl.addon.gb.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.gb.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.isdp = {}
	rootControl.addon.isdp.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_ISDP_SUBTITLE)
	rootControl.addon.isdp.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.isdp.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.yacs = {}
	rootControl.addon.yacs.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_YACS_SUBTITLE)
	rootControl.addon.yacs.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.yacs.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.yacs.pvpEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.yacs.combatEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.sc = {}
	rootControl.addon.sc.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_SC_SUBTITLE)
	rootControl.addon.sc.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.sc.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.sm = {}
	rootControl.addon.sm.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_SM_SUBTITLE)
	rootControl.addon.sm.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.sm.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.recharger = {}
	rootControl.addon.recharger.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_RECHARGER_SUBTITLE)
	rootControl.addon.recharger.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.recharger.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true then
		rootControl.addon.kc = {}
		rootControl.addon.kc.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_KC_SUBTITLE)
		rootControl.addon.kc.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
		
		BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
		
		rootControl.addon.kc.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
		
		BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	end
	rootControl.addon.bft = {}
	rootControl.addon.bft.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_BFT_SUBTITLE)
	rootControl.addon.bft.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.bft.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.bft.soundEnabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.bft.size = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.cl = {}
	rootControl.addon.cl.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CL_SUBTITLE)
	rootControl.addon.cl.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.cl.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.cs = {}
	rootControl.addon.cs.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CS_SUBTITLE)
	rootControl.addon.cs.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.cs.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.respawner = {}
	rootControl.addon.respawner.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_SUBTITLE)
	rootControl.addon.respawner.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.respawner.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.camp = {}
	rootControl.addon.camp.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CAMP_SUBTITLE)
	rootControl.addon.camp.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.camp.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.sp = {}
	rootControl.addon.sp.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_SP_SUBTITLE)
	rootControl.addon.sp.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.sp.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.mode = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventCombustionShards = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventTalons = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventNova = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventAltar = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventStandard = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventRitual = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventBoneShield = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventConduit = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventAtronach = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventTrappingWebs = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventRadiate = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventConsumingDarkness = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventSoulLeech = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventHealingSeed = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventGraveRobber = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.sp.preventPureAgony = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.so = {}
	rootControl.addon.so.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_SO_SUBTITLE)
	rootControl.addon.so.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.so.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.so.tableMode = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.so.displayMode = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.ra = {}
	rootControl.addon.ra.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_RA_SUBTITLE)
	rootControl.addon.ra.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.ra.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.addon.ra.allowOverride = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.caj = {}
	rootControl.addon.caj.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CAJ_SUBTITLE)
	rootControl.addon.caj.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.caj.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.addon.crBgTp = {}
	rootControl.addon.crBgTp.title, tempSize = BeltalowdaAdmin.CreateSubtitleControl(rootControl, BeltalowdaAdmin.constants.config.ADDON_CRBGTP_SUBTITLE)
	rootControl.addon.crBgTp.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.addon.crBgTp.enabled = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	--stats
	rootControl.stats = {}
	rootControl.stats.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.STATS_TITLE)
	rootControl.stats.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.stats.magicka, rootControl.stats.magickaRecovery = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.stats.health, rootControl.stats.healthRecovery = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.stats.stamina, rootControl.stats.staminaRecovery = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	rootControl.stats.spellDamage, rootControl.stats.weaponDamage = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.stats.spellPenetration, rootControl.stats.weaponPenetration = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.stats.spellCritical, rootControl.stats.weaponCritical = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
		
	rootControl.stats.spellResistance, rootControl.stats.physicalResistance = BeltalowdaAdmin.CreateDoubleLabel(rootControl, controlFont)
	rootControl.stats.criticalResistance = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)

	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	--Mundus
	rootControl.mundus = {}
	rootControl.mundus.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.MUNDUS_TITLE)
	rootControl.mundus.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.mundus.stone1 = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	rootControl.mundus.stone2 = BeltalowdaAdmin.CreateSimpleLabel(rootControl, controlFont)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	--skills
	rootControl.skills = {}
	rootControl.skills.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.SKILLS_TITLE)
	rootControl.skills.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.skills.bar1, tempSize = BeltalowdaAdmin.CreateSkillBarControl(rootControl)
	rootControl.skills.bar1:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.skills.bar2, tempSize = BeltalowdaAdmin.CreateSkillBarControl(rootControl)
	rootControl.skills.bar2:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize + BeltalowdaAdmin.config.configEntrySize
	
	--equipment
	rootControl.equipment = {}
	rootControl.equipment.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.EQUIPMENT_TITLE)
	rootControl.equipment.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	for i = 1, #BeltalowdaAdmin.constants.equipment do
		rootControl.equipment[BeltalowdaAdmin.constants.equipment[i].name], tempSize = BeltalowdaAdmin.CreateEquipmentControl(rootControl, BeltalowdaAdmin.constants.equipment[i], i)
		rootControl.equipment[BeltalowdaAdmin.constants.equipment[i].name]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
		BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	end
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	--champion points cp
	rootControl.cp = {}
	rootControl.cp.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.CHAMPION_TITLE)
	rootControl.cp.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	
	rootControl.cp.cpBlocks = {}
	rootControl.cp.cpValues = {}
	for i = 1, 3 do
		local cpNames = {}
		local width = BeltalowdaAdmin.config.configWidth / 3 - 10
		rootControl.cp.cpBlocks[1 + ((i - 1) * 3)], cpNames, tempSize = BeltalowdaAdmin.CreateCPBlock(rootControl, BeltalowdaAdmin.constants.cpDisciplines[1 + ((i - 1) * 3)], width)
		rootControl.cp.cpBlocks[1 + ((i - 1) * 3)]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
		rootControl.cp.cpBlocks[1 + ((i - 1) * 3)].title:SetColor(BeltalowdaAdmin.config.color.cpRed.r, BeltalowdaAdmin.config.color.cpRed.g, BeltalowdaAdmin.config.color.cpRed.b)
		rootControl.cp.cpValues[cpNames[1].name] = cpNames[1].control
		rootControl.cp.cpValues[cpNames[2].name] = cpNames[2].control
		rootControl.cp.cpValues[cpNames[3].name] = cpNames[3].control
		rootControl.cp.cpValues[cpNames[4].name] = cpNames[4].control
		
		rootControl.cp.cpBlocks[2 + ((i - 1) * 3)], cpNames, tempSize = BeltalowdaAdmin.CreateCPBlock(rootControl, BeltalowdaAdmin.constants.cpDisciplines[2 + ((i - 1) * 3)], width)
		rootControl.cp.cpBlocks[2 + ((i - 1) * 3)]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, width, BeltalowdaAdmin.state.size)
		rootControl.cp.cpBlocks[2 + ((i - 1) * 3)].title:SetColor(BeltalowdaAdmin.config.color.cpGreen.r, BeltalowdaAdmin.config.color.cpGreen.g, BeltalowdaAdmin.config.color.cpGreen.b)
		rootControl.cp.cpValues[cpNames[1].name] = cpNames[1].control
		rootControl.cp.cpValues[cpNames[2].name] = cpNames[2].control
		rootControl.cp.cpValues[cpNames[3].name] = cpNames[3].control
		rootControl.cp.cpValues[cpNames[4].name] = cpNames[4].control
		
		rootControl.cp.cpBlocks[3 + ((i - 1) * 3)], cpNames, tempSize = BeltalowdaAdmin.CreateCPBlock(rootControl, BeltalowdaAdmin.constants.cpDisciplines[3 + ((i - 1) * 3)], width)
		rootControl.cp.cpBlocks[3 + ((i - 1) * 3)]:SetAnchor(TOPLEFT, rootControl, TOPLEFT, width * 2, BeltalowdaAdmin.state.size)
		rootControl.cp.cpBlocks[3 + ((i - 1) * 3)].title:SetColor(BeltalowdaAdmin.config.color.cpBlue.r, BeltalowdaAdmin.config.color.cpBlue.g, BeltalowdaAdmin.config.color.cpBlue.b)
		rootControl.cp.cpValues[cpNames[1].name] = cpNames[1].control
		rootControl.cp.cpValues[cpNames[2].name] = cpNames[2].control
		rootControl.cp.cpValues[cpNames[3].name] = cpNames[3].control
		rootControl.cp.cpValues[cpNames[4].name] = cpNames[4].control
		
		BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize
	end
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	--[[
	--quickslots
	rootControl.quickslots = {}
	rootControl.quickslots.title, tempSize = BeltalowdaAdmin.CreateTitleControl(rootControl, BeltalowdaAdmin.constants.config.QUICKSLOT_TITLE)
	rootControl.quickslots.title:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, BeltalowdaAdmin.state.size)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + tempSize + BeltalowdaAdmin.config.configEntrySize
	]]
end

function BeltalowdaAdmin.CreateSimpleLabel(parent, controlFont)
	local control = wm:CreateControl(nil, parent, CT_LABEL)
	control:SetAnchor(TOPLEFT, parent, TOPLEFT, 3, BeltalowdaAdmin.state.size)
	control:SetDimensions(400, BeltalowdaAdmin.config.configEntrySize)
	control:SetFont(controlFont)
	control:SetWrapMode(ELLIPSIS)
	control:SetColor(BeltalowdaAdmin.config.color.default.r, BeltalowdaAdmin.config.color.default.g, BeltalowdaAdmin.config.color.default.b)
	control:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize
	
	return control
end

function BeltalowdaAdmin.CreateDoubleLabel(parent, controlFont)
	local control1 = wm:CreateControl(nil, parent, CT_LABEL)
	control1:SetAnchor(TOPLEFT, parent, TOPLEFT, 3, BeltalowdaAdmin.state.size)
	control1:SetDimensions(300, BeltalowdaAdmin.config.configEntrySize)
	control1:SetFont(controlFont)
	control1:SetWrapMode(ELLIPSIS)
	control1:SetColor(BeltalowdaAdmin.config.color.default.r, BeltalowdaAdmin.config.color.default.g, BeltalowdaAdmin.config.color.default.b)
	control1:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	local control2 = wm:CreateControl(nil, parent, CT_LABEL)
	control2:SetAnchor(TOPLEFT, parent, TOPLEFT, 303, BeltalowdaAdmin.state.size)
	control2:SetDimensions(300, BeltalowdaAdmin.config.configEntrySize)
	control2:SetFont(controlFont)
	control2:SetWrapMode(ELLIPSIS)
	control2:SetColor(BeltalowdaAdmin.config.color.default.r, BeltalowdaAdmin.config.color.default.g, BeltalowdaAdmin.config.color.default.b)
	control2:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	BeltalowdaAdmin.state.size = BeltalowdaAdmin.state.size + BeltalowdaAdmin.config.configEntrySize

	return control1, control2
end

function BeltalowdaAdmin.CreateTitleControl(parent, title)
	local titleFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize * 2 - 5, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.configEntrySize * 2)
	
	control.title = wm:CreateControl(nil, control, CT_LABEL)
	control.title:SetAnchor(TOPLEFT, control, TOPLEFT, 5, 0)
	control.title:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.configEntrySize * 2 - 5)
	control.title:SetFont(titleFont)
	control.title:SetWrapMode(ELLIPSIS)
	control.title:SetColor(BeltalowdaAdmin.config.color.titleColor.r, BeltalowdaAdmin.config.color.titleColor.g, BeltalowdaAdmin.config.color.titleColor.b)
	control.title:SetText(title)
	control.title:SetVerticalAlignment(TEXT_ALIGN_TOP)
	control.title:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	
	control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
	control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, -100, BeltalowdaAdmin.config.configEntrySize * 2 - 5) 
	control.texture:SetDimensions(800, 15) 
	control.texture:SetTexture("/esoui/art/miscellaneous/horizontaldivider.dds")
	return control, BeltalowdaAdmin.config.configEntrySize * 2 + 10
end

function BeltalowdaAdmin.CreateSubtitleControl(parent, title)
	local subtitleFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize * 2 - 5, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.configEntrySize * 2)
	
	control.title = wm:CreateControl(nil, control, CT_LABEL)
	control.title:SetAnchor(TOPLEFT, control, TOPLEFT, 5, 0)
	control.title:SetDimensions(BeltalowdaAdmin.config.configWidth, BeltalowdaAdmin.config.configEntrySize * 2 - 5)
	control.title:SetFont(subtitleFont)
	control.title:SetWrapMode(ELLIPSIS)
	control.title:SetColor(BeltalowdaAdmin.config.color.subtitleColor.r, BeltalowdaAdmin.config.color.subtitleColor.g, BeltalowdaAdmin.config.color.subtitleColor.b)
	control.title:SetText(title)
	control.title:SetVerticalAlignment(TEXT_ALIGN_TOP)
	control.title:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	
	
	control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
	control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, -100, BeltalowdaAdmin.config.configEntrySize * 2 - 5) 
	control.texture:SetDimensions(800, 5) 
	control.texture:SetTexture("/esoui/art/miscellaneous/horizontaldivider.dds")
	return control, BeltalowdaAdmin.config.configEntrySize * 2
end

function BeltalowdaAdmin.CreateEquipmentControl(rootControl, equipment, index)
	local size = 0
	if equipment ~= nil then
		size = BeltalowdaAdmin.config.configEntrySize * 4
		local infoSize = BeltalowdaAdmin.config.configEntrySize * 3
		local infoWidth = BeltalowdaAdmin.config.configWidth - size - 2 - 50
		local control = wm:CreateControl(nil, rootControl, CT_CONTROL)
		local controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		
		control:SetDimensions(BeltalowdaAdmin.config.configWidth - 50, size)
		control.eType = equipment.eType
		control.defaultTexture = equipment.texture
		
		control.mainEdge = wm:CreateControl(nil, control, CT_BACKDROP)
		control.mainEdge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.mainEdge:SetDimensions(BeltalowdaAdmin.config.configWidth - 50, size)
		control.mainEdge:SetEdgeTexture(nil, 2, 2, 2, 0)
		control.mainEdge:SetCenterColor(0, 0, 0, 0)
		control.mainEdge:SetEdgeColor(0, 0, 0, 1)
		
		control.imageEdge = wm:CreateControl(nil, control, CT_BACKDROP)
		control.imageEdge:SetAnchor(TOPLEFT, control, TOPLEFT, 6, 6)
		control.imageEdge:SetDimensions(size - 12, size - 12)
		control.imageEdge:SetEdgeTexture(nil, 2, 2, 2, 0)
		control.imageEdge:SetCenterColor(0, 0, 0, 0)
		control.imageEdge:SetEdgeColor(0, 0, 0, 1)
		
		control.textureBackdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.textureBackdrop:SetAlpha(1)
		control.textureBackdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 7, 7)
		control.textureBackdrop:SetDimensions(size - 14, size - 14)
		control.textureBackdrop:SetCenterColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, 0.0)
		control.textureBackdrop:SetEdgeColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, 0.0)	
				
		control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
		control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, 7, 7) 
		control.texture:SetDimensions(size - 14, size - 14)
		control.texture:SetTexture(control.defaultTexture)
		
		control.button = wm:CreateControl(nil, control, CT_BUTTON)
		control.button:EnableMouseButton(MOUSE_BUTTON_INDEX_RIGHT, true)
		control.button:SetMouseEnabled(true)
		control.button:SetAnchor(TOPLEFT, control, TOPLEFT, 7, 7)
		control.button:SetDimensions(size - 14, size - 14)
		control.button:SetHandler("OnMouseEnter", function() BeltalowdaAdmin.EquipmentEntryOnMouseEnter(index) end)
		control.button:SetHandler("OnMouseExit", function() BeltalowdaAdmin.EquipmentEntryOnMouseExit(index) end)
		control.button:SetHandler("OnClicked", function() BeltalowdaAdmin.EquipmentEntryOnClick(index) end)
				
		control.link = wm:CreateControl(nil, control, CT_LABEL)
		control.link:SetAnchor(TOPLEFT, control, TOPLEFT, 2 + (size - 4), 2) 
		control.link:SetDimensions(infoWidth, BeltalowdaAdmin.config.configEntrySize)
		control.link:SetColor(BeltalowdaAdmin.config.color.equipmentDescription.r, BeltalowdaAdmin.config.color.equipmentDescription.g, BeltalowdaAdmin.config.color.equipmentDescription.b)
		control.link:SetFont(controlFont)
		control.link:SetMouseEnabled(true)
		control.link.link = nil
		control.link:SetHandler('OnMouseEnter', function() BeltalowdaAdmin.ShowItemLinkToolTip(control.link, control.link) end)
		control.link:SetHandler('OnMouseExit', function() ClearTooltip(ItemTooltip) end)
		
		control.infoWindow = wm:CreateControl(nil, rootControl, CT_CONTROL)
		control.infoWindow:SetAnchor(TOPLEFT, control, TOPLEFT, 2 + (size - 4), 2)
		control.infoWindow:SetDimensions(infoWidth, infoSize)
		
		control.infoWindow.line1 = wm:CreateControl(nil, control, CT_LABEL)
		control.infoWindow.line1:SetAnchor(TOPLEFT, control, TOPLEFT, 2 + (size - 4), 2 + BeltalowdaAdmin.config.configEntrySize) 
		control.infoWindow.line1:SetDimensions(infoWidth, BeltalowdaAdmin.config.configEntrySize)
		control.infoWindow.line1:SetColor(BeltalowdaAdmin.config.color.equipmentDescription.r, BeltalowdaAdmin.config.color.equipmentDescription.g, BeltalowdaAdmin.config.color.equipmentDescription.b)
		control.infoWindow.line1:SetFont(controlFont)

		control.infoWindow.line2 = wm:CreateControl(nil, control, CT_LABEL)
		control.infoWindow.line2:SetAnchor(TOPLEFT, control, TOPLEFT, 2 + (size - 4), 2 + BeltalowdaAdmin.config.configEntrySize * 2) 
		control.infoWindow.line2:SetDimensions(infoWidth, BeltalowdaAdmin.config.configEntrySize * 2)
		control.infoWindow.line2:SetColor(BeltalowdaAdmin.config.color.equipmentDescription.r, BeltalowdaAdmin.config.color.equipmentDescription.g, BeltalowdaAdmin.config.color.equipmentDescription.b)
		control.infoWindow.line2:SetFont(controlFont)
		
		return control, size
	end
	return nil, size
end

function BeltalowdaAdmin.CreateCPBlock(parent, discipline, width)
	local cpNames = {}
	local size = BeltalowdaAdmin.config.configEntrySize * 5.5
	local titleFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize * 1.5 - 2, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	local controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaAdmin.config.configEntrySize - 6, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(width, size)
	
	control.title = wm:CreateControl(nil, control, CT_LABEL)
	control.title:SetAnchor(TOPLEFT, control, TOPLEFT, 2, 0) 
	control.title:SetDimensions(width, BeltalowdaAdmin.config.configEntrySize * 1.5)
	control.title:SetFont(titleFont)
	control.title:SetText(discipline.text)
	
	control.cpEntries = {}
	control.cpValues = {}
	for i = 1, 4 do
		control.cpEntries[i] = wm:CreateControl(nil, control, CT_LABEL)
		control.cpEntries[i]:SetAnchor(TOPLEFT, control, TOPLEFT, 2, BeltalowdaAdmin.config.configEntrySize * 1.5 + BeltalowdaAdmin.config.configEntrySize * (i - 1))
		control.cpEntries[i]:SetDimensions(width, BeltalowdaAdmin.config.configEntrySize)
		control.cpEntries[i]:SetColor(BeltalowdaAdmin.config.color.cpText.r, BeltalowdaAdmin.config.color.cpText.g, BeltalowdaAdmin.config.color.cpText.b)
		control.cpEntries[i]:SetFont(controlFont)
		control.cpEntries[i]:SetText(discipline.cp[i].text)
		control.cpEntries[i]:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.cpEntries[i]:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		
		control.cpValues[i] = wm:CreateControl(nil, control, CT_LABEL)
		control.cpValues[i]:SetAnchor(TOPLEFT, control, TOPLEFT, 2, BeltalowdaAdmin.config.configEntrySize * 1.5 + BeltalowdaAdmin.config.configEntrySize * (i - 1))
		control.cpValues[i]:SetDimensions(width - 10, BeltalowdaAdmin.config.configEntrySize)
		control.cpValues[i]:SetColor(BeltalowdaAdmin.config.color.cpValue.r, BeltalowdaAdmin.config.color.cpValue.g, BeltalowdaAdmin.config.color.cpValue.b)
		control.cpValues[i]:SetFont(controlFont)
		control.cpValues[i]:SetText("0")
		control.cpValues[i]:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.cpValues[i]:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
		
		cpNames[i] = {}
		cpNames[i].name = BeltalowdaCP.GetCPControlName(discipline.id, i)
		cpNames[i].control = control.cpValues[i]
	end
	
	return control, cpNames, size
end

function BeltalowdaAdmin.CreateSkillControl(parent, size)
	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(size, size)
	
	control.imageEdge = wm:CreateControl(nil, control, CT_BACKDROP)
	control.imageEdge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.imageEdge:SetDimensions(size, size)
	control.imageEdge:SetEdgeTexture(nil, 2, 2, 2, 0)
	control.imageEdge:SetCenterColor(0, 0, 0, 0)
	control.imageEdge:SetEdgeColor(0, 0, 0, 1)
	
	control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
	control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, 1, 1) 
	control.texture:SetDimensions(size - 2, size - 2)
	control.texture:SetTexture("esoui/art/mainmenu/menubar_skills_disabled.dds")
	control.texture:SetMouseEnabled(true)
	control.id = 0
	control.texture:SetHandler('OnMouseEnter', function() BeltalowdaAdmin.ShowSkillToolTip(control.texture) end)
	control.texture:SetHandler('OnMouseExit', function() ClearTooltip(SkillTooltip) end)
	
	return control
end

function BeltalowdaAdmin.ShowSkillToolTip(control)
	--d("show tooltip")
	if control.id ~= nil and control.id ~= 0 then
		InitializeTooltip(SkillTooltip, control, TOPLEFT, -20, 0)
		local skillType, skillIndex, abilityIndex = GetSpecificSkillAbilityKeysByAbilityId(control.id)
		if skillType ~= 0 then
			SkillTooltip:SetSkillAbility(skillType, skillIndex, abilityIndex)
		else
			SkillTooltip:SetSkillLineAbilityId(control.id)
		end
	end
end


function BeltalowdaAdmin.CreateSkillBarControl(parent)
	local size = BeltalowdaAdmin.config.configEntrySize * 4
	local width = size * 6 + 30
	

	local control = wm:CreateControl(nil, parent, CT_CONTROL)
	control:SetDimensions(width, size)
	
	control.mainEdge = wm:CreateControl(nil, control, CT_BACKDROP)
	control.mainEdge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.mainEdge:SetDimensions(width, size)
	control.mainEdge:SetEdgeTexture(nil, 2, 2, 2, 0)
	control.mainEdge:SetCenterColor(0, 0, 0, 0)
	control.mainEdge:SetEdgeColor(0, 0, 0, 1)
	
	local names = {}
	names[1] = "skill1"
	names[2] = "skill2"
	names[3] = "skill3"
	names[4] = "skill4"
	names[5] = "skill5"
	
	for i = 1, #names do
		control[names[i]] = BeltalowdaAdmin.CreateSkillControl(control, size - 12)
		control[names[i]]:SetAnchor(TOPLEFT, control, TOPLEFT, 6 + ((i - 1) * size), 6)
	end
	control.ultimate = BeltalowdaAdmin.CreateSkillControl(control, size - 12)
	control.ultimate:SetAnchor(TOPLEFT, control, TOPLEFT, 6 + 30 + 5 * size, 6)

	
	
	return control, size
end

function BeltalowdaAdmin.AdjustPlayerList()
	local selectedEntry = nil
	if BeltalowdaAdmin.state.selectedIndex ~= nil and BeltalowdaAdmin.state.selectedIndex ~= 0 then
		if BeltalowdaAdmin.state.playerList ~= nil and BeltalowdaAdmin.state.playerList[BeltalowdaAdmin.state.selectedIndex] ~= nil then
			selectedEntry = BeltalowdaAdmin.state.playerList[BeltalowdaAdmin.state.selectedIndex]
		end
	end
	local playerList = BeltalowdaGroup.GetGroupInformation()
	BeltalowdaAdmin.state.selectedIndex = 0
	BeltalowdaAdmin.state.playerList = BeltalowdaAdmin.state.playerList or {}
	BeltalowdaAdmin.state.playerList[1] = {}
	BeltalowdaAdmin.state.playerList[1].displayName = ""
	BeltalowdaAdmin.state.playerList[1].charName = ""
	BeltalowdaAdmin.state.playerList[1].unitTag = ""
	if playerList ~= nil then
		for i = 2, #playerList + 1 do
			BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHidden(false)
			BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetText(playerList[i - 1].name)
			BeltalowdaAdmin.PlayerEntryOnMouseExit(i)
			if selectedEntry ~= nil and selectedEntry.displayName == playerList[i - 1].displayName and selectedEntry.charName == playerList[i - 1].charName then
				BeltalowdaAdmin.PlayerEntryOnClick(i)
			end
			BeltalowdaAdmin.state.playerList[i] = {}
			BeltalowdaAdmin.state.playerList[i].displayName = playerList[i - 1].displayName
			BeltalowdaAdmin.state.playerList[i].charName = playerList[i - 1].charName
			BeltalowdaAdmin.state.playerList[i].unitTag = playerList[i - 1].unitTag
		end
		for i = #playerList + 2, 25 do
			BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHidden(true)
			BeltalowdaAdmin.PlayerEntryOnMouseExit(i)
			BeltalowdaAdmin.state.playerList[i] = nil
		end
	else
		for i = 2, 25 do
			BeltalowdaAdmin.controls.TLW.player.blocks[i]:SetHidden(true)
			BeltalowdaAdmin.PlayerEntryOnMouseExit(i)
			BeltalowdaAdmin.state.playerList[i] = nil
		end
	end
end

function BeltalowdaAdmin.LinkInChat(link)
	link = BeltalowdaEquip.ChangeBrackets(link)
	if link ~= nil then
		local chat = CHAT_SYSTEM.textEntry.editControl
		if chat:HasFocus() == false then 
			StartChatInput() 
		end
		chat:InsertText(link)
	end
end

function BeltalowdaAdmin.ShowItemLinkToolTip(linkControl, control)
	if control.link ~= nil and link ~= "" then
		InitializeTooltip(ItemTooltip, control, TOPLEFT, -468, 0)
		ItemTooltip:SetLink(linkControl.link)
	end
end

function BeltalowdaAdmin.SlashCmd(param)
	if param ~= nil then
		if param[1] == "admin" then
			BeltalowdaAdmin.ToggleAdminInterface()
		end
	end
end

function BeltalowdaAdmin.CreatePlayerContextMenu(index)
	if index ~= nil and index >= 1 and index <= #BeltalowdaAdmin.state.playerList then
		ClearMenu()

		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_ALL, function() BeltalowdaAdmin.RequestAll(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_VERSION, function() BeltalowdaAdmin.RequestVersion(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_CLIENT_CONFIGURATION, function() BeltalowdaAdmin.RequestClientConfiguration(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_ADDON_CONFIGURATION, function() BeltalowdaAdmin.RequestAddOnConfiguration(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_STATS_INFORMATION, function() BeltalowdaAdmin.RequestStatsInformation(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_MUNDUS_INFORMATION, function() BeltalowdaAdmin.RequestMundusInformation(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_SKILLS_INFORMATION, function() BeltalowdaAdmin.RequestSkillsInformation(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_EQUIPMENT_INFORMATION, function() BeltalowdaAdmin.RequestEquipmentInformation(index) end)
		AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_CHAMPION_INFORMATION, function() BeltalowdaAdmin.RequestChampionInformation(index) end)
		--AddCustomMenuItem(BeltalowdaAdmin.constants.player.REQUEST_QUICKSLOTS_INFORMATION, function() BeltalowdaAdmin.RequestQuicksloInformation(index) end)
		
		ShowMenu(BeltalowdaAdmin.controls.TLW.player.blocks[index])
	end
end

function BeltalowdaAdmin.SendAdminRequest(b2, b3, index)
	if b2 ~= nil and b3 ~= nil and index ~= nil and index >= 1 and index <= #BeltalowdaAdmin.state.playerList then
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST
		message.b1 = BeltalowdaAdmin.GetSelectedPlayerId(index)
		message.b2 = b2
		message.b3 = b3
		message.sent = false

		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	end
end

function BeltalowdaAdmin.GetSelectedPlayerId(index)
	local id = 25
	local players = BeltalowdaGroup.GetGroupInformation()
	if players ~= nil and index ~= nil then
		local player = players[index - 1]
		if player ~= nil then
			id = index - 1
		end
	end
	return id
end



function BeltalowdaAdmin.RequestAll(index)
	BeltalowdaAdmin.RequestVersion(index)
	BeltalowdaGroup.RetrieveAdminMundusInformation(BeltalowdaAdmin.GetSelectedPlayerId(index))
	BeltalowdaAdmin.SendAdminRequest(255, 255, index)
end

function BeltalowdaAdmin.RequestEquipmentItem(itemIndex, playerIndex)
	local entry = BeltalowdaAdmin.constants.equipment[itemIndex]
	if entry ~= nil and entry.messagePrefix ~= nil then
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST_EQUIPMENT_INFORMATION
		message.b1 = BeltalowdaAdmin.GetSelectedPlayerId(index)
		message.b2 = 0
		message.b3 = entry.messagePrefix
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	end
end

function BeltalowdaAdmin.RequestVersion(index)
	if index ~= nil and index >= 1 and index <= #BeltalowdaAdmin.state.playerList then
		if BeltalowdaAdmin.state.playerList ~= nil and BeltalowdaAdmin.state.playerList[index] ~= nil then
			--d("Requesting Version Information")
			BeltalowdaVersioning.RequestVersionInformation(BeltalowdaAdmin.state.playerList[index].unitTag)
		else
			BeltalowdaVersioning.RequestVersionInformation(nil) --25
		end
	end
end

function BeltalowdaAdmin.RequestClientConfiguration(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CLIENT_CONFIGURATION, 0, index)
end

function BeltalowdaAdmin.RequestAddOnConfiguration(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_ADDON_CONFIGURATION, 0, index)
end

function BeltalowdaAdmin.RequestEquipmentInformation(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_EQUIPMENT_INFORMATION, 0, index)
end

function BeltalowdaAdmin.RequestChampionInformation(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CHAMPION_INFORMATION, 0, index)
end

function BeltalowdaAdmin.RequestStatsInformation(index)
	--d("requesting stats for " .. index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_STATS_INFORMATION, 0, index)
end

function BeltalowdaAdmin.RequestMundusInformation(index)
	BeltalowdaGroup.RetrieveAdminMundusInformation(BeltalowdaAdmin.GetSelectedPlayerId(index))
end

function BeltalowdaAdmin.RequestSkillsInformation(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_SKILLS_INFORMATION, 0, index)
end

function BeltalowdaAdmin.RequestQuicksloInformation(index)
	BeltalowdaAdmin.SendAdminRequest(BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_QUICKSLOT_INFORMATION, 0, index)
end

function BeltalowdaAdmin.HandleAdminClientConfigurationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	--d("Client Configuration Requested")
	--AOE Configuration
	local cvarTellsEnabled = tonumber(GetCVar("MonsterTellsEnabled"))
	local cvarCustomEnabled = tonumber(GetCVar("MonsterTellsColorSwapEnabled"))
	local cvarEnemyBrightness = tonumber(string.format("%d",GetCVar("MonsterTellsEnemyBrightness")))
	local cvarFriendlyBrightness = tonumber(string.format("%d",GetCVar("MonsterTellsFriendlyBrightness")))
	local cvarB2 = cvarEnemyBrightness
	local cvarB3 = BeltalowdaMath.DecodeBitArrayHelper(cvarFriendlyBrightness)
	cvarB3[7] = cvarTellsEnabled
	cvarB3[8] = cvarCustomEnabled
	cvarB3 = BeltalowdaMath.EncodeBitArrayHelper(cvarB3, 0)
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_AOE
	message.b1 = 0
	message.b2 = cvarB2
	message.b3 = cvarB3
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--Sound Configuration
	local cvarSoundEnable = tonumber(GetCVar("SOUND_ENABLED"))
	local cvarAudioVolume = tonumber(string.format("%d",GetCVar("AUDIO_VOLUME")))
	local cvarUiVolume = tonumber(string.format("%d",GetCVar("UI_VOLUME")))
	local cvarSfxVolume = tonumber(string.format("%d",GetCVar("SFX_VOLUME")))
	local cvarB1 = BeltalowdaMath.DecodeBitArrayHelper(cvarAudioVolume)
	cvarB1[8] = cvarSoundEnable
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_SOUND
	message.b1 = BeltalowdaMath.EncodeBitArrayHelper(cvarB1, 0)
	message.b2 = cvarUiVolume
	message.b3 = cvarSfxVolume
	message.sent = false
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	
	--Graphics Configuration
	local windowMode = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_FULLSCREEN))) --2bit
	local vsync = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_VSYNC)) --1bit
	local antiAliasing = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_ANTI_ALIASING)) --1bit
	local ambient = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_AMBIENT_OCCLUSION)) --1bit
	local bloom = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_BLOOM)) --1bit
	local depthOfField = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_DEPTH_OF_FIELD)) --1bit
	local distortion = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_DISTORTION)) --1bit
	local sunlight = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_GOD_RAYS)) --1bit
	local allyEffects = tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_SHOW_ADDITIONAL_ALLY_EFFECTS)) --1bit
	local viewDistance = BeltalowdaMath.Int24ToArray(tonumber(string.format("%d",(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_VIEW_DISTANCE) * 50)))) --7bit
	local resWidth, resHeight = zo_strsplit("x", GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_RESOLUTION)) --2x 18bit
	resWidth = BeltalowdaMath.Int24ToArray(tonumber(resWidth))
	resHeight = BeltalowdaMath.Int24ToArray(tonumber(resHeight))
	local particleSupressDistance = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_PFX_SUPPRESS_DISTANCE))) --7bit
	local particleMaximum = BeltalowdaMath.Int24ToArray(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_PFX_GLOBAL_MAXIMUM) - 768)) --11bit
	local reflectionQuality = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_REFLECTION_QUALITY))) --2bit -- Water Reflection
	local shadowQuality = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_SHADOWS))) --3bit
	local subSamplingQuality = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_SUB_SAMPLING))) --2bit
	local graphicPresets = BeltalowdaMath.DecodeBitArrayHelper(tonumber(GetSetting(SETTING_TYPE_GRAPHICS, GRAPHICS_SETTING_PRESETS))) --3bit
	
	--81bit => ~4 Messages 
	--Message #1 width (18)
	--Message #2 height (18)
	--Message #3 particleMax (11) + particleSupress (7)
	--Message #4 viewDistance (7) + quality (10)
	
	--message 1
	local messageIdentifier = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_1)
	local bitfield = resWidth
	bitfield = BeltalowdaMath.CopyBitfieldRange(messageIdentifier, bitfield, 3, 1, 22)
	bitfield[19] = windowMode[1]
	bitfield[20] = windowMode[2]
	bitfield[21] = vsync
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	--d(bitfield)
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--message 2
	messageIdentifier = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_2)
	bitfield = resHeight
	bitfield = BeltalowdaMath.CopyBitfieldRange(messageIdentifier, bitfield, 3, 1, 22)
	bitfield[19] = antiAliasing
	bitfield[20] = ambient
	bitfield[21] = bloom
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	--d(bitfield)
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--message 3
	messageIdentifier = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_3)
	bitfield = particleMaximum
	bitfield = BeltalowdaMath.CopyBitfieldRange(messageIdentifier, bitfield, 3, 1, 22)
	bitfield = BeltalowdaMath.CopyBitfieldRange(particleSupressDistance, bitfield, 7, 1, 12)
	bitfield[19] = depthOfField
	bitfield[20] = distortion
	bitfield[21] = sunlight
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	--d(bitfield)
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--message 4
	messageIdentifier = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_4)
	bitfield = viewDistance
	bitfield = BeltalowdaMath.CopyBitfieldRange(messageIdentifier, bitfield, 3, 1, 22)
	bitfield = BeltalowdaMath.CopyBitfieldRange(reflectionQuality, bitfield, 2, 1, 8)
	bitfield = BeltalowdaMath.CopyBitfieldRange(shadowQuality, bitfield, 3, 1, 10)
	bitfield = BeltalowdaMath.CopyBitfieldRange(reflectionQuality, bitfield, 2, 1, 13)
	bitfield = BeltalowdaMath.CopyBitfieldRange(graphicPresets, bitfield, 3, 1, 15)
	bitfield[18] = allyEffects
	bitfield[19] = subSamplingQuality[1]
	bitfield[20] = subSamplingQuality[2]
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	--d(bitfield)
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)	
end

function BeltalowdaAdmin.HandleAdminAddonConfigurationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	--d("Addon Configuration Requested")
	--Crown / debuff overview / rapid tracker / health, damage overview / potion overview
	local crownEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.crown.enabled) -- 1bit
	local crownSize = BeltalowdaMath.Int24ToArray(BeltalowdaAdmin.vars.group.crown.size) --10bit
	local selectedCrown = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.crown.selectedCrown) --5bit
	
	local debuffOverviewEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.dbo.enabled) --1bit
	local rapidTrackerEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.rt.enabled) --1bit
	local hdmEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.hdm.enabled) --1bit
	local hdmWindowEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.hdm.windowEnabled) --1bit
	local hdmViewMode = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.hdm.viewMode) --2bit
	local poEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.po.enabled) --1bit
	local poSoundEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.po.soundEnabled) --1bit
	
	--d(crownSize)
	
	local bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
	bitfield = BeltalowdaMath.CopyBitfieldRange(crownSize, bitfield, 10, 1, 9)
	bitfield = BeltalowdaMath.CopyBitfieldRange(selectedCrown, bitfield, 5, 1, 19)
	bitfield[24] = crownEnabled
	bitfield[1] = hdmViewMode[1]
	bitfield[2] = hdmViewMode[2]
	bitfield[3] = hdmWindowEnabled
	bitfield[4] = hdmEnabled
	bitfield[5] = debuffOverviewEnabled
	bitfield[6] = rapidTrackerEnabled
	bitfield[7] = poSoundEnabled
	bitfield[8] = poEnabled
	
	
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_1
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--ftcv pt.1
	local ftcvEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftcv.enabled) --1bit
	local ftcvMinDistance = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcv.minDistance) --3bit
	local ftcvMaxDistance = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcv.maxDistance) --5bit
	local ftcvSizeClose = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcv.size.close) --7bit
	local ftcvSizeFar = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcv.size.far) --7bit
	
	bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
	bitfield = BeltalowdaMath.CopyBitfieldRange(ftcvMinDistance, bitfield, 3, 1, 22)
	bitfield = BeltalowdaMath.CopyBitfieldRange(ftcvMaxDistance, bitfield, 5, 1, 17)
	bitfield = BeltalowdaMath.CopyBitfieldRange(ftcvSizeClose, bitfield, 7, 1, 9)
	bitfield = BeltalowdaMath.CopyBitfieldRange(ftcvSizeFar, bitfield, 7, 1, 1)
	bitfield[8] = ftcvEnabled
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_2
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	
	--ftcv pt.2 / ftcw
	local ftcvOpacityFar = BeltalowdaAdmin.vars.group.ftcv.opacity.far --7bit
	local ftcvOpacityClose = BeltalowdaAdmin.vars.group.ftcv.opacity.close --7bit
	
	local ftcwEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftcw.enabled) --1bit
	local ftcwDistanceEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftcw.distanceEnabled) --1bit
	local ftcwWarningsEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftcw.warningsEnabled) --1bit
	local ftcwMaxDistance = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcw.maxDistance) --5bit
	
	bitfield = ftcwMaxDistance
	bitfield[6] = ftcwWarningsEnabled
	bitfield[7] = ftcwDistanceEnabled
	bitfield[8] = ftcwEnabled
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_3
	message.b1 = ftcvOpacityFar
	message.b2 = ftcvOpacityClose
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	
	--ftca
	local ftcaEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftca.enabled) --1bit
	local ftcaMaxDistance =  BeltalowdaAdmin.vars.group.ftca.maxDistance --5bit
	local ftcaInterval = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftca.interval) --4bit
	local ftcaThreshold = BeltalowdaAdmin.vars.group.ftca.threshold --5bit
	
	bitfield = ftcaInterval
	bitfield[8] = ftcaEnabled
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_4
	message.b1 = ftcaMaxDistance
	message.b2 = ftcaThreshold
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	
	
	
	--Resource Overview pt.1 
	local roEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.enabled) --1bit
	local roUltimateOverviewEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.ultimateOverviewSettings.enabled) --1bit
	local roClientUltimateEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.clientUltimateSettings.enabled) --1bit
	local roGroupUltimatesEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.groupUltimatesSettings.enabled) --1bit
	local roShowSoftResources = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.showSoftResources) --1bit
	local roSoundEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.soundEnabled) --1bit
	local roGroupSizeDestro = BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeDestro --5bit
	local roGroupSizeStorm = BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeStorm --5bit
	
	bitfield = BeltalowdaMath.CreateEmptyBitfield(8)
	bitfield[1] = roEnabled
	bitfield[2] = roUltimateOverviewEnabled
	bitfield[3] = roClientUltimateEnabled
	bitfield[4] = roGroupUltimatesEnabled
	bitfield[5] = roShowSoftResources
	bitfield[6] = roSoundEnabled
		
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_5
	message.b1 = roGroupSizeDestro
	message.b2 = roGroupSizeStorm
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	
	--Resource Overview pt.2 
	local roGroupSizeNegate = BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeNegate --5bit
	local roGroupSizeNova = BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeNova --5bit
	local roGroupMaxDistance = BeltalowdaAdmin.vars.group.ro.ultimates.maxDistance --5bit
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_6
	message.b1 = roGroupSizeNegate
	message.b2 = roGroupSizeNova
	message.b3 = roGroupMaxDistance
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--yacs, bft, kc, recharger, sm
	local yacsEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.compass.yacs.enabled) --1bit
	local yacsPvpEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.compass.yacs.pvpEnabled) --1bit
	local yacsCombatEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.compass.yacs.combatEnabled) --1bit
	local bftEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.bft.enabled) --1bit
	local bftSoundEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.bft.soundEnabled) --1bit
	local bftSize = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.toolbox.bft.size) --6bit
	local kcEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.kc.enabled) --1bit
	local rechargerEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.recharger.enabled) --1bit
	local smEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sm.enabled) --1bit
	local dtEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.dt.enabled) --1bit
	local clEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.cl.enabled) --1bit
	local csEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.cs.enabled) --1bit
	local gbEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.gb.enabled) --1bit
	local isdpEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.isdp.enabled) --1bit
	local respawnerEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.respawner.enabled) --1bit
	local campEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.camp.enabled) --1bit
	local spEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.enabled) --1bit
	local spMode = BeltalowdaAdmin.vars.toolbox.sp.mode - 1--1bit
	local soEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.so.enabled) --1bit

	bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
	bitfield = BeltalowdaMath.CopyBitfieldRange(bftSize, bitfield, 6, 1, 1)
	bitfield[7] = bftSoundEnabled
	bitfield[8] = bftEnabled
	bitfield[9] = yacsCombatEnabled
	bitfield[10] = yacsPvpEnabled
	bitfield[11] = yacsEnabled
	bitfield[12] = kcEnabled
	bitfield[13] = rechargerEnabled
	bitfield[14] = smEnabled
	bitfield[15] = dtEnabled
	bitfield[16] = clEnabled
	bitfield[17] = csEnabled
	bitfield[18] = gbEnabled
	bitfield[19] = isdpEnabled
	bitfield[20] = respawnerEnabled
	bitfield[21] = campEnabled
	bitfield[22] = spEnabled
	bitfield[23] = spMode
	bitfield[24] = soEnabled
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_7
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--ftcb / ra / caj
	local ftcbEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ftcb.enabled) --1bit
	local ftcbColor = tonumber(string.format("%d",BeltalowdaAdmin.vars.group.ftcb.color.a * 255)) --8bit
	local ftcbSelectedBeam = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ftcb.selectedTexture)--4bit
	local raEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.ra.enabled) --1bit
	local raAllowOverride = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.ra.allowOverride) --1bit
	local cajEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.caj.enabled) --1bit
	
		
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8
	message.b1 = BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_1
	message.b2 = ftcbColor
	ftcbSelectedBeam[5] = raEnabled
	ftcbSelectedBeam[6] = raAllowOverride
	ftcbSelectedBeam[7] = cajEnabled
	ftcbSelectedBeam[8] = ftcbEnabled
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(ftcbSelectedBeam, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	-- crBgTp, sc, Resource Overview pt.3
	local crBgTpEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.charVars.crBgTp.enabled) --1bit
	local scEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.compass.sc.enabled) --1bit
	local roGroupSizeNegateOffensive = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeNegateOffensive) --5bit
	local roGroupSizeNegateCounter = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeNegateCounter) --5bit
	local roGroupsEnabled = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.group.ro.groups.enabled) --1bit
	
	bitfield = BeltalowdaMath.CreateEmptyBitfield(8)
	bitfield[1] = crBgTpEnabled
	bitfield[2] = scEnabled
	bitfield[3] = roGroupSizeNegateOffensive[1]
	bitfield[4] = roGroupSizeNegateOffensive[2]
	bitfield[5] = roGroupSizeNegateOffensive[3]
	bitfield[6] = roGroupSizeNegateOffensive[4]
	bitfield[7] = roGroupSizeNegateOffensive[5]
	bitfield[8] = roGroupsEnabled
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8
	message.b1 = BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_2
	message.b2 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	bitfield = roGroupSizeNegateCounter
	bitfield[6] = 0
	bitfield[7] = 0
	bitfield[8] = 0
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--Resource Overview pt.4, so modes (pt2)
	local roGroupSizeNorthernStorm = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ro.ultimates.groupSizeNorthernStorm) --5bit
	local roGroupSizePermafrost = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.group.ro.ultimates.groupSizePermafrost) --5bit
	local soDisplayMode = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.toolbox.so.displayMode - 1) --3bit
	local soTableMode = BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaAdmin.vars.toolbox.so.tableMode - 1) --3bit
	
	bitfield = roGroupSizeNorthernStorm
	bitfield[6] = soDisplayMode[1]
	bitfield[7] = soDisplayMode[2]
	bitfield[8] = soDisplayMode[3]
	
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8
	message.b1 = BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_3
	message.b2 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	bitfield = roGroupSizePermafrost
	bitfield[6] = soTableMode[1]
	bitfield[7] = soTableMode[2]
	bitfield[8] = soTableMode[3]
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	--sp pt.2
	message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8
	message.b1 = BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_4
	
	bitfield = BeltalowdaMath.CreateEmptyBitfield(8)
	bitfield[1] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.COMBUSTION_SHARD]) --1bit
	bitfield[2] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TALONS]) --1bit
	bitfield[3] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.NOVA]) --1bit
	bitfield[4] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BLOOD_ALTAR]) --1bit
	bitfield[5] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.STANDARD]) --1bit
	bitfield[6] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURGE]) --1bit
	bitfield[7] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.BONE_SHIELD]) --1bit
	bitfield[8] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.FLOOD_CONDUIT]) --1bit
	message.b2 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	bitfield = BeltalowdaMath.CreateEmptyBitfield(8)
	bitfield[1] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.ATRONACH]) --1bit
	bitfield[2] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.TRAPPING_WEBS]) --1bit
	bitfield[3] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.RADIATE]) --1bit
	bitfield[4] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.CONSUMING_DARKNESS]) --1bit
	bitfield[5] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.SOUL_LEECH]) --1bit
	bitfield[6] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.WARDEN_HEALING]) --1bit
	bitfield[7] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.GRAVE_ROBBER]) --1bit
	bitfield[8] = BeltalowdaMath.BooleanToBit(BeltalowdaAdmin.vars.toolbox.sp.blacklist[BeltalowdaSP.constants.SYNERGY_ID.PURE_AGONY]) --1bit
	message.b3 = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	message.sent = false
	
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
end

function BeltalowdaAdmin.SendEquipmentInformationResponse(messagePrefix, slotId, senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	if messagePrefix ~= nil and slotId ~= nil then
		local link = GetItemLink(BAG_WORN, slotId)
		local bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		local messagePrefix = BeltalowdaMath.DecodeBitArrayHelper(messagePrefix)
		bitfield = BeltalowdaMath.CopyBitfieldRange(messagePrefix, bitfield, 4, 1, 21)
		if link ~= nil and link ~= "" then
			local value = GetItemLinkItemId(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 20, 1, 1)
		end
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_1
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
		bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		bitfield = BeltalowdaMath.CopyBitfieldRange(messagePrefix, bitfield, 4, 1, 21)
		if link ~= nil and link ~= "" then
			local value = BeltalowdaEquip.GetItemLinkEnchantmentId(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 20, 1, 1)
		end
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_2
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
		bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		bitfield = BeltalowdaMath.CopyBitfieldRange(messagePrefix, bitfield, 4, 1, 21)
		if link ~= nil and link ~= "" then
			local value = BeltalowdaEquip.GetItemLinkItemQuality(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 1)
			value = BeltalowdaEquip.GetItemLinkEnchantmentQuality(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 11)
		end
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_3
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
		bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		bitfield = BeltalowdaMath.CopyBitfieldRange(messagePrefix, bitfield, 4, 1, 21)
		if link ~= nil and link ~= "" then
			local value = BeltalowdaEquip.GetItemLinkItemLevel(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 1)
			value = BeltalowdaEquip.GetItemLinkEnchantmentLevel(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 11)
		end
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_4
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
		bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		bitfield = BeltalowdaMath.CopyBitfieldRange(messagePrefix, bitfield, 4, 1, 21)
		if link ~= nil and link ~= "" then
			local value = BeltalowdaEquip.GetItemLinkTransmutationId(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 1)
			value = BeltalowdaEquip.GetItemLinkStyleId(link)
			value = BeltalowdaMath.Int24ToArray(value)
			bitfield = BeltalowdaMath.CopyBitfieldRange(value, bitfield, 10, 1, 11)
		end
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_5
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	end
end

function BeltalowdaAdmin.HandleAdminEquipmentInformationRequest(senderTag)
	--armor
	--[[
	--Networking
	--Armor
	idemId: 524288 --20bit
	quality (inc cp): 512 --10bit
	level: 64 --7bit
	entchantment: 524288 --20bit
	quality (inc cp): 512 --10bit
	level: 64 --7bit
	transmutation: 64 --7bit
	--irrelevant stats
	boud: 2
	style: 128
	crafted: 2
	redBorder: 2
	itemHealth: 16384
	
	4 messages
	00000000 00000000 00000000 00000000
	[MESSAGE_TYPE:8bit] [PACKET_ID:4bit] [MESSAGE:20bit]
	MESSAGE_1: [itemid] itemId
	MESSAGE_2: [itemid] enchantmentId
	MESSAGE_3: [itemid] quality | quality
	MESSAGE_4: [itemid] level | level
	MESSAGE_5: [itemid] transmutation
	
	|H1:item:100269:363:50:26588:370:50:0:0:0:0:0:0:0:0:1:5:0:1:0:3040:0|h|h
	]]
	--head, message 1
	for i = 1, #BeltalowdaAdmin.constants.equipment do
		BeltalowdaAdmin.SendEquipmentInformationResponse(BeltalowdaAdmin.constants.equipment[i].messagePrefix, BeltalowdaAdmin.constants.equipment[i].slotId, senderTag)
	end
end

function BeltalowdaAdmin.HandleAdminChampionInformationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	for i = 1, #BeltalowdaAdmin.constants.cpDisciplines do
		local prefix, index = BeltalowdaCP.GetPrefixAndIndex(BeltalowdaAdmin.constants.cpDisciplines[i].id, 1)		
		
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CHAMPION_INFORMATION
		message.b1 = prefix
		message.b2 = GetNumPointsSpentOnChampionSkill(BeltalowdaAdmin.constants.cpDisciplines[i].id, 1)
		message.b3 = GetNumPointsSpentOnChampionSkill(BeltalowdaAdmin.constants.cpDisciplines[i].id, 2)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
		prefix, index = BeltalowdaCP.GetPrefixAndIndex(BeltalowdaAdmin.constants.cpDisciplines[i].id, 3)
		message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CHAMPION_INFORMATION
		message.b1 = prefix
		message.b2 = GetNumPointsSpentOnChampionSkill(BeltalowdaAdmin.constants.cpDisciplines[i].id, 3)
		message.b3 = GetNumPointsSpentOnChampionSkill(BeltalowdaAdmin.constants.cpDisciplines[i].id, 4)
		message.sent = false
		
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
		
	end
end

function BeltalowdaAdmin.SendSimpleStatsInformationResponse(prefix, value)
	local bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
	bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.Int24ToArray(value), bitfield, 20, 1, 1)
	bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.DecodeBitArrayHelper(prefix), bitfield, 4, 1, 21)
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_STATS_INFORMATION
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
	--d(message)
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
end

function BeltalowdaAdmin.HandleAdminStatsInformationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	local magicka = GetPlayerStat(STAT_MAGICKA_MAX, STAT_BONUS_OPTION_APPLY_BONUS) --17bit
	local health = GetPlayerStat(STAT_HEALTH_MAX, STAT_BONUS_OPTION_APPLY_BONUS) --17bit
	local stamina = GetPlayerStat(STAT_STAMINA_MAX, STAT_BONUS_OPTION_APPLY_BONUS) --17bit
	local magickaRecovery = GetPlayerStat(STAT_MAGICKA_REGEN_COMBAT, STAT_BONUS_OPTION_APPLY_BONUS) --14bit
	local healthRecovery = GetPlayerStat(STAT_HEALTH_REGEN_COMBAT, STAT_BONUS_OPTION_APPLY_BONUS) --14bit
	local staminaRecovery = GetPlayerStat(STAT_STAMINA_REGEN_COMBAT, STAT_BONUS_OPTION_APPLY_BONUS) --14bit
	
	local spellDamage = GetPlayerStat(STAT_SPELL_POWER, STAT_BONUS_OPTION_APPLY_BONUS) --14bit
	local weaponDamage = GetPlayerStat(STAT_POWER, STAT_BONUS_OPTION_APPLY_BONUS) --14bit
	local spellPenetration = GetPlayerStat(STAT_SPELL_PENETRATION, STAT_BONUS_OPTION_APPLY_BONUS) --16bit
	local weaponPenetration = GetPlayerStat(STAT_PHYSICAL_PENETRATION, STAT_BONUS_OPTION_APPLY_BONUS) --16bit
	local spellCritical = tonumber(string.format("%.1f", GetCriticalStrikeChance(GetPlayerStat(STAT_SPELL_CRITICAL, STAT_BONUS_OPTION_APPLY_BONUS)))) * 10 --10bit
	local weaponCritical = tonumber(string.format("%.1f", GetCriticalStrikeChance(GetPlayerStat(STAT_CRITICAL_STRIKE, STAT_BONUS_OPTION_APPLY_BONUS)))) * 10 --10bit
	
	local spellResistance = GetPlayerStat(STAT_SPELL_RESIST, STAT_BONUS_OPTION_APPLY_BONUS) --16bit
	local physicalResistance = GetPlayerStat(STAT_PHYSICAL_RESIST, STAT_BONUS_OPTION_APPLY_BONUS) --16bit
	local criticalResistance = GetPlayerStat(STAT_CRITICAL_RESISTANCE, STAT_BONUS_OPTION_APPLY_BONUS) --13bit
	
	--
	
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA, magicka)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH, health)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA, stamina)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA_RECOVERY, magickaRecovery)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH_RECOVERY, healthRecovery)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA_RECOVERY, staminaRecovery)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_DAMAGE, spellDamage)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_DAMAGE, weaponDamage)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_PENETRATION, spellPenetration)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_PENETRATION, weaponPenetration)
	
	local bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
	bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.Int24ToArray(spellCritical), bitfield, 10, 1, 1)
	bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.Int24ToArray(weaponCritical), bitfield, 10, 1, 11)
	bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.DecodeBitArrayHelper(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL), bitfield, 4, 1, 21)
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_STATS_INFORMATION
	message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
	message.sent = false
		
	BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_RESISTANCE, spellResistance)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_PHYSICAL_RESISTANCE, physicalResistance)
	BeltalowdaAdmin.SendSimpleStatsInformationResponse(BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL_RESISTANCE, criticalResistance)

end

function BeltalowdaAdmin.SendAdminSkillsInformationResponse(prefix, value)
	if prefix ~= nil and value ~= nil then
		local bitfield = BeltalowdaMath.CreateEmptyBitfield(24)
		bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.Int24ToArray(prefix), bitfield, 4, 1, 21)
		bitfield = BeltalowdaMath.CopyBitfieldRange(BeltalowdaMath.Int24ToArray(value), bitfield, 20, 1, 1)
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_SKILLS_INFORMATION
		message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeBitArrayToMessage(bitfield)
		message.sent = false
			
		BeltalowdaNetworking.SendAdminMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
	end
end

function BeltalowdaAdmin.HandleAdminSkillsInformationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
	local bars = BeltalowdaSB.GetSkillBars()
	if bars[1] ~= nil then
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_1, bars[1][1])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_2, bars[1][2])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_3, bars[1][3])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_4, bars[1][4])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_5, bars[1][5])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_1_ULTIMATE, bars[1][6])
	end
	if bars[2] ~= nil then
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_1, bars[2][1])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_2, bars[2][2])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_3, bars[2][3])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_4, bars[2][4])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_5, bars[2][5])
		BeltalowdaAdmin.SendAdminSkillsInformationResponse(BeltalowdaSB.constants.networking.messagePrefix.BAR_2_ULTIMATE, bars[2][6])
	end
end

function BeltalowdaAdmin.HandleAdminQuickslotInformationRequest(senderTag)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(senderTag)) then
		else
			return
		end
	end
end

function BeltalowdaAdmin.HandleAdminRequest(b2, b3, senderTag)
	if b2 ~= nil and b3 ~= nil then
		--d(b2)
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CLIENT_CONFIGURATION) then
			BeltalowdaAdmin.HandleAdminClientConfigurationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_ADDON_CONFIGURATION) then
			BeltalowdaAdmin.HandleAdminAddonConfigurationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_STATS_INFORMATION) then
			BeltalowdaAdmin.HandleAdminStatsInformationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_SKILLS_INFORMATION) then
			BeltalowdaAdmin.HandleAdminSkillsInformationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_EQUIPMENT_INFORMATION) then
			BeltalowdaAdmin.HandleAdminEquipmentInformationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_CHAMPION_INFORMATION) then
			BeltalowdaAdmin.HandleAdminChampionInformationRequest(senderTag)
		end
		if BeltalowdaMath.IsBitFieldPresent(b2, BeltalowdaAdmin.constants.requests.ADMIN_REQUEST_B2_QUICKSLOT_INFORMATION) then
			BeltalowdaAdmin.HandleAdminQuickslotInformationRequest(senderTag)
		end
	end
end

function BeltalowdaAdmin.HandleEquipmentRequest(messagePrefix, senderTag)
	if messagePrefix ~= nil then
		for i = 1, #BeltalowdaAdmin.constants.equipment do
			if BeltalowdaAdmin.constants.equipment[i].messagePrefix == messagePrefix then
				local slotId = BeltalowdaAdmin.constants.equipment[i].slotId
				BeltalowdaAdmin.SendEquipmentInformationResponse(messagePrefix, slotId, senderTag)
				break
			end
		end
	end
end

function BeltalowdaAdmin.ToggleAdminInterface()
	if BeltalowdaRoster.IsGuildOfficer(GetUnitDisplayName("player")) then
		BeltalowdaAdmin.controls.TLW:SetHidden(not BeltalowdaAdmin.controls.TLW:IsHidden())
		if BeltalowdaAdmin.controls.TLW:IsHidden() == false then
			BeltalowdaGroup.AddGroupChangedCallback(BeltalowdaAdmin.callbackName, BeltalowdaAdmin.AdjustPlayerList)
			BeltalowdaGroup.AddAdminInformationChangedCallback(BeltalowdaAdmin.callbackName, BeltalowdaAdmin.AdjustAdminInformation)
		else
			BeltalowdaGroup.RemoveGroupChangedCallback(BeltalowdaAdmin.callbackName)
			BeltalowdaGroup.RemoveAdminInformationChangedCallback(BeltalowdaAdmin.callbackName)
		end
		SetGameCameraUIMode(not BeltalowdaAdmin.controls.TLW:IsHidden())
		BeltalowdaAdmin.AdjustPlayerList()
	end
end

function BeltalowdaAdmin.PopulateConfigPanel(configData)
	local rootControl = BeltalowdaAdmin.controls.TLW.config.scrollPanel
	
	--player
	local player = rootControl.player
	
	player.displayName:SetText(string.format(BeltalowdaAdmin.constants.config.PLAYER_DISPLAYNAME_STRING, configData.player.displayNameColor, configData.player.displayName))
	player.charName:SetText(string.format(BeltalowdaAdmin.constants.config.PLAYER_CHARNAME_STRING, configData.player.charNameColor, configData.player.charName))
	player.version:SetText(string.format(BeltalowdaAdmin.constants.config.PLAYER_VERSION_STRING, configData.player.versionColor, configData.player.version.major, configData.player.version.minor, configData.player.version.revision))

	--client
	local client = rootControl.client
	---aoe
	local aoe = client.aoe
	aoe.tellsEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_AOE_TELLS_ENABLED_STRING, configData.client.aoe.tellsEnabledColor, configData.client.aoe.tellsEnabled))
	aoe.customColorsEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENABLED_STRING, configData.client.aoe.customEnabledColor, configData.client.aoe.customEnabled))
	aoe.friendlyBrightness:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_FRIENDLY_BRIGHTNESS, configData.client.aoe.friendlyBrightnessColor, configData.client.aoe.friendlyBrightness))
	aoe.enemyBrightness:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENEMY_BRIGHTNESS, configData.client.aoe.enemyBrightnessColor, configData.client.aoe.enemyBrightness))
	
	---sound
	local sound = client.sound
	sound.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_SOUND_ENABLED_STRING, configData.client.sound.enabledColor, configData.client.sound.enabled))
	sound.audioVolume:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_SOUND_AUDIO_VOLUME, configData.client.sound.audioVolumeColor, configData.client.sound.audioVolume))
	sound.uiVolume:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_UI_AUDIO_VOLUME, configData.client.sound.uiVolumeColor, configData.client.sound.uiVolume))
	sound.sfxVolume:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_SFX_AUDIO_VOLUME, configData.client.sound.sfxVolumeColor, configData.client.sound.sfxVolume))
	
	---graphics
	local graphics = client.graphics
	graphics.resolution:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_RESOLUTION_STRING, configData.client.graphics.resolutionColor, configData.client.graphics.resWidth, configData.client.graphics.resHeight))
	graphics.windowMode:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_WINDOW_MODE_STRING, configData.client.graphics.windowModeColor, configData.client.graphics.windowMode))
	graphics.vsync:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VSYNC_STRING, configData.client.graphics.vsyncColor, configData.client.graphics.vsync))
	graphics.antiAliasing:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ANTI_ALIASING_STRING, configData.client.graphics.antiAliasingColor, configData.client.graphics.antiAliasing))
	graphics.ambient:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_AMBIENT_STRING, configData.client.graphics.ambientColor, configData.client.graphics.ambient))
	graphics.bloom:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_BLOOM_STRING, configData.client.graphics.bloomColor, configData.client.graphics.bloom))
	graphics.depthOfField:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DEPTH_OF_FIELD_STRING, configData.client.graphics.depthOfFieldColor, configData.client.graphics.depthOfField))
	graphics.distortion:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DISTORTION_STRING, configData.client.graphics.distortionColor, configData.client.graphics.distortion))
	graphics.sunlight:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUNLIGHT_STRING, configData.client.graphics.sunlightColor, configData.client.graphics.sunlight))
	graphics.allyEffects:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ALLY_EFFECTS_STRING, configData.client.graphics.allyEffectsColor, configData.client.graphics.allyEffects))
	graphics.viewDistance:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VIEW_DISTANCE_STRING, configData.client.graphics.viewDistanceColor, configData.client.graphics.viewDistance))
	graphics.particleMaximum:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_MAXIMUM_STRING, configData.client.graphics.particleMaximumColor, configData.client.graphics.particleMaximum))
	graphics.particleSupress:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_SUPRESSION_DISTANCE_STRING, configData.client.graphics.particleSupressDistanceColor, configData.client.graphics.particleSupressDistance))
	graphics.reflectionQuality:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_REFLECTION_QUALITY_STRING, configData.client.graphics.reflectionQualityColor, configData.client.graphics.reflectionQuality))
	graphics.shadowQuality:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SHADOW_QUALITY_STRING, configData.client.graphics.shadowQualityColor, configData.client.graphics.shadowQuality))
	graphics.subSamplingQuality:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBSAMPLING_QUALITY_STRING, configData.client.graphics.subSamplingQualityColor, configData.client.graphics.subSamplingQuality))
	graphics.graphicPresets:SetText(string.format(BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_GRAPHIC_PRESETS_STRING, configData.client.graphics.graphicPresetsColor, configData.client.graphics.graphicPresets))
	
	--addon
	local addon = rootControl.addon
	---crown
	local crown = addon.crown
	crown.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CROWN_ENABLED_STRING, configData.addon.crown.enabledColor, configData.addon.crown.enabled))
	crown.size:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CROWN_SIZE_STRING, configData.addon.crown.sizeColor, configData.addon.crown.size))
	crown.selectedCrown:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CROWN_SELECTED_CROWN_STRING, configData.addon.crown.selectedCrownColor, configData.addon.crown.selectedCrown))
	
	---ftcv
	local ftcv = addon.ftcv
	ftcv.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_ENABLED_STRING, configData.addon.ftcv.enabledColor, configData.addon.ftcv.enabled))
	ftcv.sizeFar:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_FAR_STRING, configData.addon.ftcv.sizeFarColor, configData.addon.ftcv.sizeFar))
	ftcv.sizeClose:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_CLOSE_STRING, configData.addon.ftcv.sizeCloseColor, configData.addon.ftcv.sizeClose))
	ftcv.opacityFar:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_FAR_STRING, configData.addon.ftcv.opacityFarColor, configData.addon.ftcv.opacityFar))
	ftcv.opacityClose:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_CLOSE_STRING, configData.addon.ftcv.opacityCloseColor, configData.addon.ftcv.opacityClose))
	ftcv.minDistance:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_MIN_DISTANCE_STRING, configData.addon.ftcv.minDistanceColor, configData.addon.ftcv.minDistance))
	ftcv.maxDistance:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCV_MAX_DISTANCE_STRING, configData.addon.ftcv.maxDistanceColor, configData.addon.ftcv.maxDistance))
	
	---ftcw
	local ftcw = addon.ftcw
	ftcw.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCW_ENABLED_STRING, configData.addon.ftcw.enabledColor, configData.addon.ftcw.enabled))
	ftcw.distanceEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCW_DISTANCE_ENABLED_STRING, configData.addon.ftcw.distanceEnabledColor, configData.addon.ftcw.distanceEnabled))
	ftcw.warningsEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCW_WARNINGS_ENABLED_STRING, configData.addon.ftcw.warningEnabledColor, configData.addon.ftcw.warningEnabled))
	ftcw.maxDistance:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCW_MAX_DISTANCE_STRING, configData.addon.ftcw.maxDistanceColor, configData.addon.ftcw.maxDistance))
	
	---ftca
	local ftca = addon.ftca
	ftca.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCA_ENABLED_STRING, configData.addon.ftca.enabledColor, configData.addon.ftca.enabled))
	ftca.maxDistance:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCA_MAX_DISTANCE_STRING, configData.addon.ftca.maxDistanceColor, configData.addon.ftca.maxDistance))
	ftca.interval:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCA_INTERVAL_STRING, configData.addon.ftca.intervalColor, configData.addon.ftca.interval))
	ftca.threshold:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCA_THRESHOLD_STRING, configData.addon.ftca.thresholdColor, configData.addon.ftca.threshold))
	
	--ftcb
	local ftcb = addon.ftcb
	ftcb.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCB_ENABLED_STRING, configData.addon.ftcb.enabledColor, configData.addon.ftcb.enabled))
	ftcb.selectedBeam:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCB_SELECTED_BEAM_STRING, configData.addon.ftcb.selectedBeamColor, configData.addon.ftcb.selectedBeam))
	ftcb.alpha:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_FTCB_ALPHA_STRING, configData.addon.ftcb.alphaColor, configData.addon.ftcb.alpha))
	
	
	---dbo
	local dbo = addon.dbo
	dbo.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_DBO_ENABLED_STRING, configData.addon.dbo.enabledColor, configData.addon.dbo.enabled))
	
	---rt
	local rt = addon.rt
	rt.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RT_ENABLED_STRING, configData.addon.rt.enabledColor, configData.addon.rt.enabled))
		
	---ro
	local ro = addon.ro
	ro.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_ENABLED_STRING, configData.addon.ro.enabledColor, configData.addon.ro.enabled))
	ro.ultimateOverviewEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_ULTIMATE_OVERVIEW_ENABLED_STRING, configData.addon.ro.ultimateOverviewEnabledColor, configData.addon.ro.ultimateOverviewEnabled))
	ro.clientGroupEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_CLIENT_GROUP_ENABLED_STRING, configData.addon.ro.clientUltimateEnabledColor, configData.addon.ro.clientUltimateEnabled))
	ro.groupUltimateEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_ULTIMATE_ENABLED_STRING, configData.addon.ro.groupUltimatesEnabledColor, configData.addon.ro.groupUltimatesEnabled))
	ro.showSoftResources:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_SHOW_SOFT_RESOURCES_STRING, configData.addon.ro.showSoftResourcesColor, configData.addon.ro.showSoftResources))
	ro.soundEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_SOUND_ENABLED_STRING, configData.addon.ro.soundEnabledColor, configData.addon.ro.soundEnabled))
	ro.maxDistance:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_MAX_DISTANCE_STRING, configData.addon.ro.maxDistanceColor, configData.addon.ro.maxDistance))
	ro.groupSizeDestro:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_DESTRO_STRING, configData.addon.ro.groupSizeDestroColor, configData.addon.ro.groupSizeDestro))
	ro.groupSizeStorm:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_STORM_STRING, configData.addon.ro.groupSizeStormColor, configData.addon.ro.groupSizeStorm))
	ro.groupSizeNorthernStorm:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NORTHERNSTORM_STRING, configData.addon.ro.groupSizeNorthernStormColor, configData.addon.ro.groupSizeNorthernStorm))
	ro.groupSizePermafrost:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_PERMAFROST_STRING, configData.addon.ro.groupSizePermafrostColor, configData.addon.ro.groupSizePermafrost))
	ro.groupSizeNegate:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_STRING, configData.addon.ro.groupSizeNegateColor, configData.addon.ro.groupSizeNegate))
	ro.groupSizeNegateOffensive:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_OFFENSIVE_STRING, configData.addon.ro.groupSizeNegateOffensiveColor, configData.addon.ro.groupSizeNegateOffensive))
	ro.groupSizeNegateCounter:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_COUNTER_STRING, configData.addon.ro.groupSizeNegateCounterColor, configData.addon.ro.groupSizeNegateCounter))
	ro.groupSizeNova:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NOVA_STRING, configData.addon.ro.groupSizeNovaColor, configData.addon.ro.groupSizeNova))
	ro.groupsEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RO_GROUPS_ENABLED_STRING, configData.addon.ro.groupsEnabledColor, configData.addon.ro.groupsEnabled))
	
	---hdm
	local hdm = addon.hdm
	hdm.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_HDM_ENABLED_STRING, configData.addon.hdm.enabledColor, configData.addon.hdm.enabled))
	hdm.windowEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_HDM_WINDOW_ENABLED_STRING, configData.addon.hdm.windowEnabledColor, configData.addon.hdm.windowEnabled))
	hdm.viewMode:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_HDM_VIEW_MODE_STRING, configData.addon.hdm.viewModeColor, configData.addon.hdm.viewMode))
		
	---po
	local po = addon.po
	po.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_PO_ENABLED_STRING, configData.addon.po.enabledColor, configData.addon.po.enabled))
	po.soundEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_PO_SOUND_ENABLED_STRING, configData.addon.po.soundEnabledColor, configData.addon.po.soundEnabled))
	
	---dt
	local dt = addon.dt
	dt.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_DT_ENABLED_STRING, configData.addon.dt.enabledColor, configData.addon.dt.enabled))
	
	---gb
	local gb = addon.gb
	gb.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_GB_ENABLED_STRING, configData.addon.gb.enabledColor, configData.addon.gb.enabled))
	
	---isdp
	local isdp = addon.isdp
	isdp.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_DT_ENABLED_STRING, configData.addon.isdp.enabledColor, configData.addon.isdp.enabled))
	
	
	---yacs
	local yacs = addon.yacs
	yacs.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_YACS_ENABLED_STRING, configData.addon.yacs.enabledColor, configData.addon.yacs.enabled))
	yacs.pvpEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_YACS_PVP_ENABLED_STRING, configData.addon.yacs.pvpEnabledColor, configData.addon.yacs.pvpEnabled))
	yacs.combatEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_YACS_COMBAT_ENABLED_STRING, configData.addon.yacs.combatEnabledColor, configData.addon.yacs.combatEnabled))
	
	---sc
	local sc = addon.sc
	sc.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SC_ENABLED_STRING, configData.addon.sc.enabledColor, configData.addon.sc.enabled))
	
	---sm
	local sm = addon.sm
	sm.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SM_ENABLED_STRING, configData.addon.sm.enabledColor, configData.addon.sm.enabled))
	
	---recharger
	local recharger = addon.recharger
	recharger.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RECHARGER_ENABLED_STRING, configData.addon.recharger.enabledColor, configData.addon.recharger.enabled))
	
	---kc
	if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true then
		local kc = addon.kc
		kc.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_KC_ENABLED_STRING, configData.addon.kc.enabledColor, configData.addon.kc.enabled))
	end
	
	---bft
	local bft = addon.bft
	bft.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_BFT_ENABLED_STRING, configData.addon.bft.enabledColor, configData.addon.bft.enabled))
	bft.soundEnabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_BFT_SOUND_ENABLED_STRING, configData.addon.bft.soundEnabledColor, configData.addon.bft.soundEnabled))
	bft.size:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_BFT_SIZE_STRING, configData.addon.bft.sizeColor, configData.addon.bft.size))
	
	--cl
	local cl = addon.cl
	cl.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CL_ENABLED_STRING, configData.addon.cl.enabledColor, configData.addon.cl.enabled))
	
	--cs
	local cs = addon.cs
	cs.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING, configData.addon.cs.enabledColor, configData.addon.cs.enabled))
	
	--respawner
	local respawner = addon.respawner
	respawner.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING, configData.addon.respawner.enabledColor, configData.addon.respawner.enabled))
	
	--camp
	local camp = addon.camp
	camp.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING, configData.addon.camp.enabledColor, configData.addon.camp.enabled))
	
	--sp
	local sp = addon.sp
	sp.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_ENABLED_STRING, configData.addon.sp.enabledColor, configData.addon.sp.enabled))
	sp.mode:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_MODE_STRING, configData.addon.sp.modeColor, configData.addon.sp.mode))
	sp.preventCombustionShards:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_COMBUSTION_SHARD, configData.addon.sp.preventCombustionShardsColor, configData.addon.sp.preventCombustionShards))
	sp.preventTalons:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_TALONS, configData.addon.sp.preventTalonsColor, configData.addon.sp.preventTalons))
	sp.preventNova:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_NOVA, configData.addon.sp.preventNovaColor, configData.addon.sp.preventNova))
	sp.preventAltar:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_BLOOD_ALTAR, configData.addon.sp.preventAltarColor, configData.addon.sp.preventAltar))
	sp.preventStandard:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_STANDARD, configData.addon.sp.preventStandardColor, configData.addon.sp.preventStandard))
	sp.preventRitual:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_PURGE, configData.addon.sp.preventRitualColor, configData.addon.sp.preventRitual))
	sp.preventBoneShield:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_BONE_SHIELD, configData.addon.sp.preventBoneShieldColor, configData.addon.sp.preventBoneShield))
	sp.preventConduit:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_FLOOD_CONDUIT, configData.addon.sp.preventConduitColor, configData.addon.sp.preventConduit))
	sp.preventAtronach:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_ATRONACH, configData.addon.sp.preventAtronachColor, configData.addon.sp.preventAtronach))
	sp.preventTrappingWebs:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_TRAPPING_WEBS, configData.addon.sp.preventTrappingWebsColor, configData.addon.sp.preventTrappingWebs))
	sp.preventRadiate:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_RADIATE, configData.addon.sp.preventRadiateColor, configData.addon.sp.preventRadiate))
	sp.preventConsumingDarkness:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_CONSUMING_DARKNESS, configData.addon.sp.preventConsumingDarknessColor, configData.addon.sp.preventConsumingDarkness))
	sp.preventSoulLeech:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_SOUL_LEECH, configData.addon.sp.preventSoulLeechColor, configData.addon.sp.preventSoulLeech))
	sp.preventHealingSeed:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_WARDEN_HEALING, configData.addon.sp.preventHealingSeedColor, configData.addon.sp.preventHealingSeed))
	sp.preventGraveRobber:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_GRAVE_ROBBER, configData.addon.sp.preventGraveRobberColor, configData.addon.sp.preventGraveRobber))
	sp.preventPureAgony:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING, BeltalowdaMenu.constants.SP_SYNERGY_PURE_AGONY, configData.addon.sp.preventPureAgonyColor, configData.addon.sp.preventPureAgony))
	
	--so
	local so = addon.so
	so.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SO_ENABLED_STRING, configData.addon.so.enabledColor, configData.addon.so.enabled))
	so.tableMode:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SO_TABLE_MODE_STRING, configData.addon.so.tableModeColor, configData.addon.so.tableMode))
	so.displayMode:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_SO_DISPLAY_MODE_STRING, configData.addon.so.displayModeColor, configData.addon.so.displayMode))
	
	--ra
	local ra = addon.ra
	ra.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RA_ENABLED_STRING, configData.addon.ra.enabledColor, configData.addon.ra.enabled))
	ra.allowOverride:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_RA_ALLOW_OVERRIDE_STRING, configData.addon.ra.allowOverrideColor, configData.addon.ra.allowOverride))
	
	--caj
	local caj = addon.caj
	caj.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CAJ_ENABLED_STRING, configData.addon.caj.enabledColor, configData.addon.caj.enabled))
	
	--crBgTp
	local crBgTp = addon.crBgTp
	crBgTp.enabled:SetText(string.format(BeltalowdaAdmin.constants.config.ADDON_CRBGTP_ENABLED_STRING, configData.addon.crBgTp.enabledColor, configData.addon.crBgTp.enabled))
	
	
	--stats
	local stats = rootControl.stats
	stats.magicka:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_MAGICKA_STRING, configData.stats.magickaColor, configData.stats.magicka))
	stats.health:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_HEALTH_STRING, configData.stats.healthColor, configData.stats.health))
	stats.stamina:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_STAMINA_STRING, configData.stats.staminaColor, configData.stats.stamina))
	stats.magickaRecovery:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_MAGICKA_RECOVERY_STRING, configData.stats.magickaRecoveryColor, configData.stats.magickaRecovery))
	stats.healthRecovery:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_HEALTH_RECOVERY_STRING, configData.stats.healthRecoveryColor, configData.stats.healthRecovery))
	stats.staminaRecovery:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_STAMINA_RECOVERY_STRING, configData.stats.staminaRecoveryColor, configData.stats.staminaRecovery))
	stats.spellDamage:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_SPELL_DAMAGE_STRING, configData.stats.spellDamageColor, configData.stats.spellDamage))
	stats.weaponDamage:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_WEAPON_DAMAGE_STRING, configData.stats.weaponDamageColor, configData.stats.weaponDamage))
	stats.spellPenetration:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_SPELL_PENETRATION_STRING, configData.stats.spellPenetrationColor, configData.stats.spellPenetration))
	stats.weaponPenetration:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_WEAPON_PENETRATION_STRING, configData.stats.weaponPenetrationColor, configData.stats.weaponPenetration))
	stats.spellCritical:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_SPELL_CRITICAL_STRING, configData.stats.spellCriticalColor, configData.stats.spellCritical))
	stats.weaponCritical:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_WEAPON_CRITICAL_STRING, configData.stats.weaponCriticalColor, configData.stats.weaponCritical))
	stats.spellResistance:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_SPELL_RESISTANCE_STRING, configData.stats.spellResistanceColor, configData.stats.spellResistance))
	stats.physicalResistance:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_PHYSICAL_RESISTANCE_STRING, configData.stats.physicalResistanceColor, configData.stats.physicalResistance))
	stats.criticalResistance:SetText(string.format(BeltalowdaAdmin.constants.config.STATS_CRITICAL_RESISTANCE_STRING, configData.stats.criticalResistanceColor, configData.stats.criticalResistance))
	
	--mundus
	local mundus = rootControl.mundus
	mundus.stone1:SetText(string.format(BeltalowdaAdmin.constants.config.MUNDUS_STONE_1_STRING, configData.mundus.stone1Color, configData.mundus.stone1))
	mundus.stone2:SetText(string.format(BeltalowdaAdmin.constants.config.MUNDUS_STONE_2_STRING, configData.mundus.stone2Color, configData.mundus.stone2))
	
	--cp
	local cpControl = rootControl.cp.cpValues
	for key, value in pairs(configData.cp) do 
		cpControl[key]:SetText(value)
	end

	--skills
	local bar1 = rootControl.skills.bar1
	local bar2 = rootControl.skills.bar2
	bar1.skill1.texture:SetTexture(configData.skills[1].texture)
	bar1.skill1.texture.id = configData.skills[1].id
	bar1.skill2.texture:SetTexture(configData.skills[2].texture)
	bar1.skill2.texture.id = configData.skills[2].id
	bar1.skill3.texture:SetTexture(configData.skills[3].texture)
	bar1.skill3.texture.id = configData.skills[3].id
	bar1.skill4.texture:SetTexture(configData.skills[4].texture)
	bar1.skill4.texture.id = configData.skills[4].id
	bar1.skill5.texture:SetTexture(configData.skills[5].texture)
	bar1.skill5.texture.id = configData.skills[5].id
	bar1.ultimate.texture:SetTexture(configData.skills[6].texture)
	bar1.ultimate.texture.id = configData.skills[6].id
	bar2.skill1.texture:SetTexture(configData.skills[7].texture)
	bar2.skill1.texture.id = configData.skills[7].id
	bar2.skill2.texture:SetTexture(configData.skills[8].texture)
	bar2.skill2.texture.id = configData.skills[8].id
	bar2.skill3.texture:SetTexture(configData.skills[9].texture)
	bar2.skill3.texture.id = configData.skills[9].id
	bar2.skill4.texture:SetTexture(configData.skills[10].texture)
	bar2.skill4.texture.id = configData.skills[10].id
	bar2.skill5.texture:SetTexture(configData.skills[11].texture)
	bar2.skill5.texture.id = configData.skills[11].id
	bar2.ultimate.texture:SetTexture(configData.skills[12].texture)
	bar2.ultimate.texture.id = configData.skills[12].id
	
	--equipment
	local equipment = rootControl.equipment
	for i = 1, #BeltalowdaAdmin.constants.equipment do
		local name = BeltalowdaAdmin.constants.equipment[i].name
		local equipmentControl = equipment[name]
		if name ~= nil and equipmentControl ~= nil then
			equipmentControl.texture:SetTexture(configData.equipment[name].texture)
			equipmentControl.link:SetText(configData.equipment[name].link)
			equipmentControl.link.link = configData.equipment[name].link
			equipmentControl.infoWindow.line1:SetText(configData.equipment[name].line1)
			equipmentControl.infoWindow.line2:SetText(configData.equipment[name].line2)
		else
			equipmentControl.link.link = nil
		end
	end
end

function BeltalowdaAdmin.CreateDefaultDataTemplate()
	local template = {}
	
	--player
	template.player = {}
	template.player.displayName = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.player.displayNameColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.player.charName = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.player.charNameColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.player.version = {}
	template.player.version.minor = BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
	template.player.version.major = BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
	template.player.version.revision = BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
	template.player.versionColor = BeltalowdaAdmin.config.configWindow.rating.fail
	
	--client
	template.client = {}
	---aoe
	template.client.aoe = {}
	template.client.aoe.tellsEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.aoe.tellsEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.aoe.customEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.aoe.customEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.aoe.friendlyBrightness = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.aoe.friendlyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.aoe.enemyBrightness = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.aoe.enemyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	---sounds
	template.client.sound = {}
	template.client.sound.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.sound.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.sound.audioVolume = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.sound.audioVolumeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.sound.uiVolume = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.sound.uiVolumeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.sound.sfxVolume = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.sound.sfxVolumeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	---graphics
	template.client.graphics = {}
	template.client.graphics.windowMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.windowModeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.vsync = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.vsyncColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.antiAliasing = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.antiAliasingColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.ambient = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.ambientColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.bloom = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.bloomColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.depthOfField = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.depthOfFieldColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.distortion = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.distortionColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.sunlight = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.sunlightColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.allyEffects = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.allyEffectsColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.viewDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.viewDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.resWidth = BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
	template.client.graphics.resHeight = BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
	template.client.graphics.resolutionColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.particleSupressDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.particleSupressDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.particleMaximum = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.particleMaximumColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.reflectionQuality = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.reflectionQualityColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.shadowQuality = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.shadowQualityColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.subSamplingQuality = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.subSamplingQualityColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.client.graphics.graphicPresets = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.client.graphics.graphicPresetsColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--addon
	template.addon = {}
	--crown
	template.addon.crown = {}
	template.addon.crown.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.crown.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.crown.size = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.crown.sizeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.crown.selectedCrown = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.crown.selectedCrownColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--ftcv
	template.addon.ftcv = {}
	template.addon.ftcv.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.minDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.minDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.maxDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.sizeClose = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.sizeCloseColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.sizeFar = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.sizeFarColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.opacityClose = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.opacityCloseColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcv.opacityFar = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcv.opacityFarColor = BeltalowdaAdmin.config.configWindow.rating.neutral
		
	--ftcw
	template.addon.ftcw = {}
	template.addon.ftcw.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcw.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcw.distanceEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcw.distanceEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcw.warningEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcw.warningEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcw.maxDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcw.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--ftca
	template.addon.ftca = {}
	template.addon.ftca.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftca.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftca.maxDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftca.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftca.interval = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftca.intervalColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftca.threshold = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftca.thresholdColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--ftca
	template.addon.ftcb = {}
	template.addon.ftcb.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcb.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcb.selectedBeam = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcb.selectedBeamColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ftcb.alpha = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ftcb.alphaColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--dbo
	template.addon.dbo = {}
	template.addon.dbo.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.dbo.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--rt
	template.addon.rt = {}
	template.addon.rt.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.rt.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--ro
	template.addon.ro = {}
	template.addon.ro.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.ultimateOverviewEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.ultimateOverviewEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.clientUltimateEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.clientUltimateEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupUltimatesEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupUltimatesEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.showSoftResources = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.showSoftResourcesColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.soundEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.soundEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeDestro = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeDestroColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeStorm = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeStormColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeNorthernStorm = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeNorthernStormColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizePermafrost = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizePermafrostColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeNegate = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeNegateColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeNegateOffensive = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeNegateOffensiveColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeNegateCounter = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeNegateCounterColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupSizeNova = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupSizeNovaColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.maxDistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ro.groupsEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ro.groupsEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--hdm
	template.addon.hdm = {}
	template.addon.hdm.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.hdm.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.hdm.windowEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.hdm.windowEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.hdm.viewMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.hdm.viewModeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--po
	template.addon.po = {}
	template.addon.po.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.po.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.po.soundEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.po.soundEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--dt
	template.addon.dt = {}
	template.addon.dt.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.dt.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--gb
	template.addon.gb = {}
	template.addon.gb.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.gb.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--isdp
	template.addon.isdp = {}
	template.addon.isdp.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.isdp.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral

	--yacs
	template.addon.yacs = {}
	template.addon.yacs.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.yacs.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.yacs.pvpEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.yacs.pvpEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.yacs.combatEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.yacs.combatEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--sc
	template.addon.sc = {}
	template.addon.sc.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sc.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--sm
	template.addon.sm = {}
	template.addon.sm.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sm.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--recharger
	template.addon.recharger = {}
	template.addon.recharger.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.recharger.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--kc
	template.addon.kc = {}
	template.addon.kc.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.kc.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--bft
	template.addon.bft = {}
	template.addon.bft.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.bft.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.bft.soundEnabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.bft.soundEnabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.bft.size = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.bft.sizeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--cl
	template.addon.cl = {}
	template.addon.cl.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.cl.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--cs
	template.addon.cs = {}
	template.addon.cs.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.cs.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--respawner
	template.addon.respawner = {}
	template.addon.respawner.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.respawner.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--camp
	template.addon.camp = {}
	template.addon.camp.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.camp.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--sp
	template.addon.sp = {}
	template.addon.sp.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.mode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.modeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventCombustionShards = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventCombustionShardsColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventTalons = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventTalonsColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventNova = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventNovaColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventAltar = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventAltarColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventStandard = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventStandardColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventRitual = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventRitualColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventBoneShield = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventBoneShieldColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventConduit = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventConduitColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventAtronach = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventAtronachColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventTrappingWebs = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventTrappingWebsColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventRadiate = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventRadiateColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventConsumingDarkness = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventConsumingDarknessColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventSoulLeech = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventSoulLeechColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventHealingSeed = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventHealingSeedColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventGraveRobber = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventGraveRobberColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.sp.preventPureAgony = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.sp.preventPureAgonyColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--so
	template.addon.so = {}
	template.addon.so.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.so.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.so.tableMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.so.tableModeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.so.displayMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.so.displayModeColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--ra
	template.addon.ra = {}
	template.addon.ra.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ra.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.addon.ra.allowOverride = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.ra.allowOverrideColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--caj
	template.addon.caj = {}
	template.addon.caj.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.caj.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--caj
	template.addon.crBgTp = {}
	template.addon.crBgTp.enabled = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.addon.crBgTp.enabledColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--stats
	template.stats = {}
	template.stats.magicka = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.magickaColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.health = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.healthColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.stamina = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.staminaColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.magickaRecovery = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.magickaRecoveryColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.healthRecovery = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.healthRecoveryColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.staminaRecovery = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.staminaRecoveryColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.spellDamage = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.spellDamageColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.weaponDamage = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.weaponDamageColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.spellPenetration = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.spellPenetrationColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.weaponPenetration = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.weaponPenetrationColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.spellCritical = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.spellCriticalColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.weaponCritical = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.weaponCriticalColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.spellResistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.spellResistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.physicalResistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.physicalResistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.stats.criticalResistance = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.stats.criticalResistanceColor = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--mundus
	template.mundus = {}
	template.mundus.stone1 = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.mundus.stone1Color = BeltalowdaAdmin.config.configWindow.rating.neutral
	template.mundus.stone2 = BeltalowdaAdmin.constants.defaults.UNDEFINED
	template.mundus.stone2Color = BeltalowdaAdmin.config.configWindow.rating.neutral
	
	--cp
	template.cp = {}
	for i = 1, #BeltalowdaAdmin.constants.cpDisciplines do
		for j = 1, #BeltalowdaAdmin.constants.cpDisciplines[i].cp do
			template.cp[BeltalowdaCP.GetCPControlName(i, j)] = BeltalowdaAdmin.constants.defaults.UNDEFINED
		end
	end
	--skills
	template.skills = {}
	for i = 1, 12 do
		template.skills[i] = {}
		template.skills[i].id = 0
		template.skills[i].texture = "esoui/art/mainmenu/menubar_skills_disabled.dds"
	end
	--equipment
	template.equipment = {}
	for i = 1, #BeltalowdaAdmin.constants.equipment do
		local name = BeltalowdaAdmin.constants.equipment[i].name
		if name ~= nil then
			template.equipment[name] = {}
			template.equipment[name].texture = BeltalowdaAdmin.constants.equipment[i].texture
			template.equipment[name].link = nil
			template.equipment[name].line1 = ""
			template.equipment[name].line2 = ""
		end
	end
	
	return template
end

function BeltalowdaAdmin.GetOnOffValuesVersionDependant(bool, clientVersion, requiredVersion, defaultValue)
	requiredVersion = BeltalowdaVersioning.GetVersionArray(requiredVersion)
	if bool == true then
		return BeltalowdaAdmin.constants.defaults.ENABLED
	else
		if clientVersion == nil then
			if defaultValue == nil then
				return BeltalowdaAdmin.constants.defaults.UNDEFINED
			else
				return defaultValue
			end
		else
			if BeltalowdaVersioning.VersionLesserThan(clientVersion, requiredVersion) == true then
				if clientVersion.major ~= 0 and clientVersion.minor ~= 0 and clientVersion.revision ~= 0 then
					return BeltalowdaAdmin.constants.defaults.UNDEFINED_VERSION
				else
					return BeltalowdaAdmin.constants.defaults.UNDEFINED
				end
			else
				if bool == false then
					return BeltalowdaAdmin.constants.defaults.DISABLED
				else
					if defaultValue == nil then
						return BeltalowdaAdmin.constants.defaults.UNDEFINED
					else
						return defaultValue
					end
				end
			end
		end
	end
end

function BeltalowdaAdmin.GetOnOffValues(bool, defaultValue)
	if bool == true then
		return BeltalowdaAdmin.constants.defaults.ENABLED
	elseif bool == false then
		return BeltalowdaAdmin.constants.defaults.DISABLED
	else
		if defaultValue == nil then
			return BeltalowdaAdmin.constants.defaults.UNDEFINED
		else
			return defaultValue
		end
	end
end

function BeltalowdaAdmin.GetFailOkColor(bool)
	if bool == true then
		return BeltalowdaAdmin.config.configWindow.rating.ok
	elseif bool == false then
		return BeltalowdaAdmin.config.configWindow.rating.fail
	else
		return BeltalowdaAdmin.config.configWindow.rating.neutral
	end
end

function BeltalowdaAdmin.SetValueIfPresent(origin, target, attribute)
	--d(origin)
	--d(target)
	--d(attribute)
	if origin ~= nil and target ~= nil and attribute ~= nil and origin[attribute] ~= nil then
		target[attribute] = origin[attribute]
	end
end

function BeltalowdaAdmin.PopulateConfigPanelData(data, player)

	--player
	data.player.displayName = player.displayName
	data.player.charName = player.charName
	
	if player.clientVersion ~= nil and player.clientVersion.major ~= nil and player.clientVersion.minor ~= nil and player.clientVersion.revision ~= nil then
		local highestVersion = BeltalowdaVersioning.GetHighestKnownVersionNumber()
		if BeltalowdaVersioning.VersionLesserThan(player.clientVersion, highestVersion) == true then
			data.player.versionColor = BeltalowdaAdmin.config.configWindow.rating.fail
		else
			data.player.versionColor = BeltalowdaAdmin.config.configWindow.rating.ok
		end
		data.player.version.major = player.clientVersion.major
		data.player.version.minor = player.clientVersion.minor
		data.player.version.revision = player.clientVersion.revision
	end
	
	if player.admin ~= nil then
		--client
		if player.admin.client ~= nil then
			---aoe
			if player.admin.client.aoe ~= nil then
				data.client.aoe.tellsEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.client.aoe.tellsEnabled)
				data.client.aoe.tellsEnabledColor = BeltalowdaAdmin.GetFailOkColor(player.admin.client.aoe.tellsEnabled)
				data.client.aoe.customEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.client.aoe.customColorEnabled)
				data.client.aoe.customEnabledColor = BeltalowdaAdmin.GetFailOkColor(player.admin.client.aoe.customColorEnabled)
				data.client.aoe.friendlyBrightness = player.admin.client.aoe.friendlyBrightness or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.client.aoe.friendlyBrightness ~= nil then 
					if player.admin.client.aoe.friendlyBrightness < 10 then
						data.client.aoe.friendlyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.client.aoe.friendlyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				data.client.aoe.enemyBrightness = player.admin.client.aoe.enemyBrightness or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.client.aoe.enemyBrightness ~= nil then 
					if player.admin.client.aoe.enemyBrightness < 10 then
						data.client.aoe.enemyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.client.aoe.enemyBrightnessColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
			end
			---sounds
			if player.admin.client.sound ~= nil then
				data.client.sound.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.client.sound.soundEnabled)
				data.client.sound.enabledColor = BeltalowdaAdmin.GetFailOkColor(player.admin.client.sound.soundEnabled)
				data.client.sound.audioVolume = player.admin.client.sound.audioVolume or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.client.sound.audioVolume ~= nil then 
					if player.admin.client.sound.audioVolume == 0 then
						data.client.sound.audioVolumeColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.client.sound.audioVolumeColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				data.client.sound.uiVolume = player.admin.client.sound.uiVolume or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.client.sound.uiVolume ~= nil then 
					if player.admin.client.sound.uiVolume == 0 then
						data.client.sound.uiVolumeColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.client.sound.uiVolumeColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				data.client.sound.sfxVolume = player.admin.client.sound.sfxVolume or BeltalowdaAdmin.constants.defaults.UNDEFINED
				
				
			end
			---graphics
			if player.admin.client.graphics ~= nil then
				data.client.graphics.windowMode = BeltalowdaAdmin.GetWindowMode(player.admin.client.graphics.windowMode)
				data.client.graphics.vsync = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.vsync)
				data.client.graphics.antiAliasing = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.antiAliasing)
				data.client.graphics.ambient = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.ambient)
				data.client.graphics.bloom = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.bloom)
				data.client.graphics.depthOfField = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.depthOfField)
				data.client.graphics.distortion = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.distortion)
				data.client.graphics.sunlight = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.sunlight)
				data.client.graphics.allyEffects = BeltalowdaAdmin.GetOnOffValues(player.admin.client.graphics.allyEffects)
				data.client.graphics.viewDistance = player.admin.client.graphics.viewDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.client.graphics.resWidth = player.admin.client.graphics.resWidth or BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
				data.client.graphics.resHeight = player.admin.client.graphics.resHeight or BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE
				data.client.graphics.particleSupressDistance = player.admin.client.graphics.particleSupressDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.client.graphics.particleMaximum = player.admin.client.graphics.particleMaximum or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.client.graphics.reflectionQuality = BeltalowdaAdmin.GetGraphicsQuality(player.admin.client.graphics.reflectionQuality)
				data.client.graphics.shadowQuality = BeltalowdaAdmin.GetGraphicsQuality(player.admin.client.graphics.shadowQuality)
				data.client.graphics.subSamplingQuality = BeltalowdaAdmin.GetGraphicsQuality(player.admin.client.graphics.subsamplingQuality, 1)
				data.client.graphics.graphicPresets = BeltalowdaAdmin.GetGraphicsPresets(player.admin.client.graphics.graphicPresets)
			
			
			
			end
		end
		--addon
		if player.admin.addon ~= nil then
			---crown
			if player.admin.addon.crown ~= nil then
				data.addon.crown.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.crown.enabled)
				if player.admin.addon.crown.enabled == true then
					data.addon.crown.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.crown.enabled == false then
					data.addon.crown.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.crown.size = player.admin.addon.crown.size or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if data.addon.crown.size ~= nil then
					if data.addon.crown.size >= 64 then
						data.addon.crown.sizeColor = BeltalowdaAdmin.config.configWindow.rating.ok
					else
						data.addon.crown.sizeColor = BeltalowdaAdmin.config.configWindow.rating.fail
					end
				end
				if player.admin.addon.crown.selectedCrown ~= nil and Beltalowda.group.crown.config.crowns ~= nil and Beltalowda.group.crown.config.crowns[player.admin.addon.crown.selectedCrown] ~= nil then
					data.addon.crown.selectedCrown = Beltalowda.group.crown.config.crowns[player.admin.addon.crown.selectedCrown].name or BeltalowdaAdmin.constants.defaults.UNDEFINED
				end
			end
			---ftcv
			if player.admin.addon.ftcv ~= nil then
				data.addon.ftcv.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ftcv.enabled)
				if player.admin.addon.ftcv.enabled == true then
					data.addon.ftcv.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.ftcv.enabled == false then
					data.addon.ftcv.enabledColor =  BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.ftcv.sizeClose = player.admin.addon.ftcv.sizeClose or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftcv.sizeFar = player.admin.addon.ftcv.sizeFar or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftcv.opacityClose = player.admin.addon.ftcv.opacityClose or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftcv.opacityFar = player.admin.addon.ftcv.opacityFar or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftcv.minDistance = player.admin.addon.ftcv.minDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftcv.maxDistance = player.admin.addon.ftcv.maxDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.addon.ftcv.maxDistance ~= nil then
					if player.admin.addon.ftcv.maxDistance > 10 then
						data.addon.ftcv.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.addon.ftcv.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				if player.admin.addon.ftcv.opacityFar ~= nil then
					if player.admin.addon.ftcv.opacityFar <= 50 then
						data.addon.ftcv.opacityFarColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.addon.ftcv.opacityFarColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				if player.admin.addon.ftcv.sizeFar ~= nil then
					if player.admin.addon.ftcv.sizeFar <= 25 then
						data.addon.ftcv.sizeFarColor = BeltalowdaAdmin.config.configWindow.rating.fail
					else
						data.addon.ftcv.sizeFarColor = BeltalowdaAdmin.config.configWindow.rating.ok
					end
				end
				
			end
			---ftcw
			if player.admin.addon.ftcw ~= nil then
				data.addon.ftcw.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ftcw.enabled)
				if player.admin.addon.ftcw.enabled == true then
					data.addon.ftcw.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.ftcw.enabled == false then
					data.addon.ftcw.enabledColor =  BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.ftcw.warningEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ftcw.warningsEnabled)
				if player.admin.addon.ftcw.warningsEnabled == true then
					data.addon.ftcw.warningEnabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.ftcw.warningsEnabled == false then
					data.addon.ftcw.warningEnabledColor =  BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.ftcw.distanceEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ftcw.distanceEnabled)
				data.addon.ftcw.maxDistance = player.admin.addon.ftcw.maxDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.addon.ftcw.maxDistance ~= nil then
					if player.admin.addon.ftcw.maxDistance <= 10 then
						data.addon.ftcw.maxDistanceColor = BeltalowdaAdmin.config.configWindow.rating.ok
					else
						data.addon.ftcw.maxDistanceColor =  BeltalowdaAdmin.config.configWindow.rating.fail
					end
				end
			end
			---ftca
			if player.admin.addon.ftca ~= nil then
				data.addon.ftca.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ftca.enabled)
				data.addon.ftca.maxDistance = player.admin.addon.ftca.maxDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftca.threshold = player.admin.addon.ftca.threshold or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ftca.interval = player.admin.addon.ftca.interval or BeltalowdaAdmin.constants.defaults.UNDEFINED
			end
			--ftcb
			if player.admin.addon.ftcb ~= nil then
				data.addon.ftcb.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.ftcb.enabled, player.clientVersion, "1.4.0")
				if player.admin.addon.ftcb.enabled == true then
					data.addon.ftcb.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				else
					data.addon.ftcb.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
				if BeltalowdaBeams.constants.BEAM[player.admin.addon.ftcb.selectedBeam] ~= nil then
					data.addon.ftcb.selectedBeam = BeltalowdaBeams.constants.BEAM[player.admin.addon.ftcb.selectedBeam].name or BeltalowdaAdmin.constants.defaults.UNDEFINED
				else
					data.addon.ftcb.selectedBeam = BeltalowdaAdmin.constants.defaults.UNDEFINED
				end
				data.addon.ftcb.alpha = player.admin.addon.ftcb.alpha or BeltalowdaAdmin.constants.defaults.UNDEFINED
				if player.admin.addon.ftcb.alpha ~= nil then
					if player.admin.addon.ftcb.alpha >= 100 then
						data.addon.ftcb.alphaColor = BeltalowdaAdmin.config.configWindow.rating.ok
					else
						data.addon.ftcb.alphaColor = BeltalowdaAdmin.config.configWindow.rating.fail
					end
				end
			end
			---dbo
			if player.admin.addon.dbo ~= nil then
				data.addon.dbo.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.dbo.enabled)
			end
			---rt
			if player.admin.addon.rt ~= nil then
				data.addon.rt.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.rt.enabled)
			end
			---ro
			if player.admin.addon.ro ~= nil then
				data.addon.ro.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.enabled)
				if player.admin.addon.ro.enabled == true then
					data.addon.ro.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.ro.enabled == false then
					data.addon.ro.enabledColor =  BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.ro.ultimateOverviewEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.ultimateOverviewEnabled)
				data.addon.ro.clientUltimateEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.clientUltimateEnabled)
				data.addon.ro.groupUltimatesEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.groupUltimatesEnabled)
				data.addon.ro.showSoftResources = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.showSoftResources)
				data.addon.ro.soundEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.ro.soundEnabled)
				data.addon.ro.maxDistance = player.admin.addon.ro.maxDistance or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeDestro = player.admin.addon.ro.groupSizeDestro or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeStorm = player.admin.addon.ro.groupSizeStorm or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeNorthernStorm = player.admin.addon.ro.groupSizeNorthernStorm or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizePermafrost = player.admin.addon.ro.groupSizePermafrost or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeNegate = player.admin.addon.ro.groupSizeNegate or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeNegateOffensive = player.admin.addon.ro.groupSizeNegateOffensive or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeNegateCounter = player.admin.addon.ro.groupSizeNegateCounter or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupSizeNova = player.admin.addon.ro.groupSizeNova or BeltalowdaAdmin.constants.defaults.UNDEFINED
				data.addon.ro.groupsEnabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.ro.groupsEnabled, player.clientVersion, "1.16.0")
			end
			---hdm
			if player.admin.addon.hdm ~= nil then
				data.addon.hdm.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.hdm.enabled)
				if player.admin.addon.hdm.enabled == true then
					data.addon.hdm.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.hdm.enabled == false then
					data.addon.hdm.enabledColor =  BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.hdm.windowEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.hdm.windowEnabled)
				data.addon.hdm.viewMode = BeltalowdaAdmin.GetSelectedHdmMode(player.admin.addon.hdm.viewMode)
			end
			---po
			if player.admin.addon.po ~= nil then
				data.addon.po.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.po.enabled)
				data.addon.po.soundEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.po.soundEnabled)
			end
			---dt
			if player.admin.addon.dt ~= nil then
				data.addon.dt.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.dt.enabled)
			end
			---gb
			if player.admin.addon.gb ~= nil then
				data.addon.gb.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.gb.enabled, player.clientVersion, "1.8.0")
			end
			---isdp
			if player.admin.addon.isdp ~= nil then
				data.addon.isdp.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.isdp.enabled, player.clientVersion, "1.8.0")
			end
			---yacs
			if player.admin.addon.yacs ~= nil then
				data.addon.yacs.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.yacs.enabled)
				if player.admin.addon.yacs.enabled == true then
					data.addon.yacs.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.yacs.enabled == false then
					data.addon.yacs.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.yacs.pvpEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.yacs.pvpEnabled)
				if player.admin.addon.yacs.pvpEnabled == true then
					data.addon.yacs.pvpEnabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.yacs.pvpEnabled == false then
					data.addon.yacs.pvpEnabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.yacs.combatEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.yacs.combatEnabled)
				if player.admin.addon.yacs.combatEnabled == true then
					data.addon.yacs.combatEnabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.yacs.combatEnabled == false then
					data.addon.yacs.combatEnabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
			end
			---sc
			if player.admin.addon.sc ~= nil then
				data.addon.sc.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sc.enabled, player.clientVersion, "1.15.2")
			end
			---sm
			if player.admin.addon.sm ~= nil then
				data.addon.sm.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.sm.enabled)
				if player.admin.addon.sm.enabled == true then
					data.addon.sm.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.sm.enabled == false then
					data.addon.sm.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
			end
			---recharger
			if player.admin.addon.recharger ~= nil then
				data.addon.recharger.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.recharger.enabled)
				if player.admin.addon.recharger.enabled == true then
					data.addon.recharger.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.recharger.enabled == false then
					data.addon.recharger.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
			end
			---kc
			if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true then
				if player.admin.addon.kc ~= nil then
					data.addon.kc.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.kc.enabled)
				end
			end
			---bft
			if player.admin.addon.bft ~= nil then
				data.addon.bft.enabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.bft.enabled)
				if player.admin.addon.bft.enabled == true then
					data.addon.bft.enabledColor = BeltalowdaAdmin.config.configWindow.rating.ok
				elseif player.admin.addon.bft.enabled == false then
					data.addon.bft.enabledColor = BeltalowdaAdmin.config.configWindow.rating.fail
				end
				data.addon.bft.soundEnabled = BeltalowdaAdmin.GetOnOffValues(player.admin.addon.bft.soundEnabled)
				data.addon.bft.size = player.admin.addon.bft.size or BeltalowdaAdmin.constants.defaults.UNDEFINED
			end
			--cl
			if player.admin.addon.cl ~= nil then
				data.addon.cl.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.cl.enabled, player.clientVersion, "1.5.0")
			end
			--cs
			if player.admin.addon.cs ~= nil then
				data.addon.cs.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.cs.enabled, player.clientVersion, "1.5.0")
			end
			--respawner
			if player.admin.addon.respawner ~= nil then
				data.addon.respawner.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.respawner.enabled, player.clientVersion, "1.8.0")
			end
			--camp
			if player.admin.addon.camp ~= nil then
				data.addon.camp.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.camp.enabled, player.clientVersion, "1.8.0")
			end
			--sp
			if player.admin.addon.sp ~= nil then
				data.addon.sp.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.enabled, player.clientVersion, "1.9.1")
				if player.admin.addon.sp.mode ~= nil then
					data.addon.sp.mode = Beltalowda.toolbox.sp.constants.MODES[player.admin.addon.sp.mode]
				end
				data.addon.sp.preventCombustionShards = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventCombustionShards, player.clientVersion, "1.16.0")
				data.addon.sp.preventTalons = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventTalons, player.clientVersion, "1.16.0")
				data.addon.sp.preventNova = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventNova, player.clientVersion, "1.16.0")
				data.addon.sp.preventAltar = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventAltar, player.clientVersion, "1.16.0")
				data.addon.sp.preventStandard = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventStandard, player.clientVersion, "1.16.0")
				data.addon.sp.preventRitual = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventRitual, player.clientVersion, "1.16.0")
				data.addon.sp.preventBoneShield = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventBoneShield, player.clientVersion, "1.16.0")
				data.addon.sp.preventConduit = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventConduit, player.clientVersion, "1.16.0")
				data.addon.sp.preventAtronach = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventAtronach, player.clientVersion, "1.16.0")
				data.addon.sp.preventTrappingWebs = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventTrappingWebs, player.clientVersion, "1.16.0")
				data.addon.sp.preventRadiate = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventRadiate, player.clientVersion, "1.16.0")
				data.addon.sp.preventConsumingDarkness = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventConsumingDarkness, player.clientVersion, "1.16.0")
				data.addon.sp.preventSoulLeech = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventSoulLeech, player.clientVersion, "1.16.0")
				data.addon.sp.preventHealingSeed = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventHealingSeed, player.clientVersion, "1.16.0")
				data.addon.sp.preventGraveRobber = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventGraveRobber, player.clientVersion, "1.16.0")
				data.addon.sp.preventPureAgony = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.sp.preventPureAgony, player.clientVersion, "1.16.0")
			end
			--so
			if player.admin.addon.so ~= nil then
				data.addon.so.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.so.enabled, player.clientVersion, "1.12.0")
				if player.admin.addon.so.tableMode ~= nil then
					data.addon.so.tableMode = Beltalowda.toolbox.so.constants.TABLE_MODES[player.admin.addon.so.tableMode]
				end
				if player.admin.addon.so.displayMode ~= nil then
					data.addon.so.displayMode = Beltalowda.toolbox.so.constants.DISPLAY_MODES[player.admin.addon.so.displayMode]
				end
			end
			--ra
			if player.admin.addon.ra ~= nil then
				data.addon.ra.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.ra.enabled, player.clientVersion, "1.12.0")
				data.addon.ra.allowOverride = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.ra.allowOverride, player.clientVersion, "1.12.0")
			end
			--caj
			if player.admin.addon.caj ~= nil then
				data.addon.caj.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.caj.enabled, player.clientVersion, "1.12.0")
			end
			--crBgTp
			if player.admin.addon.crBgTp ~= nil then
				data.addon.crBgTp.enabled = BeltalowdaAdmin.GetOnOffValuesVersionDependant(player.admin.addon.crBgTp.enabled, player.clientVersion, "1.14.0")
			end
		end
		--stats
		if player.admin.stats ~= nil then
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "magicka")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "health")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "stamina")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "magickaRecovery")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "healthRecovery")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "staminaRecovery")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "spellDamage")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "weaponDamage")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "spellPenetration")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "weaponPenetration")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "spellCritical")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "weaponCritical")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "spellResistance")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "physicalResistance")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.stats, data.stats, "criticalResistance")
			if player.admin.stats.criticalResistance ~= nil then
				if player.admin.stats.criticalResistance <= 1700 then
					data.stats.criticalResistanceColor = BeltalowdaAdmin.config.configWindow.rating.fail
				else
					data.stats.criticalResistanceColor = BeltalowdaAdmin.config.configWindow.rating.ok
				end			
			end
			if data.stats.spellCritical ~= BeltalowdaAdmin.constants.defaults.UNDEFINED then
				data.stats.spellCritical = data.stats.spellCritical .. "%"
			end
			if data.stats.weaponCritical ~= BeltalowdaAdmin.constants.defaults.UNDEFINED then
				data.stats.weaponCritical = data.stats.weaponCritical .. "%"
			end
		end
		--mundus
		if player.admin.mundus ~= nil then
			BeltalowdaAdmin.SetValueIfPresent(player.admin.mundus, data.mundus, "stone1")
			BeltalowdaAdmin.SetValueIfPresent(player.admin.mundus, data.mundus, "stone2")
		end
		--cp
		if player.admin.cp ~= nil then
			for key, value in pairs(player.admin.cp) do 
				data.cp[key] = value
			end
		end
		--skills
		if player.admin.skills ~= nil and player.admin.skills.bars ~=nil then
			if player.admin.skills.bars[1] ~= nil then
				for i = 1, 6 do
					if player.admin.skills.bars[1][i] ~= nil and player.admin.skills.bars[1][i] ~= 0 then
						data.skills[i].id = player.admin.skills.bars[1][i]
						data.skills[i].texture = GetAbilityIcon(data.skills[i].id)
					end
				end
			end
			if player.admin.skills.bars[2] ~= nil then
				for i = 1, 6 do
					if player.admin.skills.bars[2][i] ~= nil and player.admin.skills.bars[2][i] ~= 0 then
						data.skills[i + 6].id = player.admin.skills.bars[2][i]
						data.skills[i + 6].texture = GetAbilityIcon(data.skills[i + 6].id)
					end
				end
			end
		end
		
		--equipment
		if player.admin.equipment ~= nil then
			for i = 1, #BeltalowdaAdmin.constants.equipment do
				local name = BeltalowdaAdmin.constants.equipment[i].name
				if name ~= nil and player.admin.equipment[name] ~= nil and player.admin.equipment[name].link ~= nil then
					local entry = data.equipment[name]
					entry.link = player.admin.equipment[name].link
					entry.texture = GetItemLinkIcon(player.admin.equipment[name].link)
					local line1 = ""
					local line2 = ""
					local level = GetItemLinkRequiredChampionPoints(entry.link)
					if level ~= 0 then
						level = "cp|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. level .. "|r"
					else
						level = "lv|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. GetItemLinkRequiredLevel(entry.link) .. "|r"
					end
					local _, enchant = GetItemLinkEnchantInfo(entry.link)
					if BeltalowdaAdmin.constants.equipment[i].eType == BeltalowdaAdmin.constants.equipmentType.ARMOR then
						line1 = zo_strformat("<<C:1>> <<2>>", GetString("SI_ARMORTYPE", GetItemLinkArmorType(entry.link)), GetString(SI_ITEM_FORMAT_STR_ARMOR))
						line1 = line1 .. " - |c"  .. BeltalowdaAdmin.config.configWindow.equipmentValue .. GetString("SI_ITEMTRAITTYPE", GetItemLinkTraitInfo(entry.link)) .. "|r"
						line1 = line1 .. " - " .. level
						
						
						line2 = zo_strformat("<<1>>: |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<2>>|r", GetString(SI_ITEM_FORMAT_STR_ARMOR), GetItemLinkArmorRating(entry.link))
						line2 = line2 .. " - |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. enchant .. "|r"
					elseif BeltalowdaAdmin.constants.equipment[i].eType == BeltalowdaAdmin.constants.equipmentType.WEAPON then
						line1 = zo_strformat("|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<1>> |r<<C:2>>", GetString("SI_WEAPONTYPE", GetItemLinkWeaponType(entry.link)), GetString("SI_EQUIPTYPE", GetItemLinkEquipType(entry.link)))
						line1 = line1 .. " - |c"  .. BeltalowdaAdmin.config.configWindow.equipmentValue .. GetString("SI_ITEMTRAITTYPE", GetItemLinkTraitInfo(entry.link)) .. "|r"
						line1 = line1 .. " - " .. level
						
						line2 = zo_strformat("|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<1>>|r <<C:2>>", GetString("SI_WEAPONTYPE", GetItemLinkWeaponType(entry.link)), GetString("SI_EQUIPTYPE", GetItemLinkEquipType(entry.link)))
				
						if GetItemLinkWeaponType(entry.link) == WEAPONTYPE_SHIELD then
							line2 = zo_strformat("<<1>>: |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<2>>|r", GetString(SI_ITEM_FORMAT_STR_ARMOR), GetItemLinkArmorRating(entry.link))
						else 
							line2 = zo_strformat("<<1>>: |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<2>>|r", GetString(SI_ITEM_FORMAT_STR_DAMAGE), GetItemLinkWeaponPower(entry.link)) 
						end
						line2 = line2 .. " - |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. enchant .. "|r"
					elseif BeltalowdaAdmin.constants.equipment[i].eType == BeltalowdaAdmin.constants.equipmentType.ACCESSORIES then
						line1 = zo_strformat("|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. "<<1>>|r", GetString("SI_EQUIPTYPE", GetItemLinkEquipType(entry.link)))
						line1 = line1 .. " - |c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. GetString("SI_ITEMTRAITTYPE", GetItemLinkTraitInfo(entry.link)) .. "|r"
						line1 = line1 .. " - " .. level
						line2 = "|c" .. BeltalowdaAdmin.config.configWindow.equipmentValue .. enchant .. "|r"
					end
					
					entry.line1 = line1
					entry.line2 = line2
				end
			end		
		end
	end
	return data
end

function BeltalowdaAdmin.GetGraphicsQuality(value, offset)
	if value ~= nil and offset ~= nil then
		value = value + offset
	end
	local quality = BeltalowdaAdmin.constants.defaults.qualitySelection[value]
	if quality == nil then
		quality = BeltalowdaAdmin.constants.defaults.UNDEFINED
	end
	return quality
end

function BeltalowdaAdmin.GetGraphicsPresets(value)
	local preset = BeltalowdaAdmin.constants.defaults.graphicPresets[value]
	if preset == nil then
		preset = BeltalowdaAdmin.constants.defaults.UNDEFINED
	end
	return preset
end

function BeltalowdaAdmin.GetWindowMode(value)
	local windowMode = BeltalowdaAdmin.constants.defaults.viewModes[value]
	if windowMode == nil then
		windowMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	end
	return windowMode
end

function BeltalowdaAdmin.GetSelectedHdmMode(value)
	local viewMode = Beltalowda.group.hdm.constants.viewModes[value]
	if viewMode == nil then
		viewMode = BeltalowdaAdmin.constants.defaults.UNDEFINED
	end
	return viewMode
end

function BeltalowdaAdmin.CreateConfigPanelData(index)
	local data = BeltalowdaAdmin.CreateDefaultDataTemplate()
	local playerEntry = BeltalowdaAdmin.state.playerList[index]
	local players = BeltalowdaGroup.GetGroupInformation()
	if playerEntry ~= nil and players ~= nil then
		local player = nil
		for i = 1, #players do
			if players[i].unitTag == playerEntry.unitTag then
				player = players[i]
				break
			end
		end
		--d(player.unitTag)
		if player ~= nil then
			--Populate Default Panel
			data = BeltalowdaAdmin.PopulateConfigPanelData(data, player)
		end
	end
	return data
end

--callbacks
function BeltalowdaAdmin.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaAdmin.adminVars = currentProfile.admin
		BeltalowdaAdmin.vars = currentProfile
		BeltalowdaAdmin.charVars = Beltalowda.profile.GetCharacterVars()
		if BeltalowdaAdmin.state.initialized == true then
			BeltalowdaAdmin.SetTlwLocation()
		end
	end
end

function BeltalowdaAdmin.SaveWindowLocation()
	BeltalowdaAdmin.adminVars.position = BeltalowdaAdmin.adminVars.position or {}
	BeltalowdaAdmin.adminVars.position.x = BeltalowdaAdmin.controls.TLW:GetLeft()
	BeltalowdaAdmin.adminVars.position.y = BeltalowdaAdmin.controls.TLW:GetTop()
end

function BeltalowdaAdmin.CloseWindow()
	BeltalowdaAdmin.controls.TLW:SetHidden(true)
	BeltalowdaGroup.RemoveGroupChangedCallback(BeltalowdaAdmin.callbackName)
	SetGameCameraUIMode(not BeltalowdaAdmin.controls.TLW:IsHidden())
end

function BeltalowdaAdmin.OnKeyBinding()
	BeltalowdaAdmin.ToggleAdminInterface()
end

function BeltalowdaAdmin.AdjustAdminInformation(unitTag)
	if BeltalowdaAdmin.state.selectedIndex > 0 then
		local player = BeltalowdaAdmin.state.playerList[BeltalowdaAdmin.state.selectedIndex]
		if player ~= nil then
			if player.unitTag == unitTag then
				BeltalowdaAdmin.PopulateConfigPanel(BeltalowdaAdmin.CreateConfigPanelData(BeltalowdaAdmin.state.selectedIndex))
			end
		end
	end
end

function BeltalowdaAdmin.HandleRawAdminNetworkMessage(message)
	if BeltalowdaAdmin.adminVars.enabled == false then
		if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true and BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(message.pingTag)) then
		else
			return
		end
	end
	if message ~= nil and message.b0 ~= nil and (message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST or message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST_EQUIPMENT_INFORMATION) and message.b1 ~= nil and message.b2 ~= nil and message.b3 ~= nil and BeltalowdaRoster.IsGuildOfficerOf(GetUnitDisplayName("player"),GetUnitDisplayName(message.pingTag)) then
		
		local respondToMessage = false
		if message.b1 == 25 then
			respondToMessage = true
		else
			local players = BeltalowdaGroup.GetGroupInformation()
			if players ~= nil and players[message.b1] ~= nil and players[message.b1].displayName == GetUnitDisplayName("player") and players[message.b1].charName == GetUnitName("player") then
				respondToMessage = true
			end
		end
		if respondToMessage == true then
			if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST then
				BeltalowdaAdmin.HandleAdminRequest(message.b2, message.b3, message.pingTag)
			elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST_EQUIPMENT_INFORMATION then
				BeltalowdaAdmin.HandleEquipmentRequest(message.b3, message.pingTag)
			end
		end
	end
end

function BeltalowdaAdmin.ConfigPanelOnMouseWheel(control, delta)
	
	if BeltalowdaAdmin.controls.TLW.config.slider:IsHidden() == false then
		local size = 100 / 100 --fix later
		if size < 1 then
			size = 1
		end
		local position = -delta * size * 2 + BeltalowdaAdmin.controls.TLW.config.slider:GetValue()
		
		if position < 0 then
			position = 0
		end
		if position > 100 then
			position = 100
		end
		BeltalowdaAdmin.controls.TLW.config.slider:SetValue(position)
	end
end

function BeltalowdaAdmin.AdjustConfigSlider()
	local size = (BeltalowdaAdmin.state.size - BeltalowdaAdmin.config.height)
	if size < 0 then
		size = 0
	end
	
	local slide = size / 100 * BeltalowdaAdmin.controls.TLW.config.slider:GetValue()
	
	BeltalowdaAdmin.controls.TLW.config.scrollPanel:SetSimpleAnchor(BeltalowdaAdmin.controls.TLW.config.scrollControl, 0, -slide)
end

function BeltalowdaAdmin.PlayerEntryOnMouseEnter(index)
	if index ~= nil and index >= 1 and index <= 25 then
		if BeltalowdaAdmin.state.selectedIndex == index then
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetCenterColor(BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.r, BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.g, BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.b, BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.a)
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.r, BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.g, BeltalowdaAdmin.config.color.playerEntryColorSelectedHover.b, 0.0)		
		else
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetCenterColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, BeltalowdaAdmin.config.color.playerEntryColorHover.a)
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, 0.0)		
		end
	end
end

function BeltalowdaAdmin.PlayerEntryOnMouseExit(index)
	if index ~= nil and index >= 1 and index <= 25 then
			if BeltalowdaAdmin.state.selectedIndex == index then
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetCenterColor(BeltalowdaAdmin.config.color.playerEntryColorSelected.r, BeltalowdaAdmin.config.color.playerEntryColorSelected.g, BeltalowdaAdmin.config.color.playerEntryColorSelected.b, BeltalowdaAdmin.config.color.playerEntryColorSelected.a)
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.playerEntryColorSelected.r, BeltalowdaAdmin.config.color.playerEntryColorSelected.g, BeltalowdaAdmin.config.color.playerEntryColorSelected.b, 0.0)		
		else
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetCenterColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, 0.0)
			BeltalowdaAdmin.controls.TLW.player.blocks[index].backdrop:SetEdgeColor(BeltalowdaAdmin.config.color.playerEntryColorHover.r, BeltalowdaAdmin.config.color.playerEntryColorHover.g, BeltalowdaAdmin.config.color.playerEntryColorHover.b, 0.0)		
		end
	end
end

function BeltalowdaAdmin.PlayerEntryOnClick(index)
	if index ~= nil and index >= 1 and index <= #BeltalowdaAdmin.state.playerList then
		BeltalowdaAdmin.state.selectedIndex = index
		for i = 1, 25 do
			BeltalowdaAdmin.PlayerEntryOnMouseExit(i)
		end
		BeltalowdaAdmin.PlayerEntryOnMouseEnter(index)
		--d(index)
		BeltalowdaAdmin.PopulateConfigPanel(BeltalowdaAdmin.CreateConfigPanelData(index))
		
	end
end

function BeltalowdaAdmin.EquipmentEntryOnMouseEnter(index)
	local entry = BeltalowdaAdmin.constants.equipment[index]
	if entry ~= nil and entry.name ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name] ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].textureBackdrop ~= nil then
		local name = entry.name
		BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[name].textureBackdrop:SetCenterColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, BeltalowdaAdmin.config.color.equipmentHover.a)
		BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[name].textureBackdrop:SetEdgeColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, 0.0)
	end
end
			
function BeltalowdaAdmin.EquipmentEntryOnMouseExit(index)
	local entry = BeltalowdaAdmin.constants.equipment[index]
	if entry ~= nil and entry.name ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name] ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].textureBackdrop ~= nil then
		local name = entry.name
		BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[name].textureBackdrop:SetCenterColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, 0.0)
		BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[name].textureBackdrop:SetEdgeColor(BeltalowdaAdmin.config.color.equipmentHover.r, BeltalowdaAdmin.config.color.equipmentHover.g, BeltalowdaAdmin.config.color.equipmentHover.b, 0.0)
	end
end

function BeltalowdaAdmin.EquipmentEntryOnClick(index)
	local entry = BeltalowdaAdmin.constants.equipment[index]
	if entry ~= nil and entry.name ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name] ~= nil and BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].textureBackdrop ~= nil then
		ClearMenu()
		if BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].link.link ~= nil then
			AddCustomMenuItem(BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_LINK_IN_CHAT, function() BeltalowdaAdmin.LinkInChat(BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].link.link) end)
		end
		AddCustomMenuItem(BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_REQUEST, function() BeltalowdaAdmin.RequestEquipmentItem(index, BeltalowdaAdmin.state.selectedIndex) end)

		ShowMenu(BeltalowdaAdmin.controls.TLW.config.scrollPanel.equipment[entry.name].textureBackdrop)
	end
end


--menu interaction
function BeltalowdaAdmin.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.ADMIN_HEADER,
			width = "full",
		},
		[2] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ENABLED,
					getFunc = BeltalowdaAdmin.GetAdminEnabled,
					setFunc = BeltalowdaAdmin.SetAdminEnabled
				},
				[2] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_WARNING,
					width = "full"
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CLIENT_CONFIGURATION,
					getFunc = BeltalowdaAdmin.GetAdminAllowClientConfiguration,
					setFunc = BeltalowdaAdmin.SetAdminAllowClientConfiguration
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_ADDON_CONFIGURATION,
					getFunc = BeltalowdaAdmin.GetAdminAllowAddOnConfiguration,
					setFunc = BeltalowdaAdmin.SetAdminAllowAddOnConfiguration
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_STATS,
					getFunc = BeltalowdaAdmin.GetAdminAllowStats,
					setFunc = BeltalowdaAdmin.SetAdminAllowStats
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_SKILLS,
					getFunc = BeltalowdaAdmin.GetAdminAllowSkills,
					setFunc = BeltalowdaAdmin.SetAdminAllowSkills
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_EQUIPMENT,
					getFunc = BeltalowdaAdmin.GetAdminAllowEquipment,
					setFunc = BeltalowdaAdmin.SetAdminAllowEquipment
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CP,
					getFunc = BeltalowdaAdmin.GetAdminAllowCp,
					setFunc = BeltalowdaAdmin.SetAdminAllowCp
				},
			}
		}
	}
	return menu
end

function BeltalowdaAdmin.GetAdminEnabled()
	return BeltalowdaAdmin.adminVars.enabled
end

function BeltalowdaAdmin.SetAdminEnabled(value)
	BeltalowdaAdmin.adminVars.enabled = value
end

function BeltalowdaAdmin.GetAdminAllowClientConfiguration()
	return BeltalowdaAdmin.adminVars.allowClientConfiguration
end

function BeltalowdaAdmin.SetAdminAllowClientConfiguration(value)
	BeltalowdaAdmin.adminVars.allowClientConfiguration = value
end

function BeltalowdaAdmin.GetAdminAllowAddOnConfiguration()
	return BeltalowdaAdmin.adminVars.allowAddonConfiguration
end

function BeltalowdaAdmin.SetAdminAllowAddOnConfiguration(value)
	BeltalowdaAdmin.adminVars.allowAddonConfiguration = value
end

function BeltalowdaAdmin.GetAdminAllowStats()
	return BeltalowdaAdmin.adminVars.allowStats
end

function BeltalowdaAdmin.SetAdminAllowStats(value)
	BeltalowdaAdmin.adminVars.allowStats = value
end

function BeltalowdaAdmin.GetAdminAllowSkills()
	return BeltalowdaAdmin.adminVars.allowSkills
end

function BeltalowdaAdmin.SetAdminAllowSkills(value)
	BeltalowdaAdmin.adminVars.allowSkills = value
end

function BeltalowdaAdmin.GetAdminAllowEquipment()
	return BeltalowdaAdmin.adminVars.allowEquipment
end

function BeltalowdaAdmin.SetAdminAllowEquipment(value)
	BeltalowdaAdmin.adminVars.allowEquipment = value
end

function BeltalowdaAdmin.GetAdminAllowCp()
	return BeltalowdaAdmin.adminVars.allowCp
end

function BeltalowdaAdmin.SetAdminAllowCp(value)
	BeltalowdaAdmin.adminVars.allowCp = value
end