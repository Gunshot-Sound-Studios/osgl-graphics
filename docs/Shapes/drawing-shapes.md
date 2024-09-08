---
sidebar_position: 1
---

# Drawing Shapes
Below is a list of shapes in OSGL as of version `1.2b`:

| Shape | Supported | Supports Rotation | Supports Stroke | Notes |
| ----- | --------- | ----------------- | --------------- | ----- |
| Pixel |     ✅    |       *N/A*       |     *N/A*       |  |
| Rectangle |     ✅    |       ✅       |     ✅       |  |
| Circle |     ✅    |       ✅      |     ✅       | Rotation is only visible at low resolutions.  |
| Lines |     ✅    |       *N/A*       |     ❌      |  |
| Points |     ✅    |       *N/A*       |     ❌       |  |
| Triangle |     ❌    |       *N/A*       |     *N/A*       | Will be implemented |

All shape-drawing functions can be accessed through the `draw` sub-module of OSGL. The first argument for each function is a `Drawable` object, which could be a `Window` or `Texture`. You'll also need to provide the relevant properties to define the shape (e.g., position, size, color).

Here's an example of drawing a rectangle:

```lua
draw.rectangle(window, {
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
```

**Notes**:

- **Rotation**: Most shapes support rotation, but in some cases (e.g., circles), the rotation is only visible at low resolutions.

- **Stroke**: For shapes that support strokes, you can define both the stroke color and thickness. However, strokes are entirely optional and can be omitted if not needed.