--!optimize 2
--!strict


--========================================================================
-- OSGL 1.1
--------------------------------------------------------------------------
-- Copyright (c) 2023-2024 | Gunshot Sound Studios | ShadowX
--
-- This software is provided 'as-is', without any express or implied
-- warranty. In no event will the authors be held liable for any damages
-- arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it
-- freely, subject to the following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
--    claim that you wrote the original software. If you use this software
--    in a product, an acknowledgment in the product documentation would
--    be appreciated but is not required.
--
-- 2. Altered source versions must be plainly marked as such, and must not
--    be misrepresented as being the original software.
--
-- 3. This notice may not be removed or altered from any source
--    distribution.
--
--========================================================================

local UserInputService = game:GetService("UserInputService")

local Types = require(script.Parent.Types)
local Log = require(script.Parent.Log)
local Default = require(script.Default)
local Color = require(script.Parent.Color)
local Render = require(script.Render)

local warn = Log.warn
local error = Log.error

local windowPublic = {}
local windowPrivate = {}

windowPrivate.__index = windowPrivate

local function getMousePosition(self): Vector2
	local MouseLocation = UserInputService:GetMouseLocation()

	local CanvasFrameSize = self.Renderer.Parent.AbsoluteSize :: Vector2
	local FastCanvasFrameSize = self.Renderer.Parent.AbsoluteSize :: Vector2
	local CanvasPosition = self.Renderer.Parent.AbsolutePosition :: Vector2

	local GuiInset = game.GuiService:GetGuiInset()
	local MousePoint = MouseLocation - GuiInset - CanvasPosition

	local TransformedPoint = (MousePoint / FastCanvasFrameSize) 

	TransformedPoint *= self.Renderer.Size 

	local RatioDifference = Vector2.new(
		CanvasFrameSize.X / FastCanvasFrameSize.X,
		CanvasFrameSize.Y / FastCanvasFrameSize.Y
	) - Vector2.new(1, 1)
	TransformedPoint -= (RatioDifference / 2) * self.Renderer.Size

	local RoundX = math.ceil(TransformedPoint.X)
	local RoundY = math.ceil(TransformedPoint.Y)

	TransformedPoint = Vector2.new(RoundX, RoundY)

	return TransformedPoint
end

-- Creates a new window via an Editable Image, Image, or Instance.
-- Returns the rendering context.
function windowPublic.new(preParams: Types.windowParameters): Types.Window
	
	local ENUM_MAP = {
		["0"] = Default.MAX_SIZE,
		["1"] = Default.MIN_SIZE,
		["2"] = function(Params: Types.windowParameters)
			if not Params.Instance:IsA("GuiObject") then
				warn(`Enum 'WindowSize.Mutuable' expects Function 'window.new' parameter 'Instance' to be of type: 'GuiObject', recieved: {Params.Instance}.\nDefaulting to max size.`)
				return Default.MAX_SIZE
			end

			return Params.Instance.AbsoluteSize
		end,
	}
	
	return function(forParams: Types.windowParameters?): Types.WindowRenderingContext
		local windowParams = preParams or forParams

		-- ERROR
		if not windowParams then
			error([[Function 'window.new' expects window parameters to be passed atleast once.
No window parameters were passed at all.
Did you forget to pass them?
			
local myWindow = window.new({
	Size = enum.WindowSize.Maximum
})()

-- WINDOW PARAMETERS ^^]])
		end

		windowParams.Size = windowParams.Size or Default.MAX_SIZE
		windowParams.Name = windowParams.Name or "Window"

		-- ERROR
		if not windowParams.Instance then
			error([[Function 'window.new' expects required parameter: 'Instance' to be passed.
Did you forget to pass 'Instance'? (EditableImage | ImageLabel | Instance)

local myWindow = window.new({
	Instance = script.Parent
})()

-- WINDOW PARAMETERS ^^]])
		end
		
		local renderer
		local size = windowParams.Size
		
		if typeof(size) == "number" then
			local mappedItem = ENUM_MAP[tostring(size)]
			
			-- ERROR
			if not mappedItem then
				error([[Function 'window.new' expects parameter: 'Size' to be of enum: 'WindowSize'.

local myWindow = window.new({
	Size = enum.WindowSize.Maximum
})()

-- WINDOW PARAMETERS ^^]])
			end
			
			if typeof(mappedItem) == "function" then
				windowParams.Size = mappedItem(windowParams)
			else
				windowParams.Size = mappedItem
			end
		elseif typeof(size) ~= "Vector2" then
			error([[Function 'window.new' expects parameter: 'Size' to be of enum: 'WindowSize' or Vector2.

				local myWindow = window.new({
					Size = enum.WindowSize.Maximum
				})()

				-- WINDOW PARAMETERS ^^]])
		end
		
		if not windowParams.Instance:IsA("EditableImage") then
			if windowParams.Instance:IsA("ImageLabel") or windowParams.Instance:IsA("ImageButton") then
				local newRenderer = Instance.new("EditableImage")
				newRenderer.Size = windowParams.Size
				newRenderer.Parent = windowParams.Instance
				newRenderer.Name = tostring(windowParams.Name)
				
				renderer = newRenderer :: EditableImage
			else
				local newImage = Instance.new("ImageLabel")
				newImage.Parent = windowParams.Instance
				newImage.Size = windowParams.Instance.Size
				newImage.BackgroundTransparency = 1
				newImage.Name = tostring(windowParams.Name)
				
				local newRenderer = Instance.new("EditableImage")
				newRenderer.Size = windowParams.Size
				newRenderer.Parent = newImage
				newRenderer.Name = `{tostring(windowParams.Name)}_render`

				renderer = newRenderer :: EditableImage
			end
		else
			renderer = windowParams.Instance :: EditableImage
			renderer.Size = windowParams.Size
			renderer.Name = tostring(windowParams.Name)
		end

		local self = {
			Renderer = renderer,
			Size = windowParams.Size,
			
			DoubleBuffer = {}, --// Hidden Property
		}
		
		return setmetatable(self, windowPrivate)
	end
end

-- Clears the window with the selected color. This applies
-- to the DOUBLE BUFFER ONLY - It does NOT clear the window
-- in real-time.

function windowPrivate:clear(ClearColor: Types.RGBA): nil
	if not ClearColor then
		warn([[Function 'window:clear' expects all parameters to be passed.
No parameters were passed at all.
Did you forget to pass them?

window:clear(color.Black)

WINDOW COLOR ^^^^^

Clearing with color.Black instead.]])
		
		ClearColor = Color.Black
	end
	
	self.DoubleBuffer = {}
	
	table.insert(self.DoubleBuffer, {
		Name = "Clear",
		Args = {
			Color = ClearColor
		}
	})
	
	return	
end

-- Yields the thread and returns true if the Renderer still exists.
function windowPrivate:isOpen(yieldAmount: number?): boolean
	task.wait(yieldAmount)
	return self.Renderer ~= nil
end

function windowPrivate:render(): nil
	local editableImage = self.Renderer :: EditableImage

	for i, v: Types.RenderCommand in ipairs(self.DoubleBuffer) do
		local command = Render[v.Name]

		if command then
			command(self, v)	
		end
	end
	
	return
end

function windowPrivate:getRelativeMousePosition(): Vector2?
	
	local TransformedPoint = getMousePosition(self)
	
	if
		TransformedPoint.X > 0
		and TransformedPoint.Y > 0
		and TransformedPoint.X <= self.Renderer.Size.X
		and TransformedPoint.Y <= self.Renderer.Size.Y
	then
		return TransformedPoint
	end
	return getMousePosition(self)
end

function windowPrivate:getRelativeMousePositionOnScreen(): Vector2?
	return getMousePosition(self)
end

function windowPrivate:draw(...:Types.renderableObjects): nil
	local unpacked = {...}
	
	for i, v in ipairs(unpacked) do
		local doubleBfr = self.DoubleBuffer
		
		table.insert(doubleBfr, {
			Name = v.Command,
			Args = {
				Object = v
			}
		})
	end
end

function windowPrivate:readRGBA(Position: Vector2): Types.RGBA
	local Renderer = self.Renderer :: EditableImage
	local color = Renderer:ReadPixels(Position, Vector2.zero)
	
	return Color.new(color[1], color[2], color[3], color[4])
end

return windowPublic