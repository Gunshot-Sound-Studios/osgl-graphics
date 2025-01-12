------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
-- Copyright © 2023-2025 Gunshot Sound Studios (@saaawdust)
--
-- This software is provided ‘as-is’, without any express or implied warranty.
-- In no event will the authors be held liable for any damages arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it freely,
-- subject to the following restrictions:
--
-- 1. The origin of this software must not be misrepresented;
--    you must not claim that you wrote the original software.
--    If you use this software in a product, an acknowledgment
--    in the product documentation would be appreciated but is not required.
--
-- 2. Altered source versions must be plainly marked as such,
--    and must not be misrepresented as being the original software.
--
-- 3. This notice may not be removed or altered from any source distribution.
--
------------------------------------------------------------

local OSGL = script.Parent
local drawableObject = OSGL.DrawableObject
local Texture = require(drawableObject.texture)
local types = require(OSGL.types)

--[=[
    @class Video

    The Video class is responsible for managing
    video playback and rendering. It facilitates the
    loading and manipulation of video textures (an animatable [DrawableObject]!).
]=]
local Video = {}

--[=[
    Plays a video syncronously. The callback will be ran every frame and provides the current frame as a [Texture].

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    video.frameRate = 60
    video.loop = true

    -- Plays the video syncronously, rendering 
    -- to `myWindow` every frame
    video:PlaySync(function(texture)
        Texture.draw(myWindow, texture, 0, 0)
        myWindow:Render()
    end)
    ```

    @within Video
    @param callback (texture: Texture) -> () -- A callback function that will be ran every frame, returning the current frame as a [Texture].
    @return Video -- Returns itself.
]=]
function PlaySync<T>(self: types.Video<T>, callback: (texture: types.Texture<T>) -> ())
	local frames = #self.frames
	local timePerFrame = 1 / self.frameRate

	self.playing = true
	while self.playing do
		self.playbackFrame += 1
		
		if self.playbackFrame > frames then
			if self.loop then
				self.playbackFrame = 1
			else
				self.playing = false
				break
			end
		end

		callback(Texture.new(self.sizeX, self.sizeY, self.frames[self.playbackFrame]))
		task.wait(timePerFrame)
	end

	return self
end

--[=[
    Plays a video asyncronously. The callback will be ran every frame and provides the current frame as a [Texture].

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    video.frameRate = 60
    video.loop = true

    -- Plays the video asyncronously, rendering 
    -- to `myWindow` every frame
    video:PlayAsync(function(texture)
        Texture.draw(myWindow, texture, 0, 0)
        myWindow:Render()
    end)

    print("This code will run while the video is playing!")
    ```

    @within Video
    @param callback (texture: Texture) -> () -- A callback function that will be ran every frame, returning the current frame as a [Texture].
    @return Video -- Returns itself.
]=]
function PlayAsync<T>(self: types.Video<T>, callback: (texture: types.Texture<T>) -> ())
	task.spawn(self.PlaySync, self, callback)
	return self
end

--[=[
    Skips to the next frame. Goes to the first frame if `loop` is enabled.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    video.frameRate = 60
    video.loop = true

    -- Plays the video syncronously, rendering 
    -- to `myWindow` every frame
    video:PlaySync(function(texture)
        Texture.draw(myWindow, texture, 0, 0)

        if video.playbackFrame == 10 then
            -- Skip the frame
            video:Next()
        end 
    end)
    ```

    @within Video
    @return Video -- Returns itself.
]=]
function Next<T>(self: types.Video<T>)
	local len = #self.frames
	if self.playbackFrame < len then
		self.playbackFrame += 1
	elseif self.loop then
		self.playbackFrame = 0
	end

	return self
end

--[=[
    Goes to the previous frame. Does not go to the last frame if `loop` is enabled.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    video.frameRate = 60
    video.loop = true

    -- Plays the video syncronously, rendering 
    -- to `myWindow` every frame
    video:PlaySync(function(texture)
        Texture.draw(myWindow, texture, 0, 0)

        if video.playbackFrame == 10 then
            -- Go back a frame
            video:Previous()
        end 
    end)
    ```

    @within Video
    @return Video -- Returns itself.
]=]
function Previous<T>(self: types.Video<T>)
	if self.playbackFrame > 0 then
		self.playbackFrame -= 1
	end

	return self
end

--[=[
    Stops the video playback and sets the current frame to the start.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    video.frameRate = 60
    video.loop = true

    -- Plays the video syncronously, rendering 
    -- to `myWindow` every frame
    video:PlaySync(function(texture)
        Texture.draw(myWindow, texture, 0, 0)

        if video.playbackFrame == 10 then
            -- Stop the playback
            video:Stop()
        end 
    end)
    ```

    @within Video
    @return Video -- Returns itself.
]=]
function Stop<T>(self: types.Video<T>)
	self.playing = false
	self.playbackFrame = 0

	return self
end

--[=[
    Returns a specific frame as a [Texture]

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    local frameTwo = video:GetFrame(2)

    -- frameTwo is a `Texture` object!
    ```

    @within Video
    @return Texture -- Returns the frame as a texture.
]=]
function GetFrame<T>(self: types.Video<T>, frame: number): types.Texture<T>
	return Texture.new(self.sizeX, self.sizeY, self.frames[frame])
end

--[=[
    Returns a specific frame as a buffer

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
    local frameTwo = video:GetBufferOfFrame(2)

    -- frameTwo is a buffer object!
    ```

    @within Video
    @return Texture -- Returns the frame as a buffer.
]=]
function GetBufferOfFrame<T>(self: types.Video<T>, frame: number): buffer
	return self.frames[frame] or buffer.create(0)
end

--[=[
    Create a new [Video] object of the given dimensions, with an optional buffer.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    -- Blank 500x500 video
    local video = Video.new(500, 500)
    ```

    @within Video
    @return Video -- The newly created [Video] object.
]=]
function Video.new<T>(width: number, height: number, frames: { buffer }?): types.Video<T>
	local frames = frames or {}

    local size
	for i, v: buffer in ipairs(frames) do
        local len = buffer.len(v)

		if not size then
			size = len
		elseif len ~= size then
			warn("Failed to load video frame ".. i.. ". The frame has been discarded, all frames but be the same size!")
			table.remove(frames, i)
		end
	end

	return {
		sizeX = width,
		sizeY = height,
		playbackFrame = 0,
		frameRate = 1 / #frames,
		frames = frames,
		playing = false,
		loop = false,

		PlaySync = PlaySync,
		PlayAsync = PlayAsync,
		Previous = Previous,
		Next = Next,
		Stop = Stop,

		GetBufferOfFrame = GetBufferOfFrame,
		GetFrame = GetFrame
	}
end

--[=[
    Creates a new [Video] object from a collection of [Texture] objects.
    All frames must be the same size.

    ```lua
    local OSGL = require(path.to.osgl)
    local Window = OSGL.Window
    local Video = OSGL.Video
    local Texture = OSGL.Texture

    -- Creates a Window with a size of 50x50
    -- This window is a DrawableObject
    local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })

    local frames = -- Reference to texture-data
    local video = Video.from(frames)
	
    -- video is a `Video` object!
    ```

    @within Video
    @return Video -- The newly created [Video] object.
]=]
function Video.from<T>(collection: { types.FlagTexture | ModuleScript }): types.Video<T>
	local framesAmount = #collection

	if framesAmount == 0 then
		return Video.new(0, 0)
	end

	local bfrCollection = table.create(framesAmount)

	local sizeX, sizeY
	for i, v in ipairs(collection) do
		if typeof(v) == "Instance" and v:IsA("ModuleScript") then
			v = require(v)
		end

		if not sizeX or not sizeY then
			sizeX, sizeY = v.width, v.height
		elseif sizeX ~= v.width or sizeY ~= v.height then
			warn("Failed to load video frame ".. i.. ". The frame has been discarded, all frames but be the same size!")
			continue
		end

        bfrCollection[i] = v.pixels
	end

	return Video.new(sizeX, sizeY, bfrCollection)
end

--[=[
	@prop sizeX number
	@within Video
	The videos width in pixels.
]=]

--[=[
	@prop sizeY number
	@within Video
	The videos height in pixels.
]=]

--[=[
	@prop playbackFrame number
	@within Video
	The frame the video is currently displaying
]=]

--[=[
	@prop frameRate number
	@within Video
	The videos "FPS" (frames per second).
]=]

--[=[
	@prop playing boolean
	@within Video
	Whether the video is currently playing.
]=]

--[=[
	@prop loop boolean
	@within Video
	Whether the video should loop after finishing
]=]

--[=[
	@prop frames {buffer}
	@within Video
	A set of [DrawableObject] that represent the videos frames.
]=]

return Video
