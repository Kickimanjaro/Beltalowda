-- Beltalowda Util Networking
-- Lightweight networking for group communication via LibGroupSocket
-- Author: @Kickimanjaro

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}

local BeltalowdaNetworking = BeltalowdaUtil.networking

-- Configuration
BeltalowdaNetworking.config = {}
BeltalowdaNetworking.config.updateInterval = 2000 -- Broadcast every 2 seconds
BeltalowdaNetworking.config.channelName = "beltalowda_ult" -- LibGroupSocket channel identifier

-- State
BeltalowdaNetworking.lastBroadcastTime = 0
BeltalowdaNetworking.lastBroadcastPercent = -1
BeltalowdaNetworking.lgs = nil -- LibGroupSocket reference

function BeltalowdaNetworking.Initialize()
	-- Get LibGroupSocket library
	BeltalowdaNetworking.lgs = LibStub and LibStub:GetLibrary("LibGroupSocket", true)
	
	if not BeltalowdaNetworking.lgs then
		d("|cFF0000Beltalowda: LibGroupSocket not found! Group sync disabled.|r")
		return
	end
	
	-- Register our channel with LibGroupSocket
	BeltalowdaNetworking.lgs:RegisterChannel(BeltalowdaNetworking.config.channelName, function(event, fromDisplayName, message)
		BeltalowdaNetworking.OnNetworkMessage(fromDisplayName, message)
	end)
	
	d("Beltalowda: Networking initialized (LibGroupSocket)")
end

function BeltalowdaNetworking.OnNetworkMessage(fromDisplayName, message)
	-- Parse the message payload: should be a simple number (ultimate percent)
	local percent = tonumber(message)
	
	if not percent then
		return
	end
	
	-- Extract character name from display name if needed
	-- LibGroupSocket sends @DisplayName, but we track by character name
	-- We'll use the display name as-is for now; group module will normalize
	if Beltalowda.util.group then
		Beltalowda.util.group.OnNetworkUltimateUpdate(fromDisplayName, percent)
	end
end

function BeltalowdaNetworking.BroadcastUltimate(ultimatePercent)
	-- Only broadcast if in a group and LibGroupSocket is available
	if not IsUnitGrouped("player") or not BeltalowdaNetworking.lgs then
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

	-- Send via LibGroupSocket (simple payload: just the percent as a string)
	local message = tostring(ultimatePercent)
	BeltalowdaNetworking.lgs:Send(BeltalowdaNetworking.config.channelName, message)
	
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
