-- Beltalowda Compass
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}

Beltalowda.compass = Beltalowda.compass or {}

local BeltalowdaCompass = Beltalowda.compass

Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaCompass.Initialize()
	BeltalowdaCompass.yacs.Initialize()
	BeltalowdaCompass.sc.Initialize()
end

function BeltalowdaCompass.SlashCmd(param)

end

function BeltalowdaCompass.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.COMPASS_HEADER,
			width = "full",
		},
	}
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaCompass.yacs.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaCompass.sc.GetMenu())
	return menu
end

function BeltalowdaCompass.GetDefaults()
	local defaults = {}
	defaults.yacs = BeltalowdaCompass.yacs.GetDefaults()
	defaults.sc = BeltalowdaCompass.sc.GetDefaults()
	return defaults
end