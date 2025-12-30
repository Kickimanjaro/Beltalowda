-- Beltalowda Util Versioning
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.versioning = BeltalowdaUtil.versioning or {}
local BeltalowdaVersioning = BeltalowdaUtil.versioning
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.roster = BeltalowdaUtil.roster or {}
local BeltalowdaRoster = BeltalowdaUtil.roster
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaVersioning.callbackName = Beltalowda.addonName .. "UtilVersioning"
BeltalowdaVersioning.queueCallbackName = Beltalowda.addonName .. "UtilVersioningQueue"


BeltalowdaVersioning.config = {}
BeltalowdaVersioning.config.featureInterval = 100
BeltalowdaVersioning.config.sendInterval = 900000
BeltalowdaVersioning.config.requestInterval = 2000

BeltalowdaVersioning.constants = {}
BeltalowdaVersioning.constants.NO_MESSAGE_INTERVAL = 30000
BeltalowdaVersioning.constants.INFORMATION_REQUEST_ALL = 25
BeltalowdaVersioning.constants.PREFIX = "Version"

BeltalowdaVersioning.state = {}
BeltalowdaVersioning.state.clientVersion = {}
BeltalowdaVersioning.state.clientVersion.major = 0
BeltalowdaVersioning.state.clientVersion.minor = 0
BeltalowdaVersioning.state.clientVersion.revision = 0
BeltalowdaVersioning.state.clientOutOfDate = false
BeltalowdaVersioning.state.isInGroup = false
BeltalowdaVersioning.state.requestQueue = {}

BeltalowdaVersioning.state.lastMessage = nil
BeltalowdaVersioning.state.lastMessageTimeStamp = nil

--functions
function BeltalowdaVersioning.Initialize()
	BeltalowdaGroup.AddFeature(BeltalowdaVersioning.callbackName, BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING, BeltalowdaVersioning.config.featureInterval)
	BeltalowdaGroup.SetVersionCheckCallback(BeltalowdaVersioning.CheckVersionInformation)
	BeltalowdaVersioning.state.clientVersion = BeltalowdaVersioning.GetVersionArray(Beltalowda.versionString)
	
	if GetGroupSize() ~= 0 then
		BeltalowdaVersioning.GroupMemberOnJoined()
	end
	
	EVENT_MANAGER:RegisterForEvent(BeltalowdaVersioning.callbackName, EVENT_GROUP_MEMBER_JOINED, BeltalowdaVersioning.GroupMemberOnJoined)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaVersioning.callbackName, EVENT_GROUP_MEMBER_LEFT, BeltalowdaVersioning.GroupMemberOnLeft)
	BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaVersioning.callbackName, BeltalowdaVersioning.HandleRawVersioningRequestNetworkMessage)
	EVENT_MANAGER:RegisterForUpdate(BeltalowdaVersioning.queueCallbackName, BeltalowdaVersioning.config.requestInterval, BeltalowdaVersioning.SendQueuedRequests)
end



function BeltalowdaVersioning.CheckVersionInformation(player)
	if player ~= nil and player.clientVersion ~= nil then
		--d(player.clientVersion)
		--d(BeltalowdaVersioning.state.clientVersion)
		if BeltalowdaVersioning.VersionBiggerThan(BeltalowdaVersioning.state.clientVersion, player.clientVersion) then
			--d("Other client has an older version")
			if player.clientVersion.versionAlertSent == false then
				player.clientVersion.versionAlertSent = true
				BeltalowdaVersioning.SendClientVersionInformation()
			end
		elseif BeltalowdaVersioning.VersionLesserThan(BeltalowdaVersioning.state.clientVersion, player.clientVersion) then
			--d("Other client has a newer version")
			if BeltalowdaVersioning.state.clientOutOfDate == false then
				BeltalowdaChat.SendChatMessage(BeltalowdaVersioning.constants.CLIENT_OUT_OF_DATE, BeltalowdaVersioning.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
				BeltalowdaVersioning.state.clientOutOfDate = true
			end
		end
	end
end

function BeltalowdaVersioning.VersionBiggerThan(versionA, versionB)
	local bigger = false
		if versionA.major > versionB.major or
		   (versionA.major == versionB.major and versionA.minor > versionB.minor) or
		   (versionA.major == versionB.major and versionA.minor == versionB.minor and versionA.revision > versionB.revision) then
			bigger = true
		end
	return bigger
end

function BeltalowdaVersioning.VersionLesserThan(versionA, versionB)
	local lesser = false
		if versionA.major < versionB.major or
		   (versionA.major == versionB.major and versionA.minor < versionB.minor) or
		   (versionA.major == versionB.major and versionA.minor == versionB.minor and versionA.revision < versionB.revision) then
			lesser = true
		end
	return lesser
end

function BeltalowdaVersioning.GetVersionArray(versionString)
	local versionInformation = {}
	versionInformation.major, versionInformation.minor, versionInformation.revision = 0,0,0
	if versionString ~= nil then
		local tempVersion = {zo_strsplit(".", versionString)}
		if tempVersion[1] ~= nil then
			versionInformation.major = tonumber(tempVersion[1])
		end
		if tempVersion[2] ~= nil then
			versionInformation.minor = tonumber(tempVersion[2])
		end
		if tempVersion[3] ~= nil then
			versionInformation.revision = tonumber(tempVersion[3])
		end
	end
	return versionInformation
end

function BeltalowdaVersioning.GetHighestKnownVersionNumber()
	local version = nil
	local players = BeltalowdaGroup.GetGroupInformation()
	if players ~= nil then
		for i = 1, #players do
			if version == nil or (version ~= nil and players[i].clientVersion ~= nil and players[i].clientVersion.major ~= nil and players[i].minor ~= nil and players[i].revision ~= nil and BeltalowdaVersioning.VersionBiggerThan(players[i].clientVersion, version) == true) then
				version = players[i].clientVersion
			end
		end
	end
	if version ~= nil then
		local copy = {}
		copy.major = version.major
		copy.minor = version.minor
		copy.revision = version.revision
		version = copy
	end
	return version
end

function BeltalowdaVersioning.SendClientVersionInformation()
	--d("send client information")
	if (BeltalowdaVersioning.state.lastMessage == nil or BeltalowdaVersioning.state.lastMessage.sent == true) and (BeltalowdaVersioning.state.lastMessageTimeStamp == nil or BeltalowdaVersioning.state.lastMessageTimeStamp + BeltalowdaVersioning.constants.NO_MESSAGE_INTERVAL < GetGameTimeMilliseconds()) then
		local message = {}
		message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_INFORMATION
		message.b1 = BeltalowdaVersioning.state.clientVersion.major
		message.b2 = BeltalowdaVersioning.state.clientVersion.minor
		message.b3 = BeltalowdaVersioning.state.clientVersion.revision
		message.sent = false
		BeltalowdaVersioning.state.lastMessage = message
		BeltalowdaNetworking.SendVersionMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
		BeltalowdaVersioning.state.lastMessageTimeStamp = GetGameTimeMilliseconds()
		--d(message)
	end
end

function BeltalowdaVersioning.AddVersionInformationRequestToQueue(message)
	if message ~= nil and BeltalowdaRoster.IsGuildOfficer(GetUnitDisplayName("player")) then
		--d(message)
		local queueMessage = true
		for i = 1, #BeltalowdaVersioning.state.requestQueue do
			local messageEntry = BeltalowdaVersioning.state.requestQueue[i]
			if message.b1 == messageEntry.message.b1 and messageEntry.message.sent == false then
				queueMessage = false
			end
		end
		if queueMessage == true then
			--d("adding to queue")
			table.insert(BeltalowdaVersioning.state.requestQueue, {requestAdded = false, message = message})
		end
	end
end

function BeltalowdaVersioning.RequestVersionInformation(unitTag)
	--d(unitTag)
	local message = {}
	message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_REQUEST
	message.b1 = 0
	message.b2 = 0
	message.b3 = 0
	message.sent = false
	if unitTag ~= nil and unitTag ~= "player" then
		local players = BeltalowdaGroup.GetGroupInformation()
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					message.b1 = i
					break
				end
			end
		end
	elseif unitTag == nil then
		message.b1 = BeltalowdaVersioning.constants.INFORMATION_REQUEST_ALL
	end
	if message.b1 > 0 then
		BeltalowdaVersioning.AddVersionInformationRequestToQueue(message)
	end
end

function BeltalowdaVersioning.ProcessVersionInformationRequest(requestingUnitTag, unitIndex)
	--d(requestingUnitTag)
	if unitIndex ~= nil and requestingUnitTag ~= nil then
		--if BeltalowdaRoster.IsBeltalowdaAdmin(GetUnitDisplayName(requestingUnitTag)) then
		if BeltalowdaRoster.IsGuildOfficerOf(GetUnitDisplayName("player"),GetUnitDisplayName(requestingUnitTag)) then
			--d("Version Information Requested")
			local players = BeltalowdaGroup.GetGroupInformation()
			local sendInformation = false
			if unitIndex == BeltalowdaVersioning.constants.INFORMATION_REQUEST_ALL then
				sendInformation = true
			elseif players ~= nil and players[unitIndex] ~= nil then
				local player = players[unitIndex]
				if player.charName == GetUnitName("player") and player.displayName == GetUnitDisplayName("player") then
					sendInformation = true
				end
			end
			if sendInformation == true then
				--d("send version information")
				BeltalowdaVersioning.SendClientVersionInformation()
			end
		end
	end
end

--functions version fix
function BeltalowdaVersioning.InitializeFixes(savedVars, charVars)
	BeltalowdaVersioning.FixVars(savedVars, charVars, Beltalowda.versionString, savedVars.lastVersion)
	if savedVars.lastVersion ~= Beltalowda.versionString then
		savedVars.reported = nil
	end
	savedVars.lastVersion = Beltalowda.versionString
end

function BeltalowdaVersioning.FixVars(savedVars, charVars, currentVersion, lastVersion)
	if lastVersion ~= nil then
		local current = BeltalowdaVersioning.GetVersionArray(currentVersion)
		local last = BeltalowdaVersioning.GetVersionArray(lastVersion)
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("1.1.0")) then
			BeltalowdaVersioning.Apply1d1d0Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("1.2.1")) then
			BeltalowdaVersioning.Apply1d2d1Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("1.3.0")) then
			BeltalowdaVersioning.Apply1d3d0Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("1.12.0")) then
			BeltalowdaVersioning.Apply1d12d0Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("1.12.2")) then
			BeltalowdaVersioning.Apply1d12d2Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("2.0.1")) then
			BeltalowdaVersioning.Apply2d0d1Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("2.0.40")) then
			BeltalowdaVersioning.Apply2d0d40Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("2.0.43")) then
			BeltalowdaVersioning.Apply2d0d43Fix(savedVars)
		end
		if BeltalowdaVersioning.VersionLesserThan(last, BeltalowdaVersioning.GetVersionArray("2.1.1")) then
			BeltalowdaVersioning.Apply2d1d1Fix(savedVars)
		end
	end
end

function BeltalowdaVersioning.Apply1d1d0Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		profiles[i].group.ftca.selectedSound = "CrownCrates_Purchased_With_Gems"
		profiles[i].group.ro.selectedSound = "BG_One_Minute_Warning"
	end
end

function BeltalowdaVersioning.Apply1d2d1Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group.bft ~= nil then
			profiles[i].group.bft.enabled = true
		end
	end
end

function BeltalowdaVersioning.Apply1d3d0Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group.bft ~= nil then
			profiles[i].toolbox.bft = profiles[i].group.bft
			profiles[i].group.bft = nil
		end
	end
end

function BeltalowdaVersioning.Apply1d12d0Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group ~= nil and profiles[i].group.gb ~= nil and profiles[i].group.gb.roles ~= nil then
			for j = 1, #profiles[i].group.gb.roles - 1 do
				profiles[i].group.gb.roles[j].enabled = false
			end
		end
	end
end

function BeltalowdaVersioning.Apply1d12d2Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group ~= nil and profiles[i].group.ro ~= nil and profiles[i].group.ro.ultimates ~= nil then
			profiles[i].group.ro.ultimates.groupSizeNegate = 1
			profiles[i].group.ro.ultimates.maxDistance = 50
		end
	end
end

function BeltalowdaVersioning.Apply2d0d1Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group ~= nil and profiles[i].group.dt ~= nil and profiles[i].group.dt.fontColor ~= nil and profiles[i].group.dt.detonation ~= nil then
			profiles[i].group.dt.detonation.fontColor = profiles[i].group.dt.fontColor
			profiles[i].group.dt.fontColor = nil
		end
		if profiles[i].group ~= nil and profiles[i].group.dt ~= nil and profiles[i].group.dt.progressColor ~= nil and profiles[i].group.dt.detonation ~= nil then
			profiles[i].group.dt.detonation.progressColor = profiles[i].group.dt.progressColor
			profiles[i].group.dt.progressColor = nil
		end
	end
end

--New Arcanist Ulti (RO Split) Order
--[[
runebreak SO -> Übersetzungen
runebreak SP -> Übersetzungen
/script Beltalowda.util.versioning.Apply2d0d40Fix(Beltalowda.vars.acc)
]]

function BeltalowdaVersioning.Apply2d0d40Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		if profiles[i].group ~= nil and profiles[i].group.ro ~= nil and profiles[i].group.ro.groups ~= nil and profiles[i].group.ro.groups.ultimateGroups ~= nil then
			local ultimateGroups = profiles[i].group.ro.groups.ultimateGroups
			for j = 38, 25, -1 do
				ultimateGroups[j + 3].group = ultimateGroups[j].group
				ultimateGroups[j + 3].priority = ultimateGroups[j].priority
			end
			ultimateGroups[25].group = 1
			ultimateGroups[25].priority = 20
			ultimateGroups[26].group = 3
			ultimateGroups[26].priority = 20
			ultimateGroups[27].group = 3
			ultimateGroups[27].priority = 30
			--d("profile " .. i .. " done")
		end
	end
	--d("done with fix")
end


function BeltalowdaVersioning.Apply2d0d43Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		local smItems = profiles[i].toolbox.sm.items
		smItems[1].minimum = 0 -- Old repair kit
		smItems[1].maximum = 0 -- Old repair kit
		smItems[2].minimum = 0 -- Old repair kit
		smItems[2].maximum = 0 -- Old repair kit
		smItems[3].minimum = 0 -- Old repair kit
		smItems[3].maximum = 0 -- Old repair kit
		smItems[17].minimum = 0 -- Old repair kit
		smItems[17].maximum = 0 -- Old repair kit
	end
	
end

function BeltalowdaVersioning.Apply2d1d1Fix(savedVars)
	local profiles = savedVars.profiles
	for i = 1, #profiles do
		local netItems = profiles[i].util.networking
		netItems.mode = nil
		netItems.updateInterval = nil
	end
end

--callbacks
function BeltalowdaVersioning.SendQueuedRequests()
	--d(#BeltalowdaVersioning.state.requestQueue)
	for i = 1, #BeltalowdaVersioning.state.requestQueue do
		local messageEntry = BeltalowdaVersioning.state.requestQueue[i]
		if messageEntry ~= nil and messageEntry.message ~= nil and messageEntry.message.sent == true then
			table.remove(BeltalowdaVersioning.state.requestQueue, i)
			i = i - 1
		elseif messageEntry ~= nil then
			if messageEntry.requestAdded == true then
				--Already on Network Queue
			else
				messageEntry.requestAdded = true
				--d("sending message")
				BeltalowdaNetworking.SendVersionMessage(messageEntry.message, BeltalowdaNetworking.constants.priorities.MEDIUM)
			end
		end
	end
end

function BeltalowdaVersioning.SendLoop()
	--d("sent")
	BeltalowdaVersioning.SendClientVersionInformation()
end

function BeltalowdaVersioning.GroupMemberOnJoined(...)
	if BeltalowdaVersioning.state.isInGroup == false then
		BeltalowdaVersioning.state.isInGroup = true
		BeltalowdaVersioning.SendClientVersionInformation()
		EVENT_MANAGER:RegisterForUpdate(BeltalowdaVersioning.callbackName,  BeltalowdaVersioning.config.sendInterval, BeltalowdaVersioning.SendLoop)
	end
end

function BeltalowdaVersioning.GroupMemberOnLeft(...)
	if GetGroupSize() ~= 0 then
		BeltalowdaVersioning.state.isInGroup = true
	else
		BeltalowdaVersioning.state.isInGroup = false
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaVersioning.callbackName)
	end
end

function BeltalowdaVersioning.HandleRawVersioningRequestNetworkMessage(message)
	if message ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_REQUEST then
		--d("version request received")
		--d(message)
		BeltalowdaVersioning.ProcessVersionInformationRequest(message.pingTag, message.b1)
	end
end