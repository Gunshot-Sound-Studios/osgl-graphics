--!strict
--!native
--!optimize 2

------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
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
function Texture.from<T>(textureData: types.FlagTexture | ModuleScript): types.Texture<T>
    if typeof(textureData) == "Instance" and textureData:IsA("ModuleScript") then
        textureData = require(textureData)
    end

    local width, height = textureData.width, textureData.height

    return {
        buffer = textureData.pixels,

        sizeX = width,
        sizeY = height,
        size = Vector2.new(width, height),

        Draw = utils.createDraw(),
        ReadPixel = utils.createReadPixel(),
        TintRegion = utils.createTintRegion(),
        Serialize = utils.createSerialize(),
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
function Texture.new<T>(width: number, height: number, bfr: buffer?): types.Texture<T>
	return {
		buffer = bfr or buffer.create(width * height * 4),

		sizeX = width,
		sizeY = height,
		size = Vector2.new(width, height), -- [saaawdust]: TODO: Is this needed?

		Draw = utils.createDraw(),
		ReadPixel = utils.createReadPixel(),
		TintRegion = utils.createTintRegion(),
		Serialize = utils.createSerialize(),
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
	texture: types.Texture<T>,
	spriteX: number,
	spriteY: number
): types.Texture<T>
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

		Draw = object.Draw,
		ReadPixel = object.ReadPixel,
		TintRegion = object.TintRegion,
		Serialize = object.Serialize,
	}
end

--[=[
	Draws a [DrawableObject] onto another [DrawableObject] with a rotation. The pivot is at the center of the [DrawableObject]

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local secondTextureData = require(path.to.secondTexture)

	local textureA = Texture.from(textureData)
	local textureB = Texture.from(secondTextureData)

	-- Draw textureB on textureA at 0, 0, rotated 15 degrees
	local textureC = Texture.draw(textureA, textureB, 0, 0, 15)
	```

	@within Texture
	@param object DrawableObject -- The object that the texture will be drawn onto
	@param texture DrawableObject -- The texture that will be drawn
	@param spriteX number -- The X position of where the texture will be drawn
	@param spriteY number -- The y position of where the texture will be drawn
	@param rotation number -- The rotation of the texture
	@return DrawableObject -- The final texture
]=]
function Texture.drawRotated<T>(
	object: types.DrawableObject<T>,
	texture: types.Texture<T>,
	spriteX: number,
	spriteY: number,
	rotation: number
): types.Texture<T>
local objectSizeY = object.sizeY
	local objectSizeX = object.sizeX
	local sizeY = texture.sizeY
	local sizeX = texture.sizeX
	local bfr = texture.buffer

	local radians = math.rad(rotation)

	local centerX = sizeX / 2
	local centerY = sizeY / 2

	for y = 0, objectSizeY - 1 do
		for x = 0, objectSizeX - 1 do
			local relativeX = x - spriteX - centerX
			local relativeY = y - spriteY - centerY

			local sourceX = math.cos(radians) * relativeX + math.sin(radians) * relativeY + centerX
			local sourceY = -math.sin(radians) * relativeX + math.cos(radians) * relativeY + centerY

			if sourceX >= 0 and sourceX < sizeX and sourceY >= 0 and sourceY < sizeY then
				local pixelColor = buffer.readu32(bfr, math.floor(sourceY) * sizeX * 4 + math.floor(sourceX) * 4)
				pixel(object, x, y, pixelColor)
			end
		end
	end

	return {
		buffer = bfr,

		sizeX = sizeX,
		sizeY = sizeY,

		Draw = object.Draw,
		ReadPixel = object.ReadPixel,
		TintRegion = object.TintRegion,
		Serialize = object.Serialize,
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
	Scales a [DrawableObject] by the given amount

	```lua
	local OSGL = require(path.to.osgl)
	local Texture = OSGL.Texture

	local textureData = require(path.to.texture)
	local texture = Texture.from(textureData)

	-- Enlarge `texture` by 5x on the X axis
	local enlargedTexture = Texture.scale(texture, 5)
	```

	@within Texture
	@param texture DrawableObject -- The texture that will be enlarged
	@param scaleX number -- Scaling for x axis. Defaults to 1
	@param scaleY number -- Scaling for y axis. Defaults to 1
	@return DrawableObject -- The enlarged texture
]=]
function Texture.scale<T>(texture: types.DrawableObject<T>, scaleX: number?, scaleY: number?): types.DrawableObject<T>
	-- Set default values for scaleX and scaleY if not provided
	scaleX = scaleX or 1
	scaleY = scaleY or 1

	-- Get original texture size and buffer
	local originalSizeX = texture.sizeX
	local originalSizeY = texture.sizeY
	local bfr = texture.buffer

	-- Calculate the new size of the texture
	local newSizeX = math.floor(originalSizeX * scaleX)
	local newSizeY = math.floor(originalSizeY * scaleY)

	local newBuffer = buffer.create(newSizeX * newSizeY * 4)

	for y = 0, newSizeY - 1 do
		for x = 0, newSizeX - 1 do
			local sourceX = math.floor(x / scaleX)
			local sourceY = math.floor(y / scaleY)

			if sourceX < originalSizeX and sourceY < originalSizeY then
				local color = buffer.readu32(bfr, sourceY * originalSizeX * 4 + sourceX * 4)
				buffer.writeu32(newBuffer, y * newSizeX * 4 + x * 4, color)
			end
		end
	end

	return {
		buffer = newBuffer,
		sizeX = newSizeX,
		sizeY = newSizeY,

		Draw = texture.Draw,
		ReadPixel = texture.ReadPixel,
		TintRegion = texture.TintRegion,
		Serialize = texture.Serialize,
	}
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
function Texture.fromAssetId<T>(assetId: number): types.Texture<T>
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
		Serialize = utils.createSerialize(),
    }
end

--[=[
	@prop buffer buffer
	@within DrawableObject
	The buffer of the object
]=]

--[=[
	@prop sizeX number
	@within DrawableObject
	The width of the object
]=]

--[=[
	@prop sizeY number
	@within DrawableObject
	The height of the object
]=]

--[=[
	@prop size Vector2
	@within DrawableObject
	The size of the object
]=]

return Texture
