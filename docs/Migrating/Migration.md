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

