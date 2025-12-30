-- Beltalowda Util Group
-- Lightweight group tracking for Beltalowda
-- Author: @Kickimanjaro

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}

local BeltalowdaGroup = BeltalowdaUtil.group

-- Group state
BeltalowdaGroup.state = BeltalowdaGroup.state or {}
BeltalowdaGroup.state.players = {}
BeltalowdaGroup.state.updateInterval = 1000 -- Update every 1000ms

-- Last update time
local lastUpdateTime = 0

function BeltalowdaGroup.Initialize()
	-- Register for group events
	EVENT_MANAGER:RegisterForEvent(
		Beltalowda.name .. "_Group",
		EVENT_GROUP_MEMBER_JOINED,
		function(eventCode, characterName)
			BeltalowdaGroup.OnGroupMemberJoined(characterName)
		end
	)
	
	EVENT_MANAGER:RegisterForEvent(
		Beltalowda.name .. "_Group",
		EVENT_GROUP_MEMBER_LEFT,
		function(eventCode, characterName, reason, isLocalPlayer)
			BeltalowdaGroup.OnGroupMemberLeft(characterName, isLocalPlayer)
		end
	)
	
	EVENT_MANAGER:RegisterForEvent(
		Beltalowda.name .. "_Group",
		EVENT_POWER_UPDATE,
		function(eventCode, unitTag, powerIndex, powerType, power, powerMax, powerEffectiveMax)
			if powerType == POWERTYPE_ULTIMATE then
				BeltalowdaGroup.OnPowerUpdate(unitTag, power, powerMax)
			end
		end
	)
	
	-- Initial group update
	BeltalowdaGroup.UpdateGroupMembers()
	
	d("Beltalowda: Group tracking initialized")
end

function BeltalowdaGroup.OnGroupMemberJoined(characterName)
	d("Beltalowda: Group member joined - " .. characterName)
	BeltalowdaGroup.UpdateGroupMembers()
end

function BeltalowdaGroup.OnGroupMemberLeft(characterName, isLocalPlayer)
	d("Beltalowda: Group member left - " .. characterName)
	BeltalowdaGroup.state.players[characterName] = nil
	BeltalowdaGroup.UpdateGroupMembers()
end

function BeltalowdaGroup.OnPowerUpdate(unitTag, power, powerMax)
	-- Throttle updates
	local currentTime = GetGameTimeMilliseconds()
	if currentTime - lastUpdateTime < BeltalowdaGroup.state.updateInterval then
		return
	end
	lastUpdateTime = currentTime
	
	-- Get character name from unit tag
	local characterName = GetUnitName(unitTag)
	if not characterName or characterName == "" then
		return
	end
	
	-- Update ultimate percentage
	local ultimatePercent = 0
	if powerMax > 0 then
		ultimatePercent = math.floor((power / powerMax) * 100)
	end
	
	-- Create or update player entry
	if not BeltalowdaGroup.state.players[characterName] then
		BeltalowdaGroup.state.players[characterName] = {}
	end
	
	BeltalowdaGroup.state.players[characterName].ultimatePercent = ultimatePercent
	BeltalowdaGroup.state.players[characterName].ultimatePower = power
	BeltalowdaGroup.state.players[characterName].ultimateMax = powerMax
	BeltalowdaGroup.state.players[characterName].lastUpdate = currentTime
end

function BeltalowdaGroup.UpdateGroupMembers()
	if not IsUnitGrouped("player") then
		BeltalowdaGroup.state.players = {}
		return
	end
	
	local groupSize = GetGroupSize()
	local currentMembers = {}
	
	-- Iterate through group members
	for i = 1, groupSize do
		local unitTag = GetGroupUnitTagByIndex(i)
		if unitTag then
			local characterName = GetUnitName(unitTag)
			if characterName and characterName ~= "" then
				currentMembers[characterName] = true
				
				-- Initialize player if not exists
				if not BeltalowdaGroup.state.players[characterName] then
					BeltalowdaGroup.state.players[characterName] = {}
					BeltalowdaGroup.state.players[characterName].ultimatePercent = 0
					BeltalowdaGroup.state.players[characterName].ultimatePower = 0
					BeltalowdaGroup.state.players[characterName].ultimateMax = 0
				end
				
				-- Update ultimate values
				local power = GetUnitPower(unitTag, POWERTYPE_ULTIMATE)
				local powerMax = GetUnitPowerMax(unitTag, POWERTYPE_ULTIMATE)
				
				if powerMax > 0 then
					BeltalowdaGroup.state.players[characterName].ultimatePercent = math.floor((power / powerMax) * 100)
					BeltalowdaGroup.state.players[characterName].ultimatePower = power
					BeltalowdaGroup.state.players[characterName].ultimateMax = powerMax
				end
			end
		end
	end
	
	-- Remove members who are no longer in group
	for characterName, _ in pairs(BeltalowdaGroup.state.players) do
		if not currentMembers[characterName] then
			BeltalowdaGroup.state.players[characterName] = nil
		end
	end
end

function BeltalowdaGroup.GetPlayerUltimatePercent(characterName)
	if BeltalowdaGroup.state.players[characterName] then
		return BeltalowdaGroup.state.players[characterName].ultimatePercent or 0
	end
	return 0
end

function BeltalowdaGroup.GetAllPlayers()
	return BeltalowdaGroup.state.players
end

function BeltalowdaGroup.GetReadyUltimatesCount()
	local count = 0
	for characterName, data in pairs(BeltalowdaGroup.state.players) do
		if data.ultimatePercent and data.ultimatePercent >= 100 then
			count = count + 1
		end
	end
	return count
end

function BeltalowdaGroup.OnNetworkUltimateUpdate(characterName, ultimatePercent)
	-- Update ultimate percentage from network message
	if not BeltalowdaGroup.state.players[characterName] then
		BeltalowdaGroup.state.players[characterName] = {}
	end
	
	BeltalowdaGroup.state.players[characterName].ultimatePercent = ultimatePercent
	BeltalowdaGroup.state.players[characterName].lastUpdate = GetGameTimeMilliseconds()
	BeltalowdaGroup.state.players[characterName].fromNetwork = true
end
