-- RdK AddOn Integration
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}

Beltalowda.addOnIntegration = Beltalowda.addOnIntegration or {}

local BeltalowdaAOI = Beltalowda.addOnIntegration
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaAOI.Initialize()
	--Not running Miats PvP Alerts AddOn Integration anymore as it did not really
	--fix the bug causing frame drops. Therefore, this module isn't active in any way anymore.
	--BeltalowdaAOI.mpa.Initialize()
	BeltalowdaAOI.detector.Initialize()
end

function BeltalowdaAOI.SlashCmd(param)
	if param ~= nil then

	end
end

function BeltalowdaAOI.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.ADDON_INTEGRATION_HEADER,
			width = "full",
		}
	}
	--BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaAOI.mpa.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaAOI.detector.GetMenu())
	return menu
end

function BeltalowdaAOI.GetDefaults()
	local defaults = {}
	--defaults.mpa = BeltalowdaAOI.mpa.GetDefaults()
	defaults.detector = BeltalowdaAOI.detector.GetDefaults()
	return defaults
end
