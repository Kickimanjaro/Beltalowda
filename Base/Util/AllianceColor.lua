-- Beltalowda Alliance Color
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.allianceColor = BeltalowdaUtil.allianceColor or {}
local BeltalowdaAC = BeltalowdaUtil.allianceColor
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math

BeltalowdaAC.callbackName = Beltalowda.addonName .. "UtilAllianceColor"

BeltalowdaAC.config = {}

BeltalowdaAC.state = {}
BeltalowdaAC.state.initialized = false
BeltalowdaAC.state.adColor = "FFFFFF"
BeltalowdaAC.state.epColor = "FFFFFF"
BeltalowdaAC.state.dcColor = "FFFFFF"
BeltalowdaAC.state.noAllianceColor = "FFFFFF"

BeltalowdaAC.constants = BeltalowdaAC.constants or {}

function BeltalowdaAC.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaAC.callbackName, BeltalowdaAC.OnProfileChanged)
	
	BeltalowdaAC.UpdateColors()
end

function BeltalowdaAC.GetDefaults()
	local defaults = {}
	defaults.ad = {}
	defaults.ad.r = 0.734375
	defaults.ad.g = 0.64453125
	defaults.ad.b = 0.27734375
	defaults.ep = {}
	defaults.ep.r = 0.8671875
	defaults.ep.g = 0.35546875
	defaults.ep.b = 0.3046875
	defaults.dc = {}
	defaults.dc.r = 0.30859375
	defaults.dc.g = 0.50390625
	defaults.dc.b = 0.73828125
	defaults.noAlliance = {}
	defaults.noAlliance.r = 1
	defaults.noAlliance.g = 1
	defaults.noAlliance.b = 1
	return defaults
end

function BeltalowdaAC.UpdateColors()
	BeltalowdaAC.state.adColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ad.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ad.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ad.b))
	BeltalowdaAC.state.epColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ep.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ep.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.ep.b))
	BeltalowdaAC.state.dcColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.dc.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.dc.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.dc.b))
	BeltalowdaAC.state.noAllianceColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.noAlliance.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.noAlliance.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaAC.acVars.noAlliance.b))
end

function BeltalowdaAC.GetColorForAlliance(alliance)
	if alliance == ALLIANCE_ALDMERI_DOMINION then
		return BeltalowdaAC.acVars.ad
	elseif alliance == ALLIANCE_EBONHEART_PACT then
		return BeltalowdaAC.acVars.ep
	elseif alliance == ALLIANCE_DAGGERFALL_COVENANT then
		return BeltalowdaAC.acVars.dc
	else
		return BeltalowdaAC.acVars.noAlliance
	end
end

function BeltalowdaAC.GetHexColorForAlliance(alliance)
	if alliance == ALLIANCE_ALDMERI_DOMINION then
		return BeltalowdaAC.state.adColor
	elseif alliance == ALLIANCE_EBONHEART_PACT then
		return BeltalowdaAC.state.epColor
	elseif alliance == ALLIANCE_DAGGERFALL_COVENANT then
		return BeltalowdaAC.state.dcColor
	else
		return BeltalowdaAC.state.noAllianceColor
	end
end

function BeltalowdaAC.GetNoAllianceColor()
	return BeltalowdaAC.acVars.noAlliance
end

function BeltalowdaAC.GetNoAllianceHexColor()
	return BeltalowdaAC.state.noAllianceColor
end

function BeltalowdaAC.DyeAllianceString(message, alliance)
	if message ~= nil and alliance ~= nil then
		return string.format("|c%s%s|r", BeltalowdaAC.GetHexColorForAlliance(alliance), message)
	end
	return nil
end

--callbacks
function BeltalowdaAC.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaAC.acVars = currentProfile.util.allianceColor
		BeltalowdaAC.UpdateColors()
	end
end

--menu interaction
function BeltalowdaAC.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.AC_HEADER,
			controls = {
				[1] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.AC_DC_COLOR,
					getFunc = BeltalowdaAC.GetAcDCColor,
					setFunc = BeltalowdaAC.SetAcDCColor,
					width = "full"
				},
				[2] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.AC_EP_COLOR,
					getFunc = BeltalowdaAC.GetAcEPColor,
					setFunc = BeltalowdaAC.SetAcEPColor,
					width = "full"
				},
				[3] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.AC_AD_COLOR,
					getFunc = BeltalowdaAC.GetAcADColor,
					setFunc = BeltalowdaAC.SetAcADColor,
					width = "full"
				},
				[4] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.AC_NO_ALLIANCE_COLOR,
					getFunc = BeltalowdaAC.GetAcNoAllianceColor,
					setFunc = BeltalowdaAC.SetAcNoAllianceColor,
					width = "full"
				}
			}
		}
	}
	return menu
end

function BeltalowdaAC.GetAcADColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAC.acVars.ad)
end

function BeltalowdaAC.SetAcADColor(r, g, b)
	BeltalowdaAC.acVars.ad = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAC.UpdateColors()
end

function BeltalowdaAC.GetAcEPColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAC.acVars.ep)
end

function BeltalowdaAC.SetAcEPColor(r, g, b)
	BeltalowdaAC.acVars.ep = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAC.UpdateColors()
end

function BeltalowdaAC.GetAcDCColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAC.acVars.dc)
end

function BeltalowdaAC.SetAcDCColor(r, g, b)
	BeltalowdaAC.acVars.dc = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAC.UpdateColors()
end

function BeltalowdaAC.GetAcNoAllianceColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaAC.acVars.noAlliance)
end

function BeltalowdaAC.SetAcNoAllianceColor(r, g, b)
	BeltalowdaAC.acVars.noAlliance = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaAC.UpdateColors()
end