--!optimize 2
--!strict

--========================================================================
-- OSGL 1.1
--------------------------------------------------------------------------
-- Copyright (c) 2023-2024 | Gunshot Sound Studios | ShadowX
--
-- This software is provided 'as-is', without any express or implied
-- warranty. In no event will the authors be held liable for any damages
-- arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it
-- freely, subject to the following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
--    claim that you wrote the original software. If you use this software
--    in a product, an acknowledgment in the product documentation would
--    be appreciated but is not required.
--
-- 2. Altered source versions must be plainly marked as such, and must not
--    be misrepresented as being the original software.
--
-- 3. This notice may not be removed or altered from any source
--    distribution.
--
--========================================================================

---------------

local enumerator = {
	WindowSize = {
		Maximum = 0,
		Minimum = 1,
		Mutuable = 2,
	},
	
	Font = {
		Default = 3
	}
	
} :: OSGLEnum

export type OSGLEnum = {
	WindowSize: OSGLWindowSize,
	Font: OSGLFonts
}

export type OSGLWindowSize = {
	Maximum: Vector2,
	Minimum: Vector2,
	Mutuable: typeof(enumerator.WindowSize.Mutuable),
}

export type OSGLFonts = {
	Default: Font
}

---------------

export type windowParameters = {
	Size: any? |  Vector2?,
	Instance: GuiObject,
	Name: string?
}

export type Window = (windowParams: windowParameters?) -> (WindowRenderingContext)

-- WindowRenderingContext has a few "secret" properties.
-- "DoubleBuffer" is an array containing draw commands.
export type WindowRenderingContext = {
	Renderer: EditableImage,
	Size: Vector2,
	
	Clear: (self: WindowRenderingContext, Color: RGBA) -> nil,
	IsOpen: (self: WindowRenderingContext, yieldAmount: number?) -> boolean,
	
	Render: (self: WindowRenderingContext) -> nil,
	
	GetRelativeMousePosition: (self: WindowRenderingContext) -> Vector2?,
	GtRelativeMousePositionOnScreen: (self: WindowRenderingContext) -> Vector2,
	
	Draw: (self: WindowRenderingContext, ...renderableObjects) -> nil,
	ReadRGBA: (self: WindowRenderingContext, Position: Vector2) -> RGBA,
}

export type RenderCommand = {
	Name: string,
	Args: {
		[string]: any
	}
}

export type RegisteredCommand = {
	Command: string,
	Data: {
		[string?]: string
	}
}

---------------

export type Error = {
	Message: string,
}

---------------

export type RGBA = {
	Red: number,
	Green: number,
	Blue: number,
	Alpha: number,
}

---------------

export type Texture = {
	Texture: string,
	Rect: {
		StartingPos: Vector2,
		Dimensions: Vector2
	}?
} 

export type Sprite = {
	Texture: Texture,
	Color: number,
	Position: Vector2,
	Scale: Vector2,
}

export type EditableTexture = {
	Finish: (self: EditableTexture) -> (string),
	SetPixel: (self: EditableTexture, Position: Vector2, Color: RGBA) -> (),
	SetPixels: (self: EditableTexture, Size: Vector2, Position: Vector2, Color: RGBA) -> (),
	
	GetPixel: (self: EditableTexture) -> (RGBA?),
	GetPixels: (self: EditableTexture) -> ({{{RGBA}}}),
}

---------------

export type Text = {
	Text: string,
	Font: Font,
	Position: Vector2,
	Color: RGBA
}

export type OSGLFont = {[string]: Glyph}
export type Glyph = {width: number, height: number, pixels: {number}}

---------------

export type renderableObjects = Text | Sprite | any

return enumerator