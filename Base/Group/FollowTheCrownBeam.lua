-- Beltalowda Follow The Crown Beam
-- By @s0rdrak (PC / EU)

--local lib3D = LibStub("Lib3D2")

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.ftcb = BeltalowdaGroup.ftcb or {}
local BeltalowdaBeam = BeltalowdaGroup.ftcb
BeltalowdaUtil.moving3DObjects = BeltalowdaUtil.moving3DObjects  or {}
local BeltalowdaM3DO = BeltalowdaUtil.moving3DObjects
BeltalowdaUtil.beams = BeltalowdaUtil.beams
local BeltalowdaBeams = BeltalowdaUtil.beams

BeltalowdaBeam.callbackName = Beltalowda.addonName .. "FollowTheCrownBeam"

BeltalowdaBeam.constants = {}

BeltalowdaBeam.controls = {}

BeltalowdaBeam.config = {}
BeltalowdaBeam.config.updateInterval = 10
BeltalowdaBeam.config.distanceUpdateInterval = 100
BeltalowdaBeam.config.maxDistance = 200

BeltalowdaBeam.state = {}
BeltalowdaBeam.state.initialized = false
BeltalowdaBeam.state.registredConsumers = false
BeltalowdaBeam.state.registredActivationConsumers = false
BeltalowdaBeam.state.controlCallbackRegistered = false
BeltalowdaBeam.state.textureRegistered = false

local wm = GetWindowManager()

function BeltalowdaBeam.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaBeam.callbackName, BeltalowdaBeam.OnProfileChanged)
	BeltalowdaBeam.controls.beam = wm:CreateControl(nil, BeltalowdaM3DO.GetDefaultTopLevelWindow(), CT_TEXTURE)
	BeltalowdaBeam.controls.beam:Create3DRenderSpace()
	BeltalowdaBeam.controls.beam:Set3DLocalDimensions(1, 256)
	BeltalowdaBeam.controls.beam:SetDrawLevel(3)
	BeltalowdaBeam.controls.beam:SetHidden(true)
	BeltalowdaBeam.controls.beam:Set3DRenderSpaceUsesDepthBuffer(true)
	BeltalowdaBeam.state.initialized = true
	BeltalowdaBeam.AdjustTexture()
	BeltalowdaBeam.AdjustColor()
	BeltalowdaBeam.SetEnabled(BeltalowdaBeam.ftcbVars.enabled)
	--BeltalowdaM3DO.RegisterTextureControl(BeltalowdaBeam.controls.beam)
end

function BeltalowdaBeam.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.pvpOnly = true
	defaults.selectedTexture = BeltalowdaBeams.constants.beams.BEAM_1
	defaults.color = {}
	defaults.color.r = 0
	defaults.color.g = 0.5
	defaults.color.b = 1
	defaults.color.a = 0.75
	return defaults
end

function BeltalowdaBeam.SetEnabled(value)
	--d("SetEnabled")
	if BeltalowdaBeam.state.initialized == true and value ~= nil then
		--d("dafuq")
		BeltalowdaBeam.ftcbVars.enabled = value
		if value == true then
			if BeltalowdaBeam.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaBeam.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaBeam.OnPlayerActivated)
			end
			BeltalowdaBeam.state.registredConsumers = true
		else
			if BeltalowdaBeam.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaBeam.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaBeam.state.registredConsumers = false
		end
		BeltalowdaBeam.OnPlayerActivated()
	end
end

function BeltalowdaBeam.AdjustColor()
	BeltalowdaBeam.controls.beam:SetColor(BeltalowdaBeam.ftcbVars.color.r, BeltalowdaBeam.ftcbVars.color.g, BeltalowdaBeam.ftcbVars.color.b, BeltalowdaBeam.ftcbVars.color.a)
end

function BeltalowdaBeam.AdjustTexture()
	local beam = BeltalowdaBeams.GetBeamByBeamId(BeltalowdaBeam.ftcbVars.selectedTexture)
	BeltalowdaBeam.controls.beam:SetTexture(beam.texture)
	BeltalowdaBeam.controls.beam:Set3DLocalDimensions(beam.width, beam.height)
	BeltalowdaBeam.controls.beam:Set3DRenderSpaceUsesDepthBuffer(beam.usesDepthBuffer)
end

--callbacks
function BeltalowdaBeam.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaBeam.ftcbVars = currentProfile.group.ftcb
		if BeltalowdaBeam.state.initialized == true then
			BeltalowdaBeam.AdjustColor()
			BeltalowdaBeam.AdjustTexture()
		end
		BeltalowdaBeam.SetEnabled(BeltalowdaBeam.ftcbVars.enabled)
	end
end

-- Check if beam features should be enabled based on detector settings
function BeltalowdaBeam.ShouldEnableBeam()
	local detector = Beltalowda.addOnIntegration.detector
	if detector and detector.ShouldEnableBuiltIn and detector.detectorVars then
		local addonType = detector.constants.ADDON_TYPE_BEAM
		local mode = detector.detectorVars.beamMode
		return detector.ShouldEnableBuiltIn(addonType, mode)
	end
	
	-- Default behavior if detector not available
	return true
end

function BeltalowdaBeam.OnPlayerActivated(eventCode, initial)
	--d("player activated")
	
	-- Check if we should enable based on detector settings
	local shouldEnable = BeltalowdaBeam.ShouldEnableBeam()
	
	if shouldEnable and BeltalowdaBeam.ftcbVars.enabled == true and (BeltalowdaBeam.ftcbVars.pvpOnly == false or (BeltalowdaBeam.ftcbVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaBeam.state.registredActivationConsumers == false then
			--d("enabled")
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaBeam.callbackName, BeltalowdaBeam.config.updateInterval, BeltalowdaBeam.UiLoop)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES, BeltalowdaBeam.config.updateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_DISTANCE, BeltalowdaBeam.config.distanceUpdateInterval)
			--lib3D:RegisterWorldChangeCallback(BeltalowdaBeam.callbackName, BeltalowdaBeam.OnWorldMove)
			--BeltalowdaBeam.OnWorldMove()
			BeltalowdaBeam.state.registredActivationConsumers = true
		end
		--BeltalowdaM3DO.RegisterTextureControl(BeltalowdaBeam.controls.beam)
	else
		if BeltalowdaBeam.state.registredActivationConsumers == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaBeam.callbackName)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaBeam.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_LEADER_DISTANCE)
			--lib3D:UnregisterWorldChangeCallback(BeltalowdaBeam.callbackName)
			BeltalowdaBeam.state.registredActivationConsumers = false
		end
		BeltalowdaBeam.controls.beam:SetHidden(true)
		if BeltalowdaBeam.state.textureRegistered == true then
			BeltalowdaBeam.state.textureRegistered = false
			BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaBeam.controls.beam)
		end
	end
end

--[[
function BeltalowdaBeam.OnWorldMove()
	--d("OnWorldMove")
	local x, z = lib3D:GlobalToWorld(lib3D:GetWorldOriginAsGlobal())
	BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(x, 0, z)
end

function BeltalowdaBeam.RenderSpaceUpdate()
	local x, y, z = BeltalowdaBeam.controls.beam:Get3DRenderSpaceOrigin()
	if x ~= 0 and z ~= 0 then
		--d("changed location")
		local x, z = lib3D:GlobalToWorld(lib3D:GetWorldOriginAsGlobal())
		BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(x, 0, z)
	end
end
]]

function BeltalowdaBeam.UiLoop()
	local drawBeam = false
	--d("loop")
	if BeltalowdaBeam.ftcbVars.enabled == true and (BeltalowdaBeam.ftcbVars.pvpOnly == false or (BeltalowdaBeam.ftcbVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			local leaderDistance = BeltalowdaUtilGroup.GetLeaderDistance()
			if leaderDistance ~= nil and leaderDistance < BeltalowdaBeam.config.maxDistance then
				
				local leader = nil
				local zoneIndex = nil
				for i = 1, #players do
					if players[i].isLeader == true then
						leader = players[i]
						zoneIndex = GetUnitZoneIndex(players[i].unitTag)
						break
					end
				end
				--d(leader)
				if leader ~= nil then
					if leader.isPlayer == false and leader.coordinates ~= nil and zoneIndex ~= nil and zoneIndex == GetUnitZoneIndex("player") then
						--d("yes, draw a beam")
						drawBeam = true
						local beam = BeltalowdaBeams.GetBeamByBeamId(BeltalowdaBeam.ftcbVars.selectedTexture)
						--local _, height, _ = lib3D:GetCameraRenderSpacePosition()
						--d("code path reached")
						--d("Position: " .. leader.coordinates.x .. ", " .. height .. ", " .. leader.coordinates.y)
						--BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(leader.coordinates.x, leader.coordinates.height , leader.coordinates.y)
						--if GetUnitZoneIndex(leader.unitTag) == 373 or GetUnitZoneIndex(leader.unitTag) == 346 then
							--wtf IC / Sewers?
							--[[
							d("---")
							d("IC")
							d(leader.coordinates.worldX)
							d(leader.coordinates.worldHeight)
							d(leader.coordinates.worldY)
							
							TestOffset = TestOffset or 0
							
							local x, y, z = GetMapPlayerPosition(leader.unitTag)
							local worldX, worldZ = Lib3D:LocalToWorld(x, y)
							local _, height, _ = Lib3D:GetCameraRenderSpacePosition()
							d("-Camera")
							d(worldX)
							d(height)
							d(worldZ)
							if worldX ~= nil and worldZ ~= nil then
								worldX, _, worldZ = WorldPositionToGuiRender3DPosition(worldX * 100, 0, worldZ*100)
							end
							d("-RenderSpace Camera")
							d(worldX)
							d(height)
							d(worldZ)
							d("-Raw")
							local _, x, y, z = GetUnitRawWorldPosition(leader.unitTag)
							d(x)
							d(y)
							d(z)
							d("-Raw - Render Position")
							x, y, z = WorldPositionToGuiRender3DPosition(x , y + TestOffset, z)
							d(x)
							d(y)
							d(z)
							x, y, z = WorldPositionToGuiRender3DPosition( x, y, z )
							--BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(leader.coordinates.worldX / 100, (leader.coordinates.worldHeight + beam.heightOffset) / 100, leader.coordinates.worldY / 100)
							BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(x / 100, y / 100, z / 100)
							BeltalowdaBeam.controls.beam:Set3DRenderSpaceUsesDepthBuffer(false)
							]]
						--else
							--d("Not IC")
							BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrigin(leader.coordinates.worldX, leader.coordinates.worldHeight + beam.heightOffset, leader.coordinates.worldY)
						--end
						local heading = GetPlayerCameraHeading()
						if heading > math.pi then 
							heading = heading - 2 * math.pi
						end
						BeltalowdaBeam.controls.beam:Set3DRenderSpaceOrientation(0, heading, 0)
						BeltalowdaBeam.controls.beam.coordinates = leader.coordinates --layer test
					end
				end
			end
		end
	end
	--draw beam
	if drawBeam == true then
		BeltalowdaBeam.controls.beam:SetHidden(false)
		if BeltalowdaBeam.state.textureRegistered == false then
			BeltalowdaBeam.state.textureRegistered = true
			BeltalowdaM3DO.RegisterTextureControl(BeltalowdaBeam.controls.beam)
		end
		--[[
		if BeltalowdaBeam.state.controlCallbackRegistered == false then
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaBeam.controlCallbackName, 0, BeltalowdaBeam.RenderSpaceUpdate)
			BeltalowdaBeam.state.controlCallbackRegistered = true
		end
		]]
		--d("all good")
	else
		BeltalowdaBeam.controls.beam:SetHidden(true)
		if BeltalowdaBeam.state.textureRegistered == true then
			BeltalowdaBeam.state.textureRegistered = false
			BeltalowdaM3DO.UnregisterTextureControl(BeltalowdaBeam.controls.beam)
		end
		--[[
		if BeltalowdaBeam.state.controlCallbackRegistered == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaBeam.controlCallbackName)
			BeltalowdaBeam.state.controlCallbackRegistered = false
		end
		]]
	end
end

--menu interaction
function BeltalowdaBeam.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.FTCB_HEADER,
			--width = "full",
			controls = {
				[1] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.FTCB_WARNING,
					width = "full"
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCB_ENABLED,
					getFunc = BeltalowdaBeam.GetFtcbEnabled,
					setFunc = BeltalowdaBeam.SetFtcbEnabled,
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCB_PVP_ONLY,
					getFunc = BeltalowdaBeam.GetFtcbPvpOnly,
					setFunc = BeltalowdaBeam.SetFtcbPvpOnly,
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.FTCB_SELECTED_BEAM,
					choices = BeltalowdaBeam.GetFtcbBeams(),
					getFunc = BeltalowdaBeam.GetFtcbSelectedBeam,
					setFunc = BeltalowdaBeam.SetFtcbSelectedBeam,
					width = "full"
				},
				[5] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.FTCB_COLOR,
					getFunc = BeltalowdaBeam.GetFtcbColor,
					setFunc = BeltalowdaBeam.SetFtcbColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaBeam.GetFtcbEnabled()
	return BeltalowdaBeam.ftcbVars.enabled
end

function BeltalowdaBeam.SetFtcbEnabled(value)
	BeltalowdaBeam.SetEnabled(value)
end

function BeltalowdaBeam.GetFtcbPvpOnly()
	return BeltalowdaBeam.ftcbVars.pvpOnly
end

function BeltalowdaBeam.SetFtcbPvpOnly(value)
	BeltalowdaBeam.ftcbVars.pvpOnly = value
	BeltalowdaBeam.SetEnabled(BeltalowdaBeam.ftcbVars.enabled)
end

function BeltalowdaBeam.GetFtcbBeams()
	return BeltalowdaBeams.GetBeamNames()
end

function BeltalowdaBeam.GetFtcbSelectedBeam()
	return BeltalowdaBeams.GetBeamByBeamId(BeltalowdaBeam.ftcbVars.selectedTexture).name
end

function BeltalowdaBeam.SetFtcbSelectedBeam(value)
	if value ~= nil then
		BeltalowdaBeam.ftcbVars.selectedTexture = BeltalowdaBeams.GetBeamIdByName(value)
		BeltalowdaBeam.AdjustTexture()
	end
end

function BeltalowdaBeam.GetFtcbColor()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaBeam.ftcbVars.color)
end

function BeltalowdaBeam.SetFtcbColor(r, g, b, a)
	BeltalowdaBeam.ftcbVars.color = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaBeam.AdjustColor()
end
