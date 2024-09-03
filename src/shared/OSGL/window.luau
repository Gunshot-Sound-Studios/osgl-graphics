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
local log = require(script.Parent.log)

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
    local Window = OSGL.window
    ​
    --// Creates a window from an existing EditableImage
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

    --for i, v in ipairs(self.pixels) do
    --    -- Allocate some memory
    --    self.pixels[i] = buffer.create(4) -- 4 bytes for colours
    --end

	return setmetatable(self, WindowPrivate)
end

--[=[
    Creates an OSGL window by creating a new EditableImage instance at the given place.
     ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.window
    ​
    --// Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @param instance Instance -- The instance the EditableImage will be parented to
    @param config WindowConfiguration -- Optional configurations
    @return Window -- Returns an OSGL window instance
]=]
function Window.new(instance: Instance, config: types.WindowConfiguration?): types.Window
	log.typeCheckArgument("Window.new", "instance", instance, "Instance")

	local editableImage = Instance.new("EditableImage")
	editableImage.Parent = instance

	config = config or {}
	config.sizeX = math.clamp(config.sizeX or 1, 1, 1024)
	config.sizeY = math.clamp(config.sizeY or 1, 1, 1024)

	editableImage.Size = Vector2.new(config.sizeX, config.sizeY)

	return Window.from(editableImage)
end

--[=[
    Returns if the OSGL Window still exists. Useful for game-loops. Automatically yields for a heartbeat, or the given time.
     ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.window

    --// Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        print("Window exists!")
    end

    print("The window has been destroyed.")
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @param yield number -- The amount of time to yield. Defaults to a heartbeat
    @return Window -- Returns an OSGL window instance
]=]
function WindowPrivate:IsOpen(yield: number?)
	if yield and type(yield) ~= "number" then
		log.typeCheckArgument("WindowPrivate:IsOpen", "yield", yield, "number")
	end

	task.wait(yield)
	return self.renderer ~= nil
end

--[=[
    Renders `Window.pixels` to the EditableImage
     ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.window

    --// Creates a new EditableImage
    local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

    -- Runs every heartbeat
    while myWindow:IsOpen() do
        -- Render here
        -- *rendering magic*
        -- Stop rendering here

        myWindow:Render()
    end

    print("The window has been destroyed.")
    ```

    @within Window
    @return Window -- Returns an OSGL window instance
]=]
function WindowPrivate:Render()
    local final = table.create(#self.pixels, 0) :: { number }
    local n = math.round(#final / 2) -- change later
    
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

	return
end

return Window
