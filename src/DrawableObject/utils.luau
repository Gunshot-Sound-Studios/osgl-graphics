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

local OSGL = script.Parent.Parent
local draw = require(OSGL.draw)
local types = require(OSGL.types)
local util = require(OSGL.utils)
local color = require(OSGL.color)

--[=[
	@class DrawableObject

	The DrawableObject class. This class represents
	any item that you can draw to in OSGL, that be a
	texture or a window.
]=]
local utils = {}

-- [saaawdust]: Credits to `sambouza` for this implementation
function utils.createDraw()
	return function(object)
		return {
			FloodFill = function(self, ...)
				draw.floodFill(object, ...)
				return self
			end,

			Polygon = function(self, ...)
				draw.polygon(object, ...)
				return self
			end,

			Triangle = function(self, ...)
				draw.triangle(object, ...)
				return self
			end,

			Circle = function(self, ...)
				draw.circle(object, ...)
				return self
			end,

			Rectangle = function(self, ...)
				draw.rectangle(object, ...)
				return self
			end,

			Line = function(self, ...)
				draw.line(object, ...)
				return self
			end,

			Pixel = function(self, ...)
				draw.pixel(object, ...)
				return self
			end,

			StopDrawing = function()
				return object
			end,
		}
	end
end

function utils.createReadPixel()
	return function(self, x: number, y: number)
		return buffer.readu32(self.buffer, (y * self.sizeX + x) * 4)
	end
end

function utils.createTintRegion()
	return function<T>(self: types.DrawableObject<T>, tint, factor, x, y, width, height)
		local tintR = color.r(tint)
		local tintG = color.g(tint)
		local tintB = color.b(tint)
		local tintA = color.a(tint)

		local sizeX = self.sizeX
		local bfr = self.buffer
		for x = x, x + width do
			for y = y, y + height do
				local pixelColor = buffer.readu32(bfr, (y * sizeX + x) * 4)

				buffer.writeu32(
					bfr,
					(y * sizeX + x) * 4,
					color.new(
						utils.lerp(color.r(pixelColor), tintR, factor),
						utils.lerp(color.g(pixelColor), tintG, factor),
						utils.lerp(color.b(pixelColor), tintB, factor),
						utils.lerp(color.a(pixelColor), tintA, factor)
					)
				)
			end
		end

		return self
	end
end

function utils.createSerialize()
	return function<T>(self: types.DrawableObject<T>)
		return self.buffer, self.sizeX, self.sizeY
	end
end

return utils
