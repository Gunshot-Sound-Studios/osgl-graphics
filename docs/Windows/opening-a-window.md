---
sidebar_position: 1
---

# Opening a window

In OSGL, a "window" is actually just a fancy name for an EditableImage. All that OSGL does, is wrap this EditableImage in an easy-to-use API for you; with **a lot** of handy features.

Before we can actually *draw* on our window, we need to create one. OSGL is split into *sub-modules* that each serve a different purpose (e.g, drawing on a window, creating a window, etc.). In this case, we want the `Window` class which allows us to create our window.

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
```

There are four functions available for creating our window: `Window.from`, `Window.new`, `Window.fromAssetId`, and `Window.fromBuffer` . According to the API:

> `Window.from` : ***Creates an OSGL window from an existing EditableImage.***

> `Window.new` : ***Creates an OSGL window by initializing a new EditableImage instance at the specified location.***

> `Window.fromAssetId`: ***Given an assetId, creates a Window.***

> `Window.fromBuffer`: ***Given a buffer, creates a Window.***

Since we don’t have an existing `EditableImage` and do not wish to use an assetId, nor a buffer, we'll use `Window.new` to create our window directly on the designated `ImageLabel`:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 500x500
local myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })
```

The example above creates an OSGL window, with a size of 500x500, under `windowUi`. You can find more details about this function in the API.

And that's it! We have our OSGL window ready and setup for rendering!
You can also use `Window.from` and `Window.fromAssetId` to create a window.
As previously mentioned:

> `Window.fom`: ***Creates an OSGL window from an existing EditableImage.***

This means if we already *have* an `EditableImage`, we can create a window from it:
```lua
local editableImage = reference.to.editableImage
local window = Window.from(editableImage) -- Our window now has `editableImage` as a renderer
```
It's important to remember that a window is actually just an `EditableImage` in disguise. This means
you can actually render to multiple images at the same time, since all a Window does is contain the `EditableImage`.

`Window.fromAssetId` will create a window, but the contents of the window will be a assetId.

:::warning

This function will **error** if you don't own the asset! Make sure you have the permissions before using this function to avoid errors.

:::

The function can be used like `Window.new`:
```lua
local window = Window.fromAssetId(asset.id)
```

On the other hand, you can use `Window.fromBuffer` to create a window with a `buffer` object already loaded in. This is useful when you are serializing and deserializing many `Window`s and `Texture`s. You can learn more about this [here](./serializing-and-deserializing.md).