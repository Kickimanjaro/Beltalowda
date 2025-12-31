-- Beltalowda Resource Overview (Delegation Wrapper)
-- This file provides backward compatibility by delegating to the new Ultimates module

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.ro = BeltalowdaGroup.ro or {}
local BeltalowdaOverview = BeltalowdaGroup.ro

-- Create reference to the new Ultimates module
Beltalowda.features = Beltalowda.features or {}
Beltalowda.features.ultimates = Beltalowda.features.ultimates or {}
local BeltalowdaUltimates = Beltalowda.features.ultimates

-- ============================================================================
-- Delegation Functions
-- All functionality has been migrated to Base/Features/Ultimates.lua
-- These functions delegate to the new module for backward compatibility
-- ============================================================================

-- Core lifecycle functions
function BeltalowdaOverview.Initialize()
	-- TEMPORARY: Disable Ultimates initialization to isolate crash issue
	-- return BeltalowdaUltimates.Initialize()
	d("[Beltalowda] Ultimates initialization DISABLED for testing")
	return
end

function BeltalowdaOverview.InitializeControlSettings()
	return BeltalowdaUltimates.InitializeControlSettings()
end

function BeltalowdaOverview.GetDefaults()
	return BeltalowdaUltimates.GetDefaults()
end

function BeltalowdaOverview.OnProfileChanged(currentProfile)
	return BeltalowdaUltimates.OnProfileChanged(currentProfile)
end

function BeltalowdaOverview.OnPlayerActivated(eventCode, initial)
	return BeltalowdaUltimates.OnPlayerActivated(eventCode, initial)
end

-- UI and control functions
function BeltalowdaOverview.SetEnabled(value)
	return BeltalowdaUltimates.SetEnabled(value)
end

function BeltalowdaOverview.SetGroupsEnabled(value)
	return BeltalowdaUltimates.SetGroupsEnabled(value)
end

function BeltalowdaOverview.SetPositionLocked(value)
	return BeltalowdaUltimates.SetPositionLocked(value)
end

function BeltalowdaOverview.SetControlVisibility()
	return BeltalowdaUltimates.SetControlVisibility()
end

function BeltalowdaOverview.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	return BeltalowdaUltimates.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
end

function BeltalowdaOverview.SetTlwLocation()
	return BeltalowdaUltimates.SetTlwLocation()
end

function BeltalowdaOverview.SetDisplayedUltimates(value)
	return BeltalowdaUltimates.SetDisplayedUltimates(value)
end

-- UI creation functions
function BeltalowdaOverview.CreateDefaultUI()
	return BeltalowdaUltimates.CreateDefaultUI()
end

function BeltalowdaOverview.CreateGroupsUI()
	return BeltalowdaUltimates.CreateGroupsUI()
end

function BeltalowdaOverview.CreatePlayerBlock(parent, width, height, blockGroupWidth, blockMagickaHeight, blockStaminaHeight)
	return BeltalowdaUltimates.CreatePlayerBlock(parent, width, height, blockGroupWidth, blockMagickaHeight, blockStaminaHeight)
end

-- Adjustment functions
function BeltalowdaOverview.AdjustSize()
	return BeltalowdaUltimates.AdjustSize()
end

function BeltalowdaOverview.AdjustColors()
	return BeltalowdaUltimates.AdjustColors()
end

function BeltalowdaOverview.AdjustInCombatSettings()
	return BeltalowdaUltimates.AdjustInCombatSettings()
end

function BeltalowdaOverview.AdjustGroupNames()
	return BeltalowdaUltimates.AdjustGroupNames()
end

function BeltalowdaOverview.AdjustGroupsShowSoftResources()
	return BeltalowdaUltimates.AdjustGroupsShowSoftResources()
end

function BeltalowdaOverview.AdjustGroupsColor()
	return BeltalowdaUltimates.AdjustGroupsColor()
end

function BeltalowdaOverview.AdjustDisplayMode()
	return BeltalowdaUltimates.AdjustDisplayMode()
end

-- Update loops
function BeltalowdaOverview.UiLoop()
	return BeltalowdaUltimates.UiLoop()
end

function BeltalowdaOverview.GroupsUiLoop()
	return BeltalowdaUltimates.GroupsUiLoop()
end

function BeltalowdaOverview.NetworkLoop()
	return BeltalowdaUltimates.NetworkLoop()
end

function BeltalowdaOverview.MessageUpdateLoop()
	return BeltalowdaUltimates.MessageUpdateLoop()
end

-- Use metatable for dynamic property access (constants, config, state, controls, etc.)
setmetatable(BeltalowdaOverview, {
	__index = function(table, key)
		-- Delegate property access to BeltalowdaUltimates
		return BeltalowdaUltimates[key]
	end
})

-- ============================================================================
-- End of delegation wrapper
-- All implementation is in Base/Features/Ultimates.lua
-- ============================================================================
