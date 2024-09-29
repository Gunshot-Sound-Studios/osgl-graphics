--!strict
--!native
--!optimize 2

------------------------------------------------------------
-- OSGL v1.3 - Open-Source-Graphical-Library
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

local OSGL = script.Parent
local types = require(OSGL.types)
local log = require(OSGL.log)
local writePixel = require(script.writePixel)

--[=[
    @class Draw

    The draw class. Contains functions that manipulates pixels
    on an OSGL window.
]=]
local draw = {}

--[=[
    Draws a singular pixel at the given location
     ```lua
    local OSGL = require(path.to.osgl)
    local draw = OSGL.draw
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- Render here
        -- Draws a pixel at 0, 0, with a red color, onto "myWindow"
        draw.pixel(myWindow, 0, 0, color.RED)
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```
    @param window DrawableObject -- The window or texture to draw on
    @param xPos number -- The X-Position of the pixel,
    @param yPos number -- The Y-Position of the pixel
    @param color Color -- The color of the pixel
    @error "X" -- This error occurs if the X is less than 0
    @error "Y" -- This error occurs if the Y is less than 0
    @function pixel
    @within Draw
    @return nil
]=]
function draw.pixel<P>(window: types.DrawableObject<P>, xPos: number, yPos: number, color: types.Color)
	log.cassert(xPos >= 0, "X position must be higher or equal to 0")
	log.cassert(yPos >= 0, "Y position must be higher or equal to 0")

    xPos = math.round(xPos)
    yPos = math.round(yPos)

	writePixel(window.sizeX, window, xPos, yPos, color) -- Temporary
end

--[=[
    Draws a line from point A to point B
    ```lua
    local OSGL = require(path.to.osgl)
    local draw = OSGL.draw
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- Render here
        -- Draws a red line from 0,0 to 29,29
        draw.line(myWindow, {
            startX = 0,
            startY = 0,
            stopX = 29,
            stopY = 29,

            -- Thickness defaults to 1
            -- Color defaults to black
            color = color.RED
        })
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```
    @param window DrawableObject -- The window or texture to draw on
    @param line { startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: Color? } -- The data that is used to construct the line
    @function line
    @within Draw
    @return nil
]=]
draw.line = require(script.line)

--[=[
    Draws a circle with an optional stroke onto the screen
    ```lua
    local OSGL = require(path.to.osgl)
    local Draw = OSGL.draw
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- Render here
        -- Draw our circle
        myWindow:Clear(color.TRANSPARENT)
        draw.circle(myWindow, {
            centerX = 25,
            centerY = 25,
            radius = 10,
            fillColor = color.RED,

            -- Rotation defaults to 0.
            -- Strokes are completely optional
            strokeColor = color.BLACK,
            strokeThickness = 2
        })
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```
    @param window DrawableObject -- The window or texture to draw on
    @param circle {centerX: number, centerY: number, radius: number, fillColor: Color?, strokeColor: Color?, strokeThickness: number?, rotation: number?} -- The data that is used to construct the circle
    @function circle
    @within Draw
    @return nil
]=]
draw.circle = require(script.circle)

--[=[
	Draws a rectangle with an optional stroke on the screen

	```lua
	local OSGL = require(path.to.osgl)
	local draw = OSGL.draw
	local Window = OSGL.Window
	local color = OSGL.color

	-- Creates a new EditableImage
	local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

	-- Runs every heartbeat
	while myWindow:IsOpen() do
		-- Render here
		-- Draws a square (5x5) at 0, 0, with a red color, onto "myWindow"
		draw.rectangle(myWindow, {
			xPos = 0,
			yPos = 0,
			width = 5,
			height = 5,
			fillColor = color.RED,

			-- Rotation defaults to 0.
			-- Strokes are completely optional
			strokeColor = color.BLACK,
			strokeThickness = 2
		})
		-- Stop rendering here

		myWindow:Render()
	end

	print("The window has been destroyed.")
	```

	@param window DrawableObject -- The window or texture to draw on
	@param rectangle {xPos: number, yPos: number, width: number, height: number, fillColor: Color?, strokeColor: Color?, strokeThickness: number?, rotation: number?} -- The data that is used to construct the rectangle
	@function rectangle
	@within Draw
	@return nil
]=]
draw.rectangle = require(script.rectangle)

--[=[
	Draws a shape from the given points

	```lua
	local OSGL = require(path.to.osgl)
	local draw = OSGL.draw
	local Window = OSGL.Window
	local color = OSGL.color

	-- Creates a new EditableImage
	local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

	-- An array of points (x, y)
	local points = { { 0, 0 }, { 6, 0 }, { 6, 6 }, { 0, 6 }, }
	-- Runs every heartbeat
	while myWindow:IsOpen() do
		-- Render here
		-- Draws a square at 0, 0, with a red color, onto "myWindow"
		draw.points(myWindow, {
			points = points,
			color = color.RED,
			x = 0,
			y = 0,
		})
		-- Stop rendering here

		myWindow:Render()
	end

	print("The window has been destroyed.")
	```

	@param window DrawableObject -- The window or texture to draw on
	@param points { x: number, y: number, points: Points, fillColor: Color } -- The data which is used to construct the shape
	@error "X" -- This error occurs if the X is smaller than 0
	@error "Y" -- This error occurs if the Y is smaller than 0
	@error "Points" -- This error occurs if 2 or less points are provided
	@function points
	@within Draw
	@return nil
]=]
draw.points = require(script.points)

return draw
