local imageEditor = script.Parent.Parent
local BaseTool = require(imageEditor.ToolHandler.BaseTool)
local types = require(imageEditor.types)
local mouseData = require(imageEditor.ToolHandler.mouseData)

local OSGL = require(imageEditor.OSGL)
local OSGLTypes = OSGL.types
local draw = OSGL.draw
local color = OSGL.color

local Eraser = {}
setmetatable(Eraser, BaseTool)
Eraser.__index = Eraser

type EraserTool = types.BaseTool & {}

function Eraser.new()
	local self = setmetatable({
		previousMousePointX = nil,
		previousMousePointY = nil,
	}, Eraser)

	return self
end

function Eraser.HandleInput(self: EraserTool, input: InputObject, window: OSGLTypes.Window)
	local isInWindow, x, y = window:GetRelativeMouse()
	if not isInWindow or not mouseData.MouseButton1Down then
        self.previousMousePointX = nil
		self.previousMousePointY = nil
		return
	end

	if self.previousMousePointX and self.previousMousePointY then
		draw.line(window, {
			startX = self.previousMousePointX,
			startY = self.previousMousePointY,
			stopX = x,
			stopY = y,
            color = color.TRANSPARENT
		})
	else
		draw.pixel(window, x, y, color.new(200, 50, 50, 255))
	end

	self.previousMousePointX, self.previousMousePointY = x, y
	window:Render()
end


return Eraser
