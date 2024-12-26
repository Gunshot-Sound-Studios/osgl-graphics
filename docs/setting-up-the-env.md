---
sidebar_position: 2
---

# Setting up your environment

If you haven't done so already, download the latest version of OSGL from either the [Github releases](https://github.com/Gunshot-Sound-Studios/osgl-graphics/releases/latest) or from the [Roblox Marketplace](https://create.roblox.com/store/asset/18468099737/OSGL). Once downloaded, insert it into Studio in a suitible place (such as `ReplicatedStorage/Packages`)

Create an `ImageLabel` in `StarterGui`, with its `BackgroundTransparency` set to 0. This `ImageLabel` will act as your primary canvas for rendering graphics.

![Studio View](./img/blank-canv.jpeg)

:::note

Lower resolutions cause blurred images! If you're rendering at a low resolution, or just want a pixelated look, set the `ResampleMode` property of your `ImageLabel` to `Pixelated`!

:::

Additionally, create a `LocalScript` in your desired location (e.g., `StarterPlayer/StarterPlayerScripts` ). This script will create our window and manage the rendering process.

Now you are ready to begin programming!