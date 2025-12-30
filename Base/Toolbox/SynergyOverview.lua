-- Beltalowda Synergy Overview
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
Beltalowda.toolbox.so = Beltalowda.toolbox.so or {}
local BeltalowdaSO = Beltalowda.toolbox.so
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

BeltalowdaSO.callbackName = Beltalowda.addonName .. "ToolboxSynergyOverview"
BeltalowdaSO.messageLoopCallbackName = Beltalowda.addonName .. "ToolboxSynergyOverviewMessageLoop"

BeltalowdaSO.constants = {}
BeltalowdaSO.constants.TLW = "Beltalowda.toolbox.so.tlw"
BeltalowdaSO.constants.PREFIX = "SO"

BeltalowdaSO.constants.MODES = {}
BeltalowdaSO.constants.MODES.TABLE_FULL = 1
BeltalowdaSO.constants.MODES.TABLE_REDUCED = 2
BeltalowdaSO.constants.TABLE_MODES = {}

BeltalowdaSO.constants.SYNERGY_ID = {}
BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD = 1
BeltalowdaSO.constants.SYNERGY_ID.TALONS = 2
BeltalowdaSO.constants.SYNERGY_ID.NOVA = 3
BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR = 4
BeltalowdaSO.constants.SYNERGY_ID.STANDARD = 5
BeltalowdaSO.constants.SYNERGY_ID.PURGE = 6
BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD = 7
BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT = 8
BeltalowdaSO.constants.SYNERGY_ID.ATRONACH = 9
BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS = 10
BeltalowdaSO.constants.SYNERGY_ID.RADIATE = 11
BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS = 12
BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH = 13
BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING = 14
BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER = 15
BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY = 16
BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE = 17
BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST = 18
BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL = 19
BeltalowdaSO.constants.SYNERGY_ID.URSUS = 20
BeltalowdaSO.constants.SYNERGY_ID.GRYPHON = 21
BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK = 22
BeltalowdaSO.constants.SYNERGY_ID.PASSAGE = 23

BeltalowdaSO.constants.SYNERGY_ABLITY_ID = {}
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR = 41965
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR = 39519
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS = 39451
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SHADOW_SILK = 41997
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS = 42019
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_FIRE = 42057
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_BEAST = 41840
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SHIELD = 39424
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SURGE = 42196
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB = 85434
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ENERGY_ORB = 63512
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS = 48052
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS = 95926
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH = 43769
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEALING_SEED = 85576
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL = 22270
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH = 48085
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH = 48085
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.STANDARD = 67717
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TALONS = 48040
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NOVA = 48938
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUPER_NOVA = 48939
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS = 77769
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SOUL_SHRED = 25172
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER = 115567
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PURE_AGONY = 118610
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE = 88892
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST = 141971
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL = 142780
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.URSUS = 112414
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRYPHON = 167045
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.RUNEBREAK = 191080
BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PASSAGE = 190646

BeltalowdaSO.constants.DISPLAYMODE_ALL = 1
BeltalowdaSO.constants.DISPLAYMODE_SYNERGY = 2

BeltalowdaSO.constants.sizes = {}
BeltalowdaSO.constants.size = {}
BeltalowdaSO.constants.size.SMALL = 1
BeltalowdaSO.constants.size.BIG = 2

BeltalowdaSO.controls = {}

BeltalowdaSO.config = {}
BeltalowdaSO.config.full = {}
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL] = {}
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight = 18
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension = 14
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing = 4
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth = 100
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth + 16 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension + 15 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height = 13 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].fontSize = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight - 2
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG] = {}
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].rowHeight = 30
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].synergyDimension = 26
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].spacing = 5
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].labelWidth = 150
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].width = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].labelWidth + 16 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].synergyDimension + 15 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].spacing
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].height = 13 * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].rowHeight
BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].fontSize = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].rowHeight - 10
BeltalowdaSO.config.isClampedToScreen = true
BeltalowdaSO.config.updateInterval = 100
BeltalowdaSO.config.buffUpdateInterval = 100
BeltalowdaSO.config.messageUpdateInterval = 100
BeltalowdaSO.config.backdropAlphaOdd = 0.25
BeltalowdaSO.config.backdropAlphaEven = 0.15
BeltalowdaSO.config.minCooldownMs = 200
BeltalowdaSO.config.reduced = {}
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL] = {}
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension = 40--50
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight = 20--25
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width = 16 * BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height = 6 * BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight + BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].fontSize = BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight - 9
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG] = {}
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension = 50--50
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].entryHeight = 25--25
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].width = 16 * BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].height = 6 * BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].entryHeight + BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension
BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].fontSize = BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].entryHeight - 9

BeltalowdaSO.state = {}
BeltalowdaSO.state.initialized = false
BeltalowdaSO.state.registredConsumers = false
BeltalowdaSO.state.foreground = true
BeltalowdaSO.state.activeLayerIndex = 1
BeltalowdaSO.state.registredActiveConsumers = false
BeltalowdaSO.state.lastMessages = {}
BeltalowdaSO.state.lastSynergy = 0

BeltalowdaSO.state.SYNERGY_DATA = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR].texture = "/esoui/art/icons/ability_undaunted_001_b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR].callbackName = BeltalowdaSO.callbackName .. ".altar"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR].id = BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS].texture = "/esoui/art/icons/ability_undaunted_003_b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS].callbackName = BeltalowdaSO.callbackName .. ".trapping_webs"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS].id = BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE].texture = "/esoui/art/icons/ability_undaunted_002_b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE].callbackName = BeltalowdaSO.callbackName .. ".radiate"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE].id = BeltalowdaSO.constants.SYNERGY_ID.RADIATE

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD].texture = "/esoui/art/icons/ability_undaunted_005b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD].callbackName = BeltalowdaSO.callbackName .. ".bone_shield"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD].id = BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD].texture = "/esoui/art/icons/ability_undaunted_004b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD].callbackName = BeltalowdaSO.callbackName .. ".combustion"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD].id = BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT].texture = "/esoui/art/icons/ability_sorcerer_liquid_lightning.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT].callbackName = BeltalowdaSO.callbackName .. ".conduit"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT].id = BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE].texture = "/esoui/art/icons/ability_templar_extended_ritual.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE].callbackName = BeltalowdaSO.callbackName .. ".purge"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE].id = BeltalowdaSO.constants.SYNERGY_ID.PURGE

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH].texture = "/esoui/art/icons/ability_sorcerer_storm_atronach.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH].callbackName = BeltalowdaSO.callbackName .. ".atronach"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH].id = BeltalowdaSO.constants.SYNERGY_ID.ATRONACH

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD].texture = "/esoui/art/icons/ability_dragonknight_006.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD].callbackName = BeltalowdaSO.callbackName .. ".standard"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD].id = BeltalowdaSO.constants.SYNERGY_ID.STANDARD

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS].texture = "/esoui/art/icons/ability_dragonknight_010.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS].callbackName = BeltalowdaSO.callbackName .. ".talons"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS].id = BeltalowdaSO.constants.SYNERGY_ID.TALONS

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA].texture = "/esoui/art/icons/ability_templar_solar_disturbance.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA].callbackName = BeltalowdaSO.callbackName .. ".nova"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA].id = BeltalowdaSO.constants.SYNERGY_ID.NOVA

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS].texture = "/esoui/art/icons/ability_nightblade_015.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS].callbackName = BeltalowdaSO.callbackName .. ".consuming_darkness"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS].id = BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH].texture = "/esoui/art/icons/ability_nightblade_018.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH].callbackName = BeltalowdaSO.callbackName .. ".soul_leech"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH].id = BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING].texture = "esoui/art/icons/ability_warden_007.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING].callbackName = BeltalowdaSO.callbackName .. ".warden_healing"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING].id = BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER].texture = "esoui/art/icons/ability_necromancer_004.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER].callbackName = BeltalowdaSO.callbackName .. ".grave_robber"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER].id = BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY].texture = "esoui/art/icons/ability_necromancer_010.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY].callbackName = BeltalowdaSO.callbackName .. ".pure_agony"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY].id = BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE].texture = "esoui/art/icons/ability_warden_005_b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE].callbackName = BeltalowdaSO.callbackName .. ".icy_escape"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE].id = BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST].texture = "esoui/art/icons/ability_u23_bloodball_chokeonit.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST].callbackName = BeltalowdaSO.callbackName .. ".sanguine_burst"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST].id = BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL].texture = "esoui/art/icons/achievement_u26_skyrim_werewolfdevour100.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL].callbackName = BeltalowdaSO.callbackName .. ".heed_the_call"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL].id = BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS].texture = "esoui/art/icons/ability_warden_018_c.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS].callbackName = BeltalowdaSO.callbackName .. ".ursus"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS].id = BeltalowdaSO.constants.SYNERGY_ID.URSUS

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON].texture = "esoui/art/icons/achievement_trial_cr_flavor_3.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON].callbackName = BeltalowdaSO.callbackName .. ".gryphon"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON].id = BeltalowdaSO.constants.SYNERGY_ID.GRYPHON

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK].texture = "esoui/art/icons/ability_arcanist_004.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK].callbackName = BeltalowdaSO.callbackName .. ".runebreak"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK].id = BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK

BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE] = {}
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE].cooldown = 20
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE].texture = "esoui/art/icons/ability_arcanist_016_b.dds"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE].callbackName = BeltalowdaSO.callbackName .. ".passage"
BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE].id = BeltalowdaSO.constants.SYNERGY_ID.PASSAGE

BeltalowdaSO.state.SYNERGIES = {}
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SHADOW_SILK] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_FIRE] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_BEAST] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RADIATE]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SHIELD] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SURGE] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ENERGY_ORB] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEALING_SEED] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURGE]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.STANDARD] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.STANDARD]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TALONS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.TALONS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NOVA] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUPER_NOVA] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.NOVA]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SOUL_SHRED] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PURE_AGONY] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.URSUS] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.URSUS]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRYPHON] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.RUNEBREAK] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK]
BeltalowdaSO.state.SYNERGIES[BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PASSAGE] = BeltalowdaSO.state.SYNERGY_DATA[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE]

BeltalowdaSO.state.fullWidth = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width
BeltalowdaSO.state.reducedWidth = BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width
BeltalowdaSO.state.reducedSynergyDimension = BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension
BeltalowdaSO.state.reducedEntryHeight = BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight


local wm = WINDOW_MANAGER

function BeltalowdaSO.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaSO.callbackName, BeltalowdaSO.OnProfileChanged)

	BeltalowdaSO.state.controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	
	BeltalowdaSO.CreateUI()
	
	BeltalowdaMenu.AddPositionFixedConsumer(BeltalowdaSO.SetSoPositionLocked)
	
	BeltalowdaSO.state.initialized = true
	BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, BeltalowdaSO.soVars.windowEnabled)
	BeltalowdaSO.SetPositionLocked(BeltalowdaSO.soVars.positionLocked)
	BeltalowdaSO.SetControlVisibility()
	
	BeltalowdaSO.AdjustSize()
end

function BeltalowdaSO.CreateUI()
	BeltalowdaSO.controls.TLW = wm:CreateTopLevelWindow(BeltalowdaSO.constants.TLW)
	
	BeltalowdaSO.SetTlwLocation()
	
	BeltalowdaSO.controls.TLW:SetClampedToScreen(BeltalowdaSO.config.isClampedToScreen)
	BeltalowdaSO.controls.TLW:SetHandler("OnMoveStop", BeltalowdaSO.SaveWindowLocation)
	BeltalowdaSO.controls.TLW:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height)
	
	--full table mode
	BeltalowdaSO.controls.TLW.fullTableControl = wm:CreateControl(nil, BeltalowdaSO.controls.TLW, CT_CONTROL)
	
	local fullTableControl = BeltalowdaSO.controls.TLW.fullTableControl
	
	
	fullTableControl:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height)
	fullTableControl:SetAnchor(TOPLEFT, BeltalowdaSO.controls.TLW, TOPLEFT, 0, 0)
	
	fullTableControl.movableBackdrop = wm:CreateControl(nil, fullTableControl, CT_BACKDROP)
	
	fullTableControl.movableBackdrop:SetAnchor(TOPLEFT, fullTableControl, TOPLEFT, 0, 0)
	fullTableControl.movableBackdrop:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height)
	
	fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	fullTableControl.header = BeltalowdaSO.CreateUiHeader(fullTableControl)
	fullTableControl.rows = {}
	for i = 1, 24 do
		fullTableControl.rows[i] = BeltalowdaSO.CreateUiRow(fullTableControl, i * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight)
	end
	
	--reduced table mode
	BeltalowdaSO.controls.TLW.reducedTableControl = wm:CreateControl(nil, BeltalowdaSO.controls.TLW, CT_CONTROL)
	
	local reducedTableControl = BeltalowdaSO.controls.TLW.reducedTableControl
	
	
	reducedTableControl:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height)
	reducedTableControl:SetAnchor(TOPLEFT, BeltalowdaSO.controls.TLW, TOPLEFT, 0, 0)
	
	reducedTableControl.movableBackdrop = wm:CreateControl(nil, reducedTableControl, CT_BACKDROP)
	
	reducedTableControl.movableBackdrop:SetAnchor(TOPLEFT, reducedTableControl, TOPLEFT, 0, 0)
	reducedTableControl.movableBackdrop:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height)
	
	reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
	reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	
	reducedTableControl.header = BeltalowdaSO.CreateUiReducedHeader(reducedTableControl)
	reducedTableControl.entries = {}
	for i = 1, 12 do
		reducedTableControl.entries[i] = BeltalowdaSO.CreateReducedEntry(reducedTableControl)
	end
end

function BeltalowdaSO.SetTlwLocation()
	BeltalowdaSO.controls.TLW:ClearAnchors()
	if BeltalowdaSO.soVars.location == nil then
		BeltalowdaSO.controls.TLW:SetAnchor(CENTER, GuiRoot, CENTER, -250, 250)
	else
		BeltalowdaSO.controls.TLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, BeltalowdaSO.soVars.location.x, BeltalowdaSO.soVars.location.y)
	end
end

function BeltalowdaSO.CreateUiHeader(control)
	local header = wm:CreateControl(nil, control, CT_CONTROL)
	header:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight)
	header:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	header.synergies = {}
	
	for i = 1, #BeltalowdaSO.state.SYNERGY_DATA do
		local positionX = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth + ((i - 1) * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension) + ((i - 1) * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing)
		header.synergies[i] = BeltalowdaSO.CreateSynergyIcon(header, positionX, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing, i)
	end
	
	return header
end

function BeltalowdaSO.CreateUiReducedHeader(control)
	local header = wm:CreateControl(nil, control, CT_CONTROL)
	header:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	header:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	header.synergies = {}
	for i = 1, #BeltalowdaSO.state.SYNERGY_DATA do
		local positionX = ((i - 1) * BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension)
		header.synergies[i] = BeltalowdaSO.CreateReducedSynergyIcon(header, positionX, 0, i)
	end
	return header
end

function BeltalowdaSO.CreateSynergyIcon(control, positionX, positionY, index)
	local texture = wm:CreateControl(nil, control, CT_TEXTURE)
	texture:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	texture:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	texture:SetTexture(BeltalowdaSO.state.SYNERGY_DATA[index].texture)
	return texture
end

function BeltalowdaSO.CreateReducedSynergyIcon(control, positionX, positionY, index)
	local retControl = wm:CreateControl(nil, control, CT_CONTROL)
	retControl:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	retControl:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	
	retControl.texture = wm:CreateControl(nil, retControl, CT_TEXTURE)
	retControl.texture:SetAnchor(TOPLEFT, retControl, TOPLEFT, 0, 0)
	retControl.texture:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	retControl.texture:SetTexture(BeltalowdaSO.state.SYNERGY_DATA[index].texture)
	retControl.texture:SetDrawTier(0)
	
	retControl.border = wm:CreateControl(nil, retControl, CT_TEXTURE)
	retControl.border:SetAnchor(TOPLEFT, retControl, TOPLEFT, 0, 0)
	retControl.border:SetDimensions(BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	retControl.border:SetTexture("/esoui/art/actionbar/abilityframe64_up.dds")
	retControl.border:SetDrawTier(1)
	return retControl
end

function BeltalowdaSO.CreateUiRow(control, positionY)
	local row = wm:CreateControl(nil, control, CT_CONTROL)
	row:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight)
	row:SetAnchor(TOPLEFT, control, TOPLEFT, 0, positionY)
	row:SetHidden(true)
	
	row.backdrop = wm:CreateControl(nil, row, CT_BACKDROP)
	row.backdrop:SetAnchor(TOPLEFT, row, TOPLEFT, 0, 0)
	row.backdrop:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight)
	row.backdrop:SetCenterColor(BeltalowdaSO.soVars.backgroundColor.r, BeltalowdaSO.soVars.backgroundColor.g, BeltalowdaSO.soVars.backgroundColor.b, 0)
	row.backdrop:SetEdgeColor(BeltalowdaSO.soVars.backgroundColor.r, BeltalowdaSO.soVars.backgroundColor.g, BeltalowdaSO.soVars.backgroundColor.b, 0)
		
	row.label = wm:CreateControl(nil, row, CT_LABEL)
	row.label:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight)
	row.label:SetAnchor(TOPLEFT, row, TOPLEFT, 0, 0)
	row.label:SetFont(BeltalowdaSO.state.controlFont)
	row.label:SetWrapMode(ELLIPSIS)
	row.label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	row.label:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	--row.label:SetText("test")
	
	row.synergies = {}
	for i = 1, #BeltalowdaSO.state.SYNERGY_DATA do
		local positionX = BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth + ((i - 1) * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension) + ((i - 1) * BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing)
		row.synergies[i] = BeltalowdaSO.CreateSynergyProgressBar(row, positionX, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing / 2)
	end
	return row
end

function BeltalowdaSO.CreateReducedEntry(control)
	local sizeIncrease = BeltalowdaSO.soVars.size - BeltalowdaSO.constants.size.SMALL
	local synergyDimension = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local entryHeight = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].entryHeight - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight) * sizeIncrease)
	local font = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].fontSize + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].fontSize - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].fontSize) * sizeIncrease), BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	
	local entry = wm:CreateControl(nil, control, CT_CONTROL)
	entry:SetDimensions(synergyDimension, entryHeight)
	entry:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
	
	entry.backdrop = wm:CreateControl(nil, entry, CT_BACKDROP)
	entry.backdrop:SetAnchor(TOPLEFT, entry, TOPLEFT, 0, 0)
	entry.backdrop:SetDimensions(synergyDimension, entryHeight)
	entry.backdrop:SetCenterColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, BeltalowdaSO.soVars.synergyBackdropColor.a)
	entry.backdrop:SetEdgeColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, 0)
	
	entry.progress = wm:CreateControl(nil, entry, CT_STATUSBAR)
	entry.progress:SetAnchor(TOPLEFT, entry, TOPLEFT, 1, 1)
	entry.progress:SetDimensions(synergyDimension - 2, entryHeight - 2)
	entry.progress:SetMinMax(0, 100)
	entry.progress:SetValue(0)
	entry.progress:SetColor(BeltalowdaSO.soVars.progressColor.r, BeltalowdaSO.soVars.progressColor.g, BeltalowdaSO.soVars.progressColor.b, 1)
	
	entry.name = wm:CreateControl(nil, entry, CT_LABEL)
	entry.name:SetDimensions(synergyDimension - 8, entryHeight - 4)
	entry.name:SetAnchor(TOPLEFT, entry, TOPLEFT, 4, 2)
	entry.name:SetFont(font)
	entry.name:SetWrapMode(ELLIPSIS)
	entry.name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	entry.name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	entry.name:SetColor(BeltalowdaSO.soVars.textColor.r, BeltalowdaSO.soVars.textColor.g, BeltalowdaSO.soVars.textColor.b, 1)
	
	entry.edge = wm:CreateControl(nil, entry, CT_BACKDROP)
	entry.edge:SetAnchor(TOPLEFT, entry, TOPLEFT, 0, 0)
	entry.edge:SetDimensions(synergyDimension, entryHeight)
	entry.edge:SetEdgeTexture(nil, 1, 1, 1, 0)
	entry.edge:SetCenterColor(0, 0, 0, 0)
	entry.edge:SetEdgeColor(0, 0, 0, 1)
	
	return entry
end

function BeltalowdaSO.CreateSynergyProgressBar(control, positionX, positionY)
	local synergy = wm:CreateControl(nil, control, CT_CONTROL)
	synergy:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, positionY)
	synergy:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	
	synergy.backdrop = wm:CreateControl(nil, synergy, CT_BACKDROP)
	synergy.backdrop:SetAnchor(TOPLEFT, synergy, TOPLEFT, 0, 0)
	synergy.backdrop:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	synergy.backdrop:SetCenterColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, BeltalowdaSO.soVars.synergyBackdropColor.a)
	synergy.backdrop:SetEdgeColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, 0)
	
	synergy.progress = wm:CreateControl(nil, synergy, CT_STATUSBAR)
	synergy.progress:SetAnchor(TOPLEFT, synergy, TOPLEFT, 0, 0)
	synergy.progress:SetDimensions(BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension, BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension)
	synergy.progress:SetMinMax(0, 100)
	synergy.progress:SetValue(0)
	synergy.progress:SetColor(BeltalowdaSO.soVars.progressColor.r, BeltalowdaSO.soVars.progressColor.g, BeltalowdaSO.soVars.progressColor.b, 1)
	
	return synergy
end

function BeltalowdaSO.AdjustSynergyColors()
	for i = 1, #BeltalowdaSO.controls.TLW.fullTableControl.rows do
		for j = 1, #BeltalowdaSO.controls.TLW.fullTableControl.rows[i].synergies do
			local synergy = BeltalowdaSO.controls.TLW.fullTableControl.rows[i].synergies[j]
			synergy.backdrop:SetCenterColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, BeltalowdaSO.soVars.synergyBackdropColor.a)
			synergy.backdrop:SetEdgeColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, 0)
			synergy.progress:SetColor(BeltalowdaSO.soVars.progressColor.r, BeltalowdaSO.soVars.progressColor.g, BeltalowdaSO.soVars.progressColor.b, 1)
			BeltalowdaSO.controls.TLW.fullTableControl.rows[i].label:SetColor(BeltalowdaSO.soVars.textColor.r, BeltalowdaSO.soVars.textColor.g, BeltalowdaSO.soVars.textColor.b, 1)
		end
	end
	
	for j = 1, #BeltalowdaSO.controls.TLW.reducedTableControl.entries do
		local entry = BeltalowdaSO.controls.TLW.reducedTableControl.entries[j]
		entry.backdrop:SetCenterColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, BeltalowdaSO.soVars.synergyBackdropColor.a)
		entry.backdrop:SetEdgeColor(BeltalowdaSO.soVars.synergyBackdropColor.r, BeltalowdaSO.soVars.synergyBackdropColor.g, BeltalowdaSO.soVars.synergyBackdropColor.b, 0)
		entry.progress:SetColor(BeltalowdaSO.soVars.progressColor.r, BeltalowdaSO.soVars.progressColor.g, BeltalowdaSO.soVars.progressColor.b, 1)
		entry.name:SetColor(BeltalowdaSO.soVars.textColor.r, BeltalowdaSO.soVars.textColor.g, BeltalowdaSO.soVars.textColor.b, 1)
	end

end

function BeltalowdaSO.SetEnabled(enabled, windowEnabled)
	if BeltalowdaSO.state.initialized == true and enabled ~= nil then
		BeltalowdaSO.soVars.enabled = enabled
		BeltalowdaSO.soVars.windowEnabled = windowEnabled
		if enabled == true then
			if BeltalowdaSO.state.registredConsumers == false then
				EVENT_MANAGER:RegisterForEvent(BeltalowdaSO.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaSO.OnPlayerActivated)
			end
			BeltalowdaSO.state.registredConsumers = true
		else
			if BeltalowdaSO.state.registredConsumers == true then
				EVENT_MANAGER:UnregisterForEvent(BeltalowdaSO.callbackName, EVENT_PLAYER_ACTIVATED)
			end
			BeltalowdaSO.state.registredConsumers = false
			BeltalowdaSO.SetControlVisibility()
		end
		BeltalowdaSO.OnPlayerActivated()
	end
end

function BeltalowdaSO.GetDefaults()
	local defaults = {}
	defaults.enabled = true
	defaults.windowEnabled = false
	defaults.positionLocked = true
	defaults.pvpOnly = true
	defaults.tableMode = BeltalowdaSO.constants.MODES.TABLE_FULL
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
	defaults.displayMode = BeltalowdaSO.constants.DISPLAYMODE_ALL
	defaults.synergyVisibility = {}
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.COMBUSTION_SHARD] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.TALONS] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.NOVA] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.BLOOD_ALTAR] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.STANDARD] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.PURGE] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.BONE_SHIELD] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.FLOOD_CONDUIT] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.ATRONACH] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.TRAPPING_WEBS] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.RADIATE] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.CONSUMING_DARKNESS] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.SOUL_LEECH] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.WARDEN_HEALING] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.GRAVE_ROBBER] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.PURE_AGONY] = true
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.ICY_ESCAPE] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.SANGUINE_BURST] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.HEED_THE_CALL] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.URSUS] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.GRYPHON] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.RUNEBREAK] = false
	defaults.synergyVisibility[BeltalowdaSO.constants.SYNERGY_ID.PASSAGE] = false
	defaults.size = BeltalowdaSO.constants.size.SMALL
	return defaults
end

function BeltalowdaSO.SetPositionLocked(value)
	BeltalowdaSO.soVars.positionLocked = value
	
	BeltalowdaSO.controls.TLW:SetMovable(not value)
	BeltalowdaSO.controls.TLW:SetMouseEnabled(not value)
	if value == true then
		BeltalowdaSO.controls.TLW.fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSO.controls.TLW.fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaSO.controls.TLW.reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.0)
		BeltalowdaSO.controls.TLW.reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	else
		BeltalowdaSO.controls.TLW.fullTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSO.controls.TLW.fullTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
		BeltalowdaSO.controls.TLW.reducedTableControl.movableBackdrop:SetCenterColor(1, 0, 0, 0.5)
		BeltalowdaSO.controls.TLW.reducedTableControl.movableBackdrop:SetEdgeColor(1, 0, 0, 0.0)
	end
end

function BeltalowdaSO.SetControlVisibility()
	local enabled = BeltalowdaSO.soVars.enabled and BeltalowdaSO.soVars.windowEnabled
	local setHidden = true
	if enabled ~= nil and enabled == true and (BeltalowdaSO.soVars.pvpOnly == false or (BeltalowdaSO.soVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		setHidden = false
	end
	if setHidden == false then
		if BeltalowdaSO.state.foreground == false then
			BeltalowdaSO.controls.TLW:SetHidden(BeltalowdaSO.state.activeLayerIndex > 2)
		else
			BeltalowdaSO.controls.TLW:SetHidden(false)
		end
	else
		BeltalowdaSO.controls.TLW:SetHidden(setHidden)
	end
	if BeltalowdaSO.soVars.tableMode == BeltalowdaSO.constants.MODES.TABLE_FULL then
		BeltalowdaSO.controls.TLW.fullTableControl:SetHidden(false)
		BeltalowdaSO.controls.TLW.reducedTableControl:SetHidden(true)
		
		local sizeIncrease = BeltalowdaSO.soVars.size - BeltalowdaSO.constants.size.SMALL
		local width = BeltalowdaSO.state.fullWidth
		local height = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
		BeltalowdaSO.controls.TLW:SetDimensions(width, height)
	elseif BeltalowdaSO.soVars.tableMode == BeltalowdaSO.constants.MODES.TABLE_REDUCED then
		BeltalowdaSO.controls.TLW.fullTableControl:SetHidden(true)
		BeltalowdaSO.controls.TLW.reducedTableControl:SetHidden(false)
		
		local sizeIncrease = BeltalowdaSO.soVars.size - BeltalowdaSO.constants.size.SMALL
		local width = BeltalowdaSO.state.reducedWidth
		local height = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
		BeltalowdaSO.controls.TLW:SetDimensions(width, height)
	end
	--d(setHidden)
end

function BeltalowdaSO.RegisterForCombatEvent(id, suffix)
	if id ~= nil then
		local data = BeltalowdaSO.state.SYNERGIES[id]
		if data ~= nil then
			local callbackName = data.callbackName
			if suffix ~= nil then
				callbackName = callbackName .. suffix
			end
			EVENT_MANAGER:RegisterForEvent(callbackName, EVENT_COMBAT_EVENT, BeltalowdaSO.OnCombatEvent)
			EVENT_MANAGER:AddFilterForEvent(callbackName, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, id)
		end
	end
end

function BeltalowdaSO.UnregisterForCombatEvent(id, suffix)
	if id ~= nil then
		local data = BeltalowdaSO.state.SYNERGIES[id]
		if data ~= nil then
			local callbackName = data.callbackName
			if suffix ~= nil then
				callbackName = callbackName .. suffix
			end
			EVENT_MANAGER:UnregisterForEvent(callbackName, EVENT_COMBAT_EVENT)
		end
	end
end

function BeltalowdaSO.AdjustSynergyDisplay()
	--fullTableControl
	local fullTableControl = BeltalowdaSO.controls.TLW.fullTableControl
	local header = fullTableControl.header
	local rows = fullTableControl.rows
	
	local sizeIncrease = BeltalowdaSO.soVars.size - BeltalowdaSO.constants.size.SMALL
	local synergyDimension = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].synergyDimension - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local labelWidth = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].labelWidth - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth) * sizeIncrease)
	local spacing = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].spacing - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing) * sizeIncrease)
	local rowHeight = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].rowHeight - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight) * sizeIncrease)
	--local width = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].width - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].width) * sizeIncrease)
	local height = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
	
	for i = 1, #rows do
		local visibleIndex = 1
		for j = 1, #rows[i].synergies do
			local synergy = rows[i].synergies[j]
			if BeltalowdaSO.soVars.synergyVisibility[j] == true then
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
		if BeltalowdaSO.soVars.synergyVisibility[i] == true then
			synergy:SetHidden(false)
			synergy:ClearAnchors()
			local positionX = labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing)
			synergy:SetAnchor(TOPLEFT, header, TOPLEFT, positionX, spacing / 2)
				
			visibleIndex = visibleIndex + 1
		else
			synergy:SetHidden(true)
		end
		BeltalowdaSO.state.fullWidth = labelWidth + ((visibleIndex - 1) * synergyDimension) + ((visibleIndex - 1) * spacing)
	end
	fullTableControl.movableBackdrop:SetDimensions(BeltalowdaSO.state.fullWidth, height)
	--reducedTableControl
	local reducedTableControl = BeltalowdaSO.controls.TLW.reducedTableControl
	synergyDimension = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension) * sizeIncrease)
	--width = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].width - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].width) * sizeIncrease)
	height = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
	
	
	header = reducedTableControl.header
	visibleIndex = 1
	for i = 1, #header.synergies do
		local synergy = header.synergies[i]
		if BeltalowdaSO.soVars.synergyVisibility[i] == true then
			synergy:SetHidden(false)
			synergy:ClearAnchors()
			local positionX = (visibleIndex - 1) * synergyDimension + (visibleIndex - 1) * BeltalowdaSO.soVars.spacing
			synergy:SetAnchor(TOPLEFT, header, TOPLEFT, positionX, 0)
				
			visibleIndex = visibleIndex + 1
		else
			synergy:SetHidden(true)
		end
		BeltalowdaSO.state.reducedWidth = (visibleIndex - 1) * synergyDimension + (visibleIndex - 1) * BeltalowdaSO.soVars.spacing
	end
	reducedTableControl.movableBackdrop:SetDimensions(BeltalowdaSO.state.reducedWidth, height)
	BeltalowdaSO.SetControlVisibility()
end

function BeltalowdaSO.GetSynergyIdForAbilityId(abilityId)
	local synergyId = 0
	if BeltalowdaSO.state.SYNERGIES[abilityId] ~= nil then
		synergyId = BeltalowdaSO.state.SYNERGIES[abilityId].id
	end
	return synergyId
end

function BeltalowdaSO.SortNumbers(value1, value2) 
	return value1 > value2
end

function BeltalowdaSO.SortSynergyList(playerA, playerB)
	local index = BeltalowdaSO.state.tempSortIndex --to prevent a closure performance impact
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

function BeltalowdaSO.CreateSortedSynergyList(players)
	local synergyList = {}
	local synergyHeaders = BeltalowdaSO.controls.TLW.reducedTableControl.header.synergies
	for i = 1, #synergyHeaders do
		if synergyHeaders[i]:IsHidden() == false then
			synergyList[i] = {}
			for j = 1, #players do
				if players[j].synergies[i] ~= nil and (BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_ALL or (BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_SYNERGY and players[j].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY)) then
					--d("adding synergy")
					table.insert(synergyList[i], players[j])
				end
			end
			BeltalowdaSO.state.tempSortIndex = i
			--d("sorting synergies")
			table.sort(synergyList[i], BeltalowdaSO.SortSynergyList)
		end
	end
	return synergyList
end

function BeltalowdaSO.AdjustSize()
	local sizeIncrease = BeltalowdaSO.soVars.size - BeltalowdaSO.constants.size.SMALL
	local synergyDimension = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].synergyDimension - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local labelWidth = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].labelWidth - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].labelWidth) * sizeIncrease)
	local spacing = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].spacing - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].spacing) * sizeIncrease)
	local rowHeight = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].rowHeight - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].rowHeight) * sizeIncrease)
	local fontSize = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].fontSize + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].fontSize - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].fontSize) * sizeIncrease)
	local width = BeltalowdaSO.state.fullWidth
	local height = (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.full[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.full[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
	
	BeltalowdaSO.state.controlFont = BeltalowdaFonts.CreateFontString(BeltalowdaFonts.constants.CHAT_FONT, BeltalowdaFonts.constants.INPUT_KB, fontSize, BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN)
	--full
	local fullTableControl = BeltalowdaSO.controls.TLW.fullTableControl
	
	fullTableControl:SetDimensions(width, height)
	fullTableControl.movableBackdrop:SetDimensions(width, height)

	fullTableControl.header:SetDimensions(width, rowHeight)
	for i = 1, #BeltalowdaSO.state.SYNERGY_DATA do
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
		fullTableControl.rows[i].label:SetFont(BeltalowdaSO.state.controlFont)
		
		for j = 1, #BeltalowdaSO.state.SYNERGY_DATA do
			local positionX = labelWidth + ((j - 1) * synergyDimension) + ((j - 1) * spacing)
			fullTableControl.rows[i].synergies[j]:ClearAnchors()
			fullTableControl.rows[i].synergies[j]:SetAnchor(TOPLEFT, control, TOPLEFT, positionX, spacing / 2)
			fullTableControl.rows[i].synergies[j]:SetDimensions(synergyDimension, synergyDimension)
			fullTableControl.rows[i].synergies[j].backdrop:SetDimensions(synergyDimension, synergyDimension)
			fullTableControl.rows[i].synergies[j].progress:SetDimensions(synergyDimension, synergyDimension)
		end
	end
	
	--reduced
	local reducedTableControl = BeltalowdaSO.controls.TLW.reducedTableControl
	width = BeltalowdaSO.state.reducedWidth
	height = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].height - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].height) * sizeIncrease)
	synergyDimension = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].synergyDimension - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].synergyDimension) * sizeIncrease)
	local entryHeight = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].entryHeight - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].entryHeight) * sizeIncrease)
	fontSize = (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].fontSize + (BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.BIG].fontSize - BeltalowdaSO.config.reduced[BeltalowdaSO.constants.size.SMALL].fontSize) * sizeIncrease)
	
	BeltalowdaSO.state.reducedSynergyDimension = synergyDimension
	BeltalowdaSO.state.reducedEntryHeight = entryHeight
	
	reducedTableControl:SetDimensions(width, height)
	
	reducedTableControl.movableBackdrop:SetDimensions(width, height)
		
	reducedTableControl.header:SetDimensions(width, synergyDimension)
	
	for i = 1, #BeltalowdaSO.state.SYNERGY_DATA do
		local positionX = ((i - 1) * synergyDimension) + (i - 1) * BeltalowdaSO.soVars.spacing
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
		reducedTableControl.entries[i]:SetDimensions(synergyDimension + BeltalowdaSO.soVars.spacing, entryHeight)
		
		reducedTableControl.entries[i].backdrop:ClearAnchors()
		reducedTableControl.entries[i].backdrop:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 0, 0)
		reducedTableControl.entries[i].backdrop:SetDimensions(synergyDimension + BeltalowdaSO.soVars.spacing, entryHeight)
		
		reducedTableControl.entries[i].progress:ClearAnchors()
		reducedTableControl.entries[i].progress:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 1, 1)
		reducedTableControl.entries[i].progress:SetDimensions(synergyDimension - 2 + BeltalowdaSO.soVars.spacing, entryHeight - 2)
		
		reducedTableControl.entries[i].name:SetFont(font)
		reducedTableControl.entries[i].name:SetDimensions(synergyDimension - 8 + BeltalowdaSO.soVars.spacing, entryHeight - 4)
		reducedTableControl.entries[i].name:ClearAnchors()
		reducedTableControl.entries[i].name:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 4, 2)
		
		reducedTableControl.entries[i].edge:ClearAnchors()
		reducedTableControl.entries[i].edge:SetAnchor(TOPLEFT, reducedTableControl.entries[i], TOPLEFT, 0, 0)
		reducedTableControl.entries[i].edge:SetDimensions(synergyDimension + BeltalowdaSO.soVars.spacing, entryHeight)
		
	end
	BeltalowdaSO.AdjustSynergyDisplay()
end

function BeltalowdaSO.GetPlayerDebuffs()
	return BeltalowdaDbo.GetPlayerDebuffs()
end

--callbacks
function BeltalowdaSO.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaSO.soVars = currentProfile.toolbox.so
		if BeltalowdaSO.state.initialized == true then
			BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, BeltalowdaSO.soVars.windowEnabled)
			BeltalowdaSO.SetPositionLocked(BeltalowdaSO.soVars.positionLocked)
			BeltalowdaSO.SetControlVisibility()
			BeltalowdaSO.SetTlwLocation()
			BeltalowdaSO.AdjustSynergyColors()
			BeltalowdaSO.AdjustSize()
		end
	end
end

function BeltalowdaSO.OnPlayerActivated(eventCode, initial)
	if BeltalowdaSO.soVars.enabled == true and (BeltalowdaSO.soVars.pvpOnly == false or (BeltalowdaSO.soVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true)) then
		if BeltalowdaSO.state.registredActiveConsumers == false then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSO.callbackName, EVENT_ACTION_LAYER_POPPED, BeltalowdaSO.SetForegroundVisibility)
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSO.callbackName, EVENT_ACTION_LAYER_PUSHED, BeltalowdaSO.SetForegroundVisibility)
		
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SHADOW_SILK, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS, "3")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_FIRE, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_BEAST, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SHIELD, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SURGE, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ENERGY_ORB, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS, "3")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS, "4")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEALING_SEED, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.STANDARD, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TALONS, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NOVA, "1")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUPER_NOVA, "2")
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SOUL_SHRED, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PURE_AGONY, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.URSUS, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRYPHON, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.RUNEBREAK, nil)
			BeltalowdaSO.RegisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PASSAGE, nil)
			
			BeltalowdaUtilGroup.AddFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_SYNERGY, BeltalowdaSO.config.updateInterval)
			BeltalowdaUtilGroup.AddFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS, BeltalowdaSO.config.buffUpdateInterval)
			--BeltalowdaUtilGroup.AddFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE, BeltalowdaSO.config.updateInterval)
			
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaSO.callbackName, BeltalowdaSO.config.updateInterval, BeltalowdaSO.UiLoop)
			EVENT_MANAGER:RegisterForUpdate(BeltalowdaSO.messageLoopCallbackName, BeltalowdaSO.config.messageUpdateInterval, BeltalowdaSO.MessageLoop)
			
			BeltalowdaSO.state.registredActiveConsumers = true
		end
	else
		if BeltalowdaSO.state.registredActiveConsumers == true then
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSO.callbackName, EVENT_ACTION_LAYER_POPPED)
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSO.callbackName, EVENT_ACTION_LAYER_PUSHED)
			
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BLOOD_ALTAR, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.OVERFLOWING_ALTAR, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TRAPPING_WEBS, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SHADOW_SILK, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TANGLING_WEBS, "3")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_FIRE, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.INNER_BEAST, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SHIELD, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.BONE_SURGE, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NECROTIC_ORB, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ENERGY_ORB, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LUMINOUS_SHARDS, "3")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SPEAR_SHARDS, "4")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.LIGHTNING_SPLASH, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEALING_SEED, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.EXTENDED_RITUAL, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_STORM_ATRONACH, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUMMON_ATRONACH, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.STANDARD, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.TALONS, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.NOVA, "1")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SUPER_NOVA, "2")
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.CONSUMING_DARKNESS, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SOUL_SHRED, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRAVE_ROBBER, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PURE_AGONY, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.ICY_ESCAPE, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.SANGUINE_BURST, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.HEED_THE_CALL, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.URSUS, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.GRYPHON, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.RUNEBREAK, nil)
			BeltalowdaSO.UnregisterForCombatEvent(BeltalowdaSO.constants.SYNERGY_ABLITY_ID.PASSAGE, nil)
			
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_SYNERGY)
			BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_BUFFS)
			--BeltalowdaUtilGroup.RemoveFeature(BeltalowdaSO.callbackName, BeltalowdaUtilGroup.features.FEATURE_GROUP_DEAD_STATE)
			
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaSO.callbackName)
			EVENT_MANAGER:UnregisterForUpdate(BeltalowdaSO.messageLoopCallbackName)
			
			BeltalowdaSO.state.registredActiveConsumers = false
		end
	end
	BeltalowdaSO.SetControlVisibility()
end

--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") d(an) d(ai) d(si)d(ti)d(sn)d(tn) end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") d(an) d(ai) d(sn)d(tn) end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an,_,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") if sn == "Cartraf^Mx" or tn == "Cartraf^Mx" then d(an) d(ai) d(sn)d(tn) end end)
--/script EVENT_MANAGER:RegisterForEvent("test",EVENT_COMBAT_EVENT, function(_, _, _, an, gr,_,sn,_,tn,_,_,_,_,_,si,ti,ai) d("---") if sn == "Flying Locus^Mx" or tn == "Flying Locus^Mx" then d(an) d(ai) d(sn)d(tn) d(gr) end end)
function BeltalowdaSO.OnCombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, isLog, sourceUnitId, targetUnitId, abilityId) 
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
		--if BeltalowdaSO.state.lastSynergy + BeltalowdaSO.config.minCooldownMs < timeStamp then
			
			BeltalowdaSO.state.lastSynergy = timeStamp
			local synergyId = BeltalowdaSO.GetSynergyIdForAbilityId(abilityId)
			--d(abilityId)
			if synergyId ~= 0 then
				local message = {}
				message.b0 = BeltalowdaNetworking.messageTypes.MESSAGE_ID_SYNERGY
				message.b1 = synergyId
				message.b2 = 0
				local debuffs = BeltalowdaSO.GetPlayerDebuffs()
				if debuffs > 7 then
					debuffs = 7
				end
				message.b3 = debuffs
				message.timeStamp = timeStamp
				message.sent = false
				BeltalowdaNetworking.SendSynergyMessage(message, BeltalowdaNetworking.constants.priorities.HIGH)
				table.insert(BeltalowdaSO.state.lastMessages, message)
				BeltalowdaChat.SendChatMessage("Synergy Message Sent: " .. message.b1 .. " - " .. message.b2, BeltalowdaSO.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
			end
		--end
	end
	
end

function BeltalowdaSO.MessageLoop()
	local messages = BeltalowdaSO.state.lastMessages
	local removeMessages = {}
	for i = 1, #messages do
		local message = messages[i]
		if message.sent == true then
			table.insert(removeMessages, i)
		else
			message.b2 = tonumber(string.format("%d",(GetGameTimeMilliseconds() - message.timeStamp) / 100))
			local debuffs = BeltalowdaSO.GetPlayerDebuffs()
			if debuffs > 7 then
				debuffs = 7
			end
			message.b3 = debuffs
		end
	end
	table.sort(removeMessages, BeltalowdaSO.SortNumbers)
	for i = 1, #removeMessages do
		table.remove(messages, removeMessages[i])
	end
end

function BeltalowdaSO.SetForegroundVisibility(eventCode, layerIndex, activeLayerIndex)
	if eventCode == EVENT_ACTION_LAYER_POPPED then
		BeltalowdaSO.state.foreground = true
	elseif eventCode == EVENT_ACTION_LAYER_PUSHED then
		BeltalowdaSO.state.foreground = false
	end
	--hack?
	BeltalowdaSO.state.activeLayerIndex = activeLayerIndex
	
	BeltalowdaSO.SetControlVisibility()
end

function BeltalowdaSO.SaveWindowLocation()
	if BeltalowdaSO.soVars.positionLocked == false then
		BeltalowdaSO.soVars.location = BeltalowdaSO.soVars.location or {}
		BeltalowdaSO.soVars.location.x = BeltalowdaSO.controls.TLW:GetLeft()
		BeltalowdaSO.soVars.location.y = BeltalowdaSO.controls.TLW:GetTop()
	end
end

function BeltalowdaSO.UiLoop()
	local players = BeltalowdaUtilGroup.GetGroupInformation()
	local timeStamp = GetGameTimeMilliseconds()
	if BeltalowdaSO.soVars.tableMode == BeltalowdaSO.constants.MODES.TABLE_FULL then
		--BeltalowdaSO.constants.MODES.TABLE_FULL
		local rows = BeltalowdaSO.controls.TLW.fullTableControl.rows
		if players ~= nil then
			local visibleIndex = 1
			for i = 1, #players do
				local player = players[i]
				local row = rows[visibleIndex]
				if BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_ALL or (BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_SYNERGY and players[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) then
					row:SetHidden(false)
					row.label:SetText(player.name)
					local alpha = BeltalowdaSO.config.backdropAlphaOdd
					if visibleIndex % 2 == 0 then
						alpha = BeltalowdaSO.config.backdropAlphaEven
					end
					if player.role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY then
						row.backdrop:SetCenterColor(BeltalowdaSO.soVars.synergyColor.r, BeltalowdaSO.soVars.synergyColor.g, BeltalowdaSO.soVars.synergyColor.b, alpha)
						row.backdrop:SetEdgeColor(BeltalowdaSO.soVars.synergyColor.r, BeltalowdaSO.soVars.synergyColor.g, BeltalowdaSO.soVars.synergyColor.b, 0)
					else
						row.backdrop:SetCenterColor(BeltalowdaSO.soVars.backgroundColor.r, BeltalowdaSO.soVars.backgroundColor.g, BeltalowdaSO.soVars.backgroundColor.b, alpha)
						row.backdrop:SetEdgeColor(BeltalowdaSO.soVars.backgroundColor.r, BeltalowdaSO.soVars.backgroundColor.g, BeltalowdaSO.soVars.backgroundColor.b, 0)
					end
					
					
					visibleIndex = visibleIndex + 1
					for j = 1, #row.synergies do
						local progress = 0
						if player.synergies[j] ~= nil then
							progress = (BeltalowdaSO.state.SYNERGY_DATA[j].cooldown * 1000) - (timeStamp - player.synergies[j]) 
							if progress < 0 then
								progress = 0
								player.synergies[j] = nil
							end
							progress = progress / (BeltalowdaSO.state.SYNERGY_DATA[j].cooldown * 1000) * 100
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
	elseif BeltalowdaSO.soVars.tableMode == BeltalowdaSO.constants.MODES.TABLE_REDUCED then
		--BeltalowdaSO.constants.MODES.TABLE_REDUCED
		local reducedTableControl = BeltalowdaSO.controls.TLW.reducedTableControl
		local entries = reducedTableControl.entries
		local synergyControls = reducedTableControl.header.synergies
		if players ~= nil then
			local visibleIndex = 1
			local currentControlWidthIndex = 0
			local synergies = BeltalowdaSO.CreateSortedSynergyList(players)
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
								synergyControl = BeltalowdaSO.CreateReducedEntry(reducedTableControl)
								entries[visibleIndex] = synergyControl
							end
							synergyControl.name:SetText(synergyPlayerList[j].name)
							local progress = 0
							if synergyPlayerList[j].synergies[i] ~= nil then
								progress = (BeltalowdaSO.state.SYNERGY_DATA[i].cooldown * 1000) - (timeStamp - synergyPlayerList[j].synergies[i]) 
								if progress < 0 then
									progress = 0
									synergyPlayerList[j].synergies[i] = nil
								end
								progress = progress / (BeltalowdaSO.state.SYNERGY_DATA[i].cooldown * 1000) * 100
							end
							synergyControl.progress:SetValue(progress)
							
							synergyControl:ClearAnchors()
							synergyControl:SetAnchor(TOPLEFT, reducedTableControl, TOPLEFT, (currentControlWidthIndex) * BeltalowdaSO.state.reducedSynergyDimension + (currentControlWidthIndex) * BeltalowdaSO.soVars.spacing , BeltalowdaSO.state.reducedSynergyDimension + (currentControlHeightIndex * BeltalowdaSO.state.reducedEntryHeight) - (currentControlHeightIndex * 1))
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
				--if BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_ALL or (BeltalowdaSO.soVars.displayMode == BeltalowdaSO.constants.DISPLAYMODE_SYNERGY and players[i].role == BeltalowdaUtilGroup.constants.roles.ROLE_SYNERGY) then
					
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
function BeltalowdaSO.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.SO_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_ENABLED,
					getFunc = BeltalowdaSO.GetSoEnabled,
					setFunc = BeltalowdaSO.SetSoEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_WINDOW_ENABLED,
					getFunc = BeltalowdaSO.GetSoWindowEnabled,
					setFunc = BeltalowdaSO.SetSoWindowEnabled
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_PVP_ONLY,
					getFunc = BeltalowdaSO.GetSoPvpOnly,
					setFunc = BeltalowdaSO.SetSoPvpOnly
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_POSITION_FIXED,
					getFunc = BeltalowdaSO.GetSoPositionLocked,
					setFunc = BeltalowdaSO.SetSoPositionLocked
				},
				[5] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_TABLE_MODE,
					choices = BeltalowdaSO.GetSoTableModes(),
					getFunc = BeltalowdaSO.GetSoTableMode,
					setFunc = BeltalowdaSO.SetSoTableMode
				},
				[6] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SO_DISPLAY_MODE,
					choices = BeltalowdaSO.GetSoDisplayModes(),
					getFunc = BeltalowdaSO.GetSoDisplayMode,
					setFunc = BeltalowdaSO.SetSoDisplayMode
				},
				[7] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SO_REDUCED_SPACING,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSO.GetSoReducedSpacing,
					setFunc = BeltalowdaSO.SetSoReducedSpacing,
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
					getFunc = BeltalowdaSO.GetSoSize,
					setFunc = BeltalowdaSO.SetSoSize,
					width = "full",
					decimals = 2,
					default = 1.0
				},
				[9] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP,
					getFunc = BeltalowdaSO.GetSoSynergyBackdropColor,
					setFunc = BeltalowdaSO.SetSoSynergyBackdropColor,
					width = "full"
				},
				[10] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS,
					getFunc = BeltalowdaSO.GetSoSynergyProgressColor,
					setFunc = BeltalowdaSO.SetSoSynergyProgressColor,
					width = "full"
				},
				[11] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_SYNERGY,
					getFunc = BeltalowdaSO.GetSoSynergyColor,
					setFunc = BeltalowdaSO.SetSoSynergyColor,
					width = "full"
				},
				[12] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_BACKGROUND,
					getFunc = BeltalowdaSO.GetSoBackgroundColor,
					setFunc = BeltalowdaSO.SetSoBackgroundColor,
					width = "full"
				},
				[13] = {
					type = "colorpicker",
					name = BeltalowdaMenu.constants.SO_COLOR_TEXT,
					getFunc = BeltalowdaSO.GetSoTextColor,
					setFunc = BeltalowdaSO.SetSoTextColor,
					width = "full"
				},
				[14] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(1) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(1, value) end
				},
				[15] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TALONS,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(2) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(2, value) end
				},
				[16] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_NOVA,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(3) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(3, value) end
				},
				[17] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(4) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(4, value) end
				},
				[18] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_STANDARD,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(5) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(5, value) end
				},
				[19] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURGE,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(6) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(6, value) end
				},
				[20] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(7) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(7, value) end
				},
				[21] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(8) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(8, value) end
				},
				[22] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(9) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(9, value) end
				},
				[23] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(10) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(10, value) end
				},
				[24] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RADIATE,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(11) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(11, value) end
				},
				[25] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(12) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(12, value) end
				},
				[26] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(13) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(13, value) end
				},
				[27] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(14) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(14, value) end
				},
				[28] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(15) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(15, value) end
				},
				[29] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(16) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(16, value) end
				},
				[30] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(17) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(17, value) end
				},
				[31] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(18) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(18, value) end
				},
				[32] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(19) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(19, value) end
				},
				[33] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_URSUS,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(20) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(20, value) end
				},
				[34] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(21) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(21, value) end
				},
				[35] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(22) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(22, value) end
				},
				[36] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE,
					getFunc = function() return BeltalowdaSO.GetSoSynergyEnabled(23) end,
					setFunc = function(value) BeltalowdaSO.SetSoSynergyEnabled(23, value) end
				}
			}
		}
	}
	return menu
end

function BeltalowdaSO.GetSoEnabled()
	return BeltalowdaSO.soVars.enabled
end

function BeltalowdaSO.SetSoEnabled(value)
	BeltalowdaSO.SetEnabled(value, BeltalowdaSO.soVars.windowEnabled)
	BeltalowdaSO.AdjustSynergyDisplay()
end

function BeltalowdaSO.GetSoWindowEnabled()
	return BeltalowdaSO.soVars.windowEnabled
end

function BeltalowdaSO.SetSoWindowEnabled(value)
	BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, value)
	BeltalowdaSO.AdjustSynergyDisplay()
end

function BeltalowdaSO.GetSoPositionLocked()
	return BeltalowdaSO.soVars.positionLocked
end

function BeltalowdaSO.SetSoPositionLocked(value)
	BeltalowdaSO.SetPositionLocked(value)
end

function BeltalowdaSO.GetSoPvpOnly()
	return BeltalowdaSO.soVars.pvpOnly
end

function BeltalowdaSO.SetSoPvpOnly(value)
	BeltalowdaSO.soVars.pvpOnly = value
	BeltalowdaSO.SetEnabled(BeltalowdaSO.soVars.enabled, BeltalowdaSO.soVars.windowEnabled)
	BeltalowdaSO.SetControlVisibility()
end

function BeltalowdaSO.GetSoSynergyBackdropColor()
	return BeltalowdaMenu.GetRGBAColor(BeltalowdaSO.soVars.synergyBackdropColor)
end

function BeltalowdaSO.SetSoSynergyBackdropColor(r, g, b, a)
	BeltalowdaSO.soVars.synergyBackdropColor = BeltalowdaMenu.GetColorFromRGBA(r, g, b, a)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSO.GetSoSynergyProgressColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.progressColor)
end

function BeltalowdaSO.SetSoSynergyProgressColor(r, g, b)
	BeltalowdaSO.soVars.progressColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSO.GetSoTableModes()
	return BeltalowdaSO.constants.TABLE_MODES
end

function BeltalowdaSO.GetSoTableMode()
	return BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.soVars.tableMode]
end

function BeltalowdaSO.SetSoTableMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSO.constants.TABLE_MODES do
			if BeltalowdaSO.constants.TABLE_MODES[i] == value then
				BeltalowdaSO.soVars.tableMode = i
			end
		end
		BeltalowdaSO.SetControlVisibility()
	end
end

function BeltalowdaSO.GetSoDisplayModes()
	return BeltalowdaSO.constants.DISPLAY_MODES
end

function BeltalowdaSO.GetSoDisplayMode()
	return BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.soVars.displayMode]
end

function BeltalowdaSO.SetSoDisplayMode(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSO.constants.DISPLAY_MODES do
			if BeltalowdaSO.constants.DISPLAY_MODES[i] == value then
				BeltalowdaSO.soVars.displayMode = i
			end
		end
	end
end

function BeltalowdaSO.GetSoReducedSpacing()
	return BeltalowdaSO.soVars.spacing
end

function BeltalowdaSO.SetSoReducedSpacing(value)
	BeltalowdaSO.soVars.spacing = value
	BeltalowdaSO.AdjustSize()
end

function BeltalowdaSO.GetSoSize()
	return BeltalowdaSO.soVars.size
end

function BeltalowdaSO.SetSoSize(value)
	if value ~= nil and value >= BeltalowdaSO.constants.size.SMALL and value <= BeltalowdaSO.constants.size.BIG then
		BeltalowdaSO.soVars.size = value
		BeltalowdaSO.AdjustSize()
	end
end

function BeltalowdaSO.GetSoSynergyColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.synergyColor)
end

function BeltalowdaSO.SetSoSynergyColor(r, g, b)
	BeltalowdaSO.soVars.synergyColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSO.GetSoBackgroundColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.backgroundColor)
end

function BeltalowdaSO.SetSoBackgroundColor(r, g, b)
	BeltalowdaSO.soVars.backgroundColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
end

function BeltalowdaSO.GetSoTextColor()
	return BeltalowdaMenu.GetRGBColor(BeltalowdaSO.soVars.textColor)
end

function BeltalowdaSO.SetSoTextColor(r, g, b)
	BeltalowdaSO.soVars.textColor = BeltalowdaMenu.GetColorFromRGB(r, g, b)
	BeltalowdaSO.AdjustSynergyColors()
end

function BeltalowdaSO.GetSoSynergyEnabled(index)
	return BeltalowdaSO.soVars.synergyVisibility[index]
end

function BeltalowdaSO.SetSoSynergyEnabled(index, value)
	BeltalowdaSO.soVars.synergyVisibility[index] = value
	BeltalowdaSO.AdjustSynergyDisplay()
end
