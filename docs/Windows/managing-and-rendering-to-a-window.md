---
sidebar_position: 2
---

#   Managing & Rendering to a window

Now that we have our window, let's make this code a bit more interesting.

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 500x500
local myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })

while myWindow:IsOpen() do
    myWindow:Clear(color.BLACK)
    myWindow:Render()
end
```

In summary, the above code creates a window, and while it is open, clears the screen with a `BLACK` color (0, 0, 0, 255). The `IsOpen` method returns if our window still exists, yielding for a heartbeat, meaning we don't need to include a `task.wait`. The `Clear` method clears the Windows' `buffer` with the given color, which in this case is `BLACK`. Finally, we call the `Render` method, which, as the name suggests, renders the `buffer` to the screen. After the window is destroyed, the program will end. The `color` sub-module is used to manipulate OSGL colors (RGBA).

Using `IsOpen` is known as the "event loop" or the "game loop". The contents of this loop are usually executed every frame. But what else can we do other than clear the buffer?

We can utilize the `draw` sub-module to draw directly to the `buffer`. All drawing functions require a Window or Texture to draw too. For example, to draw a pixel:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 10x10
local myWindow = Window.new(windowUi, { sizeX = 10, sizeY = 10 })

while myWindow:IsOpen() do
    myWindow:Clear(color.BLACK)
    -- It isn't necessary to clear the screen. If you want to keep the contents
    -- of the previous frame, you can!

    -- Draw a red pixel on `myWindow`, at 0, 0
    draw.pixel(myWindow, 0, 0, color.RED)

    myWindow:Render()
end
```
You can learn more about the different shapes you can draw in "[Drawing shapes](../Shapes/drawing-shapes)"!