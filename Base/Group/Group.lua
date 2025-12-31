-- Beltalowda Group
-- By @s0rdrak (PC / EU)
-- Modified by @Kickimanjaro for Beltalowda

Beltalowda = Beltalowda or {}

Beltalowda.group = Beltalowda.group or {}

local BeltalowdaGroup = Beltalowda.group
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaGroup.Initialize()
	BeltalowdaGroup.crown.Initialize() -- Crown display and highlighting
	BeltalowdaGroup.ai.Initialize() -- Auto Invite system
	BeltalowdaGroup.ftcv.Initialize() -- Follow The Crown Visual (beams, arrows, etc)
	BeltalowdaGroup.ftcw.Initialize() -- Follow The Crown Warnings (alerts and notifications)
	BeltalowdaGroup.ftca.Initialize() -- Follow The Crown Audio (sound alerts)
	BeltalowdaGroup.ftcb.Initialize() -- Follow The Crown Beam (directional beam to leader)
	BeltalowdaGroup.dbo.Initialize() -- Debuff Overview (group debuff tracking)
	BeltalowdaGroup.rt.Initialize() -- Rapid Tracker (ultimate cooldown tracking)
	BeltalowdaGroup.ro.Initialize() -- Resource Overview (health, stamina, magicka tracking)
	BeltalowdaGroup.hdm.Initialize() -- HP/Damage Meter (health and damage information)
	BeltalowdaGroup.po.Initialize() -- Potion Overview (buff duration tracking)
	BeltalowdaGroup.dt.Initialize() -- Detonation Tracker (explosive tracking)
	BeltalowdaGroup.gb.Initialize() -- Group Beams (visual beams connecting group members)
	BeltalowdaGroup.isdp.Initialize() -- I See Dead People (fallen member highlighting)
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
	defaults.crown = BeltalowdaGroup.crown.GetDefaults() -- Crown display and highlighting
	defaults.ai = BeltalowdaGroup.ai.GetDefaults() -- Auto Invite system
	defaults.ftcv = BeltalowdaGroup.ftcv.GetDefaults() -- Follow The Crown Visual (beams, arrows, etc)
	defaults.ftcw = BeltalowdaGroup.ftcw.GetDefaults() -- Follow The Crown Warnings (alerts and notifications)
	defaults.ftca = BeltalowdaGroup.ftca.GetDefaults() -- Follow The Crown Audio (sound alerts)
	defaults.ftcb = BeltalowdaGroup.ftcb.GetDefaults() -- Follow The Crown Beam (directional beam to leader)
	defaults.dbo = BeltalowdaGroup.dbo.GetDefaults() -- Debuff Overview (group debuff tracking)
	defaults.rt = BeltalowdaGroup.rt.GetDefaults() -- Rapid Tracker (ultimate cooldown tracking)
	defaults.ro = BeltalowdaGroup.ro.GetDefaults() -- Resource Overview (health, stamina, magicka tracking)
	defaults.hdm = BeltalowdaGroup.hdm.GetDefaults() -- HP/Damage Meter (health and damage information)
	defaults.po = BeltalowdaGroup.po.GetDefaults() -- Potion Overview (buff duration tracking)
	defaults.dt = BeltalowdaGroup.dt.GetDefaults() -- Detonation Tracker (explosive tracking)
	defaults.gb = BeltalowdaGroup.gb.GetDefaults() -- Group Beams (visual beams connecting group members)
	defaults.isdp = BeltalowdaGroup.isdp.GetDefaults() -- I See Dead People (fallen member highlighting)
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
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.crown.GetMenu()) -- Crown display and highlighting
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ai.GetMenu()) -- Auto Invite system
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcv.GetMenu()) -- Follow The Crown Visual (beams, arrows, etc)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcw.GetMenu()) -- Follow The Crown Warnings (alerts and notifications)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftca.GetMenu()) -- Follow The Crown Audio (sound alerts)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.ftcb.GetMenu()) -- Follow The Crown Beam (directional beam to leader)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.dbo.GetMenu()) -- Debuff Overview (group debuff tracking)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.hdm.GetMenu()) -- HP/Damage Meter (health and damage information)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.po.GetMenu()) -- Potion Overview (buff duration tracking)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.dt.GetMenu()) -- Detonation Tracker (explosive tracking)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.gb.GetMenu()) -- Group Beams (visual beams connecting group members)
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaGroup.isdp.GetMenu()) -- I See Dead People (fallen member highlighting)
	return menu
end