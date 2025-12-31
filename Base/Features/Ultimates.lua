-- Beltalowda Ultimates Tracker
-- By @Kickimanjaro
-- Wrapper for ResourceOverview functionality focused on Ultimate tracking
-- This module tracks group members' ultimate abilities and resources (stamina/magicka)

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.ultimates = Beltalowda.features.ultimates or {}

-- Create local aliases (performance)
local BeltalowdaUltimates = Beltalowda.features.ultimates
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.ro = BeltalowdaGroup.ro or {}
local BeltalowdaRO = BeltalowdaGroup.ro

-- Re-export the existing ResourceOverview functionality
-- Phase 1: Just provide a clearer namespace while keeping original implementation

function BeltalowdaUltimates.Initialize()
	-- Delegate to original implementation
	if BeltalowdaRO.Initialize then
		BeltalowdaRO.Initialize()
	end
end

function BeltalowdaUltimates.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaRO.GetDefaults then
		return BeltalowdaRO.GetDefaults()
	end
	return {}
end

function BeltalowdaUltimates.GetMenu()
	-- Delegate to original implementation
	if BeltalowdaRO.GetMenu then
		return BeltalowdaRO.GetMenu()
	end
	return {}
end

-- Expose common configuration functions
function BeltalowdaUltimates.SetEnabled(value)
	if BeltalowdaRO.SetEnabled then
		BeltalowdaRO.SetEnabled(value)
	end
end

function BeltalowdaUltimates.GetEnabled()
	if BeltalowdaRO.GetRoEnabled then
		return BeltalowdaRO.GetRoEnabled()
	end
	return false
end

-- Note: This is Phase 1 - a wrapper that delegates to the existing ResourceOverview.
-- In future phases, we will gradually move the implementation here.
