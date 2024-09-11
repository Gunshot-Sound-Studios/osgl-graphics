local OSGL = require(script.Parent.Parent.OSGL)
local OSGLTypes = OSGL.types

local imageEditor = script.Parent.Parent
local types = require(imageEditor.types)

local BaseTool = {}
BaseTool.__index = BaseTool

type BaseTool = types.BaseTool

function BaseTool.new()
    local self = setmetatable({
        _connections = {},
    }, BaseTool)

    return self
end

function BaseTool.Equip(self: BaseTool, window: OSGLTypes.Window)

end
function BaseTool.UnEquip(self: BaseTool, window: OSGLTypes.Window)

end
function BaseTool.HandleInput(self: BaseTool, input: InputObject, window: OSGLTypes.Window)

end

function BaseTool.Clean(self: BaseTool)
    for _, connection in ipairs(self._connections) do
        connection:Disconnect()
    end

    table.clear(self._connections)
end
function BaseTool.Destroy(self: BaseTool)
    self:Clean()
    table.clear(self)
end

return BaseTool
