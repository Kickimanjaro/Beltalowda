-- Beltalowda Crown
-- By @s0rdrak (PC / EU)

Beltalowda.group.crown = Beltalowda.group.crown or {}
local BeltalowdaCrown = Beltalowda.group.crown

Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaCrown.callbackName = Beltalowda.addonName .. "Crown"
BeltalowdaCrown.crownVars = nil

BeltalowdaCrown.constants = {}
BeltalowdaCrown.constants.PREFIX = "Crown"

BeltalowdaCrown.config = {}
BeltalowdaCrown.config.crowns = {}
BeltalowdaCrown.config.crowns[1] = {}
BeltalowdaCrown.config.crowns[1].dds = "EsoUI/Art/Compass/groupleader.dds"
BeltalowdaCrown.config.crowns[2] = {}
BeltalowdaCrown.config.crowns[2].dds = "Beltalowda/Art/Crowns/Pfeilweiss.dds"
BeltalowdaCrown.config.crowns[3] = {}
BeltalowdaCrown.config.crowns[3].dds = "Beltalowda/Art/Crowns/Pfeilblau.dds"
BeltalowdaCrown.config.crowns[4] = {}
BeltalowdaCrown.config.crowns[4].dds = "Beltalowda/Art/Crowns/Pfeilhellblau.dds"
BeltalowdaCrown.config.crowns[5] = {}
BeltalowdaCrown.config.crowns[5].dds = "Beltalowda/Art/Crowns/Pfeilgelb.dds"
BeltalowdaCrown.config.crowns[6] = {}
BeltalowdaCrown.config.crowns[6].dds = "Beltalowda/Art/Crowns/Pfeilhellgruen.dds"
BeltalowdaCrown.config.crowns[7] = {}
BeltalowdaCrown.config.crowns[7].dds = "Beltalowda/Art/Crowns/Pfeilrot.dds"
BeltalowdaCrown.config.crowns[8] = {}
BeltalowdaCrown.config.crowns[8].dds = "Beltalowda/Art/Crowns/Pfeilpink.dds"
BeltalowdaCrown.config.crowns[9] = {}
BeltalowdaCrown.config.crowns[9].dds = "Beltalowda/Art/Crowns/Krone.dds"
BeltalowdaCrown.config.crowns[10] = {}
BeltalowdaCrown.config.crowns[10].dds = "Beltalowda/Art/Crowns/BeltalowdaWhite.dds"

BeltalowdaCrown.state = {}

function BeltalowdaCrown.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaCrown.callbackName, BeltalowdaCrown.OnProfileChanged)
	
	-- Check if we should enable crown features based on detector settings
	-- Note: Detector is initialized early, but detector vars (user preferences) 
	-- may not be loaded yet. We check detector availability and notify user of 
	-- detected addons, but actual integration mode is applied in OnPlayerActivated
	-- where detector vars are guaranteed to be available.
	local detector = Beltalowda.addOnIntegration.detector
	if detector and detector.state and detector.state.initialized then
		local addonType = detector.constants.ADDON_TYPE_CROWN
		local detected = detector.GetDetectedAddons(addonType)
		
		if #detected > 0 then
			-- External crown addon detected - notify user
			local names = detector.GetDetectedAddonNames(addonType)
			BeltalowdaChat.SendChatMessage(
				string.format("Crown addon detected: %s", table.concat(names, ", ")),
				BeltalowdaCrown.constants.PREFIX,
				BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING
			)
		end
	else
		-- Fallback to old detection method if detector not available yet
		if QAddon ~= nil and QAddon.name == "PapaCrown" then
			BeltalowdaChat.SendChatMessage(BeltalowdaCrown.constants.PAPA_CROWN_DETECTED, BeltalowdaCrown.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
			return
		end
		if RO ~= nil and RO.name == "SanctsUltimateOrganiser" then
			BeltalowdaChat.SendChatMessage(BeltalowdaCrown.constants.SANCTS_ULTIMATE_ORGANIZER_DETECTED, BeltalowdaCrown.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
			return
		end
		if CrownOfCyrodiil ~= nil and CrownOfCyrodiil.name == "CrownOfCyrodiil" then
			BeltalowdaChat.SendChatMessage(BeltalowdaCrown.constants.CROWN_OF_CYRODIIL_DETECTED, BeltalowdaCrown.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
			return
		end
	end
	
	if BeltalowdaCrown.crownVars.enabled then
		EVENT_MANAGER:RegisterForEvent(BeltalowdaCrown.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaCrown.OnPlayerActivated)
	end
end


function BeltalowdaCrown.OnPlayerActivated()
	--d("OnPlayerActivated")
	--/script SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, 64, "Beltalowda/Art/Crowns/Pfeilpink.dds")
	
	-- Check if we should enable based on detector settings
	if not BeltalowdaCrown.ShouldEnableCrown() then
		SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER)
		return
	end
	
	if BeltalowdaCrown.crownVars.enabled and (BeltalowdaCrown.crownVars.pvponly == false or (BeltalowdaCrown.crownVars.pvponly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaCrown.crownVars.selectedMode == 1 then
			if BeltalowdaCrown.crownVars.customDDS == true then
				SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, BeltalowdaCrown.crownVars.size, BeltalowdaCrown.crownVars.customDDSPath--[[, "EsoUI/Art/Comapss/groupleader_door.dds"]])
			else
				SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, BeltalowdaCrown.crownVars.size, BeltalowdaCrown.config.crowns[BeltalowdaCrown.crownVars.selectedCrown].dds --[[, "EsoUI/Art/Comapss/groupleader_door.dds"]])
			end
		end
	else
		SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER)
	end
end

function BeltalowdaCrown.GetDefaults()
	local defaults = {}
	defaults.customDDS = false
	defaults.enabled = false
	defaults.size = 64
	defaults.pvponly = false
	defaults.selectedMode = 1
	defaults.selectedCrown = 1
	defaults.customDDSPath = "Beltalowda/Art/Crowns/pfeil_pink.dds"
	return defaults
end

function BeltalowdaCrown.SlashCmd(param)

end

--profile synchronization
function BeltalowdaCrown.OnProfileChanged(currentProfile)
	--d(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaCrown.crownVars = currentProfile.group.crown
	end
end

-- Check if crown features should be enabled based on detector settings
function BeltalowdaCrown.ShouldEnableCrown()
	local detector = Beltalowda.addOnIntegration.detector
	if detector and detector.ShouldEnableBuiltIn and detector.detectorVars then
		local addonType = detector.constants.ADDON_TYPE_CROWN
		local mode = detector.detectorVars.crownMode
		return detector.ShouldEnableBuiltIn(addonType, mode)
	end
	
	-- Default behavior if detector not available: disable if external detected
	if QAddon ~= nil and QAddon.name == "PapaCrown" then
		return false
	end
	if RO ~= nil and RO.name == "SanctsUltimateOrganiser" then
		return false
	end
	if CrownOfCyrodiil ~= nil and CrownOfCyrodiil.name == "CrownOfCyrodiil" then
		return false
	end
	
	return true
end

--Menu Interaction
function BeltalowdaCrown.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CROWN_HEADER,
			--width = "full",
			--requiresReload = true
			controls = {

				[1] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.CROWN_WARNING,
					width = "full"
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CROWN_CHK_GROUP_CROWN_ENABLED,
					getFunc = BeltalowdaCrown.GetGroupCrownState,
					setFunc = BeltalowdaCrown.SetGroupCrownState,
					--requiresReload = true
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CROWN_PVP_ONLY,
					getFunc = BeltalowdaCrown.GetCrownPvpOnly,
					setFunc = BeltalowdaCrown.SetCrownPvpOnly,
					--requiresReload = true
				},
				[4] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.CROWN_SELECTED_MODE,
					choices = BeltalowdaCrown.GetAvailableCrownModes(),
					getFunc = BeltalowdaCrown.GetSelectedCrownMode,
					setFunc = BeltalowdaCrown.SetSelectedCrownMode,
					width = "full",
					--requiresReload = true
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.CROWN_SELECTED_CROWN,
					choices = BeltalowdaCrown.GetAvailableCrowns(),
					getFunc = BeltalowdaCrown.GetSelectedCrown,
					setFunc = BeltalowdaCrown.SetSelectedCrown,
					width = "full",
					--requiresReload = true
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.CROWN_SIZE,
					min = 10,
					max = 512,
					step = 1,
					getFunc = BeltalowdaCrown.GetCrownSize,
					setFunc = BeltalowdaCrown.SetCrownSize,
					width = "full",
					default = 64,
					--requiresReload = true
				}
			}
		}
	}
	return menu
end

function BeltalowdaCrown.GetGroupCrownState()
	return BeltalowdaCrown.crownVars.enabled
end

function BeltalowdaCrown.SetGroupCrownState(value)
	BeltalowdaCrown.crownVars.enabled = value
	BeltalowdaCrown.OnPlayerActivated()
end


function BeltalowdaCrown.GetAvailableCrownModes()
	local modes = { Beltalowda.menu.constants.CROWN_MODE[1] }
	return modes
end

function BeltalowdaCrown.GetSelectedCrownMode()
	return Beltalowda.menu.constants.CROWN_MODE[BeltalowdaCrown.crownVars.selectedMode]
end

function BeltalowdaCrown.SetSelectedCrownMode(value)
	for i = 1, #Beltalowda.menu.constants.CROWN_MODE do
		if Beltalowda.menu.constants.CROWN_MODE[i] == value then
			BeltalowdaCrown.crownVars.selectedMode = i
			break
		end
	end
	BeltalowdaCrown.OnPlayerActivated()
end

function BeltalowdaCrown.GetAvailableCrowns()
	--ugly bug fix cause through menu entry in libaddonmenu... wtf?
	if BeltalowdaCrown.crownVars == nil then
		BeltalowdaCrown.crownVars = Beltalowda.profile.GetSelectedProfile().group.crown
	end
	if BeltalowdaCrown.crownVars.selectedMode == 1 then
		local crowns = { BeltalowdaCrown.config.crowns[1].name, 
						 BeltalowdaCrown.config.crowns[2].name,
						 BeltalowdaCrown.config.crowns[3].name,
						 BeltalowdaCrown.config.crowns[4].name,
						 BeltalowdaCrown.config.crowns[5].name,
						 BeltalowdaCrown.config.crowns[6].name,
						 BeltalowdaCrown.config.crowns[7].name,
						 BeltalowdaCrown.config.crowns[8].name,
						 BeltalowdaCrown.config.crowns[9].name,
						 BeltalowdaCrown.config.crowns[10].name
		}
		return crowns
	else
		BeltalowdaChat.SendChatMessage("Invalid Crown Mode", BeltalowdaCrown.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	end
end

function BeltalowdaCrown.GetSelectedCrown()
	return BeltalowdaCrown.config.crowns[BeltalowdaCrown.crownVars.selectedCrown].name
end

function BeltalowdaCrown.SetSelectedCrown(value)
	for i = 1, #BeltalowdaCrown.config.crowns do
		if BeltalowdaCrown.config.crowns[i].name == value then
			BeltalowdaCrown.crownVars.selectedCrown = i
			break
		end
	end
	BeltalowdaCrown.OnPlayerActivated()
end

function BeltalowdaCrown.GetCrownSize()
	return BeltalowdaCrown.crownVars.size
end

function BeltalowdaCrown.SetCrownSize(value)
	BeltalowdaCrown.crownVars.size = value
	BeltalowdaCrown.OnPlayerActivated()
end

function BeltalowdaCrown.GetCrownPvpOnly()
	return BeltalowdaCrown.crownVars.pvponly
end

function BeltalowdaCrown.SetCrownPvpOnly(value)
	BeltalowdaCrown.crownVars.pvponly = value
	BeltalowdaCrown.OnPlayerActivated()
end
