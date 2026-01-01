# ESO Addon Development Best Practices

A reference guide for creating addons for The Elder Scrolls Online.

---

## Namespace Initialization

### Overview
Lua doesn't have built-in namespaces, so ESO addons create them manually using tables. This prevents naming conflicts and organizes code across multiple files.

### The Standard Pattern

```lua
-- Create/ensure global namespace exists
RdKGTool.toolbox = RdKGTool.toolbox or {}

-- Create local alias for performance
local RdKGToolTB = RdKGTool.toolbox

-- Create nested namespace
RdKGTool.toolbox.so = RdKGTool.toolbox.so or {}
local RdKGToolSO = RdKGTool.toolbox.so
```

### Why Use This Pattern?

#### 1. Prevents Name Collisions
Without namespaces, multiple addons or files creating the same function/variable names would overwrite each other:

```lua
-- BAD: Global variables (any addon could overwrite this)
update = function() end
state = {}

-- GOOD: Namespaced (isolated from other addons)
MyAddon.update = function() end
MyAddon.state = {}
```

#### 2. Multi-File Safety with `or {}`
The `table = table or {}` pattern allows multiple files to safely initialize the same namespace:

```lua
-- File1.lua
RdKGTool.menu = RdKGTool.menu or {}  -- Creates new table
RdKGTool.menu.Initialize = function() end

-- File2.lua  
RdKGTool.menu = RdKGTool.menu or {}  -- Uses existing table (doesn't overwrite!)
RdKGTool.menu.OpenMenu = function() end
```

Without `or {}`, the second file would destroy everything the first file added.

#### 3. Organization
Hierarchical structure keeps related functionality together:

```lua
MyAddon.group = {}           -- Group management
MyAddon.group.ai = {}        -- Auto-invite
MyAddon.group.crown = {}     -- Crown features

MyAddon.toolbox = {}         -- Utility features  
MyAddon.toolbox.so = {}      -- Synergy overview
MyAddon.toolbox.respawner = {} -- Respawn tools

MyAddon.util = {}            -- Shared utilities
MyAddon.util.chatSystem = {} -- Chat functions
MyAddon.util.math = {}       -- Math helpers
```

#### 4. Performance with Local Aliases
Local variable lookups are faster than table traversals in Lua:

```lua
-- Slower: Table lookup every time
RdKGTool.toolbox.so.constants.SYNERGY_ID.BLOOD_ALTAR
RdKGTool.toolbox.so.constants.SYNERGY_ID.TRAPPING_WEBS

-- Faster: Local variable (single lookup)
local RdKGToolSO = RdKGTool.toolbox.so
RdKGToolSO.constants.SYNERGY_ID.BLOOD_ALTAR
RdKGToolSO.constants.SYNERGY_ID.TRAPPING_WEBS
```

### Common Namespace Structure

```lua
-- Main addon namespace
MyAddonName = MyAddonName or {}

-- Module namespaces
MyAddonName.core = MyAddonName.core or {}
MyAddonName.ui = MyAddonName.ui or {}
MyAddonName.data = MyAddonName.data or {}
MyAddonName.util = MyAddonName.util or {}

-- Local aliases for the file
local MyAddon = MyAddonName
local MyAddonCore = MyAddonName.core
```

### File Header Template

Every file in a multi-file addon should start with namespace initialization:

```lua
-- MyAddon Feature Module
-- Description of what this file does

-- Initialize required namespaces
MyAddon = MyAddon or {}
MyAddon.feature = MyAddon.feature or {}
MyAddon.util = MyAddon.util or {}

-- Create local aliases
local MyAddonFeature = MyAddon.feature
local MyAddonUtil = MyAddon.util

-- Now use the local aliases in your code
MyAddonFeature.Initialize = function()
    -- Implementation
end
```

### Best Practices

1. **Always use `or {}`** when creating namespace tables
2. **Create local aliases** at the top of each file for frequently accessed namespaces
3. **Use consistent naming** across your addon (e.g., always prefix with addon name)
4. **Document your namespace structure** so you know where to find things
5. **Initialize only what you need** in each file (don't copy/paste all namespaces everywhere)

---

## Additional Topics (To Be Added)

- Event handling and callbacks
- SavedVariables and settings management
- UI creation with XML vs. Lua
- Performance optimization
- Localization patterns
- Common ESO API patterns
- Debugging techniques
