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

local Types = require(script.Parent.Types)
local Compression = require(script.StringCompressor)
local Log = require(script.Parent.Log)
local Color = require(script.Parent.Color)

local error = Log.error

local TexturePublic = {}
local TexturePrivate = {}
TexturePrivate.__index = TexturePrivate

function TexturePublic.rectCrop(Position: Vector2, Size: Vector2)
	Position = Position or Vector2.zero
	Size = Size or Vector2.one
	
	return {
		StartingPos = Position,
		Dimensions = Size
	}
end

local function loadTexture(Str: string, cutTexture: { StartingPos: Vector2, Dimensions: Vector2 }?): string
	local decompressedStr = Compression.Decompress(Str)
	local startDim, endDim = string.find(decompressedStr, "<%d+!%d+>")
	
	if not startDim or not endDim then
		error([[Error while loading texture.
The texture provided was corrupted.]])
	end
	
	local dimensionsRaw = string.sub(decompressedStr, startDim + 1, endDim - 1)
	local dimensions = string.split(dimensionsRaw, "!")
	
	dimensions[1] = tonumber(dimensions[1])
	dimensions[2] = tostring(dimensions[2])
	
	decompressedStr = string.sub(decompressedStr, endDim + 1)
	
	local function extractColor(): {{Hex: string, Alpha: number?}}
		local result = {}
		local pattern = "(.-)(%d%d%d);"
		
		for hex, alpha in string.gmatch(decompressedStr, pattern) do
			local alphaBuffer = buffer.create(2)
			buffer.writei16(alphaBuffer, 0, tonumber(alpha))
			
			table.insert(result, {Hex = buffer.fromstring(hex), Alpha = alphaBuffer})
		end

		return result
	end
	
	local extractedPixelData = extractColor()
	local pixelAmount = dimensions[1] * dimensions[2]
	local textureData = table.create(pixelAmount)
	
	local index = 0
	for Y = 1, dimensions[2] do
		textureData[Y] = {}
		for X = 1, dimensions[1] do
			index += 1
			textureData[Y][X] = {
				RGB = Color.fromHex(buffer.readstring(extractedPixelData[index].Hex, 0, buffer.len(extractedPixelData[index].Hex))),
				Alpha = buffer.readi16(extractedPixelData[index].Alpha, 0)
			}
		end
	end
	
	if cutTexture then
		local cutData = {}
		local startX = cutTexture.StartingPos.X
		local startY = cutTexture.StartingPos.Y
		local cutWidth = cutTexture.Dimensions.X
		local cutHeight = cutTexture.Dimensions.Y

		for Y = startY + 1, math.min(startY + cutHeight, dimensions[2]) do
			local row = {}
			for X = startX + 1, math.min(startX + cutWidth, dimensions[1]) do
				table.insert(row, textureData[Y][X])
			end
			table.insert(cutData, row)
		end

		textureData = cutData
	end
	
	return Compression.Compress(HttpService:JSONEncode(textureData))
end

function TexturePublic.loadFromModule(Module: ModuleScript, Dimensions: { StartingPos: Vector2, Dimensions: Vector2 }?): Types.Texture
	local moduleString = require(Module) :: any
	
	if not moduleString then moduleString = "" end
	
	moduleString = loadTexture(moduleString, Dimensions)
	
	return {
		Texture = moduleString,
		Rect = Dimensions
	}
end

function TexturePublic.loadFromString(Str: string, Dimensions: { StartingPos: Vector2, Dimensions: Vector2 }?): Types.Texture
	if not Str then Str = "" end
	
	Str = loadTexture(Str, Dimensions)
	
	return {
		Texture = Str,
		Rect = Dimensions
	}
end

function TexturePublic.new(Dimensions: Vector2): Types.EditableTexture
	
	if Dimensions then
		Dimensions = Vector2.new(math.abs(Dimensions.X), math.abs(Dimensions.Y))
		if Dimensions.X == 0 then
			Dimensions = Vector2.new(1, Dimensions.Y)
		end

		if Dimensions.Y == 0 then
			Dimensions = Vector2.new(Dimensions.X, 1)
		end
	end
	
	local self = {
		Dimensions = Dimensions or Vector2.one,
		Buffer = {}
	}
	
	for Y = 0, Dimensions.Y do
		self.Buffer[Y] = {}
		for X = 0, Dimensions.X do
			self.Buffer[Y][X] = Color.Transparent
		end
	end
	
	return setmetatable(self, TexturePrivate)
end



function TexturePrivate:SetPixel(Position: Vector2, PixelColor: Types.RGBA)
	Position = Position or Vector2.one
	PixelColor = PixelColor or Color.Black
	
	if not self.Buffer[Position.Y] then return end
	if not self.Buffer[Position.Y][Position.X] then return end
	
	self.Buffer[Position.Y][Position.X] = PixelColor
	
	return
end

function TexturePrivate:SetPixels(Size: Vector2, Position: Vector2, PixelColor: Types.RGBA)
	Position = Position or Vector2.one
	PixelColor = PixelColor or Color.Black
	
	for Y = Position.Y, (Position.Y + Size.Y) do
		local yBfr = self.Buffer[Y]
		if not yBfr then continue end
		for X = Position.X, Position.X + Size.X do
			if not yBfr[X] then return end
			self.Buffer[Y][X] = PixelColor
		end
	end

	return
end

function TexturePrivate:GetPixels(Size: Vector2, Position: Vector2): {{{Types.RGBA}}}
	Position = Position or Vector2.one
	
	local Pixels = {}
	for Y = Position.Y, Position.Y + Size.Y do
		local yBfr = self.Buffer[Y]
		if not yBfr then continue end
		Pixels[Y] = {}
		for X = Position.X, Position.X + Size.X do
			local xBfr = yBfr[X]
			if not xBfr then continue end
			Pixels[Y][X] = xBfr
		end
	end

	return Pixels
end

function TexturePrivate:GetPixel(Position: Vector2): Types.RGBA?
	Position = Position or Vector2.one

	if not self.Buffer[Position.Y] then return end
	if not self.Buffer[Position.Y][Position.X] then return end

	return 	self.Buffer[Position.Y][Position.X]
end

function TexturePrivate:finish()
	local str = ""
	
	local function toThreeDigits(number: number): string
		if number > 255 then
			number = 255
		end

		return string.format("%03d", number)
	end
	
	for _, YObj in ipairs(self.Buffer) do
		for __, XObj in ipairs(YObj) do
			local RGB, Alpha = Color.toRGB(XObj)
			str ..= RGB:ToHex()..toThreeDigits((1-Alpha)*255)..";"
		end
	end
	
	print(str)
	
	return Compression.Compress(`<{self.Dimensions.X}!{self.Dimensions.Y}>{str}`)
end

return TexturePublic