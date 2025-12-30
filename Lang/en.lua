--[[
    Beltalowda - English Language File
    Author: @Kickimanjaro
]]--

local strings = {
    SI_BELTALOWDA_NAME = "Beltalowda",
    SI_BELTALOWDA_LOADED = "Beltalowda loaded successfully",
    SI_BELTALOWDA_PLAYER_ACTIVATED = "Player activated",
}

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end
