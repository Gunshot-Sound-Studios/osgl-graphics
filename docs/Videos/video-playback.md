---
sidebar_position: 2
---

# Handling video playback

## Overview

This guide covers how to handle video playback using OSGL. You will learn how to play videos both synchronously and asynchronously, manipulate video frames, and control playback using various methods provided by the `Video` class.

## Playing a video

OSGL allows you to write your own video-playing logic. The `callback` argument of `PlayAsync` and `PlaySync` provides you with the current frame as a `Texture`, which you can manipulate as needed.

### Playing a Video Synchronously

You can play a video synchronously and draw each frame onto a window:

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local Video = OSGL.Video
local Texture = OSGL.Texture

local WIDTH = 800
local HEIGHT = 600

-- Create a new window
local myWindow = Window.new(parent, { sizeX = WIDTH, sizeY = HEIGHT })

-- Load a video
local myVideo = Video.from({ frameOne, frameTwo, frameThree })

-- Play the video synchronously and draw each frame onto the window
myVideo:PlaySync(function(frame)
    Texture.draw(myWindow, frame, 0, 0)
    myWindow:Render()
end)
```

In this example, for every frame of the video, the frame is drawn onto `myWindow` as a `Texture`, and then the window is rendered to display the frame.

### Playing a Video Asynchronously

You can also play a video asynchronously, allowing other operations to run concurrently:

```lua
local OSGL = require(path.to.osgl)
local Window = OSGL.Window
local Video = OSGL.Video
local Texture = OSGL.Texture

local WIDTH = 800
local HEIGHT = 600

-- Create a new window
local myWindow = Window.new(parent, { sizeX = WIDTH, sizeY = HEIGHT })

-- Load a video
local myVideo = Video.from({ frameOne, frameTwo, frameThree })

-- Play the video asynchronously and draw each frame onto the window
myVideo:PlayAsync(function(frame)
    Texture.draw(myWindow, frame, 0, 0)
    myWindow:Render()
end)

-- Perform other operations while the video is playing
-- ...
```

In this asynchronous example, the video frames are drawn onto `myWindow` in the same way, but the video playback does not block other operations.

During playback, you can also call the other various methods of `Video`. Setting the `playbackFrame` to 0 will restart the video from the first frame. You can also use `Previous` and `Next` to go back and forward a frame. If `Video.loop` is `true`, `Next` will loop to the first frame after reaching the end. It is also possible to stop playback via the `Stop` method. You can learn more about these, among other functions, in the individual code examples attached to each function in the API.