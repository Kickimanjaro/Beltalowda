-- Beltalowda I See Dead People
-- By @s0rdrak (PC / EU)

--local lib3D = LibStub("Lib3D2")
local lib3D = Lib3D

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.isdp = BeltalowdaGroup.isdp or {}
local BeltalowdaIsdp = BeltalowdaGroup.isdp
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.moving3DObjects = BeltalowdaUtil.moving3DObjects  or {}
local BeltalowdaM3DO = BeltalowdaUtil.moving3DObjects
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.beams = BeltalowdaUtil.beams
local BeltalowdaBeams = BeltalowdaUtil.beams

BeltalowdaIsdp.callbackName = Beltalowda.addonName .. "ISeeDeadPeople"

BeltalowdaIsdp.constants = {}

BeltalowdaIsdp.controls = {}
BeltalowdaIsdp.controls.beams = {}

BeltalowdaIsdp.config = {}
BeltalowdaIsdp.config.updateInterval = 10
BeltalowdaIsdp.config.distanceUpdateInterval = 100
BeltalowdaIsdp.config.deadStateUpdateInterval = 10
BeltalowdaIsdp.config.maxDistance = 200

BeltalowdaIsdp.state = {}
BeltalowdaIsdp.state.initialized = false
BeltalowdaIsdp.state.registredConsumers = false
BeltalowdaIsdp.state.registredActivationConsumers = false
BeltalowdaIsdp.state.beams = {}

local wm = GetWindowManager()

function BeltalowdaIsdp.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaIsdp.callbackName, BeltalowdaIsdp.OnProfileChanged)
	BeltalowdaIsdp.InitializeTextures()
	BeltalowdaIsdp.CreateBeams()
	BeltalowdaIsdp.state.initialized = true
	BeltalowdaIsdp.SetEnabled(BeltalowdaIsdp.isdpVars.enabled)
end

function BeltalowdaIsdp.CreateBeams()
	for i = 1, 10 do
		table.insert(BeltalowdaIsdp.controls.beams, BeltalowdaIsdp.CreateBeam())
	end
end

function BeltalowdaIsdp.CreateBeam()
	local beamConfig = BeltalowdaIsdp.state.beams[BeltalowdaIsdp.isdpVars.texture]
	local beam = wm:CreateControl(nil, BeltalowdaM3DO.GetDefaultTopLevelWindow(), CT_TEXTURE)
	beam:Create3DRenderSpace()
	if beamConfig.ignoreSize == true then
		beam:Set3DLocalDimensions(beamConfig.width, beamConfig.height)
	else
		beam:Set3DLocalDimensions(BeltalowdaIsdp.isdpVars.size, beamConfig.height)
	end
	beam:SetDrawLevel(3)
	beam:SetTexture(beamConfig.texture)
	beam:Set3DRenderSpaceUsesDepthBuffer(beamConfig.usesDepthBuffer)
	beam:SetHidden(true)
	beam.registeredTexture = false
	return beam
end

function BeltalowdaIsdp.InitializeTextures()
	local commonBeams = BeltalowdaBeams.GetBeams()
	for i = 1, #commonBeams do
		BeltalowdaIsdp.state.beams[i] = {}
		BeltalowdaIsdp.state.beams[i].texture = commonBeams[i].texture
		BeltalowdaIsdp.state.beams[i].name = commonBeams[i].name
		BeltalowdaIsdp.state.beams[i].usesDepthBuffer = commonBeams[i].usesDepthBuffer
		BeltalowdaIsdp.state.beams[i].ignoreSize = commonBeams[i].ignoreSize
		BeltalowdaIsdp.state.beams[i].height = commonBeams[i].height
		BeltalowdaIsdp.state.beams[i].width = commonBeams[i].width
		BeltalowdaIsdp.state.beams[i].heightOffset = commonBeams[i].heightOffset
	end
	BeltalowdaIsdp.state.beams[#commonBeams - 2].heightOffset = 2
	BeltalowdaIsdp.state.beams[#commonBeams - 3].heightOffset = 2
	BeltalowdaIsdp.state.beams[#commonBeams - 4].heightOffset = 2
	BeltalowdaIsdp.state.beams[#commonBeams - 5].heightOffset = 2
	
	local index = #commonBeams + 1
	BeltalowdaIsdp.state.beams[index] = {}
	BeltalowdaIsdp.state.beams[index].texture = "EsoUI/Art/icons/poi/poi_groupboss_complete.dds"
	BeltalowdaIsdp.state.beams[index].name = BeltalowdaIsdp.constants.BEAM_SKULL_USING_BUFFER
	BeltalowdaIsdp.state.beams[index].usesDepthBuffer = true
	BeltalowdaIsdp.state.beams[index].ignoreSize = true
	BeltalowdaIsdp.state.beams[index].height = 1
	BeltalowdaIsdp.state.beams[index].width = 1
	BeltalowdaIsdp.state.beams[index].heightOffset = 2
	index = index + 1
	BeltalowdaIsdp.state.beams[index] = {}
	BeltalowdaIsdp.state.beams[index].texture = "EsoUI/Art/icons/poi/poi_groupboss_complete.dds"
	BeltalowdaIsdp.state.beams[index].name = BeltalowdaIsdp.constants.BEAM_SKULL_NOT_USING_BUFFER
	BeltalowdaIsdp.state.beams[index].usesDepthBuffer = false
	BeltalowdaIsdp.state.beams[index].ignoreSize = true
	BeltalowdaIsdp.state.beams[index].height = 1
	BeltalowdaIsdp.state.beams[index].width = 1
	BeltalowdaIsdp.state.beams[index].heightOffset = 2
end

function BeltalowdaIsdp.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.size = 0.125
	defaults.texture = BeltalowdaBeams.constants.beams.BEAM_1
	defaults.colors = {}
	defaults.colors.dead = {}
	defaults.colors.dead.r = 1
	defaults.colors.dead.g = 0
	defaults.colors.dead.b = 0
	defaults.colors.dead.a = 0.75
	defaults.colors.beingRessurected = {}
	defaults.colors.beingRessurected.r = 0.86274509803921568627450980392157
	defaults.colors.beingRessurected.g = 0.65882352941176470588235294117647
	defaults.colors.beingRessurected.b = 0.18039215686274509803921568627451
	defaults.colors.beingRessurected.a = 0.75
	defaults.colors.ressurected = {}
	defaults.colors.ressurected.r = 0.16862745098039215686274509803922
	defaults.colors.ressurected.g = 0.91372549019607843137254901960784
	defaults.colors.ressurected.b = 0.12941176470588235294117647058824
	defaults.colors.ressurected.a = 0.75
	return defaults
end

function BeltalowdaIsdp.SetEnabled(value)
	if BeltalowdaIsdp.state.initialized == true and value ~= nil then
		BeltalowdaIsdp.isdpVars.enabled = value
		if value == true then
			if BeltalowdaIsdp.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaIsdp.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaIsdp.OnPlayerActivated)
			end
			BeltalowdaIsdp.state.registredConsumers = true
		else
			if BeltalowdaIsdp.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaIsdp.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaIsdp.state.registredConsumers = false
		end
		BeltalowdaIsdp.OnPlayerActivated()
	end
end

function BeltalowdaIsdp.AdjustSize()
	local beamConfig = BeltalowdaIsdp.state.beams[BeltalowdaIsdp.isdpVars.texture]
	for i = 1, #BeltalowdaIsdp.controls.beams do
		if beamConfig.ignoreSize == true then
			BeltalowdaIsdp.controls.beams[i]:Set3DLocalDimensions(beamConfig.width, beamConfig.height)
		else
			BeltalowdaIsdp.controls.beams[i]:Set3DLocalDimensions(BeltalowdaIsdp.isdpVars.size, beamConfig.height)
		end
	end
end

function BeltalowdaIsdp.AdjustTextures()
	local beamConfig = BeltalowdaIsdp.state.beams[BeltalowdaIsdp.isdpVars.texture]
	for i = 1, #BeltalowdaIsdp.controls.beams do
		BeltalowdaIsdp.controls.beams[i]:SetTexture(beamConfig.texture)
		BeltalowdaIsdp.controls.beams[i]:Set3DRenderSpaceUsesDepthBuffer(beamConfig.usesDepthBuffer)
	end
end

function BeltalowdaIsdp.GetBeamColor(isDead, isResurrected, isBeingResurrected)
	local color = nil
	if isBeingResurrected == true and isDead == true then
		color = BeltalowdaIsdp.isdpVars.colors.beingRessurected
	elseif isResurrected == true and isDead == true then
		color = BeltalowdaIsdp.isdpVars.colors.ressurected
	elseif isDead == true then
		color = BeltalowdaIsdp.isdpVars.colors.dead
	end
	return color
end

--callbacks
function BeltalowdaIsdp.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaIsdp.isdpVars = currentProfile.group.isdp
		if BeltalowdaIsdp.state.initialized == true then
			BeltalowdaIsdp.AdjustTextures()
			BeltalowdaIsdp.AdjustSize()
		end
		BeltalowdaIsdp.SetEnabled(BeltalowdaIsdp.isdpVars.enabled)
	end
end

function BeltalowdaIsdp.OnPlayerActivated(eventCode, initial)
	if BeltalowdaIsdp.isdpVars.enabled == true and (BeltalowdaIsdp.isdpVars.pvpOnly == false or (BeltalowdaIsdp.isdpVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaIsdp.state.registredActivationConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaIsdp.callbackName, BeltalowdaIsdp.config.updateInterval, BeltalowdaIsdp.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES, BeltalowdaIsdp.config.updateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaIsdp.config.distanceUpdateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE, BeltalowdaIsdp.config.deadStateUpdateInterval)
			BeltalowdaIsdp.state.registredActivationConsumers = true
		end
	else
		if BeltalowdaIsdp.state.registredActivationConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaIsdp.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaIsdp.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE)
			BeltalowdaIsdp.state.registredActivationConsumers = false
		end
		--Hide if neccessary
		for i = 1, #BeltalowdaIsdp.controls.beams do
			if BeltalowdaIsdp.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaIsdp.controls.beams[i])
				BeltalowdaIsdp.controls.beams[i].registeredTexture = false
			end
			BeltalowdaIsdp.controls.beams[i]:SetHidden(true)
		end
	end
end

function BeltalowdaIsdp.UiLoop()
	if BeltalowdaIsdp.isdpVars.enabled == true and (BeltalowdaIsdp.isdpVars.pvpOnly == false or (BeltalowdaIsdp.isdpVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		local beamIndex = 1
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			if #players > #BeltalowdaIsdp.controls.beams then
				local amount = #players - #BeltalowdaIsdp.controls.beams
				for i = 1, amount do
					local beam = BeltalowdaIsdp.CreateBeam()
					table.insert(BeltalowdaIsdp.controls.beams, beam)
					--BeltalowdaM3DO.RegisterTextureControl(beam)
				end
			end
			--local _, height, _ = lib3D:GetCameraRenderSpacePosition()
			local heading = GetPlayerCameraHeading()
			if heading > math.pi then 
				heading = heading - 2 * math.pi
			end
			local beamConfig = BeltalowdaIsdp.state.beams[BeltalowdaIsdp.isdpVars.texture]
			for i = 1, #players do
				local player = players[i]
				if player.isOnline == true and player.isPlayer == false and player.isLeader == false and player.distances ~= nil and player.distances.fromPlayer ~= nil and BeltalowdaIsdp.config.maxDistance >= player.distances.fromPlayer then
					local color = BeltalowdaIsdp.GetBeamColor(player.isDead, player.isResurrected, player.isBeingResurrected)
					if color ~= nil then
						local coordinates = player.coordinates
						local beam = BeltalowdaIsdp.controls.beams[beamIndex]
						beam:SetColor(color.r, color.g, color.b)
						--beam:Set3DRenderSpaceOrigin(coordinates.x, coordinates.height + beamConfig.heightOffset, coordinates.y)
						beam:Set3DRenderSpaceOrigin(coordinates.worldX, coordinates.worldHeight + beamConfig.heightOffset, coordinates.worldY)
						beam:Set3DRenderSpaceOrientation(0, heading, 0)
						beam:SetHidden(false)
						if beam.registeredTexture == false then
							BeltalowdaM3DO.RegisterTextureControl(beam)
							beam.registeredTexture = true
						end
						beam.coordinates = coordinates --layer test
						beamIndex = beamIndex + 1
					end
				end
			end	
		end
		for i = beamIndex, #BeltalowdaIsdp.controls.beams do
			BeltalowdaIsdp.controls.beams[i]:SetHidden(true)
			if BeltalowdaIsdp.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaIsdp.controls.beams[i])
				BeltalowdaIsdp.controls.beams[i].registeredTexture = false
			end
		end
	else
		for i = 1, #BeltalowdaIsdp.controls.beams do
			BeltalowdaIsdp.controls.beams[i]:SetHidden(true)
			if BeltalowdaIsdp.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaIsdp.controls.beams[i])
				BeltalowdaIsdp.controls.beams[i].registeredTexture = false
			end
		end
	end
end

--menu interaction
function BeltalowdaIsdp.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.ISDP_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ISDP_ENABLED,
					getFunc = BeltalowdaIsdp.GetIsdpEnabled,
					setFunc = BeltalowdaIsdp.SetIsdpEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.ISDP_PVP_ONLY,
					getFunc = BeltalowdaIsdp.GetIsdpPvpOnly,
					setFunc = BeltalowdaIsdp.SetIsdpPvpOnly
				},
				[3] = {
					type = "slider",
					name = BeltalowdaMenu.constants.ISDP_SIZE,
					min = 1,
					max = 16,
					step = 1,
					getFunc = BeltalowdaIsdp.GetIsdpSize,
					setFunc = BeltalowdaIsdp.SetIsdpSize,
					width = "full",
					default = 2
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.ISDP_SELECTED_BEAM,
					choices = BeltalowdaIsdp.GetIsdpBeams(),
					getFunc = BeltalowdaIsdp.GetIsdpSelectedBeam,
					setFunc = BeltalowdaIsdp.SetIsdpSelectedBeam
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.ISDP_COLOR_DEAD,
					getFunc = BeltalowdaIsdp.GetIsdpColorDead,
					setFunc = BeltalowdaIsdp.SetIsdpColorDead,
					width = "full"
				},
				[6] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.ISDP_COLOR_BEING_RESURRECTED,
					getFunc = BeltalowdaIsdp.GetIsdpColorBeingResurrected,
					setFunc = BeltalowdaIsdp.SetIsdpColorBeingResurrected,
					width = "full"
				},
				[7] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.ISDP_COLOR_RESURRECTED,
					getFunc = BeltalowdaIsdp.GetIsdpColorResurrected,
					setFunc = BeltalowdaIsdp.SetIsdpColorResurrected,
					width = "full"
				},
			}
		},		
	}
	return menu
end

function BeltalowdaIsdp.GetIsdpEnabled()
	return BeltalowdaIsdp.isdpVars.enabled
end

function BeltalowdaIsdp.SetIsdpEnabled(value)
	BeltalowdaIsdp.SetEnabled(value)
end

function BeltalowdaIsdp.GetIsdpPvpOnly()
	return BeltalowdaIsdp.isdpVars.pvpOnly
end

function BeltalowdaIsdp.SetIsdpPvpOnly(value)
	BeltalowdaIsdp.isdpVars.pvpOnly = value
	BeltalowdaIsdp.SetEnabled(BeltalowdaIsdp.isdpVars.enabled)
end

function BeltalowdaIsdp.GetIsdpSize()
	return BeltalowdaMath.FloatingPointToValue(BeltalowdaIsdp.isdpVars.size, 16)
end

function BeltalowdaIsdp.SetIsdpSize(value)
	if value ~= nil and value >= 1 and value <= 16 then
		BeltalowdaIsdp.isdpVars.size = BeltalowdaMath.ValueToFloatingPoint(value, 16)
		BeltalowdaIsdp.AdjustSize()
	end
end

function BeltalowdaIsdp.GetIsdpBeams()
	local names = {}
	for i = 1, #BeltalowdaIsdp.state.beams do
		table.insert(names, BeltalowdaIsdp.state.beams[i].name)
	end
	return names
end

function BeltalowdaIsdp.GetIsdpSelectedBeam()
	return BeltalowdaIsdp.state.beams[BeltalowdaIsdp.isdpVars.texture].name
end

function BeltalowdaIsdp.SetIsdpSelectedBeam(value)
	if value ~= nil then
		for i = 1, #BeltalowdaIsdp.state.beams do
			if BeltalowdaIsdp.state.beams[i].name == value then
				BeltalowdaIsdp.isdpVars.texture = i
				BeltalowdaIsdp.AdjustTextures()
				BeltalowdaIsdp.AdjustSize()
				return
			end
		end
	end
end

function BeltalowdaIsdp.GetIsdpColorDead()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaIsdp.isdpVars.colors.dead)
end

function BeltalowdaIsdp.SetIsdpColorDead(r, g, b, a)
	BeltalowdaIsdp.isdpVars.colors.dead = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

function BeltalowdaIsdp.GetIsdpColorBeingResurrected()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaIsdp.isdpVars.colors.beingRessurected)
end

function BeltalowdaIsdp.SetIsdpColorBeingResurrected(r, g, b, a)
	BeltalowdaIsdp.isdpVars.colors.beingRessurected = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

function BeltalowdaIsdp.GetIsdpColorResurrected()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaIsdp.isdpVars.colors.ressurected)
end

function BeltalowdaIsdp.SetIsdpColorResurrected(r, g, b, a)
	BeltalowdaIsdp.isdpVars.colors.ressurected = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end
