--!optimize 2
--!native

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
local line = require(draw.line)
local mode = require(draw.mode)

return function<T>(object: types.DrawableObject<T>, corners: { { number } }, fill: types.Color, strokeColor: types.Color?, strokeWidth: number?)
	-- [saaawdust]: These are temporary, cause
	-- if I calculate it, it takes up
	-- like 10FPS

    local pixel = mode.drawPixel

    fill = fill or color.BLACK
    strokeColor = strokeColor or color.TRANSPARENT
    strokeWidth = strokeWidth or 1

	local sizeX = object.sizeX
	local maxY = object.sizeY

    if strokeColor ~= color.TRANSPARENT and strokeWidth > 0 then
        for i = 1, #corners do
            local p1 = corners[i]
            local p2 = corners[i % #corners + 1]

            line(
                object,
                math.floor(p1[1]),
                math.floor(p1[2]),
                math.floor(p2[1]),
                math.floor(p2[2]),
                strokeWidth,
                strokeColor
            )
        end
    end

    for y = 0, maxY do
        local intersections = {}

        for i = 1, #corners do
            local p1 = corners[i]
            local p2 = corners[i % #corners + 1]

            if (p1[2] <= y and p2[2] > y) or (p2[2] <= y and p1[2] > y) then
                local t = (y - p1[2]) / (p2[2] - p1[2])
                local intersectX = p1[1] + t * (p2[1] - p1[1])
                table.insert(intersections, intersectX)
            end
        end

        table.sort(intersections)

        for i = 1, #intersections - 1, 2 do
            local startX = math.max(0, math.floor(intersections[i]))
            local endX = math.min(sizeX - 1, math.ceil(intersections[i + 1]))

			for x = startX, endX do
				if x > sizeX then continue end
                pixel(object, x, y, fill)
            end
        end
    end
end
