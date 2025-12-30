-- Beltalowda Cyrodiil Log
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.cl = BeltalowdaTB.cl or {}
local BeltalowdaCL = BeltalowdaTB.cl
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.cyrodiil = BeltalowdaUtil.cyrodiil or {}
local BeltalowdaCyro = BeltalowdaUtil.cyrodiil
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
BeltalowdaUtil.allianceColor = BeltalowdaUtil.allianceColor or {}
local BeltalowdaAC = BeltalowdaUtil.allianceColor
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.group = BeltalowdaUtil.group
local BeltalowdaGroup = BeltalowdaUtil.group

BeltalowdaCL.callbackName = Beltalowda.addonName .. "CyrodiilLog"

BeltalowdaCL.config = {}

BeltalowdaCL.constants = BeltalowdaCL.constants or {}
BeltalowdaCL.constants.PREFIX = "CL"

BeltalowdaCL.state = {}
BeltalowdaCL.state.initialized = false
BeltalowdaCL.state.registredConsumers = false
BeltalowdaCL.state.registredCyrodiilConsumers = false
BeltalowdaCL.state.language = ""
BeltalowdaCL.state.flipMessagePrevention = {}

function BeltalowdaCL.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaCL.callbackName, BeltalowdaCL.OnProfileChanged)
	BeltalowdaCL.state.language = GetCVar("Language.2")
	BeltalowdaCL.state.initialized = true
	BeltalowdaCL.SetEnabled(BeltalowdaCL.clVars.enabled)
end

function BeltalowdaCL.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.guildClaimEnalbled = false
	defaults.guildLostEnabled = false
	defaults.statusUAEnabled = false
	defaults.statusUALostEnabled = false
	defaults.keepAllianceChangedEnabled = false
	defaults.tickDefense = true
	defaults.tickOffense = true
	defaults.scrollsEnabled = true
	defaults.emperorEnabled = true
	defaults.questEnabled = true
	defaults.battlegroundEnabled = true
	defaults.daedricArtifactEnabled = true
	return defaults
end

function BeltalowdaCL.SetEnabled(value)
	if BeltalowdaCL.state.initialized == true and value ~= nil then
		BeltalowdaCL.clVars.enabled = value
		if value == true then
			if BeltalowdaCL.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaCL.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaCL.OnPlayerActivated)
			end
			BeltalowdaCL.state.registredConsumers = true
		else
			if BeltalowdaCL.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaCL.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaCL.state.registredConsumers = false
		end
		BeltalowdaCL.OnPlayerActivated()
	end
end

function BeltalowdaCL.Print(message)
	if message ~= nil then
		--d(message)
		--message = string.format("|c%s%s|r", BeltalowdaChat.GetBodyColorHex(), message)
		BeltalowdaChat.SendChatMessage(message, BeltalowdaCL.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL)
	end
end

--callbacks
function BeltalowdaCL.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaCL.clVars = currentProfile.toolbox.cl
		BeltalowdaCL.SetEnabled(BeltalowdaCL.clVars.enabled)
	end
end

function BeltalowdaCL.OnPlayerActivated(eventCode, initial)
	if BeltalowdaCL.clVars.enabled == true and BeltalowdaUtil.IsInCyrodiil() == true then
		if BeltalowdaCL.state.registredCyrodiilConsumers == false then
			BeltalowdaCyro.AddConsumer(BeltalowdaCL.callbackName, nil, BeltalowdaCL.HandleMessage)
			BeltalowdaCL.state.registredCyrodiilConsumers = true
		end
	else
		if BeltalowdaCL.state.registredCyrodiilConsumers == true then
			BeltalowdaCyro.RemoveConsumer(BeltalowdaCL.callbackName)
			BeltalowdaCL.state.registredCyrodiilConsumers = false
		end
	end
end

function BeltalowdaCL.HandleMessage(eventData)
	--d(eventData)
	local bodyColor = BeltalowdaChat.GetBodyColorHex()
	if eventData.event == BeltalowdaCyro.constants.events.GUILD_CLAIM and BeltalowdaCL.clVars.guildClaimEnalbled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_CLAIM, BeltalowdaAC.DyeAllianceString(eventData.playerName, eventData.alliance), bodyColor,  BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance), bodyColor,  BeltalowdaAC.DyeAllianceString(eventData.guildName, eventData.alliance)))
	elseif eventData.event == BeltalowdaCyro.constants.events.GUILD_LOST and BeltalowdaCL.clVars.guildLostEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_LOST, BeltalowdaAC.DyeAllianceString(eventData.guildName, eventData.previousOwningAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.previousOwningAlliance)))
	elseif eventData.event == BeltalowdaCyro.constants.events.STATUS_UA and BeltalowdaCL.clVars.statusUAEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.STATUS_UA_LOST and BeltalowdaCL.clVars.statusUALostEnabled == true then
		if BeltalowdaCL.state.flipMessagePrevention[eventData.keepId] == nil or BeltalowdaCL.state.flipMessagePrevention[eventData.keepId] + 1000 < GetGameTimeMilliseconds() then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA_LOST, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance), bodyColor))
		end
	elseif eventData.event == BeltalowdaCyro.constants.events.KEEP_OWNER_CHANGED and BeltalowdaCL.clVars.keepAllianceChangedEnabled == true then
		local alliance = GetAllianceName(eventData.alliance)
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_KEEP_OWNER_CHANGED, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance), bodyColor, BeltalowdaAC.DyeAllianceString(alliance, eventData.alliance)))
		BeltalowdaCL.state.flipMessagePrevention[eventData.keepId] = GetGameTimeMilliseconds()
	elseif eventData.event == BeltalowdaCyro.constants.events.TICK_DEFENSE and BeltalowdaCL.clVars.tickDefense == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_TICK_DEFENSE, bodyColor, eventData.apGained, bodyColor, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance)))
	elseif eventData.event == BeltalowdaCyro.constants.events.TICK_OFFENSE and BeltalowdaCL.clVars.tickOffense == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_TICK_OFFENSE, bodyColor, eventData.apGained, bodyColor, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.alliance)))
	elseif eventData.event == BeltalowdaCyro.constants.events.SCROLL_PICKED_UP and BeltalowdaCL.clVars.scrollsEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		if BeltalowdaCL.state.language == "de" then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_PICKED_UP, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor))
		else
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_PICKED_UP, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance)))
		end
	elseif eventData.event == BeltalowdaCyro.constants.events.SCROLL_DROPPED and BeltalowdaCL.clVars.scrollsEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		if BeltalowdaCL.state.language == "de" then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_DROPPED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor))
		else
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_DROPPED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance)))
		end
	elseif eventData.event == BeltalowdaCyro.constants.events.SCROLL_RETURNED and BeltalowdaCL.clVars.scrollsEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		if BeltalowdaCL.state.language == "de" then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor))
		else
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance)))
		end
	elseif eventData.event == BeltalowdaCyro.constants.events.SCROLL_RETURNED_BY_TIMER and BeltalowdaCL.clVars.scrollsEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED_BY_TIMER, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.SCROLL_CAPTURED and BeltalowdaCL.clVars.scrollsEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		if BeltalowdaCL.state.language == "de" then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_CAPTURED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.playerAlliance), bodyColor))
		else
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_SCROLL_CAPTURED, BeltalowdaAC.DyeAllianceString(name, eventData.playerAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.scroll, eventData.scrollAlliance), bodyColor, BeltalowdaAC.DyeAllianceString(eventData.keepName, eventData.playerAlliance)))
		end
	elseif eventData.event == BeltalowdaCyro.constants.events.EMPEROR_CORONATED and BeltalowdaCL.clVars.emperorEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_EMPEROR_CORONATED, BeltalowdaAC.DyeAllianceString(name, eventData.alliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.EMPEROR_DEPOSED and BeltalowdaCL.clVars.emperorEnabled == true then
		local name = BeltalowdaGroup.GetNameFromDisplayCharName(eventData.charName, eventData.displayName)
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_EMPEROR_DEPOSED, BeltalowdaAC.DyeAllianceString(name, eventData.alliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.QUEST_REWARD and BeltalowdaCL.clVars.questEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_QUEST_REWARD, bodyColor, eventData.apGained, bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.BATTLEGROUND_REWARD and BeltalowdaCL.clVars.battlegroundEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_REWARD, bodyColor, eventData.apGained, bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.BATTLEGROUND_MEDAL_REWARD and BeltalowdaCL.clVars.battlegroundEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_MEDAL_REWARD, bodyColor, eventData.apGained, bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_SPAWNED and BeltalowdaCL.clVars.daedricArtifactEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_SPAWNED, bodyColor, eventData.objectiveName))
	elseif eventData.event == BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_REVEALED and BeltalowdaCL.clVars.daedricArtifactEnabled == true then
			BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_REVEALED, bodyColor, eventData.objectiveName))
	elseif eventData.event == BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DROPPED and BeltalowdaCL.clVars.daedricArtifactEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DROPPED, bodyColor, eventData.objectiveName, BeltalowdaAC.DyeAllianceString(GetAllianceName(eventData.alliance), eventData.alliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_TAKEN and BeltalowdaCL.clVars.daedricArtifactEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_TAKEN, bodyColor, eventData.objectiveName, BeltalowdaAC.DyeAllianceString(GetAllianceName(eventData.alliance), eventData.alliance), bodyColor))
	elseif eventData.event == BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DESPAWNED and BeltalowdaCL.clVars.daedricArtifactEnabled == true then
		BeltalowdaCL.Print(string.format(BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DESPAWNED, bodyColor, eventData.objectiveName))
	end
end

--menu interaction
function BeltalowdaCL.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CL_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_ENABLED,
					getFunc = BeltalowdaCL.GetClEnabled,
					setFunc = BeltalowdaCL.SetClEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_GUILD_CLAIM_ENABLED,
					getFunc = BeltalowdaCL.GetClGuildClaimEnabled,
					setFunc = BeltalowdaCL.SetClGuildClaimEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_GUILD_LOST_ENABLED,
					getFunc = BeltalowdaCL.GetClGuildLostEnabled,
					setFunc = BeltalowdaCL.SetClGuildLostEnabled
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_UA_ENABLED,
					getFunc = BeltalowdaCL.GetClStatusUAEnabled,
					setFunc = BeltalowdaCL.SetClStatusUAEnabled
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_UA_LOST_ENABLED,
					getFunc = BeltalowdaCL.GetClStatusUALostEnabled,
					setFunc = BeltalowdaCL.SetClStatusUALostEnabled
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_KEEP_ALLIANCE_CHANGED_ENABLED,
					getFunc = BeltalowdaCL.GetClKeepAllianceChangedEnabled,
					setFunc = BeltalowdaCL.SetClKeepAllianceChangedEnabled
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_TICK_DEFENSE,
					getFunc = BeltalowdaCL.GetClTickDefenseEnabled,
					setFunc = BeltalowdaCL.SetClTickDefenseEnabled
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_TICK_OFFENSE,
					getFunc = BeltalowdaCL.GetClTickOffenseEnabled,
					setFunc = BeltalowdaCL.SetClTickOffenseEnabled
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_SCROLL_NOTIFICATIONS,
					getFunc = BeltalowdaCL.GetClScrollsEnabled,
					setFunc = BeltalowdaCL.SetClScrollsEnabled
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_EMPEROR_ENABLED,
					getFunc = BeltalowdaCL.GetClEmperorEnabled,
					setFunc = BeltalowdaCL.SetClEmperorEnabled
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_QUEST_ENABLED,
					getFunc = BeltalowdaCL.GetClQuestEnabled,
					setFunc = BeltalowdaCL.SetClQuestEnabled
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_BATTLEGROUND_ENABLED,
					getFunc = BeltalowdaCL.GetClBattlegroundEnabled,
					setFunc = BeltalowdaCL.SetClBattlegroundEnabled
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CL_DAEDRIC_ARTIFACT_ENABLED,
					getFunc = BeltalowdaCL.GetClDaedricArtifactEnabled,
					setFunc = BeltalowdaCL.SetClDaedricArtifactEnabled
				},
			}
		}
	}
	return menu
end

function BeltalowdaCL.GetClEnabled()
	return BeltalowdaCL.clVars.enabled
end

function BeltalowdaCL.SetClEnabled(value)
	BeltalowdaCL.SetEnabled(value)
end

function BeltalowdaCL.GetClGuildClaimEnabled()
	return BeltalowdaCL.clVars.guildClaimEnalbled
end

function BeltalowdaCL.SetClGuildClaimEnabled(value)
	BeltalowdaCL.clVars.guildClaimEnalbled = value
end

function BeltalowdaCL.GetClGuildLostEnabled()
	return BeltalowdaCL.clVars.guildLostEnabled
end

function BeltalowdaCL.SetClGuildLostEnabled(value)
	BeltalowdaCL.clVars.guildLostEnabled = value
end

function BeltalowdaCL.GetClStatusUAEnabled()
	return BeltalowdaCL.clVars.statusUAEnabled
end

function BeltalowdaCL.SetClStatusUAEnabled(value)
	BeltalowdaCL.clVars.statusUAEnabled = value
end

function BeltalowdaCL.GetClStatusUALostEnabled()
	return BeltalowdaCL.clVars.statusUALostEnabled
end

function BeltalowdaCL.SetClStatusUALostEnabled(value)
	BeltalowdaCL.clVars.statusUALostEnabled = value
end

function BeltalowdaCL.GetClKeepAllianceChangedEnabled()
	return BeltalowdaCL.clVars.keepAllianceChangedEnabled
end

function BeltalowdaCL.SetClKeepAllianceChangedEnabled(value)
	BeltalowdaCL.clVars.keepAllianceChangedEnabled = value
end

function BeltalowdaCL.GetClTickDefenseEnabled()
	return BeltalowdaCL.clVars.tickDefense
end

function BeltalowdaCL.SetClTickDefenseEnabled(value)
	BeltalowdaCL.clVars.tickDefense = value
end

function BeltalowdaCL.GetClTickOffenseEnabled()
	return BeltalowdaCL.clVars.tickOffense
end

function BeltalowdaCL.SetClTickOffenseEnabled(value)
	BeltalowdaCL.clVars.tickOffense = value
end

function BeltalowdaCL.GetClScrollsEnabled()
	return BeltalowdaCL.clVars.scrollsEnabled
end

function BeltalowdaCL.SetClScrollsEnabled(value)
	BeltalowdaCL.clVars.scrollsEnabled = value
end

function BeltalowdaCL.GetClEmperorEnabled()
	return BeltalowdaCL.clVars.emperorEnabled
end

function BeltalowdaCL.SetClEmperorEnabled(value)
	BeltalowdaCL.clVars.emperorEnabled = value
end

function BeltalowdaCL.GetClQuestEnabled()
	return BeltalowdaCL.clVars.questEnabled
end

function BeltalowdaCL.SetClQuestEnabled(value)
	BeltalowdaCL.clVars.questEnabled = value
end

function BeltalowdaCL.GetClBattlegroundEnabled()
	return BeltalowdaCL.clVars.battlegroundEnabled
end

function BeltalowdaCL.SetClBattlegroundEnabled(value)
	BeltalowdaCL.clVars.battlegroundEnabled = value
end

function BeltalowdaCL.GetClDaedricArtifactEnabled()
	return BeltalowdaCL.clVars.daedricArtifactEnabled
end

function BeltalowdaCL.SetClDaedricArtifactEnabled(value)
	BeltalowdaCL.clVars.daedricArtifactEnabled = value
end