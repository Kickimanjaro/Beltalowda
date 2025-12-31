-- Beltalowda Attack Timers
-- By @Kickimanjaro
-- Wrapper for DetonationTracker functionality
-- This module tracks Detonation and Shalk (Subterranean Assault/Deep Fissure) timers

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.attackTimers = Beltalowda.features.attackTimers or {}

-- Create local aliases (performance)
local BeltalowdaAttackTimers = Beltalowda.features.attackTimers
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.dt = BeltalowdaGroup.dt or {}
local BeltalowdaDT = BeltalowdaGroup.dt

-- Re-export the existing DetonationTracker functionality
-- Phase 1: Just provide a clearer namespace while keeping original implementation

function BeltalowdaAttackTimers.Initialize()
	-- Delegate to original implementation
	if BeltalowdaDT.Initialize then
		BeltalowdaDT.Initialize()
	end
end

function BeltalowdaAttackTimers.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaDT.GetDefaults then
		return BeltalowdaDT.GetDefaults()
	end
	return {}
end

function BeltalowdaAttackTimers.GetMenu()
	-- Delegate to original implementation
	if BeltalowdaDT.GetMenu then
		return BeltalowdaDT.GetMenu()
	end
	return {}
end

-- Expose common configuration functions
function BeltalowdaAttackTimers.SetEnabled(value)
	if BeltalowdaDT.SetEnabled then
		BeltalowdaDT.SetEnabled(value)
	end
end

function BeltalowdaAttackTimers.GetEnabled()
	if BeltalowdaDT.GetDtEnabled then
		return BeltalowdaDT.GetDtEnabled()
	end
	return false
end

-- Note: This is Phase 1 - a wrapper that delegates to the existing DetonationTracker.
-- In future phases, we will gradually move the implementation here.
