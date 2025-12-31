-- Beltalowda Core
-- By @Kickimanjaro for Beltalowda
-- Core group data aggregation and event coordination

Beltalowda = Beltalowda or {}
Beltalowda.core = Beltalowda.core or {}

local BeltalowdaCore = Beltalowda.core

-- Initialize namespace (safe for multi-file use)
BeltalowdaCore.features = BeltalowdaCore.features or {}
BeltalowdaCore.state = BeltalowdaCore.state or {}
BeltalowdaCore.config = BeltalowdaCore.config or {}

-- Constants
BeltalowdaCore.constants = {}
BeltalowdaCore.constants.FEATURE_POSITIONING = "positioning"
BeltalowdaCore.constants.FEATURE_SYNERGIES = "synergies"
BeltalowdaCore.constants.FEATURE_ATTACK_TIMERS = "attackTimers"
BeltalowdaCore.constants.FEATURE_ULTIMATES = "ultimates"

-- State
BeltalowdaCore.state.groupData = {}
BeltalowdaCore.state.groupData.members = {}
BeltalowdaCore.state.groupData.resources = {}
BeltalowdaCore.state.groupData.buffs = {}
BeltalowdaCore.state.groupData.distances = {}
BeltalowdaCore.state.initialized = false

-- Feature registry - maps feature name to callbacks
BeltalowdaCore.features.registered = {}

--[[
  Register a feature to receive group data updates
  
  @param featureName string - Unique identifier for the feature (use constants)
  @param callbacks table - Table containing callback functions:
    - onGroupUpdate: function(groupData) - Called when group data changes
    - onEnable: function() - Called when feature should enable
    - onDisable: function() - Called when feature should disable
  
  Example:
    BeltalowdaCore.RegisterFeature(
      BeltalowdaCore.constants.FEATURE_POSITIONING,
      {
        onGroupUpdate = function(groupData) 
          -- Update positioning UI with groupData
        end,
        onEnable = function() 
          -- Initialize positioning feature
        end,
        onDisable = function() 
          -- Cleanup positioning feature
        end
      }
    )
]]
function BeltalowdaCore.RegisterFeature(featureName, callbacks)
  if not featureName or not callbacks then
    return false
  end
  
  BeltalowdaCore.features.registered[featureName] = {
    onGroupUpdate = callbacks.onGroupUpdate,
    onEnable = callbacks.onEnable,
    onDisable = callbacks.onDisable,
    enabled = false
  }
  
  return true
end

--[[
  Unregister a feature from receiving updates
  
  @param featureName string - Feature identifier
]]
function BeltalowdaCore.UnregisterFeature(featureName)
  if BeltalowdaCore.features.registered[featureName] then
    -- Call disable callback if registered
    local feature = BeltalowdaCore.features.registered[featureName]
    if feature.enabled and feature.onDisable then
      feature.onDisable()
    end
    
    BeltalowdaCore.features.registered[featureName] = nil
    return true
  end
  
  return false
end

--[[
  Enable a registered feature
  
  @param featureName string - Feature identifier
]]
function BeltalowdaCore.EnableFeature(featureName)
  local feature = BeltalowdaCore.features.registered[featureName]
  if not feature then
    return false
  end
  
  if not feature.enabled then
    feature.enabled = true
    if feature.onEnable then
      feature.onEnable()
    end
  end
  
  return true
end

--[[
  Disable a registered feature
  
  @param featureName string - Feature identifier
]]
function BeltalowdaCore.DisableFeature(featureName)
  local feature = BeltalowdaCore.features.registered[featureName]
  if not feature then
    return false
  end
  
  if feature.enabled then
    feature.enabled = false
    if feature.onDisable then
      feature.onDisable()
    end
  end
  
  return true
end

--[[
  Notify all registered and enabled features of group data update
  
  @param groupData table - Current group data snapshot
]]
function BeltalowdaCore.NotifyFeatures(groupData)
  for featureName, feature in pairs(BeltalowdaCore.features.registered) do
    if feature.enabled and feature.onGroupUpdate then
      feature.onGroupUpdate(groupData)
    end
  end
end

--[[
  Get current group data snapshot
  
  @return table - Current group data
]]
function BeltalowdaCore.GetGroupData()
  return BeltalowdaCore.state.groupData
end

--[[
  Initialize Core module
  
  This sets up the feature registry infrastructure but does NOT
  set up event handlers or data collection. That remains in
  BeltalowdaUtil.group for now during migration.
]]
function BeltalowdaCore.Initialize()
  if BeltalowdaCore.state.initialized then
    return
  end
  
  -- Initialize group data structure
  BeltalowdaCore.state.groupData = {
    members = {},
    resources = {},
    buffs = {},
    distances = {}
  }
  
  BeltalowdaCore.state.initialized = true
end

--[[
  Get defaults for Core module
  
  @return table - Default configuration
]]
function BeltalowdaCore.GetDefaults()
  return {
    enabled = true
  }
end
