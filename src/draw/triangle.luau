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

local OSGL = script.Parent.Parent
local draw = OSGL.draw
local types = require(OSGL.types)
local color = require(OSGL.color)
local fillPolygon = require(draw.fillPolygon)

return function<T>(object: types.DrawableObject<T>, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, fill: types.Color?, stroke: types.Color?, strokeThickness: number?)
    fill = fill or color.BLACK
    stroke = stroke or color.TRANSPARENT
    strokeThickness = strokeThickness or 0

    -- [saaawdust]: Somehow this is faster than
    --              an optimised triangle rasterizer.
    --              Use this implementation until something
    --              faster is found.
    fillPolygon(object, {
        { x1, y1 },
        { x2, y2 },
        { x3, y3 },
    }, fill, stroke, strokeThickness)
end
