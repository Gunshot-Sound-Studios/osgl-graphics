local imageEditor = script.Parent
local types = require(imageEditor.types)

local OSGLTypes = require(script.Parent.OSGL).types

local ToolHandler = {}
ToolHandler.__index = ToolHandler

type ToolHandler = types.ToolHandler & {
    lastEquippedTool: types.BaseTool?,
    tools: types.Tools,
    window: OSGLTypes.Window,
}

function ToolHandler.new(tools: types.Tools, window: OSGLTypes.Window): types.ToolHandler
    local self = setmetatable({
        lastEquippedTool = nil,
        tools = tools,
        _connections = {},
    }, ToolHandler)

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
