------------------------------------------------------------
-- OSGL v1.5b - Open-Source-Graphical-Library
-- Copyright © 2023-2025 OSGL (@saaawdust)
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
local enum = require(OSGL.enum)

--- @type Color number
--- @within Color
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local color = OSGL.color
--- ​
--- -- All other parameters are defaulted
--- -- to 0, except for alpha, which is
--- -- defaulted to 255.
--- local myAwesomeRedColor = color.new(255)
--- ```
export type Color = number

--- @interface WindowConfiguration
--- @within Window
--- .sizeX number -- The width of the OSGL window. The maximum width is 1024. Defaults to 100
--- .sizeY number -- The height of the OSGL window. The maximum height is 1024. Defaults to 100
---
--- An OSGL window is the representation of the EditableImage instance.
--- A window can be created by importing the OSGL '*window*' submodule:
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- ​
--- -- Creates a Window with a size of 50x50
--- local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })
--- ```
export type WindowConfiguration = {
    sizeX: number?,
    sizeY: number?,
}

--- @interface DrawableObject
--- @within DrawableObject
--- .buffer buffer -- The buffer of the object
--- .sizeX number -- The width of the object.
--- .sizeY number -- The height of the object.
--- .size Vector2 -- The size of the object as a Vector2
--- .Draw (self: DrawableObject<T>) -> DrawingContext<T> -- Returns the drawing context of the object
--- .TintRegion (self: DrawableObject<T>, tint: Color, factor: number, x: number, y: number, width: number, height: number) -> T -- Tints a region of pixels
--- .ReadPixel (self: T, x: number, y: number) -> Color -- Reads a pixel at the given X, Y
--- .WritePixel (self: T, x: number, y: number, color: Color) -> T -- Writes a pixel at the given X, Y
--- .OverwritePixel (self: T, x: number, y: number) -> T -- Writes a pixel at the given X, Y, ignoring the `AlphaBlendMode`. Faster than `WritePixel`
--- .Serialize (self: T) -> (buffer, number, number) -- Returns the object's buffer, as well as its dimensions
---
--- A DrawableObject is an item that you can draw too. This can be
--- a window, or a texture.
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- ​
--- -- Creates a Window with a size of 50x50
--- -- This window is a DrawableObject
--- local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })
--- ```
export type DrawableObject<T> = {
    buffer: buffer,
    sizeX: number,
    sizeY: number,
    size: Vector2,
    alphaBlendingMode: enum.AlphaBlendMode,

    Draw: (self: DrawableObject<T>) -> DrawingContext<T>,
    ReadPixel: (self: T, x: number, y: number) -> Color,
    WritePixel: (self: Window, x: number, y: number, color: Color) -> T,
    OverwritePixel: (self: Window, x: number, y: number, color: Color) -> T,
    TintRegion: (self: DrawableObject<T>, tint: Color, factor: number, x: number, y: number, width: number, height: number) ->  T,
    Serialize: (self: T) -> (buffer, number, number),
}


--- @within Window
--- @interface Window
--- .editableImage EditableImage -- The actual `EditableImage` instance.
--- .targetFPS number -- The FPS OSGL should aim to render at.
--- .renderers {ImageLabel | ImageButton} -- A value used internally to keep track of what the Window is rendering too
--- .Render (self: Window) -> Window -- Renders the contents of the buffer
--- .Clear (self: Window, color: Color) -> Window -- Clears the window with a color
--- .Resize (self: Window, newWidth: number, newHeight: number) -> Window -- Resizes the window to a new size
---
--- .AddRenderer (self: Window, ...ImageLabel | ImageButton) -> Window -- Adds a new renderer instance
--- .RemoveRenderer (self: Window, ...ImageLabel | ImageButton) -> Window -- Removes a renderer instance
---
--- .Deserialize (self: Window, bfr: buffer, width: number, height: number) -> Window -- Safely replaces the current window's buffer with a new buffer by resizing it to the specified width and height, preventing errors during the update
---
--- .GetRelativeMouseToRenderer (self: Window, image: ImageLabel | ImageButton) -> (boolean, number, number) -- Returns the mouse position relative to the renderer
---
--- An OSGL window is the representation of the EditableImage instance.
--- A window can be created by importing the OSGL '*window*' submodule:
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- ​
--- -- Creates a window from an existing EditableImage
--- local myWindow = Window.from(path.to.editableImage)
--- ```
export type Window = DrawableObject<Window> & {
    editableImage: EditableImage,
    targetFPS: number,
    lastRenderTime: number,
    renderers: {ImageLabel | ImageButton},

    Render: (self: Window) -> Window,
    Clear: (self: Window, color: Color) -> Window,
    Resize: (self: Window, newWidth: number, newHeight: number) -> Window,

    AddRenderer: (self: Window, ...ImageLabel | ImageButton) -> Window,
    RemoveRenderer: (self: Window, ...ImageLabel | ImageButton) -> Window,

    Deserialize: (self: Window, bfr: buffer, width: number, height: number) -> Window,

    GetRelativeMouseToRenderer: (self: Window, image: ImageLabel | ImageButton) -> (boolean, number, number)
}

--- @interface DrawingContext
--- @within DrawableObject
--- .Pixel (self: DrawingContext<V>, x: number, y: number, color: Color) -> DrawingContext<V>
--- .Line (self: DrawingContext<V>, startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: Color) -> DrawingContext<V>
--- .Rectangle (self: DrawingContext<V>, xPos: number, yPos: number, width: number, height: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>
--- .Circle (self: DrawingContext<V>, centerX: number, centerY: number, radius: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>
--- .Triangle (self: DrawingContext<V>, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, fill: Color?, stroke: Color?, strokeThickness: number?) -> DrawingContext<V>
--- .Polygon (self: DrawingContext<V>, corners: {{number}}, fill: Color) -> DrawingContext<V>
--- .FloodFill (self: DrawableObject<V>, x: number, y: number, fill: Color) -> DrawingContext<V>
--- .StopDrawing (self: DrawingContext<V>) -> V
---
--- The DrawingContext is a wrapper around [draw] that allows you to
--- to call the functions with your [DrawableObject] already passed as
--- the first argument.
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- local color = OSGL.color
--- ​
--- -- Creates a Window with a size of 50x50
--- -- This window is a DrawableObject
--- local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })
---
--- myWindow:Draw():Pixel(1, 1, color.RED):StopDrawing()
--- ```
export type DrawingContext<V> = {
    Pixel: (self: DrawingContext<V>, x: number, y: number, color: Color) -> DrawingContext<V>,
    Line: (self: DrawingContext<V>, startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: Color) -> DrawingContext<V>,
    Rectangle: (self: DrawingContext<V>, xPos: number, yPos: number, width: number, height: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>,
    Circle: (self: DrawingContext<V>, centerX: number, centerY: number, radius: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>,
    Triangle: (self: DrawingContext<V>, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, fill: Color?, stroke: Color?, strokeThickness: number?) -> DrawingContext<V>,
    Polygon: (self: DrawingContext<V>, corners: {{number}}, fill: Color) -> DrawingContext<V>,
    FloodFill: (self: DrawableObject<V>, x: number, y: number, fill: Color) -> DrawingContext<V>,
    Buffer: (self: DrawableObject<V>, bfr: buffer, sizeX: number, sizeY: number, x: number, y: number) -> DrawingContext<V>,

    StopDrawing: (self: DrawingContext<V>) -> V
}

--- @type Texture DrawableObject<T>
--- @within Texture
--- A [DrawableObject] that represents a texture.
export type Texture<T> = DrawableObject<T>

--- @interface Video
--- @within Video
---
--- .sizeX number -- The videos width.
--- .sizeX number -- The videos height.
--- .playbackFrame number -- Which frame the video is playing.
--- .frameRate number -- How many frames-per-second to display.
--- .playing boolean -- Whether the video is playing or not.
--- .loop boolean -- Whether the video should loop after finishing.
--- .frames {buffer} -- A set of [DrawableObject] that represent the videos frames.
---
--- .PlaySync (self: Video<T>, callback: (texture: Texture<T>) -> ()) -> Video<T>
--- .PlayAsync (self: Video<T>, callback: (texture: Texture<T>) -> ()) -> Video<T>
--- .Stop (self: Video<T>) -> Video<T>
--- .GetFrame (self: Video<T>, frame: number) -> Texture<T>
--- .GetBufferOfFrame (self: Video<T>, frame: number) -> buffer
--- .Previous: (self: Video<T>) -> Video<T>
--- .Next: (self: Video<T>) -> Video<T>
---
--- An animatable set of [DrawableObject] that represents a video.
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- local Video = OSGL.Video
--- local Texture = OSGL.Texture
--- ​
--- -- Creates a Window with a size of 50x50
--- -- This window is a DrawableObject
--- local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })
--- ㅤ
--- local frames = -- Reference to texture-data
--- local video = Video.from(frames)
--- video.frameRate = 60
--- video.loop = true
--- 
--- video:PlaySync(function(texture)
---     Texture.draw(myWindow, texture, 0, 0)
---     myWindow:Render()
--- end)
--- ```
export type Video<T> = {
    sizeX: number,
    sizeY: number,
    playbackFrame: number,
    frameRate: number,
    playing: boolean,
    loop: boolean,
    frames: {buffer},

    PlaySync: (self: Video<T>, callback: (texture: Texture<T>) -> ()) -> Video<T>,
    PlayAsync: (self: Video<T>, callback: (texture: Texture<T>) -> ()) -> Video<T>,

    Stop: (self: Video<T>) -> Video<T>,

    GetFrame: (self: Video<T>, frame: number) -> Texture<T>,
    GetBufferOfFrame: (self: Video<T>, frame: number) -> buffer,

    Previous: (self: Video<T>) -> Video<T>,
    Next: (self: Video<T>) -> Video<T>,
}

--- @type Glyph number | buffer | { number }
--- @within Font
--- The representation of a letter in a font made with the `converter` exe provided with the module.
export type Glyph = {
    number | buffer | { number }
}

--- @type Glyphs { [string]: Glyph }
--- @within Font
--- A group of letters
export type Glyphs = { [string]: Glyph }

--- @type StoredFont { version: string, letters: Glyphs }
--- @within Font
--- The representation of a font made with the `converter` exe provided with the module.
export type StoredFont = {
    version: string,
    letters: Glyphs,
    maxHeight: number,
}

--- @type Font { glyphs: Glyphs, spacing: number, linePadding: number }
--- @within Font
--- A loaded font
export type Font = {
    glyphs: Glyphs,

    spacing: number,
    linePadding: number,

    Draw:<T>(self: Font, object: DrawableObject<T>, text: string, x: number, y: number, color: Color) -> Font,
}

--- @type FlagTexture { version: string, width: number, height: number, pixels: buffer, }
--- @within Texture
--- The representation of a texture made with the `converter` exe provided with the module.
export type FlagTexture = {
    version: string,

    width: number,
    height: number,
    pixels: buffer,
}

return nil
