-- Beltalowda Util Networking
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group

--local LGPS = LibGPS2
--local LMP = LibMapPing
--local lib3d = LibStub("Lib3D2")
--local lib3d = Lib3D

local LGB = LibGroupBroadcast

BeltalowdaNetworking.callbackName = Beltalowda.addonName .. "UtilNetworking"

BeltalowdaNetworking.config = {}
BeltalowdaNetworking.config.updateInterval = 1000
BeltalowdaNetworking.config.mapIndex = 23
BeltalowdaNetworking.config.mapStepSize = 1.4285034012573e-005
BeltalowdaNetworking.config.urgentMessageInterval = 3000

BeltalowdaNetworking.messageTypes = {}

BeltalowdaNetworking.messageTypes.MESSAGE_ID_HP = 60
BeltalowdaNetworking.messageTypes.MESSAGE_ID_DMG = 50
BeltalowdaNetworking.messageTypes.MESSAGE_ID_BOOM = 190
BeltalowdaNetworking.messageTypes.MESSAGE_ID_SYNERGY = 110
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ROLE = 109
BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_INFORMATION = 189
BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_REQUEST = 188
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST = 170
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_1 = 169
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_2 = 168
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_3 = 167
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_4 = 166
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_5 = 165
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_6 = 164
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_7 = 163
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8 = 162
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_9 = 161
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_AOE = 150
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_SOUND = 149
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS = 148
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_REQUEST_EQUIPMENT_INFORMATION = 140
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_1 = 139
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_2 = 138
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_3 = 137
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_4 = 136
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_5 = 135
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CHAMPION_INFORMATION = 134
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_STATS_INFORMATION = 133
BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_SKILLS_INFORMATION = 132

BeltalowdaNetworking.messageIdentifiers = {}
BeltalowdaNetworking.messageIdentifiers.adminResponse = {}
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics = {}
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_1 = 0
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_2 = 1
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_3 = 2
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_4 = 3
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_5 = 4
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_6 = 5
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_7 = 6
BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_8 = 7
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats = {}
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA = 0
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH = 1
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA = 2
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA_RECOVERY = 3
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH_RECOVERY = 4
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA_RECOVERY = 5
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_DAMAGE = 6
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_DAMAGE = 7
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_PENETRATION = 8
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_PENETRATION = 9
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL = 10
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_RESISTANCE = 11
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_PHYSICAL_RESISTANCE = 12
BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL_RESISTANCE = 13
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin = {}
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_1 = 0
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_2 = 1
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_3 = 2
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_4 = 3
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_5 = 4
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_6 = 5
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_7 = 6
BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_8 = 7

BeltalowdaNetworking.protocolTypes = {}
BeltalowdaNetworking.protocolTypes.LEGACY = 102
BeltalowdaNetworking.protocolTypes.ADMIN = 103
BeltalowdaNetworking.protocolTypes.VERSION = 104
BeltalowdaNetworking.protocolTypes.HEARTBEAT = 105
BeltalowdaNetworking.protocolTypes.SYNERGY = 106
BeltalowdaNetworking.protocolTypes.HPDMG = 107

BeltalowdaNetworking.messageIdentifiers.roleMessage = {}
BeltalowdaNetworking.messageIdentifiers.roleMessage.MESSAGE_ADMIN_SET_ROLE = 255

BeltalowdaNetworking.state = {}
BeltalowdaNetworking.state.initialized = false
BeltalowdaNetworking.state.isRunning = false
BeltalowdaNetworking.state.queues = {}
BeltalowdaNetworking.state.queues.critical = {}
BeltalowdaNetworking.state.queues.high = {}
BeltalowdaNetworking.state.queues.medium = {}
BeltalowdaNetworking.state.queues.low = {}
BeltalowdaNetworking.state.lastUrgentMessage = 0
BeltalowdaNetworking.state.rawMessageHandlers = {}

BeltalowdaNetworking.constants = BeltalowdaNetworking.constants or {}
BeltalowdaNetworking.constants.priorities = BeltalowdaNetworking.constants.priorities or {}
BeltalowdaNetworking.constants.priorities.CRITICAL = 1
BeltalowdaNetworking.constants.priorities.HIGH = 2
BeltalowdaNetworking.constants.priorities.MEDIUM = 3
BeltalowdaNetworking.constants.priorities.LOW = 4
BeltalowdaNetworking.constants.urgentSelection = BeltalowdaNetworking.constants.urgentSelection or {}
BeltalowdaNetworking.constants.urgentMode = {}
BeltalowdaNetworking.constants.urgentMode.DIRECT = 1
BeltalowdaNetworking.constants.urgentMode.CRITICAL = 2

function BeltalowdaNetworking.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaNetworking.callbackName, BeltalowdaNetworking.OnProfileChanged)
	BeltalowdaNetworking.LGB = LGB:RegisterHandler("Beltalowda", "BeltalowdaHandler")
	BeltalowdaNetworking.LGB:SetDisplayName("Beltalowda")
	BeltalowdaNetworking.LGB:SetDescription("Beltalowda - PvP AddOn -> https://www.esoui.com/downloads/info2475-Beltalowda.html \r\nPlease use the AddOn configuration (/beltalowda menu) to further configure the AddOn.")
	BeltalowdaNetworking.protocols = {}
	BeltalowdaNetworking.protocols.legacy = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.LEGACY, "BeltalowdaLegacyProtocol")
	BeltalowdaNetworking.protocols.legacy:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.legacy:OnData(BeltalowdaNetworking.LgbLegacyOnData)
	BeltalowdaNetworking.protocols.legacy:Finalize({isRelevantInCombat = true, replaceQueuedMessages = false})
	
	BeltalowdaNetworking.protocols.admin = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.ADMIN, "BeltalowdaAdminProtocol")
	BeltalowdaNetworking.protocols.admin:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.admin:OnData(BeltalowdaNetworking.LgbAdminOnData)
	BeltalowdaNetworking.protocols.admin:Finalize({isRelevantInCombat = false, replaceQueuedMessages = false})
	
	BeltalowdaNetworking.protocols.version = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.VERSION, "BeltalowdaVersionProtocol")
	BeltalowdaNetworking.protocols.version:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.version:OnData(BeltalowdaNetworking.LgbVersionOnData)
	BeltalowdaNetworking.protocols.version:Finalize({isRelevantInCombat = false, replaceQueuedMessages = false})
	
	BeltalowdaNetworking.protocols.heartbeat = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.HEARTBEAT, "BeltalowdaHeartbeatProtocol")
	BeltalowdaNetworking.protocols.heartbeat:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.heartbeat:OnData(BeltalowdaNetworking.LgbHeartbeatOnData)
	BeltalowdaNetworking.protocols.heartbeat:Finalize({isRelevantInCombat = true, replaceQueuedMessages = true})
	
	BeltalowdaNetworking.protocols.synergy = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.SYNERGY, "BeltalowdaSynergyProtocol")
	BeltalowdaNetworking.protocols.synergy:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.synergy:OnData(BeltalowdaNetworking.LgbSynergyOnData)
	BeltalowdaNetworking.protocols.synergy:Finalize({isRelevantInCombat = true, replaceQueuedMessages = false})
	
	BeltalowdaNetworking.protocols.hpDmg = BeltalowdaNetworking.LGB:DeclareProtocol(BeltalowdaNetworking.protocolTypes.HPDMG, "BeltalowdaHpDmgProtocol")
	BeltalowdaNetworking.protocols.hpDmg:AddField(LGB.CreateNumericField("numeric"))
	BeltalowdaNetworking.protocols.hpDmg:OnData(BeltalowdaNetworking.LgbHpDmgOnData)
	BeltalowdaNetworking.protocols.hpDmg:Finalize({isRelevantInCombat = true, replaceQueuedMessages = false})
	
	
	--BeltalowdaNetworking.protocols.legacy:Send()
	
	BeltalowdaNetworking.state.initialized = true
	BeltalowdaNetworking.SetEnabled(BeltalowdaNetworking.netVars.enabled)
end

function BeltalowdaNetworking.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	--defaults.mode = BeltalowdaNetworking.constants.urgentMode.CRITICAL
	--defaults.updateInterval = BeltalowdaNetworking.config.updateInterval
	return defaults
end

function BeltalowdaNetworking.SetEnabled(value)
	if BeltalowdaNetworking.state.initialized == true and value ~= nil then
		BeltalowdaNetworking.netVars.enabled = value
		if value == true then
			if BeltalowdaNetworking.state.isRunning == true then
				BeltalowdaNetworking.Disable()
				BeltalowdaNetworking.Enable()
			else
				BeltalowdaNetworking.Enable()
			end
		else
			if BeltalowdaNetworking.state.isRunning == true then
				BeltalowdaNetworking.Disable()
			else
				--Nothing to do
			end
		end
	end
end

--[[
function BeltalowdaNetworking.SendUrgentMessage(message)
	--d("sending urgent message")
	if BeltalowdaNetworking.netVars.mode == BeltalowdaNetworking.constants.urgentMode.CRITICAL then
		return nil
	end
	local messageSent = false
	if BeltalowdaNetworking.netVars.enabled == true then
	--[-[
		if message ~= nil and message.b0 ~= nil and message.b1 ~= nil and message.b2 ~= nil and message.b3 ~= nil then
			if BeltalowdaNetworking.state.lastUrgentMessage + BeltalowdaNetworking.config.urgentMessageInterval < GetGameTimeMilliseconds() then
				LGPS:PushCurrentMap()
				SetMapToMapListIndex(BeltalowdaNetworking.config.mapIndex)

				LMP:SetMapPing(MAP_PIN_TYPE_PING, MAP_TYPE_LOCATION_CENTERED, BeltalowdaNetworking.EncodeMessage(message.b0, message.b1, message.b2, message.b3))
				LGPS:PopCurrentMap()
				message.sent = true
					
				if GetGroupSize() == 0 then
					message.isPingOwner = true
					message.pingType = MAP_PIN_TYPE_PING
					message.pingTag = "player"
					BeltalowdaNetworking.HandleRawMessage(message)
				end
				BeltalowdaNetworking.state.lastUrgentMessage = GetGameTimeMilliseconds()
				messageSent = true
			else
				messageSent = false
			end
		else
			messageSent = true
		end
	else
		messageSent = true
		--]-]
	end
	return messageSent
end
]]

function BeltalowdaNetworking.LgbLegacyOnData(unitTag, data)
	--d("LEGACY: Received data from " .. GetUnitName(unitTag))
    --d("LEGACY: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.legacy:Send({numeric=numericVal})
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
		--d("message sent")
	end
--[[
	if BeltalowdaNetworking.netVars.enabled == true then
		local queues = BeltalowdaNetworking.state.queues
		local queue = queues.low
		local priorities = BeltalowdaNetworking.constants.priorities
		if priority == priorities.CRITICAL then
			queue = queues.critical
		elseif priority == priorities.HIGH then
			queue = queues.high
		elseif priority == priorities.MEDIUM then
			queue = queues.medium
		end
		message.priority = priority
		table.insert(queue, message)
	else
		if GetGroupSize() == 0 then
			message.pingTag = "player"
		else
			message.pingTag = BeltalowdaGroup.GetUnitTagForPlayer()
		end
		BeltalowdaNetworking.HandleRawMessage(message)
	end
	]]
end

function BeltalowdaNetworking.LgbAdminOnData(unitTag, data)
	--d("Admin: Received data from " .. GetUnitName(unitTag))
    --d("Admin: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendAdminMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.admin:Send({numeric=numericVal})
		--d("message sent")
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
	end
end

function BeltalowdaNetworking.LgbVersionOnData(unitTag, data)
	--d("Version: Received data from " .. GetUnitName(unitTag))
    --d("Version: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendVersionMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.version:Send({numeric=numericVal})
		--d("message sent")
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
	end
end

function BeltalowdaNetworking.LgbHeartbeatOnData(unitTag, data)
	--d("Heartbeat: Received data from " .. GetUnitName(unitTag))
    --d("Heartbeat: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendHeartbeatMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.heartbeat:Send({numeric=numericVal})
		--d("message sent")
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
	end
end

function BeltalowdaNetworking.LgbSynergyOnData(unitTag, data)
	--d("Synergy: Received data from " .. GetUnitName(unitTag))
    --d("Synergy: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendSynergyMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.synergy:Send({numeric=numericVal})
		--d("message sent")
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
	end
end

function BeltalowdaNetworking.LgbHpDmgOnData(unitTag, data)
	--d("HpDmg: Received data from " .. GetUnitName(unitTag))
    --d("HpDmg: myNumber: " .. data.numeric)
	local message = {}
	message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.Encode4ByteInt24(data.numeric)
	message.pingType = 0 -- old implementation - ping type
	message.pingTag = unitTag
	message.x = 0 -- old implementation via map pins - x coordinate
	message.y = 0 -- old implementation via map pins - y coordinate
	message.isPingOwner = false -- old implementation - ping owner
	
	BeltalowdaNetworking.HandleRawMessage(message)
end

function BeltalowdaNetworking.SendHpDmgMessage(message, priority)
	if BeltalowdaNetworking.netVars.enabled == true then
		local numericVal = BeltalowdaNetworking.Decode4ByteInt24(message.b0, message.b1, message.b2, message.b3)
		message.sent = true
		BeltalowdaNetworking.protocols.hpDmg:Send({numeric=numericVal})
		--d("message sent")
		if GetGroupSize() == 0 then
			message.pingTag = "player"
			BeltalowdaNetworking.HandleRawMessage(message)
		end
	end
end

function BeltalowdaNetworking.IsRawMessageHandlerRegistred(name)
	local isRegistred = false
	for i = 1, #BeltalowdaNetworking.state.rawMessageHandlers do
		if BeltalowdaNetworking.state.rawMessageHandlers[i].name == name then
			isRegistred = true
			break
		end
	end
	return isRegistred
end

function BeltalowdaNetworking.AddRawMessageHandler(name, messageCallback)
	if name ~= nil and messageCallback ~= nil then
		if BeltalowdaNetworking.IsRawMessageHandlerRegistred(name) == false then
			local newHandler = {}
			newHandler.name = name
			newHandler.handleRawMessage = messageCallback
			table.insert(BeltalowdaNetworking.state.rawMessageHandlers, newHandler)
		end
	end
end

function BeltalowdaNetworking.RemoveRawMessageHandler(name)
	if name ~= nil then
		local handlers = BeltalowdaNetworking.state.rawMessageHandlers
		for i = 1, #handlers do
			if handlers[i].name == name then
				table.remove(handlers, i)
				--i = i - 1
				break
			end
		end
	end
end

--Careful not to mess up arrays and b1, b2, b3
function BeltalowdaNetworking.EncodeBitArrayToMessage(array)
	local b1, b2, b3 = 0,0,0
	b1 = BeltalowdaMath.EncodeBitArrayHelper(array, 0)
	b2 = BeltalowdaMath.EncodeBitArrayHelper(array, 8)
	b3 = BeltalowdaMath.EncodeBitArrayHelper(array, 16)
	return b1, b2, b3
end

--Careful not to mess up arrays and b1, b2, b3
function BeltalowdaNetworking.DecodeMessageFromBitArray(b1, b2, b3)
	local array = {}
	local tempArray = BeltalowdaMath.DecodeBitArrayHelper(b1)
	for i = 1, 8 do
		array[i] = tempArray[i]
	end
	tempArray =BeltalowdaMath.DecodeBitArrayHelper(b2)
	local localIndex = 1
	for i = 9, 16 do
		array[i] = tempArray[localIndex]
		localIndex = localIndex + 1
	end
	tempArray =BeltalowdaMath.DecodeBitArrayHelper(b3)
	localIndex = 1
	for i = 17, 24 do
		array[i] = tempArray[localIndex]
		localIndex = localIndex + 1
	end
	return array
end

function BeltalowdaNetworking.Decode4ByteInt24(b0, b1, b2, b3)
	return (b0 * 16777216) + (b1 * 65536) + (b2 * 256) + b3
end

function BeltalowdaNetworking.Encode4ByteInt24(int24)
	local b0 = math.floor(int24 / 16777216)
	local b1 = math.floor((int24 % 16777216) / 65536)
    local b2 = math.floor((int24 % 16777216 % 65536) / 256)
    local b3 = int24 % 256

    return b0, b1, b2, b3
end

-- Compatible with Taos Group Tools Hp / Dmg calculations
function BeltalowdaNetworking.DecodeInt24(b1, b2, b3)
    return (b1 * 65536) + (b2 * 256) + b3
end

-- Compatible with Taos Group Tools Hp / Dmg calculations
function BeltalowdaNetworking.EncodeInt24(int24)
    local b1 = math.floor(int24 / 65536)
    local b2 = math.floor((int24 % 65536) / 256)
    local b3 = int24 % 256

    return b1, b2, b3
end

--Unfortunately, this code has to be used to integrate with addons like taos
--Original code comes from libgroupsocket
function BeltalowdaNetworking.DecodeMessage(x, y)
	x = math.floor(x / BeltalowdaNetworking.config.mapStepSize + 0.5)
	y = math.floor(y / BeltalowdaNetworking.config.mapStepSize + 0.5)

	local b0 = math.floor(x / 0x100)
	local b1 = x % 0x100
	local b2 = math.floor(y / 0x100)
	local b3 = y % 0x100

	return b0, b1, b2, b3
end

--Unfortunately, this code has to be used to integrate with addons like taos
--Original code comes from libgroupsocket
function BeltalowdaNetworking.EncodeMessage(b0, b1, b2, b3)
	b0 = b0 or 0
	b1 = b1 or 0
	b2 = b2 or 0
	b3 = b3 or 0
	return (b0 * 0x100 + b1) * BeltalowdaNetworking.config.mapStepSize, (b2 * 0x100 + b3) * BeltalowdaNetworking.config.mapStepSize
end

--[[
function BeltalowdaNetworking.GetUrgentMode()
	return BeltalowdaNetworking.netVars.mode
end]]

--internal functions
function BeltalowdaNetworking.Enable()
	--LMP:RegisterCallback("BeforePingAdded", BeltalowdaNetworking.OnBeforePingAdded)
	--LMP:RegisterCallback("AfterPingRemoved", BeltalowdaNetworking.OnAfterPingRemoved)
	--[[
	local updateInterval = BeltalowdaNetworking.netVars.updateInterval
	if updateInterval < 1000 and updateInterval > 3000 then
		updateInterval = BeltalowdaNetworking.config.updateInterval
	end]]
	--d(updateInterval)
	--EVENT_MANAGER:RegisterForUpdate(BeltalowdaNetworking.callbackName, updateInterval, BeltalowdaNetworking.OnSendData)
	
	BeltalowdaNetworking.state.isRunning = true
end

function BeltalowdaNetworking.Disable()
	--LMP:UnregisterCallback("BeforePingAdded", BeltalowdaNetworking.OnBeforePingAdded)
	--LMP:UnregisterCallback("AfterPingRemoved", BeltalowdaNetworking.OnAfterPingRemoved)
	--EVENT_MANAGER:UnregisterForUpdate(BeltalowdaNetworking.callbackName)
	BeltalowdaNetworking.state.isRunning = false
end

function BeltalowdaNetworking.HandleRawMessage(message)
	--d(message)
	--[[
	if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_INFORMATION then
		d("received MESSAGE_ID_VERSION_INFORMATION")
	end
	if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_REQUEST then
		d("received MESSAGE_ID_VERSION_REQUEST")
	end
	]]
	if message ~= nil then
		local handlers = BeltalowdaNetworking.state.rawMessageHandlers
		for i = 1, #handlers do
			handlers[i].handleRawMessage(message)
		end
	end
end

--callbacks
function BeltalowdaNetworking.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaNetworking.netVars = currentProfile.util.networking
		if BeltalowdaNetworking.state.initialized == true then
			BeltalowdaNetworking.SetEnabled(BeltalowdaNetworking.netVars.enabled)
		end
	end
end
--[[
function BeltalowdaNetworking.OnBeforePingAdded(pingType, pingTag, x, y, isPingOwner)
	--d("received")
	if (pingType == MAP_PIN_TYPE_PING) then
		LGPS:PushCurrentMap()
		SetMapToMapListIndex(BeltalowdaNetworking.config.mapIndex)
		--d(pingTag)
		x, y = LMP:GetMapPing(pingType, pingTag)

		LGPS:PopCurrentMap()
		LMP:SuppressPing(pingType, pingTag)
		
		local message = {}
		message.b0, message.b1, message.b2, message.b3 = BeltalowdaNetworking.DecodeMessage(x,y)
		message.pingType = pingType
		message.pingTag = pingTag
		message.x = x
		message.y = y
		message.isPingOwner = isPingOwner
		
		BeltalowdaNetworking.HandleRawMessage(message)
	end
end

function BeltalowdaNetworking.OnAfterPingRemoved(pingType, pingTag, x, y, isPingOwner)
	if (pingType == MAP_PIN_TYPE_PING) then
			
		LMP:UnsuppressPing(pingType, pingTag)
	end
end
]]



--[[
function BeltalowdaNetworking.OnSendData()
	---[-[
	local b0 = 1
	local b1 = math.random(100) -- ulti
	local b2 = math.random(100) -- magicka
	local b3 = math.random(100) -- stamina
	]-]
	--d(GetGameTimeMilliseconds())
	--d("update" .. GetGameTimeMilliseconds())
	if lib3d:IsValidZone() and BeltalowdaNetworking.state.lastUrgentMessage + 1000 < GetGameTimeMilliseconds() then
		local queues = BeltalowdaNetworking.state.queues
		local queue = nil
		if #queues.critical > 0 then
			queue = queues.critical
		elseif #queues.high > 0 then
			queue = queues.high
		elseif #queues.medium > 0 then
			queue = queues.medium
		elseif #queues.low > 0 then
			queue = queues.low
		end

		if queue ~= nil and #queue > 0 then
			local message = queue[1]
			if message ~= nil and message.b0 ~= nil and message.b1 ~= nil and message.b2 ~= nil and message.b3 ~= nil then
				LGPS:PushCurrentMap()
				SetMapToMapListIndex(BeltalowdaNetworking.config.mapIndex)
				---[-[
				if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_INFORMATION then
					d("sent MESSAGE_ID_VERSION_INFORMATION")
				end
				if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_REQUEST then
					d("sent MESSAGE_ID_VERSION_REQUEST")
				end
				]-]
				table.remove(queue, 1)
				LMP:SetMapPing(MAP_PIN_TYPE_PING, MAP_TYPE_LOCATION_CENTERED, BeltalowdaNetworking.EncodeMessage(message.b0, message.b1, message.b2, message.b3))
				LGPS:PopCurrentMap()
				message.sent = true
				
				if GetGroupSize() == 0 then
					message.isPingOwner = true
					message.pingType = MAP_PIN_TYPE_PING
					message.pingTag = "player"
					BeltalowdaNetworking.HandleRawMessage(message)
				end
			else
				if message ~= nil then
					message.sent = true
					table.remove(queue, 1)
				end
			end
			--d("message sent")
		end
	end
end
]]

--menu interactions
function BeltalowdaNetworking.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.NET_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.NET_ENABLED,
					getFunc = BeltalowdaNetworking.GetNetEnabled,
					setFunc = BeltalowdaNetworking.SetNetEnabled
				}--[[,
				[2] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.NET_URGENT_MODE,
					choices = BeltalowdaNetworking.GetNetUrgentModes(),
					getFunc = BeltalowdaNetworking.GetNetUrgentMode,
					setFunc = BeltalowdaNetworking.SetNetUrgentMode
				},
				[3] = {
					type = "slider",
					name = BeltalowdaMenu.constants.NET_INTERVAL,
					min = 1000,
					max = 3000,
					step = 10,
					getFunc = BeltalowdaNetworking.GetNetInterval,
					setFunc = BeltalowdaNetworking.SetNetInterval,
					width = "full",
					default = BeltalowdaNetworking.config.updateInterval
				},--]]
			}
		},
	}
	return menu
end

function BeltalowdaNetworking.GetNetEnabled()
	return BeltalowdaNetworking.netVars.enabled
end

function BeltalowdaNetworking.SetNetEnabled(value)
	BeltalowdaNetworking.SetEnabled(value)
end
--[[
function BeltalowdaNetworking.GetNetUrgentModes()
	return BeltalowdaNetworking.constants.urgentSelection
end

function BeltalowdaNetworking.GetNetUrgentMode()
	return BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.netVars.mode]
end

function BeltalowdaNetworking.SetNetUrgentMode(value)
		if value ~= nil then
		for i = 1, #BeltalowdaNetworking.constants.urgentSelection do
			if BeltalowdaNetworking.constants.urgentSelection[i] == value then
				BeltalowdaNetworking.netVars.mode = i
				break
			end
		end
	end
end

function BeltalowdaNetworking.GetNetInterval()
	return BeltalowdaNetworking.netVars.updateInterval
end

function BeltalowdaNetworking.SetNetInterval(value)
	BeltalowdaNetworking.netVars.updateInterval = value
	BeltalowdaNetworking.SetNetEnabled(BeltalowdaNetworking.netVars.enabled)
end
]]