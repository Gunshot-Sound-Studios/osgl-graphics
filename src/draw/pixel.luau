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
local types = require(OSGL.types)
local enum = require(OSGL.enum)
local colorLib = require(OSGL.color)
local util = require(OSGL.utils)

local alphaBlendMode = enum.AlphaBlendMode

lerp = util.lerp

return function<T>(object: types.DrawableObject<T>, x: number, y: number, color: types.Color)
    -- [saaawdust]: This is the exact same as `window:WritePixel`.
    
    color = color or colorLib.BLACK

    local alpha = colorLib.a(color)
    local index = (y * object.sizeX + x) * 4
    if alpha == 255 or object.alphaBlendingMode == alphaBlendMode.Overwrite then
        buffer.writeu32(object.buffer, index, color)
    elseif object.alphaBlendingMode == alphaBlendMode.Additive then
        local alpha = colorLib.a(color)
        if alpha == 0 or alpha == 255 then
            return
        end

        alpha /= 255

        local col = buffer.readu32(object.buffer, index)
        local OR, OG, OB = colorLib.r(color), colorLib.g(color), colorLib.b(color)
        local R, G, B = colorLib.r(col), colorLib.g(col), colorLib.b(col)
        local newColor = colorLib.newRGB(
            lerp(R, OR, alpha),
            lerp(G, OG, alpha),
            lerp(B, OB, alpha)
        )  

        -- [saaawdust]: We repeat the code from the if branch above here. It might be worth
        --              Having a single if-statement that checks for the alpha blending mode,
        --              moving the buffer.writeu32 call outside of the if-else block.
        buffer.writeu32(object.buffer, index, newColor)
    end
end