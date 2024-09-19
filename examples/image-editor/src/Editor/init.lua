local OSGL = require(script.Parent.OSGL)
local Window = OSGL.Window

local imageEditor = script.Parent
local ToolHandler = require(imageEditor.ToolHandler)
local Pen = require(imageEditor.ToolHandler.Pen)
local Eraser = require(imageEditor.ToolHandler.Eraser)
local types = require(imageEditor.types)

local TOOLS: types.Tools<string> = {
    draw = Pen.new(),
    erase = Eraser.new()
}

local Editor = {}
Editor.__index = Editor

function Editor.new(mouse: PluginMouse, ui: ScreenGui)
    local window = Window.new(ui.drawingArea, { sizeX = 100, sizeY = 100 })

    local self = setmetatable({
        window = window,
        toolHandler = ToolHandler.new(mouse, TOOLS, window, ui.toolsUi)
    }, Editor)

    return self
end

return Editor
