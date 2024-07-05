# Mod name

A in-game log viewer that lets you view your log content more quickly.

## Usage

```lua
---@module 'Abevol-InGameLogger'
InGameLogger = mods["Abevol-InGameLogger"]

local function on_ready()
    logger = InGameLogger.New({Name = _ENV._PLUGIN.guid})
    logger:Add("Add")
    logger:AddColored(0xF42069FF, "AddColored")
    logger:Waring("Waring")
    logger:Error("Error")
    logger:Info("Info")
    logger:Debug("Debug")
end
```

## Configuration

```lua
local DefaultInGameLoggerArgs = {
    Name = _ENV._PLUGIN.guid,
    ShowLogger = true,
    ToggleKeyBind = "Ctrl L",
    MaxLines = 8,
    DisplayDuration = -1,
    NoTitleBar = true,
    WindowBgAlpha = 0.3,
    XPos = 1412,
    YPos = 882,
    Width = 382,
    Height = 192,
}
```
