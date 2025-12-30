-- Beltalowda Toolbox
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox

Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu


function BeltalowdaTB.Initialize()
	BeltalowdaTB.sm.Initialize()
	BeltalowdaTB.recharger.Initialize()
	BeltalowdaTB.kc.Initialize()
	BeltalowdaTB.bft.Initialize()
	BeltalowdaTB.siege.Initialize()
	BeltalowdaTB.cl.Initialize()
	BeltalowdaTB.cs.Initialize()
	BeltalowdaTB.enhancements.Initialize()
	BeltalowdaTB.respawner.Initialize()
	BeltalowdaTB.camp.Initialize()
	BeltalowdaTB.ra.Initialize()
	BeltalowdaTB.sp.Initialize()
	BeltalowdaTB.so.Initialize()
	BeltalowdaTB.caj.Initialize()
	BeltalowdaTB.am.Initialize()
end

function BeltalowdaTB.SlashCmd(param)
	if param ~= nil then

	end
end

function BeltalowdaTB.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.TOOLBOX_HEADER,
			width = "full",
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.sm.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.recharger.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.kc.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.bft.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.siege.GetMenu()) --There is no menu
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.cl.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.cs.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.enhancements.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.respawner.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.camp.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.ra.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.sp.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.so.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.caj.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaTB.am.GetMenu())
	return menu
end

function BeltalowdaTB.GetDefaults()
	local defaults = {}
	defaults.sm = BeltalowdaTB.sm.GetDefaults()
	defaults.recharger = BeltalowdaTB.recharger.GetDefaults()
	defaults.kc = BeltalowdaTB.kc.GetDefaults()
	defaults.bft = BeltalowdaTB.bft.GetDefaults()
	defaults.siege = BeltalowdaTB.siege.GetDefaults()
	defaults.cl = BeltalowdaTB.cl.GetDefaults()
	defaults.cs = BeltalowdaTB.cs.GetDefaults()
	defaults.enhancements = BeltalowdaTB.enhancements.GetDefaults()
	defaults.respawner = BeltalowdaTB.respawner.GetDefaults()
	defaults.camp = BeltalowdaTB.camp.GetDefaults()
	defaults.ra = BeltalowdaTB.ra.GetDefaults()
	defaults.sp = BeltalowdaTB.sp.GetDefaults()
	defaults.so = BeltalowdaTB.so.GetDefaults()
	defaults.caj = BeltalowdaTB.caj.GetDefaults()
	defaults.am = BeltalowdaTB.am.GetDefaults()
	return defaults
end