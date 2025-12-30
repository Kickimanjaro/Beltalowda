-- Beltalowda Util Networking
-- Lightweight networking for group communication
-- Author: @Kickimanjaro

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}

local BeltalowdaNetworking = BeltalowdaUtil.networking

-- Configuration
BeltalowdaNetworking.config = {}
BeltalowdaNetworking.config.updateInterval = 2000 -- Broadcast every 2 seconds
BeltalowdaNetworking.config.messagePrefix = "BTLWD_ULT"
BeltalowdaNetworking.config.channelType = CHAT_CHANNEL_PARTY -- Use party chat for group messages

-- State
BeltalowdaNetworking.lastBroadcastTime = 0
BeltalowdaNetworking.lastBroadcastPercent = -1

function BeltalowdaNetworking.Initialize()
	-- Register for chat message events
	EVENT_MANAGER:RegisterForEvent(
		Beltalowda.name .. "_Networking",
		EVENT_CHAT_MESSAGE_CHANNEL,
		function(eventCode, channelType, fromName, text, isFromCustomerService, fromDisplayName)
			BeltalowdaNetworking.OnChatMessage(channelType, fromName, text)
		end
	)
	
	-- Add filter to prevent our messages from showing in chat
	EVENT_MANAGER:AddFilterForEvent(
		Beltalowda.name .. "_Networking",
		EVENT_CHAT_MESSAGE_CHANNEL,
		REGISTER_FILTER_MESSAGE_CHANNEL,
		function(channelType, fromName, text)
			-- Filter out our own messages
			if text and string.find(text, "^" .. BeltalowdaNetworking.config.messagePrefix) then
				return true -- Filter this message (don't display)
			end
			return false
		end
	)
	
	d("Beltalowda: Networking initialized")
end

function BeltalowdaNetworking.OnChatMessage(channelType, fromName, text)
	-- Only process party chat messages
	if channelType ~= CHAT_CHANNEL_PARTY then
		return
	end
	
	-- Check if this is our message format
	if not text or not string.find(text, "^" .. BeltalowdaNetworking.config.messagePrefix) then
		return
	end
	
	-- Parse the message: BTLWD_ULT:<percent>
	local percent = string.match(text, BeltalowdaNetworking.config.messagePrefix .. ":(%d+)")
	if percent then
		percent = tonumber(percent)
		if percent and Beltalowda.util.group then
			-- Update the group member's ultimate percentage
			Beltalowda.util.group.OnNetworkUltimateUpdate(fromName, percent)
		end
	end
end

function BeltalowdaNetworking.BroadcastUltimate(ultimatePercent)
	-- Only broadcast if in a group
	if not IsUnitGrouped("player") then
		return
	end
	
	-- Throttle broadcasts
	local currentTime = GetGameTimeMilliseconds()
	if currentTime - BeltalowdaNetworking.lastBroadcastTime < BeltalowdaNetworking.config.updateInterval then
		return
	end
	
	-- Only broadcast on significant changes or when ready (100%)
	local percentChange = math.abs(ultimatePercent - BeltalowdaNetworking.lastBroadcastPercent)
	if percentChange < 5 and ultimatePercent ~= 100 and ultimatePercent ~= 0 then
		return
	end
	
	-- Send the message using the proper chat API
	local message = string.format("%s:%d", BeltalowdaNetworking.config.messagePrefix, ultimatePercent)
	
	-- Use SendChatMessage for programmatic message sending
	if SendChatMessage then
		SendChatMessage(message, CHAT_CHANNEL_PARTY)
	end
	
	BeltalowdaNetworking.lastBroadcastTime = currentTime
	BeltalowdaNetworking.lastBroadcastPercent = ultimatePercent
end

function BeltalowdaNetworking.EnableBroadcasting()
	-- Register for power updates to broadcast ultimate changes
	EVENT_MANAGER:RegisterForEvent(
		Beltalowda.name .. "_NetworkingBroadcast",
		EVENT_POWER_UPDATE,
		function(eventCode, unitTag, powerIndex, powerType, power, powerMax, powerEffectiveMax)
			if unitTag == "player" and powerType == POWERTYPE_ULTIMATE then
				if powerMax > 0 then
					local percent = math.floor((power / powerMax) * 100)
					BeltalowdaNetworking.BroadcastUltimate(percent)
				end
			end
		end
	)
	d("Beltalowda: Ultimate broadcasting enabled")
end

function BeltalowdaNetworking.DisableBroadcasting()
	EVENT_MANAGER:UnregisterForEvent(Beltalowda.name .. "_NetworkingBroadcast", EVENT_POWER_UPDATE)
	d("Beltalowda: Ultimate broadcasting disabled")
end
