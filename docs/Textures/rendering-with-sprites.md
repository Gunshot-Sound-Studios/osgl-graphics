---
sidebar_position: 2
---

# Rendering textures

Texture-data on its own is simply a buffer (like a `Window`). To render the Texture onto another `DrawableObject`, you can use the `Texture.draw` function:

```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.Texture

local textureData = require(path.to.texture)
local secondTextureData = require(path.to.secondTexture)

local textureA = Texture.from(textureData)
local textureB = Texture.from(secondTextureData)

-- Draw textureB on textureA at 0, 0
local textureC = Texture.draw(textureA, textureB, 0, 0)
```
In this example, we load 2 textures, `textureA`, and `textureB`. Then, using the `Texture.draw` function, we **draw** `textureB` **onto** `textureA` at 0, 0, which returns the new texture. You can also do this to a `Window`, which allows you to draw a `Texture` onto a `Window`. Remember, a `Window` is also a `DrawableObject` (a `Texture`!)
