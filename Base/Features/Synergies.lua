-- Beltalowda Synergies Tracker
-- By @Kickimanjaro
-- Fully self-contained module for tracking group synergies
-- Migrated from SynergyOverview.lua in Phase 3 Milestone 3

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
Beltalowda.features.synergies = Beltalowda.features.synergies or {}
local BeltalowdaSynergies = Beltalowda.features.synergies
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaUtilGroup = BeltalowdaUtil.group
BeltalowdaUtil.networking = BeltalowdaUtil.networking or {}
local BeltalowdaNetworking = BeltalowdaUtil.networking
BeltalowdaUtil.math = BeltalowdaUtil.math or {}
local BeltalowdaMath = BeltalowdaUtil.math
Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.dbo = BeltalowdaGroup.dbo or {}
local BeltalowdaDbo = BeltalowdaGroup.dbo

BeltalowdaSynergies.callbackName = Beltalowda.addonName .. "Synergies"
BeltalowdaSynergies.messageLoopCallbackName = Beltalowda.addonName .. "SynergiesMessageLoop"

BeltalowdaSynergies.constants = {}
BeltalowdaSynergies.constants.TLW = "Beltalowda.features.synergies.tlw"
BeltalowdaSynergies.constants.PREFIX = "SO"

BeltalowdaSynergies.constants.MODES = {}
BeltalowdaSynergies.constants.MODES.TABLE_FULL = 1
BeltalowdaSynergies.constants.MODES.TABLE_REDUCED = 2
BeltalowdaSynergies.constants.TABLE_MODES = {}

BeltalowdaSynergies.constants.SYNERGY_ID = {}
BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD = 1
BeltalowdaSynergies.constants.SYNERGY_ID.TALONS = 2
BeltalowdaSynergies.constants.SYNERGY_ID.NOVA = 3
BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR = 4
BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD = 5
BeltalowdaSynergies.constants.SYNERGY_ID.PURGE = 6
BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD = 7
BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT = 8
BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH = 9
BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS = 10
BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE = 11
BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS = 12
BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH = 13
BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING = 14
BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER = 15
BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY = 16
BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE = 17
BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST = 18
BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL = 19
BeltalowdaSynergies.constants.SYNERGY_ID.URSUS = 20
BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON = 21
BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK = 22
BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE = 23

BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID = {}
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR = 41965
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR = 39519
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS = 39451
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SHADOW_SILK = 41997
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS = 42019
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_FIRE = 42057
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_BEAST = 41840
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SHIELD = 39424
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SURGE = 42196
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB = 85434
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ENERGY_ORB = 63512
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS = 48052
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS = 95926
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH = 43769
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEALING_SEED = 85576
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL = 22270
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH = 48085
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH = 48085
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.STANDARD = 67717
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TALONS = 48040
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NOVA = 48938
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUPER_NOVA = 48939
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS = 77769
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SOUL_SHRED = 25172
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER = 115567
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PURE_AGONY = 118610
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE = 88892
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST = 141971
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL = 142780
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.URSUS = 112414
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRYPHON = 167045
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.RUNEBREAK = 191080
BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PASSAGE = 190646

BeltalowdaSynergies.constants.DISPLAYMODE_ALL = 1
BeltalowdaSynergies.constants.DISPLAYMODE_SYNERGY = 2

BeltalowdaSynergies.constants.sizes = {}
BeltalowdaSynergies.constants.size = {}
BeltalowdaSynergies.constants.size.SMALL = 1
BeltalowdaSynergies.constants.size.BIG = 2

BeltalowdaSynergies.controls = {}

BeltalowdaSynergies.config = {}
BeltalowdaSynergies.config.full = {}
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL] = {}
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight = 18
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension = 14
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing = 4
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth = 100
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth + 16 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + 15 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height = 13 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].fontSize = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight - 2
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG] = {}
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].rowHeight = 30
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].synergyDimension = 26
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].spacing = 5
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].labelWidth = 150
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].width = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].labelWidth + 16 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].synergyDimension + 15 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].spacing
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].height = 13 * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].rowHeight
BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].fontSize = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].rowHeight - 10
BeltalowdaSynergies.config.isClampedToScreen = true
BeltalowdaSynergies.config.updateInterval = 100
BeltalowdaSynergies.config.buffUpdateInterval = 100
BeltalowdaSynergies.config.messageUpdateInterval = 100
BeltalowdaSynergies.config.backdropAlphaOdd = 0.25
BeltalowdaSynergies.config.backdropAlphaEven = 0.15
BeltalowdaSynergies.config.minCooldownMs = 200
BeltalowdaSynergies.config.reduced = {}
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL] = {}
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension = 40--50
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight = 20--25
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width = 16 * BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height = 6 * BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight + BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].fontSize = BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight - 9
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG] = {}
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension = 50--50
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].entryHeight = 25--25
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].width = 16 * BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].height = 6 * BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].entryHeight + BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension
BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].fontSize = BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].entryHeight - 9

BeltalowdaSynergies.state = {}
BeltalowdaSynergies.state.initialized = false
BeltalowdaSynergies.state.registredConsumers = false
BeltalowdaSynergies.state.foreground = true
BeltalowdaSynergies.state.activeLayerIndex = 1
BeltalowdaSynergies.state.registredActiveConsumers = false
BeltalowdaSynergies.state.lastMessages = {}
BeltalowdaSynergies.state.lastSynergy = 0

BeltalowdaSynergies.state.SYNERGY_DATA = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR].texture = "/esoui/art/icons/ability_undaunted_001_b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR].callbackName = BeltalowdaSynergies.callbackName .. ".altar"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR].id = BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS].texture = "/esoui/art/icons/ability_undaunted_003_b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS].callbackName = BeltalowdaSynergies.callbackName .. ".trapping_webs"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS].id = BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE].texture = "/esoui/art/icons/ability_undaunted_002_b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE].callbackName = BeltalowdaSynergies.callbackName .. ".radiate"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE].id = BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD].texture = "/esoui/art/icons/ability_undaunted_005b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD].callbackName = BeltalowdaSynergies.callbackName .. ".bone_shield"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD].id = BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD].texture = "/esoui/art/icons/ability_undaunted_004b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD].callbackName = BeltalowdaSynergies.callbackName .. ".combustion"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD].id = BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT].texture = "/esoui/art/icons/ability_sorcerer_liquid_lightning.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT].callbackName = BeltalowdaSynergies.callbackName .. ".conduit"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT].id = BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE].texture = "/esoui/art/icons/ability_templar_extended_ritual.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE].callbackName = BeltalowdaSynergies.callbackName .. ".purge"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE].id = BeltalowdaSynergies.constants.SYNERGY_ID.PURGE

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH].texture = "/esoui/art/icons/ability_sorcerer_storm_atronach.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH].callbackName = BeltalowdaSynergies.callbackName .. ".atronach"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH].id = BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD].texture = "/esoui/art/icons/ability_dragonknight_006.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD].callbackName = BeltalowdaSynergies.callbackName .. ".standard"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD].id = BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS].texture = "/esoui/art/icons/ability_dragonknight_010.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS].callbackName = BeltalowdaSynergies.callbackName .. ".talons"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS].id = BeltalowdaSynergies.constants.SYNERGY_ID.TALONS

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA].texture = "/esoui/art/icons/ability_templar_solar_disturbance.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA].callbackName = BeltalowdaSynergies.callbackName .. ".nova"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA].id = BeltalowdaSynergies.constants.SYNERGY_ID.NOVA

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS].texture = "/esoui/art/icons/ability_nightblade_015.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS].callbackName = BeltalowdaSynergies.callbackName .. ".consuming_darkness"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS].id = BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH].texture = "/esoui/art/icons/ability_nightblade_018.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH].callbackName = BeltalowdaSynergies.callbackName .. ".soul_leech"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH].id = BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING].texture = "esoui/art/icons/ability_warden_007.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING].callbackName = BeltalowdaSynergies.callbackName .. ".warden_healing"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING].id = BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER].texture = "esoui/art/icons/ability_necromancer_004.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER].callbackName = BeltalowdaSynergies.callbackName .. ".grave_robber"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER].id = BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY].texture = "esoui/art/icons/ability_necromancer_010.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY].callbackName = BeltalowdaSynergies.callbackName .. ".pure_agony"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY].id = BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE].texture = "esoui/art/icons/ability_warden_005_b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE].callbackName = BeltalowdaSynergies.callbackName .. ".icy_escape"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE].id = BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST].texture = "esoui/art/icons/ability_u23_bloodball_chokeonit.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST].callbackName = BeltalowdaSynergies.callbackName .. ".sanguine_burst"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST].id = BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL].texture = "esoui/art/icons/achievement_u26_skyrim_werewolfdevour100.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL].callbackName = BeltalowdaSynergies.callbackName .. ".heed_the_call"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL].id = BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS].texture = "esoui/art/icons/ability_warden_018_c.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS].callbackName = BeltalowdaSynergies.callbackName .. ".ursus"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS].id = BeltalowdaSynergies.constants.SYNERGY_ID.URSUS

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON].texture = "esoui/art/icons/achievement_trial_cr_flavor_3.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON].callbackName = BeltalowdaSynergies.callbackName .. ".gryphon"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON].id = BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK].texture = "esoui/art/icons/ability_arcanist_004.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK].callbackName = BeltalowdaSynergies.callbackName .. ".runebreak"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK].id = BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK

BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE] = {}
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE].cooldown = 20
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE].texture = "esoui/art/icons/ability_arcanist_016_b.dds"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE].callbackName = BeltalowdaSynergies.callbackName .. ".passage"
BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE].id = BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE

BeltalowdaSynergies.state.SYNERGIES = {}
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SHADOW_SILK] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_FIRE] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_BEAST] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SHIELD] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SURGE] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ENERGY_ORB] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEALING_SEED] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.STANDARD] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TALONS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NOVA] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUPER_NOVA] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SOUL_SHRED] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PURE_AGONY] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.URSUS] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRYPHON] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.RUNEBREAK] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK]
BeltalowdaSynergies.state.SYNERGIES[BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PASSAGE] = BeltalowdaSynergies.state.SYNERGY_DATA[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE]

BeltalowdaSynergies.state.fullWidth = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width
BeltalowdaSynergies.state.reducedWidth = BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width
BeltalowdaSynergies.state.reducedSynergyDimension = BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension
BeltalowdaSynergies.state.reducedEntryHeight = BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight


local wm = WINDOW_MANAGER

function BeltalowdaSynergies.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaSynergies.callbackName, BeltalowdaSynergies.OnProfileChanged)

	BeltalowdaSynergies.state.controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	
	BeltalowdaSynergies.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaSynergies.SetSoPositionLocked)
	
	BeltalowdaSynergies.state.initialized = true
	BeltalowdaSynergies.SetEnabled(BeltalowdaSynergies.vars.enabled, BeltalowdaSynergies.vars.windowEnabled)
	BeltalowdaSynergies.SetPositionLocked(BeltalowdaSynergies.vars.positionLocked)
	BeltalowdaSynergies.SetControlVisibility()
	
	BeltalowdaSynergies.AdjustSize()
end

function BeltalowdaSynergies.CreateUI()
	BeltalowdaSynergies.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaSynergies.constants.TLW)
	
	BeltalowdaSynergies.SetTlwLocation()
	
	BeltalowdaSynergies.controls.TLW:SetClampedToScreen(BeltalowdaSynergies.config.isClampedToScreen)
	BeltalowdaSynergies.controls.TLW:SetHandler("OnMoveStop", BeltalowdaSynergies.SaveWindowLocation)
	BeltalowdaSynergies.controls.TLW:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height)
	
	--full table mode
	BeltalowdaSynergies.controls.TLW.fullTableControl = wm:CreateControl(nil, BeltalowdaSynergies.controls.TLW, CT_CONTROL)
	
	local fullTableControl = BeltalowdaSynergies.controls.TLW.fullTableControl
	
	
	fullTableControl:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height)
	fullTableControl:SetAnchor(TOPLEFT, BeltalowdaSynergies.controls.TLW, TOPLEFT, 0, 0)
	
	fullTableControl.movableBackdrop = wm:CreateControl(nil, fullTableControl, CT_BACKDROP)
	
	fullTableControl.movableBackdrop:SetAnchor(TOPLEFT, fullTableControl, TOPLEFT, 0, 0)
	fullTableControl.movableBackdrop:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height)
	
	fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	fullTableControl.header = BeltalowdaSynergies.CreateUiHeader(fullTableControl)
	fullTableControl.rows = {}
	for i = 1, 24 do
		fullTableControl.rows[i] = BeltalowdaSynergies.CreateUiRow(fullTableControl, i * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight)
	end
	
	--reduced table mode
	BeltalowdaSynergies.controls.TLW.reducedTableControl = wm:CreateControl(nil, BeltalowdaSynergies.controls.TLW, CT_CONTROL)
	
	local reducedTableControl = BeltalowdaSynergies.controls.TLW.reducedTableControl
	
	
	reducedTableControl:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height)
	reducedTableControl:SetAnchor(TOPLEFT, BeltalowdaSynergies.controls.TLW, TOPLEFT, 0, 0)
	
	reducedTableControl.movableBackdrop = wm:CreateControl(nil, reducedTableControl, CT_BACKDROP)
	
	reducedTableControl.movableBackdrop:SetAnchor(TOPLEFT, reducedTableControl, TOPLEFT, 0, 0)
	reducedTableControl.movableBackdrop:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height)
	
	reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	reducedTableControl.header = BeltalowdaSynergies.CreateUiReducedHeader(reducedTableControl)
	reducedTableControl.entries = {}
	for i = 1, 12 do
		reducedTableControl.entries[i] = BeltalowdaSynergies.CreateReducedEntry(reducedTableControl)
	end
end

function BeltalowdaSynergies.SetTlwLocation()
	BeltalowdaSynergies.controls.TLW:ClearAnchors()
	if BeltalowdaSynergies.vars.location == nil then
		BeltalowdaSynergies.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -250, 250)
	else
		BeltalowdaSynergies.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaSynergies.vars.location.x, BeltalowdaSynergies.vars.location.y)
	end
end

function BeltalowdaSynergies.CreateUiHeader(control)
	local header = wm:CreateControl(nil, control, CT_CONTROL)
	header:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight)
	header:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	header.synergies = {}
	
	for i = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
		local positionX = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth + ((i - 1) * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) + ((i - 1) * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing)
		header.synergies[i] = BeltalowdaSynergies.CreateSynergyIcon(header, positionX, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing, i)
	end
	
	return header
end

function BeltalowdaSynergies.CreateUiReducedHeader(control)
	local header = wm:CreateControl(nil, control, CT_CONTROL)
	header:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	header:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	header.synergies = {}
	for i = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
		local positionX = ((i - 1) * BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
		header.synergies[i] = BeltalowdaSynergies.CreateReducedSynergyIcon(header, positionX, 0, i)
	end
	return header
end

function BeltalowdaSynergies.CreateSynergyIcon(control, positionX, positionY, index)
	local texture = wm:CreateControl(nil, control, CT_TEXTURE)
	texture:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	texture:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	texture:SetTexture(BeltalowdaSynergies.state.SYNERGY_DATA[index].texture)
	return texture
end

function BeltalowdaSynergies.CreateReducedSynergyIcon(control, positionX, positionY, index)
	local retControl = wm:CreateControl(nil, control, CT_CONTROL)
	retControl:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	retControl:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	
	retControl.texture = wm:CreateControl(nil, retControl, CT_TEXTURE)
	retControl.texture:SetAnchor(TOPLEFT, retControl, TOPLEFT, 0, 0)
	retControl.texture:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	retControl.texture:SetTexture(BeltalowdaSynergies.state.SYNERGY_DATA[index].texture)
	retControl.texture:SetDrawTier(0)
	
	retControl.border = wm:CreateControl(nil, retControl, CT_TEXTURE)
	retControl.border:SetAnchor(TOPLEFT, retControl, TOPLEFT, 0, 0)
	retControl.border:SetDimensions(BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	retControl.border:SetTexture("/esoui/art/actionbar/abilityframe64_up.dds")
	retControl.border:SetDrawTier(1)
	return retControl
end

function BeltalowdaSynergies.CreateUiRow(control, positionY)
	local row = wm:CreateControl(nil, control, CT_CONTROL)
	row:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight)
	row:SetAnchor(TOPLEFT, control, TOPLEFT, 0, positionY)
	row:SetHidden(true)
	
	row.backdrop = wm:CreateControl(nil, row, CT_BACKDROP)
	row.backdrop:SetAnchor(TOPLEFT, row, TOPLEFT, 0, 0)
	row.backdrop:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight)
	row.backdrop:SetCenterColor(BeltalowdaSynergies.vars.backgroundColor.r, BeltalowdaSynergies.vars.backgroundColor.g, BeltalowdaSynergies.vars.backgroundColor.b, 0)
	row.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.backgroundColor.r, BeltalowdaSynergies.vars.backgroundColor.g, BeltalowdaSynergies.vars.backgroundColor.b, 0)
		
	row.label = wm:CreateControl(nil, row, CT_LABEL)
	row.label:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight)
	row.label:SetAnchor(TOPLEFT, row, TOPLEFT, 0, 0)
	row.label:SetFont(BeltalowdaSynergies.state.controlFont)
	row.label:SetWrapMode(ELLIPSIS)
	row.label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	row.label:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	--row.label:SetText("test")
	
	row.synergies = {}
	for i = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
		local positionX = BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth + ((i - 1) * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) + ((i - 1) * BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing)
		row.synergies[i] = BeltalowdaSynergies.CreateSynergyProgressBar(row, positionX, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing / 2)
	end
	return row
end

function BeltalowdaSynergies.CreateReducedEntry(control)
	local sizeIncrease = BeltalowdaSynergies.vars.size - BeltalowdaSynergies.constants.size.SMALL
	local synergyDimension = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local entryHeight = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].entryHeight - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight) * sizeIncrease)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].fontSize + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].fontSize - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].fontSize) * sizeIncrease), BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	
	local entry = wm:CreateControl(nil, control, CT_CONTROL)
	entry:SetDimensions(synergyDimension, entryHeight)
	entry:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	entry.backdrop = wm:CreateControl(nil, entry, CT_BACKDROP)
	entry.backdrop:SetAnchor(TOPLEFT, entry, TOPLEFT, 0, 0)
	entry.backdrop:SetDimensions(synergyDimension, entryHeight)
	entry.backdrop:SetCenterColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, BeltalowdaSynergies.vars.synergyBackdropColor.a)
	entry.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, 0)
	
	entry.progress = wm:CreateControl(nil, entry, CT_STATUSBAR)
	entry.progress:SetAnchor(TOPLEFT, entry, TOPLEFT, 1, 1)
	entry.progress:SetDimensions(synergyDimension - 2, entryHeight - 2)
	entry.progress:SetMinMax(0, 100)
	entry.progress:SetValue(0)
	entry.progress:SetColor(BeltalowdaSynergies.vars.progressColor.r, BeltalowdaSynergies.vars.progressColor.g, BeltalowdaSynergies.vars.progressColor.b, 1)
	
	entry.name = wm:CreateControl(nil, entry, CT_LABEL)
	entry.name:SetDimensions(synergyDimension - 8, entryHeight - 4)
	entry.name:SetAnchor(TOPLEFT, entry, TOPLEFT, 4, 2)
	entry.name:SetFont(font)
	entry.name:SetWrapMode(ELLIPSIS)
	entry.name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	entry.name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	entry.name:SetColor(BeltalowdaSynergies.vars.textColor.r, BeltalowdaSynergies.vars.textColor.g, BeltalowdaSynergies.vars.textColor.b, 1)
	
	entry.edge = wm:CreateControl(nil, entry, CT_BACKDROP)
	entry.edge:SetAnchor(TOPLEFT, entry, TOPLEFT, 0, 0)
	entry.edge:SetDimensions(synergyDimension, entryHeight)
	entry.edge:SetEdgeTexture(nil, 1, 1, 1, 0)
	entry.edge:SetCenterColor(0, 0, 0, 0)
	entry.edge:SetEdgeColor(0, 0, 0, 1)
	
	return entry
end

function BeltalowdaSynergies.CreateSynergyProgressBar(control, positionX, positionY)
	local synergy = wm:CreateControl(nil, control, CT_CONTROL)
	synergy:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	synergy:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	
	synergy.backdrop = wm:CreateControl(nil, synergy, CT_BACKDROP)
	synergy.backdrop:SetAnchor(TOPLEFT, synergy, TOPLEFT, 0, 0)
	synergy.backdrop:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	synergy.backdrop:SetCenterColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, BeltalowdaSynergies.vars.synergyBackdropColor.a)
	synergy.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, 0)
	
	synergy.progress = wm:CreateControl(nil, synergy, CT_STATUSBAR)
	synergy.progress:SetAnchor(TOPLEFT, synergy, TOPLEFT, 0, 0)
	synergy.progress:SetDimensions(BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension, BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension)
	synergy.progress:SetMinMax(0, 100)
	synergy.progress:SetValue(0)
	synergy.progress:SetColor(BeltalowdaSynergies.vars.progressColor.r, BeltalowdaSynergies.vars.progressColor.g, BeltalowdaSynergies.vars.progressColor.b, 1)
	
	return synergy
end

function BeltalowdaSynergies.AdjustSynergyColors()
	for i = 1, #BeltalowdaSynergies.controls.TLW.fullTableControl.rows do
		for j = 1, #BeltalowdaSynergies.controls.TLW.fullTableControl.rows[i].synergies do
			local synergy = BeltalowdaSynergies.controls.TLW.fullTableControl.rows[i].synergies[j]
			synergy.backdrop:SetCenterColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, BeltalowdaSynergies.vars.synergyBackdropColor.a)
			synergy.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, 0)
			synergy.progress:SetColor(BeltalowdaSynergies.vars.progressColor.r, BeltalowdaSynergies.vars.progressColor.g, BeltalowdaSynergies.vars.progressColor.b, 1)
			BeltalowdaSynergies.controls.TLW.fullTableControl.rows[i].label:SetColor(BeltalowdaSynergies.vars.textColor.r, BeltalowdaSynergies.vars.textColor.g, BeltalowdaSynergies.vars.textColor.b, 1)
		end
	end
	
	for j = 1, #BeltalowdaSynergies.controls.TLW.reducedTableControl.entries do
		local entry = BeltalowdaSynergies.controls.TLW.reducedTableControl.entries[j]
		entry.backdrop:SetCenterColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, BeltalowdaSynergies.vars.synergyBackdropColor.a)
		entry.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.synergyBackdropColor.r, BeltalowdaSynergies.vars.synergyBackdropColor.g, BeltalowdaSynergies.vars.synergyBackdropColor.b, 0)
		entry.progress:SetColor(BeltalowdaSynergies.vars.progressColor.r, BeltalowdaSynergies.vars.progressColor.g, BeltalowdaSynergies.vars.progressColor.b, 1)
		entry.name:SetColor(BeltalowdaSynergies.vars.textColor.r, BeltalowdaSynergies.vars.textColor.g, BeltalowdaSynergies.vars.textColor.b, 1)
	end

end

function BeltalowdaSynergies.SetEnabled(enabled, windowEnabled)
	if BeltalowdaSynergies.state.initialized == true and enabled ~= nil then
		BeltalowdaSynergies.vars.enabled = enabled
		BeltalowdaSynergies.vars.windowEnabled = windowEnabled
		if enabled == true then
			if BeltalowdaSynergies.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSynergies.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaSynergies.OnPlayerActivated)
			end
			BeltalowdaSynergies.state.registredConsumers = true
		else
			if BeltalowdaSynergies.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSynergies.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaSynergies.state.registredConsumers = false
			BeltalowdaSynergies.SetControlVisibility()
		end
		BeltalowdaSynergies.OnPlayerActivated()
	end
end

function BeltalowdaSynergies.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.windowEnabled = false
	defaults.positionLocked = true
	defaults.pvpOnly = true
	defaults.tableMode = BeltalowdaSynergies.constants.MODES.TABLE_FULL
	defaults.synergyBackdropColor = {}
	defaults.synergyBackdropColor.r = 0.25
	defaults.synergyBackdropColor.g = 0.25
	defaults.synergyBackdropColor.b = 0.25
	defaults.synergyBackdropColor.a = 0.4
	defaults.progressColor = {}
	defaults.progressColor.r = 1.0
	defaults.progressColor.g = 0.0
	defaults.progressColor.b = 0.0
	defaults.synergyColor = {}
	defaults.synergyColor.r = 0.1
	defaults.synergyColor.g = 1.0
	defaults.synergyColor.b = 0.1
	defaults.backgroundColor = {}
	defaults.backgroundColor.r = 0.8
	defaults.backgroundColor.g = 0.8
	defaults.backgroundColor.b = 0.8
	defaults.textColor = {}
	defaults.textColor.r = 1.0
	defaults.textColor.g = 1.0
	defaults.textColor.b = 1.0
	defaults.spacing = 0
	defaults.displayMode = BeltalowdaSynergies.constants.DISPLAYMODE_ALL
	defaults.synergyVisibility = {}
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.COMBUSTION_SHARD] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.TALONS] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.NOVA] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.BLOOD_ALTAR] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.STANDARD] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.PURGE] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.BONE_SHIELD] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.FLOOD_CONDUIT] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.ATRONACH] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.TRAPPING_WEBS] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.RADIATE] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.CONSUMING_DARKNESS] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.SOUL_LEECH] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.WARDEN_HEALING] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.GRAVE_ROBBER] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.PURE_AGONY] = true
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.ICY_ESCAPE] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.SANGUINE_BURST] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.HEED_THE_CALL] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.URSUS] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.GRYPHON] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.RUNEBREAK] = false
	defaults.synergyVisibility[BeltalowdaSynergies.constants.SYNERGY_ID.PASSAGE] = false
	defaults.size = BeltalowdaSynergies.constants.size.SMALL
	return defaults
end

function BeltalowdaSynergies.SetPositionLocked(value)
	BeltalowdaSynergies.vars.positionLocked = value
	
	BeltalowdaSynergies.controls.TLW:SetMovable(not value)
	BeltalowdaSynergies.controls.TLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaSynergies.SetTlwLocation()
		BeltalowdaSynergies.controls.TLW.fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSynergies.controls.TLW.fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaSynergies.controls.TLW.reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSynergies.controls.TLW.reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaSynergies.controls.TLW:ClearAnchors()
		BeltalowdaSynergies.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaSynergies.controls.TLW:GetLeft(), BeltalowdaSynergies.controls.TLW:GetTop())
		BeltalowdaSynergies.controls.TLW.fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSynergies.controls.TLW.fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaSynergies.controls.TLW.reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSynergies.controls.TLW.reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaSynergies.SetControlVisibility()
	local enabled = BeltalowdaSynergies.vars.enabled and BeltalowdaSynergies.vars.windowEnabled
	local setHidden = true
	if enabled ~= nil and enabled == true and (BeltalowdaSynergies.vars.pvpOnly == false or (BeltalowdaSynergies.vars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		setHidden = false
	end
	BeltalowdaSynergies.controls.TLW:SetHidden(setHidden)
	if BeltalowdaSynergies.vars.tableMode == BeltalowdaSynergies.constants.MODES.TABLE_FULL then
		BeltalowdaSynergies.controls.TLW.fullTableControl:SetHidden(false)
		BeltalowdaSynergies.controls.TLW.reducedTableControl:SetHidden(true)
		
		local sizeIncrease = BeltalowdaSynergies.vars.size - BeltalowdaSynergies.constants.size.SMALL
		local width = BeltalowdaSynergies.state.fullWidth
		local height = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
		BeltalowdaSynergies.controls.TLW:SetDimensions(width, height)
	elseif BeltalowdaSynergies.vars.tableMode == BeltalowdaSynergies.constants.MODES.TABLE_REDUCED then
		BeltalowdaSynergies.controls.TLW.fullTableControl:SetHidden(true)
		BeltalowdaSynergies.controls.TLW.reducedTableControl:SetHidden(false)
		
		local sizeIncrease = BeltalowdaSynergies.vars.size - BeltalowdaSynergies.constants.size.SMALL
		local width = BeltalowdaSynergies.state.reducedWidth
		local height = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
		BeltalowdaSynergies.controls.TLW:SetDimensions(width, height)
	end
	--d(setHidden)
end

function BeltalowdaSynergies.RegisterForCombatEvent(id, suffix)
	if id ~= nil then
		local data = BeltalowdaSynergies.state.SYNERGIES[id]
		if data ~= nil then
			local callbackName = data.callbackName
			if suffix ~= nil then
				callbackName = callbackName .. suffix
			end
			EVENT_MANAGER:RegisterForEvent(callbackName, EVENT_COMBAT_EVENT, BeltalowdaSynergies.OnCombatEvent)
			EVENT_MANAGER:AddFilterForEvent(callbackName, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, id)
		end
	end
end

function BeltalowdaSynergies.UnregisterForCombatEvent(id, suffix)
	if id ~= nil then
		local data = BeltalowdaSynergies.state.SYNERGIES[id]
		if data ~= nil then
			local callbackName = data.callbackName
			if suffix ~= nil then
				callbackName = callbackName .. suffix
			end
			EVENT_MANAGER:UnregisterForEvent(callbackName, EVENT_COMBAT_EVENT)
		end
	end
end

function BeltalowdaSynergies.AdjustSynergyDisplay()
	--fullTableControl
	local fullTableControl = BeltalowdaSynergies.controls.TLW.fullTableControl
	local header = fullTableControl.header
	local rows = fullTableControl.rows
	
	local sizeIncrease = BeltalowdaSynergies.vars.size - BeltalowdaSynergies.constants.size.SMALL
	local synergyDimension = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].synergyDimension - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local labelWidth = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].labelWidth - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth) * sizeIncrease)
	local spacing = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].spacing - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing) * sizeIncrease)
	local rowHeight = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].rowHeight - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight) * sizeIncrease)
	--local width = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].width - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].width) * sizeIncrease)
	local height = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
	
	for i = 1, #rows do
		local visibleIndex = 1
		for j = 1, #rows[i].synergies do
			local synergy = rows[i].synergies[j]
			if BeltalowdaSynergies.vars.synergyVisibility[j] == true then
				synergy:SetHidden(false)
				synergy:ClearAnchors()
				local positionX = labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing)
				synergy:SetAnchor(TOPLEFT, rows[i], TOPLEFT, positionX, spacing / 2)
				
				visibleIndex = visibleIndex + 1
			else
				synergy:SetHidden(true)
			end
		end
		rows[i].backdrop:SetDimensions(labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing), rowHeight)
	end
	local visibleIndex = 1
	for i = 1, #header.synergies do
		local synergy = header.synergies[i]
		if BeltalowdaSynergies.vars.synergyVisibility[i] == true then
			synergy:SetHidden(false)
			synergy:ClearAnchors()
			local positionX = labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing)
			synergy:SetAnchor(TOPLEFT, header, TOPLEFT, positionX, spacing / 2)
				
			visibleIndex = visibleIndex + 1
		else
			synergy:SetHidden(true)
		end
		BeltalowdaSynergies.state.fullWidth = labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing)
	end
	fullTableControl.movableBackdrop:SetDimensions(BeltalowdaSynergies.state.fullWidth, height)
	--reducedTableControl
	local reducedTableControl = BeltalowdaSynergies.controls.TLW.reducedTableControl
	synergyDimension = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) * sizeIncrease)
	--width = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].width - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].width) * sizeIncrease)
	height = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
	
	
	header = reducedTableControl.header
	visibleIndex = 1
	for i = 1, #header.synergies do
		local synergy = header.synergies[i]
		if BeltalowdaSynergies.vars.synergyVisibility[i] == true then
			synergy:SetHidden(false)
			synergy:ClearAnchors()
			local positionX = (visibleIndex - 1) * synergyDimension + (visibleIndex - 1) * BeltalowdaSynergies.vars.spacing
			synergy:SetAnchor(TOPLEFT, header, TOPLEFT, positionX, 0)
				
			visibleIndex = visibleIndex + 1
		else
			synergy:SetHidden(true)
		end
		BeltalowdaSynergies.state.reducedWidth = (visibleIndex - 1) * synergyDimension + (visibleIndex - 1) * BeltalowdaSynergies.vars.spacing
	end
	reducedTableControl.movableBackdrop:SetDimensions(BeltalowdaSynergies.state.reducedWidth, height)
	BeltalowdaSynergies.SetControlVisibility()
end

function BeltalowdaSynergies.GetSynergyIdForAbilityId(abilityId)
	local synergyId = 0
	if BeltalowdaSynergies.state.SYNERGIES[abilityId] ~= nil then
		synergyId = BeltalowdaSynergies.state.SYNERGIES[abilityId].id
	end
	return synergyId
end

function BeltalowdaSynergies.SortNumbers(value1, value2) 
	return value1 > value2
end

function BeltalowdaSynergies.SortSynergyList(playerA, playerB)
	local index = BeltalowdaSynergies.state.tempSortIndex --to prevent a closure performance impact
	if playerA.synergies == nil and playerB.synergies == nil then
		return true
	elseif playerA.synergies ~= nil and playerB.synergies == nil then
		return true
	elseif playerA.synergies == nil and playerB.synergies ~= nil then
		return false
	elseif playerA.synergies[index] == nil and playerB.synergies[index] == nil then
		return true
	elseif playerA.synergies[index] ~= nil and playerB.synergies[index] == nil then
		return true
	elseif playerA.synergies[index] == nil and playerB.synergies[index] ~= nil then
		return false
	end
	if playerA.synergies[index] > playerB.synergies[index] then
		return true
	else
		return false
	end
end

function BeltalowdaSynergies.CreateSortedSynergyList(players)
	local synergyList = {}
	local synergyHeaders = BeltalowdaSynergies.controls.TLW.reducedTableControl.header.synergies
	for i = 1, #synergyHeaders do
		if synergyHeaders[i]:IsHidden() == false then
			synergyList[i] = {}
			for j = 1, #players do
				if players[j].synergies[i] ~= nil and (BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_ALL or (BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_SYNERGY and players[j].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY)) then
					--d("adding synergy")
					table.insert(synergyList[i], players[j])
				end
			end
			BeltalowdaSynergies.state.tempSortIndex = i
			--d("sorting synergies")
			table.sort(synergyList[i], BeltalowdaSynergies.SortSynergyList)
		end
	end
	return synergyList
end

function BeltalowdaSynergies.AdjustSize()
	local sizeIncrease = BeltalowdaSynergies.vars.size - BeltalowdaSynergies.constants.size.SMALL
	local synergyDimension = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].synergyDimension - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local labelWidth = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].labelWidth - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].labelWidth) * sizeIncrease)
	local spacing = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].spacing - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].spacing) * sizeIncrease)
	local rowHeight = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].rowHeight - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].rowHeight) * sizeIncrease)
	local fontSize = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].fontSize + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].fontSize - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].fontSize) * sizeIncrease)
	local width = BeltalowdaSynergies.state.fullWidth
	local height = (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.full[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
	
	BeltalowdaSynergies.state.controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	--full
	local fullTableControl = BeltalowdaSynergies.controls.TLW.fullTableControl
	
	fullTableControl:SetDimensions(width, height)
	fullTableControl.movableBackdrop:SetDimensions(width, height)

	fullTableControl.header:SetDimensions(width, rowHeight)
	for i = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
		local positionX = labelWidth + ((i - 1) * synergyDimension) + ((i - 1) * spacing)
		fullTableControl.header.synergies[i]:ClearAnchors()
		fullTableControl.header.synergies[i]:SetAnchor(TOPLEFT, fullTableControl.header, TOPLEFT, positionX, spacing)
		fullTableControl.header.synergies[i]:SetDimensions(synergyDimension, synergyDimension)
	end


	for i = 1, 24 do
		fullTableControl.rows[i]:SetDimensions(width, rowHeight)
		fullTableControl.rows[i]:ClearAnchors()
		fullTableControl.rows[i]:SetAnchor(TOPLEFT, fullTableControl, TOPLEFT, 0, i * rowHeight)
		
		fullTableControl.rows[i].backdrop:SetDimensions(width, rowHeight)
		fullTableControl.rows[i].label:SetDimensions(labelWidth, rowHeight)
		fullTableControl.rows[i].label:SetFont(BeltalowdaSynergies.state.controlFont)
		
		for j = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
			local positionX = labelWidth + ((j - 1) * synergyDimension) + ((j - 1) * spacing)
			fullTableControl.rows[i].synergies[j]:ClearAnchors()
			fullTableControl.rows[i].synergies[j]:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, spacing / 2)
			fullTableControl.rows[i].synergies[j]:SetDimensions(synergyDimension, synergyDimension)
			fullTableControl.rows[i].synergies[j].backdrop:SetDimensions(synergyDimension, synergyDimension)
			fullTableControl.rows[i].synergies[j].progress:SetDimensions(synergyDimension, synergyDimension)
		end
	end
	
	--reduced
	local reducedTableControl = BeltalowdaSynergies.controls.TLW.reducedTableControl
	width = BeltalowdaSynergies.state.reducedWidth
	height = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].height - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].height) * sizeIncrease)
	synergyDimension = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].synergyDimension - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local entryHeight = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].entryHeight - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].entryHeight) * sizeIncrease)
	fontSize = (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].fontSize + (BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.BIG].fontSize - BeltalowdaSynergies.config.reduced[BeltalowdaSynergies.constants.size.SMALL].fontSize) * sizeIncrease)
	
	BeltalowdaSynergies.state.reducedSynergyDimension = synergyDimension
	BeltalowdaSynergies.state.reducedEntryHeight = entryHeight
	
	reducedTableControl:SetDimensions(width, height)
	
	reducedTableControl.movableBackdrop:SetDimensions(width, height)
		
	reducedTableControl.header:SetDimensions(width, synergyDimension)
	
	for i = 1, #BeltalowdaSynergies.state.SYNERGY_DATA do
		local positionX = ((i - 1) * synergyDimension) + (i - 1) * BeltalowdaSynergies.vars.spacing
		--d(positionX)
		reducedTableControl.header.synergies[i]:ClearAnchors()
		reducedTableControl.header.synergies[i]:SetAnchor(TOPLEFT, reducedTableControl.header, TOPLEFT, positionX, 0)
		reducedTableControl.header.synergies[i]:SetDimensions(synergyDimension, synergyDimension)
		reducedTableControl.header.synergies[i].texture:ClearAnchors()
		reducedTableControl.header.synergies[i].texture:SetAnchor(TOPLEFT, reducedTableControl.header.synergies[i], TOPLEFT, 0, 0)
		reducedTableControl.header.synergies[i].texture:SetDimensions(synergyDimension, synergyDimension)
		reducedTableControl.header.synergies[i].border:ClearAnchors()
		reducedTableControl.header.synergies[i].border:SetAnchor(TOPLEFT, reducedTableControl.header.synergies[i], TOPLEFT, 0, 0)
		reducedTableControl.header.synergies[i].border:SetDimensions(synergyDimension, synergyDimension)
	end
	
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	for i = 1, #reducedTableControl.entries do
		reducedTableControl.entries[i]:SetDimensions(synergyDimension + BeltalowdaSynergies.vars.spacing, entryHeight)
		
		reducedTableControl.entries[i].backdrop:ClearAnchors()
		reducedTableControl.entries[i].backdrop:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 0, 0)
		reducedTableControl.entries[i].backdrop:SetDimensions(synergyDimension + BeltalowdaSynergies.vars.spacing, entryHeight)
		
		reducedTableControl.entries[i].progress:ClearAnchors()
		reducedTableControl.entries[i].progress:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 1, 1)
		reducedTableControl.entries[i].progress:SetDimensions(synergyDimension - 2 + BeltalowdaSynergies.vars.spacing, entryHeight - 2)
		
		reducedTableControl.entries[i].name:SetFont(font)
		reducedTableControl.entries[i].name:SetDimensions(synergyDimension - 8 + BeltalowdaSynergies.vars.spacing, entryHeight - 4)
		reducedTableControl.entries[i].name:ClearAnchors()
		reducedTableControl.entries[i].name:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 4, 2)
		
		reducedTableControl.entries[i].edge:ClearAnchors()
		reducedTableControl.entries[i].edge:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 0, 0)
		reducedTableControl.entries[i].edge:SetDimensions(synergyDimension + BeltalowdaSynergies.vars.spacing, entryHeight)
		
	end
	BeltalowdaSynergies.AdjustSynergyDisplay()
end

function BeltalowdaSynergies.GetPlayerDebuffs()
	return BeltalowdaDbo.GetPlayerDebuffs()
end

--callbacks
function BeltalowdaSynergies.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaSynergies.vars = currentProfile.toolbox.so
		if BeltalowdaSynergies.state.initialized == true then
			BeltalowdaSynergies.SetEnabled(BeltalowdaSynergies.vars.enabled, BeltalowdaSynergies.vars.windowEnabled)
			BeltalowdaSynergies.SetPositionLocked(BeltalowdaSynergies.vars.positionLocked)
			BeltalowdaSynergies.SetControlVisibility()
			BeltalowdaSynergies.SetTlwLocation()
			BeltalowdaSynergies.AdjustSynergyColors()
			BeltalowdaSynergies.AdjustSize()
		end
	end
end

function BeltalowdaSynergies.OnPlayerActivated(eventCode, initial)
	if BeltalowdaSynergies.vars.enabled == true and (BeltalowdaSynergies.vars.pvpOnly == false or (BeltalowdaSynergies.vars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaSynergies.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSynergies.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaSynergies.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSynergies.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaSynergies.SetForegroundVisibility)
		
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SHADOW_SILK, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS, "3")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_FIRE, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_BEAST, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SHIELD, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SURGE, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ENERGY_ORB, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS, "3")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS, "4")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEALING_SEED, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.STANDARD, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TALONS, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NOVA, "1")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUPER_NOVA, "2")
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SOUL_SHRED, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PURE_AGONY, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.URSUS, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRYPHON, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.RUNEBREAK, nil)
			BeltalowdaSynergies.RegisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PASSAGE, nil)
			
			BeltalowdaUtilGroup.AddFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_SYNERGY, BeltalowdaSynergies.config.updateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaSynergies.config.buffUpdateInterval)
			--BeltalowdaUtilGroup.AddFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE, BeltalowdaSynergies.config.updateInterval)
			
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaSynergies.callbackName, BeltalowdaSynergies.config.updateInterval, BeltalowdaSynergies.UiLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaSynergies.messageLoopCallbackName, BeltalowdaSynergies.config.messageUpdateInterval, BeltalowdaSynergies.MessageLoop)
			
			BeltalowdaSynergies.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaSynergies.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSynergies.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSynergies.callbackName, EVENT_ACTION_LAYER_PUSHED)
			
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SHADOW_SILK, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS, "3")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_FIRE, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.INNER_BEAST, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SHIELD, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.BONE_SURGE, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ENERGY_ORB, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS, "3")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS, "4")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEALING_SEED, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.STANDARD, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.TALONS, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.NOVA, "1")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SUPER_NOVA, "2")
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SOUL_SHRED, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PURE_AGONY, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.URSUS, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.GRYPHON, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.RUNEBREAK, nil)
			BeltalowdaSynergies.UnregisterForCombatEvent(BeltalowdaSynergies.constants.SYNERGY_ABLITY_ID.PASSAGE, nil)
			
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_SYNERGY)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			--BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSynergies.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE)
			
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaSynergies.callbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaSynergies.messageLoopCallbackName)
			
			BeltalowdaSynergies.state.registredActiveConsumers = false
		end
	end
	BeltalowdaSynergies.SetControlVisibility()
end

--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") d(an) d(ai) d(si)d(ti)d(sn)d(tn) end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") d(an) d(ai) d(sn)d(tn) end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") if sn == "Cartraf^Mx" or tn == "Cartraf^Mx" then d(an) d(ai) d(sn)d(tn) end end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an, gr,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") if sn == "Flying Locus^Mx" or tn == "Flying Locus^Mx" then d(an) d(ai) d(sn)d(tn) d(gr) end end)
function BeltalowdaSynergies.OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, isLog, sourceUnitId, targetUnitId, abilityId) 
	--[[
	d("---New Data: " .. GetGameTimeMilliseconds() .. "---")
	d("Source: " .. sourceName)
	d("Source Unit ID: " .. sourceUnitId)
	d("Target: " .. targetName) -- raw name
	d("Target Unit ID: " .. targetUnitId)
	d("Ability Name: " .. abilityName)
	d("Ability ID: " .. abilityId)
	]]
	--[[
	local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_HP
				message.b1, message.b2, message.b3 = BeltalowdaNetworking.EncodeInt24(BeltalowdaHdm.state.meter.healing)
				BeltalowdaHdm.state.meter.healing = 0
				message.sent = false
				BeltalowdaNetworking.SendMessage(message, BeltalowdaNetworking.constants.priorities.MEDIUM)
				BeltalowdaHdm.state.meter.lastHpMessage = message
	]]
	--d("---")
	--d(abilityId)
	--d(result)
	if result == ACTION_RESULT_EFFECT_GAINED  and targetName == GetRawUnitName("player") then
		local timeStamp = GetGameTimeMilliseconds()
		--if BeltalowdaSynergies.state.lastSynergy + BeltalowdaSynergies.config.minCooldownMs < timeStamp then
			
			BeltalowdaSynergies.state.lastSynergy = timeStamp
			local synergyId = BeltalowdaSynergies.GetSynergyIdForAbilityId(abilityId)
			--d(abilityId)
			if synergyId ~= 0 then
				local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_SYNERGY
				message.b1 = synergyId
				message.b2 = 0
				local debuffs = BeltalowdaSynergies.GetPlayerDebuffs()
				if debuffs > 7 then
					debuffs = 7
				end
				message.b3 = debuffs
				message.timeStamp = timeStamp
				message.sent = false
				BeltalowdaNetworking.SendSynergyMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
				table.insert(BeltalowdaSynergies.state.lastMessages, message)
				BeltalowdaChat.SendChatMessage("Synergy Message Sent: " .. message.b1 .. " - " .. message.b2, BeltalowdaSynergies.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
			end
		--end
	end
	
end

function BeltalowdaSynergies.MessageLoop()
	local messages = BeltalowdaSynergies.state.lastMessages
	local removeMessages = {}
	for i = 1, #messages do
		local message = messages[i]
		if message.sent == true then
			table.insert(removeMessages, i)
		else
			message.b2 = tonumber(string.format("%d",(GetGameTimeMilliseconds() - message.timeStamp) / 100))
			local debuffs = BeltalowdaSynergies.GetPlayerDebuffs()
			if debuffs > 7 then
				debuffs = 7
			end
			message.b3 = debuffs
		end
	end
	table.sort(removeMessages, BeltalowdaSynergies.SortNumbers)
	for i = 1, #removeMessages do
		table.remove(messages, removeMessages[i])
	end
end

function BeltalowdaSynergies.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaSynergies.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaSynergies.state.foreground = false
	end
	--hack?
	BeltalowdaSynergies.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaSynergies.SetControlVisibility()
end

function BeltalowdaSynergies.SaveWindowLocation()
	if BeltalowdaSynergies.vars.positionLocked == false then
		BeltalowdaSynergies.vars.location = BeltalowdaSynergies.vars.location or {}
		BeltalowdaSynergies.vars.location.x = BeltalowdaSynergies.controls.TLW:GetLeft()
		BeltalowdaSynergies.vars.location.y = BeltalowdaSynergies.controls.TLW:GetTop()
	end
end

function BeltalowdaSynergies.UiLoop()
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	local timeStamp = GetGameTimeMilliseconds()
	if BeltalowdaSynergies.vars.tableMode == BeltalowdaSynergies.constants.MODES.TABLE_FULL then
		--BeltalowdaSynergies.constants.MODES.TABLE_FULL
		local rows = BeltalowdaSynergies.controls.TLW.fullTableControl.rows
		if players ~= nil then
			local visibleIndex = 1
			for i = 1, #players do
				local player = players[i]
				local row = rows[visibleIndex]
				if BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_ALL or (BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_SYNERGY and players[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) then
					row:SetHidden(false)
					row.label:SetText(player.name)
					local alpha = BeltalowdaSynergies.config.backdropAlphaOdd
					if visibleIndex % 2 == 0 then
						alpha = BeltalowdaSynergies.config.backdropAlphaEven
					end
					if player.role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY then
						row.backdrop:SetCenterColor(BeltalowdaSynergies.vars.synergyColor.r, BeltalowdaSynergies.vars.synergyColor.g, BeltalowdaSynergies.vars.synergyColor.b, alpha)
						row.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.synergyColor.r, BeltalowdaSynergies.vars.synergyColor.g, BeltalowdaSynergies.vars.synergyColor.b, 0)
					else
						row.backdrop:SetCenterColor(BeltalowdaSynergies.vars.backgroundColor.r, BeltalowdaSynergies.vars.backgroundColor.g, BeltalowdaSynergies.vars.backgroundColor.b, alpha)
						row.backdrop:SetEdgeColor(BeltalowdaSynergies.vars.backgroundColor.r, BeltalowdaSynergies.vars.backgroundColor.g, BeltalowdaSynergies.vars.backgroundColor.b, 0)
					end
					
					
					visibleIndex = visibleIndex + 1
					for j = 1, #row.synergies do
						local progress = 0
						if player.synergies[j] ~= nil then
							progress = (BeltalowdaSynergies.state.SYNERGY_DATA[j].cooldown * 1000) - (timeStamp - player.synergies[j]) 
							if progress < 0 then
								progress = 0
								player.synergies[j] = nil
							end
							progress = progress / (BeltalowdaSynergies.state.SYNERGY_DATA[j].cooldown * 1000) * 100
						end
						row.synergies[j].progress:SetValue(progress)
					end
					
				end

			end
			for i = visibleIndex, #rows do --prev 24
				rows[i]:SetHidden(true)
			end
		else
			for i = 1, #rows do
				rows[i]:SetHidden(true)
			end
		end
	elseif BeltalowdaSynergies.vars.tableMode == BeltalowdaSynergies.constants.MODES.TABLE_REDUCED then
		--BeltalowdaSynergies.constants.MODES.TABLE_REDUCED
		local reducedTableControl = BeltalowdaSynergies.controls.TLW.reducedTableControl
		local entries = reducedTableControl.entries
		local synergyControls = reducedTableControl.header.synergies
		if players ~= nil then
			local visibleIndex = 1
			local currentControlWidthIndex = 0
			local synergies = BeltalowdaSynergies.CreateSortedSynergyList(players)
			for i = 1, #synergyControls do
				if synergyControls[i]:IsHidden() == false then
					--d("loop 1")
					local currentControlHeightIndex = 0
					local synergyPlayerList = synergies[i]
					if synergyPlayerList ~= nil then
						--d("loop 2")
						for j = 1, #synergyPlayerList do
							local synergyControl = entries[visibleIndex] 
							if synergyControl == nil then
								synergyControl = BeltalowdaSynergies.CreateReducedEntry(reducedTableControl)
								entries[visibleIndex] = synergyControl
							end
							synergyControl.name:SetText(synergyPlayerList[j].name)
							local progress = 0
							if synergyPlayerList[j].synergies[i] ~= nil then
								progress = (BeltalowdaSynergies.state.SYNERGY_DATA[i].cooldown * 1000) - (timeStamp - synergyPlayerList[j].synergies[i]) 
								if progress < 0 then
									progress = 0
									synergyPlayerList[j].synergies[i] = nil
								end
								progress = progress / (BeltalowdaSynergies.state.SYNERGY_DATA[i].cooldown * 1000) * 100
							end
							synergyControl.progress:SetValue(progress)
							
							synergyControl:ClearAnchors()
							synergyControl:SetAnchor(TOPLEFT, reducedTableControl, TOPLEFT, (currentControlWidthIndex) * BeltalowdaSynergies.state.reducedSynergyDimension + (currentControlWidthIndex) * BeltalowdaSynergies.vars.spacing , BeltalowdaSynergies.state.reducedSynergyDimension + (currentControlHeightIndex * BeltalowdaSynergies.state.reducedEntryHeight) - (currentControlHeightIndex * 1))
							synergyControl:SetHidden(false)
							
							visibleIndex = visibleIndex + 1
							currentControlHeightIndex = currentControlHeightIndex + 1
							--d("synergy")
						end
					end
					currentControlWidthIndex = currentControlWidthIndex + 1
				end
				--local player = players[i]
				--local entry = entries[visibleIndex]
				--if BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_ALL or (BeltalowdaSynergies.vars.displayMode == BeltalowdaSynergies.constants.DISPLAYMODE_SYNERGY and players[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) then
					
				--end
			end
			for i = visibleIndex, #entries do
				entries[i]:SetHidden(true)
			end 
		else
			for i = 1, #entries do
				entries[i]:SetHidden(true)
			end
		end
	end
end

--menu interaction

-- Note: Menu functions (GetMenu and all Get*/Set* functions) have been moved to
-- Base/Features/Synergies.lua as part of Phase 2 refactoring.
-- Core implementation remains here.

-- ============================================================================
-- MENU FUNCTIONS (Phase 2 Migration - Now integrated)
-- ============================================================================

function BeltalowdaSynergies.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.SO_HEADER,
			controls = {
				[1] = {
					type = "description",
					text = "Tracks and displays available synergies from your group members in real-time. Shows which synergies are currently active and ready to be triggered (like Orbs, Shards, Blood Altar, etc.). Helps you quickly identify synergy opportunities during combat, especially useful for players in synergy-focused roles who need to maintain high resource generation or healing through synergy activation.",
					width = "full",
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_ENABLED,
					getFunc = BeltalowdaSynergies.GetSoEnabled,
					setFunc = BeltalowdaSynergies.SetSoEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_WINDOW_ENABLED,
					getFunc = BeltalowdaSynergies.GetSoWindowEnabled,
					setFunc = BeltalowdaSynergies.SetSoWindowEnabled
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_PVP_ONLY,
					getFunc = BeltalowdaSynergies.GetSoPvpOnly,
					setFunc = BeltalowdaSynergies.SetSoPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_POSITION_FIXED,
					getFunc = BeltalowdaSynergies.GetSoPositionLocked,
					setFunc = BeltalowdaSynergies.SetSoPositionLocked
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_TABLE_MODE,
					choices = BeltalowdaSynergies.GetSoTableModes(),
					getFunc = BeltalowdaSynergies.GetSoTableMode,
					setFunc = BeltalowdaSynergies.SetSoTableMode
				},
				[6] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_DISPLAY_MODE,
					choices = BeltalowdaSynergies.GetSoDisplayModes(),
					getFunc = BeltalowdaSynergies.GetSoDisplayMode,
					setFunc = BeltalowdaSynergies.SetSoDisplayMode
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SO_REDUCED_SPACING,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSynergies.GetSoReducedSpacing,
					setFunc = BeltalowdaSynergies.SetSoReducedSpacing,
					width = "full",
					decimals = 0,
					default = 0
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SO_SIZE,
					min = 1.0,
					max = 2.0,
					step = 0.01,
					getFunc = BeltalowdaSynergies.GetSoSize,
					setFunc = BeltalowdaSynergies.SetSoSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP,
					getFunc = BeltalowdaSynergies.GetSoSynergyBackdropColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyBackdropColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS,
					getFunc = BeltalowdaSynergies.GetSoSynergyProgressColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY,
					getFunc = BeltalowdaSynergies.GetSoSynergyColor,
					setFunc = BeltalowdaSynergies.SetSoSynergyColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_BACKGROUND,
					getFunc = BeltalowdaSynergies.GetSoBackgroundColor,
					setFunc = BeltalowdaSynergies.SetSoBackgroundColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_TEXT,
					getFunc = BeltalowdaSynergies.GetSoTextColor,
					setFunc = BeltalowdaSynergies.SetSoTextColor,
					width = "full"
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(1) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(1, value) end
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TALONS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(2) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(2, value) end
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_NOVA,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(3) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(3, value) end
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(4) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(4, value) end
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_STANDARD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(5) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(5, value) end
				},
				[19] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURGE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(6) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(6, value) end
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(7) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(7, value) end
				},
				[21] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(8) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(8, value) end
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(9) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(9, value) end
				},
				[23] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(10) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(10, value) end
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RADIATE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(11) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(11, value) end
				},
				[25] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(12) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(12, value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(13) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(13, value) end
				},
				[27] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(14) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(14, value) end
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(15) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(15, value) end
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(16) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(16, value) end
				},
				[30] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(17) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(17, value) end
				},
				[31] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(18) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(18, value) end
				},
				[32] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(19) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(19, value) end
				},
				[33] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_URSUS,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(20) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(20, value) end
				},
				[34] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(21) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(21, value) end
				},
				[35] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(22) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(22, value) end
				},
				[36] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE,
					getFunc = function() return BeltalowdaSynergies.GetSoSynergyEnabled(23) end,
					setFunc = function(value) BeltalowdaSynergies.SetSoSynergyEnabled(23, value) end
				}
			}
		}
	}
	return menu
end

-- Menu getter/setter functions (Phase 2)
function BeltalowdaSynergies.GetSoEnabled()
	return BeltalowdaSynergies.vars.enabled
end

function BeltalowdaSynergies.SetSoEnabled(value)
	BeltalowdaSynergies.vars.enabled = value
	BeltalowdaSynergies.SetEnabled(value, BeltalowdaSynergies.vars.windowEnabled)
	BeltalowdaSynergies.AdjustSynergyDisplay()
	if BeltalowdaSynergies.SetControlVisibility then
		BeltalowdaSynergies.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoWindowEnabled()
	return BeltalowdaSynergies.vars.windowEnabled
end

function BeltalowdaSynergies.SetSoWindowEnabled(value)
	BeltalowdaSynergies.vars.windowEnabled = value
	BeltalowdaSynergies.SetEnabled(BeltalowdaSynergies.vars.enabled, value)
	BeltalowdaSynergies.AdjustSynergyDisplay()
	if BeltalowdaSynergies.SetControlVisibility then
		BeltalowdaSynergies.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoPositionLocked()
	return BeltalowdaSynergies.vars.positionLocked
end

function BeltalowdaSynergies.SetSoPositionLocked(value)
	BeltalowdaSynergies.SetPositionLocked(value)
end

function BeltalowdaSynergies.GetSoPvpOnly()
	return BeltalowdaSynergies.vars.pvpOnly
end

function BeltalowdaSynergies.SetSoPvpOnly(value)
	BeltalowdaSynergies.vars.pvpOnly = value
	BeltalowdaSynergies.SetEnabled(BeltalowdaSynergies.vars.enabled, BeltalowdaSynergies.vars.windowEnabled)
	BeltalowdaSynergies.SetControlVisibility()
end

function BeltalowdaSynergies.GetSoSynergyBackdropColor()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSynergies.vars.synergyBackdropColor)
end

function BeltalowdaSynergies.SetSoSynergyBackdropColor(r, g, b, a)
	BeltalowdaSynergies.vars.synergyBackdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSynergies.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoSynergyProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSynergies.vars.progressColor)
end

function BeltalowdaSynergies.SetSoSynergyProgressColor(r, g, b)
	BeltalowdaSynergies.vars.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSynergies.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoTableModes()
	return BeltalowdaSynergies.constants.TABLE_MODES
end

function BeltalowdaSynergies.GetSoTableMode()
	return BeltalowdaSynergies.constants.TABLE_MODES[BeltalowdaSynergies.vars.tableMode]
end

function BeltalowdaSynergies.SetSoTableMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSynergies.constants.TABLE_MODES do
			if BeltalowdaSynergies.constants.TABLE_MODES[i] == value then
				BeltalowdaSynergies.vars.tableMode = i
			end
		end
		BeltalowdaSynergies.SetControlVisibility()
	end
end

function BeltalowdaSynergies.GetSoDisplayModes()
	return BeltalowdaSynergies.constants.DISPLAY_MODES
end

function BeltalowdaSynergies.GetSoDisplayMode()
	return BeltalowdaSynergies.constants.DISPLAY_MODES[BeltalowdaSynergies.vars.displayMode]
end

function BeltalowdaSynergies.SetSoDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSynergies.constants.DISPLAY_MODES do
			if BeltalowdaSynergies.constants.DISPLAY_MODES[i] == value then
				BeltalowdaSynergies.vars.displayMode = i
			end
		end
	end
end

function BeltalowdaSynergies.GetSoReducedSpacing()
	return BeltalowdaSynergies.vars.spacing
end

function BeltalowdaSynergies.SetSoReducedSpacing(value)
	BeltalowdaSynergies.vars.spacing = value
	BeltalowdaSynergies.AdjustSize()
end

function BeltalowdaSynergies.GetSoSize()
	return BeltalowdaSynergies.vars.size
end

function BeltalowdaSynergies.SetSoSize(value)
	if value ~= nil and value >= BeltalowdaSynergies.constants.size.SMALL and value <= BeltalowdaSynergies.constants.size.BIG then
		BeltalowdaSynergies.vars.size = value
		BeltalowdaSynergies.AdjustSize()
	end
end

function BeltalowdaSynergies.GetSoSynergyColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSynergies.vars.synergyColor)
end

function BeltalowdaSynergies.SetSoSynergyColor(r, g, b)
	BeltalowdaSynergies.vars.synergyColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSynergies.GetSoBackgroundColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSynergies.vars.backgroundColor)
end

function BeltalowdaSynergies.SetSoBackgroundColor(r, g, b)
	BeltalowdaSynergies.vars.backgroundColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSynergies.GetSoTextColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSynergies.vars.textColor)
end

function BeltalowdaSynergies.SetSoTextColor(r, g, b)
	BeltalowdaSynergies.vars.textColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSynergies.AdjustSynergyColors()
end

function BeltalowdaSynergies.GetSoSynergyEnabled(index)
	return BeltalowdaSynergies.vars.synergyVisibility[index]
end

function BeltalowdaSynergies.SetSoSynergyEnabled(index, value)
	BeltalowdaSynergies.vars.synergyVisibility[index] = value
	BeltalowdaSynergies.AdjustSynergyDisplay()
end

-- Note: Phase 2 - Menu functions now in wrapper, core logic still in SynergyOverview.
