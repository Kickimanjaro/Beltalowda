-- Beltalowda SiegeMerchant
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox.sm = Beltalowda.toolbox.sm or {}
local BeltalowdaSm = Beltalowda.toolbox.sm
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaSm.constants = BeltalowdaSm.constants or {}
BeltalowdaSm.constants.ITEM_REPAIR_WALL = 1 -- Does not exist anymore
BeltalowdaSm.constants.ITEM_REPAIR_DOOR = 2 -- Does not exist anymore
BeltalowdaSm.constants.ITEM_REPAIR_SIEGE = 3 -- Does not exist anymore
BeltalowdaSm.constants.ITEM_BALLISTA_FIRE = 4
BeltalowdaSm.constants.ITEM_BALLISTA_STONE = 5
BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING = 6
BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE = 7
BeltalowdaSm.constants.ITEM_TREBUCHET_STONE = 8
BeltalowdaSm.constants.ITEM_TREBUCHET_ICE = 9
BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG = 10
BeltalowdaSm.constants.ITEM_CATAPULT_OIL = 11
BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT = 12
BeltalowdaSm.constants.ITEM_OIL = 13
BeltalowdaSm.constants.ITEM_CAMP = 14
BeltalowdaSm.constants.ITEM_RAM = 15
BeltalowdaSm.constants.ITEM_KEEP_RECALL = 16
BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR = 17 -- Does not exist anymore
BeltalowdaSm.constants.ITEM_REPAIR_ALL = 18 -- Instead of 1,2,3,17
BeltalowdaSm.constants.ITEM_POT_RED = 19
BeltalowdaSm.constants.ITEM_POT_GREEN = 20
BeltalowdaSm.constants.ITEM_POT_BLUE = 21

BeltalowdaSm.constants.PAYMENT_ONLY_AP = 1
BeltalowdaSm.constants.PAYMENT_ONLY_GOLD = 2
BeltalowdaSm.constants.PAYMENT_FIRST_AP = 3
BeltalowdaSm.constants.PAYMENT_FIRST_GOLD = 4

BeltalowdaSm.constants.STATE_BUY_SUCCESS = 1
BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING = 2
BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING = 3
BeltalowdaSm.constants.STATE_BUY_FAILED_INVENTORY_SLOTS = 4
BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR = 5
BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT = 6
BeltalowdaSm.constants.STATE_BUY_FAILED_AP_OR_GOLD_MISSING = 7

BeltalowdaSm.constants.STACK_NORMAL = 100
BeltalowdaSm.constants.STACK_POTS = 200
BeltalowdaSm.constants.STACK_WEAPONS = 20

BeltalowdaSm.constants.PREFIX = "SM"

BeltalowdaSm.callbackName = Beltalowda.addonName .. "SiegeMerchant"

BeltalowdaSm.paymentOptions = BeltalowdaSm.paymentOptions or {}

BeltalowdaSm.config = {}

BeltalowdaSm.state = {}
BeltalowdaSm.state.initialized = false

BeltalowdaSm.state.items = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_OIL] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CAMP] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_RAM] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_RED] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_GREEN] = {}
BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_BLUE] = {}

BeltalowdaSm.state.priorityList = {}
BeltalowdaSm.state.priorityList[1] = BeltalowdaSm.constants.ITEM_BALLISTA_STONE
BeltalowdaSm.state.priorityList[2] = BeltalowdaSm.constants.ITEM_BALLISTA_FIRE
BeltalowdaSm.state.priorityList[3] = BeltalowdaSm.constants.ITEM_CAMP
BeltalowdaSm.state.priorityList[4] = BeltalowdaSm.constants.ITEM_KEEP_RECALL
BeltalowdaSm.state.priorityList[5] = BeltalowdaSm.constants.ITEM_REPAIR_ALL
BeltalowdaSm.state.priorityList[6] = BeltalowdaSm.constants.ITEM_RAM
BeltalowdaSm.state.priorityList[7] = BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT
BeltalowdaSm.state.priorityList[8] = BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG
BeltalowdaSm.state.priorityList[9] = BeltalowdaSm.constants.ITEM_OIL
BeltalowdaSm.state.priorityList[10] = BeltalowdaSm.constants.ITEM_TREBUCHET_STONE
BeltalowdaSm.state.priorityList[11] = BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE
BeltalowdaSm.state.priorityList[12] = BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING
BeltalowdaSm.state.priorityList[13] = BeltalowdaSm.constants.ITEM_TREBUCHET_ICE
BeltalowdaSm.state.priorityList[14] = BeltalowdaSm.constants.ITEM_CATAPULT_OIL
BeltalowdaSm.state.priorityList[15] = BeltalowdaSm.constants.ITEM_POT_RED
BeltalowdaSm.state.priorityList[16] = BeltalowdaSm.constants.ITEM_POT_GREEN
BeltalowdaSm.state.priorityList[17] = BeltalowdaSm.constants.ITEM_POT_BLUE
BeltalowdaSm.state.priorityList[18] = BeltalowdaSm.constants.ITEM_REPAIR_SIEGE -- Does not exist anymore
BeltalowdaSm.state.priorityList[19] = BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR -- Does not exist anymore
BeltalowdaSm.state.priorityList[20] = BeltalowdaSm.constants.ITEM_REPAIR_DOOR -- Does not exist anymore
BeltalowdaSm.state.priorityList[21] = BeltalowdaSm.constants.ITEM_REPAIR_WALL -- Does not exist anymore


function BeltalowdaSm.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaSm.callbackName, BeltalowdaSm.OnProfileChanged)
	
	BeltalowdaSm.CreateAllianceBasedItemList()
	BeltalowdaSm.state.initialized = true
	BeltalowdaSm.SetEnabled(BeltalowdaSm.smVars.enabled)
end

function BeltalowdaSm.GetDefaults()
	local defaults = {}
	defaults.enabled = false
	defaults.sendChatMessages = true
	defaults.items = {}
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL] = {} -- Does not exist anymore
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR] = {} -- Does not exist anymore
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE] = {} -- Does not exist anymore
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE].minimum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE].maximum = 10
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE].minimum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE].maximum = 10
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG].minimum = 2
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG].maximum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_OIL] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_OIL].minimum = 3
	defaults.items[BeltalowdaSm.constants.ITEM_OIL].maximum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_CAMP] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_CAMP].minimum = 2
	defaults.items[BeltalowdaSm.constants.ITEM_CAMP].maximum = 3
	defaults.items[BeltalowdaSm.constants.ITEM_RAM] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_RAM].minimum = 2
	defaults.items[BeltalowdaSm.constants.ITEM_RAM].maximum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL].minimum = 2
	defaults.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL].maximum = 5
	defaults.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR] = {} -- Does not exist anymore
	defaults.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL].minimum = 100
	defaults.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL].maximum = 100
	defaults.items[BeltalowdaSm.constants.ITEM_POT_RED] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_POT_RED].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_POT_RED].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_POT_GREEN] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_POT_GREEN].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_POT_GREEN].maximum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_POT_BLUE] = {}
	defaults.items[BeltalowdaSm.constants.ITEM_POT_BLUE].minimum = 0
	defaults.items[BeltalowdaSm.constants.ITEM_POT_BLUE].maximum = 0
	defaults.paymentOption = BeltalowdaSm.constants.PAYMENT_ONLY_AP
	return defaults
end

function BeltalowdaSm.SetEnabled(value)
	if BeltalowdaSm.state.initialized == true and value ~= nil then
		BeltalowdaSm.smVars.enabled = value
		if value == true then
			EVENT_MANAGER:RegisterForEvent(BeltalowdaSm.callbackName, EVENT_OPEN_STORE, BeltalowdaSm.OnOpenStore)
		else
			EVENT_MANAGER:UnregisterForEvent(BeltalowdaSm.callbackName, EVENT_OPEN_STORE)
		end
	end
end

--callbacks
function BeltalowdaSm.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaSm.smVars = currentProfile.toolbox.sm
		BeltalowdaSm.SetEnabled(BeltalowdaSm.smVars.enabled)
	end
end

function BeltalowdaSm.OnOpenStore(eventCode)
	if eventCode == EVENT_OPEN_STORE and IsInCyrodiil() == true then
		if BeltalowdaSm.UpdateShopList() then
			BeltalowdaSm.BuyItems()
			BeltalowdaSm.DisplaySalesFeedback()
		end
	end
end

--internal functions
function BeltalowdaSm.GetMinimum(key)
	return BeltalowdaSm.smVars.items[key].minimum
end

function BeltalowdaSm.SetMinimum(key, value)
	BeltalowdaSm.smVars.items[key].minimum = value
end

function BeltalowdaSm.GetMaximum(key)
	return BeltalowdaSm.smVars.items[key].maximum
end

function BeltalowdaSm.SetMaximum(key, value)
	BeltalowdaSm.smVars.items[key].maximum = value
end

--Recall: |H1:item:141731:6:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h

function BeltalowdaSm.CreateADItemList()
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL].id = 27138
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR].id = 27962
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE].id = 27112
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE].id = 27970
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE].id = 36567
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING].id = 27973
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE].id = 27105
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE].id = 44769
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE].id = 44768
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG].id = 27964
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL].id = 27967
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT].id = 44770
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_OIL].id = 30359
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CAMP].id = 29533
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_RAM].id = 27136
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL].id = 141731
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR].id = 142133
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL].id = 204483
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_RED].id = 71071
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_GREEN].id = 71073
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_BLUE].id = 71072
end

function BeltalowdaSm.CreateDCItemList()
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL].id = 27138
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR].id = 27962
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE].id = 27112
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE].id = 27972
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE].id = 36569
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING].id = 27975
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE].id = 27115
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE].id = 44772
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE].id = 44771
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG].id = 27966
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL].id = 27969
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT].id = 44773
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_OIL].id = 30359
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CAMP].id = 29535
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_RAM].id = 27835
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL].id = 141731
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR].id = 142133
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL].id = 204483
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_RED].id = 71071
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_GREEN].id = 71073
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_BLUE].id = 71072
end

function BeltalowdaSm.CreateEPItemList()
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_WALL].id = 27138
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_DOOR].id = 27962
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_SIEGE].id = 27112
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_FIRE].id = 27971
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_STONE].id = 36568
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING].id = 27974
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE].id = 27114
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_STONE].id = 44776
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_TREBUCHET_ICE].id = 44775
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG].id = 27965
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_OIL].id = 27968
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT].id = 44777
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_OIL].id = 30359
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_CAMP].id = 29534
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_RAM].id = 27850
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_KEEP_RECALL].id = 141731
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR].id = 142133
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_REPAIR_ALL].id = 204483
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_RED].id = 71071
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_GREEN].id = 71073
	BeltalowdaSm.state.items[BeltalowdaSm.constants.ITEM_POT_BLUE].id = 71072
end

function BeltalowdaSm.CreateAllianceBasedItemList()
	local alliance = GetUnitAlliance("player")
	if alliance == ALLIANCE_ALDMERI_DOMINION then
		BeltalowdaSm.CreateADItemList()
	elseif alliance == ALLIANCE_EBONHEART_PACT then
		BeltalowdaSm.CreateEPItemList()
	elseif alliance == ALLIANCE_DAGGERFALL_COVENANT then
		BeltalowdaSm.CreateDCItemList()
	end
end

function BeltalowdaSm.ClearStateEntries()
		for siegeIndex = 1, #BeltalowdaSm.state.items do
		BeltalowdaSm.state.items[siegeIndex].shopEntryGold = nil
		BeltalowdaSm.state.items[siegeIndex].shopEntryAP = nil
		BeltalowdaSm.state.items[siegeIndex].shopIndexGold = nil
		BeltalowdaSm.state.items[siegeIndex].shopIndexAP = nil
		BeltalowdaSm.state.items[siegeIndex].buyMax = nil
		BeltalowdaSm.state.items[siegeIndex].buyMin = nil
		BeltalowdaSm.state.items[siegeIndex].boughtGold = nil
		BeltalowdaSm.state.items[siegeIndex].boughtAP = nil
		BeltalowdaSm.state.items[siegeIndex].stack = 0
		BeltalowdaSm.state.items[siegeIndex].statusCode = nil
		BeltalowdaSm.state.items[siegeIndex].boughtItems = 0
	end
end

function BeltalowdaSm.DisplaySalesFeedback()
	local showErrorUnknownMessage = false
	local showErrorPaymentOptionMessage = false
	local showErrorInventoryMessage = false
	local showErrorAPMessage = false
	local showErrorGoldMessage = false
	local showErrorApOrGoldMessage = false
	local showSuccessMessage = false

	for siegeIndex = 1, #BeltalowdaSm.state.items do
		if BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_SUCCESS then
			showSuccessMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_INVENTORY_SLOTS then
			showErrorInventoryMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING then
			showErrorAPMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING then
			showErrorGoldMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_AP_OR_GOLD_MISSING then
			showErrorApOrGoldMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT then
			showErrorPaymentOptionMessage = true
		elseif BeltalowdaSm.state.items[siegeIndex].statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
			showErrorUnknownMessage = true
		end
	end
	if showSuccessMessage == true and showErrorGoldMessage == false and showErrorAPMessage == false and showErrorInventoryMessage == false and showErrorPaymentOptionMessage == false and showErrorUnknownMessage == false and showErrorApOrGoldMessage == false then
		BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.SUCCESS_MESSAGE, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_NORMAL, BeltalowdaSm.smVars.sendChatMessages)
	else
		if showErrorGoldMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end
		if showErrorAPMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end
		if showErrorApOrGoldMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP_OR_GOLD, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end
		if showErrorInventoryMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_INVENTORY_SLOTS, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end
		if showErrorPaymentOptionMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_UNKNOWN_PAYMENT_OPTION, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end
		if showErrorUnknownMessage == true then
			BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_UNKNOWN, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
		end		
	end
	--BeltalowdaChat.SendChatMessage(BeltalowdaSm.constants.ERROR_UNKNOWN, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_WARNING, BeltalowdaSm.smVars.sendChatMessages)
end

function BeltalowdaSm.IsItemStackable(itemId)
	if itemId == 27138 or itemId == 27962 or itemId == 27112 or itemId == 141731 or
	   itemId == 29534 or itemId == 29535 or itemId == 29533 or itemId == 142133 or 
	   itemId == 27971 or itemId == 36568 or itemId == 27974 or itemId == 27114 or
	   itemId == 44776 or itemId == 44775 or itemId == 27965 or itemId == 27968 or
	   itemId == 44777 or itemId == 30359 or itemId == 27850 or itemId == 204483 then
		return true
	else
		return false
	end
end

function BeltalowdaSm.GetMaxStackSize(itemId)
	if itemId == 27138 or itemId == 27962 or itemId == 27112 or itemId == 141731 or
	   itemId == 29534 or itemId == 29535 or itemId == 29533 or itemId == 142133 or 
	   itemId == 204483 then
		return BeltalowdaSm.constants.STACK_NORMAL
	elseif itemId == 71071 or itemId == 71072 or itemId == 71073 then
		return BeltalowdaSm.constants.STACK_POTS
	else
		return BeltalowdaSm.constants.STACK_WEAPONS
	end
end

function BeltalowdaSm.GetQuantity(storeIndex, paymentOption, quantity, siegeIndex)
	local statusCode = BeltalowdaSm.constants.STATE_BUY_SUCCESS
	local slotSize = 0
	--d("siegeIndex: " .. siegeIndex)
	if quantity < 0 then
		return statusCode, 0, slotSize
	end
	if storeIndex.available ~= nil and storeIndex.costs ~= nil then
		local maxItems = storeIndex.available / storeIndex.costs
		local maxQuantity = quantity
		
		if BeltalowdaSm.IsItemStackable(BeltalowdaSm.state.items[siegeIndex].id) == true then
			local maxStackSize = BeltalowdaSm.GetMaxStackSize(BeltalowdaSm.state.items[siegeIndex].id)
			--local freeSpace = BeltalowdaSm.state.itemSlots * 100 + (100 - (BeltalowdaSm.state.items[siegeIndex].stack % 100))
			local freeSpace = BeltalowdaSm.state.itemSlots * maxStackSize --+ (100 - (BeltalowdaSm.state.items[siegeIndex].stack % 100))
			if freeSpace < quantity then
				--not enough free space available.
				maxQuantity = freeSpace
				statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_INVENTORY_SLOTS
			end
			if maxItems < maxQuantity then
				--not enough ap or gold
				if paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_AP then
					statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING
				elseif paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_GOLD then
					statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING
				end
				maxQuantity = maxItem
			end
			--slotSize = maxQuantity - (100 - (maxQuantity % 100))
			slotSize = maxQuantity -- - (100 - (maxQuantity % 100))
			if maxQuantity == nil then
				maxQuantity = 0
			end
			if slotSize == nil or slotSize < 0 then
				slotSize = 0
			else
				local incompleteStacke = false
				if slotSize % maxStackSize ~= 0 then
					incompleteStacke = true
				end
				slotSize = (slotSize - (slotSize % maxStackSize)) / maxStackSize
				if incompleteStacke == true then
					slotSize = slotSize + 1
				end
			end

		else
			if BeltalowdaSm.state.itemSlots < quantity then
				--not enough free space available.
				maxQuantity = BeltalowdaSm.state.itemSlots
				slotSize = maxQuantity
				statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_INVENTORY_SLOTS
			end
			if maxItems < maxQuantity then
				--not enough ap or gold
				if paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_AP then
					statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING
				elseif paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_GOLD then
					statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING
				end
				
				maxQuantity = maxItems
				slotSize = maxItems
			end
			
		end
		return statusCode, maxQuantity, slotSize
	else
		--d(slotSize)
		return statusCode, -1, slotSize
	end
end

function BeltalowdaSm.BuySpecificItem(siegeIndex, quantity)
	local statusCode = BeltalowdaSm.constants.STATE_BUY_SUCCESS
	local boughtItems = 0
	if quantity > 0 then
		local ap = GetAlliancePoints()
		local gold = GetCurrentMoney()
		local buyItem = false
		local simpleStoreIndex = {}
		local complexStoreIndex = {}
		
		if BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_AP then
			simpleStoreIndex.costs = BeltalowdaSm.state.items[siegeIndex].shopEntryAP
			simpleStoreIndex.available = ap
			simpleStoreIndex.index = BeltalowdaSm.state.items[siegeIndex].shopIndexAP
			simpleStoreIndex.error = BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP
		elseif BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_ONLY_GOLD then
			simpleStoreIndex.costs = BeltalowdaSm.state.items[siegeIndex].shopEntryGold
			simpleStoreIndex.available = gold
			simpleStoreIndex.index = BeltalowdaSm.state.items[siegeIndex].shopIndexGold
			simpleStoreIndex.error = BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD
		elseif BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_FIRST_AP or BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_FIRST_GOLD then
			complexStoreIndex.ap = {}
			complexStoreIndex.ap.costs = BeltalowdaSm.state.items[siegeIndex].shopEntryAP
			complexStoreIndex.ap.available = ap
			complexStoreIndex.ap.index = BeltalowdaSm.state.items[siegeIndex].shopIndexAP
			complexStoreIndex.ap.error = BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_AP
			complexStoreIndex.gold = {}
			complexStoreIndex.gold.costs = BeltalowdaSm.state.items[siegeIndex].shopEntryGold
			complexStoreIndex.gold.available = gold
			complexStoreIndex.gold.index = BeltalowdaSm.state.items[siegeIndex].shopIndexGold
			complexStoreIndex.gold.error = BeltalowdaSm.constants.ERROR_PAYMENT_NOT_ENOUGH_GOLD
			if complexStoreIndex.ap.costs ~= nil then
				BeltalowdaChat.SendChatMessage("Item: " .. siegeIndex .. ", Quantity: " .. quantity .. ", AP: " .. complexStoreIndex.ap.costs, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG, BeltalowdaSm.smVars.sendChatMessages)
			end
			if complexStoreIndex.gold.costs ~= nil then
				BeltalowdaChat.SendChatMessage("Item: " .. siegeIndex .. ", Quantity: " .. quantity .. ", Gold: " .. complexStoreIndex.gold.costs, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG, BeltalowdaSm.smVars.sendChatMessages)
			end
		else
			statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT
		end
		BeltalowdaChat.SendChatMessage("Buy: nil, Item: " .. siegeIndex .. ", Quantity: " .. quantity, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG, BeltalowdaSm.smVars.sendChatMessages)
		if simpleStoreIndex.costs ~= nil or (complexStoreIndex.gold ~= nil and complexStoreIndex.ap ~= nil and (complexStoreIndex.gold.costs ~= nil or complexStoreIndex.ap.costs ~= nil)) then
			buyItem = true
			BeltalowdaChat.SendChatMessage("Buy: true, Item: " .. siegeIndex .. ", Quantity: " .. quantity, BeltalowdaSm.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG, BeltalowdaSm.smVars.sendChatMessages)
		end
		--d("method called on siegeIndex: " .. siegeIndex)
		if buyItem == true then
			if simpleStoreIndex.costs ~= nil and simpleStoreIndex.available ~= nil then
				--AP or Gold
				local status, maxQuantity, stackSize = BeltalowdaSm.GetQuantity(simpleStoreIndex, BeltalowdaSm.smVars.paymentOption, quantity, siegeIndex)
				statusCode = status
				
				if statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
					boughtItems = maxQuantity
					BuyStoreItem(simpleStoreIndex.index, maxQuantity)
					BeltalowdaSm.state.itemSlots = BeltalowdaSm.state.itemSlots - stackSize
					BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + maxQuantity
					--d("BuyStoreItem: " .. siegeIndex .. " -> " .. maxQuantity)
				end
			elseif complexStoreIndex.ap ~= nil and complexStoreIndex.gold ~= nil then 
				--AP and Gold
				if BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_FIRST_AP then
					--First AP
					local buyForGold = false
					local status, maxQuantity, stackSize = BeltalowdaSm.GetQuantity(complexStoreIndex.ap, BeltalowdaSm.constants.PAYMENT_ONLY_AP, quantity, siegeIndex)
					if maxQuantity > 0 and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
						boughtItems = maxQuantity
						BuyStoreItem(complexStoreIndex.ap.index, maxQuantity)
						BeltalowdaSm.state.itemSlots = BeltalowdaSm.state.itemSlots - stackSize
						BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + maxQuantity
					end
					if status == BeltalowdaSm.constants.STATE_BUY_SUCCESS and maxQuantity == -1 or status == BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING then
						buyForGold = true
					else
						statusCode = status
					end
					
					--Then Gold
					if buyForGold == true then
						status, maxQuantity, stackSize = BeltalowdaSm.GetQuantity(complexStoreIndex.gold, BeltalowdaSm.constants.PAYMENT_ONLY_GOLD, quantity - boughtItems, siegeIndex)
						statusCode = status
						if maxQuantity > 0 and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
							boughtItems = boughtItems + maxQuantity
							BuyStoreItem(complexStoreIndex.gold.index, maxQuantity)
							BeltalowdaSm.state.itemSlots = BeltalowdaSm.state.itemSlots - stackSize
							BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + maxQuantity
						end
						if statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING then
							statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING
						end
					end
					
				elseif BeltalowdaSm.smVars.paymentOption == BeltalowdaSm.constants.PAYMENT_FIRST_GOLD then
					--First Gold
					--d("fsg: " .. quantity)
					local buyForAP = false
					local status, maxQuantity, stackSize = BeltalowdaSm.GetQuantity(complexStoreIndex.gold, BeltalowdaSm.constants.PAYMENT_ONLY_GOLD, quantity, siegeIndex)
					if maxQuantity > 0 and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
						boughtItems = maxQuantity
						BuyStoreItem(complexStoreIndex.gold.index, maxQuantity)
						BeltalowdaSm.state.itemSlots = BeltalowdaSm.state.itemSlots - stackSize
						BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + maxQuantity
						--d("bought")
					end
					if status == BeltalowdaSm.constants.STATE_BUY_SUCCESS and maxQuantity == -1 or status == BeltalowdaSm.constants.STATE_BUY_FAILED_GOLD_MISSING then
						buyForAP = true
					else
						statusCode = status
					end
					--d(statusCode)
					--Then AP
					if buyForAP == true then
						status, maxQuantity, stackSize = BeltalowdaSm.GetQuantity(complexStoreIndex.ap, BeltalowdaSm.constants.PAYMENT_ONLY_AP, quantity - boughtItems, siegeIndex)
						statusCode = status
						if maxQuantity > 0 and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR_PAYMENT and statusCode ~= BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR then
							boughtItems = boughtItems + maxQuantity
							BuyStoreItem(complexStoreIndex.ap.index, maxQuantity)
							BeltalowdaSm.state.itemSlots = BeltalowdaSm.state.itemSlots - maxQuantity
							BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + stackSize
						end
						if statusCode == BeltalowdaSm.constants.STATE_BUY_FAILED_AP_MISSING then
							statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_AP_OR_GOLD_MISSING
						end
					end
					
				end
			else
				--Something is off
				statusCode = BeltalowdaSm.constants.STATE_BUY_FAILED_ERROR
			end
		end
	end
	return statusCode, boughtItems
end

function BeltalowdaSm.BuyItems()
	--Min
	BeltalowdaSm.state.itemSlots = GetNumBagFreeSlots(BAG_BACKPACK)
	BeltalowdaSm.UpdateInventoryList()
	BeltalowdaSm.UpdatePersonalShoppingList()
	local validStatusCode = true
	for i = 1, #BeltalowdaSm.state.priorityList do
		local siegeIndex = BeltalowdaSm.state.priorityList[i]
		local statusCode, boughtItems = BeltalowdaSm.BuySpecificItem(siegeIndex, BeltalowdaSm.state.items[siegeIndex].buyMin)
		BeltalowdaSm.state.items[siegeIndex].statusCode = statusCode
		BeltalowdaSm.state.items[siegeIndex].boughtItems = boughtItems
		if statusCode ~= BeltalowdaSm.constants.STATE_BUY_SUCCESS then
			validStatusCode = false
		end
	end
	--d(validStatusCode)
	--Max
	if validStatusCode == true then
		--BeltalowdaSm.UpdateInventoryList()
		BeltalowdaSm.UpdatePersonalShoppingList()
		for i = 1, #BeltalowdaSm.state.priorityList do
			local siegeIndex = BeltalowdaSm.state.priorityList[i]
			local statusCode, boughtItems = BeltalowdaSm.BuySpecificItem(siegeIndex, BeltalowdaSm.state.items[siegeIndex].buyMax)
			BeltalowdaSm.state.items[siegeIndex].statusCode = statusCode
			BeltalowdaSm.state.items[siegeIndex].boughtItems = BeltalowdaSm.state.items[siegeIndex].boughtItems + boughtItems
		end
	end
end

function BeltalowdaSm.UpdatePersonalShoppingList()
	for i = 1, #BeltalowdaSm.smVars.items do
		BeltalowdaSm.state.items[i].buyMax = BeltalowdaSm.smVars.items[i].maximum - BeltalowdaSm.state.items[i].stack
		BeltalowdaSm.state.items[i].buyMin = BeltalowdaSm.smVars.items[i].minimum - BeltalowdaSm.state.items[i].stack
	end
end

function BeltalowdaSm.UpdateShopList()
	BeltalowdaSm.ClearStateEntries()
	local shopIdentified = false
	for itemIndex = 1, GetNumStoreItems() do
		local icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToUse, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, entryType = GetStoreEntryInfo(itemIndex)
		local _, _, _, itemId = ZO_LinkHandler_ParseLink(GetStoreItemLink(itemIndex))
		if itemId ~= nil then
			itemId = tonumber(itemId)
			--d(name .. ": " .. itemId .. ", " .. price .. ", " .. sellPrice .. ", " .. currencyQuantity1 .. currencyType1 .. ", " .. currencyQuantity2 .. currencyType2 .. ", " .. entryType)
			--d(#BeltalowdaSm.state.items)
			for siegeIndex = 1, #BeltalowdaSm.state.items do
				--d(BeltalowdaSm.state.items[siegeIndex].id)
				--d(itemId)
				--d(BeltalowdaSm.state.items[siegeIndex].id == itemId)
				if BeltalowdaSm.state.items[siegeIndex].id == itemId then
					--d("item identified: " .. price .. ", " .. currencyQuantity1)
					shopIdentified = true
					if price ~= nil and price ~= 0 then
						BeltalowdaSm.state.items[siegeIndex].shopEntryGold = price
						BeltalowdaSm.state.items[siegeIndex].shopIndexGold = itemIndex
					elseif currencyQuantity1 ~= nil and currencyQuantity1 ~= 0 then
						BeltalowdaSm.state.items[siegeIndex].shopEntryAP = currencyQuantity1
						BeltalowdaSm.state.items[siegeIndex].shopIndexAP = itemIndex
					end
					break
				end
			end
		end			
	end
	return shopIdentified
end

function BeltalowdaSm.UpdateInventoryList()
	for siegeIndex = 1, #BeltalowdaSm.state.items do
		BeltalowdaSm.state.items[siegeIndex].stack = 0
	end
	for invId = 0, GetBagSize(BAG_BACKPACK) do
		local _, _, _, itemId = ZO_LinkHandler_ParseLink(GetItemLink(BAG_BACKPACK, invId))
		--d(itemId)
		itemId = tonumber(itemId)
		
		if itemId ~= nil then
			local stack = GetSlotStackSize(BAG_BACKPACK, invId)
			for siegeIndex = 1, #BeltalowdaSm.state.items do
				if BeltalowdaSm.state.items[siegeIndex].id == itemId then
					BeltalowdaSm.state.items[siegeIndex].stack = BeltalowdaSm.state.items[siegeIndex].stack + stack
					break
				end
			end			
		end
	end
end

--menu interactions
function BeltalowdaSm.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.SM_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SM_ENABLED,
					getFunc = BeltalowdaSm.GetSmEnabled,
					setFunc = BeltalowdaSm.SetSmEnabled
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.SM_SEND_CHAT_MESSAGES,
					getFunc = BeltalowdaSm.GetSmSendChatMessages,
					setFunc = BeltalowdaSm.SetSmSendChatMessages
				},
				[3] = {
					type = "divider",
					width = "full"
				},
				[4] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_REPAIR_ALL,
					width = "full"
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 1000,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairAllMin,
					setFunc = BeltalowdaSm.SetSmItemRepairAllMin,
					width = "full",
					default = 5
				},
				[6] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemRepairAllMax,
					setFunc = BeltalowdaSm.SetSmItemRepairAllMax,
					width = "full",
					default = 10
				},
				[7] = {
					type = "divider",
					width = "full"
				},
				[8] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_BALLISTA_FIRE,
					width = "full"
				},
				[9] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaFireMin,
					setFunc = BeltalowdaSm.SetSmItemBallistaFireMin,
					width = "full",
					default = 5
				},
				[10] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaFireMax,
					setFunc = BeltalowdaSm.SetSmItemBallistaFireMax,
					width = "full",
					default = 10
				},
				[11] = {
					type = "divider",
					width = "full"
				},
				[12] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_BALLISTA_STONE,
					width = "full"
				},
				[13] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaMin,
					setFunc = BeltalowdaSm.SetSmItemBallistaMin,
					width = "full",
					default = 5
				},
				[14] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaMax,
					setFunc = BeltalowdaSm.SetSmItemBallistaMax,
					width = "full",
					default = 10
				},
				[15] = {
					type = "divider",
					width = "full"
				},
				[16] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_BALLISTA_LIGHTNING,
					width = "full"
				},
				[17] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaLightningMin,
					setFunc = BeltalowdaSm.SetSmItemBallistaLightningMin,
					width = "full",
					default = 0
				},
				[18] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemBallistaLightningMax,
					setFunc = BeltalowdaSm.SetSmItemBallistaLightningMax,
					width = "full",
					default = 0
				},
				[19] = {
					type = "divider",
					width = "full"
				},
				[20] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_FIRE,
					width = "full"
				},
				[21] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetFireMin,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetFireMin,
					width = "full",
					default = 0
				},
				[22] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetFireMax,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetFireMax,
					width = "full",
					default = 0
				},
				[23] = {
					type = "divider",
					width = "full"
				},
				[24] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_STONE,
					width = "full"
				},
				[25] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetStoneMin,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetStoneMin,
					width = "full",
					default = 0
				},
				[26] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetStoneMax,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetStoneMax,
					width = "full",
					default = 0
				},
				[27] = {
					type = "divider",
					width = "full"
				},
				[28] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_TREBUCHET_ICE,
					width = "full"
				},
				[29] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetIceMin,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetIceMin,
					width = "full",
					default = 0
				},
				[30] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemTrebuchetIceMax,
					setFunc = BeltalowdaSm.SetSmItemTrebuchetIceMax,
					width = "full",
					default = 0
				},
				[31] = {
					type = "divider",
					width = "full"
				},
				[32] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_CATAPULT_MEATBAG,
					width = "full"
				},
				[33] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultMeatbagMin,
					setFunc = BeltalowdaSm.SetSmItemCatapultMeatbagMin,
					width = "full",
					default = 2
				},
				[34] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultMeatbagMax,
					setFunc = BeltalowdaSm.SetSmItemCatapultMeatbagMax,
					width = "full",
					default = 5
				},
				[35] = {
					type = "divider",
					width = "full"
				},
				[36] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_CATAPULT_OIL,
					width = "full"
				},
				[37] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultOilMin,
					setFunc = BeltalowdaSm.SetSmItemCatapultOilMin,
					width = "full",
					default = 0
				},
				[38] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultOilMax,
					setFunc = BeltalowdaSm.SetSmItemCatapultOilMax,
					width = "full",
					default = 0
				},
				[39] = {
					type = "divider",
					width = "full"
				},
				[40] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_CATAPULT_SCATTERSHOT,
					width = "full"
				},
				[41] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultScattershotMin,
					setFunc = BeltalowdaSm.SetSmItemCatapultScattershotMin,
					width = "full",
					default = 0
				},
				[42] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCatapultScattershotMax,
					setFunc = BeltalowdaSm.SetSmItemCatapultScattershotMax,
					width = "full",
					default = 0
				},
				[43] = {
					type = "divider",
					width = "full"
				},
				[44] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_OIL,
					width = "full"
				},
				[45] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemOilMin,
					setFunc = BeltalowdaSm.SetSmItemOilMin,
					width = "full",
					default = 3
				},
				[46] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemOilMax,
					setFunc = BeltalowdaSm.SetSmItemOilMax,
					width = "full",
					default = 5
				},
				[47] = {
					type = "divider",
					width = "full"
				},
				[48] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_CAMP,
					width = "full"
				},
				[49] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 25,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCampMin,
					setFunc = BeltalowdaSm.SetSmItemCampMin,
					width = "full",
					default = 2
				},
				[50] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 25,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemCampMax,
					setFunc = BeltalowdaSm.SetSmItemCampMax,
					width = "full",
					default = 3
				},
				[51] = {
					type = "divider",
					width = "full"
				},
				[52] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_RAM,
					width = "full"
				},
				[53] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRamMin,
					setFunc = BeltalowdaSm.SetSmItemRamMin,
					width = "full",
					default = 2
				},
				[54] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRamMax,
					setFunc = BeltalowdaSm.SetSmItemRamMax,
					width = "full",
					default = 5
				},
				[55] = {
					type = "divider",
					width = "full"
				},
				[56] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_KEEP_RECALL,
					width = "full"
				},
				[57] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemKeepRecallMin,
					setFunc = BeltalowdaSm.SetSmItemKeepRecallMin,
					width = "full",
					default = 2
				},
				[58] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 100,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemKeepRecallMax,
					setFunc = BeltalowdaSm.SetSmItemKeepRecallMax,
					width = "full",
					default = 5
				},
				[59] = {
					type = "divider",
					width = "full"
				},
				[60] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_POT_RED,
					width = "full"
				},
				[61] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotRedMin,
					setFunc = BeltalowdaSm.SetSmItemPotRedMin,
					width = "full",
					default = 2
				},
				[62] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotRedMax,
					setFunc = BeltalowdaSm.SetSmItemPotRedMax,
					width = "full",
					default = 5
				},
				[63] = {
					type = "divider",
					width = "full"
				},
				[64] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_POT_GREEN,
					width = "full"
				},
				[65] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotGreenMin,
					setFunc = BeltalowdaSm.SetSmItemPotGreenMin,
					width = "full",
					default = 2
				},
				[66] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotGreenMax,
					setFunc = BeltalowdaSm.SetSmItemPotGreenMax,
					width = "full",
					default = 5
				},
				[67] = {
					type = "divider",
					width = "full"
				},
				[68] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_POT_BLUE,
					width = "full"
				},
				[69] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotBlueMin,
					setFunc = BeltalowdaSm.SetSmItemPotBlueMin,
					width = "full",
					default = 2
				},
				[70] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 1000,
					step = 10,
					getFunc = BeltalowdaSm.GetSmItemPotBlueMax,
					setFunc = BeltalowdaSm.SetSmItemPotBlueMax,
					width = "full",
					default = 5
				},
				[71] = {
					type = "divider",
					width = "full"
				},
				[72] = {
					type = "dropdown",
					name = BeltalowdaMenu.constants.SM_PAYMENT_OPTIONS,
					choices = BeltalowdaSm.GetSmPaymentOptions(),
					getFunc = BeltalowdaSm.GetSmPaymentOption,
					setFunc = BeltalowdaSm.SetSmPaymentOption
				}
				--[[
				[3] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_REPAIR_WALL,
					width = "full"
				},
				[4] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairWallMin,
					setFunc = BeltalowdaSm.SetSmItemRepairWallMin,
					width = "full",
					default = 100
				},
				[5] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairWallMax,
					setFunc = BeltalowdaSm.SetSmItemRepairWallMax,
					width = "full",
					default = 100
				},
				[6] = {
					type = "divider",
					width = "full"
				},
				[7] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_REPAIR_DOOR,
					width = "full"
				},
				[8] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairDoorMin,
					setFunc = BeltalowdaSm.SetSmItemRepairDoorMin,
					width = "full",
					default = 100
				},
				[9] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairDoorMax,
					setFunc = BeltalowdaSm.SetSmItemRepairDoorMax,
					width = "full",
					default = 100
				},
				
				[10] = {
					type = "divider",
					width = "full"
				},
				[11] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_REPAIR_SIEGE,
					width = "full"
				},
				[12] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairSiegeMin,
					setFunc = BeltalowdaSm.SetSmItemRepairSiegeMin,
					width = "full",
					default = 0
				},
				[13] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemRepairSiegeMax,
					setFunc = BeltalowdaSm.SetSmItemRepairSiegeMax,
					width = "full",
					default = 0
				},
				[66] = {
					type = "divider",
					width = "full"
				},
				[67] = {
					type = "description",
					title = nil,
					text = BeltalowdaMenu.constants.SM_ITEM_DESTRUCTIBLE_REPAIR,
					width = "full"
				},
				[68] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MIN,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemDestructibleRepairMin,
					setFunc = BeltalowdaSm.SetSmItemDestructibleRepairMin,
					width = "full",
					default = 0
				},
				[69] = {
					type = "slider",
					name = BeltalowdaMenu.constants.SM_MAX,
					min = 0,
					max = 500,
					step = 1,
					getFunc = BeltalowdaSm.GetSmItemDestructibleRepairMax,
					setFunc = BeltalowdaSm.SetSmItemDestructibleRepairMax,
					width = "full",
					default = 0
				},
				]]
			}
		}
	}
	return menu
end

function BeltalowdaSm.GetSmEnabled()
	return BeltalowdaSm.smVars.enabled
end

function BeltalowdaSm.SetSmEnabled(value)
	BeltalowdaSm.SetEnabled(value)
end

function BeltalowdaSm.GetSmSendChatMessages()
	return BeltalowdaSm.smVars.sendChatMessages
end

function BeltalowdaSm.SetSmSendChatMessages(value)
	BeltalowdaSm.smVars.sendChatMessages = value
end

--[[
function BeltalowdaSm.GetSmItemRepairWallMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_WALL)
end

function BeltalowdaSm.SetSmItemRepairWallMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_WALL, value)
end

function BeltalowdaSm.GetSmItemRepairWallMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_WALL)
end

function BeltalowdaSm.SetSmItemRepairWallMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_WALL, value)
end

function BeltalowdaSm.GetSmItemRepairDoorMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_DOOR)
end

function BeltalowdaSm.SetSmItemRepairDoorMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_DOOR, value)
end

function BeltalowdaSm.GetSmItemRepairDoorMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_DOOR)
end

function BeltalowdaSm.SetSmItemRepairDoorMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_DOOR, value)
end

function BeltalowdaSm.GetSmItemRepairSiegeMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_SIEGE)
end

function BeltalowdaSm.SetSmItemRepairSiegeMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_SIEGE, value)
end

function BeltalowdaSm.GetSmItemRepairSiegeMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_SIEGE)
end

function BeltalowdaSm.SetSmItemRepairSiegeMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_SIEGE, value)
end
]]

function BeltalowdaSm.GetSmItemBallistaFireMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_FIRE)
end

function BeltalowdaSm.SetSmItemBallistaFireMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_FIRE, value)
end

function BeltalowdaSm.GetSmItemBallistaFireMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_FIRE)
end

function BeltalowdaSm.SetSmItemBallistaFireMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_FIRE, value)
end

function BeltalowdaSm.GetSmItemBallistaMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_STONE)
end

function BeltalowdaSm.SetSmItemBallistaMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_STONE, value)
end

function BeltalowdaSm.GetSmItemBallistaMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_STONE)
end

function BeltalowdaSm.SetSmItemBallistaMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_STONE, value)
end

function BeltalowdaSm.GetSmItemBallistaLightningMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING)
end

function BeltalowdaSm.SetSmItemBallistaLightningMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING, value)
end

function BeltalowdaSm.GetSmItemBallistaLightningMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING)
end

function BeltalowdaSm.SetSmItemBallistaLightningMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_BALLISTA_LIGHTNING, value)
end

function BeltalowdaSm.GetSmItemTrebuchetFireMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE)
end

function BeltalowdaSm.SetSmItemTrebuchetFireMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE, value)
end

function BeltalowdaSm.GetSmItemTrebuchetFireMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE)
end

function BeltalowdaSm.SetSmItemTrebuchetFireMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_FIRE, value)
end

function BeltalowdaSm.GetSmItemTrebuchetStoneMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_STONE)
end

function BeltalowdaSm.SetSmItemTrebuchetStoneMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_STONE, value)
end

function BeltalowdaSm.GetSmItemTrebuchetStoneMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_STONE)
end

function BeltalowdaSm.SetSmItemTrebuchetStoneMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_STONE, value)
end

function BeltalowdaSm.GetSmItemTrebuchetIceMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_ICE)
end

function BeltalowdaSm.SetSmItemTrebuchetIceMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_TREBUCHET_ICE, value)
end

function BeltalowdaSm.GetSmItemTrebuchetIceMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_ICE)
end

function BeltalowdaSm.SetSmItemTrebuchetIceMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_TREBUCHET_ICE, value)
end

function BeltalowdaSm.GetSmItemCatapultMeatbagMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG)
end

function BeltalowdaSm.SetSmItemCatapultMeatbagMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG, value)
end

function BeltalowdaSm.GetSmItemCatapultMeatbagMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG)
end

function BeltalowdaSm.SetSmItemCatapultMeatbagMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_MEATBAG, value)
end

function BeltalowdaSm.GetSmItemCatapultOilMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_OIL)
end

function BeltalowdaSm.SetSmItemCatapultOilMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_OIL, value)
end

function BeltalowdaSm.GetSmItemCatapultOilMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_OIL)
end

function BeltalowdaSm.SetSmItemCatapultOilMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_OIL, value)
end

function BeltalowdaSm.GetSmItemCatapultScattershotMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT)
end

function BeltalowdaSm.SetSmItemCatapultScattershotMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT, value)
end

function BeltalowdaSm.GetSmItemCatapultScattershotMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT)
end

function BeltalowdaSm.SetSmItemCatapultScattershotMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_CATAPULT_SCATTERSHOT, value)
end

function BeltalowdaSm.GetSmItemOilMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_OIL)
end

function BeltalowdaSm.SetSmItemOilMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_OIL, value)
end

function BeltalowdaSm.GetSmItemOilMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_OIL)
end

function BeltalowdaSm.SetSmItemOilMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_OIL, value)
end

function BeltalowdaSm.GetSmItemCampMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_CAMP)
end

function BeltalowdaSm.SetSmItemCampMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_CAMP, value)
end

function BeltalowdaSm.GetSmItemCampMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_CAMP)
end

function BeltalowdaSm.SetSmItemCampMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_CAMP, value)
end

function BeltalowdaSm.GetSmItemRamMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_RAM)
end

function BeltalowdaSm.SetSmItemRamMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_RAM, value)
end

function BeltalowdaSm.GetSmItemRamMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_RAM)
end

function BeltalowdaSm.SetSmItemRamMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_RAM, value)
end

function BeltalowdaSm.GetSmItemKeepRecallMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_KEEP_RECALL)
end

function BeltalowdaSm.SetSmItemKeepRecallMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_KEEP_RECALL, value)
end

function BeltalowdaSm.GetSmItemKeepRecallMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_KEEP_RECALL)
end

function BeltalowdaSm.SetSmItemKeepRecallMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_KEEP_RECALL, value)
end

--[[
function BeltalowdaSm.GetSmItemDestructibleRepairMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR)
end

function BeltalowdaSm.SetSmItemDestructibleRepairMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR, value)
end

function BeltalowdaSm.GetSmItemDestructibleRepairMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR)
end

function BeltalowdaSm.SetSmItemDestructibleRepairMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_DESTRUCTIBLE_REPAIR, value)
end
]]
function BeltalowdaSm.GetSmItemRepairAllMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_ALL)
end

function BeltalowdaSm.SetSmItemRepairAllMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_REPAIR_ALL, value)
end

function BeltalowdaSm.GetSmItemRepairAllMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_ALL)
end

function BeltalowdaSm.SetSmItemRepairAllMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_REPAIR_ALL, value)
end

function BeltalowdaSm.GetSmItemPotRedMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_POT_RED)
end

function BeltalowdaSm.SetSmItemPotRedMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_POT_RED, value)
end

function BeltalowdaSm.GetSmItemPotRedMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_POT_RED)
end

function BeltalowdaSm.SetSmItemPotRedMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_POT_RED, value)
end

function BeltalowdaSm.GetSmItemPotGreenMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_POT_GREEN)
end

function BeltalowdaSm.SetSmItemPotGreenMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_POT_GREEN, value)
end

function BeltalowdaSm.GetSmItemPotGreenMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_POT_GREEN)
end

function BeltalowdaSm.SetSmItemPotGreenMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_POT_GREEN, value)
end

function BeltalowdaSm.GetSmItemPotBlueMin()
	return BeltalowdaSm.GetMinimum(BeltalowdaSm.constants.ITEM_POT_BLUE)
end

function BeltalowdaSm.SetSmItemPotBlueMin(value)
	BeltalowdaSm.SetMinimum(BeltalowdaSm.constants.ITEM_POT_BLUE, value)
end

function BeltalowdaSm.GetSmItemPotBlueMax()
	return BeltalowdaSm.GetMaximum(BeltalowdaSm.constants.ITEM_POT_BLUE)
end

function BeltalowdaSm.SetSmItemPotBlueMax(value)
	BeltalowdaSm.SetMaximum(BeltalowdaSm.constants.ITEM_POT_BLUE, value)
end

function BeltalowdaSm.GetSmPaymentOptions()
	return {
		BeltalowdaSm.paymentOptions[BeltalowdaSm.constants.PAYMENT_ONLY_AP],
		BeltalowdaSm.paymentOptions[BeltalowdaSm.constants.PAYMENT_ONLY_GOLD],
		BeltalowdaSm.paymentOptions[BeltalowdaSm.constants.PAYMENT_FIRST_AP],
		BeltalowdaSm.paymentOptions[BeltalowdaSm.constants.PAYMENT_FIRST_GOLD]
	}
end

function BeltalowdaSm.GetSmPaymentOption()
	return BeltalowdaSm.paymentOptions[BeltalowdaSm.smVars.paymentOption]
end

function BeltalowdaSm.SetSmPaymentOption(value)
	if value ~= nil then
		for i = 1, #BeltalowdaSm.paymentOptions do
			if BeltalowdaSm.paymentOptions[i] == value then
				BeltalowdaSm.smVars.paymentOption = i
				return
			end
		end
	end
end
