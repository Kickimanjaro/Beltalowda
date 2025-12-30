-- Beltalowda AvA Messages
-- By @s0rdrak (PC / EU)

Beltalowda.toolbox = Beltalowda.toolbox or {}
local BeltalowdaTB = Beltalowda.toolbox
Beltalowda.toolbox.am = Beltalowda.toolbox.am or {}
local BeltalowdaAM = Beltalowda.toolbox.am
Beltalowda.menu = Beltalowda.menu or {}
local BeltalowdaMenu = Beltalowda.menu
Beltalowda.util = Beltalowda.util or {}
local BeltalowdaUtil = Beltalowda.util


BeltalowdaAM.callbackName = Beltalowda.addonName .. "ToolboxAvAMessages"

BeltalowdaAM.constants = {}
BeltalowdaAM.constants.events = {}
BeltalowdaAM.constants.events.CORONATE_EMPEROR = 1
BeltalowdaAM.constants.events.DEPOSE_EMPEROR = 2
BeltalowdaAM.constants.events.KEEP_GATE = 3
BeltalowdaAM.constants.events.ARTIFACT_CONTROL = 4
BeltalowdaAM.constants.events.REVENGE_KILL = 5
BeltalowdaAM.constants.events.AVENGE_KILL = 6
BeltalowdaAM.constants.events.QUEST_ADDED = 7
BeltalowdaAM.constants.events.QUEST_COMPLETE = 8
BeltalowdaAM.constants.events.QUEST_CONDITION_COUNTER_CHANGED = 9
BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED = 10
BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED = 11

BeltalowdaAM.state = {}
BeltalowdaAM.state.initialized = false
BeltalowdaAM.state.events = {}
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.CORONATE_EMPEROR] = EVENT_CORONATE_EMPEROR_NOTIFICATION
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.DEPOSE_EMPEROR] = EVENT_DEPOSE_EMPEROR_NOTIFICATION
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.KEEP_GATE] = EVENT_KEEP_GATE_STATE_CHANGED
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.ARTIFACT_CONTROL] = EVENT_ARTIFACT_CONTROL_STATE
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.REVENGE_KILL] = EVENT_REVENGE_KILL
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.AVENGE_KILL] = EVENT_AVENGE_KILL
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.QUEST_ADDED] = EVENT_QUEST_ADDED
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.QUEST_COMPLETE] = EVENT_QUEST_COMPLETE
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.QUEST_CONDITION_COUNTER_CHANGED] = EVENT_QUEST_CONDITION_COUNTER_CHANGED
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED] = EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED
BeltalowdaAM.state.events[BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED] = EVENT_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED

function BeltalowdaAM.Initialize()
	Beltalowda.profile.AddProfileChangeListener(BeltalowdaAM.callbackName, BeltalowdaAM.OnProfileChanged)

	BeltalowdaAM.HookMessages()
	
	BeltalowdaAM.state.initialized = true
end

function BeltalowdaAM.GetDefaults()
	local defaults = {}
	defaults.pvpOnly = true
	defaults.events = {}
	defaults.events[BeltalowdaAM.constants.events.CORONATE_EMPEROR] = true
	defaults.events[BeltalowdaAM.constants.events.DEPOSE_EMPEROR] = true
	defaults.events[BeltalowdaAM.constants.events.KEEP_GATE] = true
	defaults.events[BeltalowdaAM.constants.events.ARTIFACT_CONTROL] = true
	defaults.events[BeltalowdaAM.constants.events.REVENGE_KILL] = true
	defaults.events[BeltalowdaAM.constants.events.AVENGE_KILL] = true
	defaults.events[BeltalowdaAM.constants.events.QUEST_ADDED] = true
	defaults.events[BeltalowdaAM.constants.events.QUEST_COMPLETE] = true
	defaults.events[BeltalowdaAM.constants.events.QUEST_CONDITION_COUNTER_CHANGED] = true
	defaults.events[BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED] = true
	defaults.events[BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED] = true
	
	defaults.questProgress = true
	return defaults
end

function BeltalowdaAM.HookMessages()
	for i = 1, #BeltalowdaAM.state.events do
		BeltalowdaUtil.AddConditionalPreHook(BeltalowdaAM.callbackName .. BeltalowdaAM.state.events[i], ZO_CenterScreenAnnounce_GetEventHandlers(), BeltalowdaAM.state.events[i], function(...) return BeltalowdaAM.MessageHook(BeltalowdaAM.state.events[i], ...) end, nil)
	end
	
	BeltalowdaUtil.AddConditionalPreHook(BeltalowdaAM.callbackName .. ".AddMessageWithParamsHook", CENTER_SCREEN_ANNOUNCE, "AddMessageWithParams", BeltalowdaAM.AddMessageWithParamsHook, nil)
	--for i = 125000, 140000 do
	--	if i ~= 131279 then
	--		BeltalowdaUtil.AddConditionalPreHook(BeltalowdaAM.callbackName .. i, ZO_CenterScreenAnnounce_GetEventHandlers(), i, function(...) return BeltalowdaAM.MessageHook(i, ...) end, nil)
	--	end
	--end
end

function BeltalowdaAM.MessageHook(event, ...)
	--d(event)
	if BeltalowdaAM.amVars.pvpOnly == false or (BeltalowdaAM.amVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		for i = 1, #BeltalowdaAM.state.events do
			if BeltalowdaAM.state.events[i] == event then
				--d(BeltalowdaAM.amVars.events[i])
				return BeltalowdaAM.amVars.events[i]
			end
		end
	end
	return true
end

function BeltalowdaAM.AddMessageWithParamsHook(object, message)
	--d(message)
	if BeltalowdaAM.amVars.pvpOnly == false or (BeltalowdaAM.amVars.pvpOnly == true and BeltalowdaUtil.IsInPvPArea() == true) then
		if message ~= nil and message.csaType == CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_PROGRESSION_CHANGED then
			return BeltalowdaAM.amVars.questProgress
		end
	end
	return true
end

--callbacks
function BeltalowdaAM.OnProfileChanged(currentProfile)
	if currentProfile ~= nil then
		BeltalowdaAM.amVars = currentProfile.toolbox.am
		if BeltalowdaAM.state.initialized == true then
			
		end
	end
end

--menu interaction
function BeltalowdaAM.GetMenu()
	local menu = {
		[1] = {
			type = "submenu",
			name = BeltalowdaMenu.constants.AM_HEADER,
			controls = {
				[1] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_PVP_ONLY,
					getFunc = BeltalowdaAM.GetAmPvpOnly,
					setFunc = BeltalowdaAM.SetAmPvpOnly
				},
				[2] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_CORONATE_EMPEROR,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.CORONATE_EMPEROR) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.CORONATE_EMPEROR, value) end
				},
				[3] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_DEPOSE_EMPEROR,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.DEPOSE_EMPEROR) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.DEPOSE_EMPEROR, value) end
				},
				[4] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_KEEP_GATE,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.KEEP_GATE) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.KEEP_GATE, value) end
				},
				[5] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_ARTIFACT_CONTROL,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.ARTIFACT_CONTROL) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.ARTIFACT_CONTROL, value) end
				},
				[6] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_REVENGE_KILL,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.REVENGE_KILL) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.REVENGE_KILL, value) end
				},
				[7] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_AVENGE_KILL,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.AVENGE_KILL) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.AVENGE_KILL, value) end
				},
				[8] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_QUEST_ADDED,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_ADDED) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_ADDED, value) end
				},
				[9] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_QUEST_COMPLETE,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_COMPLETE) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_COMPLETE, value) end
				},
				[10] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_QUEST_CONDITION_COUNTER_CHANGED,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_CONDITION_COUNTER_CHANGED) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.QUEST_CONDITION_COUNTER_CHANGED, value) end
				},
				[11] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_QUEST_CONDITION_CHANGED,
					getFunc = BeltalowdaAM.GetAmQuestConditionChanged,
					setFunc = BeltalowdaAM.SetAmQuestConditionChanged
				},
				[12] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_SPAWNED_BUT_NOT_REVEALED, value) end
				},
				[13] = {
					type = "checkbox",
					name = BeltalowdaMenu.constants.AM_DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED,
					getFunc = function() return BeltalowdaAM.GetAmVarEnabled(BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED) end,
					setFunc = function(value) BeltalowdaAM.SetAmVarEnabled(BeltalowdaAM.constants.events.DAEDRIC_ARTIFACT_OBJECTIVE_STATE_CHANGED, value) end
				},
			}
		}
	}
	return menu
end

function BeltalowdaAM.GetAmPvpOnly()
	return BeltalowdaAM.amVars.pvpOnly
end

function BeltalowdaAM.SetAmPvpOnly(value)
	BeltalowdaAM.amVars.pvpOnly = value
end

function BeltalowdaAM.GetAmVarEnabled(index)
	return BeltalowdaAM.amVars.events[index]
end

function BeltalowdaAM.SetAmVarEnabled(index, value)
	BeltalowdaAM.amVars.events[index] = value
end

function BeltalowdaAM.GetAmQuestConditionChanged()
	return BeltalowdaAM.amVars.questProgress
end

function BeltalowdaAM.SetAmQuestConditionChanged(value)
	BeltalowdaAM.amVars.questProgress = value
end