--!native
--!optimize 2

------------------------------------------------------------
-- OSGL v1.3b - Open-Source-Graphical-Library
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
local draw = require(script.Parent.draw)

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
    local txt -- *load texture*
    local mySprite = Sprite.new(txt)
    ```

    @within Sprite
    @param Texture Texture -- The texture of the sprite
    @return Sprite -- The new sprite
]=]
function Sprite.new(Texture: types.Texture): types.Sprite
	local self = setmetatable({
		x = 0,
		y = 0,
		texture = Texture,
	}, SpritePrivate)

	return self
end

--[=[
    Creates a new sprite on the given window or texture.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Sprite = OSGL.Sprite
    ​
    -- Creates a window from an existing EditableImage
    local myWindow = Window.from(path.to.editableImage, { sizeX = 50, sizeY = 50 })

    local txt = -- *load texture*
    local mySprite = Sprite.new(myWindow, txt)
    mySprite:Draw(myWindow) -- Draws the sprite onto the window at 0, 0
    ```

    @within Sprite
    @param window Drawable -- The window, or texture, the sprite will be drawn on.
]=]
function SpritePrivate:Draw(window: types.Drawable)
	self = self :: types.Sprite

	local texture = self.texture

	local y2 = 0
	for y = self.y, self.y + texture.sizeY - 1 do
		if y >= window.sizeY then
			break
		end

		y2 = y - self.y

		local x2 = 0
		for x = self.x, self.x + texture.sizeY - 1 do
			if x >= window.sizeX then
				break
			end

			x2 = x - self.x
			if y2 < texture.sizeY and x2 < texture.sizeX then
				draw.pixel(window, x, y, texture.pixels[(y2 * texture.sizeX + x2) + 1])
			end
		end
	end
end

return Sprite