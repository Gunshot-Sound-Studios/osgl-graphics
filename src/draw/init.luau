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

-- [saaawdust]: NOTE: I'm not implementing typechecking for any of
--              these functions. These functions could be called every
--              frame and even though it's a minor slow-down, it still
--              could make the function slower in the long-run since
--              we're calling it constantly.
--              The user should give the correct values.

-- [saaawdust]: Require shapes here. I don't know if `require`
--              caches (I think it does), but just incase it doesn't,
--              this will help optimise.
--
--              If it does, we can change this to
--              `draw.pixel = require(script.pixel)` safely
local pixel = require(script.pixel)
local line = require(script.line)
local rectangle = require(script.rectangle)
local circle = require(script.circle)
local triangle = require(script.triangle)
local polygon = require(script.fillPolygon)
local floodFill = require(script.floodFill)

--[=[
    @class Draw

    The draw class. Contains functions for drawing various
    shapes on a [DrawableObject]
]=]
local draw = {}

--[=[
Draws a singular pixel onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a red pixel at 0, 0
draw.pixel(myWindow, 0, 0, color.RED)
```

@function pixel
@param object DrawableObject
@param X number
@param Y number
@param color Color
@within Draw
]=]
draw.pixel = pixel

--[=[
Draws a line onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a red line from 5, 5 to 10, 10 with a thickness of 2
draw.line(myWindow, 5, 5, 10, 10, 2, color.RED)
```

@function line
@param object DrawableObject
@param startX number
@param startY number
@param endX number
@param endY number
@param thickness number
@param color Color
@within Draw
]=]
draw.line = line

--[=[
Draws a rectangle onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a 5x5 red square at 0, 0 
draw.rectangle(myWindow, 0, 0, 5, 5, color.RED)
```

@function rectangle
@param object DrawableObject
@param xPos number
@param yPos number
@param width number
@param height number
@param fill Color?
@param stroke Color?
@param strokeThickness number?
@param rotation number?
@within Draw
]=]
draw.rectangle = rectangle

--[=[
Draws a circle onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a red circle with a radius of 10 at 26, 26
draw.circle(myWindow, 26, 26, 10, color.RED)
```

@function circle
@param object DrawableObject
@param centerX number
@param centerY number
@param radius number
@param fill Color?
@param stroke Color?
@param strokeThickness number?
@param rotation number? -- This can only be viewed at low resolutions
@within Draw
]=]
draw.circle = circle

--[=[
Draws a triangle onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a red triangle with the given points
draw.triangle(myWindow, 0, 0, 5, 5, 10, 0, color.RED)
```

@function triangle
@param object DrawableObject
@param x1 number
@param y1 number
@param x2 number
@param y2 number
@param x3 number
@param y3 number
@param fill Color?
@param stroke Color?
@param strokeThickness number?
@within Draw
]=]
draw.triangle = triangle

--[=[
Draws a polygon onto the [DrawableObject]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Draws a red polygon with the given points
draw.polygon(myWindow, {
    -- Points for a triangle
    { 0, 0 },
    { 5, 5 },
    { 10,0 },
}, color.RED)
```

@function polygon
@param object DrawableObject
@param points {{number}}
@param fill Color?
@within Draw
]=]
draw.polygon = polygon

--[=[
Replaces all adjacent pixels of the same color with a replacement

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
-- *draw something*

-- Start flood-filling from (5, 5)
myWindow:Draw():FloodFill(5, 5, color.RED)
```

@function floodFill
@param x number
@param y number
@param fill Color
@within Draw
]=]
draw.floodFill = floodFill

return draw
