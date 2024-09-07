---
sidebar_position: 2
---

# Setting up our environment

Before we can *use* OSGL, there are a few things we need to do first. Firstly, we need to make sure that we have the EditableImage beta option enabled in Studio. You can enable it in `File > Beta Features > EditableImages & EditableMeshes`

If you haven't already, grab yourself the latest copy of OSGL from the [github](https://github.com/Gunshot-Sound-Studios/osgl-graphics/releases/latest) or the [Roblox](https://create.roblox.com/store/asset/18468099737/OSGL) marketplace, and insert it into Studio in a suitible place (such as `ReplicatedStorage/Packages`)

Create an `ImageLabel` in `StarterGui`, with its `BackgroundTransparency` set to 0. This `ImageLabel` will serve as your canvas:

![alt text](./img/blank-canv.jpeg)

:::note

Lower resolutions cause blurred images! If you're rendering at a low resolution, set the `ResampleMode` property of your `ImageLabel` to `Pixelated`!

:::

Additionally, create a `LocalScript` in your desired location (e.g., `StarterPlayer/StarterPlayerScripts` ) and name it appropriately. This script will create our window and manage the rendering process.

Now we can start programming!