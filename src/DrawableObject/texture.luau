--!strict
--!native
--!optimize 2

------------------------------------------------------------
-- OSGL v1.4b - Open-Source-Graphical-Library
-- Copyright © 2023-2024 Gunshot Sound Studios (@saaawdust)
--
-- This software is provided ‘as-is’, without any express or implied warranty.
-- In no event will the authors be held liable for any damages arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it freely,
-- subject to the following restrictions:
--
-- 1. The origin of this software must not be misrepresented;
--    you must not claim that you wrote the original software.
--    If you use this software in a product, an acknowledgment
--    in the product documentation would be appreciated but is not required.
--
-- 2. Altered source versions must be plainly marked as such,
--    and must not be misrepresented as being the original software.
--
-- 3. This notice may not be removed or altered from any source distribution.
--
------------------------------------------------------------

local AssetService = game:GetService("AssetService")

local OSGL = script.Parent.Parent
local drawableObject = OSGL.DrawableObject
local draw = OSGL.draw
local types = require(OSGL.types)
local pixel = require(draw.pixel)
local log = require(OSGL.log)
local utils = require(drawableObject.utils)

--[=[
    @class Texture

    The Texture class. Handles loading textures into memory
    so you can draw them onto a [DrawableObject]. Inherits everything from
    [DrawableObject]
]=]
local Texture = {}

local function getIndex(width: number, height: number, index: number)
	if index < 1 or index > (width * height) then
		return nil, nil
	end

	local x = (index - 1) % width + 1
	local y = math.ceil(index / width)

	return x, y
end

--[=[
	Creates a texture from textureData

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local texture = Texture.from(textureData)
	```

	@within Texture
	@param textureData FlagTexture | ModuleScript -- The textureData
	@return DrawableObject -- The loaded texture
]=]
function Texture.from(textureData: types.FlagTexture | ModuleScript): types.DrawableObject<types.DrawableObject>
	if typeof(textureData) == "Instance" and textureData:IsA("ModuleScript") then
		textureData = require(textureData)
	end

	local width, height = textureData.width, textureData.height
	local bfr = buffer.create(width * height * 4)

	local i = 1
	for _, v in ipairs(textureData.pixels) do
		if type(v) == "number" then
			local x, y = getIndex(width, height, i)

			if not x or not y then
				continue
			end

			x -= 1
			y -= 1

			buffer.writeu32(bfr, (y * width + x) * 4, v)
			i += 1
		else
			-- This is a flag. For now, there's only an `r` flag.
			local repetitions, color = string.match(v, "(%d+)-(%d+)")
			for _ = 1, repetitions do
				local x, y = getIndex(width, height, i)
				if not x or not y then
					continue
				end

				x -= 1
				y -= 1

				buffer.writeu32(bfr, (y * width + x) * 4, color)
				i += 1
			end
		end
	end

	return {
		buffer = bfr,

		sizeX = width,
		sizeY = height,
		size = Vector2.new(width, height), -- Is this needed?

		Draw = utils.createDraw(),
		ReadPixel = utils.createReadPixel(),
		TintRegion = utils.createTintRegion(),
	}
end

--[=[
	Creates a texture of the given dimensions with an optional buffer

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local texture = Texture.new(5, 10)
	```

	@within Texture
	@param width number -- The texture's width
	@param height number -- The texture's height
	@param bfr buffer? -- An optional buffer for textureData
	@return DrawableObject -- The loaded texture
]=]
function Texture.new(width: number, height: number, bfr: buffer?): types.DrawableObject<types.DrawableObject>
	return {
		buffer = bfr or buffer.create(width * height * 4),

		sizeX = width,
		sizeY = height,
		size = Vector2.new(width, height), -- [saaawdust]: TODO: Is this needed?

		Draw = utils.createDraw(),
		ReadPixel = utils.createReadPixel(),
		TintRegion = utils.createTintRegion(),
	}
end

--[=[
	Draws a [DrawableObject] onto another [DrawableObject]

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local secondTextureData = require(path.to.secondTexture)

	local textureA = Texture.from(textureData)
	local textureB = Texture.from(secondTextureData)

	-- Draw textureB on textureA at 0, 0
	local textureC = Texture.draw(textureA, textureB, 0, 0)
	```

	@within Texture
	@param object DrawableObject -- The object that the texture will be drawn onto
	@param texture DrawableObject -- The texture that will be drawn
	@param spriteX number -- The X position of where the texture will be drawn
	@param spriteY number -- The y position of where the texture will be drawn
	@return DrawableObject -- The final texture
]=]
function Texture.draw<T>(
	object: types.DrawableObject<T>,
	texture: types.DrawableObject<types.DrawableObject>,
	spriteX: number,
	spriteY: number
): types.DrawableObject<types.DrawableObject>
	local y2 = 0
	local objectSizeY = object.sizeY
	local objectSizeX = object.sizeX
	local sizeY = texture.sizeY
	local sizeX = texture.sizeX
	local bfr = texture.buffer

	for y = spriteY, spriteY + sizeY - 1 do
		if y >= objectSizeY then
			break
		end

		y2 = y - spriteY

		local x2 = 0
		for x = spriteX, spriteX + sizeX - 1 do
			if x >= objectSizeX then
				break
			end

			x2 = x - spriteX
			if y2 < sizeY and x2 < sizeX then
				pixel(object, x, y, buffer.readu32(bfr, (y * sizeX + x) * 4))
			end
		end
	end

	return {
		buffer = bfr,

		sizeX = sizeX,
		sizeY = sizeY,

		Draw = utils.createDraw(),
		ReadPixel = utils.createReadPixel(),
		TintRegion = utils.createTintRegion(),
	}
end

--[=[
	Reads a rectangular selection of pixels from a [DrawableObject]

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local texture = Texture.from(textureData)
	-- Read a rectangular selection of pixels from 0, 5, with the
	-- selection being 10x15 (150 pixels, from 0, 5)
	local bfr, width, height = Texture.read(texture, 0, 5, 10, 15)
	```

	@within Texture
	@param texture DrawableObject -- The texture that the selection of pixels will be taken from
	@param xPos number -- The top-left X position of the selection
	@param yPos number -- The top-left Y position of the selection
	@param width number -- The width of the selection box
	@param height number -- The height of the selection box
	@return (buffer, number, number) -- A tuple containing the buffer-data, the width, and height
]=]
function Texture.read<T>(texture: types.DrawableObject<T>, xPos: number, yPos: number, width: number, height: number): (buffer, number, number)
	local sizeX = texture.sizeX
	local sizeY = texture.sizeY
    local txt = texture.buffer

	if xPos < 0 or xPos > 1024 or yPos < 0 or yPos > 1024 then
		log.warn(
			"Attempt to read a texture from an invalid position (X: "
				.. xPos
				.. ", Y: "
				.. yPos
				.. "). Dimensions must be within the texture. The position has been clamped to fit inside the texture."
		)
	end

    if width <= 0 or width > sizeX or height <= 0 or height > sizeY then
		log.warn(
			"Attempt to read from a texture with the width or height being out of bounds (Width: "
				.. width
				.. ", Height: "
				.. height
				.. "). All dimensions must be within the texture. The width / height has been automatically clamped to valid parameters."
		)
	end


	local clampedXPos = math.clamp(xPos, 0, sizeX - 1)
	local clampedYPos = math.clamp(yPos, 0, sizeY - 1)
	local clampedWidth = math.clamp(width, 1, sizeX - clampedXPos)
	local clampedHeight = math.clamp(height, 1, sizeY - clampedYPos)

	local bfr = buffer.create(clampedWidth * clampedHeight * 4)
	for h = 0, clampedHeight - 1 do
		for w = 0, clampedWidth - 1 do
			local textureIndex = ((clampedYPos + h) * sizeX + (clampedXPos + w)) * 4
			local bufferIndex = (h * clampedWidth + w) * 4
			buffer.writeu32(bfr, bufferIndex, buffer.readu32(txt, textureIndex))
		end
	end

	return bfr, width, height
end

--[=[
	Creates a [DrawableObject] (texture) from an assetId

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local texture = Texture.fromAssetId(asset.id)
	```

	@within Texture
	@param assetId number -- The assetId that the texture will be
	@error "Memory" -- This error occurs when the device doesn't have enough memory to create the texture
	@return DrawableObject -- A finished texture that is the assetId
]=]
function Texture.fromAssetId(assetId: number): types.DrawableObject<types.DrawableObject>
    local newContent = Content.fromAssetId(assetId)

    -- [saaawdust]: Do I check if they can create an editable image or not? [1]
    local temporaryEditableImage = AssetService:CreateEditableImageAsync(newContent)
    if not temporaryEditableImage then
        log.error("Could not make texture as the device does not have enough memory")
    end

    local size = temporaryEditableImage.Size
    local width, height = size.X, size.Y

	    -- [saaawdust]: Do I check if they can create an editable image or not? [2]
    local pixelBuffer = temporaryEditableImage:ReadPixelsBuffer(Vector2.zero, size)
	temporaryEditableImage:Destroy()
	
    return {
        buffer = pixelBuffer,

        sizeX = width,
        sizeY = height,
        size = size,

        Draw = utils.createDraw(),
		ReadPixel = utils.createReadPixel(),
		TintRegion = utils.createTintRegion(),
    }
end

return Texture
