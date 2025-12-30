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
	if Beltalowda.addOnIntegration.detector then
		Beltalowda.addOnIntegration.detector.Initialize()
	end
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
	if Beltalowda.addOnIntegration.detector then
		BeltalowdaMenu.AddMenuEntries(menu, Beltalowda.addOnIntegration.detector.GetMenu())
	end
	return menu
end

function BeltalowdaAOI.GetDefaults()
	local defaults = {}
	--defaults.mpa = BeltalowdaAOI.mpa.GetDefaults()
	if Beltalowda.addOnIntegration.detector then
		defaults.detector = Beltalowda.addOnIntegration.detector.GetDefaults()
	end
	return defaults
end
