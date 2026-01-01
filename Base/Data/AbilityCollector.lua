-- Beltalowda Ability Collector
-- Tracks player abilities and active effects

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.abilities = Beltalowda.data.abilities or {}

-- Create local alias
local AbilityCollector = Beltalowda.data.abilities

-- Module state
AbilityCollector.state = {
    initialized = false,
    abilities = {},  -- Skill bar abilities (10 total: 5 per bar)
    activeEffects = {}  -- Active buffs/debuffs
}

--[[
    Initialize the ability collector
]]--
function AbilityCollector.Initialize()
    if AbilityCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] AbilityCollector: Initializing")
    
    -- Register with data collector coordinator
    if Beltalowda.data.collector then
        Beltalowda.data.collector.RegisterCollector("abilities", AbilityCollector)
    end
    
    -- Stub: Event registration will be added in Phase 1 (basic) and Phase 6 (full)
    -- EVENT_ACTION_SLOT_UPDATED (skill bar changes)
    -- EVENT_EFFECT_CHANGED (buff/debuff application)
    -- EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED (visual effects)
    
    AbilityCollector.state.initialized = true
end

--[[
    Get current ability data
    @return table - Current abilities and effects
]]--
function AbilityCollector.GetAbilities()
    return {
        abilities = AbilityCollector.state.abilities,
        activeEffects = AbilityCollector.state.activeEffects
    }
end
