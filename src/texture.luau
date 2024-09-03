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

--[=[
    @class Texture

    The Texture class. Handles loading textures into memory
    for further use with sprites.
]=]
local Texture = {}

local function loadTxt(txt: types.RawTexture): types.Texture
    local finalTexture = table.create(#txt) -- remove me

    return {
        rawTexture = txt,
        width = 0,
        height = 0,
    }
end

function Texture.from(string: types.RawTexture | ModuleScript): types.Texture
    if type(string) ~= "string" and string:IsA("ModuleScript") then
        string = require(string) -- Assuming it's an array
    end

    return loadTxt(string)
end

return Texture