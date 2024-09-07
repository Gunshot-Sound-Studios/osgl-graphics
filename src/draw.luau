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
local color = require(script.Parent.color)
local log = require(script.Parent.log)

--[=[
    @class Draw

    The draw class. Contains functions that manipulates pixels
    on an OSGL window.
]=]
local draw = {}

local function writePixel(SIZE_X: number, window: types.Window, x: number, y: number, color: types.Color)
	window.pixels[(y * SIZE_X + x) + 1] = color
end

local function fillPolygon(corners: { { number } }, window: types.Window, fillColor: types.Color)
	-- These are temporary, cause 
	-- if i calculate it, it takes up
	-- like 10FPS

	local sizeX = window.sizeX
	local maxY = window.sizeY

    for y = 0, maxY do
        local intersections = {}

        for i = 1, #corners do
            local p1 = corners[i]
            local p2 = corners[i % #corners + 1]

            if (p1[2] <= y and p2[2] > y) or (p2[2] <= y and p1[2] > y) then
                local t = (y - p1[2]) / (p2[2] - p1[2])
                local intersectX = p1[1] + t * (p2[1] - p1[1])
                table.insert(intersections, intersectX)
            end
        end

        table.sort(intersections)

        for i = 1, #intersections - 1, 2 do
            local startX = math.max(0, math.floor(intersections[i]))
            local endX = math.min(sizeX - 1, math.ceil(intersections[i + 1]))

            for x = startX, endX do
                writePixel(sizeX, window, x, y, fillColor)
            end
        end
    end
end

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
        draw.pixel(myWindow, 0, 0, color.red)
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```
    @param window Window -- The window to draw on
    @param xPos number -- The X-Position of the window
    @param yPos number -- The Y-Position of the window
    @param color Color -- The color of the pixel
	@error "X" -- This error occurs if the X is less than 0
    @error "Y" -- This error occurs if the Y is less than 0
    @within Draw
    @return nil
]=]
function draw.pixel(window: types.Window, xPos: number, yPos: number, color: types.Color)
	log.cassert(xPos >= 0, "X position must be higher or equal to 0")
	log.cassert(yPos >= 0, "Y position must be higher or equal to 0")

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
    @param line { startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: Color? } -- The data that is used to construct the line
    @within Draw
    @return nil
]=]
function draw.line(
	window: types.Window,
	line: {
		startX: number,
		startY: number,
		stopX: number,
		stopY: number,
		thickness: number?,
		color: types.Color?,
	}
)
	line.thickness = line.thickness or 1
	line.color = line.color or color.BLACK

	local sizeX, sizeY = window.sizeX, window.sizeY

	local dx = line.stopX - line.startX
	local dy = line.stopY - line.startY

	local steps = math.max(math.abs(dx), math.abs(dy))

	local xIncrement = dx / steps
	local yIncrement = dy / steps

	local x = line.startX
	local y = line.startY

	local function drawThickPoint(px: number, py: number, thickness: number)
		local halfThickness = thickness / 2
		for offsetX = -halfThickness, halfThickness do
			for offsetY = -halfThickness, halfThickness do
				local pixelX = math.floor(px + offsetX + 0.5)
				local pixelY = math.floor(py + offsetY + 0.5)
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					writePixel(sizeX, window, pixelX, pixelY, line.color)
				end
			end
		end
	end

	for _ = 0, steps do
		drawThickPoint(x, y, line.thickness)
		x += xIncrement
		y += yIncrement
	end
end

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
    @param circle {centerX: number, centerY: number, radius: number, fillColor: Color?, strokeColor: Color?, strokeThickness: number?, rotation: number?} -- The data that is used to construct the circle
    @within Draw
    @return nil
]=]
function draw.circle(
	window: types.Window,
	circle: {
		centerX: number,
		centerY: number,
		radius: number,
		fillColor: types.Color?,
		strokeColor: types.Color?,
		strokeThickness: number?,
		rotation: number?,
	}
)
	circle.fillColor = circle.fillColor or color.BLACK
	circle.rotation = circle.rotation or 0
	circle.strokeColor = circle.strokeColor or color.TRANSPARENT
	circle.strokeThickness = circle.strokeThickness or 0

	local radius = circle.radius
	local strokeThickness = if circle.strokeColor ~= color.TRANSPARENT then circle.strokeThickness else 0

	local sizeX, sizeY = window.sizeX, window.sizeY
	local radians = circle.rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local radiusSquared = radius * radius
	local totalRadius = strokeThickness + radius
	local strokeSquared = totalRadius * totalRadius

	for y = -totalRadius, totalRadius do
		local ySquared = y * y

		for x = -totalRadius, totalRadius do
			local distance = x * x + ySquared

			if distance <= strokeSquared then
				local pixelColor = if distance <= radiusSquared then circle.fillColor else circle.strokeColor

				local rotatedX = x * cosTheta - y * sinTheta
				local rotatedY = x * sinTheta + y * cosTheta

				local pixelX = math.floor(circle.centerX + rotatedX + 0.5) -- Snap to nearest pixel
				local pixelY = math.floor(circle.centerY + rotatedY + 0.5)

				-- Bounds check and pixel writing
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					writePixel(sizeX, window, pixelX, pixelY, pixelColor)
				end
			end
		end
	end
end

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
	@param window Window -- The window to draw on
	@param rectangle {xPos: number, yPos: number, width: number, height: number, fillColor: Color?, strokeColor: Color?, strokeThickness: number?, rotation: number?} -- The data that is used to construct the rectangle
	@within Draw
	@return nil
]=]
function draw.rectangle(
	window: types.Window,
	rectangle: {
		xPos: number,
		yPos: number,
		width: number,
		height: number,
		fillColor: types.Color?,
		strokeColor: types.Color?,
		strokeThickness: number?,
		rotation: number?,
	}
)
	rectangle.fillColor = rectangle.fillColor or color.TRANSPARENT
	rectangle.rotation = rectangle.rotation or 0
	rectangle.strokeColor = rectangle.strokeColor or color.TRANSPARENT
	rectangle.strokeThickness = rectangle.strokeThickness or 0

	local strokeLength = if rectangle.strokeColor ~= color.TRANSPARENT then rectangle.strokeThickness else 0

	local sizeX, sizeY = window.sizeX, window.sizeY

	local centerX = rectangle.xPos + rectangle.width / 2
	local centerY = rectangle.yPos + rectangle.height / 2

	if rectangle.rotation % 90 == 0 then
		local width, height

		if rectangle.rotation % 180 == 0 then
			width, height = rectangle.width, rectangle.height
		else
			width, height = rectangle.height, rectangle.width
		end

		width += strokeLength
		height += strokeLength

		for x = 1, width do
			x += rectangle.xPos
			if x >= sizeX then
				break
			end

			for y = 1, height do
				y += rectangle.yPos
				if y >= sizeY then
					break
				end

				local pixelColor = if x > width or y > height then rectangle.strokeColor else rectangle.fillColor

				writePixel(sizeX, window, x, y, pixelColor)
			end
		end

		return
	end

	local radians = rectangle.rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local function rotatePoint(x, y)
		local relativeX = x - centerX
		local relativeY = y - centerY
		local rotatedX = relativeX * cosTheta - relativeY * sinTheta
		local rotatedY = relativeX * sinTheta + relativeY * cosTheta
		return centerX + rotatedX, centerY + rotatedY
	end

	local x0, y0 = rotatePoint(rectangle.xPos, rectangle.yPos)
	local x1, y1 = rotatePoint(rectangle.xPos + rectangle.width, rectangle.yPos)
	local x2, y2 = rotatePoint(rectangle.xPos + rectangle.width, rectangle.yPos + rectangle.height)
	local x3, y3 = rotatePoint(rectangle.xPos, rectangle.yPos + rectangle.height)

	fillPolygon({
		{ x0, y0 },
		{ x1, y1 },
		{ x2, y2 },
		{ x3, y3 },
	}, window, rectangle.fillColor)
end

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
	@param window Window -- The window to draw on
	@param points { x: number, y: number, points: Points, fillColor: Color } -- The data which is used to construct the shape
	@error "X" -- This error occurs if the X is smaller than 0
    @error "Y" -- This error occurs if the Y is smaller than 0
	@error "Points" -- This error occurs if 2 or less points are provided
	@within Draw
	@return nil
]=]
function draw.points(
	window: types.Window,
	points: { x: number, y: number, points: types.Points, fillColor: types.Color }
)

	log.cassert(points.x >= 0, "X position must be higher or equal to 0")
	log.cassert(points.y >= 0, "Y position must be higher or equal to 0")
	log.cassert(#points.points >= 3, "Shapes must have atleast 3 points")

	points.fillColor = points.fillColor or color.RED
	points.points = points.points or {}

	fillPolygon(points.points, window, points.fillColor)
end

return draw
