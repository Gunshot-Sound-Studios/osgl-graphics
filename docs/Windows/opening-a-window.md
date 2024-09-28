---
sidebar_position: 1
---

# Opening a window

In OSGL, a "window" is actually just a fancy name for an EditableImage. All that OSGL does, is wrap this EditableImage in an easy-to-use API for you. With **a lot** of handy features.

Before we can actually *draw* on our window, we need to create one. OSGL is split into *sub-modules* that each serve a different purpose (e.g, drawing on a window, creating a window, etc.). In this case, we want the `Window` class which allows us to create our window.

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
```

There are two functions available for creating our window: `Window.from` and `Window.new` . According to the API:

> `Window.from` : ***Creates an OSGL window from an existing EditableImage.***
> `Window.new` : ***Creates an OSGL window by initializing a new EditableImage instance at the specified location.***

Since we don’t have an existing `EditableImage` , we'll use `Window.new` to create our window on the designated `ImageLabel`:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 500x500
local myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })
```

The example above creates an OSGL window, with a size of 500x500, under `windowUi`. You can find more details about this function in the API

And that's it! We have our OSGL window ready and setup for rendering!
