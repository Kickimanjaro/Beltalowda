-- Beltalowda Iventory
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.inventory = BeltalowdaUtil.inventory or {}
local RdkGToolInventory = BeltalowdaUtil.inventory

--functions
function RdkGToolInventory.GetSoulGemsInventoryInformation()
	local retVal = {}
	local identifiedItem = 1
	for invId = 0, GetBagSize(BAG_BACKPACK) do
		if IsItemSoulGem(SOUL_GEM_TYPE_FILLED,BAG_BACKPACK,invId) == true then
			retVal[identifiedItem] = {}
			retVal[identifiedItem].slot = invId
			retVal[identifiedItem].stack = GetSlotStackSize(BAG_BACKPACK, invId)
			identifiedItem = identifiedItem + 1
		end
	end
	return retVal
end