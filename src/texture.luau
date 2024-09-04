------------------------------------------------------------
-- OSGL v1.2b - Open-Source-Graphical-Library
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

local types = require(script.Parent.types)
local colorm = require(script.Parent.color)

--[=[
    @class Texture

    The Texture class. Handles loading textures into memory
    for further use with sprites.
]=]
local Texture = {}

local function loadTxt(txt: types.FlagTexture): types.Texture
    local finalTable = table.create(txt.width * txt.height, 0) -- isn't the accurate amount, but still more performant!
    local i = 1
    for _, v in ipairs(txt.pixels) do
        if type(v) == "number" then
            finalTable[i] = v
            i += 1
        else
            -- This is a flag. For now, there's only an `r` flag.
            local repetitions, color = string.match(v, "(%d+)-(%d+)")
            for _ = 1, repetitions do
                finalTable[i] = color
                i += 1
            end
        end
    end

    return {
        rawTexture = finalTable,
        width = txt.width,
        height = txt.height,
    }
end

function Texture.from(textureData: types.FlagTexture | ModuleScript): types.Texture
	if type(textureData) ~= "string" and textureData:IsA("ModuleScript") then
		textureData = require(textureData) -- Assuming it's an array
	end

	return loadTxt(textureData)
end

return Texture
