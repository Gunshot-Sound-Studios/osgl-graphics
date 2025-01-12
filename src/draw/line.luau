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
local pixel = require(draw.pixel)

local types = require(OSGL.types)

return function<T>(object: types.DrawableObject<T>, startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: types.Color)
    thickness = thickness or 1
	color = color or color.BLACK

	if thickness == 0 then
		return
	end

	local sizeX, sizeY = object.sizeX, object.sizeY

	local dx = stopX - startX
	local dy = stopY - startY

	local steps = math.max(math.abs(dx), math.abs(dy))

	local xIncrement = dx / steps
	local yIncrement = dy / steps

	local x = startX
	local y = startY

	local function drawThickPoint(px: number, py: number, thickness: number)
		local halfThickness = thickness / 2
		for offsetX = -halfThickness, halfThickness do
			for offsetY = -halfThickness, halfThickness do
				local pixelX = math.floor(px + offsetX + 0.5)
				local pixelY = math.floor(py + offsetY + 0.5)
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					pixel(object, pixelX, pixelY, color)
				end
			end
		end
	end

	for _ = 0, steps do
		drawThickPoint(x, y, thickness)
		x += xIncrement
		y += yIncrement
	end
end