-- Beltalowda Menu
-- By @Kickimanjaro
-- Based on RdK Group Tool Menu by @s0rdrak (PC / EU)

--local LAM = LibStub("LibAddonMenu-2.0")
local LAM = LibAddonMenu2

local Beltalowda = _G['Beltalowda']
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.profile = Beltalowda.profile or {}
local BeltalowdaProfile = Beltalowda.profile
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
Beltalowda.compass = Beltalowda.compass or {}
local BeltalowdaCompass = Beltalowda.compass
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaToolbox = Beltalowda.toolbox
Beltalowda.classRole = Beltalowda.classRole or {}
local BeltalowdaCR = Beltalowda.classRole
Beltalowda.addOnIntegration = Beltalowda.addOnIntegration or {}
local BeltalowdaAoi = Beltalowda.addOnIntegration
BeltalowdaAoi.mpa = BeltalowdaAoi.mpa or {}
local BeltalowdaMpa = BeltalowdaAoi.mpa
Beltalowda.admin = Beltalowda.admin or {}
local BeltalowdaAdmin = Beltalowda.admin
Beltalowda.cfg = Beltalowda.cfg or {}
local BeltalowdaConfig = Beltalowda.cfg
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
Beltalowda.features = Beltalowda.features or {}
local BeltalowdaFeatures = Beltalowda.features

local wm = GetWindowManager()

BeltalowdaMenu.lam = {}
BeltalowdaMenu.lam.panel = nil
BeltalowdaMenu.lam.panelData = {}
BeltalowdaMenu.lam.panelData.type = "panel"
BeltalowdaMenu.lam.panelData.name = "|c4592FFBeltalowda|r"
BeltalowdaMenu.lam.panelData.displayName = "|c4592FFBeltalowda Configuration|r"
BeltalowdaMenu.lam.panelData.author = string.format("|cFF8174%s|r\r\nThanks to: |cFF8174%s|r\r\n", Beltalowda.author, Beltalowda.credits)
BeltalowdaMenu.lam.panelData.version = string.format("|cFF8174%s|r", Beltalowda.versionString)
BeltalowdaMenu.lam.panelData.registerForRefresh = true
BeltalowdaMenu.lam.panelData.registerForDefaults = false
BeltalowdaMenu.constants = BeltalowdaMenu.constants or {}
BeltalowdaMenu.constants.PREFIX = "Menu"


BeltalowdaMenu.state = {}
BeltalowdaMenu.state.newProfileName = ""
BeltalowdaMenu.state.positionFixedConsumers = {}



--General
function BeltalowdaMenu.Initialize()
	--zo_callLater(function()
		BeltalowdaMenu.lam.optionsData = BeltalowdaMenu.CreateOptionsData()
		BeltalowdaMenu.lam.panel = LAM:RegisterAddonPanel(BeltalowdaMenu.name, BeltalowdaMenu.lam.panelData)
		LAM:RegisterOptionControls(BeltalowdaMenu.name, BeltalowdaMenu.lam.optionsData)
	--end,1)
end

function BeltalowdaMenu.OpenMenu()
	LAM:OpenToPanel(BeltalowdaMenu.lam.panel)
end

function BeltalowdaMenu.SetErrorMessage(controlName, errorMessage)
	local errorDescription = wm:GetControlByName(controlName)
	--d(errorDescription)
	--d(errorMessage)
	if errorDescription ~= nil and errorDescription.data ~= nil then
		errorDescription.data.text = errorMessage
		errorDescription:UpdateValue()
	end
end

function BeltalowdaMenu.UpdateCheckbox(checkbox)
	if checkbox ~= nil and checkbox.data ~= nil then
		checkbox:UpdateValue()
	end
end

function BeltalowdaMenu.UpdateControl(control)
	if control ~= nil and control.data ~= nil then
		control:UpdateValue()
	end
end

function BeltalowdaMenu.AddMenuEntries(menu, entries)
	if menu ~= nil and entries ~= nil then
		for i = 1, #entries do
			table.insert(menu, entries[i])
		end
	end
end

function BeltalowdaMenu.CreateOptionsData()
	local menu = {}
	local tempMenu = {}
	--profile
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaProfile.GetMenu())
	--Fixed Components
	tempMenu = {
		[1] = {
			type = "divider",
			width = "full"
			},
		[2] = {
			type = "button",
			name = BeltalowdaMenu.constants.POSITION_FIXED_SET,
			func = BeltalowdaMenu.SetPositionFixed,
			width = "full"
		},
		[3] = {
			type = "button",
			name = BeltalowdaMenu.constants.POSITION_FIXED_UNSET,
			func = BeltalowdaMenu.UnsetPositionFixed,
			width = "full"
		},
	}
	BeltalowdaMenu.AddMenuEntries(menu, tempMenu)
	--new hotness
	tempMenu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.NEW_HOTNESS_HEADER,
			width = "full",
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, tempMenu)
	-- Use new wrapper namespaces for clearer organization
	if BeltalowdaFeatures.ultimates and BeltalowdaFeatures.ultimates.GetMenu then
		BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaFeatures.ultimates.GetMenu())
	end
	if BeltalowdaFeatures.synergies and BeltalowdaFeatures.synergies.GetMenu then
		BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaFeatures.synergies.GetMenu())
	end
	if BeltalowdaFeatures.positioning and BeltalowdaFeatures.positioning.GetMenu then
		BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaFeatures.positioning.GetMenu())
	end
	if BeltalowdaFeatures.attackTimers and BeltalowdaFeatures.attackTimers.GetMenu then
		BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaFeatures.attackTimers.GetMenu())
	end
	--placeholder submenus for future features
	tempMenu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.OFFENSIVE_TIMERS_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = "Coming soon...",
				}
			}
		},
		[2] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.POSITIONING_ASSISTANCE_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = "Coming soon...\n\nPlanned features:\n\n• Follow the Crown - Options to highlight the group leader to make following them easier (different icons, beams, or other visual indicators)\n\n• Compass - Additional compass UI element with options to add arrows pointing to crown or other group members\n\n• Speeder - Display group Expedition (Major and Minor) buff cooldown status on group members, with options to highlight the speeder role similarly to crown highlighting",
				}
			}
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, tempMenu)
	--group
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.GetMenu())
	--compass
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaCompass.GetMenu())
	--toolbox
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaToolbox.GetMenu())
	--util
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaUtil.GetMenu())
	--classRole
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaCR.GetMenu())
	--addOnIntegration
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaAoi.GetMenu())
	--Admin
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaAdmin.GetMenu())
	--Config
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaConfig.GetMenu())
	return menu
end

function BeltalowdaMenu.GetRGBColor(color)
	return color.r, color.g, color.b
end

function BeltalowdaMenu.GetRGBAColor(color)
	return color.r, color.g, color.b, color.a
end

function BeltalowdaMenu.GetColorFromRGB(r, g, b)
	return {["r"] = r, ["g"] = g, ["b"] = b}
end

function BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	return {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
end

function BeltalowdaMenu.PositionFixedConsumerExists(consumer)
	for i = 1, #BeltalowdaMenu.state.positionFixedConsumers do
		if BeltalowdaMenu.state.positionFixedConsumers[i] == consumer then
			return true
		end
	end
	return false
end

function BeltalowdaMenu.AddPositionFixedConsumer(consumer)
	if consumer ~= nil and type(consumer) == "function" and BeltalowdaMenu.PositionFixedConsumerExists(consumer) == false then
		table.insert(BeltalowdaMenu.state.positionFixedConsumers, consumer)
	end
end

function BeltalowdaMenu.RemovePositionFixedConsumer(consumer)
	if consumer ~= nil and type(consumer) == "function" and BeltalowdaMenu.PositionFixedConsumerExists(consumer) == true then
		for i = 1, #BeltalowdaMenu.state.positionFixedConsumers do
			if BeltalowdaMenu.state.positionFixedConsumers[i] == consumer then
				table.remove(BeltalowdaMenu.state.positionFixedConsumers, i)
				break
			end
		end
	end
end

function BeltalowdaMenu.Donate(amount)
	if GetWorldName() == "EU Megaserver" then
		SCENE_MANAGER:Show('mailSend')
		zo_callLater(
			function()
				ZO_MailSendToField:SetText("@s0rdrak")
				ZO_MailSendSubjectField:SetText(BeltalowdaMenu.constants.DONATE_MAIL_SUBJECT)
				QueueMoneyAttachment(amount)
				ZO_MailSendBodyField:TakeFocus() 
			end, 
		200)
	else
		CHAT_SYSTEM:Maximize()
		BeltalowdaChat.SendChatMessage(BeltalowdaMenu.constants.DONATE_SERVER_ERROR, BeltalowdaMenu.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
	end
end
--menu interaction
function BeltalowdaMenu.SetPositionFixed()
	for i = 1, #BeltalowdaMenu.state.positionFixedConsumers do
		BeltalowdaMenu.state.positionFixedConsumers[i](true)
	end
end

function BeltalowdaMenu.UnsetPositionFixed()
	for i = 1, #BeltalowdaMenu.state.positionFixedConsumers do
		BeltalowdaMenu.state.positionFixedConsumers[i](false)
	end
end

function BeltalowdaMenu.Feedback()
	CHAT_SYSTEM:Maximize()
	BeltalowdaChat.SendChatMessage(BeltalowdaMenu.constants.FEEDBACK_STRING, BeltalowdaMenu.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING)
end

function BeltalowdaMenu.DonateFreeAmount()
	BeltalowdaMenu.Donate(0)
end

function BeltalowdaMenu.Donate5k()
	BeltalowdaMenu.Donate(5000)
end

function BeltalowdaMenu.Donate50k()
	BeltalowdaMenu.Donate(50000)
end
--[[

zo_callLater(function()
			ZO_MailSendToField:SetText(p.mailDestination)
			ZO_MailSendSubjectField:SetText(p.parentAddonName)
			QueueMoneyAttachment(self.amount)
			ZO_MailSendBodyField:TakeFocus() end, 200)
			]]