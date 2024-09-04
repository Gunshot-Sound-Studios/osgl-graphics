------------------------------------------------------------
-- OSGL v1.2b - Open-Source-Graphical-Library
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

local types = require(script.Parent.types)
local color = require(script.Parent.color)

--[=[
    @class Sprite

    The sprite class. Loads a `texture` onto the screen at the
    given position
]=]
local Sprite = {}
local SpritePrivate = {}
SpritePrivate.__index = SpritePrivate

--[=[
    Creates a new sprite
     ```lua
    local OSGL = require(path.to.osgl)
    local Sprite = OSGL.Sprite
    ​
    local txt = -- *load texture*
    local mySprite = Sprite.new(txt)
    ```

    @within Sprite
    @param Texture Texture -- The texture of the sprite
    @return Sprite -- The new sprite
]=]
function Sprite.new(Texture: types.Texture): types.Sprite
	local self = {
		width = Texture.width,
		height = Texture.height,
		x = 0,
		y = 0,
		color = color.WHITE,
		texture = Texture,
	}

	return setmetatable(self, SpritePrivate)
end

--[=[
    Creates a new sprite on the given window
     ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Sprite = OSGL.Sprite
    ​
    -- Creates a window from an existing EditableImage
    local myWindow = Window.from(path.to.editableImage, { size = Vector2.new(50, 50) })

    local txt = -- *load texture*
    local mySprite = Sprite.new(myWindow, txt)
    ```

    @within Sprite
    @param window Window -- The window the sprite will be drawn on
    @return Sprite -- The new sprite
]=]
function SpritePrivate:Draw(window: types.Window)
	self = self :: types.Sprite -- Remove me!

	local SIZE_X = window.sizeX
	local pixels = window.pixels
	local texture = self.texture

	local everythingIsZero = true
	local y2 = 0 -- Initialize outside the loop
	for y = self.y, self.y + self.height - 1 do
		if y >= window.sizeY then
			break
		end -- Stop drawing if outside window bounds

		y2 = y - self.y -- Calculate y2 relative to the texture (top-left aligned)

		local x2 = 0 -- Reset x2 for each row
		for x = self.x, self.x + self.width - 1 do
			if x >= window.sizeX then
				break
			end -- Stop drawing if outside window bounds

			x2 = x - self.x -- Calculate x2 relative to the texture (top-left aligned)

			-- Make sure the index for both `pixels` and `rawTexture` are valid
			if y2 < texture.height and x2 < texture.width then
				pixels[(y * SIZE_X + x) + 1] = texture.rawTexture[(y2 * texture.width + x2) + 1]
			end
		end
	end
end

return Sprite
