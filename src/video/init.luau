------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
-- Copyright © 2023-2024 Gunshot Sound Studios (@saaawdust)
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

local Video = {}

function Video.new(width: number, height: number, frames: { buffer }?)
	return {
		sizeX = width,
		sizeY = height,
		playbackFrame = 1,
		frames = frames or {},

        PlaySync = function<T>(self: types.Video<T>, callback: (texture: types.Texture<T>) -> ())
            local frames = #self.frames
            local timePerFrame = 1 / #frames

            while self.playing do
                self.playbackFrame += 1
                if self.playbackFrame >= frames then
                    self.playing = false
                    break
                end

                callback(
                    Texture.new(self.sizeX, self.sizeY, self.frames[self.playbackFrame])
                )

                task.wait(timePerFrame)
            end
        end,

        Next = function<T>(self: types.Video<T>)
            local len = #self.frames
            if self.playbackFrame < len then
                self.playbackFrame += 1
            end

            return self
        end,

        Previous = function<T>(self: types.Video<T>)
            if self.playbackFrame > 0 then
                self.playbackFrame -= 1
            end

            return self
        end,
	}
end

return Video
