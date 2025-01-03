---
sidebar_position: 1
---

# Drawing Shapes

Below is a list of shapes in OSGL as of version `1.4b`:

| Shape | Supported | Supports Rotation | Supports Stroke | Notes |
| ----- | --------- | ----------------- | --------------- | ----- |
| Pixel |     ✅    |       *N/A*       |     *N/A*       |  |
| Rectangle |     ✅    |       ✅       |     ✅       |  |
| Circle |     ✅    |       ✅      |     ✅       | Rotation is only visible at low resolutions.  |
| Lines |     ✅    |       *N/A*       |     ❌      |  |
| Polygon |     ✅    |       *N/A*       |     ✅       |  |
| Triangle |     ✅    |       *N/A*       |     ✅       |  |
| Flood Fill |     ✅    |       *N/A*       |     *N/A*       | Dynamic shape that fills an area |

All shape-drawing functions are accessible through the `draw` sub-module of OSGL. The first argument for each function must be a `DrawableObject`, which can be either a `Window` or a `Texture`. Additionally, you will need to provide the necessary parameters to define the shape, such as its position, size, and color.

Here is an example of how to draw a square, as defined by the documentation:

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

**Notes**:

- **Rotation**: Most shapes support rotation, but in some cases (e.g., circles), the rotation is only visible at low resolutions.

- **Stroke**: For shapes that support strokes, you can define both the stroke color and thickness. However, strokes are entirely optional and can be omitted if not needed.
