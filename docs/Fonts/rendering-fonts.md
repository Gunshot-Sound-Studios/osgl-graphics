---
sidebar_position: 2
---

# Rendering fonts

You can draw a font onto a [DrawableObject] via the `Draw` function

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local Font = OSGL.Font

local WIDTH = 800
local HEIGHT = 600

-- Create a new window
local myWindow = Window.new(parent, { sizeX = WIDTH, sizeY = HEIGHT })

-- Load a font
local fnt = Font.from(fontData)
fnt:Draw("Hello, World!", 1, 1)
```

In this example, the text "Hello, World!" will be rendered at the coordinates (1, 1) on the window.