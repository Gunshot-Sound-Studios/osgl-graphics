--!strict
--!native
--!optimize 2

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
local log = require(script.Parent.log)
local colorM = require(script.Parent.color)

--[=[
    @class Window

    The window class. Handles creations of OSGL-Windows.
    An OSGL window is the representation of the EditableImage
    instance.
]=]
local Window = {}
local WindowPrivate = {}
WindowPrivate.__index = WindowPrivate

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
function Window.from(editableImage: EditableImage): types.Window
	log.typeCheckArgument("Window.from", "editableImage", editableImage, "EditableImage")

	local self = {
		renderer = editableImage,
		pixels = table.create(editableImage.Size.X * editableImage.Size.Y, 0),
		sizeX = editableImage.Size.X,
		sizeY = editableImage.Size.Y,
		size = editableImage.Size,
	}

	return setmetatable(self, WindowPrivate)
end

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
function Window.new(parent: Instance, config: types.WindowConfiguration?): types.Window
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
function WindowPrivate:IsOpen(yield: number?): boolean
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
function WindowPrivate:Render()
    if not self._didUpdate then
        self._didUpdate = false

        return
    end

	local final = table.create(#self.pixels, 0) :: { number }
	local n = math.round(#final / 2)

	for i, color in ipairs(self.pixels) do
		if i % n == 0 then
			task.wait()
		end

		local i = (i - 1) * 4
		final[i + 1] = bit32.rshift(color, 24) / 255
		final[i + 2] = bit32.band(bit32.rshift(color, 16), 0xFF) / 255
		final[i + 3] = bit32.band(bit32.rshift(color, 8), 0xFF) / 255
		final[i + 4] = bit32.band(color, 0xFF) / 255
	end

	(self.renderer :: EditableImage):WritePixels(Vector2.zero, self.size, final)
    self._didUpdate = false
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
function WindowPrivate:Clear(clearColor: types.Color?)
    self.pixels = table.create(self.sizeX * self.sizeY, clearColor or colorM.TRANSPARENT)
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
    @within Window
]=]
function WindowPrivate:Resize(newWidth: number?, newHeight: number?)
	newWidth = newWidth or self.size.X
	newHeight = newHeight or self.size.Y

    assert(newHeight > 0, "Height passed to `Window:Resize()` must be larger than 0.")
    assert(newWidth > 0, "Width passed to `Window:Resize()` must be larger than 0.")

	local resizedPixels = table.create(newWidth * newHeight, 0)
	local oldWidth = self.sizeX
	local oldHeight = self.sizeY

	for y = 0, newHeight - 1 do
        if y > oldHeight then
            break
        end

		for x = 0, newWidth - 1 do
			if x > oldWidth then
                break
			end

            local oldIndex = (y * oldWidth) + x + 1
            local newIndex = (y * newWidth) + x + 1

            resizedPixels[newIndex] = self.pixels[oldIndex]
		end
	end

	self.pixels = resizedPixels
	self.size = Vector2.new(newWidth, newHeight)
	self.sizeX = newWidth
	self.sizeY = newHeight

	self.renderer.Size = self.size
end

return Window
