---
sidebar_position: 2
---

# Rendering with sprites

A texture on its own cannot directly be drawn to the screen. Instead, it can be applied to a `Sprite`, which can render itself on the screen.

Creating a sprite is as simple as:

```lua
local OSGL = require(path.to.osgl)
local Sprite = OSGL.Sprite
​
local txt -- *load texture*
local mySprite = Sprite.new(txt)
```

You can then render these sprites to a window (or even another texture) by using its `Draw` method:

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local Sprite = OSGL.Sprite
​
-- Creates a window from an existing EditableImage
local myWindow = Window.from(path.to.editableImage, { sizeX = 50, sizeY = 50 })

local txt = -- *load texture*
local mySprite = Sprite.new(myWindow, txt)
mySprite:Draw(myWindow)
```

Sprites also have an X and Y, meaning you can change the position of the sprite on the screen.