-- Beltalowda Group
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}

Beltalowda.group = Beltalowda.group or {}

local BeltalowdaGroup = Beltalowda.group
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaGroup.Initialize()
	BeltalowdaGroup.crown.Initialize()
	BeltalowdaGroup.ai.Initialize()
	BeltalowdaGroup.ftcv.Initialize()
	BeltalowdaGroup.ftcw.Initialize()
	BeltalowdaGroup.ftca.Initialize()
	BeltalowdaGroup.ftcb.Initialize()
	BeltalowdaGroup.dbo.Initialize()
	BeltalowdaGroup.rt.Initialize()
	BeltalowdaGroup.ro.Initialize()
	BeltalowdaGroup.hdm.Initialize()
	BeltalowdaGroup.po.Initialize()
	BeltalowdaGroup.dt.Initialize()
	BeltalowdaGroup.gb.Initialize()
	BeltalowdaGroup.isdp.Initialize()
	BeltalowdaGroup.mst.Initialize()
end

function BeltalowdaGroup.SlashCmd(param)
	if param ~= nil then
		if param[1] == "ai" then
			table.remove(param,1)
			BeltalowdaGroup.ai.SlashCmd(param)
		elseif param[1] == "hdm" then
			BeltalowdaGroup.hdm.SlashCmd(param)
		end
	end
end

function BeltalowdaGroup.GetDefaults()
	local defaults = {}
	defaults.crown = BeltalowdaGroup.crown.GetDefaults()
	defaults.ai = BeltalowdaGroup.ai.GetDefaults()
	defaults.ftcv = BeltalowdaGroup.ftcv.GetDefaults()
	defaults.ftcw = BeltalowdaGroup.ftcw.GetDefaults()
	defaults.ftca = BeltalowdaGroup.ftca.GetDefaults()
	defaults.ftcb = BeltalowdaGroup.ftcb.GetDefaults()
	defaults.dbo = BeltalowdaGroup.dbo.GetDefaults()
	defaults.rt = BeltalowdaGroup.rt.GetDefaults()
	defaults.ro = BeltalowdaGroup.ro.GetDefaults()
	defaults.hdm = BeltalowdaGroup.hdm.GetDefaults()
	defaults.po = BeltalowdaGroup.po.GetDefaults()
	defaults.dt = BeltalowdaGroup.dt.GetDefaults()
	defaults.gb = BeltalowdaGroup.gb.GetDefaults()
	defaults.isdp = BeltalowdaGroup.isdp.GetDefaults()
	defaults.mst = BeltalowdaGroup.mst.GetDefaults()
	return defaults
end

function BeltalowdaGroup.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.GROUP_HEADER,
			width = "full",
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.crown.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ai.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcv.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcw.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftca.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcb.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.dbo.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.hdm.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.po.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.dt.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.gb.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.isdp.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.mst.GetMenu())
	return menu
end