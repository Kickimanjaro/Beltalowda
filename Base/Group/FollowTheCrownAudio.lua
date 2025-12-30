-- Beltalowda Follow The Crown Audio
-- By @s0rdrak (PC / EU)

Beltalowda.group.ftca = Beltalowda.group.ftca or {}
local BeltalowdaFtca = Beltalowda.group.ftca
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group
local BeltalowdaGroup = BeltalowdaUtil.group
BeltalowdaUtil.sound = BeltalowdaUtil.sound or {}
local BeltalowdaSound = BeltalowdaUtil.sound

BeltalowdaFtca.constants = BeltalowdaFtca.constants or {}

BeltalowdaFtca.callbackName = Beltalowda.addonName .. "FollowTheCrownAduio"

BeltalowdaFtca.config = {}
BeltalowdaFtca.config.updateInterval = 100

BeltalowdaFtca.state = {}
BeltalowdaFtca.state.initialized = false
BeltalowdaFtca.state.registeredConsumer = false
BeltalowdaFtca.state.lastPlayedSound = nil
BeltalowdaFtca.state.isInRange = true

function BeltalowdaFtca.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaFtca.callbackName, BeltalowdaFtca.OnProfileChanged)
	
	BeltalowdaFtca.state.sounds = BeltalowdaSound.GetRestrictedSounds()
	
	BeltalowdaFtca.state.initialized = true
	BeltalowdaFtca.SetEnabled(BeltalowdaFtca.ftcaVars.enabled)
end

function BeltalowdaFtca.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.maxDistance = 10
	defaults.ignoreDistance = 100
	defaults.pvpOnly = true
	defaults.interval = 3
	defaults.threshold = 3
	defaults.selectedSound = "BG_One_Minute_Warning"
	defaults.unmountedOnly = true
	return defaults
end

function BeltalowdaFtca.SetEnabled(value)
	if BeltalowdaFtca.state.initialized == true and value ~= nil then
		BeltalowdaFtca.ftcaVars.enabled = value
		if value == true then
			if BeltalowdaFtca.state.registeredConsumer == false then
				Beltalowda.util.group.AddFeature(BeltalowdaFtca.callbackName, Beltalowda.util.group.features.FEATURE_GROUP_LEADER_DISTANCE, BeltalowdaFtca.config.updateInterval)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaFtca.callbackName, BeltalowdaFtca.config.updateInterval, BeltalowdaFtca.OnUpdate)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaFtca.callbackName, EVENT_END_SIEGE_CONTROL, BeltalowdaFtca.SiegeEndEvent)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaFtca.callbackName, EVENT_MOUNTED_STATE_CHANGED, BeltalowdaFtca.OnMountStateChanged)
				BeltalowdaFtca.state.registeredConsumer = true
			end
		else
			if BeltalowdaFtca.state.registeredConsumer == true then
				Beltalowda.util.group.RemoveFeature(BeltalowdaFtca.callbackName, Beltalowda.util.group.features.FEATURE_GROUP_LEADER_DISTANCE)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaFtca.callbackName)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtca.callbackName, EVENT_END_SIEGE_CONTROL)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaFtca.callbackName, EVENT_MOUNTED_STATE_CHANGED)
				BeltalowdaFtca.state.registeredConsumer = false
			end
		end
	end
end

--callbacks
function BeltalowdaFtca.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		--BeltalowdaFtca.SetEnabled(false)
		BeltalowdaFtca.ftcaVars = currentProfile.group.ftca
		BeltalowdaFtca.SetEnabled(BeltalowdaFtca.ftcaVars.enabled)
	end
end

function BeltalowdaFtca.OnUpdate()
	if IsUnitGrouped("player") == true and BeltalowdaGroup.IsPlayerGroupLeader() == false and ( BeltalowdaFtca.ftcaVars.pvpOnly == false or (BeltalowdaFtca.ftcaVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea())) then
		local distance = Beltalowda.util.group.GetLeaderDistance()
		if distance ~= nil then
			--d(IsPlayerControllingSiegeWeapon())
			if distance > BeltalowdaFtca.ftcaVars.maxDistance and distance < BeltalowdaFtca.ftcaVars.ignoreDistance then
				if BeltalowdaFtca.state.isInRange == true then
					BeltalowdaFtca.state.lastPlayedSound = GetTimeStamp() + BeltalowdaFtca.ftcaVars.threshold - BeltalowdaFtca.ftcaVars.interval
				end
				if BeltalowdaFtca.state.lastPlayedSound == nil or (BeltalowdaFtca.state.lastPlayedSound ~= nil and BeltalowdaFtca.state.lastPlayedSound + BeltalowdaFtca.ftcaVars.interval < GetTimeStamp()) then
					--d(IsPlayerControllingSiegeWeapon())
					if (BeltalowdaFtca.ftcaVars.unmountedOnly == false or (BeltalowdaFtca.ftcaVars.unmountedOnly == true and IsMounted() == false)) and IsPlayerControllingSiegeWeapon() == false and IsPlayerEscortingRam() == false and IsUnitDead("player") == false then
						BeltalowdaSound.PlaySoundByName(BeltalowdaFtca.ftcaVars.selectedSound)
						BeltalowdaFtca.state.lastPlayedSound = GetTimeStamp() + BeltalowdaFtca.ftcaVars.threshold - BeltalowdaFtca.ftcaVars.interval
					else
						BeltalowdaFtca.state.lastPlayedSound = GetTimeStamp() + BeltalowdaFtca.ftcaVars.threshold - BeltalowdaFtca.ftcaVars.interval
					end
				end
				BeltalowdaFtca.state.isInRange = false
			else
				BeltalowdaFtca.state.isInRange = true
			end
		end
	end
end

function BeltalowdaFtca.SiegeEndEvent(eventCode)
	if eventCode == EVENT_END_SIEGE_CONTROL then
		BeltalowdaFtca.state.lastPlayedSound = GetTimeStamp() + BeltalowdaFtca.ftcaVars.threshold - BeltalowdaFtca.ftcaVars.interval
	end
end

function BeltalowdaFtca.OnMountStateChanged(eventCode, mounted)
	if eventCode == EVENT_MOUNTED_STATE_CHANGED and mounted == false then
		BeltalowdaFtca.state.lastPlayedSound = GetTimeStamp() + BeltalowdaFtca.ftcaVars.threshold - BeltalowdaFtca.ftcaVars.interval
	end
end

--menu interaction
function BeltalowdaFtca.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.FTCA_HEADER,
			--width = "full",
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCA_ENABLED,
					getFunc = BeltalowdaFtca.GetFtcaEnabled,
					setFunc = BeltalowdaFtca.SetFtcaEnabled,
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCA_PVP_ONLY,
					getFunc = BeltalowdaFtca.GetFtcaPvpOnly,
					setFunc = BeltalowdaFtca.SetFtcaPvpOnly,
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.FTCA_UNMOUNTED_ONLY,
					getFunc = BeltalowdaFtca.GetFtcaUnmountedOnly,
					setFunc = BeltalowdaFtca.SetFtcaUnmountedOnly,
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.FTCA_SOUND,
					choices = BeltalowdaFtca.GetFtcaAvailableSounds(),
					getFunc = BeltalowdaFtca.GetFtcaSelectedSound,
					setFunc = BeltalowdaFtca.SetFtcaSelectedSound,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCA_DISTANCE,
					min = 0,
					max = 25,
					step = 1,
					getFunc = BeltalowdaFtca.GetFtcaMaxDistance,
					setFunc = BeltalowdaFtca.SetFtcaMaxDistance,
					width = "full",
					default = 8
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCA_IGNORE_DISTANCE,
					min = 100,
					max = 1000,
					step = 1,
					getFunc = BeltalowdaFtca.GetFtcaIgnoreDistance,
					setFunc = BeltalowdaFtca.SetFtcaIgnoreDistance,
					width = "full",
					default = 100
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCA_INTERVAL,
					min = 1,
					max = 10,
					step = 1,
					getFunc = BeltalowdaFtca.GetFtcaInterval,
					setFunc = BeltalowdaFtca.SetFtcaInterval,
					width = "full",
					default = 1
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.FTCA_THRESHOLD,
					min = 1,
					max = 25,
					step = 1,
					getFunc = BeltalowdaFtca.GetFtcaThreshold,
					setFunc = BeltalowdaFtca.SetFtcaThreshold,
					width = "full",
					default = 3
				}
			}
		}
	}
	return menu
end

function BeltalowdaFtca.GetFtcaEnabled()
	return BeltalowdaFtca.ftcaVars.enabled
end

function BeltalowdaFtca.SetFtcaEnabled(value)
	BeltalowdaFtca.SetEnabled(value)
end

function BeltalowdaFtca.GetFtcaPvpOnly()
	return BeltalowdaFtca.ftcaVars.pvpOnly
end

function BeltalowdaFtca.SetFtcaPvpOnly(value)
	BeltalowdaFtca.ftcaVars.pvpOnly = value
end

function BeltalowdaFtca.GetFtcaUnmountedOnly()
	return BeltalowdaFtca.ftcaVars.unmountedOnly
end

function BeltalowdaFtca.SetFtcaUnmountedOnly(value)
	BeltalowdaFtca.ftcaVars.unmountedOnly = value
end

function BeltalowdaFtca.GetFtcaAvailableSounds()
	local sounds = {}
	for i = 1, #BeltalowdaFtca.state.sounds do
		sounds[i] = BeltalowdaFtca.state.sounds[i].name
	end
	return sounds
end

function BeltalowdaFtca.GetFtcaSelectedSound()
	return BeltalowdaFtca.ftcaVars.selectedSound
end

function BeltalowdaFtca.SetFtcaSelectedSound(value)
	if value ~= nil then
		BeltalowdaFtca.ftcaVars.selectedSound = value
		BeltalowdaSound.PlaySoundByName(value)
	end
end

function BeltalowdaFtca.GetFtcaMaxDistance()
	return BeltalowdaFtca.ftcaVars.maxDistance
end

function BeltalowdaFtca.SetFtcaMaxDistance(value)
	BeltalowdaFtca.ftcaVars.maxDistance = value
end

function BeltalowdaFtca.GetFtcaIgnoreDistance()
	return BeltalowdaFtca.ftcaVars.ignoreDistance
end

function BeltalowdaFtca.SetFtcaIgnoreDistance(value)
	BeltalowdaFtca.ftcaVars.ignoreDistance = value
end

function BeltalowdaFtca.GetFtcaInterval()
	return BeltalowdaFtca.ftcaVars.interval
end

function BeltalowdaFtca.SetFtcaInterval(value)
	BeltalowdaFtca.ftcaVars.interval = value
end

function BeltalowdaFtca.GetFtcaThreshold()
	return BeltalowdaFtca.ftcaVars.threshold
end

function BeltalowdaFtca.SetFtcaThreshold(value)
	BeltalowdaFtca.ftcaVars.threshold = value
end
