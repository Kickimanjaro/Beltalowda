--[[
    Beltalowda - English Language File
    Author: @Kickimanjaro
]]--

local strings = {
    SI_BELTALOWDA_NAME = "Beltalowda",
    SI_BELTALOWDA_LOADED = "Beltalowda v1.0.0 loaded successfully",
    SI_BELTALOWDA_PLAYER_ACTIVATED = "Beltalowda: Player activated",
}

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
end
