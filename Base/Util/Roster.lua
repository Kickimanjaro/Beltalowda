-- Beltalowda Roster
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
Beltalowda.util.roster = Beltalowda.util.roster or {}

local BeltalowdaRoster = Beltalowda.util.roster

BeltalowdaRoster.callbackName = Beltalowda.addonName .. "Util.Roster"
BeltalowdaRoster.friends = {}
BeltalowdaRoster.guilds = {}
BeltalowdaRoster.guilds[1] = {}
BeltalowdaRoster.guilds[1].all = {}
BeltalowdaRoster.guilds[1].at = {}
BeltalowdaRoster.guilds[1].name = ""
BeltalowdaRoster.guilds[1].id = 0
BeltalowdaRoster.guilds[2] = {}
BeltalowdaRoster.guilds[2].all = {}
BeltalowdaRoster.guilds[2].at = {}
BeltalowdaRoster.guilds[2].name = ""
BeltalowdaRoster.guilds[2].id = 0
BeltalowdaRoster.guilds[3] = {}
BeltalowdaRoster.guilds[3].all = {}
BeltalowdaRoster.guilds[3].at = {}
BeltalowdaRoster.guilds[3].name = ""
BeltalowdaRoster.guilds[3].id = 0
BeltalowdaRoster.guilds[4] = {}
BeltalowdaRoster.guilds[4].all = {}
BeltalowdaRoster.guilds[4].at = {}
BeltalowdaRoster.guilds[4].name = ""
BeltalowdaRoster.guilds[4].id = 0
BeltalowdaRoster.guilds[5] = {}
BeltalowdaRoster.guilds[5].all = {}
BeltalowdaRoster.guilds[5].at = {}
BeltalowdaRoster.guilds[5].name = ""
BeltalowdaRoster.guilds[5].id = 0

BeltalowdaRoster.state = {}
BeltalowdaRoster.state.guildListConsumers = {}

BeltalowdaRoster.constants = {}
BeltalowdaRoster.constants.RDK = "Retter des Kaiserreiches"
BeltalowdaRoster.constants.adminRanks = {}
BeltalowdaRoster.constants.adminRanks[1] = 1
BeltalowdaRoster.constants.adminRanks[2] = 2
BeltalowdaRoster.constants.adminRanks[3] = 3


--[[
	Current Known Bugs:
	- If the game fucks up, the API doesn't come up with any guilds, players etc. This means that under certain circumstances this functionality doesn't work
	- If anything changes on the roster during a loading screen, it won't be noticed. EVENT_PLAYER_ACTIVATED should be used to completely rebuild the roster. Yet for performance reason this hasn't been implemented.
]]

function BeltalowdaRoster.Initialize()
	--create list
	
	for guildId = 1, GetNumGuilds() do
		BeltalowdaRoster.guilds[guildId].name = GetGuildName(BeltalowdaRoster.GetGuildIdFromId(guildId))
        for memberId = 1, GetNumGuildMembers(BeltalowdaRoster.GetGuildIdFromId(guildId)) do
            local hasCharacter, charName, zoneName, classType, alliance, level, championRank, zoneId = GetGuildMemberCharacterInfo(BeltalowdaRoster.GetGuildIdFromId(guildId), memberId)
            local name, note, rankIndex, playerStatus, secsSinceLogoff = GetGuildMemberInfo(BeltalowdaRoster.GetGuildIdFromId(guildId), memberId)

			charName = zo_strformat("<<!aC:1>>", charName)
			local character = {}
			character.displayName = name
			character.name = charName
			character.rankIndex = rankIndex
			local charNameIndex = string.sub(charName, 1, 1)
			local displayNameIndex = string.sub(name, 2, 2)

			BeltalowdaRoster.guilds[guildId][charNameIndex] = BeltalowdaRoster.guilds[guildId][charNameIndex] or {}
			BeltalowdaRoster.guilds[guildId].at[displayNameIndex] = BeltalowdaRoster.guilds[guildId].at[displayNameIndex] or {}
			BeltalowdaRoster.guilds[guildId].id = GetGuildId(guildId)
			
			table.insert(BeltalowdaRoster.guilds[guildId].all, character)
			table.insert(BeltalowdaRoster.guilds[guildId].at[displayNameIndex], character)
			table.insert(BeltalowdaRoster.guilds[guildId][charNameIndex], character)
			
		end
	end
	
	for friendIndex = 1, GetNumFriends() do
        local displayName, note, playerStatus, secsSinceLogoff = GetFriendInfo(friendIndex)
		local hasCharacter, characterName, zoneName, classType, alliance, level, championRank, zoneId = GetFriendCharacterInfo(friendIndex)
		characterName = zo_strformat("<<!aC:1>>", characterName)
		
		local character = {}
		character.displayName = displayName
		character.name = characterName
		
		table.insert(BeltalowdaRoster.friends, character)
    end
	
	
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_FRIEND_ADDED, BeltalowdaRoster.OnFriendAdded)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_FRIEND_REMOVED, BeltalowdaRoster.OnFriendRemoved)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_GUILD_MEMBER_ADDED, BeltalowdaRoster.OnGuildMemberAdded)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_GUILD_MEMBER_REMOVED, BeltalowdaRoster.OnGuildMemberRemoved)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_GUILD_MEMBER_RANK_CHANGED, BeltalowdaRoster.OnGuildMemberRankChanged)
	
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_GUILD_SELF_JOINED_GUILD, BeltalowdaRoster.OnGuildJoined)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaRoster.callbackName, EVENT_GUILD_SELF_LEFT_GUILD, BeltalowdaRoster.OnGuildLeft)
end

--functions
function BeltalowdaRoster.GetGuildIdFromId(id)
--Elsweyr Changes
	if GetGuildId ~= nil then
		return GetGuildId(id)
	else
		return id
	end
end

function BeltalowdaRoster.GetGuidIdFromEventGuidId(id)
	if GetGuildId ~= nil then
		for guildId = 1, GetNumGuilds() do
			if id == GetGuildId(guildId) then
				id = guildId
				break
			end
		end
	end
	return id
end

function BeltalowdaRoster.IsFriendByCharName(name)
	local nameExists = false
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.friends do
			if BeltalowdaRoster.friends[i].name == name then
				nameExists = true
				break
			end	
		end
	end
	return nameExists
end

function BeltalowdaRoster.IsFriendByAccountName(name)
	local nameExists = false
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.friends do
			if BeltalowdaRoster.friends[i].displayName == name then
				nameExists = true
				break
			end	
		end
	end
	return nameExists
end

function BeltalowdaRoster.IsFriend(name)
	local nameExists = false
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.friends do
			if BeltalowdaRoster.friends[i].displayName == name or BeltalowdaRoster.friends[i].name == name then
				nameExists = true
				break
			end	
		end
	end
	return nameExists
end

function BeltalowdaRoster.IsGuildMemberByCharName(name, guildAllowed)
	local nameExists = false
	if name ~= nil and string.len(name) > 2 then
		local index = string.sub(name, 1, 1)
		for guildId = 1, #BeltalowdaRoster.guilds do
			local guildDictionary = BeltalowdaRoster.guilds[guildId][index]
			if guildAllowed == nil or (guildAllowed ~= nil and guildAllowed[guildId] ~= nil and guildAllowed[guildId] == true) then
				if guildDictionary ~= nil then
					for i = 1, #guildDictionary do
						if guildDictionary[i].name == name then
							nameExists = true
							break
						end
					end
				end
			end
		end
	end
	return nameExists
end

function BeltalowdaRoster.IsGuildMemberByAccountName(name, guildAllowed)
	local nameExists = false
	if name ~= nil and string.len(name) > 2 then
		local index = string.sub(name, 2, 2)
		for guildId = 1, #BeltalowdaRoster.guilds do
			local guildDictionary = BeltalowdaRoster.guilds[guildId].at[index]
			if guildAllowed == nil or (guildAllowed ~= nil and guildAllowed[guildId] ~= nil and guildAllowed[guildId] == true) then
				if guildDictionary ~= nil then
					for i = 1, #guildDictionary do
						if guildDictionary[i].displayName == name then
							nameExists = true
							break
						end
					end
				end
			end
		end
	end
	return nameExists
end

function BeltalowdaRoster.IsGuildMember(name)
	local nameExists = false
	if name ~= nil and string.len(name) > 2 then
		local accIndex = string.sub(name, 2, 2)
		local charIndex = string.sub(name, 1, 1)
		for guildId = 1, #BeltalowdaRoster.guilds do
			local guildDictionary = BeltalowdaRoster.guilds[guildId][charIndex]
			if guildDictionary ~= nil then
				for i = 1, #guildDictionary do
					if guildDictionary[i].name == name then
						nameExists = true
						break
					end
				end
			end
			guildDictionary = BeltalowdaRoster.guilds[guildId].at[accIndex]
			if guildDictionary ~= nil then
				for i = 1, #guildDictionary do
					if guildDictionary[i].displayName == name then
						nameExists = true
						break
					end
				end
			end
		end
	end
	return nameExists
end

function BeltalowdaRoster.GetGuildIdForName(name)
	local retVal = nil
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.guilds do
			if BeltalowdaRoster.guilds[i].name == name then
				retVal = i
				break
			end
		end
	end
	return retVal
end

function BeltalowdaRoster.IsBeltalowdaMember(displayName)
	local isMember = false
	for guildId = 1, #BeltalowdaRoster.guilds do
		if BeltalowdaRoster.guilds[guildId].name == BeltalowdaRoster.constants.RDK then
			local guild = BeltalowdaRoster.guilds[guildId]
			local guildDictionary = guild.at[string.sub(displayName, 2, 2)]
			if guildDictionary ~= nil then
				for j = 1, #guildDictionary do
					if guildDictionary[j].displayName == displayName then
						isMember = true
						break
					end
				end
				break
			end
		end
	end
	return isMember
end

function BeltalowdaRoster.IsGuildOfficerOf(targetName, officerName)
	local isOfficer = false
	if targetName ~= nil and officerName ~= nil then
		for guildId = 1, #BeltalowdaRoster.guilds do
			
			local guild = BeltalowdaRoster.guilds[guildId]
			local targetGuildDictionary = guild.at[string.sub(targetName, 2, 2)]
			local officerGuildDictionary = guild.at[string.sub(officerName, 2, 2)]
			local isInGuild = false
			local isGuidOfficer = false
			if targetGuildDictionary ~= nil and officerGuildDictionary ~= nil then
				for j = 1, #targetGuildDictionary do
					if targetGuildDictionary[j].displayName == targetName then
						isInGuild = true
						break
					end
				end
				for j = 1, #officerGuildDictionary do
					if officerGuildDictionary[j].displayName == officerName then
						for k = 1, #BeltalowdaRoster.constants.adminRanks do
							if BeltalowdaRoster.constants.adminRanks[k] == officerGuildDictionary[j].rankIndex then
								isGuidOfficer = true
								break
							end
						end
					end
				end
				if isGuidOfficer == true and isInGuild == true then
					isOfficer = true
					break
				end
			end
		end
	end
	return isOfficer
end

function BeltalowdaRoster.IsGuildOfficer(displayName)
	local isOfficer = false
	if displayName ~= nil then
		for guildId = 1, #BeltalowdaRoster.guilds do
			--d("index: " .. guildId)
			local guild = BeltalowdaRoster.guilds[guildId]
			local guildDictionary = guild.at[string.sub(displayName, 2, 2)]
			if guildDictionary ~= nil then
				for j = 1, #guildDictionary do
					if guildDictionary[j].displayName == displayName then
						--d("member exists")
						for k = 1, #BeltalowdaRoster.constants.adminRanks do
							if BeltalowdaRoster.constants.adminRanks[k] == guildDictionary[j].rankIndex then
								isOfficer = true
								break
							end
						end
						break
					end
				end
				if isOfficer == true then
					break
				end
			end
		end
	end
	return isOfficer
end

function BeltalowdaRoster.IsBeltalowdaAdmin(displayName)
	local isAdmin = false
	if displayName ~= nil then
		for guildId = 1, #BeltalowdaRoster.guilds do
			if BeltalowdaRoster.guilds[guildId].name == BeltalowdaRoster.constants.RDK then
				local guild = BeltalowdaRoster.guilds[guildId]
				local guildDictionary = guild.at[string.sub(displayName, 2, 2)]
				if guildDictionary ~= nil then

					for j = 1, #guildDictionary do
						if guildDictionary[j].displayName == displayName then
							for k = 1, #BeltalowdaRoster.constants.adminRanks do
								if BeltalowdaRoster.constants.adminRanks[k] == guildDictionary[j].rankIndex then
									isAdmin = true
									break
								end
							end
							break
						end
					end
					break
				end
			end
		end
	end
	return isAdmin
end


--consumers / listeners
function BeltalowdaRoster.GuildListConsumerExists(name)
	local exists = false
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.state.guildListConsumers do
			if BeltalowdaRoster.state.guildListConsumers[i].name == name then
				exists = true
				break
			end
		end
	end
	return exists
end

function BeltalowdaRoster.AddGuildListConsumer(name, callback)
	if name ~= nil and callback ~= nil then
		if BeltalowdaRoster.GuildListConsumerExists(name) == false then
			local entry = {}
			entry.name = name
			entry.callback = callback
			table.insert(BeltalowdaRoster.state.guildListConsumers, entry)
		end
	end
end

function BeltalowdaRoster.RemoveGuildListConsumer(name)
	if name ~= nil then
		for i = 1, #BeltalowdaRoster.state.guildListConsumers do
			if BeltalowdaRoster.state.guildListConsumers[i].name == name then
				table.remove(BeltalowdaRoster.state.guildListConsumers, i)
				break
			end
		end
	end
end

function BeltalowdaRoster.GuildListChanged()
	for i = 1, #BeltalowdaRoster.state.guildListConsumers do
		if type(BeltalowdaRoster.state.guildListConsumers[i].callback) == "function" then
			BeltalowdaRoster.state.guildListConsumers[i].callback()
		end
	end
end

function BeltalowdaRoster.GetGuildIndex(guildId)
	local guildIndex = nil
	for i = 1, 5 do
		if guildId == BeltalowdaRoster.guilds[i].id then
			guildIndex = i
			break
		end
	end
	return guildIndex
end

--callbacks
function BeltalowdaRoster.OnFriendAdded(eventCode, name)
	if eventCode == EVENT_FRIEND_ADDED then
		for friendIndex = 1, GetNumFriends() do
			local displayName, note, playerStatus, secsSinceLogoff = GetFriendInfo(friendIndex)
			local hasCharacter, characterName, zoneName, classType, alliance, level, championRank, zoneId = GetFriendCharacterInfo(friendIndex)
			if name == displayName then
				characterName = zo_strformat("<<!aC:1>>", characterName)
				local character = {}
				character.displayName = displayName
				character.name = characterName
				
				table.insert(BeltalowdaRoster.friends, character)
				break
			end
		end
	end
end

function BeltalowdaRoster.OnFriendRemoved(eventCode, displayName)
	if eventCode == EVENT_FRIEND_REMOVED then
		for i = 1, #BeltalowdaRoster.friends do
			if BeltalowdaRoster.friends[i].displayName == displayName then
				table.remove(BeltalowdaRoster.friends, i)
				break
			end
		end
	end
end

function BeltalowdaRoster.OnGuildMemberAdded(eventCode, guildId, displayName)
	if eventCode == EVENT_GUILD_MEMBER_ADDED and guildId ~= nil then
		guildId = BeltalowdaRoster.GetGuildIndex(guildId)
		for memberId = 1, GetNumGuildMembers(BeltalowdaRoster.GetGuildIdFromId(guildId)) do
			
			local name, note, rankIndex, playerStatus, secsSinceLogoff = GetGuildMemberInfo(BeltalowdaRoster.GetGuildIdFromId(guildId), memberId)
			if name == displayName then
				local hasCharacter, charName, zoneName, classType, alliance, level, championRank, zoneId = GetGuildMemberCharacterInfo(BeltalowdaRoster.GetGuildIdFromId(guildId), memberId)
				charName = zo_strformat("<<!aC:1>>", charName)

				local character = {}
				character.displayName = name
				character.name = charName

				local charNameIndex = string.sub(charName, 1, 1)
				local displayNameIndex = string.sub(name, 2, 2)
				BeltalowdaRoster.guilds[guildId][charNameIndex] = BeltalowdaRoster.guilds[guildId][charNameIndex] or {}
				BeltalowdaRoster.guilds[guildId].at[displayNameIndex] = BeltalowdaRoster.guilds[guildId].at[displayNameIndex] or {}
			
				table.insert(BeltalowdaRoster.guilds[guildId].all, character)
				table.insert(BeltalowdaRoster.guilds[guildId].at[displayNameIndex], character)
				table.insert(BeltalowdaRoster.guilds[guildId][charNameIndex], character)
				break
			end
		end
	end
end

function BeltalowdaRoster.OnGuildMemberRemoved(eventCode, guildId, displayName, characterName)
	if eventCode == EVENT_GUILD_MEMBER_REMOVED and guildId ~= nil then
		guildId = BeltalowdaRoster.GetGuildIndex(guildId)
		local charName = ""
		local accIndex = string.sub(displayName, 2, 2)
		
		for i = 1, #BeltalowdaRoster.guilds[guildId].all do
			if BeltalowdaRoster.guilds[guildId].all[i].displayName == displayName then
				charName = BeltalowdaRoster.guilds[guildId].all[i].name
				table.remove(BeltalowdaRoster.guilds[guildId].all, i)
				break
			end
		end
		
		local accDictionary = BeltalowdaRoster.guilds[guildId].at[accIndex]
		if accDictionary ~= nil then
			for i = 1, #accDictionary do
				if accDictionary[i].displayName == displayName then
					table.remove(accDictionary, i)
					break
				end
			end
		end
		
		if charName == "" then
			--debug
		else
			local charIndex = string.sub(charName, 1, 1)
			local charDictionary = BeltalowdaRoster.guilds[guildId][charIndex]
			if charDictionary ~= nil then
				for i = 1, #charDictionary do
					if charDictionary[i].name == charName then
						table.remove(charDictionary, i)
						break
					end
				end
			end
		end
	end
end

function BeltalowdaRoster.OnGuildMemberRankChanged(eventCode, guildId, displayName, rankIndex)
	if eventCode == EVENT_GUILD_MEMBER_RANK_CHANGED then
		guildId = BeltalowdaRoster.GetGuildIndex(guildId)
		local guild = BeltalowdaRoster.guilds[guildId]
		local accIndex = string.sub(displayName, 2, 2)
		local accDictionary = guild.at[accIndex]
		if accDictionary ~= nil then
			for i = 1, #accDictionary do
				if accDictionary[i].displayName == displayName then
					accDictionary[i].rankIndex = rankIndex
					break
				end
			end
		end
	end
end

function BeltalowdaRoster.OnGuildJoined(eventCode, guildId, guildName)
	--d("id: " .. guildId)
	--d("Num: " .. GetNumGuilds())
	if eventCode == EVENT_GUILD_SELF_JOINED_GUILD then
		--guildId = BeltalowdaRoster.GetGuidIdFromEventGuidId(guildId)
		local guildIndex = GetNumGuilds()
		if guildIndex ~= nil then
			BeltalowdaRoster.guilds[guildIndex].name = GetGuildName(guildId)
			for memberId = 1, GetNumGuildMembers(guildId) do
				local hasCharacter, charName, zoneName, classType, alliance, level, championRank, zoneId = GetGuildMemberCharacterInfo(guildId, memberId)
				local name, note, rankIndex, playerStatus, secsSinceLogoff = GetGuildMemberInfo(guildId, memberId)

				charName = zo_strformat("<<!aC:1>>", charName)
				local character = {}
				character.displayName = name
				character.name = charName
				local charNameIndex = string.sub(charName, 1, 1)
				local displayNameIndex = string.sub(name, 2, 2)

				BeltalowdaRoster.guilds[guildIndex][charNameIndex] = BeltalowdaRoster.guilds[guildIndex][charNameIndex] or {}
				BeltalowdaRoster.guilds[guildIndex].at[displayNameIndex] = BeltalowdaRoster.guilds[guildIndex].at[displayNameIndex] or {}
				BeltalowdaRoster.guilds[guildIndex].id = GetGuildId(guildIndex)
				
				table.insert(BeltalowdaRoster.guilds[guildIndex].all, character)
				table.insert(BeltalowdaRoster.guilds[guildIndex].at[displayNameIndex], character)
				table.insert(BeltalowdaRoster.guilds[guildIndex][charNameIndex], character)
				
			end
			BeltalowdaRoster.GuildListChanged()
		end
	end
end

function BeltalowdaRoster.OnGuildLeft(eventCode, guildId, guildName)
	--d(guildId)
	if eventCode == EVENT_GUILD_SELF_LEFT_GUILD then
		guildId = BeltalowdaRoster.GetGuildIndex(guildId)
		--if guildId > 5 then
		--	guildId = BeltalowdaRoster.GetGuildIndex(guildId)
		--end
		if guildId ~= nil and guildId >= 1 and guildId <= 5 then
			table.remove(BeltalowdaRoster.guilds, guildId)
			BeltalowdaRoster.guilds[5] = {}
			BeltalowdaRoster.guilds[5].all = {}
			BeltalowdaRoster.guilds[5].at = {}
			BeltalowdaRoster.guilds[5].name = ""
		end
		BeltalowdaRoster.GuildListChanged()
	end
end