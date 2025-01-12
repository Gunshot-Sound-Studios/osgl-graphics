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

return function<T>(object: types.DrawableObject<T>, centerX: number, centerY: number, radius: number, fill: types.Color?, stroke: types.Color?, strokeThickness: number?, rotation: number?)
    fill = fill or color.BLACK
	rotation = rotation or 0
	stroke = stroke or color.TRANSPARENT
	strokeThickness = strokeThickness or 0

	local radius = radius
	local strokeThickness = if stroke ~= color.TRANSPARENT then strokeThickness else 0

	local sizeX, sizeY = object.sizeX, object.sizeY
	local radians = rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local radiusSquared = radius * radius
	local totalRadius = strokeThickness + radius
	local strokeSquared = totalRadius * totalRadius

	for y = -totalRadius, totalRadius do
		local ySquared = y * y

		for x = -totalRadius, totalRadius do
			local distance = x * x + ySquared

			if distance <= strokeSquared then
				local pixelColor = if distance <= radiusSquared then fill else stroke

				local rotatedX = x * cosTheta - y * sinTheta
				local rotatedY = x * sinTheta + y * cosTheta

				-- TODO: [saaawdust]: Fix holes.
				local pixelX = math.floor(centerX + rotatedX + 0.5) -- Snap to nearest pixel
				local pixelY = math.floor(centerY + rotatedY + 0.5)

				-- Bounds check and pixel writing
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					pixel(object, pixelX, pixelY, pixelColor)
				end
			end
		end
	end
end