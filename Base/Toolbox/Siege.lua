-- Beltalowda Siege
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.siege = BeltalowdaTB.siege or {}
local BeltalowdaSiege = BeltalowdaTB.siege

BeltalowdaSiege.constants = BeltalowdaSiege.constants or {}

function BeltalowdaSiege.Initialize()
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_TOGGLE_SIEGE_CAMERA", BeltalowdaSiege.constants.TOGGLE_SIEGE)
end

function BeltalowdaSiege.GetDefaults()
	return nil
end

function BeltalowdaSiege.ToggleCamera()
	local siegeWeaponCamera = GetSetting(SETTING_TYPE_CAMERA, CAMERA_SETTING_THIRD_PERSON_SIEGE_WEAPONRY)
	if siegeWeaponCamera == "1" then
		siegeWeaponCamera = "0"
	else
		siegeWeaponCamera = "1"
	end
    SetSetting(SETTING_TYPE_CAMERA, CAMERA_SETTING_THIRD_PERSON_SIEGE_WEAPONRY, siegeWeaponCamera, 1)
	--d(siegeWeaponCamera)
end

--menu interactions
function BeltalowdaSiege.GetMenu()
	return nil
end