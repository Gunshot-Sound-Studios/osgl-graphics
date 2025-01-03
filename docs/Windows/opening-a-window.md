---
sidebar_position: 1
---

# Opening a window

In OSGL, a `Window` is an EditableImage. OSGL is wrapper around this EditableImage that gives you an easy-to-use API with many handy features.

To *draw* on a window, you need to create one. OSGL is split into *sub-modules* that each serve a different purpose (e.g, drawing on a window, creating a window, etc.). The `Window` class enables you to create a `Window` in OSGL:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window
```

There are four functions available for creating a window: `Window.from`, `Window.new`, `Window.fromAssetId`, and `Window.fromBuffer`. Below is a high-level extract from the API:

> `Window.from` : ***Creates an OSGL window from an existing EditableImage.***

> `Window.new` : ***Creates an OSGL window by initializing a new EditableImage instance at the specified location.***

> `Window.fromAssetId`: ***Given an assetId, creates a Window.***

> `Window.fromBuffer`: ***Given a buffer, creates a Window.***

To create a `Window` directly on the designated ImageLabel, utilize the `Window.new` function. Since there is no existing EditableImage, and using either a assetId or buffer is not desired, this method allows for direct window creation:

```lua
local OSGL = require(ReplicatedStorage.Packages.OSGL)
local Window = OSGL.Window

local windowUi = -- *reference to windowUi, our `ImageLabel`*

-- Create our window, 500x500
local myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })
```

The example above creates an OSGL window, with a size of 500x500, under `windowUi`. You can find more details about this function in the API.

And that's it! This OSGL window is now ready and setup for rendering!
The functions `Window.from` and `Window.fromAssetId` can also be used to create a window.
As previously mentioned:

> `Window.fom`: ***Creates an OSGL window from an existing EditableImage.***

This means if an `EditableImage` already exists, we can create a window from it:
```lua
local editableImage = reference.to.editableImage
local window = Window.from(editableImage) -- Our window now has `editableImage` as a renderer
```
It's important to remember that a window is actually just an `EditableImage` in disguise. This means
it can render to multiple images at the same time, as all a window does is contain the `EditableImage`.

`Window.fromAssetId` will create a window, but the contents of the window will be a assetId.

:::warning

This function will **error** if you don't own the asset! Make sure you have the permissions before using this function to avoid errors. The owner of the place (or group that owns the experience) must have the valid access.

:::

The function can be used like `Window.new`:
```lua
local window = Window.fromAssetId(asset.id)
```

On the other hand, you can use `Window.fromBuffer` to create a window with a `buffer` object already loaded in. This is useful when you are serializing and deserializing `Window`s and `Texture`s. You can learn more about this [here](./serializing-and-deserializing.md).