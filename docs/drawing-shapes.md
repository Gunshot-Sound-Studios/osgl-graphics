---
sidebar_position: 4
---

# Drawing Shapes

Below is a list of shapes in OSGL as of version `1.5b`:

| Shape | Supported | Supports Rotation | Supports Stroke | Notes |
| ----- | --------- | ----------------- | --------------- | ----- |
| Pixel |     ✅    |       *N/A*       |     *N/A*       |  |
| Rectangle |     ✅    |       ✅       |     ✅       |  |
| Circle |     ✅    |       ✅      |     ✅       | Rotation is only visible at low resolutions.  |
| Lines |     ✅    |       *N/A*       |     ❌      |  |
| Polygon |     ✅    |       *N/A*       |     ✅       |  |
| Triangle |     ✅    |       *N/A*       |     ✅       |  |
| Flood Fill |     ✅    |       *N/A*       |     *N/A*       | Dynamic shape that fills an area |

All shape-drawing functions are accessible through the `draw` sub-module of OSGL. Each function requires a `DrawableObject` as the first argument, which can be either a `Window` or a `Texture`. You will also need to provide parameters to define the shape, such as its position, size, and color.

Here is an example of how to draw a square, as described in the documentation:

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

local WIDTH = 50
local HEIGHT = 50

-- Create a new EditableImage
local myWindow = Window.new(path.to.parent, { sizeX = WIDTH, sizeY = HEIGHT })
myWindow.targetFPS = 244

-- Draw a 5x5 red square at coordinates (0, 0)
draw.rectangle(myWindow, 0, 0, 5, 5, color.RED)
```

To draw any shape within a single statement, without the `draw` module, use the `Draw` method of a `DrawableObject`, which returns a `DrawingContext`. To revert to the original object, use `StopDrawing`:

```lua
-- Example.luau

-- ...

-- `object` refers to `window`
local object = window
                    :Draw() -- Open a `DrawingContext`
                    :SomeDrawingMethod() -- Equivalent to `draw.someDrawingMethod`
                    :AnotherDrawingMethod() -- Equivalent to `draw.anotherDrawingMethod`
                    :StopDrawing() -- Return the window
```

For instance, to draw a rectangle:

```lua

-- ...

window
    :Draw()
    :Rectangle(0, 0, 5, 5, color.RED)

-- We don't need to continue using `window`, so `StopDrawing` isn't needed.
-- If you wanted to call another method of `window`, you would use
-- `StopDrawing`.
```

In all draw functions, the first argument is always a `DrawableObject`, which is automatically passed in this context.

**Notes**:

- **Rotation**: Most shapes support rotation, but in some cases (e.g., circles), the rotation is only visible at low resolutions.

- **Stroke**: For shapes that support strokes, you can define both the stroke color and thickness. However, strokes are entirely optional and can be omitted if not needed.
