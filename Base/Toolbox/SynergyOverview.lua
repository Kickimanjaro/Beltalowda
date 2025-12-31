-- Beltalowda Synergy Overview
-- By @s0rdrak (PC / EU)
-- Modified by @Kickimanjaro for Beltalowda
--
-- ============================================================================
-- MIGRATION NOTICE - Phase 3 Milestone 3
-- ============================================================================
-- This module has been migrated to Base/Features/Synergies.lua
-- This file now contains only delegation stubs for backward compatibility
-- ============================================================================

Beltalowda = Beltalowda or {}
Beltalowda.toolbox = Beltalowda.toolbox or {}
Beltalowda.toolbox.so = Beltalowda.toolbox.so or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.synergies = Beltalowda.features.synergies or {}

local BeltalowdaSO = Beltalowda.toolbox.so
local BeltalowdaSynergies = Beltalowda.features.synergies

-- Expose constants for backward compatibility (used by Lang files)
BeltalowdaSO.constants = BeltalowdaSynergies.constants

-- Delegate all functions to Synergies module
function BeltalowdaSO.Initialize()
return BeltalowdaSynergies.Initialize()
end

function BeltalowdaSO.GetDefaults()
return BeltalowdaSynergies.GetDefaults()
end

function BeltalowdaSO.SetEnabled(enabled, windowEnabled)
return BeltalowdaSynergies.SetEnabled(enabled, windowEnabled)
end

function BeltalowdaSO.CreateUI()
return BeltalowdaSynergies.CreateUI()
end

function BeltalowdaSO.SetPositionLocked(value)
return BeltalowdaSynergies.SetPositionLocked(value)
end

function BeltalowdaSO.AdjustSynergyDisplay()
return BeltalowdaSynergies.AdjustSynergyDisplay()
end

function BeltalowdaSO.AdjustSynergyColors()
return BeltalowdaSynergies.AdjustSynergyColors()
end

function BeltalowdaSO.SetControlVisibility()
return BeltalowdaSynergies.SetControlVisibility()
end

function BeltalowdaSO.OnPlayerActivated(eventCode, initial)
return BeltalowdaSynergies.OnPlayerActivated(eventCode, initial)
end

function BeltalowdaSO.SaveWindowLocation()
return BeltalowdaSynergies.SaveWindowLocation()
end

-- Note: All implementation has been moved to Base/Features/Synergies.lua
-- This file is maintained for backward compatibility only
