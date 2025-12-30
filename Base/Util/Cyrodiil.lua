-- Beltalowda Cyrodiil
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.cyrodiil = BeltalowdaUtil.cyrodiil or {}
local BeltalowdaCyro = BeltalowdaUtil.cyrodiil
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem


BeltalowdaCyro.callbackName = Beltalowda.addonName .. "UtilCyro"


BeltalowdaCyro.config = {}
BeltalowdaCyro.config.updateInterval = 1000
BeltalowdaCyro.config.siegeTimeout = 30000
BeltalowdaCyro.config.previousOwnerThreshold = 5000

BeltalowdaCyro.state = {}
BeltalowdaCyro.state.registredConsumers = false
BeltalowdaCyro.state.initializedItems = false
BeltalowdaCyro.state.campaignId = 0
BeltalowdaCyro.state.consumers = {}

BeltalowdaCyro.state.resources = {}
BeltalowdaCyro.state.keeps = {}
BeltalowdaCyro.state.outposts = {}
BeltalowdaCyro.state.villages = {}
BeltalowdaCyro.state.destructibles = {}
BeltalowdaCyro.state.temples = {}
BeltalowdaCyro.state.scrolls = {}

BeltalowdaCyro.constants = {}
BeltalowdaCyro.constants.resourceType = {}
BeltalowdaCyro.constants.resourceType.FARM = 1
BeltalowdaCyro.constants.resourceType.MINE = 2
BeltalowdaCyro.constants.resourceType.LUMBER = 3
BeltalowdaCyro.constants.events = {}
BeltalowdaCyro.constants.events.GUILD_CLAIM = 1
BeltalowdaCyro.constants.events.GUILD_LOST = 2
BeltalowdaCyro.constants.events.STATUS_UA = 3
BeltalowdaCyro.constants.events.STATUS_UA_LOST = 4
BeltalowdaCyro.constants.events.KEEP_OWNER_CHANGED = 5
BeltalowdaCyro.constants.events.TICK_DEFENSE = 6
BeltalowdaCyro.constants.events.TICK_OFFENSE = 7
BeltalowdaCyro.constants.events.SCROLL_PICKED_UP = 8
BeltalowdaCyro.constants.events.SCROLL_DROPPED = 9
BeltalowdaCyro.constants.events.SCROLL_RETURNED = 10
BeltalowdaCyro.constants.events.SCROLL_RETURNED_BY_TIMER = 11
BeltalowdaCyro.constants.events.SCROLL_CAPTURED = 12
BeltalowdaCyro.constants.events.EMPEROR_CORONATED = 13
BeltalowdaCyro.constants.events.EMPEROR_DEPOSED = 14
BeltalowdaCyro.constants.events.QUEST_REWARD = 15
BeltalowdaCyro.constants.events.BATTLEGROUND_REWARD = 16
BeltalowdaCyro.constants.events.BATTLEGROUND_MEDAL_REWARD = 16
BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_SPAWNED = 17
BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_REVEALED = 18
BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DROPPED = 19
BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_TAKEN = 20
BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DESPAWNED = 21
BeltalowdaCyro.constants.flipTimes = {}
BeltalowdaCyro.constants.flipTimes.KEEP = 20000
BeltalowdaCyro.constants.flipTimes.OUTPOST = 20000
BeltalowdaCyro.constants.flipTimes.RESOURCE = 20000
BeltalowdaCyro.constants.PREFIX = "Cyro"

function BeltalowdaCyro.Initialize()
	EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaCyro.OnPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_ALLIANCE_POINT_UPDATE, BeltalowdaCyro.OnApUpdate)
end

function BeltalowdaCyro.AddConsumer(name, updateCallback, messageCallback)
	if name ~= nil then
		local entryFound = false
		for i = 1, #BeltalowdaCyro.state.consumers do
			if BeltalowdaCyro.state.consumers.name == name then
				entryFound = true
				break
			end
		end
		if entryFound == false then
			local entry = {}
			entry.name = name
			entry.updateCallback = updateCallback
			entry.messageCallback = messageCallback
			table.insert(BeltalowdaCyro.state.consumers, entry)
			BeltalowdaCyro.OnPlayerActivated()
		end
	end
end

function BeltalowdaCyro.RemoveConsumer(name)
	if name ~= nil then
		for i = 1, #BeltalowdaCyro.state.consumers do
			if BeltalowdaCyro.state.consumers[i].name == name then
				table.remove(BeltalowdaCyro.state.consumers, i)
				break
			end
		end
	end
end

function BeltalowdaCyro.NotifyUpdateConsumers(itemsOfInterest)
	if BeltalowdaCyro.state.consumers ~= nil then
		for i = 1, #BeltalowdaCyro.state.consumers do
			if type(BeltalowdaCyro.state.consumers[i].updateCallback) == "function" then
				BeltalowdaCyro.state.consumers[i].updateCallback(itemsOfInterest)
			end
		end
	end
end

function BeltalowdaCyro.NotifyMessageConsumers(eventData)
	if BeltalowdaCyro.state.consumers ~= nil then
		for i = 1, #BeltalowdaCyro.state.consumers do
			if BeltalowdaCyro.state.consumers[i].messageCallback ~= nil and type(BeltalowdaCyro.state.consumers[i].messageCallback) == "function" then
				BeltalowdaCyro.state.consumers[i].messageCallback(eventData)
			end
		end
	end
end

function BeltalowdaCyro.AdjustResourceName(name)
	name = name:gsub("%^.d$", ""):gsub("Castle ",""):gsub("[fF]ort ",""):gsub("Keep ",""):gsub("Feste ",""):gsub("Kastell ",""):gsub("Kastells ",""):gsub("Burg ",""):gsub("der ", ""):gsub("die ", ""):gsub("das ", ""):gsub("des ", ""):gsub("lager", ""):gsub("Bauernhof", "Farm"):gsub("mill",""):gsub("la bastille ", ""):gsub("de la ", " "):gsub(" de "," "):gsub(" du ", " "):gsub(" la ", " "):gsub(" le ", " "):gsub(" les ", " "):gsub("la ferme", "ferme"):gsub("la scierie", "scierie"):gsub("la mine", "mine"):gsub("le château", ""):gsub(" château ", " "):gsub(" bastille ", " ")
	return name
end

function BeltalowdaCyro.AdjustKeepName(name)
	name = name:gsub(",..$", ""):gsub("%^.d$", ""):gsub("Castle ",""):gsub("le fort ", ""):gsub("[fF]ort ",""):gsub("Keep ",""):gsub("Keep",""):gsub("Feste ",""):gsub("Kastell ",""):gsub("Burg ",""):gsub("avant.poste d[eu] ", ""):gsub("bastille d[eu]s? ", ""):gsub("fort de la ", ""):gsub("der ", ""):gsub("das ", ""):gsub("die ", ""):gsub("la bastille ", ""):gsub("de la ", " "):gsub(" de "," "):gsub(" du ", " "):gsub(" la ", " "):gsub(" le ", " "):gsub(" les ", " "):gsub("le château", ""):gsub(" château ", " "):gsub(" bastille ", " "):gsub("de la", " ")
	return name
end

function BeltalowdaCyro.AdjustOutpostName(name)
	name = name:gsub("Outpost","")
	--name = name:gsub("Outpost",""):gsub("der ", ""):gsub("die ", ""):gsub("das ", "")
	return name
end

function BeltalowdaCyro.AdjustTempleName(name)
	name = name:gsub("Scroll ","")
	return name
end

function BeltalowdaCyro.InitResources(gameTime)
	local resources = { 22, 23, 24, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
						61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85 ,86, 87}
	BeltalowdaCyro.state.resources = {}
	for i = 1, #resources do
		BeltalowdaCyro.state.resources[resources[i]] = {}
		BeltalowdaCyro.state.resources[resources[i]].id = resources[i]
		BeltalowdaCyro.state.resources[resources[i]].keepType = GetKeepType(resources[i])
		BeltalowdaCyro.state.resources[resources[i]].name = BeltalowdaCyro.AdjustResourceName(zo_strformat("<<1>>", GetKeepName(resources[i])))
		BeltalowdaCyro.state.resources[resources[i]].isUnderAttack = GetKeepUnderAttack(resources[i],  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.resources[resources[i]].isUnderAttack == true then
			BeltalowdaCyro.state.resources[resources[i]].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.resources[resources[i]].underAttackSince = nil
		end
		BeltalowdaCyro.state.resources[resources[i]].attackStatusLostAt = 0
		BeltalowdaCyro.state.resources[resources[i]].underAttackFor = 0
		BeltalowdaCyro.state.resources[resources[i]].siegeWeapons = {}
		BeltalowdaCyro.state.resources[resources[i]].siegeWeapons.AD = GetNumSieges(resources[i], BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
		BeltalowdaCyro.state.resources[resources[i]].siegeWeapons.DC = GetNumSieges(resources[i], BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
		BeltalowdaCyro.state.resources[resources[i]].siegeWeapons.EP = GetNumSieges(resources[i], BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		BeltalowdaCyro.state.resources[resources[i]].owningAlliance = GetKeepAlliance(resources[i], BGQUERY_LOCAL)
		BeltalowdaCyro.state.resources[resources[i]].previousOwningAlliance = GetKeepAlliance(resources[i], BGQUERY_LOCAL)
	end
end

function BeltalowdaCyro.InitKeeps(gameTime)
--/script for i=3, 20 do d(GetKeepAlliance(i, BGQUERY_LOCAL) .. " - " .. GetKeepAlliance(i, BGQUERY_ASSIGNED_AND_LOCAL)) end
	BeltalowdaCyro.state.keeps = {}
	for i = 3, 20 do
		BeltalowdaCyro.state.keeps[i] = {}
		BeltalowdaCyro.state.keeps[i].id = i
		BeltalowdaCyro.state.keeps[i].keepType = GetKeepType(i)
		BeltalowdaCyro.state.keeps[i].name = BeltalowdaCyro.AdjustKeepName(zo_strformat("<<1>>", GetKeepName(i)))
		BeltalowdaCyro.state.keeps[i].isUnderAttack = GetKeepUnderAttack(i,  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.keeps[i].isUnderAttack == true then
			BeltalowdaCyro.state.keeps[i].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.keeps[i].underAttackSince = nil
		end
		BeltalowdaCyro.state.keeps[i].attackStatusLostAt = 0
		BeltalowdaCyro.state.keeps[i].underAttackFor = 0
		BeltalowdaCyro.state.keeps[i].siegeWeapons = {}
		BeltalowdaCyro.state.keeps[i].siegeWeapons.AD = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
		BeltalowdaCyro.state.keeps[i].siegeWeapons.DC = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
		BeltalowdaCyro.state.keeps[i].siegeWeapons.EP = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		BeltalowdaCyro.state.keeps[i].resources = {}
		BeltalowdaCyro.state.keeps[i].resources.farm = BeltalowdaCyro.state.resources[GetResourceKeepForKeep(i, RESOURCETYPE_FOOD)]
		BeltalowdaCyro.state.keeps[i].resources.farm.rType = BeltalowdaCyro.constants.resourceType.FARM
		BeltalowdaCyro.state.keeps[i].resources.lumber = BeltalowdaCyro.state.resources[GetResourceKeepForKeep(i, RESOURCETYPE_WOOD)]
		BeltalowdaCyro.state.keeps[i].resources.lumber.rType = BeltalowdaCyro.constants.resourceType.LUMBER
		BeltalowdaCyro.state.keeps[i].resources.mine = BeltalowdaCyro.state.resources[GetResourceKeepForKeep(i, RESOURCETYPE_ORE)]
		BeltalowdaCyro.state.keeps[i].resources.mine.rType = BeltalowdaCyro.constants.resourceType.MINE
		BeltalowdaCyro.state.keeps[i].owningAlliance = GetKeepAlliance(i, BGQUERY_LOCAL)
		BeltalowdaCyro.state.keeps[i].previousOwningAlliance = GetKeepAlliance(i, BGQUERY_LOCAL)
		--local _, x, y = GetKeepPinInfo(i, BGQUERY_LOCAL)
		--BeltalowdaCyro.state.keeps[i].x = x
		--BeltalowdaCyro.state.keeps[i].y = y
	end
	
end

function BeltalowdaCyro.InitOutposts(gameTime)
	local outposts = {132, 133, 134, 163, 164, 165}
	BeltalowdaCyro.state.outposts = {}
	for i = 1, #outposts do
		BeltalowdaCyro.state.outposts[outposts[i]] = {}
		BeltalowdaCyro.state.outposts[outposts[i]].id = outposts[i]
		BeltalowdaCyro.state.outposts[outposts[i]].keepType = GetKeepType(outposts[i])
		BeltalowdaCyro.state.outposts[outposts[i]].name = zo_strformat("<<1>>", GetKeepName(outposts[i]))
		BeltalowdaCyro.state.outposts[outposts[i]].isUnderAttack = GetKeepUnderAttack(outposts[i],  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.outposts[outposts[i]].isUnderAttack == true then
			BeltalowdaCyro.state.outposts[outposts[i]].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.outposts[outposts[i]].underAttackSince = nil
		end
		BeltalowdaCyro.state.outposts[outposts[i]].attackStatusLostAt = 0
		BeltalowdaCyro.state.outposts[outposts[i]].underAttackFor = 0
		BeltalowdaCyro.state.outposts[outposts[i]].siegeWeapons = {}
		BeltalowdaCyro.state.outposts[outposts[i]].siegeWeapons.AD = GetNumSieges(outposts[i], BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
		BeltalowdaCyro.state.outposts[outposts[i]].siegeWeapons.DC = GetNumSieges(outposts[i], BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
		BeltalowdaCyro.state.outposts[outposts[i]].siegeWeapons.EP = GetNumSieges(outposts[i], BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		BeltalowdaCyro.state.outposts[outposts[i]].owningAlliance = GetKeepAlliance(outposts[i], BGQUERY_LOCAL)
		BeltalowdaCyro.state.outposts[outposts[i]].previousOwningAlliance = GetKeepAlliance(outposts[i], BGQUERY_LOCAL)
	end
	
end

function BeltalowdaCyro.InitVillages(gameTime)
	local villages = {149, 151, 152}
	BeltalowdaCyro.state.villages = {}
	for i = 1, #villages do
		BeltalowdaCyro.state.villages[villages[i]] = {}
		BeltalowdaCyro.state.villages[villages[i]].id = villages[i]
		BeltalowdaCyro.state.villages[villages[i]].keepType = GetKeepType(villages[i])
		BeltalowdaCyro.state.villages[villages[i]].name = zo_strformat("<<1>>", GetKeepName(villages[i]))
		BeltalowdaCyro.state.villages[villages[i]].isUnderAttack = GetKeepUnderAttack(villages[i],  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.villages[villages[i]].isUnderAttack == true then
			BeltalowdaCyro.state.villages[villages[i]].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.villages[villages[i]].underAttackSince = nil
		end
		BeltalowdaCyro.state.villages[villages[i]].attackStatusLostAt = 0
		BeltalowdaCyro.state.villages[villages[i]].underAttackFor = 0
		BeltalowdaCyro.state.villages[villages[i]].siegeWeapons = {}
		BeltalowdaCyro.state.villages[villages[i]].siegeWeapons.AD = GetNumSieges(villages[i], BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
		BeltalowdaCyro.state.villages[villages[i]].siegeWeapons.DC = GetNumSieges(villages[i], BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
		BeltalowdaCyro.state.villages[villages[i]].siegeWeapons.EP = GetNumSieges(villages[i], BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		BeltalowdaCyro.state.villages[villages[i]].owningAlliance = GetKeepAlliance(villages[i], BGQUERY_LOCAL)
		BeltalowdaCyro.state.villages[villages[i]].previousOwningAlliance = GetKeepAlliance(villages[i], BGQUERY_LOCAL)
	end
end

function BeltalowdaCyro.InitDestructibles(gameTime)
	BeltalowdaCyro.state.destructibles = {}
	for i = 154, 162 do
		BeltalowdaCyro.state.destructibles[i] = {}
		BeltalowdaCyro.state.destructibles[i].id = i
		BeltalowdaCyro.state.destructibles[i].keepType = GetKeepType(i)
		BeltalowdaCyro.state.destructibles[i].name = BeltalowdaCyro.AdjustResourceName(zo_strformat("<<1>>", GetKeepName(i)))
		BeltalowdaCyro.state.destructibles[i].isUnderAttack = GetKeepUnderAttack(i,  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.destructibles[i].isUnderAttack == true then
			BeltalowdaCyro.state.destructibles[i].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.destructibles[i].underAttackSince = nil
		end
		BeltalowdaCyro.state.destructibles[i].attackStatusLostAt = 0
		BeltalowdaCyro.state.destructibles[i].underAttackFor = 0
		BeltalowdaCyro.state.destructibles[i].isPassable = IsKeepPassable(i, BGQUERY_LOCAL)
		BeltalowdaCyro.state.destructibles[i].directionalAccess = GetKeepDirectionalAccess(i, BGQUERY)
	end
end

function BeltalowdaCyro.InitTemples(gameTime)
	BeltalowdaCyro.state.temples = {}
	for i = 118, 123 do
		BeltalowdaCyro.state.temples[i] = {}
		BeltalowdaCyro.state.temples[i].id = i
		BeltalowdaCyro.state.temples[i].keepType = GetKeepType(i)
		BeltalowdaCyro.state.temples[i].name = zo_strformat("<<1>>", BeltalowdaCyro.AdjustTempleName(GetKeepName(i)))
		BeltalowdaCyro.state.temples[i].isUnderAttack = GetKeepUnderAttack(i,  BGQUERY_LOCAL)
		if BeltalowdaCyro.state.temples[i].isUnderAttack == true then
			BeltalowdaCyro.state.temples[i].underAttackSince = gameTime
		else
			BeltalowdaCyro.state.temples[i].underAttackSince = nil
		end
		BeltalowdaCyro.state.temples[i].attackStatusLostAt = 0
		BeltalowdaCyro.state.temples[i].underAttackFor = 0
		BeltalowdaCyro.state.temples[i].siegeWeapons = {}
		BeltalowdaCyro.state.temples[i].siegeWeapons.AD = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
		BeltalowdaCyro.state.temples[i].siegeWeapons.DC = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
		BeltalowdaCyro.state.temples[i].siegeWeapons.EP = GetNumSieges(i, BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		BeltalowdaCyro.state.temples[i].owningAlliance = GetKeepAlliance(i, BGQUERY_LOCAL)
	end
end

function BeltalowdaCyro.AddObjectives()
	local numObjectives = GetNumObjectives()
	for i = 1, numObjectives do
		local keepId, objectiveId, bgqueryType = GetObjectiveIdsForIndex(i)
		if bgqueryType == BGQUERY_ASSIGNED_AND_LOCAL or bgqueryType == BGQUERY_LOCAL then
			if BeltalowdaCyro.state.keeps[keepId] ~= nil then
				BeltalowdaCyro.state.keeps[keepId].objectives = BeltalowdaCyro.state.keeps[keepId].objectives or {}
				if BeltalowdaCyro.state.keeps[keepId].objectives[1] == nil then
					BeltalowdaCyro.state.keeps[keepId].objectives[1] = {}
					BeltalowdaCyro.state.keeps[keepId].objectives[1].id = objectiveId
					BeltalowdaCyro.state.keeps[keepId].objectives[1].state = 100
					BeltalowdaCyro.state.keeps[keepId].objectives[1].holdingAlliance = BeltalowdaCyro.state.keeps[keepId].owningAlliance
				elseif BeltalowdaCyro.state.keeps[keepId].objectives[2] == nil then
					BeltalowdaCyro.state.keeps[keepId].objectives[2] = {}
					BeltalowdaCyro.state.keeps[keepId].objectives[2].id = objectiveId
					BeltalowdaCyro.state.keeps[keepId].objectives[2].state = 100
					BeltalowdaCyro.state.keeps[keepId].objectives[2].holdingAlliance = BeltalowdaCyro.state.keeps[keepId].owningAlliance
				end
			elseif BeltalowdaCyro.state.resources[keepId] ~= nil then
				BeltalowdaCyro.state.resources[keepId].objectives = BeltalowdaCyro.state.resources[keepId].objectives or {}
				BeltalowdaCyro.state.resources[keepId].objectives[1] = {}
				BeltalowdaCyro.state.resources[keepId].objectives[1].id = objectiveId
				BeltalowdaCyro.state.resources[keepId].objectives[1].state = 100
				BeltalowdaCyro.state.resources[keepId].objectives[1].holdingAlliance = BeltalowdaCyro.state.resources[keepId].owningAlliance
			elseif BeltalowdaCyro.state.outposts[keepId] ~= nil then
				BeltalowdaCyro.state.outposts[keepId].objectives = BeltalowdaCyro.state.outposts[keepId].objectives or {}
				if BeltalowdaCyro.state.outposts[keepId].objectives[1] == nil then
					BeltalowdaCyro.state.outposts[keepId].objectives[1] = {}
					BeltalowdaCyro.state.outposts[keepId].objectives[1].id = objectiveId
					BeltalowdaCyro.state.outposts[keepId].objectives[1].state = 100
					BeltalowdaCyro.state.outposts[keepId].objectives[1].holdingAlliance = BeltalowdaCyro.state.outposts[keepId].owningAlliance
				else
					BeltalowdaCyro.state.outposts[keepId].objectives[2] = {}
					BeltalowdaCyro.state.outposts[keepId].objectives[2].id = objectiveId
					BeltalowdaCyro.state.outposts[keepId].objectives[2].state = 100
					BeltalowdaCyro.state.outposts[keepId].objectives[2].holdingAlliance = BeltalowdaCyro.state.outposts[keepId].owningAlliance
				end
			elseif BeltalowdaCyro.state.villages[keepId] ~= nil then
				BeltalowdaCyro.state.villages[keepId].objectives = BeltalowdaCyro.state.villages[keepId].objectives or {}
				if BeltalowdaCyro.state.villages[keepId].objectives[1] == nil then
					BeltalowdaCyro.state.villages[keepId].objectives[1] = {}
					BeltalowdaCyro.state.villages[keepId].objectives[1].id = objectiveId
					BeltalowdaCyro.state.villages[keepId].objectives[1].state = 100
					BeltalowdaCyro.state.villages[keepId].objectives[1].holdingAlliance = BeltalowdaCyro.state.villages[keepId].owningAlliance
				elseif BeltalowdaCyro.state.villages[keepId].objectives[2] == nil then
					BeltalowdaCyro.state.villages[keepId].objectives[2] = {}
					BeltalowdaCyro.state.villages[keepId].objectives[2].id = objectiveId
					BeltalowdaCyro.state.villages[keepId].objectives[2].state = 100
					BeltalowdaCyro.state.villages[keepId].objectives[2].holdingAlliance = BeltalowdaCyro.state.villages[keepId].owningAlliance
				else
					BeltalowdaCyro.state.villages[keepId].objectives[3] = {}
					BeltalowdaCyro.state.villages[keepId].objectives[3].id = objectiveId
					BeltalowdaCyro.state.villages[keepId].objectives[3].state = 100
					BeltalowdaCyro.state.villages[keepId].objectives[3].holdingAlliance = BeltalowdaCyro.state.villages[keepId].owningAlliance
				end
			end
		end
	end
end

function BeltalowdaCyro.ResetObjective(keeps)
	for key, keep in pairs(keeps) do
		if keep.objectives ~= nil then
			for i = 1, #keep.objectives do
				keep.objectives[i].state = 100
				keep.objectives[i].holdingAlliance = keep.owningAlliance
			end
		end
	end
end

function BeltalowdaCyro.ResetObjectives()
	BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.keeps)
	BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.outposts)
	BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.resources)
	BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.villages)
	--BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.destructibles)
	--BeltalowdaCyro.ResetObjective(BeltalowdaCyro.state.temples)
end

function BeltalowdaCyro.GetResources()
	return BeltalowdaCyro.state.resources
end

function BeltalowdaCyro.GetKeeps()
	return BeltalowdaCyro.state.keeps
end

function BeltalowdaCyro.GetOutposts()
	return BeltalowdaCyro.state.outposts
end

function BeltalowdaCyro.GetVillages()
	return BeltalowdaCyro.state.villages
end

function BeltalowdaCyro.GetDestructibles()
	return BeltalowdaCyro.state.destructibles
end

function BeltalowdaCyro.GetTemples()
	return BeltalowdaCyro.state.temples
end

function BeltalowdaCyro.InitState()
	local gameTime = GetGameTimeMilliseconds()
	BeltalowdaCyro.InitResources(gameTime)
	BeltalowdaCyro.InitKeeps(gameTime)
	BeltalowdaCyro.InitOutposts(gameTime)
	BeltalowdaCyro.InitVillages(gameTime)
	BeltalowdaCyro.InitDestructibles(gameTime)
	BeltalowdaCyro.InitTemples(gameTime)
	BeltalowdaCyro.AddObjectives()
	BeltalowdaCyro.InitScrolls()
end

function BeltalowdaCyro.InitScrolls()
	BeltalowdaCyro.state.scrolls = {}
	for key, scrollKeep in pairs(BeltalowdaCyro.state.temples) do
		local scroll = {}
		scroll.id = GetKeepArtifactObjectiveId(key)
		local name, _, _ = GetObjectiveInfo(key, scroll.id, BGQUERY_LOCAL)
		scroll.name = zo_strformat("<<1>>", name)
		scroll.alliance = GetKeepAlliance(key, BGQUERY_LOCAL)
		table.insert(BeltalowdaCyro.state.scrolls, scroll)
	end
end

function BeltalowdaCyro.GetItemsOfInterest()
	return BeltalowdaCyro.state.itemsOfInterest
end

function BeltalowdaCyro.UpdateItemsOfInterest(itemsOfInterest)
	BeltalowdaCyro.state.itemsOfInterest = itemsOfInterest
	BeltalowdaCyro.NotifyUpdateConsumers(itemsOfInterest)
end

function BeltalowdaCyro.GetItemByKeepId(keepId)
	if keepId ~= nil then
		if BeltalowdaCyro.state.resources[keepId] ~= nil then
			return BeltalowdaCyro.state.resources[keepId]
		elseif BeltalowdaCyro.state.keeps[keepId] ~= nil then
			return BeltalowdaCyro.state.keeps[keepId]
		elseif BeltalowdaCyro.state.outposts[keepId] ~= nil then
			return BeltalowdaCyro.state.outposts[keepId]
		elseif BeltalowdaCyro.state.villages[keepId] ~= nil then
			return BeltalowdaCyro.state.villages[keepId]
		elseif BeltalowdaCyro.state.temples[keepId] ~= nil then
			return BeltalowdaCyro.state.temples[keepId]
		end
	end
	return nil
end

function BeltalowdaCyro.UpdateItem(items, gameTime)
	local itemsOfInterest = {}
	for key, item in pairs(items) do
		local itemOfInterest = false
		local previousOwningAlliance = item.owningAlliance
		item.owningAlliance = GetKeepAlliance(key, BGQUERY_LOCAL)
		if item.previousOwningAllianceTimestamp == nil or item.previousOwningAllianceTimestamp + BeltalowdaCyro.config.previousOwnerThreshold < gameTime then
			item.previousOwningAlliance = previousOwningAlliance
			item.previousOwningAllianceTimestamp = gameTime
		end
		local previousAttackState = item.isUnderAttack
		item.isUnderAttack = GetKeepUnderAttack(key,  BGQUERY_LOCAL)
		item.underAttackFor = 0
		item.isCoolingDown = true
		
		if item.owningAlliance ~= previousOwningAlliance and BeltalowdaCyro.state.destructibles[key] == nil then
			itemOfInterest = true
			--d("keep switched")
			if item.interestingSince == nil then
				item.interestingSince = gameTime
			end
			item.underAttackFor = gameTime - item.interestingSince
			if item.objectives ~= nil then
				for i = 1, #item.objectives do
					item.objectives[i].state = 100
					item.objectives[i].holdingAlliance = item.owningAlliance
				end
			end
			item.flipsAt = nil
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.KEEP_OWNER_CHANGED
			eventData.keepId = key
			eventData.keepName = zo_strformat("<<1>>", GetKeepName(key))
			eventData.alliance = item.owningAlliance
			eventData.previousOwningAlliance = previousOwningAlliance
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		end
		if previousAttackState == false and item.isUnderAttack == true then
			--throw isUaMessage
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.STATUS_UA
			eventData.keepId = key
			eventData.keepName = zo_strformat("<<1>>", GetKeepName(key))
			eventData.alliance = item.owningAlliance
			eventData.previousOwningAlliance = previousOwningAlliance
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
			if item.attackStatusLostAt ~= 0 and item.attackStatusLostAt + BeltalowdaCyro.config.siegeTimeout < gameTime then
				item.underAttackSince = gameTime
			end
		elseif previousAttackState == true and item.isUnderAttack == false then
			--throw isUaLostMessage
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.STATUS_UA_LOST
			eventData.keepId = key
			eventData.keepName = zo_strformat("<<1>>", GetKeepName(key))
			eventData.alliance = item.owningAlliance
			eventData.previousOwningAlliance = previousOwningAlliance
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
			item.attackStatusLostAt = gameTime
		end
		if item.isUnderAttack == true then
			itemOfInterest = true
			--d("is under attack")
			if item.interestingSince == nil then
				item.interestingSince = gameTime
			end
			item.underAttackFor = gameTime - item.interestingSince
			item.isCoolingDown = false
		else
			if item.attackStatusLostAt ~= 0 and item.attackStatusLostAt + BeltalowdaCyro.config.siegeTimeout > gameTime then
				itemOfInterest = true
				--d("not under attack")
				if item.interestingSince == nil then
					item.interestingSince = gameTime
				end
				item.underAttackFor = gameTime - item.interestingSince
			end
		end
		if BeltalowdaCyro.state.destructibles[key] == nil then
			item.siegeWeapons.AD = GetNumSieges(key, BGQUERY_LOCAL, ALLIANCE_ALDMERI_DOMINION)
			item.siegeWeapons.DC = GetNumSieges(key, BGQUERY_LOCAL, ALLIANCE_DAGGERFALL_COVENANT)
			item.siegeWeapons.EP = GetNumSieges(key, BGQUERY_LOCAL, ALLIANCE_EBONHEART_PACT)
		
			if item.siegeWeapons.AD > 0 or item.siegeWeapons.DC > 0 or item.siegeWeapons.EP > 0 then
				itemOfInterest = true
				item.isCoolingDown = false
				--d("siege weapons deployed")
				if item.interestingSince == nil then
					item.interestingSince = gameTime
				end
				item.underAttackFor = gameTime - item.interestingSince
				item.lastSiegeWeaponSeen = gameTime
			elseif item.lastSiegeWeaponSeen ~= nil and item.lastSiegeWeaponSeen + BeltalowdaCyro.config.siegeTimeout > gameTime then
				itemOfInterest = true
				if item.interestingSince == nil then
					item.interestingSince = gameTime
				end
				item.underAttackFor = gameTime - item.interestingSince
			else
				item.lastSiegeWeaponSeen = nil
			end
		end
		
		if item.keepType == KEEPTYPE_BRIDGE or item.keepType == KEEPTYPE_MILEGATE then
			item.isPassable = IsKeepPassable(key, BGQUERY_LOCAL)
			item.directionalAccess = GetKeepDirectionalAccess(key, BGQUERY)
		end
		if itemOfInterest == true then
			--d(key)
			table.insert(itemsOfInterest, item)
		else
			item.interestingSince = nil
		end
	end
	return itemsOfInterest
end

function BeltalowdaCyro.AdjustItemsOfInterest(oldItems, newItems)
	if newItems ~= nil then
		for i = 1, #newItems do
			table.insert(oldItems, newItems[i])
		end
	end
	return oldItems
end

function BeltalowdaCyro.SortItemsOfInterest(itemA, itemB)
	--d(itemA)
	--d(itemB)
	--d("----")
	if itemA == nil or itemB == nil or itemA.interestingSince == nil or itemB.interestingSince == nil then
		return true
	end
	if itemA.interestingSince > itemB.interestingSince then
		return false
	elseif itemA.interestingSince < itemB.interestingSince then
		return true
	else
		if itemA.name ~= nil and itemB.name ~= nil and itemA.name > itemB.name then
			return false
		elseif itemA.name ~= nil and itemB.name ~= nil and itemA.name < itemB.name then
			return true
		else
			--something is odd, there seems to be a subtle bug or table.sort is doing strange things
			--d("wtf")
			--d(#BeltalowdaCyro.state.itemsOfInterest)
			--d(itemA)
			--d(itemB)
			return false
		end
	end
	return false
end

function BeltalowdaCyro.GetFlagStatePercent(state, owningAlliance, holdingAlliance)
	local percent = 99
	if state == OBJECTIVE_CONTROL_STATE_AREA_ABOVE_CONTROL_THRESHOLD then
		if holdingAlliance == owningAlliance then
			percent = 90
		else
			percent = 51
		end
	elseif state == OBJECTIVE_CONTROL_STATE_AREA_NO_CONTROL then
		if holdingAlliance == 0 then
			percent = 0
		else
			percent = 10
		end
	elseif state == OBJECTIVE_CONTROL_STATE_AREA_MAX_CONTROL then
		percent = 100
	elseif state == OBJECTIVE_CONTROL_STATE_AREA_BELOW_CONTROL_THRESHOLD then
		if holdingAlliance == owningAlliance then
			percent = 40
		else
			percent = 10
		end
	end
	return percent
end

function BeltalowdaCyro.GetFlipConstant(keepType)
	if keepType == KEEPTYPE_KEEP then
		return BeltalowdaCyro.constants.flipTimes.KEEP
	elseif keepType == KEEPTYPE_OUTPOST then
		return BeltalowdaCyro.constants.flipTimes.OUTPOST
	elseif keepType == KEEPTYPE_RESOURCE then
		return BeltalowdaCyro.constants.flipTimes.RESOURCE
	else
		return 0
	end
end

function BeltalowdaCyro.FlagsAtFlipState(objectives, owningAlliance)
	local flips = false
	if objectives ~= nil then
		local flipedFlags = 0
		--d("----------------------")
		--d("objective states: ")
		for i = 1, #objectives do
			--d("id: " .. objectives[i].id)
			--d("state: " .. objectives[i].state)
			if objectives[i].holdingAlliance ~= owningAlliance and objectives[i].state > 50 then
				flipedFlags = flipedFlags + 1
			else
				break
			end
		end
		if flipedFlags == #objectives then
			if #objectives == 1 then
				flips = true
			elseif #objectives == 2 and objectives[1].holdingAlliance == objectives[2].holdingAlliance then
				flips = true
			elseif #objectives == 3 and objectives[1].holdingAlliance == objectives[2].holdingAlliance and objectives[1].holdingAlliance == objectives[3].holdingAlliance then
				flips = true
			end
		end
	end
	return flips
end

function BeltalowdaCyro.AdjustKeepFlipping(keep)
	local flipTime = BeltalowdaCyro.GetFlipConstant(keep.keepType)
	if flipTime > 0 then
		if keep.flipsAt == nil and BeltalowdaCyro.FlagsAtFlipState(keep.objectives, keep.owningAlliance) == true then
			keep.flipsAt = GetGameTimeMilliseconds() + flipTime
		elseif keep.flipsAt ~= nil and BeltalowdaCyro.FlagsAtFlipState(keep.objectives, keep.owningAlliance) == true then
			--all good
		else
			keep.flipsAt = nil
		end
	end
end

function BeltalowdaCyro.GetScrollAlliance(artifactName)
	local alliance = 0
	for i = 1, #BeltalowdaCyro.state.scrolls do
		if BeltalowdaCyro.state.scrolls[i].name == artifactName then
			alliance = BeltalowdaCyro.state.scrolls[i].alliance
			break
		end
	end
	return alliance
end

function BeltalowdaCyro.AdjustCoordinates(keeps)
	if keeps ~= nil then
		for key, keep in pairs(keeps) do
			local _, x, y = GetKeepPinInfo(key, BGQUERY_LOCAL)
			keep.x = x
			keep.y = y
		end
	end
end

function BeltalowdaCyro.AdjustKeepCoordinates()
	BeltalowdaCyro.AdjustCoordinates(BeltalowdaCyro.state.keeps)
end

function BeltalowdaCyro.AdjustOutpostCoordinates()
	BeltalowdaCyro.AdjustCoordinates(BeltalowdaCyro.state.outposts)
end

function BeltalowdaCyro.AdjustVillageCoordinates()
	BeltalowdaCyro.AdjustCoordinates(BeltalowdaCyro.state.villages)
end

function BeltalowdaCyro.TempDebugPrint(name, value)
	if value ~= nil and (type(value) == "number" or type(value) == "string") then
		BeltalowdaChat.SendChatMessage(name .. ": " .. value, BeltalowdaCyro.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	elseif value ~= nil and type(value) == "boolean" then
		if value == true then
			BeltalowdaChat.SendChatMessage(name .. ": true", BeltalowdaCyro.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		else
			BeltalowdaChat.SendChatMessage(name .. ": false", BeltalowdaCyro.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
		end
	end
end

--callbacks
function BeltalowdaCyro.OnPlayerActivated()
	if BeltalowdaUtil.IsInCyrodiil() == true then
		if BeltalowdaCyro.state.initializedItems == false then
			BeltalowdaCyro.InitState()
			BeltalowdaCyro.state.initializedItems = true
		end
		if BeltalowdaCyro.state.registredConsumers == false and #BeltalowdaCyro.state.consumers > 0 then
			
			BeltalowdaCyro.state.registredConsumers = true
			BeltalowdaCyro.state.campaignId = GetCurrentCampaignId()
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_GUILD_CLAIM_KEEP_CAMPAIGN_NOTIFICATION, BeltalowdaCyro.OnGuildClaimKeepCampaignNotification)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_GUILD_LOST_KEEP_CAMPAIGN_NOTIFICATION, BeltalowdaCyro.OnGuildLostKeepCampaignNotification)
			--EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_ALLIANCE_POINT_UPDATE, BeltalowdaCyro.OnApUpdate)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_OBJECTIVE_CONTROL_STATE, BeltalowdaCyro.OnObjectiveControlState)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_ARTIFACT_CONTROL_STATE, BeltalowdaCyro.OnScrollState)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_CORONATE_EMPEROR_NOTIFICATION , BeltalowdaCyro.OnCoronateEmperorNotification)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_DEPOSE_EMPEROR_NOTIFICATION , BeltalowdaCyro.OnDeposeEmperorNotification)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_ACTIVE_DAEDRIC_ARTIFACT_CHANGED, BeltalowdaCyro.OnActiveDaedricArtifactChanged)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED, BeltalowdaCyro.OnDaedricArtifactObjectiveStateChanged)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaCyro.callbackName, EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED, BeltalowdaCyro.OnDaedricArtifactObjectiveSpawnedButNoRevealed)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaCyro.callbackName, BeltalowdaCyro.config.updateInterval, BeltalowdaCyro.CyroUpdateLoop)
		end
		if #BeltalowdaCyro.state.consumers > 0 then
			BeltalowdaCyro.ResetObjectives()
		end
	else
		if BeltalowdaCyro.state.registredConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_ARTIFACT_CONTROL_STATE)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_OBJECTIVE_CONTROL_STATE)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_GUILD_CLAIM_KEEP_CAMPAIGN_NOTIFICATION)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_GUILD_LOST_KEEP_CAMPAIGN_NOTIFICATION)
			--EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_ALLIANCE_POINT_UPDATE)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_CORONATE_EMPEROR_NOTIFICATION)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_DEPOSE_EMPEROR_NOTIFICATION)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_ACTIVE_DAEDRIC_ARTIFACT_CHANGED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaCyro.callbackName, EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaCyro.callbackName)
			BeltalowdaCyro.state.registredConsumers = false
			BeltalowdaCyro.state.campaignId = 0
		end
		BeltalowdaCyro.state.initializedItems = false
	end
end

-- /script d(#Beltalowda.util.cyrodiil.state.itemsOfInterest)
function BeltalowdaCyro.CyroUpdateLoop()
	if BeltalowdaUtil.IsInCyrodiil() == true then
		local itemsOfInterest = {}
		local gameTime = GetGameTimeMilliseconds()
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.resources, gameTime))
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.keeps, gameTime))
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.outposts, gameTime))
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.villages, gameTime))
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.destructibles, gameTime))
		itemsOfInterest = BeltalowdaCyro.AdjustItemsOfInterest(itemsOfInterest, BeltalowdaCyro.UpdateItem(BeltalowdaCyro.state.temples, gameTime))
		--d("Sort: " .. #itemsOfInterest)
		if #itemsOfInterest > 1 then
			table.sort(itemsOfInterest, BeltalowdaCyro.SortItemsOfInterest)
		end
		BeltalowdaCyro.UpdateItemsOfInterest(itemsOfInterest)
	end
end


function BeltalowdaCyro.OnGuildClaimKeepCampaignNotification(eventCode, campaignId, keepId, guildName, playerName)
	if BeltalowdaCyro.state.campaignId == campaignId then
		--d("KeepId Claim: " .. keepId .. " -> " .. guildName .. " -> " .. playerName)
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.GUILD_CLAIM
		eventData.keepName = zo_strformat("<<1>>", GetKeepName(keepId))
		eventData.keepId = keepId
		eventData.guildName = guildName
		local alliance = GetKeepAlliance(keepId, BGQUERY_LOCAL)
		if alliance ~= nil then
			eventData.alliance = alliance
		else
			eventData.alliance = 0
		end
		eventData.playerName = playerName
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
end


function BeltalowdaCyro.OnGuildLostKeepCampaignNotification(eventCode, campaignId, keepId, guildName)
	if BeltalowdaCyro.state.campaignId == campaignId then
		--d("KeepId Lost: " .. keepId .. " -> " .. guildName)
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.GUILD_LOST
		eventData.keepName = zo_strformat("<<1>>", GetKeepName(keepId))
		eventData.keepId = keepId
		eventData.guildName = guildName
		local item = BeltalowdaCyro.GetItemByKeepId(keepId)
		local alliance = GetKeepAlliance(keepId, BGQUERY_LOCAL)
		if alliance ~= nil then
			eventData.alliance = alliance
		else
			eventData.alliance = 0
		end
		local item = BeltalowdaCyro.state.resources[keepId] or BeltalowdaCyro.state.keeps[keepId] or BeltalowdaCyro.state.outposts[keepId] or BeltalowdaCyro.state.villages[keepId]
		if item ~= nil and item.previousOwningAlliance ~= nil then
			eventData.previousOwningAlliance = item.previousOwningAlliance
		else
			eventData.previousOwningAlliance = 0
		end
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
end

function BeltalowdaCyro.OnObjectiveControlState(eventCode, keepId, objectiveId, battlegroundContext, objectiveName, objectiveType, objectiveControlEvent, objectiveControlState, holdingAlliance, attackingAlliance, pinType)
	--d(objectiveName)
	--d(holdingAlliance)
	--d(objectiveParam2)
	--d("keepId..:" .. keepId)
	--/script EVENT_MANAGER:RegisterForEvent("test", EVENT_OBJECTIVE_CONTROL_STATE,function(ec, kId, oId, bC, oName, oType, oCE, oCS, hA, aA, pT) d('---') d(oCS) d(hA) d('---') end)
	local keep = BeltalowdaCyro.GetItemByKeepId(keepId)
	if keep ~= nil then
		--d("-----------------")
		--d("keepId: " .. keepId)
		--d("objectiveId: " .. objectiveId)
		--d("objectiveName: " .. objectiveName)
		--d("holdingAlliance: " .. holdingAlliance)
		--d("attackingAlliance: " .. attackingAlliance)
		local objectives = keep.objectives
		local objective = nil
		--Race Condition onplayer activated => GetNumObjectives() (likely all such methods...)
		if objectives == nil then
			BeltalowdaChat.SendChatMessage("Race condition detected. Trying to fix it...", BeltalowdaCyro.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
			BeltalowdaCyro.AddObjectives()
		end
		if objectives ~= nil then
			for i = 1, #objectives do
				if objectives[i].id == objectiveId then
					objective = objectives[i]
					break
				end
			end
		else
			BeltalowdaCyro.TempDebugPrint("OnObjectiveControlState objectives", "nil")
		end
		if objective ~= nil then
			objective.holdingAlliance = holdingAlliance
			if objective.holdingAlliance == 0 then
				objective.holdingAlliance = attackingAlliance
			end
			objective.state = BeltalowdaCyro.GetFlagStatePercent(objectiveControlState, keep.owningAlliance, holdingAlliance)
			--d("state: " .. objective.state)
			BeltalowdaCyro.AdjustKeepFlipping(keep)
			BeltalowdaCyro.UpdateItemsOfInterest(BeltalowdaCyro.state.itemsOfInterest)
		end
	end
end

function BeltalowdaCyro.OnApUpdate(eventCode, alliancePoints, playSound, difference, reason, keepId)
	if reason == CURRENCY_CHANGE_REASON_DEFENSIVE_KEEP_REWARD then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.TICK_DEFENSE
		eventData.keepName = zo_strformat("<<1>>", GetKeepName(keepId))
		eventData.keepId = keepId
		eventData.apGained = difference
		local alliance = GetKeepAlliance(keepId, BGQUERY_LOCAL)
		if alliance ~= nil then
			eventData.alliance = alliance
		else
			eventData.alliance = 0
		end
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	elseif reason == CURRENCY_CHANGE_REASON_OFFENSIVE_KEEP_REWARD then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.TICK_OFFENSE
		eventData.keepName = zo_strformat("<<1>>", GetKeepName(keepId))
		eventData.keepId = keepId
		eventData.apGained = difference
		local alliance = GetUnitAlliance("player")
		if alliance ~= nil then
			eventData.alliance = alliance
		else
			eventData.alliance = 0
		end
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	elseif reason == CURRENCY_CHANGE_REASON_QUESTREWARD then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.QUEST_REWARD
		eventData.apGained = difference
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	elseif reason == CURRENCY_CHANGE_REASON_BATTLEGROUND then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.BATTLEGROUND_REWARD
		eventData.apGained = difference
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	elseif reason == CURRENCY_CHANGE_REASON_MEDAL then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.BATTLEGROUND_MEDAL_REWARD
		eventData.apGained = difference
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
	--d("AP: " .. difference .. ", reason: " .. reason)
	--if keepId ~= nil then
	--	d("KeepId: " .. keepId)
	--end
end

function BeltalowdaCyro.OnScrollState(eventCode, artifactName, keepId, characterName, playerAlliance, objectiveControlEvent, objectiveControlState, campaignId, displayName)
	if BeltalowdaCyro.state.campaignId == campaignId then
		artifactName = zo_strformat("<<1>>", artifactName)
		if objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_DROPPED then
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.SCROLL_DROPPED
			eventData.charName = characterName
			eventData.displayName = displayName
			eventData.playerAlliance = playerAlliance
			eventData.scrollAlliance = BeltalowdaCyro.GetScrollAlliance(artifactName)
			eventData.scroll = artifactName
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_TAKEN then
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.SCROLL_PICKED_UP
			eventData.charName = characterName
			eventData.displayName = displayName
			eventData.playerAlliance = playerAlliance
			eventData.scrollAlliance = BeltalowdaCyro.GetScrollAlliance(artifactName)
			eventData.scroll = artifactName
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_RETURNED then
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.SCROLL_RETURNED
			eventData.charName = characterName
			eventData.displayName = displayName
			eventData.playerAlliance = playerAlliance
			eventData.scrollAlliance = BeltalowdaCyro.GetScrollAlliance(artifactName)
			eventData.scroll = artifactName
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_RETURNED_BY_TIMER then
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.SCROLL_RETURNED_BY_TIMER
			eventData.scroll = artifactName
			eventData.scrollAlliance = BeltalowdaCyro.GetScrollAlliance(artifactName)
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_CAPTURED then
			local eventData = {}
			eventData.event = BeltalowdaCyro.constants.events.SCROLL_CAPTURED
			eventData.charName = characterName
			eventData.displayName = displayName
			eventData.playerAlliance = playerAlliance
			eventData.scrollAlliance = BeltalowdaCyro.GetScrollAlliance(artifactName)
			eventData.scroll = artifactName
			eventData.keepId = keepId
			eventData.keepName = zo_strformat("<<1>>", GetKeepName(keepId))
			BeltalowdaCyro.NotifyMessageConsumers(eventData)
		end
	end
end

function BeltalowdaCyro.OnCoronateEmperorNotification(eventCode, campaignId, characterName, emperorAlliance, displayName)
	if BeltalowdaCyro.state.campaignId == campaignId then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.EMPEROR_CORONATED
		eventData.charName = characterName
		eventData.displayName = displayName
		eventData.alliance = emperorAlliance
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
end

function BeltalowdaCyro.OnDeposeEmperorNotification(eventCode, campaignId, characterName, emperorAlliance, abdication, displayName)
	if BeltalowdaCyro.state.campaignId == campaignId then
		local eventData = {}
		eventData.event = BeltalowdaCyro.constants.events.EMPEROR_DEPOSED
		eventData.charName = characterName
		eventData.displayName = displayName
		eventData.alliance = emperorAlliance
		eventData.abdication = abdication
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
end
			
function BeltalowdaCyro.OnActiveDaedricArtifactChanged(eventCode, artifactId)
	BeltalowdaCyro.TempDebugPrint("OnActiveDaedricArtifactChanged", artifactId)
end

function BeltalowdaCyro.OnDaedricArtifactObjectiveSpawnedButNoRevealed(eventCode, daedricArtifactId)
	BeltalowdaCyro.TempDebugPrint("OnDaedricArtifactObjectiveSpawnedButNoRevealed", "invoked")
	BeltalowdaCyro.TempDebugPrint("daedricArtifactId", daedricArtifactId)
	local eventData = {}
	eventData.event = BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_SPAWNED
	if GetDaedricArtifactDisplayName ~= nil and GetDaedricArtifactDisplayName(daedricArtifactId) ~= nil or GetDaedricArtifactDisplayName(daedricArtifactId) ~= "" then
		eventData.objectiveName = GetDaedricArtifactDisplayName(daedricArtifactId)
	else
		eventData.objectiveName = "[Unknown]"
	end
	
	BeltalowdaCyro.NotifyMessageConsumers(eventData)
	
end

function BeltalowdaCyro.OnDaedricArtifactObjectiveStateChanged(eventCode, objectiveKeepId, objectiveObjectiveId, battlegroundContext, objectiveControlEvent, objectiveControlState, holderAlliance, lastHolderAlliance, holderRawCharacterName, holderDisplayName, lastHolderRawCharacterName, lastHolderDisplayName, pinType, daedricArtifactId)
	BeltalowdaCyro.TempDebugPrint("OnDaedricArtifactObjectiveStateChanged", "invoked")
	BeltalowdaCyro.TempDebugPrint("IsInCampaign", IsInCampaign())
	BeltalowdaCyro.TempDebugPrint("objectiveKeepId", objectiveKeepId)
	BeltalowdaCyro.TempDebugPrint("objectiveObjectiveId", objectiveObjectiveId)
	BeltalowdaCyro.TempDebugPrint("battlegroundContext", battlegroundContext)
	BeltalowdaCyro.TempDebugPrint("objectiveControlEvent", objectiveControlEvent)
	BeltalowdaCyro.TempDebugPrint("objectiveControlState", objectiveControlState)
	BeltalowdaCyro.TempDebugPrint("holderAlliance", holderAlliance)
	BeltalowdaCyro.TempDebugPrint("lastHolderAlliance", lastHolderAlliance)
	BeltalowdaCyro.TempDebugPrint("holderRawCharacterName", holderRawCharacterName)
	BeltalowdaCyro.TempDebugPrint("holderDisplayName", holderDisplayName)
	BeltalowdaCyro.TempDebugPrint("lastHolderRawCharacterName", lastHolderRawCharacterName)
	BeltalowdaCyro.TempDebugPrint("lastHolderDisplayName", lastHolderDisplayName)
	BeltalowdaCyro.TempDebugPrint("pinType", pinType)
	BeltalowdaCyro.TempDebugPrint("daedricArtifactId", daedricArtifactId)
	
	BeltalowdaCyro.TempDebugPrint("objectiveName", GetObjectiveInfo(objectiveKeepId, objectiveObjectiveId, battlegroundContext))
	if IsInCampaign() then
		local eventData = {}
		eventData.objectiveName = GetObjectiveInfo(objectiveKeepId, objectiveObjectiveId, battlegroundContext)
		if objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_SPAWNED then
			eventData.event = BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_REVEALED
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_DROPPED then
			eventData.event = BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DROPPED
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_FLAG_TAKEN then
			eventData.event = BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_TAKEN
		elseif objectiveControlEvent == OBJECTIVE_CONTROL_EVENT_ITERATION_END then --This might be an other objective event!
			eventData.event = BeltalowdaCyro.constants.events.DAEDRIC_ARTIFACT_DESPAWNED
		end
		eventData.alliance = holderAlliance
		if holderAlliance == 0 then
			eventData.alliance = lastHolderAlliance
		end
		BeltalowdaCyro.NotifyMessageConsumers(eventData)
	end
end