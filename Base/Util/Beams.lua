-- Beltalowda Util Beams
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.beams = BeltalowdaUtil.beams or {}
local BeltalowdaBeams = BeltalowdaUtil.beams

BeltalowdaBeams.constants = {}
BeltalowdaBeams.constants.beams = {}
BeltalowdaBeams.constants.beams.BEAM_1 = 1
BeltalowdaBeams.constants.beams.BEAM_2 = 2
BeltalowdaBeams.constants.beams.BEAM_3 = 3
BeltalowdaBeams.constants.beams.BEAM_4 = 4
BeltalowdaBeams.constants.beams.BEAM_5 = 5
BeltalowdaBeams.constants.beams.BEAM_6 = 6
BeltalowdaBeams.constants.beams.BEAM_7 = 7
BeltalowdaBeams.constants.beams.BEAM_8 = 8
BeltalowdaBeams.constants.beams.BEAM_9 = 9
BeltalowdaBeams.constants.beams.BEAM_10 = 10
BeltalowdaBeams.constants.BEAM = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].texture = "Beltalowda/Art/3DObjects/Beam1.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].height = 256
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_1].heightOffset = 0
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].texture = "Beltalowda/Art/3DObjects/Beam2.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].height = 256
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_2].heightOffset = 0
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].texture = "Beltalowda/Art/3DObjects/Beam3.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].height = 256
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_3].heightOffset = 0
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].texture = "Beltalowda/Art/3DObjects/Beam4.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].height = 256
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_4].heightOffset = 0
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].texture = "Beltalowda/Art/3DObjects/Circle1.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].ignoreSize = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].height = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_5].heightOffset = 4
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].texture = "Beltalowda/Art/3DObjects/Circle1.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].usesDepthBuffer = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].ignoreSize = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].height = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_6].heightOffset = 4
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].texture = "Beltalowda/Art/3DObjects/Circle2.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].ignoreSize = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].height = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_7].heightOffset = 4
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].texture = "Beltalowda/Art/3DObjects/Circle2.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].usesDepthBuffer = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].ignoreSize = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].height = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_8].heightOffset = 4
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].texture = "Beltalowda/Art/3DObjects/Arrows1.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].height = 128
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_9].heightOffset = -2
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10] = {}
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].texture = "Beltalowda/Art/3DObjects/Arrows2.dds"
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].usesDepthBuffer = true
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].ignoreSize = false
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].height = 128
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].width = 1
BeltalowdaBeams.constants.BEAM[BeltalowdaBeams.constants.beams.BEAM_10].heightOffset = -2

function BeltalowdaBeams.GetBeamByBeamId(beamId)
	return BeltalowdaBeams.constants.BEAM[beamId]
end

function BeltalowdaBeams.GetBeamIds()
	return BeltalowdaBeams.constants.beams
end

function BeltalowdaBeams.GetBeams()
	return BeltalowdaBeams.constants.BEAM
end

function BeltalowdaBeams.GetBeamNames()
	local beams = {}
	for i = 1, #BeltalowdaBeams.constants.BEAM do
		beams[i] = BeltalowdaBeams.constants.BEAM[i].name
	end
	return beams
end

function BeltalowdaBeams.GetBeamIdByName(name)
	local index = 0
	if name ~= nil then
		for i = 1, #BeltalowdaBeams.constants.BEAM do
			if BeltalowdaBeams.constants.BEAM[i].name == name then
				index = i
				break
			end
		end
	end
	return index
end