--!optimize 2
--!strict
--!native


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

local HttpService = game:GetService("HttpService")

local Types = require(script.Parent.Parent.Types)
local RGBA = require(script.Parent.Parent.Color)
local Compression = require(script.Parent.Parent.Texture.StringCompressor)
local Fonts = require(script.Fonts)
local Log = require(script.Parent.Parent.Log)

local error = Log.error
local warn = Log.warn

local function DrawThickLine( 	EditableImage: EditableImage, p1: Vector2, p2: Vector2, color: Color3, transparency: number, thickness: number )
	local distance = (p2 - p1).Magnitude
	local stepSize = 1 
	local stepVector = (p2 - p1).Unit * stepSize
	local numSteps = math.floor(distance / stepSize)

	for i = 0, numSteps do
		local currentPoint = p1 + stepVector * i
		EditableImage:DrawCircle(currentPoint, thickness / 2, color, transparency)
	end

	EditableImage:DrawCircle(p1, thickness / 2, color, transparency)
	EditableImage:DrawCircle(p2, thickness / 2, color, transparency)
end

local function fillShapeFromVerts(verts: {Vector2}, Renderer: EditableImage, RGB: Color3, Alpha: number)
	for i, v in ipairs(verts) do
		local nextObj = verts[i + 1] or verts[1]
		Renderer:DrawLine(v, nextObj, RGB, Alpha)
	end

	local minY, maxY = math.huge, -math.huge
	for _, vert in ipairs(verts) do
		minY = math.min(minY, vert.Y)
		maxY = math.max(maxY, vert.Y)
	end

	for y = math.floor(minY), math.ceil(maxY) do
		local intersections = {}
		for i, vert1 in ipairs(verts) do
			local vert2 = verts[i % #verts + 1]
			if (vert1.Y <= y and vert2.Y > y) or (vert2.Y <= y and vert1.Y > y) then
				local x = (vert2.X - vert1.X) * (y - vert1.Y) / (vert2.Y - vert1.Y) + vert1.X
				table.insert(intersections, x)
			end
		end

		table.sort(intersections)

		for i = 1, #intersections, 2 do
			local x1, x2 = intersections[i], intersections[i + 1]
			if x2 then
				for x = math.floor(x1), math.ceil(x2) do
					DrawThickLine(Renderer, Vector2.new(x, y), Vector2.new(x, y), RGB, Alpha, 1)
				end
			end
		end
	end
end

local function getGridIndex(X: number, Y: number, Renderer: EditableImage): number
	return (X + (Y - 1) * Renderer.Size.X) * 4 - 3
end

return {
	["Clear"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local RGB, Alpha = RGBA.toRGB(Command.Args.Color)
		Window.Renderer:DrawRectangle(Vector2.zero, Window.Renderer.Size, RGB, Alpha)
	end,

	["DrawSprite"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Sprite = Command.Args.Object :: Types.Sprite 
		
		if not Sprite.Texture then return end
		
		local decodedTexture = HttpService:JSONDecode(Compression.Decompress(Sprite.Texture.Texture))
		local scale = Sprite.Scale or Vector2.one :: Vector2 
	
		for Y = 1, #decodedTexture do
			for X = 1, #decodedTexture[Y] do
				local pixel = decodedTexture[Y][X] :: {RGB: Types.RGBA, Alpha: number}

				local realX = ((X - 1) * scale.X) + Sprite.Position.X
				local realY = ((Y - 1) * scale.Y) + Sprite.Position.Y

				for offsetY = 0, scale.Y - 1 do
					for offsetX = 0, scale.X - 1 do
						local scaledX = realX + offsetX
						local scaledY = realY + offsetY
						local newPos = Vector2.new(scaledX, scaledY)

						if (scaledX >= Window.Renderer.Size.X) or (scaledX <= -1) or (scaledY >= Window.Renderer.Size.Y) or (scaledY <= -1) then
							continue
						end

						local mixedRGB = {
							Red = pixel.RGB.Red * Sprite.Color,
							Green = pixel.RGB.Green * Sprite.Color,
							Blue = pixel.RGB.Blue * Sprite.Color
						}

						Window.Renderer:WritePixels(newPos, Vector2.one, {
							mixedRGB.Red / 255,
							mixedRGB.Green / 255,
							mixedRGB.Blue / 255,
							pixel.Alpha / 255
						})
					end
				end
			end
		end
	end,

	["DrawText"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Text = Command.Args.Object :: Types.Text
		local Renderer = Window.Renderer

		if typeof(Text.Font) ~= "number" then
			warn(`Unable to draw text.\nText requires an OSGL Font, but type '{typeof(Text.Font)}'' was provided.\nDefaulting to 'default' font.`)
			Text.Font = Types.Font.Default	
		end

		local bfrMap = Fonts[tostring(Text.Font)]
		local fontMap = buffer.readstring(bfrMap, 0, buffer.len(bfrMap))

		fontMap = HttpService:JSONDecode(fontMap) 
		
		if fontMap and fontMap.__config then
			--// Another "if" incase we add more stuff later
			local config = fontMap.__config
			
			if config.capsOnly then
				Text.Text = string.upper(Text.Text)
			elseif config.lowerOnly then
				Text.Text = string.lower(Text.Text)
			end
		end

		local baseSpacing = 5 
		local position = Text.Position 

		local text = Text.Text
		local currentX = position.X

		local color = {
			Text.Color.Red / 255,
			Text.Color.Green / 255,
			Text.Color.Blue / 255,
			1 - Text.Color.Alpha / 255
		}


		for i = 1, #text do
			local subStr = string.sub(text, i, i)
			local mappedLetter = fontMap[subStr]

			if mappedLetter then
				local charWidth = mappedLetter.width
				local charHeight = mappedLetter.height
				local pixels = mappedLetter.pixels

				for y = 1, charHeight do
					for x = 1, charWidth do
						local index = (y - 1) * charWidth + x
						local pixelValue = pixels[index]

						if pixelValue == 1 then
							local posX = currentX + (x - 1)
							local posY = position.Y + (y - 1)
							local newPos = Vector2.new(posX, posY)

							Renderer:WritePixels(newPos, Vector2.one, color)
						end
					end
				end

				currentX = currentX + charWidth + baseSpacing
			end
		end
	end,	

	["Circle"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Circle = Command.Args.Object
		local Data = Circle.Data
		local Color = Data.Color :: Types.RGBA

		local RGB, Alpha = RGBA.toRGB(Color)

		Window.Renderer:DrawCircle(Data.Position, Data.Radius, RGB, Alpha)
	end,

	["Rect"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Rect = Command.Args.Object
		local Data = Rect.Data
		local Color = Data.Color :: Types.RGBA

		local RGB, Alpha = RGBA.toRGB(Color)

		Window.Renderer:DrawRectangle(Data.Position, Data.Size, RGB, Alpha)
	end,

	["Poly"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Poly = Command.Args.Object
		local Data = Poly.Data
		local Color = Data.Color
		local Sides = Data.Sides

		local RGB, Alpha = RGBA.toRGB(Color)

		local position = Data.Position
		local size = Data.Size

		local verts = {}
		local centerX = position.X
		local centerY = position.Y
		local radiusX = size.X / 2
		local radiusY = size.Y / 2

		for i = 1, Sides do
			local angle = (i - 1) * (2 * math.pi) / Sides
			local x = centerX + radiusX * math.cos(angle)
			local y = centerY + radiusY * math.sin(angle)
			table.insert(verts, Vector2.new(x, y))
		end

		fillShapeFromVerts(verts, Window.Renderer, RGB, Alpha)
	end,

	["Convex"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Convex = Command.Args.Object
		local Data = Convex.Data
		local Color = Data.Color
		local Verts = Data.Verts

		local RGB, Alpha = RGBA.toRGB(Color)

		fillShapeFromVerts(Verts, Window.Renderer, RGB, Alpha)
	end,

	["Line"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Line = Command.Args.Object
		local Data = Line.Data
		local Color = Data.Color :: Types.RGBA

		local RGB, Alpha = RGBA.toRGB(Color)

		DrawThickLine(Window.Renderer, Data.P1, Data.P2, RGB, Alpha, Data.Thickness)
	end,	
	
	["Pixel"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Pixel = Command.Args.Object
		local Data = Pixel.Data
		
		local renderer = Window.Renderer
		
		local RGB, Alpha = RGBA.toRGB(Data.Color)

		Window.Renderer:WritePixels(Data.Position, Vector2.one, {
			RGB.R,
			RGB.G,
			RGB.B,
			1 - Alpha
		})
	end,
	
	["Register"] = function(Window: Types.WindowRenderingContext, Command: Types.RenderCommand)
		local Vertex = Command.Args.Object

		Vertex.Callback(Window, Command)
	end
}