-- Beltalowda Chat System
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaChat.callbackName = Beltalowda.addonName .. "ChatSystem"

BeltalowdaChat.constants = {}
BeltalowdaChat.constants.BELTALOWDA_PREFIX_WITHOUT_MODULE = "|c%s[Beltalowda]: %s"
BeltalowdaChat.constants.BELTALOWDA_PREFIX_WITH_MODULE = "|c%s[Beltalowda %s]: %s"
BeltalowdaChat.constants.PREFIX_WITH_MODULE = "|c%s[%s]: %s"
BeltalowdaChat.constants.messageTypes = {}
BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL = 1
BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING = 2
BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG = 3
BeltalowdaChat.constants.references = BeltalowdaChat.constants.references or {}
BeltalowdaChat.constants.references.CHAT_DROPDOWN_SELECTED_TAB = "CHAT_DROPDOWN_SELECTED_TAB"

BeltalowdaChat.state = {}
BeltalowdaChat.state.prefixColor = "FFFFFF"
BeltalowdaChat.state.bodyColor = "FFFFFF"

function BeltalowdaChat.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaChat.callbackName, BeltalowdaChat.OnProfileChanged)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.tab = 1
	defaults.prefixEnabled = true
	defaults.beltalowdaPrefixEnabled = true
	defaults.showWarnings = true
	defaults.showDebug = false
	defaults.showNormal = true
	defaults.addTimestamp = false
	defaults.hideSeconds = true
	defaults.colors = {}
	defaults.colors.prefix = {}
	defaults.colors.prefix.r = 0.5
	defaults.colors.prefix.g = 1
	defaults.colors.prefix.b = 0.5
	defaults.colors.body = {}
	defaults.colors.body.r = 1
	defaults.colors.body.g = 1
	defaults.colors.body.b = 1
	defaults.colors.warning = {}
	defaults.colors.warning.r = 1
	defaults.colors.warning.g = 0
	defaults.colors.warning.b = 0
	defaults.colors.debug = {}
	defaults.colors.debug.r = 0.5
	defaults.colors.debug.g = 1
	defaults.colors.debug.b = 1
	defaults.colors.player = {}
	defaults.colors.player.r = 0
	defaults.colors.player.g = 0.59765625
	defaults.colors.player.b = 0.6640625
	defaults.colors.timestamp = {}
	defaults.colors.timestamp.r = 0.42578125
	defaults.colors.timestamp.g = 0.42578125
	defaults.colors.timestamp.b = 0.42578125
	return defaults
end

function BeltalowdaChat.SendChatMessage(message, prefix, messageType, sendMessage)
	if messageType == nil then
		messageType = BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL 
	end
	if BeltalowdaChat.csVars.enabled == true and (sendMessage == nil or sendMessage == true) and 
	  (((BeltalowdaChat.csVars.showWarnings == true and messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)) or
	  ((BeltalowdaChat.csVars.showDebug == true and messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)) or
	  ((BeltalowdaChat.csVars.showNormal == true and messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL))) then
		local messageColor = BeltalowdaChat.state.bodyColor
		local color = BeltalowdaChat.csVars.colors.body
		if messageType == nil or messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL then
			messageColor = BeltalowdaChat.state.bodyColor
			color = BeltalowdaChat.csVars.colors.body
		elseif messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING then
			messageColor = BeltalowdaChat.state.warningColor
			color = BeltalowdaChat.csVars.colors.warning
		elseif messageType == BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG then
			messageColor = BeltalowdaChat.state.debugColor
			color = BeltalowdaChat.csVars.colors.debug
		end
		message = string.format("|c%s%s", messageColor, message)
		if BeltalowdaChat.csVars.prefixEnabled == true then
			if BeltalowdaChat.csVars.beltalowdaPrefixEnabled == true then
				if prefix ~= nil then
					message = string.format(BeltalowdaChat.constants.BELTALOWDA_PREFIX_WITH_MODULE, BeltalowdaChat.state.prefixColor, prefix, message)
				else
					message = string.format(BeltalowdaChat.constants.BELTALOWDA_PREFIX_WITHOUT_MODULE, BeltalowdaChat.state.prefixColor, message)
				end
			else
				if prefix ~= nil then
					message = string.format(BeltalowdaChat.constants.PREFIX_WITH_MODULE, BeltalowdaChat.state.prefixColor, prefix, message)
				end
			end
		end
		if BeltalowdaChat.csVars.addTimestamp == true then
			local timestamp = GetTimeString()
			if BeltalowdaChat.csVars.hideSeconds == true then
				local split = {zo_strsplit(":",timestamp)}
				timestamp = string.format("%s:%s", split[1], split[2])
			end
			message = string.format("|c%s[%s]|r%s", BeltalowdaChat.state.timestampColor, timestamp, message)
		end
		if CHAT_SYSTEM ~= nil then
			if CHAT_SYSTEM.containers[1] ~= nil and CHAT_SYSTEM.containers[1].windows[BeltalowdaChat.csVars.tab] ~= nil and CHAT_SYSTEM.containers[1].windows[BeltalowdaChat.csVars.tab].buffer ~= nil then
				CHAT_SYSTEM.containers[1].windows[BeltalowdaChat.csVars.tab].buffer:AddMessage(message, color.r, color.g, color.b)
			else
				CHAT_SYSTEM:AddMessage(message)
			end
		else
			d(message)
		end
	end
end

function BeltalowdaChat.AdjustColors()
	BeltalowdaChat.state.prefixColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.prefix.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.prefix.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.prefix.b))
	BeltalowdaChat.state.bodyColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.body.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.body.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.body.b))
	BeltalowdaChat.state.warningColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.warning.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.warning.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.warning.b))
	BeltalowdaChat.state.debugColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.debug.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.debug.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.debug.b))
	BeltalowdaChat.state.playerColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.player.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.player.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.player.b))
	BeltalowdaChat.state.timestampColor = BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.timestamp.r)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.timestamp.g)) .. BeltalowdaMath.ByteToHex(BeltalowdaMath.FloatingPointToByte(BeltalowdaChat.csVars.colors.timestamp.b))
end

function BeltalowdaChat.GetPrefixColor()
	return BeltalowdaChat.csVars.colors.prefix
end

function BeltalowdaChat.GetBodyPrefixHex()
	return BeltalowdaChat.state.prefixColor
end

function BeltalowdaChat.GetBodyColor()
	return BeltalowdaChat.csVars.colors.body
end

function BeltalowdaChat.GetBodyColorHex()
	return BeltalowdaChat.state.bodyColor
end

function BeltalowdaChat.GetWarningColor()
	return BeltalowdaChat.csVars.colors.warning
end

function BeltalowdaChat.GetWarningColorHex()
	return BeltalowdaChat.state.warningColor
end

function BeltalowdaChat.GetDebugColor()
	return BeltalowdaChat.csVars.colors.debug
end

function BeltalowdaChat.GetDebugColorHex()
	return BeltalowdaChat.state.debugColor
end

function BeltalowdaChat.GetPlayerColor()
	return BeltalowdaChat.csVars.colors.player
end

function BeltalowdaChat.GetPlayerColorHex()
	return BeltalowdaChat.state.playerColor
end

--callbacks
function BeltalowdaChat.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaChat.csVars = currentProfile.util.chatSystem
		BeltalowdaChat.AdjustColors()
	end
end

function BeltalowdaChat.RefreshMenu()
	BeltalowdaChat.UpdateChatTabs(BeltalowdaChat.GetChatAvailableTabs(), BeltalowdaChat.GetChatAvailableTabValues())
end

--menu interaction
function BeltalowdaChat.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CHAT_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_ENABLED,
					getFunc = BeltalowdaChat.GetChatEnabled,
					setFunc = BeltalowdaChat.SetChatEnabled
				},
				[2] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.CHAT_SELECTED_TAB,
					choices = BeltalowdaChat.GetChatAvailableTabs(),
					choicesValues = BeltalowdaChat.GetChatAvailableTabValues(),
					getFunc = BeltalowdaChat.GetChatSelectedTab,
					setFunc = BeltalowdaChat.SetChatSelectedTab,
					reference = BeltalowdaChat.constants.references.CHAT_DROPDOWN_SELECTED_TAB
				},
				[3] = {
					type = "button",
					name = BeltalowdaMenu.constants.CHAT_REFRESH,
					func = BeltalowdaChat.RefreshMenu,
					width = "full"
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_WARNINGS_ONLY,
					getFunc = BeltalowdaChat.GetChatWarningsOnly,
					setFunc = BeltalowdaChat.SetChatWarningsOnly
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_DEBUG_ONLY,
					getFunc = BeltalowdaChat.GetChatDebugOnly,
					setFunc = BeltalowdaChat.SetChatDebugOnly
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_NORMAL_ONLY,
					getFunc = BeltalowdaChat.GetChatNormalOnly,
					setFunc = BeltalowdaChat.SetChatNormalOnly
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_PREFIX_ENABLED,
					getFunc = BeltalowdaChat.GetChatPrefixEnabled,
					setFunc = BeltalowdaChat.SetChatPrefixEnabled
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_BELTALOWDA_PREFIX_ENABLED,
					getFunc = BeltalowdaChat.GetChatBeltalowdaPrefixEnabled,
					setFunc = BeltalowdaChat.SetChatBeltalowdaPrefixEnabled
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_PREFIX,
					getFunc = BeltalowdaChat.GetChatPrefixColor,
					setFunc = BeltalowdaChat.SetChatPrefixColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_BODY,
					getFunc = BeltalowdaChat.GetChatBodyColor,
					setFunc = BeltalowdaChat.SetChatBodyColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_WARNING,
					getFunc = BeltalowdaChat.GetChatWarningColor,
					setFunc = BeltalowdaChat.SetChatWarningColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_DEBUG,
					getFunc = BeltalowdaChat.GetChatDebugColor,
					setFunc = BeltalowdaChat.SetChatDebugColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_PLAYER,
					getFunc = BeltalowdaChat.GetChatPlayerColor,
					setFunc = BeltalowdaChat.SetChatPlayerColor,
					width = "full"
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_ADD_TIMESTAMP,
					getFunc = BeltalowdaChat.GetChatAddTimestamp,
					setFunc = BeltalowdaChat.SetChatAddTimestamp
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CHAT_HIDE_SECONDS,
					getFunc = BeltalowdaChat.GetChatHideSeconds,
					setFunc = BeltalowdaChat.SetChatHideSeconds
				},
				[16] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.CHAT_COLOR_TIMESTAMP,
					getFunc = BeltalowdaChat.GetChatTimestampColor,
					setFunc = BeltalowdaChat.SetChatTimestampColor,
					width = "full"
				},
			}
		},
	}
	return menu
end

function BeltalowdaChat.GetChatEnabled()
	return BeltalowdaChat.csVars.enabled
end

function BeltalowdaChat.SetChatEnabled(value)
	BeltalowdaChat.csVars.enabled = value
end

function BeltalowdaChat.GetChatAvailableTabs()
	local tabNames = {}
	if CHAT_SYSTEM ~= nil and CHAT_SYSTEM.containers ~= nil and CHAT_SYSTEM.containers[1] ~= nil and CHAT_SYSTEM.containers[1].windows ~= nil then
		for i = 1, #CHAT_SYSTEM.containers[1].windows do
			table.insert(tabNames, CHAT_SYSTEM.containers[1]:GetTabName(i))
		end
	end
	return tabNames
end

function BeltalowdaChat.GetChatAvailableTabValues()
	local tabIndexes = {}
	if CHAT_SYSTEM ~= nil and CHAT_SYSTEM.containers ~= nil and CHAT_SYSTEM.containers[1] ~= nil and CHAT_SYSTEM.containers[1].windows ~= nil then
		for i = 1, #CHAT_SYSTEM.containers[1].windows do
			table.insert(tabIndexes, i)
		end
	end
	return tabIndexes
end

function BeltalowdaChat.GetChatSelectedTab()
	if CHAT_SYSTEM ~= nil and CHAT_SYSTEM.containers ~= nil and CHAT_SYSTEM.containers[1] ~= nil and CHAT_SYSTEM.containers[1].windows ~= nil then
		return BeltalowdaChat.csVars.tab
	else
		return nil
	end
end

function BeltalowdaChat.SetChatSelectedTab(value)
	if value ~= nil then
		BeltalowdaChat.csVars.tab = value
	end
end

function BeltalowdaChat.GetChatWarningsOnly()
	return BeltalowdaChat.csVars.showWarnings
end

function BeltalowdaChat.SetChatWarningsOnly(value)
	BeltalowdaChat.csVars.showWarnings = value
end

function BeltalowdaChat.GetChatDebugOnly()
	return BeltalowdaChat.csVars.showDebug
end

function BeltalowdaChat.SetChatDebugOnly(value)
	BeltalowdaChat.csVars.showDebug = value
end

function BeltalowdaChat.GetChatNormalOnly()
	return BeltalowdaChat.csVars.showNormal
end

function BeltalowdaChat.SetChatNormalOnly(value)
	BeltalowdaChat.csVars.showNormal = value
end

function BeltalowdaChat.GetChatPrefixEnabled()
	return BeltalowdaChat.csVars.prefixEnabled
end

function BeltalowdaChat.SetChatPrefixEnabled(value)
	BeltalowdaChat.csVars.prefixEnabled = value
end

function BeltalowdaChat.GetChatBeltalowdaPrefixEnabled()
	return BeltalowdaChat.csVars.beltalowdaPrefixEnabled
end

function BeltalowdaChat.SetChatBeltalowdaPrefixEnabled(value)
	BeltalowdaChat.csVars.beltalowdaPrefixEnabled = value
end

function BeltalowdaChat.GetChatPrefixColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.prefix)
end

function BeltalowdaChat.SetChatPrefixColor(r, g, b)
	BeltalowdaChat.csVars.colors.prefix = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetChatBodyColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.body)
end

function BeltalowdaChat.SetChatBodyColor(r, g, b)
	BeltalowdaChat.csVars.colors.body = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetChatWarningColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.warning)
end

function BeltalowdaChat.SetChatWarningColor(r, g, b)
	BeltalowdaChat.csVars.colors.warning = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetChatDebugColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.debug)
end

function BeltalowdaChat.SetChatDebugColor(r, g, b)
	BeltalowdaChat.csVars.colors.debug = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetChatPlayerColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.player)
end

function BeltalowdaChat.SetChatPlayerColor(r, g, b)
	BeltalowdaChat.csVars.colors.player = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.GetChatAddTimestamp()
	return BeltalowdaChat.csVars.addTimestamp
end

function BeltalowdaChat.SetChatAddTimestamp(value)
	BeltalowdaChat.csVars.addTimestamp = value
end

function BeltalowdaChat.GetChatHideSeconds()
	return BeltalowdaChat.csVars.hideSeconds
end

function BeltalowdaChat.SetChatHideSeconds(value)
	BeltalowdaChat.csVars.hideSeconds = value
end

function BeltalowdaChat.GetChatTimestampColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaChat.csVars.colors.timestamp)
end

function BeltalowdaChat.SetChatTimestampColor(r, g, b)
	BeltalowdaChat.csVars.colors.timestamp = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaChat.AdjustColors()
end

function BeltalowdaChat.UpdateChatTabs(chatNames, chatIndexes)
	local control = GetWindowManager():GetControlByName(BeltalowdaChat.constants.references.CHAT_DROPDOWN_SELECTED_TAB)
	if control ~= nil and #chatNames == #chatIndexes then
		--control.value = chatNames
		--control.valueChoises = chatIndexes
		--control.choises = {}
		--for i = 1, #chatNames do
		--	control.choises[chatIndexes[i]] = chatNames[i]
		--end
		control:UpdateChoices(chatNames, chatIndexes)
	end
end