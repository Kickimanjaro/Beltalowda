-- Beltalowda 3D Moving Objects
-- By @s0rdrak (PC / EU)

--local lib3D = LibStub("Lib3D2")
local lib3D = Lib3D
local libGPS = LibGPS2

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.moving3DObjects = BeltalowdaUtil.moving3DObjects  or {}
local BeltalowdaM3DO = BeltalowdaUtil.moving3DObjects


BeltalowdaM3DO.callbackName = Beltalowda.addonName .. "UtilM3DO"
BeltalowdaM3DO.drawLayerCallbackName = Beltalowda.addonName .. "UtilM3DODrawLayerUpdate"

BeltalowdaM3DO.constants = BeltalowdaM3DO.constants or {}
BeltalowdaM3DO.constants.updateIntervals = {}
BeltalowdaM3DO.constants.updateIntervals.AWAY = 1
BeltalowdaM3DO.constants.updateIntervals.CLOSE = 2
BeltalowdaM3DO.constants.updateIntervals.CRITICAL = 3
BeltalowdaM3DO.constants.MEASUREMENT_CONTROL = BeltalowdaM3DO.callbackName .. "MeasurementControl"
BeltalowdaM3DO.constants.CAMERA_CONTROL = BeltalowdaM3DO.callbackName .. "CameraControl"
BeltalowdaM3DO.constants.PREFIX = "M3DO"

BeltalowdaM3DO.config = {}
BeltalowdaM3DO.config.updateIntervals = {}
BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.constants.updateIntervals.AWAY] = 1500
BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.constants.updateIntervals.CLOSE] = 100
BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.constants.updateIntervals.CRITICAL] = 0
BeltalowdaM3DO.config.drawLayerUpdateInterval = 10
BeltalowdaM3DO.config.lowestDrawLayer = 3

BeltalowdaM3DO.state = {}
BeltalowdaM3DO.state.initialized = false
BeltalowdaM3DO.state.registeredControls = {}
BeltalowdaM3DO.state.updateRegistered = false
BeltalowdaM3DO.state.measurementControl = nil
BeltalowdaM3DO.state.cameraControl = nil
BeltalowdaM3DO.state.currentUpdateInterval = nil
BeltalowdaM3DO.state.registeredTextureControls = {}

local wm = GetWindowManager()
local measurementControl = nil
local cameraControl = nil

function BeltalowdaM3DO.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.OnProfileChanged)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaM3DO.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaM3DO.OnPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaM3DO.callbackName, EVENT_PLAYER_DEACTIVATED, BeltalowdaM3DO.OnPlayerDeactivated)
	BeltalowdaM3DO.state.measurementControl = wm:CreateTopLevelWindow(BeltalowdaM3DO.constants.MEASUREMENT_CONTROL)
	BeltalowdaM3DO.state.measurementControl:Create3DRenderSpace()
	measurementControl = BeltalowdaM3DO.state.measurementControl
	measurementControl:SetDrawTier(0)
	measurementControl:SetDrawLayer(0)
	measurementControl:SetDrawLevel(0)
	BeltalowdaM3DO.state.cameraControl = wm:CreateTopLevelWindow(BeltalowdaM3DO.constants.CAMERA_CONTROL)
	BeltalowdaM3DO.state.cameraControl:Create3DRenderSpace()
	cameraControl = BeltalowdaM3DO.state.cameraControl
	BeltalowdaM3DO.state.initialized = true
	lib3D:RegisterWorldChangeCallback(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.OnWorldMove)
end

function BeltalowdaM3DO.GetDefaults()
	local defaults = {}

	return defaults
end

function BeltalowdaM3DO.ContainsControl(control, container)
	local containsControl = false
	local index = 0
	for i = 1, #container do
		if container[i] == control then
			containsControl = true
			index = i
			break
		end
	end
	return containsControl, index
end

function BeltalowdaM3DO.RegisterControl(control)
	if control ~= nil then
		if BeltalowdaM3DO.ContainsControl(control, BeltalowdaM3DO.state.registeredControls) == false then
			table.insert(BeltalowdaM3DO.state.registeredControls, control)
		end
		if BeltalowdaM3DO.state.updateRegistered == false then
			BeltalowdaM3DO.state.currentUpdateInterval = BeltalowdaM3DO.GetUpdateIntervalFromDistance()
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.state.currentUpdateInterval], BeltalowdaM3DO.OnUpdate)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.drawLayerCallbackName, BeltalowdaM3DO.config.drawLayerUpdateInterval, BeltalowdaM3DO.DrawLayerUpdateLoop)
			BeltalowdaM3DO.state.updateRegistered = true
		end
	end
end

function BeltalowdaM3DO.UnregisterControl(control)
	if control ~= nil then
		local containsItem, index = BeltalowdaM3DO.ContainsControl(control, BeltalowdaM3DO.state.registeredControls)
		if containsItem == true then
			table.remove(BeltalowdaM3DO.state.registeredControls, index)
			if #BeltalowdaM3DO.state.registeredControls == 0 and #BeltalowdaM3DO.state.registeredTextureControls == 0 and BeltalowdaM3DO.state.updateRegistered == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.callbackName)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.drawLayerCallbackName)
				BeltalowdaM3DO.state.updateRegistered = false
			end
		end
	end
end

function BeltalowdaM3DO.RegisterTextureControl(control)
	--d("register texture control")
	if control ~= nil and control.GetType ~= nil and type(control.GetType) == "function" and control:GetType() == CT_TEXTURE then
		local found, _ = BeltalowdaM3DO.ContainsControl(control, BeltalowdaM3DO.state.registeredTextureControls)
		if found == false then
			table.insert(BeltalowdaM3DO.state.registeredTextureControls, control)
			control:SetParent(measurementControl)
			control.origDrawLevel = control:GetDrawLevel()
			if BeltalowdaM3DO.state.updateRegistered == false then
				BeltalowdaM3DO.state.currentUpdateInterval = BeltalowdaM3DO.GetUpdateIntervalFromDistance()
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.state.currentUpdateInterval], BeltalowdaM3DO.OnUpdate)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.drawLayerCallbackName, BeltalowdaM3DO.config.drawLayerUpdateInterval, BeltalowdaM3DO.DrawLayerUpdateLoop)
				BeltalowdaM3DO.state.updateRegistered = true
			end
		end
	end
end

function BeltalowdaM3DO.UnregisterTextureControl(control)
	--d("unregister texture control")
	if control ~= nil and control.GetType ~= nil and type(control.GetType) == "function" and control:GetType() == CT_TEXTURE then
		local found, index = BeltalowdaM3DO.ContainsControl(control, BeltalowdaM3DO.state.registeredTextureControls)
		if found == true then
			BeltalowdaM3DO.state.registeredTextureControls[index]:SetDrawLevel(BeltalowdaM3DO.state.registeredTextureControls[index].origDrawLevel)
			table.remove(BeltalowdaM3DO.state.registeredTextureControls, index)
			if #BeltalowdaM3DO.state.registeredControls == 0 and #BeltalowdaM3DO.state.registeredTextureControls == 0 and BeltalowdaM3DO.state.updateRegistered == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.callbackName)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.drawLayerCallbackName)
				BeltalowdaM3DO.state.updateRegistered = false
			end
		end
	end
end

function BeltalowdaM3DO.GetUpdateIntervalFromDistance()
	local x, y = GetMapPlayerPosition("player")
	x, y = libGPS:LocalToGlobal(x, y)
	local updateInterval = BeltalowdaM3DO.constants.updateIntervals.AWAY
	if x ~= nil and x ~= 0 and lib3D:IsValidZone() then
		local originX, originY = lib3D:GetCurrentWorldOriginAsGlobal()
		local factor, _ = lib3D:GetGlobalToWorldFactor(GetZoneId(GetUnitZoneIndex("player")))
		if factor ~= nil then
			x = (originX - x) * factor
			y = (originX - y) * factor
			local distance = x * x + y * y
			if distance >= 902500 then --[[950*950]]
				updateInterval = BeltalowdaM3DO.constants.updateIntervals.CRITICAL
			elseif distance >= 902500 then
				updateInterval = BeltalowdaM3DO.constants.updateIntervals.CLOSE
			end
		else
			BeltalowdaChat.SendChatMessage("GetUpdateIntervalFromDistance: Factor = nil", BeltalowdaM3DO.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		end
	end
	return updateInterval
end

function BeltalowdaM3DO.OnWorldMove()
	--d("OnWorldMove")
	--[[
	local x, z = lib3D:GlobalToWorld(lib3D:GetCurrentWorldOriginAsGlobal())
	measurementControl:Set3DRenderSpaceOrigin(x, 0, z)
	]]
	BeltalowdaM3DO.UpdateAll()
end

function BeltalowdaM3DO.UpdateAll()
	local x, y = lib3D:GlobalToWorld(lib3D:GetCurrentWorldOriginAsGlobal())
	for i = 1, #BeltalowdaM3DO.state.registeredControls do
		BeltalowdaM3DO.state.registeredControls[i]:Set3DRenderSpaceOrigin(x, 0, y)
	end
	measurementControl:Set3DRenderSpaceOrigin(x, 0, y)
end

function BeltalowdaM3DO.GetDefaultTopLevelWindow()
	return measurementControl
end

function BeltalowdaM3DO.CalculateDistances()
	Set3DRenderSpaceToCurrentCamera(BeltalowdaM3DO.constants.CAMERA_CONTROL)
	local x, height, y = cameraControl:Get3DRenderSpaceOrigin()
	for i = 1, #BeltalowdaM3DO.state.registeredTextureControls do
		local coordinates = BeltalowdaM3DO.state.registeredTextureControls[i].coordinates
		if coordinates ~= nil and coordinates.x ~= nil and coordinates.y ~= nil then
			local distanceX = x - coordinates.x
			local distanceY = y - coordinates.y
			BeltalowdaM3DO.state.registeredTextureControls[i].distance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
		else
			BeltalowdaM3DO.state.registeredTextureControls[i].distance = 10000
		end
	end
end

function BeltalowdaM3DO.SortTextureDistance(a, b)
	if a.distance < b.distance then
		return true
	else
		return false
	end
end

--callbacks
function BeltalowdaM3DO.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaM3DO.m3doVars = currentProfile.util.moving3DObjects
	end
end

function BeltalowdaM3DO.OnUpdate()
	local x, _, y = measurementControl:Get3DRenderSpaceOrigin()
	if x ~= 0 and y ~= 0 then
		x, y = lib3D:GlobalToWorld(lib3D:GetCurrentWorldOriginAsGlobal())
		--d(x) d(y)
		for i = 1, #BeltalowdaM3DO.state.registeredControls do
			--d(BeltalowdaM3DO.state.registeredControls[i]:Get3DRenderSpaceOrigin())
			BeltalowdaM3DO.state.registeredControls[i]:Set3DRenderSpaceOrigin(x, 0, y)
		end
		measurementControl:Set3DRenderSpaceOrigin(x, 0, y)
		--d(BeltalowdaM3DO.state.registeredControls[1]:Get3DRenderSpaceOrigin())
	end
	local updateInterval = BeltalowdaM3DO.GetUpdateIntervalFromDistance()
	if updateInterval ~= BeltalowdaM3DO.state.currentUpdateInterval then
		BeltalowdaM3DO.state.currentUpdateInterval = updateInterval
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.callbackName)
		EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.config.updateIntervals[updateInterval], BeltalowdaM3DO.OnUpdate)
	end
end


function BeltalowdaM3DO.DrawLayerUpdateLoop()
	BeltalowdaM3DO.CalculateDistances()
	table.sort(BeltalowdaM3DO.state.registeredTextureControls, BeltalowdaM3DO.SortTextureDistance)
	local controls = #BeltalowdaM3DO.state.registeredTextureControls
	for i = 1, #BeltalowdaM3DO.state.registeredTextureControls do
		BeltalowdaM3DO.state.registeredTextureControls[i]:SetDrawLevel(BeltalowdaM3DO.config.lowestDrawLayer + controls - i)
	end
end

function BeltalowdaM3DO.OnPlayerActivated()
	if #BeltalowdaM3DO.state.registeredControls >= 1 or #BeltalowdaM3DO.state.registeredTextureControls >= 1 then
		EVENT_MANAGER:RegisterForUpdate(BeltalowdaM3DO.callbackName, BeltalowdaM3DO.config.updateIntervals[BeltalowdaM3DO.constants.updateIntervals.AWAY], BeltalowdaM3DO.OnUpdate)
		BeltalowdaM3DO.state.currentUpdateInterval = BeltalowdaM3DO.constants.updateIntervals.AWAY
		BeltalowdaM3DO.state.updateRegistered = true
		--BeltalowdaM3DO.UpdateAll()
	end
end

function BeltalowdaM3DO.OnPlayerDeactivated()
	if BeltalowdaM3DO.state.updateRegistered == true then
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaM3DO.callbackName)
		BeltalowdaM3DO.state.updateRegistered = false
	end
end