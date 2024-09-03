--!strict
--!native
--!optimize 2

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
    @class Draw

    The draw class. Contains functions that manipulates pixels
    on an OSGL window.
]=]
local draw = {}

local function writePixel(SIZE_X: number, pixels: {buffer}, x: number, y: number, color: types.Color)
    pixels[(y * SIZE_X + x) + 1] = color
end

--[=[
    Draws a singular pixel at the given location
     ```lua
    local OSGL = require(path.to.osgl)
    local Draw = OSGL.draw
    local Window = OSGL.Window
    local color = OSGL.color

    --// Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- Render here
        -- Draws a pixel at 0, 0, with a red color, onto "myWindow"
        Draw.pixel(myWindow, 0, 0, color.red)
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```
    @param window Window -- The window to draw on
    @param xPos number -- The X-Position of the window
    @param yPos number -- The Y-Position of the window
    @param color Color -- The color of the pixel
    @within Draw
    @return nil
]=]
function draw.pixel(window: types.Window, xPos: number, yPos: number, color: types.Color)
    xPos = math.clamp(xPos or 0, 0, 1023)
    yPos = math.clamp(yPos or 0, 0, 1023)

    writePixel(window.sizeX, window.pixels, xPos, yPos, color) -- Temporary
end

return draw