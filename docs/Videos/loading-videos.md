---
sidebar_position: 1
---

# Loading Videos

To load a video format, such as an MP4, like a [Texture](../Textures/loading-textures.md), OSGL uses an external tool bundled with OSGL on the GitHub releases page, [here](https://github.com/Gunshot-Sound-Studios/osgl-graphics/releases/latest), named `video-converter`. Choose the version for your OS. If unsure, feel free to ask us!

:::note
You can get help with the `video-converter` executable by running it in the command prompt with the `-h` flag, e.g.:

```bash
> video-converter -h
```
:::

The `video-converter` converts the video into a series of `Textures`. The structure of each texture is documented [here](../Textures/custom-texture-format.md).

A video can be loaded via the `Video.from` function. Pass an array of Textures in order:

```lua
local OSGL = require(path.to.osgl)
local Video = OSGL.Video

-- ...

local video = Video.from({ frameOne, frameTwo })
-- "video" is a video of frameOne and frameTwo
```

All frames must be the same size. If a frame isn't the same size as the others, it will be discarded.

You can also create a blank video with the given dimensions and an optional buffer, allowing you to create videos during runtime:

```lua
local OSGL = require(path.to.osgl)
local Video = OSGL.Video

local video = Video.new(50, 50)
-- Creates a blank 50x50 video with no frames

local video2 = Video.new(50, 50, {frameOne, frameTwo})
-- Creates a 50x50 video with frameOne and frameTwo
```

:::warning
High-resolution videos are even more expensive to load into memory than textures! Try to avoid storing them. Instead, consider optimizing your videos by reducing their resolution or compressing them before loading. This will help manage memory usage and improve performance.
:::
