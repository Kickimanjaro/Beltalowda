-- Beltalowda Settings Menu
-- LibAddonMenu-2.0 integration for addon configuration

Beltalowda = Beltalowda or {}
Beltalowda.Settings = Beltalowda.Settings or {}

local Settings = Beltalowda.Settings

-- Default settings
Settings.defaults = {
    logging = {
        enabled = true,
        defaultLevel = 1,  -- ERROR
        moduleLevels = {
            Network = 1,    -- ERROR
            Ultimates = 1,  -- ERROR
            Equipment = 1,  -- ERROR
            General = 1,    -- ERROR
        },
        maxLogEntries = 200,
        verboseReset = true,
    }
}

--[[
    Initialize settings panel
    Should be called after addon is loaded
]]--
function Settings.Initialize()
    -- Don't initialize if LibAddonMenu isn't available
    if not LibAddonMenu2 then
        d("[Beltalowda] LibAddonMenu2 not found - settings menu disabled")
        return false
    end
    
    -- Ensure defaults are set
    Settings.ApplyDefaults()
    
    -- Create the settings panel
    Settings.CreatePanel()
    
    return true
end

--[[
    Apply default settings if they don't exist
]]--
function Settings.ApplyDefaults()
    if not BeltalowdaVars then return end
    
    -- Initialize logging settings if not present
    if not BeltalowdaVars.logging then
        BeltalowdaVars.logging = {}
    end
    
    -- Apply defaults for missing values
    if BeltalowdaVars.logging.enabled == nil then
        BeltalowdaVars.logging.enabled = Settings.defaults.logging.enabled
    end
    
    if not BeltalowdaVars.logging.defaultLevel then
        BeltalowdaVars.logging.defaultLevel = Settings.defaults.logging.defaultLevel
    end
    
    if not BeltalowdaVars.logging.moduleLevels then
        BeltalowdaVars.logging.moduleLevels = {}
        for module, level in pairs(Settings.defaults.logging.moduleLevels) do
            BeltalowdaVars.logging.moduleLevels[module] = level
        end
    end
    
    if not BeltalowdaVars.logging.maxLogEntries then
        BeltalowdaVars.logging.maxLogEntries = Settings.defaults.logging.maxLogEntries
    end
    
    if BeltalowdaVars.logging.verboseReset == nil then
        BeltalowdaVars.logging.verboseReset = Settings.defaults.logging.verboseReset
    end
end

--[[
    Create the LibAddonMenu settings panel
]]--
function Settings.CreatePanel()
    local LAM = LibAddonMenu2
    
    -- Create the panel
    local panelData = {
        type = "panel",
        name = "Beltalowda",
        displayName = "Beltalowda",
        author = "Kickimanjaro",
        version = Beltalowda.version or "0.2.1",
        slashCommand = "/btlwsettings",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    
    LAM:RegisterAddonPanel("BeltalowdaSettings", panelData)
    
    -- Create the options
    local optionsData = {
        -- Header: Debugging & Diagnostics
        {
            type = "header",
            name = "Debugging & Diagnostics",
            width = "full",
        },
        {
            type = "description",
            text = "Configure debug logging to troubleshoot issues. See docs/DEBUGGING_GUIDE.md for detailed information.",
            width = "full",
        },
        
        -- Master enable/disable toggle
        {
            type = "checkbox",
            name = "Enable Debug Logging",
            tooltip = "Master switch for debug logging. When disabled, only critical errors are logged.",
            getFunc = function() 
                return BeltalowdaVars.logging.enabled 
            end,
            setFunc = function(value)
                BeltalowdaVars.logging.enabled = value
                -- Update logger if available
                if value and Beltalowda.Logger then
                    d("[Beltalowda] Debug logging enabled")
                end
            end,
            width = "full",
            default = Settings.defaults.logging.enabled,
        },
        
        -- Default debug level
        {
            type = "dropdown",
            name = "Default Debug Level",
            tooltip = "Default log level for all modules. Lower levels show fewer messages.",
            choices = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"},
            getFunc = function()
                local level = BeltalowdaVars.logging.defaultLevel or 1
                local levelNames = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"}
                return levelNames[level]
            end,
            setFunc = function(value)
                local levelMap = {ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, VERBOSE = 5}
                BeltalowdaVars.logging.defaultLevel = levelMap[value]
                
                -- Apply to logger if available
                if Beltalowda.Logger then
                    for module, _ in pairs(Beltalowda.Logger.moduleConfig) do
                        BeltalowdaVars.logging.moduleLevels[module] = levelMap[value]
                        Beltalowda.Logger.SetModuleLevel(module, levelMap[value])
                    end
                end
            end,
            width = "full",
            default = "ERROR",
        },
        
        -- Module-specific levels submenu
        {
            type = "submenu",
            name = "Module-Specific Levels",
            tooltip = "Configure debug levels for individual modules",
            controls = {
                {
                    type = "description",
                    text = "Set log levels for each module independently. Module settings override the default level.",
                },
                
                -- Network module
                {
                    type = "dropdown",
                    name = "Network Module",
                    tooltip = "Debug level for network communication and data synchronization",
                    choices = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"},
                    getFunc = function()
                        local level = BeltalowdaVars.logging.moduleLevels.Network or 1
                        local levelNames = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"}
                        return levelNames[level]
                    end,
                    setFunc = function(value)
                        local levelMap = {ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, VERBOSE = 5}
                        BeltalowdaVars.logging.moduleLevels.Network = levelMap[value]
                        if Beltalowda.Logger then
                            Beltalowda.Logger.SetModuleLevel("Network", levelMap[value])
                        end
                    end,
                    width = "full",
                    default = "ERROR",
                },
                
                -- Ultimates module
                {
                    type = "dropdown",
                    name = "Ultimate Tracking",
                    tooltip = "Debug level for ultimate tracking and display",
                    choices = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"},
                    getFunc = function()
                        local level = BeltalowdaVars.logging.moduleLevels.Ultimates or 1
                        local levelNames = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"}
                        return levelNames[level]
                    end,
                    setFunc = function(value)
                        local levelMap = {ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, VERBOSE = 5}
                        BeltalowdaVars.logging.moduleLevels.Ultimates = levelMap[value]
                        if Beltalowda.Logger then
                            Beltalowda.Logger.SetModuleLevel("Ultimates", levelMap[value])
                        end
                    end,
                    width = "full",
                    default = "ERROR",
                },
                
                -- Equipment module
                {
                    type = "dropdown",
                    name = "Equipment Tracking",
                    tooltip = "Debug level for equipment and set detection",
                    choices = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"},
                    getFunc = function()
                        local level = BeltalowdaVars.logging.moduleLevels.Equipment or 1
                        local levelNames = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"}
                        return levelNames[level]
                    end,
                    setFunc = function(value)
                        local levelMap = {ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, VERBOSE = 5}
                        BeltalowdaVars.logging.moduleLevels.Equipment = levelMap[value]
                        if Beltalowda.Logger then
                            Beltalowda.Logger.SetModuleLevel("Equipment", levelMap[value])
                        end
                    end,
                    width = "full",
                    default = "ERROR",
                },
                
                -- General module
                {
                    type = "dropdown",
                    name = "General / Core",
                    tooltip = "Debug level for general addon functionality",
                    choices = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"},
                    getFunc = function()
                        local level = BeltalowdaVars.logging.moduleLevels.General or 1
                        local levelNames = {"ERROR", "WARN", "INFO", "DEBUG", "VERBOSE"}
                        return levelNames[level]
                    end,
                    setFunc = function(value)
                        local levelMap = {ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, VERBOSE = 5}
                        BeltalowdaVars.logging.moduleLevels.General = levelMap[value]
                        if Beltalowda.Logger then
                            Beltalowda.Logger.SetModuleLevel("General", levelMap[value])
                        end
                    end,
                    width = "full",
                    default = "ERROR",
                },
            },
        },
        
        -- Advanced settings
        {
            type = "header",
            name = "Advanced Logging Settings",
            width = "full",
        },
        
        -- Max log entries slider
        {
            type = "slider",
            name = "Max Log Entries",
            tooltip = "Maximum number of log entries to keep in memory before rotation. Higher values use more memory.",
            min = 50,
            max = 500,
            step = 50,
            getFunc = function()
                return BeltalowdaVars.logging.maxLogEntries or 200
            end,
            setFunc = function(value)
                BeltalowdaVars.logging.maxLogEntries = value
                if Beltalowda.Logger then
                    Beltalowda.Logger.maxLogEntries = value
                end
            end,
            width = "full",
            default = 200,
        },
        
        -- VERBOSE reset checkbox
        {
            type = "checkbox",
            name = "Reset VERBOSE on Reload",
            tooltip = "When enabled, VERBOSE debug level automatically resets to configured level after /reloadui. Prevents chat spam after debugging sessions.",
            getFunc = function()
                return BeltalowdaVars.logging.verboseReset
            end,
            setFunc = function(value)
                BeltalowdaVars.logging.verboseReset = value
                if Beltalowda.Logger then
                    Beltalowda.Logger.verboseModeResetOnReload = value
                end
            end,
            width = "full",
            default = Settings.defaults.logging.verboseReset,
        },
        
        -- Help text
        {
            type = "description",
            text = "For more information on debugging, see docs/DEBUGGING_GUIDE.md or use /btlwdata help",
            width = "full",
        },
        
        -- Button to open documentation
        {
            type = "button",
            name = "Show Debug Commands",
            tooltip = "Display available debug slash commands in chat",
            func = function()
                d("=== Beltalowda Debug Commands ===")
                d("/btlwdata help - Show all available commands")
                d("/btlwdata debug <module> <level> - Set debug level")
                d("/btlwdata log show [module] - View recent logs")
                d("/btlwdata log levels - Show current levels")
                d("")
                d("See docs/DEBUGGING_GUIDE.md for detailed information")
            end,
            width = "full",
        },
    }
    
    LAM:RegisterOptionControls("BeltalowdaSettings", optionsData)
    
    d("[Beltalowda] Settings menu initialized. Use /btlwsettings to configure.")
end

return Settings
