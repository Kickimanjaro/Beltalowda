-- Beltalowda Player Link
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.playerLink = BeltalowdaUtil.playerLink or {}
local BeltalowdaPL = BeltalowdaUtil.playerLink

function BeltalowdaPL.CreateDisplayNameLink(nameToDisplay, displayName, hasBrackets)
	local link = ""
	if nameToDisplay ~= nil then
		link = ZO_LinkHandler_CreateLink(nameToDisplay, nil, DISPLAY_NAME_LINK_TYPE, displayName)
	end
	if hasBrackets == nil or hasBrackets == false then
		link = BeltalowdaPL.RemoveBracketsFromLink(link)
	end
	return link
end

function BeltalowdaPL.CreateCharNameLink(nameToDisplay, charName, hasBrackets)
	local link = ""
	if nameToDisplay ~= nil then
		link = ZO_LinkHandler_CreateLink(nameToDisplay, nil, CHARACTER_LINK_TYPE, charName)
	end
	if hasBrackets == nil or hasBrackets == false then
		link = BeltalowdaPL.RemoveBracketsFromLink(link)
	end
	return link
end

function BeltalowdaPL.RemoveBracketsFromLink(link)
	link = link:gsub("%[",""):gsub("%]","")
	return link
end