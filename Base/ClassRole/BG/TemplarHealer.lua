-- Beltalowda Class Role
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.classRole = Beltalowda.classRole or {}
local BeltalowdaCR = Beltalowda.classRole
BeltalowdaCR.bg = BeltalowdaCR.bg or {}
local BeltalowdaBG = BeltalowdaCR.bg
BeltalowdaBG.tpHeal = BeltalowdaBG.tpHeal or {}
local BeltalowdaTH = BeltalowdaBG.tpHeal
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
Beltalowda.ui = Beltalowda.ui or {}
local BeltalowdaUI = Beltalowda.ui
BeltalowdaUI.buffs = BeltalowdaUI.buffs or {}
local BeltalowdaBuffs = BeltalowdaUI.buffs



BeltalowdaTH.constants = BeltalowdaTH.constants or {}
BeltalowdaTH.constants.TLW = "Beltalowda.classRole.bg.tpHeal.tlw"
BeltalowdaTH.constants.BUFF_TYPES = {}
BeltalowdaTH.constants.BUFF_TYPES.DAMAGE = 1
BeltalowdaTH.constants.BUFF_TYPES.HEALING = 2
BeltalowdaTH.constants.BUFF_TYPES.RECOVERY = 3
BeltalowdaTH.constants.COOLDOWN_TYPES = {}
BeltalowdaTH.constants.COOLDOWN_TYPES.NONE = 1
BeltalowdaTH.constants.COOLDOWN_TYPES.PROC = 2

BeltalowdaTH.callbackName = Beltalowda.addonName .. "BGTemplarHealer"

BeltalowdaTH.config = {}
BeltalowdaTH.config.updateInterval = 100
BeltalowdaTH.config.isClampedToScreen = false
BeltalowdaTH.config.width = 150

BeltalowdaTH.config.buffs = {}
BeltalowdaTH.config.buffs[1] = {}
BeltalowdaTH.config.buffs[1].texture = "/esoui/art/icons/ability_buff_major_sorcery.dds"
BeltalowdaTH.config.buffs[1].ids = {}
BeltalowdaTH.config.buffs[1].ids[1] = 92503
BeltalowdaTH.config.buffs[1].name = "majorSorcery"
BeltalowdaTH.config.buffs[1].buffType = BeltalowdaTH.constants.BUFF_TYPES.DAMAGE
BeltalowdaTH.config.buffs[1].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[2] = {}
BeltalowdaTH.config.buffs[2].texture = "/esoui/art/icons/ability_buff_minor_sorcery.dds"
BeltalowdaTH.config.buffs[2].ids = {}
BeltalowdaTH.config.buffs[2].ids[1] = 62800
BeltalowdaTH.config.buffs[2].name = "minorSorcery"
BeltalowdaTH.config.buffs[2].buffType = BeltalowdaTH.constants.BUFF_TYPES.DAMAGE
BeltalowdaTH.config.buffs[2].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[3] = {}
BeltalowdaTH.config.buffs[3].texture = "/esoui/art/icons/ability_mage_045.dds" -- courage
BeltalowdaTH.config.buffs[3].ids = {}
BeltalowdaTH.config.buffs[3].ids[1] = 109994
BeltalowdaTH.config.buffs[3].name = "majorCourage"
BeltalowdaTH.config.buffs[3].buffType = BeltalowdaTH.constants.BUFF_TYPES.DAMAGE
BeltalowdaTH.config.buffs[3].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[4] = {}
BeltalowdaTH.config.buffs[4].texture = "/esoui/art/icons/ava_artifact_006.dds" -- weapon glyph
BeltalowdaTH.config.buffs[4].ids = {}
BeltalowdaTH.config.buffs[4].ids[1] = 21230
BeltalowdaTH.config.buffs[4].name = "weaponGlyph"
BeltalowdaTH.config.buffs[4].buffType = BeltalowdaTH.constants.BUFF_TYPES.DAMAGE
BeltalowdaTH.config.buffs[4].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.PROC
BeltalowdaTH.config.buffs[4].cooldown = {}
BeltalowdaTH.config.buffs[4].cooldown.lastProc = 0
BeltalowdaTH.config.buffs[4].cooldown.duration = 10
BeltalowdaTH.config.buffs[5] = {}
BeltalowdaTH.config.buffs[5].texture = "/esoui/art/icons/ability_weapon_028.dds" -- continous attack
BeltalowdaTH.config.buffs[5].ids = {}
BeltalowdaTH.config.buffs[5].ids[1] = 45617
BeltalowdaTH.config.buffs[5].name = "continousAttack"
BeltalowdaTH.config.buffs[5].buffType = BeltalowdaTH.constants.BUFF_TYPES.DAMAGE
BeltalowdaTH.config.buffs[5].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[6] = {}
BeltalowdaTH.config.buffs[6].texture = "/esoui/art/icons/ability_buff_major_mending.dds"
BeltalowdaTH.config.buffs[6].ids = {}
BeltalowdaTH.config.buffs[6].ids[1] = 77922
BeltalowdaTH.config.buffs[6].name = "majorMending"
BeltalowdaTH.config.buffs[6].buffType = BeltalowdaTH.constants.BUFF_TYPES.HEALING
BeltalowdaTH.config.buffs[6].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[7] = {}
BeltalowdaTH.config.buffs[7].texture = "/esoui/art/icons/ability_buff_minor_mending.dds"
BeltalowdaTH.config.buffs[7].ids = {}
BeltalowdaTH.config.buffs[7].ids[1] = 77082
BeltalowdaTH.config.buffs[7].ids[2] = 31759
BeltalowdaTH.config.buffs[7].name = "minorMending"
BeltalowdaTH.config.buffs[7].buffType = BeltalowdaTH.constants.BUFF_TYPES.HEALING
BeltalowdaTH.config.buffs[7].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[8] = {}
BeltalowdaTH.config.buffs[8].texture = "/esoui/art/icons/ability_templar_channeled_focus.dds"
BeltalowdaTH.config.buffs[8].ids = {}
BeltalowdaTH.config.buffs[8].ids[1] = 37009
BeltalowdaTH.config.buffs[8].name = "channeledFocus"
BeltalowdaTH.config.buffs[8].buffType = BeltalowdaTH.constants.BUFF_TYPES.RECOVERY
BeltalowdaTH.config.buffs[8].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.buffs[9] = {}
BeltalowdaTH.config.buffs[9].texture = "/esoui/art/icons/ability_mage_045.dds" -- lich
BeltalowdaTH.config.buffs[9].ids = {}
BeltalowdaTH.config.buffs[9].ids[1] = 57164
BeltalowdaTH.config.buffs[9].name = "lich"
BeltalowdaTH.config.buffs[9].buffType = BeltalowdaTH.constants.BUFF_TYPES.RECOVERY
BeltalowdaTH.config.buffs[9].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.PROC
BeltalowdaTH.config.buffs[9].cooldown = {}
BeltalowdaTH.config.buffs[9].cooldown.lastProc = 0
BeltalowdaTH.config.buffs[9].cooldown.duration = 60
BeltalowdaTH.config.buffs[10] = {}
BeltalowdaTH.config.buffs[10].texture = "/esoui/art/icons/ability_buff_major_intellect.dds"
BeltalowdaTH.config.buffs[10].ids = {}
BeltalowdaTH.config.buffs[10].ids[1] = 45224
BeltalowdaTH.config.buffs[10].name = "majorIntellect"
BeltalowdaTH.config.buffs[10].buffType = BeltalowdaTH.constants.BUFF_TYPES.RECOVERY
BeltalowdaTH.config.buffs[10].cdType = BeltalowdaTH.constants.COOLDOWN_TYPES.NONE
BeltalowdaTH.config.height = #BeltalowdaTH.config.buffs * 20

BeltalowdaTH.state = {}
BeltalowdaTH.state.initialized = false
BeltalowdaTH.state.foreground = true
BeltalowdaTH.state.registredConsumers = false
BeltalowdaTH.state.registredActiveConsumers = false
BeltalowdaTH.state.activeLayerIndex = 1

BeltalowdaTH.controls = {}

local wm = WINDOW_MANAGER
local buffControls = nil

function BeltalowdaTH.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaTH.callbackName, BeltalowdaTH.OnProfileChanged)
	
	BeltalowdaTH.CreateUI()
	
	buffControls = BeltalowdaTH.controls.TLW.rootControl.buffs
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaTH.SetCrBgTpHealPositionLocked)
	
	BeltalowdaTH.state.initialized = true
	BeltalowdaTH.AdjustColors()
	BeltalowdaTH.SetEnabled(BeltalowdaTH.tpVars.enabled)
end

function BeltalowdaTH.SetTlwLocation()
	if BeltalowdaTH.tpVars.location == nil then
		BeltalowdaTH.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -200, -125)
	else
		BeltalowdaTH.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaTH.tpVars.location.x, BeltalowdaTH.tpVars.location.y)
	end
end

function BeltalowdaTH.CreateUI()
	BeltalowdaTH.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaTH.constants.TLW)
	
	BeltalowdaTH.SetTlwLocation()
	
	
	BeltalowdaTH.controls.TLW:SetClampedToScreen(BeltalowdaTH.config.isClampedToScreen)
	BeltalowdaTH.controls.TLW:SetHandler("OnMoveStop", BeltalowdaTH.SaveWindowLocation)
	BeltalowdaTH.controls.TLW:SetDimensions(BeltalowdaTH.config.width, BeltalowdaTH.config.height)
	
	BeltalowdaTH.controls.TLW.rootControl = wm:CreateControl(nil, BeltalowdaTH.controls.TLW, CT_CONTROL)
	
	local rootControl = BeltalowdaTH.controls.TLW.rootControl
	
	rootControl:SetDimensions(BeltalowdaTH.config.width, BeltalowdaTH.config.height)
	rootControl:SetAnchor(TOPLEFT, BeltalowdaTH.controls.TLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.movableBackdrop:SetDimensions(BeltalowdaTH.config.width, BeltalowdaTH.config.height)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.buffs = {}
	for i = 1, 10 do
		rootControl.buffs[i] = BeltalowdaBuffs.CreateBuffControl(rootControl, 0, (i - 1) * 20)
		rootControl.buffs[i].texture:SetTexture(BeltalowdaTH.config.buffs[i].texture)
	end
	
end

function BeltalowdaTH.GetDefaults()
	local defaults = {}
	
	return defaults
end

function BeltalowdaTH.GetCharDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.damageColor = {}
	defaults.damageColor.r = 0.9
	defaults.damageColor.g = 0.2
	defaults.damageColor.b = 0.2
	defaults.healingColor = {}
	defaults.healingColor.r = 0.2
	defaults.healingColor.g = 0.9
	defaults.healingColor.b = 0.2
	defaults.recoveryColor = {}
	defaults.recoveryColor.r = 0.2
	defaults.recoveryColor.g = 0.2
	defaults.recoveryColor.b = 0.9
	defaults.damageLabelColor = {}
	defaults.damageLabelColor.r = 1
	defaults.damageLabelColor.g = 1
	defaults.damageLabelColor.b = 1
	defaults.healingLabelColor = {}
	defaults.healingLabelColor.r = 1
	defaults.healingLabelColor.g = 1
	defaults.healingLabelColor.b = 1
	defaults.recoveryLabelColor = {}
	defaults.recoveryLabelColor.r = 1
	defaults.recoveryLabelColor.g = 1
	defaults.recoveryLabelColor.b = 1
	defaults.cooldownLabelColor = {}
	defaults.cooldownLabelColor.r = 1
	defaults.cooldownLabelColor.g = 0.1
	defaults.cooldownLabelColor.b = 0.1
	return defaults
end

function BeltalowdaTH.SetEnabled(value)
	if BeltalowdaTH.state.initialized == true and value ~= nil then
		BeltalowdaTH.tpVars.enabled = value
		if value == true then
			if BeltalowdaTH.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaTH.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaTH.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaTH.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaTH.SetForegroundVisibility)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaTH.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaTH.OnPlayerActivated)
			end
			BeltalowdaTH.state.registredConsumers = true
		else
			if BeltalowdaTH.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaTH.callbackName, EVENT_ACTION_LAYER_POPPED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaTH.callbackName, EVENT_ACTION_LAYER_PUSHED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaTH.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaTH.state.registredConsumers = false
		end
		BeltalowdaTH.SetControlVisibility()
		BeltalowdaTH.OnPlayerActivated()
	end
end

function BeltalowdaTH.GetBuffColors(buffType)
	local color = BeltalowdaTH.tpVars.damageColor
	local textColor = BeltalowdaTH.tpVars.damageLabelColor
	if buffType == BeltalowdaTH.constants.BUFF_TYPES.HEALING then
		color = BeltalowdaTH.tpVars.healingColor
		textColor = BeltalowdaTH.tpVars.healingLabelColor
	elseif buffType == BeltalowdaTH.constants.BUFF_TYPES.RECOVERY then
		color = BeltalowdaTH.tpVars.recoveryColor
		textColor = BeltalowdaTH.tpVars.recoveryLabelColor
	end
	return color, textColor
end

function BeltalowdaTH.AdjustColors()
	for i = 1, #buffControls do
		local color, textColor = BeltalowdaTH.GetBuffColors(BeltalowdaTH.config.buffs[i].buffType)

		buffControls[i].progress:SetColor(color.r, color.g, color.b ,0.7)
		buffControls[i].timeLabel:SetColor(textColor.r, textColor.g, textColor.b ,1.0)
	end
end

function BeltalowdaTH.SetPositionLocked(value)
	BeltalowdaTH.tpVars.positionLocked = value
	BeltalowdaTH.controls.TLW:SetMovable(not value)
	BeltalowdaTH.controls.TLW:SetMouseEnabled(not value)
	
	if value == true then
		BeltalowdaTH.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaTH.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaTH.controls.TLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaTH.controls.TLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
	--BeltalowdaTH.SetControlVisibility()
end

function BeltalowdaTH.SetControlVisibility()
	local enabled = BeltalowdaTH.tpVars.enabled
	local pvpOnly = BeltalowdaTH.tpVars.pvpOnly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaTH.state.foreground == false then
			BeltalowdaTH.controls.TLW:SetHidden(BeltalowdaTH.state.activeLayerIndex > 2)
		else
			BeltalowdaTH.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaTH.controls.TLW:SetHidden(setHidden)
	end
end

function BeltalowdaTH.AdjustProgress(buff, control, currentTime)
	local timer = 0
	local percent = 0
	if buff ~= nil then
		buff.remaining = buff.ending - (currentTime / 1000)
		if buff.remaining < 0 then
			buff.remaining = 0
		end
		timer = buff.remaining
		--d(timer)
		
		
		if buff.started == buff.ending and buff.started == 0 then
			percent = 100
		else
			if buff.remaining > 0 then
				percent = 100 / (buff.ending - buff.started) * buff.remaining
			end
		end
		
	end
	control.timeLabel:SetText(string.format("%.1f", timer))
	control.progress:SetValue(percent)
end

function BeltalowdaTH.CreateCharVars()
		local charVars = Beltalowda.profile.GetCharacterVars()
		charVars.crBgTp = charVars.crBgTp or {}
		BeltalowdaTH.tpVars = charVars.crBgTp
		
		local defaults = BeltalowdaTH.GetCharDefaults()
		
		Beltalowda.PopulateWithDefaults(BeltalowdaTH.tpVars, defaults)
		
end

--callbacks
function BeltalowdaTH.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		--BeltalowdaTH.tpVars = currentProfile.classRole.bg.tpHeal
		BeltalowdaTH.CreateCharVars()

		if BeltalowdaTH.state.initialized == true then
			BeltalowdaTH.SetControlVisibility()
			BeltalowdaTH.AdjustColors()
			BeltalowdaTH.SetPositionLocked(BeltalowdaTH.tpVars.positionLocked)
			BeltalowdaTH.SetTlwLocation()
		end
		BeltalowdaTH.SetEnabled(BeltalowdaTH.tpVars.enabled)
		
	end
end

function BeltalowdaTH.SaveWindowLocation()
	if BeltalowdaTH.tpVars.positionLocked == false then
		BeltalowdaTH.tpVars.location = BeltalowdaTH.tpVars.location or {}
		BeltalowdaTH.tpVars.location.x = BeltalowdaTH.controls.TLW:GetLeft()
		BeltalowdaTH.tpVars.location.y = BeltalowdaTH.controls.TLW:GetTop()
	end
end

function BeltalowdaTH.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaTH.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaTH.state.foreground = false
	end
	--hack?
	BeltalowdaTH.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaTH.SetControlVisibility()
end

function BeltalowdaTH.OnPlayerActivated(eventCode, initial)
	if BeltalowdaTH.tpVars.enabled == true and (BeltalowdaTH.tpVars.pvpOnly == false or (BeltalowdaTH.tpVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaTH.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaTH.callbackName, BeltalowdaTH.config.updateInterval, BeltalowdaTH.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaTH.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaTH.config.updateInterval)
			BeltalowdaUtilGroup.SetCrBgTpHealBuffs(BeltalowdaTH.config.buffs)
			
			BeltalowdaTH.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaTH.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaTH.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaTH.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			BeltalowdaUtilGroup.SetCrBgTpHealBuffs(nil)
			
			BeltalowdaTH.state.registredActiveConsumers = false
		end
	end
	BeltalowdaTH.SetControlVisibility()
end

function BeltalowdaTH.UiLoop()
	--d("loop")
	if BeltalowdaTH.tpVars.pvpOnly == false or (BeltalowdaTH.tpVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) then
		--d("inner loop")
		local buffs = BeltalowdaUtilGroup.GetUnitFromRawCharName(GetRawUnitName("player")).buffs
		if buffs ~= nil and buffs.specialInformation ~= nil and buffs.specialInformation.crBgTpHealBuffs ~= nil then
			buffs = BeltalowdaUtilGroup.GetUnitFromRawCharName(GetRawUnitName("player")).buffs.specialInformation.crBgTpHealBuffs
			local confBuffs = BeltalowdaTH.config.buffs
			local currentTime = GetGameTimeMilliseconds()
			--d(buffs)
			for i = 1, #confBuffs do
				BeltalowdaTH.AdjustProgress(buffs[confBuffs[i].name], buffControls[i], currentTime)
				if confBuffs[i].cdType == BeltalowdaTH.constants.COOLDOWN_TYPES.PROC then
					local buff = buffs[confBuffs[i].name]
					local _, labelColor = BeltalowdaTH.GetBuffColors(confBuffs[i].buffType)
					if buff == nil then
						if confBuffs[i].cooldown.lastProc > 0 then
							local timeSinceProc = currentTime / 1000 - confBuffs[i].cooldown.lastProc
							local timer = confBuffs[i].cooldown.duration - timeSinceProc
							if timer < 0 then
								timer = 0
							end
							if timer > 0 then
								labelColor = BeltalowdaTH.tpVars.cooldownLabelColor
							end
							buffControls[i].timeLabel:SetColor(labelColor.r, labelColor.g, labelColor.b ,1.0)
							buffControls[i].timeLabel:SetText(string.format("%.1f", timer))
						end
					else
						
						confBuffs[i].cooldown.lastProc = buff.started
						buffControls[i].timeLabel:SetColor(labelColor.r, labelColor.g, labelColor.b ,1.0)
					end
				end
			end
		end
	end
end


--menu interaction
function BeltalowdaTH.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CRBG_TPHEAL_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_ENABLED,
					getFunc = BeltalowdaTH.GetCrBgTpHealEnabled,
					setFunc = BeltalowdaTH.SetCrBgTpHealEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_PVP_ONLY,
					getFunc = BeltalowdaTH.GetCrBgTpHealPvpOnly,
					setFunc = BeltalowdaTH.SetCrBgTpHealPvpOnly
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_POSITION_FIXED,
					getFunc = BeltalowdaTH.GetCrBgTpHealPositionLocked,
					setFunc = BeltalowdaTH.SetCrBgTpHealPositionLocked
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_DAMAGE,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorProgressDamage,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorProgressDamage,
					width = "full"
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_DAMAGE,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorLabelDamage,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorLabelDamage,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_HEALING,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorProgressHealing,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorProgressHealing,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_HEALING,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorLabelHealing,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorLabelHealing,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_RECOVERY,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorProgressRecovery,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorProgressRecovery,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_RECOVERY,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorLabelRecovery,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorLabelRecovery,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_COOLDOWN,
					getFunc = BeltalowdaTH.GetCrBgTpHealColorLabelCooldown,
					setFunc = BeltalowdaTH.SetCrBgTpHealColorLabelCooldown,
					width = "full"
				},
			}
		},
	}
	return menu
end

function BeltalowdaTH.GetCrBgTpHealEnabled()
	return BeltalowdaTH.tpVars.enabled
end

function BeltalowdaTH.SetCrBgTpHealEnabled(value)
	BeltalowdaTH.SetEnabled(value)
end

function BeltalowdaTH.GetCrBgTpHealPositionLocked()
	return BeltalowdaTH.tpVars.positionLocked
end

function BeltalowdaTH.SetCrBgTpHealPositionLocked(value)
	BeltalowdaTH.SetPositionLocked(value)
end

function BeltalowdaTH.GetCrBgTpHealPvpOnly()
	return BeltalowdaTH.tpVars.pvpOnly
end

function BeltalowdaTH.SetCrBgTpHealPvpOnly(value)
	BeltalowdaTH.tpVars.pvpOnly = value
	BeltalowdaTH.SetEnabled(BeltalowdaTH.tpVars.enabled)
end

function BeltalowdaTH.GetCrBgTpHealColorProgressDamage()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.damageColor)
end

function BeltalowdaTH.SetCrBgTpHealColorProgressDamage(r, g, b)
	BeltalowdaTH.tpVars.damageColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorProgressRecovery()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.recoveryColor)
end

function BeltalowdaTH.SetCrBgTpHealColorProgressRecovery(r, g, b)
	BeltalowdaTH.tpVars.recoveryColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorProgressHealing()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.healingColor)
end

function BeltalowdaTH.SetCrBgTpHealColorProgressHealing(r, g, b)
	BeltalowdaTH.tpVars.healingColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorLabelDamage()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.damageLabelColor)
end

function BeltalowdaTH.SetCrBgTpHealColorLabelDamage(r, g, b)
	BeltalowdaTH.tpVars.damageLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorLabelRecovery()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.recoveryLabelColor)
end

function BeltalowdaTH.SetCrBgTpHealColorLabelRecovery(r, g, b)
	BeltalowdaTH.tpVars.recoveryLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorLabelHealing()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.healingLabelColor)
end

function BeltalowdaTH.SetCrBgTpHealColorLabelHealing(r, g, b)
	BeltalowdaTH.tpVars.healingLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end

function BeltalowdaTH.GetCrBgTpHealColorLabelCooldown()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaTH.tpVars.cooldownLabelColor)
end

function BeltalowdaTH.SetCrBgTpHealColorLabelCooldown(r, g, b)
	BeltalowdaTH.tpVars.cooldownLabelColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaTH.AdjustColors()
end