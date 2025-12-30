-- Beltalowda Camp Preview
-- By @s0rdrak (PC / EU)

--local libMapPins = LibStub("LibMapPins-1.0")
local libMapPins = LibMapPins

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.camp = BeltalowdaTB.camp or {}
local BeltalowdaCamp = BeltalowdaTB.camp
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaCamp.constants = BeltalowdaCamp.constants or {}

BeltalowdaCamp.callbackName = Beltalowda.addonName .. "CampPreview"

BeltalowdaCamp.config = {}
BeltalowdaCamp.config.pinType = "BeltalowdaToolboxCampPreviewPinType"
BeltalowdaCamp.config.pinTag = "BeltalowdaToolboxCampPreviewPinTag"
BeltalowdaCamp.config.updateInterval = 50
BeltalowdaCamp.config.zoneRadius = 0.026000000536442
BeltalowdaCamp.config.subZoneRadius = 0.52204173803329
BeltalowdaCamp.config.worldRadius = 0.0046799997799098

BeltalowdaCamp.state = {}
BeltalowdaCamp.state.initialized = false
BeltalowdaCamp.state.alreadyEnabled = false
BeltalowdaCamp.state.registredActivationConsumers = false
BeltalowdaCamp.state.campId = 0
BeltalowdaCamp.state.campPreviewUp = false
BeltalowdaCamp.state.previousCoordinates = {}
BeltalowdaCamp.state.previousCoordinates.x = 0
BeltalowdaCamp.state.previousCoordinates.y = 0
BeltalowdaCamp.state.pinLayoutData = {}
BeltalowdaCamp.state.pinLayoutData.level = 111
BeltalowdaCamp.state.pinLayoutData.texture = nil -- "/art/fx/texture/aoe_circle_hollow.dds"
BeltalowdaCamp.state.pinLayoutData.size = 0 -- 0.026000000536442
BeltalowdaCamp.state.pinLayoutData.tint = nil
--BeltalowdaCamp.state.pinLayoutData.color = {r=1,g=0,b=0,a=1}
BeltalowdaCamp.state.pinLayoutData.grayscale = false
BeltalowdaCamp.state.pinLayoutData.insetX = 0
BeltalowdaCamp.state.pinLayoutData.insetY = 0
BeltalowdaCamp.state.pinLayoutData.minSize = 0
BeltalowdaCamp.state.pinLayoutData.minAreaSize = nil
BeltalowdaCamp.state.pinLayoutData.showsPinAndArea = true
BeltalowdaCamp.state.pinLayoutData.isAnimated = false
BeltalowdaCamp.state.updateLoopRunning = false
--[[
/script d("|t50:50:/art/fx/texture/aoe_circle_hollow.dds|t")
/script d("|t50:50:/art/fx/texture/aoe_circle_hollow_thinouter.dds|t")
]]

--[[
pinLayoutData: table which can contain the following keys:
   level =     number > 2, pins with higher level are drawn on the top of pins
               with lower level.
               Examples: Points of interest 50, quests 110, group members 130,
               wayshrine 140, player 160.
   texture =   string or function(pin). Function can return just one texture
               or overlay, pulse and glow textures.
   size =      texture will be resized to size*size, if not specified size is 20.
   tint  =     ZO_ColorDef object or function(pin) which returns this object.
               If defined, color of background texture is set to this color.
   grayscale = true/false, could be function(pin). If defined and not false,
               background texure will be converted to grayscale (http://en.wikipedia.org/wiki/Colorfulness)
   insetX =    size of transparent texture border, used to handle mouse clicks
   insetY =    dtto
   minSize =   if not specified, default value is 18
   minAreaSize = used for area pins
   showsPinAndArea = true/false
   isAnimated = true/false
  ]]

function BeltalowdaCamp.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaCamp.callbackName, BeltalowdaCamp.OnProfileChanged)
	BeltalowdaCamp.state.campId = BeltalowdaCamp.GetCampId()
	libMapPins:AddPinType(BeltalowdaCamp.config.pinType, function() end, function() end, BeltalowdaCamp.state.pinLayoutData, nil)
	BeltalowdaCamp.state.initialized = true
	BeltalowdaCamp.SetEnabled(BeltalowdaCamp.cpVars.enabled)
end

function BeltalowdaCamp.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	return defaults
end

function BeltalowdaCamp.SetEnabled(value)
	if BeltalowdaCamp.state.initialized == true and value ~= nil then
		BeltalowdaCamp.cpVars.enabled = value
		if value == true then
			if BeltalowdaCamp.state.alreadyEnabled == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaCamp.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaCamp.OnPlayerActivated)
				EVENT_MANAGER:RegisterForEvent(BeltalowdaCamp.callbackName, EVENT_PLAYER_DEACTIVATED, BeltalowdaCamp.OnPlayerDeactivated)
				BeltalowdaCamp.state.alreadyEnabled = true
			end
		else
			if BeltalowdaCamp.state.alreadyEnabled == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaCamp.callbackName, EVENT_PLAYER_ACTIVATED)
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaCamp.callbackName, EVENT_PLAYER_DEACTIVATED)
				BeltalowdaCamp.state.alreadyEnabled = false
			end
		end
		BeltalowdaCamp.OnPlayerActivated()
	end
end

function BeltalowdaCamp.GetCampId()
	local alliance = GetUnitAlliance("player")
	local campId = 0
	if alliance == ALLIANCE_ALDMERI_DOMINION then
		campId = 29533
	elseif alliance == ALLIANCE_DAGGERFALL_COVENANT then
		campId = 29535
	elseif alliance == ALLIANCE_EBONHEART_PACT then
		campId = 29534
	end
	return campId
end

function BeltalowdaCamp.ShowCamp()
	--d("show loop")
	local updatePosition = true
	local x, y, _ = GetMapPlayerPosition("player")
	if BeltalowdaCamp.state.campPreviewUp == true then
		if BeltalowdaCamp.state.previousCoordinates.x == x and BeltalowdaCamp.state.previousCoordinates.y == y then
			updatePosition = false
		else
			BeltalowdaCamp.HideCamp()
		end
	end
	if updatePosition == true then
		local radius = BeltalowdaCamp.config.zoneRadius
		if GetMapType() == MAPTYPE_SUBZONE then
			radius = BeltalowdaCamp.config.subZoneRadius
		elseif GetMapType() == MAPTYPE_WORLD then
			radius = BeltalowdaCamp.config.worldRadius
		end
		libMapPins:CreatePin(BeltalowdaCamp.config.pinType, BeltalowdaCamp.config.pinTag, x, y, radius)
		--[[
			GetForwardCampPinInfo(number BattlegroundQueryContextType battlegroundContext, number index)
			Returns: number pinType, number normalizedX, number normalizedY, number normalizedRadius (0.026000000536442), boolean useable
			zone:    0.026000000536442
			subZone: 0.52204173803329
		]]
		BeltalowdaCamp.state.previousCoordinates.x = x
		BeltalowdaCamp.state.previousCoordinates.y = y
		BeltalowdaCamp.state.campPreviewUp = true
		--libMapPins:RefreshPins(BeltalowdaCamp.config.pinType)
	end
end

function BeltalowdaCamp.HideCamp()
	libMapPins:RemoveCustomPin(BeltalowdaCamp.config.pinType, BeltalowdaCamp.config.pinTag)
	BeltalowdaCamp.state.campPreviewUp = false
	--libMapPins:RefreshPins(BeltalowdaCamp.config.pinType)
end

--callbacks
function BeltalowdaCamp.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaCamp.cpVars = currentProfile.toolbox.camp
		BeltalowdaCamp.SetEnabled(BeltalowdaCamp.cpVars.enabled)
	end
end

function BeltalowdaCamp.OnPlayerActivated(eventCode, initial)
	if BeltalowdaCamp.cpVars.enabled == true and IsInCyrodiil() == true then
		--d("activated")
		if BeltalowdaCamp.state.registredActivationConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCamp.callbackName, EVENT_ACTIVE_QUICKSLOT_CHANGED, BeltalowdaCamp.OnQuickSlotChanged)
			BeltalowdaCamp.state.registredActivationConsumers = true
		end
		BeltalowdaCamp.OnQuickSlotChanged(EVENT_ACTIVE_QUICKSLOT_CHANGED, GetCurrentQuickslot())
	else
		if BeltalowdaCamp.state.registredActivationConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCamp.callbackName, EVENT_ACTIVE_QUICKSLOT_CHANGED)
			BeltalowdaCamp.state.registredActivationConsumers = false
		end
		if BeltalowdaCamp.state.updateLoopRunning == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaCamp.callbackName)
			BeltalowdaCamp.state.updateLoopRunning = false
		end
		BeltalowdaCamp.HideCamp()
	end
end

function BeltalowdaCamp.OnPlayerDeactivated()
	if BeltalowdaCamp.state.updateLoopRunning == true then
		--d("deactivated")
		EVENT_MANAGER:UnregisterForUpdate(BeltalowdaCamp.callbackName)
		BeltalowdaCamp.state.updateLoopRunning = false
	end
	BeltalowdaCamp.HideCamp()
end

function BeltalowdaCamp.OnQuickSlotChanged(eventCode, slotId)
	--d("quickslot changed")
	--local itemLink = GetSlotItemLink(slotId + 1)
	local itemLink = GetSlotItemLink(slotId)
	if itemLink ~= nil then
		local _, _, _, itemId = ZO_LinkHandler_ParseLink(itemLink)
		--d(itemId)
		if itemId ~= nil and tonumber(itemId) == BeltalowdaCamp.state.campId then
			if BeltalowdaCamp.state.updateLoopRunning == false then
				--d("register for update")
				EVENT_MANAGER:RegisterForUpdate(BeltalowdaCamp.callbackName, BeltalowdaCamp.config.updateInterval, BeltalowdaCamp.ShowCamp)
				BeltalowdaCamp.state.updateLoopRunning = true
			end
		else
			if BeltalowdaCamp.state.updateLoopRunning == true then
				EVENT_MANAGER:UnregisterForUpdate(BeltalowdaCamp.callbackName)
				BeltalowdaCamp.state.updateLoopRunning = false
			end
			BeltalowdaCamp.HideCamp()
		end
	else
		if BeltalowdaCamp.state.updateLoopRunning == true then
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaCamp.callbackName)
			BeltalowdaCamp.state.updateLoopRunning = false
		end
		BeltalowdaCamp.HideCamp()
	end
end

--menu interactions
function BeltalowdaCamp.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.CP_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.CP_ENABLED,
					getFunc = BeltalowdaCamp.GetCampEnabled,
					setFunc = BeltalowdaCamp.SetCampEnabled
				}
			}
		}
	}
	return menu
end

function BeltalowdaCamp.GetCampEnabled()
	return BeltalowdaCamp.cpVars.enabled
end

function BeltalowdaCamp.SetCampEnabled(value)
	BeltalowdaCamp.SetEnabled(value)
end