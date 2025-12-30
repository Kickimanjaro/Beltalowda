-- Beltalowda Buff Food Tracker
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.bft = BeltalowdaTB.bft or {}
local BeltalowdaBft = BeltalowdaTB.bft
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.sound = BeltalowdaUtil.sound or {}
local BeltalowdaSound = BeltalowdaUtil.sound
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

BeltalowdaBft.constants = BeltalowdaBft.constants or {}
BeltalowdaBft.constants.TLW_ALERT_MESSAGE = "Beltalowda.group.bft.tlw"

BeltalowdaBft.constants.ALERT_INTERVAL = 30000

BeltalowdaBft.callbackName = Beltalowda.addonName .. "BuffFoodTracker"

BeltalowdaBft.config = {}
BeltalowdaBft.config.updateInterval = 100
BeltalowdaBft.config.isClampedToScreen = true
BeltalowdaBft.config.ratio = 6.0

BeltalowdaBft.state = {}
BeltalowdaBft.state.initialized = false
BeltalowdaBft.state.foreground = true
BeltalowdaBft.state.registredConsumers = false
BeltalowdaBft.state.lastAlert = 0
BeltalowdaBft.state.outOfLoadingScreen = false
BeltalowdaBft.state.registredActiveConsumers = false
BeltalowdaBft.state.activeLayerIndex = 1

BeltalowdaBft.controls = {}

local wm = WINDOW_MANAGER

function BeltalowdaBft.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaBft.callbackName, BeltalowdaBft.OnProfileChanged)
	
	BeltalowdaBft.state.sounds = BeltalowdaSound.GetRestrictedSounds()
	
	BeltalowdaBft.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaBft.SetBftPositionLocked)
	
	BeltalowdaBft.state.initialized = true
	BeltalowdaBft.InitializeControlSettings()
end

function BeltalowdaBft.InitializeControlSettings()
	BeltalowdaBft.SetEnabled(BeltalowdaBft.bftVars.enabled)
	BeltalowdaBft.SetControlVisibility()
	BeltalowdaBft.SetPositionLocked(BeltalowdaBft.bftVars.positionLocked)
	BeltalowdaBft.AdjustColors()
	BeltalowdaBft.AdjustSize()
end

function BeltalowdaBft.SetTlwLocation()
	BeltalowdaBft.controls.alertTLW:ClearAnchors()
	if BeltalowdaBft.bftVars.location == nil then
		BeltalowdaBft.controls.alertTLW:SetAnchor(CENTER, GuiRoot, CENTER, 450, -450)
	else
		BeltalowdaBft.controls.alertTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaBft.bftVars.location.x, BeltalowdaBft.bftVars.location.y)
	end
end

function BeltalowdaBft.CreateUI()
	BeltalowdaBft.controls.alertTLW = wm:CreateTopLevelWindow(BeltalowdaBft.constants.TLW_ALERT_MESSAGE)
	
	BeltalowdaBft.SetTlwLocation()
	
	BeltalowdaBft.controls.alertTLW:SetClampedToScreen(BeltalowdaBft.config.isClampedToScreen)
	BeltalowdaBft.controls.alertTLW:SetHandler("OnMoveStop", BeltalowdaBft.SaveWindowLocation)
	
	BeltalowdaBft.controls.alertTLW.rootControl = wm:CreateControl(nil, BeltalowdaBft.controls.alertTLW, CT_CONTROL)
	local rootControl = BeltalowdaBft.controls.alertTLW.rootControl
	
	rootControl:SetAnchor(TOPLEFT, BeltalowdaBft.controls.alertTLW, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop = wm:CreateControl(nil, rootControl, CT_BACKDROP)
	
	rootControl.movableBackdrop:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	
	rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	rootControl.alertLabel = wm:CreateControl(nil, rootControl, CT_LABEL)
	rootControl.alertLabel:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 3, 0)
	rootControl.alertLabel:SetWrapMode(ELLIPSIS)
	rootControl.alertLabel:SetText("")
	
end

function BeltalowdaBft.AdjustSize()
	BeltalowdaBft.controls.alertTLW:SetDimensions(BeltalowdaBft.config.ratio * BeltalowdaBft.bftVars.size, BeltalowdaBft.bftVars.size)
	BeltalowdaBft.controls.alertTLW.rootControl:SetDimensions(BeltalowdaBft.config.ratio * BeltalowdaBft.bftVars.size, BeltalowdaBft.bftVars.size)
	BeltalowdaBft.controls.alertTLW.rootControl.movableBackdrop:SetDimensions(BeltalowdaBft.config.ratio * BeltalowdaBft.bftVars.size, BeltalowdaBft.bftVars.size)
	BeltalowdaBft.controls.alertTLW.rootControl.alertLabel:SetFont(BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.BOLD_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaBft.bftVars.size - 6, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK))
	BeltalowdaBft.controls.alertTLW.rootControl.alertLabel:SetDimensions(BeltalowdaBft.config.ratio * BeltalowdaBft.bftVars.size - 3, BeltalowdaBft.bftVars.size)
end

function BeltalowdaBft.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.positionLocked = false
	defaults.size = 60
	defaults.color = {}
	defaults.color.r = 1
	defaults.color.g = 0
	defaults.color.b = 0
	defaults.soundEnabled = true
	defaults.selectedSound = "EnlightenedState_Lost"
	defaults.warningTimer = 600
	return defaults
end

function BeltalowdaBft.SetEnabled(value)
	if BeltalowdaBft.state.initialized == true and value ~= nil then
		BeltalowdaBft.bftVars.enabled = value
		if value == true then
			if BeltalowdaBft.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaBft.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaBft.OnPlayerActivated)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaBft.callbackName, EVENT_PLAYER_DEACTIVATED, BeltalowdaBft.OnPlayerDeactivated)
				
			end
			BeltalowdaBft.state.registredConsumers = true
		else
			if BeltalowdaBft.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaBft.callbackName, EVENT_PLAYER_ACTIVATED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaBft.callbackName, EVENT_PLAYER_DEACTIVATED)
				
			end
			BeltalowdaBft.state.registredConsumers = false
		end
		BeltalowdaBft.OnPlayerActivated()
	end
end

function BeltalowdaBft.SetControlVisibility()
	local enabled = BeltalowdaBft.bftVars.enabled
	local pvpOnly = BeltalowdaBft.bftVars.pvpOnly
	local setHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setHidden = false
		end
	end
	if setHidden == false then
		if BeltalowdaBft.state.foreground == false then
			BeltalowdaBft.controls.alertTLW:SetHidden(BeltalowdaBft.state.activeLayerIndex > 2)
		else
			BeltalowdaBft.controls.alertTLW:SetHidden(false)
		end
	else
		BeltalowdaBft.controls.alertTLW:SetHidden(setHidden)
	end
end

function BeltalowdaBft.SetPositionLocked(value)
	BeltalowdaBft.bftVars.positionLocked = value
	BeltalowdaBft.controls.alertTLW:SetMovable(not value)
	BeltalowdaBft.controls.alertTLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaBft.controls.alertTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaBft.controls.alertTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaBft.controls.alertTLW.rootControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaBft.controls.alertTLW.rootControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaBft.AdjustColors()
	local rootControl = BeltalowdaBft.controls.alertTLW.rootControl
	rootControl.alertLabel:SetColor(BeltalowdaBft.bftVars.color.r, BeltalowdaBft.bftVars.color.g, BeltalowdaBft.bftVars.color.b)
end

function BeltalowdaBft.PlaySound()
	if BeltalowdaBft.bftVars.soundEnabled == true and BeltalowdaBft.bftVars.enabled == true and (BeltalowdaBft.bftVars.pvpOnly == false or (BeltalowdaBft.bftVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if GetGameTimeMilliseconds() > BeltalowdaBft.constants.ALERT_INTERVAL + BeltalowdaBft.state.lastAlert and BeltalowdaBft.state.outOfLoadingScreen == true then
			BeltalowdaBft.state.lastAlert = GetGameTimeMilliseconds()
			BeltalowdaSound.PlaySoundByName(BeltalowdaBft.bftVars.selectedSound)
		end
	end
end
--callbacks
function BeltalowdaBft.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaBft.bftVars = currentProfile.toolbox.bft
		BeltalowdaBft.SetEnabled(BeltalowdaBft.bftVars.enabled)
		if BeltalowdaBft.state.initialized == true then
			BeltalowdaBft.InitializeControlSettings()
			BeltalowdaBft.SetTlwLocation()
		end
	end
end

function BeltalowdaBft.SaveWindowLocation()
	if BeltalowdaBft.bftVars.positionLocked == false then
		BeltalowdaBft.bftVars.location = BeltalowdaBft.bftVars.location or {}
		BeltalowdaBft.bftVars.location.x = BeltalowdaBft.controls.alertTLW:GetLeft()
		BeltalowdaBft.bftVars.location.y = BeltalowdaBft.controls.alertTLW:GetTop()
	end
end

function BeltalowdaBft.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaBft.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaBft.state.foreground = false
	end
	--hack?
	BeltalowdaBft.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaBft.SetControlVisibility()
end

function BeltalowdaBft.OnPlayerActivated(eventCode, initial)
	BeltalowdaBft.state.lastAlert = GetGameTimeMilliseconds()
	BeltalowdaBft.state.outOfLoadingScreen = true
	if BeltalowdaBft.bftVars.enabled == true and (BeltalowdaBft.bftVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaBft.bftVars.pvpOnly == false) then
		--d("register")
		if BeltalowdaBft.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaBft.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaBft.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaBft.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaBft.SetForegroundVisibility)
			
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaBft.callbackName, BeltalowdaBft.config.updateInterval, BeltalowdaBft.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaBft.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaBft.config.updateInterval)
			
			BeltalowdaBft.state.registredActiveConsumers = true
		end
	else
		--d("unregister")
		if BeltalowdaBft.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaBft.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaBft.callbackName, EVENT_ACTION_LAYER_PUSHED)
			
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaBft.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaBft.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
				
			BeltalowdaBft.state.registredActiveConsumers = false
		end
	end
	BeltalowdaBft.SetControlVisibility()
end

function BeltalowdaBft.OnPlayerDeactivated(eventCode)
	BeltalowdaBft.state.outOfLoadingScreen = false
end

function BeltalowdaBft.UiLoop()
	if BeltalowdaBft.bftVars.enabled == true and (BeltalowdaBft.bftVars.pvpOnly == false or (BeltalowdaBft.bftVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			for i = 1, #players do
				if players[i].displayName == GetUnitDisplayName("player") and players[i].charName == GetUnitName("player") then
					local label = BeltalowdaBft.controls.alertTLW.rootControl.alertLabel
					if players[i].buffs ~= nil and players[i].buffs.specialInformation ~= nil and players[i].buffs.specialInformation.foodDrink ~= nil and 
					   players[i].buffs.specialInformation.foodDrink.active == true and players[i].buffs.specialInformation.foodDrink.ending ~= nil then
						local left = players[i].buffs.specialInformation.foodDrink.ending - (GetGameTimeMilliseconds() / 1000)
						if left > BeltalowdaBft.bftVars.warningTimer then
							label:SetText("")
						else
							local minutes = math.floor(left / 60)
							local seconds = math.floor(left - (minutes * 60))
							if seconds < 10 and seconds > 0 then
								seconds = string.format("0%d", seconds)
								left = string.format("%d:%s", minutes, seconds)
							elseif seconds == 0 then
								seconds = "00"
								left = string.format("%d:%s", minutes, seconds)
							else
								left = string.format("%d:%d", minutes, seconds)
							end
							label:SetText(string.format(BeltalowdaBft.constants.BUFF_FOOD_STRING, left))
							--d(left)
							BeltalowdaBft.PlaySound()
						end
					else
						label:SetText(string.format(BeltalowdaBft.constants.BUFF_FOOD_STRING, "--:--"))
						BeltalowdaBft.PlaySound()
					end
					break
				end
			end
		end
	end
end

--menu interactions
function BeltalowdaBft.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.BFT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.BFT_ENABLED,
					getFunc = BeltalowdaBft.GetBftEnabled,
					setFunc = BeltalowdaBft.SetBftEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.BFT_POSITION_FIXED,
					getFunc = BeltalowdaBft.GetBftPositionLocked,
					setFunc = BeltalowdaBft.SetBftPositionLocked
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.BFT_PVP_ONLY,
					getFunc = BeltalowdaBft.GetBftPvpOnly,
					setFunc = BeltalowdaBft.SetBftPvpOnly
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.BFT_COLOR,
					getFunc = BeltalowdaBft.GetBftColor,
					setFunc = BeltalowdaBft.SetBftColor,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.BFT_SIZE,
					min = 20,
					max = 60,
					step = 1,
					getFunc = BeltalowdaBft.GetBftSize,
					setFunc = BeltalowdaBft.SetBftSize,
					width = "full",
					default = 60
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.BFT_SOUND_ENABLED,
					getFunc = BeltalowdaBft.GetBftSoundEnabled,
					setFunc = BeltalowdaBft.SetBftSoundEnabled
				},
				[7] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.BFT_SELECTED_SOUND,
					choices = BeltalowdaBft.GetBftAvailableSounds(),
					getFunc = BeltalowdaBft.GetBftSelectedSound,
					setFunc = BeltalowdaBft.SetBftSelectedSound,
					width = "full"
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.BFT_WARNING_TIMER,
					min = 1,
					max = 1800,
					step = 1,
					getFunc = BeltalowdaBft.GetBftWarningTimer,
					setFunc = BeltalowdaBft.SetBftWarningTimer,
					width = "full",
					default = 600
				},
			}
		},
	}
	return menu
end

function BeltalowdaBft.GetBftEnabled()
	return BeltalowdaBft.bftVars.enabled
end

function BeltalowdaBft.SetBftEnabled(value)
	BeltalowdaBft.SetEnabled(value)
end

function BeltalowdaBft.GetBftPositionLocked()
	return BeltalowdaBft.bftVars.positionLocked
end

function BeltalowdaBft.SetBftPositionLocked(value)
	BeltalowdaBft.SetPositionLocked(value)
end

function BeltalowdaBft.GetBftPvpOnly()
	return BeltalowdaBft.bftVars.pvpOnly
end

function BeltalowdaBft.SetBftPvpOnly(value)
	BeltalowdaBft.bftVars.pvpOnly = value
	BeltalowdaBft.SetControlVisibility()
end

function BeltalowdaBft.GetBftColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaBft.bftVars.color)
end

function BeltalowdaBft.SetBftColor(r, g, b)
	BeltalowdaBft.bftVars.color = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaBft.controls.alertTLW.rootControl.alertLabel:SetColor(r, g, b, 1)
end

function BeltalowdaBft.GetBftSize()
	return BeltalowdaBft.bftVars.size
end

function BeltalowdaBft.SetBftSize(value)
	BeltalowdaBft.bftVars.size = value
	BeltalowdaBft.AdjustSize()
end

function BeltalowdaBft.GetBftSoundEnabled()
	return BeltalowdaBft.bftVars.soundEnabled
end

function BeltalowdaBft.SetBftSoundEnabled(value)
	BeltalowdaBft.bftVars.soundEnabled = value
end

function BeltalowdaBft.GetBftAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaBft.state.sounds do
		sounds[i] = BeltalowdaBft.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaBft.GetBftSelectedSound()
	return BeltalowdaBft.bftVars.selectedSound
end

function BeltalowdaBft.SetBftSelectedSound(value)
	if value ~= nil then
		BeltalowdaBft.bftVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end

function BeltalowdaBft.GetBftWarningTimer()
	return BeltalowdaBft.bftVars.warningTimer
end

function BeltalowdaBft.SetBftWarningTimer(value)
	BeltalowdaBft.bftVars.warningTimer = value
end