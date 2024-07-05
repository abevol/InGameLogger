local InGameLogger = {}
InGameLogger.__index = InGameLogger

local DefaultInGameLoggerArgs = {
    Name = _ENV._PLUGIN.guid,
    ShowLogger = true,
    ToggleKeyBind = "",
    MaxLines = 8,
    DisplayDuration = -1,
    NoTitleBar = true,
    WindowBgAlpha = 0.3,
    XPos = 1412,
    YPos = 882,
    Width = 382,
    Height = 192,
}

local function CombineDefaultInGameLoggerArgs(args)
    if not args then return DefaultInGameLoggerArgs end
    local loggerArgs = DefaultInGameLoggerArgs
    for key, value in pairs(args) do
        loggerArgs[key] = value
    end
    return loggerArgs
end

function InGameLogger.New(args)
    local self = setmetatable({}, InGameLogger)
    self.Args = CombineDefaultInGameLoggerArgs(args)
    self.Lines = {}

    self:Init()
    return self
end

function InGameLogger:Clear()
    self.Lines = {}
end

function InGameLogger:AddColored(color, fmt, ...)
    local text = string.format(fmt, ...)
    for line in string.gmatch(text, "[^\r\n]+") do
        local item = {
            Text = line,
            Timestamp = os.time(),
            Color = color
        }

        if #self.Lines >= self.Args.MaxLines then
            table.remove(self.Lines, 1)
        end
        table.insert(self.Lines, item)
    end
end

function InGameLogger:Add(fmt, ...)
    self:AddColored(nil, fmt, ...)
end

function InGameLogger:Waring(fmt, ...)
    self:AddColored(0xFF20EEEE, fmt, ...)
end

function InGameLogger:Error(fmt, ...)
    self:AddColored(0xFF2020EE, fmt, ...)
end

function InGameLogger:Info(fmt, ...)
    self:AddColored(0xFFEEEEEE, fmt, ...)
end

function InGameLogger:Debug(fmt, ...)
    self:AddColored(0x20FF20EE, fmt, ...)
end

function InGameLogger:Draw()
    if not self.Args.ShowLogger or (not rom.gui.is_open() and #self.Lines == 0) then return end

    local flags = self.Args.NoTitleBar and ImGuiWindowFlags.NoTitleBar or ImGuiWindowFlags.None
    if not rom.gui.is_open() then
        ImGui.SetNextWindowBgAlpha(self.Args.WindowBgAlpha)
    end

    ImGui.SetNextWindowPos(self.Args.XPos, self.Args.YPos, rom.ImGuiCond.FirstUseEver)
    ImGui.SetNextWindowSize(self.Args.Width, self.Args.Height, rom.ImGuiCond.FirstUseEver)
    if not rom.ImGui.Begin(self.Args.Name, flags) then
        rom.ImGui.End()
        return
    end

    flags = ImGuiWindowFlags.NoBackground
    ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 0, 0)

    if ImGui.BeginChild("scrolling", 0, 0, true, flags) then
        ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 0)
        local newArr = {}
        for _, line in ipairs(self.Lines) do
            if self.Args.DisplayDuration < 0 or os.time() - line.Timestamp <= self.Args.DisplayDuration then
                if line.Color then ImGui.PushStyleColor(rom.ImGuiCol.Text, line.Color) end
                ImGui.TextUnformatted(line.Text)
                if line.Color then ImGui.PopStyleColor() end
                table.insert(newArr, line)
            end
        end
        self.Lines = newArr
        ImGui.PopStyleVar(ImGuiStyleVar.ItemSpacing)
    end
    ImGui.PopStyleVar(ImGuiStyleVar.WindowPadding)

    ImGui.EndChild()
    ImGui.End()
end

function InGameLogger:Init()
    rom.gui.add_always_draw_imgui(function() self:Draw() end)
    rom.inputs.on_key_pressed({self.Args.ToggleKeyBind, Name = "Toggle Logger Visibility: " .. self.Args.Name, function()
        self.Args.ShowLogger = not self.Args.ShowLogger
    end})
end

public.New = InGameLogger.New
