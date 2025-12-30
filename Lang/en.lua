--[[
    Beltalowda - English Language File
    Author: @Kickimanjaro
    
    This file defines localized strings for the addon using ESO's string ID system.
    Strings are registered with ZO_CreateStringId() and can be retrieved using GetString().
    
    Usage in code:
        d(GetString(SI_BELTALOWDA_LOADED))  -- Displays the loaded message
    
    These strings are used in:
        - Beltalowda.lua: SI_BELTALOWDA_LOADED for addon initialization message
        - Beltalowda.lua: SI_BELTALOWDA_PLAYER_ACTIVATED for player activation message
]]--

local strings = {
    SI_BELTALOWDA_NAME = "Beltalowda",
    SI_BELTALOWDA_LOADED = "Beltalowda v1.0.0 loaded successfully",
    SI_BELTALOWDA_PLAYER_ACTIVATED = "Beltalowda: Player activated",
}

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
end
