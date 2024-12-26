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
local types = require(OSGL.types)

return function<T>(object: types.DrawableObject<T>, x: number, y: number, color: types.Color)
    -- [saaawdust]: This is the exact same as `window:WritePixel`.
    buffer.writeu32(object.buffer, (y * object.sizeX + x) * 4, color or color.BLACK)

    return -- [saaawdust]: Not quite sure what this should return.
end