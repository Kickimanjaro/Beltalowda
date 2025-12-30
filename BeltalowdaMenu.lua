-- Beltalowda Addon Menu
-- Settings integration using LibAddonMenu-2.0
-- Based on RdK Group Tool by @s0rdrak (PC / EU)

local LAM = LibAddonMenu2

Beltalowda = Beltalowda or {}
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

-- Panel data for the addon settings
BeltalowdaMenu.panelData = {
	type = "panel",
	name = "|c4592FFBeltalowda|r",
	displayName = "|c4592FFBeltalowda Configuration|r",
	author = "|cFF8174@Kickimanjaro|r",
	version = "|cFF81740.1.1|r",
	registerForRefresh = true,
	registerForDefaults = false
}

function BeltalowdaMenu.Initialize()
	-- Create the options data
	local optionsData = BeltalowdaMenu.CreateOptionsData()
	
	-- Register the addon panel
	BeltalowdaMenu.panel = LAM:RegisterAddonPanel("BeltalowdaSettings", BeltalowdaMenu.panelData)
	
	-- Register the options
	LAM:RegisterOptionControls("BeltalowdaSettings", optionsData)
end

function BeltalowdaMenu.CreateOptionsData()
	local options = {}
	
	-- Ultimate Tracking Section
	table.insert(options, {
		type = "header",
		name = "Ultimate Tracking Display"
	})
	
	table.insert(options, {
		type = "checkbox",
		name = "Show Player Blocks",
		tooltip = "Display the main window showing all group members with color-coded ultimate bars",
		getFunc = function() 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				return Beltalowda.UI.UltimateDisplay.savedVars.showPlayerBlocks
			end
			return true
		end,
		setFunc = function(value) 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				Beltalowda.UI.UltimateDisplay.savedVars.showPlayerBlocks = value
				if value then
					Beltalowda.UI.UltimateDisplay.ShowPlayerBlocks()
				else
					Beltalowda.UI.UltimateDisplay.HidePlayerBlocks()
				end
			end
		end,
		default = true
	})
	
	table.insert(options, {
		type = "checkbox",
		name = "Show Client Ultimate",
		tooltip = "Display your own ultimate icon with color feedback",
		getFunc = function() 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				return Beltalowda.UI.UltimateDisplay.savedVars.showClientUltimate
			end
			return true
		end,
		setFunc = function(value) 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				Beltalowda.UI.UltimateDisplay.savedVars.showClientUltimate = value
				if value then
					Beltalowda.UI.UltimateDisplay.ShowClientUltimate()
				else
					Beltalowda.UI.UltimateDisplay.HideClientUltimate()
				end
			end
		end,
		default = true
	})
	
	table.insert(options, {
		type = "checkbox",
		name = "Show Group Ultimates",
		tooltip = "Display row of 12 trackable ultimate icons with counts",
		getFunc = function() 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				return Beltalowda.UI.UltimateDisplay.savedVars.showGroupUltimates
			end
			return true
		end,
		setFunc = function(value) 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				Beltalowda.UI.UltimateDisplay.savedVars.showGroupUltimates = value
				if value then
					Beltalowda.UI.UltimateDisplay.ShowGroupUltimates()
				else
					Beltalowda.UI.UltimateDisplay.HideGroupUltimates()
				end
			end
		end,
		default = true
	})
	
	table.insert(options, {
		type = "checkbox",
		name = "Show Ultimate Overview",
		tooltip = "Display compact window showing key ultimate counts",
		getFunc = function() 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				return Beltalowda.UI.UltimateDisplay.savedVars.showUltimateOverview
			end
			return false
		end,
		setFunc = function(value) 
			if Beltalowda.UI and Beltalowda.UI.UltimateDisplay then
				Beltalowda.UI.UltimateDisplay.savedVars.showUltimateOverview = value
				if value then
					Beltalowda.UI.UltimateDisplay.ShowUltimateOverview()
				else
					Beltalowda.UI.UltimateDisplay.HideUltimateOverview()
				end
			end
		end,
		default = false
	})
	
	table.insert(options, {
		type = "divider"
	})
	
	-- Broadcasting Section
	table.insert(options, {
		type = "header",
		name = "Networking"
	})
	
	table.insert(options, {
		type = "checkbox",
		name = "Enable Ultimate Broadcasting",
		tooltip = "Share your ultimate percentage with group members via party chat (filtered from visible chat)",
		getFunc = function() 
			if Beltalowda.util and Beltalowda.util.networking then
				return Beltalowda.util.networking.IsEnabled()
			end
			return true
		end,
		setFunc = function(value) 
			if Beltalowda.util and Beltalowda.util.networking then
				if value then
					Beltalowda.util.networking.EnableBroadcasting()
				else
					Beltalowda.util.networking.DisableBroadcasting()
				end
			end
		end,
		default = true
	})
	
	return options
end
