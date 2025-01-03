---
sidebar_position: 2
---

# Rendering Textures

In OSGL, `Texture` data is essentially a buffer (just like a `Window`). However, if you want to render a `Texture` onto another `DrawableObject`, such as a `Window` or another `Texture`, you can use the `Texture.draw` function:

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

#### What's Happening Here?
 - Loading Textures: We load two textures, `textureA` and `textureB`, using the `Texture.from` function.
 - Drawing: The `Texture.draw` function draws `textureB` onto `textureA` at position (0, 0). This operation    returns a new `Texture` object, which we've assigned to `textureC`.

You can also perform this operation on a `Window`. Remember: a `Window` in OSGL is also a DrawableObject, which is a `Texture`.

### Drawing a Texture onto a Window

To render a `Texture` onto a `Window`, you can do the exact same thing:
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
### Example: Combining Textures with layers

Using this knowledge, you can layer multiple `Texture` objects onto a singular `DrawableObject` like so:
```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.Texture

-- Load base texture and 2 additional layers
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