-- RdK Group Rapid Tracker
-- By @s0rdrak (PC / EU)
-- Modified by @Kickimanjaro for Beltalowda
--
-- ============================================================================
-- MIGRATION NOTICE - Phase 3 Milestone 2
-- ============================================================================
-- This module has been migrated to Base/Features/Positioning.lua
-- This file now contains only delegation stubs for backward compatibility
-- ============================================================================

Beltalowda = Beltalowda or {}
Beltalowda.group = Beltalowda.group or {}
Beltalowda.group.rt = Beltalowda.group.rt or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.positioning = Beltalowda.features.positioning or {}

local BeltalowdaRt = Beltalowda.group.rt
local BeltalowdaPositioning = Beltalowda.features.positioning

-- Alias for backward compatibility
BeltalowdaRt.rtVars = nil  -- Will be set to BeltalowdaPositioning.vars after init

-- Delegate all functions to Positioning module
function BeltalowdaRt.Initialize()
return BeltalowdaPositioning.Initialize()
end

function BeltalowdaRt.GetDefaults()
return BeltalowdaPositioning.GetDefaults()
end

function BeltalowdaRt.SetEnabled(value)
return BeltalowdaPositioning.SetEnabled(value)
end

function BeltalowdaRt.CreateUI()
return BeltalowdaPositioning.CreateUI()
end

function BeltalowdaRt.SetMovable(isMovable)
return BeltalowdaPositioning.SetMovable(isMovable)
end

function BeltalowdaRt.AdjustColors()
return BeltalowdaPositioning.AdjustColors()
end

function BeltalowdaRt.SetControlVisibility()
return BeltalowdaPositioning.SetControlVisibility()
end

function BeltalowdaRt.OnPlayerActivated(eventCode, initial)
return BeltalowdaPositioning.OnPlayerActivated(eventCode, initial)
end

function BeltalowdaRt.OnUpdate()
return BeltalowdaPositioning.OnUpdate()
end

function BeltalowdaRt.SaveWindowLocation()
return BeltalowdaPositioning.SaveWindowLocation()
end

function BeltalowdaRt.SetRtPositionLocked(value)
return BeltalowdaPositioning.SetRtPositionLocked(value)
end

-- Note: All implementation has been moved to Base/Features/Positioning.lua
-- This file is maintained for backward compatibility only
