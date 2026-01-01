-- LibAsync - Minimal Stub Implementation
-- NOTE: This is a placeholder stub. For production use, download the full LibAsync library
-- from https://www.esoui.com/ or https://github.com/sirinsidiator/LibAsync
-- Version: 2.8 (stub)

if LibAsync then
    return -- Library already loaded
end

LibAsync = {}
local lib = LibAsync

lib.VERSION = 2.8

-- Minimal stub implementation for basic functionality
function lib:Create(name)
    return {
        Call = function(self, func) if func then func() end return self end,
        Then = function(self, func) if func then func() end return self end,
        Finalize = function(self) end,
    }
end

-- Export global reference
LibStub:NewLibrary("LibAsync", lib.VERSION)
