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

function getIndex(x, y, sizeX)
    return (y * sizeX + x) * 4
end

function offsetIndex(i, x, y, sizeX)
    return i + (y * sizeX + x) * 4
end

return function<T>(object: types.DrawableObject<T>, x: number, y: number, color: types.Color)
	x = x or 0
	y = y or 0

	local sizeX, sizeY = object.sizeX, object.sizeY
	local originalColor = object:ReadPixel(x, y)

	-- Creates more than enough memory, better optimization.
	local checked = table.create(sizeX * sizeY, false)
	local stack = table.create(sizeX * sizeY, 0)
	stack[1] = getIndex(x, y, sizeX)
   
	local MAX_INDEX = getIndex(sizeX - 1, sizeY - 1, sizeX)
    local bfr = object.buffer
	while #stack > 0 do
		local currentIndex = stack[#stack]
		stack[#stack] = nil

		if checked[currentIndex] or currentIndex < 0 or currentIndex > MAX_INDEX then
			continue
		end
		checked[currentIndex] = true
        
		if buffer.readu32(bfr, currentIndex) ~= originalColor then
			continue
		end

        buffer.writeu32(bfr, currentIndex, color)

		stack[#stack + 1] = offsetIndex(currentIndex, 1, 0, sizeX)
		stack[#stack + 1] = offsetIndex(currentIndex, -1, 0, sizeX)
		stack[#stack + 1] = offsetIndex(currentIndex, 0, 1, sizeX)
		stack[#stack + 1] = offsetIndex(currentIndex, 0, -1, sizeX)
	end
end
