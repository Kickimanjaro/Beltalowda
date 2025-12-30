-- Beltalowda Profile
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.profile = Beltalowda.profile or {}
local BeltalowdaProfile = Beltalowda.profile
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.chatSystem = BeltalowdaUtil.chatSystem or {}
local BeltalowdaChat = BeltalowdaUtil.chatSystem

BeltalowdaProfile.profileChangeListeners = {}

BeltalowdaProfile.constants = BeltalowdaProfile.constants or {}
BeltalowdaProfile.constants.DEFAULT_PROFILE = "Default"
BeltalowdaProfile.constants.PREFIX = "Profile"
BeltalowdaProfile.constants.references = BeltalowdaProfile.constants.references or {}
BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION = "Beltalowda.menu.ProfileErrorMessageDescription"
BeltalowdaProfile.constants.references.PROFILE_SELECTED_PROFILE_DROPDOWN = "Beltalowda.menu.ProfileSelectedProfileDropdown"

BeltalowdaProfile.state = BeltalowdaProfile.state or {}
BeltalowdaProfile.state.newProfileName = ""

--initialization
function BeltalowdaProfile.Initialize(accountVars, charVars)
	BeltalowdaProfile.savedVars = {}
	BeltalowdaProfile.savedVars.acc = accountVars
	BeltalowdaProfile.savedVars.char = charVars
	--BeltalowdaProfile.savedVars.char.test = "test"
end

function BeltalowdaProfile.GetAccountDefaults()
	local defaults = {}
	defaults.profiles = {}
	defaults.profiles[1] = {}
	defaults.profiles[1].name = BeltalowdaProfile.constants.DEFAULT_PROFILE
	return defaults
end

function BeltalowdaProfile.GetCharacterDefaults()
	local defaults = {}
	defaults.selectedProfile = BeltalowdaProfile.constants.DEFAULT_PROFILE
	return defaults
end



--util
function BeltalowdaProfile.GetCharacterVars()
	return BeltalowdaProfile.savedVars.char
end

function BeltalowdaProfile.GetSelectedProfile()
	local currentProfile = nil
	for i = 1, #BeltalowdaProfile.savedVars.acc.profiles do
		if BeltalowdaProfile.savedVars.acc.profiles[i].name == BeltalowdaProfile.savedVars.char.selectedProfile then
			currentProfile = BeltalowdaProfile.savedVars.acc.profiles[i]
			break
		end
	end
	if currentProfile == nil then
		currentProfile = BeltalowdaProfile.savedVars.acc.profiles[1]
		BeltalowdaProfile.savedVars.char.selectedProfile = currentProfile.name
		
	end
	return currentProfile
end

function BeltalowdaProfile.ProfileExists(value)
	local profileExists = false
	for i = 1, #BeltalowdaProfile.savedVars.acc.profiles do
		if BeltalowdaProfile.savedVars.acc.profiles[i].name == value then
			profileExists = true
			break
		end
	end
	return profileExists
end

function BeltalowdaProfile.GetAllAccProfiles()
	return BeltalowdaProfile.savedVars.acc.profiles
end

function BeltalowdaProfile.GetSpecificAccProfile(name)
	local profile = nil
	for i = 1, #BeltalowdaProfile.savedVars.acc.profiles do
		if BeltalowdaProfile.savedVars.acc.profiles[i].name == name then
			profile = BeltalowdaProfile.savedVars.acc.profiles[i]
			break
		end
	end
	return profile
end

function BeltalowdaProfile.AddNewProfileData(profile)
	if profile ~= nil then
		profile.name = zo_strtrim(profile.name)
		if BeltalowdaProfile.ProfileExists(profile.name) == false then
			table.insert(BeltalowdaProfile.savedVars.acc.profiles, profile)
			BeltalowdaProfile.UpdateProfileSection()
		end
	end
end

--profile change listener code
function BeltalowdaProfile.AddProfileChangeListener(moduleName, callback, update)
	if BeltalowdaProfile.ProfileChangeListenerExists(moduleName) == false then
		local newModule = {}
		newModule.moduleName = moduleName
		newModule.callback = callback
		table.insert(BeltalowdaProfile.profileChangeListeners, newModule)
		if (update == true or update == nil) and type(callback) == "function" then
			callback(BeltalowdaProfile.GetSelectedProfile())
		end
	else
		BeltalowdaChat.SendChatMessage("Listener already exists: " .. moduleName, BeltalowdaProfile.constants.PREFIX, BeltalowdaChat.constants.messageTypes.MESSAGE_DEBUG)
	end
end

function BeltalowdaProfile.RemoveProfileChangeListener(moduleName)
	for i = 1, #BeltalowdaProfile.profileChangeListeners do
		if BeltalowdaProfile.profileChangeListeners[i].moduleName == moduleName then
			table.remove(BeltalowdaProfile.profileChangeListeners, i)
			i = i - 1 
		end
	end
end

function BeltalowdaProfile.ProfileChangeListenerExists(moduleName)
	local retVal = false
	for i = 1, #BeltalowdaProfile.profileChangeListeners do
		if BeltalowdaProfile.profileChangeListeners[i].moduleName == moduleName then
			retVal = true
			break
		end
	end
	return retVal
end

function BeltalowdaProfile.NotifyChangeListeners(moduleName)
	local currentProfile = BeltalowdaProfile.GetSelectedProfile()
	if moduleName == nil then
		for i = 1, #BeltalowdaProfile.profileChangeListeners do
			if type(BeltalowdaProfile.profileChangeListeners[i].callback) == "function" then
				BeltalowdaProfile.profileChangeListeners[i].callback(currentProfile)
			end
		end
	else
		for i = 1, #BeltalowdaProfile.profileChangeListeners do
			if BeltalowdaProfile.profileChangeListeners[i].name == moduleName and type(BeltalowdaProfile.profileChangeListeners[i].callback) == "function" then
				BeltalowdaProfile.profileChangeListeners[i].callback(currentProfile)
				break
			end
		end
	end
end

--Menu Interaction
function BeltalowdaProfile.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.PROFILE_HEADER,
			width = "full",
		},
		[2] = {
			type = "dropdown",
			name = BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE,
			tooltip = BeltalowdaMenu.constants.PROFILE_SELECTED_PROFILE_TOOLTIP,
			choices = BeltalowdaProfile.GetAvailableProfiles(),
			getFunc = BeltalowdaProfile.GetSelectedProfileName,
			setFunc = BeltalowdaProfile.SetSelectedProfileName,
			width = "full",
			--requiresReload = true,
			reference = BeltalowdaProfile.constants.references.PROFILE_SELECTED_PROFILE_DROPDOWN
		},
		[3] = {
			type = "button",
			name = BeltalowdaMenu.constants.PROFILE_REMOVE_PROFILE,
			func = BeltalowdaProfile.RemoveSelectedProfile,
			width = "full"
		},
		[4] = {
			type = "editbox",
			name = BeltalowdaMenu.constants.PROFILE_NEW_PROFILE,
			getFunc = BeltalowdaProfile.GetNewProfileName,
			setFunc = BeltalowdaProfile.SetNewProfileName,
			isMultiline = false,
			width = "full",
			default = ""
		},
		[5] = {
			type = "button",
			name = BeltalowdaMenu.constants.PROFILE_ADD_PROFILE,
			func = BeltalowdaProfile.AddNewProfile,
			width = "full"
		},
		[6] = {
			type = "button",
			name = BeltalowdaMenu.constants.PROFILE_CLONE_PROFILE,
			func = BeltalowdaProfile.CloneProfile,
			width = "full"
		},
		[7] = {
			type = "description",
			title = nil,
			text = "",
			width = "full",
			reference = BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION
		}
	}
	BeltalowdaProfile.state.dropDownMenuEntry = menu[2]
	return menu
end

function BeltalowdaProfile.GetAvailableProfiles()
	local profiles = {}
	local acc = BeltalowdaProfile.savedVars.acc.profiles
	for i = 1, #acc do
		profiles[i] = acc[i].name
	end
	return profiles
end

function BeltalowdaProfile.GetSelectedProfileName()
	return BeltalowdaProfile.savedVars.char.selectedProfile
end

function BeltalowdaProfile.SetSelectedProfileName(value)
	if BeltalowdaProfile.ProfileExists(value) == true then
		BeltalowdaProfile.savedVars.char.selectedProfile = value
		BeltalowdaProfile.NotifyChangeListeners()
	end
end

function BeltalowdaProfile.AddNewProfile()
	local value = BeltalowdaProfile.state.newProfileName
	--d(value)
	if BeltalowdaProfile.ProfileExists(value) == true then
		BeltalowdaMenu.SetErrorMessage(BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION, BeltalowdaMenu.constants.PROFILE_EXISTS)
		--d("error message set")
	else
		if value ~= nil and zo_strtrim(value) ~= "" then
			local newProfile = Beltalowda.CreateCleanProfile()
			newProfile.name = value
			table.insert(BeltalowdaProfile.savedVars.acc.profiles, newProfile)
		end
		BeltalowdaProfile.UpdateProfileSection()
	end
end

function BeltalowdaProfile.CloneProfile()
	local value = BeltalowdaProfile.state.newProfileName
	--d(value)
	if BeltalowdaProfile.ProfileExists(value) == true then
		BeltalowdaMenu.SetErrorMessage(BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION, BeltalowdaMenu.constants.PROFILE_EXISTS)
		--d("error message set")
	else
		local oldProfile = BeltalowdaProfile.GetSelectedProfile()
		if value ~= nil and zo_strtrim(value) ~= "" and oldProfile ~= nil then
			--local newProfile = Beltalowda.CreateCleanProfile()
			local newProfile = {}
			
			BeltalowdaUtil.DeepCopy(newProfile, oldProfile)
			newProfile.name = value
			table.insert(BeltalowdaProfile.savedVars.acc.profiles, newProfile)
		end
		BeltalowdaProfile.UpdateProfileSection()
	end
end

function BeltalowdaProfile.RemoveSelectedProfile()
	if BeltalowdaProfile.savedVars.char.selectedProfile == BeltalowdaProfile.constants.DEFAULT_PROFILE then
		BeltalowdaMenu.SetErrorMessage(BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION, BeltalowdaMenu.constants.PROFILE_CANT_REMOVE_DEFAULT)
		--d("error message set")
	else
		local index = 0
		for i = 1, #BeltalowdaProfile.savedVars.acc.profiles do
			if BeltalowdaProfile.savedVars.acc.profiles[i].name == BeltalowdaProfile.savedVars.char.selectedProfile then
				index = i
				break
			end
		end
		table.remove(BeltalowdaProfile.savedVars.acc.profiles, index)
		index = index - 1
		if index >= 1 then
			BeltalowdaProfile.savedVars.char.selectedProfile = BeltalowdaProfile.savedVars.acc.profiles[index].name
		else
			BeltalowdaProfile.savedVars.char.selectedProfile = BeltalowdaProfile.constants.DEFAULT_PROFILE
		end
		BeltalowdaProfile.NotifyChangeListeners()
		BeltalowdaProfile.UpdateProfileSection()
	end
end

function BeltalowdaProfile.UpdateProfileSection()
	--d("update profile section")
	BeltalowdaProfile.state.newProfileName = ""
	BeltalowdaMenu.SetErrorMessage(BeltalowdaProfile.constants.references.PROFILE_ERROR_MESSAGE_DESCRIPTION, "")
	local dropdownControl = GetWindowManager():GetControlByName(BeltalowdaProfile.constants.references.PROFILE_SELECTED_PROFILE_DROPDOWN)
	if dropdownControl ~= nil then
		dropdownControl:UpdateChoices(BeltalowdaProfile.GetAvailableProfiles())
	else
		BeltalowdaProfile.state.dropDownMenuEntry.choices = BeltalowdaProfile.GetAvailableProfiles()
	end
end


function BeltalowdaProfile.GetNewProfileName()
	return BeltalowdaProfile.state.newProfileName
end

function BeltalowdaProfile.SetNewProfileName(value)
	BeltalowdaProfile.state.newProfileName = value
end
