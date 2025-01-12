--!optimize 2

------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
-- Copyright © 2023-2025 Gunshot Sound Studios (@saaawdust)
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
local draw = OSGL.draw
local types = require(OSGL.types)
local color = require(OSGL.color)
local pixel = require(draw.pixel)
local fillPolygon = require(draw.fillPolygon)

return function<T>(object: types.DrawableObject<T>, xPos: number, yPos: number, width: number, height: number, fill: types.Color?, stroke: types.Color?, strokeThickness: number?, rotation: number?)
    fill = fill or color.BLACK
	rotation = rotation or 0
	stroke = stroke or color.TRANSPARENT
	strokeThickness = strokeThickness or 0

	local strokeLength = if stroke ~= color.TRANSPARENT then strokeThickness else 0

	local sizeX, sizeY = object.sizeX, object.sizeY

	local centerX = xPos + width / 2
	local centerY = yPos + height / 2

	if rotation % 90 == 0 then
		local w, h

		if rotation % 180 == 0 then
			w, h = width, height
		else
			w, h = height, width
		end

		w += strokeLength
		h += strokeLength

		for x = 0, w  do
			x += xPos
			
			if x >= sizeX then
				continue
			end

			for y = 0, h do
				y += yPos
				if y >= sizeY then
					continue
				end

				local pixelColor = if x > (w + xPos) or y > (h + yPos) then stroke else fill

				pixel(object, x, y, pixelColor)
			end
		end

		return
	end

	local radians = rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local function rotatePoint(x, y)
		local relativeX = x - centerX
		local relativeY = y - centerY
		local rotatedX = relativeX * cosTheta - relativeY * sinTheta
		local rotatedY = relativeX * sinTheta + relativeY * cosTheta
		return centerX + rotatedX, centerY + rotatedY
	end

	local x0, y0 = rotatePoint(xPos, yPos)
	local x1, y1 = rotatePoint(xPos + width, yPos)
	local x2, y2 = rotatePoint(xPos + width, yPos + height)
	local x3, y3 = rotatePoint(xPos, yPos + height)
    

	fillPolygon(object, {
		{ x0, y0 },
		{ x1, y1 },
		{ x2, y2 },
		{ x3, y3 },
	}, fill)
end