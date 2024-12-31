---
sidebar_position: 2
---

# Rendering Textures

## Drawing a Texture on Another Texture

In OSGL, a `Texture` is essentially a buffer, similar to a `Window`. To render a `Texture` onto another `DrawableObject`, such as a `Window` or another `Texture`, use the `Texture.draw` function:

```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.Texture

local textureData = require(path.to.texture)
local secondTextureData = require(path.to.secondTexture)

local textureA = Texture.from(textureData)
local textureB = Texture.from(secondTextureData)

-- Draw textureB on textureA at (0, 0)
local textureC = Texture.draw(textureA, textureB, 0, 0)
```

### Explanation

- Two textures, `textureA` and `textureB`, are loaded using the `Texture.from` function.
- The `Texture.draw` function draws `textureB` onto `textureA` at position (0, 0). This operation returns a new `Texture` object, assigned to `textureC`.

## Drawing a Texture onto a Window

You can also draw a `Texture` onto a `Window`, as it is a `DrawableObject`:

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local Texture = OSGL.Texture

-- Create a new window
local myWindow = Window.new(parent, { sizeX = 100, sizeY = 100 })

-- Load a texture
local textureData = require(path.to.texture)
local myTexture = Texture.from(textureData)

-- Draw the texture onto the window at position (10, 10)
Texture.draw(myWindow, myTexture, 10, 10)

-- Render the window to display it on the screen
myWindow:Render()
```

## Example: Combining Textures with Layers

Using this knowledge, you can layer multiple `Texture` objects onto a single `DrawableObject`:

```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.Texture

-- Load base texture and two additional layers
local baseTextureData = require(path.to.baseTexture)
local layer1Data = require(path.to.layer1)
local layer2Data = require(path.to.layer2)

local baseTexture = Texture.from(baseTextureData)
local layer1 = Texture.from(layer1Data)
local layer2 = Texture.from(layer2Data)

-- Draw layer1 onto the base texture at (20, 20)
Texture.draw(baseTexture, layer1, 20, 20)

-- Draw layer2 onto the updated base texture at (40, 40)
Texture.draw(baseTexture, layer2, 40, 40)

-- Now baseTexture contains both layers combined!
```

