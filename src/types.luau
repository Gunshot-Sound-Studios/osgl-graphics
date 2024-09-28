------------------------------------------------------------
-- OSGL v1.3b - Open-Source-Graphical-Library
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

---@diagnostic disable: undefined-doc-name
-- ^^ for Luau LSP

local OSGL = script.Parent
local privateTypes = require(OSGL.DrawableObject.types)

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

--- @interface Window
--- @within Window
--- .renderer EditableImage -- The actual `EditableImage` instance.
--- .pixels { Color } -- An array of color values.
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
export type Window<P> = {
    renderer: EditableImage,
    pixelStorage: privateTypes.PixelStorage<P>,

    IsOpen: (self: Window<P>, yield: number?) -> boolean,
    Render: (self: Window<P>) -> nil,
    Clear: (self: Window<P>, clearColor: Color) -> (),
    Resize: (self: Window<P>, newWidth: number?, newHeight: number?) -> (),
    GetRelativeMouse: (self: Window<P>) -> (number, number),
    ReadPixel: (self: Window<P>, x: number, y: number) -> Color,
    WritePixel: (self: Window<P>, x: number, y: number, newColor: Color) -> (),
}

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

--- @type FlagTexture { width: number, height: number, pixels: { Color | string }, }
--- @within Texture
--- The representation of a texture made with the `converter` exe provided with the module.
export type FlagTexture = {
    width: number,
    height: number,
    pixels: { number | string },
}

--- @interface Texture
--- @within Texture
--- .pixelStorage PixelStorage -- The raw-bytes of the texture
--- .sizeX number -- The width of the texture
--- .sizeY number -- The height of the texture
---
--- A `Texture` can be drawn onto a `Sprite` to be displayed on-screen.
--- Textures are simply an array of colors.
export type Texture<P> = {
    pixelStorage: privateTypes.PixelStorage<P>,
    sizeX: number,
    sizeY: number
}

--- @interface Sprite
--- @within Sprite
--- .texture Texture -- The sprites' texture
--- .color Color -- The color of the sprite
--- .x number -- The X position of the sprite
--- .y number -- The Y position of the sprite
---
--- A `Sprite` can be drawn onto onto the screen to display a `Texture`
export type Sprite<P> = {
    texture: Texture<P>,
    x: number,
    y: number,

    Draw: (self: Sprite<P>, window: Window<P>) -> ()
}

--- @type Points { {number} }
--- @within Draw
--- An array of points
export type Points = {{number}}

--- @type Drawable Window | Texture
--- @within Draw
--- An object that contains a buffer. You can draw to these objects.
export type Drawable<P> = Window<P> | Texture<P>

export type DrawableObject<P> = {
    pixelStorage: privateTypes.PixelStorage<any>,
    sizeX: number,
    sizeY: number,
    size: Vector2,

    GetRelativeMouse: (self: Window<P>) -> (number, number),
    ReadPixel: (self: Window<P>, x: number, y: number) -> Color,
    WritePixel: (self: Window<P>, x: number, y: number, newColor: Color) -> (),
    Tint: (self: DrawableObject<P>, tint: Color, tintFactor: number) -> (),
    TintRegion: (
        self: DrawableObject<P>,
        tint: Color,
        tintFactor: number,
        x: number,
        y: number,
        width: number,
        height: number
    ) -> (),
    FloodFill: (self: DrawableObject<P>, newColor: Color, x: number?, y: number?) -> (),
}

return nil
