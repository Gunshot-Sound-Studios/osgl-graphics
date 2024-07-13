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

local Types = require(script.Parent.Types)
local Log = require(script.Parent.Log)
local Color = require(script.Parent.Color)

local error = Log.error

local SpritePublic = {}
local SpritePrivate = {}

SpritePrivate.__index = SpritePrivate

function SpritePublic.new(Texture: Types.Texture): Types.Sprite
	if not Texture then
		error([[Function 'sprite.new' requires all parameters to be passed
No parameters were passed at all.
Did you forget to pass the parameters?

sprite.new(texture)

PARAMETERS ^^^]])
	end
	
	local self = {
		Command = "DrawSprite",
		
		Texture = Texture,
		Color = 1,
		Position = Vector2.zero,
		Scale = Vector2.one
	}
	
	return setmetatable(self, SpritePrivate)
end

return SpritePublic