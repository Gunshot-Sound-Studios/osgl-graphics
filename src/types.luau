------------------------------------------------------------
-- OSGL v1.1 - Open-Source-Graphical-Library
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

--- @interface Window
--- @within Window
--- .renderer EditableImage -- The actual EditableImage instance
--- .pixels {Buffer} -- The double-buffer. An array of buffers containing RGBA values
---
--- An OSGL window is the representation of the EditableImage instance.
--- A window can be created by importing the OSGL '*window*' submodule:
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- ​
--- --// Creates a window from an existing EditableImage
--- local myWindow = Window.from(path.to.editableImage)
--- ```
export type Window = {
    renderer: EditableImage,
    pixels: {buffer},

    IsOpen: (self: Window, yield: number?) -> boolean,
    Render: (self: Window) -> nil
}

--- @interface WindowConfiguration
--- @within Window
--- .sizeX number -- The width of the OSGL window. The maximum width is 1024. Defaults to 100
--- .sizeY number -- The height of the OSGL window. The maximum height is 1024. Defaults to 100
---
--- An OSGL window is the representation of the EditableImage instance.
--- A window can be created by importing the OSGL '*window*' submodule:
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Window = OSGL.Window
--- ​
--- --// Creates an EditableImage with a size of 50x50
--- local myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })
--- ```
export type WindowConfiguration = {
    sizeX: number,
    sizeY: number
}

--- @interface RGBA
--- @within Color
--- .buffer buffer -- A color buffer containing color data
---
--- ```lua
--- local OSGL = require(path.to.osgl)
--- local Color = OSGL.Color
--- ​
--- --// All other parameters are defaulted
--- --// to 0, except for alpha, which is
--- --// defaulted to 255.
--- local myAwesomeRedColor = RGBA.new(255)
--- ```
export type RGBA = {
    buffer: buffer,

    ToColor3: () -> (Color3, number),
    ToHex: () -> (string, number),
    Read: () -> { R: number, G: number, B: number, A: number },
    Set: (red: number?, green: number?, blue: number?, alpha: number?) -> (),
}

return nil