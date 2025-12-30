-- Beltalowda Champion Points
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.cp = BeltalowdaUtil.cp or {}
local BeltalowdaCP = BeltalowdaUtil.cp

BeltalowdaCP.constants = BeltalowdaCP.constants or {}
BeltalowdaCP.constants.networking = {}
BeltalowdaCP.constants.networking.messagePrefix = {}
BeltalowdaCP.constants.networking.messagePrefix.STEED_MED_IRON = 0
BeltalowdaCP.constants.networking.messagePrefix.STEED_SPELL_RESISTANT = 1
BeltalowdaCP.constants.networking.messagePrefix.LADY_LIGHT_THICK = 2
BeltalowdaCP.constants.networking.messagePrefix.LADY_HARDY_ELEMENT = 3
BeltalowdaCP.constants.networking.messagePrefix.LORD_HEAVY_BASTION = 4
BeltalowdaCP.constants.networking.messagePrefix.LORD_EXPERT_QUICK = 5
BeltalowdaCP.constants.networking.messagePrefix.TOWER_BASHING_SPRINTER = 6
BeltalowdaCP.constants.networking.messagePrefix.TOWER_SIPHON_WAR = 7
BeltalowdaCP.constants.networking.messagePrefix.LOVER_MOON_ARCAN = 8
BeltalowdaCP.constants.networking.messagePrefix.LOVER_HEALTHY_TENA = 9
BeltalowdaCP.constants.networking.messagePrefix.SHADOW_BEFOUL_SHADE = 10
BeltalowdaCP.constants.networking.messagePrefix.SHADOW_SHADOW_TUMBLING = 11
BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELEMENTAL_SPELL = 12
BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELF_BLESSED = 13
BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_PHYSICAL_SHATTERING = 14
BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_MASTER_STAFF = 15
BeltalowdaCP.constants.networking.messagePrefix.RITUAL_THAUM_PRECISE = 16
BeltalowdaCP.constants.networking.messagePrefix.RITUAL_PIERCING_MIGHTY = 17

function BeltalowdaCP.GetChampionSkillName(id, subId)
	return zo_strformat("<<C:1>>", GetChampionSkillName(id, subId))
end

function BeltalowdaCP.GetDisciplineText(id)
	return zo_strformat("<<C:A:1>>", GetChampionDisciplineName(id))
end

function BeltalowdaCP.CreateCPStructureForDiscipline(id)
	local cps = {}
		for i = 1, 4 do
			cps[i] = {}
			cps[i].text = BeltalowdaCP.GetChampionSkillName(id, i)
		end
	return cps
end

function BeltalowdaCP.GetPrefixAndIndex(id, subId)
	--d(id)
	--d(subId)
	--[[

	BeltalowdaAdmin.constants.cpDisciplines[1].id = 4
	BeltalowdaAdmin.constants.cpDisciplines[2].id = 1
	BeltalowdaAdmin.constants.cpDisciplines[3].id = 7
	BeltalowdaAdmin.constants.cpDisciplines[4].id = 3
	BeltalowdaAdmin.constants.cpDisciplines[5].id = 9
	BeltalowdaAdmin.constants.cpDisciplines[6].id = 6
	BeltalowdaAdmin.constants.cpDisciplines[7].id = 2
	BeltalowdaAdmin.constants.cpDisciplines[8].id = 8
	BeltalowdaAdmin.constants.cpDisciplines[9].id = 5
	]]
	local prefix = nil
	local index = 0
	if subId == 1 or subId == 3 then
		index = 1
	elseif subId == 2 or subId == 4 then
		index = 2
	end
	if id == 1 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.TOWER_BASHING_SPRINTER
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.TOWER_SIPHON_WAR
		end
	elseif id == 2 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LORD_HEAVY_BASTION
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LORD_EXPERT_QUICK
		end
	elseif id == 3 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LADY_LIGHT_THICK
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LADY_HARDY_ELEMENT
		end
	elseif id == 4 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.STEED_MED_IRON
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.STEED_SPELL_RESISTANT
		end
	elseif id == 5 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.RITUAL_THAUM_PRECISE
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.RITUAL_PIERCING_MIGHTY
		end
	elseif id == 6 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_PHYSICAL_SHATTERING
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_MASTER_STAFF
		end
	elseif id == 7 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELEMENTAL_SPELL
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELF_BLESSED
		end
	elseif id == 8 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.SHADOW_BEFOUL_SHADE
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.SHADOW_SHADOW_TUMBLING
		end
	elseif id == 9 then
		if subId == 1 or subId == 2 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LOVER_MOON_ARCAN
		elseif subId == 3 or subId == 4 then
			prefix = BeltalowdaCP.constants.networking.messagePrefix.LOVER_HEALTHY_TENA
		end
	end
	return prefix, index
end

function BeltalowdaCP.GetCPControlName(id, subId)
	local prefix, index = BeltalowdaCP.GetPrefixAndIndex(id, subId)
	if prefix ~= nil and index ~= 0 then
		return BeltalowdaCP.GetCPNameFromMessagePrefix(prefix, index)
	end
	return nil
end

function BeltalowdaCP.GetCPNameFromMessagePrefix(messagePrefix, index)
	local name = nil
	--d(messagePrefix)
	--d(index)
	if messagePrefix ~= nil and index ~= nil and (index == 1 or index == 2) then
		if messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.STEED_MED_IRON and index == 1 then
			name = "MediumArmorFocus"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.STEED_MED_IRON and index == 2 then
			name = "Ironclad"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.STEED_SPELL_RESISTANT and index == 1 then
			name = "SpellShield"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.STEED_SPELL_RESISTANT and index == 2 then
			name = "Resistant"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LADY_LIGHT_THICK and index == 1 then
			name = "LightArmorFocus"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LADY_LIGHT_THICK and index == 2 then
			name = "ThickSkinned"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LADY_HARDY_ELEMENT and index == 1 then
			name = "Hardy"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LADY_HARDY_ELEMENT and index == 2 then
			name = "ElementalDefender"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LORD_HEAVY_BASTION and index == 1 then
			name = "HeavyArmorFocus"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LORD_HEAVY_BASTION and index == 2 then
			name = "Bastion"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LORD_EXPERT_QUICK and index == 1 then
			name = "ExpertDefender"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LORD_EXPERT_QUICK and index == 2 then
			name = "QuickRecovery"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.TOWER_BASHING_SPRINTER and index == 1 then
			name = "BashingFocus"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.TOWER_BASHING_SPRINTER and index == 2 then
			name = "Sprinter"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.TOWER_SIPHON_WAR and index == 1 then
			name = "Siphoner"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.TOWER_SIPHON_WAR and index == 2 then
			name = "Warlord"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LOVER_MOON_ARCAN and index == 1 then
			name = "Mooncalf"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LOVER_MOON_ARCAN and index == 2 then
			name = "Arcanist"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LOVER_HEALTHY_TENA and index == 1 then
			name = "Healthy"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.LOVER_HEALTHY_TENA and index == 2 then
			name = "Tenacity"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.SHADOW_BEFOUL_SHADE and index == 1 then
			name = "Befoul"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.SHADOW_BEFOUL_SHADE and index == 2 then
			name = "Shade"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.SHADOW_SHADOW_TUMBLING and index == 1 then
			name = "ShadowWard"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.SHADOW_SHADOW_TUMBLING and index == 2 then
			name = "Tumbling"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELEMENTAL_SPELL and index == 1 then
			name = "ElementalExpert"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELEMENTAL_SPELL and index == 2 then
			name = "SpellErosion"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELF_BLESSED and index == 1 then
			name = "Elfborn"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.APPRENTICE_ELF_BLESSED and index == 2 then
			name = "Blessed"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_PHYSICAL_SHATTERING and index == 1 then
			name = "PhysicalWeaponExpert"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_PHYSICAL_SHATTERING and index == 2 then
			name = "ShatteringBlows"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_MASTER_STAFF and index == 1 then
			name = "MasterAtArms"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.ATRONACH_MASTER_STAFF and index == 2 then
			name = "StaffExpert"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.RITUAL_THAUM_PRECISE and index == 1 then
			name = "Thaumaturge"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.RITUAL_THAUM_PRECISE and index == 2 then
			name = "PreciseStrikes"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.RITUAL_PIERCING_MIGHTY and index == 1 then
			name = "Piercing"
		elseif messagePrefix == BeltalowdaCP.constants.networking.messagePrefix.RITUAL_PIERCING_MIGHTY and index == 2 then
			name = "Mighty"
		end
	end
	return name
end