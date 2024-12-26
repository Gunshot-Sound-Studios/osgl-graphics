Welcome to the migration guide for transitioning from CanvasDraw to OSGL. This guide will walk you through the key steps and changes needed to migrate your existing codebase smoothly from CanvasDraw to OSGL.

It's important to note that OSGL and CanvasDraw's internal architecture is **different**. OSGL works completely differently to CanvasDraw, and vice-versa. You may need to refactor your code.

In CanvasDraw, you create objects known as canvases, with `CanvasDraw.new()`. You can replicate this in OSGL by creating a **window**, which you can read about [here](../Windows/opening-a-window.md):

```lua
local CanvasDraw = require(path)
local OSGL = require(path)
local Window = OSGL.Window -- OSGL is broken down into sub-modules that handle different aspects

-- CanvasDraw
CanvasDraw.new(Parent, Resolution, Color, Blur)

-- OSGL
Window.new(Parent, { sizeX = width, sizeY = height })
```
You can utilize the `Window.new` function to create the equivilent of a CanvasDraw canvas, in OSGL. The OSGL code creates an EditableImage of size: `(sizeX, sizeY)`.

All drawing methods can be directly accessed straight from the `Canvas` object; which is not the case in OSGL. As shown in the code-example above, OSGL is broken down into different sub-modules that each do their own thing (e.g handling color, drawing, loading textures, etc.). Comparison example:

```lua
local CanvasDraw = require(path)
local OSGL = require(path)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

-- Draw a red pixel
local Canvas = CanvasDraw.new(Frame, Vector2.new(150, 100))
Canvas:DrawPixel(Vector2.new(75, 50), Color3.new(1, 0, 0))

-- Draw a red pixel
local window = Window.new(Frame, { sizeX = 150, sizeY = 100 })
draw.pixel(window, 76, 51, color.RED)
```
It's also important to note 2 things:
 - In OSGL, the top-left corner of the window is (0,0). In CanvasDraw, it is (1, 1)
 - The `draw` module is not needed to draw onto the window

Similarly to CanvasDraw, you can draw any shape via method, however OSGL allows you to chain these methods:
```lua
local Canvas = CanvasDraw.new(Frame, Vector2.new(150, 100))
Canvas:DrawPixel(Vector2.new(75, 50), Color3.new(1, 0, 0))
Canvas:DrawLine(Vector2.new(5, 5), Vector2.new(145, 95), Color3.new(1, 0, 0), 2, true)

local window = Window.new(Frame, { sizeX = 150, sizeY = 100 })
window
    :Draw() -- Opens a "DrawingContext". 
    :Pixel(76, 51, color.RED)
    :Line(6, 6, 146, 96, 2, color.RED)
    :StopDrawing() -- If you want to access the window's methods, you can use this.
                   -- Else, it is not needed!
```
These methods are exactly the same as the `Draw` methods, but they automatically pass the window as the first argument.

You can find more about these methods in the `API`.

Both `Window`s, and `Texture`s are something known as a `DrawableObject`. Effectively, a `Window` is just a special form of a `Texture`, and by extend, all a `Texture` is, is a `buffer` containing pixel-data. This is similar to CanvasDraw's `ImageData`. If you wanted to save a texture somewhere, all you would have to do is save the `buffer`, and the `sizeX` and `sizeY` (or just the `size`). Since it's a `Texture`, you can load it back into the game:

```lua
-- Save.luau
local bfr, size = window.buffer, window.size
-- *Save data here*

-- Load.luau
local bfr, size = -- *Load data here*
local newTexture = Texture.new(size.X, size.Y, bfr)

-- You can do whatever you want with this texture. You can even turn it into a window:
window.buffer = newTexture.buffer
```
:::warning

Be careful when setting a window's `buffer` to another `buffer`! If the `buffer`s aren't the same size, this will cause an error. This is the same case with a `Texture`. If you're setting one `buffer` to another, make sure they're the same size to avoid any errors.

:::