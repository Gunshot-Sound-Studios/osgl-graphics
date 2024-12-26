---
sidebar_position: 3
---

# Serializing & Deserializing

OSGL makes it easy to save and load your `Window`s and [`Texture`s](../Textures/loading-textures.md) safely—no more worrying about dreaded `buffer` errors! This process, known as **serialization** and **deserialization**, helps you transfer data smoothly.

### Why Serialize and Deserialize?

Imagine you have two `Window`s: Window A and Window B. You want to copy the contents of `A` into `B`. Normally, you'd do something like this:

```lua
local B = Window.fromBuffer(A.buffer, configuration)
```

But, here's the catch: if `B` isn't the same size as `A`, you'll get an error. That's where **serialization** and **deserialization** come in. You can **serialize** a `Window` and **deserialize** it into another `Window` or even a `Texture`:

```lua
local A = Window.new(parent, { sizeX = 50, sizeY = 50 })

-- Draw a texture to `A`
local txt = texture.fromAssetId(14419725604)
texture.draw(A, txt, 0, 0)

-- Serialize `A` to get its buffer, width, and height
local bfr, w, h = A:Serialize()

local B = Window.new(parentTwo, { sizeX = 2, sizeY = 10 })

-- Resize `B` to match `A`'s dimensions and paste the contents
B:Deserialize(bfr, w, h)

-- Now `B` has the same size and contents as `A`
B:Render()
```

### What's the Difference?
If you're confident about the sizes of the `Window`s, you can use `fromBuffer`. But when you're not sure or need to resize dynamically, always use `Deserialize`.

### Serializing Textures

`Texture`s can also be serialized:
```lua
local txt = texture.fromAssetId(14419725604)
local bfr, w, h = txt:Serialize()

-- Create a new window with the texture's contents
local window = Window.fromBuffer(bfr, { sizeX = w, sizeY = h })

-- Alternatively, use `Deserialize` to update an existing window:
local secondWindow = -- *reference to a window*
secondWindow:Deserialize(bfr, w, h)
```

`fromBuffer` creates a new Window, while `Deserialize` updates an existing one. Both approaches get the job done; it just depends on what you need.

### Deserializing Textures

Unlike `Window`s, `Texture`s don’t have a `Deserialize` method. Why? Because you can simply create a new one like this:
```lua
local txt = texture.fromAssetId(14419725604)
local bfr, w, h = txt:Serialize()

-- Create a new texture from the serialized data
local newTxt = texture.new(w, h, bfr)
```