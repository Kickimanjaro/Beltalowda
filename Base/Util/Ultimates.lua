-- Beltalowda Util Ultimates
-- Ported from RdK Group Tool by @s0rdrak (PC / EU)
-- Adapted for Beltalowda by @Kickimanjaro

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.ultimates = BeltalowdaUtil.ultimates or {}

local BeltalowdaUltimates = BeltalowdaUtil.ultimates

BeltalowdaUltimates.constants = BeltalowdaUltimates.constants or {}

-- Define ultimate constant names
BeltalowdaUltimates.constants.NEGATE = "Sorcerer - Negate"
BeltalowdaUltimates.constants.NEGATE_OFFENSIVE = "Sorcerer - Negate Offensive"
BeltalowdaUltimates.constants.NEGATE_COUNTER = "Sorcerer - Negate Counter"
BeltalowdaUltimates.constants.ATRONACH = "Sorcerer - Atronach"
BeltalowdaUltimates.constants.OVERLOAD = "Sorcerer - Overload"
BeltalowdaUltimates.constants.SWEEP = "Templar - Sweep"
BeltalowdaUltimates.constants.NOVA = "Templar - Nova"
BeltalowdaUltimates.constants.T_HEAL = "Templar - Healing Ultimate"
BeltalowdaUltimates.constants.STANDARD = "Dragonknight - Standard"
BeltalowdaUltimates.constants.LEAP = "Dragonknight - Dragon Leap"
BeltalowdaUltimates.constants.MAGMA = "Dragonknight - Magma Armor"
BeltalowdaUltimates.constants.STROKE = "Nightblade - Death Stroke"
BeltalowdaUltimates.constants.DARKNESS = "Nightblade - Consuming Darkness"
BeltalowdaUltimates.constants.SOUL = "Nightblade - Soul Shred"
BeltalowdaUltimates.constants.SOUL_SIPHON = "Nightblade - Soul Siphon"
BeltalowdaUltimates.constants.SOUL_TETHER = "Nightblade - Soul Tether"
BeltalowdaUltimates.constants.STORM = "Warden - Storm"
BeltalowdaUltimates.constants.NORTHERN_STORM = "Warden - Northern Storm"
BeltalowdaUltimates.constants.PERMAFROST = "Warden - Permafrost"
BeltalowdaUltimates.constants.W_HEAL = "Warden - Healing Ultimate"
BeltalowdaUltimates.constants.GUARDIAN = "Warden - Guardian"
BeltalowdaUltimates.constants.COLOSSUS = "Necromancer - Colossus"
BeltalowdaUltimates.constants.GOLIATH = "Necromancer - Goliath"
BeltalowdaUltimates.constants.REANIMATE = "Necromancer - Reanimate"
BeltalowdaUltimates.constants.UNBLINKING_EYE = "Arcanist - Unblinking Eye"
BeltalowdaUltimates.constants.GIBBERING_SHIELD = "Arcanist - Gibbering Shield"
BeltalowdaUltimates.constants.VITALIZING_GLYPHIC = "Arcanist - Vitalizing Glyphic"
BeltalowdaUltimates.constants.DESTRUCTION = "Weapon - Destruction Staff"
BeltalowdaUltimates.constants.RESTORATION = "Weapon - Restoration Staff"
BeltalowdaUltimates.constants.TWO_HANDED = "Weapon - Two Handed"
BeltalowdaUltimates.constants.SHIELD = "Weapon - One Handed and Shield"
BeltalowdaUltimates.constants.DUAL_WIELD = "Weapon - Dual Wield"
BeltalowdaUltimates.constants.BOW = "Weapon - Bow"
BeltalowdaUltimates.constants.SOUL_MAGIC = "World - Soul Strike"
BeltalowdaUltimates.constants.WEREWOLF = "World (Werewolf) - Werewolf"
BeltalowdaUltimates.constants.VAMPIRE = "World (Vampire) - Bat Swarm"
BeltalowdaUltimates.constants.MAGES = "Guild (Mages) - Meteor"
BeltalowdaUltimates.constants.FIGHTERS = "Guild (Fighters) - Dawnbreaker"
BeltalowdaUltimates.constants.PSIJIC = "Guild (Psijic) - Undo"
BeltalowdaUltimates.constants.ALLIANCE_SUPPORT = "Alliance War (Support) - Barrier"
BeltalowdaUltimates.constants.ALLIANCE_ASSAULT = "Alliance War (Assault) - War Horn"

function BeltalowdaUltimates.InitializeUltimates()
	BeltalowdaUltimates.ultimates = {}
	BeltalowdaUltimates.ultimates[1] = {}
	BeltalowdaUltimates.ultimates[1].name = BeltalowdaUltimates.constants.NEGATE
	BeltalowdaUltimates.ultimates[1].abilityId = 28341
	BeltalowdaUltimates.ultimates[1].id = 1
	
	BeltalowdaUltimates.ultimates[2] = {}
	BeltalowdaUltimates.ultimates[2].name = BeltalowdaUltimates.constants.NEGATE_OFFENSIVE
	BeltalowdaUltimates.ultimates[2].abilityId = 28341
	BeltalowdaUltimates.ultimates[2].id = 32
	BeltalowdaUltimates.ultimates[2].iconColor = {}
	BeltalowdaUltimates.ultimates[2].iconColor.r = 0.6
	BeltalowdaUltimates.ultimates[2].iconColor.g = 0.2
	BeltalowdaUltimates.ultimates[2].iconColor.b = 0.2
	
	BeltalowdaUltimates.ultimates[3] = {}
	BeltalowdaUltimates.ultimates[3].name = BeltalowdaUltimates.constants.NEGATE_COUNTER
	BeltalowdaUltimates.ultimates[3].abilityId = 28341
	BeltalowdaUltimates.ultimates[3].id = 33
	BeltalowdaUltimates.ultimates[3].iconColor = {}
	BeltalowdaUltimates.ultimates[3].iconColor.r = 0.2
	BeltalowdaUltimates.ultimates[3].iconColor.g = 0.2
	BeltalowdaUltimates.ultimates[3].iconColor.b = 0.6

	BeltalowdaUltimates.ultimates[4] = {}
	BeltalowdaUltimates.ultimates[4].name = BeltalowdaUltimates.constants.ATRONACH
	BeltalowdaUltimates.ultimates[4].abilityId = 23634
	BeltalowdaUltimates.ultimates[4].id = 2

	BeltalowdaUltimates.ultimates[5] = {}
	BeltalowdaUltimates.ultimates[5].name = BeltalowdaUltimates.constants.OVERLOAD
	BeltalowdaUltimates.ultimates[5].abilityId = 24785
	BeltalowdaUltimates.ultimates[5].id = 3

	BeltalowdaUltimates.ultimates[6] = {}
	BeltalowdaUltimates.ultimates[6].name = BeltalowdaUltimates.constants.SWEEP
	BeltalowdaUltimates.ultimates[6].abilityId = 22138
	BeltalowdaUltimates.ultimates[6].id = 4

	BeltalowdaUltimates.ultimates[7] = {}
	BeltalowdaUltimates.ultimates[7].name = BeltalowdaUltimates.constants.NOVA
	BeltalowdaUltimates.ultimates[7].abilityId = 21752
	BeltalowdaUltimates.ultimates[7].id = 5

	BeltalowdaUltimates.ultimates[8] = {}
	BeltalowdaUltimates.ultimates[8].name = BeltalowdaUltimates.constants.T_HEAL
	BeltalowdaUltimates.ultimates[8].abilityId = 22223
	BeltalowdaUltimates.ultimates[8].id = 6

	BeltalowdaUltimates.ultimates[9] = {}
	BeltalowdaUltimates.ultimates[9].name = BeltalowdaUltimates.constants.STANDARD
	BeltalowdaUltimates.ultimates[9].abilityId = 32958
	BeltalowdaUltimates.ultimates[9].id = 7

	BeltalowdaUltimates.ultimates[10] = {}
	BeltalowdaUltimates.ultimates[10].name = BeltalowdaUltimates.constants.LEAP
	BeltalowdaUltimates.ultimates[10].abilityId = 29012
	BeltalowdaUltimates.ultimates[10].id = 8

	BeltalowdaUltimates.ultimates[11] = {}
	BeltalowdaUltimates.ultimates[11].name = BeltalowdaUltimates.constants.MAGMA
	BeltalowdaUltimates.ultimates[11].abilityId = 15957
	BeltalowdaUltimates.ultimates[11].id = 9

	BeltalowdaUltimates.ultimates[12] = {}
	BeltalowdaUltimates.ultimates[12].name = BeltalowdaUltimates.constants.STROKE
	BeltalowdaUltimates.ultimates[12].abilityId = 33398
	BeltalowdaUltimates.ultimates[12].id = 10

	BeltalowdaUltimates.ultimates[13] = {}
	BeltalowdaUltimates.ultimates[13].name = BeltalowdaUltimates.constants.DARKNESS
	BeltalowdaUltimates.ultimates[13].abilityId = 25411
	BeltalowdaUltimates.ultimates[13].id = 11

	BeltalowdaUltimates.ultimates[14] = {}
	BeltalowdaUltimates.ultimates[14].name = BeltalowdaUltimates.constants.SOUL
	BeltalowdaUltimates.ultimates[14].abilityId = 25091
	BeltalowdaUltimates.ultimates[14].id = 12
	
	BeltalowdaUltimates.ultimates[15] = {}
	BeltalowdaUltimates.ultimates[15].name = BeltalowdaUltimates.constants.SOUL_SIPHON
	BeltalowdaUltimates.ultimates[15].abilityId = 35508
	BeltalowdaUltimates.ultimates[15].id = 37
	
	BeltalowdaUltimates.ultimates[16] = {}
	BeltalowdaUltimates.ultimates[16].name = BeltalowdaUltimates.constants.SOUL_TETHER
	BeltalowdaUltimates.ultimates[16].abilityId = 35460
	BeltalowdaUltimates.ultimates[16].id = 38

	BeltalowdaUltimates.ultimates[17] = {}
	BeltalowdaUltimates.ultimates[17].name = BeltalowdaUltimates.constants.STORM
	BeltalowdaUltimates.ultimates[17].abilityId = 86109
	BeltalowdaUltimates.ultimates[17].id = 13
	
	BeltalowdaUltimates.ultimates[18] = {}
	BeltalowdaUltimates.ultimates[18].name = BeltalowdaUltimates.constants.NORTHERN_STORM
	BeltalowdaUltimates.ultimates[18].abilityId = 86113
	BeltalowdaUltimates.ultimates[18].id = 35
	
	BeltalowdaUltimates.ultimates[19] = {}
	BeltalowdaUltimates.ultimates[19].name = BeltalowdaUltimates.constants.PERMAFROST
	BeltalowdaUltimates.ultimates[19].abilityId = 86117
	BeltalowdaUltimates.ultimates[19].id = 36

	BeltalowdaUltimates.ultimates[20] = {}
	BeltalowdaUltimates.ultimates[20].name = BeltalowdaUltimates.constants.W_HEAL
	BeltalowdaUltimates.ultimates[20].abilityId = 85532
	BeltalowdaUltimates.ultimates[20].id = 14
	
	BeltalowdaUltimates.ultimates[21] = {}
	BeltalowdaUltimates.ultimates[21].name = BeltalowdaUltimates.constants.GUARDIAN
	BeltalowdaUltimates.ultimates[21].abilityId = 85982
	BeltalowdaUltimates.ultimates[21].id = 31
	
	BeltalowdaUltimates.ultimates[22] = {}
	BeltalowdaUltimates.ultimates[22].name = BeltalowdaUltimates.constants.COLOSSUS
	BeltalowdaUltimates.ultimates[22].abilityId = 122174
	BeltalowdaUltimates.ultimates[22].id = 29
	
	BeltalowdaUltimates.ultimates[23] = {}
	BeltalowdaUltimates.ultimates[23].name = BeltalowdaUltimates.constants.GOLIATH
	BeltalowdaUltimates.ultimates[23].abilityId = 115001
	BeltalowdaUltimates.ultimates[23].id = 28
	
	BeltalowdaUltimates.ultimates[24] = {}
	BeltalowdaUltimates.ultimates[24].name = BeltalowdaUltimates.constants.REANIMATE
	BeltalowdaUltimates.ultimates[24].abilityId = 115410
	BeltalowdaUltimates.ultimates[24].id = 30
		
	BeltalowdaUltimates.ultimates[25] = {}
	BeltalowdaUltimates.ultimates[25].name = BeltalowdaUltimates.constants.UNBLINKING_EYE
	BeltalowdaUltimates.ultimates[25].abilityId = 189791
	BeltalowdaUltimates.ultimates[25].id = 39
	
	BeltalowdaUltimates.ultimates[26] = {}
	BeltalowdaUltimates.ultimates[26].name = BeltalowdaUltimates.constants.GIBBERING_SHIELD
	BeltalowdaUltimates.ultimates[26].abilityId = 183676
	BeltalowdaUltimates.ultimates[26].id = 40
	
	BeltalowdaUltimates.ultimates[27] = {}
	BeltalowdaUltimates.ultimates[27].name = BeltalowdaUltimates.constants.VITALIZING_GLYPHIC
	BeltalowdaUltimates.ultimates[27].abilityId = 183709
	BeltalowdaUltimates.ultimates[27].id = 41
	
	BeltalowdaUltimates.ultimates[28] = {}
	BeltalowdaUltimates.ultimates[28].name = BeltalowdaUltimates.constants.DESTRUCTION
	BeltalowdaUltimates.ultimates[28].abilityId = 83619
	BeltalowdaUltimates.ultimates[28].id = 15

	BeltalowdaUltimates.ultimates[29] = {}
	BeltalowdaUltimates.ultimates[29].name = BeltalowdaUltimates.constants.RESTORATION
	BeltalowdaUltimates.ultimates[29].abilityId = 83552
	BeltalowdaUltimates.ultimates[29].id = 16

	BeltalowdaUltimates.ultimates[30] = {}
	BeltalowdaUltimates.ultimates[30].name = BeltalowdaUltimates.constants.TWO_HANDED
	BeltalowdaUltimates.ultimates[30].abilityId = 83216
	BeltalowdaUltimates.ultimates[30].id = 17

	BeltalowdaUltimates.ultimates[31] = {}
	BeltalowdaUltimates.ultimates[31].name = BeltalowdaUltimates.constants.SHIELD
	BeltalowdaUltimates.ultimates[31].abilityId = 83272
	BeltalowdaUltimates.ultimates[31].id = 18

	BeltalowdaUltimates.ultimates[32] = {}
	BeltalowdaUltimates.ultimates[32].name = BeltalowdaUltimates.constants.DUAL_WIELD
	BeltalowdaUltimates.ultimates[32].abilityId = 83600
	BeltalowdaUltimates.ultimates[32].id = 19

	BeltalowdaUltimates.ultimates[33] = {}
	BeltalowdaUltimates.ultimates[33].name = BeltalowdaUltimates.constants.BOW
	BeltalowdaUltimates.ultimates[33].abilityId = 83465
	BeltalowdaUltimates.ultimates[33].id = 20

	BeltalowdaUltimates.ultimates[34] = {}
	BeltalowdaUltimates.ultimates[34].name = BeltalowdaUltimates.constants.SOUL_MAGIC
	BeltalowdaUltimates.ultimates[34].abilityId = 39270
	BeltalowdaUltimates.ultimates[34].id = 21

	BeltalowdaUltimates.ultimates[35] = {}
	BeltalowdaUltimates.ultimates[35].name = BeltalowdaUltimates.constants.WEREWOLF
	BeltalowdaUltimates.ultimates[35].abilityId = 32455
	BeltalowdaUltimates.ultimates[35].id = 22

	BeltalowdaUltimates.ultimates[36] = {}
	BeltalowdaUltimates.ultimates[36].name = BeltalowdaUltimates.constants.VAMPIRE
	BeltalowdaUltimates.ultimates[36].abilityId = 32624
	BeltalowdaUltimates.ultimates[36].id = 23

	BeltalowdaUltimates.ultimates[37] = {}
	BeltalowdaUltimates.ultimates[37].name = BeltalowdaUltimates.constants.MAGES
	BeltalowdaUltimates.ultimates[37].abilityId = 16536
	BeltalowdaUltimates.ultimates[37].id = 24

	BeltalowdaUltimates.ultimates[38] = {}
	BeltalowdaUltimates.ultimates[38].name = BeltalowdaUltimates.constants.FIGHTERS
	BeltalowdaUltimates.ultimates[38].abilityId = 35713
	BeltalowdaUltimates.ultimates[38].id = 25

	BeltalowdaUltimates.ultimates[39] = {}
	BeltalowdaUltimates.ultimates[39].name = BeltalowdaUltimates.constants.PSIJIC
	BeltalowdaUltimates.ultimates[39].abilityId = 103478
	BeltalowdaUltimates.ultimates[39].id = 34

	BeltalowdaUltimates.ultimates[40] = {}
	BeltalowdaUltimates.ultimates[40].name = BeltalowdaUltimates.constants.ALLIANCE_SUPPORT
	BeltalowdaUltimates.ultimates[40].abilityId = 38573
	BeltalowdaUltimates.ultimates[40].id = 26

	BeltalowdaUltimates.ultimates[41] = {}
	BeltalowdaUltimates.ultimates[41].name = BeltalowdaUltimates.constants.ALLIANCE_ASSAULT
	BeltalowdaUltimates.ultimates[41].abilityId = 38563
	BeltalowdaUltimates.ultimates[41].id = 27
end

function BeltalowdaUltimates.Initialize()
	BeltalowdaUltimates.InitializeUltimates()
	for i = 1, #BeltalowdaUltimates.ultimates do
		local ultimate = BeltalowdaUltimates.ultimates[i]
		ultimate.icon = GetAbilityIcon(ultimate.abilityId)
		ultimate.cost = GetAbilityCost(ultimate.abilityId)
	end
end

function BeltalowdaUltimates.UpdateAbilityCosts(index)
	if index ~= nil and BeltalowdaUltimates.ultimates[index] ~= nil then
		BeltalowdaUltimates.ultimates[index].cost = GetAbilityCost(BeltalowdaUltimates.ultimates[index].abilityId)
	end
end

function BeltalowdaUltimates.GetUltimateIndexFromUltimateId(id)
	local selectedIndex = nil
	if id ~= nil then
		local ultimates = BeltalowdaUltimates.ultimates
		for i = 1, #ultimates do
			if id == ultimates[i].id then
				selectedIndex = i
				break
			end
		end
		
	end
	return selectedIndex
end
