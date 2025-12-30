-- Beltalowda Class Role
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.classRole = Beltalowda.classRole or {}
local BeltalowdaCR = Beltalowda.classRole
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

function BeltalowdaCR.Initialize()
	BeltalowdaCR.bg.tpHeal.Initialize()
end

function BeltalowdaCR.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.CR_HEADER,
			width = "full",
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaCR.bg.tpHeal.GetMenu())
	return menu
end

function BeltalowdaCR.GetDefaults()
	local defaults = {}
	defaults.bg = {}
	defaults.bg.tpHeal = BeltalowdaCR.bg.tpHeal.GetDefaults()
	return defaults
end