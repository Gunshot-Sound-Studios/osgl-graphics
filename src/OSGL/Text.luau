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

local HttpService = game:GetService("HttpService")

local TextPublic = {}
local TextPrivate = {}

local Types = require(script.Parent.Types)
local Color = require(script.Parent.Color)
local Fonts = require(script.Parent.Window.Render.Fonts)
local Log = require(script.Parent.Log)

local error = Log.error

TextPrivate.__index = TextPrivate

function TextPublic.new(Text: string?): Types.Text
	local self = {
		Command = "DrawText",
		
		Text = Text or "",
		Font = Types.Font.Default,

		Position = Vector2.zero,
		Color = Color.Black
	}
	
	return setmetatable(self, TextPrivate)
end

function TextPublic.newFont(Code: string, KeyCodes: Types.OSGLFont, Config: {capsOnly: boolean?, lowerOnly: boolean?}?)
	if typeof(Code) ~= "string" then
		error(`The function 'text.newFont' must be a string.\nGot type: '{typeof(Code)}'`)
	end
	
	if (Config) then
		KeyCodes["__config"] = Config
	end
	
	local bfr = Fonts.__bufferCreate__(KeyCodes)
	
	Fonts[Code] = bfr
	return Code
end

function TextPublic.getAllFonts()
	return Fonts
end

function TextPublic.getFont(Code: string): Types.OSGLFont?
	if not Code or Code == "__bufferCreate__" then return end
	if not Fonts[Code] then return end
	
	local bfr = Fonts[Code]
	
	return HttpService:JSONDecode(buffer.readstring(bfr, 0, buffer.len(bfr)))
end

function TextPublic.removeFont(Code: string): Types.OSGLFont?
	if Code == "3" or Code == "__bufferCreate__" then return end
	if not Fonts[Code] then return end
	
	local buffered = Fonts[Code]
	Fonts[Code] = nil
	
	return HttpService:JSONDecode(buffer.readstring(buffered, 0, buffer.len(buffered)))
end

function TextPublic.getGlyphFromFont(Code: string, Character: string): Types.Glyph?
	if not Code or not Character then return end
	if Code == "__bufferCreate__" then return end
	if not Fonts[Code] then return end
	
	local bfrdFont = TextPublic.getFont(Code)
	
	return bfrdFont[Character]
end

return TextPublic