-- Beltalowda Group Beams
-- By @s0rdrak (PC / EU)

--local lib3D = LibStub("Lib3D2")
local lib3D = Lib3D

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.gb = BeltalowdaGroup.gb or {}
local BeltalowdaGBeam = BeltalowdaGroup.gb
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.moving3DObjects = BeltalowdaUtil.moving3DObjects  or {}
local BeltalowdaM3DO = BeltalowdaUtil.moving3DObjects
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.beams = BeltalowdaUtil.beams
local BeltalowdaBeams = BeltalowdaUtil.beams

BeltalowdaGBeam.callbackName = Beltalowda.addonName .. "GroupBeam"

BeltalowdaGBeam.constants = {}

BeltalowdaGBeam.controls = {}
BeltalowdaGBeam.controls.beams = {}

BeltalowdaGBeam.config = {}
BeltalowdaGBeam.config.updateInterval = 10
BeltalowdaGBeam.config.distanceUpdateInterval = 100
BeltalowdaGBeam.config.maxDistance = 200

BeltalowdaGBeam.state = {}
BeltalowdaGBeam.state.initialized = false
BeltalowdaGBeam.state.registredConsumers = false
BeltalowdaGBeam.state.registredActivationConsumers = false

local wm = GetWindowManager()

function BeltalowdaGBeam.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaGBeam.callbackName, BeltalowdaGBeam.OnProfileChanged)
	BeltalowdaGBeam.CreateBeams()
	BeltalowdaGBeam.state.initialized = true
	BeltalowdaGBeam.AdjustTextures()
	BeltalowdaGBeam.SetEnabled(BeltalowdaGBeam.gbVars.enabled)
end

function BeltalowdaGBeam.CreateBeams()
	for i = 1, 10 do
		table.insert(BeltalowdaGBeam.controls.beams, BeltalowdaGBeam.CreateBeam())
	end
end

function BeltalowdaGBeam.CreateBeam()
	local beam = wm:CreateControl(nil, BeltalowdaM3DO.GetDefaultTopLevelWindow(), CT_TEXTURE)
	beam:Create3DRenderSpace()
	beam:Set3DLocalDimensions(BeltalowdaGBeam.gbVars.size, 256)
	beam:SetDrawLevel(3)
	beam:SetTexture(BeltalowdaBeams.GetBeamByBeamId(BeltalowdaGBeam.gbVars.texture).texture)
	beam:Set3DRenderSpaceUsesDepthBuffer(true)
	beam:SetHidden(true)
	beam.registeredTexture = false
	return beam
end

function BeltalowdaGBeam.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.size = 0.5
	defaults.hideWhenDead = true
	defaults.texture = BeltalowdaBeams.constants.beams.BEAM_1
	defaults.roles = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].color.r = 0.05490196078431372549019607843137
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].color.g = 0.77254901960784313725490196078431
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].color.b = 0.09019607843137254901960784313725
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].color.r = 0.87450980392156862745098039215686
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].color.g = 0.94117647058823529411764705882353
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].color.b = 0.05882352941176470588235294117647
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].color.r = 0.6
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].color.g = 0.85098039215686274509803921568627
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].color.b = 0.91764705882352941176470588235294
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].color.r = 0.53333333333333333333333333333333
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].color.g = 0
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].color.b = 0.08235294117647058823529411764706
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].color.r = 0.70980392156862745098039215686275
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].color.g = 0.90196078431372549019607843137255
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].color.b = 0.11372549019607843137254901960784
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].color.r = 1
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].color.g = 0.78823529411764705882352941176471
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].color.b = 0.05490196078431372549019607843137
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].color.r = 0.44705882352941176470588235294118
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].color.g = 0.61176470588235294117647058823529
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].color.b = 0.61176470588235294117647058823529
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].enabled = false
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].color.r = 0.71764705882352941176470588235294
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].color.g = 0.58823529411764705882352941176471
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].color.b = 0.34117647058823529411764705882353
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER].color.a = 0.5
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT] = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].enabled = true
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].color = {}
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].color.r = 0.38039215686274509803921568627451
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].color.g = 0.22352941176470588235294117647059
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].color.b = 0.83529411764705882352941176470588
	defaults.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT].color.a = 0.5
	return defaults
end

function BeltalowdaGBeam.SetEnabled(value)
	if BeltalowdaGBeam.state.initialized == true and value ~= nil then
		BeltalowdaGBeam.gbVars.enabled = value
		if value == true then
			if BeltalowdaGBeam.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaGBeam.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaGBeam.OnPlayerActivated)
			end
			BeltalowdaGBeam.state.registredConsumers = true
		else
			if BeltalowdaGBeam.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaGBeam.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaGBeam.state.registredConsumers = false
		end
		BeltalowdaGBeam.OnPlayerActivated()
	end
end

function BeltalowdaGBeam.AdjustSize()
	local beam = BeltalowdaBeams.GetBeamByBeamId(BeltalowdaGBeam.gbVars.texture)
	for i = 1, #BeltalowdaGBeam.controls.beams do
		if beam.ignoreSize == false then
			BeltalowdaGBeam.controls.beams[i]:Set3DLocalDimensions(BeltalowdaGBeam.gbVars.size, beam.height)
		else
			BeltalowdaGBeam.controls.beams[i]:Set3DLocalDimensions(beam.width, beam.height)
		end
	end
end

function BeltalowdaGBeam.AdjustTextures()
	local beam = BeltalowdaBeams.GetBeamByBeamId(BeltalowdaGBeam.gbVars.texture)
	for i = 1, #BeltalowdaGBeam.controls.beams do
		BeltalowdaGBeam.controls.beams[i]:SetTexture(beam.texture)
		BeltalowdaGBeam.controls.beams[i]:Set3DRenderSpaceUsesDepthBuffer(beam.usesDepthBuffer)
	end
	BeltalowdaGBeam.AdjustSize()
end

function BeltalowdaGBeam.GetRoleBeamInformation(role)
	local color = nil
	local enabled = false
	if BeltalowdaGBeam.gbVars.roles[role] ~= nil then
		if BeltalowdaGBeam.gbVars.roles[role].enabled ~= nil then
			enabled = BeltalowdaGBeam.gbVars.roles[role].enabled
		end
		if BeltalowdaGBeam.gbVars.roles[role].color ~= nil then
			color = BeltalowdaGBeam.gbVars.roles[role].color
		end
	end
	return enabled, color
end

function BeltalowdaGBeam.GetEnabled()
	return (BeltalowdaGBeam.gbVars.enabled == true and (BeltalowdaGBeam.gbVars.pvpOnly == false or (BeltalowdaGBeam.gbVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)))
end

--callbacks
function BeltalowdaGBeam.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaGBeam.gbVars = currentProfile.group.gb
		if BeltalowdaGBeam.state.initialized == true then
			BeltalowdaGBeam.AdjustTextures()
		end
		BeltalowdaGBeam.SetEnabled(BeltalowdaGBeam.gbVars.enabled)
	end
end

function BeltalowdaGBeam.OnPlayerActivated(eventCode, initial)
	if BeltalowdaGBeam.gbVars.enabled == true and (BeltalowdaGBeam.gbVars.pvpOnly == false or (BeltalowdaGBeam.gbVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaGBeam.state.registredActivationConsumers == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaGBeam.callbackName, BeltalowdaGBeam.config.updateInterval, BeltalowdaGBeam.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaGBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES, BeltalowdaGBeam.config.updateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaGBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE, BeltalowdaGBeam.config.distanceUpdateInterval)
			BeltalowdaGBeam.state.registredActivationConsumers = true
		end
	else
		if BeltalowdaGBeam.state.registredActivationConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaGBeam.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaGBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaGBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE)
			BeltalowdaGBeam.state.registredActivationConsumers = false
		end
		--Hide if neccessary
		for i = 1, #BeltalowdaGBeam.controls.beams do
			if BeltalowdaGBeam.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaGBeam.controls.beams[i])
				BeltalowdaGBeam.controls.beams[i].registeredTexture = false
			end
			BeltalowdaGBeam.controls.beams[i]:SetHidden(true)
		end
	end
end

function BeltalowdaGBeam.UiLoop()
	--d("ui loop")
	if BeltalowdaGBeam.gbVars.enabled == true and (BeltalowdaGBeam.gbVars.pvpOnly == false or (BeltalowdaGBeam.gbVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		--d("ui loop enabled")
		local beamIndex = 1
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			if #players > #BeltalowdaGBeam.controls.beams then
				local amount = #players - #BeltalowdaGBeam.controls.beams
				for i = 1, amount do
					local beam = BeltalowdaGBeam.CreateBeam()
					table.insert(BeltalowdaGBeam.controls.beams, beam)
					BeltalowdaGBeam.AdjustTextures()
					--BeltalowdaM3DO.RegisterTextureControl(beam)
				end
			end
			--local _, height, _ = lib3D:GetCameraRenderSpacePosition()
			local heading = GetPlayerCameraHeading()
			if heading > math.pi then 
				heading = heading - 2 * math.pi
			end
			for i = 1, #players do
				local player = players[i]
				local role = player.role
				--d(role)
				if role ~= nil and player.isOnline == true and player.isPlayer == false and player.isLeader == false then
					local enabled, color = BeltalowdaGBeam.GetRoleBeamInformation(role)
					--d("here we go")
					
					if enabled == true and player.distances.fromPlayer ~= nil and BeltalowdaGBeam.config.maxDistance >= player.distances.fromPlayer and (BeltalowdaGBeam.gbVars.hideWhenDead == false or (BeltalowdaGBeam.gbVars.hideWhenDead == true and player.isDead == false)) then
						local coordinates = player.coordinates
						local beam = BeltalowdaGBeam.controls.beams[beamIndex]
						local beamTemplate = BeltalowdaBeams.GetBeamByBeamId(BeltalowdaGBeam.gbVars.texture)
						beam:SetColor(color.r, color.g, color.b)
						--beam:Set3DRenderSpaceOrigin(coordinates.x, coordinates.height , coordinates.y)
						beam:Set3DRenderSpaceOrigin(coordinates.worldX, coordinates.worldHeight + beamTemplate.heightOffset, coordinates.worldY)
						beam:Set3DRenderSpaceOrientation(0, heading, 0)
						beam:SetHidden(false)
						if beam.registeredTexture == false then
							BeltalowdaM3DO.RegisterTextureControl(beam)
							beam.registeredTexture = true
						end
						beam.coordinates = coordinates --layer test 
						beamIndex = beamIndex + 1
						--d("done")
					end
				end
			end
			
		end
		for i = beamIndex, #BeltalowdaGBeam.controls.beams do
			BeltalowdaGBeam.controls.beams[i]:SetHidden(true)
			if BeltalowdaGBeam.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaGBeam.controls.beams[i])
				BeltalowdaGBeam.controls.beams[i].registeredTexture = false
			end
		end
	else
		for i = 1, #BeltalowdaGBeam.controls.beams do
			BeltalowdaGBeam.controls.beams[i]:SetHidden(true)
			if BeltalowdaGBeam.controls.beams[i].registeredTexture == true then
				BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaGBeam.controls.beams[i])
				BeltalowdaGBeam.controls.beams[i].registeredTexture = false
			end
		end
	end
end

--menu interaction
function BeltalowdaGBeam.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.GB_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = BeltalowdaMenu.constants.GB_DESCRIPTION
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ENABLED,
					getFunc = BeltalowdaGBeam.GetGbEnabled,
					setFunc = BeltalowdaGBeam.SetGbEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_PVP_ONLY,
					getFunc = BeltalowdaGBeam.GetGbPvpOnly,
					setFunc = BeltalowdaGBeam.SetGbPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_HIDE_WHEN_DEAD,
					getFunc = BeltalowdaGBeam.GetGbHideWhenDead,
					setFunc = BeltalowdaGBeam.SetGbHideWhenDead
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.GB_SIZE,
					min = 1,
					max = 8,
					step = 1,
					getFunc = BeltalowdaGBeam.GetGbSize,
					setFunc = BeltalowdaGBeam.SetGbSize,
					width = "full",
					default = 4
				},
				[6] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.GB_SELECTED_BEAM,
					choices = BeltalowdaGBeam.GetGbBeams(),
					getFunc = BeltalowdaGBeam.GetGbSelectedBeam,
					setFunc = BeltalowdaGBeam.SetGbSelectedBeam
				},
				[7] = {
					type = "divider",
					width = "full"
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_RAPID_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_RAPID) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_RAPID, value) end,
					width = "full"
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_RAPID_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_RAPID) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_RAPID, r, g, b, a) end,
					width = "full"
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_PURGE_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_PURGE) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_PURGE, value) end,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_PURGE_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_PURGE) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_PURGE, r, g, b, a) end,
					width = "full"
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_HEAL_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_HEAL) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_HEAL, value) end,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_HEAL_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_HEAL) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_HEAL, r, g, b, a) end,
					width = "full"
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_DD_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_DD) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_DD, value) end,
					width = "full"
				},
				[15] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_DD_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_DD) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_DD, r, g, b, a) end,
					width = "full"
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_SYNERGY_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY, value) end,
					width = "full"
				},
				[17] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_SYNERGY_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY, r, g, b, a) end,
					width = "full"
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_CC_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_CC) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_CC, value) end,
					width = "full"
				},
				[19] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_CC_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_CC) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_CC, r, g, b, a) end,
					width = "full"
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_SUPPORT_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT, value) end,
					width = "full"
				},
				[21] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_SUPPORT_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT, r, g, b, a) end,
					width = "full"
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER, value) end,
					width = "full"
				},
				[23] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER, r, g, b, a) end,
					width = "full"
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.GB_ROLE_APPLICANT_ENABLED,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT) end,
					setFunc = function(value) BeltalowdaGBeam.SetGbRoleEnabled(BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT, value) end,
					width = "full"
				},
				[25] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.GB_ROLE_APPLICANT_COLOR,
					getFunc = function() return BeltalowdaGBeam.GetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT) end,
					setFunc = function(r, g, b, a) BeltalowdaGBeam.SetGbRoleColor(BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT, r, g, b, a) end,
					width = "full"
				}
			}
		}
	}
	return menu
end


function BeltalowdaGBeam.GetGbEnabled()
	return BeltalowdaGBeam.gbVars.enabled
end

function BeltalowdaGBeam.SetGbEnabled(value)
	BeltalowdaGBeam.SetEnabled(value)
end

function BeltalowdaGBeam.GetGbPvpOnly()
	return BeltalowdaGBeam.gbVars.pvpOnly
end

function BeltalowdaGBeam.SetGbPvpOnly(value)
	BeltalowdaGBeam.gbVars.pvpOnly = value
	BeltalowdaGBeam.SetEnabled(BeltalowdaGBeam.gbVars.enabled)
end

function BeltalowdaGBeam.GetGbSize()
	return BeltalowdaMath.FloatingPointToValue(BeltalowdaGBeam.gbVars.size, 8)
end

function BeltalowdaGBeam.SetGbSize(value)
	if value ~= nil and value >= 1 and value <= 8 then
		BeltalowdaGBeam.gbVars.size = BeltalowdaMath.ValueToFloatingPoint(value, 8)
		BeltalowdaGBeam.AdjustSize()
	end
end

function BeltalowdaGBeam.GetGbHideWhenDead()
	return BeltalowdaGBeam.gbVars.hideWhenDead
end

function BeltalowdaGBeam.SetGbHideWhenDead(value)
	BeltalowdaGBeam.gbVars.hideWhenDead = value
end

function BeltalowdaGBeam.GetGbBeams()
	return BeltalowdaBeams.GetBeamNames()
end

function BeltalowdaGBeam.GetGbSelectedBeam()
	return BeltalowdaBeams.GetBeamByBeamId(BeltalowdaGBeam.gbVars.texture).name
end

function BeltalowdaGBeam.SetGbSelectedBeam(value)
	if value ~= nil then
		BeltalowdaGBeam.gbVars.texture = BeltalowdaBeams.GetBeamIdByName(value)
		BeltalowdaGBeam.AdjustTextures()
	end
end

function BeltalowdaGBeam.GetGbRoleEnabled(role)
	return BeltalowdaGBeam.gbVars.roles[role].enabled
end

function BeltalowdaGBeam.SetGbRoleEnabled(role, value)
	BeltalowdaGBeam.gbVars.roles[role].enabled = value
end

function BeltalowdaGBeam.GetGbRoleColor(role)
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaGBeam.gbVars.roles[role].color)
end

function BeltalowdaGBeam.SetGbRoleColor(role, r, g, b, a)
	BeltalowdaGBeam.gbVars.roles[role].color = BeltalowdaMenu.GetColorFromRGB(r, g, b, a)
end

