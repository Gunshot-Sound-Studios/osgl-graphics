---
sidebar_position: 1
---

# Serializing & Deserializing

OSGL simplifies the process of saving and loading your `Window`s and [`Texture`s](../Textures/loading-textures.md) without encountering `buffer` errors. This process, known as **serialization** and **deserialization**, ensures smooth data transfer.

### Why Serialize and Deserialize?

Consider a scenario where you have two `Window`s: Window A and Window B. You want to copy the contents of `A` into `B`. Typically, you might do something like this:

```lua
local B = Window.fromBuffer(A.buffer, configuration)
```

However, if `B` is not the same size as `A`, an error will occur. This is where **serialization** and **deserialization** become useful. You can **serialize** a `Window` and **deserialize** it into another `Window` or even a `Texture`:

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

### Understanding the Difference

If you are certain about the sizes of the `Window`s, you can use `fromBuffer`. However, if you are unsure or need to resize dynamically, it is advisable to use `Deserialize`. The `Deserialize` function safely scales the size of the buffer. Directly setting the `buffer` to another buffer may cause size errors! It's always safer to use `Deserialize`, however if you are confident that both `buffer`s will always be the same size, you can directly set the buffer via:

```lua
A.buffer = B.buffer
```

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

### Saving and Loading Example

Here is an example of how you can save and load the state of a `Window` using serialization and deserialization:

```lua
-- Save.luau
local bfr, width, height = windowOne:Serialize()
-- *save data*

-- Load.luau
local bfr, width, height = -- *load data*
windowTwo:Deserialize(bfr, width, height)
```

In summary, while serialization and deserialization are powerful functions for managing `Window`s and `Texture`s, there are times when directly setting the buffer with `A.buffer = B.buffer` might be more convenient. This approach can be useful when you are certain that the sizes of the buffers match, as it avoids the need to handle potential performance issues / resizing issues that come with deserialization.