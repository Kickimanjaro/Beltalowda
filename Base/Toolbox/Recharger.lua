-- Beltalowda Recharger
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox.recharger = Beltalowda.toolbox.recharger or {}
local BeltalowdaRecharger = Beltalowda.toolbox.recharger
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.inventory = BeltalowdaUtil.inventory or {}
local BeltalowdaInventory = BeltalowdaUtil.inventory
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaRecharger.constants = BeltalowdaRecharger.constants or {}
BeltalowdaRecharger.constants.PREFIX = "Recharger"

BeltalowdaRecharger.callbackName = Beltalowda.addonName .. "Recharger"

BeltalowdaRecharger.config = {}
BeltalowdaRecharger.config.slots = {}
BeltalowdaRecharger.config.slots[1] = EQUIP_SLOT_MAIN_HAND
BeltalowdaRecharger.config.slots[2] = EQUIP_SLOT_OFF_HAND
BeltalowdaRecharger.config.slots[3] = EQUIP_SLOT_BACKUP_MAIN
BeltalowdaRecharger.config.slots[4] = EQUIP_SLOT_BACKUP_OFF

BeltalowdaRecharger.state = {}
BeltalowdaRecharger.state.initialized = false
BeltalowdaRecharger.state.alreadyEnabled = false
BeltalowdaRecharger.state.noSoulGemsMessageShown = false

function BeltalowdaRecharger.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaRecharger.callbackName, BeltalowdaRecharger.OnProfileChanged)
	
	BeltalowdaRecharger.state.initialized = true
	BeltalowdaRecharger.SetEnabled(BeltalowdaRecharger.rcVars.enabled)
	if BeltalowdaRecharger.rcVars.alerts.login == true then
		EVENT_MANAGER:RegisterForEvent(BeltalowdaRecharger.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaRecharger.OnPlayerActivated)
	end
end

function BeltalowdaRecharger.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.sendChatMessages = true
	defaults.percent = 5
	defaults.alerts = {}
	defaults.alerts.login = true
	defaults.alerts.empty = true
	defaults.alerts.threshold = true
	defaults.threshold = 100
	defaults.checkInterval = 10
	return defaults
end

function BeltalowdaRecharger.SetEnabled(value)
	if BeltalowdaRecharger.state.initialized == true and value ~= nil then
		BeltalowdaRecharger.rcVars.enabled = value
		if value == true then
			if BeltalowdaRecharger.state.alreadyEnabled == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRecharger.callbackName)
			end
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaRecharger.callbackName, BeltalowdaRecharger.rcVars.checkInterval * 1000, BeltalowdaRecharger.OnUpdate)
			BeltalowdaRecharger.state.alreadyEnabled = true
		else
			if BeltalowdaRecharger.state.alreadyEnabled == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRecharger.callbackName)
			end
			BeltalowdaRecharger.state.alreadyEnabled = false
		end
	end
end

--internal functions
function BeltalowdaRecharger.GetNextSouldGemIndex(soulGems)
	local retVal = nil
	if soulGems ~= nil and #soulGems > 0 then
		retVal = soulGems[1].slot
		local currentStack = soulGems[1].stack
		for i = 1, #soulGems - 1 do
			if soulGems[i].stack < soulGems[i + 1].stack and soulGems[i].stack < currentStack then
				retVal = soulGems.slot
				currentStack = soulGems[i].stack
			end
		end
	end
	return retVal
end

function BeltalowdaRecharger.RemoveSoulGem(soulGems, bagIndex)
	if soulGems ~= nil and bagIndex ~= nil then
		for i = 1, #soulGems do
			if soulGems[i].slot == bagIndex then
				soulGems[i].stack = soulGems[i].stack - 1
				if soulGems[i].stack <= 0 then
					table.remove(soulGems,i)
				end
				break
			end
		end
	end
end

function BeltalowdaRecharger.GetSoulGemsStackCount(soulGems)
	local retVal = 0
	if soulGems ~= nil then
		for i = 1, #soulGems do
			retVal = retVal + soulGems[i].stack
		end
	end
	return retVal
end

--callbacks
function BeltalowdaRecharger.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaRecharger.rcVars = currentProfile.toolbox.recharger
		BeltalowdaRecharger.SetEnabled(BeltalowdaRecharger.rcVars.enabled)
	end
end

function BeltalowdaRecharger.OnPlayerActivated(event)
	if event == EVENT_PLAYER_ACTIVATED then
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaRecharger.callbackName, EVENT_PLAYER_ACTIVATED)
		local soulGems = BeltalowdaInventory.GetSoulGemsInventoryInformation()
		local soulGemsLeft = BeltalowdaRecharger.GetSoulGemsStackCount(soulGems)
		if soulGemsLeft < BeltalowdaRecharger.rcVars.threshold then
			BeltalowdaChat.SendChatMessage(string.format(BeltalowdaRecharger.constants.MESSAGE_WARNING_LOW_SOULGEMS, BeltalowdaRecharger.rcVars.threshold), BeltalowdaRecharger.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaRecharger.rcVars.sendChatMessages)
		end
	end
end

function BeltalowdaRecharger.OnUpdate()
	--d("interval: " .. BeltalowdaRecharger.rcVars.checkInterval)
	if IsUnitDead("player") == false then
		local soulGems = BeltalowdaInventory.GetSoulGemsInventoryInformation()
		local showNoSoulGemsMessage = false
		local weaponHasBeenCharged = false
		for i = 1, #BeltalowdaRecharger.config.slots do
			local charges, maxCharges = GetChargeInfoForItem(BAG_WORN,BeltalowdaRecharger.config.slots[i])
			local percent = charges / maxCharges * 100
			if percent <= BeltalowdaRecharger.rcVars.percent then
				local bagIndex = BeltalowdaRecharger.GetNextSouldGemIndex(soulGems)
				if bagIndex ~= nil and bagIndex >= 0 then
					ChargeItemWithSoulGem(BAG_WORN,BeltalowdaRecharger.config.slots[i],BAG_BACKPACK, bagIndex)
					BeltalowdaRecharger.RemoveSoulGem(soulGems, bagIndex)
					BeltalowdaRecharger.state.noSoulGemsMessageShown = false
					weaponHasBeenCharged = true
					BeltalowdaChat.SendChatMessage(string.format(BeltalowdaRecharger.constants.MESSAGE_SUCCESS, GetItemLink(BAG_WORN,BeltalowdaRecharger.config.slots[i]), percent), BeltalowdaRecharger.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaRecharger.rcVars.sendChatMessages)
				else
					showNoSoulGemsMessage = true
					return
				end
			end
		end
		if weaponHasBeenCharged == true and BeltalowdaRecharger.rcVars.alerts.threshold == true then
			local soulGemsLeft = BeltalowdaRecharger.GetSoulGemsStackCount(soulGems)
			if soulGemsLeft < BeltalowdaRecharger.rcVars.threshold then
				BeltalowdaChat.SendChatMessage(string.format(BeltalowdaRecharger.constants.MESSAGE_WARNING_LOW_SOULGEMS, BeltalowdaRecharger.rcVars.threshold), BeltalowdaRecharger.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaRecharger.rcVars.sendChatMessages)
			end
		end
		if BeltalowdaRecharger.state.noSoulGemsMessageShown == false and showNoSoulGemsMessage == true and BeltalowdaRecharger.rcVars.alerts.empty == true then
			BeltalowdaRecharger.state.noSoulGemsMessageShown = true
			BeltalowdaChat.SendChatMessage(BeltalowdaRecharger.constants.MESSAGE_WARNING_NO_SOULGEMS, BeltalowdaRecharger.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaRecharger.rcVars.sendChatMessages)
		end
	end
end

--menu interactions
function BeltalowdaRecharger.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RECHARGER_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RECHARGER_ENABLED,
					getFunc = BeltalowdaRecharger.GetRechargerEnabled,
					setFunc = BeltalowdaRecharger.SetRechargerEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RECHARGER_SEND_CHAT_MESSAGES,
					getFunc = BeltalowdaRecharger.GetRechargerSendChatMessages,
					setFunc = BeltalowdaRecharger.SetRechargerSendChatMessages
				},
				[3] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RECHARGER_PERCENT,
					min = 0,
					max = 99,
					step = 1,
					getFunc = BeltalowdaRecharger.GetRechargerPercent,
					setFunc = BeltalowdaRecharger.SetRechargerPercent,
					width = "full",
					default = 5
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_WARNING,
					getFunc = BeltalowdaRecharger.GetRechargerEmptyWarningEnabled,
					setFunc = BeltalowdaRecharger.SetRechargerEmptyWarningEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_WARNING,
					getFunc = BeltalowdaRecharger.GetRechargerThresholdWarningEnabled,
					setFunc = BeltalowdaRecharger.SetRechargerThresholdWarningEnabled
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_SLIDER,
					min = 0,
					max = 1000,
					step = 1,
					getFunc = BeltalowdaRecharger.GetRechargerThreshold,
					setFunc = BeltalowdaRecharger.SetRechargerThreshold,
					width = "full",
					default = 50
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_LOGIN_WARNING,
					getFunc = BeltalowdaRecharger.GetRechargerLoginWarningEnabled,
					setFunc = BeltalowdaRecharger.SetRechargerLoginWarningEnabled
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.RECHARGER_INTERVAL,
					min = 1,
					max = 300,
					step = 1,
					getFunc = BeltalowdaRecharger.GetRechargerCheckInterval,
					setFunc = BeltalowdaRecharger.SetRechargerCheckInterval,
					width = "full",
					default = 10
				},
			}
		},
	}
	return menu
end

function BeltalowdaRecharger.GetRechargerEnabled()
	return BeltalowdaRecharger.rcVars.enabled
end

function BeltalowdaRecharger.SetRechargerEnabled(value)
	BeltalowdaRecharger.SetEnabled(value)
end

function BeltalowdaRecharger.GetRechargerSendChatMessages()
	return BeltalowdaRecharger.rcVars.sendChatMessages
end

function BeltalowdaRecharger.SetRechargerSendChatMessages(value)
	BeltalowdaRecharger.rcVars.sendChatMessages = value
end

function BeltalowdaRecharger.GetRechargerPercent()
	return BeltalowdaRecharger.rcVars.percent
end

function BeltalowdaRecharger.SetRechargerPercent(value)
	BeltalowdaRecharger.rcVars.percent = value
end

function BeltalowdaRecharger.GetRechargerEmptyWarningEnabled()
	return BeltalowdaRecharger.rcVars.alerts.empty
end

function BeltalowdaRecharger.SetRechargerEmptyWarningEnabled(value)
	BeltalowdaRecharger.rcVars.alerts.empty = value
end

function BeltalowdaRecharger.GetRechargerThresholdWarningEnabled()
	return BeltalowdaRecharger.rcVars.alerts.threshold
end

function BeltalowdaRecharger.SetRechargerThresholdWarningEnabled(value)
	BeltalowdaRecharger.rcVars.alerts.threshold = value
end

function BeltalowdaRecharger.GetRechargerThreshold()
	return BeltalowdaRecharger.rcVars.threshold
end

function BeltalowdaRecharger.SetRechargerThreshold(value)
	BeltalowdaRecharger.rcVars.threshold = value
end

function BeltalowdaRecharger.GetRechargerLoginWarningEnabled()
	return BeltalowdaRecharger.rcVars.alerts.login
end

function BeltalowdaRecharger.SetRechargerLoginWarningEnabled(value)
	BeltalowdaRecharger.rcVars.alerts.login = value
end

function BeltalowdaRecharger.GetRechargerCheckInterval()
	return BeltalowdaRecharger.rcVars.checkInterval
end

function BeltalowdaRecharger.SetRechargerCheckInterval(value)
	BeltalowdaRecharger.rcVars.checkInterval = value
	BeltalowdaRecharger.SetEnabled(BeltalowdaRecharger.rcVars.enabled)
end