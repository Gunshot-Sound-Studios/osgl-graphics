------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
-- Copyright © 2023-2025 OSGL (@saaawdust)
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
local mode = require(draw.mode)

return function<T>(object: types.DrawableObject<T>, bfr: buffer, sizeX: number, sizeY: number, x: number, y: number)
    local pixel = mode.drawPixel
    
    local winX = object.sizeX
    local winY = object.sizeY

    for i = 0, sizeX - 1 do
        local pixelX = x + i
        for j = 0, sizeY - 1 do
            local pixelY = y + j

            if pixelX >= 0 and pixelX < winX and pixelY >= 0 and pixelY < winY then
                local col = buffer.readu32(bfr, (y * sizeX + x) * 4)
                pixel(object, pixelX, pixelY, col)
            end
        end
    end
end
