-- Beltalowda - Language - fr
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

Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.slashCmd .. " menu: ouvre le menu de configuration"
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." admin: ouvre l'interface d'administration." 
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." config: ouvre l'interface d'importation et exportation des configurations." 
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n" .. Beltalowda.slashCmd .." hdm clear: Resets the Healing Damage Meter" ---xxx
Beltalowda.config.constants.CMD_TEXT_MENU = Beltalowda.config.constants.CMD_TEXT_MENU .. "\r\n/ai: active l'invitation automatique (e.g. /ai beltalowda) - désactiver avec /ai" 

--Tool
Beltalowda.constants = Beltalowda.constants or {}
Beltalowda.constants.MISSING_LIBRARIES = "Librairies manquantes : Beltalowda nécessite les librairies suivantes : "

--Menu Constants
--Profile
BeltalowdaMenu.constants = BeltalowdaMenu.constants or {}
BeltalowdaMenu.constants.PROFILE_HEADER = "Réglages du profil"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE = "Profil sélectionné"
BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE_TOOLTIP = "Sélectionnez le profil souhaité"
BeltalowdaMenu.constants.PROFILE_NEW_PROFILE = "Nouveau profil"
BeltalowdaMenu.constants.PROFILE_ADD_PROFILE = "Ajouter"
BeltalowdaMenu.constants.PROFILE_CLONE_PROFILE = "Copier" 
BeltalowdaMenu.constants.PROFILE_REMOVE_PROFILE = "Supprimer"
BeltalowdaMenu.constants.PROFILE_EXISTS = "|cFF0000Ce profil existe déjà - Veuillez choisir un autre nom de profil|r"
BeltalowdaMenu.constants.PROFILE_CANT_REMOVE_DEFAULT = "|cFF0000Ce profil ne peut être supprimé|r"

--Fixed Components
BeltalowdaMenu.constants.POSITION_FIXED_SET = "Figer la position"
BeltalowdaMenu.constants.POSITION_FIXED_UNSET = "Libérer la position"

--Donate
BeltalowdaMenu.constants.FEEDBACK = "Retour"
BeltalowdaMenu.constants.FEEDBACK_STRING = "Merci d'adresser vos retours et commentaires sur les forums ESO ou ESOUI. Je ne pourrai pas répondre à vos messages en jeu."
BeltalowdaMenu.constants.DONATE = "Dons"
BeltalowdaMenu.constants.DONATE_5K = "Donner 5000 gold"
BeltalowdaMenu.constants.DONATE_50K = "Donner 50000 gold"
BeltalowdaMenu.constants.DONATE_SERVER_ERROR = "Merci d'essayer de me transmettre un don. Malheureusement, nous ne jouons pas sur le même serveur, ce qui rend la chose impossible."
BeltalowdaMenu.constants.DONATE_MAIL_SUBJECT = "Beltalowda - Don"

--New Hotness
BeltalowdaMenu.constants.NEW_HOTNESS_HEADER = "|cFF8174New Hotness|r"
BeltalowdaMenu.constants.SYNERGY_TRACKING_HEADER = "|c4592FFSynergy Tracking|r"
BeltalowdaMenu.constants.OFFENSIVE_TIMERS_HEADER = "|c4592FFOffensive Timers|r"
BeltalowdaMenu.constants.POSITIONING_ASSISTANCE_HEADER = "|c4592FFPositioning Assistance|r"

--Group
BeltalowdaMenu.constants.GROUP_HEADER = "|cFF8174Réglages de groupe|r"

--Crown
BeltalowdaMenu.constants.CROWN_HEADER = "|c4592FFChef de groupe|r"
BeltalowdaMenu.constants.CROWN_CHK_GROUP_CROWN_ENABLED = "Mode \"chef de groupe personnalisé\" activé"
BeltalowdaMenu.constants.CROWN_SELECTED_MODE = "Mode chef de groupe"
BeltalowdaMenu.constants.CROWN_MODE = {}
BeltalowdaMenu.constants.CROWN_MODE[1] = "Epingle"
BeltalowdaMenu.constants.CROWN_SELECTED_CROWN = "Chef de groupe sélectionné"
BeltalowdaMenu.constants.CROWN_SIZE = "Taille"
BeltalowdaMenu.constants.CROWN_WARNING = "|cFF0000Only 1 L'add-on peut mettre en oeuvre cette fonctionnalité, mais attention, le jeu va crasher si deux add-ons l'utilisent en même temps.|r"
BeltalowdaMenu.constants.CROWN_PVP_ONLY = "Uniquement en PvP"

--Auto Invite
BeltalowdaMenu.constants.AI_HEADER = "|c4592FFInvitation automatique|r"
BeltalowdaMenu.constants.AI_ENABLED = "Activé"
BeltalowdaMenu.constants.AI_INVITE_TEXT = "Critère d'invitation"
BeltalowdaMenu.constants.AI_GROUP_SIZE = "Taille maximale de groupe"
BeltalowdaMenu.constants.AI_PVP_CHECK = "Uniquement en PvP"
BeltalowdaMenu.constants.AI_SEND_CHAT_MESSAGES = "Envoyer les messages de chat"
BeltalowdaMenu.constants.AI_AUTO_KICK = "Renvoi automatique"
BeltalowdaMenu.constants.AI_AUTO_KICK_TIME = "Intervalle de renvoi automatique"
BeltalowdaMenu.constants.AI_CHAT = "Chats autorisés"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS = "Restrictions joueur"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_TOOLTIP = "Détermine à qui s'appliquent les restrictions d'invitation automatique"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD = "Guilde"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_GUILD_FRIEND = "Guilde et amis"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_FRIEND = "Amis"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD = "Guilde spécifique"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_SPECIFIC_GUILD_FRIEND = "Guildes et amis spécifiques"
BeltalowdaMenu.constants.AI_CHAT_RESTRICTIONS_NONE = "Aucune restriction"
BeltalowdaMenu.constants.AI_SHOW_MEMBER_LEFT = "Afficher tous les messages de départ/"

--Follow The Crown Visual
BeltalowdaMenu.constants.FTCV_HEADER = "|c4592FFSuivre la couronne (Visuel)|r"
BeltalowdaMenu.constants.FTCV_ENABLED = "Activé"
BeltalowdaMenu.constants.FTCV_MODE = "Mode"
BeltalowdaMenu.constants.FTCV_COLOR_MODE = "Mode couleurs"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_ORIENTATION = "Orientation (Devant, côté, arrière)"
BeltalowdaMenu.constants.FTCV_COLOR_MODE_DISTANCE = "Distance (Proche, éloigné)"
BeltalowdaMenu.constants.FTCV_COLOR_FRONT = "Couleur 1 (Devant / Proche)"
BeltalowdaMenu.constants.FTCV_COLOR_SIDE = "Couleur 2 (Côté)"
BeltalowdaMenu.constants.FTCV_COLOR_BACK = "Couleur (Arrière / éloigné)"
BeltalowdaMenu.constants.FTCV_OPACITY_CLOSE = "Distance opacité proche"
BeltalowdaMenu.constants.FTCV_OPACITY_FAR = "Distance opacité éloigné"
BeltalowdaMenu.constants.FTCV_SIZE_CLOSE = "Taille Proche"
BeltalowdaMenu.constants.FTCV_SIZE_FAR = "Taille éloigné"
BeltalowdaMenu.constants.FTCV_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.FTCV_MODE_RETICLE = "Réticule"
BeltalowdaMenu.constants.FTCV_MODE_FIXED = "Fixe"
BeltalowdaMenu.constants.FTCV_POSITION = "Position"
BeltalowdaMenu.constants.FTCV_MAX_DISTANCE = "Distance maximale autorisée"
BeltalowdaMenu.constants.FTCV_MIN_DISTANCE = "Distance minimale"
BeltalowdaMenu.constants.FTCV_TEXTURES = "Texture"

--Follow The Crown Warnings
BeltalowdaMenu.constants.FTCW_HEADER = "|c4592FFSuivre la couronne (Avertissements)|r"
BeltalowdaMenu.constants.FTCW_ENABLED = "Activé"
BeltalowdaMenu.constants.FTCW_WARNINGS_ENABLED = "Avertissements activés"
BeltalowdaMenu.constants.FTCW_DISTANCE_ENABLED = "Distance activée"
BeltalowdaMenu.constants.FTCW_DISTANCE_BACKDROP_ENABLED = "Distance en arrière-plan activée"
BeltalowdaMenu.constants.FTCW_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.FTCW_DISTANCE = "Distance maximale autorisée"
BeltalowdaMenu.constants.FTCW_IGNORE_DISTANCE = "Désactivation de la distance"
BeltalowdaMenu.constants.FTCW_WARNING_COLOR = "Couleur d'avertissement"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_NORMAL = "Couleur distance normale"
BeltalowdaMenu.constants.FTCW_DISTANCE_COLOR_ALERT = "Couleur alterte distance"
BeltalowdaMenu.constants.FTCW_PVP_ONLY = "Uniquement en PvP"

--Follow The Crown Audio
BeltalowdaMenu.constants.FTCA_HEADER = "|c4592FFSuivre la couronne (Audio)|r"
BeltalowdaMenu.constants.FTCA_ENABLED = "Activé"
BeltalowdaMenu.constants.FTCA_DISTANCE = "Distance maximale autorisée"
BeltalowdaMenu.constants.FTCA_IGNORE_DISTANCE = "Distance désactivée"
BeltalowdaMenu.constants.FTCA_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.FTCA_UNMOUNTED_ONLY = "Seulement sans monture"
BeltalowdaMenu.constants.FTCA_SOUND = "Audio"
BeltalowdaMenu.constants.FTCA_INTERVAL = "Intervalle"
BeltalowdaMenu.constants.FTCA_THRESHOLD = "Seuil"

--Follow The Crown Beam
BeltalowdaMenu.constants.FTCB_HEADER = "|c4592FFSuivre la couronne (Faisceau)|r"
BeltalowdaMenu.constants.FTCB_WARNING = "|cFF0000Ce module ne fonctionnera qu'avec un taux de sous-échantillonage (subsampling) élevé.|r"
BeltalowdaMenu.constants.FTCB_ENABLED = "Activé"
BeltalowdaMenu.constants.FTCB_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.FTCB_SELECTED_BEAM = "Choix du faisceau"
BeltalowdaMenu.constants.FTCB_COLOR = "Couleur"

--Debuff Overview
BeltalowdaMenu.constants.DBO_HEADER = "|c4592FFAperçu des débuffs|r"
BeltalowdaMenu.constants.DBO_ENABLED = "Activé"
BeltalowdaMenu.constants.DBO_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.DBO_CRITICAL_AMOUNT = "Nombre critique de débuffs"
BeltalowdaMenu.constants.DBO_COLOR_OKAY = "Couleur OK [0]"
BeltalowdaMenu.constants.DBO_COLOR_NOT_OKAY = "Couleur insuffisant  [1]"
BeltalowdaMenu.constants.DBO_COLOR_CRITICAL = " Couleur critique"
BeltalowdaMenu.constants.DBO_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.DBO_COLOR_OUT_OF_RANGE = "Couleur hors de portée"
BeltalowdaMenu.constants.DBO_DESCRIPTION = "Ce module requiert les marqueurs de carte d'autres modules (aperçu des ressources, aperçu des synergies, mesure des soins et des dégâts).Pour obtenir les meilleurs résultats, activez l'aperçu des ressoucres"
BeltalowdaMenu.constants.DBO_SIZE = "Taille"

--Rapid Tracker
BeltalowdaMenu.constants.RT_HEADER = "|c4592FFAperçu manoeuvre rapide|r"
BeltalowdaMenu.constants.RT_ENABLED = "Activé"
BeltalowdaMenu.constants.RT_PVP_ONLY = "PvP Only"
BeltalowdaMenu.constants.RT_POSITION_FIXED = "Position Fixed"
BeltalowdaMenu.constants.RT_COLOR_LABEL_IN_RANGE = "Couleur du nom à portée"
BeltalowdaMenu.constants.RT_COLOR_LABEL_NOT_IN_RANGE = "Couleur du nom hors de portée"
BeltalowdaMenu.constants.RT_COLOR_LABEL_OUT_OF_RANGE = "Couleur du nom absent"
BeltalowdaMenu.constants.RT_COLOR_RAPID_ON = "Couleur manoeuvre rapide activée"
BeltalowdaMenu.constants.RT_COLOR_RAPID_OFF = "Couleur manoeuvre rapide inactive"

--Ultimate Tracker
BeltalowdaMenu.constants.RO_HEADER_ULTIMATES = "|c4592FFUltimate Tracker - Vue Unifiée|r" 
BeltalowdaMenu.constants.RO_ENABLED = "Activé"
BeltalowdaMenu.constants.RO_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.RO_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.RO_ULTIMATE_OVERVIEW_ENABLED = "Aperçu des ultis du groupe activé"
BeltalowdaMenu.constants.RO_CLIENT_ULTIMATE_ENABLED = "Fenêtre individuelle activée"
BeltalowdaMenu.constants.RO_GROUP_ULTIMATES_ENABLED = "Fenêtre de groupe activée"
BeltalowdaMenu.constants.RO_SHOW_SOFT_RESOURCES = "Afficher stamina / magicka"
BeltalowdaMenu.constants.RO_DISPLAYED_ULTIMATES = "Afficher le nombre des ultis"
BeltalowdaMenu.constants.RO_COLOR_BACKGROUND = "Couleur de fond des ressources"
BeltalowdaMenu.constants.RO_COLOR_MAGICKA = "Couleur des ressources en magicka"
BeltalowdaMenu.constants.RO_COLOR_STAMINA = "Couleur des ressources en stamina"
BeltalowdaMenu.constants.RO_COLOR_OUT_OF_RANGE = "Couleur des ressources hors de portée"
BeltalowdaMenu.constants.RO_COLOR_DEAD = "Couleur des ressoucres mort"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_NOT_FULL = "Couleur des ressources entamées"
BeltalowdaMenu.constants.RO_COLOR_PROGRESS_FULL = "couleur des ressources pleines"
BeltalowdaMenu.constants.RO_COLOR_LABEL_FULL = "Couleur d'étiquette de ressource \"Pleine\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_NOT_FULL = "Couleur d'étiquette de ressources \"Entamée\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_GROUP = "Couleur d'étiquette de ressources \"Groupe\""
BeltalowdaMenu.constants.RO_COLOR_LABEL_ANNOUNCEMENT = "Couleur d'annonce"
BeltalowdaMenu.constants.RO_ANNOUNCEMENT_SIZE = "Taille d'annonce"
BeltalowdaMenu.constants.RO_IN_COMBAT_ENABLED = "In Combat State Enabled" ---xxx
BeltalowdaMenu.constants.RO_IN_COMBAT_COLOR = "In Combat Color" ---xxx
BeltalowdaMenu.constants.RO_OUT_OF_COMBAT_COLOR = "Out Of Combat Color" ---xxx
BeltalowdaMenu.constants.RO_IN_STEALTH_ENABLED = "Afficher le statut furtif"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUPS_ENABLED = "Ultis de groupe activées" 
BeltalowdaMenu.constants.RO_ULTIMATE_SORTING_MODE = "Mode de tri"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_DESTRO = "Taille de groupe bâton de destruction"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_STORM = "Taille de groupe tempête"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NORTHERNSTORM = "Taille de groupe tempête du nord"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_PERMAFROST = "Taille de groupe permafrost"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE = "Taille de groupe négation de la magie"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_OFFENSIVE = "Negate Off Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NEGATE_COUNTER = "Negate Counter Group Size"
BeltalowdaMenu.constants.RO_ULTIMATE_GROUP_SIZE_NOVA = "Taille de groupe Nova"
BeltalowdaMenu.constants.RO_ULTIMATE_DISPLAY_MODE = "Mode d'affichage" 
BeltalowdaMenu.constants.RO_MAX_DISTANCE = "Distance maximale"
BeltalowdaMenu.constants.RO_SOUND_ENABLED = "Son activé"
BeltalowdaMenu.constants.RO_SELECTED_SOUND = "Sélection du son"
BeltalowdaMenu.constants.RO_GROUPS_ENABLED = "Groupes activés"
BeltalowdaMenu.constants.RO_GROUPS_MODE = "Mode" 
BeltalowdaMenu.constants.RO_GROUPS_1_NAME = "Groupe 1 Nom"
BeltalowdaMenu.constants.RO_GROUPS_2_NAME = "Group 2 Nom"
BeltalowdaMenu.constants.RO_GROUPS_3_NAME = "Group 3 Nom"
BeltalowdaMenu.constants.RO_GROUPS_4_NAME = "Group 4 Nom"
BeltalowdaMenu.constants.RO_GROUPS_5_NAME = "Group 5 Nom"
BeltalowdaMenu.constants.RO_GROUPS_1_ENABLED = "Groupe 1 activé"
BeltalowdaMenu.constants.RO_GROUPS_2_ENABLED = "Group 2 activé"
BeltalowdaMenu.constants.RO_GROUPS_3_ENABLED = "Group 3 activé"
BeltalowdaMenu.constants.RO_GROUPS_4_ENABLED = "Group 4 activé"
BeltalowdaMenu.constants.RO_GROUPS_5_ENABLED = "Group 5 activé"
BeltalowdaMenu.constants.RO_GROUPS_1_DEFAULT = "Dégâts"
BeltalowdaMenu.constants.RO_GROUPS_2_DEFAULT = "Support"
BeltalowdaMenu.constants.RO_GROUPS_3_DEFAULT = "Soin"
BeltalowdaMenu.constants.RO_GROUPS_4_DEFAULT = "Synergie"
BeltalowdaMenu.constants.RO_GROUPS_5_DEFAULT = "Indéfini"
BeltalowdaMenu.constants.RO_GROUPS_PRIORITY = " Priorité:"
BeltalowdaMenu.constants.RO_GROUPS_GROUP = " Groupe:"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_OUT_OF_COMBAT = "Bordure hors combat"
BeltalowdaMenu.constants.RO_COLOR_GROUPS_EDGE_IN_COMBAT = "Bordure en combat"
BeltalowdaMenu.constants.RO_SIZE = "Taille"
BeltalowdaMenu.constants.RO_SPACING = "Espacement"
BeltalowdaMenu.constants.RO_SHARED_SETTING = "Ce réglage d'aperçu de ressources est partagé (Ultis / Groupes) Modifier cette valeur affectera les deux modules. Vous pouvez désactiver des modules en ajustant d'autres réglages (fenêtres)."

--HP Damage Meter
BeltalowdaMenu.constants.HDM_HEADER = "|c4592FFMesure des dégâts de santé|r"
BeltalowdaMenu.constants.HDM_ENABLED = "Activé"
BeltalowdaMenu.constants.HDM_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.HDM_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.HDM_WINDOW_ENABLED = "Fenêtre activée"
BeltalowdaMenu.constants.HDM_USING_ALPHA = "Utilisation de l'Alpha"
BeltalowdaMenu.constants.HDM_USING_COLORS = "Couleurs de fond"
BeltalowdaMenu.constants.HDM_USING_HIGHLIGHT_APPLICANT = "Surbrillance candidat"
BeltalowdaMenu.constants.HDM_AUTO_RESET = "Reset Counter Out Of Combat" ---xxx
BeltalowdaMenu.constants.HDM_SELECTED_VIEWMODE = "Sélection du mode"
BeltalowdaMenu.constants.HDM_ALIVE_COLOR = "Couleur vivant"
BeltalowdaMenu.constants.HDM_DEAD_COLOR = "Couleur mort"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_HEALER = "Couleur de fond soigneur"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_DD = "Couleur de fond DPS"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_TANK = "Couleur de fond tank"
BeltalowdaMenu.constants.HDM_BACKGROUND_COLOR_APPLICANT = "Couleur de fond candidat"
BeltalowdaMenu.constants.HDM_SIZE = "Taille"

--Potion Overview
BeltalowdaMenu.constants.PO_HEADER = "|c4592FFAperçu des potions|r"
BeltalowdaMenu.constants.PO_ENABLED = "Activé"
BeltalowdaMenu.constants.PO_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.PO_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_NO_IMMOVABLE = "Couleur de fond pas d'inamovible"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_FULL = "Couleur de fond inamovible plein"
BeltalowdaMenu.constants.PO_COLOR_BACKGROUND_IMMOVABLE_LOW = "Couleur de fond inamovible bas"
BeltalowdaMenu.constants.PO_COLOR_PROGRESS_IMMOVABLE = "Couleur de fond inamovible"
-- U30+ Change (Temporary Fix)
--[[
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Couleur de progression potions (fabriquée)"
BeltalowdaMenu.constants.PO_COLOR_CROWN_PROGRESS_POTION = "Couleur de progression potions (couronnes)"
BeltalowdaMenu.constants.PO_COLOR_NON_CRAFTED_PROGRESS_POTION = "Couleur de progression potion (non fabriquée)"
BeltalowdaMenu.constants.PO_COLOR_ALLIANCE_PROGRESS_POTION = "Couleur de progression potion (Alliance)"
]]
BeltalowdaMenu.constants.PO_COLOR_CRAFTED_PROGRESS_POTION = "Couleur de progression potions"
BeltalowdaMenu.constants.PO_COLOR_LABEL_IMMOVABLE = "Couleur d'étiquette inamovible"
BeltalowdaMenu.constants.PO_COLOR_LABEL_POTION = "Couleur d'étiquette potion"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_IMMOVABLE = "Couleur de fond inamovible"
BeltalowdaMenu.constants.PO_COLOR_BACKDROP_POTION = "Couleur de fond potion"
BeltalowdaMenu.constants.PO_SOUND_ENABLED = "Son activé"
BeltalowdaMenu.constants.PO_SELECTED_SOUND = "Sélection du son"

--Detonation Tracker
BeltalowdaMenu.constants.DT_HEADER = "|c4592FFSuivi des détonations / shalks|r"
BeltalowdaMenu.constants.DT_ENABLED = "Activé"
BeltalowdaMenu.constants.DT_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.DT_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.DT_FONT_COLOR_DETONATION = "Détonation: Couleur de police"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DETONATION = "Détonation: Couleur de progression"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT = "Assaut: Couleur de police"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT = "Assaut: Couleur de progression"
BeltalowdaMenu.constants.DT_FONT_COLOR_SUBTERRANEAN_ASSAULT2 = "Assaut 2: Couleur de police"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_SUBTERRANEAN_ASSAULT2 = "Assaut 2: Couleur de progression"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE = "Fissure: Couleur de police"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE = "Fissure: Couleur de progression"
BeltalowdaMenu.constants.DT_FONT_COLOR_DEEP_FISSURE2 = "Fissure 2: Couleur de police"
BeltalowdaMenu.constants.DT_PROGRESS_COLOR_DEEP_FISSURE2 = "Fissure 2: Couleur de progression"
BeltalowdaMenu.constants.DT_SIZE = "Taille"
BeltalowdaMenu.constants.DT_MODE = "Mode"
BeltalowdaMenu.constants.DT_SMOOTH_TRANSITION = "Transition douce"

--Group Beams
BeltalowdaMenu.constants.GB_HEADER = "|c4592FFFaisceaux de groupe|r"
BeltalowdaMenu.constants.GB_DESCRIPTION = "Le rayon du joueur dépend du rôle qui lui a été assigné. Les rôles peuvent être répartis par le chef de groupe ou par le joueur."
BeltalowdaMenu.constants.GB_ENABLED = "Activé"
BeltalowdaMenu.constants.GB_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.GB_HIDE_WHEN_DEAD = "Cacher quand mort"
BeltalowdaMenu.constants.GB_SIZE = "Taille"
BeltalowdaMenu.constants.GB_SELECTED_BEAM = "Sélection du faisceau"
BeltalowdaMenu.constants.GB_ROLE_RAPID_ENABLED = "Manoeuvre rapide activée"
BeltalowdaMenu.constants.GB_ROLE_RAPID_COLOR = "Couleur de maoeuvre rapide"
BeltalowdaMenu.constants.GB_ROLE_PURGE_ENABLED = "Purge activée"
BeltalowdaMenu.constants.GB_ROLE_PURGE_COLOR = "Couleur de purge"
BeltalowdaMenu.constants.GB_ROLE_HEAL_ENABLED = "Soin activé"
BeltalowdaMenu.constants.GB_ROLE_HEAL_COLOR = "Couleur de soin"
BeltalowdaMenu.constants.GB_ROLE_DD_ENABLED = "APS activé"
BeltalowdaMenu.constants.GB_ROLE_DD_COLOR = "Couleur de DPS"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_ENABLED = "Synergie activée"
BeltalowdaMenu.constants.GB_ROLE_SYNERGY_COLOR = "Couleur synergie"
BeltalowdaMenu.constants.GB_ROLE_CC_ENABLED = "CC activé"
BeltalowdaMenu.constants.GB_ROLE_CC_COLOR = "Couleur de CC"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_ENABLED = "Soutien activé"
BeltalowdaMenu.constants.GB_ROLE_SUPPORT_COLOR = "Couleur de soutien"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_ENABLED = "Indéfini activé"
BeltalowdaMenu.constants.GB_ROLE_PLACEHOLDER_COLOR = "Couleur d'indéfini"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_ENABLED = "Candidat activé"
BeltalowdaMenu.constants.GB_ROLE_APPLICANT_COLOR = "Couleur de candidat"

--I See Dead People
BeltalowdaMenu.constants.ISDP_HEADER = "|c4592FFJe vois les morts|r"
BeltalowdaMenu.constants.ISDP_ENABLED = "Activé"
BeltalowdaMenu.constants.ISDP_PVP_ONLY = "Uniquement en PvP"
BeltalowdaMenu.constants.ISDP_SIZE = "Taille"
BeltalowdaMenu.constants.ISDP_SELECTED_BEAM = "Couleur de rayon - sélectionné"
BeltalowdaMenu.constants.ISDP_COLOR_DEAD = "Couleur mort"
BeltalowdaMenu.constants.ISDP_COLOR_BEING_RESURRECTED = "Couleur en cours de résurrection"
BeltalowdaMenu.constants.ISDP_COLOR_RESURRECTED = "Couleur ressuscité"

--Compass
BeltalowdaMenu.constants.COMPASS_HEADER = "|cFF8174Réglages de la boussole|r"
--YACS
BeltalowdaMenu.constants.YACS_HEADER = "|c4592FFYet Another Compass|r"
BeltalowdaMenu.constants.YACS_CHK_ADDON_ENABLED = "Activé"
BeltalowdaMenu.constants.YACS_CHK_PVP = "Activé en PvP"
BeltalowdaMenu.constants.YACS_CHK_PVE = "Activé en PvE"
BeltalowdaMenu.constants.YACS_CHK_COMBAT = "Activé en combat"
BeltalowdaMenu.constants.YACS_CHK_MOVABLE = "Boussole déplaçable"
BeltalowdaMenu.constants.YACS_COLOR_COMPASS = "Couleur de la boussole"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE = "Taille de la boussole"
BeltalowdaMenu.constants.YACS_COMPASS_SIZE_TOOLTIPE = "Règle la taille de la boussole"
BeltalowdaMenu.constants.YACS_COMPASS_STYLE = "Style"
BeltalowdaMenu.constants.YACS_COMPASS_STYLE_TOOLTIP = "Sélection du type de boussole"
BeltalowdaMenu.constants.YACS_RESTORE_DEFAULTS = "Valeurs par défaut"

--SC
BeltalowdaMenu.constants.COMPASS_SC_HEADER = "|c4592FFSimple Compass|r"
BeltalowdaMenu.constants.COMPASS_SC_ENABLED = "Activé"
BeltalowdaMenu.constants.COMPASS_SC_PVP = "Activé en PvP"
BeltalowdaMenu.constants.COMPASS_SC_PVE = "Activé en PvE"
BeltalowdaMenu.constants.COMPASS_SC_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_BACKDROP = "Couleur de fond"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_NORTH = "Couleur direction nord"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_SOUTH = "Couleur direction sud"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_WEST = "Couleur direction ouest"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_EAST = "Couleur direction est"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_DIRECTION_OTHERS = "Couleur autres directions"
BeltalowdaMenu.constants.COMPASS_SC_COLOR_MARKERS = "Couleur marqueurs"

--Toolbox
BeltalowdaMenu.constants.TOOLBOX_HEADER = "|cFF8174Réglages de la boîte à outils|r"
--Siege Merchant
BeltalowdaMenu.constants.SM_HEADER = "|c4592FFMarchand d'engins de siège|r"
BeltalowdaMenu.constants.SM_ENABLED = "Activé"
BeltalowdaMenu.constants.SM_SEND_CHAT_MESSAGES = "Envoyer les messages au chat"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_WALL = "Kit de réparation de murs de forteresse"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_DOOR = "Kit de réparation de portes de forteresse"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_SIEGE = "Kit de réparation d'engins de siège"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_FIRE = "Balliste de feu"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_STONE = "Balliste"
BeltalowdaMenu.constants.SM_ITEM_BALLISTA_LIGHTNING = "Balliste de foudre"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_FIRE = "Trébuchet de feu"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_STONE = "Trébuchet de pierres"
BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_ICE = "Trébuchet de glace"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_MEATBAG = "Trébuchet de sacs à viande"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_OIL = "Catapulte à huile"
BeltalowdaMenu.constants.SM_ITEM_CATAPULT_SCATTERSHOT = "Catapulte ??? "
BeltalowdaMenu.constants.SM_ITEM_OIL = "Huile enflammée"
BeltalowdaMenu.constants.SM_ITEM_CAMP = "Camp avancé"
BeltalowdaMenu.constants.SM_ITEM_RAM = "Bélier"
BeltalowdaMenu.constants.SM_ITEM_KEEP_RECALL = "Pierre de retour au fort"
BeltalowdaMenu.constants.SM_ITEM_DESTRUCTIBLE_REPAIR = "Kit de réparation de pont et de passages"
BeltalowdaMenu.constants.SM_MIN = "Minimum"
BeltalowdaMenu.constants.SM_MAX = "Maximum"
BeltalowdaMenu.constants.SM_PAYMENT_OPTIONS = "Options de paiement"
BeltalowdaMenu.constants.SM_ITEM_REPAIR_ALL = "Nécessaire de réparation de Cyrodiil"
BeltalowdaMenu.constants.SM_ITEM_POT_RED = "Lampée de Santé d'alliance"
BeltalowdaMenu.constants.SM_ITEM_POT_GREEN = "Lampée de bataille d'alliance"
BeltalowdaMenu.constants.SM_ITEM_POT_BLUE = "Lampée de sorts d'alliance"

--Rechargeur
BeltalowdaMenu.constants.RECHARGER_HEADER = "|c4592FFRechargement des armes|r"
BeltalowdaMenu.constants.RECHARGER_ENABLED = "Activé"
BeltalowdaMenu.constants.RECHARGER_SEND_CHAT_MESSAGES = "Envoyer les messages au chat"
BeltalowdaMenu.constants.RECHARGER_PERCENT = "Pourcentage minimum de recharge"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_WARNING = "Alerte si stock de pierres d'âmes épuisé"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_WARNING = "Alerte si  stock de pierres d'âmes bientôt épuisé"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_THRESHOLD_SLIDER = "Seuil de pierres d'âmes"
BeltalowdaMenu.constants.RECHARGER_SOULGEMS_EMPTY_LOGIN_WARNING = "Alerte de pierres d'âmes au chargement"
BeltalowdaMenu.constants.RECHARGER_INTERVAL = "Intervalle de vérification"

--Keep Claimer
BeltalowdaMenu.constants.KC_HEADER = "|c4592FFRevendication de forteresses|r"
BeltalowdaMenu.constants.KC_ENABLED = "Activé"
BeltalowdaMenu.constants.KC_GUILD_1 = "Priorité 1"
BeltalowdaMenu.constants.KC_GUILD_2 = "Priorité 2"
BeltalowdaMenu.constants.KC_GUILD_3 = "Priorité 3"
BeltalowdaMenu.constants.KC_GUILD_4 = "Priorité 4"
BeltalowdaMenu.constants.KC_GUILD_5 = "Priorité 5"
BeltalowdaMenu.constants.KC_CLAIM_KEEPS = "Revendiquer les forts"
BeltalowdaMenu.constants.KC_CLAIM_OUTPOSTS = "Revendiquer les avant-postes"
BeltalowdaMenu.constants.KC_CLAIM_RESOURCES = "Revendiquer les ressources"

--Buff Food Tracker
BeltalowdaMenu.constants.BFT_HEADER = "|c4592FFSuivi des buffs d'aliments|r"
BeltalowdaMenu.constants.BFT_ENABLED = "Activé"
BeltalowdaMenu.constants.BFT_PVP_ONLY = "Uniquemen en PvP"
BeltalowdaMenu.constants.BFT_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.BFT_SIZE = "Taille de l'alerte"
BeltalowdaMenu.constants.BFT_COLOR = "Couleur de l'alerte"
BeltalowdaMenu.constants.BFT_SOUND_ENABLED = "Son activé"
BeltalowdaMenu.constants.BFT_SELECTED_SOUND = "Sélection du son"
BeltalowdaMenu.constants.BFT_WARNING_TIMER = "Timer d'alerte"

--Journal de Cyrodiil
BeltalowdaMenu.constants.CL_HEADER = "|c4592FFJournal de Cyrodiil|r"
BeltalowdaMenu.constants.CL_ENABLED = "Activé"
BeltalowdaMenu.constants.CL_GUILD_CLAIM_ENABLED = "Messages concernant les revendications de guilde"
BeltalowdaMenu.constants.CL_GUILD_LOST_ENABLED = "Messages concernant les échecs de revendication"
BeltalowdaMenu.constants.CL_UA_ENABLED = "Messages d'attaque"
BeltalowdaMenu.constants.CL_UA_LOST_ENABLED = "Messages de fin d'attaque"
BeltalowdaMenu.constants.CL_KEEP_ALLIANCE_CHANGED_ENABLED = "Messages de changement d'alliance"
BeltalowdaMenu.constants.CL_TICK_DEFENSE = "Messages de ticks défensifs"
BeltalowdaMenu.constants.CL_TICK_OFFENSE = "Messages de ticks offensifs"
BeltalowdaMenu.constants.CL_SCROLL_NOTIFICATIONS = "Défilement des messages"
BeltalowdaMenu.constants.CL_EMPEROR_ENABLED = "Messages concernant d'empereur"
BeltalowdaMenu.constants.CL_QUEST_ENABLED = "Messages de quêtes"
BeltalowdaMenu.constants.CL_BATTLEGROUND_ENABLED = "Messages de champs de bataille"
BeltalowdaMenu.constants.CL_DAEDRIC_ARTIFACT_ENABLED = "Alertes artifacts daédriques"

--Cyrodiil Status
BeltalowdaMenu.constants.CS_HEADER = "|c4592FFStatut de Cyrodiil|r"
BeltalowdaMenu.constants.CS_ENABLED = "Activé"
BeltalowdaMenu.constants.CS_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.CS_HIDE_ON_WORLDMAP = "Cacher sur la carte"
BeltalowdaMenu.constants.CS_SHOW_FLAGS = "Afficher les drapeaux"
BeltalowdaMenu.constants.CS_SHOW_SIEGES = "Afficher les sièges"
BeltalowdaMenu.constants.CS_SHOW_OWNER_CHANGES = "Afficher les timers de changements de bannières"
BeltalowdaMenu.constants.CS_SHOW_ACTION_TIMERS = "Afficher les timers d'actions"
BeltalowdaMenu.constants.CS_COLOR_DEFAULT = "Couleur par défaut"
BeltalowdaMenu.constants.CS_COLOR_COOLDOWN = "Couleur de temps de recharge"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_POSITIVE = "Couleur de changement de drapeau positif"
BeltalowdaMenu.constants.CS_COLOR_FLIPS_NEGATIVE = "Couleur de changement de drapeau négatif"
BeltalowdaMenu.constants.CS_SHOW_KEEPS = "Montrer les forts"
BeltalowdaMenu.constants.CS_SHOW_OUTPOSTS = "Montrer les avant-postes"
BeltalowdaMenu.constants.CS_SHOW_RESOURCES = "Montrer les ressources"
BeltalowdaMenu.constants.CS_SHOW_VILLAGES = "Montrer les villages"
BeltalowdaMenu.constants.CS_SHOW_TEMPLES = "Montrer les temples"
BeltalowdaMenu.constants.CS_SHOW_DESTRUCTIBLES = "Montrer destructible"

--Enhancements
BeltalowdaMenu.constants.ENHANCE_HEADER = "|c4592FFAméliorations|r"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_ENABLED = "Désactiver le suivi de quêtes"
BeltalowdaMenu.constants.ENHANCE_QUEST_TRACKER_PVP_ONLY = "Suivi de quêtes uniquement en PvP"
BeltalowdaMenu.constants.ENHANCE_COMPASS_TWEAKS_ENABLED = "Activer les améliorations de boussole"
BeltalowdaMenu.constants.ENHANCE_COMPASS_PVP_ONLY = "Boussole uniquement en PvP"
BeltalowdaMenu.constants.ENHANCE_COMPASS_HIDDEN = "Cacher la boussole"
BeltalowdaMenu.constants.ENHANCE_COMPASS_WIDTH = "Largeur de la boussole"
BeltalowdaMenu.constants.ENHANCE_ALERTS_TWEAKS_ENABLED = "Amélioration des alertes activée"
BeltalowdaMenu.constants.ENHANCE_ALERTS_PVP_ONLY = "Alertes uniqiuement en PvP"
BeltalowdaMenu.constants.ENHANCE_ALERTS_HIDDEN = "Cacher les alertes"
BeltalowdaMenu.constants.ENHANCE_ALERTS_POSITION = "Position des alertes"
BeltalowdaMenu.constants.ENHANCE_ALERTS_COLOR = "Couleur des alertes"
BeltalowdaMenu.constants.ENHANCE_RESPAWN_TIMER_ENABLED = "Désactiver le chronomètre de résurrection"

--Respawner
BeltalowdaMenu.constants.RESPAWNER_HEADER = "|c4592FFRésurrection|r"
BeltalowdaMenu.constants.RESPAWNER_ENABLED = "Activé"
BeltalowdaMenu.constants.RESPAWNER_RESTRICTED_PORT = "Distance limitée"

--Camp Preview
BeltalowdaMenu.constants.CP_HEADER = "|c4592FFPrévisualisation du camp|r"
BeltalowdaMenu.constants.CP_ENABLED = "Activé"

--Synergy Prevention
BeltalowdaMenu.constants.SP_HEADER = "|c4592FFPrévention des synergies|r"
BeltalowdaMenu.constants.SP_ENABLED = "Activé"
BeltalowdaMenu.constants.SP_PVP_ONLY = "Seulement en PvP"
BeltalowdaMenu.constants.SP_WINDOW_ENABLED = "Fenêtre activée"
BeltalowdaMenu.constants.SP_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.SP_MODE = "Mode"
BeltalowdaMenu.constants.SP_MAX_DISTANCE = "Distance maximale"
BeltalowdaMenu.constants.SP_SYNERGY_COMBUSTION_SHARD = "Empêcher Combustion / Eclats"
BeltalowdaMenu.constants.SP_SYNERGY_TALONS = "Empêcher Serres"
BeltalowdaMenu.constants.SP_SYNERGY_NOVA = "Empêcher Nova"
BeltalowdaMenu.constants.SP_SYNERGY_BLOOD_ALTAR = "Empêcher Entonnoir de sang"
BeltalowdaMenu.constants.SP_SYNERGY_STANDARD = "Empêcher Etendard"
BeltalowdaMenu.constants.SP_SYNERGY_PURGE = "Empêcher Rituel"
BeltalowdaMenu.constants.SP_SYNERGY_BONE_SHIELD = "Empêcher bouclier d'os"
BeltalowdaMenu.constants.SP_SYNERGY_FLOOD_CONDUIT = "Empêcher canalisation"
BeltalowdaMenu.constants.SP_SYNERGY_ATRONACH = "Empêcher Atronach"
BeltalowdaMenu.constants.SP_SYNERGY_TRAPPING_WEBS = "Empêcher toiles entravantes"
BeltalowdaMenu.constants.SP_SYNERGY_RADIATE = "Empêcher Faisceau"
BeltalowdaMenu.constants.SP_SYNERGY_CONSUMING_DARKNESS = "Empêcher Ténèbres dévorantes"
BeltalowdaMenu.constants.SP_SYNERGY_SOUL_LEECH = "Empêcher absorption d'âme"
BeltalowdaMenu.constants.SP_SYNERGY_WARDEN_HEALING = "Empêcher graine curative"
BeltalowdaMenu.constants.SP_SYNERGY_GRAVE_ROBBER = "Empêcher tombe"
BeltalowdaMenu.constants.SP_SYNERGY_PURE_AGONY = "Empêcher agonie pure"
BeltalowdaMenu.constants.SP_SYNERGY_ICY_ESCAPE = "Empêcher Évasion glacée"
BeltalowdaMenu.constants.SP_SYNERGY_SANGUINE_BURST = "Empêcher Détonation sanguine"
BeltalowdaMenu.constants.SP_SYNERGY_HEED_THE_CALL = "Empêcher Répondez à l'appel"
BeltalowdaMenu.constants.SP_SYNERGY_URSUS = "Empêcher Bouclier d'Ursus" ---xxx
BeltalowdaMenu.constants.SP_SYNERGY_GRYPHON = "Empêcher Représailles du griffon" ---xxx
BeltalowdaMenu.constants.SP_SYNERGY_RUNEBREAK = "Empêcher Brusire de rune" ---xxx
BeltalowdaMenu.constants.SP_SYNERGY_PASSAGE = "Empêcher Passage" ---xxx

--Aperçu des synergies
BeltalowdaMenu.constants.SO_HEADER = "|c4592FFSynergy Tracking|r"
BeltalowdaMenu.constants.SO_ENABLED = "Activé"
BeltalowdaMenu.constants.SO_WINDOW_ENABLED = "Fenâtre activée"
BeltalowdaMenu.constants.SO_PVP_ONLY = "Seulement en PvP"
BeltalowdaMenu.constants.SO_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.SO_DISPLAY_MODE = "Mode d'affichage"
BeltalowdaMenu.constants.SO_TABLE_MODE = "Mode tableau"
BeltalowdaMenu.constants.SO_SIZE = "Taille"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_BACKDROP = "Couleur de fond synergies"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY_PROGRESS = "Couleur de progression synergies"
BeltalowdaMenu.constants.SO_COLOR_SYNERGY = "Couleur de synergie"
BeltalowdaMenu.constants.SO_COLOR_BACKGROUND = "Couleur de fond"
BeltalowdaMenu.constants.SO_COLOR_TEXT = "Couleur du texte"
BeltalowdaMenu.constants.SO_SYNERGY_COMBUSTION_SHARD = "Afficher combustion / éclats"
BeltalowdaMenu.constants.SO_SYNERGY_TALONS = "Afficher Serres"
BeltalowdaMenu.constants.SO_SYNERGY_NOVA = "Afficher Nova"
BeltalowdaMenu.constants.SO_SYNERGY_BLOOD_ALTAR = "Afficher Autel"
BeltalowdaMenu.constants.SO_SYNERGY_STANDARD = "Afficher Etendard"
BeltalowdaMenu.constants.SO_SYNERGY_PURGE = "Afficher Rituel"
BeltalowdaMenu.constants.SO_SYNERGY_BONE_SHIELD = "Afficher Bouclier d'os"
BeltalowdaMenu.constants.SO_SYNERGY_FLOOD_CONDUIT = "Afficher Canalisation"
BeltalowdaMenu.constants.SO_SYNERGY_ATRONACH = "Afficher Atronach"
BeltalowdaMenu.constants.SO_SYNERGY_TRAPPING_WEBS = "Afficher Toiles entravantes"
BeltalowdaMenu.constants.SO_SYNERGY_RADIATE = "Afficher Faisceau"
BeltalowdaMenu.constants.SO_SYNERGY_CONSUMING_DARKNESS = "Afficher Ténèbres dévorantes"
BeltalowdaMenu.constants.SO_SYNERGY_SOUL_LEECH = "Afficher absorption d'âme"
BeltalowdaMenu.constants.SO_SYNERGY_WARDEN_HEALING = "Afficher graine curative"
BeltalowdaMenu.constants.SO_SYNERGY_GRAVE_ROBBER = "Afficher tomber"
BeltalowdaMenu.constants.SO_SYNERGY_PURE_AGONY = "Afficher agonie pure"
BeltalowdaMenu.constants.SO_SYNERGY_ICY_ESCAPE = "Afficher Évasion glacée"
BeltalowdaMenu.constants.SO_SYNERGY_SANGUINE_BURST = "Afficher Détonation sanguine"
BeltalowdaMenu.constants.SO_SYNERGY_HEED_THE_CALL = "Afficher Répondez à l'appel"
BeltalowdaMenu.constants.SO_SYNERGY_URSUS = "Afficher Bouclier d'Ursus" ---xxx
BeltalowdaMenu.constants.SO_SYNERGY_GRYPHON = "Afficher Représailles du griffon" ---xxx
BeltalowdaMenu.constants.SO_SYNERGY_RUNEBREAK = "Afficher Brusire de rune" ---xxx
BeltalowdaMenu.constants.SO_REDUCED_SPACING = "Réduite Espacement" ---xxx
BeltalowdaMenu.constants.SO_SYNERGY_PASSAGE = "Réduite Passage" ---xxx

--Role Assignment
BeltalowdaMenu.constants.RA_HEADER = "|c4592FFRépartition des rôles|r"
BeltalowdaMenu.constants.RA_ENABLED = "Activé"
BeltalowdaMenu.constants.RA_OVERRIDE_ALLOWED = "Autoriser l'écrasement"
BeltalowdaMenu.constants.RA_ROLE = "Rôle du personnage"

--Campaign Joiner
BeltalowdaMenu.constants.CAJ_HEADER = "|c4592FFRejoindre automatiquement la campagne|r"
BeltalowdaMenu.constants.CAJ_ENABLED = "Activé"

--AvA Messages
BeltalowdaMenu.constants.AM_HEADER = "|c4592FFAvA Messages|r"
BeltalowdaMenu.constants.AM_PVP_ONLY = "Seulement en PvP"
BeltalowdaMenu.constants.AM_CORONATE_EMPEROR = "Messages de couronnement d'empereur"
BeltalowdaMenu.constants.AM_DEPOSE_EMPEROR = "Messages de chute d'empereur"
BeltalowdaMenu.constants.AM_KEEP_GATE = "Messages de fermeture de portes de forteresses"
BeltalowdaMenu.constants.AM_ARTIFACT_CONTROL = "Messages d'artefacts"
BeltalowdaMenu.constants.AM_REVENGE_KILL = "Messages de revanches"
BeltalowdaMenu.constants.AM_AVENGE_KILL = "Messages de vengeance"
BeltalowdaMenu.constants.AM_QUEST_ADDED = "Messages de nouvelles quêtes"
BeltalowdaMenu.constants.AM_QUEST_COMPLETE = "Messages de quêtes terminées"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_COUNTER_CHANGED = "Messages de compteurs de quêtes"
BeltalowdaMenu.constants.AM_QUEST_CONDITION_CHANGED = "Messages de ocnditions de quêtes"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED = "Messages d'apparition d'artefacts daédriques"
BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED = "Message dd'état des artéfacts daédriques"

--Util
BeltalowdaMenu.constants.UTIL_HEADER = "|cFF8174Réglage des outils|r"

--Util Networking
BeltalowdaMenu.constants.NET_HEADER = "|c4592FFRéseau|r"
BeltalowdaMenu.constants.NET_ENABLED = "Activé"
BeltalowdaMenu.constants.NET_URGENT_MODE = "Mode urgent"
BeltalowdaMenu.constants.NET_INTERVAL = "Update Interval" ---xxx

--Util Group
BeltalowdaMenu.constants.UTIL_GROUP_HEADER = "|c4592FFGroupe|r"
BeltalowdaMenu.constants.UTIL_GROUP_DISPLAY_TYPE = "Type d'affichage"

--Util Alliance Color
BeltalowdaMenu.constants.AC_HEADER = "|c4592FFCouleurs d'alliance|r"
BeltalowdaMenu.constants.AC_DC_COLOR = "Couleur Daguefilante"
BeltalowdaMenu.constants.AC_EP_COLOR = "Couleur Pacte"
BeltalowdaMenu.constants.AC_AD_COLOR = "Couleur Domaine"
BeltalowdaMenu.constants.AC_NO_ALLIANCE_COLOR = "Pas de couleur d'alliances"

--Chat System
BeltalowdaMenu.constants.CHAT_HEADER = "|c4592FFSystème de chat|r"
BeltalowdaMenu.constants.CHAT_ENABLED = "Activé"
BeltalowdaMenu.constants.CHAT_SELECTED_TAB = "Onglet sélectionné"
BeltalowdaMenu.constants.CHAT_REFRESH = "Rafraîchir"
BeltalowdaMenu.constants.CHAT_WARNINGS_ONLY = "Afficher les alertes"
BeltalowdaMenu.constants.CHAT_DEBUG_ONLY = "Afficher les infos de débogage"
BeltalowdaMenu.constants.CHAT_NORMAL_ONLY = "Affichage normal"
BeltalowdaMenu.constants.CHAT_PREFIX_ENABLED = "Préfixe activé"
BeltalowdaMenu.constants.CHAT_RDK_PREFIX_ENABLED = "Préfixe Beltalowda activé"
BeltalowdaMenu.constants.CHAT_COLOR_PREFIX = "Couleur de préfixe"
BeltalowdaMenu.constants.CHAT_COLOR_BODY = "Couleur de police - texte principal"
BeltalowdaMenu.constants.CHAT_COLOR_WARNING = "Couleur d'alerte"
BeltalowdaMenu.constants.CHAT_COLOR_DEBUG = "Couleur de débogage"
BeltalowdaMenu.constants.CHAT_COLOR_PLAYER = "Couleur de joueur"
BeltalowdaMenu.constants.CHAT_ADD_TIMESTAMP = "Ajouter heure"
BeltalowdaMenu.constants.CHAT_HIDE_SECONDS = "Masquer les secondes"
BeltalowdaMenu.constants.CHAT_COLOR_TIMESTAMP = "Couleur de l'heure"

--Class Role
BeltalowdaMenu.constants.CR_HEADER = "|cFF8174Classe / Rôle|r"

--BG Templar Heal
BeltalowdaMenu.constants.CRBG_TPHEAL_HEADER = "|c4592FFSoigneur templier (Groupe)|r"
BeltalowdaMenu.constants.CRBG_TPHEAL_ENABLED = "Activé"
BeltalowdaMenu.constants.CRBG_TPHEAL_PVP_ONLY = "Seulement en PvP"
BeltalowdaMenu.constants.CRBG_TPHEAL_POSITION_FIXED = "Position fixe"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_DAMAGE = "Progression des dégâts"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_DAMAGE = "Etiquette des dégâts"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_HEALING = "Progression des soins"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_HEALING = "Etiquette des soins"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_PROGRESS_RECOVERY = "Progression des récupérations"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_RECOVERY = "Etiquette des récupérations"
BeltalowdaMenu.constants.CRBG_TPHEAL_COLOR_LABEL_COOLDOWN = "Etiquette du temps de recharge"

--AddOn Integration
BeltalowdaMenu.constants.ADDON_INTEGRATION_HEADER = "|cFF8174Réglage de l'intégration des add-ons|r"
--Miats Pvp Alerts
BeltalowdaMenu.constants.MPAI_HEADER = "|c4592FFMiat Pvp Alerts|r"
BeltalowdaMenu.constants.MPAI_ENABLED = "Effacer après login (Activé)"
BeltalowdaMenu.constants.MPAI_ONPLAYERACTIVATION = "Effacer après écran de chargement"
BeltalowdaMenu.constants.MPAI_CLEAR_VARS = "Effacer les variables"

--Admin
BeltalowdaMenu.constants.ADMIN_HEADER = "|cFF8174Réglages administrateur|r"
--Group Share
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_HEADER = "|c4592FFPartage de groupe|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ENABLED = "Activé"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_WARNING = "|cFF0000Activer cette fonction permettra à n'importe quel membre de votre guilde disposant du rang 1 à 3 d'appeler les configurations autorisées|r"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CLIENT_CONFIGURATION = "Permettre la configuration du client"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_ADDON_CONFIGURATION = "Permettre la configuration de l'add-on"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_STATS = "Permettre les stats"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_SKILLS = "Permettre les compétences"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_EQUIPMENT = "Permettre l'équipement"
BeltalowdaMenu.constants.ADMIN_GROUP_SHARE_ALLOW_CP = "Permettre les points de champion"

--Base
--Couronne
BeltalowdaCrown.constants = BeltalowdaCrown.constants or {}
BeltalowdaCrown.constants.PAPA_CROWN_DETECTED = "Papa Crown détecté. Les réglages de couronne seront ignorés."
BeltalowdaCrown.constants.SANCTS_ULTIMATE_ORGANIZER_DETECTED = "Sancts Ultimate Organizer détecté. Les réglages de couronnes seront ignorés."
BeltalowdaCrown.constants.CROWN_OF_CYRODIIL_DETECTED = "Crown of Cyrodiil détecté. Les réglages de couronnes seront ignorés."
BeltalowdaCrown.config.crowns[1].name = "Couronne: Standard"
BeltalowdaCrown.config.crowns[2].name = "Flèche: Blanc"
BeltalowdaCrown.config.crowns[3].name = "Flèche: Bleu"
BeltalowdaCrown.config.crowns[4].name = "Flèche: Bleu clair"
BeltalowdaCrown.config.crowns[5].name = "Flèche: Jaune"
BeltalowdaCrown.config.crowns[6].name = "Flèche: Vert clair"
BeltalowdaCrown.config.crowns[7].name = "Flèche: Rouge"
BeltalowdaCrown.config.crowns[8].name = "Flèche: Rose"
BeltalowdaCrown.config.crowns[9].name = "Couronne: Blanc"
BeltalowdaCrown.config.crowns[10].name = "Beltalowda: Blanc"

--Auto Invite
BeltalowdaAI.constants = BeltalowdaAI.constants or {}
BeltalowdaAI.constants.AI_MENU_NAME = "Auto Invite"
BeltalowdaAI.constants.AI_ENABLED = "Activé"
BeltalowdaAI.constants.AI_INVITE_TEXT = "Texte d'invitation"
BeltalowdaAI.constants.AI_SENT_INVITE_TO = "Invitation envoyée à|c%s%s|c%s.|r"
BeltalowdaAI.constants.AI_NOT_LEADER_SEND_TO = "L'invitation n'a pas été envoyée à|r |c%s%s|c%s. You don't have the crown.|r"
BeltalowdaAI.constants.AI_FULL_GROUP = "Aucune invitation n'a été envoyée. Le groupe est déjà complet." ---xxx
BeltalowdaAI.constants.AI_REQUIREMENTS_NOT_MET = "L'invitation n'a pas été envoyée à|r |c%s%s |c%s. Critères non remplis.|r"
BeltalowdaAI.constants.AI_AUTO_KICK_MESSAGE = "Le membre du groupe|r |c%s%s|r |c%swill sera retiré du groupe.|r"
BeltalowdaAI.constants.TOGGLE_AI = "Enclencher Auto Invite"
BeltalowdaAI.constants.AI_ENABLED_TRUE = "Auto Invite activé."
BeltalowdaAI.constants.AI_ENABLED_FALSE = "Auto Invite désactivé."
BeltalowdaAI.constants.AI_MEMBER_LEFT = "Le membre|r |c%s%s|r |c%sa quitté le groupe."

--Follow The Crown Visual
BeltalowdaFtcv.textures[1].name = "Flèche 1"
BeltalowdaFtcv.textures[2].name = "Flèche 2"
BeltalowdaFtcv.textures[3].name = "Flèche 3"
BeltalowdaFtcv.textures[4].name = "Flèche 4"
BeltalowdaFtcv.textures[5].name = "Flèche 5"
BeltalowdaFtcv.textures[6].name = "Flèche 6"
BeltalowdaFtcv.textures[7].name = "Flèche 7"
BeltalowdaFtcv.textures[8].name = "Flèche 8"

--Follow The Crown Warnings
BeltalowdaFtcw.constants = BeltalowdaFtcw.constants or {}
BeltalowdaFtcw.constants.FTCW_MAX_DISTANCE ="Distance maximale atteinte!!!"

--Resource Overview
BeltalowdaOverview.config.ultimateModes = BeltalowdaOverview.config.ultimateModes or {}
--BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_GROUP] = "Consignes de groupe"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_READINESS] = "Prêt"
BeltalowdaOverview.config.ultimateModes[BeltalowdaOverview.constants.ultimateModes.ORDER_BY_NAME] = "Nom"
BeltalowdaOverview.constants.BOOM = "BOUM"
BeltalowdaOverview.constants.TOGGLE_BOOM = "Envoyer BOUM"
BeltalowdaOverview.constants.IDENENTIFIER_DESTRUCTION = "Destro"
BeltalowdaOverview.constants.IDENENTIFIER_STORM = "Tempête"
BeltalowdaOverview.constants.IDENENTIFIER_NEGATE = "Neg."
BeltalowdaOverview.constants.IDENENTIFIER_NOVA = "Nova"
BeltalowdaOverview.config.groupsModes = BeltalowdaOverview.config.groupsModes or {}
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_NAME] = "Priorité - Nom"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PRIORITY_PERCENT] = "Priorité - Pourcentage"
BeltalowdaOverview.config.groupsModes[BeltalowdaOverview.constants.groupsModes.MODE_PERCENT] = "Pourcentage"
BeltalowdaOverview.config.displayModes = BeltalowdaOverview.config.displayModes or {}
BeltalowdaOverview.config.displayModes[BeltalowdaOverview.constants.displayModes.CLASSIC] = "Classique"

--Healing / Damage Meter
BeltalowdaHdm.constants = BeltalowdaHdm.constants or {}
BeltalowdaHdm.constants.TITLE_HEALING = "Soins"
BeltalowdaHdm.constants.TITLE_DAMAGE = "Dégâts"
BeltalowdaHdm.constants.viewModes = BeltalowdaHdm.constants.viewModes or {}
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH] = "Les deux"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_HEALING] = "Soins"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_DAMAGE] = "Dégâts"
BeltalowdaHdm.constants.viewModes[BeltalowdaHdm.constants.VIEWMODE_BOTH_ON_TOP] = "Les deux (Verticalement)"
BeltalowdaHdm.constants.RESET_COUNTER = "Reset Counter" ---xxx

--Detonation Tracker
BeltalowdaDt.constants.modes = BeltalowdaDt.constants.modes or {}
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_BOTH] = "Les deux"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_DETONATION] = "Détonation"
BeltalowdaDt.constants.modes[BeltalowdaDt.constants.MODE_SHALK] = "Shalks"

--I See Dead People
BeltalowdaIsdp.constants = BeltalowdaIsdp.constants or {}
BeltalowdaIsdp.constants.BEAM_SKULL_USING_BUFFER = "Crâne"
BeltalowdaIsdp.constants.BEAM_SKULL_NOT_USING_BUFFER = "Crâne (Sans buffer)"

--Compass
--YACS
BeltalowdaYacs.compasses[1].name = "Standard"
BeltalowdaYacs.compasses[2].name = "Nordique épais"
BeltalowdaYacs.compasses[3].name = "Lignes fines"
BeltalowdaYacs.compasses[4].name = "Nordique extravagant souligné"
BeltalowdaYacs.compasses[5].name = "Nordique épais souligné"
BeltalowdaYacs.compasses[6].name = "Gribouillis"
BeltalowdaYacs.compasses[7].name = "Cercle 1"
BeltalowdaYacs.compasses[8].name = "Cercle 2"
BeltalowdaYacs.compasses[9].name = "Diamant 1"
BeltalowdaYacs.compasses[10].name = "Diamant 2"
BeltalowdaYacs.compasses[11].name = "Points 1"
BeltalowdaYacs.compasses[12].name = "Points 2"
BeltalowdaYacs.compasses[13].name = "E-Alphabet 1"
BeltalowdaYacs.compasses[14].name = "E-Alphabet 2"
BeltalowdaYacs.compasses[15].name = "Flèche pleine 1"
BeltalowdaYacs.compasses[16].name = "Flèche pleine 2"
BeltalowdaYacs.compasses[17].name = "Aiguille 1"
BeltalowdaYacs.compasses[18].name = "Aiguille 2"
BeltalowdaYacs.compasses[19].name = "Petite flèche 1"
BeltalowdaYacs.compasses[20].name = "Petite flèche 2"
BeltalowdaYacs.compasses[21].name = "Boussole Fr. 1" 
BeltalowdaYacs.compasses[22].name = "Boussole Fr. 2" 
BeltalowdaYacs.compasses[23].name = "Boussole Fr. 3" 
BeltalowdaYacs.compasses[24].name = "Boussole Fr. 4"
BeltalowdaYacs.config.constants.TOGGLE_YACS = "Enclencher la boussole"

--SC
BeltalowdaSC.constants = BeltalowdaSC.constants or {}
BeltalowdaSC.constants.NORTH = "N"
BeltalowdaSC.constants.NORTH_EAST = "NE"
BeltalowdaSC.constants.EAST = "E"
BeltalowdaSC.constants.SOUTH_EAST = "SE"
BeltalowdaSC.constants.SOUTH = "S"
BeltalowdaSC.constants.SOUTH_WEST = "SO"
BeltalowdaSC.constants.WEST = "O"
BeltalowdaSC.constants.NORTH_WEST = "NO"

--Toolbox
--Siege Merchant
BeltalowdaSm.paymentOptions = BeltalowdaSm.paymentOptions or {}
BeltalowdaSm.paymentOptions[1] = "Points d'Alliance seulement"
BeltalowdaSm.paymentOptions[2] = "Pièces d'or seulement"
BeltalowdaSm.paymentOptions[3] = "PA d'abord, puis PO"
BeltalowdaSm.paymentOptions[4] = "PO d'abord, puis PA"
BeltalowdaSm.constants = BeltalowdaSm.constants or {}
BeltalowdaSm.constants.ERROR_UNKNOWN = "Une erreur inconnue est survenue."
BeltalowdaSm.constants.ERROR_UNKNOWN_PAYMENT_OPTION = "La méthode de paiment choisie est inconnue."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD = "Pas assez d'or pour poursuivre les achats."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP = "Pas asez de points d'alliance pour poursuivre les achats."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP_OR_GOLD = "Pas assez de points d'alliance ni d'or pour poursuivre les achats."
BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_INVENTORY_SLOTS = "Pas assez d'espace d'inventaire pour poursuivre les achats."
BeltalowdaSm.constants.SUCCESS_MESSAGE = "Achat terminé."

--Recharger
BeltalowdaRecharger.constants = BeltalowdaRecharger.constants or {}
BeltalowdaRecharger.constants.MESSAGE_SUCCESS = "%s (%d%%) a été rechargée."
BeltalowdaRecharger.constants.MESSAGE_WARNING_LOW_SOULGEMS = "Il reste moins de %d de pierres d'âme."
BeltalowdaRecharger.constants.MESSAGE_WARNING_NO_SOULGEMS = "Plus de pierres d'âmes."

--Buff Food Tracking
BeltalowdaBft.constants = BeltalowdaBft.constants or {}
BeltalowdaBft.constants.BUFF_FOOD_STRING = "Nourriture: %s"

--Siege
BeltalowdaSiege.constants = BeltalowdaSiege.constants or {}
BeltalowdaSiege.constants.TOGGLE_SIEGE = "|c4592FFBeltalowda: Modifier la vue|r"

--Cyrodiil Log
BeltalowdaCL.constants = BeltalowdaCL.constants or {}
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_CLAIM = "%s|c%s a revendiqué %s|c%s for %s"
BeltalowdaCL.constants.MESSAGE_KEEP_GUILD_LOST = "%s|c%s a perdu %s"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA = "%s|c%s est assiégé(e)"
BeltalowdaCL.constants.MESSAGE_KEEP_STATUS_UA_LOST = "%s|c%s n'est plus assiég(e)"
BeltalowdaCL.constants.MESSAGE_KEEP_OWNER_CHANGED = "%s|c%s appartient désormais à %s"
BeltalowdaCL.constants.MESSAGE_TICK_DEFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s points de défense %s"
BeltalowdaCL.constants.MESSAGE_TICK_OFFENSE = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s points de capture %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_PICKED_UP = "%s|c%s s'est emparé du the %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_DROPPED = "%s|c%s a lâché le %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED = "%s|c%s a replacé le %s"
BeltalowdaCL.constants.MESSAGE_SCROLL_RETURNED_BY_TIMER = "%s|c%s a été remis en place"
BeltalowdaCL.constants.MESSAGE_SCROLL_CAPTURED = "%s|c%s a capturé %s|c%s at %s"
BeltalowdaCL.constants.MESSAGE_EMPEROR_CORONATED = "%s|c%s a été couronné empereur."
BeltalowdaCL.constants.MESSAGE_EMPEROR_DEPOSED = "%s|c%s a été révoqué comme empereur."
BeltalowdaCL.constants.MESSAGE_QUEST_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gagnés pour la quête."
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gagnés pour le champ de bataille."
BeltalowdaCL.constants.MESSAGE_BATTLEGROUND_MEDAL_REWARD = "|c%s%s|t16:16:/esoui/art/currency/alliancepoints.dds|t|c%s gagnés pour l'obtention d'une médaille."
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_SPAWNED = "|c%s%s est apparu"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_REVEALED = "|c%s%s est révélé"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DROPPED = "|c%s%s a été lâché par %s|c%s"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_TAKEN = "|c%s%s a été pris par %s|c%s"
BeltalowdaCL.constants.MESSAGE_DAEDRIC_ARTIFACT_DESPAWNED = "|c%s%s est retourné en Oblivion"

--Respawner
BeltalowdaRespawner.constants = BeltalowdaRespawner.constants or {}
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_CAMP = "Ressusciter au campement."
BeltalowdaRespawner.constants.KEYBINDING_RESPAWN_KEEP = "ressusciter au fort"
BeltalowdaRespawner.constants.RESPAWN_CAMP = "Campement"
BeltalowdaRespawner.constants.RESPAWN_KEEP = "Fort"

--Synergy Prevention
BeltalowdaSP.constants = BeltalowdaSP.constants or {}
BeltalowdaSP.constants.ON = "ON"
BeltalowdaSP.constants.OFF = "OFF"
BeltalowdaSP.constants.KEYBINDING = "Enclencher la prévention de synergies"
BeltalowdaSP.constants.SYNERGY_COMBUSTION = "Combustion"
BeltalowdaSP.constants.SYNERGY_HEALING_COMBUSTION = "Combustion curative"
BeltalowdaSP.constants.SYNERGY_SHARDS_BLESSED = "Éclats bénis"
BeltalowdaSP.constants.SYNERGY_SHARDS_HOLY = "Éclats sacrés"
BeltalowdaSP.constants.SYNERGY_BLOOD_FEAST = "Festin sanglant"
BeltalowdaSP.constants.SYNERGY_BLOOD_FUNNEL = "Entonnoir de sang"
BeltalowdaSP.constants.SYNERGY_SUPERNOVA = "Supernova"
BeltalowdaSP.constants.SYNERGY_GRAVITY_CRUSH = "Anéantissement de gravité"
BeltalowdaSP.constants.SYNERGY_SHACKLE = "Chaîne"
BeltalowdaSP.constants.SYNERGY_PURIFY = "Purification"
BeltalowdaSP.constants.SYNERGY_BONE_WALL = "Mur d'os"
BeltalowdaSP.constants.SYNERGY_SPINAL_SURGE = "Surcharge élémentaire"
BeltalowdaSP.constants.SYNERGY_IGNITE = "Empalement"
BeltalowdaSP.constants.SYNERGY_RADIATE = "Faisceau"
BeltalowdaSP.constants.SYNERGY_CONDUIT = "Canalisation"
BeltalowdaSP.constants.SYNERGY_SPAWN_BROODLINGS = "Nuée de jeunes"
BeltalowdaSP.constants.SYNERGY_BLACK_WIDOWS = "Veuve noire"
BeltalowdaSP.constants.SYNERGY_ARACHNOPHOBIA = "Arachnophobie"
BeltalowdaSP.constants.SYNERGY_HIDDEN_REFRESH = "Rafraîchissement dissimulé"
BeltalowdaSP.constants.SYNERGY_SOUL_LEECH = "Absorption d'âme"
BeltalowdaSP.constants.SYNERGY_HARVEST = "Graine curative"
BeltalowdaSP.constants.SYNERGY_ATRONACH = "Éclair chargé"
BeltalowdaSP.constants.SYNERGY_GRAVE_ROBBER = "Tombe"
BeltalowdaSP.constants.SYNERGY_PURE_AGONY = "Agonie pure"
BeltalowdaSP.constants.SYNERGY_ICY_ESCAPE = "Évasion glacée"
BeltalowdaSP.constants.SYNERGY_SANGUINE_BURST = "Détonation sanguine"
BeltalowdaSP.constants.SYNERGY_HEED_THE_CALL = "Répondez à l'appel"
BeltalowdaSP.constants.SYNERGY_URSUS = "Bouclier d'Ursus"
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
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_ALL] = "Tous"
BeltalowdaSP.constants.MODES[BeltalowdaSP.constants.MODE_BLOCK_IF_SYNERGY_ROLE] = "Synergie de rôle"

--Synergy Overview
BeltalowdaSO.constants.DISPLAY_MODES = BeltalowdaSO.constants.DISPLAY_MODES or {}
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_ALL] = "Tous"
BeltalowdaSO.constants.DISPLAY_MODES[BeltalowdaSO.constants.DISPLAYMODE_SYNERGY] = "Synergie de rôle"
BeltalowdaSO.constants.TABLE_MODES = BeltalowdaSO.constants.TABLE_MODES or {}
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_FULL] = "Pleine"
BeltalowdaSO.constants.TABLE_MODES[BeltalowdaSO.constants.MODES.TABLE_REDUCED] = "Réduite"

--util
--util
BeltalowdaUtil.constants = BeltalowdaUtil.constants or {}
BeltalowdaUtil.constants.G1 = "Guilde 1"
BeltalowdaUtil.constants.O1 = "Officier 1"
BeltalowdaUtil.constants.G2 = "Guilde 2"
BeltalowdaUtil.constants.O2 = "Officier 2"
BeltalowdaUtil.constants.G3 = "Guilde 3"
BeltalowdaUtil.constants.O3 = "Officier 3"
BeltalowdaUtil.constants.G4 = "Guilde 4"
BeltalowdaUtil.constants.O4 = "Officier 4"
BeltalowdaUtil.constants.G5 = "Guilde 5"
BeltalowdaUtil.constants.O5 = "Officier 5"
BeltalowdaUtil.constants.EMOTE = "Emote"
BeltalowdaUtil.constants.SAY = "Dire"
BeltalowdaUtil.constants.YELL = "Crier"
BeltalowdaUtil.constants.GROUP = "Groupe"
BeltalowdaUtil.constants.TELL = "Parler"
BeltalowdaUtil.constants.ZONE = "Zone"
BeltalowdaUtil.constants.ENZONE = "Zone - Anglais"
BeltalowdaUtil.constants.FRZONE = "Zone - Français"
BeltalowdaUtil.constants.DEZONE = "Zone - Allemand"
BeltalowdaUtil.constants.JPZONE = "Zone - Japonais"

--ui
BeltalowdaUtilUI.constants = BeltalowdaUtilUI.constants or {}
BeltalowdaUtilUI.constants.ON = "MARCHE"
BeltalowdaUtilUI.constants.OFF = "ARRÊT"

--Ultimates
BeltalowdaUltimates.constants = BeltalowdaUltimates.constants or {}
BeltalowdaUltimates.constants.NEGATE = "Sorcier - Négation de la magie"
BeltalowdaUltimates.constants.NEGATE_OFFENSIVE = "Sorcier - Négation de la magie (offensif)"
BeltalowdaUltimates.constants.NEGATE_COUNTER = "Sorcier - Négation de la magie (défensif)"
BeltalowdaUltimates.constants.ATRONACH = "Sorcier - Atronach"
BeltalowdaUltimates.constants.OVERLOAD = "Sorcier - Surcharge"
BeltalowdaUltimates.constants.SWEEP = "Templier - Balayage"
BeltalowdaUltimates.constants.NOVA = "Templier - Nova"
BeltalowdaUltimates.constants.T_HEAL = "Templier - Ulti de soin"
BeltalowdaUltimates.constants.STANDARD = "Chevalier-Dragon - Etendard"
BeltalowdaUltimates.constants.LEAP = "Chevalier-Dragon - Bond de dragon"
BeltalowdaUltimates.constants.MAGMA = "Chevalier-Dragon - Armure de magma"
BeltalowdaUltimates.constants.STROKE = "Lame-Noire - Coup fatal"
BeltalowdaUltimates.constants.DARKNESS = "Lame-Noire - Ténèbres dévorantes"
BeltalowdaUltimates.constants.SOUL = "Lame-Noire - Lacération d'âmes"
BeltalowdaUltimates.constants.SOUL_SIPHON = "Lame-Noire - Siphon d'âmes"
BeltalowdaUltimates.constants.SOUL_TETHER = "Lame-Noire - Amarre spirituelle"
BeltalowdaUltimates.constants.STORM = "Gardien - Tempête"
BeltalowdaUltimates.constants.NORTHERN_STORM = "Gardien - Tempête du nord"
BeltalowdaUltimates.constants.PERMAFROST = "Gardien - Permafrost"
BeltalowdaUltimates.constants.W_HEAL = "Gardien - Bosquet isolé (soin)"
BeltalowdaUltimates.constants.GUARDIAN = "Gardien - Ours gardien"
BeltalowdaUltimates.constants.COLOSSUS = "Nécromancien - Colosse de chair"
BeltalowdaUltimates.constants.GOLIATH = "Nécromancien - Colosse d'os"
BeltalowdaUltimates.constants.REANIMATE = "Nécromancien - Réanimation"
BeltalowdaUltimates.constants.UNBLINKING_EYE = "Arcaniste - L'Œil fixe"
BeltalowdaUltimates.constants.GIBBERING_SHIELD = "Arcaniste - Bouclier ricanant"
BeltalowdaUltimates.constants.VITALIZING_GLYPHIC = "Arcaniste - Glyphique vitalisant"
BeltalowdaUltimates.constants.DESTRUCTION = "Arme - Bâton de destruction"
BeltalowdaUltimates.constants.RESTORATION = "Arme - Bâton de rétablissement"
BeltalowdaUltimates.constants.TWO_HANDED = "Arme - Arme à deux mains"
BeltalowdaUltimates.constants.SHIELD = "Arme - Une main et un bouclier"
BeltalowdaUltimates.constants.DUAL_WIELD = "Arme - Deux armes"
BeltalowdaUltimates.constants.BOW = "Arme - Arc"
BeltalowdaUltimates.constants.SOUL_MAGIC = "Monde - Frappe à l'âme"
BeltalowdaUltimates.constants.WEREWOLF = "Monde (Loup-garou) - Loup-garou"
BeltalowdaUltimates.constants.VAMPIRE = "Monde (Vampire) - Nuée de chauves-souris"
BeltalowdaUltimates.constants.MAGES = "Guilde (Mages) - Météore"
BeltalowdaUltimates.constants.FIGHTERS = "Guilde (Guerriers) - Aubéclat"
BeltalowdaUltimates.constants.PSIJIC = "Guilde (Psijique) - Annulation"
BeltalowdaUltimates.constants.ALLIANCE_SUPPORT = "Alliance War (Soutien) - Barrière"
BeltalowdaUltimates.constants.ALLIANCE_ASSAULT = "Alliance War (Assaut) - Cor de guerre"

--Networking
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.DIRECT] = "Direct"
BeltalowdaNetworking.constants.urgentSelection[BeltalowdaNetworking.constants.urgentMode.CRITICAL] = "Queue (Critique)"

--Util Group
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_CHAR_NAME] = "Par nom"
BeltalowdaUtilGroup.constants.displayTypes[BeltalowdaUtilGroup.constants.BY_DISPLAY_NAME] = "Par @Compte"

BeltalowdaUtilGroup.constants.ROLE_RAPID = "Manoeuvre rapide"
BeltalowdaUtilGroup.constants.ROLE_PURGE = "Purge"
BeltalowdaUtilGroup.constants.ROLE_HEAL = "Soigneur"
BeltalowdaUtilGroup.constants.ROLE_DD = "DPS"
BeltalowdaUtilGroup.constants.ROLE_SYNERGY = "Synergie"
BeltalowdaUtilGroup.constants.ROLE_CC = "Contrôle"
BeltalowdaUtilGroup.constants.ROLE_SUPPORT = "Soutien"
BeltalowdaUtilGroup.constants.ROLE_PLACEHOLDER = "Indéfini"
BeltalowdaUtilGroup.constants.ROLE_APPLICANT = "Candidat"

--Util Versioning
BeltalowdaVersioning.constants = BeltalowdaVersioning.constants or {}
BeltalowdaVersioning.constants.CLIENT_OUT_OF_DATE = "|cFF0000[Beltalowda] Le client n'est pas à jour|r"

--Util Enhancements
BeltalowdaEnhance.constants = BeltalowdaEnhance.constants or {}
BeltalowdaEnhance.constants.positionNames = BeltalowdaEnhance.constants.positionNames or {}
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPRIGHT] = "En haut à droite"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMRIGHT] = "En bas à droite"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.TOPLEFT] = "En haut à gauche"
BeltalowdaEnhance.constants.positionNames[BeltalowdaEnhance.constants.BOTTOMLEFT] = "En bas à gauche"
BeltalowdaEnhance.constants.CAMP_RESPAWN = "Campement : "

--Util Group Menu
BeltalowdaGMenu.constants = BeltalowdaGMenu.constants or {}
BeltalowdaGMenu.constants.BG_LEADER_ADD_CROWN = "Marquer comme couronne"
BeltalowdaGMenu.constants.BG_LEADER_REMOVE_CROWN = "Enlever la couronne"
BeltalowdaGMenu.constants.ROLE_MENU_ENTRY = "Rôle"
BeltalowdaGMenu.constants.ROLE_SUBMENU_SET = "Définir"
BeltalowdaGMenu.constants.ROLE_SUBMENU_REMOVE = "Supprimer"
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
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].name = "Faisceau 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].name = "Faisceau 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].name = "Faisceau 3"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].name = "Faisceau 4"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].name = "Cercle 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].name = "Cercle 1 (w/o Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].name = "Cercle 2"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].name = "Cercle 2 (w/o Buffer)"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].name = "Flèche 1"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].name = "Flèche 2"

--Admin [General]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.TOGGLE_ADMIN = "Utiliser l'interface d'administrateur"
BeltalowdaAdmin.constants.HEADER_TITLE = "Administrateur"
BeltalowdaAdmin.constants.PLAYERS_ALL = "Tous"
--Admin UI [Player]
BeltalowdaAdmin.constants.player = BeltalowdaAdmin.constants.player or {}
BeltalowdaAdmin.constants.player.REQUEST_ALL = "Requête à tous"
BeltalowdaAdmin.constants.player.REQUEST_VERSION = "Requête version"
BeltalowdaAdmin.constants.player.REQUEST_CLIENT_CONFIGURATION = "Requête configuration client"
BeltalowdaAdmin.constants.player.REQUEST_ADDON_CONFIGURATION = "Requête configuration d'add-on"
BeltalowdaAdmin.constants.player.REQUEST_EQUIPMENT_INFORMATION = "Requête information équipement"
BeltalowdaAdmin.constants.player.REQUEST_STATS_INFORMATION = "Requête information statistiques"
BeltalowdaAdmin.constants.player.REQUEST_MUNDUS_INFORMATION = "Requête information pierre de mundus"
BeltalowdaAdmin.constants.player.REQUEST_SKILLS_INFORMATION = "Requête information compétences"
BeltalowdaAdmin.constants.player.REQUEST_QUICKSLOTS_INFORMATION = "Requêtes information raccourcis rapides"
BeltalowdaAdmin.constants.player.REQUEST_CHAMPION_INFORMATION = "Requête information CP"
--Admin UI [Config]
BeltalowdaAdmin.constants = BeltalowdaAdmin.constants or {}
BeltalowdaAdmin.constants.defaults = BeltalowdaAdmin.constants.defaults or {}
BeltalowdaAdmin.constants.defaults.ENABLED = "MARCHE"
BeltalowdaAdmin.constants.defaults.DISABLED = "Arrêt"
BeltalowdaAdmin.constants.defaults.UNDEFINED = "Indisponible"
BeltalowdaAdmin.constants.defaults.UNDEFINED_LINE = "-"
BeltalowdaAdmin.constants.defaults.UNDEFINED_VERSION = "Indisponible (Version)"
BeltalowdaAdmin.constants.defaults.viewModes = BeltalowdaAdmin.constants.defaults.viewModes or {}
BeltalowdaAdmin.constants.defaults.viewModes[0] = "Fenêtré"
BeltalowdaAdmin.constants.defaults.viewModes[1] = "Fenêtré (Plein écran)"
BeltalowdaAdmin.constants.defaults.viewModes[2] = "Plein écran"
BeltalowdaAdmin.constants.defaults.qualitySelection = BeltalowdaAdmin.constants.defaults.qualitySelection or {}
BeltalowdaAdmin.constants.defaults.qualitySelection[0] = "Arrêt"
BeltalowdaAdmin.constants.defaults.qualitySelection[1] = "Bas"
BeltalowdaAdmin.constants.defaults.qualitySelection[2] = "Moyen"
BeltalowdaAdmin.constants.defaults.qualitySelection[3] = "Haut"
BeltalowdaAdmin.constants.defaults.qualitySelection[4] = "Ultra"
BeltalowdaAdmin.constants.defaults.graphicPresets = BeltalowdaAdmin.constants.defaults.graphicPresets or {}
BeltalowdaAdmin.constants.defaults.graphicPresets[0] = "Minumum"
BeltalowdaAdmin.constants.defaults.graphicPresets[1] = "Bas"
BeltalowdaAdmin.constants.defaults.graphicPresets[2] = "Moyen"
BeltalowdaAdmin.constants.defaults.graphicPresets[3] = "Haut"
BeltalowdaAdmin.constants.defaults.graphicPresets[4] = "Ultra"
BeltalowdaAdmin.constants.defaults.graphicPresets[7] = "Sur mesure"
BeltalowdaAdmin.constants.config = BeltalowdaAdmin.constants.config or {}
BeltalowdaAdmin.constants.config.PLAYER_TITLE = "Information Joueur"
BeltalowdaAdmin.constants.config.PLAYER_DISPLAYNAME_STRING = "Nom affiché: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_CHARNAME_STRING = "Nom du personnage: |c%s%s|r"
BeltalowdaAdmin.constants.config.PLAYER_VERSION_STRING = "Version: |c%s%s.%s.%s|r"
BeltalowdaAdmin.constants.config.CLIENT_TITLE = "Information client"
BeltalowdaAdmin.constants.config.CLIENT_AOE_SUBTITLE = "AOE"
BeltalowdaAdmin.constants.config.CLIENT_AOE_TELLS_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENABLED_STRING = "Couleurs sur mesure activées: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_FRIENDLY_BRIGHTNESS = "Luminosité allié: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_AOE_CUSTOM_COLOR_ENEMY_BRIGHTNESS = "Luminosité ennemi: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_SUBTITLE = "Son"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SOUND_AUDIO_VOLUME = "Volume audio: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_SFX_AUDIO_VOLUME = "Volume effets: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_UI_AUDIO_VOLUME = "Volume interface: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBTITLE = "Graphismes"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_RESOLUTION_STRING = "Resolution: |c%s%sx%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_WINDOW_MODE_STRING = "Mode d'affichage: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VSYNC_STRING = "Synchronisation verticale: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ANTI_ALIASING_STRING = "Anti-Aliasing: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_AMBIENT_STRING = "Occlusion ambiante: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_BLOOM_STRING = "Bloom: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DEPTH_OF_FIELD_STRING = "Profondeur de champ: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_DISTORTION_STRING = "Distortion: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUNLIGHT_STRING = "Rayons de soleil Rays: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_ALLY_EFFECTS_STRING = "Effets supplémentaires alliés: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_VIEW_DISTANCE_STRING = "Distance de vue: ~|c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_SUPRESSION_DISTANCE_STRING = "Distance de suppression des particules: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_PARTICLE_MAXIMUM_STRING = "Système de particules max: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_REFLECTION_QUALITY_STRING = "Qualité des reflets sur l'eau: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SHADOW_QUALITY_STRING = "Qualité des ombres: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_SUBSAMPLING_QUALITY_STRING = "Qualité de sous-échantillonnage: |c%s%s|r"
BeltalowdaAdmin.constants.config.CLIENT_GRAPHICS_GRAPHIC_PRESETS_STRING = "Qualité des graphiques: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_TITLE = "Configuration de l'add-on"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SUBTITLE = "Couronne"
BeltalowdaAdmin.constants.config.ADDON_CROWN_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SIZE_STRING = "Taille: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CROWN_SELECTED_CROWN_STRING = "Couronne sélectionnée: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SUBTITLE = "Suivre la couronne (Visuel)"
BeltalowdaAdmin.constants.config.ADDON_FTCV_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_FAR_STRING = "Taille (loin): |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_SIZE_CLOSE_STRING = "Taille (proche): |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MIN_DISTANCE_STRING = "Distance minimale: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_MAX_DISTANCE_STRING = "Distance maximale: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_FAR_STRING = "Opacité (loin): |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCV_OPACITY_CLOSE_STRING = "Opacité (proche): |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_SUBTITLE = "Suivre la couronne (Alertes)"
BeltalowdaAdmin.constants.config.ADDON_FTCW_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_DISTANCE_ENABLED_STRING = "Distance activée: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_WARNINGS_ENABLED_STRING = "Alertes activées: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCW_MAX_DISTANCE_STRING = "Distance maximale: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_SUBTITLE = "Suivre la couronne (Audio)"
BeltalowdaAdmin.constants.config.ADDON_FTCA_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_MAX_DISTANCE_STRING = "Distance maximale: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_INTERVAL_STRING = "Intervalle: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCA_THRESHOLD_STRING = "Seuil: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SUBTITLE = "Suivre la couronne (Faisceau)"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_SELECTED_BEAM_STRING = "Faisceau sélectionné: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_FTCB_ALPHA_STRING = "Alpha: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DBO_SUBTITLE = "Aperçu des débuffs"
BeltalowdaAdmin.constants.config.ADDON_DBO_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RT_SUBTITLE = "Aperçu manoeuvre rapide"
BeltalowdaAdmin.constants.config.ADDON_RT_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SUBTITLE = "Aperçu des ressources"
BeltalowdaAdmin.constants.config.ADDON_RO_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_ULTIMATE_OVERVIEW_ENABLED_STRING = "Aperçu des ultis de groupes Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_CLIENT_GROUP_ENABLED_STRING = "Client Window Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_ULTIMATE_ENABLED_STRING = "Fenêtre de groupe activée: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SHOW_SOFT_RESOURCES_STRING = "Stamina / Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_SOUND_ENABLED_STRING = "Son Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_MAX_DISTANCE_STRING = "Distance maximale: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_DESTRO_STRING = "Taille de groupe destro: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_STORM_STRING = "Taille de groupe tempête: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NORTHERNSTORM_STRING = "Taille de groupe Tempête du Nord: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_PERMAFROST_STRING = "Taille de groupe Permafrost: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_STRING = "Taille de groupe négation: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_OFFENSIVE_STRING = "Taille de groupe négation offensive: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NEGATE_COUNTER_STRING = "Taille de groupe négation défensive: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUP_SIZE_NOVA_STRING = "Taille de groupe Nova: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RO_GROUPS_ENABLED_STRING = "Groupes activés: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_SUBTITLE = "Mesure des dégâts de vie"
BeltalowdaAdmin.constants.config.ADDON_HDM_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_WINDOW_ENABLED_STRING = "Fenêtre Activée: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_HDM_VIEW_MODE_STRING = "Mode sélectionné: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SUBTITLE = "Aperçu des potions"
BeltalowdaAdmin.constants.config.ADDON_PO_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_PO_SOUND_ENABLED_STRING = "Son Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_DT_SUBTITLE = "Suivi détonation"
BeltalowdaAdmin.constants.config.ADDON_DT_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_GB_SUBTITLE = "Faiseaux de groupe"
BeltalowdaAdmin.constants.config.ADDON_GB_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_ISDP_SUBTITLE = "Je vois les morts"
BeltalowdaAdmin.constants.config.ADDON_ISDP_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_SUBTITLE = "Yet Another Compass"
BeltalowdaAdmin.constants.config.ADDON_YACS_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_PVP_ENABLED_STRING = "Activé en PVP: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_YACS_COMBAT_ENABLED_STRING = "Activé en combat: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SC_SUBTITLE = "Simple Compass"
BeltalowdaAdmin.constants.config.ADDON_SC_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SM_SUBTITLE = "Marchand d'engins de siège"
BeltalowdaAdmin.constants.config.ADDON_SM_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_SUBTITLE = "Recharger"
BeltalowdaAdmin.constants.config.ADDON_RECHARGER_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_KC_SUBTITLE = "Revendication de forts"
BeltalowdaAdmin.constants.config.ADDON_KC_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SUBTITLE = "Suivi des buffs repas"
BeltalowdaAdmin.constants.config.ADDON_BFT_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SOUND_ENABLED_STRING = "Son Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_BFT_SIZE_STRING = "Size: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CL_SUBTITLE = "Journal Cyrodiil"
BeltalowdaAdmin.constants.config.ADDON_CL_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CS_SUBTITLE = "Statut Cyrodiil"
BeltalowdaAdmin.constants.config.ADDON_CS_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_SUBTITLE = "Respawner"
BeltalowdaAdmin.constants.config.ADDON_RESPAWNER_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAMP_SUBTITLE = "Aperçu du campement"
BeltalowdaAdmin.constants.config.ADDON_CAMP_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_SUBTITLE = "Prévention des synergies"
BeltalowdaAdmin.constants.config.ADDON_SP_ENABLED_STRING = "Aperçu: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_MODE_STRING = "Mode: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SP_PREVENT_STRING = "%s: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_SUBTITLE = "Aperçu des synergies"
BeltalowdaAdmin.constants.config.ADDON_SO_ENABLED_STRING = "Aperçu: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_TABLE_MODE_STRING = "Mode table: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_SO_DISPLAY_MODE_STRING = "Mode d'affichage: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_SUBTITLE = "Répartition des rôles"
BeltalowdaAdmin.constants.config.ADDON_RA_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_RA_ALLOW_OVERRIDE_STRING = "Autoriser l'écrasement: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CAJ_SUBTITLE = "Rejoindre campagne automatiquement"
BeltalowdaAdmin.constants.config.ADDON_CAJ_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_SUBTITLE = "CR - BG - Templier soigneur (BG)"
BeltalowdaAdmin.constants.config.ADDON_CRBGTP_ENABLED_STRING = "Activé: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_TITLE = "Stats"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_STRING = "Magicka: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_STRING = "Santé: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_STRING = "Stamina: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_MAGICKA_RECOVERY_STRING = "Récupération de magie: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_HEALTH_RECOVERY_STRING = "Récupération de santé: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_STAMINA_RECOVERY_STRING = "Récupération de stamina: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_DAMAGE_STRING = "Dégâts des sorts: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_DAMAGE_STRING = "Dégâts des armes: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_PENETRATION_STRING = "Pénétration des sorts: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_PENETRATION_STRING = "Pénétration des armes: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_CRITICAL_STRING = "Critique de sorts: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_WEAPON_CRITICAL_STRING = "Critique des armes: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_SPELL_RESISTANCE_STRING = "Résistance aux sorts: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_PHYSICAL_RESISTANCE_STRING = "résistance physique: |c%s%s|r"
BeltalowdaAdmin.constants.config.STATS_CRITICAL_RESISTANCE_STRING = "Résistance critique: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_TITLE = "Pierre de Mundus"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_1_STRING = "Pierre dde mundus 1: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_STONE_2_STRING = "Pierre de mundus 2: |c%s%s|r"
BeltalowdaAdmin.constants.config.MUNDUS_FILTER = "Bénédiction: "
BeltalowdaAdmin.constants.config.CHAMPION_TITLE = "Points de champion"
BeltalowdaAdmin.constants.config.SKILLS_TITLE = "Compétences"
BeltalowdaAdmin.constants.config.EQUIPMENT_TITLE = "Equipement"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_REQUEST = "Demander item"
BeltalowdaAdmin.constants.config.EQUIPMENT_CONTEXT_LINK_IN_CHAT = "Lien dans le chat"
BeltalowdaAdmin.constants.config.QUICKSLOT_TITLE = "Raccourcis rapides"

--Config
BeltalowdaConfig.constants = BeltalowdaConfig.constants or {}
BeltalowdaConfig.constants.TOGGLE_CONFIG = "Choix de configuration de l'interface"
BeltalowdaConfig.constants.HEADER_TITLE = "Configuration Import / Export"
BeltalowdaConfig.constants.TAB_IMPORT_TITLE = "Import"
BeltalowdaConfig.constants.TAB_EXPORT_TITLE = "Export"
BeltalowdaConfig.constants.EXPORT_SELECT_ALL = "Tout sélectionner"
BeltalowdaConfig.constants.EXPORT_PROFILE = "Profil"
BeltalowdaConfig.constants.EXPORT_STRING_LENGTH_ERROR = "Le nom de la configuration est trop long - Merci de rapporter ce bug!"
BeltalowdaConfig.constants.IMPORT_PROFILE = "Nom du nouveau profil"
BeltalowdaConfig.constants.IMPORT = "Import"
BeltalowdaConfig.constants.IMPORT_STATUS = "Statut: "
BeltalowdaConfig.constants.IMPORT_ADD_ALL = "Ajouter toutes les valeurs (par ex. la position des fenêtres)"
BeltalowdaConfig.constants.IMPORT_STATUS_STARTED = "Import en cours"
BeltalowdaConfig.constants.IMPORT_STATUS_FAILED = "Import échoué"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED = "Import terminé"
BeltalowdaConfig.constants.IMPORT_STATUS_FINISHED_DIFFERENT_VERSION = "Import terminé (des versions différentes peuvent causer des problèmes)"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_INVALID_NAME = "Echec de l'importation - Nom de profil invalide"
BeltalowdaConfig.constants.IMPORT_STATUS_PROFILE_DUPLICATE = "Echec de l'importation - Le nom de profil existe déjà"
BeltalowdaConfig.constants.IMPORT_STATUS_NO_CONTENT = "Echec de l'importation - Pas de contenu"
BeltalowdaConfig.constants.IMPORT_CONFIG_LINE_COUNT = "Lignes de configuration: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON = "Import failed at line %s. Reason: %s"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_NIL = "Nil value"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_BOOLEAN = "Boolean expected"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_NUMBER = "Number expected"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_TYPE_INVALID = "Invalid type"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_INVALID = "Layer1 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_2_INVALID = "Layer2 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_1_2_INVALID = "Layer1 or Layer2 invalid"
BeltalowdaConfig.constants.IMPORT_CONFIG_FAILED_REASON_LAYER_X_INVALID = "LayerX invalid"