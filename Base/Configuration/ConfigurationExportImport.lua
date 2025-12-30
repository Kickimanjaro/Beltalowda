-- Beltalowda Configuration Export Import
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.cfg = Beltalowda.cfg or {}
local BeltalowdaConfig = Beltalowda.cfg
Beltalowda.profile = Beltalowda.profile or {}
local BeltalowdaProfile = Beltalowda.profile
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaConfig.constants = BeltalowdaConfig.constants or {}
BeltalowdaConfig.constants.TLW_CONFIG_WINDOW = "Beltalowda.cfg.config_TLW"
BeltalowdaConfig.constants.HEADER_BACKDROP_NAME = "Beltalowda.cfg.config_TLW_Header_Backdrop"
BeltalowdaConfig.constants.BODY_BACKDROP_NAME = "Beltalowda.cfg.config_TLW_Body_Backdrop"
BeltalowdaConfig.constants.EXPORT_DROPDOWN = "Beltalowda.cfg.config_TLW_Export_Dropdown"
BeltalowdaConfig.constants.IMPORT_CHECKBOX_ADD_ALL = "Beltalowda.cfg.config_TLW_Import_Add_All"

BeltalowdaConfig.constants.TAB_EXPORT = 1
BeltalowdaConfig.constants.TAB_IMPORT = 2

BeltalowdaConfig.constants.syntax = {}
BeltalowdaConfig.constants.syntax.LAYER_1_START = "["
BeltalowdaConfig.constants.syntax.LAYER_1_END = "]"
BeltalowdaConfig.constants.syntax.LAYER_2_START = "{"
BeltalowdaConfig.constants.syntax.LAYER_2_END = "}"
BeltalowdaConfig.constants.syntax.LAYER_X_START = "("
BeltalowdaConfig.constants.syntax.LAYER_X_END = ")"
BeltalowdaConfig.constants.syntax.LAYER_X_SEPERATOR = "."
BeltalowdaConfig.constants.syntax.types = {}
BeltalowdaConfig.constants.syntax.types.NUMBER = "n"
BeltalowdaConfig.constants.syntax.types.BOOLEAN = "b"
BeltalowdaConfig.constants.syntax.types.STRING = "s"
BeltalowdaConfig.constants.syntax.identifiers = {}
BeltalowdaConfig.constants.syntax.identifiers.VERSION = "Version"

BeltalowdaConfig.constants.PREFIX = "CFG"

BeltalowdaConfig.callbackName = Beltalowda.addonName .. "Config"

BeltalowdaConfig.controls = {}

BeltalowdaConfig.config = {}
BeltalowdaConfig.config.width = 800
BeltalowdaConfig.config.height = 600
BeltalowdaConfig.config.headerHeight = 33
BeltalowdaConfig.config.headerOffset = 3
BeltalowdaConfig.config.isMovable = true
BeltalowdaConfig.config.isMouseEnabled = true
BeltalowdaConfig.config.isClampedToScreen = true
BeltalowdaConfig.config.headerFont = "$(BOLD_FONT)|$(KB_20)soft-shadow-thick"
BeltalowdaConfig.config.color = {}
BeltalowdaConfig.config.color.default = {}
BeltalowdaConfig.config.color.default.r = 0.85
BeltalowdaConfig.config.color.default.g = 0.83
BeltalowdaConfig.config.color.default.b = 0.7
BeltalowdaConfig.config.color.backdrop = {}
BeltalowdaConfig.config.color.backdrop.r = 0.0
BeltalowdaConfig.config.color.backdrop.g = 0.0
BeltalowdaConfig.config.color.backdrop.b = 0.0
BeltalowdaConfig.config.color.backdrop.a = 0.7
BeltalowdaConfig.config.color.backdropEdge = {}
BeltalowdaConfig.config.color.backdropEdge.r = 1.0
BeltalowdaConfig.config.color.backdropEdge.g = 1.0
BeltalowdaConfig.config.color.backdropEdge.b = 1.0
BeltalowdaConfig.config.color.backdropEdge.a = 0.7
BeltalowdaConfig.config.color.tabSelected = {}
BeltalowdaConfig.config.color.tabSelected.r = 0.5
BeltalowdaConfig.config.color.tabSelected.g = 0.5
BeltalowdaConfig.config.color.tabSelected.b = 0.5
BeltalowdaConfig.config.color.tabSelected.a = 0.7
BeltalowdaConfig.config.color.tabNotSelected = {}
BeltalowdaConfig.config.color.tabNotSelected.r = 0.3
BeltalowdaConfig.config.color.tabNotSelected.g = 0.3
BeltalowdaConfig.config.color.tabNotSelected.b = 0.3
BeltalowdaConfig.config.color.tabNotSelected.a = 0.7
BeltalowdaConfig.config.color.tabMouseOver = {}
BeltalowdaConfig.config.color.tabMouseOver.r = 0.2
BeltalowdaConfig.config.color.tabMouseOver.g = 0.6
BeltalowdaConfig.config.color.tabMouseOver.b = 0.8
BeltalowdaConfig.config.color.tabMouseOver.a = 0.7
BeltalowdaConfig.config.color.edgeColor = {}
BeltalowdaConfig.config.color.edgeColor.r = 0.8
BeltalowdaConfig.config.color.edgeColor.g = 0.8
BeltalowdaConfig.config.color.edgeColor.b = 0.8
BeltalowdaConfig.config.color.edgeColor.a = 0.7
BeltalowdaConfig.config.tabHeight = 50
BeltalowdaConfig.config.tabOffset = 8
BeltalowdaConfig.config.controlHeight = BeltalowdaConfig.config.height - BeltalowdaConfig.config.tabHeight - BeltalowdaConfig.config.tabOffset
BeltalowdaConfig.config.tabWidth = 200
BeltalowdaConfig.config.controlOffset = 2
BeltalowdaConfig.config.controlWidth = BeltalowdaConfig.config.width - BeltalowdaConfig.config.controlOffset * 2

BeltalowdaConfig.state = {}
BeltalowdaConfig.state.initialized = false
BeltalowdaConfig.state.selectedTab = BeltalowdaConfig.constants.TAB_EXPORT
BeltalowdaConfig.state.selectedExportProfile = ""

local wm = WINDOW_MANAGER

function BeltalowdaConfig.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaConfig.callbackName, BeltalowdaConfig.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_CONFIG_OPEN", BeltalowdaConfig.constants.TOGGLE_CONFIG)
	
	BeltalowdaConfig.CreateUI()
	
	BeltalowdaConfig.state.initialized = true
end

function BeltalowdaConfig.GetDefaults()
	local defaults = {}
	return defaults
end

function BeltalowdaConfig.CreateUI()
	--TLW
	BeltalowdaConfig.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaConfig.constants.TLW_ADMIN_WINDOW)
	
	BeltalowdaConfig.controls.TLW:SetDimensions(BeltalowdaConfig.config.width, BeltalowdaConfig.config.headerHeight)
	BeltalowdaConfig.SetTlwLocation()
	
	BeltalowdaConfig.controls.TLW:SetMovable(BeltalowdaConfig.config.isMovable)
	BeltalowdaConfig.controls.TLW:SetMouseEnabled(BeltalowdaConfig.config.isMouseEnabled)
	
	BeltalowdaConfig.controls.TLW:SetClampedToScreen(BeltalowdaConfig.config.isClampedToScreen)
	BeltalowdaConfig.controls.TLW:SetHandler("OnMoveStop", BeltalowdaConfig.SaveWindowLocation)
	BeltalowdaConfig.controls.TLW:SetHidden(true)
	
	--Header
	BeltalowdaConfig.controls.TLW.header= wm:CreateControl(nil, BeltalowdaConfig.controls.TLW, CT_CONTROL)
	BeltalowdaConfig.controls.TLW.header:SetDimensions(BeltalowdaConfig.config.width, BeltalowdaConfig.config.headerHeight)
	BeltalowdaConfig.controls.TLW.header:SetAnchor(TOPLEFT, BeltalowdaConfig.controls.TLW, TOPLEFT, 0, 0)
	
	
	BeltalowdaConfig.controls.TLW.header.label = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW.header, CT_LABEL)
	BeltalowdaConfig.controls.TLW.header.label:SetAnchor(TOP, BeltalowdaConfig.controls.TLW.header, TOP ,0 , 3)
	BeltalowdaConfig.controls.TLW.header.label:SetFont(BeltalowdaConfig.config.headerFont)
	BeltalowdaConfig.controls.TLW.header.label:SetWrapMode(ELLIPSIS)
	BeltalowdaConfig.controls.TLW.header.label:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	BeltalowdaConfig.controls.TLW.header.label:SetText(BeltalowdaConfig.constants.HEADER_TITLE)
		
		
	BeltalowdaConfig.controls.TLW.header.backdrop = CreateControlFromVirtual(BeltalowdaConfig.constants.HEADER_BACKDROP_NAME, BeltalowdaConfig.controls.TLW.header, "ZO_SliderBackdrop")
	BeltalowdaConfig.controls.TLW.header.backdrop:SetCenterColor(BeltalowdaConfig.config.color.backdrop.r, BeltalowdaConfig.config.color.backdrop.g, BeltalowdaConfig.config.color.backdrop.b, BeltalowdaConfig.config.color.backdrop.a)
	BeltalowdaConfig.controls.TLW.header.backdrop:SetEdgeColor(BeltalowdaConfig.config.color.backdropEdge.r, BeltalowdaConfig.config.color.backdropEdge.g, BeltalowdaConfig.config.color.backdropEdge.b, BeltalowdaConfig.config.color.backdropEdge.a)
		
	BeltalowdaConfig.controls.TLW.header.button = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW.header, CT_BUTTON)
	BeltalowdaConfig.controls.TLW.header.button:SetAnchor(TOPRIGHT, BeltalowdaConfig.controls.TLW.header, TOPRIGHT, -3, 7)
	BeltalowdaConfig.controls.TLW.header.button:SetDimensions(20, 20)
	BeltalowdaConfig.controls.TLW.header.button:SetNormalTexture("/esoui/art/buttons/decline_up.dds")
	BeltalowdaConfig.controls.TLW.header.button:SetMouseOverTexture("/esoui/art/buttons/decline_over.dds")
	BeltalowdaConfig.controls.TLW.header.button:SetHandler("OnClicked", BeltalowdaConfig.CloseWindow)
	
	--Body	
	BeltalowdaConfig.controls.TLW.body = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW, CT_CONTROL)
	BeltalowdaConfig.controls.TLW.body:SetDimensions(BeltalowdaConfig.config.width, BeltalowdaConfig.config.height)
	BeltalowdaConfig.controls.TLW.body:SetAnchor(TOPLEFT, BeltalowdaConfig.controls.TLW, TOPLEFT, 0, BeltalowdaConfig.config.headerOffset + BeltalowdaConfig.config.headerHeight)
	
	BeltalowdaConfig.controls.TLW.body.backdrop = CreateControlFromVirtual(BeltalowdaConfig.constants.BODY_BACKDROP_NAME, BeltalowdaConfig.controls.TLW.body, "ZO_SliderBackdrop")
	BeltalowdaConfig.controls.TLW.body.backdrop:SetCenterColor(BeltalowdaConfig.config.color.backdrop.r, BeltalowdaConfig.config.color.backdrop.g, BeltalowdaConfig.config.color.backdrop.b, BeltalowdaConfig.config.color.backdrop.a)
	BeltalowdaConfig.controls.TLW.body.backdrop:SetEdgeColor(BeltalowdaConfig.config.color.backdropEdge.r, BeltalowdaConfig.config.color.backdropEdge.g, BeltalowdaConfig.config.color.backdropEdge.b, BeltalowdaConfig.config.color.backdropEdge.a)
	
	--Body Tabs
	BeltalowdaConfig.controls.TLW.body.tabControl = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW.body, CT_CONTROL)
	BeltalowdaConfig.controls.TLW.body.tabControl:SetDimensions(BeltalowdaConfig.config.width, BeltalowdaConfig.config.tabHeight - BeltalowdaConfig.config.tabOffset)
	BeltalowdaConfig.controls.TLW.body.tabControl:SetAnchor(TOPLEFT, BeltalowdaConfig.controls.TLW.body, TOPLEFT, 0, BeltalowdaConfig.config.tabOffset)
	
	BeltalowdaConfig.controls.TLW.body.tabControl.exportTab = BeltalowdaConfig.CreateTabControl(BeltalowdaConfig.controls.TLW.body.tabControl, BeltalowdaConfig.config.controlOffset * 2, BeltalowdaConfig.constants.TAB_EXPORT,BeltalowdaConfig.constants.TAB_EXPORT_TITLE)
	BeltalowdaConfig.controls.TLW.body.tabControl.importTab = BeltalowdaConfig.CreateTabControl(BeltalowdaConfig.controls.TLW.body.tabControl, BeltalowdaConfig.config.controlOffset * 2 + BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.constants.TAB_IMPORT, BeltalowdaConfig.constants.TAB_IMPORT_TITLE)
	
	--Body Control
	BeltalowdaConfig.controls.TLW.body.rootControl = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW.body, CT_CONTROL)
	BeltalowdaConfig.controls.TLW.body.rootControl:SetDimensions(BeltalowdaConfig.config.controlWidth, BeltalowdaConfig.config.controlHeight)
	BeltalowdaConfig.controls.TLW.body.rootControl:SetAnchor(TOPLEFT, BeltalowdaConfig.controls.TLW.body, TOPLEFT, BeltalowdaConfig.config.controlOffset, BeltalowdaConfig.config.tabHeight + BeltalowdaConfig.config.tabOffset - 2)
	
	BeltalowdaConfig.controls.TLW.body.edge = wm:CreateControl(nil, BeltalowdaConfig.controls.TLW.body.rootControl, CT_BACKDROP)
	BeltalowdaConfig.controls.TLW.body.edge:SetAnchor(TOPLEFT, BeltalowdaConfig.controls.TLW.body.rootControl, TOPLEFT, 0, 0)
	BeltalowdaConfig.controls.TLW.body.edge:SetDimensions(BeltalowdaConfig.config.controlWidth, BeltalowdaConfig.config.controlHeight)
	BeltalowdaConfig.controls.TLW.body.edge:SetEdgeTexture(nil, 1, 1, 2, 0)
	BeltalowdaConfig.controls.TLW.body.edge:SetCenterColor(0, 0, 0, 0)
	BeltalowdaConfig.controls.TLW.body.edge:SetEdgeColor(BeltalowdaConfig.config.color.edgeColor.r, BeltalowdaConfig.config.color.edgeColor.g, BeltalowdaConfig.config.color.edgeColor.b, BeltalowdaConfig.config.color.edgeColor.a)
	
	
	--Export Control
	BeltalowdaConfig.controls.TLW.body.rootControl.exportControl = BeltalowdaConfig.CreateExportControl(BeltalowdaConfig.controls.TLW.body.rootControl)
	
	--Import Control
	BeltalowdaConfig.controls.TLW.body.rootControl.importControl = BeltalowdaConfig.CreateImportControl(BeltalowdaConfig.controls.TLW.body.rootControl)
	
	BeltalowdaConfig.TabSelected(BeltalowdaConfig.constants.TAB_EXPORT)
end

function BeltalowdaConfig.CreateTabControl(rootControl, offset, index, title)
	local control = wm:CreateControl(nil, rootControl, CT_CONTROL)
	control:SetDimensions(BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.config.tabHeight)
	control:SetAnchor(TOPLEFT, rootControl, TOPLEFT, offset, 0)
	
	--control.backdrop2 = CreateControlFromVirtual(backdropName, control, "ZO_SliderBackdrop")
	--control.backdrop2:SetCenterColor(BeltalowdaConfig.config.color.backdrop.r, BeltalowdaConfig.config.color.backdrop.g, BeltalowdaConfig.config.color.backdrop.b, BeltalowdaConfig.config.color.backdrop.a)
	--control.backdrop2:SetEdgeColor(BeltalowdaConfig.config.color.backdropEdge.r, BeltalowdaConfig.config.color.backdropEdge.g, BeltalowdaConfig.config.color.backdropEdge.b, BeltalowdaConfig.config.color.backdropEdge.a)
	
	control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
	control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.backdrop:SetDimensions(BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.config.tabHeight)
	--control.backdrop:SetDrawTier(0)
	control.backdrop:SetCenterColor(BeltalowdaConfig.config.color.tabNotSelected.r, BeltalowdaConfig.config.color.tabNotSelected.g, BeltalowdaConfig.config.color.tabNotSelected.b, BeltalowdaConfig.config.color.tabNotSelected.a)
	control.backdrop:SetEdgeColor(0,0,0,0)
	
	control.edge = wm:CreateControl(nil, control, CT_BACKDROP)
	control.edge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.edge:SetDimensions(BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.config.tabHeight)
	control.edge:SetEdgeTexture(nil, 1, 1, 2, 0)
	control.edge:SetCenterColor(0, 0, 0, 0)
	control.edge:SetEdgeColor(BeltalowdaConfig.config.color.edgeColor.r, BeltalowdaConfig.config.color.edgeColor.g, BeltalowdaConfig.config.color.edgeColor.b, BeltalowdaConfig.config.color.edgeColor.a)
	
	control.label = wm:CreateControl(nil, control, CT_LABEL)
	control.label:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.label:SetFont(BeltalowdaConfig.config.headerFont)
	control.label:SetWrapMode(ELLIPSIS)
	control.label:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	control.label:SetText(title)
	control.label:SetDimensions(BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.config.tabHeight)
	control.label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	control.label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.button = wm:CreateControl(nil, control, CT_BUTTON)
	local button = control.button
	button:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	button:SetDimensions(BeltalowdaConfig.config.tabWidth, BeltalowdaConfig.config.tabHeight)
	--button:SetNormalTexture("/esoui/art/actionbar/abilityframe64_up.dds")
	--button:SetPressedTexture("/esoui/art/actionbar/abilityframe64_down.dds")
	--button:SetMouseOverTexture("EsoUI/Art/ActionBar/actionBar_mouseOver.dds")
	button:SetHandler("OnClicked", function () BeltalowdaConfig.TabSelected(index) end)
	button:SetHandler("OnMouseEnter", function() BeltalowdaConfig.TabOnMouseEnter(index) end)
	button:SetHandler("OnMouseExit", function() BeltalowdaConfig.TabOnMouseExit(index) end)
	--button:SetDrawTier(1)
	
	
	return control
end

function BeltalowdaConfig.CreateExportControl(rootControl)
	local control = wm:CreateControl(nil, rootControl, CT_CONTROL)
	control:SetDimensions(BeltalowdaConfig.config.controlWidth, BeltalowdaConfig.config.controlHeight)
	control:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	
	control.profileLabel = wm:CreateControl(nil, control, CT_LABEL)
	control.profileLabel:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, 10)
	control.profileLabel:SetFont(BeltalowdaConfig.config.headerFont)
	control.profileLabel:SetWrapMode(ELLIPSIS)
	control.profileLabel:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	control.profileLabel:SetText(BeltalowdaConfig.constants.EXPORT_PROFILE)
	control.profileLabel:SetDimensions(100, 25)
	control.profileLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	control.profileLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.combobox = wm:CreateControlFromVirtual(BeltalowdaConfig.constants.EXPORT_DROPDOWN, control, "ZO_ScrollableComboBox")
	control.combobox:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset + 100, 10)
	control.combobox:SetDimensions(325, 25)
	control.dropdown = ZO_ComboBox_ObjectFromContainer(control.combobox)
	
	control.config = BeltalowdaConfig.CreateEditControl(control, BeltalowdaConfig.config.controlWidth - BeltalowdaConfig.config.controlOffset * 2, BeltalowdaConfig.config.controlHeight - 40 - BeltalowdaConfig.config.controlOffset * 3, 100000, true)
	control.config:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, 40)

	control.selectAllButton = CreateControlFromVirtual(nil, control, "ZO_DefaultButton")
	control.selectAllButton:SetAnchor(TOPLEFT, control, TOPLEFT, 450, 10)
	control.selectAllButton:SetDimensions(175, 25)
	control.selectAllButton:SetText(BeltalowdaConfig.constants.EXPORT_SELECT_ALL)
	control.selectAllButton:SetClickSound("Click")
	control.selectAllButton:SetHandler("OnClicked", BeltalowdaConfig.SelectAllExportText)
	
	
	
	BeltalowdaConfig.CreateExportDropdownEntries(control.dropdown)
	
	return control
end

function BeltalowdaConfig.CreateImportControl(rootControl)
	local control = wm:CreateControl(nil, rootControl, CT_CONTROL)
	control:SetDimensions(BeltalowdaConfig.config.controlWidth, BeltalowdaConfig.config.controlHeight)
	control:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	
	control.profileLabel = wm:CreateControl(nil, control, CT_LABEL)
	control.profileLabel:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, 10)
	control.profileLabel:SetFont(BeltalowdaConfig.config.headerFont)
	control.profileLabel:SetWrapMode(ELLIPSIS)
	control.profileLabel:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	control.profileLabel:SetText(BeltalowdaConfig.constants.IMPORT_PROFILE)
	control.profileLabel:SetDimensions(180, 25)
	control.profileLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	control.profileLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.name = BeltalowdaConfig.CreateEditControl(control, 250, 25, 100, false)
	control.name:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset + 180, 10)
	
	control.config = BeltalowdaConfig.CreateEditControl(control, BeltalowdaConfig.config.controlWidth - BeltalowdaConfig.config.controlOffset * 2, BeltalowdaConfig.config.controlHeight - 40 - BeltalowdaConfig.config.controlOffset * 3 - 25 * 2, 100000, true)
	control.config:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, 40)
	
	control.import = CreateControlFromVirtual(nil, control, "ZO_DefaultButton")
	control.import:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset + 250 + 180, 10)
	control.import:SetDimensions(175, 25)
	control.import:SetText(BeltalowdaConfig.constants.IMPORT)
	control.import:SetClickSound("Click")
	control.import:SetHandler("OnClicked", BeltalowdaConfig.Import)
	
	control.chkAddAllValues = CreateControlFromVirtual(BeltalowdaConfig.constants.IMPORT_CHECKBOX_ADD_ALL, control, "ZO_CheckButton")
	control.chkAddAllValues:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, BeltalowdaConfig.config.controlHeight - 40 - BeltalowdaConfig.config.controlOffset * 4)
	--control.chkAddAllValues:SetDimensions(100, 25)
	ZO_CheckButton_SetChecked(control.chkAddAllValues)
	ZO_CheckButton_SetLabelText(control.chkAddAllValues, BeltalowdaConfig.constants.IMPORT_ADD_ALL)
	ZO_CheckButton_SetLabelWidth(control.chkAddAllValues, 390)
	control.chkAddAllValues.label:SetFont(BeltalowdaConfig.config.headerFont)
	
	control.statusDescriptionLabel = wm:CreateControl(nil, control, CT_LABEL)
	control.statusDescriptionLabel:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaConfig.config.controlOffset, BeltalowdaConfig.config.controlHeight - 40 - BeltalowdaConfig.config.controlOffset * 3 - 25 + 40)
	control.statusDescriptionLabel:SetFont(BeltalowdaConfig.config.headerFont)
	control.statusDescriptionLabel:SetWrapMode(ELLIPSIS)
	control.statusDescriptionLabel:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	control.statusDescriptionLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS)
	control.statusDescriptionLabel:SetDimensions(75, 25)
	control.statusDescriptionLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	control.statusDescriptionLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	control.statusLabel = wm:CreateControl(nil, control, CT_LABEL)
	control.statusLabel:SetAnchor(TOPLEFT, control, TOPLEFT, 110, BeltalowdaConfig.config.controlHeight - 40 - BeltalowdaConfig.config.controlOffset * 3 - 25 + 40)
	control.statusLabel:SetFont(BeltalowdaConfig.config.headerFont)
	control.statusLabel:SetWrapMode(ELLIPSIS)
	control.statusLabel:SetColor(BeltalowdaConfig.config.color.default.r, BeltalowdaConfig.config.color.default.g, BeltalowdaConfig.config.color.default.b)
	control.statusLabel:SetText()
	control.statusLabel:SetDimensions(BeltalowdaConfig.config.controlWidth - BeltalowdaConfig.config.controlOffset * 2 - 75, 25)
	control.statusLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	control.statusLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
	return control
end

function BeltalowdaConfig.CreateEditControl(rootControl, width, height, maxChars, isMultiLine)
	control = wm:CreateControl(nil, rootControl, CT_CONTROL)
	control:SetDimensions(width, height)
	control:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	
	control.bd = wm:CreateControlFromVirtual(nil, control, "ZO_EditBackdrop")
	if isMultiLine == true then
		control.editbox = wm:CreateControlFromVirtual(nil, control.bd, "ZO_DefaultEditMultiLineForBackdrop")
	else
		control.editbox = wm:CreateControlFromVirtual(nil, control.bd, "ZO_DefaultEditForBackdrop")
	end
	
	
	control.bd:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.bd:SetDimensions(width, height)
	
	control.editbox:SetMaxInputChars(maxChars)

	
	control.editbox:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.editbox:SetDimensions(width, height)

	
	control.edge = wm:CreateControl(nil, control, CT_BACKDROP)
	control.edge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	control.edge:SetDimensions(width, height)
	control.edge:SetEdgeTexture(nil, 1, 1, 1, 0)
	control.edge:SetCenterColor(0, 0, 0, 0)
	control.edge:SetEdgeColor(BeltalowdaConfig.config.color.edgeColor.r, BeltalowdaConfig.config.color.edgeColor.g, BeltalowdaConfig.config.color.edgeColor.b, BeltalowdaConfig.config.color.edgeColor.a)
	
	return control
end

function BeltalowdaConfig.SetTlwLocation()
	if BeltalowdaConfig.configVars == nil or BeltalowdaConfig.configVars.position == nil then
		BeltalowdaConfig.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, 0, -BeltalowdaConfig.config.height / 2)
	else
		BeltalowdaConfig.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaConfig.configVars.position.x , BeltalowdaConfig.configVars.position.y)
	end
end

function BeltalowdaConfig.SlashCmd(param)
	if param ~= nil then
		if param[1] == "config" then
			BeltalowdaConfig.ToggleConfigInterface()
		end
	end
end

function BeltalowdaConfig.ToggleConfigInterface()
	BeltalowdaConfig.controls.TLW:SetHidden(not BeltalowdaConfig.controls.TLW:IsHidden())
	if BeltalowdaConfig.controls.TLW:IsHidden() == false then
		
	else
		
	end
	SetGameCameraUIMode(not BeltalowdaConfig.controls.TLW:IsHidden())
end

function BeltalowdaConfig.UpdateExportControl()
	BeltalowdaConfig.UpdateExportDropdownEntries()
	
end

function BeltalowdaConfig.UpdateImportControl()

end

function BeltalowdaConfig.UpdateExportDropdownEntries()
	BeltalowdaConfig.CreateExportDropdownEntries(BeltalowdaConfig.controls.TLW.body.rootControl.exportControl.dropdown)
end

function BeltalowdaConfig.CreateExportDropdownEntries(dropdown)
	dropdown:SetSortsItems(false)
	dropdown:ClearItems()
	local profiles = BeltalowdaProfile.GetAvailableProfiles()
	for i = 1, #profiles do
		if profiles[i] ~= nil then
			local entry = dropdown:CreateItemEntry(profiles[i], BeltalowdaConfig.SelectedExportProfileChanged)
			dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
			if profiles[i] == BeltalowdaConfig.state.selectedExportProfile then
				dropdown:SetSelected(i)
			end
		end
    end
end

function BeltalowdaConfig.GetLayerXData(rootLayer, prefix)
	local layerData = {}
	local layerString = ""
	for key, value in pairs(rootLayer) do
		local kType = BeltalowdaConfig.constants.syntax.types.STRING
		if type(key) == "number" then
			kType = BeltalowdaConfig.constants.syntax.types.NUMBER
		end
		if type(value) == "table" then
			local keyType = "s:"
			if type(key) == "number" then
				keyType = "n:"
			end
			local newPrefix = prefix
			if newPrefix == nil then
				newPrefix = keyType .. key
			else
				newPrefix = newPrefix .. BeltalowdaConfig.constants.syntax.LAYER_X_SEPERATOR .. keyType .. key
			end
			val = BeltalowdaConfig.constants.syntax.LAYER_X_START .. newPrefix .. BeltalowdaConfig.constants.syntax.LAYER_X_END .. "\r\n"
			val = val .. BeltalowdaConfig.GetLayerXData(value, newPrefix)
			table.insert(layerData, val)
		elseif type(value) == "number" then
			val = kType .. ":" .. key .. ":" .. BeltalowdaConfig.constants.syntax.types.NUMBER  .. ":" .. value .."\r\n"
			table.insert(layerData, 1, val)
		elseif type(value) == "boolean" then
			local bool = "true"
			if value == false then
				bool = "false"
			end
			val = kType .. ":" .. key .. ":".. BeltalowdaConfig.constants.syntax.types.BOOLEAN .. ":" .. bool .."\r\n"
			table.insert(layerData, 1, val)
		elseif type(value) == "string" then
			val = kType .. ":" .. key .. ":".. BeltalowdaConfig.constants.syntax.types.STRING .. ":" .. value .."\r\n"
			table.insert(layerData, 1, val)
		end
	end
	for i = 1, #layerData do
		layerString = layerString .. layerData[i]
	end
	return layerString
end

function BeltalowdaConfig.SplitConfigLines(config)
	local configList = nil
	if config ~= nil and type(config) == "string" then
		configList = {}
		local startIndex = 1
		for i = 1, string.len(config) - 1 do
			local sequence = string.sub(config, i, i + 1)
			if sequence == "\r\n" then
				local entry = string.sub(config, startIndex, i - 1)
				if entry ~= nil and entry ~= "" then
					table.insert(configList, entry)
				end
				startIndex = i + 2
			end
		end
		if startIndex ~= string.len(config) then
			local entry = string.sub(config, startIndex, string.len(config))
			if entry ~= nil and entry ~= "" then
				table.insert(configList, entry)
			end
		end
	end
	return configList
end

function BeltalowdaConfig.GetConfigList(config)
	local validConfig = false
	local configList = {}
	local version = nil
	local tempList = BeltalowdaConfig.SplitConfigLines(config)
	if tempList ~= nil and #tempList > 0 then
		BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_LINE_COUNT, #tempList), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		local currentLayer1 = nil
		local currentLayer2 = nil
		local currentLayerX = nil
		local workingLayer = nil
		for i = 1, #tempList do 
			if string.sub(tempList[i],1,1) == "#" then
				BeltalowdaChat.SendChatMessage("Comment", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
				local tmp = string.sub(tempList[i], 2, string.len(tempList[i]))
				local key, value = zo_strsplit(":",tmp)
				key = zo_strtrim(key)
				value = zo_strtrim(value)
				if key == BeltalowdaConfig.constants.syntax.identifiers.VERSION then
					version = value
				end
			else
				BeltalowdaChat.SendChatMessage("Entry Handling", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
				local cType = ""
				local firstSymbol = string.sub(tempList[i], 1, 1)
				if firstSymbol == BeltalowdaConfig.constants.syntax.LAYER_1_START then
					BeltalowdaChat.SendChatMessage("Layer 1", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
					currentLayer1 = string.sub(tempList[i], 2, string.len(tempList[i]) - 1)
					if currentLayer1 == nil or string.len(currentLayer1) == 0 then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					cType, currentLayer1 = zo_strsplit(":", currentLayer1)
					if cType == nil or currentLayer1 == nil or cType == "" or currentLayer1 == "" then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					if cType == "n" then
						currentLayer1 = tonumber(currentLayer1)
						if currentLayer1 == nil then
							BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
							return nil, version, false
						end
					end
					configList[currentLayer1] = configList[currentLayer1] or {}
					currentLayer2 = nil
					workingLayer = nil
				elseif firstSymbol == BeltalowdaConfig.constants.syntax.LAYER_2_START then
					BeltalowdaChat.SendChatMessage("Layer 2", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
					currentLayer2 = string.sub(tempList[i], 2, string.len(tempList[i]) - 1)
					if currentLayer2 == nil or string.len(currentLayer2) == 0 then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_2_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					cType, currentLayer2 = zo_strsplit(":", currentLayer2)
					if cType == nil or currentLayer2 == nil or cType == "" or currentLayer2 == "" then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_2_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					if configList[currentLayer1] == nil then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					if cType == "n" then
						currentLayer2 = tonumber(currentLayer2)
						if currentLayer2 == nil then
							BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
							return nil, version, false
						end
					end
					configList[currentLayer1][currentLayer2] = configList[currentLayer1][currentLayer2] or {}
					workingLayer = nil
				elseif firstSymbol == BeltalowdaConfig.constants.syntax.LAYER_X_START then
					BeltalowdaChat.SendChatMessage("Layer X", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
					currentLayerX = string.sub(tempList[i], 2, string.len(tempList[i]) - 1)
					if currentLayerX == nil or string.len(currentLayerX) == 0 then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_X_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					--d("1")
					if configList[currentLayer1] == nil or configList[currentLayer1][currentLayer2] == nil then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_2_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					--d("2")
					local xLayers = {zo_strsplit(".", currentLayerX)}
					
					if xLayers == nil or #xLayers == 0 then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_X_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					--d("3")
					local tempLayer = configList[currentLayer1][currentLayer2]
					for j = 1, #xLayers do
						local layer = nil
						cType, layer = zo_strsplit(":", xLayers[j])
						--d("---------")
						--d(cType)
						--d(layer)
						if cType == nil or layer == nil or cType == "" or layer == "" then
							BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
							return nil, version, false
						end
						if cType == "n" then
							layer = tonumber(layer)
							if layer == nil then
								BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
								return nil, version, false
							end
						end
						tempLayer[layer] = tempLayer[layer] or {}
						tempLayer = tempLayer[layer]
					end
					--d("4")
					workingLayer = tempLayer
				else
					BeltalowdaChat.SendChatMessage("Entry", BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
					if currentLayer1 == nil or currentLayer1 == "" or configList[currentLayer1] == nil then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					--d("1")
					local kType, key, vType, value = zo_strsplit(":", tempList[i])
					if kType == nil or key == nil or vType == nil --[[or value == nil]] then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_NIL), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					end
					--d("2")
					if kType ~= BeltalowdaConfig.constants.syntax.types.NUMBER and kType ~= BeltalowdaConfig.constants.syntax.types.STRING then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					else
						if kType == BeltalowdaConfig.constants.syntax.types.NUMBER then
							key = tonumber(key)
							if key == nil then
								BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
								return nil, version, false
							end
						end
					end
					--d("3")
					if vType ~= BeltalowdaConfig.constants.syntax.types.NUMBER and vType ~= BeltalowdaConfig.constants.syntax.types.STRING and vType ~= BeltalowdaConfig.constants.syntax.types.BOOLEAN then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
						return nil, version, false
					else
						if vType == BeltalowdaConfig.constants.syntax.types.NUMBER then
							value = tonumber(value)
							if value == nil then
								BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_NIL), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
								return nil, version, false
							end
						elseif vType == BeltalowdaConfig.constants.syntax.types.BOOLEAN then
							if value == "true" then
								value = true
							elseif value == "false" then
								value = false
							else
								BeltalowdaChat.SendChatMessage(string.format(BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON, i, BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_BOOLEAN), BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
								return nil, version, false
							end
						else
							if value == nil then
								value = ""
							end
						end
					end
					--d("4")
					if currentLayer2 == nil then
						configList[currentLayer1][key] = value
					else
						if workingLayer == nil then
							configList[currentLayer1][currentLayer2][key] = value
						else
							workingLayer[key] = value
						end
					end					
				end
			end
		end
		validConfig = true
	end
	return configList, version, validConfig
end

function BeltalowdaConfig.UpdateProfile(target, origin, addValues)
	if target ~= nil and origin ~= nil and addValues ~= nil then
		for key, value in pairs(origin) do
			if target[key] == nil then
				if addValues == true then
					if type(origin[key]) == "table" then
						target[key] = {}
						BeltalowdaConfig.UpdateProfile(target[key], origin[key], addValues)
					else
						target[key] = value
					end
				end
			else
				if type(origin[key]) == "table" then
					if type(target[key]) ~= "table" then
						target[key] = {}
					end
					BeltalowdaConfig.UpdateProfile(target[key], origin[key], addValues)
				else
					if type(target[key]) == type(origin[key]) then
						target[key] = origin[key]
					end
				end
			end
			
		end
	end
end

--[[
function BeltalowdaConfig.Test(configList, profile)
	local matches = 0
	local fails = 0
	if configList ~= nil and profile == nil or configList == nil and profile ~= nil then
		if configList == nil then
			d("emtpy configList")
		else
			d("emtpy profile")
		end
		return 0, 1
	end
	for key, value in pairs(profile) do
		if type(value) == "table" then
			local retM, retF = BeltalowdaConfig.Test(configList[key], profile[key])
		else
			if configList[key] == profile[key] then
				matches = matches + 1
			else
				fails = fails + 1
				d(key)
			end
		end
	end
	
	return matches, fails
end
]]

--callbacks
function BeltalowdaConfig.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaConfig.configVars = currentProfile.cfg
		if BeltalowdaConfig.state.initialized == true then
			BeltalowdaConfig.SetTlwLocation()
		end
	end
end

function BeltalowdaConfig.SaveWindowLocation()
	BeltalowdaConfig.configVars.position = BeltalowdaConfig.configVars.position or {}
	BeltalowdaConfig.configVars.position.x = BeltalowdaConfig.controls.TLW:GetLeft()
	BeltalowdaConfig.configVars.position.y = BeltalowdaConfig.controls.TLW:GetTop()
end

function BeltalowdaConfig.CloseWindow()
	BeltalowdaConfig.controls.TLW:SetHidden(true)
	SetGameCameraUIMode(not BeltalowdaConfig.controls.TLW:IsHidden())
end

function BeltalowdaConfig.OnKeyBinding()
	BeltalowdaConfig.ToggleConfigInterface()
end

function BeltalowdaConfig.SelectedExportProfileChanged(control, text, choice)
	local profile = BeltalowdaProfile.GetSpecificAccProfile(text)
	BeltalowdaConfig.state.selectedExportProfile = text
	--d(text)
	local config = "" 
	if profile ~= nil then
		config = config .. "#".. BeltalowdaConfig.constants.syntax.identifiers.VERSION .. ": " .. Beltalowda.versionString .. "\r\n"
		config = config .. "#Account: ".. GetDisplayName("player") .. "\r\n"
		config = config .. "#Profile: " .. text .. "\r\n"
		config = config .. "\r\n"
		
		--layer 1
		local layer1 = {}
		for key, value in pairs(profile) do
			if key ~= "name" then
				local kType = BeltalowdaConfig.constants.syntax.types.STRING
				if type(key) == "number" then
					kType = BeltalowdaConfig.constants.syntax.types.NUMBER
				end
				local val = ""
				if type(value) == "table" then
					local keyType = "s:"
					if type(key) == "number" then
						keyType = "n:"
					end
					val = BeltalowdaConfig.constants.syntax.LAYER_1_START .. keyType .. key .. BeltalowdaConfig.constants.syntax.LAYER_1_END .. "\r\n"
					local layer2 = {}
						
					for key2, value2 in pairs(value) do
						local kType2 = BeltalowdaConfig.constants.syntax.types.STRING
						if type(key2) == "number" then
							kType2 = BeltalowdaConfig.constants.syntax.types.NUMBER
						end
						local val2 = ""
						if type(value2) == "table" then
							local keyType2 = "s:"
							if type(key2) == "number" then
								keyType2 = "n:"
							end
							val2 = BeltalowdaConfig.constants.syntax.LAYER_2_START .. keyType2 .. key2 .. BeltalowdaConfig.constants.syntax.LAYER_2_END .. "\r\n"
							local layerX = BeltalowdaConfig.GetLayerXData(value2)
							if layerX ~= nil then
								val2 = val2 .. layerX
							end
							table.insert(layer2, val2)
						elseif type(value2) == "number" then
							val2 = kType2 .. ":" .. key2 .. ":" .. BeltalowdaConfig.constants.syntax.types.NUMBER .. ":" .. value2 .."\r\n"
							table.insert(layer2, 1, val2)
						elseif type(value2) == "boolean" then
							local bool = "true"
							if value2 == false then
								bool = "false"
							end
							val2 = kType2 .. ":" .. key2 .. ":" .. BeltalowdaConfig.constants.syntax.types.BOOLEAN .. ":" .. bool .."\r\n"
							table.insert(layer2, 1, val2)
						elseif type(value2) == "string" then
							val2 = kType2 .. ":" .. key2 .. ":" .. BeltalowdaConfig.constants.syntax.types.STRING .. ":" .. value2 .."\r\n"
							table.insert(layer2, 1, val2)
						end
						
						
					end
					for i = 1, #layer2 do
						val = val .. layer2[i]
					end
					table.insert(layer1, val)
				elseif type(value) == "number" then
					val = kType .. ":" .. key .. ":" .. BeltalowdaConfig.constants.syntax.types.NUMBER .. ":" .. value .."\r\n"
					table.insert(layer1, 1, val)
				elseif type(value) == "boolean" then
					local bool = "true"
					if value == false then
						bool = "false"
					end
					val = kType .. ":" .. key .. ":" .. BeltalowdaConfig.constants.syntax.types.BOOLEAN .. ":" .. bool .."\r\n"
					table.insert(layer1, 1, val)
				elseif type(value) == "string" then
					val = kType .. ":" .. key .. ":" .. BeltalowdaConfig.constants.syntax.types.STRING .. ":" .. value .."\r\n"
					table.insert(layer1, 1, val)
				end
				
			end
		end
		
		for i = 1, #layer1 do
			config = config .. layer1[i]
		end
	end
	if string.len(config) > 29903 then
		BeltalowdaChat.SendChatMessage(BeltalowdaConfig.constants.EXPORT_STRING_LENGTH_ERROR, BeltalowdaConfig.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	end
	BeltalowdaConfig.controls.TLW.body.rootControl.exportControl.config.editbox:SetText(config)
end

function BeltalowdaConfig.TabSelected(index)
	local control = BeltalowdaConfig.controls.TLW.body.tabControl.exportTab.backdrop
	local controlUnselected = BeltalowdaConfig.controls.TLW.body.tabControl.importTab.backdrop
	BeltalowdaConfig.state.selectedTab = BeltalowdaConfig.constants.TAB_EXPORT
	if index == BeltalowdaConfig.constants.TAB_IMPORT then
		control = BeltalowdaConfig.controls.TLW.body.tabControl.importTab.backdrop
		controlUnselected = BeltalowdaConfig.controls.TLW.body.tabControl.exportTab.backdrop
		BeltalowdaConfig.state.selectedTab = BeltalowdaConfig.constants.TAB_IMPORT
	end
	control:SetCenterColor(BeltalowdaConfig.config.color.tabSelected.r, BeltalowdaConfig.config.color.tabSelected.g, BeltalowdaConfig.config.color.tabSelected.b, BeltalowdaConfig.config.color.tabSelected.a)
	controlUnselected:SetCenterColor(BeltalowdaConfig.config.color.tabNotSelected.r, BeltalowdaConfig.config.color.tabNotSelected.g, BeltalowdaConfig.config.color.tabNotSelected.b, BeltalowdaConfig.config.color.tabNotSelected.a)

	if index == BeltalowdaConfig.constants.TAB_IMPORT then
		BeltalowdaConfig.controls.TLW.body.rootControl.exportControl:SetHidden(true)
		BeltalowdaConfig.controls.TLW.body.rootControl.importControl:SetHidden(false)
		BeltalowdaConfig.UpdateImportControl()
	else
		BeltalowdaConfig.controls.TLW.body.rootControl.exportControl:SetHidden(false)
		BeltalowdaConfig.controls.TLW.body.rootControl.importControl:SetHidden(true)
		BeltalowdaConfig.UpdateExportControl()
	end
end

function BeltalowdaConfig.TabOnMouseEnter(index)
	local control = BeltalowdaConfig.controls.TLW.body.tabControl.exportTab.backdrop
	if index == BeltalowdaConfig.constants.TAB_IMPORT then
		control = BeltalowdaConfig.controls.TLW.body.tabControl.importTab.backdrop
	end
	control:SetCenterColor(BeltalowdaConfig.config.color.tabMouseOver.r, BeltalowdaConfig.config.color.tabMouseOver.g, BeltalowdaConfig.config.color.tabMouseOver.b, BeltalowdaConfig.config.color.tabMouseOver.a)
end

function BeltalowdaConfig.TabOnMouseExit(index)
	local control = BeltalowdaConfig.controls.TLW.body.tabControl.exportTab.backdrop
	if index == BeltalowdaConfig.constants.TAB_IMPORT then
		control = BeltalowdaConfig.controls.TLW.body.tabControl.importTab.backdrop
	end
	local color = BeltalowdaConfig.config.color.tabSelected
	if index ~= BeltalowdaConfig.state.selectedTab then
		color = BeltalowdaConfig.config.color.tabNotSelected
	end
	control:SetCenterColor(color.r, color.g, color.b, color.a)
end

function BeltalowdaConfig.SelectAllExportText()
	BeltalowdaConfig.controls.TLW.body.rootControl.exportControl.config.editbox:SelectAll()
	BeltalowdaConfig.controls.TLW.body.rootControl.exportControl.config.editbox:TakeFocus()
end

function BeltalowdaConfig.Import()
	local statusLabel = BeltalowdaConfig.controls.TLW.body.rootControl.importControl.statusLabel
	statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_STARTED)
	local profileName = BeltalowdaConfig.controls.TLW.body.rootControl.importControl.name.editbox:GetText()
	if profileName ~= nil then
		profileName = zo_strtrim(profileName)
	end
	if profileName == nil or profileName == "" then
		statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_INVALID_NAME)
		return
	end
	if BeltalowdaProfile.ProfileExists(profileName) == true then
		statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_DUPLICATE)
		return
	end
	local config = BeltalowdaConfig.controls.TLW.body.rootControl.importControl.config.editbox:GetText()
	if config ~= nil then
		config = zo_strtrim(config)
	end
	if config == nil or config == "" then
		statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_NO_CONTENT)
		return
	end
	local configList, version, validConfig = BeltalowdaConfig.GetConfigList(config)
	
	if validConfig == true then
		local localVersion = Beltalowda.versionString
		--d(version)
		--[[
		local m, f = BeltalowdaConfig.Test(configList, BeltalowdaProfile.GetSpecificAccProfile("Default"))
		d(m)
		d(f)
		m, f = BeltalowdaConfig.Test(BeltalowdaProfile.GetSpecificAccProfile("Default"), configList)
		d(m)
		d(f)
		]]
		
		local newProfile = Beltalowda.CreateCleanProfile()
		newProfile.name = profileName
		
		BeltalowdaConfig.UpdateProfile(newProfile, configList, ZO_CheckButton_IsChecked(BeltalowdaConfig.controls.TLW.body.rootControl.importControl.chkAddAllValues))
		
		BeltalowdaProfile.AddNewProfileData(newProfile)
		if localVersion == version then
			statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED)
		else
			statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED_DIFFERENT_VERSION)
		end
	else
		statusLabel:SetText(BeltalowdaConfig.constants.IMPORT_STATUS_FAILED)
	end
	
end

--menu
function BeltalowdaConfig.GetMenu()
	local menu = nil
	return menu
end