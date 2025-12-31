-- Beltalowda Detonation Tracker
-- By @s0rdrak (PC / EU)
-- Modified by @Kickimanjaro for Beltalowda
--
-- ============================================================================
-- MIGRATION NOTICE - Phase 3 Milestone 4
-- ============================================================================
-- This module has been migrated to Base/Features/AttackTimers.lua
-- This file now contains only delegation stubs for backward compatibility
-- ============================================================================

Beltalowda = Beltalowda or {}
Beltalowda.group = Beltalowda.group or {}
Beltalowda.group.dt = Beltalowda.group.dt or {}
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.attackTimers = Beltalowda.features.attackTimers or {}

local BeltalowdaDt = Beltalowda.group.dt
local BeltalowdaAttackTimers = Beltalowda.features.attackTimers

-- Create a proxy that forwards constants access to the AttackTimers module
-- This works around load order issues
setmetatable(BeltalowdaDt, {
__index = function(table, key)
if key == "constants" then
return BeltalowdaAttackTimers.constants
end
return rawget(table, key)
end
})

-- Delegate all functions to AttackTimers module
function BeltalowdaDt.Initialize()
return BeltalowdaAttackTimers.Initialize()
end

function BeltalowdaDt.GetDefaults()
return BeltalowdaAttackTimers.GetDefaults()
end

function BeltalowdaDt.SetEnabled(value)
return BeltalowdaAttackTimers.SetEnabled(value)
end

function BeltalowdaDt.CreateUI()
return BeltalowdaAttackTimers.CreateUI()
end

function BeltalowdaDt.SetPositionLocked(value)
return BeltalowdaAttackTimers.SetPositionLocked(value)
end

function BeltalowdaDt.AdjustMode()
return BeltalowdaAttackTimers.AdjustMode()
end

function BeltalowdaDt.AdjustSize()
return BeltalowdaAttackTimers.AdjustSize()
end

function BeltalowdaDt.AdjustColors()
return BeltalowdaAttackTimers.AdjustColors()
end

function BeltalowdaDt.SetControlVisibility()
return BeltalowdaAttackTimers.SetControlVisibility()
end

function BeltalowdaDt.OnPlayerActivated(eventCode, initial)
return BeltalowdaAttackTimers.OnPlayerActivated(eventCode, initial)
end

function BeltalowdaDt.SaveWindowLocation()
return BeltalowdaAttackTimers.SaveWindowLocation()
end

-- Note: All implementation has been moved to Base/Features/AttackTimers.lua
-- This file is maintained for backward compatibility only
