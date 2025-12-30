-- Beltalowda Auto Invite
-- By @s0rdrak (PC / EU)

Beltalowda.group.ai = Beltalowda.group.ai or {}
local BeltalowdaAI = Beltalowda.group.ai
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

local wm = WINDOW_MANAGER

BeltalowdaAI.callbackName = Beltalowda.addonName .. "AutoInvite"

BeltalowdaAI.constants = BeltalowdaAI.constants or {}
BeltalowdaAI.constants.BODY_CONTROL_NAME = "Beltalowda.group.ai.AutoInviteControl"
BeltalowdaAI.constants.RESTRICTIONS_NONE = 1
BeltalowdaAI.constants.RESTRICTIONS_GUILD = 2
BeltalowdaAI.constants.RESTRICTIONS_GUILD_FRIEND = 3
BeltalowdaAI.constants.RESTRICTIONS_FRIEND = 4
BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD = 5
BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD_FRIEND = 6
BeltalowdaAI.constants.RESTRICTIONS = {}
BeltalowdaAI.constants.PREFIX = "AI"
BeltalowdaAI.constants.references = BeltalowdaAI.constants.references or {}
BeltalowdaAI.constants.references.AI_ENABLED_CHECKBOX = "Beltalowda.menu.AIEnabledCheckbox"
BeltalowdaAI.constants.references.AI_INVITE_TEXTBOX = "Beltalowda.menu.AIInviteStringTextbox"

BeltalowdaAI.config = BeltalowdaAI.config or {}
BeltalowdaAI.config.font = "$(BOLD_FONT)|$(KB_20)soft-shadow-thick"

BeltalowdaAI.state = {}
BeltalowdaAI.state.enabled = false
BeltalowdaAI.state.isLeader = false
BeltalowdaAI.state.previousStateRunning = false
BeltalowdaAI.state.offliner = {}

BeltalowdaAI.aiVars = nil

BeltalowdaAI.slashCmd = "/ai"


function BeltalowdaAI.Initialize()
	--vars
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaAI.callbackName, BeltalowdaAI.OnProfileChanged)
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_NONE] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_NONE
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_GUILD] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_GUILD
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_GUILD_FRIEND] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_GUILD_FRIEND
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_FRIEND] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_FRIEND
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD
	BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD_FRIEND] = Beltalowda.menu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD_FRIEND
	
	ZO_CreateStringId("SI_BINDING_NAME_RDKGTOOL_TOGGLE_AI", BeltalowdaAI.constants.TOGGLE_AI)
	
	--UI
	
	BeltalowdaAI.groupFragement = ZO_FadeSceneFragment:New(Beltalowda_AutoInvite)
	local data =
		{
			name = BeltalowdaAI.constants.AI_MENU_NAME,
			categoryFragment = BeltalowdaAI.groupFragement,
			normalIcon = "EsoUI/Art/Guild/tabIcon_history_up.dds",
			pressedIcon = "EsoUI/Art/Guild/tabIcon_history_down.dds",
			mouseoverIcon = "EsoUI/Art/Guild/tabIcon_history_over.dds",
			priority = 500
		}
		
		
	
	GROUP_MENU_KEYBOARD:AddCategory(data)

	BeltalowdaAI.groupFragement.bodyControl = wm:CreateControl(BeltalowdaAI.constants.BODY_CONTROL_NAME, Beltalowda_AutoInvite, CT_CONTROL)
	BeltalowdaAI.groupFragement.bodyControl:SetAnchor(TOPLEFT, ZO_GroupList, TOPLEFT, 0, 0)

	
	local checkbox = {}
	checkbox.width = 600
	checkbox.height = 26
	checkbox.isEnabled = true
	checkbox.isChecked = BeltalowdaAI.state.enabled
	checkbox.text = BeltalowdaAI.constants.AI_ENABLED
	checkbox.OnCheckChanged = BeltalowdaAI.OnCheckChanged
	
	BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox = BeltalowdaUtil.ui.CreateCheckBox(BeltalowdaAI.groupFragement.bodyControl, checkbox, nil)
	BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox:SetAnchor(TOPLEFT, BeltalowdaAI.groupFragement.bodyControl, TOPLEFT, 0, 0)
	
	BeltalowdaAI.groupFragement.bodyControl.inviteControl = wm:CreateControl(nil, BeltalowdaAI.groupFragement.bodyControl, CT_CONTROL)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl:SetDimensions(600,26)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl:SetAnchor(TOPLEFT, BeltalowdaAI.groupFragement.bodyControl, TOPLEFT, 0, 30)
	
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.label = wm:CreateControl(nil, BeltalowdaAI.groupFragement.bodyControl.inviteControl, CT_LABEL)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.label:SetDimensions(400,26)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.label:SetAnchor(TOPLEFT, BeltalowdaAI.groupFragement.bodyControl.inviteControl, TOPLEFT, 0, 0)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.label:SetFont(BeltalowdaAI.config.font)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.label:SetText(BeltalowdaAI.constants.AI_INVITE_TEXT)
	
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.bd = wm:CreateControlFromVirtual(nil, BeltalowdaAI.groupFragement.bodyControl.inviteControl, "ZO_EditBackdrop")
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox = wm:CreateControlFromVirtual(nil, BeltalowdaAI.groupFragement.bodyControl.inviteControl.bd, "ZO_DefaultEditForBackdrop")

	BeltalowdaAI.groupFragement.bodyControl.inviteControl.bd:SetAnchor(TOPLEFT, BeltalowdaAI.groupFragement.bodyControl.inviteControl, TOPLEFT, 400, 0)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.bd:SetDimensions(200,26)
	
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetMaxInputChars(64)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetHandler("OnTextChanged", BeltalowdaAI.OnInviteTextChanged)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetAnchor(TOPLEFT, BeltalowdaAI.groupFragement.bodyControl.inviteControl, TOPLEFT, 400, 0)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetDimensions(200,26)
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetText(BeltalowdaAI.aiVars.inviteText)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_GROUP_MEMBER_JOINED, BeltalowdaAI.OnMemberJoined)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_LEADER_UPDATE, BeltalowdaAI.OnLeaderUpdated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_CHAT_MESSAGE_CHANNEL, BeltalowdaAI.ChatMessageReceived)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_GROUP_MEMBER_LEFT, BeltalowdaAI.OnMemberLeft)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaAI.OnPlayerActivated)
	
	BeltalowdaAI.OnLeaderUpdated(EVENT_LEADER_UPDATE, nil)
	
	SLASH_COMMANDS[BeltalowdaAI.slashCmd] = BeltalowdaAI.CustomSlashCmd
end

function BeltalowdaAI.GetDefaults()
	local defaults = {}
	defaults.inviteText = "beltalowda"
	defaults.maxGroupSize = 24
	defaults.pvpOnly = false
	defaults.sendChatMessages = true
	defaults.autokick = true
	defaults.autokickTime = 30
	defaults.channels = {}
	defaults.channels["G1"] = true
	defaults.channels["O1"] = true
	defaults.channels["G2"] = true
	defaults.channels["O2"] = true
	defaults.channels["G3"] = true
	defaults.channels["O3"] = true
	defaults.channels["G4"] = true
	defaults.channels["O4"] = true
	defaults.channels["G5"] = true
	defaults.channels["O5"] = true
	defaults.channels["EMOTE"] = false
	defaults.channels["SAY"] = false
	defaults.channels["YELL"] = false
	defaults.channels["GROUP"] = false
	defaults.channels["TELL"] = true
	defaults.channels["ZONE"] = false
	defaults.channels["ENZONE"] = false
	defaults.channels["FRZONE"] = false
	defaults.channels["DEZONE"] = false
	defaults.channels["JPZONE"] = false
	defaults.restrictions = BeltalowdaAI.constants.RESTRICTIONS_GUILD_FRIEND
	defaults.alwaysShowLeave = true
	return defaults
end

function BeltalowdaAI.CustomSlashCmd(param)
	BeltalowdaChat.SendChatMessage(string.format("%s %s", BeltalowdaAI.slashCmd, param), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
	--d(string.format("%s %s", BeltalowdaAI.slashCmd, param))
	param = {zo_strsplit(" ", zo_strtrim(param))}
	BeltalowdaAI.SlashCmd(param)
end

function BeltalowdaAI.SlashCmd(param)
	--d(param)
	if #param > 0 then
		local inviteString = ""
		for i = 1, #param do
			inviteString = inviteString .. " " .. param[i]
		end
		inviteString = zo_strtrim(inviteString)
		if inviteString ~= "" then
			BeltalowdaAI.aiVars.inviteText = inviteString
			BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetText(inviteString)
			BeltalowdaAI.SetAIInviteText(inviteString)
			
			BeltalowdaAI.state.enabled = true
			BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox:SetChecked(true)
			BeltalowdaAI.SetAICheckedState(true)
			
			BeltalowdaAI.SetKickCheck()
		end
	else
		BeltalowdaAI.state.enabled = false
		BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox:SetChecked(false)
		BeltalowdaAI.SetAICheckedState(false)
		BeltalowdaAI.SetKickCheck()
	end
end

function BeltalowdaAI.GetMenu()
	local menu = {
	
	}
	return menu
end

function BeltalowdaAI.IsChatAllowed(channelType)
	--channelType (12 - 16 g1-5, 17-21 o1-5)
	--6: emote
	--0: say
	--1: yell
	--3: group
	--4: whisper (tell) (2 is real)
	--31: zone
	--32: enzone
	--33: frzone
	--34: dezone
	--35: jpzone
	local retVal = false
	if channelType ~= nil and (
	(channelType == 12 and BeltalowdaAI.aiVars.channels["G1"] == true) or
	(channelType == 13 and BeltalowdaAI.aiVars.channels["G2"] == true) or
	(channelType == 14 and BeltalowdaAI.aiVars.channels["G3"] == true) or
	(channelType == 15 and BeltalowdaAI.aiVars.channels["G4"] == true) or
	(channelType == 16 and BeltalowdaAI.aiVars.channels["G5"] == true) or
	(channelType == 17 and BeltalowdaAI.aiVars.channels["O1"] == true) or
	(channelType == 18 and BeltalowdaAI.aiVars.channels["O2"] == true) or
	(channelType == 19 and BeltalowdaAI.aiVars.channels["O3"] == true) or
	(channelType == 20 and BeltalowdaAI.aiVars.channels["O4"] == true) or
	(channelType == 21 and BeltalowdaAI.aiVars.channels["O5"] == true) or
	(channelType == 0 and BeltalowdaAI.aiVars.channels["SAY"] == true) or
	(channelType == 1 and BeltalowdaAI.aiVars.channels["YELL"] == true) or
	(channelType == 2 and BeltalowdaAI.aiVars.channels["TELL"] == true) or
	(channelType == 6 and BeltalowdaAI.aiVars.channels["EMOTE"] == true) or
	(channelType == 31 and BeltalowdaAI.aiVars.channels["ZONE"] == true) or
	(channelType == 32 and BeltalowdaAI.aiVars.channels["ENZONE"] == true) or
	(channelType == 33 and BeltalowdaAI.aiVars.channels["FRZONE"] == true) or
	(channelType == 34 and BeltalowdaAI.aiVars.channels["DEZONE"] == true) or
	(channelType == 35 and BeltalowdaAI.aiVars.channels["JPZONE"] == true)
	) then
		retVal = true
	end
	return retVal
end


function BeltalowdaAI.IsAllowedToInvite()
	local isAllowed = false
	if GetGroupSize() == 0 then
		isAllowed = true
	else
		isAllowed = BeltalowdaAI.state.isLeader
	end
	
	return isAllowed
end

function BeltalowdaAI.ValidRestrictions(fromDisplayName) 
	local hasValidRestrictions = false
	if BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_NONE then
		hasValidRestrictions = true
	elseif BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_GUILD then
		hasValidRestrictions = BeltalowdaUtil.roster.IsGuildMemberByAccountName(fromDisplayName)
	elseif BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_GUILD_FRIEND then
		hasValidRestrictions = BeltalowdaUtil.roster.IsGuildMemberByAccountName(fromDisplayName) or BeltalowdaUtil.roster.IsFriendByAccountName(fromDisplayName)
	elseif BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_FRIEND then
		hasValidRestrictions = BeltalowdaUtil.roster.IsFriendByAccountName(fromDisplayName)
	elseif BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD then
		hasValidRestrictions = BeltalowdaUtil.roster.IsGuildMemberByAccountName(fromDisplayName, {BeltalowdaAI.aiVars.channels["G1"], BeltalowdaAI.aiVars.channels["G2"], BeltalowdaAI.aiVars.channels["G3"], BeltalowdaAI.aiVars.channels["G4"], BeltalowdaAI.aiVars.channels["G5"]})
	elseif BeltalowdaAI.aiVars.restrictions == BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD_FRIEND then
		hasValidRestrictions = BeltalowdaUtil.roster.IsGuildMemberByAccountName(fromDisplayName, {BeltalowdaAI.aiVars.channels["G1"], BeltalowdaAI.aiVars.channels["G2"], BeltalowdaAI.aiVars.channels["G3"], BeltalowdaAI.aiVars.channels["G4"], BeltalowdaAI.aiVars.channels["G5"]}) or BeltalowdaUtil.roster.IsFriendByAccountName(fromDisplayName)
	end

	return hasValidRestrictions
end

function BeltalowdaAI.SetKickCheck()
	if BeltalowdaAI.aiVars.autokick == true and BeltalowdaAI.state.enabled == true then
		if BeltalowdaAI.state.previousStateRunning == false then
			BeltalowdaAI.state.offliner = {}
			BeltalowdaAI.CreateOfflinerList()
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaAI.callbackName, 1000, BeltalowdaAI.CheckForKick)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_GROUP_MEMBER_CONNECTED_STATUS, BeltalowdaAI.OnMemberConnectedStatus)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaAI.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaAI.CreateOfflinerList)
		end
			BeltalowdaAI.state.previousStateRunning = true
	else
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaAI.callbackName)
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaAI.callbackName, EVENT_GROUP_MEMBER_CONNECTED_STATUS)
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaAI.callbackName, EVENT_PLAYER_ACTIVATED)
		BeltalowdaAI.state.previousStateRunning = false
		BeltalowdaAI.state.offliner = {}
	end
end

function BeltalowdaAI.CreateOfflinerList()
	local size = GetGroupSize()
	
	for i = 1, size do
		local unitTag = GetGroupUnitTagByIndex(i)
		if IsUnitOnline(unitTag) == false then
			local exists = false
			local name = GetUnitName(unitTag)
			for i = 1, #BeltalowdaAI.state.offliner do
				if BeltalowdaAI.state.offliner[i].name == name then
					exists = true
					break
				end
			end
			if exists == false then
				local character = {}
				character.name = name
				character.timeStamp = GetTimeStamp()
				table.insert(BeltalowdaAI.state.offliner, character)
			end
		else
			for i = 1, #BeltalowdaAI.state.offliner do
				if BeltalowdaAI.state.offliner[i].name == name then
					table.remove(BeltalowdaAI.state.offliner, i)
					i = i - 1
				end
			end
		end
	end
end

--profile synchronization
function BeltalowdaAI.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaAI.state.enabled = false
		BeltalowdaAI.aiVars = currentProfile.group.ai
	end
end

--callbacks
function BeltalowdaAI.OnInviteTextChanged()
	local inviteString = BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:GetText()
	
	if inviteString ~= nil and inviteString ~= BeltalowdaAI.aiVars.inviteText then
		--d("state adjustment needed")
		BeltalowdaAI.aiVars.inviteText = inviteString
		BeltalowdaAI.SetAIInviteText(inviteString)
	end
end

function BeltalowdaAI.ChatMessageReceived(eventCode, channelType, fromName, text, isCustomerService, fromDisplayName)
	--d(fromName) d(fromDisplayName)
	if BeltalowdaAI.state.enabled == true and ((BeltalowdaAI.aiVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea()) or BeltalowdaAI.aiVars.pvpOnly == false) then
		if eventCode == EVENT_CHAT_MESSAGE_CHANNEL and string.lower(text) == string.lower(BeltalowdaAI.aiVars.inviteText) then
			local bodyColor = BeltalowdaChat.GetBodyColorHex()
			local warningColor = BeltalowdaChat.GetWarningColorHex()
			local playerColor = BeltalowdaChat.GetPlayerColorHex()
			if BeltalowdaAI.IsChatAllowed(channelType) and GetGroupSize() < BeltalowdaAI.aiVars.maxGroupSize and BeltalowdaAI.ValidRestrictions(fromDisplayName) == true then
				if BeltalowdaAI.IsAllowedToInvite() then
					if GetGroupSize() < 12 then
						BeltalowdaChat.SendChatMessage(string.format(BeltalowdaAI.constants.AI_SENT_INVITE_TO, playerColor, BeltalowdaGroup.GetNameLinkFromDisplayCharName(fromName, fromDisplayName), bodyColor), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
						GroupInviteByName(fromDisplayName)
					else
						BeltalowdaChat.SendChatMessage(BeltalowdaAI.constants.AI_FULL_GROUP, BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
					end
				else
					BeltalowdaChat.SendChatMessage(string.format(BeltalowdaAI.constants.AI_NOT_LEADER_SEND_TO, playerColor, BeltalowdaGroup.GetNameLinkFromDisplayCharName(fromName, fromDisplayName), warningColor), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaAI.aiVars.sendChatMessages)
				end
			else
				BeltalowdaChat.SendChatMessage(string.format(BeltalowdaAI.constants.AI_REQUIREMENTS_NOT_MET, playerColor, BeltalowdaGroup.GetNameLinkFromDisplayCharName(fromName, fromDisplayName), warningColor), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaAI.aiVars.sendChatMessages)
			end
		end
	end
end

function BeltalowdaAI.OnLeaderUpdated(eventCode, leaderTag)
	if eventCode == EVENT_LEADER_UPDATE then
		BeltalowdaAI.state.isLeader = false
		for i = 1, GetGroupSize() do
			local unitTag = GetGroupUnitTagByIndex(i)
			if GetUnitName("player") == GetUnitName(GetGroupUnitTagByIndex(i)) or GetDisplayName() == GetUnitName(GetGroupUnitTagByIndex(i)) then
				BeltalowdaAI.state.isLeader = IsUnitGroupLeader(GetGroupUnitTagByIndex(i))
				break
			end
		end
	end
end

function BeltalowdaAI.OnMemberJoined(eventCode, memberName)
	if eventCode == EVENT_GROUP_MEMBER_JOINED then
		BeltalowdaAI.state.isLeader = false
		for i = 1, GetGroupSize() do
			local unitTag = GetGroupUnitTagByIndex(i)
			if GetUnitName("player") == GetUnitName(GetGroupUnitTagByIndex(i)) or GetDisplayName() == GetUnitName(GetGroupUnitTagByIndex(i)) then
				BeltalowdaAI.state.isLeader = IsUnitGroupLeader(GetGroupUnitTagByIndex(i))
				break
			end
		end
	end
end

function BeltalowdaAI.CheckForKick()
	if BeltalowdaAI.aiVars.autokick == true then
		local now = GetTimeStamp()
		for i = 1, #BeltalowdaAI.state.offliner do
			local offliner = BeltalowdaAI.state.offliner[i]
			if offliner == nil then
				table.remove(BeltalowdaAI.state.offliner, i)
				i = i - 1
			elseif GetDiffBetweenTimeStamps(now, offliner.timeStamp) >= BeltalowdaAI.aiVars.autokickTime then
				local unitTag = BeltalowdaUtil.GetUnitTagFromGroupMemberName(offliner.name)
				if unitTag ~= nil then
					local bodyColor = BeltalowdaChat.GetBodyColorHex()
					BeltalowdaChat.SendChatMessage(string.format(BeltalowdaAI.constants.AI_AUTO_KICK_MESSAGE, bodyColor, BeltalowdaGroup.GetNameLinkFromDisplayCharName(offliner.name, offliner.displayName), bodyColor), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
					GroupKick(unitTag)
					table.remove(BeltalowdaAI.state.offliner, i)
					i = i - 1
				else
					table.remove(BeltalowdaAI.state.offliner, i)
					i = i - 1
				end

			end
		end
	end

end

function BeltalowdaAI.OnMemberConnectedStatus(eventCode, unitTag, isOnline)
	if eventCode == EVENT_GROUP_MEMBER_CONNECTED_STATUS then
		local name = GetUnitName(unitTag)
		local displayName = GetUnitDisplayName(unitTag)
		if isOnline == false then
			local identified = false
			
			for i = 1, #BeltalowdaAI.state.offliner do
				if BeltalowdaAI.state.offliner[i].name == name then
					identified = true
					break
				end
			end
			
			if identified == false then
				local character = {}
				character.name = name
				character.displayName = displayName
				character.timeStamp = GetTimeStamp()
				table.insert(BeltalowdaAI.state.offliner, character)
			end
		else
			for i = 1, #BeltalowdaAI.state.offliner do
				if BeltalowdaAI.state.offliner[i].name == name then
					table.remove(BeltalowdaAI.state.offliner, i)
					break
				end
			end
		end
		
	end
end

function BeltalowdaAI.OnKeyBinding()
	BeltalowdaAI.state.enabled = not BeltalowdaAI.state.enabled
	if BeltalowdaAI.state.enabled == false then
		BeltalowdaChat.SendChatMessage(BeltalowdaAI.constants.AI_ENABLED_FALSE, BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
	else
		BeltalowdaChat.SendChatMessage(BeltalowdaAI.constants.AI_ENABLED_TRUE, BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
	end
	BeltalowdaAI.state.enabled = BeltalowdaAI.state.enabled
	BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox:SetChecked(BeltalowdaAI.state.enabled)
	BeltalowdaAI.SetAICheckedState(BeltalowdaAI.state.enabled)
	BeltalowdaAI.SetKickCheck()
end

function BeltalowdaAI.OnMemberLeft(eventCode, memberCharacterName, reason, isLocalPlayer, isLeader, memberDisplayName, actionRequiredVote)
	if eventCode == EVENT_GROUP_MEMBER_LEFT then
		if reason ~= GROUP_LEAVE_REASON_KICKED and (BeltalowdaAI.aiVars.alwaysShowLeave == true or (BeltalowdaAI.aiVars.alwaysShowLeave == false and BeltalowdaAI.state.enabled == true)) then
			if string.sub(memberDisplayName, 1, 1) == "@" then
				local bodyColor = BeltalowdaChat.GetBodyColorHex()
				local playerColor = BeltalowdaChat.GetPlayerColorHex()
				BeltalowdaChat.SendChatMessage(string.format(BeltalowdaAI.constants.AI_MEMBER_LEFT, playerColor, BeltalowdaGroup.GetNameLinkFromDisplayCharName(memberCharacterName, memberDisplayName), bodyColor), BeltalowdaAI.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaAI.aiVars.sendChatMessages)
			end
		end
		
	end
end

function BeltalowdaAI.OnPlayerActivated(eventCode, initial)
	BeltalowdaAI.OnLeaderUpdated(EVENT_LEADER_UPDATE, nil)
end

--menu interaction
function BeltalowdaAI.GetMenu()
	local menu = {
	[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.AI_HEADER,
			--width = "full",
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AI_ENABLED,
					getFunc = BeltalowdaAI.GetAIEnabled,
					setFunc = BeltalowdaAI.SetAIEnabled,
					reference = BeltalowdaAI.constants.references.AI_ENABLED_CHECKBOX
				},
				[2] = {
					type = "editbox",
					name = BeltalowdaMenu.constants.AI_INVITE_TEXT,
					getFunc = BeltalowdaAI.GetInviteText,
					setFunc = BeltalowdaAI.SetInviteText,
					isMultiline = false,
					width = "full",
					default = "",
					reference = BeltalowdaAI.constants.references.AI_INVITE_TEXTBOX
				},
				[3] = {
					type = "slider",
					name = BeltalowdaMenu.constants.AI_GROUP_SIZE,
					min = 2,
					max = 24,
					step = 1,
					getFunc = BeltalowdaAI.GetMaxGroupSize,
					setFunc = BeltalowdaAI.SetMaxGroupSize,
					width = "full",
					default = 24
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AI_PVP_CHECK,
					getFunc = BeltalowdaAI.GetAIPvpOnly,
					setFunc = BeltalowdaAI.SetAIPvpOnly
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AI_SEND_CHAT_MESSAGES,
					getFunc = BeltalowdaAI.GetAISendChatMessages,
					setFunc = BeltalowdaAI.SetAISendChatMessages
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AI_SHOW_MEMBER_LEFT,
					getFunc = BeltalowdaAI.GetAIShowMemberLeft,
					setFunc = BeltalowdaAI.SetAIShowMemberLeft
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AI_AUTO_KICK,
					getFunc = BeltalowdaAI.GetAutoKickEnabled,
					setFunc = BeltalowdaAI.SetAutoKickEnabled
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.AI_AUTO_KICK_TIME,
					min = 1,
					max = 600,
					step = 1,
					getFunc = BeltalowdaAI.GetAutoKickEnabledTime,
					setFunc = BeltalowdaAI.SetAutoKickEnabledTime,
					width = "full",
					default = 30
				},
				[9] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.AI_CHAT,
					width = "full"
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.G1,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("G1") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("G1", value) end
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.O1,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("O1") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("O1", value) end
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.G2,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("G2") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("G2", value) end
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.O2,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("O2") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("O2", value) end
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.G3,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("G3") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("G3", value) end
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.O3,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("O3") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("O3", value) end
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.G4,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("G4") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("G4", value) end
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.O4,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("O4") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("O4", value) end
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.G5,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("G5") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("G5", value) end
				},
				[19] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.O5,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("O5") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("O5", value) end
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.EMOTE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("EMOTE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("EMOTE", value) end
				},
				[21] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.SAY,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("SAY") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("SAY", value) end
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.YELL,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("YELL") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("YELL", value) end
				},
				[23] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.TELL,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("TELL") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("TELL", value) end
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.ZONE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("ZONE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("ZONE", value) end
				},
				[25] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.ENZONE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("ENZONE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("ENZONE", value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.FRZONE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("FRZONE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("FRZONE", value) end
				},
				[27] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.DEZONE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("DEZONE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("DEZONE", value) end
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaUtil.constants.JPZONE,
					getFunc = function() return BeltalowdaAI.GetAIChatEnabled("JPZONE") end,
					setFunc = function(value) BeltalowdaAI.SetAIChatEnabled("JPZONE", value) end
				},
				[29] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS,
					choices = BeltalowdaAI.GetAvailableAIRestrictions(),
					getFunc = BeltalowdaAI.GetSelectedAIRestriction,
					setFunc = BeltalowdaAI.SetSelectedAIRestriction,
					width = "full"
				}
			}
		},
	}
	return menu
end

function BeltalowdaAI.GetAIEnabled()
	return BeltalowdaAI.state.enabled
end

function BeltalowdaAI.SetAIEnabled(value)
	BeltalowdaAI.state.enabled = value
	BeltalowdaAI.groupFragement.bodyControl.enabledCheckbox:SetChecked(value)
	BeltalowdaAI.SetKickCheck()
end

function BeltalowdaAI.GetInviteText()
	return BeltalowdaAI.aiVars.inviteText
end

function BeltalowdaAI.SetInviteText(value)
	BeltalowdaAI.aiVars.inviteText = value
	BeltalowdaAI.groupFragement.bodyControl.inviteControl.editbox:SetText(value)
end

function BeltalowdaAI.GetMaxGroupSize()
	return BeltalowdaAI.aiVars.maxGroupSize
end

function BeltalowdaAI.SetMaxGroupSize(value)
	BeltalowdaAI.aiVars.maxGroupSize = value
end

function BeltalowdaAI.GetAIPvpOnly()
	return BeltalowdaAI.aiVars.pvpOnly
end

function BeltalowdaAI.SetAIPvpOnly(value)
	BeltalowdaAI.aiVars.pvpOnly = value
end

function BeltalowdaAI.GetAISendChatMessages()
	return BeltalowdaAI.aiVars.sendChatMessages
end

function BeltalowdaAI.SetAISendChatMessages(value)
	BeltalowdaAI.aiVars.sendChatMessages = value
end

function BeltalowdaAI.GetAIShowMemberLeft()
	return BeltalowdaAI.aiVars.alwaysShowLeave
end

function BeltalowdaAI.SetAIShowMemberLeft(value)
	BeltalowdaAI.aiVars.alwaysShowLeave = value
end

function BeltalowdaAI.GetAutoKickEnabled()
	return BeltalowdaAI.aiVars.autokick
end

function BeltalowdaAI.SetAutoKickEnabled(value)
	BeltalowdaAI.aiVars.autokick = value
	BeltalowdaAI.SetKickCheck()
end

function BeltalowdaAI.GetAutoKickEnabledTime()
	return BeltalowdaAI.aiVars.autokickTime
end

function BeltalowdaAI.SetAutoKickEnabledTime(value)
	BeltalowdaAI.aiVars.autokickTime = value
end

function BeltalowdaAI.GetAIChatEnabled(channel)
	return BeltalowdaAI.aiVars.channels[channel]
end

function BeltalowdaAI.SetAIChatEnabled(channel, value)
	BeltalowdaAI.aiVars.channels[channel] = value
end

function BeltalowdaAI.GetAvailableAIRestrictions()
	return {
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_NONE],
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_GUILD],
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_GUILD_FRIEND],
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_FRIEND],
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD],
		BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.constants.RESTRICTIONS_SPECIFIC_GUILD_FRIEND]
	}
end

function BeltalowdaAI.GetSelectedAIRestriction()
	return BeltalowdaAI.constants.RESTRICTIONS[BeltalowdaAI.aiVars.restrictions]
end

function BeltalowdaAI.SetSelectedAIRestriction(value)
	if value ~= nil then
		for i = 1, #BeltalowdaAI.constants.RESTRICTIONS do
			if BeltalowdaAI.constants.RESTRICTIONS[i] == value then
				BeltalowdaAI.aiVars.restrictions = i
				break
			end
		end
	end
end

--Auto Invite Callback
function BeltalowdaAI.SetAICheckedState(state)
	local control = GetWindowManager():GetControlByName(BeltalowdaAI.constants.references.AI_ENABLED_CHECKBOX)
	if control ~= nil then
		--d("changing state")
		control.value = state
		control:UpdateValue(false, state)
	end
end

function BeltalowdaAI.SetAIInviteText(text)
	local control = GetWindowManager():GetControlByName(BeltalowdaAI.constants.references.AI_INVITE_TEXTBOX)
	if control ~= nil then
		--d("changing state")
		control.value = text
		control:UpdateValue()
	end
end

--UI
function BeltalowdaAI.OnCheckChanged(control, state)
	BeltalowdaAI.state.enabled = state
	BeltalowdaAI.SetAICheckedState(state)
	BeltalowdaAI.SetKickCheck()
end
