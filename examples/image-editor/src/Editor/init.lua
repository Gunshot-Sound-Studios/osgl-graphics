local OSGL = require(script.Parent.OSGL)
local OSGLTypes = OSGL.types

local imageEditor = script.Parent
local ToolHandler = require(imageEditor.ToolHandler)
local Pen = require(imageEditor.ToolHandler.Pen)
local types = require(imageEditor.types)

local TOOLS: types.Tools<string> = {
    draw = Pen.new(),
}

local Editor = {}
Editor.__index = Editor

function Editor.new(mouse: PluginMouse, ui: ScreenGui)
    -- TODO: Add UI
    local window = OSGL.Window.new(ui.drawingArea, { sizeX = 100, sizeY = 100 })

    local self = setmetatable({
        window = window,
        toolHandler = ToolHandler.new(mouse, TOOLS, window, ui.toolsUi)
    }, Editor)

    return self
end

return Editor
