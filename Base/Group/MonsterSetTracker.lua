-- Beltalowda Monster Set Tracker
-- By @Kickimanjaro
-- Wishlist feature for tracking Monster Helm Item Sets

Beltalowda.group = Beltalowda.group or {}
local BeltalowdaGroup = Beltalowda.group
BeltalowdaGroup.mst = BeltalowdaGroup.mst or {}
local BeltalowdaMST = BeltalowdaGroup.mst

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.equipment = BeltalowdaUtil.equipment or {}
local BeltalowdaEquip = BeltalowdaUtil.equipment

Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaMST.callbackName = Beltalowda.addonName .. "GroupMonsterSetTracker"
BeltalowdaMST.messageLoopCallbackName = Beltalowda.addonName .. "GroupMonsterSetTrackerMessageLoop"

BeltalowdaMST.constants = {}
BeltalowdaMST.constants.TLW = "Beltalowda.group.mst.tlw"
BeltalowdaMST.constants.PREFIX = "MST"

-- Monster Set IDs based on UESP data
-- These are the head piece item IDs for each set
BeltalowdaMST.constants.SET_ID = {}
BeltalowdaMST.constants.SET_ID.EARTHGORE = 1 -- Earthgore (healing/support set)
BeltalowdaMST.constants.SET_ID.SYMPHONY_OF_BLADES = 2 -- Symphony of Blades (group resource restore)
BeltalowdaMST.constants.SET_ID.OZEZAN = 3 -- Ozezan the Inferno
BeltalowdaMST.constants.SET_ID.BLOODSPAWN = 4 -- Bloodspawn (self buff)
BeltalowdaMST.constants.SET_ID.BALORGH = 5 -- Balorgh (ultimate scaling)

-- Item IDs for head pieces (these would need to be verified in-game)
-- Placeholder values - actual IDs need to be determined from game data
BeltalowdaMST.constants.ITEM_ID = {}
BeltalowdaMST.constants.ITEM_ID.EARTHGORE_HEAD = 97940 -- Placeholder
BeltalowdaMST.constants.ITEM_ID.SYMPHONY_HEAD = 147330 -- Placeholder
BeltalowdaMST.constants.ITEM_ID.OZEZAN_HEAD = 147336 -- Placeholder
BeltalowdaMST.constants.ITEM_ID.BLOODSPAWN_HEAD = 59584 -- Placeholder
BeltalowdaMST.constants.ITEM_ID.BALORGH_HEAD = 127239 -- Placeholder

-- Cooldown durations for each set (in seconds)
BeltalowdaMST.constants.COOLDOWN = {}
BeltalowdaMST.constants.COOLDOWN.EARTHGORE = 35 -- Earthgore cleanses every 35 seconds
BeltalowdaMST.constants.COOLDOWN.SYMPHONY_OF_BLADES = 18 -- Symphony of Blades per target every 18 seconds
BeltalowdaMST.constants.COOLDOWN.OZEZAN = 10 -- Ozezan cooldown
BeltalowdaMST.constants.COOLDOWN.BLOODSPAWN = 5 -- Bloodspawn can proc every 5 seconds
BeltalowdaMST.constants.COOLDOWN.BALORGH = 12 -- Balorgh buff duration 12 seconds

-- Effect durations for tracking
BeltalowdaMST.constants.DURATION = {}
BeltalowdaMST.constants.DURATION.EARTHGORE = 6 -- Earthgore effect duration
BeltalowdaMST.constants.DURATION.SYMPHONY_OF_BLADES = 6 -- Symphony restore duration
BeltalowdaMST.constants.DURATION.BLOODSPAWN = 5 -- Bloodspawn buff duration
BeltalowdaMST.constants.DURATION.BALORGH = 12 -- Balorgh buff duration

BeltalowdaMST.state = {}
BeltalowdaMST.state.initialized = false
BeltalowdaMST.state.groupMembers = {} -- Track which sets each group member is wearing
BeltalowdaMST.state.cooldowns = {} -- Track cooldown status for each player/set combination

BeltalowdaMST.controls = {}
BeltalowdaMST.vars = {}

-- Monster Set Data Structure
-- Each set has metadata about how it should be tracked
BeltalowdaMST.monsterSets = {}

function BeltalowdaMST.InitializeMonsterSetData()
	-- Earthgore: Healing/Support set that cleanses and heals
	BeltalowdaMST.monsterSets[BeltalowdaMST.constants.SET_ID.EARTHGORE] = {
		id = BeltalowdaMST.constants.SET_ID.EARTHGORE,
		name = "Earthgore",
		headItemId = BeltalowdaMST.constants.ITEM_ID.EARTHGORE_HEAD,
		cooldown = BeltalowdaMST.constants.COOLDOWN.EARTHGORE,
		duration = BeltalowdaMST.constants.DURATION.EARTHGORE,
		type = "healing", -- healing, damage, tank, buff
		affectsGroup = true, -- Does this set affect group members?
		description = "Cleanses and heals group members under 50% health",
		-- Icon path would go here when art assets are added
		iconPath = nil, -- Placeholder for future icon
	}
	
	-- Symphony of Blades: Group resource restore
	BeltalowdaMST.monsterSets[BeltalowdaMST.constants.SET_ID.SYMPHONY_OF_BLADES] = {
		id = BeltalowdaMST.constants.SET_ID.SYMPHONY_OF_BLADES,
		name = "Symphony of Blades",
		headItemId = BeltalowdaMST.constants.ITEM_ID.SYMPHONY_HEAD,
		cooldown = BeltalowdaMST.constants.COOLDOWN.SYMPHONY_OF_BLADES,
		duration = BeltalowdaMST.constants.DURATION.SYMPHONY_OF_BLADES,
		type = "support",
		affectsGroup = true,
		description = "Restores 570 primary resource per second for 6 seconds to group members under 50% resource",
		iconPath = nil,
	}
	
	-- Ozezan the Inferno
	BeltalowdaMST.monsterSets[BeltalowdaMST.constants.SET_ID.OZEZAN] = {
		id = BeltalowdaMST.constants.SET_ID.OZEZAN,
		name = "Ozezan the Inferno",
		headItemId = BeltalowdaMST.constants.ITEM_ID.OZEZAN_HEAD,
		cooldown = BeltalowdaMST.constants.COOLDOWN.OZEZAN,
		duration = 0,
		type = "damage",
		affectsGroup = false,
		description = "Fire damage proc",
		iconPath = nil,
	}
	
	-- Bloodspawn: Self buff for tank
	BeltalowdaMST.monsterSets[BeltalowdaMST.constants.SET_ID.BLOODSPAWN] = {
		id = BeltalowdaMST.constants.SET_ID.BLOODSPAWN,
		name = "Bloodspawn",
		headItemId = BeltalowdaMST.constants.ITEM_ID.BLOODSPAWN_HEAD,
		cooldown = BeltalowdaMST.constants.COOLDOWN.BLOODSPAWN,
		duration = BeltalowdaMST.constants.DURATION.BLOODSPAWN,
		type = "tank",
		affectsGroup = false,
		description = "Ultimate and resistances when taking damage (6% chance)",
		iconPath = nil,
	}
	
	-- Balorgh: Ultimate scaling damage/penetration
	BeltalowdaMST.monsterSets[BeltalowdaMST.constants.SET_ID.BALORGH] = {
		id = BeltalowdaMST.constants.SET_ID.BALORGH,
		name = "Balorgh",
		headItemId = BeltalowdaMST.constants.ITEM_ID.BALORGH_HEAD,
		cooldown = BeltalowdaMST.constants.COOLDOWN.BALORGH,
		duration = BeltalowdaMST.constants.DURATION.BALORGH,
		type = "damage",
		affectsGroup = false,
		description = "Weapon/Spell Damage and Penetration based on Ultimate consumed",
		iconPath = nil,
		trackUltimate = true, -- Special flag for sets that interact with ultimates
	}
end

function BeltalowdaMST.Initialize()
	BeltalowdaMST.InitializeMonsterSetData()
	
	-- Get saved variables
	BeltalowdaMST.vars = Beltalowda.profile.GetProfile().group.mst
	
	-- Register for player activation event
	EVENT_MANAGER:RegisterForEvent(BeltalowdaMST.callbackName, EVENT_PLAYER_ACTIVATED, BeltalowdaMST.OnPlayerActivated)
	
	BeltalowdaMST.state.initialized = true
end

function BeltalowdaMST.OnPlayerActivated(eventCode, initial)
	if BeltalowdaMST.vars.enabled then
		-- TODO: Register for equipment change events
		-- TODO: Register for buff/debuff events to track set procs
		-- TODO: Start monitoring group member equipment
		BeltalowdaMST.ScanPlayerEquipment()
		BeltalowdaMST.BroadcastEquippedSets()
	else
		-- TODO: Unregister from events when disabled
	end
end

-- Scan the player's currently equipped gear for tracked monster sets
function BeltalowdaMST.ScanPlayerEquipment()
	-- TODO: Implement equipment scanning
	-- This would use GetItemLink(BAG_WORN, EQUIP_SLOT_HEAD) and EQUIP_SLOT_SHOULDERS
	-- to detect if player is wearing a tracked monster set
	-- For now this is a placeholder
	
	local headLink = GetItemLink(BAG_WORN, EQUIP_SLOT_HEAD)
	local shoulderLink = GetItemLink(BAG_WORN, EQUIP_SLOT_SHOULDERS)
	
	-- Check if we have a complete 2-piece monster set
	-- This is placeholder logic - actual implementation would need to:
	-- 1. Parse item links to get item IDs
	-- 2. Check if head + shoulder form a tracked monster set
	-- 3. Update local state with equipped set
	
	return nil -- Returns the set ID if wearing a tracked set, nil otherwise
end

-- Broadcast equipped monster sets to group
function BeltalowdaMST.BroadcastEquippedSets()
	-- TODO: Implement broadcasting
	-- This would use the networking utilities to broadcast which set(s)
	-- the player is currently wearing to other group members
	-- Similar to how ultimates are broadcasted
end

-- Handle receiving monster set information from group members
function BeltalowdaMST.OnSetDataReceived(playerName, setId)
	-- TODO: Implement data reception
	-- Store which sets each group member is wearing
	-- Update the UI to show this information
	
	if BeltalowdaMST.state.groupMembers[playerName] == nil then
		BeltalowdaMST.state.groupMembers[playerName] = {}
	end
	
	BeltalowdaMST.state.groupMembers[playerName].equippedSet = setId
end

-- Track cooldown status for a set proc
function BeltalowdaMST.OnSetProc(playerName, setId, timestamp)
	-- TODO: Implement cooldown tracking
	-- When a set procs (detected via buff events), record the timestamp
	-- and calculate when it will be available again
	
	local key = playerName .. "_" .. setId
	BeltalowdaMST.state.cooldowns[key] = {
		setId = setId,
		playerName = playerName,
		lastProc = timestamp,
		nextAvailable = timestamp + (BeltalowdaMST.monsterSets[setId].cooldown or 0),
	}
end

-- Get the cooldown status for a player's set
function BeltalowdaMST.GetCooldownStatus(playerName, setId)
	-- TODO: Implement cooldown status retrieval
	-- Returns information about whether the set is on cooldown or available
	
	local key = playerName .. "_" .. setId
	local cooldownData = BeltalowdaMST.state.cooldowns[key]
	
	if cooldownData == nil then
		return {
			available = true,
			remaining = 0,
		}
	end
	
	local currentTime = GetGameTimeMilliseconds() / 1000
	local remaining = cooldownData.nextAvailable - currentTime
	
	return {
		available = remaining <= 0,
		remaining = math.max(0, remaining),
	}
end

function BeltalowdaMST.GetDefaults()
	local defaults = {}
	defaults.enabled = false -- Disabled by default as this is a wishlist item
	defaults.showInCombatOnly = false
	defaults.pvpOnly = true -- Typically used in PvP scenarios
	defaults.positionLocked = false
	
	-- Display options
	defaults.displayMode = 1 -- 1 = Full, 2 = Compact
	defaults.showCooldowns = true
	defaults.showPlayerNames = true
	
	-- Which sets to track (all enabled by default when feature is enabled)
	defaults.trackEarthgore = true
	defaults.trackSymphony = true
	defaults.trackOzezan = true
	defaults.trackBloodspawn = true
	defaults.trackBalorgh = true
	
	-- UI positioning
	defaults.offsetX = 100
	defaults.offsetY = 100
	
	return defaults
end

function BeltalowdaMST.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = "|cFF8174Monster Set Tracker|r |cFFFFFF(Wishlist)|r",
			controls = {
				[1] = {
					type = "description",
					text = "Track Monster Helm Item Sets worn by group members. This feature is currently a placeholder for future development.",
				},
				[2] = {
					type = "checkbox",
					name = "Enable Monster Set Tracking",
					tooltip = "Enable tracking of equipped monster sets. Currently a wishlist feature - functionality is limited.",
					getFunc = function() return BeltalowdaMST.vars.enabled end,
					setFunc = function(value)
						BeltalowdaMST.vars.enabled = value
						BeltalowdaMST.OnPlayerActivated(nil, false)
					end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().enabled,
				},
				[3] = {
					type = "checkbox",
					name = "PvP Only",
					tooltip = "Only show monster set tracking in PvP areas",
					getFunc = function() return BeltalowdaMST.vars.pvpOnly end,
					setFunc = function(value) BeltalowdaMST.vars.pvpOnly = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().pvpOnly,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
				[4] = {
					type = "header",
					name = "Tracked Sets",
				},
				[5] = {
					type = "checkbox",
					name = "Track Earthgore",
					tooltip = "Track Earthgore monster set (healing/support)",
					getFunc = function() return BeltalowdaMST.vars.trackEarthgore end,
					setFunc = function(value) BeltalowdaMST.vars.trackEarthgore = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().trackEarthgore,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
				[6] = {
					type = "checkbox",
					name = "Track Symphony of Blades",
					tooltip = "Track Symphony of Blades monster set (group resource restore)",
					getFunc = function() return BeltalowdaMST.vars.trackSymphony end,
					setFunc = function(value) BeltalowdaMST.vars.trackSymphony = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().trackSymphony,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
				[7] = {
					type = "checkbox",
					name = "Track Ozezan the Inferno",
					tooltip = "Track Ozezan the Inferno monster set",
					getFunc = function() return BeltalowdaMST.vars.trackOzezan end,
					setFunc = function(value) BeltalowdaMST.vars.trackOzezan = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().trackOzezan,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
				[8] = {
					type = "checkbox",
					name = "Track Bloodspawn",
					tooltip = "Track Bloodspawn monster set (tank)",
					getFunc = function() return BeltalowdaMST.vars.trackBloodspawn end,
					setFunc = function(value) BeltalowdaMST.vars.trackBloodspawn = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().trackBloodspawn,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
				[9] = {
					type = "checkbox",
					name = "Track Balorgh",
					tooltip = "Track Balorgh monster set (ultimate scaling)",
					getFunc = function() return BeltalowdaMST.vars.trackBalorgh end,
					setFunc = function(value) BeltalowdaMST.vars.trackBalorgh = value end,
					width = "full",
					default = BeltalowdaMST.GetDefaults().trackBalorgh,
					disabled = function() return not BeltalowdaMST.vars.enabled end,
				},
			},
		},
	}
	return menu
end
