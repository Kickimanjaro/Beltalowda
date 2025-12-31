-- Beltalowda Positioning Assistance
-- By @Kickimanjaro
-- Wrapper for RapidTracker functionality
-- This module tracks Expedition buffs (Major/Minor) for speed coordination

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.positioning = Beltalowda.features.positioning or {}

-- Create local aliases (performance)
local BeltalowdaPositioning = Beltalowda.features.positioning
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.rt = BeltalowdaGroup.rt or {}
local BeltalowdaRT = BeltalowdaGroup.rt

-- Re-export the existing RapidTracker functionality
-- Phase 1: Just provide a clearer namespace while keeping original implementation

function BeltalowdaPositioning.Initialize()
	-- Delegate to original implementation
	if BeltalowdaRT.Initialize then
		BeltalowdaRT.Initialize()
	end
end

function BeltalowdaPositioning.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaRT.GetDefaults then
		return BeltalowdaRT.GetDefaults()
	end
	return {}
end

function BeltalowdaPositioning.GetMenu()
	-- Delegate to original implementation
	if BeltalowdaRT.GetMenu then
		return BeltalowdaRT.GetMenu()
	end
	return {}
end

-- Expose common configuration functions
function BeltalowdaPositioning.SetEnabled(value)
	if BeltalowdaRT.SetEnabled then
		BeltalowdaRT.SetEnabled(value)
	end
end

function BeltalowdaPositioning.GetEnabled()
	if BeltalowdaRT.GetRtEnabled then
		return BeltalowdaRT.GetRtEnabled()
	end
	return false
end

-- Note: This is Phase 1 - a wrapper that delegates to the existing RapidTracker.
-- In future phases, we will gradually move the implementation here.
