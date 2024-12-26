---
sidebar_position: 2
---

# Managing & Rendering to a window

Now that we have our window, let's make this code a bit more interesting:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local windowUi -- reference to windowUi, our `ImageLabel`

-- Create our window, 500x500
local myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })

while task.wait() do
    myWindow
        :Clear(color.BLACK)
        :Render()
end
```

In summary, the code above creates a window with a size of 500x500 pixels. While the window remains open, it continuously clears the screen using the `BLACK` color (0, 0, 0, 255). The `Clear` method clears the window's buffer with the specified color, and the `Render` method displays the updated buffer on the screen.

It's important to note that the method calls do not need to be chained. You can achieve the same effect with separate statements, as shown below:

```lua
myWindow:Clear(color.BLACK)
myWindow:Render()
```

This sample illustrates that you can call `Clear` and `Render` as independent operations if you prefer. The `color` sub-module is utilized for manipulating colors in OSGL using the RGBA format. Once the window is closed, the program will terminate.

In this context, the loop implemented above is often referred to as the "event loop" or "game loop." The code inside this loop is executed every frame, allowing for continuous updates to the window. While clearing the buffer is one function we can perform, there are many additional operations we can execute within this loop.

For instance, we can utilize the `draw` sub-module to render directly onto the buffer. All drawing functions require a `Window` or `Texture` (known as a `DrawableObject`) to specify where to draw. For example, to draw a pixel, you would use the appropriate draw function provided by OSGL:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 10x10
local myWindow = Window.new(windowUi, { sizeX = 10, sizeY = 10 })

while task.wait() do
    myWindow:Clear(color.BLACK)
    -- It isn't necessary to clear the screen. If you want to keep the contents
    -- of the previous frame, you can!

    -- Draw a red pixel on `myWindow`, at 0, 0
    draw.pixel(myWindow, 0, 0, color.RED)

    myWindow:Render()
end
```

In this example, each operation within the loop is presented as separate statements. However, these statements can be combined into a single statement using method chaining, as shown below:

```lua
myWindow
    :Clear(color.BLACK)
    :Draw() -- Open a `DrawingContext`
    :Pixel(0, 0, color.RED) -- `myWindow` is automatically passed as the first argument
    :StopDrawing()
    :Render()
```

You can learn more about the various shapes you can draw in the [Drawing Shapes](../Shapes/drawing-shapes) section!

As alluded in the previous section, it's possible to render multiple `EditableImages` within a single window using the `AddRenderer` and `RemoveRenderer` methods. These methods accept various types of Image components, such as `ImageLabel`s, `ImageButton`s, or any other image-like instances.

For example, to add multiple renderers to a window, you can use the AddRenderer method as follows:
```lua
-- Add two renderers to the window
myWindow:AddRenderer(imageLabelOne, imageButtonTwo)
```
This code effectively enables the window to render onto both imageLabelOne and imageButtonTwo, with a minimal performance impact.

If you need to remove a renderer, you can do so by passing the instance you wish to remove as an argument to the `RemoveRenderer` method. Instances that are not currently rendering in the window will be ignored:
```lua
-- Stop the window from rendering to imageButtonTwo
myWindow:RemoveRenderer(imageButtonTwo)
```