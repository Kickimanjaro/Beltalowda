-- Beltalowda Fonts
-- By @s0rdrak (PC / EU)

Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.fonts = BeltalowdaUtil.fonts or {}
local BeltalowdaFonts = BeltalowdaUtil.fonts

BeltalowdaFonts.constants = {}
BeltalowdaFonts.constants.COMPLEX_FONT = "$(%s)|$(%s_%d)|%s"
BeltalowdaFonts.constants.SIMPLE_FONT = "$(%s)|$(%s_%d)"

BeltalowdaFonts.constants.INPUT_KB = 1
BeltalowdaFonts.constants.INPUT_GP = 2

BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK = 1
BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN = 2
BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE = 3

BeltalowdaFonts.constants.MEDIUM_FONT = 1
BeltalowdaFonts.constants.BOLD_FONT = 2
BeltalowdaFonts.constants.CHAT_FONT = 3
BeltalowdaFonts.constants.GAMEPAD_LIGHT_FONT = 4
BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT = 5
BeltalowdaFonts.constants.GAMEPAD_BOLD_FONT = 6
BeltalowdaFonts.constants.ANTIQUE_FONT = 7
BeltalowdaFonts.constants.HANDWRITTEN_FONT = 8
BeltalowdaFonts.constants.STONE_TABLET_FONT = 9


BeltalowdaFonts.config = {}
BeltalowdaFonts.config.sizes = {}
BeltalowdaFonts.config.sizes.names = {}
BeltalowdaFonts.config.sizes.names[BeltalowdaFonts.constants.INPUT_KB] = "KB"
BeltalowdaFonts.config.sizes.names[BeltalowdaFonts.constants.INPUT_GP] = "GP"
BeltalowdaFonts.config.sizes.kb = {}
BeltalowdaFonts.config.sizes.kb[1] = 8
BeltalowdaFonts.config.sizes.kb[2] = 9
BeltalowdaFonts.config.sizes.kb[3] = 10
BeltalowdaFonts.config.sizes.kb[4] = 11
BeltalowdaFonts.config.sizes.kb[5] = 12
BeltalowdaFonts.config.sizes.kb[6] = 13
BeltalowdaFonts.config.sizes.kb[7] = 14
BeltalowdaFonts.config.sizes.kb[8] = 15
BeltalowdaFonts.config.sizes.kb[9] = 16
BeltalowdaFonts.config.sizes.kb[10] = 17
BeltalowdaFonts.config.sizes.kb[11] = 18
BeltalowdaFonts.config.sizes.kb[12] = 19
BeltalowdaFonts.config.sizes.kb[13] = 20
BeltalowdaFonts.config.sizes.kb[14] = 21
BeltalowdaFonts.config.sizes.kb[15] = 22
BeltalowdaFonts.config.sizes.kb[16] = 23
BeltalowdaFonts.config.sizes.kb[17] = 24
BeltalowdaFonts.config.sizes.kb[18] = 25
BeltalowdaFonts.config.sizes.kb[19] = 26
BeltalowdaFonts.config.sizes.kb[20] = 28
BeltalowdaFonts.config.sizes.kb[21] = 30
BeltalowdaFonts.config.sizes.kb[22] = 32
BeltalowdaFonts.config.sizes.kb[23] = 34
BeltalowdaFonts.config.sizes.kb[24] = 36
BeltalowdaFonts.config.sizes.kb[25] = 40
BeltalowdaFonts.config.sizes.kb[26] = 48
BeltalowdaFonts.config.sizes.kb[27] = 54

BeltalowdaFonts.config.sizes.gp = {}
BeltalowdaFonts.config.sizes.gp[1] = 18
BeltalowdaFonts.config.sizes.gp[2] = 20
BeltalowdaFonts.config.sizes.gp[3] = 22
BeltalowdaFonts.config.sizes.gp[4] = 25
BeltalowdaFonts.config.sizes.gp[5] = 27
BeltalowdaFonts.config.sizes.gp[6] = 30
BeltalowdaFonts.config.sizes.gp[7] = 34
BeltalowdaFonts.config.sizes.gp[8] = 36
BeltalowdaFonts.config.sizes.gp[9] = 42
BeltalowdaFonts.config.sizes.gp[10] = 45
BeltalowdaFonts.config.sizes.gp[11] = 48
BeltalowdaFonts.config.sizes.gp[12] = 54
BeltalowdaFonts.config.sizes.gp[13] = 61

BeltalowdaFonts.config.styles = {}
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.MEDIUM_FONT] = "MEDIUM_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.BOLD_FONT] = "BOLD_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.CHAT_FONT] = "CHAT_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.GAMEPAD_LIGHT_FONT] = "GAMEPAD_LIGHT_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.GAMEPAD_MEDIUM_FONT] = "GAMEPAD_MEDIUM_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.GAMEPAD_BOLD_FONT] = "GAMEPAD_BOLD_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.ANTIQUE_FONT] = "ANTIQUE_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.HANDWRITTEN_FONT] = "HANDWRITTEN_FONT"
BeltalowdaFonts.config.styles[BeltalowdaFonts.constants.STONE_TABLET_FONT] = "STONE_TABLET_FONT"


BeltalowdaFonts.config.weights = {}
BeltalowdaFonts.config.weights[BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THICK] = "soft-shadow-thick"
BeltalowdaFonts.config.weights[BeltalowdaFonts.constants.WEIGHT_SOFT_SHADOW_THIN] = "soft-shadow-thin"
BeltalowdaFonts.config.weights[BeltalowdaFonts.constants.WEIGHT_THICK_OUTLINE] = "thick-outline"

function BeltalowdaFonts.CreateFontString(style, inputType, size, weight)
	local fontString = nil
	if style ~= nil and inputType ~= nil and size ~= nil then
		style = BeltalowdaFonts.config.styles[style]
		local inputTypeString = BeltalowdaFonts.config.sizes.names[inputType]
		if style ~= nil and inputTypeString ~= nil then
			local sizes = nil
			if inputType == BeltalowdaFonts.constants.INPUT_KB then
				sizes = BeltalowdaFonts.config.sizes.kb
			elseif inputType == BeltalowdaFonts.constants.INPUT_GP then
				sizes = BeltalowdaFonts.config.sizes.gp
			end
			if sizes ~= nil then
				for i = 1, #sizes do
					if i == 1 and sizes[1] > size then
						size = sizes[1]
						break
					elseif sizes[i] == size then
						break
					elseif sizes[i] > size then
						size = sizes[i - 1]
						break
					elseif sizes[i + 1] == nil then
						size = sizes[i]
					end
				end
				if weight ~= nil then
					weight = BeltalowdaFonts.config.weights[weight]
					if weight ~= nil then
						fontString = string.format(BeltalowdaFonts.constants.COMPLEX_FONT, style, inputTypeString, size, weight)
					end
				else
					fontString = string.format(BeltalowdaFonts.constants.SIMPLE_FONT, style, inputTypeString, size)
				end
			end
		end
	end
	return fontString
end

