-- Beltalowda Follow The Crown Visual
-- By @s0rdrak (PC / EU)

--local lib3d = LibStub("Lib3D2")
local lib3d = Lib3D

Beltalowda.group.ftcv = Beltalowda.group.ftcv or {}
local BeltalowdaFtcv = Beltalowda.group.ftcv
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.ui = BeltalowdaUtil.ui or {}
local BeltalowdaUI = BeltalowdaUtil.ui
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group
BeltalowdaFtcv.constants = BeltalowdaFtcv.constants or {}
BeltalowdaFtcv.constants.modes = {}
BeltalowdaFtcv.constants.modes.RETICLE = 1
BeltalowdaFtcv.constants.modes.FIXED = 2
BeltalowdaFtcv.constants.MODES = {}
BeltalowdaFtcv.constants.color_modes = {}
BeltalowdaFtcv.constants.color_modes.DISTANCE = 1
BeltalowdaFtcv.constants.color_modes.ORIENTATION = 2
BeltalowdaFtcv.constants.COLOR_MODES = {}
BeltalowdaFtcv.constants.TLW_RETICLE_NAME = "Beltalowda.group.ftcv.RETICLE_TLW"
BeltalowdaFtcv.constants.RETICLE_NAME = "Beltalowda.group.ftcv.RETICLE"
BeltalowdaFtcv.constants.TLW_FIXED_NAME = "Beltalowda.group.ftcv.FIXED_TLW"
BeltalowdaFtcv.constants.FIXED_NAME = "Beltalowda.group.ftcv.FIXED"

local wm = WINDOW_MANAGER
BeltalowdaFtcv.controls = {}

BeltalowdaFtcv.callbackName = Beltalowda.addonName .. "FollowTheCrownVisual"

BeltalowdaFtcv.config = BeltalowdaFtcv.config or {}
BeltalowdaFtcv.config.isClampedToScreen = true
BeltalowdaFtcv.config.updateInterval = 10
BeltalowdaFtcv.config.minDis = 0
BeltalowdaFtcv.config.maxDis = 10

BeltalowdaFtcv.textures = {}
BeltalowdaFtcv.textures[1] = {}
BeltalowdaFtcv.textures[1].dds = "Beltalowda/Art/FTCV/pfeil8.dds"
BeltalowdaFtcv.textures[2] = {}
BeltalowdaFtcv.textures[2].dds = "Beltalowda/Art/FTCV/pfeil1.dds"
BeltalowdaFtcv.textures[3] = {}
BeltalowdaFtcv.textures[3].dds = "Beltalowda/Art/FTCV/pfeil2.dds"
BeltalowdaFtcv.textures[4] = {}
BeltalowdaFtcv.textures[4].dds = "Beltalowda/Art/FTCV/pfeil3.dds"
BeltalowdaFtcv.textures[5] = {}
BeltalowdaFtcv.textures[5].dds = "Beltalowda/Art/FTCV/pfeil4.dds"
BeltalowdaFtcv.textures[6] = {}
BeltalowdaFtcv.textures[6].dds = "Beltalowda/Art/FTCV/pfeil5.dds"
BeltalowdaFtcv.textures[7] = {}
BeltalowdaFtcv.textures[7].dds = "Beltalowda/Art/FTCV/pfeil6.dds"
BeltalowdaFtcv.textures[8] = {}
BeltalowdaFtcv.textures[8].dds = "Beltalowda/Art/FTCV/pfeil7.dds"

BeltalowdaFtcv.state = {}
BeltalowdaFtcv.state.foreground = true
BeltalowdaFtcv.state.initialized = false
BeltalowdaFtcv.state.registeredConsumer = false
BeltalowdaFtcv.state.activeLayerIndex = 1
BeltalowdaFtcv.state.registredActiveConsumers = false

function BeltalowdaFtcv.Initialize()
	--vars
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaFtcv.callbackName, BeltalowdaFtcv.OnProfileChanged)
	BeltalowdaFtcv.constants.MODES[BeltalowdaFtcv.constants.modes.RETICLE] = Beltalowda.menu.constants.FTCV_MODE_RETICLE
	BeltalowdaFtcv.constants.MODES[BeltalowdaFtcv.constants.modes.FIXED] = Beltalowda.menu.constants.FTCV_MODE_FIXED
	
	
	BeltalowdaFtcv.constants.COLOR_MODES[BeltalowdaFtcv.constants.color_modes.DISTANCE] = Beltalowda.menu.constants.FTCV_COLOR_MODE_DISTANCE
	BeltalowdaFtcv.constants.COLOR_MODES[BeltalowdaFtcv.constants.color_modes.ORIENTATION] = Beltalowda.menu.constants.FTCV_COLOR_MODE_ORIENTATION
	--ui
	local size = BeltalowdaFtcv.ftcvVars.size.close

	--reticle
	
	BeltalowdaFtcv.controls.TLW_Reticle = wm:CreateTopLevelWindow(BeltalowdaFtcv.constants.TLW_RETICLE_NAME)
	
	BeltalowdaFtcv.controls.TLW_Reticle:SetDimensions(size, size)
	BeltalowdaFtcv.controls.TLW_Reticle:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
		
	BeltalowdaFtcv.controls.TLW_Reticle:SetClampedToScreen(BeltalowdaFtcv.config.isClampedToScreen)
	BeltalowdaFtcv.controls.TLW_Reticle:SetDrawLayer(0)
	BeltalowdaFtcv.controls.TLW_Reticle:SetDrawLevel(0)
	
	BeltalowdaFtcv.controls.reticle = wm:CreateControl(BeltalowdaFtcv.constants.RETICLE_NAME, BeltalowdaFtcv.controls.TLW_Reticle, CT_TEXTURE)
	
	BeltalowdaFtcv.controls.reticle:SetAnchor(TOPLEFT, BeltalowdaFtcv.controls.TLW_Reticle, TOPLEFT, 0, 0)
	BeltalowdaFtcv.controls.reticle:SetColor(1, 1, 1, 1)

	BeltalowdaFtcv.controls.reticle:SetDimensions(size, size)
	
	
	
	--fixed
	BeltalowdaFtcv.controls.TLW_Fixed = wm:CreateTopLevelWindow(BeltalowdaFtcv.constants.TLW_FIXED_NAME)
	
	BeltalowdaFtcv.controls.TLW_Fixed:SetDimensions(size, size)
	BeltalowdaFtcv.controls.TLW_Fixed:SetAnchor(CENTER, GuiRoot, CENTER, 0, BeltalowdaFtcv.ftcvVars.fixedPosition)
		
	BeltalowdaFtcv.controls.TLW_Fixed:SetClampedToScreen(BeltalowdaFtcv.config.isClampedToScreen)
	BeltalowdaFtcv.controls.TLW_Fixed:SetDrawLayer(0)
	BeltalowdaFtcv.controls.TLW_Fixed:SetDrawLevel(0)
	
	BeltalowdaFtcv.controls.fixed = wm:CreateControl(BeltalowdaFtcv.constants.FIXED_NAME, BeltalowdaFtcv.controls.TLW_Fixed, CT_TEXTURE)
	
	BeltalowdaFtcv.controls.fixed:SetAnchor(TOPLEFT, BeltalowdaFtcv.controls.TLW_Fixed, TOPLEFT, 0, 0)
	BeltalowdaFtcv.controls.fixed:SetColor(1, 1, 1, 1)
	
	BeltalowdaFtcv.controls.fixed:SetDimensions(size, size)
	
	
		
	--EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaFtcv.SetVisible)
	--EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaFtcv.SetVisible)
	
	--config
	BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(true)
	BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(true)

	
	BeltalowdaFtcv.UpdateTextures()

	BeltalowdaFtcv.state.initialized = true
	BeltalowdaFtcv.SetEnabled(BeltalowdaFtcv.ftcvVars.enabled)
end

function BeltalowdaFtcv.GetDefaults()
	local defaults = {}
	defaults.mode = BeltalowdaFtcv.constants.modes.RETICLE
	defaults.colorMode = BeltalowdaFtcv.constants.color_modes.DISTANCE
	defaults.colors = {}
	defaults.colors.front = {}
	defaults.colors.front.r = 0
	defaults.colors.front.g = 1
	defaults.colors.front.b = 0
	defaults.colors.side = {}
	defaults.colors.side.r = 1
	defaults.colors.side.g = 0.5
	defaults.colors.side.b = 0
	defaults.colors.back = {}
	defaults.colors.back.r = 1
	defaults.colors.back.g = 0
	defaults.colors.back.b = 0
	defaults.enabled = true
	defaults.pvponly = false
	defaults.opacity = {}
	defaults.opacity.close = 50
	defaults.opacity.far = 100
	defaults.size = {}
	defaults.size.close = 30
	defaults.size.far = 75
	defaults.distance = 25
	defaults.position = 65
	defaults.maxDistance = 10
	defaults.minDistance = 3
	defaults.selectedTexture = 1
	return defaults
end

function BeltalowdaFtcv.SetEnabled(value)
	if BeltalowdaFtcv.state.initialized == true then
		BeltalowdaFtcv.ftcvVars.enabled = value
		if BeltalowdaFtcv.state.foreground == true then
			if BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.RETICLE then
				BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(not BeltalowdaFtcv.ftcvVars.enabled)
			elseif BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.FIXED then
				BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(not BeltalowdaFtcv.ftcvVars.enabled)
			end
		end
		
		if value == true then
			if BeltalowdaFtcv.state.registredConsumers == false then
				
				EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcv.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaFtcv.OnPlayerActivated)
				
			end
			BeltalowdaFtcv.state.registredConsumers = true
		else
			if BeltalowdaFtcv.state.registredConsumers == true then
				
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcv.callbackName, EVENT_PLAYER_ACTIVATED)
				
			end
			BeltalowdaFtcv.state.registredConsumers = false
		end
		BeltalowdaFtcv.OnPlayerActivated()
		
	end
end

function BeltalowdaFtcv.GetTextureString()
	return BeltalowdaFtcv.textures[BeltalowdaFtcv.ftcvVars.selectedTexture].dds
end

function BeltalowdaFtcv.UpdateTextures()
	local texture = BeltalowdaFtcv.GetTextureString()
	--d(texture)
	BeltalowdaFtcv.controls.reticle:SetTexture(texture)
	BeltalowdaFtcv.controls.fixed:SetTexture(texture)
end

function BeltalowdaFtcv.GetDistanceColorTone(r1, r2, distance)
	local d = BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance
	local color = r1
	
	local delta = r2 - r1
	
	if delta > 0 then
		color = r1 + delta * ((distance - BeltalowdaFtcv.ftcvVars.minDistance) / d)
	elseif delta < 0 then
		color = r2 - delta * (d - (distance - BeltalowdaFtcv.ftcvVars.minDistance)) / d
	end
	return color
end

--callbacks
function BeltalowdaFtcv.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		--BeltalowdaFtcv.SetEnabled(false)
		BeltalowdaFtcv.ftcvVars = currentProfile.group.ftcv
		BeltalowdaFtcv.SetEnabled(BeltalowdaFtcv.ftcvVars.enabled)
		if BeltalowdaFtcv.state.initialized == true then
			BeltalowdaFtcv.UpdateTextures()
			BeltalowdaFtcv.SetFtcvPosition(BeltalowdaFtcv.ftcvVars.position)
		end
	end
end

function BeltalowdaFtcv.OnPlayerActivated(eventCode, initial)
	if BeltalowdaFtcv.ftcvVars.enabled == true and (BeltalowdaFtcv.ftcvVars.pvponly == true and BeltalowdaUtil.IsInPvPArea() == true or BeltalowdaFtcv.ftcvVars.pvponly == false) then
		if BeltalowdaFtcv.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaFtcv.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaFtcv.SetForegroundVisibility)
			BeltalowdaGroup.AddFeature(BeltalowdaFtcv.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE, BeltalowdaFtcv.config.updateInterval)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaFtcv.callbackName, BeltalowdaFtcv.config.updateInterval, BeltalowdaFtcv.OnUpdate)
			BeltalowdaFtcv.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaFtcv.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtcv.callbackName, EVENT_ACTION_LAYER_PUSHED)
			BeltalowdaGroup.RemoveFeature(BeltalowdaFtcv.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaFtcv.callbackName)
			BeltalowdaFtcv.state.registredActiveConsumers = false
		end
	end
	BeltalowdaFtcv.SetControlVisibility()
end

function BeltalowdaFtcv.SetControlVisibility()
	local enabled = BeltalowdaFtcv.ftcvVars.enabled
	local pvpOnly = BeltalowdaFtcv.ftcvVars.pvpOnly
	local setOverviewHidden = true
	if enabled ~= nil and pvpOnly ~= nil then

		if enabled == true and (pvpOnly == false or (pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
			setOverviewHidden = false
		end
	end
	if setOverviewHidden == false then
		if BeltalowdaFtcv.state.foreground == false then
			if BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.RETICLE then
				BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(BeltalowdaFtcv.state.activeLayerIndex > 2)
			else
				BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(BeltalowdaFtcv.state.activeLayerIndex > 2)
			end
		else
			if BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.RETICLE then
				BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(false)
			else
				BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(false)
			end
		end
	else
		BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(setOverviewHidden)
		BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(setOverviewHidden)
	end
end

function BeltalowdaFtcv.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaFtcv.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaFtcv.state.foreground = false
	end
	--hack?
	BeltalowdaFtcv.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaFtcv.SetControlVisibility()
end

function BeltalowdaFtcv.OnUpdate()
	
	--d(pvpZone)
	--d("dafuq")
	if BeltalowdaFtcv.ftcvVars.enabled == true and IsUnitGrouped("player") and BeltalowdaGroup.IsPlayerGroupLeader() == false then
		--d("unit isn't lead and addon enabled")
		local pvpZone = BeltalowdaUtil.IsInPvPArea()
		if BeltalowdaFtcv.ftcvVars.pvponly == true and pvpZone == true or BeltalowdaFtcv.ftcvVars.pvponly == false then
			

			if lib3d:IsValidZone() then
				--Rotate

				local distance = BeltalowdaGroup.GetLeaderDistance()
				local rotation = BeltalowdaGroup.GetLeaderRotation()
				--d("FTCV: " .. rotation)
				if distance ~= nil and rotation ~= nil then
					
					BeltalowdaFtcv.controls.reticle:SetTextureRotation(rotation)
					BeltalowdaFtcv.controls.fixed:SetTextureRotation(rotation)
					--Scale
					local size = BeltalowdaFtcv.ftcvVars.size.far
					if BeltalowdaFtcv.ftcvVars.size.close > BeltalowdaFtcv.ftcvVars.size.far then
						size = BeltalowdaFtcv.ftcvVars.size.close
					end
					if BeltalowdaFtcv.ftcvVars.size.close < BeltalowdaFtcv.ftcvVars.size.far then
						--size = BeltalowdaFtcv.ftcvVars.size.close + ((BeltalowdaFtcv.ftcvVars.size.far - BeltalowdaFtcv.ftcvVars.size.close) / (BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance)) * distance
						size = BeltalowdaFtcv.ftcvVars.size.far - (BeltalowdaFtcv.ftcvVars.size.far - BeltalowdaFtcv.ftcvVars.size.close) * ((BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance) - (distance - BeltalowdaFtcv.ftcvVars.minDistance))/(BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance)
						--d(size)
						if size > BeltalowdaFtcv.ftcvVars.size.far then
							size = BeltalowdaFtcv.ftcvVars.size.far
						elseif size < BeltalowdaFtcv.ftcvVars.size.close then
							size = BeltalowdaFtcv.ftcvVars.size.close
						end
					end
					size = size * 2
					
					BeltalowdaFtcv.controls.TLW_Reticle:SetDimensions(size,size)
					BeltalowdaFtcv.controls.TLW_Fixed:SetDimensions(size,size)
					BeltalowdaFtcv.controls.reticle:SetDimensions(size,size)
					BeltalowdaFtcv.controls.fixed:SetDimensions(size,size)
					
					
					
					--Reposition (Reticle Only)
					
					if BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.RETICLE then
						local position = BeltalowdaFtcv.ftcvVars.position
						if position < 0 then
							position = -position
						end
						
						local reticleDistance = position + size / 2
						local distanceX = math.sin(math.pi + rotation) * reticleDistance
						local distanceY = math.cos(math.pi + rotation) * reticleDistance
						
						BeltalowdaFtcv.controls.TLW_Reticle:ClearAnchors()
						BeltalowdaFtcv.controls.TLW_Reticle:SetAnchor(CENTER, GuiRoot, CENTER, distanceX, distanceY)
					end
					--d(rotation)
					
					
					
					
					--opacity
					local opacity = BeltalowdaFtcv.ftcvVars.opacity.far
					if BeltalowdaFtcv.ftcvVars.opacity.close > BeltalowdaFtcv.ftcvVars.opacity.far then
						opacity = BeltalowdaFtcv.ftcvVars.opacity.close
					end
					if BeltalowdaFtcv.ftcvVars.opacity.close < BeltalowdaFtcv.ftcvVars.opacity.far then
						--opacity = (BeltalowdaFtcv.ftcvVars.opacity.close + ((BeltalowdaFtcv.ftcvVars.opacity.far - BeltalowdaFtcv.ftcvVars.opacity.close) / (BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance))* distance) / 100
						opacity = (BeltalowdaFtcv.ftcvVars.opacity.far - (BeltalowdaFtcv.ftcvVars.opacity.far - BeltalowdaFtcv.ftcvVars.opacity.close) * ((BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance) - (distance - BeltalowdaFtcv.ftcvVars.minDistance))/(BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance)) / 100
						--d(opacity)
						if opacity > BeltalowdaFtcv.ftcvVars.opacity.far / 100 then
							opacity = BeltalowdaFtcv.ftcvVars.opacity.far / 100
						elseif opacity < BeltalowdaFtcv.ftcvVars.opacity.close / 100 then
							opacity = BeltalowdaFtcv.ftcvVars.opacity.close / 100
						end
					end
					
					--BeltalowdaFtcv.controls.reticle:SetAlpha(opacity)
					--BeltalowdaFtcv.controls.fixed:SetAlpha(opacity)
					
					--Color
					if BeltalowdaFtcv.ftcvVars.colorMode == BeltalowdaFtcv.constants.color_modes.ORIENTATION then
						local color1 = nil
						local color2 = nil
						local minRotation = nil
						local maxRotation = nil
						if rotation >= math.pi and rotation <= math.pi * 1.5 then
							color1 = BeltalowdaFtcv.ftcvVars.colors.back
							color2 = BeltalowdaFtcv.ftcvVars.colors.side
							minRotation = math.pi
							maxRotation = math.pi * 1.5
						elseif rotation > math.pi * 1.5 and rotation <= math.pi * 2 then
							color1 = BeltalowdaFtcv.ftcvVars.colors.side
							color2 = BeltalowdaFtcv.ftcvVars.colors.front
							minRotation = math.pi * 1.5
							maxRotation = math.pi * 2
						elseif rotation > math.pi * 2 and rotation <= math.pi * 2.5 then
							color1 = BeltalowdaFtcv.ftcvVars.colors.front
							color2 = BeltalowdaFtcv.ftcvVars.colors.side
							minRotation = math.pi * 2
							maxRotation = math.pi * 2.5
						else
							color1 = BeltalowdaFtcv.ftcvVars.colors.side
							color2 = BeltalowdaFtcv.ftcvVars.colors.back
							minRotation = math.pi * 2.5
							maxRotation = math.pi * 3
						end

						local colorR = color1.r + (color2.r - color1.r) / (maxRotation - minRotation) * (rotation - minRotation)
						local colorG = color1.g + (color2.g - color1.g) / (maxRotation - minRotation) * (rotation - minRotation)
						local colorB = color1.b + (color2.b - color1.b) / (maxRotation - minRotation) * (rotation - minRotation)
						
						--d(colorR.. " ".. colorG.. " ".. colorB)
						BeltalowdaFtcv.controls.reticle:SetColor(colorR, colorG, colorB, opacity)
						BeltalowdaFtcv.controls.fixed:SetColor(colorR, colorG, colorB, opacity)
					elseif BeltalowdaFtcv.ftcvVars.colorMode == BeltalowdaFtcv.constants.color_modes.DISTANCE then
						local d = BeltalowdaFtcv.ftcvVars.maxDistance - BeltalowdaFtcv.ftcvVars.minDistance
						local colorR = BeltalowdaFtcv.GetDistanceColorTone(BeltalowdaFtcv.ftcvVars.colors.front.r, BeltalowdaFtcv.ftcvVars.colors.back.r, distance)
						local colorG = BeltalowdaFtcv.GetDistanceColorTone(BeltalowdaFtcv.ftcvVars.colors.front.g, BeltalowdaFtcv.ftcvVars.colors.back.g, distance)
						local colorB = BeltalowdaFtcv.GetDistanceColorTone(BeltalowdaFtcv.ftcvVars.colors.front.b, BeltalowdaFtcv.ftcvVars.colors.back.b, distance)

						--d(colorR " " .. " ".. colorG.. " ".. colorB)
						BeltalowdaFtcv.controls.reticle:SetColor(colorR, colorG, colorB, opacity)
						BeltalowdaFtcv.controls.fixed:SetColor(colorR, colorG, colorB, opacity)

					end
					--d(BeltalowdaFtcv.state.foreground)
					--foreground always == false?
					if BeltalowdaFtcv.state.foreground == true then
						if BeltalowdaFtcv.ftcvVars.mode == BeltalowdaFtcv.constants.modes.RETICLE then
							BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(false)
						else
							BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(false)
						end
					end
					
				end
				return
			end
		end
	end
	
	BeltalowdaFtcv.controls.TLW_Reticle:SetHidden(true)
	BeltalowdaFtcv.controls.TLW_Fixed:SetHidden(true)
end


--menu interaction
function BeltalowdaFtcv.GetMenu()
	local menu = {
	[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.FTCV_HEADER,
			--width = "full",
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCV_ENABLED,
					getFunc = BeltalowdaFtcv.GetFtcvEnabled,
					setFunc = BeltalowdaFtcv.SetFtcvEnabled,
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCV_PVP_ONLY,
					getFunc = BeltalowdaFtcv.GetFtcvPvpOnly,
					setFunc = BeltalowdaFtcv.SetFtcvPvpOnly
				},
				[3] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.FTCV_MODE,
					choices = BeltalowdaFtcv.GetFtcvAvailableModes(),
					getFunc = BeltalowdaFtcv.GetFtcvSelectedMode,
					setFunc = BeltalowdaFtcv.SetFtcvSelectedMode,
					width = "full"
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.FTCV_COLOR_MODE,
					choices = BeltalowdaFtcv.GetFtcvAvailableColorModes(),
					getFunc = BeltalowdaFtcv.GetFtcvSelectedColorMode,
					setFunc = BeltalowdaFtcv.SetFtcvSelectedColorMode,
					width = "full"
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.FTCV_TEXTURES,
					choices = BeltalowdaFtcv.GetFtcvAvailableTextures(),
					getFunc = BeltalowdaFtcv.GetFtcvSelectedTexture,
					setFunc = BeltalowdaFtcv.SetFtcvSelectedTexture,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCV_COLOR_FRONT,
					getFunc = BeltalowdaFtcv.GetFtcvFrontColor,
					setFunc = BeltalowdaFtcv.SetFtcvFrontColor,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCV_COLOR_SIDE,
					getFunc = BeltalowdaFtcv.GetFtcvSideColor,
					setFunc = BeltalowdaFtcv.SetFtcvSidetColor,
					width = "full"
				},
				[8] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCV_COLOR_BACK,
					getFunc = BeltalowdaFtcv.GetFtcvBackColor,
					setFunc = BeltalowdaFtcv.SetFtcvBackColor,
					width = "full"
				},
				[9] =
				{
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_OPACITY_CLOSE,
					min = 1,
					max = 100,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvOpacityClose,
					setFunc = BeltalowdaFtcv.SetFtcvOpacityClose,
					width = "full",
					default = 50
				},
				[10] =
				{
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_OPACITY_FAR,
					min = 1,
					max = 100,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvOpacityFar,
					setFunc = BeltalowdaFtcv.SetFtcvOpacityFar,
					width = "full",
					default = 100
				},
				[11] =
				{
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_SIZE_CLOSE,
					min = 1,
					max = 100,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvSizeClose,
					setFunc = BeltalowdaFtcv.SetFtcvSizeClose,
					width = "full",
					default = 50
				},
				[12] =
				{
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_SIZE_FAR,
					min = 1,
					max = 100,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvSizeFar,
					setFunc = BeltalowdaFtcv.SetFtcvSizeFar,
					width = "full",
					default = 100
				},
				[13] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_POSITION,
					min = -250,
					max = 250,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvPosition,
					setFunc = BeltalowdaFtcv.SetFtcvPosition,
					width = "full",
					default = 65
				},
				[14] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_MAX_DISTANCE,
					min = 0,
					max = 25,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvMaxDistance,
					setFunc = BeltalowdaFtcv.SetFtcvMaxDistance,
					width = "full",
					default = 8
				},
				[15] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCV_MIN_DISTANCE ,
					min = 0,
					max = 5,
					step = 1,
					getFunc = BeltalowdaFtcv.GetFtcvMinDistance,
					setFunc = BeltalowdaFtcv.SetFtcvMinDistance,
					width = "full",
					default = 3
				}
			}
		}
	}
	return menu
end

function BeltalowdaFtcv.GetFtcvEnabled()
	return BeltalowdaFtcv.ftcvVars.enabled
end

function BeltalowdaFtcv.SetFtcvEnabled(value)
	BeltalowdaFtcv.SetEnabled(value)
end


function BeltalowdaFtcv.GetFtcvSelectedMode()
	return BeltalowdaFtcv.constants.MODES[BeltalowdaFtcv.ftcvVars.mode]
end

function BeltalowdaFtcv.SetFtcvSelectedMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaFtcv.constants.MODES do
			if BeltalowdaFtcv.constants.MODES[i] == value then
				BeltalowdaFtcv.ftcvVars.mode = i
				break
			end
		end
	end
end

function BeltalowdaFtcv.GetFtcvAvailableModes()
	return {
		BeltalowdaFtcv.constants.MODES[BeltalowdaFtcv.constants.modes.RETICLE], 
		BeltalowdaFtcv.constants.MODES[BeltalowdaFtcv.constants.modes.FIXED]
	}
end

function BeltalowdaFtcv.GetFtcvSelectedColorMode()
	return BeltalowdaFtcv.constants.COLOR_MODES[BeltalowdaFtcv.ftcvVars.colorMode]
end

function BeltalowdaFtcv.SetFtcvSelectedColorMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaFtcv.constants.COLOR_MODES do
			if BeltalowdaFtcv.constants.COLOR_MODES[i] == value then
				BeltalowdaFtcv.ftcvVars.colorMode = i
				break
			end
		end
	end
end

function BeltalowdaFtcv.GetFtcvAvailableColorModes()
	return {
		BeltalowdaFtcv.constants.COLOR_MODES[BeltalowdaFtcv.constants.color_modes.DISTANCE], 
		BeltalowdaFtcv.constants.COLOR_MODES[BeltalowdaFtcv.constants.color_modes.ORIENTATION]
	}
end

function BeltalowdaFtcv.GetFtcvFrontColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcv.ftcvVars.colors.front)
end

function BeltalowdaFtcv.SetFtcvFrontColor(r, g, b)
	BeltalowdaFtcv.ftcvVars.colors.front = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaFtcv.GetFtcvSideColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcv.ftcvVars.colors.side)
end

function BeltalowdaFtcv.SetFtcvSidetColor(r, g, b)
	BeltalowdaFtcv.ftcvVars.colors.side = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaFtcv.GetFtcvBackColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaFtcv.ftcvVars.colors.back)
end

function BeltalowdaFtcv.SetFtcvBackColor(r, g, b)
	BeltalowdaFtcv.ftcvVars.colors.back = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaFtcv.GetFtcvSizeClose()
	return BeltalowdaFtcv.ftcvVars.size.close
end

function BeltalowdaFtcv.SetFtcvSizeClose(value)
	BeltalowdaFtcv.ftcvVars.size.close = value
end

function BeltalowdaFtcv.GetFtcvSizeFar()
	return BeltalowdaFtcv.ftcvVars.size.far
end

function BeltalowdaFtcv.SetFtcvSizeFar(value)
	BeltalowdaFtcv.ftcvVars.size.far = value
end

function BeltalowdaFtcv.GetFtcvOpacityClose()
	return BeltalowdaFtcv.ftcvVars.opacity.close
end

function BeltalowdaFtcv.SetFtcvOpacityClose(value)
	BeltalowdaFtcv.ftcvVars.opacity.close = value
end

function BeltalowdaFtcv.GetFtcvOpacityFar()
	return BeltalowdaFtcv.ftcvVars.opacity.far
end

function BeltalowdaFtcv.SetFtcvOpacityFar(value)
	BeltalowdaFtcv.ftcvVars.opacity.far = value
end

function BeltalowdaFtcv.GetFtcvPvpOnly()
	return BeltalowdaFtcv.ftcvVars.pvponly
end

function BeltalowdaFtcv.SetFtcvPvpOnly(value)
	BeltalowdaFtcv.ftcvVars.pvponly = value
	BeltalowdaFtcv.SetEnabled(BeltalowdaFtcv.ftcvVars.enabled)
end

function BeltalowdaFtcv.GetFtcvPosition()
	return BeltalowdaFtcv.ftcvVars.position
end

function BeltalowdaFtcv.SetFtcvPosition(value)
	if value ~= nil then
		BeltalowdaFtcv.ftcvVars.position = value
		BeltalowdaFtcv.controls.TLW_Fixed:ClearAnchors()
		BeltalowdaFtcv.controls.TLW_Fixed:SetAnchor(CENTER, GuiRoot, CENTER, 0, value)
	end
end

function BeltalowdaFtcv.GetFtcvMaxDistance()
	return BeltalowdaFtcv.ftcvVars.maxDistance
end

function BeltalowdaFtcv.SetFtcvMaxDistance(value)
	BeltalowdaFtcv.ftcvVars.maxDistance = value
end

function BeltalowdaFtcv.GetFtcvMinDistance()
	return BeltalowdaFtcv.ftcvVars.minDistance
end

function BeltalowdaFtcv.SetFtcvMinDistance(value)
	BeltalowdaFtcv.ftcvVars.minDistance = value
end

function BeltalowdaFtcv.GetFtcvAvailableTextures()
	local textures = {}
	for i = 1, #BeltalowdaFtcv.textures do
		table.insert(textures, BeltalowdaFtcv.textures[i].name)
	end
	return textures
end

function BeltalowdaFtcv.GetFtcvSelectedTexture()
	return BeltalowdaFtcv.textures[BeltalowdaFtcv.ftcvVars.selectedTexture].name
end

function BeltalowdaFtcv.SetFtcvSelectedTexture(value)
	if value ~= nil then
		for i = 1, #BeltalowdaFtcv.textures do
			if BeltalowdaFtcv.textures[i].name == value then
				BeltalowdaFtcv.ftcvVars.selectedTexture = i
				
				break
			end
		end
		BeltalowdaFtcv.UpdateTextures()
	end
end