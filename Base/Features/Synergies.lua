-- Beltalowda Synergies Tracker
-- By @Kickimanjaro
-- Wrapper for SynergyOverview functionality
-- This module tracks synergy availability across the group

-- Initialize namespaces (safe for multi-file use)
Beltalowda = Beltalowda or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.synergies = Beltalowda.features.synergies or {}

-- Create local aliases (performance)
local BeltalowdaSynergies = Beltalowda.features.synergies
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaToolbox = Beltalowda.toolbox
BeltalowdaToolbox.so = BeltalowdaToolbox.so or {}
local BeltalowdaSO = BeltalowdaToolbox.so

-- Re-export the existing SynergyOverview functionality
-- Phase 1: Just provide a clearer namespace while keeping original implementation

function BeltalowdaSynergies.Initialize()
	-- Delegate to original implementation
	if BeltalowdaSO.Initialize then
		BeltalowdaSO.Initialize()
	end
end

function BeltalowdaSynergies.GetDefaults()
	-- Delegate to original implementation
	if BeltalowdaSO.GetDefaults then
		return BeltalowdaSO.GetDefaults()
	end
	return {}
end

function BeltalowdaSynergies.GetMenu()
	-- Delegate to original implementation
	if BeltalowdaSO.GetMenu then
		return BeltalowdaSO.GetMenu()
	end
	return {}
end

-- Expose common configuration functions
function BeltalowdaSynergies.SetEnabled(value)
	if BeltalowdaSO.SetEnabled then
		BeltalowdaSO.SetEnabled(value)
	end
end

function BeltalowdaSynergies.GetEnabled()
	if BeltalowdaSO.GetSoEnabled then
		return BeltalowdaSO.GetSoEnabled()
	end
	return false
end

-- Note: This is Phase 1 - a wrapper that delegates to the existing SynergyOverview.
-- In future phases, we will gradually move the implementation here.
