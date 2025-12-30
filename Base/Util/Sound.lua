-- Beltalowda Sound
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
Beltalowda.util.sound = Beltalowda.util.sound or {}

local BeltalowdaSound = Beltalowda.util.sound
BeltalowdaSound.state = {}

function BeltalowdaSound.Initialize()
	local index = 1
	BeltalowdaSound.state.allSounds = {}
	local allSounds = BeltalowdaSound.state.allSounds
	for key, value in pairs(SOUNDS) do
		local sound = {}
		sound.key = key
		sound.name = value
		allSounds[index] = sound
		index = index + 1
	end
	BeltalowdaSound.CreateRestrictedSoundList()
end

function BeltalowdaSound.CreateRestrictedSoundList()
	BeltalowdaSound.state.restrictedSounds = {}
	local sounds = BeltalowdaSound.state.restrictedSounds
	sounds[1] = {}
	sounds[1].key = "DYEING_TOOL_SET_FILL_USED"
	sounds[1].name = "Dyeing_Tool_Set_Fill_Used"
	sounds[2] = {}
	sounds[2].key = "ABILITY_ULTIMATE_READY"
	sounds[2].name = "Ability_Ultimate_Ready_Sound"
	sounds[3] = {}
	sounds[3].key = "NOTIFICATIONS_WINDOW_OPEN"
	sounds[3].name = "Notifications_Open"
	sounds[4] = {}
	sounds[4].key = "BATTLEGROUND_CAPTURE_AREA_MOVED"
	sounds[4].name = "BG_CA_AreaCaptured_Moved"
	sounds[5] = {}
	sounds[5].key = "LFG_FIND_REPLACEMENT"
	sounds[5].name = "LFG_Find_Replacement"
	sounds[6] = {}
	sounds[6].key = "QUEST_COMPLETED"
	sounds[6].name = "Quest_Complete"
	sounds[7] = {}
	sounds[7].key = "STABLE_FEED_STAMINA"
	sounds[7].name = "Stable_FeedStamina"
	sounds[8] = {}
	sounds[8].key = "VOICE_CHAT_ALERT_CHANNEL_MADE_ACTIVE"
	sounds[8].name = "Voice_Chat_Alert_Channel_Made_Active"
	sounds[9] = {}
	sounds[9].key = "RAID_TRIAL_SCORE_ADDED_LOW"
	sounds[9].name = "Raid_Trial_Score_Added_Low"
	sounds[10] = {}
	sounds[10].key = "OBJECTIVE_COMPLETED"
	sounds[10].name = "Objective_Complete"
	sounds[11] = {}
	sounds[11].key = "RAID_TRIAL_COMPLETED"
	sounds[11].name = "Raid_Trial_Completed"
	sounds[12] = {}
	sounds[12].key = "EMPEROR_DEPOSED_EBONHEART"
	sounds[12].name = "Emperor_Deposed_Ebonheart"
	sounds[13] = {}
	sounds[13].key = "CLOTHIER_IMPROVE_TOOLTIP_GLOW_SUCCESS"
	sounds[13].name = "Clothier_Improve_Tooltip_Glow_Success"
	sounds[14] = {}
	sounds[14].key = "CROWN_CRATES_CARD_FLIPPING"
	sounds[14].name = "CrownCrates_Card_Flipping"
	sounds[15] = {}
	sounds[15].key = "STATS_PURCHASE"
	sounds[15].name = "Stats_Purchase"
	sounds[16] = {}
	sounds[16].key = "BATTLEGROUND_CAPTURE_FLAG_DROPPED_OWN_TEAM"
	sounds[16].name = "BG_CTF_FlagDropped_OwnTeam"
	sounds[17] = {}
	sounds[17].key = "LFG_SEARCH_FINISHED"
	sounds[17].name = "LFG_Search_Finished"
	sounds[18] = {}
	sounds[18].key = "ENLIGHTENED_STATE_LOST"
	sounds[18].name = "EnlightenedState_Lost"
	sounds[19] = {}
	sounds[19].key = "EMPEROR_CORONATED_DAGGERFALL"
	sounds[19].name = "Emperor_Coronated_Daggerfall"
	sounds[20] = {}
	sounds[20].key = "CROWN_CRATES_PURCHASED_WITH_GEMS"
	sounds[20].name = "CrownCrates_Purchased_With_Gems"
	sounds[21] = {}
	sounds[21].key = "LEVEL_UP"
	sounds[21].name = "LevelUp"
	sounds[22] = {}
	sounds[22].key = "JUSTICE_PICKPOCKET_FAILED"
	sounds[22].name = "Justice_PickpocketFailed"
	sounds[23] = {}
	sounds[23].key = "ENLIGHTENED_STATE_GAINED"
	sounds[23].name = "EnlightenedState_Gained"
	sounds[24] = {}
	sounds[24].key = "CHAMPION_POINT_GAINED"
	sounds[24].name = "Champion_PointGained"
	sounds[25] = {}
	sounds[25].key = "QUEST_ABANDONED"
	sounds[25].name = "Quest_Abandon"
	sounds[26] = {}
	sounds[26].key = "BATTLEGROUND_ONE_MINUTE_WARNING"
	sounds[26].name = "BG_One_Minute_Warning"
end

function BeltalowdaSound.GetRestrictedSounds()
	return BeltalowdaSound.state.restrictedSounds
end

function BeltalowdaSound.GetAllSounds()
	return BeltalowdaSound.state.allSounds
end

function BeltalowdaSound.PlaySoundByKey(key)
	BeltalowdaSound.PlaySoundByName(SOUNDS[key])
end

function BeltalowdaSound.PlaySoundByName(name)
	if name ~= nil then
		PlaySound(name)
	end
end

function BeltalowdaSound.PlaySoundByGlobalIndex(index)
	local sound = BeltalowdaSound.state.allSounds[index]
	if sound ~= nil then
		BeltalowdaSound.PlaySoundByName(sound.name)
	end
end

function BeltalowdaSound.PlaySoundByRestrictedIndex(index)
	local sound = BeltalowdaSound.state.restrictedSounds[index]
	if sound ~= nil then
		BeltalowdaSound.PlaySoundByName(sound.name)
	end
end

--sound check
--[[
/script local i = 6 d(Beltalowda.util.sound.state.allSounds[i]) Beltalowda.util.sound.PlaySoundByGlobalIndex(i)

]]