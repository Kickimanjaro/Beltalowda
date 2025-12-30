-- Beltalowda Keep Claimer
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox.kc = Beltalowda.toolbox.kc or {}
local BeltalowdaKc = Beltalowda.toolbox.kc
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
local BeltalowdaRoster = BeltalowdaUtil.roster

BeltalowdaKc.constants = BeltalowdaKc.constants or {}

BeltalowdaKc.callbackName = Beltalowda.addonName .. "KeepClaimer"

BeltalowdaKc.config = {}
BeltalowdaKc.config.updateInterval = 5

BeltalowdaKc.state = {}
BeltalowdaKc.state.initialized = false
BeltalowdaKc.state.registeredConsumer = false


function BeltalowdaKc.Initialize()
	if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true then
		Beltalowda.profile.AddProfileChangeListener(BeltalowdaKc.callbackName, BeltalowdaKc.OnProfileChanged)
		
		BeltalowdaKc.state.initialized = true
		BeltalowdaKc.SetEnabled(BeltalowdaKc.kcVars.enabled)
	end
end

function BeltalowdaKc.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.claimKeep = true
	defaults.claimOutpost = false
	defaults.claimResource = false
	defaults.guilds = {}
	defaults.guilds[1] = "Retter des Kaiserreiches"
	defaults.guilds[2] = "The Inglorious Smurfs"
	defaults.guilds[3] = "-"
	defaults.guilds[4] = "-"
	defaults.guilds[5] = "-"
	return defaults
end

function BeltalowdaKc.SetEnabled(value)
	if BeltalowdaKc.state.initialized == true and value ~= nil then
		BeltalowdaKc.kcVars.enabled = value
		if value == true then
			if BeltalowdaKc.state.registeredConsumer == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaKc.callbackName, EVENT_START_KEEP_GUILD_CLAIM_INTERACTION, BeltalowdaKc.OnStartKeepGuildClaimInteraction)
				--EVENT_MANAGER:RegisterForEvent(BeltalowdaKc.callbackName, EVENT_END_KEEP_GUILD_CLAIM_INTERACTION, BeltalowdaKc.OnEndKeepGuildClaimInteraction)
				BeltalowdaKc.state.registeredConsumer = true
			end
		else
			if BeltalowdaKc.state.registeredConsumer == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaKc.callbackName, EVENT_START_KEEP_GUILD_CLAIM_INTERACTION)
				--EVENT_MANAGER:UnregisterForEvent(BeltalowdaKc.callbackName, EVENT_END_KEEP_GUILD_CLAIM_INTERACTION)
				BeltalowdaKc.state.registeredConsumer = false
			end
		end
	end
end

--internal functions
function BeltalowdaKc.GetNextClaimingGuildIndex()
	local retVal = nil
	for i = 1, #BeltalowdaKc.kcVars.guilds do
		if BeltalowdaKc.kcVars.guilds[i] ~= nil and BeltalowdaKc.kcVars.guilds[i] ~= "" and BeltalowdaKc.kcVars.guilds[i] ~= "-" then
			local guildId = BeltalowdaRoster.GetGuildIdForName(BeltalowdaKc.kcVars.guilds[i])
			if guildId ~= nil then
				if DoesGuildHaveClaimedKeep(GetGuildId(guildId)) == false then
					retVal = guildId
					break
				end
			else
				BeltalowdaKc.kcVars.guilds[i] = ""
			end			
		end
	end
	return retVal
end

--callbacks
function BeltalowdaKc.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaKc.kcVars = currentProfile.toolbox.kc
		BeltalowdaKc.SetEnabled(BeltalowdaKc.kcVars.enabled)
	end
end

--[[
function BeltalowdaKc.OnEndKeepGuildClaimInteraction(event)
	if event == EVENT_END_KEEP_GUILD_CLAIM_INTERACTION then
		--d("dialog left")
	end
end
]]

function BeltalowdaKc.OnUpdate()
	local guildId = BeltalowdaKc.GetNextClaimingGuildIndex()
	if guildId ~= nil and GetGuildClaimInteractionKeepId() ~= 0 and GetGuildId(guildId) ~= nil and GetGuildId(guildId) ~= 0 then
		
		local secondsToClaim = GetSecondsUntilKeepClaimAvailable(GetGuildClaimInteractionKeepId(), BGQUERY_LOCAL)
		if secondsToClaim == 0 then
			ClaimInteractionKeepForGuild(GetGuildId(guildId))
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaKc.callbackName)
		end
	else
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaKc.callbackName)
	end
end

function BeltalowdaKc.OnStartKeepGuildClaimInteraction(event)
	if event == EVENT_START_KEEP_GUILD_CLAIM_INTERACTION then
		--d("event fired")
		local keepType = GetKeepType(GetGuildClaimInteractionKeepId())
		if (keepType == KEEPTYPE_KEEP and BeltalowdaKc.kcVars.claimKeep == true) or (keepType == KEEPTYPE_OUTPOST and BeltalowdaKc.kcVars.claimOutpost == true) or (keepType == KEEPTYPE_RESOURCE and BeltalowdaKc.kcVars.claimResource == true) then
			--d("claim claim claim:P")
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaKc.callbackName, BeltalowdaKc.config.updateInterval, BeltalowdaKc.OnUpdate)
		end
		--GetGuildClaimedKeep(number guildLuaId) : number claimedKeepId, number claimedKeepCampaignId
		--DoesGuildHaveClaimedKeep(number guildLuaId) : boolean hasClaimedKeep
		--ClaimInteractionKeepForGuild(number guildLuaId) 
		--GetKeepType(number keepId) : number keepType 
		--GetNumKeeps()
		--GetKeepName(number keepId) : string keepName
		--GetResourceKeepForKeep(number parentKeepId, number KeepResourceType resourceType)  : number keepId
		--GetKeepResourceType(number keepId) : number KeepResourceType resourceType
		--GetSecondsUntilKeepClaimAvailable(number keepId, number BattlegroundQueryContextType battlegroundContext) : number secondsUntilAvailable
		--GetGuildClaimInteractionKeepId() : number keepId
		--GetInteractionKeepId() : number keepId
		--IsKeepTypeClaimable(number KeepType keepType) : boolean isClaimable
		
		-- KeepType
		----KEEPTYPE_ARTIFACT_GATE
		----KEEPTYPE_ARTIFACT_KEEP
		----KEEPTYPE_BORDER_KEEP
		----KEEPTYPE_IMPERIAL_CITY_DISTRICT
		----KEEPTYPE_KEEP
		----KEEPTYPE_OUTPOST
		----KEEPTYPE_RESOURCE
		----KEEPTYPE_TOWN 
		--KeepResourceType
		----RESOURCETYPE_FOOD
		----RESOURCETYPE_NONE
		----RESOURCETYPE_ORE
		----RESOURCETYPE_WOOD 
		--BattlegroundQueryContextType
		----BGQUERY_ASSIGNED_AND_LOCAL
		----BGQUERY_ASSIGNED_CAMPAIGN
		----BGQUERY_LOCAL
		----BGQUERY_UNKNOWN 
	end
end

--menu interaction
function BeltalowdaKc.GetMenu()
	if BeltalowdaRoster.IsBeltalowdaMember(GetUnitDisplayName("player")) == true then
		local menu = {
			[1] = {
				type = "submenu",
				name = BeltalowdaMenu.constants.KC_HEADER,
				controls = {
					[1] = {
						type = "checkbox",
						name = BeltalowdaMenu.constants.KC_ENABLED,
						getFunc = BeltalowdaKc.GetKcEnabled,
						setFunc = BeltalowdaKc.SetKcEnabled
					},
					[2] = {
						type = "checkbox",
						name = BeltalowdaMenu.constants.KC_CLAIM_KEEPS,
						getFunc = BeltalowdaKc.GetKcClaimKeeps,
						setFunc = BeltalowdaKc.SetKcClaimKeeps
					},
					[3] = {
						type = "checkbox",
						name = BeltalowdaMenu.constants.KC_CLAIM_OUTPOSTS,
						getFunc = BeltalowdaKc.GetKcClaimOutposts,
						setFunc = BeltalowdaKc.SetKcClaimOutposts
					},
					[4] = {
						type = "checkbox",
						name = BeltalowdaMenu.constants.KC_CLAIM_RESOURCES,
						getFunc = BeltalowdaKc.GetKcClaimResources,
						setFunc = BeltalowdaKc.SetKcClaimResources
					},
					[5] = {
						type = "dropdown",
						name = BeltalowdaMenu.constants.KC_GUILD_1,
						choices = BeltalowdaKc.GetKcGuilds(),
						getFunc = function() return BeltalowdaKc.GetKcGuild(1) end,
						setFunc = function(value) BeltalowdaKc.SetKcGuild(1, value) end
					},
					[6] = {
						type = "dropdown",
						name = BeltalowdaMenu.constants.KC_GUILD_2,
						choices = BeltalowdaKc.GetKcGuilds(),
						getFunc = function() return BeltalowdaKc.GetKcGuild(2) end,
						setFunc = function(value) BeltalowdaKc.SetKcGuild(2, value) end
					},
					[7] = {
						type = "dropdown",
						name = BeltalowdaMenu.constants.KC_GUILD_3,
						choices = BeltalowdaKc.GetKcGuilds(),
						getFunc = function() return BeltalowdaKc.GetKcGuild(3) end,
						setFunc = function(value) BeltalowdaKc.SetKcGuild(3, value) end
					},
					[8] = {
						type = "dropdown",
						name = BeltalowdaMenu.constants.KC_GUILD_4,
						choices = BeltalowdaKc.GetKcGuilds(),
						getFunc = function() return BeltalowdaKc.GetKcGuild(4) end,
						setFunc = function(value) BeltalowdaKc.SetKcGuild(4, value) end
					},
					[9] = {
						type = "dropdown",
						name = BeltalowdaMenu.constants.KC_GUILD_5,
						choices = BeltalowdaKc.GetKcGuilds(),
						getFunc = function() return BeltalowdaKc.GetKcGuild(5) end,
						setFunc = function(value) BeltalowdaKc.SetKcGuild(5, value) end
					},
				}
			}
		}
		return menu
	else
		return nil
	end
end


function BeltalowdaKc.GetKcEnabled()
	return BeltalowdaKc.kcVars.enabled
end

function BeltalowdaKc.SetKcEnabled(value)
	BeltalowdaKc.SetEnabled(value)
end

function BeltalowdaKc.GetKcClaimKeeps()
	return BeltalowdaKc.kcVars.claimKeep
end

function BeltalowdaKc.SetKcClaimKeeps(value)
	BeltalowdaKc.kcVars.claimKeep = value
end

function BeltalowdaKc.GetKcClaimOutposts()
	return BeltalowdaKc.kcVars.claimOutpost
end

function BeltalowdaKc.SetKcClaimOutposts(value)
	BeltalowdaKc.kcVars.claimOutpost = value
end

function BeltalowdaKc.GetKcClaimResources()
	return BeltalowdaKc.kcVars.claimResource
end

function BeltalowdaKc.SetKcClaimResources(value)
	BeltalowdaKc.kcVars.claimResource = value
end

function BeltalowdaKc.GetKcGuilds()
	local guilds = {}
	for i = 1, GetNumGuilds() do
		table.insert(guilds, GetGuildName(GetGuildId(i)))
	end
	table.insert(guilds, "-")
	return guilds
end

function BeltalowdaKc.GetKcGuild(index)
	local retVal = "-"
	if BeltalowdaKc.kcVars.guilds[index] ~= nil and BeltalowdaKc.kcVars.guilds[index] ~= "" and BeltalowdaKc.kcVars.guilds[index] ~= "-" then
		local tempName = BeltalowdaRoster.GetGuildIdForName(BeltalowdaKc.kcVars.guilds[index])
		if tempName ~= nil then
			retVal = BeltalowdaKc.kcVars.guilds[index]
		else
			BeltalowdaKc.kcVars.guilds[index] = "-"
		end
	else
		BeltalowdaKc.kcVars.guilds[index] = "-"
	end
	return retVal
end

function BeltalowdaKc.SetKcGuild(index, value)
	if index ~= nil and value ~= nil and index > 0 and index < 6 then
		BeltalowdaKc.kcVars.guilds[index] = value
	end
end