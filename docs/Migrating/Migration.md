Welcome to the migration guide for transitioning from CanvasDraw to OSGL. This guide will walk you through the key steps and changes needed to migrate your existing codebase smoothly from CanvasDraw to OSGL.

It's important to note that OSGL and CanvasDraw have different internal architectures. OSGL works differently from CanvasDraw, so you may need to refactor your code.

In CanvasDraw, you create objects known as canvases with `CanvasDraw.new()`. In OSGL, you create a **window**, which you can read about [here](../Windows/opening-a-window.md):

```lua
local CanvasDraw = require(path)
local OSGL = require(path)
local Window = OSGL.Window -- OSGL is broken down into sub-modules that handle different aspects

-- CanvasDraw
CanvasDraw.new(Parent, Resolution, Color, Blur)

-- OSGL
Window.new(Parent, { sizeX = width, sizeY = height })
```

You can use the `Window.new` function to create the equivalent of a CanvasDraw canvas in OSGL. The OSGL code creates an EditableImage of size `(sizeX, sizeY)`.

All drawing methods can be directly accessed from the `Canvas` object in CanvasDraw. In OSGL, drawing is handled by different sub-modules (e.g., handling color, drawing, loading textures, etc.). Here is a comparison example:

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

It's also important to note two things:
- In OSGL, the top-left corner of the window is (0,0). In CanvasDraw, it is (1,1).
- The `draw` module is not needed to draw onto the window.

Similar to CanvasDraw, you can draw any shape via method in OSGL, but OSGL allows you to chain these methods:

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
                   -- Otherwise, it is not needed!
```

These methods are the same as the `Draw` methods, but they automatically pass the window as the first argument.

You can find more about these methods in the `API`, or on the [shapes](../drawing-shapes.md) page.

Both `Window`s and `Texture`s are known as `DrawableObject`s. A `Window` is a special form of a `Texture`, and a `Texture` is a `buffer` containing pixel data. This is similar to CanvasDraw's `ImageData`. To save a texture, save the `buffer`, `sizeX`, and `sizeY` (or just the `size`). Since it's a `Texture`, you can load it back into the game. This process is described in [`Serialization` and `Deserialization`](../Advanced/serializing-and-deserializing.md).
