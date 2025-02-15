---
sidebar_position: 1
---

# Loading Textures

To load file formats such as `PNGs`, `WebPs`, etc., OSGL uses its own external tool. The tool is bundled with OSGL on the github releases page, [here](https://github.com/osgl-rbx/osgl/releases/latest), named `image-converter` (previously `converter`). Pick the one for your OS. If you don't know which to pick, feel free to ask us!

:::note
You can get help with the `image-converter` exe by running it in the command-prompt, with the `-h` flag! e.g:

```bash
> image-converter -h
```

:::
The `image-converter` turns these image formats into OSGLs custom image-format, which you can learn more about [here](./custom-texture-format).

You can load textures into OSGL with the `Texture.from` function, which takes the texture generated by the `image-converter`:

```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.Texture
​
local txt = Texture.from(script.ModuleThatReturnsTexture)
-- "txt" now contains OSGL-Texture data
```

You can also create a blank texture of the given width, and height, with optional texture-data with the `Texture.new` function:

```lua
local OSGL = require(path.to.osgl)
local Texture = OSGL.texture
​
local txt = Texture.new(50, 50) -- Creates a 50x50 texture
```

:::info
A `Texture` is a `DrawableObject`, like a `Window`, meaning it can only be drawn too. You can edit a texture like any other window. This is because both belong to the super-class `DrawableObject`. This means anything you can draw to a `Window`, can also be drawn to a `Texture`. Or, in other words, a `Window` is also a `Texture`.
:::

:::warning
Textures are expensive to load into memory! Once loaded however, they can be used everywhere. Always keep in mind some devices may not be able to load large textures. Textures, can, however, be loaded extremely fast, meaning you can load them in quick succession.
:::
