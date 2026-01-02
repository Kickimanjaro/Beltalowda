-- Beltalowda Logger Wrapper
-- LibDebugLogger integration with graceful fallback to d()

Beltalowda = Beltalowda or {}
Beltalowda.Logger = Beltalowda.Logger or {}

local Logger = Beltalowda.Logger

-- Debug levels (ordered by verbosity)
Logger.Levels = {
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    VERBOSE = 5,
}

-- Level names for display
Logger.LevelNames = {
    [1] = "ERROR",
    [2] = "WARN",
    [3] = "INFO",
    [4] = "DEBUG",
    [5] = "VERBOSE",
}

-- Module configuration
Logger.moduleLoggers = {}
Logger.moduleConfig = {
    Network = { level = Logger.Levels.ERROR },
    Ultimates = { level = Logger.Levels.ERROR },
    Equipment = { level = Logger.Levels.ERROR },
    General = { level = Logger.Levels.ERROR },
}

-- Session log storage (in-memory)
Logger.sessionLog = {}
Logger.maxLogEntries = 200

-- LibDebugLogger instance
Logger.libDebugLogger = nil
Logger.hasLibDebugLogger = false

-- VERBOSE mode state tracking
Logger.verboseModeActive = false
Logger.verboseModeResetOnReload = true

--[[
    Initialize the Logger system
    Should be called early in addon initialization
]]--
function Logger.Initialize()
    -- Check if LibDebugLogger is available
    if LibDebugLogger then
        Logger.hasLibDebugLogger = true
        Logger.libDebugLogger = LibDebugLogger
        d("[Beltalowda] LibDebugLogger found - advanced logging enabled")
    else
        Logger.hasLibDebugLogger = false
        d("[Beltalowda] LibDebugLogger not found - using fallback logging to chat")
    end
    
    -- Load saved configuration from SavedVariables
    Logger.LoadConfiguration()
    
    return true
end

--[[
    Load configuration from SavedVariables
]]--
function Logger.LoadConfiguration()
    if not BeltalowdaVars then return end
    
    -- Initialize logging config if not exists
    BeltalowdaVars.logging = BeltalowdaVars.logging or {}
    
    -- Load module-specific levels
    if BeltalowdaVars.logging.moduleLevels then
        for module, level in pairs(BeltalowdaVars.logging.moduleLevels) do
            if Logger.moduleConfig[module] then
                Logger.moduleConfig[module].level = level
            end
        end
    end
    
    -- Load max log entries
    if BeltalowdaVars.logging.maxLogEntries then
        Logger.maxLogEntries = BeltalowdaVars.logging.maxLogEntries
    end
    
    -- Load VERBOSE reset preference
    if BeltalowdaVars.logging.verboseReset ~= nil then
        Logger.verboseModeResetOnReload = BeltalowdaVars.logging.verboseReset
    end
    
    -- Reset VERBOSE mode if configured to do so
    if Logger.verboseModeResetOnReload then
        -- Check if any module is set to VERBOSE and reset it
        for module, config in pairs(Logger.moduleConfig) do
            if config.level == Logger.Levels.VERBOSE then
                -- Reset to saved level or ERROR
                local savedLevel = Logger.Levels.ERROR
                if BeltalowdaVars.logging.moduleLevels and BeltalowdaVars.logging.moduleLevels[module] then
                    savedLevel = BeltalowdaVars.logging.moduleLevels[module]
                end
                -- Only reset if saved level is not VERBOSE
                if savedLevel ~= Logger.Levels.VERBOSE then
                    config.level = savedLevel
                end
            end
        end
    end
end

--[[
    Save configuration to SavedVariables
]]--
function Logger.SaveConfiguration()
    if not BeltalowdaVars then return end
    
    BeltalowdaVars.logging = BeltalowdaVars.logging or {}
    
    -- Save module-specific levels
    BeltalowdaVars.logging.moduleLevels = {}
    for module, config in pairs(Logger.moduleConfig) do
        BeltalowdaVars.logging.moduleLevels[module] = config.level
    end
    
    -- Save max log entries
    BeltalowdaVars.logging.maxLogEntries = Logger.maxLogEntries
    
    -- Save VERBOSE reset preference
    BeltalowdaVars.logging.verboseReset = Logger.verboseModeResetOnReload
end

--[[
    Create a module-specific logger instance
    @param moduleName: Name of the module (e.g., "Network", "Ultimates")
    @return: Logger instance with level-specific methods
]]--
function Logger.CreateModuleLogger(moduleName)
    -- Ensure module config exists
    if not Logger.moduleConfig[moduleName] then
        Logger.moduleConfig[moduleName] = { level = Logger.Levels.ERROR }
    end
    
    local moduleLogger = {
        moduleName = moduleName,
    }
    
    -- Define logging methods for each level
    function moduleLogger:Error(message, ...)
        Logger.Log(Logger.Levels.ERROR, self.moduleName, message, ...)
    end
    
    function moduleLogger:Warn(message, ...)
        Logger.Log(Logger.Levels.WARN, self.moduleName, message, ...)
    end
    
    function moduleLogger:Info(message, ...)
        Logger.Log(Logger.Levels.INFO, self.moduleName, message, ...)
    end
    
    function moduleLogger:Debug(message, ...)
        Logger.Log(Logger.Levels.DEBUG, self.moduleName, message, ...)
    end
    
    function moduleLogger:Verbose(message, ...)
        Logger.Log(Logger.Levels.VERBOSE, self.moduleName, message, ...)
    end
    
    -- Store the logger instance
    Logger.moduleLoggers[moduleName] = moduleLogger
    
    return moduleLogger
end

--[[
    Core logging function
    @param level: Log level (Logger.Levels.*)
    @param moduleName: Module name
    @param message: Message string
    @param ...: Additional arguments to format
]]--
function Logger.Log(level, moduleName, message, ...)
    -- Get current module level
    local moduleConfig = Logger.moduleConfig[moduleName]
    if not moduleConfig then
        moduleConfig = { level = Logger.Levels.ERROR }
    end
    
    -- Check if this message should be logged
    if level > moduleConfig.level then
        return
    end
    
    -- Format the message
    local formattedMessage = Logger.FormatMessage(level, moduleName, message, ...)
    
    -- Add to session log
    Logger.AddToSessionLog(level, moduleName, formattedMessage)
    
    -- Output to appropriate destination
    if Logger.hasLibDebugLogger then
        Logger.LogToLibDebugLogger(level, moduleName, formattedMessage)
    else
        Logger.LogToChat(level, moduleName, formattedMessage)
    end
end

--[[
    Format a log message
    @param level: Log level
    @param moduleName: Module name
    @param message: Message string
    @param ...: Additional arguments
    @return: Formatted message string
]]--
function Logger.FormatMessage(level, moduleName, message, ...)
    local levelName = Logger.LevelNames[level] or "UNKNOWN"
    local args = {...}
    
    -- Format additional arguments if provided
    local formattedArgs = ""
    if #args > 0 then
        local argStrings = {}
        for i, arg in ipairs(args) do
            table.insert(argStrings, tostring(arg))
        end
        formattedArgs = " " .. table.concat(argStrings, ", ")
    end
    
    return string.format("[%s][%s] %s%s", moduleName, levelName, message, formattedArgs)
end

--[[
    Add entry to session log with rotation
    @param level: Log level
    @param moduleName: Module name
    @param message: Formatted message
]]--
function Logger.AddToSessionLog(level, moduleName, message)
    local entry = {
        timestamp = os.time(),
        level = level,
        module = moduleName,
        message = message,
    }
    
    table.insert(Logger.sessionLog, entry)
    
    -- Rotate log if it exceeds max entries
    while #Logger.sessionLog > Logger.maxLogEntries do
        table.remove(Logger.sessionLog, 1)
    end
end

--[[
    Log to LibDebugLogger
    @param level: Log level
    @param moduleName: Module name
    @param message: Formatted message
]]--
function Logger.LogToLibDebugLogger(level, moduleName, message)
    if not Logger.libDebugLogger then return end
    
    -- LibDebugLogger has different level methods
    -- Map our levels to LibDebugLogger levels
    if level == Logger.Levels.ERROR then
        Logger.libDebugLogger:Error("Beltalowda", message)
    elseif level == Logger.Levels.WARN then
        Logger.libDebugLogger:Warn("Beltalowda", message)
    elseif level == Logger.Levels.INFO then
        Logger.libDebugLogger:Info("Beltalowda", message)
    elseif level == Logger.Levels.DEBUG then
        Logger.libDebugLogger:Debug("Beltalowda", message)
    elseif level == Logger.Levels.VERBOSE then
        Logger.libDebugLogger:Verbose("Beltalowda", message)
    end
end

--[[
    Log to chat using d()
    @param level: Log level
    @param moduleName: Module name
    @param message: Formatted message
]]--
function Logger.LogToChat(level, moduleName, message)
    -- Only output ERROR and WARN to chat in fallback mode to avoid spam
    if level <= Logger.Levels.WARN then
        d("[Beltalowda] " .. message)
    end
end

--[[
    Set debug level for a module
    @param moduleName: Module name or "all" for all modules
    @param level: Log level (Logger.Levels.*)
]]--
function Logger.SetModuleLevel(moduleName, level)
    if moduleName == "all" then
        for module, config in pairs(Logger.moduleConfig) do
            config.level = level
        end
    else
        if Logger.moduleConfig[moduleName] then
            Logger.moduleConfig[moduleName].level = level
        else
            -- Create config for unknown module
            Logger.moduleConfig[moduleName] = { level = level }
        end
    end
    
    -- Mark VERBOSE mode as active if any module is set to VERBOSE
    Logger.verboseModeActive = false
    for _, config in pairs(Logger.moduleConfig) do
        if config.level == Logger.Levels.VERBOSE then
            Logger.verboseModeActive = true
            break
        end
    end
    
    -- Save configuration
    Logger.SaveConfiguration()
end

--[[
    Get debug level for a module
    @param moduleName: Module name
    @return: Log level (Logger.Levels.*)
]]--
function Logger.GetModuleLevel(moduleName)
    local config = Logger.moduleConfig[moduleName]
    if config then
        return config.level
    end
    return Logger.Levels.ERROR
end

--[[
    Get session log entries
    @param moduleName: Optional module filter (nil for all)
    @param count: Optional max number of entries to return (nil for all)
    @return: Array of log entries
]]--
function Logger.GetSessionLog(moduleName, count)
    local filtered = {}
    
    -- Filter by module if specified
    for i = #Logger.sessionLog, 1, -1 do
        local entry = Logger.sessionLog[i]
        if not moduleName or entry.module == moduleName then
            table.insert(filtered, entry)
            if count and #filtered >= count then
                break
            end
        end
    end
    
    return filtered
end

--[[
    Clear session log
]]--
function Logger.ClearSessionLog()
    Logger.sessionLog = {}
end

--[[
    Get formatted timestamp
    @param timestamp: OS time
    @return: Formatted time string
]]--
function Logger.FormatTimestamp(timestamp)
    return os.date("%H:%M:%S", timestamp)
end

--[[
    Parse level name to level value
    @param levelName: Level name string (e.g., "ERROR", "DEBUG")
    @return: Level value or nil
]]--
function Logger.ParseLevel(levelName)
    local upperName = string.upper(levelName)
    for level, name in pairs(Logger.LevelNames) do
        if name == upperName then
            return level
        end
    end
    return nil
end

return Logger
