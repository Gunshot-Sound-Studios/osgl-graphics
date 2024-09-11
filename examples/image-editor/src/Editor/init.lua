local OSGL = require(script.Parent.OSGL)
local OSGLTypes = OSGL.types

local imageEditor = script.Parent
local ToolHandler = require(imageEditor.ToolHandler)
local BaseTool = require(imageEditor.ToolHandler.BaseTool)
local types = require(imageEditor.types)

local TOOLS: types.Tools<string> = {
    name = BaseTool.new(),
}

local Editor = {}
Editor.__index = Editor

function Editor.new(ui: ScreenGui)
    -- TODO: Add UI
    local window = OSGL.Window.new(ui.drawingArea)

    local self = setmetatable({
        window = window,
        toolHandler = ToolHandler.new(TOOLS, window, ui.toolsUi)
    }, Editor)

    return self
end

return Editor
