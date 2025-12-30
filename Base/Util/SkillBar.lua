-- Beltalowda Skill Bar
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.sb = BeltalowdaUtil.sb or {}
local BeltalowdaSB = BeltalowdaUtil.sb


BeltalowdaSB.callbackName = Beltalowda.addonName .. "SkillBar"

BeltalowdaSB.config = {}
BeltalowdaSB.config.interval = 1000

BeltalowdaSB.state = {}
BeltalowdaSB.state.bar = {}

BeltalowdaSB.constants = {}
BeltalowdaSB.constants.networking = {}
BeltalowdaSB.constants.networking.messagePrefix = {}
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_1 = 0
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_2 = 1
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_3 = 2
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_4 = 3
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_SKILL_5 = 4
BeltalowdaSB.constants.networking.messagePrefix.BAR_1_ULTIMATE = 5
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_1 = 6
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_2 = 7
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_3 = 8
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_4 = 9
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_SKILL_5 = 10
BeltalowdaSB.constants.networking.messagePrefix.BAR_2_ULTIMATE = 11

--[[
/script for i = 1, 32 do d(GetAbilityName(GetSlotBoundId(i))) end
]]

function BeltalowdaSB.Initialize()
	EVENT_MANAGER:RegisterForEvent(BeltalowdaSB.callbackName, EVENT_ACTIVE_WEAPON_PAIR_CHANGED, BeltalowdaSB.OnWeaponPairChanged)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaSB.callbackName, EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED, BeltalowdaSB.OnSlotsAllHotbarsUpdated)
	EVENT_MANAGER:RegisterForEvent(BeltalowdaSB.callbackName, EVENT_ACTION_SLOT_UPDATED, BeltalowdaSB.OnSlotUpdated)
	BeltalowdaSB.UpdateSkillBarInformation()
end

function BeltalowdaSB.GetSkillBars()
	return BeltalowdaSB.state.bar
end

function BeltalowdaSB.UpdateSkillBarInformation()
	local activeWeapon, locked = GetActiveWeaponPairInfo()
	local bar = BeltalowdaSB.state.bar
	bar[activeWeapon] = bar[activeWeapon] or {}
	bar[activeWeapon][1] = GetSlotBoundId(3)
	bar[activeWeapon][2] = GetSlotBoundId(4)
	bar[activeWeapon][3] = GetSlotBoundId(5)
	bar[activeWeapon][4] = GetSlotBoundId(6)
	bar[activeWeapon][5] = GetSlotBoundId(7)
	bar[activeWeapon][6] = GetSlotBoundId(8)
end

--callbacks
function BeltalowdaSB.OnWeaponPairChanged(eventCode, activeWeaponPair, locked)
	BeltalowdaSB.UpdateSkillBarInformation()
end

function BeltalowdaSB.OnSlotsAllHotbarsUpdated(eventCode)
	--d("debug")
	BeltalowdaSB.UpdateSkillBarInformation()
end

function BeltalowdaSB.OnSlotUpdated(eventCode)
	--d("debug")
	BeltalowdaSB.UpdateSkillBarInformation()
end
