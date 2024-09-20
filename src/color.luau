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
    @class Color

    The color class. Handles manipulations of color values.
]=]
local color = {}

--[=[
    Creates a new color value. Values cannot be changed manually and must be changed
    via a function.

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted
    -- to 0, except for alpha, which is
    -- defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    ```

    @within Color
    @return Color -- Returns a color Value
]=]
function color.new(red: number?, green: number?, blue: number?, alpha: number?): types.Color
    local r = red or 0
    local g = green or 0
    local b = blue or 0
    local a = alpha or 255

    return bit32.bor(
        bit32.lshift(a, 24),
        bit32.lshift(b, 16),
        bit32.lshift(g, 8),
        r
    )
end

--[=[
    Reads the value of the color

     ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted to 0, except for alpha,
    -- which is defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    print(color.read(myAwesomeRedColor)) -- Output: { 255, 0, 0, 255 }
    ```

    @param rgbaColor Color -- The color to read
    @within Color
    @return { number }
]=]
function color.read(rgbaColor: types.Color): {  number }
	return {
        color.r(rgbaColor),
        color.g(rgbaColor),
        color.b(rgbaColor),
        color.a(rgbaColor),
    }
end

--[=[
    Reads the 'r' value of the color

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted to 0, except for alpha,
    -- which is defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    print color.r(myAwesomeRedColor)) -- Ouput:  255
    ```

    @param color Color -- The color to read
    @within Color
    @return number
]=]
function color.r(color: types.Color): number
    return bit32.band(color, 0xFF) / 255
end

--[=[
    Reads the 'g' value of the color

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted to 0, except for alpha,
    -- which is defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    print color.g(myAwesomeRedColor)) -- Ouput:  0
    ```

    @param color Color -- The color to read
    @within Color
    @return number
]=]
function color.g(color: types.Color): number
    return bit32.band(bit32.rshift(color, 8), 0xFF) / 255
end

--[=[
    Reads the 'b' value of the color

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted to 0, except for alpha,
    -- which is defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    print color.b(myAwesomeRedColor)) -- Ouput:  0
    ```

    @param color Color -- The color to read
    @within Color
    @return number
]=]
function color.b(color: types.Color): number
    return bit32.band(bit32.rshift(color, 16), 0xFF) / 255
end

--[=[
    Reads the 'a' value of the color

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted to 0, except for alpha,
    -- which is defaulted to 255.
    local myAwesomeRedColor = color.new(255)
    print(color.a(myAwesomeRedColor)) -- Ouput:  255
    ```

    @param color Color -- The color to read
    @within Color
    @return number
]=]
function color.a(color: types.Color): number
    return bit32.rshift(color, 24) / 255
end

--- @prop RED Color
--- @within Color
--- A red color
color.RED = color.new(255)

--- @prop GREEN Color
--- @within Color
--- A green color
color.GREEN = color.new(0, 255)

--- @prop BLUE color
--- @within Color
--- A blue color
color.BLUE = color.new(0, 0, 255)

--- @prop WHITE Color
--- @within Color
--- A white color
color.WHITE = color.new(255, 255, 255)

--- @prop BLACK Color
--- @within Color
--- A black color
color.BLACK = color.new()

--- @prop YELLOW Color
--- @within Color
--- A yellow color
color.YELLOW = color.new(255, 255)

--- @prop MAGENTA Color
--- @within Color
--- A magenta color
color.MAGENTA = color.new(255, 0, 255)

--- @prop CYAN Color
--- @within Color
--- A cyan color
color.CYAN = color.new(0, 255, 255)

--- @prop TRANSPARENT Color
--- @within Color
--- A completely transparent color
color.TRANSPARENT = color.new(0, 0, 0, 0)

return color
