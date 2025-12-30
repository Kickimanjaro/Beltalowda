-- Beltalowda Util
-- By @s0rdrak (PC / EU)

Beltalowda = Beltalowda or {}
Beltalowda.util = Beltalowda.util or {}

local BeltalowdaUtil = Beltalowda.util
BeltalowdaUtil.roster = BeltalowdaUtil.roster or {}
local BeltalowdaRoster = BeltalowdaUtil.roster
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu

BeltalowdaUtil.callbackReportName = Beltalowda.addonName .. "Report"

BeltalowdaUtil.state = {}
BeltalowdaUtil.state.parameterPreHooks = {}
BeltalowdaUtil.state.parameterPostHooks = {}
BeltalowdaUtil.state.preHooks = {}
BeltalowdaUtil.state.postHooks = {}
BeltalowdaUtil.state.conditionalPreHooks = {}

--functions
--General
function BeltalowdaUtil.Initialize()
	BeltalowdaUtil.chatSystem.Initialize()
	BeltalowdaUtil.roster.Initialize()
	BeltalowdaUtil.group.Initialize()
	BeltalowdaUtil.groupMenu.Initialize()
	BeltalowdaUtil.sound.Initialize()
	BeltalowdaUtil.ultimates.Initialize()
	BeltalowdaUtil.networking.Initialize()
	BeltalowdaUtil.versioning.Initialize()
	BeltalowdaUtil.sb.Initialize()
	BeltalowdaUtil.allianceColor.Initialize()
	BeltalowdaUtil.cyrodiil.Initialize()
	BeltalowdaUtil.moving3DObjects.Initialize()
end

function BeltalowdaUtil.GetMenu()
	local menu = {
		[1] = {
			type = "header",
			name = BeltalowdaMenu.constants.UTIL_HEADER,
			width = "full",
		}
	}
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaUtil.networking.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaUtil.group.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaUtil.allianceColor.GetMenu())
	BeltalowdaMenu.AddMenuEntries(menu, BeltalowdaUtil.chatSystem.GetMenu())
	return menu
end

function BeltalowdaUtil.GetDefaults()
	local defaults = {}
		defaults.chatSystem = BeltalowdaUtil.chatSystem.GetDefaults()
		defaults.networking = BeltalowdaUtil.networking.GetDefaults()
		defaults.group = BeltalowdaUtil.group.GetDefaults()
		defaults.groupMenu = BeltalowdaUtil.groupMenu.GetDefaults()
		defaults.allianceColor = BeltalowdaUtil.allianceColor.GetDefaults()
		defaults.moving3DObjects = BeltalowdaUtil.moving3DObjects.GetDefaults()
	return defaults
end

--callbacks
function BeltalowdaUtil.ReportFailed(eventCode, reason)
	if eventCode == EVENT_MAIL_SEND_FAILED then
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaUtil.callbackReportName, EVENT_MAIL_SEND_FAILED)
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaUtil.callbackReportName, EVENT_MAIL_SEND_SUCCESS)
		Beltalowda.vars.acc.reported = false
	end
end

function BeltalowdaUtil.ReportSuccess()
	if eventCode == EVENT_MAIL_SEND_SUCCESS then
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaUtil.callbackReportName, EVENT_MAIL_SEND_FAILED)
		EVENT_MANAGER:UnregisterForEvent(BeltalowdaUtil.callbackReportName, EVENT_MAIL_SEND_SUCCESS)
		Beltalowda.vars.acc.reported = true
	end
end

--Util
function BeltalowdaUtil.DeepCopy(target, source)
	if source ~= nil and target ~= nil and type(source) == "table" then
		for key, value in pairs(source) do
			if type(source[key]) == "table" then
				if target[key] == nil or type(target[key]) ~= "table" then
					target[key] = {}
				end
				BeltalowdaUtil.DeepCopy(target[key], source[key])
			else 
				target[key] = source[key]
			end
		end
	end
end

function BeltalowdaUtil.ColorRgbToParams(color)
	return color.r, color.g, color.b
end

function BeltalowdaUtil.ColorRgbaToParams(color)
	return color.r, color.g, color.b, color.a
end

function BeltalowdaUtil.HookTableContainsEntry(hookName, hookTable)
	local containsName = false
	if hookName ~= nil and hookTable ~= nil then
		for i = 1, #hookTable do
			if hookTable[i].hookName == hookName then
				containsName = true
				break
			end
		end
	end
	return containsName
end

function BeltalowdaUtil.RemoveHook(hookName, hookTable)
	if hookName ~= nil and hookTable ~= nil then
		for i = 1, #hookTable do
			if hookTable[i].hookName == hookName then
				if hookTable[i].object == nil then
					_G[hookTable[i].fn] = hookTable[i].origFn
				else
					hookTable[i].object[hookTable[i].fn] = hookTable[i].origFn
				end
				table.remove(hookTable, i)
				break
			end
		end
	end
end

function BeltalowdaUtil.PreHook(hookName, object, fn, callback)
	if BeltalowdaUtil.HookTableContainsEntry(hookName, BeltalowdaUtil.state.preHooks) == false then
		local entry = {}
		entry.hookName = hookName
		entry.fn = fn
		entry.object = object
		entry.callback = callback
		if object == nil then
			entry.origFn = _G[fn]
		else
			entry.origFn = object[fn]
		end
		local hook = function(...)
			callback(...)
			return entry.origFn(...)
		end
		if object == nil then
			_G[fn] = hook
		else
			object[fn] = hook
		end
		table.insert(BeltalowdaUtil.state.preHooks, entry)
	end
end

function BeltalowdaUtil.RemovePreHook(hookName)
	if hookName ~= nil then
		BeltalowdaUtil.RemoveHook(hookName, BeltalowdaUtil.state.preHooks)
	end
end

function BeltalowdaUtil.PostHook(hookName, object, fn, callback)
	if BeltalowdaUtil.HookTableContainsEntry(hookName, BeltalowdaUtil.state.postHooks) == false then
		local entry = {}
		entry.hookName = hookName
		entry.fn = fn
		entry.object = object
		entry.callback = callback
		if object == nil then
			entry.origFn = _G[fn]
		else
			entry.origFn = object[fn]
		end
		local hook = function(...)
			entry.origFn(...)
			return callback(...)
		end
		if object == nil then
			_G[fn] = hook
		else
			object[fn] = hook
		end
		table.insert(BeltalowdaUtil.state.postHooks, entry)
	end
end

function BeltalowdaUtil.RemovePostHook(hookName)
	if hookName ~= nil then
		BeltalowdaUtil.RemoveHook(hookName, BeltalowdaUtil.state.postHooks)
	end
end

function BeltalowdaUtil.AddConditionalPreHook(hookName, object, fn, callback, defaultValues)
	if BeltalowdaUtil.HookTableContainsEntry(hookName, BeltalowdaUtil.state.conditionalPreHooks) == false then
		local entry = {}
		entry.hookName = hookName
		entry.fn = fn
		entry.object = object
		entry.callback = callback
		if object == nil then
			entry.origFn = _G[fn]
		else
			entry.origFn = object[fn]
		end
		local hook = function(...)
			local executeOriginalFunction = callback(...)
			if executeOriginalFunction == true then
				return entry.origFn(...)
			else
				if defaultValues ~= nil and type(defaultValues) == "table" then
					return unpack(defaultValues)
				elseif defaultValues ~= nil then
					return defaultValues
				else
					return nil
				end
			end
		end
		if object == nil then
			_G[fn] = hook
		else
			object[fn] = hook
		end
		table.insert(BeltalowdaUtil.state.conditionalPreHooks, entry)
	end
end

function BeltalowdaUtil.RemoveConditionalPreHook(hookName)
	if hookName ~= nil then
		BeltalowdaUtil.RemoveHook(hookName, BeltalowdaUtil.state.conditionalPreHooks)
	end
end

function BeltalowdaUtil.ParameterPreHook(hookName, object, fn, callback)
	if BeltalowdaUtil.HookTableContainsEntry(hookName, BeltalowdaUtil.state.parameterPreHooks) == false then
		local entry = {}
		entry.hookName = hookName
		entry.fn = fn
		entry.object = object
		entry.callback = callback
		if object == nil then
			entry.origFn = _G[fn]
		else
			entry.origFn = object[fn]
		end
		local hook = function(...)
			return entry.origFn(callback(...))
		end
		if object == nil then
			_G[fn] = hook
		else
			object[fn] = hook
		end
		table.insert(BeltalowdaUtil.state.parameterPreHooks, entry)
	end
end

function BeltalowdaUtil.RemoveParameterPreHook(hookName)
	if hookName ~= nil then
		BeltalowdaUtil.RemoveHook(hookName, BeltalowdaUtil.state.parameterPreHooks)
	end
end

function BeltalowdaUtil.ParameterPostHook(hookName, object, fn, callback)	
	if BeltalowdaUtil.HookTableContainsEntry(hookName, BeltalowdaUtil.state.parameterPostHooks) == false then
		local entry = {}
		entry.hookName = hookName
		entry.fn = fn
		entry.object = object
		entry.callback = callback
		if object == nil then
			entry.origFn = _G[fn]
		else
			entry.origFn = object[fn]
		end
		local hook = function(...)
			return callback(entry.origFn(...))
		end
		if object == nil then
			_G[fn] = hook
		else
			object[fn] = hook
		end
		table.insert(BeltalowdaUtil.state.parameterPostHooks, entry)
	end
end

function BeltalowdaUtil.RemoveParameterPostHook(hookName)
	if hookName ~= nil then
		BeltalowdaUtil.RemoveHook(hookName, BeltalowdaUtil.state.parameterPostHooks)
	end
end

--Player, Character, Group
function BeltalowdaUtil.IsInPvPArea()
	if IsPlayerInAvAWorld() == true then
		return true
	end
	if IsInAvAZone() == true then
		return true
	end	
	if IsInImperialCity() == true then
		return true
	end
	if IsInCyrodiil() == true then
		return true
	end
	if IsActiveWorldBattleground() == true then
		return true
	end
	return false
end

function BeltalowdaUtil.IsInCyrodiil()
	if IsInCyrodiil() == true then
		return true
	elseif IsInCyrodiil() == false and IsPlayerInAvAWorld() == true and IsInAvAZone() == true and IsInImperialCity() == false and IsActiveWorldBattleground() == false then
		return true
	else
		return false
	end
end

function BeltalowdaUtil.GetUnitTagFromGroupMemberName(name)
	local size = GetGroupSize()
	for i = 1, size do
		local tag = GetGroupUnitTagByIndex(i)
        if GetUnitName(tag) == name then
            return tag
        end
	end
	return nil
end


--UI

