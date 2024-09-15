local imageEditor = script.Parent.Parent
local editor = imageEditor.Editor
local BaseTool = require(imageEditor.ToolHandler.BaseTool)
local types = require(imageEditor.types)
local mouseData = require(imageEditor.ToolHandler.mouseData)
local colorHandler = require(editor.colorHandler)

local OSGL = require(imageEditor.OSGL)
local OSGLTypes = OSGL.types
local draw = OSGL.draw
local color = OSGL.color

local Pen = {}
setmetatable(Pen, BaseTool)
Pen.__index = Pen

type PenTool = types.BaseTool & {
	color: OSGLTypes.Color,
}

function Pen.new()
	local self = setmetatable({
		previousMousePointX = nil,
		previousMousePointY = nil,
	}, Pen)

	return self
end

function Pen.HandleInput(self: PenTool, input: InputObject, window: OSGLTypes.Window)
	local isInWindow, x, y = window:GetRelativeMouse()
	if not isInWindow or not mouseData.MouseButton1Down then
        self.previousMousePointX = nil
		self.previousMousePointY = nil
		return
	end

	print(colorHandler.getRGB(window.renderer.Parent.Parent))
	if self.previousMousePointX and self.previousMousePointY then
		draw.line(window, {
			startX = self.previousMousePointX,
			startY = self.previousMousePointY,
			stopX = x,
			stopY = y,
            color = colorHandler.getRGB(window.renderer.Parent.Parent)
		})
	else
		draw.pixel(window, x, y, colorHandler.getRGB(window.renderer.Parent.Parent))
	end

	self.previousMousePointX, self.previousMousePointY = x, y
	window:Render()
end


return Pen
