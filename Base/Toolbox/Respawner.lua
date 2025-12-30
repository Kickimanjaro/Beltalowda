-- Beltalowda Respawner
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.respawner = BeltalowdaTB.respawner or {}
local BeltalowdaRespawner = BeltalowdaTB.respawner
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.cyrodiil = BeltalowdaUtil.cyrodiil or {}
local BeltalowdaCyro = BeltalowdaUtil.cyrodiil

BeltalowdaRespawner.constants = BeltalowdaRespawner.constants or {}
BeltalowdaRespawner.constants.TLW = "BeltalowdaToolboxRespawnerTLW"
BeltalowdaRespawner.constants.KEEP = "BeltalowdaToolboxRespawnerKEEP"
BeltalowdaRespawner.constants.CAMP = "BeltalowdaToolboxRespawnerCAMP"

BeltalowdaRespawner.callbackName = Beltalowda.addonName .. "Respawner"
BeltalowdaRespawner.delayCallbackName = Beltalowda.addonName .. "RespawnerDelayInit"

BeltalowdaRespawner.config = {}
BeltalowdaRespawner.config.initDelay = 100
BeltalowdaRespawner.config.updateInterval = 100

BeltalowdaRespawner.controls = {}

BeltalowdaRespawner.state = {}
BeltalowdaRespawner.state.initialized = false
BeltalowdaRespawner.state.alreadyEnabled = false
BeltalowdaRespawner.state.updateLoopRunning = false

local wm = GetWindowManager()

function BeltalowdaRespawner.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaRespawner.callbackName, BeltalowdaRespawner.OnProfileChanged)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_DEATH_CAMP", BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_CAMP)
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_DEATH_KEEP", BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_KEEP)
	BeltalowdaRespawner.CreateUI()
	BeltalowdaRespawner.state.initialized = true
	EVENT_MANAGER:RegisterForUpdate(BeltalowdaRespawner.delayCallbackName, BeltalowdaRespawner.config.initDelay, BeltalowdaRespawner.DelayedInit)
end

--[[
/script tempHud = ZO_HUDFadeSceneFragment:New(Beltalowda.toolbox.respawner.controls.tlw)
/script HUD_SCENE:AddFragment(Beltalowda.toolbox.respawner.controls.hudControl)
/script HUD_UI_SCENE:AddFragment(Beltalowda.toolbox.respawner.controls.hudControl)
/script Beltalowda.toolbox.respawner.controls.hudControl:Show()
/script d(getmetatable(ZO_DeathAvA))
/script d(getmetatable(ZO_DeathAvAButtons))
/script d(DEATH.types["AvA"].buttons[1]:SetHidden(true))
/script Beltalowda.toolbox.respawner.controls.rootControl.keep:SetAnchor(TOPLEFT, GuiRoot,TOPLEFT,300,300)
/script Beltalowda.toolbox.respawner.controls.rootControl:SetAnchor(TOPLEFT, ZO_DeathAvAButtons, TOPLEFT, 0, 0)
]]
function BeltalowdaRespawner.CreateUI()
	BeltalowdaRespawner.controls.tlw = wm:CreateTopLevelWindow(BeltalowdaRespawner.constants.TLW)
	BeltalowdaRespawner.controls.tlw:SetHidden(true)
	BeltalowdaRespawner.controls.rootControl = wm:CreateControl(nil, BeltalowdaRespawner.controls.tlw, CT_CONTROL)
	local rootControl = BeltalowdaRespawner.controls.rootControl
	
	rootControl.keep = wm:CreateControlFromVirtual(BeltalowdaRespawner.constants.KEEP, rootControl, "ZO_KeybindButton")
	rootControl.keep:SetAnchor(TOPLEFT, rootControl, TOPLEFT, 0, 0)
	rootControl.keep.nameLabel:SetText(BeltalowdaRespawner.constants.RESPAWN_KEEP)
	rootControl.keep:SetKeybind('RDKGTOOL_DEATH_RESPAWN_KEEP')
	rootControl.keep:SetCallback(function() d("keep") end)
	
	rootControl.camp = wm:CreateControlFromVirtual(BeltalowdaRespawner.constants.CAMP, rootControl, "ZO_KeybindButton")
	rootControl.camp:SetAnchor(TOPLEFT, rootControl, TOPRIGHT, 200, 0)
	rootControl.camp.nameLabel:SetText(BeltalowdaRespawner.constants.RESPAWN_CAMP)
	rootControl.camp:SetKeybind('RDKGTOOL_DEATH_RESPAWN_CAMP')
	rootControl.camp:SetCallback(function() d("camp") end)
    
	
end

function BeltalowdaRespawner.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.restrictedPort = true
	return defaults
end

function BeltalowdaRespawner.SetEnabled(value)
	if BeltalowdaRespawner.state.initialized == true and value ~= nil then
		BeltalowdaRespawner.reVars.enabled = value
		if value == true and IsInCyrodiil() == true then
			if BeltalowdaRespawner.state.alreadyEnabled == false then
				BeltalowdaRespawner.controls.rootControl:SetParent(ZO_DeathAvAButtons)
				BeltalowdaRespawner.controls.rootControl:ClearAnchors()
				BeltalowdaRespawner.controls.rootControl:SetAnchor(TOPLEFT, ZO_DeathAvAButtons, TOPLEFT, -400, 0)
				BeltalowdaRespawner.state.alreadyEnabled = true
				--EVENT_MANAGER:RegisterForUpdate(BeltalowdaRespawner.callbackName, BeltalowdaRespawner.config.updateInterval, BeltalowdaRespawner.UpdateRespawn)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaRespawner.callbackName, EVENT_PLAYER_DEAD, BeltalowdaRespawner.OnPlayerDead)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaRespawner.callbackName, EVENT_PLAYER_ALIVE, BeltalowdaRespawner.OnPlayerAlive)
				if IsUnitDead("player") == true then
					BeltalowdaRespawner.OnPlayerDead()
				end
			end
		else
			if BeltalowdaRespawner.state.alreadyEnabled == true then
				BeltalowdaRespawner.controls.rootControl:SetParent(BeltalowdaRespawner.controls.tlw)
				BeltalowdaRespawner.state.alreadyEnabled = false
				--EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRespawner.callbackName)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaRespawner.callbackName, EVENT_PLAYER_DEAD)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaRespawner.callbackName, EVENT_PLAYER_ALIVE)
				BeltalowdaRespawner.DisableUpdateLoop()
			end
		end
	end
end

function BeltalowdaRespawner.CombineKeepLists(keeps, outposts, villages)
	local keepEntries = {}
	for key, keep in pairs(keeps) do
		keepEntries[key] = keep
	end
	for key, keep in pairs(outposts) do
		keepEntries[key] = keep
	end
	for key, keep in pairs(villages) do
		keepEntries[key] = keep
	end
	return keepEntries
end

function BeltalowdaRespawner.RetrieveAllRespawnKeeps()
	local keeps = {}
	BeltalowdaCyro.AdjustKeepCoordinates()
	BeltalowdaCyro.AdjustOutpostCoordinates()
	BeltalowdaCyro.AdjustVillageCoordinates()
	local potentialRespawnKeeps = BeltalowdaRespawner.CombineKeepLists(BeltalowdaCyro.GetKeeps(), BeltalowdaCyro.GetOutposts(), BeltalowdaCyro.GetVillages())
	if potentialRespawnKeeps ~= nil then
		for key, keep in pairs(potentialRespawnKeeps) do
			if CanRespawnAtKeep(key) then
				table.insert(keeps, keep)
			end
		end
	end
	--CanRespawnAtKeep
	return keeps
end

function BeltalowdaRespawner.RetrieveNearestKeep()
	local nearestKeep = nil
	BeltalowdaCyro.AdjustKeepCoordinates()
	BeltalowdaCyro.AdjustOutpostCoordinates()
	BeltalowdaCyro.AdjustVillageCoordinates()
	local potentialRespawnKeeps = BeltalowdaRespawner.CombineKeepLists(BeltalowdaCyro.GetKeeps(), BeltalowdaCyro.GetOutposts(), BeltalowdaCyro.GetVillages())
	if potentialRespawnKeeps ~= nil then
		local playerX, playerY = GetMapPlayerPosition("player")
		for key, keep in pairs(potentialRespawnKeeps) do
			keep.customData = keep.customData or {}
			keep.customData.distance = math.sqrt((playerX - keep.x) * (playerX - keep.x) + (playerY - keep.y) * (playerY - keep.y))
			if nearestKeep == nil or keep.customData.distance < nearestKeep.customData.distance then
				nearestKeep = keep
			end
		end
	end
	return nearestKeep
end

function BeltalowdaRespawner.RetrieveNearbyCamps()
	local camps = {}
	local numCamps = GetNumForwardCamps(BGQUERY_LOCAL)
	for i = 1, numCamps do
		local camp = {}
		camp.id = i
		camp.pinType, camp.x, camp.y, camp.radius, camp.useable = GetForwardCampPinInfo(BGQUERY_LOCAL, i)
		if camp.useable == true then
			table.insert(camps, camp)
		end
	end	
	return camps
end

function BeltalowdaRespawner.RespawnAtCamp()
	if BeltalowdaRespawner.reVars.enabled == true and IsInCyrodiil() == true then
		--d("respawn at camp")
		local camps = BeltalowdaRespawner.RetrieveNearbyCamps()
		if #camps > 0 then
			if #camps == 1 then
				RespawnAtForwardCamp(camps[1].id)
			else
				--calculate
				local leader = BeltalowdaUtilGroup.GetLeaderUnit()
				if leader ~= nil and leader.coordinates ~= nil and leader.coordinates.localX ~= nil and leader.coordinates.localY ~= nil then
					local localX = leader.coordinates.localX
					local localY = leader.coordinates.localY
					for i = 1, #camps do
						local x = camps[i].x
						local y = camps[i].y
						camps[i].distanceToLeader = math.sqrt((localX - x) * (localX - x) + (localY - y) * (localY - y))
					end
					local camp = camps[1]
					for i = 1, #camps do
						if camps[i].distanceToLeader < camp.distanceToLeader then
							camp = camps[i]
						end
					end
					RespawnAtForwardCamp(camp.id)
				else
					RespawnAtForwardCamp(camps[1].id)
				end
			end
		end
	end
end

function BeltalowdaRespawner.RespawnAtKeep()
	if BeltalowdaRespawner.reVars.enabled == true and IsInCyrodiil() == true then
		--d("respawn at keep")
		if BeltalowdaRespawner.reVars.restrictedPort == false then
			local keeps = BeltalowdaRespawner.RetrieveAllRespawnKeeps()
			if #keeps > 0 then
				local playerX, playerY = GetMapPlayerPosition("player")
				for i = 1, #keeps do
					local keep = keeps[i]
					keep.customData = keep.customData or {}
					keep.customData.distance = math.sqrt((playerX - keep.x) * (playerX - keep.x) + (playerY - keep.y) * (playerY - keep.y))
				end
				local keep = keeps[1]
				for i = 1, #keeps do
					if keeps[i].customData.distance < keep.customData.distance then
						keep =  keeps[i]
					end
				end
				RespawnAtKeep(keep.id)
			end
		else
			local keep = BeltalowdaRespawner.RetrieveNearestKeep()
			if keep ~= nil and CanRespawnAtKeep(keep.id) == true then
				RespawnAtKeep(keep.id)
			end
		end
	end
end

function BeltalowdaRespawner.KeybindingPlaceholder()
end

function BeltalowdaRespawner.EnabledUpdateLoop()
	if BeltalowdaRespawner.state.updateLoopRunning == false then
		BeltalowdaUtilGroup.AddFeature(BeltalowdaRespawner.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES, BeltalowdaRespawner.config.updateInterval)
		EVENT_MANAGER:RegisterForUpdate(BeltalowdaRespawner.callbackName, BeltalowdaRespawner.config.updateInterval, BeltalowdaRespawner.UpdateRespawn)
		BeltalowdaRespawner.state.updateLoopRunning = true
	end
end

function BeltalowdaRespawner.DisableUpdateLoop()
	if BeltalowdaRespawner.state.updateLoopRunning == true then
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRespawner.callbackName)
		BeltalowdaUtilGroup.RemoveFeature(BeltalowdaRespawner.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_COORDINATES)
		BeltalowdaRespawner.state.updateLoopRunning = false
	end
end

--callbacks
function BeltalowdaRespawner.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaRespawner.reVars = currentProfile.toolbox.respawner
		if BeltalowdaRespawner.state.initialized == true then
			BeltalowdaRespawner.SetEnabled(BeltalowdaRespawner.reVars.enabled)
		end
	end
end

function BeltalowdaRespawner.DelayedInit()
	EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRespawner.delayCallbackName)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRespawner.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaRespawner.OnPlayerActivated)
	BeltalowdaRespawner.OnPlayerActivated()
end

function BeltalowdaRespawner.OnPlayerActivated()
	BeltalowdaRespawner.SetEnabled(BeltalowdaRespawner.reVars.enabled)
end

function BeltalowdaRespawner.OnPlayerDead()
	BeltalowdaRespawner.EnabledUpdateLoop()
end

function BeltalowdaRespawner.OnPlayerAlive()
	BeltalowdaRespawner.DisableUpdateLoop()
end

function BeltalowdaRespawner.UpdateRespawn()
	--camps
	--d("update loop")
	local camps = BeltalowdaRespawner.RetrieveNearbyCamps()
	if #camps > 0 then
		BeltalowdaRespawner.controls.rootControl.camp:SetEnabled(true)
	else
		BeltalowdaRespawner.controls.rootControl.camp:SetEnabled(false)
	end
	
	--keeps
	if BeltalowdaRespawner.reVars.restrictedPort == false then
		local keeps = BeltalowdaRespawner.RetrieveAllRespawnKeeps()
		if #keeps > 0 then
			BeltalowdaRespawner.controls.rootControl.keep:SetEnabled(true)
		else
			BeltalowdaRespawner.controls.rootControl.keep:SetEnabled(false)
		end
	else
		local keep = BeltalowdaRespawner.RetrieveNearestKeep()
		if keep ~= nil and CanRespawnAtKeep(keep.id) == true then
			BeltalowdaRespawner.controls.rootControl.keep:SetEnabled(true)
		else
			BeltalowdaRespawner.controls.rootControl.keep:SetEnabled(false)
		end
	end
end

--menu interactions
function BeltalowdaRespawner.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RESPAWNER_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RESPAWNER_ENABLED,
					getFunc = BeltalowdaRespawner.GetRespawnerEnabled,
					setFunc = BeltalowdaRespawner.SetRespawnerEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RESPAWNER_RESTRICTED_PORT,
					getFunc = BeltalowdaRespawner.GetRespawnerRestrictedPort,
					setFunc = BeltalowdaRespawner.SetRespawnerRestrictedPort
				}
			}
		}
	}
	return menu
end

function BeltalowdaRespawner.GetRespawnerEnabled()
	return BeltalowdaRespawner.reVars.enabled
end

function BeltalowdaRespawner.SetRespawnerEnabled(value)
	BeltalowdaRespawner.SetEnabled(value)
end

function BeltalowdaRespawner.GetRespawnerRestrictedPort()
	return BeltalowdaRespawner.reVars.restrictedPort
end

function BeltalowdaRespawner.SetRespawnerRestrictedPort(value)
	BeltalowdaRespawner.reVars.restrictedPort = value
end