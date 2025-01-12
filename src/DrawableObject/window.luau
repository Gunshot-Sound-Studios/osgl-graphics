--!strict
--!native
--!optimize 2

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

local AssetService = game:GetService("AssetService")
local UserInputService = game:GetService("UserInputService")

local OSGL = script.Parent.Parent
local drawableObject = OSGL.DrawableObject
local types = require(OSGL.types)
local log = require(OSGL.log)
local color = require(OSGL.color)
local utils = require(drawableObject.utils)
local draw = require(OSGL.draw)

--[=[
    @class Window

    The window class. Handles creations of OSGL-Windows.
    An OSGL window is the representation of the EditableImage
    instance. Inherits everything from [DrawableObject].
]=]
local Window = {}
local windowPrivate = {}

--[=[
Renders the buffer to the EditableImage

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window

-- Creates a new Window
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Runs every heartbeat
while task.wait() do
    -- *rendering magic*

    myWindow:Render()
end
```

@within Window
@return Window
]=]
function windowPrivate.Render(self: types.Window)
	self.editableImage:WritePixelsBuffer(Vector2.zero, self.size, self.buffer)

	local now = os.clock()
	local fps = 1 / (now - self.lastRenderTime)
	if fps > self.targetFPS then
		task.wait(1 / self.targetFPS - 1 / fps)
	end

	self.lastRenderTime = os.clock()

	return self
end

--[=[
Writes a color to a certain pixel on a [DrawableObject]. The exact same as `draw.pixel`.

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:WritePixel(0, 0, color.RED):Render()
```

@param x number -- X position
@param y number -- Y position
@param color Color -- The color that will be written at the location
@return DrawableObject
@within DrawableObject
]=]
windowPrivate.WritePixel = utils.createWritePixel()

--[=[
Writes a color to a certain pixel on a [DrawableObject], ignoring `AlphaBlendMode`

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:OverwritePixel(0, 0, color.RED):Render()
```

@param x number -- X position
@param y number -- Y position
@param color Color -- The color that will be written at the location
@return DrawableObject
@within DrawableObject
]=]
windowPrivate.OverwritePixel = utils.createOverwritePixel()

--[=[
Reads a color on a window at the given location from the buffer

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:WritePixel(0, 0, color.RED):Render()

print(
    myWindow:ReadPixel(0, 0) -- 255
)
```

@function ReadPixel
@param x number -- X position
@param y number -- Y position
@return Color

@within DrawableObject
]=]
windowPrivate.ReadPixel = utils.createReadPixel()
--[=[
Clears the double-buffer with the given color or a transparent color

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })

-- Runs every heartbeat
while task.wait() do
    myWindow:Clear(color.GREEN)
    myWindow:Render()

    -- The above could also be chained as the followed:
    --[[
    myWindow:Clear(color.GREEN)
            :Render()
    --]]
end
```

@param clearColor Color? -- The color the screen will be cleared with
@return Window
@within Window
]=]
function windowPrivate.Clear(self: types.Window, clearColor: types.Color)
	local bufferLength = buffer.len(self.buffer)
	local current_size = 4
	local numCopies = math.ceil(math.log(bufferLength / 4, 2))

	buffer.writeu32(self.buffer, 0, clearColor or color.TRANSPARENT)

	for _ = 1, numCopies do
		local copy_size = math.min(current_size, bufferLength - current_size)
		buffer.copy(self.buffer, current_size, self.buffer, 0, copy_size)

		current_size += copy_size
	end

	return self
end

--[=[
Renders the current window to a set of Images with little-to-no performance impact.

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:AddRenderer(path.to.imageA, path.to.imageB)
-- imageA and imageB now both render the Window at the same time
```

@param ... ...(ImageLabel | ImageButton) -- The Images that will become renderers
@return Window
@within Window
]=]
function windowPrivate.AddRenderer(self: types.Window, ...: ImageLabel)
	local content = Content.fromObject(self.editableImage)
	local renderers = self.renderers
	for _, v: ImageLabel in ipairs({ ... }) do
		if not table.find(renderers, v) then
			table.insert(renderers, v)
			v.ImageContent = content
		end
	end

	return self
end

--[=[
Removes any renderers from any Images that are rendering the Window

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:AddRenderer(path.to.imageA, path.to.imageB)
-- imageA and imageB now both render the Window at the same time
myWindow:RemoveRenderer(path.to.imageB)
-- imageB no longer renders the Window

```

@param ... ...(ImageLabel | ImageButton) -- The Images that will be removed if rendering the Window
@return Window
@within Window
]=]
function windowPrivate.RemoveRenderer(self: types.Window, ...: ImageLabel)
	local content = Content.fromObject(self.editableImage)
	local renderers = self.renderers
	for _, v: ImageLabel in ipairs({ ... }) do
		local isInTable = table.find(renderers, v)
		if v.ImageContent == content or isInTable then
			if isInTable then
				table.remove(renderers, isInTable)
			end

			v.ImageContent = Content.none
		end
	end

	return self
end

--[=[
Resizes the window and its pixel buffer. This function may be resource intensive and
is not made for constant use. May require a re-render, depending on the new size.
After a window is resized, all renderers in `window.renderers` are added as a renderer

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new Window
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:Resize(100) -- Changes width to 100

-- Runs every heartbeat
while task.wait() do
    -- *rendering magic*

    myWindow:Render()
end
```

@param newWidth number? -- The new width of the window
@param newHeight number? -- The new height of the window
@error "Height" -- This error occurs if the height is smaller than 0
@error "Width" -- This error occurs if the width is smaller than 0
@error "Memory" -- This error occurs when the device does not have enough memory to resize the window
@return Window
@within Window
]=]
function windowPrivate.Resize(self: types.Window, newWidth, newHeight)
	local sizeX, sizeY = self.sizeX, self.sizeY

	newWidth = newWidth or sizeX
	newHeight = newHeight or sizeY

	if newHeight == sizeY and newWidth == sizeX then
		return self
	end

	log.cassert(newHeight > 0, "Height passed to `Window:Resize()` must be larger than 0.")
	log.cassert(newWidth > 0, "Width passed to `Window:Resize()` must be larger than 0.")

	local copy_size
	local bfrSize = newWidth * newHeight * 4
	local currentSize = buffer.len(self.buffer)
	if bfrSize < currentSize then
		copy_size = bfrSize
	else
		copy_size = currentSize
	end

	local resizedBuffer = buffer.create(newWidth * newHeight * 4)
	buffer.copy(resizedBuffer, 0, self.buffer, 0, copy_size)

	self.buffer = resizedBuffer

	local size = Vector2.new(newWidth, newHeight)
	self.size = size
	self.sizeX = newWidth
	self.sizeY = newHeight

	local editableImage = AssetService:CreateEditableImage({ Size = size })
	if not editableImage then
		log.error("Could not resize window as the device does not have enough memory")
	end

	self.editableImage = editableImage
	local content = Content.fromObject(editableImage)
	for _, v in ipairs(self.renderers) do
		v.ImageContent = content
	end

	return self
end

--[=[
Returns the Window's [DrawingContext]

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:Draw():Pixel(1, 1, color.RED):StopDrawing()
```

@function Draw
@return DrawingContext
@within DrawableObject
]=]
windowPrivate.Draw = utils.createDraw()

--[=[
Tints a region of pixels

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
myWindow:TintRegion(color.RED, .5, 0, 0, 10, 10)
-- Tint pixels from 0, 0, with the
-- tinting region being 10x15 (150 pixels, from 0, 0) the color red, with
-- a tinting factor of .5
```

@function TintRegion
@return DrawableObject
@within DrawableObject
]=]
windowPrivate.TintRegion = utils.createTintRegion()

--[=[
Returns the object's buffer, as well as its width and height

```lua
-- Save.luau
local bfr, width, height = myWindow:Serialize()
-- *save data*

-- Load.luau
local bfr, width, height = -- *load data*
window:Deserialize(bfr, width, height)
```

@function Serialize
@return (buffer, number, number)
@within DrawableObject
]=]
windowPrivate.Serialize = utils.createSerialize()

--[=[
Safely replaces the current window's buffer with a new buffer by resizing it to the specified width and height, preventing errors during the update

```lua
-- Save.luau
local bfr, width, height = myWindow:Serialize()
-- *save data*

-- Load.luau
local bfr, width, height = -- *load data*
window:Deserialize(bfr, width, height)
```

@function Deserialize
@param bfr buffer -- The new buffer
@param width number? -- The width of the buffer
@param height number? -- The height of the buffer
@return Window
@within Window
]=]
function windowPrivate.Deserialize(self: types.Window, bfr: buffer, width: number?, height: number?)
	width = width or self.sizeX
	height = height or self.sizeY

	log.cassert(height > 0, "Height passed to `Window:Deserialize()` must be larger than 0.")
	log.cassert(width > 0, "Width passed to `Window:Deserialize()` must be larger than 0.")

	local copy_size
	local bfrSize = width * height * 4
	local currentSize = buffer.len(bfr)
	if bfrSize < currentSize then
		copy_size = bfrSize
	else
		copy_size = currentSize
	end

	local resizedBuffer = buffer.create(width * height * 4)
	buffer.copy(resizedBuffer, 0, bfr, 0, copy_size)

	self.buffer = resizedBuffer

	local size = Vector2.new(width, height)
	self.size = size
	self.sizeX = width
	self.sizeY = height

	local editableImage = AssetService:CreateEditableImage({ Size = size })
	if not editableImage then
		log.error("Could not deserialize window as the device does not have enough memory")
	end

	self.editableImage = editableImage
	local content = Content.fromObject(editableImage)
	for _, v in ipairs(self.renderers) do
		v.ImageContent = content
	end

	return self
end

--[=[
Returns a tuple describing the mouse position relative to the renderer from the top-left corner.
The boolean represents if the mouse is in the renderer, and the following 2 numbers are the X and Y

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color

-- Creates a new Window
local myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })
print(myWindow:GetRelativeMouseToRenderer(path.to.parent))
```

@param image ImageLabel | ImageButton -- The renderer instance
@return (boolean, number, number)
@within Window
]=]
function windowPrivate.GetRelativeMouseToRenderer(self: types.Window, image: ImageLabel): (boolean, number, number)
	local sizeFactor = self.size / image.AbsoluteSize
	local mousePosition = UserInputService:GetMouseLocation() - image.AbsolutePosition

	local relativeMousePosition = mousePosition * sizeFactor
	local isInWindow = relativeMousePosition.X > 0 and relativeMousePosition.Y > 0

	return isInWindow, math.round(relativeMousePosition.X), math.round(relativeMousePosition.Y)
end

function makeWindow(
	editableImage: EditableImage,
	sizeX: number,
	sizeY: number,
	bfr: buffer,
	renderers: {}?
): types.Window
	return {
		-- Looks stupid, but it's efficient.
		editableImage = editableImage,
		buffer = bfr,

		targetFPS = 60,
		lastRenderTime = os.clock(),
		renderers = renderers or {},

		sizeX = sizeX,
		sizeY = sizeY,
		size = Vector2.new(sizeX, sizeY),

		Render = windowPrivate.Render,
		Clear = windowPrivate.Clear,
		Resize = windowPrivate.Resize,
		WritePixel = windowPrivate.WritePixel,
		ReadPixel = windowPrivate.ReadPixel,

		AddRenderer = windowPrivate.AddRenderer,
		RemoveRenderer = windowPrivate.RemoveRenderer,

		Serialize = windowPrivate.Serialize,
		Deserialize = windowPrivate.Deserialize,

		Draw = windowPrivate.Draw,
	}
end

--[=[
    Creates an OSGL window by creating a new EditableImage instance at the given place.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a new Window
    local myWindow = Window.new(path.to.parent, { size = 50, size = 50 })
    ```

    @within Window
    @error "Typechecking" -- This error occurs when a required argument is not passed or the type is incorrect
    @error "Permission" -- This error occurs when the owner of the place does not have the `EditableImage` feature enabled
    @error "Memory" -- This error occurs when the device doesn't have enough memory to create the Window
    @param parent Instance -- The instance the EditableImage will be parented to
    @param config WindowConfiguration? -- Optional configurations
    @return Window -- Returns an OSGL window instance
]=]
function Window.new<P>(parent: ImageLabel | ImageButton, config: types.WindowConfiguration?): types.Window
	log.typeCheckArgument("Window.new", "parent", parent, "Instance")

	config = config or {}

	local sizeX, sizeY = config.sizeX or 1, config.sizeY or 1

	if sizeX <= 0 or sizeX > 1024 or sizeY <= 0 or sizeY > 1024 then
		log.warn(
			"Attempt to create a window with invalid dimensions (X: "
				.. sizeX
				.. ", Y: "
				.. sizeY
				.. "). Dimensions must be within the range of 1 to 1024. The window size has been automatically clamped to valid parameters."
		)
	end

	sizeX = math.clamp(sizeX, 1, 1024)
	sizeY = math.clamp(sizeY, 1, 1024)

	local editableImage = AssetService:CreateEditableImage({ Size = Vector2.new(sizeX, sizeY) })
	if not editableImage then
		return log.error("Could not make EditableImage as the device does not have enough memory")
	end

	parent.ImageContent = Content.fromObject(editableImage)

	return Window.from(editableImage, { parent })
end

--[=[
    Creates an OSGL window from an existing EditableImage.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a window from an existing EditableImage
    local myWindow = Window.from(path.to.editableImage)
    ```

    @within Window
    @error "Argument Type" -- This error occurs when a required argument is not passed or the type is incorrect
    @error "Permission" -- This error occurs when the owner of the place does not have the `EditableImage` feature enabled
    @error "Memory" -- This error occurs when the device doesn't have enough memory to create the Window
    @param editableImage EditableImage -- The existing EditableImage
    @param renderers {ImageLabel | ImageButton?} -- An argument used internally to initially set any renderers
    @return Window -- Returns an OSGL window instance
]=]
function Window.from(editableImage: EditableImage, renderers: { ImageLabel | ImageButton? }): types.Window
	log.typeCheckArgument("Window.from", "editableImage", editableImage, "EditableImage")

	local size = editableImage.Size
	local sizeX = size.X
	local sizeY = size.Y

	local bfr = buffer.create(sizeX * sizeY * 4)

	-- Check if the user can actually draw to the window
	local success, errorMessage = pcall(function()
		local temporaryBuffer = buffer.create(4)
		buffer.writeu8(temporaryBuffer, 0, 0)

		editableImage:WritePixelsBuffer(Vector2.zero, Vector2.one, temporaryBuffer)
	end)

	if not success then
		log.error(errorMessage)
	end

	return makeWindow(editableImage, sizeX, sizeY, bfr, renderers)
end

--[=[
    Given an assetId, creates a Window.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a window from an assetId
    local myWindow = Window.fromAssetId(asset.id)

    -- use AddRenderers to add a renderer
    myWindow:AddRenderers(path.to.imageA)
    ```

    @within Window
    @error "Permission" -- This error occurs when the owner of the place does not have the `EditableImage` feature enabled
    @error "Memory" -- This error occurs when the device doesn't have enough memory to create the Window
    @param assetId number -- The assetId that will be loaded
    @return Window -- Returns an OSGL window instance
]=]
function Window.fromAssetId(assetId: number)
	local texture = Content.fromAssetId(assetId)
	local editableImage = AssetService:CreateEditableImageAsync(texture)
	if not editableImage then
		log.error("Could not make window as the device does not have enough memory")
	end

	return Window.from(editableImage)
end

--[=[
    Given a buffer, creates a Window.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    ​
    -- Creates a window from an assetId
    local myWindow = Window.fromBuffer(bfr, { sizeX = bufferWidth, sizeY = bufferHeight })

    -- use AddRenderers to add a renderer
    myWindow:AddRenderers(path.to.imageA)
    ```

    @within Window
    @error "Permission" -- This error occurs when the owner of the place does not have the `EditableImage` feature enabled
    @error "Memory" -- This error occurs when the device doesn't have enough memory to create the Window
    @param bfr buffer -- The buffer that will be loaded into the Window
    @param config WindowConfiguration? -- Optional configurations
    @return Window -- Returns an OSGL window instance
]=]
function Window.fromBuffer(bfr: buffer, config: types.WindowConfiguration)
	log.typeCheckValue("Window.fromBuffer", "bfr", bfr, "buffer")

	config = config or {}

	local sizeX, sizeY = config.sizeX or 1, config.sizeY or 1

	if sizeX <= 0 or sizeX > 1024 or sizeY <= 0 or sizeY > 1024 then
		log.warn(
			"Attempt to create a window with invalid dimensions (X: "
				.. sizeX
				.. ", Y: "
				.. sizeY
				.. "). Dimensions must be within the range of 1 to 1024. The window size has been automatically clamped to valid parameters."
		)
	end

	sizeX = math.clamp(sizeX, 1, 1024)
	sizeY = math.clamp(sizeY, 1, 1024)

	local size = Vector2.new(config.sizeX, config.sizeY)

	local editableImage = AssetService:CreateEditableImage({ Size = size })
	if not editableImage then
		return log.error("Could not make EditableImage as the device does not have enough memory")
	end

	editableImage:WritePixelsBuffer(Vector2.zero, size, bfr)

	-- [saaawdust]: Makes another Vector2 :(
	return makeWindow(editableImage, sizeX, sizeY, bfr)
end

--[=[
	@prop editableImage EditableImage
	@within Window
	The actual editableImage of the Window
]=]

--[=[
	@prop targetFPS number
	@within Window
	The Window's Target FPS. Defaults to 60

	```lua
	window.targetFPS = 5

	while task.wait() do
		window:Render() -- Renders at roughly 5FPS
	end
	```
]=]

return Window
