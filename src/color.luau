------------------------------------------------------------
-- OSGL v1.3b - Open-Source-Graphical-Library
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

local bit32 = bit32

--[=[
    @class Color

    The color class. Handles manipulations of color values.
]=]
local colorModule = {}

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
function colorModule.new(r: number?, g: number?, b: number?, a: number?): types.Color
    r = r or 0
    g = g or 0
    b = b or 0
    a = a or 255

    return bit32.bor(
        bit32.lshift(a, 24),
        bit32.lshift(b, 16),
        bit32.lshift(g, 8),
        r
    )
end

--[=[
    Creates a new color value with the alpha channel being 255. Values cannot be changed
    manually and must be changed via a function.

    ```lua
    local OSGL = require(path.to.osgl)
    local color = OSGL.color

    -- All other parameters are defaulted
    -- to 0.
    local myAwesomeRedColor = color.newRGB(255)
    ```

    @within Color
    @return Color -- Returns a color Value
]=]
function colorModule.newRGB(r: number?, g: number?, b: number?): types.Color
    r = r or 0
    g = g or 0
    b =  b or 0

    return bit32.bor(
        colorModule.BLACK,
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
function colorModule.read(rgbaColor: types.Color): {  number }
	return {
        colorModule.r(rgbaColor),
        colorModule.g(rgbaColor),
        colorModule.b(rgbaColor),
        colorModule.a(rgbaColor),
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
function colorModule.r(color: types.Color): number
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
function colorModule.g(color: types.Color): number
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
function colorModule.b(color: types.Color): number
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
function colorModule.a(color: types.Color): number
    return bit32.rshift(color, 24) / 255
end

--- @prop RED Color
--- @within Color
--- A red color
colorModule.RED = colorModule.new(255)

--- @prop GREEN Color
--- @within Color
--- A green color
colorModule.GREEN = colorModule.new(0, 255)

--- @prop BLUE color
--- @within Color
--- A blue color
colorModule.BLUE = colorModule.new(0, 0, 255)

--- @prop WHITE Color
--- @within Color
--- A white color
colorModule.WHITE = colorModule.new(255, 255, 255)

--- @prop BLACK Color
--- @within Color
--- A black color
colorModule.BLACK = colorModule.new(0, 0, 0, 255)

--- @prop YELLOW Color
--- @within Color
--- A yellow color
colorModule.YELLOW = colorModule.new(255, 255)

--- @prop MAGENTA Color
--- @within Color
--- A magenta color
colorModule.MAGENTA = colorModule.new(255, 0, 255)

--- @prop CYAN Color
--- @within Color
--- A cyan color
colorModule.CYAN = colorModule.new(0, 255, 255)

--- @prop TRANSPARENT Color
--- @within Color
--- A completely transparent color
colorModule.TRANSPARENT = colorModule.new(0, 0, 0, 0)

return colorModule
