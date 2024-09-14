local UserInputService = game:GetService("UserInputService")

local imageEditor = script.Parent.Parent
local BaseTool = require(imageEditor.ToolHandler.BaseTool)
local types = require(imageEditor.types)
local mouseData = require(imageEditor.ToolHandler.mouseData)

local OSGL = require(imageEditor.OSGL)
local OSGLTypes = OSGL.types
local draw = OSGL.draw
local color = OSGL.color

local Pen = {}
setmetatable(Pen, BaseTool)
Pen.__index = Pen

type PenTool = types.BaseTool & {
    color: OSGLTypes.Color
}

function Pen.new()
    local self = setmetatable({
        color = color.RED
    }, Pen)

    return self
end

function Pen.HandleInput(self: PenTool, input: InputObject, window: OSGLTypes.Window)
    if not mouseData.MouseButton1Down then
        return
    end

    local isInWindow, x, y = window:GetRelativeMouse()
    if not isInWindow then
        return
    end

    draw.pixel(window, x, y, self.color)
    window:Render()
end

return Pen
