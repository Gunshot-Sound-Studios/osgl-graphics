local UserInputService = game:GetService("UserInputService")
local imageEditor = script.Parent
local types = require(imageEditor.types)

local OSGLTypes = require(script.Parent.OSGL).types

local ToolHandler = {}
ToolHandler.__index = ToolHandler

type ToolsUi = GuiObject

type ToolHandler = types.ToolHandler & {
    window: OSGLTypes.Window,
    lastEquippedTool: types.BaseTool?,
    tools: types.Tools<number>,
    toolsUi: ToolsUi,
}

function ToolHandler.new(
    tools: types.Tools<string>,
    window: OSGLTypes.Window,
    toolsUi: ToolsUi
): types.ToolHandler
    local self = setmetatable({
        window = window,
        lastEquippedTool = nil :: types.BaseTool?,
        tools = {},
        toolsUi = toolsUi,
        _connections = {},
    }, ToolHandler) :: ToolHandler

    table.insert(
        self._connections,
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            --FIXME: Should I care about `gameProcessedEvent`?
            if self.lastEquippedTool then
                self.lastEquippedTool:HandleInput(input, self.window)
            end
        end)
    )
    table.insert(
        self._connections,
        UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
            --FIXME: Should I care about `gameProcessedEvent`?
            if self.lastEquippedTool then
                self.lastEquippedTool:HandleInput(input, self.window)
            end
        end)
    )
    for i, toolFrame: ImageButton in toolsUi:GetChildren() do
        if not toolFrame:IsA("GuiObject") then
            continue
        end

        self.tools[i] = tools[toolFrame.Name]
        table.insert(self._connections, toolFrame.MouseButton1Click:Connect(function()
            self:EquipTool(i)
        end))
    end

    return self
end

function ToolHandler.EquipTool(self: ToolHandler, index: number)
    local tool = self.tools[index]
    if not tool then
        warn("Attempt to equip non-existent tool.")
    end

    if self.lastEquippedTool then
        self.lastEquippedTool:UnEquip(self.window)
    end

    tool:Equip(self.window)
    self.lastEquippedTool = tool
end

function ToolHandler.UnEquipTool(self: ToolHandler, index: number)
    local tool = self.tools[index]
    if not tool then
        warn("Attempt to unequip non-existent tool.")
    end

    tool:UnEquip(self.window)
    self.lastEquippedTool = nil
end

function ToolHandler.Clean(self: ToolHandler)
    for _, connection in ipairs(self._connections) do
        connection:Disconnect()
    end

    table.clear(self._connections)
end
function ToolHandler.Destroy(self: ToolHandler)
    self:Clean()
    table.clear(self)
end

return ToolHandler
