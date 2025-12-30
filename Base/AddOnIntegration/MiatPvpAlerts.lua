-- RdK Miat AddOn Integration
-- By @s0rdrak (PC / EU)
-- Not running Miats PvP Alerts AddOn Integration anymore as it did not really
-- fix the bug causing frame drops. Therefore, this module isn't active in any way anymore.

Beltalowda.addOnIntegration.mpa = Beltalowda.addOnIntegration.mpa or {}
local BeltalowdaMpa = Beltalowda.addOnIntegration.mpa
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaMpa.callbackName = Beltalowda.addonName .. "AOIMiatsPvpAlerts"

BeltalowdaMpa.state = {}
BeltalowdaMpa.state.initialized = false
BeltalowdaMpa.state.registeredActivation = false

function BeltalowdaMpa.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaMpa.callbackName, BeltalowdaMpa.OnProfileChanged)
	BeltalowdaMpa.state.initialized = true
	BeltalowdaMpa.SetEnabled(BeltalowdaMpa.mpaVars.enabled, BeltalowdaMpa.mpaVars.enabledOnPlayerActivation)
end

function BeltalowdaMpa.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.enabledOnPlayerActivation = false
	return defaults
end


function BeltalowdaMpa.SetEnabled(enabled, enabledOnPlayerActivation)
	if BeltalowdaMpa.state.initialized == true and enabled ~= nil and enabledOnPlayerActivation ~= nil then
		if enabled == true and BeltalowdaMpa.mpaVars.enabled == false then
			BeltalowdaMpa.ClearMiatsPvpAlertsVars()
		end
		BeltalowdaMpa.mpaVars.enabled = enabled
		BeltalowdaMpa.mpaVars.enabledOnPlayerActivation = enabledOnPlayerActivation
		if enabled == true and enabledOnPlayerActivation == true then
			if BeltalowdaMpa.state.registeredActivation == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaMpa.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaMpa.OnPlayerActivation)
				BeltalowdaMpa.state.registeredActivation = true
			end
		elseif enabled == true and enabledOnPlayerActivation == false then
			if BeltalowdaMpa.state.registeredActivation == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaMpa.callbackName, EVENT_PLAYER_ACTIVATED)
				BeltalowdaMpa.state.registeredActivation = false
			end
		elseif enabled == false then
			if BeltalowdaMpa.state.registeredActivation == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaMpa.callbackName, EVENT_PLAYER_ACTIVATED)
				BeltalowdaMpa.state.registeredActivation = false
			end
		end
	end
end

function BeltalowdaMpa.ClearMiatsPvpAlertsVars()
	--d("Clear Miats Pvp Alerts Vars")
	if PVP_Alerts_Main_Table ~= nil and PVP_Alerts_Main_Table.SV ~= nil then
		if PVP_Alerts_Main_Table.playerNames ~= nil then
			PVP_Alerts_Main_Table.playerNames = {}
		end
		if PVP_Alerts_Main_Table.playerSpec ~= nil then
			PVP_Alerts_Main_Table.playerSpec = {}
		end
		if PVP_Alerts_Main_Table.namesToDisplay ~= nil then
			PVP_Alerts_Main_Table.namesToDisplay = {}
		end
		if PVP_Alerts_Main_Table.SV.CP ~= nil then
			PVP_Alerts_Main_Table.SV.CP = {}
		end
		if PVP_Alerts_Main_Table.SV.playersDB ~= nil then
			PVP_Alerts_Main_Table.SV.playersDB = {}
		end
		--d("vars cleared")

	else
		--d("no vars identified")
	end
end

--callbacks
function BeltalowdaMpa.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then

		BeltalowdaMpa.mpaVars = currentProfile.addOnIntegration.mpa
		BeltalowdaMpa.SetEnabled(BeltalowdaMpa.mpaVars.enabled, BeltalowdaMpa.mpaVars.enabledOnPlayerActivation)
	end
end

function BeltalowdaMpa.OnPlayerActivation(eventCode)
	if eventCode == EVENT_PLAYER_ACTIVATED then
		BeltalowdaMpa.ClearMiatsPvpAlertsVars()
	end
end

--menu interaction
function BeltalowdaMpa.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.MPAI_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.MPAI_ENABLED,
					getFunc = BeltalowdaMpa.GetMpaEnabled,
					setFunc = BeltalowdaMpa.SetMpaEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.MPAI_ONPLAYERACTIVATION,
					getFunc = BeltalowdaMpa.GetMpaOnPlayerActivationEnabled,
					setFunc = BeltalowdaMpa.SetMpaOnPlayerActivationEnabled
				},
				[3] = {
					type = "button",
					name = BeltalowdaMenu.constants.MPAI_CLEAR_VARS,
					func = BeltalowdaMpa.ClearMiatsPvpAlertsVars,
					width = "full"
				},
			}
		}
	}
	return menu
end

function BeltalowdaMpa.GetMpaEnabled()
	return BeltalowdaMpa.mpaVars.enabled
end

function BeltalowdaMpa.SetMpaEnabled(value)
	BeltalowdaMpa.SetEnabled(value, BeltalowdaMpa.mpaVars.enabledOnPlayerActivation)
end

function BeltalowdaMpa.GetMpaOnPlayerActivationEnabled()
	return BeltalowdaMpa.mpaVars.enabledOnPlayerActivation
end

function BeltalowdaMpa.SetMpaOnPlayerActivationEnabled(value)
	BeltalowdaMpa.SetEnabled(BeltalowdaMpa.mpaVars.enabled, value)
end