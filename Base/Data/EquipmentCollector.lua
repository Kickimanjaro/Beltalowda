-- Beltalowda Equipment Collector
-- Tracks equipped gear using LibSets

-- Initialize namespaces
Beltalowda = Beltalowda or {}
Beltalowda.data = Beltalowda.data or {}
Beltalowda.data.equipment = Beltalowda.data.equipment or {}

-- Create local alias
local EquipmentCollector = Beltalowda.data.equipment

-- Module state
EquipmentCollector.state = {
    initialized = false,
    equippedSets = {},  -- Set IDs and piece counts
    equipmentSlots = {}  -- Individual slot data
}

-- Equipment slot constants (ESO game constants)
-- These are defined by the ESO API
EquipmentCollector.SLOTS = {
    0,  -- EQUIP_SLOT_HEAD
    1,  -- EQUIP_SLOT_SHOULDERS
    2,  -- EQUIP_SLOT_CHEST
    3,  -- EQUIP_SLOT_WAIST
    4,  -- EQUIP_SLOT_HAND
    5,  -- EQUIP_SLOT_LEGS
    6,  -- EQUIP_SLOT_FEET
    7,  -- EQUIP_SLOT_NECK
    8,  -- EQUIP_SLOT_RING1
    9,  -- EQUIP_SLOT_RING2
    10, -- EQUIP_SLOT_MAIN_HAND
    11, -- EQUIP_SLOT_OFF_HAND
    12, -- EQUIP_SLOT_BACKUP_MAIN
    13  -- EQUIP_SLOT_BACKUP_OFF
}

--[[
    Initialize the equipment collector
]]--
function EquipmentCollector.Initialize()
    if EquipmentCollector.state.initialized then
        return
    end
    
    d("[Beltalowda] EquipmentCollector: Initializing")
    
    -- Check if LibSets is available
    if not LibSets then
        d("[Beltalowda] EquipmentCollector: LibSets not available. Equipment tracking disabled.")
        return
    end
    
    -- Register with data collector coordinator
    if Beltalowda.data.collector then
        Beltalowda.data.collector.RegisterCollector("equipment", EquipmentCollector)
    end
    
    -- Stub: Event registration and scanning will be added in Phase 4
    -- EVENT_INVENTORY_SINGLE_SLOT_UPDATE (gear changes)
    -- EVENT_EFFECT_CHANGED (set proc effects)
    
    EquipmentCollector.state.initialized = true
end

--[[
    Get equipped sets
    @return table - Equipped sets and piece counts
]]--
function EquipmentCollector.GetEquippedSets()
    return EquipmentCollector.state.equippedSets
end

--[[
    Get set piece count
    @param setId number - The set ID
    @return number - Number of pieces equipped
]]--
function EquipmentCollector.GetSetPieceCount(setId)
    return EquipmentCollector.state.equippedSets[setId] or 0
end

--[[
    Check if a set is active
    @param setId number - The set ID
    @param requiredPieces number - Required pieces (default: 5)
    @return boolean - True if set has enough pieces
]]--
function EquipmentCollector.IsSetActive(setId, requiredPieces)
    requiredPieces = requiredPieces or 5
    return EquipmentCollector.GetSetPieceCount(setId) >= requiredPieces
end
