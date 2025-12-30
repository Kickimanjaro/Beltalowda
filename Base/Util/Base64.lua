-- Beltalowda Base64
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.base64 = BeltalowdaUtil.base64 or {}
local BeltalowdaBase64 = BeltalowdaUtil.base64
BeltalowdaBase64.returnCodes = {}
BeltalowdaBase64.returnCodes.SUCCESS = 0
BeltalowdaBase64.returnCodes.FAILED = 1

local keySpace = { [0] =
   'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
   'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
   'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
   'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/',
}

function BeltalowdaBase64.Encode(content)
	local retVal = ""
	local errorCode = BeltalowdaBase64.returnCodes.FAILED
	if type(content) == "string" then
		content = {content:byte(1,content:len())}
	
	end
	return retVal, errorCode
end

function BeltalowdaBase64.Decode(content)
	local retVal = ""
	local errorCode = BeltalowdaBase64.returnCodes.FAILED
	if type(content) == "string" then
	
	
	end
	return retVal, errorCode
end