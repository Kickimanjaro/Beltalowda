-- Beltalowda Role Assignment
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.ra = BeltalowdaTB.ra or {}
local BeltalowdaRa = BeltalowdaTB.ra
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaRa.constants = BeltalowdaRa.constants or {}
BeltalowdaRa.constants.PREFIX = "RA"

BeltalowdaRa.callbackName = Beltalowda.addonName .. "RoleAssignment"

BeltalowdaRa.config = {}
BeltalowdaRa.config.updateInterval = 30000

BeltalowdaRa.state = {}
BeltalowdaRa.state.registredConsumers = false
BeltalowdaRa.state.initialized = false
BeltalowdaRa.state.lastMessages = nil

function BeltalowdaRa.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaRa.callbackName, BeltalowdaRa.OnProfileChanged)

	BeltalowdaRa.state.roles = {}
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_RAPID] = BeltalowdaUtilGroup.constants.ROLE_RAPID
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PURGE] = BeltalowdaUtilGroup.constants.ROLE_PURGE
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_HEAL] = BeltalowdaUtilGroup.constants.ROLE_HEAL
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_DD] = BeltalowdaUtilGroup.constants.ROLE_DD
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY] = BeltalowdaUtilGroup.constants.ROLE_SYNERGY
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_CC] = BeltalowdaUtilGroup.constants.ROLE_CC
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_SUPPORT] = BeltalowdaUtilGroup.constants.ROLE_SUPPORT
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_PLACEHOLDER] = BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT] = BeltalowdaUtilGroup.constants.ROLE_APPLICANT
	BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT + 1] = "-"
	
	BeltalowdaRa.state.initialized = true
	
	BeltalowdaRa.SetEnabled(BeltalowdaRa.raVars.enabled)
end

function BeltalowdaRa.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.allowOverride = true
	return defaults
end

function BeltalowdaRa.SetEnabled(value)
	if BeltalowdaRa.state.initialized == true and value ~= nil then
		BeltalowdaRa.raVars.enabled = value
		if value == true then
			BeltalowdaRa.AdjustRole()
			if BeltalowdaRa.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaRa.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaRa.OnPlayerActivated)
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaRa.callbackName, BeltalowdaRa.config.updateInterval, BeltalowdaRa.SendRoleLoop)
				BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaRa.callbackName, BeltalowdaRa.HandleRawNetworkMessage)
			end
			BeltalowdaRa.state.registredConsumers = true
		else
			if BeltalowdaRa.state.registredConsumers == true then
				BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaRa.callbackName)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaRa.callbackName, EVENT_PLAYER_ACTIVATED)
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaRa.callbackName)
			end
			BeltalowdaRa.state.registredConsumers = false
		end
		BeltalowdaRa.OnPlayerActivated()
	end
end

function BeltalowdaRa.SetPlayerRole(charName, displayName, role)
	local leader = BeltalowdaUtilGroup.GetLeaderUnit()
	if leader ~= nil and leader.isPlayer == true then
		local players = BeltalowdaUtilGroup.GetGroupInformation()
		if players ~= nil then
			local index = 0
			for i = 1, #players do
				if players[i].charName == charName and players[i].displayName == displayName then
					index = i
					break
				end
			end
			if index > 0 then
				local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ROLE
				message.b1 = BeltalowdaNetworking.messageIdentifiers.roleMessage.MESSAGE_ADMIN_SET_ROLE
				message.b2 = index
				message.b3 = role
				if message.b3 == nil then
					message.b3 = 0
				end
				message.sent = false
				BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
				BeltalowdaChat.SendChatMessage("Set Role Message Sent: " .. message.b1 .. " - " .. message.b2 .. " - " .. message.b3, BeltalowdaRa.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
			end
		end
	end
end

function BeltalowdaRa.SendRole()
	if BeltalowdaRa.raVars.enabled == true then
		local playerUnitTag = BeltalowdaUtilGroup.GetUnitTagForPlayer()
		if playerUnitTag ~= nil then
			local player = BeltalowdaUtilGroup.GetPlayerByUnitTag(playerUnitTag)
			if player ~= nil then
				if BeltalowdaRa.state.lastMessages == nil or BeltalowdaRa.state.lastMessages.sent == true then
					local role = player.role
					if role == nil then
						role = 0
					end
					local roleName = ""
					if role == 0 then
						roleName = BeltalowdaRa.state.roles[BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT + 1]
					else
						roleName = BeltalowdaRa.state.roles[role]
					end
					local message = {}
					message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_ROLE
					message.b1 = role
					message.b2 = 0
					message.b3 = 0
					message.sent = false
					BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
					BeltalowdaRa.state.lastMessages = message
					BeltalowdaChat.SendChatMessage("Role Message Sent: " .. message.b1 .. " - " .. roleName, BeltalowdaRa.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
				end
			end
		end
	end
end

function BeltalowdaRa.AdjustRole()
	if BeltalowdaRa.raVars.enabled == true then
		local role = BeltalowdaRa.charVars.selectedRole
		if role == BeltalowdaUtilGroup.constants.roles.ROLE_APPLICANT + 1 then
			role = nil
		end
		BeltalowdaUtilGroup.SetRole(GetUnitName("player") , GetUnitDisplayName("player"), role)
		BeltalowdaRa.SendRole()
	end
end

--callbacks
function BeltalowdaRa.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaRa.raVars = currentProfile.toolbox.ra
		local charVars = Beltalowda.profile.GetCharacterVars()
		charVars.ra = charVars.ra or {}
		BeltalowdaRa.charVars = charVars.ra
		if BeltalowdaRa.state.initialized == true then
			BeltalowdaRa.SetEnabled(BeltalowdaRa.raVars.enabled)
		end
	end
end

function BeltalowdaRa.OnPlayerActivated(eventCode, initial)
	if BeltalowdaRa.raVars.enabled == true then
		BeltalowdaRa.SendRole()
	end
end

function BeltalowdaRa.SendRoleLoop()
	if BeltalowdaRa.raVars.enabled == true then
		if BeltalowdaUtilGroup.IsGroupInCombat() == false then
			BeltalowdaRa.SendRole()
		end
	end
end

function BeltalowdaRa.HandleRawNetworkMessage(message)
	if message ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ROLE then
		BeltalowdaChat.SendChatMessage("Role Message Received: " .. message.b1 .. " - " .. message.b2 .. " -- " .. message.b3, BeltalowdaRa.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		if BeltalowdaRa.raVars.allowOverride == true and message.b1 ~= BeltalowdaNetworking.messageIdentifiers.roleMessage.MESSAGE_ADMIN_SET_ROLE then
			local player = BeltalowdaUtilGroup.GetPlayerByUnitTag(message.pingTag)
			if player ~= nil and player.isPlayer == false then
				player.role = message.b1
				if player.role == 0 then
					player.role = nil
				end
			end
		end
		local sender = BeltalowdaUtilGroup.GetPlayerByUnitTag(message.pingTag)
		if sender ~= nil and sender.isLeader == true and message.b1 == BeltalowdaNetworking.messageIdentifiers.roleMessage.MESSAGE_ADMIN_SET_ROLE then
			local players = BeltalowdaUtilGroup.GetGroupInformation()
			if players ~= nil and message.b2 ~= nil and message.b2 >= 1 and message.b2 <= #players then
				local player = players[message.b2]
				local role = message.b3
				player.role = message.b3
				if player.role == 0 then
					player.role = nil
				end
				if player.isPlayer == true then
					if BeltalowdaRa.state.lastMessages ~= nil and BeltalowdaRa.state.lastMessages.sent == false then
						local queuedMessage = BeltalowdaRa.state.lastMessages
						queuedMessage.b1 = message.b3
					end
				end
			end
		end
	end
end

--menu interaction
function BeltalowdaRa.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.RA_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RA_ENABLED,
					getFunc = BeltalowdaRa.GetRaEnabled,
					setFunc = BeltalowdaRa.SetRaEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.RA_OVERRIDE_ALLOWED,
					getFunc = BeltalowdaRa.GetRaAllowOverride,
					setFunc = BeltalowdaRa.SetRaAllowOverride
				},
				[3] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.RA_ROLE,
					choices = BeltalowdaRa.GetRaRoles(),
					getFunc = BeltalowdaRa.GetRaRole,
					setFunc = BeltalowdaRa.SetRaRole
				},
			}
		},
	}
	return menu
end

function BeltalowdaRa.GetRaEnabled()
	return BeltalowdaRa.raVars.enabled
end

function BeltalowdaRa.SetRaEnabled(value)
	BeltalowdaRa.SetEnabled(value)
end

function BeltalowdaRa.GetRaAllowOverride()
	return BeltalowdaRa.raVars.allowOverride
end

function BeltalowdaRa.SetRaAllowOverride(value)
	BeltalowdaRa.raVars.allowOverride = value
end

function BeltalowdaRa.GetRaRoles()
	return BeltalowdaRa.state.roles
end

function BeltalowdaRa.GetRaRole()
	local roles = BeltalowdaRa.state.roles
	local selectedRole = "-"
	if roles[BeltalowdaRa.charVars.selectedRole] ~= nil then
		selectedRole = roles[BeltalowdaRa.charVars.selectedRole]
	end
	return selectedRole
end

function BeltalowdaRa.SetRaRole(value)
	BeltalowdaRa.charVars.selectedRole = nil
	if value ~= nil then
		local roles = BeltalowdaRa.state.roles
		for i = 1, #roles do
			if roles[i] == value then
				BeltalowdaRa.charVars.selectedRole = i
				break
			end
		end
	end
	BeltalowdaRa.AdjustRole()
end