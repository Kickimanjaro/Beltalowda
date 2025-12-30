-- Beltalowda - Language - de
-- By @s0rdrak (PC / EU)

local Beltalowda = _G['Beltalowda']
local BeltalowdaMenu = Beltalowda.menu
local BeltalowdaGroup = Beltalowda.group
local BeltalowdaCrown = BeltalowdaGroup.crown
local BeltalowdaAI = BeltalowdaGroup.ai
local BeltalowdaFtcv = BeltalowdaGroup.ftcv
local BeltalowdaFtcw = BeltalowdaGroup.ftcw
local BeltalowdaBeam = BeltalowdaGroup.ftcb
local BeltalowdaOverview = BeltalowdaGroup.ro
local BeltalowdaGBeam = BeltalowdaGroup.gb
local BeltalowdaHdm = BeltalowdaGroup.hdm
local BeltalowdaDt = BeltalowdaGroup.dt
local BeltalowdaIsdp = BeltalowdaGroup.isdp
local BeltalowdaCompass = Beltalowda.compass
local BeltalowdaYacs = BeltalowdaCompass.yacs
local BeltalowdaSC = BeltalowdaCompass.sc
local BeltalowdaUtil = Beltalowda.util
local BeltalowdaUtilUI = BeltalowdaUtil.ui
local BeltalowdaUltimates = BeltalowdaUtil.ultimates
local BeltalowdaNetworking = BeltalowdaUtil.networking
local BeltalowdaUtilGroup = BeltalowdaUtil.group
local BeltalowdaVersioning = BeltalowdaUtil.versioning
local BeltalowdaGMenu = BeltalowdaUtil.groupMenu
local BeltalowdaBeams = BeltalowdaUtil.beams
local BeltalowdaToolbox = Beltalowda.toolbox
local BeltalowdaSm = BeltalowdaToolbox.sm
local BeltalowdaRecharger = BeltalowdaToolbox.recharger
local BeltalowdaBft = BeltalowdaToolbox.bft
local BeltalowdaSiege = BeltalowdaToolbox.siege
local BeltalowdaCL = BeltalowdaToolbox.cl
local BeltalowdaEnhance = BeltalowdaToolbox.enhancements
local BeltalowdaRespawner = BeltalowdaToolbox.respawner
local BeltalowdaSP = BeltalowdaToolbox.sp
local BeltalowdaSO = BeltalowdaToolbox.so
local BeltalowdaAdmin = Beltalowda.admin
local BeltalowdaConfig = Beltalowda.cfg

Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.slashCmd .. " menu: Öffnet das Konfigurationsmenü"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." admin: Öffnet das Admin-Interface"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." config: Öffnet das Konfigurations-Import/Export-Interface"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." hdm clear: Löscht den Heilung und Schaden über Zeitzähler"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n/ai: enable auto invite (e.g. /ai beltalowda) - turn off with /ai"

--Tool
Beltalowda.constants = Beltalowda.constants or {}
Beltalowda.constants.MISSING_LIBRARIES = "Beltalowda benötigt noch folgende Bibliotheken: "

--Menu Constants
--Profile
BeltalowdaMenu.constants = BeltalowdaMenu.constants or {}
BeltalowdaMenu.constants.PROFILE_HEADER = "Profileinstellungen"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE = "Ausgewähltes Profil"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE_TOOLTIP = "Wähle das zu verwendende Profil aus"
BeltalowdaMenu.constants.PROFILE_NEW_PROFILE = "Neues Profil"
BeltalowdaMenu.constants.PROFILE_ADD_PROFILE = "Hinzufügen"
BeltalowdaMenu.constants.PROFILE_CLONE_PROFILE = "Kopieren"
BeltalowdaMenu.constants.PROFILE_REMOVE_PROFILE = "Entfernen"
BeltalowdaMenu.constants.PROFILE_EXISTS = "|cFF0000Das Profil existiert bereits. Bitte verwende einen anderen Namen|r"
BeltalowdaMenu.constants.PROFILE_CANT_REMOVE_DEFAULT = "|cFF0000Dieses Profil kann nicht entfernt werden|r"

--Fixed Components
BeltalowdaMenu.constants.POSITION_FIXED_SET = "Position fixieren"
BeltalowdaMenu.constants.POSITION_FIXED_UNSET = "Position freigeben"

--Donate
BeltalowdaMenu.constants.FEEDBACK = "Feedback"
BeltalowdaMenu.constants.FEEDBACK_STRING = "Bitte teile mir dein Feedback via ESO Forum oder ESOUI mit. Ich werde nicht in der Lage sein auf Mails zu reagieren."
BeltalowdaMenu.constants.DONATE = "Spenden"
BeltalowdaMenu.constants.DONATE_5K = "5'000 Gold spenden"
BeltalowdaMenu.constants.DONATE_50K = "50'000 Gold spenden"
BeltalowdaMenu.constants.DONATE_SERVER_ERROR = "Danke für den Versuch etwas zu spenden. Leider spielen wir auf unterschiedlichen Servern, wodurch dies nicht möglich ist."
BeltalowdaMenu.constants.DONATE_MAIL_SUBJECT = "Beltalowda-Spende"

--Group
BeltalowdaMenu.constants.GROUP_HEADER = "|cFF8174Gruppeneinstellungen|r"

--Crown
BeltalowdaMenu.constants.CROWN_HEADER = "|c4592FFKrone|r"
BeltalowdaMenu.constants.CROWN_CHK_GROUP_CROWN_ENABLED = "Erweiterte Krone aktiviert"
BeltalowdaMenu.constants.CROWN_SELECTED_MODE = "Kronenmode"
BeltalowdaMenu.constants.CROWN_MODE = {}
BeltalowdaMenu.constants.CROWN_MODE[1] = "Pin"
BeltalowdaMenu.constants.CROWN_SELECTED_CROWN = "Ausgewählte Krone"
BeltalowdaMenu.constants.CROWN_SIZE = "Größe"
BeltalowdaMenu.constants.CROWN_WARNING = "|cFF0000Es kann nur 1 AddOn diese Funktionalität implementieren. Falls 2 Addons diese verwenden, wird das Spiel abstürzen!|r"
BeltalowdaMenu.constants.CROWN_PVP_ONLY = "PvP Only"

--Auto Invite
BeltalowdaMenu.constants.AI_HEADER = "|c4592FFAuto Invite|r"
BeltalowdaMenu.constants.AI_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.AI_INVITE_TEXT = "Invite-Text"
BeltalowdaMenu.constants.AI_GROUP_SIZE = "Maximale Gruppengröße"
BeltalowdaMenu.constants.AI_PVP_CHECK = "PvP Only"
BeltalowdaMenu.constants.AI_SEND_CHAT_MESSAGES = "Sende Chatnachrichten"
BeltalowdaMenu.constants.AI_AUTO_KICK = "Auto Kick"
BeltalowdaMenu.constants.AI_AUTO_KICK_TIME = "Auto Kick-Intervall"
BeltalowdaMenu.constants.AI_CHAT = "Erlaubte Chats"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS = "Einschränkung der Spieler"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_TOOLTIP = "Definiert die Einschränkung, anhand der Auto Invite ausgelöst wird."
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD = "Gilde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD_FRIEND = "Gilde und Freunde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_FRIEND = "Freunde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD = "Spezifische Gilde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD_FRIEND = "Spezifische Gilde und Freunde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_NONE = "Keine"
BeltalowdaMenu.constants.AI_SHOW_MEMBER_LEFT = "Zeige alle Verlassen-Nachrichten"

--Follow The Crown Visual
BeltalowdaMenu.constants.FTCV_HEADER = "|c4592FFFollow The Crown - Pfeil|r"
BeltalowdaMenu.constants.FTCV_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.FTCV_MODE = "Modus"
BeltalowdaMenu.constants.FTCV_COLOR_MODE = "Farbmodus"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_ORIENTATION = "Ausrichtung (vorne, Seite, hinten)"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_DISTANCE = "Entfernung (nahe, fern)"
BeltalowdaMenu.constants.FTCV_COLOR_FRONT = "Farbe 1 (vorne / nahe)"
BeltalowdaMenu.constants.FTCV_COLOR_SIDE = "Farbe 2 (Seite)"
BeltalowdaMenu.constants.FTCV_COLOR_BACK = "Farbe 3 (hinten / fern)"
BeltalowdaMenu.constants.FTCV_OPACITY_CLOSE = "Distanzdurchsichtigkeit nahe"
BeltalowdaMenu.constants.FTCV_OPACITY_FAR = "Distanzdurchsichtigkeit fern"
BeltalowdaMenu.constants.FTCV_SIZE_CLOSE = "Größe nahe"
BeltalowdaMenu.constants.FTCV_SIZE_FAR = "Größe fern"
BeltalowdaMenu.constants.FTCV_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCV_MODE_RETICLE = "Fadenkreuz"
BeltalowdaMenu.constants.FTCV_MODE_FIXED = "Fixiert"
BeltalowdaMenu.constants.FTCV_POSITION = "Position"
BeltalowdaMenu.constants.FTCV_MAX_DISTANCE = "Maximal erlaubte Distanz"
BeltalowdaMenu.constants.FTCV_MIN_DISTANCE = "Minimale Distanz"
BeltalowdaMenu.constants.FTCV_TEXTURES = "Textur"

--Follow The Crown Warnings
BeltalowdaMenu.constants.FTCW_HEADER = "|c4592FFFollow The Crown - Warnungen|r"
BeltalowdaMenu.constants.FTCW_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.FTCW_WARNINGS_ENABLED = "Warnungen aktiviert"
BeltalowdaMenu.constants.FTCW_DISTANCE_ENABLED = "Distanz aktiviert"
BeltalowdaMenu.constants.FTCW_DISTANCE_BACKDROP_ENABLED = "Distanzhintergrund aktiviert"
BeltalowdaMenu.constants.FTCW_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.FTCW_DISTANCE = "Maximal erlaubte Distanz"
BeltalowdaMenu.constants.FTCW_IGNORE_DISTANCE = "Distanzdeaktivierung"
BeltalowdaMenu.constants.FTCW_WARNING_COLOR = "Warnungsfarbe"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_NORMAL = "Distanzfarbe für Normal"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_ALERT = "Distanzfarbe für Alarm"
BeltalowdaMenu.constants.FTCW_PVP_ONLY = "PvP Only"

--Follow The Crown Audio
BeltalowdaMenu.constants.FTCA_HEADER = "|c4592FFFollow The Crown - Audio|r"
BeltalowdaMenu.constants.FTCA_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.FTCA_DISTANCE = "Maximal erlaubte Distanz"
BeltalowdaMenu.constants.FTCA_IGNORE_DISTANCE = "Distanzdeaktivierung"
BeltalowdaMenu.constants.FTCA_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCA_UNMOUNTED_ONLY = "Nur ohne Reittier"
BeltalowdaMenu.constants.FTCA_SOUND = "Audio"
BeltalowdaMenu.constants.FTCA_INTERVAL = "Intervall"
BeltalowdaMenu.constants.FTCA_THRESHOLD = "Schwellwert"

--Follow The Crown Beam
BeltalowdaMenu.constants.FTCB_HEADER = "|c4592FFFollow The Crown - Strahl|r"
BeltalowdaMenu.constants.FTCB_WARNING = "|cFF0000Sub Sampling-Qualität muss auf Hoch sein. Ansonsten funktioniert dieses Modul nicht richtig.|r"
BeltalowdaMenu.constants.FTCB_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.FTCB_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.FTCB_SELECTED_BEAM = "Selektierter Strahl"
BeltalowdaMenu.constants.FTCB_COLOR = "Farbe"

--Debuff Overview
BeltalowdaMenu.constants.DBO_HEADER = "|c4592FFDebuff-Übersicht|r"
BeltalowdaMenu.constants.DBO_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.DBO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.DBO_CRITICAL_AMOUNT = "Kritische Anzahl der Debuffs"
BeltalowdaMenu.constants.DBO_COLOR_OKAY = "Farbe okay [0]"
BeltalowdaMenu.constants.DBO_COLOR_NOT_OKAY = "Farbe nicht okay [1]"
BeltalowdaMenu.constants.DBO_COLOR_CRITICAL = "Farbe kritisch"
BeltalowdaMenu.constants.DBO_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.DBO_COLOR_OUT_OF_RANGE = "Farbe außer Reichweite"
BeltalowdaMenu.constants.DBO_DESCRIPTION = "Dieses Modul verwendet die Map Pins anderer Module (Ressourcenübersicht, Synergieübersicht, Heilung und Schaden über Zeit). Die besten Resultate werden mit der Resourcenübersicht erzielt."
BeltalowdaMenu.constants.DBO_SIZE = "Größe"

--Rapid Tracker
BeltalowdaMenu.constants.RT_HEADER = "|c4592FFRapid-Übersicht|r"
BeltalowdaMenu.constants.RT_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.RT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.RT_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.RT_COLOR_LABEL_IN_RANGE = "Farbname in Reichweite"
BeltalowdaMenu.constants.RT_COLOR_LABEL_NOT_IN_RANGE = "Farbname wenn außer Reichweite"
BeltalowdaMenu.constants.RT_COLOR_LABEL_OUT_OF_RANGE = "Farbname wenn AFK"
BeltalowdaMenu.constants.RT_COLOR_RAPID_ON = "Farbe für Rapid aktiv"
BeltalowdaMenu.constants.RT_COLOR_RAPID_OFF = "Farbe für Rapid inaktiv"

--Resource Overview
BeltalowdaMenu.constants.RO_HEADER_ULTIMATES = "|c4592FFRessourcenübersicht - Kombiniert|r"
BeltalowdaMenu.constants.RO_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.RO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.RO_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED = "Ultimate-Gruppenübersicht aktiviert"
BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED = "Eigenes Fenster aktiviert"
BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED = "Gruppenfenster aktiviert"
BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES = "Zeige Stamina / Magicka an"
BeltalowdaMenu.constants.RO_DISPLAYED_ULTIMATES = "Eingeblendete Anzahl der Ultimates"
BeltalowdaMenu.constants.RO_COLOR_BACKGROUND = "Ressourcen-Hintergrundfarbe"
BeltalowdaMenu.constants.RO_COLOR_MAGICKA = "Ressourcen-Magickafarbe"
BeltalowdaMenu.constants.RO_COLOR_STAMINA = "Ressourcen-Staminafarbe"
BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE = "Ressourcen-Reichweitenfarbe"
BeltalowdaMenu.constants.RO_COLOR_DEAD = "Ressourcen-Todesfarbe"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL = "Ressourcen-nicht-voll-Farbe"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL = "Ressourcen-voll-Farbe"
BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL = "Ressourcen-Beschriftungsfarbe \"voll\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL = "Ressourcen-Beschriftungsfarbe \"nicht voll\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP = "Ressourcen-Beschriftungsfarbe \"Gruppe\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT = "Ankündigungsfarbe"
BeltalowdaMenu.constants.RO_ANNOUNCEMENT_SIZE = "Ankündigungsgröße"
BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED = "Kampfstatus anzeigen"
BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR = "Farbe im Kampf"
BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR = "Farbe außerhalb des Kampfs"
BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED = "Stealth-Status anzeigen"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED = "Ultimate-Gruppen aktiviert"
BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE = "Sortierungsmodus"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_DESTRO = "Zerstörungsstab-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_STORM = "Sturm-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NORTHERNSTORM = "Nordsturm-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_PERMAFROST = "Permafrost-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE = "Magienegation-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_OFFENSIVE = "Magienegation-off-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_COUNTER = "Magienegation-Counter-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NOVA = "Nova-Gruppengröße"
BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE = "Anzeigemodus"
BeltalowdaMenu.constants.RO_MAX_DISTANCE = "Max Distanz"
BeltalowdaMenu.constants.RO_SOUND_ENABLED = "Sound aktiviert"
BeltalowdaMenu.constants.RO_SELECTED_SOUND = "Ausgewählter Sound"
BeltalowdaMenu.constants.RO_HEADER_GROUPS = "|c4592FFRessourcenübersicht - Geteilt|r"
BeltalowdaMenu.constants.RO_GROUPS_ENABLED = "Gruppen aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_MODE = "Modus"
BeltalowdaMenu.constants.RO_GROUPS_1_NAME = "Gruppe 1 Name"
BeltalowdaMenu.constants.RO_GROUPS_2_NAME = "Gruppe 2 Name"
BeltalowdaMenu.constants.RO_GROUPS_3_NAME = "Gruppe 3 Name"
BeltalowdaMenu.constants.RO_GROUPS_4_NAME = "Gruppe 4 Name"
BeltalowdaMenu.constants.RO_GROUPS_5_NAME = "Gruppe 5 Name"
BeltalowdaMenu.constants.RO_GROUPS_1_ENABLED = "Gruppe 1 aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_2_ENABLED = "Gruppe 2 aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_3_ENABLED = "Gruppe 3 aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_4_ENABLED = "Gruppe 4 aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_5_ENABLED = "Gruppe 5 aktiviert"
BeltalowdaMenu.constants.RO_GROUPS_1_DEFAULT = "Schaden"
BeltalowdaMenu.constants.RO_GROUPS_2_DEFAULT = "Unterstützung"
BeltalowdaMenu.constants.RO_GROUPS_3_DEFAULT = "Heilung"
BeltalowdaMenu.constants.RO_GROUPS_4_DEFAULT = "Synergie"
BeltalowdaMenu.constants.RO_GROUPS_5_DEFAULT = "Undefiniert"
BeltalowdaMenu.constants.RO_GROUPS_PRIORITY = "-Priorität:"
BeltalowdaMenu.constants.RO_GROUPS_GROUP = "-Gruppe:"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_OUT_OF_COMBAT = "Rand außerhalb vom Kampf"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_IN_COMBAT = "Rand innerhalb des Kampfs"
BeltalowdaMenu.constants.RO_SIZE = "Größe"
BeltalowdaMenu.constants.RO_SPACING = "Abstand"
BeltalowdaMenu.constants.RO_SHARED_SETTING = "Diese Einstellung gilt sowohl für die kombinierte als auch für geteilte Ressourcenübersicht."

--HP Damage Meter
BeltalowdaMenu.constants.HDM_HEADER = "|c4592FFHeilung und Schaden über Zeit|r"
BeltalowdaMenu.constants.HDM_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.HDM_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.HDM_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.HDM_WINDOW_ENABLED = "Fenster aktiviert"
BeltalowdaMenu.constants.HDM_USING_ALPHA = "Benutze Alpha"
BeltalowdaMenu.constants.HDM_USING_COLORS = "Hintergrundfarben"
BeltalowdaMenu.constants.HDM_USING_HIGHLIGHT_APPLICANT = "Hervorheben von Bewerbern"
BeltalowdaMenu.constants.HDM_AUTO_RESET = "Zähler automatisch zurücksetzen"
BeltalowdaMenu.constants.HDM_SELECTED_VIEWMODE = "Ausgewählter Modus"
BeltalowdaMenu.constants.HDM_ALIVE_COLOR = "Farbe lebend"
BeltalowdaMenu.constants.HDM_DEAD_COLOR = "Farbe tot"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_HEALER = "Heiler-Hintergrundfarbe"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_DD = "DD-Hintergrundfarbe"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_TANK = "Tank-Hintergrundfarbe "
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_APPLICANT = "Bewerber-Hintergrundfarbe"
BeltalowdaMenu.constants.HDM_SIZE = "Größe"

--Potion Overview
BeltalowdaMenu.constants.PO_HEADER = "|c4592FFTränkeübersicht|r"
BeltalowdaMenu.constants.PO_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.PO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.PO_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_NO_IMMOVABLE = "Beweglich-Hintergrundfarbe:"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_FULL = "Voll-unbeweglich-Hintergrundfarbe"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_LOW = "Leer-unbeweglich-Hintergrundfarbe"
BeltalowdaMenu.constants.PO_COLOR_PROGRESS_IMMOVABLE = "Unbeweglich-Fortschrittsfarbe"
-- U30+ Change (Temporary Fix)
--[[
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Crafted-Trank-Fortschrittsfarbe"
BeltalowdaMenu.constants.PO_COLOR_CROWN_PROGRESS_POTION = "Kronentrank-Fortschrittsfarbe"
BeltalowdaMenu.constants.PO_COLOR_NON_CRAFTED_PROGRESS_POTION = "Nicht-gecrafted-Trank-Fortschrittsfarbe"
BeltalowdaMenu.constants.PO_COLOR_ALLIANZ_PROGRESS_POTION = "Trank-Fortschrittsfarbe (Allianz)"
]]
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Trank-Fortschrittsfarbe"
BeltalowdaMenu.constants.PO_COLOR_LABEL_IMMOVABLE = "Unbeweglich-Beschriftungsfarbe"
BeltalowdaMenu.constants.PO_COLOR_LABEL_POTION = "Trank-Beschriftungsfarbe"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_IMMOVABLE = "Unbeweglich-Hintergrundfarbe"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_POTION = "Trank-Hintergrundfarbe"
BeltalowdaMenu.constants.PO_SOUND_ENABLED = "Sound aktiviert"
BeltalowdaMenu.constants.PO_SELECTED_SOUND = "Ausgewählter Sound"

--Detonation Tracker
BeltalowdaMenu.constants.DT_HEADER = "|c4592FFDetonation / Käfer Tracker|r"
BeltalowdaMenu.constants.DT_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.DT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.DT_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION = "Detonation: Schriftfarbe"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION = "Detonation: Hintergrundfarbe"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT = "Unt Ansturm: Schriftfarbe"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT = "Unt Ansturm: Hintergrundfarbe"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2 = "Unt Ansturm 2: Schriftfarbe"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2 = "Unt Ansturm 2: Hintergrundfarbe"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE = "Tiefer Riss: Schriftfarbe"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE = "Tiefer Riss: Hintergrundfarbe"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2 = "Tiefer Riss 2: Schriftfarbe"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2 = "Tiefer Riss 2: Hintergrundfarbe"
BeltalowdaMenu.constants.DT_SIZE = "Größe"
BeltalowdaMenu.constants.DT_MODE = "Modus"
BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION = "Weicher Übergang"

--Group Beams
BeltalowdaMenu.constants.GB_HEADER = "|c4592FFStrahlen - Gruppenmitglieder|r"
BeltalowdaMenu.constants.GB_DESCRIPTION = "Welcher Strahl bei einem Spieler angezeigt wird, hängt von seiner Rolle ab, die er sich entweder unter Rollenzuteilung zuweist oder ihm vom Leiter im Gruppenfenster zugewiesen wird."
BeltalowdaMenu.constants.GB_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.GB_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.GB_HIDE_WHEN_DEAD = "Verbergen wenn tot"
BeltalowdaMenu.constants.GB_SIZE = "Größe"
BeltalowdaMenu.constants.GB_SELECTED_BEAM = "Selektierter Strahl"
BeltalowdaMenu.constants.GB_ROLE_RAPID_ENABLED = "Rapid aktiviert"
BeltalowdaMenu.constants.GB_ROLE_RAPID_COLOR = "Rapid-Farbe"
BeltalowdaMenu.constants.GB_ROLE_PURGE_ENABLED = "Purge aktiviert"
BeltalowdaMenu.constants.GB_ROLE_PURGE_COLOR = "Purge-Farbe"
BeltalowdaMenu.constants.GB_ROLE_HEAL_ENABLED = "Heiler aktiviert"
BeltalowdaMenu.constants.GB_ROLE_HEAL_COLOR = "Heilerfarbe"
BeltalowdaMenu.constants.GB_ROLE_DD_ENABLED = "DD aktiviert"
BeltalowdaMenu.constants.GB_ROLE_DD_COLOR = "DD-Farbe"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_ENABLED = "Synergie aktiviert"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_COLOR = "Synergiefarbe"
BeltalowdaMenu.constants.GB_ROLE_CC_ENABLED = "CC aktiviert"
BeltalowdaMenu.constants.GB_ROLE_CC_COLOR = "CC-Farbe"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_ENABLED = "Support aktiviert"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_COLOR = "Support-Farbe"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_ENABLED = "Undefiniert aktiviert"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_COLOR = "Undefiniertfarbe"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_ENABLED = "Bewerber aktiviert"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_COLOR = "Bewerberfarbe"

--I See Dead People
BeltalowdaMenu.constants.ISDP_HEADER = "|c4592FFIch sehe tote Menschen|r"
BeltalowdaMenu.constants.ISDP_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.ISDP_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.ISDP_SIZE = "Größe"
BeltalowdaMenu.constants.ISDP_SELECTED_BEAM = "Selektierter Strahl"
BeltalowdaMenu.constants.ISDP_COLOR_DEAD = "Farbe wenn tot"
BeltalowdaMenu.constants.ISDP_COLOR_BEING_RESURRECTED = "Farbe beim Wiederbeleben"
BeltalowdaMenu.constants.ISDP_COLOR_RESURRECTED = "Farbe wenn wiederbelebt"

--Compass
BeltalowdaMenu.constants.COMPASS_HEADER = "|cFF8174Kompasseinstellungen|r"
--YACS
BeltalowdaMenu.constants.YACS_HEADER = "|c4592FFYet Another Compass|r"
BeltalowdaMenu.constants.YACS_CHK_ADDON_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.YACS_CHK_PVP = "Aktiviert im PVP"
BeltalowdaMenu.constants.YACS_CHK_PVE = "Aktiviert im PVE"
BeltalowdaMenu.constants.YACS_CHK_COMBAT = "Aktiviert im Kampf"
BeltalowdaMenu.constants.YACS_CHK_MOVABLE = "Bewegbaren Kompass"
BeltalowdaMenu.constants.YACS_COLOR_COMPASS = "Kompassfarbe"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE = "Kompassgröße"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE_TOOLTIPE = "Setzt die Größe des Kompass."
BeltalowdaMenu.constants.YACS_COMPASS_STYLE = "Stil"
BeltalowdaMenu.constants.YACS_COMPASS_STYLE_TOOLTIP = "Wähle den Kompassstil aus."
BeltalowdaMenu.constants.YACS_RESTORE_DEFAULTS = "Wiederherstellen"

--SC
BeltalowdaMenu.constants.COMPASS_SC_HEADER = "|c4592FFSimple Compass|r"
BeltalowdaMenu.constants.COMPASS_SC_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.COMPASS_SC_PVP = "Aktiviert im PVP"
BeltalowdaMenu.constants.COMPASS_SC_PVE = "Aktiviert im PVE"
BeltalowdaMenu.constants.COMPASS_SC_POSITION_FIXED = "Position Fixiert"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_BACKDROP = "Hintergrundfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_NORTH = "Nordfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_SOUTH = "Südfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_WEST = "Westfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_EAST = "Ostfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_OTHERS = "Zwischenfarbe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_MARKERS = "Markierungsfarbe"

--Toolbox
BeltalowdaMenu.constants.TOOLBOX_HEADER = "|cFF8174Werkzeugeinstellungen|r"
--Siege Merchant
BeltalowdaMenu.constants.SM_HEADER = "|c4592FFBelagerungshändler|r"
BeltalowdaMenu.constants.SM_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.SM_SEND_CHAT_MESSAGES = "Sende Chatnachrichten"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_WALL = "Reparaturmaterial für Mauern"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_DOOR = "Reparaturmaterial für Tore"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_SIEGE = "Reparaturmaterial für Belagerungswaffen"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_FIRE = "Feuerballiste"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_STONE = "Balliste"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_LIGHTNING = "Blitzschlagballiste"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_FIRE = "Feuertopftribok"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_STONE = "Steintribok"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_ICE = "Eiskugeltribok"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_MEATBAG = "Fleischsackkatapult"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_OIL = "Ölkatapult"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_SCATTERSHOT = "Streuschusskatapult"
BeltalowdaMenu.constants.SM_ITEM_OIL = "Brandöl"
BeltalowdaMenu.constants.SM_ITEM_CAMP = "Feldlager"
BeltalowdaMenu.constants.SM_ITEM_RAM = "Rammbock"
BeltalowdaMenu.constants.SM_ITEM_KEEP_RECALL = "Burgrückrufstein"
BeltalowdaMenu.constants.SM_ITEM_DESTRUCTIBLE_REPAIR = "Bridge/Milegate-Reparaturmaterial"
BeltalowdaMenu.constants.SM_MIN = "Mindestens"
BeltalowdaMenu.constants.SM_MAX = "Maximal"
BeltalowdaMenu.constants.SM_PAYMENT_OPTIONS = "Zahlungsart"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_ALL = "Reparaturmaterial für Cyrodiil"
BeltalowdaMenu.constants.SM_ITEM_POT_RED = "Allianz-Lebenstrunk"
BeltalowdaMenu.constants.SM_ITEM_POT_GREEN = "Allianz-Kampftrunk"
BeltalowdaMenu.constants.SM_ITEM_POT_BLUE = "Allianz-Magietrunk"

--Recharger
BeltalowdaMenu.constants.RECHARGER_HEADER = "|c4592FFRecharger - Seelensteine|r"
BeltalowdaMenu.constants.RECHARGER_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.RECHARGER_SEND_CHAT_MESSAGES = "Sende Chatnachrichten"
BeltalowdaMenu.constants.RECHARGER_PERCENT = "Minimale Aufladung auf der Waffe in %"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_WARNING = "Keine-Seelensteine-Warnung"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_WARNING = "Bald-keine-Seelensteine-Warnung"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_SLIDER = "Seelenstein-Schwellwert"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_LOGIN_WARNING = "Seelenstein-Login-Warnung"
BeltalowdaMenu.constants.RECHARGER_INTERVAL = "Prüfintervall"

--Keep Claimer
BeltalowdaMenu.constants.KC_HEADER = "|c4592FFKeep Claimer|r"
BeltalowdaMenu.constants.KC_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.KC_GUILD_1 = "Priorität 1"
BeltalowdaMenu.constants.KC_GUILD_2 = "Priorität 2"
BeltalowdaMenu.constants.KC_GUILD_3 = "Priorität 3"
BeltalowdaMenu.constants.KC_GUILD_4 = "Priorität 4"
BeltalowdaMenu.constants.KC_GUILD_5 = "Priorität 5"
BeltalowdaMenu.constants.KC_CLAIM_KEEPS = "Burgen beanspruchen"
BeltalowdaMenu.constants.KC_CLAIM_OUTPOSTS = "Außenposten beanspruchen"
BeltalowdaMenu.constants.KC_CLAIM_RESOURCES = "Ressourcen beanspruchen"

--Buff Food Tracker
BeltalowdaMenu.constants.BFT_HEADER = "|c4592FFBuff Food Tracker|r"
BeltalowdaMenu.constants.BFT_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.BFT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.BFT_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.BFT_SIZE = "Warnungsgröße"
BeltalowdaMenu.constants.BFT_COLOR = "Warnungsfarbe"
BeltalowdaMenu.constants.BFT_SOUND_ENABLED = "Sound aktiviert"
BeltalowdaMenu.constants.BFT_SELECTED_SOUND = "Ausgewählter Sound"
BeltalowdaMenu.constants.BFT_WARNING_TIMER = "Timer für Warnung"

--Cyrodiil Log
BeltalowdaMenu.constants.CL_HEADER = "|c4592FFCyrodiil-Log|r"
BeltalowdaMenu.constants.CL_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.CL_GUILD_CLAIM_ENABLED = "Nachrichten wenn beansprucht"
BeltalowdaMenu.constants.CL_GUILD_LOST_ENABLED = "Nachrichten wenn nicht beansprucht"
BeltalowdaMenu.constants.CL_UA_ENABLED = "Nachrichten bei Angriff"
BeltalowdaMenu.constants.CL_UA_LOST_ENABLED = "Nachrichten wenn Angriff vorbei"
BeltalowdaMenu.constants.CL_KEEP_ALLIANCE_CHANGED_ENABLED = "Allianzwechsel-Nachrichten"
BeltalowdaMenu.constants.CL_TICK_DEFENSE = "Defense-Tick-Nachrichten"
BeltalowdaMenu.constants.CL_TICK_OFFENSE = "Offense-Tick-Nachrichten"
BeltalowdaMenu.constants.CL_SCROLL_NOTIFICATIONS = "Schriftrollen-Nachrichten"
BeltalowdaMenu.constants.CL_EMPEROR_ENABLED = "Kaiser-Nachrichten"
BeltalowdaMenu.constants.CL_QUEST_ENABLED = "Quest-Nachrichten"
BeltalowdaMenu.constants.CL_BATTLEGROUND_ENABLED = "Schlachtfelder-Nachrichten"
BeltalowdaMenu.constants.CL_DAEDRIC_ARTIFACT_ENABLED = "Daedrische-Artefakt-Nachrichten"

--Cyrodiil Status
BeltalowdaMenu.constants.CS_HEADER = "|c4592FFCyrodiilstatus|r"
BeltalowdaMenu.constants.CS_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.CS_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.CS_HIDE_ON_WORLDMAP = "Auf Weltkarte unsichtbar"
BeltalowdaMenu.constants.CS_SHOW_FLAGS = "Zeige Flaggen"
BeltalowdaMenu.constants.CS_SHOW_SIEGES = "Zeige Belagerungen"
BeltalowdaMenu.constants.CS_SHOW_OWNER_CHANGES = "Zeige Burgendrehzeit"
BeltalowdaMenu.constants.CS_SHOW_ACTION_TIMERS = "Zeige Zeit"
BeltalowdaMenu.constants.CS_COLOR_DEFAULT = "Standardfarbe"
BeltalowdaMenu.constants.CS_COLOR_COOLDOWN = "Abklingfarbe"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_POSITIVE = "Positive Flaggendrehfarbe"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_NEGATIVE = "Negative Flaggendrehfarbe"
BeltalowdaMenu.constants.CS_SHOW_KEEPS = "Zeige Burgen"
BeltalowdaMenu.constants.CS_SHOW_OUTPOSTS = "Zeige Außenposten"
BeltalowdaMenu.constants.CS_SHOW_RESOURCES = "Zeige Ressourcen"
BeltalowdaMenu.constants.CS_SHOW_VILLAGES = "Zeige Dörfer"
BeltalowdaMenu.constants.CS_SHOW_TEMPLES = "Zeige Temple"
BeltalowdaMenu.constants.CS_SHOW_DESTRUCTIBLES = "Zeige Zerstörbares"

--Enhancements
BeltalowdaMenu.constants.ENHANCE_HEADER = "|c4592FFDiverses|r"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_ENABLED = "Quest Tracker deaktiviert"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_PVP_ONLY = "Quest Tracker PvP Only"
BeltalowdaMenu.constants.ENHANCE_COMPASS_TWEAKS_ENABLED = "Kompassverbesserungen aktiviert"
BeltalowdaMenu.constants.ENHANCE_COMPASS_PVP_ONLY = "Kompass PvP Only"
BeltalowdaMenu.constants.ENHANCE_COMPASS_HIDDEN = "Kompass unsichtbar"
BeltalowdaMenu.constants.ENHANCE_COMPASS_WIDTH = "Kompasslänge"
BeltalowdaMenu.constants.ENHANCE_ALERTS_TWEAKS_ENABLED = "Alerts-Erweiterung aktiviert"
BeltalowdaMenu.constants.ENHANCE_ALERTS_PVP_ONLY = "Alerts PvP Only"
BeltalowdaMenu.constants.ENHANCE_ALERTS_HIDDEN = "Alerts unsichtbar"
BeltalowdaMenu.constants.ENHANCE_ALERTS_POSITION = "Alerts-Position"
BeltalowdaMenu.constants.ENHANCE_ALERTS_COLOR = "Alerts-Farbe"
BeltalowdaMenu.constants.ENHANCE_RESPAWN_TIMER_ENABLED = "Respawn Timer aktiviert"

--Respawner
BeltalowdaMenu.constants.RESPAWNER_HEADER = "|c4592FFRespawner|r"
BeltalowdaMenu.constants.RESPAWNER_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.RESPAWNER_RESTRICTED_PORT = "Begrenzte Reichweite"

--Camp Preview
BeltalowdaMenu.constants.CP_HEADER = "|c4592FFZeltvorschau|r"
BeltalowdaMenu.constants.CP_ENABLED = "Aktiviert"

--Synergy Prevention
BeltalowdaMenu.constants.SP_HEADER = "|c4592FFSynergieunterdrückung|r"
BeltalowdaMenu.constants.SP_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.SP_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.SP_WINDOW_ENABLED = "Fenster aktiviert"
BeltalowdaMenu.constants.SP_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.SP_MODE = "Modus"
BeltalowdaMenu.constants.SP_MAX_DISTANCE = "Maximale Distanz"
BeltalowdaMenu.constants.SP_SYNERGY_COMBUSTION_SHARD = "Verhindere Combustion / Scherben"
BeltalowdaMenu.constants.SP_SYNERGY_TALONS = "Verhindere Entzünden"
BeltalowdaMenu.constants.SP_SYNERGY_NOVA = "Verhindere Nova"
BeltalowdaMenu.constants.SP_SYNERGY_BLOOD_ALTAR = "Verhindere Altar"
BeltalowdaMenu.constants.SP_SYNERGY_STANDARD = "Verhindere Standarte"
BeltalowdaMenu.constants.SP_SYNERGY_PURGE = "Verhindere Ritual"
BeltalowdaMenu.constants.SP_SYNERGY_BONE_SHIELD = "Verhindere Knochenschild"
BeltalowdaMenu.constants.SP_SYNERGY_FLOOD_CONDUIT = "Verhindere Ableiten"
BeltalowdaMenu.constants.SP_SYNERGY_ATRONACH = "Verhindere Atronachen"
BeltalowdaMenu.constants.SP_SYNERGY_TRAPPING_WEBS = "Verhindere Spinnenbrut"
BeltalowdaMenu.constants.SP_SYNERGY_RADIATE = "Verhindere Strahlung"
BeltalowdaMenu.constants.SP_SYNERGY_CONSUMING_DARKNESS = "Verhindere Consuming Darkness"
BeltalowdaMenu.constants.SP_SYNERGY_SOUL_LEECH = "Verhindere Seelenentzug"
BeltalowdaMenu.constants.SP_SYNERGY_WARDEN_HEALING = "Verhindere Heilende Saat"
BeltalowdaMenu.constants.SP_SYNERGY_GRAVE_ROBBER = "Verhindere Grabräuber"
BeltalowdaMenu.constants.SP_SYNERGY_PURE_AGONY = "Verhindere Reine Qual"
BeltalowdaMenu.constants.SP_SYNERGY_ICY_ESCAPE = "Verhindere eisige Flucht"
BeltalowdaMenu.constants.SP_SYNERGY_SANGUINE_BURST = "Verhindere sanguine Explosion"
BeltalowdaMenu.constants.SP_SYNERGY_HEED_THE_CALL = "Verhindere Erhört den Ruf"
BeltalowdaMenu.constants.SP_SYNERGY_URSUS = "Verhindere Schild von Ursus"
BeltalowdaMenu.constants.SP_SYNERGY_GRYPHON = "Verhindere Vergeltung des Greifen"
BeltalowdaMenu.constants.SP_SYNERGY_RUNEBREAK = "Verhindere Runenbrechen"
BeltalowdaMenu.constants.SP_SYNERGY_PASSAGE = "Verhindere Übergang"

--Synergy Overview
BeltalowdaMenu.constants.SO_HEADER = "|c4592FFSynergieübersicht|r"
BeltalowdaMenu.constants.SO_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.SO_WINDOW_ENABLED = "Fenster aktiviert"
BeltalowdaMenu.constants.SO_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.SO_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.SO_DISPLAY_MODE = "Anzeigemodus"
BeltalowdaMenu.constants.SO_TABLE_MODE = "Tabellenmodus"
BeltalowdaMenu.constants.SO_SIZE = "Größe"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP = "Synergie-Hintergrundsfarbe"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS = "Synergie-Fortschrittsfarbe"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY = "Synergiefarbe"
BeltalowdaMenu.constants.SO_COLOR_BACKGROUND = "Hintergrundfarbe"
BeltalowdaMenu.constants.SO_COLOR_TEXT = "Textfarbe"
BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD = "Zeige Combustion / Scherben"
BeltalowdaMenu.constants.SO_SYNERGY_TALONS = "Zeige Entzünden"
BeltalowdaMenu.constants.SO_SYNERGY_NOVA = "Zeige Nova"
BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR = "Zeige Altar"
BeltalowdaMenu.constants.SO_SYNERGY_STANDARD = "Zeige Standarte"
BeltalowdaMenu.constants.SO_SYNERGY_PURGE = "Zeige Ritual"
BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD = "Zeige Knochenschild"
BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT = "Zeige Ableiten"
BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH = "Zeige Atronachen"
BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS = "Zeige Spinnenbrut"
BeltalowdaMenu.constants.SO_SYNERGY_RADIATE = "Zeige Strahlung"
BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS = "Zeige Consuming Darkness"
BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH = "Zeige Seelenentzug"
BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING = "Zeige Heilende Saat"
BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER = "Zeige Grabräuber"
BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY = "Zeige Reine Qual"
BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE = "Zeige eisige Flucht"
BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST = "Zeige sanguine Explosion"
BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL = "Zeige Erhört den Ruf"
BeltalowdaMenu.constants.SO_SYNERGY_URSUS = "Zeige Schild von Ursus"
BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON = "Zeige Vergeltung des Greifen"
BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK = "Zeige Runenbrechen"
BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE = "Zeige Übergang"
BeltalowdaMenu.constants.SO_REDUCED_SPACING = "Reduziert Abstand"

--Role Assignment
BeltalowdaMenu.constants.RA_HEADER = "|c4592FFRollenzuteilung|r"
BeltalowdaMenu.constants.RA_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.RA_OVERRIDE_ALLOWED = "Überschreiben erlaubt"
BeltalowdaMenu.constants.RA_ROLE = "Charakterrolle"

--Campaign Joiner
BeltalowdaMenu.constants.CAJ_HEADER = "|c4592FFCampaign Auto Join|r"
BeltalowdaMenu.constants.CAJ_ENABLED = "Aktiviert"

--AvA Messages
BeltalowdaMenu.constants.AM_HEADER = "|c4592FFAvA-Nachrichten|r"
BeltalowdaMenu.constants.AM_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.AM_CORONATE_EMPEROR = "Kaiser-gekrönt-Nachrichten"
BeltalowdaMenu.constants.AM_DEPOSE_EMPEROR = "Kaiser-entthront-Nachrichten"
BeltalowdaMenu.constants.AM_KEEP_GATE = "Tor-Nachrichten"
BeltalowdaMenu.constants.AM_ARTIFACT_CONTROL = "Artefakt-Nachrichten"
BeltalowdaMenu.constants.AM_REVENGE_KILL = "Revanche-Nachrichten"
BeltalowdaMenu.constants.AM_AVENGE_KILL = "Rächen-Nachrichten"
BeltalowdaMenu.constants.AM_QUEST_ADDED = "Quest-hinzugefügt-Nachrichten"
BeltalowdaMenu.constants.AM_QUEST_COMPLETE = "Quest-abgeschlossen-Nachrichten"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_COUNTER_CHANGED = "Quest-Zähler-Nachrichten"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_CHANGED = "Quest-Kondition-Nachrichten"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED = "Erscheinen-Nachrichten für daedrisches Artefakt"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED = "Statusnachrichten für daedrisches Artefakt"

--Util
BeltalowdaMenu.constants.UTIL_HEADER = "|cFF8174Util-Einstellungen|r"

--Util Networking
BeltalowdaMenu.constants.NET_HEADER = "|c4592FFNetworking|r"
BeltalowdaMenu.constants.NET_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.NET_URGENT_MODE = "Urgent-Modus"
BeltalowdaMenu.constants.NET_INTERVAL = "Update-Intervall"

--Util Group
BeltalowdaMenu.constants.UTIL_GROUP_HEADER = "|c4592FFGruppe|r"
BeltalowdaMenu.constants.UTIL_GROUP_DISPLAY_TYPE = "Anzeigeoption"

--Util Alliance Color
BeltalowdaMenu.constants.AC_HEADER = "|c4592FFAllianzfarben|r"
BeltalowdaMenu.constants.AC_DC_COLOR = "DC-Farbe"
BeltalowdaMenu.constants.AC_EP_COLOR = "EP-Farbe"
BeltalowdaMenu.constants.AC_AD_COLOR = "AD-Farbe"
BeltalowdaMenu.constants.AC_NO_ALLIANCE_COLOR = "Keine Allianzfarbe"

--Chat System
BeltalowdaMenu.constants.CHAT_HEADER = "|c4592FFChatsystem|r"
BeltalowdaMenu.constants.CHAT_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.CHAT_SELECTED_TAB = "Selektierter Tab"
BeltalowdaMenu.constants.CHAT_REFRESH = "Aktualisieren"
BeltalowdaMenu.constants.CHAT_WARNINGS_ONLY = "Zeige Warnungen"
BeltalowdaMenu.constants.CHAT_DEBUG_ONLY = "Zeige Debug"
BeltalowdaMenu.constants.CHAT_NORMAL_ONLY = "Zeige Normal"
BeltalowdaMenu.constants.CHAT_PREFIX_ENABLED = "Prefix aktiviert"
BeltalowdaMenu.constants.CHAT_RDK_PREFIX_ENABLED = "Beltalowda-Prefix aktiviert"
BeltalowdaMenu.constants.CHAT_COLOR_PREFIX = "Prefixfarbe"
BeltalowdaMenu.constants.CHAT_COLOR_BODY = "Schriftfarbe"
BeltalowdaMenu.constants.CHAT_COLOR_WARNING = "Warnungsfarbe"
BeltalowdaMenu.constants.CHAT_COLOR_DEBUG = "Debugfarbe"
BeltalowdaMenu.constants.CHAT_COLOR_PLAYER = "Spielerfarbe"
BeltalowdaMenu.constants.CHAT_ADD_TIMESTAMP = "Zeitstempel hinzufügen"
BeltalowdaMenu.constants.CHAT_HIDE_SECONDS = "Zeitstempelsekunden verbergen"
BeltalowdaMenu.constants.CHAT_COLOR_TIMESTAMP = "Zeitstempelfarbe"

--Class Role
BeltalowdaMenu.constants.CR_HEADER = "|cFF8174Klasse / Rolle|r"

--BG Templar Heal
BeltalowdaMenu.constants.CRBG_TPHEAL_HEADER = "|c4592FFTemplerheiler (Gruppe)|r"
BeltalowdaMenu.constants.CRBG_TPHEAL_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.CRBG_TPHEAL_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.CRBG_TPHEAL_POSITION_FIXED = "Position fixiert"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_DAMAGE = "Schadensfortschritt"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_DAMAGE = "Schadensbezeichnung"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_HEALING = "Heilungsfortschritt"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_HEALING = "Heilungsbezeichnung"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_RECOVERY = "Regenerationsfortschritt"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_RECOVERY = "Regenerationsfortschritt"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_COOLDOWN = "Cooldown-Bezeichnung"

--AddOn Integration
BeltalowdaMenu.constants.ADDON_INTEGRATION_HEADER = "|cFF8174AddOn Integrationseinstellungen|r"
--Miats Pvp Alerts
BeltalowdaMenu.constants.MPAI_HEADER = "|c4592FFMiat PvP Alerts|r"
BeltalowdaMenu.constants.MPAI_ENABLED = "Löschen nach Login (aktiviert)"
BeltalowdaMenu.constants.MPAI_ONPLAYERACTIVATION = "Löschen nach Ladebildschirm"
BeltalowdaMenu.constants.MPAI_CLEAR_VARS = "Variablen löschen"

--Admin
BeltalowdaMenu.constants.ADMIN_HEADER = "|cFF8174Admineinstellungen|r"
--Group Share
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_HEADER = "|c4592FFGroup Share|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ENABLED = "Aktiviert"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_WARNING = "|cFF0000Enabling this will allow ranks 1 to 3 of any of your guilds to query the allowed configurations|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CLIENT_CONFIGURATION = "Erlaube Client-Konfiguration"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_ADDON_CONFIGURATION = "Erlaube AddOn-Konfiguration"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_STATS = "Erlaube Stats"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_SKILLS = "Erlaube Fähigkeiten"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_EQUIPMENT = "Erlaube Rüstung"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CP = "Erlaube CP"

--Base
--Crown
BeltalowdaCrown.constants = BeltalowdaCrown.constants or {}
BeltalowdaCrown.constants.PAPA_CROWN_DETECTED = "Papa Crown wurde detektiert. Einstellungen zur Krone werden nicht übernommen."
BeltalowdaCrown.constants.SANCTS_ULTIMATE_ORGANIZER_DETECTED = "Sancts Ultimate Organizer wurde detektiert. Einstellungen zur Krone werden nicht übernommen."
BeltalowdaCrown.constants.CROWN_OF_CYRODIIL_DETECTED = "Crown of Cyrodiil wurde detektiert. Einstellungen zur Krone werden nicht übernommen."
BeltalowdaCrown.config.crowns[1].name = "Standardkrone"
BeltalowdaCrown.config.crowns[2].name = "Weißer Pfeil"
BeltalowdaCrown.config.crowns[3].name = "Blauer Pfeil"
BeltalowdaCrown.config.crowns[4].name = "Hellblauer Pfeil"
BeltalowdaCrown.config.crowns[5].name = "Gelber Pfeil"
BeltalowdaCrown.config.crowns[6].name = "Hellgrüner Pfeil"
BeltalowdaCrown.config.crowns[7].name = "Roter Pfeil"
BeltalowdaCrown.config.crowns[8].name = "Pinker Pfeil"
BeltalowdaCrown.config.crowns[9].name = "Große weiße Krone"
BeltalowdaCrown.config.crowns[10].name = "Weißes RDK-Symbol"

--Auto Invite
BeltalowdaAI.constants = BeltalowdaAI.constants or {}
BeltalowdaAI.constants.AI_MENU_NAME = "Auto Invite"
BeltalowdaAI.constants.AI_ENABLED = "Aktiviert"
BeltalowdaAI.constants.AI_INVITE_TEXT = "Invite-Text"
BeltalowdaAI.constants.AI_SENT_INVITE_TO = "Einladung an|r |c%s%s |c%sgesendet.|r"
BeltalowdaAI.constants.AI_NOT_LEADER_SEND_TO = "Einladung wurde nicht an|r |c%s%s|r |c%sgesendet. Du hast nicht die Krone.|r"
BeltalowdaAI.constants.AI_FULL_GROUP = "Einladung wurde nicht gesendet. Die Gruppe ist bereits voll."
BeltalowdaAI.constants.AI_REQUIREMENTS_NOT_MET = "Einladung wurde nicht an|r |c%s%s|r |c%sgesendet. Die Anforderungen wurden nicht erfüllt.|r"
BeltalowdaAI.constants.AI_AUTO_KICK_MESSAGE = "Gruppenmitglied|r |c%s%s|r |c%swird aus der Gruppe entfernt.|r"
BeltalowdaAI.constants.TOGGLE_AI = "Auto Invite an- / ausschalten"
BeltalowdaAI.constants.AI_ENABLED_TRUE = "Auto Invite wurde aktiviert."
BeltalowdaAI.constants.AI_ENABLED_FALSE = "Auto Invite wurde deaktiviert."
BeltalowdaAI.constants.AI_MEMBER_LEFT = "Gruppenmitglied|r |c%s%s|r |c%shat die Gruppe verlassen.|r"

--Follow The Crown Visual
BeltalowdaFtcv.textures[1].name = "Pfeil 1"
BeltalowdaFtcv.textures[2].name = "Pfeil 2"
BeltalowdaFtcv.textures[3].name = "Pfeil 3"
BeltalowdaFtcv.textures[4].name = "Pfeil 4"
BeltalowdaFtcv.textures[5].name = "Pfeil 5"
BeltalowdaFtcv.textures[6].name = "Pfeil 6"
BeltalowdaFtcv.textures[7].name = "Pfeil 7"
BeltalowdaFtcv.textures[8].name = "Pfeil 8"

--Follow The Crown Warnings
BeltalowdaFtcw.constants = BeltalowdaFtcw.constants or {}
BeltalowdaFtcw.constants.FTCW_MAX_DISTANCE ="Maximale Distanz erreicht!!!"

--Resource Overview
BeltalowdaOverview.config.ultimateModes = BeltalowdaOverview.config.ultimateModes or {}
--BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_GROUP] = "Gruppezuweisung"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS] = "Bereitschaft"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME] = "Name"
BeltalowdaOverview.constants.BOOM = "BOOM"
BeltalowdaOverview.constants.TOGGLE_BOOM = "Schicke BOOM"
BeltalowdaOverview.constants.IDENENTIFIER_DESTRUCTION = "Destro"
BeltalowdaOverview.constants.IDENENTIFIER_STORM = "Storm"
BeltalowdaOverview.constants.IDENENTIFIER_NEGATE = "Neg."
BeltalowdaOverview.constants.IDENENTIFIER_NOVA = "Nova"
BeltalowdaOverview.config.groupsModes = BeltalowdaOverview.config.groupsModes or {}
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME] = "Priorität Name"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT] = "Priorität Prozent"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PERCENT] = "Prozent"
BeltalowdaOverview.config.displayModes = BeltalowdaOverview.config.displayModes or {}
BeltalowdaOverview.config.displayModes[BeltalowdaOverview.constants.displayModes.CLASSIC] = "Klassisch"
BeltalowdaOverview.config.displayModes[BeltalowdaOverview.constants.displayModes.SWIMLANES] = "Swimlanes"

--Healing / Damage Meter
BeltalowdaHdm.constants = BeltalowdaHdm.constants or {}
BeltalowdaHdm.constants.TITLE_HEALING = "Heilung"
BeltalowdaHdm.constants.TITLE_DAMAGE = "Schaden"
BeltalowdaHdm.constants.viewModes = BeltalowdaHdm.constants.viewModes or {}
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH] = "Beides"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_HEALING] = "Heilung"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_DAMAGE] = "Schaden"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH_ON_TOP] = "Beides (vertikal)"
BeltalowdaHdm.constants.RESET_COUNTER = "Zähler zurücksetzen"

--Detonation Tracker
BeltalowdaDt.constants.modes = BeltalowdaDt.constants.modes or {}
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_BOTH] = "Beides"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_DETONATION] = "Detonation"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_SHALK] = "Käfer"

--I See Dead People
BeltalowdaIsdp.constants = BeltalowdaIsdp.constants or {}
BeltalowdaIsdp.constants.BEAM_SKULL_USING_BUFFER = "Totenkopf"
BeltalowdaIsdp.constants.BEAM_SKULL_NOT_USING_BUFFER = "Totenkopf (o. Buffer)"

--Compass
--YACS
BeltalowdaYacs.compasses[1].name = "Standard"
BeltalowdaYacs.compasses[2].name = "Dicker Norden"
BeltalowdaYacs.compasses[3].name = "Dünne Linien"
BeltalowdaYacs.compasses[4].name = "Betont unterstrichener Norden"
BeltalowdaYacs.compasses[5].name = "Dick unterstrichener Norden"
BeltalowdaYacs.compasses[6].name = "Gekritzel"
BeltalowdaYacs.compasses[7].name = "Kreise 1"
BeltalowdaYacs.compasses[8].name = "Kreise 2"
BeltalowdaYacs.compasses[9].name = "Diamant 1"
BeltalowdaYacs.compasses[10].name = "Diamant 2"
BeltalowdaYacs.compasses[11].name = "Punkte 1"
BeltalowdaYacs.compasses[12].name = "Punkte 2"
BeltalowdaYacs.compasses[13].name = "EBuchstaben 1"
BeltalowdaYacs.compasses[14].name = "EBuchstaben 2"
BeltalowdaYacs.compasses[15].name = "Voller Pfeil 1"
BeltalowdaYacs.compasses[16].name = "Voller Pfeil 2"
BeltalowdaYacs.compasses[17].name = "Nadel 1"
BeltalowdaYacs.compasses[18].name = "Nadel 2"
BeltalowdaYacs.compasses[19].name = "Kleiner Pfeil 1"
BeltalowdaYacs.compasses[20].name = "Kleiner Pfeil 2"
BeltalowdaYacs.compasses[21].name = "Kompass Fr. 1"
BeltalowdaYacs.compasses[22].name = "Kompass Fr. 2"
BeltalowdaYacs.compasses[23].name = "Kompass Fr. 3"
BeltalowdaYacs.compasses[24].name = "Kompass Fr. 4"
BeltalowdaYacs.config.constants.TOGGLE_YACS = "Kompass umschalten"

--SC
BeltalowdaSC.constants = BeltalowdaSC.constants or {}
BeltalowdaSC.constants.NORTH = "N"
BeltalowdaSC.constants.NORTH_EAST = "NO"
BeltalowdaSC.constants.EAST = "O"
BeltalowdaSC.constants.SOUTH_EAST = "SO"
BeltalowdaSC.constants.SOUTH = "S"
BeltalowdaSC.constants.SOUTH_WEST = "SW"
BeltalowdaSC.constants.WEST = "W"
BeltalowdaSC.constants.NORTH_WEST = "NW"

--Toolbox
--Siege Merchant
BeltalowdaSm.paymentOptions = BeltalowdaSm.paymentOptions or {}
BeltalowdaSm.paymentOptions[1] = "Nur AP"
BeltalowdaSm.paymentOptions[2] = "Nur Gold"
BeltalowdaSm.paymentOptions[3] = "Erst AP, dann Gold"
BeltalowdaSm.paymentOptions[4] = "Erst Gold, dann AP"
BeltalowdaSm.constants = BeltalowdaSm.constants or {}
BeltalowdaSm.constants.ERROR_UNKNOWN = "Ein unbekannter Fehler ist aufgetreten."
BeltalowdaSm.constants.ERROR_UNKNOWN_PAYMENT_OPTION = "Unbekannte Zahlungsart wurde ausgewählt."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD = "Es ist nicht genügend Gold vorhanden, um weitere Gegenstände zu kaufen."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP = "Es sind nicht genügend AP vorhanden, um weitere Gegenstände zu kaufen."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP_OR_GOLD = "Es sind nicht genügend AP oder Gold vorhanden, um weitere Gegenstände zu kaufen."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_INVENTORY_SLOTS = "Es sind nicht genügend freie Inventarplätze vorhanden, um weitere Gegenstände zu kaufen."
BeltalowdaSm.constants.SUCCESS_MESSAGE = "Einkauf abgeschlossen."

--Recharger
BeltalowdaRecharger.constants = BeltalowdaRecharger.constants or {}
BeltalowdaRecharger.constants.MESSAGE_SUCCESS = "%s (%d%%) wurde wieder aufgeladen."
BeltalowdaRecharger.constants.MESSAGE_WARNING_LOW_SOULGEMS = "Weniger als %d Seelensteine sind vorhanden."
BeltalowdaRecharger.constants.MESSAGE_WARNING_NO_SOULGEMS = "Es sind keine Seelensteine mehr vorhanden."

--Buff Food Tracking
BeltalowdaBft.constants = BeltalowdaBft.constants or {}
BeltalowdaBft.constants.BUFF_FOOD_STRING = "Buff Food: %s"

--Siege
BeltalowdaSiege.constants = BeltalowdaSiege.constants or {}
BeltalowdaSiege.constants.TOGGLE_SIEGE = "|c4592FFBeltalowda: Ansicht umschalten|r"

--Cyrodiil Log
BeltalowdaCL.constants = BeltalowdaCL.constants or {}
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_CLAIM = "%s|c%s beanspruchte %s|c%s für %s"
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_LOST = "%s|c%s verlor %s"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA = "%s|c%s steht unter Angriff"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA_LOST = "%s|c%s steht nicht mehr unter Angriff"
BeltalowdaCL.constants.MESSAGE_KEEP_OWNER_CHANGED = "%s|c%s gehört nun %s"
BeltalowdaCL.constants.MESSAGE_TICK_DEFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s erhalten für das Verteidigen von %s"
BeltalowdaCL.constants.MESSAGE_TICK_OFFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s erhalten für das Einnehmen von %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_PICKED_UP = "%s|c%s hat die %s|c%s aufgehoben"
BeltalowdaCL.constants.MESSAGE_SCROLL_DROPPED = "%s|c%s hat die %s|c%s fallen lassen"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED = "%s|c%s hat die %s|c%s zurückgebracht"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED_BY_TIMER = "%s|c%s wurde zurückgesetzt"
BeltalowdaCL.constants.MESSAGE_SCROLL_CAPTURED = "%s|c%s hat die %s|c%s nach %s|c%s gebracht"
BeltalowdaCL.constants.MESSAGE_EMPEROR_CORONATED = "%s|c%s wurde zum Kaiser gekrönt"
BeltalowdaCL.constants.MESSAGE_EMPEROR_DEPOSED = "%s|c%s wurde als Kaiser abgesetzt"
BeltalowdaCL.constants.MESSAGE_QUEST_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s erhalten für das Abschließen einer Quest"
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s erhalten für das Abschließen eines Schlachtfeldes"
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_MEDAL_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s für des Erhalten einer Medaille erhalten"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_SPAWNED = "|c%s%s ist erschienen"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_REVEALED = "|c%s%s wurde aufgedeckt"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DROPPED = "|c%s%s wurde von %s|c%s fallen gelassen"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_TAKEN = "|c%s%s wurde von %s|c%s aufgenommen"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DESPAWNED = "|c%s%s kehrt in die Vergessenheit zurück"

--Respawner
BeltalowdaRespawner.constants = BeltalowdaRespawner.constants or {}
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_CAMP = "Respawn at Camp" ---xxx
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_KEEP = "Respawn at Keep" ---xxx
BeltalowdaRespawner.constants.RESPAWN_CAMP = "Zelt"
BeltalowdaRespawner.constants.RESPAWN_KEEP = "Burg"

--Synergy Prevention
BeltalowdaSP.constants = BeltalowdaSP.constants or {}
BeltalowdaSP.constants.ON = "AN"
BeltalowdaSP.constants.OFF = "AUS"
BeltalowdaSP.constants.KEYBINDING = "Umschalten der Synergieprävention"
BeltalowdaSP.constants.SYNERGY_COMBUSTION = "Verbrennung"
BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION = "heilende Verbrennung"
BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED = "gesegnete Scherben"
BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY = "heilige Scherben"
BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST = "Blutgelage"
BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL = "Blutfluss"
BeltalowdaSP.constants.SYNERGY_SUPERNOVA = "Supernova"
BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH = "zertrümmernde Schwerkraft"
BeltalowdaSP.constants.SYNERGY_SHACKLE = "Fessel"
BeltalowdaSP.constants.SYNERGY_PURIFY = "Reinigen"
BeltalowdaSP.constants.SYNERGY_BONE_WALL = "Knochenwand"
BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE = "Wirbelwoge"
BeltalowdaSP.constants.SYNERGY_IGNITE = "Entzünden"
BeltalowdaSP.constants.SYNERGY_RADIATE = "Strahlung"
BeltalowdaSP.constants.SYNERGY_CONDUIT = "Ableiten"
BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS = "Spinnenbrut"
BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS = "schwarze Witwe"
BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA = "Arachnophobie"
BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH = "verborgene Erholung"
BeltalowdaSP.constants.SYNERGY_SOUL_LEECH = "Seelenentzug"
BeltalowdaSP.constants.SYNERGY_HARVEST = "Einsammeln"
BeltalowdaSP.constants.SYNERGY_ATRONACH = "aufgeladener Blitz"
BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER = "Grabräuber"
BeltalowdaSP.constants.SYNERGY_PURE_AGONY = "reine Qual"
BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE = "eisige Flucht"
BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST = "sanguine Explosion"
BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL = "Erhört den Ruf"
BeltalowdaSP.constants.SYNERGY_URSUS = "Schild von Ursus"
--BeltalowdaSP.constants.blacklist = BeltalowdaSP.constants.blacklist or {}
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_COMBUSTION] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_SUPERNOVA] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_SHACKLE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_IGNITE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_RADIATE] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_CONDUIT] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER] = true
--BeltalowdaSP.constants.blacklist[BeltalowdaSP.constants.SYNERGY_PURE_AGONY] = true
BeltalowdaSP.constants.MODES = BeltalowdaSP.constants.MODES or {}
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_ALL] = "Alle"
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_IF_SYNERGY_ROLE] = "Synergierolle"

--Synergy Overview
BeltalowdaSO.constants.DISPLAY_MODES = BeltalowdaSO.constants.DISPLAY_MODES or {}
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_ALL] = "Alle"
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_SYNERGY] = "Synergierolle"
BeltalowdaSO.constants.TABLE_MODES = BeltalowdaSO.constants.TABLE_MODES or {}
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_FULL] = "Voll"
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_REDUCED] = "Reduziert"

--util
--util
BeltalowdaUtil.constants = BeltalowdaUtil.constants or {}
BeltalowdaUtil.constants.G1 = "Gilde 1"
BeltalowdaUtil.constants.O1 = "Offiziere 1"
BeltalowdaUtil.constants.G2 = "Gilde 2"
BeltalowdaUtil.constants.O2 = "Offiziere 2"
BeltalowdaUtil.constants.G3 = "Gilde 3"
BeltalowdaUtil.constants.O3 = "Offiziere 3"
BeltalowdaUtil.constants.G4 = "Gilde 4"
BeltalowdaUtil.constants.O4 = "Offiziere 4"
BeltalowdaUtil.constants.G5 = "Gilde 5"
BeltalowdaUtil.constants.O5 = "Offiziere 5"
BeltalowdaUtil.constants.EMOTE = "Aktionen"
BeltalowdaUtil.constants.SAY = "Sagen"
BeltalowdaUtil.constants.YELL = "Rufen"
BeltalowdaUtil.constants.GROUP = "Gruppe"
BeltalowdaUtil.constants.TELL = "Flüstern"
BeltalowdaUtil.constants.ZONE = "Gebiet"
BeltalowdaUtil.constants.ENZONE = "Gebiet: English"
BeltalowdaUtil.constants.FRZONE = "Gebiet: French"
BeltalowdaUtil.constants.DEZONE = "Gebiet: German"
BeltalowdaUtil.constants.JPZONE = "Gebiet: Japan"

--ui
BeltalowdaUtilUI.constants = BeltalowdaUtilUI.constants or {}
BeltalowdaUtilUI.constants.ON = "AN"
BeltalowdaUtilUI.constants.OFF = "AUS"

--Ultimates
BeltalowdaUltimates.constants = BeltalowdaUltimates.constants or {}
BeltalowdaUltimates.constants.NEGATE = "Zauberer: Magienegation"
BeltalowdaUltimates.constants.NEGATE_OFFENSIVE = "Zauberer: Offensiv-Magienegation"
BeltalowdaUltimates.constants.NEGATE_COUNTER = "Zauberer: Counter-Magienegation"
BeltalowdaUltimates.constants.ATRONACH = "Zauberer: Atronach"
BeltalowdaUltimates.constants.OVERLOAD = "Zauberer: Überladung"
BeltalowdaUltimates.constants.SWEEP = "Templer: Rundumschlag"
BeltalowdaUltimates.constants.NOVA = "Templer: Nova"
BeltalowdaUltimates.constants.T_HEAL = "Templer: Heilung"
BeltalowdaUltimates.constants.STANDARD = "Drachenritter: Standarte"
BeltalowdaUltimates.constants.LEAP = "Drachenritter: Drachensprung"
BeltalowdaUltimates.constants.MAGMA = "Drachenritter:Magmarüstung"
BeltalowdaUltimates.constants.STROKE = "Nachtklinge: Todesstoss"
BeltalowdaUltimates.constants.DARKNESS = "Nachtklinge: Verschlingende Dunkelheit"
BeltalowdaUltimates.constants.SOUL = "Nachtklinge: Seelenfetzen"
BeltalowdaUltimates.constants.SOUL_SIPHON = "Nachtklinge: Seelensiphon"
BeltalowdaUltimates.constants.SOUL_TETHER = "Nachtklinge: Seelenfessel"
BeltalowdaUltimates.constants.STORM = "Hüter: Sturm"
BeltalowdaUltimates.constants.NORTHERN_STORM = "Hüter: Nordsturm"
BeltalowdaUltimates.constants.PERMAFROST = "Hüter: Permafrost"
BeltalowdaUltimates.constants.W_HEAL = "Hüter: Heilung"
BeltalowdaUltimates.constants.GUARDIAN = "Hüter: Wächter"
BeltalowdaUltimates.constants.COLOSSUS = "Nekromant: Koloss"
BeltalowdaUltimates.constants.GOLIATH = "Nekromant: Knochenhüne"
BeltalowdaUltimates.constants.REANIMATE = "Nekromant: Wiederbeleben"
BeltalowdaUltimates.constants.UNBLINKING_EYE = "Arkanist - Starrendes Auge"
BeltalowdaUltimates.constants.GIBBERING_SHIELD = "Arkanist - Schnatterschild"
BeltalowdaUltimates.constants.VITALIZING_GLYPHIC = "Arkanist - Vitalisierende Glyphik"
BeltalowdaUltimates.constants.DESTRUCTION = "Waffe: Zerstörungsstab"
BeltalowdaUltimates.constants.RESTORATION = "Waffe: Heilungsstab"
BeltalowdaUltimates.constants.TWO_HANDED = "Waffe: Zweihänder"
BeltalowdaUltimates.constants.SHIELD = "Waffe: Waffe mit Schild"
BeltalowdaUltimates.constants.DUAL_WIELD = "Waffe: Zwei Waffen"
BeltalowdaUltimates.constants.BOW = "Waffe: Bogen"
BeltalowdaUltimates.constants.SOUL_MAGIC = "Welt: Seelenschlag"
BeltalowdaUltimates.constants.WEREWOLF = "Welt: Werwolf: Werwolfverwandlung"
BeltalowdaUltimates.constants.VAMPIRE = "Welt: Vampirismus: Fledermausschwarm"
BeltalowdaUltimates.constants.MAGES = "Magiergilde: Meteor"
BeltalowdaUltimates.constants.FIGHTERS = "Kriegergilde: Dämmerbrecher"
BeltalowdaUltimates.constants.PSIJIC = "Psijikorden: Rückgängig"
BeltalowdaUltimates.constants.ALLIANCE_SUPPORT = "Allianzkrieg: Unterstützung: Barriere"
BeltalowdaUltimates.constants.ALLIANCE_ASSAULT = "Allianzkrieg: Sturmangriff: Kriegshorn"

--Networking
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.DIRECT] = "Direkt"
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.CRITICAL] = "Queue (kritisch)"

--Util Group
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_CHAR_NAME] = "Nach Name"
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_DISPLAY_NAME] = "Nach @Account"

BeltalowdaUtilGroup.constants.ROLE_RAPID = "Rapid"
BeltalowdaUtilGroup.constants.ROLE_PURGE = "Purge"
BeltalowdaUtilGroup.constants.ROLE_HEAL = "Heiler"
BeltalowdaUtilGroup.constants.ROLE_DD = "DD"
BeltalowdaUtilGroup.constants.ROLE_SYNERGY = "Synergie"
BeltalowdaUtilGroup.constants.ROLE_CC = "CC"
BeltalowdaUtilGroup.constants.ROLE_SUPPORT = "Support"
BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER = "Undefiniert"
BeltalowdaUtilGroup.constants.ROLE_APPLICANT = "Bewerber"

--Util Versioning
BeltalowdaVersioning.constants = BeltalowdaVersioning.constants or {}
BeltalowdaVersioning.constants.CLIENT_OUT_OF_DATE = "|cFF0000[Beltalowda] Die Clientversion ist nicht mehr aktuell|r"

--Util Enhancements
BeltalowdaEnhance.constants = BeltalowdaEnhance.constants or {}
BeltalowdaEnhance.constants.positionNames = BeltalowdaEnhance.constants.positionNames or {}
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPRIGHT] = "Oben rechts"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMRIGHT] = "Unten rechts"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPLEFT] = "Oben links"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMLEFT] = "Unten links"
BeltalowdaEnhance.constants.CAMP_RESPAWN = "Zelt : "

--Util Group Menu
BeltalowdaGMenu.constants = BeltalowdaGMenu.constants or {}
BeltalowdaGMenu.constants.BG_LEADER_ADD_CROWN = "Als Krone markieren"
BeltalowdaGMenu.constants.BG_LEADER_REMOVE_CROWN = "Krone entfernen"
BeltalowdaGMenu.constants.ROLE_MENU_ENTRY = "Rolle"
BeltalowdaGMenu.constants.ROLE_SUBMENU_SET = "Setze"
BeltalowdaGMenu.constants.ROLE_SUBMENU_REMOVE = "Entferne"
BeltalowdaGMenu.constants.ROLE_SUBMENU_RAPID = BeltalowdaUtilGroup.constants.ROLE_RAPID
BeltalowdaGMenu.constants.ROLE_SUBMENU_PURGE = BeltalowdaUtilGroup.constants.ROLE_PURGE
BeltalowdaGMenu.constants.ROLE_SUBMENU_HEAL = BeltalowdaUtilGroup.constants.ROLE_HEAL
BeltalowdaGMenu.constants.ROLE_SUBMENU_DD = BeltalowdaUtilGroup.constants.ROLE_DD
BeltalowdaGMenu.constants.ROLE_SUBMENU_SYNERGY = BeltalowdaUtilGroup.constants.ROLE_SYNERGY
BeltalowdaGMenu.constants.ROLE_SUBMENU_CC = BeltalowdaUtilGroup.constants.ROLE_CC
BeltalowdaGMenu.constants.ROLE_SUBMENU_SUPPORT = BeltalowdaUtilGroup.constants.ROLE_SUPPORT
BeltalowdaGMenu.constants.ROLE_SUBMENU_PLACEHOLDER = BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER
BeltalowdaGMenu.constants.ROLE_SUBMENU_APPLICANT = BeltalowdaUtilGroup.constants.ROLE_APPLICANT

--Util Beams
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].name = "Beam 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].name = "Beam 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].name = "Beam 3"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].name = "Beam 4"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].name = "Kreis 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].name = "Kreis 1 (o. Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].name = "Kreis 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].name = "Kreis 2 (o. Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].name = "Pfeil 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].name = "Pfeil 2"

--Admin [General]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.TOGGLE_ADMIN = "Admininterface umschalten"
BeltalowdaAdmin.constants.HEADER_TITLE = "Admin"
BeltalowdaAdmin.constants.PLAYERS_ALL = "Alle"
--Admin UI [Player]
BeltalowdaAdmin.constants.player = BeltalowdaAdmin.constants.player or {}
BeltalowdaAdmin.constants.player.REQUEST_ALL = "Alles abfragen"
BeltalowdaAdmin.constants.player.REQUEST_VERSION = "Version abfragen"
BeltalowdaAdmin.constants.player.REQUEST_CLIENT_CONFIGURATION = "Clientkonfiguration abfragen"
BeltalowdaAdmin.constants.player.REQUEST_ADDON_CONFIGURATION = "AddOn-Konfiguration abfragen"
BeltalowdaAdmin.constants.player.REQUEST_EQUIPMENT_INFORMATION = "Ausrüstungsinformationen abfragen"
BeltalowdaAdmin.constants.player.REQUEST_STATS_INFORMATION = "Stats-Informationen abfragen"
BeltalowdaAdmin.constants.player.REQUEST_MUNDUS_INFORMATION = "Mundus-Informationen abfragen"
BeltalowdaAdmin.constants.player.REQUEST_SKILLS_INFORMATION = "Skills abfragen"
BeltalowdaAdmin.constants.player.REQUEST_QUICKSLOTS_INFORMATION = "Schnellzugriff-Informationen abfragen"
BeltalowdaAdmin.constants.player.REQUEST_CHAMPION_INFORMATION = "CP abfragen"
--Admin UI [Config]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.defaults = BeltalowdaAdmin.constants.defaults or {}
BeltalowdaAdmin.constants.defaults.ENABLED = "An"
BeltalowdaAdmin.constants.defaults.DISABLED = "Aus"
BeltalowdaAdmin.constants.defaults.UNDEFINED = "N/A"
BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE = "-"
BeltalowdaAdmin.constants.defaults.UNDEFINED_VERSION = "N/A (Version)"
BeltalowdaAdmin.constants.defaults.viewModes = BeltalowdaAdmin.constants.defaults.viewModes or {}
BeltalowdaAdmin.constants.defaults.viewModes[0] = "Fenster"
BeltalowdaAdmin.constants.defaults.viewModes[1] = "Fenster (Vollbild)"
BeltalowdaAdmin.constants.defaults.viewModes[2] = "Vollbild"
BeltalowdaAdmin.constants.defaults.qualitySelection = BeltalowdaAdmin.constants.defaults.qualitySelection or {}
BeltalowdaAdmin.constants.defaults.qualitySelection[0] = "Aus"
BeltalowdaAdmin.constants.defaults.qualitySelection[1] = "Niedrig"
BeltalowdaAdmin.constants.defaults.qualitySelection[2] = "Mittel"
BeltalowdaAdmin.constants.defaults.qualitySelection[3] = "Hoch"
BeltalowdaAdmin.constants.defaults.qualitySelection[4] = "Ultra"
BeltalowdaAdmin.constants.defaults.graphicPresets = BeltalowdaAdmin.constants.defaults.graphicPresets or {}
BeltalowdaAdmin.constants.defaults.graphicPresets[0] = "Minumum"
BeltalowdaAdmin.constants.defaults.graphicPresets[1] = "Niedrig"
BeltalowdaAdmin.constants.defaults.graphicPresets[2] = "Mittel"
BeltalowdaAdmin.constants.defaults.graphicPresets[3] = "Hoch"
BeltalowdaAdmin.constants.defaults.graphicPresets[4] = "Ultra"
BeltalowdaAdmin.constants.defaults.graphicPresets[7] = "Benutzerdefiniert"
BeltalowdaAdmin.constants.config = BeltalowdaAdmin.constants.config or {}
BeltalowdaAdmin.constants.config.PLAYER_TITLE = "Spielerinformationen"
BeltalowdaAdmin.constants.config.PLAYER_DISPLAYNAME_STRING = "Display-Name: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_CHARNAME_STRING = "Charakter-Name: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_VERSION_STRING = "Version: |c%s%s.%s.%s|r"
BeltalowdaAdmin.constants.config.CLIENT_TITLE = "Clientinformation"
BeltalowdaAdmin.constants.config.CLIENT_AOE_SUBTITLE = "AOE"
BeltalowdaAdmin.constants.config.CLIENT_AOE_TELLS_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENABLED_STRING = "Farben aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_FRIENDLY_BRIGHTNESS = "Freundliche Helligkeit: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENEMY_BRIGHTNESS = "Gegnerische Helligkeit: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_SUBTITLE = "Sound"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_AUDIO_VOLUME = "Audiolautstärke: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SFX_AUDIO_VOLUME = "SFX-Lautstärke: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_UI_AUDIO_VOLUME = "UI-Lautstärke: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBTITLE = "Grafiken"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_RESOLUTION_STRING = "Auflösung: |c%s%sx%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_WINDOW_MODE_STRING = "Anzeigemodus: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VSYNC_STRING = "Vertikale Synchronization: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ANTI_ALIASING_STRING = "Kantenglättung: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_AMBIENT_STRING = "Umgebungsverdeckung: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_BLOOM_STRING = "Überblendeffekt: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DEPTH_OF_FIELD_STRING = "Tiefenunschärfe: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DISTORTION_STRING = "Verzerrungen: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUNLIGHT_STRING = "Lichtstrahlen: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ALLY_EFFECTS_STRING = "Effekte von Verbündeten: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VIEW_DISTANCE_STRING = "Sichtweite: ~|c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_SUPRESSION_DISTANCE_STRING = "Partikeldistanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_MAXIMUM_STRING = "Partikelsysteme: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_REFLECTION_QUALITY_STRING = "Reflexionsqualität: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SHADOW_QUALITY_STRING = "Schattenqualität: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBSAMPLING_QUALITY_STRING = "Subsamplingqualität: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_GRAPHIC_PRESETS_STRING = "Grafikqualität: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_TITLE = "AddOn-Einstellungen"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SUBTITLE = "Krone"
BeltalowdaAdmin.constants.config.ADDON_CROWN_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SIZE_STRING = "Kronengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SELECTED_CROWN_STRING = "Selektierte Krone: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SUBTITLE = "Follow The Crown - Anzeige"
BeltalowdaAdmin.constants.config.ADDON_FTCV_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_FAR_STRING = "Größe fern: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_CLOSE_STRING = "Größe nahe: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MIN_DISTANCE_STRING = "Minimale Distanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MAX_DISTANCE_STRING = "Maximale Distanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_FAR_STRING = "Durchsichtigkeit fern: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_CLOSE_STRING = "Durchsichtigkeit nahe: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_SUBTITLE = "Follow The Crown - Warnungen"
BeltalowdaAdmin.constants.config.ADDON_FTCW_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_DISTANCE_ENABLED_STRING = "Distanz aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_WARNINGS_ENABLED_STRING = "Warnungen aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_MAX_DISTANCE_STRING = "Maximale Distanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_SUBTITLE = "Follow The Crown - Audio"
BeltalowdaAdmin.constants.config.ADDON_FTCA_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_MAX_DISTANCE_STRING = "Maximale Distanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_INTERVAL_STRING = "Intervall: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_THRESHOLD_STRING = "Schwellwert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SUBTITLE = "Follow The Crown - Strahl"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SELECTED_BEAM_STRING = "Selektierter Strahl: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ALPHA_STRING = "Alpha: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DBO_SUBTITLE = "Debuff-Übersicht"
BeltalowdaAdmin.constants.config.ADDON_DBO_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RT_SUBTITLE = "Rapid-Übersicht"
BeltalowdaAdmin.constants.config.ADDON_RT_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SUBTITLE = "Ressourcenübersicht"
BeltalowdaAdmin.constants.config.ADDON_RO_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_ULTIMATE_OVERVIEW_ENABLED_STRING = "Ultimate-Gruppenübersicht aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_CLIENT_GROUP_ENABLED_STRING = "Eigenes Fenster aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_ULTIMATE_ENABLED_STRING = "Gruppenfenster aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SHOW_SOFT_RESOURCES_STRING = "Stamina / Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SOUND_ENABLED_STRING = "Sound aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_MAX_DISTANCE_STRING = "Maximale Distanz: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_DESTRO_STRING = "Destro-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_STORM_STRING = "Storm-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NORTHERNSTORM_STRING = "Nordsturm-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_STORM_PERMAFROST = "Permafrost-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_STRING = "Negate-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_OFFENSIVE_STRING = "Offensiv-Negate-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_COUNTER_STRING = "Counter-Negate-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NOVA_STRING = "Nova-Gruppengröße: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUPS_ENABLED_STRING = "Gruppen aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_SUBTITLE = "Schadenzähler für Leben"
BeltalowdaAdmin.constants.config.ADDON_HDM_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_WINDOW_ENABLED_STRING = "Fenster aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_VIEW_MODE_STRING = "Ausgewählter Modus: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SUBTITLE = "Tränke-Übersicht"
BeltalowdaAdmin.constants.config.ADDON_PO_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SOUND_ENABLED_STRING = "Sound aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DT_SUBTITLE = "Detonation Tracker"
BeltalowdaAdmin.constants.config.ADDON_DT_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_GB_SUBTITLE = "Gruppenstrahlen"
BeltalowdaAdmin.constants.config.ADDON_GB_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_ISDP_SUBTITLE = "Ich sehe tote Menschen"
BeltalowdaAdmin.constants.config.ADDON_ISDP_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_SUBTITLE = "Yet Another Compass"
BeltalowdaAdmin.constants.config.ADDON_YACS_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_PVP_ENABLED_STRING = "Aktiviert im PVP: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_COMBAT_ENABLED_STRING = "Aktiviert im Kampf: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SC_SUBTITLE = "Simple Compass"
BeltalowdaAdmin.constants.config.ADDON_SC_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SM_SUBTITLE = "Belagerungshändler"
BeltalowdaAdmin.constants.config.ADDON_SM_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_SUBTITLE = "Recharger"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_KC_SUBTITLE = "Keep Claimer"
BeltalowdaAdmin.constants.config.ADDON_KC_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SUBTITLE = "Buff Food Tracker"
BeltalowdaAdmin.constants.config.ADDON_BFT_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SOUND_ENABLED_STRING = "Sound aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SIZE_STRING = "Größe: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CL_SUBTITLE = "Cyrodiillog"
BeltalowdaAdmin.constants.config.ADDON_CL_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CS_SUBTITLE = "Cyrodiil-Status"
BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_SUBTITLE = "Respawner"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAMP_SUBTITLE = "Zeltvorschau"
BeltalowdaAdmin.constants.config.ADDON_CAMP_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_SUBTITLE = "Synergieprävention"
BeltalowdaAdmin.constants.config.ADDON_SP_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_MODE_STRING = "Modus: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING = "%s: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_SUBTITLE = "Synergieübersicht"
BeltalowdaAdmin.constants.config.ADDON_SO_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_TABLE_MODE_STRING = "Tabellenmodus: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_DISPLAY_MODE_STRING = "Anzeigemodus: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_SUBTITLE = "Rollenzuteilung"
BeltalowdaAdmin.constants.config.ADDON_RA_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_ALLOW_OVERRIDE_STRING = "Überschreiben erlaubt: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAJ_SUBTITLE = "Campaign Auto Join"
BeltalowdaAdmin.constants.config.ADDON_CAJ_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_SUBTITLE = "CR - BG - Templar Healer (BG)"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_ENABLED_STRING = "Aktiviert: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_TITLE = "Stats"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_STRING = "Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_STRING = "Leben: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_STRING = "Ausdauer: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_RECOVERY_STRING = "Magickaregeneration: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_RECOVERY_STRING = "Lebensregeneration: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_RECOVERY_STRING = "Ausdauerregeneration: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_DAMAGE_STRING = "Magiekraft: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_DAMAGE_STRING = "Waffenkraft: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_PENETRATION_STRING = "Magiedurchdringung: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_PENETRATION_STRING = "Waffendurchdringung: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_CRITICAL_STRING = "Kritische Magietreffer: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_CRITICAL_STRING = "Kritische Waffentreffer: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_RESISTANCE_STRING = "Magieresistenz: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_PHYSICAL_RESISTANCE_STRING = "Physische Resistenz: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_CRITICAL_RESISTANCE_STRING = "Kritische Resistenz: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_TITLE = "Mundus"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_1_STRING = "Mundusstone 1: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_2_STRING = "Mundusstone 2: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_FILTER = "Segen: "
BeltalowdaAdmin.constants.config.CHAMPION_TITLE = "Champion Points"
BeltalowdaAdmin.constants.config.SKILLS_TITLE = "Skills"
BeltalowdaAdmin.constants.config.EQUIPMENT_TITLE = "Ausrüstung"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_REQUEST = "Gegenstand abfragen"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_LINK_IN_CHAT = "In Chat einfügen"
BeltalowdaAdmin.constants.config.QUICKSLOT_TITLE = "Schnellzugriff"

--Config
BeltalowdaConfig.constants = BeltalowdaConfig.constants or {}
BeltalowdaConfig.constants.TOGGLE_CONFIG = "Konfigurations-Interface umschalten"
BeltalowdaConfig.constants.HEADER_TITLE = "Konfigurations-Import/Export"
BeltalowdaConfig.constants.TAB_IMPORT_TITLE = "Import"
BeltalowdaConfig.constants.TAB_EXPORT_TITLE = "Export"
BeltalowdaConfig.constants.EXPORT_SELECT_ALL = "Alles selektieren"
BeltalowdaConfig.constants.EXPORT_PROFILE = "Profil"
BeltalowdaConfig.constants.EXPORT_STRING_LENGTH_ERROR = "Der Konfigurationstext ist zu lang. Bitte melde dies!"
BeltalowdaConfig.constants.IMPORT_PROFILE = "Neuer Profilnamen"
BeltalowdaConfig.constants.IMPORT = "Importieren"
BeltalowdaConfig.constants.IMPORT_STATUS = "Status: "
BeltalowdaConfig.constants.IMPORT_ADD_ALL = "Alle Werte hinzufügen (bspw. Fensterpositionen)"
BeltalowdaConfig.constants.IMPORT_STATUS_STARTED = "Import gestartet"
BeltalowdaConfig.constants.IMPORT_STATUS_FAILED = "Import fehlgeschlagen"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED = "Import abgeschlossen"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED_DIFFERENT_VERSION = "Import abgeschlossen (unterschiedliche Versionen können zu Inkonsistenzen führen)"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_INVALID_NAME = "Import fehlgeschlagen - Ungültiger Profilname"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_DUPLICATE = "Import fehlgeschlagen - Profilname existiert bereits"
BeltalowdaConfig.constants.IMPORT_STATUS_NO_CONTENT = "Import fehlgeschlagen - Kein Inhalt"
BeltalowdaConfig.constants.IMPORT_CONFIG_LINE_COUNT = "Konfigurationszeilen: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON = "Import fehlgeschlagen in Zeile %s. Grund: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_NIL = "Nil Wert"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_BOOLEAN = "Boolean erwartet"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER = "Zahl erwartet"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID = "Invalider Datentyp"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID = "Layer1 ungültig"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_2_INVALID = "Layer2 ungültig"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_2_INVALID = "Layer1 oder Layer2 ungültig"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_X_INVALID = "LayerX ungültig"