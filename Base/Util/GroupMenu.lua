-- Beltalowda Group Menu
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.groupMenu = BeltalowdaUtil.groupMenu or {}
local BeltalowdaGMenu = BeltalowdaUtil.groupMenu
BeltalowdaUtil.group = BeltalowdaUtil.group or {}
local BeltalowdaGroup = BeltalowdaUtil.group
Beltalowda.group = Beltalowda.group or {}
Beltalowda.group.gb = Beltalowda.group.gb or {}
local BeltalowdaGBeam = Beltalowda.group.gb
Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
BeltalowdaTB.ra = BeltalowdaTB.ra or {}
local BeltalowdaRa = BeltalowdaTB.ra

BeltalowdaGMenu.callbackName = Beltalowda.addonName .. "GroupMenu"

BeltalowdaGMenu.constants = BeltalowdaGMenu.constants or {}

BeltalowdaGMenu.config = {}

BeltalowdaGMenu.state = {}
BeltalowdaGMenu.state.initialized = false

function BeltalowdaGMenu.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaGMenu.callbackName, BeltalowdaGMenu.OnProfileChanged)
	BeltalowdaGMenu.state.initialized = true
	BeltalowdaGMenu.AdjustGroupMenu()
end

function BeltalowdaGMenu.GetDefaults()
	local defaults = {}
	
	return defaults
end

function BeltalowdaGMenu.BgAddCrown(charName, displayName)
	BeltalowdaGroup.SetBgCrown(charName, displayName)
	BeltalowdaGMenu.SetRole(charName, displayName, nil)
end

function BeltalowdaGMenu.BgRemoveCrown(charName, displayName)
	BeltalowdaGroup.RemoveBgCrown(charName, displayName)
end

function BeltalowdaGMenu.SetRole(charName, displayName, role)
	BeltalowdaGroup.SetRole(charName, displayName, role)
	if charName == GetUnitName("player") and displayName == GetUnitDisplayName("player") then
		BeltalowdaRa.SendRole()
	else
		BeltalowdaRa.SetPlayerRole(charName, displayName, role)
	end
end

function BeltalowdaGMenu.CreateRoleSubEntry(player, role, description)
	local entry = {}
	if player.role == role then
		entry.label = string.format("%s %s", BeltalowdaGMenu.constants.ROLE_SUBMENU_REMOVE, description)
		entry.callback = function() BeltalowdaGMenu.SetRole(player.charName, player.displayName, nil) end
	else
		entry.label = string.format("%s %s", BeltalowdaGMenu.constants.ROLE_SUBMENU_SET, description)
		entry.callback = function() BeltalowdaGMenu.SetRole(player.charName, player.displayName, role) end
	end
	return entry
end

function BeltalowdaGMenu.CreateRoleSubEntries(player)
	local entries = {}
	if player ~= nil then
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_RAPID, BeltalowdaGMenu.constants.ROLE_SUBMENU_RAPID))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_PURGE, BeltalowdaGMenu.constants.ROLE_SUBMENU_PURGE))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_HEAL, BeltalowdaGMenu.constants.ROLE_SUBMENU_HEAL))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_DD, BeltalowdaGMenu.constants.ROLE_SUBMENU_DD))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_SYNERGY, BeltalowdaGMenu.constants.ROLE_SUBMENU_SYNERGY))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_CC, BeltalowdaGMenu.constants.ROLE_SUBMENU_CC))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_SUPPORT, BeltalowdaGMenu.constants.ROLE_SUBMENU_SUPPORT))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_PLACEHOLDER, BeltalowdaGMenu.constants.ROLE_SUBMENU_PLACEHOLDER))
		table.insert(entries, BeltalowdaGMenu.CreateRoleSubEntry(player, BeltalowdaGroup.constants.roles.ROLE_APPLICANT, BeltalowdaGMenu.constants.ROLE_SUBMENU_APPLICANT))
	end
	return entries
end

function BeltalowdaGMenu.AdjustGroupMenu()
	local groupMenu = GROUP_LIST.GroupListRow_OnMouseUp
	GROUP_LIST.GroupListRow_OnMouseUp = function(selfControl, control, button, upInside)
		groupMenu(selfControl, control, button, upInside)
		if(button == MOUSE_BUTTON_INDEX_RIGHT and upInside) then
			local data = ZO_ScrollList_GetData(control)
			if data ~= nil then
				--[[
				data.isPlayer
				data.characterName
				data.displayName
				data.unitTag
				data.online]]
				if data.online == true then
					local players = BeltalowdaGroup.GetGroupInformation()
					if players ~= nil then
						for i = 1, #players do
							if players[i].unitTag == data.unitTag then
								if IsActiveWorldBattleground() then
									if players[i].isLeader == true then
										AddCustomMenuItem(BeltalowdaGMenu.constants.BG_LEADER_REMOVE_CROWN, function() BeltalowdaGMenu.BgRemoveCrown(players[i].charName, players[i].displayName) end )
									else
										AddCustomMenuItem(BeltalowdaGMenu.constants.BG_LEADER_ADD_CROWN, function() BeltalowdaGMenu.BgAddCrown(players[i].charName, players[i].displayName) end )
										--if players[i].isLeader == false then
											--if BeltalowdaGBeam.GetEnabled() == true then
												AddCustomSubMenuItem(BeltalowdaGMenu.constants.ROLE_MENU_ENTRY, BeltalowdaGMenu.CreateRoleSubEntries(players[i]))
											--end
										--end
									end
								else
									--if players[i].isLeader == false then
										--if BeltalowdaGBeam.GetEnabled() == true then
											AddCustomSubMenuItem(BeltalowdaGMenu.constants.ROLE_MENU_ENTRY, BeltalowdaGMenu.CreateRoleSubEntries(players[i]))
										--end
									--end
								end
							end
						end
					end
					if ZO_Menu_GetNumMenuItems() > 0 then 
						ShowMenu() 
					end
				end
			end
		end
	end
end

--callbacks
function BeltalowdaGMenu.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaGMenu.gmVars = currentProfile.util.groupMenu
	end
end