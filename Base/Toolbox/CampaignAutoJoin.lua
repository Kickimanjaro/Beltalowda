-- Beltalowda Campaign Joiner
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
Beltalowda.toolbox.caj = Beltalowda.toolbox.caj or {}
local BeltalowdaCaj = Beltalowda.toolbox.caj
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaCaj.callbackName = Beltalowda.addonName .. "ToolboxCampaignJoiner"

BeltalowdaCaj.constants = {}

BeltalowdaCaj.state = {}
BeltalowdaCaj.state.initialized = false
BeltalowdaCaj.state.registredConsumers = false

BeltalowdaCaj.config = {}
BeltalowdaCaj.config.joinDelay = 5000

function BeltalowdaCaj.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaCaj.callbackName, BeltalowdaCaj.OnProfileChanged)

	
	BeltalowdaCaj.state.initialized = true
	BeltalowdaCaj.SetEnabled(BeltalowdaCaj.cajVars.enabled)
end

function BeltalowdaCaj.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	return defaults
end

function BeltalowdaCaj.SetEnabled(value)
	if BeltalowdaCaj.state.initialized == true and value ~= nil then
		BeltalowdaCaj.cajVars.enabled = value
		if value == true then
			if BeltalowdaCaj.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaCaj.callbackName, EVENT_CAMPAIGN_QUEUE_STATE_CHANGED, BeltalowdaCaj.OnCampaignQueueStateChanged)
			end
			BeltalowdaCaj.state.registredConsumers = true
		else
			if BeltalowdaCaj.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaCaj.callbackName, EVENT_CAMPAIGN_QUEUE_STATE_CHANGED)
			end
			BeltalowdaCaj.state.registredConsumers = false
		end
	end
end

--callbacks
function BeltalowdaCaj.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaCaj.cajVars = currentProfile.toolbox.caj
		if BeltalowdaCaj.state.initialized == true then
	
		end
	end
end

function BeltalowdaCaj.OnCampaignQueueStateChanged(eventId, campaignId, isGroup, state)
	if state == CAMPAIGN_QUEUE_REQUEST_STATE_CONFIRMING then
		zo_callLater(function() ConfirmCampaignEntry(campaignId, isGroup, true) end, BeltalowdaCaj.config.joinDelay)
		
	end 
end

--menu interaction
function BeltalowdaCaj.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CAJ_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CAJ_ENABLED,
					getFunc = BeltalowdaCaj.GetCajEnabled,
					setFunc = BeltalowdaCaj.SetCajEnabled
				}
			}
		},
	}
	return menu
end

function BeltalowdaCaj.GetCajEnabled()
	return BeltalowdaCaj.cajVars.enabled
end

function BeltalowdaCaj.SetCajEnabled(value)
	BeltalowdaCaj.SetEnabled(value)
end