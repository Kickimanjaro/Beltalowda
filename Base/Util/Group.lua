-- Beltalowda Util Group
-- By @s0rdrak (PC / EU)

--local lib3d = LibStub("Lib3D2")
local lib3d = Lib3D
local libPB = LibPotionBuff
--local libFDB = LibStub("LibFoodDrinkBuff")
local libFDB = LIB_FOOD_DRINK_BUFF

Beltalowda = Beltalowda or {}

Beltalowda.util = Beltalowda.util or {}
Beltalowda.util.group = Beltalowda.util.group or {}
Beltalowda.util.ui = Beltalowda.util.ui or {}
Beltalowda.util.networking = Beltalowda.util.networking or {}
Beltalowda.util.ultimates = Beltalowda.util.ultimates or {}
Beltalowda.util.equipment = Beltalowda.util.equipment  or {}
Beltalowda.util.cp = Beltalowda.util.cp  or {}
Beltalowda.util.sb = Beltalowda.util.sb  or {}
Beltalowda.util.math = Beltalowda.util.math or {}
Beltalowda.util.playerLink = Beltalowda.util.playerLink or {}
Beltalowda.util.chatSystem = Beltalowda.util.chatSystem or {}
Beltalowda.util.versioning = Beltalowda.util.versioning or {}
Beltalowda.util.roster = Beltalowda.util.roster or {}
Beltalowda.menu = Beltalowda.menu or {}


local BeltalowdaUtil = Beltalowda.util
local BeltalowdaGroup = BeltalowdaUtil.group
local BeltalowdaUI = BeltalowdaUtil.ui
local BeltalowdaUltimates = BeltalowdaUtil.ultimates
local BeltalowdaNetworking = BeltalowdaUtil.networking
local BeltalowdaEquip = BeltalowdaUtil.equipment
local BeltalowdaCP = BeltalowdaUtil.cp
local BeltalowdaSB = BeltalowdaUtil.sb
local BeltalowdaMath = BeltalowdaUtil.math
local BeltalowdaPL = BeltalowdaUtil.playerLink
local BeltalowdaChat = BeltalowdaUtil.chatSystem
local BeltalowdaVersioning = BeltalowdaUtil.versioning
local BeltalowdaMenu = Beltalowda.menu
local BeltalowdaRoster = BeltalowdaUtil.roster

BeltalowdaGroup.features = {}
BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE = 1
BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE = 2
BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE = 3
BeltalowdaGroup.features.FEATURE_GROUP_BUFFS = 4
BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES = 5
BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG = 6
BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING = 7
BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES = 8
BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE = 9
BeltalowdaGroup.features.FEATURE_GROUP_NONE = 10
BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY = 11

BeltalowdaGroup.features.state = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].callbackName = Beltalowda.addonName .. "UtilGroupLeaderUpdate"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE].callbackName = Beltalowda.addonName .. "UtilGroupPlayerToMemberDistance"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE].callbackName = Beltalowda.addonName .. "UtilGroupLeaderToPlayerDistance"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_BUFFS] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_BUFFS].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_BUFFS].callbackName = Beltalowda.addonName .. "UtilGroupBuffs"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_BUFFS].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES].callbackName = Beltalowda.addonName .. "UtilGroupResources"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES].activeCustomFeature = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG].callbackName = Beltalowda.addonName .. "UtilGroupHpDmg"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG].activeCustomFeature = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING].callbackName = Beltalowda.addonName .. "UtilGroupVersioning"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING].activeCustomFeature = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES].callbackName = Beltalowda.addonName .. "UtilGroupCoordinates"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE].callbackName = Beltalowda.addonName .. "UtilGroupDeadState"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_NONE] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_NONE].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_NONE].callbackName = Beltalowda.addonName .. "UtilGroupNone"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_NONE].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY] = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY].consumers = {}
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY].callbackName = Beltalowda.addonName .. "UtilGroupSynergy"
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY].activeCallback = false
BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY].activeCustomFeature = false


BeltalowdaGroup.features.stackCount = 0

BeltalowdaGroup.constants = {}
BeltalowdaGroup.constants.BY_CHAR_NAME = 1
BeltalowdaGroup.constants.BY_DISPLAY_NAME = 2
BeltalowdaGroup.constants.displayTypes = {}
BeltalowdaGroup.constants.COMBAT_TIMEOUT = 30000
BeltalowdaGroup.constants.PREFIX = "Group"
BeltalowdaGroup.constants.potionTypes = {}
BeltalowdaGroup.constants.potionTypes.CRAFTED = 1
BeltalowdaGroup.constants.potionTypes.CROWN = 2
BeltalowdaGroup.constants.potionTypes.NON_CRAFTED = 3
BeltalowdaGroup.constants.potionTypes.ALLIANCE = 4

BeltalowdaGroup.constants.roles = {}
BeltalowdaGroup.constants.roles.ROLE_RAPID = 1
BeltalowdaGroup.constants.roles.ROLE_PURGE = 2
BeltalowdaGroup.constants.roles.ROLE_HEAL = 3
BeltalowdaGroup.constants.roles.ROLE_DD = 4
BeltalowdaGroup.constants.roles.ROLE_SYNERGY = 5
BeltalowdaGroup.constants.roles.ROLE_CC = 6
BeltalowdaGroup.constants.roles.ROLE_SUPPORT = 7
BeltalowdaGroup.constants.roles.ROLE_PLACEHOLDER = 8
BeltalowdaGroup.constants.roles.ROLE_APPLICANT = 9

BeltalowdaGroup.state = {}
BeltalowdaGroup.state.leader = {}
BeltalowdaGroup.state.lastCombatTimestamp = 0
BeltalowdaGroup.state.versionCheckCallback = nil
BeltalowdaGroup.state.groupChangedConsumers = {}
BeltalowdaGroup.state.ultimatesChangedConsumers = {}
BeltalowdaGroup.state.adminInformationChangedConsumers = {}
BeltalowdaGroup.state.lastLeader = nil
BeltalowdaGroup.state.crBgTpHealBuffs = nil
BeltalowdaGroup.state.hdmAutoClear = true

BeltalowdaGroup.callbackName = Beltalowda.addonName .. "UtilGroup"

BeltalowdaGroup.config = BeltalowdaGroup.config or {}
BeltalowdaGroup.config.combatUpdateInterval = 250


--abilities
BeltalowdaGroup.abilityIds = {}
--[[
BeltalowdaGroup.abilityIds.rapidManeuver = {
	[1] = 61736-- 101161,
}
BeltalowdaGroup.abilityIds.chargingManeuverMajor = {
	[1] = 61736 -- 101178
}
BeltalowdaGroup.abilityIds.chargingManeuverMinor = {
	[1] = 61735 -- 40219
}
BeltalowdaGroup.abilityIds.retreatingManeuver = {
	[1] = 61736 -- 101169,--/script d(GetAbilityDescription(101169))
}
]]
BeltalowdaGroup.abilityIds.majorExpedition = {
	[1] = 61736
}
BeltalowdaGroup.abilityIds.minorExpedition = {
	[1] = 61735
}
--Likely not woking anymore due to ZOS changing IDs (~U30, adjusted in 2.0.33)
BeltalowdaGroup.abilityIds.immovablePot = {
	[1] = 45239, -- U30+, should not work anymore
	[2] = 72930, -- U30+, should not work anymore
	[3] = 86698, -- U30+, should not work anymore
	[4] = 72930  -- U30+, Only on alliance pots - wtf
}
-- Not working anymore due to ZOS changing IDs (~U30, adjusted in 2.0.33)
BeltalowdaGroup.abilityIds.alliancePot = {
	[72935] = true,
	[72936] = true,
	[72928] = true,
	[72930] = true,
	[72932] = true,
	[72933] = true
}
-- Temporary (2.0.33) Fix for broken LibPotionBuff library (ZOS fault: Changing IDs)
BeltalowdaGroup.abilityIds.isPotion = {
--Positive
	[61698] = true, --"Major Fortitude",
	[61707] = true, --"Major Intellect",
	[61705] = true, --"Major Endurance",
	[45236] = true, --"Increase Detection",
	[45237] = true, --"Invisibility", INFO: Still has a different ID on alliance Potions 136002 (wtf?)
	[72930] = true, --"Unstoppable", INFO: Does not exist on crafted Potions anymore (wtf?)

	[61665] = true, --"Major Brutality",
	[61687] = true, --"Major Sorcery",
	[61736] = true, --"Major Expedition",
	[61667] = true, --"Major Savagery",
	[61689] = true, --"Major Prophecy",

	[79705] = true, --"Lingering Restore Health",
	[61721] = true, --"Minor Protection",
	[61713] = true, --"Major Vitality",
	
	[64564] = true, -- "Physical Resistance Potion",
	[64562] = true, -- "Spell Resistance Potion",
	[61708] = true, -- "Minor Heroism",
	
	-- Negative
	[46113] = true, --"Ravage Health",
	[46193] = true, --"Ravage Magicka",
	[46199] = true, --"Ravage Stamina",
	[79867] = true, --"Minor Cowardice",
	[61723] = true, --"Minor Maim",
	[46206] = true, --"Spell Resistance Reduction",
	[46208] = true, --"Physical Resistance Reduction",
	[46210] = true, --"Hindrance",
	
	[79907] = true, -- "Minor Enervation",
	[140699] = true, -- "Minor Timidity",
	[61726] = true, -- "Minor Defile",
	[79895] = true, -- "Minor Uncertainty",
	[79709] = true, -- "Creeping Ravage Health",
	[79717] = true, -- "Minor Vulnerability",
}

BeltalowdaGroup.abilityIds.proximityDetonation = {
	[61500] = true
}

-- 146919
BeltalowdaGroup.abilityIds.subterraneanAssault = {
	[86019] = true
	
}
BeltalowdaGroup.abilityIds.subterraneanAssaultWaveTwo = {
	[146919] = true
}

BeltalowdaGroup.abilityIds.deepFissure = {
	[86015] = true
}

BeltalowdaGroup.abilityIds.deepFissureWaveTwo = {
	[178028] = true
}
--public functions

function BeltalowdaGroup.Initialize()	
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].callback = BeltalowdaGroup.OnUpdateLeader
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_PLAYER_TO_MEMBER_DISTANCE].callback = BeltalowdaGroup.OnUpdatePlayerDistance
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_TO_MEMBER_DISTANCE].callback = BeltalowdaGroup.OnUpdateLeaderDistance
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_BUFFS].callback = BeltalowdaGroup.OnUpdateBuff
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES].callback = nil
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG].callback = nil
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING].callback = nil
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_COORDINATES].callback = BeltalowdaGroup.OnUpdateCoordinates
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_DEAD_STATE].callback = BeltalowdaGroup.OnUpdateDeadState
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_NONE].callback = nil
	BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY].callback = nil
	
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaGroup.callbackName, BeltalowdaGroup.OnProfileChanged)
end

function BeltalowdaGroup.GetDefaults()
	local defaults = {}
	defaults.displayType = BeltalowdaGroup.constants.BY_CHAR_NAME
	return defaults
end

function BeltalowdaGroup.GetDisplayType()
	return BeltalowdaGroup.groupVars.displayType
end

function BeltalowdaGroup.AddFeature(consumerName, featureName, interval)
	if consumerName ~= nil and featureName ~= nil then
		if BeltalowdaGroup.IsValidFeature(featureName) == true then
			local feature = BeltalowdaGroup.features.state[featureName]
			local consumers = feature.consumers
			local callbackName = feature.callbackName
			local callbackFunction = feature.callback
			
			local entryExists = false
			for i = 1, #consumers do
				if consumers[i].name == consumerName then
					entryExists = true
					break
				end
			end
			if entryExists == false then
				BeltalowdaGroup.features.stackCount = BeltalowdaGroup.features.stackCount + 1
				if BeltalowdaGroup.features.stackCount == 1 then
					BeltalowdaGroup.EnableGroup()
				end
				
				local entry = {}
				entry.name = consumerName
				entry.interval = interval
				--d("reached entry creation")
				if callbackFunction ~= nil and callbackName ~= nil then
					local isMainConsumer = true
					local oldConsumer = 0
					for i = 1, #consumers do
						if consumers[i].isMainConsumer == true then
							if consumers[i].interval <= interval then
								isMainConsumer = false
							end
							oldConsumer = i
						end
					end
					entry.isMainConsumer = isMainConsumer
					if oldConsumer > 0 and isMainConsumer == true then
						consumers[oldConsumer].isMainConsumer = false
					end
					--d("reached this part")
					if isMainConsumer == true then
						if feature.activeCallback == true then
							EVENT_MANAGER:UnregisterForUpdate(callbackName)
							EVENT_MANAGER:RegisterForUpdate(callbackName, interval, callbackFunction)
						else
							EVENT_MANAGER:RegisterForUpdate(callbackName, interval, callbackFunction)
						end
						--d("reached this part 2")
						feature.activeCallback = true
					end
				end
				--d("reached this part 3")
				table.insert(consumers, entry)
				BeltalowdaGroup.AddCustomFeature(featureName)
			end
				
			
		end
	end
end

function BeltalowdaGroup.RemoveFeature(consumerName, featureName)
	if consumerName ~= nil and featureName ~= nil then
		if BeltalowdaGroup.IsValidFeature(featureName) == true then
			local feature = BeltalowdaGroup.features.state[featureName]
			local consumers = feature.consumers
			local callbackName = feature.callbackName
			local callbackFunction = feature.callback
			--if callbackFunction != nil and callbackName ~= nil then
				
			for i = 1, #consumers do
				if consumers[i].name == consumerName then
					local isMainConsumer = consumers[i].isMainConsumer
					local interval = consumers[i].interval
					table.remove(consumers, i)
					BeltalowdaGroup.features.stackCount = BeltalowdaGroup.features.stackCount - 1
					if callbackName ~= nil and callbackFunction ~= nil then
						local isListening = true
						if #consumers == 0 then
							isListening, feature.activeCallback = false, false
							EVENT_MANAGER:UnregisterForUpdate(callbackName)
						end
						if isListening == true and isMainConsumer == true then
							local lowestInterval = consumers[1].interval
							local lowestIndex = 1
							if #consumers > 2 then
								for j = 2, #consumers do
									if consumers[j].interval < lowestInterval then
										lowestInterval = consumers[j].interval
										lowestIndex = j
									end
								end
							end
							consumers[lowestIndex].isMainConsumer = true
							if lowestInterval ~= interval then
								EVENT_MANAGER:UnregisterForUpdate(callbackName)
								EVENT_MANAGER:RegisterForUpdate(callbackName, lowestInterval, callbackFunction)
							end
						end
					end
					BeltalowdaGroup.RemoveCustomFeature(featureName)
					break
				end
			end

			if BeltalowdaGroup.features.stackCount == 0 then
				BeltalowdaGroup.DisableGroup()
			end
		end
	end
end

function BeltalowdaGroup.AddCustomFeature(featureName)
	--d("AddCustomFeature: " .. featureName)
	if BeltalowdaGroup.features.state[featureName].activeCustomFeature == false then
		if featureName == BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES then 
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaGroup.features.state[featureName].callbackName, BeltalowdaGroup.HandleRawResourceNetworkMessage)
		elseif featureName == BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG then 
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaGroup.features.state[featureName].callbackName, BeltalowdaGroup.HandleRawHpDmgNetworkMessage)
			--EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.features.state[featureName].callbackName, EVENT_POWER_UPDATE, BeltalowdaGroup.OnPowerUpdate)
		elseif featureName == BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING then 
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaGroup.features.state[featureName].callbackName, BeltalowdaGroup.HandleRawVersionNetworkMessage)
		elseif featureName == BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY then
			BeltalowdaNetworking.AddRawMessageHandler(BeltalowdaGroup.features.state[featureName].callbackName, BeltalowdaGroup.HandleRawSynergyNetworkMessage)
		end
		BeltalowdaGroup.features.state[featureName].activeCustomFeature = true
	end
end

function BeltalowdaGroup.RemoveCustomFeature(featureName)
	--d("RemoveCustomFeature: " .. featureName)
	if BeltalowdaGroup.features.state[featureName].activeCustomFeature == true then
		if featureName == BeltalowdaGroup.features.FEATURE_GROUP_RESOURCES or
		   featureName == BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG or
		   featureName == BeltalowdaGroup.features.FEATURE_GROUP_VERSIONING or 
		   featureName == BeltalowdaGroup.features.FEATURE_GROUP_SYNERGY then
			BeltalowdaNetworking.RemoveRawMessageHandler(BeltalowdaGroup.features.state[featureName].callbackName)
		end
		if featureName == BeltalowdaGroup.features.FEATURE_GROUP_HP_DMG then
			--EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.features.state[featureName].callbackName, EVENT_POWER_UPDATE)
		end
		BeltalowdaGroup.features.state[featureName].activeCustomFeature = false
	end
end

function BeltalowdaGroup.IsValidFeature(featureName)
	local status = false
	if BeltalowdaGroup.features.state[featureName] ~= nil then
		status = true
	end
	return status
end

function BeltalowdaGroup.GetLeaderDistance()
	if BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].activeCallback == true then
		return BeltalowdaGroup.state.leader.leaderDistance
	else
		return nil
	end
end

function BeltalowdaGroup.GetLeaderRotation()
	if BeltalowdaGroup.features.state[BeltalowdaGroup.features.FEATURE_GROUP_LEADER_DISTANCE].activeCallback == true then
		return BeltalowdaGroup.state.leader.leaderRotation
	else
		return nil
	end
end


function BeltalowdaGroup.GetGroupInformation()
	if BeltalowdaGroup.features.stackCount > 0 then
		return BeltalowdaGroup.state.players
	else
		return nil
	end
end

function BeltalowdaGroup.IsGroupInCombat()
	local inCombat = IsUnitInCombat("player")
	if BeltalowdaGroup.features.stackCount > 0 and inCombat == false then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if IsUnitInCombat(players[i].unitTag) == true then
					inCombat = true
					break
				end
			end
		else
			inCombat = false
		end
	end
	return inCombat
end

function BeltalowdaGroup.IsUnitGroupLeader(unitTag)
	if unitTag == "player" then
		return BeltalowdaGroup.IsPlayerGroupLeader()
	else
		local isLeader = false
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag and players[i].isLeader == true then
					isLeader = true
					break
				end
			end
		end
		return isLeader
	end
end

function BeltalowdaGroup.IsPlayerGroupLeader()
	local isLeader = false
	local players = BeltalowdaGroup.state.players
	if players ~= nil and #players > 1 then
		for i = 1, #players do
			if players[i].charName == GetUnitName("player") and players[i].displayName == GetUnitDisplayName("player") and players[i].isLeader == true then
				isLeader = true
			end
		end
	end
	return isLeader
end

function BeltalowdaGroup.GetPlayerUnitTag()
	local playerTag = "player"
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].charName == GetUnitName("player") and players[i].displayName == GetUnitDisplayName("player") then
				playerTag = players[i].unitTag
				break
			end
		end
	end
	return playerTag
end

function BeltalowdaGroup.GetGroupLeaderUnitTag()
	local leaderTag = nil
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].isLeader == true then
				leaderTag = players[i].unitTag
				break
			end
		end
	end
	return leaderTag
end

function BeltalowdaGroup.UpdateMemberResources(unitTag, ultiId, ultiPercent, magickaPercent, stamPercent)
	local players = BeltalowdaGroup.state.players

	if players ~= nil then
		for i = 1, #players do
			--d(unitTag .. " vs " .. players[i].unitTag)
			if players[i].unitTag == unitTag then
				local debuffs = {}
				
				local ultimate = BeltalowdaMath.DecodeBitArrayHelper(ultiPercent)
				local magicka = BeltalowdaMath.DecodeBitArrayHelper(magickaPercent)
				local stamina = BeltalowdaMath.DecodeBitArrayHelper(stamPercent)
				debuffs[1] = ultimate[8]
				debuffs[2] = magicka[8]
				debuffs[3] = stamina[8]
				ultimate[8] = 0
				magicka[8] = 0
				stamina[8] = 0
				ultimate = BeltalowdaMath.EncodeBitArrayHelper(ultimate, 0)
				magicka = BeltalowdaMath.EncodeBitArrayHelper(magicka, 0)
				stamina = BeltalowdaMath.EncodeBitArrayHelper(stamina, 0)
				debuffs = BeltalowdaMath.EncodeBitArrayHelper(debuffs, 0)
				--d("debuffs ulti: " .. debuffs)
				--d("Group")
				--d(debuffs)
				if players[i].buffs ~= nil and players[i].isPlayer == false then
					--d(debuffs)
					players[i].buffs.numPurgableBuffs = debuffs
				end
				players[i].resources = players[i].resources or {}
				players[i].resources.ultimateId = ultiId
				if ultiId ~= players[i].resources.previousUltimateId then
					BeltalowdaGroup.NotifyUltimatesChangedCallbacks()
				end
				players[i].resources.previousUltimateId = ultiId
				players[i].resources.ultimatePercent = ultimate
				players[i].resources.magickaPercent = magicka
				players[i].resources.staminaPercent = stamina
				players[i].resources.lastPing = GetGameTimeMilliseconds()
				break
			end
		end
	end
end

function BeltalowdaGroup.UpdateMemberDamage(unitTag, damage)
	if unitTag ~= nil and damage ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					local temp = BeltalowdaMath.Int24ToArray(damage)
					local debuffs = {}
					debuffs[1] = temp[22]
					debuffs[2] = temp[23]
					debuffs[3] = temp[24]
					debuffs = BeltalowdaMath.EncodeBitArrayHelper(debuffs, 0)
					--d("debuffs damage: " .. debuffs)
					if players[i].buffs ~= nil and players[i].isPlayer == false then
						--d(debuffs)
						players[i].buffs.numPurgableBuffs = debuffs
					end
					temp[22] = 0
					temp[23] = 0
					temp[24] = 0
					temp = BeltalowdaMath.ArrayToInt24(temp)
					players[i].meter.damage = players[i].meter.damage + temp
					break
				end
			end
		end
	end
end

function BeltalowdaGroup.UpdateMemberHealing(unitTag, healing)
	if unitTag ~= nil and healing ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					local temp = BeltalowdaMath.Int24ToArray(healing)
					local debuffs = {}
					debuffs[1] = temp[22]
					debuffs[2] = temp[23]
					debuffs[3] = temp[24]
					debuffs = BeltalowdaMath.EncodeBitArrayHelper(debuffs, 0)
					--d("debuffs healing: " .. debuffs)
					if players[i].buffs ~= nil and players[i].isPlayer == false then
						--d(debuffs)
						players[i].buffs.numPurgableBuffs = debuffs
					end
					temp[22] = 0
					temp[23] = 0
					temp[24] = 0
					temp = BeltalowdaMath.ArrayToInt24(temp)
					players[i].meter.healing = players[i].meter.healing + temp
					break
				end
			end
		end
	end
end

function BeltalowdaGroup.UpdateMemberVersionInformation(unitTag, versionInformation)
	if unitTag ~= nil and versionInformation ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					players[i].clientVersion.major = versionInformation.major
					players[i].clientVersion.minor = versionInformation.minor
					players[i].clientVersion.revision = versionInformation.revision
					if BeltalowdaGroup.state.versionCheckCallback ~= nil and type(BeltalowdaGroup.state.versionCheckCallback) == "function" then
						BeltalowdaGroup.state.versionCheckCallback(players[i])
					end
					break
				end
			end
		end
	end
end

function BeltalowdaGroup.UpdateMemberSynergy(unitTag, synergyId, delay)
	if unitTag ~= nil and synergyId ~= nil and delay ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					players[i].synergies[synergyId] = GetGameTimeMilliseconds() - delay * 100
					break
				end
			end
		end
	end
end

function BeltalowdaGroup.UpdateDebuffs(unitTag, numDebuffs)
	if unitTag ~= nil and numDebuffs ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					if players[i].buffs ~= nil and players[i].isPlayer == false then
						--d(numDebuffs)
						players[i].buffs.numPurgableBuffs = numDebuffs
						--d(numDebuffs)
					end
					break
				end
			end
		end
	end
end

function BeltalowdaGroup.GetAdjustedNameFromUnitTag(unitTag)
	local name = nil
	if unitTag ~= nil then
		if BeltalowdaGroup.groupVars.displayType == BeltalowdaGroup.constants.BY_CHAR_NAME then
			name = GetUnitName(unitTag)
		elseif BeltalowdaGroup.groupVars.displayType == BeltalowdaGroup.constants.BY_DISPLAY_NAME then
			name = string.sub(GetUnitDisplayName(unitTag), 2)
		end
	end
	return name
end

function BeltalowdaGroup.GetNameLinkFromDisplayCharName(fromName, fromDisplayName)
	local displayType = BeltalowdaGroup.GetDisplayType()
	local link = ""
	if displayType == BeltalowdaGroup.constants.BY_CHAR_NAME and fromName:sub(1,1) ~= "@" then
		fromName = zo_strformat("<<1>>", fromName)
		link = BeltalowdaPL.CreateCharNameLink(fromName, fromName, false)
	else
		link = BeltalowdaPL.CreateDisplayNameLink(fromDisplayName, fromDisplayName, false)
	end
	if link == "" then
		BeltalowdaChat.SendChatMessage("Invalid FromName in GetNameLinkFromDisplayCharName", BeltalowdaGroup.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	end
	return link
end

function BeltalowdaGroup.GetNameFromDisplayCharName(fromName, fromDisplayName)
	local displayType = BeltalowdaGroup.GetDisplayType()
	local name = ""
	if fromName == nil then
		return fromDisplayName
	elseif fromDisplayName == nil then
		return fromName
	end
	if displayType == BeltalowdaGroup.constants.BY_CHAR_NAME and fromName:sub(1,1) ~= "@" then
		name = fromName
	else
		name = fromDisplayName
	end
	return name
end

function BeltalowdaGroup.IsCharNameInGroup(charName)
	local inGroup = false
	if charName ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].charName == charName then
					inGroup = true
					break
				end
			end
		end
	end
	return inGroup
end

function BeltalowdaGroup.GetUnitTagFromCharName(charName)
	local unitTag = nil
	if charName ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].charName == charName then
					unitTag = players[i].unitTag
					break
				end
			end
		end
	end
	return unitTag
end

function BeltalowdaGroup.GetUnitTagFromRawCharName(charName)
	local unitTag = nil
	if charName ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].rawName == charName then
					unitTag = players[i].unitTag
					break
				end
			end
		end
	end
	return unitTag
end

function BeltalowdaGroup.GetUnitFromRawCharName(charName)
	local player = nil
	if charName ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].rawName == charName then
					player = players[i]
					break
				end
			end
		end
	end
	return player
end

function BeltalowdaGroup.AdjustBgGroup()
	if IsActiveWorldBattleground() and BeltalowdaGroup.state.lastLeader ~= nil then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].name == BeltalowdaGroup.state.lastLeader.name and players[i].displayName == BeltalowdaGroup.state.lastLeader.displayName then
					players[i].isLeader = true
				else
					players[i].isLeader = false
				end
			end
		end
	end
end

function BeltalowdaGroup.SetBgCrown(charName, displayName)
	if IsActiveWorldBattleground() then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].charName == charName and players[i].displayName == displayName then
					players[i].isLeader = true
				else
					players[i].isLeader = false
				end
			end
		end
	end
end

function BeltalowdaGroup.RemoveBgCrown(charName, displayName)
	if IsActiveWorldBattleground() then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].charName == charName and players[i].displayName == displayName then
					players[i].isLeader = false
				end
			end
		end
	end
end

function BeltalowdaGroup.SetRole(charName, displayName, role)
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].charName == charName and players[i].displayName == displayName then
				players[i].role = role
				break
			end
		end
	end
end

function BeltalowdaGroup.SetVersionCheckCallback(checkFunction)
	BeltalowdaGroup.state.versionCheckCallback = checkFunction
end


function BeltalowdaGroup.AddAdminInformationChangedCallback(name, callback)
	if name ~= nil and callback ~= nil then
		local entryPresent = false
		for i = 1, #BeltalowdaGroup.state.adminInformationChangedConsumers do
			if BeltalowdaGroup.state.adminInformationChangedConsumers[i] ~= nil and BeltalowdaGroup.state.adminInformationChangedConsumers[i].name == name then
				entryPresent = true
				break
			end
		end
		if entryPresent == false then
			local entry = {}
			entry.callback = callback
			entry.name = name
			table.insert(BeltalowdaGroup.state.adminInformationChangedConsumers, entry)
		end
	end
end

function BeltalowdaGroup.RemoveAdminInformationChangedCallback(name)
	if name ~= nil then
		for i = 1, #BeltalowdaGroup.state.adminInformationChangedConsumers do
			if BeltalowdaGroup.state.adminInformationChangedConsumers[i] ~= nil and BeltalowdaGroup.state.adminInformationChangedConsumers[i].name == name then
				table.remove(BeltalowdaGroup.state.adminInformationChangedConsumers, i)
				break
			end
		end
	end
end

function BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(unitTag)
	for i = 1, #BeltalowdaGroup.state.adminInformationChangedConsumers do
		if BeltalowdaGroup.state.adminInformationChangedConsumers[i] ~= nil and BeltalowdaGroup.state.adminInformationChangedConsumers[i].callback ~= nil and type(BeltalowdaGroup.state.adminInformationChangedConsumers[i].callback) == "function" then
			BeltalowdaGroup.state.adminInformationChangedConsumers[i].callback(unitTag)
		end
	end
end

function BeltalowdaGroup.AddUltimatesChangedCallback(name, callback)
	if name ~= nil and callback ~= nil then
		local entryPresent = false
		for i = 1, #BeltalowdaGroup.state.ultimatesChangedConsumers do
			if BeltalowdaGroup.state.ultimatesChangedConsumers[i] ~= nil and BeltalowdaGroup.state.ultimatesChangedConsumers[i].name == name then
				entryPresent = true
				break
			end
		end
		if entryPresent == false then
			local entry = {}
			entry.callback = callback
			entry.name = name
			table.insert(BeltalowdaGroup.state.ultimatesChangedConsumers, entry)
		end
	end
end

function BeltalowdaGroup.RemoveUltimatesChangedCallback(name)
	if name ~= nil then
		for i = 1, #BeltalowdaGroup.state.ultimatesChangedConsumers do
			if BeltalowdaGroup.state.ultimatesChangedConsumers[i] ~= nil and BeltalowdaGroup.state.ultimatesChangedConsumers[i].name == name then
				table.remove(BeltalowdaGroup.state.ultimatesChangedConsumers, i)
				break
			end
		end
	end
end

function BeltalowdaGroup.NotifyUltimatesChangedCallbacks()
	for i = 1, #BeltalowdaGroup.state.ultimatesChangedConsumers do
		if BeltalowdaGroup.state.ultimatesChangedConsumers[i] ~= nil and BeltalowdaGroup.state.ultimatesChangedConsumers[i].callback ~= nil and type(BeltalowdaGroup.state.groupChangedConsumers[i].callback) == "function" then
			BeltalowdaGroup.state.ultimatesChangedConsumers[i].callback()
		end
	end
end

function BeltalowdaGroup.AddGroupChangedCallback(name, callback)
	if name ~= nil and callback ~= nil then
		local entryPresent = false
		for i = 1, #BeltalowdaGroup.state.groupChangedConsumers do
			if BeltalowdaGroup.state.groupChangedConsumers[i] ~= nil and BeltalowdaGroup.state.groupChangedConsumers[i].name == name then
				entryPresent = true
				break
			end
		end
		if entryPresent == false then
			local entry = {}
			entry.callback = callback
			entry.name = name
			table.insert(BeltalowdaGroup.state.groupChangedConsumers, entry)
		end
	end
end

function BeltalowdaGroup.RemoveGroupChangedCallback(name)
	if name ~= nil then
		for i = 1, #BeltalowdaGroup.state.groupChangedConsumers do
			if BeltalowdaGroup.state.groupChangedConsumers[i] ~= nil and BeltalowdaGroup.state.groupChangedConsumers[i].name == name then
				table.remove(BeltalowdaGroup.state.groupChangedConsumers, i)
				break
			end
		end
	end
end

function BeltalowdaGroup.NotifyGroupChangedCallbacks()
	for i = 1, #BeltalowdaGroup.state.groupChangedConsumers do
		if BeltalowdaGroup.state.groupChangedConsumers[i] ~= nil and BeltalowdaGroup.state.groupChangedConsumers[i].callback ~= nil and type(BeltalowdaGroup.state.groupChangedConsumers[i].callback) == "function" then
			BeltalowdaGroup.state.groupChangedConsumers[i].callback()
		end
	end
end

--internal functions
function BeltalowdaGroup.GetCurrentPlainGroup()
	local players = {}
	local unitTags = BeltalowdaGroup.GetUnitTags()
	for i = 1, #unitTags do
		players[i] = {}
		players[i].unitTag = unitTags[i]
		players[i].name = BeltalowdaGroup.GetAdjustedNameFromUnitTag(unitTags[i])
		players[i].charName = GetUnitName(unitTags[i])
		players[i].rawName = GetRawUnitName(unitTags[i])
		players[i].displayName = GetUnitDisplayName(unitTags[i])
		if GetUnitDisplayName(unitTags[i]) == GetUnitDisplayName("player") and GetUnitName(unitTags[i]) == GetUnitName("player") then
			players[i].isPlayer = true
			players[i].clientVersion = BeltalowdaVersioning.GetVersionArray(Beltalowda.versionString)
		else
			players[i].isPlayer = false
			players[i].clientVersion = {}
			players[i].clientVersion.major = 0
			players[i].clientVersion.minor = 0
			players[i].clientVersion.revision = 0
		end
		players[i].isLeader = IsUnitGroupLeader(unitTags[i])
		players[i].isOnline = IsUnitOnline(unitTags[i])
		players[i].buffs = {}
		players[i].buffs.numPurgableBuffs = 0
		players[i].distances = {}
		players[i].distances.fromPlayer = 0
		players[i].distances.fromLeader = 0
		players[i].coordinates = {}
		players[i].coordinates.x = 0
		players[i].coordinates.y = 0
		players[i].coordinates.height = 0
		players[i].coordinates.worldX = 0
		players[i].coordinates.worldY = 0
		players[i].coordinates.worldHeight = 0
		players[i].resources = {}
		players[i].resources.lastPing = 0
		players[i].meter = {}
		players[i].meter.damage = 0
		players[i].meter.healing = 0

		players[i].clientVersion.versionAlertSent = false
		players[i].admin = {}
		players[i].synergies = {}
		players[i].isDead = IsUnitDead(unitTag)
		players[i].isReincarnating = IsUnitReincarnating(unitTag)
		players[i].isBeingResurrected = IsUnitBeingResurrected(unitTag)
		players[i].role = nil
		players[i].isInCombat = false
		players[i].isInStealth = 0
		players[i].lastKnownHealth = GetUnitPower(players[i].unitTag, POWERTYPE_HEALTH)
	end
	return players
end

function BeltalowdaGroup.InitializeGroup()
	BeltalowdaGroup.state.players = {}
	BeltalowdaGroup.state.players = BeltalowdaGroup.GetCurrentPlainGroup()
	
	
end

function BeltalowdaGroup.ClearGroup()
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			players[i].unitTag = nil
			players[i].name = nil
			players[i].charName = nil
			players[i].rawName = nil
			players[i].displayName = nil
			players[i].isPlayer = nil
			players[i].isLeader = nil
			players[i].isOnline = nil
			players[i].buffs = nil
			players[i].buffs.numPurgableBuffs = nil
			players[i].distances = nil
			players[i].distances.fromPlayer = nil
			players[i].distances.fromLeader = nil
			players[i].coordinates.x = nil
			players[i].coordinates.y = nil
			players[i].coordinates.height = nil
			players[i].coordinates.worldX = nil
			players[i].coordinates.worldY = nil
			players[i].coordinates.worldHeight = nil
			players[i].coordinates = nil
			players[i].resources.lastPing = nil
			players[i].resources = nil
			players[i].meter.damage = nil
			players[i].meter.healing = nil
			players[i].meter = nil
			players[i].isInCombat = nil
			players[i].isInStealth = nil
			players[i].clientVersion.major = nil
			players[i].clientVersion.minor = nil
			players[i].clientVersion.revision = nil
			players[i].clientVersion.versionAlertSent = nil
			players[i].clientVersion = nil
			players[i].admin = nil
			players[i].synergies = nil
			players[i].isDead = nil
			players[i].isReincarnating = nil
			players[i].isBeingResurrected = nil
			players[i].role = nil
			players[i].lastKnownHealth = nil
			players[i] = nil
			
		end
	end
end

function BeltalowdaGroup.UpdateGroup()
	local oldPlayers = BeltalowdaGroup.state.players
	local newPlayers = BeltalowdaGroup.GetCurrentPlainGroup()
	for i = 1, #newPlayers do
		local newPlayer = newPlayers[i]
		for j = 1, #oldPlayers do
			
			local oldPlayer = oldPlayers[j]
			if newPlayer.displayName == oldPlayer.displayName and newPlayer.charName == oldPlayer.charName then
				newPlayer.buffs = oldPlayer.buffs
				newPlayer.distances = oldPlayer.distances
				newPlayer.resources = oldPlayer.resources
				newPlayer.meter = oldPlayer.meter
				newPlayer.admin = oldPlayer.admin
				newPlayer.synergies = oldPlayer.synergies
				newPlayer.clientVersion = oldPlayer.clientVersion
				newPlayer.role = oldPlayer.role
			end
		end
	end
	BeltalowdaGroup.state.players = newPlayers
	BeltalowdaGroup.NotifyGroupChangedCallbacks()
end

function BeltalowdaGroup.EnableGroup()
	BeltalowdaGroup.ClearGroup()
	BeltalowdaGroup.InitializeGroup()
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_CONNECTED_STATUS, BeltalowdaGroup.GroupMemberOnConnectedStatus)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_JOINED, BeltalowdaGroup.GroupMemberOnJoined)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_LEFT, BeltalowdaGroup.GroupMemberOnLeft)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_UPDATE, BeltalowdaGroup.GroupMemberOnUpdate)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_LEADER_UPDATE, BeltalowdaGroup.GroupMemberOnLeaderUpdate)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaGroup.GroupMemberOnPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaGroup.callbackName, EVENT_PLAYER_DEACTIVATED, BeltalowdaGroup.GroupMemberOnPlayerDeactivated)
	EVENT_MANAGER:RegisterForUpdate(BeltalowdaGroup.callbackName, BeltalowdaGroup.config.combatUpdateInterval, BeltalowdaGroup.UpdateStatusLoop)
end

function BeltalowdaGroup.DisableGroup()
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_CONNECTED_STATUS)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_JOINED)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_MEMBER_LEFT)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_GROUP_UPDATE)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_LEADER_UPDATE)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_PLAYER_ACTIVATED)
	EVENT_MANAGER:UnregisterForEvent(BeltalowdaGroup.callbackName, EVENT_PLAYER_DEACTIVATED)
	EVENT_MANAGER:UnregisterForUpdate(BeltalowdaGroup.callbackName)
	BeltalowdaGroup.ClearGroup()
end



function BeltalowdaGroup.GetUnitTags()
	local unitTags = {}
	local groupSize = GetGroupSize()
	if groupSize > 0 then
		for i = 1, groupSize do
			unitTags[i] = GetGroupUnitTagByIndex(i)
		end
	else
		unitTags[1] = "player"
	end
	return unitTags
end

function BeltalowdaGroup.GetUnitTagForPlayer()
	local unitTag = "player"
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].displayName == GetUnitDisplayName("player") and players[i].charName == GetUnitName("player") then
				unitTag = players[i].unitTag
				break
			end
		end
	end
	return unitTag
end

function BeltalowdaGroup.SortBuffLists(list)
	if list ~= nil then
		
		local itemCount = #list
		repeat
			local hasChanged = false
			itemCount=itemCount - 1
			for i = 1, itemCount do
				--d("sort loop")
				if list[i].name > list[i + 1].name then
					list[i], list[i + 1] = list[i + 1], list[i]
					hasChanged = true
				end
			end
		until hasChanged == false
		return list
	end
	return nil
end

function BeltalowdaGroup.CheckForAbilityActive(buffs, buff, abilityIds, alreadyUp)
	if alreadyUp == nil then
		alreadyUp = false
	end
	local abilityPresent = alreadyUp
	if abilityPresent == false then
		for i = 1, #abilityIds do
			if buff.abilityId == abilityIds[i] then
				abilityPresent = true
				--d("identified")
				break
			end
		end
	end
	return abilityPresent
end

function BeltalowdaGroup.CheckForAbility(buffs, buff, abilityIds, alreadyUp)
	if alreadyUp == nil then
		alreadyUp = false
	end
	local abilityPresent = alreadyUp
	local identified = false
	for i = 1, #abilityIds do
		if buff.abilityId == abilityIds[i] then
			abilityPresent = true
			identified = true
			--d("identified")
			break
		end
	end
	return abilityPresent, identified
end

function BeltalowdaGroup.CheckForPotions(buffs, buff)
	local isImmovable = BeltalowdaGroup.CheckForAbilityActive(buffs, buff, BeltalowdaGroup.abilityIds.immovablePot, buffs.specialInformation.potion.immovablePot)
	if buffs.specialInformation.potion.immovablePot == false then
		buffs.specialInformation.potion.immovablePot = isImmovable
		if isImmovable == true then
			buffs.specialInformation.potion.immovableStart = buff.started
			buffs.specialInformation.potion.immovableEnd = buff.ending
			buffs.specialInformation.potion.started = buff.started
		else
			buffs.specialInformation.potion.immovableStart = nil
			buffs.specialInformation.potion.immovableEnd = nil
			
			-- U30+ Change (Temporary Fix)
			--[[
			if libPB.IS_CRAFTED_POTION_BUFF[buff.abilityId] == true or libPB.IS_NON_CRAFTED_POTION_BUFF[buff.abilityId] == true or libPB.IS_CROWNSTORE_POTION_BUFF[buff.abilityId] == true then
				buffs.specialInformation.potion.started = buff.started
			end
			]]
			if BeltalowdaGroup.abilityIds.isPotion[buff.abilityId] == true then
				buffs.specialInformation.potion.started = buff.started
			end
		end
		--d(buff.abilityId)
		-- U30+ Change (Temporary Fix)
		--[[
		if libPB.IS_CRAFTED_POTION_BUFF[buff.abilityId] == true then
			buffs.specialInformation.potion.type = BeltalowdaGroup.constants.potionTypes.CRAFTED
		elseif libPB.IS_NON_CRAFTED_POTION_BUFF[buff.abilityId] == true then
			buffs.specialInformation.potion.type = BeltalowdaGroup.constants.potionTypes.NON_CRAFTED
		elseif libPB.IS_CROWNSTORE_POTION_BUFF[buff.abilityId] == true then
			buffs.specialInformation.potion.type = BeltalowdaGroup.constants.potionTypes.CROWN
		end
		if BeltalowdaGroup.abilityIds.alliancePot[buff.abilityId] == true then
			buffs.specialInformation.potion.type = BeltalowdaGroup.constants.potionTypes.ALLIANCE
		end
		]]
		if BeltalowdaGroup.abilityIds.isPotion[buff.abilityId] == true then
			buffs.specialInformation.potion.type = BeltalowdaGroup.constants.potionTypes.CRAFTED
		end
	end
	
end

function BeltalowdaGroup.CheckForFoodDrinks(buffs, buff)
	buffs.specialInformation.foodDrink = buffs.specialInformation.foodDrink or {}
	--d(buff.abilityId)
	--d(libFDB)
	--d(libFDB.IS_FOOD_BUFF[buff.abilityId])
	--d("------")
	--d(libFDB:IsAbilityADrinkBuff(buff.abilityId))
	if libFDB:IsAbilityADrinkBuff(buff.abilityId) ~= nil then
		--d("Food identified")
		buffs.specialInformation.foodDrink.started = buff.started
		buffs.specialInformation.foodDrink.ending = buff.ending
		buffs.specialInformation.foodDrink.active = true
		--d(buff.abilityId)
	end
end

function BeltalowdaGroup.AdjustRapidValues(buffs, buff, abilityIds, rapidMorph)
	local active, identified = BeltalowdaGroup.CheckForAbility(buffs, buff, abilityIds, rapidMorph.active)
	if rapidMorph.active == false and identified == true then
		--d(buff.abilityId)
		rapidMorph.active = active
		rapidMorph.started = buff.started
		rapidMorph.ending = buff.started + 8 -- buff.ending -- result of ending = 30 secs instead of 8
		rapidMorph.uptime = rapidMorph.ending - buff.started
		--d(buff.ending)
	end
end

function BeltalowdaGroup.CheckForRapid(buffs, buff)
	--[[
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.rapidManeuver, buffs.specialInformation.rapidManeuverOn)
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.chargingManeuverMajor, buffs.specialInformation.chargingManeuverMajorOn)
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.chargingManeuverMinor, buffs.specialInformation.chargingManeuverMinorOn)
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.retreatingManeuver, buffs.specialInformation.retreatingManeuverOn)
	]]
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.majorExpedition, buffs.specialInformation.majorExpeditionOn)
	BeltalowdaGroup.AdjustRapidValues(buffs, buff, BeltalowdaGroup.abilityIds.minorExpedition, buffs.specialInformation.minorExpeditionOn)
end

function BeltalowdaGroup.CheckForShalk(buffs, buff)
	if BeltalowdaGroup.abilityIds.subterraneanAssault[buff.abilityId] == true then
		buffs.specialInformation.subterraneanAssault.active = true
		buffs.specialInformation.subterraneanAssault.started = buff.started
		buffs.specialInformation.subterraneanAssault.ending = buff.ending
		buffs.specialInformation.subterraneanAssault.waveTwo = false
		--d(buff.started)
	elseif BeltalowdaGroup.abilityIds.subterraneanAssaultWaveTwo[buff.abilityId] == true then
		buffs.specialInformation.subterraneanAssault.active = true
		buffs.specialInformation.subterraneanAssault.started = buff.started
		buffs.specialInformation.subterraneanAssault.ending = buff.ending
		buffs.specialInformation.subterraneanAssault.waveTwo = true
	elseif BeltalowdaGroup.abilityIds.deepFissure[buff.abilityId] == true then
		buffs.specialInformation.deepFissure.active = true
		buffs.specialInformation.deepFissure.started = buff.started
		buffs.specialInformation.deepFissure.ending = buff.ending
		buffs.specialInformation.deepFissure.waveTwo = false
	elseif BeltalowdaGroup.abilityIds.deepFissureWaveTwo[buff.abilityId] == true then
		buffs.specialInformation.deepFissure.active = true
		buffs.specialInformation.deepFissure.started = buff.started
		buffs.specialInformation.deepFissure.ending = buff.ending
		buffs.specialInformation.deepFissure.waveTwo = true
	end
	
end

function BeltalowdaGroup.CheckForProximityDetonation(buffs, buff)
	if BeltalowdaGroup.abilityIds.proximityDetonation[buff.abilityId] == true then
		buffs.specialInformation.proximityDetonation.active = true
		buffs.specialInformation.proximityDetonation.started = buff.started
		buffs.specialInformation.proximityDetonation.ending = buff.ending
	end
end

function BeltalowdaGroup.RunSpecialChecks(buffs, buff)
	BeltalowdaGroup.CheckForRapid(buffs, buff)
	BeltalowdaGroup.CheckForPotions(buffs, buff)
	BeltalowdaGroup.CheckForFoodDrinks(buffs, buff)
	BeltalowdaGroup.CheckForProximityDetonation(buffs, buff)
	BeltalowdaGroup.CheckForShalk(buffs, buff)
end

function BeltalowdaGroup.GetLeaderUnitTag()
	local players = BeltalowdaGroup.state.players
	local unitTag = "player"
	if players ~= nil then
		for i = 1, #players do
			if players[i].isLeader == true then
				unitTag = players[i].unitTag
				break
			end
		end
	end
	return unitTag
end

function BeltalowdaGroup.GetLeaderUnit()
	local entry = nil
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].isLeader == true then
				entry = players[i]
				break
			end
		end
	end
	return entry
end

function BeltalowdaGroup.CalculateGroupDistances(unitTag, field)
	if unitTag ~= nil and field ~= nil then
		local players = BeltalowdaGroup.state.players
		local x, y = nil, nil
		local playerX, playerY = nil, nil
		if lib3d:IsValidZone() then
			x, y = GetMapPlayerPosition(unitTag)
			if x ~= nil and x ~= 0 and y ~= nil and y ~= 0 then
				playerX, playerY = lib3d:LocalToWorld(x, y)
			end
		end
		for i = 1, #players do
			if lib3d:IsValidZone() then
				if IsUnitGrouped("player") == true then
					local x, y = GetMapPlayerPosition(players[i].unitTag)
					if x ~= nil and y ~= nil and x ~= 0 and y ~= 0 then
						local memberX, memberY = lib3d:LocalToWorld(x, y)
						if playerX ~= nil and playerY ~= nil and memberX ~= nil and memberY ~= nil then
							local distanceX = playerX - memberX
							local distanceY = playerY - memberY
							players[i].distances[field] = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
						else
							players[i].distances[field] = nil
						end
					end
				else
					players[i].distances[field] = 0
				end
			else
				players[i].distances[field] = nil
			end
		end
	end
end

function BeltalowdaGroup.UpdateDisplayNames()
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			players[i].name = BeltalowdaGroup.GetAdjustedNameFromUnitTag(players[i].unitTag)
		end
	end
	BeltalowdaGroup.NotifyGroupChangedCallbacks()
end

function BeltalowdaGroup.ClearDamageHealingMeter()
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			players[i].meter.damage = 0
			players[i].meter.healing = 0
		end
	end
end

function BeltalowdaGroup.GetPlayerByUnitTag(unitTag)
	local player = nil
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].unitTag == unitTag then
				player = players[i]
				break
			end
		end
	end
	return player
end

function BeltalowdaGroup.SetCrBgTpHealBuffs(buffs)
	local newBuffs = {}
	if buffs ~= nil then
		for i = 1, #buffs do
			for j = 1, #buffs[i].ids do
				newBuffs[buffs[i].ids[j]] = buffs[i].name
			end
		end
	end
	BeltalowdaGroup.state.crBgTpHealBuffs = newBuffs
end

function BeltalowdaGroup.CheckCrBgTpHealBuff(buffs, buff)
	--buff.name, buff.started, buff.ending, buff.slot, buff.stackCount, buff.iconFilename, buff.buffType, buff.effectType, buff.abilityType, buff.statusEffectType, buff.abilityId, buff.canClickOff, buff.castByPlayer
	local item = BeltalowdaGroup.state.crBgTpHealBuffs[buff.abilityId]
	if item ~= nil then
		
		buffs.specialInformation.crBgTpHealBuffs[item] = buffs.specialInformation.crBgTpHealBuffs[item] or {}
		buffs.specialInformation.crBgTpHealBuffs[item].started = buff.started
		buffs.specialInformation.crBgTpHealBuffs[item].ending = buff.ending
		--buffs.specialInformation.crBgTpHealBuffs[item].remaining = buff.ending - (GetGameTimeMilliseconds() / 1000)
		--if buffs.specialInformation.crBgTpHealBuffs[item].remaining < 0 then
		--	buffs.specialInformation.crBgTpHealBuffs[item].remaining = 0
		--end
		--buffs.specialInformation.crBgTpHealBuffs[item].active = true
	end
end

--Admin Functionality
function BeltalowdaGroup.SetAdminMundusInformation(index)
	local player = BeltalowdaGroup.state.players[index]
	if player ~= nil then
		player.admin = player.admin or {}
		player.admin.mundus = player.admin.mundus or {}
		local filter = Beltalowda.admin.constants.config.MUNDUS_FILTER
		local buffs = GetNumBuffs(player.unitTag)
		local stoneIndex = 1
		player.admin.mundus.stone1 = "-"
		player.admin.mundus.stone2 = "-"
		for i = 1, buffs do
			local name, _, _, _, _, _, _, _, _, _, _, _, _ = GetUnitBuffInfo(player.unitTag, i)
			if string.match(name, filter) then
				player.admin.mundus["stone" .. stoneIndex] = zo_strformat("<<1>>", string.gsub(name, filter, ""))
				stoneIndex = stoneIndex + 1
			end
		end
	end
end

function BeltalowdaGroup.RetrieveAdminMundusInformation(index)
	--d(index)
	if index ~= nil and index >= 1 and index <= 24 and #BeltalowdaGroup.state.players >= index then
		BeltalowdaGroup.SetAdminMundusInformation(index)
	elseif index ~= nil and (index == 25 or index == 0) then
		for i = 1, #BeltalowdaGroup.state.players do
			BeltalowdaGroup.SetAdminMundusInformation(i)
		end
	end
	if BeltalowdaGroup.state.players[index] ~= nil then
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(BeltalowdaGroup.state.players[index].unitTag)
	end
end

--Admin Networking
function BeltalowdaGroup.HandleAdminAoeResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		player.admin = player.admin or {}
		player.admin.client = player.admin.client or {}
		player.admin.client.aoe = {}
		player.admin.client.aoe.tellsEnabled = BeltalowdaMath.BitToBoolean(bitfield[7])
		player.admin.client.aoe.customColorEnabled = BeltalowdaMath.BitToBoolean(bitfield[8])
		bitfield[7] = 0
		bitfield[8] = 0
		player.admin.client.aoe.friendlyBrightness = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		player.admin.client.aoe.enemyBrightness = message.b2
		
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminSoundResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b1)
		player.admin = player.admin or {}
		player.admin.client = player.admin.client or {}
		player.admin.client.sound = {}
		player.admin.client.sound.soundEnabled = BeltalowdaMath.BitToBoolean(bitfield[8])
		bitfield[8] = 0
		player.admin.client.sound.audioVolume = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		player.admin.client.sound.uiVolume = message.b2
		player.admin.client.sound.sfxVolume = message.b3
		
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminGraphicsResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
		local messageIdentifier = BeltalowdaMath.EncodeBitArrayHelper(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(3), 3, 22, 1),0)
		player.admin = player.admin or {}
		player.admin.client = player.admin.client or {}
		player.admin.client.graphics = player.admin.client.graphics or {}
		--d(message)
		if messageIdentifier == BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_1 then
			BeltalowdaGroup.HandleAdminGraphicsMessage1(player, message, bitfield)
		elseif messageIdentifier == BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_2 then
			BeltalowdaGroup.HandleAdminGraphicsMessage2(player, message, bitfield)
		elseif messageIdentifier == BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_3 then
			BeltalowdaGroup.HandleAdminGraphicsMessage3(player, message, bitfield)
		elseif messageIdentifier == BeltalowdaNetworking.messageIdentifiers.adminResponse.graphics.MESSAGE_4 then
			BeltalowdaGroup.HandleAdminGraphicsMessage4(player, message, bitfield)
		end
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminGraphicsMessage1(player, message, bitfield)
	local graphics = player.admin.client.graphics
	
	graphics.windowMode = BeltalowdaMath.EncodeBitArrayHelper(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(2), 2, 19, 1), 0)
	graphics.vsync = BeltalowdaMath.BitToBoolean(bitfield[21])
	
	graphics.resWidth = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 18, 1, 1))
	--d("-----")
	--d(bitfield)
end

function BeltalowdaGroup.HandleAdminGraphicsMessage2(player, message, bitfield)
	local graphics = player.admin.client.graphics
	
	graphics.antiAliasing = BeltalowdaMath.BitToBoolean(bitfield[19])
	graphics.ambient = BeltalowdaMath.BitToBoolean(bitfield[20])
	graphics.bloom = BeltalowdaMath.BitToBoolean(bitfield[21])
	
	graphics.resHeight = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 18, 1, 1))

end

function BeltalowdaGroup.HandleAdminGraphicsMessage3(player, message, bitfield)
	local graphics = player.admin.client.graphics
	
	graphics.depthOfField = BeltalowdaMath.BitToBoolean(bitfield[19])
	graphics.distortion = BeltalowdaMath.BitToBoolean(bitfield[20])
	graphics.sunlight = BeltalowdaMath.BitToBoolean(bitfield[21])
	
	graphics.particleMaximum = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 11, 1, 1)) + 768
	graphics.particleSupressDistance = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 7, 12, 1))

end

function BeltalowdaGroup.HandleAdminGraphicsMessage4(player, message, bitfield)
	local graphics = player.admin.client.graphics
	
	graphics.allyEffects = BeltalowdaMath.BitToBoolean(bitfield[18])
	
	graphics.viewDistance = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 7, 1, 1))
	graphics.reflectionQuality = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 2, 8, 1))
	graphics.shadowQuality = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 3, 10, 1))
	graphics.reflectionQuality = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 2, 13, 1))
	graphics.graphicPresets = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 3, 15, 1))
	graphics.subsamplingQuality = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 2, 19, 1))
end

function BeltalowdaGroup.HandleAdminAddonResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_1 then
			BeltalowdaGroup.HandleAdminAddon1Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_2 then
			BeltalowdaGroup.HandleAdminAddon2Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_3 then
			BeltalowdaGroup.HandleAdminAddon3Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_4 then
			BeltalowdaGroup.HandleAdminAddon4Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_5 then
			BeltalowdaGroup.HandleAdminAddon5Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_6 then
			BeltalowdaGroup.HandleAdminAddon6Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_7 then
			BeltalowdaGroup.HandleAdminAddon7Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8 then
			BeltalowdaGroup.HandleAdminAddon8Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_9 then
			BeltalowdaGroup.HandleAdminAddon9Response(player, message)
		end
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminAddon1Response(player, message)
	--Crown / debuff overview / rapid tracker / health, damage overview / potion overview
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	--d(bitfield)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.crown = {}
	player.admin.addon.dbo = {}
	player.admin.addon.rt = {}
	player.admin.addon.hdm = {}
	player.admin.addon.po = {}
	
	--crown
	player.admin.addon.crown.enabled = BeltalowdaMath.BitToBoolean(bitfield[24])
	
	local tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 10, 9, 1)
	player.admin.addon.crown.size = BeltalowdaMath.ArrayToInt24(tempField)
	
	tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 5, 19, 1)
	player.admin.addon.crown.selectedCrown = BeltalowdaMath.ArrayToInt24(tempField)
	
	--hdm
	player.admin.addon.hdm.windowEnabled = BeltalowdaMath.BitToBoolean(bitfield[3])
	player.admin.addon.hdm.enabled = BeltalowdaMath.BitToBoolean(bitfield[4])
	
	tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 2, 1, 1)
	player.admin.addon.hdm.viewMode = BeltalowdaMath.EncodeBitArrayHelper(tempField, 0)
	
	--dbo, rt, po
	player.admin.addon.dbo.enabled = BeltalowdaMath.BitToBoolean(bitfield[5])
	player.admin.addon.rt.enabled = BeltalowdaMath.BitToBoolean(bitfield[6])
	player.admin.addon.po.soundEnabled = BeltalowdaMath.BitToBoolean(bitfield[7])
	player.admin.addon.po.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
	
	
end

function BeltalowdaGroup.HandleAdminAddon2Response(player, message)
	--ftcv [pt.1]
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.ftcv = player.admin.addon.ftcv or {}
	
	player.admin.addon.ftcv.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
	
	local tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 7, 9, 1)
	player.admin.addon.ftcv.sizeClose = BeltalowdaMath.EncodeBitArrayHelper(tempField, 0)
	
	tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 7, 1, 1)
	player.admin.addon.ftcv.sizeFar = BeltalowdaMath.EncodeBitArrayHelper(tempField, 0)
	
	tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 3, 22, 1)
	player.admin.addon.ftcv.minDistance = BeltalowdaMath.EncodeBitArrayHelper(tempField, 0)
	
	tempField = BeltalowdaMath.CreateEmptyBitfield(24)
	tempField = BeltalowdaMath.CopyBitfieldRange(bitfield, tempField, 5, 17, 1)
	player.admin.addon.ftcv.maxDistance = BeltalowdaMath.EncodeBitArrayHelper(tempField, 0)
	
end

function BeltalowdaGroup.HandleAdminAddon3Response(player, message)
	--ftcv [pt.2] / ftcw
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b3, message.b2, message.b1)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.ftcv = player.admin.addon.ftcv or {}
	
	player.admin.addon.ftcv.opacityFar = message.b1
	player.admin.addon.ftcv.opacityClose = message.b2
	
	player.admin.addon.ftcw = {}
	player.admin.addon.ftcw.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
	player.admin.addon.ftcw.distanceEnabled = BeltalowdaMath.BitToBoolean(bitfield[7])
	player.admin.addon.ftcw.warningsEnabled = BeltalowdaMath.BitToBoolean(bitfield[6])
	
	bitfield[6] = 0
	bitfield[7] = 0
	bitfield[8] = 0
	
	player.admin.addon.ftcw.maxDistance = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)	
end

function BeltalowdaGroup.HandleAdminAddon4Response(player, message)
	--ftca
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b3, message.b2, message.b1)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.ftca = {}
	
	player.admin.addon.ftca.maxDistance = message.b1
	player.admin.addon.ftca.threshold = message.b2
	player.admin.addon.ftca.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
	
	bitfield[8] = 0
	player.admin.addon.ftca.interval = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
end

function BeltalowdaGroup.HandleAdminAddon5Response(player, message)
	--ressource overview pt.1
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b3, message.b2, message.b1)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.ro = player.admin.addon.ro or {}
	
	player.admin.addon.ro.enabled = BeltalowdaMath.BitToBoolean(bitfield[1])
	player.admin.addon.ro.ultimateOverviewEnabled = BeltalowdaMath.BitToBoolean(bitfield[2])
	player.admin.addon.ro.clientUltimateEnabled = BeltalowdaMath.BitToBoolean(bitfield[3])
	player.admin.addon.ro.groupUltimatesEnabled = BeltalowdaMath.BitToBoolean(bitfield[4])
	player.admin.addon.ro.showSoftResources = BeltalowdaMath.BitToBoolean(bitfield[5])
	player.admin.addon.ro.soundEnabled = BeltalowdaMath.BitToBoolean(bitfield[6])

	player.admin.addon.ro.groupSizeDestro = message.b1
	player.admin.addon.ro.groupSizeStorm = message.b2
end

function BeltalowdaGroup.HandleAdminAddon6Response(player, message)
	--ressource overview pt.2
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.ro = player.admin.addon.ro or {}
	
	player.admin.addon.ro.groupSizeNegate = message.b1
	player.admin.addon.ro.groupSizeNova = message.b2
	player.admin.addon.ro.maxDistance = message.b3
end

function BeltalowdaGroup.HandleAdminAddon7Response(player, message)
	--yacs, bft, kc, recharger, sm
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	player.admin = player.admin or {}
	player.admin.addon = player.admin.addon or {}
	player.admin.addon.yacs = {}
	player.admin.addon.kc = {}
	player.admin.addon.sm = {}
	player.admin.addon.recharger = {}
	player.admin.addon.bft = {}
	player.admin.addon.dt = {}
	player.admin.addon.cl = {}
	player.admin.addon.cs = {}
	player.admin.addon.gb = {}
	player.admin.addon.isdp = {}
	player.admin.addon.respawner = {}
	player.admin.addon.camp = {}
	player.admin.addon.sp = {}
	player.admin.addon.so = {}
	
	player.admin.addon.bft.soundEnabled = BeltalowdaMath.BitToBoolean(bitfield[7])
	player.admin.addon.bft.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
	
	bitfield[7] = 0
	bitfield[8] = 0
	player.admin.addon.bft.size = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	
	player.admin.addon.yacs.enabled = BeltalowdaMath.BitToBoolean(bitfield[9])
	player.admin.addon.yacs.pvpEnabled = BeltalowdaMath.BitToBoolean(bitfield[10])
	player.admin.addon.yacs.combatEnabled = BeltalowdaMath.BitToBoolean(bitfield[11])
	player.admin.addon.kc.enabled = BeltalowdaMath.BitToBoolean(bitfield[12])
	player.admin.addon.recharger.enabled = BeltalowdaMath.BitToBoolean(bitfield[13])
	player.admin.addon.sm.enabled = BeltalowdaMath.BitToBoolean(bitfield[14])
	player.admin.addon.dt.enabled = BeltalowdaMath.BitToBoolean(bitfield[15])
	player.admin.addon.cl.enabled = BeltalowdaMath.BitToBoolean(bitfield[16])
	player.admin.addon.cs.enabled = BeltalowdaMath.BitToBoolean(bitfield[17])
	player.admin.addon.gb.enabled = BeltalowdaMath.BitToBoolean(bitfield[18])
	player.admin.addon.isdp.enabled = BeltalowdaMath.BitToBoolean(bitfield[19])
	player.admin.addon.respawner.enabled = BeltalowdaMath.BitToBoolean(bitfield[20])
	player.admin.addon.camp.enabled = BeltalowdaMath.BitToBoolean(bitfield[21])
	player.admin.addon.sp.enabled = BeltalowdaMath.BitToBoolean(bitfield[22])
	player.admin.addon.sp.mode = bitfield[23] + 1
	player.admin.addon.so.enabled = BeltalowdaMath.BitToBoolean(bitfield[24])
end

function BeltalowdaGroup.HandleAdminAddon8Response(player, message)
	local messagePrefix = message.b1
	--d(messagePrefix)
	if messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_1 then
		--MESSAGE_1: ftcb / ra /caj
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		player.admin = player.admin or {}
		player.admin.addon = player.admin.addon or {}
		player.admin.addon.ftcb = {}
		player.admin.addon.ra = {}
		player.admin.addon.caj = {}
		
		player.admin.addon.ftcb.alpha = message.b2
		player.admin.addon.ftcb.enabled = BeltalowdaMath.BitToBoolean(bitfield[8])
		player.admin.addon.caj.enabled = BeltalowdaMath.BitToBoolean(bitfield[7])
		player.admin.addon.ra.allowOverride = BeltalowdaMath.BitToBoolean(bitfield[6])
		player.admin.addon.ra.enabled = BeltalowdaMath.BitToBoolean(bitfield[5])
		bitfield[8] = 0
		bitfield[7] = 0
		bitfield[6] = 0
		bitfield[5] = 0
		player.admin.addon.ftcb.selectedBeam = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
	elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_2 then
		--MESSAGE_2: crBgTp, sc, ro
		player.admin = player.admin or {}
		player.admin.addon = player.admin.addon or {}
		player.admin.addon.crBgTp = {}
		player.admin.addon.sc = {}
		player.admin.addon.ro = player.admin.addon.ro or {}
		
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b2)
		
		player.admin.addon.crBgTp.enabled = BeltalowdaMath.BitToBoolean(bitfield[1])
		player.admin.addon.sc.enabled = BeltalowdaMath.BitToBoolean(bitfield[2])
		player.admin.addon.ro.groupsEnabled = BeltalowdaMath.BitToBoolean(bitfield[8])
		bitfield[1] = bitfield[3]
		bitfield[2] = bitfield[4]
		bitfield[3] = bitfield[5]
		bitfield[4] = bitfield[6]
		bitfield[5] = bitfield[7]
		bitfield[6] = 0
		bitfield[7] = 0
		bitfield[8] = 0
		player.admin.addon.ro.groupSizeNegateOffensive = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		
		bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		bitfield[6] = 0
		bitfield[7] = 0
		bitfield[8] = 0
		player.admin.addon.ro.groupSizeNegateCounter = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		
	elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_3 then
		--MESSAGE_3: ro
		player.admin = player.admin or {}
		player.admin.addon = player.admin.addon or {}
		player.admin.addon.ro = player.admin.addon.ro or {}
		player.admin.addon.so = player.admin.addon.so or {}
		
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b2)
		local bitfield2 = BeltalowdaMath.DecodeBitArrayHelper(message.b2)
		bitfield2[1] = bitfield2[6]
		bitfield2[2] = bitfield2[7]
		bitfield2[3] = bitfield2[8]
		bitfield2[4] = 0
		bitfield2[5] = 0
		bitfield2[6] = 0
		bitfield2[7] = 0
		bitfield2[8] = 0
		bitfield[6] = 0
		bitfield[7] = 0
		bitfield[8] = 0
		player.admin.addon.ro.groupSizeNorthernStorm = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		player.admin.addon.so.displayMode = BeltalowdaMath.EncodeBitArrayHelper(bitfield2, 0) + 1
		
		bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		bitfield2 = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		bitfield2[1] = bitfield2[6]
		bitfield2[2] = bitfield2[7]
		bitfield2[3] = bitfield2[8]
		bitfield2[4] = 0
		bitfield2[5] = 0
		bitfield2[6] = 0
		bitfield2[7] = 0
		bitfield2[8] = 0
		bitfield[6] = 0
		bitfield[7] = 0
		bitfield[8] = 0
		player.admin.addon.ro.groupSizePermafrost = BeltalowdaMath.EncodeBitArrayHelper(bitfield, 0)
		player.admin.addon.so.tableMode = BeltalowdaMath.EncodeBitArrayHelper(bitfield2, 0) + 1
	elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.admin.MESSAGE_4 then
		--MESSAGE_4: sp
		player.admin = player.admin or {}
		player.admin.addon = player.admin.addon or {}
		player.admin.addon.sp = player.admin.addon.sp or {}
	
	
		local bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b2)
		player.admin.addon.sp.preventCombustionShards = BeltalowdaMath.BitToBoolean(bitfield[1])
		player.admin.addon.sp.preventTalons = BeltalowdaMath.BitToBoolean(bitfield[2])
		player.admin.addon.sp.preventNova = BeltalowdaMath.BitToBoolean(bitfield[3])
		player.admin.addon.sp.preventAltar = BeltalowdaMath.BitToBoolean(bitfield[4])
		player.admin.addon.sp.preventStandard = BeltalowdaMath.BitToBoolean(bitfield[5])
		player.admin.addon.sp.preventRitual = BeltalowdaMath.BitToBoolean(bitfield[6])
		player.admin.addon.sp.preventBoneShield = BeltalowdaMath.BitToBoolean(bitfield[7])
		player.admin.addon.sp.preventConduit = BeltalowdaMath.BitToBoolean(bitfield[8])		
		
		bitfield = BeltalowdaMath.DecodeBitArrayHelper(message.b3)
		player.admin.addon.sp.preventAtronach = BeltalowdaMath.BitToBoolean(bitfield[1])
		player.admin.addon.sp.preventTrappingWebs = BeltalowdaMath.BitToBoolean(bitfield[2])
		player.admin.addon.sp.preventRadiate = BeltalowdaMath.BitToBoolean(bitfield[3])
		player.admin.addon.sp.preventConsumingDarkness = BeltalowdaMath.BitToBoolean(bitfield[4])
		player.admin.addon.sp.preventSoulLeech = BeltalowdaMath.BitToBoolean(bitfield[5])
		player.admin.addon.sp.preventHealingSeed = BeltalowdaMath.BitToBoolean(bitfield[6])
		player.admin.addon.sp.preventGraveRobber = BeltalowdaMath.BitToBoolean(bitfield[7])
		player.admin.addon.sp.preventPureAgony = BeltalowdaMath.BitToBoolean(bitfield[8])
		
	end
end

function BeltalowdaGroup.HandleAdminAddon9Response(player, message)
	--
end

function BeltalowdaGroup.HandleAdminChampionInformationResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		player.admin = player.admin or {}
		player.admin.cp = player.admin.cp or {}
		--d(message)
		player.admin.cp[BeltalowdaCP.GetCPNameFromMessagePrefix(message.b1, 1)] = message.b2
		player.admin.cp[BeltalowdaCP.GetCPNameFromMessagePrefix(message.b1, 2)] = message.b3
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminStatsResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	--d("received")
	--d(message)
	if player ~= nil then
		player.admin = player.admin or {}
		player.admin.stats = player.admin.stats or {}
		
		local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
		local messagePrefix = BeltalowdaMath.EncodeBitArrayHelper(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(4), 4, 21, 1), 0)
		local value = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(20), 20, 1, 1))
		
		if messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA then
			player.admin.stats.magicka = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH then
			player.admin.stats.health = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA then
			player.admin.stats.stamina = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_MAGICKA_RECOVERY then
			player.admin.stats.magickaRecovery = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_HEALTH_RECOVERY then
			player.admin.stats.healthRecovery = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_STAMINA_RECOVERY then
			player.admin.stats.staminaRecovery = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_DAMAGE then
			player.admin.stats.spellDamage = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_DAMAGE then
			player.admin.stats.weaponDamage = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_PENETRATION then
			player.admin.stats.spellPenetration = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_WEAPON_PENETRATION then
			player.admin.stats.weaponPenetration = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL then
			player.admin.stats.spellCritical = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(10), 10, 1, 1)) / 10
			player.admin.stats.weaponCritical = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(10), 10, 11, 1)) / 10
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_SPELL_RESISTANCE then
			player.admin.stats.spellResistance = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_PHYSICAL_RESISTANCE then
			player.admin.stats.physicalResistance = value
		elseif messagePrefix == BeltalowdaNetworking.messageIdentifiers.adminResponse.stats.MESSAGE_CRITICAL_RESISTANCE then
			player.admin.stats.criticalResistance = value
		end
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminSkillsResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
		local messagePrefix = BeltalowdaMath.EncodeBitArrayHelper(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(4), 4, 21, 1), 0)
		local value = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(20), 20, 1, 1))
		
		--d(message)
		
		player.admin = player.admin or {}
		player.admin.skills = player.admin.skills or {}
		player.admin.skills.bars = player.admin.skills.bars or {}
		player.admin.skills.bars[1] = player.admin.skills.bars[1] or {}
		player.admin.skills.bars[2] = player.admin.skills.bars[2] or {}
		
		if messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_1 then
			player.admin.skills.bars[1][1] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_2 then
			player.admin.skills.bars[1][2] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_3 then
			player.admin.skills.bars[1][3] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_4 then
			player.admin.skills.bars[1][4] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_5 then
			player.admin.skills.bars[1][5] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_1_ULTIMATE then
			player.admin.skills.bars[1][6] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_1 then
			player.admin.skills.bars[2][1] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_2 then
			player.admin.skills.bars[2][2] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_3 then
			player.admin.skills.bars[2][3] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_4 then
			player.admin.skills.bars[2][4] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_5 then
			player.admin.skills.bars[2][5] = value
		elseif messagePrefix == BeltalowdaSB.constants.networking.messagePrefix.BAR_2_ULTIMATE then
			player.admin.skills.bars[2][6] = value
		end
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleAdminEquipmentInformationResponse(message)
	local player = BeltalowdaGroup.GetPlayerByUnitTag(message.pingTag)
	if player ~= nil then
		if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_1 then
			BeltalowdaGroup.HandleAdminEquipment1Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_2 then
			BeltalowdaGroup.HandleAdminEquipment2Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_3 then
			BeltalowdaGroup.HandleAdminEquipment3Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_4 then
			BeltalowdaGroup.HandleAdminEquipment4Response(player, message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_5 then
			BeltalowdaGroup.HandleAdminEquipment5Response(player, message)
			BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
		end
	end
end

function BeltalowdaGroup.CreateItemLink(messagePrefix, player)
	local item = player.admin.equipment[messagePrefix]
	if item ~= nil and item.itemId ~= nil and item.itemId ~= 0 then
		--d("everthing is fine so far")
		if item.message1received == true and
		   item.message2received == true and
		   item.message3received == true and
		   item.message4received == true and
		   item.message5received == true then
			--d("okay, let's create the link")
			item.link = BeltalowdaEquip.CreateItemLink(item.itemId, item.itemQuality, item.itemLevel, item.enchantmentId, item.enchantmentQuality, item.enchantmentLevel, item.transmutationId, nil, item.styleId, nil, nil, nil, 0)
		end
	end
end

function BeltalowdaGroup.HandleAdminEquipment1Response(player, message)
	--Equipment 1: itemId
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	local messagePrefix = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 4, 21, 1))
	--d(messagePrefix)
	--d(type(messagePrefix))
	local equipmentName = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(messagePrefix)
	--d(equipmentName)
	bitfield[24] = 0
	bitfield[23] = 0
	bitfield[22] = 0
	bitfield[21] = 0
	local value = BeltalowdaMath.ArrayToInt24(bitfield)
	player.admin = player.admin or {}
	player.admin.equipment = player.admin.equipment or {}
	if equipmentName ~= nil then
		player.admin.equipment[equipmentName] = player.admin.equipment[equipmentName] or {}
		player.admin.equipment[equipmentName].itemId = value
		player.admin.equipment[equipmentName].message1received = true
		player.admin.equipment[equipmentName].message2received = false
		player.admin.equipment[equipmentName].message3received = false
		player.admin.equipment[equipmentName].message4received = false
		player.admin.equipment[equipmentName].message5received = false
	end
	BeltalowdaGroup.CreateItemLink(equipmentName, player)
end

function BeltalowdaGroup.HandleAdminEquipment2Response(player, message)
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	local messagePrefix = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 4, 21, 1))
	local equipmentName = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(messagePrefix)
	bitfield[24] = 0
	bitfield[23] = 0
	bitfield[22] = 0
	bitfield[21] = 0
	local value = BeltalowdaMath.ArrayToInt24(bitfield)
	player.admin = player.admin or {}
	player.admin.equipment = player.admin.equipment or {}
	if equipmentName ~= nil then
		player.admin.equipment[equipmentName] = player.admin.equipment[equipmentName] or {}
		player.admin.equipment[equipmentName].enchantmentId = value
		player.admin.equipment[equipmentName].message2received = true
	end
	BeltalowdaGroup.CreateItemLink(equipmentName, player)
end

function BeltalowdaGroup.HandleAdminEquipment3Response(player, message)
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	local messagePrefix = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 4, 21, 1))
	local equipmentName = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(messagePrefix)
	bitfield[24] = 0
	bitfield[23] = 0
	bitfield[22] = 0
	bitfield[21] = 0
	local value1 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 1, 1))
	local value2 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 11, 1))
	player.admin = player.admin or {}
	player.admin.equipment = player.admin.equipment or {}
	if equipmentName ~= nil then
		player.admin.equipment[equipmentName] = player.admin.equipment[equipmentName] or {}
		player.admin.equipment[equipmentName].itemQuality = value1
		player.admin.equipment[equipmentName].enchantmentQuality = value2
		player.admin.equipment[equipmentName].message3received = true
	end
	BeltalowdaGroup.CreateItemLink(equipmentName, player)
end

function BeltalowdaGroup.HandleAdminEquipment4Response(player, message)
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	local messagePrefix = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 4, 21, 1))
	local equipmentName = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(messagePrefix)
	bitfield[24] = 0
	bitfield[23] = 0
	bitfield[22] = 0
	bitfield[21] = 0
	local value1 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 1, 1))
	local value2 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 11, 1))
	player.admin = player.admin or {}
	player.admin.equipment = player.admin.equipment or {}
	if equipmentName ~= nil then
		player.admin.equipment[equipmentName] = player.admin.equipment[equipmentName] or {}
		player.admin.equipment[equipmentName].itemLevel = value1
		player.admin.equipment[equipmentName].enchantmentLevel = value2
		player.admin.equipment[equipmentName].message4received = true
	end
	BeltalowdaGroup.CreateItemLink(equipmentName, player)
end

function BeltalowdaGroup.HandleAdminEquipment5Response(player, message)
	local bitfield = BeltalowdaNetworking.DecodeMessageFromBitArray(message.b1, message.b2, message.b3)
	local messagePrefix = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 4, 21, 1))
	local equipmentName = BeltalowdaEquip.GetEquipmentNameFromMessagePrefix(messagePrefix)
	bitfield[24] = 0
	bitfield[23] = 0
	bitfield[22] = 0
	bitfield[21] = 0
	local value1 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 1, 1))
	local value2 = BeltalowdaMath.ArrayToInt24(BeltalowdaMath.CopyBitfieldRange(bitfield, BeltalowdaMath.CreateEmptyBitfield(24), 10, 11, 1))
	player.admin = player.admin or {}
	player.admin.equipment = player.admin.equipment or {}
	if equipmentName ~= nil then
		player.admin.equipment[equipmentName] = player.admin.equipment[equipmentName] or {}
		player.admin.equipment[equipmentName].transmutationId = value1
		player.admin.equipment[equipmentName].styleId = value2
		player.admin.equipment[equipmentName].message5received = true
	end
	BeltalowdaGroup.CreateItemLink(equipmentName, player)
end

--callbacks (group)
function BeltalowdaGroup.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaGroup.groupVars = currentProfile.util.group
		BeltalowdaGroup.UpdateDisplayNames()
	end
end

function BeltalowdaGroup.GroupMemberOnConnectedStatus(eventCode, unitTag, isOnline)
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			if players[i].unitTag == unitTag then
				players[i].isOnline = isOnline
			end
		end
	end
end

function BeltalowdaGroup.GroupMemberOnJoined(eventCode, memberName)
	BeltalowdaGroup.UpdateGroup()
	BeltalowdaGroup.AdjustBgGroup()
end

function BeltalowdaGroup.GroupMemberOnLeft(eventCode, memberCharacterName, reason, isLocalPlayer, isLeader, memberDisplayName, actionRequiredVote)
	BeltalowdaGroup.UpdateGroup()
	BeltalowdaGroup.AdjustBgGroup()
end

function BeltalowdaGroup.GroupMemberOnUpdate(eventCode)
	BeltalowdaGroup.UpdateGroup()
	BeltalowdaGroup.AdjustBgGroup()
end

function BeltalowdaGroup.GroupMemberOnLeaderUpdate(eventCode, leaderTag)
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			players[i].isLeader = false
			if players[i].unitTag == leaderTag then
				players[i].isLeader = true
			end
		end
	end
	BeltalowdaGroup.AdjustBgGroup()
end

function BeltalowdaGroup.GroupMemberOnPlayerActivated(eventCode, initial)
	BeltalowdaGroup.UpdateGroup()
	BeltalowdaGroup.AdjustBgGroup()
end

function BeltalowdaGroup.GroupMemberOnPlayerDeactivated(eventCode)
	if GetGroupSize() > 1 then
		BeltalowdaGroup.state.lastLeader = BeltalowdaGroup.GetLeaderUnit()
	else
		BeltalowdaGroup.state.lastLeader = nil
	end
end

function BeltalowdaGroup.UpdateStatusLoop()
	local players =  BeltalowdaGroup.state.players
	local isInCombat = false
	if players ~= nil then
		for i = 1, #players do
			players[i].isInCombat = IsUnitInCombat(players[i].unitTag)
			if players[i].isInCombat == true then
				isInCombat = true
			end
			players[i].isInStealth = GetUnitStealthState(players[i].unitTag)
		end
	end
	if isInCombat == true then
		BeltalowdaGroup.state.lastCombatTimestamp = GetGameTimeMilliseconds()
	else
		if BeltalowdaGroup.IsHdmAutoClearEnabled() == true and GetGameTimeMilliseconds() > BeltalowdaGroup.state.lastCombatTimestamp + BeltalowdaGroup.constants.COMBAT_TIMEOUT then
			BeltalowdaGroup.ClearDamageHealingMeter()
		end
	end
end

function BeltalowdaGroup.IsHdmAutoClearEnabled()
	return BeltalowdaGroup.state.hdmAutoClear
end

function BeltalowdaGroup.SetHdmAutoClearEnabled(value)
	BeltalowdaGroup.state.hdmAutoClear = value
end

--callbacks
function BeltalowdaGroup.OnUpdatePlayerDistance()
	BeltalowdaGroup.CalculateGroupDistances("player", "fromPlayer")
end

function BeltalowdaGroup.OnUpdateLeaderDistance()
	BeltalowdaGroup.CalculateGroupDistances(BeltalowdaGroup.GetLeaderUnitTag(), "fromLeader")
end

function BeltalowdaGroup.OnUpdateBuff()
	local players = BeltalowdaGroup.state.players
	local currentTime = GetGameTimeMilliseconds() / 1000
	for i = 1, #players do
		local buffs = players[i].buffs
		buffs.specialInformation = buffs.specialInformation or {}
		--[[
		buffs.specialInformation.rapidManeuverOn = {}
		buffs.specialInformation.rapidManeuverOn.active = false
		buffs.specialInformation.chargingManeuverMajorOn = {}
		buffs.specialInformation.chargingManeuverMajorOn.active = false
		buffs.specialInformation.chargingManeuverMinorOn = {}
		buffs.specialInformation.chargingManeuverMinorOn.active = false
		buffs.specialInformation.retreatingManeuverOn = {}
		buffs.specialInformation.retreatingManeuverOn.active = false
		]]
		buffs.specialInformation.minorExpeditionOn = {}
		buffs.specialInformation.minorExpeditionOn.active = false
		buffs.specialInformation.majorExpeditionOn = {}
		buffs.specialInformation.majorExpeditionOn.active = false
		buffs.specialInformation.potion = buffs.specialInformation.potion or {}
		buffs.specialInformation.potion.immovablePot = false
		buffs.specialInformation.foodDrink = buffs.specialInformation.foodDrink or {}
		buffs.specialInformation.foodDrink.started = 0
		buffs.specialInformation.foodDrink.ending = 0
		buffs.specialInformation.foodDrink.active = false
		buffs.specialInformation.proximityDetonation = buffs.specialInformation.proximityDetonation or {}
		buffs.specialInformation.proximityDetonation.active = false
		buffs.specialInformation.proximityDetonation.started = 0
		buffs.specialInformation.proximityDetonation.ending = 0
		buffs.specialInformation.subterraneanAssault = buffs.specialInformation.subterraneanAssault or {}
		buffs.specialInformation.subterraneanAssault.active = false
		buffs.specialInformation.subterraneanAssault.started = 0
		buffs.specialInformation.subterraneanAssault.ending = 0
		buffs.specialInformation.deepFissure = buffs.specialInformation.deepFissure or {}
		buffs.specialInformation.deepFissure.active = false
		buffs.specialInformation.deepFissure.started = 0
		buffs.specialInformation.deepFissure.ending = 0
		buffs.specialInformation.crBgTpHealBuffs = {}
				
		buffs.numBuffs = GetNumBuffs(players[i].unitTag)
		buffs.all = buffs.all or {}
		buffs.buffs = buffs.buffs or {}
		buffs.debuffs = buffs.debuffs or {}
		buffs.debuffsPurgable = buffs.debuffsPurgable or {}
		--clear old data
		for j = 1, #buffs.all do
			buffs.all[j] = nil
		end
		for j = 1, #buffs.buffs do
			buffs.buffs[j] = nil
		end
		for j = 1, #buffs.debuffs do
			buffs.debuffs[j] = nil
		end
		for j = 1, #buffs.debuffsPurgable do
			buffs.debuffsPurgable[j] = nil
		end
		local numPlayerDebuffs = 0
		if buffs.numBuffs ~= nil then
			for buffIndex = 1, buffs.numBuffs do
				local buff = {}
				buff.name, buff.started, buff.ending, buff.slot, buff.stackCount, buff.iconFilename, buff.buffType, buff.effectType, buff.abilityType, buff.statusEffectType, buff.abilityId, buff.canClickOff, buff.castByPlayer = GetUnitBuffInfo(players[i].unitTag, buffIndex)
				--d(buff.iconFilename)
				table.insert(buffs.all, buff)
				if buff.effectType == BUFF_EFFECT_TYPE_BUFF then
					table.insert(buffs.buffs, buff)
					BeltalowdaGroup.RunSpecialChecks(buffs, buff)
				elseif buff.effectType == BUFF_EFFECT_TYPE_DEBUFF then
					if --[[buff.statusEffectType ~= STATUS_EFFECT_TYPE_ENVIRONMENT and]] buff.statusEffectType ~= STATUS_EFFECT_TYPE_SILENCE then
						table.insert(buffs.debuffsPurgable, buff)
						if players[i].isPlayer == true then
							--d("debuff 1")
							if buff.ending ~= nil and buff.started ~= nil and buff.ending > currentTime then
								numPlayerDebuffs = numPlayerDebuffs + 1
								--d("debuff 2")
							end
						end
					end
					table.insert(buffs.debuffs, buff)
				end
				if BeltalowdaGroup.state.crBgTpHealBuffs ~= nil and players[i].isPlayer == true then
					BeltalowdaGroup.CheckCrBgTpHealBuff(buffs, buff)
				end
			end
		end
		if players[i].isPlayer == true then
			--d(numPlayerDebuffs)
			buffs.numPurgableBuffs = numPlayerDebuffs
		end
	end
end

function BeltalowdaGroup.OnUpdateDeadState()
	local players = BeltalowdaGroup.state.players
	if players ~= nil then
		for i = 1, #players do
			local player = players[i]
			local unitTag = player.unitTag
			player.isDead = IsUnitDead(unitTag)
			player.isResurrected = DoesUnitHaveResurrectPending(unitTag)
			player.isBeingResurrected = IsUnitBeingResurrected(unitTag)
		end
	end
end

function BeltalowdaGroup.OnUpdateCoordinates()
	if lib3d:IsValidZone() then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				local playerX, playerY = GetMapPlayerPosition(players[i].unitTag)
				players[i].coordinates.localX = playerX
				players[i].coordinates.localY = playerY
				if playerX ~= nil and playerY ~= nil and playerX ~= 0 and playerY ~= 0 then
					players[i].coordinates.x, players[i].coordinates.y = lib3d:LocalToWorld(playerX, playerY)
					local _, height = nil, nil
					_, players[i].coordinates.worldX, height, players[i].coordinates.worldY = GetUnitWorldPosition(players[i].unitTag)
					players[i].coordinates.worldX, players[i].coordinates.worldHeight, players[i].coordinates.worldY = WorldPositionToGuiRender3DPosition(players[i].coordinates.worldX, height, players[i].coordinates.worldY)
					if players[i].coordinates.x ~= nil and players[i].coordinates.y ~= nil then
						
						players[i].coordinates.x, players[i].coordinates.height, players[i].coordinates.y = WorldPositionToGuiRender3DPosition(players[i].coordinates.x * 100, height, players[i].coordinates.y * 100)
					end
					
				end
			end
		end
	end
end

function BeltalowdaGroup.OnUpdateLeader()
	if lib3d:IsValidZone() and IsUnitGrouped("player") == true and BeltalowdaGroup.IsPlayerGroupLeader() == false then
		local leaderLocX, leaderLocY = GetMapPlayerPosition(BeltalowdaGroup.GetGroupLeaderUnitTag())
		local playerLocX, playerLocY = GetMapPlayerPosition("player")
		if leaderLocX ~= nil and leaderLocY ~= nil and leaderLocX ~= 0 and leaderLocY ~= 0 and 
		   playerLocX ~= nil and playerLocY ~= nil and playerLocX ~= 0 and playerLocY ~= 0 then
			local leaderX, leaderY = lib3d:LocalToWorld(leaderLocX, leaderLocY)
			local playerX, playerY = lib3d:LocalToWorld(playerLocX, playerLocY)
			--d("a")
			if leaderX ~= nil and leaderY ~= nil and playerX ~= nil and playerY ~= nil then
				local distanceLocX = playerLocX - leaderLocX
				local distanceLocY = playerLocY - leaderLocY
				local distanceX = playerX - leaderX
				local distanceY = playerY - leaderY
				BeltalowdaGroup.state.leader.leaderDistance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
				local cameraHeading = BeltalowdaUI.NormalizeAngle(GetPlayerCameraHeading())
				BeltalowdaGroup.state.leader.leaderRotation = (math.pi * 2) - BeltalowdaUI.NormalizeAngle(cameraHeading - math.atan2( distanceLocX, distanceLocY ))
			end
		else
			BeltalowdaGroup.state.leader.leaderDistance = nil
			BeltalowdaGroup.state.leader.leaderRotation = nil
		end
	end
end

function BeltalowdaGroup.HandleRawAdminNetworkMessage(message)
	if message ~= nil and BeltalowdaRoster.IsGuildOfficerOf(GetUnitDisplayName(message.pingTag), GetUnitDisplayName("player")) then
		
		--d("received: " .. message.b0)
		if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_AOE then
			BeltalowdaGroup.HandleAdminAoeResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_SOUND then
			BeltalowdaGroup.HandleAdminSoundResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CLIENT_CONFIGURATION_GRAPHICS then
			BeltalowdaGroup.HandleAdminGraphicsResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_1 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_2 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_3 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_4 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_5 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_6 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_7 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_8 or 
			   message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_ADDON_CONFIGURATION_9 then
			BeltalowdaGroup.HandleAdminAddonResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_CHAMPION_INFORMATION then
			BeltalowdaGroup.HandleAdminChampionInformationResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_STATS_INFORMATION then
			BeltalowdaGroup.HandleAdminStatsResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_SKILLS_INFORMATION then
			BeltalowdaGroup.HandleAdminSkillsResponse(message)
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_1 or
		       message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_2 or
		       message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_3 or
		       message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_4 or
		       message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_ADMIN_RESPONSE_EQUIPMENT_INFORMATION_5 then
			BeltalowdaGroup.HandleAdminEquipmentInformationResponse(message)
		end		
	end
end

function BeltalowdaGroup.HandleRawResourceNetworkMessage(message)
	--d(message)
	if message ~= nil and message.b0 ~= nil and message.b0 >= 1 and message.b0 <= #BeltalowdaUltimates.ultimates then
		--d("ulti message received")
		BeltalowdaGroup.UpdateMemberResources(message.pingTag, message.b0, message.b1, message.b2, message.b3)
	end
end

function BeltalowdaGroup.HandleRawHpDmgNetworkMessage(message)
	--d(message)
	if message ~= nil and message.b0 ~= nil and (message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_HP or message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_DMG) then
		if message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_DMG then
			BeltalowdaGroup.UpdateMemberDamage(message.pingTag, BeltalowdaNetworking.DecodeInt24(message.b1, message.b2, message.b3))
		elseif message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_HP then
			BeltalowdaGroup.UpdateMemberHealing(message.pingTag, BeltalowdaNetworking.DecodeInt24(message.b1, message.b2, message.b3))
		end
	end
end

function BeltalowdaGroup.HandleRawVersionNetworkMessage(message)
	--d(message)
	if message ~= nil and message.b0 ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_VERSION_INFORMATION then
		--d(message)
		local unitTag = message.pingTag
		if unitTag == "player" then
			unitTag = BeltalowdaGroup.GetUnitTagForPlayer()
		end
		--d(unitTag)
		BeltalowdaGroup.UpdateMemberVersionInformation(unitTag, {major = message.b1, minor = message.b2, revision = message.b3})
		BeltalowdaGroup.NotifyAdminInformationChangedCallbacks(message.pingTag)
	end
end

function BeltalowdaGroup.HandleRawSynergyNetworkMessage(message)
	if message ~= nil and message.b0 ~= nil and message.b0 == BeltalowdaNetworking.messageTypes.MESSAGE_ID_SYNERGY then
		BeltalowdaChat.SendChatMessage("Synergy Message Received: " .. message.b1 .. " - " .. message.b2, BeltalowdaGroup.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		BeltalowdaGroup.UpdateMemberSynergy(message.pingTag, message.b1, message.b2)
		BeltalowdaGroup.UpdateDebuffs(message.pingTag, message.b3)
	end
end

function BeltalowdaGroup.OnPowerUpdate(eventCode, unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax)
	if eventCode == EVENT_POWER_UPDATE and unitTag ~= nil and powerType == POWERTYPE_HEALTH then
		local players = BeltalowdaGroup.state.players
		if players ~= nil then
			for i = 1, #players do
				if players[i].unitTag == unitTag then
					players[i].lastKnownHealth = powerValue
					--if i == 3 then
					--	d("health: " .. powerValue)
					--end
				end
			end
		end
	end
end

--menu interaction
function BeltalowdaGroup.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.UTIL_GROUP_HEADER,
			controls = {
				[1] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.UTIL_GROUP_DISPLAY_TYPE,
					choices = BeltalowdaGroup.GetUtilGroupDisplayTypes(),
					getFunc = BeltalowdaGroup.GetUtilGroupDisplayType,
					setFunc = BeltalowdaGroup.SetUtilGroupDisplayType
				},
			}
		},
	}
	return menu
end

function BeltalowdaGroup.GetUtilGroupDisplayTypes()
	return BeltalowdaGroup.constants.displayTypes
end

function BeltalowdaGroup.GetUtilGroupDisplayType()
	return BeltalowdaGroup.constants.displayTypes[BeltalowdaGroup.groupVars.displayType]
end
	
function BeltalowdaGroup.SetUtilGroupDisplayType(value)
	if value ~= nil then
		for i = 1, #BeltalowdaGroup.constants.displayTypes do
			if BeltalowdaGroup.constants.displayTypes[i] == value then
				BeltalowdaGroup.groupVars.displayType = i
				BeltalowdaGroup.UpdateDisplayNames()
				break
			end
		end
	end
end