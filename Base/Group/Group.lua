-- Beltalowda Group
-- By @s0rdrak (PC / EU)
-- Modified by @Kickimanjaro for Beltalowda

Beltalowda = Beltalowda or {}

Beltalowda.group = Beltalowda.group or {}

local BeltalowdaGroup = Beltalowda.group
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaGroup.Initialize()
	-- DIAGNOSTIC: Systematically disable migrated features to isolate crash
	d("[Beltalowda] Group Initialize START")
	
	BeltalowdaGroup.crown.Initialize() -- Crown display and highlighting
	d("[Beltalowda] - Crown initialized")
	
	BeltalowdaGroup.ai.Initialize() -- Auto Invite system
	d("[Beltalowda] - AutoInvite initialized")
	
	BeltalowdaGroup.ftcv.Initialize() -- Follow The Crown Visual (beams, arrows, etc)
	d("[Beltalowda] - FTC Visual initialized")
	
	BeltalowdaGroup.ftcw.Initialize() -- Follow The Crown Warnings (alerts and notifications)
	d("[Beltalowda] - FTC Warnings initialized")
	
	BeltalowdaGroup.ftca.Initialize() -- Follow The Crown Audio (sound alerts)
	d("[Beltalowda] - FTC Audio initialized")
	
	BeltalowdaGroup.ftcb.Initialize() -- Follow The Crown Beam (directional beam to leader)
	d("[Beltalowda] - FTC Beam initialized")
	
	BeltalowdaGroup.dbo.Initialize() -- Debuff Overview (group debuff tracking)
	d("[Beltalowda] - Debuff Overview initialized")
	
	-- MIGRATED FEATURE #1: Positioning (Rapid Tracker) - DISABLED FOR TESTING
	-- BeltalowdaGroup.rt.Initialize() -- Rapid Tracker (ultimate cooldown tracking)
	d("[Beltalowda] - Rapid Tracker (Positioning) DISABLED")
	
	-- MIGRATED FEATURE #2: Ultimates (Resource Overview) - DISABLED FOR TESTING  
	-- BeltalowdaGroup.ro.Initialize() -- Resource Overview (health, stamina, magicka tracking)
	d("[Beltalowda] - Resource Overview (Ultimates) DISABLED")
	
	BeltalowdaGroup.hdm.Initialize() -- HP/Damage Meter (health and damage information)
	d("[Beltalowda] - HP/Damage Meter initialized")
	
	BeltalowdaGroup.po.Initialize() -- Potion Overview (buff duration tracking)
	d("[Beltalowda] - Potion Overview initialized")
	
	-- MIGRATED FEATURE #3: AttackTimers (Detonation Tracker) - DISABLED FOR TESTING
	-- BeltalowdaGroup.dt.Initialize() -- Detonation Tracker (explosive tracking)
	d("[Beltalowda] - Detonation Tracker (AttackTimers) DISABLED")
	
	BeltalowdaGroup.gb.Initialize() -- Group Beams (visual beams connecting group members)
	d("[Beltalowda] - Group Beams initialized")
	
	BeltalowdaGroup.isdp.Initialize() -- I See Dead People (fallen member highlighting)
	d("[Beltalowda] - I See Dead People initialized")
	
	d("[Beltalowda] Group Initialize COMPLETE")
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