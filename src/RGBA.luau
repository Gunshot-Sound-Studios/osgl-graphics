------------------------------------------------------------
-- OSGL v1.1 - Open-Source-Graphical-Library
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

    The color class. Handles manipulations of
    RGBA color values.
]=]
local RGBA = {}

function RGBA.add(color1: types.RGBA, color2: types.RGBA)
    return RGBA.new(
        math.clamp(color1.R + color2.R, 0, 255),
        math.clamp(color1.G + color2.G, 0, 255),
        math.clamp(color1.B + color2.B, 0, 255),
        math.clamp(color1.A + color2.A, 0, 255)
    )
end

function RGBA.subtract(color1: types.RGBA, color2: types.RGBA)
    return RGBA.new(
        math.clamp(color1.R + color2.R, 0, 255),
        math.clamp(color1.G + color2.G, 0, 255),
        math.clamp(color1.B + color2.B, 0, 255),
        math.clamp(color1.A + color2.A, 0, 255)
    )
end

function RGBA.multiply(color1: types.RGBA, color2: types.RGBA)
    local r = math.clamp((color1.R / 255) * (color2.R / 255) * 255, 0, 255)
    local g = math.clamp((color1.G / 255) * (color2.G / 255) * 255, 0, 255)
    local b = math.clamp((color1.B / 255) * (color2.B / 255) * 255, 0, 255)
    local a = math.clamp((color1.A / 255) * (color2.A / 255) * 255, 0, 255)

    return RGBA.new(r, g, b, a)
end

function RGBA.divide(color1: types.RGBA, color2: types.RGBA)
    local r = (color2.R == 0 and 255 or math.clamp((color1.R / 255) / (color2.R / 255) * 255, 0, 255))
    local g = (color2.G == 0 and 255 or math.clamp((color1.G / 255) / (color2.G / 255) * 255, 0, 255))
    local b = (color2.B == 0 and 255 or math.clamp((color1.B / 255) / (color2.B / 255) * 255, 0, 255))
    local a = (color2.A == 0 and 255 or math.clamp((color1.A / 255) / (color2.A / 255) * 255, 0, 255))
    
    return RGBA.new(r, g, b, a)
end

--[=[
    Creates a new RGBA value. Values cannot be changed manually and must be changed
    via a function.

     ```lua
    local OSGL = require(path.to.osgl)
    local RGBA = OSGL.Color

    --// All other parameters are defaulted
    --// to 0, except for alpha, which is
    --// defaulted to 255.
    local myAwesomeRedColor = RGBA.new(255)
    ```

    @within Color
    @return Color -- Returns a RGBA Value
]=]
function RGBA.new(red: number?, green: number?, blue: number?, alpha: number?): types.RGBA
    local r = red or 0
    local g = green or 0
    local b = blue or 0
    local a = alpha or 255 
    
    local n = bit32.bor(
        bit32.lshift(r, 24),
        bit32.lshift(g, 16),
        bit32.lshift(b, 8),
        a
    )

    return n
end

--[=[
    Sets the value of the RGBA and modifies the buffer

     ```lua
    local OSGL = require(path.to.osgl)
    local RGBA = OSGL.Color

    --// All other parameters are defaulted
    --// to 0, except for alpha, which is
    --// defaulted to 255.
    local myAwesomeRedColor = RGBA.new(255)
    myAwesomeRedColor:Set(0, 255) --// Color is now green
    ```

    @within Color
    @return nil
]=]
function RGBA:Set(red: number?, green: number?, blue: number?, alpha: number?)
    updateBuffer(self.buffer, red or self.R, green or self.G, blue or self.B, alpha or self.A)

    return
end

--[=[
    Reads the value of the RGBA

     ```lua
    local OSGL = require(path.to.osgl)
    local RGBA = OSGL.Color

    --// All other parameters are defaulted
    --// to 0, except for alpha, which is
    --// defaulted to 255.
    local myAwesomeRedColor = RGBA.new(255)
    print(myAwesomeRedColor:Read()) --// Ouput:  { 255, 0, 0, 255 }
    ```

    @within Color
    @return { R: number, G: number, B: number, A: number }
]=]
function RGBA:Read(): { R: number, G: number, B: number, A: number }
	return {
        buffer.readu8(self.buffer, 0),
        buffer.readu8(self.buffer, 1),
        buffer.readu8(self.buffer, 2),
        buffer.readu8(self.buffer, 3),
    }
end

--[=[
    Returns the RGBA color as a Color3, with the alpha
     ```lua
    local OSGL = require(path.to.osgl)
    local RGBA = OSGL.Color

    --// All other parameters are defaulted
    --// to 0, except for alpha, which is
    --// defaulted to 255.
    local myAwesomeRedColor = RGBA.new(255)
    local color, alpha = myAwesomeRedColor:ToColor3()

    print(color, alpha) --// Output: 1, 0, 0 1
    ```

    @within Color
    @return (Color3, number) -- Returns a Color3 and alpha
]=]
function RGBAPrivate:ToColor3(): (Color3, number)
	return Color3.fromRGB(buffer.readu8(self.buffer, 0), buffer.readu8(self.buffer, 1), buffer.readu8(self.buffer, 2)), buffer.readu8(self.buffer, 3) / 255
end

--[=[
    Returns the RGBA as a hex-string, with the alpha
     ```lua
    local OSGL = require(path.to.osgl)
    local RGBA = OSGL.Color

    --// All other parameters are defaulted
    --// to 0, except for alpha, which is
    --// defaulted to 255.
    local myAwesomeRedColor = RGBA.new(255)
    local color, alpha = myAwesomeRedColor:ToHex()

    print(color, alpha) --// Output: FF0000 1
    ```

    @within Color
    @return (string, number) -- Returns a string and an alpha
]=]
function RGBAPrivate:ToHex(): (string, number)
    local color, alpha = self:ToColor3()
    return color:ToHex(), alpha
end

RGBA.red = RGBA.new(255)
RGBA.green = RGBA.new(0, 255)
RGBA.blue = RGBA.new(0, 0, 255)
RGBA.white = RGBA.new(255, 255, 255)
RGBA.black = RGBA.new()
RGBA.yellow = RGBA.new(255, 255)
RGBA.magenta = RGBA.new(255, 255)
RGBA.cyan = RGBA.new(0, 255, 255)
RGBA.transparent = RGBA.new(0, 0, 0, 255)

return RGBA