--!strict
--!native
--!optimize 2

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

local UserInputService = game:GetService("UserInputService")

local OSGL = script.Parent
local types = require(OSGL.types)
local privateTypes = require(script.types)
local log = require(OSGL.log)
local colorM = require(OSGL.color)
local config = require(OSGL.config)
local pixelStorage
do
    if config.useBufferPixelStorage then
        pixelStorage = require(script.buffer)
    else
        pixelStorage = require(script.default)
    end
end

--[=[
    @class Window

    The window class. Handles creations of OSGL-Windows.
    An OSGL window is the representation of the EditableImage
    instance.
]=]
local Window = {}
local WindowPrivate = {}
WindowPrivate.__index = WindowPrivate

type Window<P> = types.Window<P> & {
    renderer: EditableImage,
    pixelStorage: privateTypes.PixelStorage<any>,
    sizeX: number,
    sizeY: number,
    size: Vector2,
}

--[=[
    Creates an OSGL window by creating a new EditableImage instance at the given place.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @param parent Instance -- The instance the EditableImage will be parented to
    @param config WindowConfiguration? -- Optional configurations
    @return Window -- Returns an OSGL window instance
]=]
function Window.new<P>(parent: Instance, config: types.WindowConfiguration?): Window<P>
	log.typeCheckArgument("Window.new", "parent", parent, "Instance")

	config = config or {}
	config.sizeX = math.clamp(config.sizeX or 1, 1, 1024)
	config.sizeY = math.clamp(config.sizeY or 1, 1, 1024)

    local editableImage = Instance.new("EditableImage")
	editableImage.Size = Vector2.new(config.sizeX, config.sizeY)
	editableImage.Parent = parent

	return Window.from(editableImage)
end

--[=[
    Creates an OSGL window from an existing EditableImage.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a window from an existing EditableImage
    local myWindow = Window.from(path.to.editableImage, { size = Vector2.new(50, 50) })
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @param editableImage EditableImage -- The existing EditableImage
    @return Window -- Returns an OSGL window instance
]=]
function Window.from<P>(editableImage: EditableImage): Window<P>
	log.typeCheckArgument("Window.from", "editableImage", editableImage, "EditableImage")

	local self = setmetatable({
		renderer = editableImage,
		pixelStorage = pixelStorage.new(editableImage.Size.X, editableImage.Size.Y),
		sizeX = editableImage.Size.X,
		sizeY = editableImage.Size.Y,
		size = editableImage.Size,
	}, WindowPrivate)

	return self
end

--[=[
    Returns if the OSGL Window still exists. Useful for game-loops. Automatically yields
    for a heartbeat, or the given time.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        print("Window exists!")
    end

    print("The window has been destroyed.")
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @param yield number? -- The amount of time to yield. Defaults to a heartbeat.
]=]
function WindowPrivate.IsOpen<P>(self: Window<P>, yield: number?): boolean
	if yield and type(yield) ~= "number" then
		log.typeCheckArgument("Window:IsOpen", "yield", yield, "number")
	end

	task.wait(yield)
	return self.renderer ~= nil
end

--[=[
    Renders `Window.pixels` to the EditableImage

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- *rendering magic*

        myWindow:Render()
    end
    ```

    @within Window
]=]
function WindowPrivate.Render<P>(self: Window<P>)
	self.pixelStorage:Render(self.renderer, self.size)
end

--[=[
    Clears the double-buffer with the given color or a transparent color

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        myWindow:Clear(color.GREEN)
        myWindow:Render()
    end
    ```

    @param clearColor Color? -- The color the screen will be cleared with
    @within Window
]=]
function WindowPrivate.Clear<P>(self: Window<P>, clearColor: types.Color?)
    self.pixelStorage:Clear(clearColor or colorM.TRANSPARENT)
end

--[=[
    Resizes the window and its pixel buffer. This function may be resource intensive and
    is not made for constant use. May require a re-render, depending on the new size.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    myWindow:Resize(100) -- Changes width to 100

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- *rendering magic*

        myWindow:Render()
    end
    ```

    @param newWidth number? -- The new width of the window
    @param newHeight number? -- The new height of the window
    @error "Height" -- This error occurs if the height is smaller than 0
    @error "Width" -- This error occurs if the width is smaller than 0
    @within Window
]=]
function WindowPrivate.Resize<P>(self: Window<P>, newWidth: number?, newHeight: number?)
	newWidth = newWidth or self.size.X
	newHeight = newHeight or self.size.Y

    log.cassert(newHeight > 0, "Height passed to `Window:Resize()` must be larger than 0.")
    log.cassert(newWidth > 0, "Width passed to `Window:Resize()` must be larger than 0.")

	self.pixelStorage:Resize(self.sizeX, self.sizeY, newWidth, newHeight)

	self.size = Vector2.new(newWidth, newHeight)
	self.sizeX = newWidth
	self.sizeY = newHeight

	self.renderer.Size = self.size
end

--[=[
    Returns whether or not the mouse is inside the window and the mouse's position
    relative to the window.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    print(myWindow:GetRelativeMouse()) -- Example output: true, 25, 25
    ```

    @within Window
    @return (boolean, number, number) -- Whether or not the mouse is in the window, it's X and Y positions.
]=]
function WindowPrivate.GetRelativeMouse<P>(self: Window<P>): (boolean, number, number)
    local sizeFactor = self.size / self.renderer.Parent.AbsoluteSize
    local mousePosition = UserInputService:GetMouseLocation() - self.renderer.Parent.AbsolutePosition

    local relativeMousePosition = mousePosition * sizeFactor
    local isInWindow = relativeMousePosition.X > 0 and relativeMousePosition.Y > 0

    return isInWindow, math.round(relativeMousePosition.X), math.round(relativeMousePosition.Y)
end

--[=[
    Reads a pixel from the canvas.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    print(myWindow:ReadPixel(1, 1)) -- Example output: 0
    ```

    @within Window
    @return Color -- The color of the pixel
]=]
function WindowPrivate.ReadPixel<P>(self: Window<P>, x: number, y: number): types.Color
    self.pixelStorage:ReadPixel(x, y, self.sizeX)
end

--[=[
    Writes a pixel to the canvas.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local color = OSGL.color

    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    myWindow:WritePixel(1, 1, color.RED)
    ```

    @within Window
    @return Color -- The color of the pixel
]=]
function WindowPrivate.WritePixel<P>(self: Window<P>, x: number, y: number, newColor: types.Color)
    self.pixelStorage:WritePixel(x, y, self.sizeX, newColor)
end

return Window
