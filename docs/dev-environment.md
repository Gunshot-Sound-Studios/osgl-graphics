---
sidebar_position: 2
---

# Development environment

In this chapter, we'll set up your environment for using OSGL. All of the tools we'll use, such as the `image-converter` executable, are available on Windows and MacOS.

The most important component you'll need is the actual OSGl module itself. You can download the latest version of the module from either the [Github releases](https://github.com/Gunshot-Sound-Studios/osgl-graphics/releases/latest), the [Roblox marketplace](https://create.roblox.com/store/asset/18468099737/OSGL) or the [Wally Index](https://wally.run/package/gunshotsoundstudios/osgl). 

You can use [Rojo](https://rojo.space) to sync the `Examples` folder to view any examples showcased or referenced in this tutorial. By default, all scripts have their `Enabled` property set to `false`, so you'll need to enable the script to test them. These scripts are designed to be self-sufficient and will automatically create any necessary resources during runtime.

If you have Rojo, it's a good idea to sync the `Examples` folder to try out OSGL. A good place to start is to try the example "**01-BlackScreen**," which renders a black window. If you encounter any issues, refer to the [FAQ](./FAQ.md) for solutions to common problems.

To start, create a `LocalScript` in your desired location (e.g., `StarterPlayer/StarterPlayerScripts`). Assuming the OSGL module has been placed in `ReplicatedStorage`, paste the following code into your newly created script to test if OSGL works. Don't worry if you don't understand it yet! Upon running the game, there should be a black `ImageLabel` in the center of your screen.

```lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local player = Players.LocalPlayer
assert(player)

-- Define window dimensions
local WIDTH = 420
local HEIGHT = 420

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(.5, .5)
ImageLabel.Size = UDim2.fromOffset(WIDTH, HEIGHT)
ImageLabel.Parent = ScreenGui

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244

-- Draw a black screen and render
window
    :Clear(color.BLACK)
    :Render()
```

If the code above executed successfully, you are now ready to proceed with the tutorial and the script can be deleted. If not, you can refer to the [FAQ](./FAQ.md).