---@meta Abevol-InGameLogger
local public = {}

-- document whatever you made publicly available to other plugins here
-- use luaCATS annotations and give descriptions where appropriate

---@class InGameLoggerArgs
---@field public Name string
---@field public ShowLogger boolean
---@field public ToggleKeyBind string
---@field public NoTitleBar boolean
---@field public MaxLines number
---@field public XPos number
---@field public YPos number
---@field public Width number
---@field public Height number
---@field public DisplayDuration number

---@class InGameLoggerLine
---@field public Text string
---@field public Timestamp number

---@class InGameLogger
---@field public Args InGameLoggerArgs
---@field public Lines table<integer,InGameLoggerLine>
public.InGameLogger = {
    Args = ...,
    Lines = {}
}

---@param args InGameLoggerArgs
---@return InGameLogger InGameLogger
public.InGameLogger.New = function (args) end

public.InGameLogger.Clear = function () end

---@param fmt string
---@param ... string
public.InGameLogger.Add = function (fmt, ...) end

---@param fmt string
---@param ... string
public.InGameLogger.Waring = function (fmt, ...) end

---@param fmt string
---@param ... string
public.InGameLogger.Error = function (fmt, ...) end

---@param fmt string
---@param ... string
public.InGameLogger.Info = function (fmt, ...) end

---@param fmt string
---@param ... string
public.InGameLogger.Debug = function (fmt, ...) end

---@param color number
---@param fmt string
---@param ... string
public.InGameLogger.AddColored = function (color, fmt, ...) end

public.InGameLogger.Init = function () end

return public