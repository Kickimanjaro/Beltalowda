-- Beltalowda UI Buffs
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.ui = Beltalowda.ui or {}
local BeltalowdaUI = Beltalowda.ui
BeltalowdaUI.buffs = BeltalowdaUI.buffs or {}
local BeltalowdaBuffs = BeltalowdaUI.buffs
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

local wm = WINDOW_MANAGER

BeltalowdaBuffs.config = {}
BeltalowdaBuffs.config.defaults = {}
BeltalowdaBuffs.config.defaults.width = 150
BeltalowdaBuffs.config.defaults.height = 20

function BeltalowdaBuffs.CreateBuffControl(tlw, rLocX, rLocY)
	local control = nil
	if tlw ~= nil then
		local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.MEDIUM_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaBuffs.config.defaults.height - 4, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
		
		control = wm:CreateControl(nil, tlw, CT_CONTROL)
			
		control:SetDimensions(BeltalowdaBuffs.config.defaults.width, BeltalowdaBuffs.config.defaults.height)
		control:SetAnchor(TOPLEFT, tlw, TOPLEFT, rLocX, rLocY)
		
		control.backdrop = wm:CreateControl(nil, control, CT_BACKDROP)
		control.backdrop:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.backdrop:SetDimensions(BeltalowdaBuffs.config.defaults.width, BeltalowdaBuffs.config.defaults.height)
		control.backdrop:SetCenterColor(1, 0, 0, 0.0)
		control.backdrop:SetEdgeColor(1, 0, 0, 0.0)
		
		control.edge = wm:CreateControl(nil, control, CT_BACKDROP)
		control.edge:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		control.edge:SetDimensions(BeltalowdaBuffs.config.defaults.width, BeltalowdaBuffs.config.defaults.height)
		control.edge:SetEdgeTexture(nil, 1, 1, 1, 0)
		control.edge:SetCenterColor(0, 0, 0, 0)
		control.edge:SetEdgeColor(0, 0, 0, 1)
		
		control.progress = wm:CreateControl(nil, control, CT_STATUSBAR)
		control.progress:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaBuffs.config.defaults.height - 1, 1)
		control.progress:SetDimensions(BeltalowdaBuffs.config.defaults.width - BeltalowdaBuffs.config.defaults.height, BeltalowdaBuffs.config.defaults.height - 2)
		control.progress:SetMinMax(0, 100)
		control.progress:SetValue(0)
		
		control.timeLabel = wm:CreateControl(nil, control, CT_LABEL)
		control.timeLabel:SetAnchor(TOPLEFT, control, TOPLEFT, BeltalowdaBuffs.config.defaults.height, 0)
		control.timeLabel:SetFont(font)
		control.timeLabel:SetWrapMode(ELLIPSIS)
		control.timeLabel:SetDimensions(BeltalowdaBuffs.config.defaults.width - BeltalowdaBuffs.config.defaults.height, BeltalowdaBuffs.config.defaults.height - 2)
		--control.timeLabel:SetText("test")
		control.timeLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control.timeLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
		
		control.texture = wm:CreateControl(nil, control, CT_TEXTURE)
		control.texture:SetAnchor(TOPLEFT, control, TOPLEFT, 1, 1)
		control.texture:SetDimensions(BeltalowdaBuffs.config.defaults.height - 2, BeltalowdaBuffs.config.defaults.height - 2)
		
	end
	return control
end

