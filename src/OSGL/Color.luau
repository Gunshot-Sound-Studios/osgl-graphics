--!optimize 2
--!strict
--!native


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

local Type = require(script.Parent.Types)

local RGBA_Public = {}
local RGBA = {}
RGBA.__index = RGBA

RGBA.__tostring = function(self: Type.RGBA)
	return `{self.Red}, {self.Green}, {self.Blue}, {self.Alpha}`
end

RGBA.__add = function(lhs, rhs)
	if lhs and typeof(lhs) == "table" and lhs.Alpha and rhs and typeof(rhs) == "table" and rhs.Alpha then
		local lhsRgb = Color3.fromRGB(lhs.Red or 0, lhs.Green or 0, lhs.Blue or 0) :: Color3
		local rhsRgb = Color3.fromRGB(rhs.Red or 0, rhs.Green or 0, rhs.Blue or 0) :: Color3
		local mixed = lhsRgb:Lerp(rhsRgb, .5)

		return RGBA_Public.new(mixed.R * 255, mixed.G * 255, mixed.B * 255, (lhs.Alpha or 0 + rhs.Alpha or 0) / 2)
	end

	return RGBA_Public.new()	
end

RGBA.__sub = function(lhs, rhs)
	if lhs and typeof(lhs) == "table" and lhs.Alpha and rhs and typeof(rhs) == "table" and rhs.Alpha then
		local red = (lhs.Red or 0) - (rhs.Red or 0)
		local green = (lhs.Green or 0) - (rhs.Green or 0)
		local blue = (lhs.Blue or 0) - (rhs.Blue or 0)
		local alpha = (lhs.Alpha or 0) - (rhs.Alpha or 0)

		return RGBA_Public.new(red, green, blue, alpha)
	end

	return RGBA_Public.new()   
end

RGBA.__div = function(lhs, rhs)
	if lhs and typeof(lhs) == "table" and lhs.Alpha and rhs and typeof(rhs) == "number" then
		local red = (lhs.Red or 0) / rhs
		local green = (lhs.Green or 0) / rhs
		local blue = (lhs.Blue or 0) / rhs
		local alpha = (lhs.Alpha or 0) / rhs

		return RGBA_Public.new(red, green, blue, alpha)
	end

	return RGBA_Public.new()   
end

RGBA.__mul = function(lhs, rhs)
	if lhs and typeof(lhs) == "table" and lhs.Alpha and rhs and typeof(rhs) == "number" then
		local red = (lhs.Red or 0) * rhs
		local green = (lhs.Green or 0) * rhs
		local blue = (lhs.Blue or 0) * rhs
		local alpha = (lhs.Alpha or 0) * rhs

		return RGBA_Public.new(red, green, blue, alpha)
	end

	return RGBA_Public.new()   
end

local function hsvToRgb(hue: number, saturation: number, value: number): Color3
	local red, green, blue

	local sector = math.floor(hue * 6)
	local fraction = hue * 6 - sector
	local p = value * (1 - saturation)
	local q = value * (1 - fraction * saturation)
	local t = value * (1 - (1 - fraction) * saturation)

	sector = sector % 6

	if sector == 0 then 
		red, green, blue = value, t, p
	elseif sector == 1 then 
		red, green, blue = q, value, p
	elseif sector == 2 then 
		red, green, blue = p, value, t
	elseif sector == 3 then 
		red, green, blue = p, q, value
	elseif sector == 4 then 
		red, green, blue = t, p, value
	elseif sector == 5 then 
		red, green, blue = value, p, q
	end

	return Color3.fromRGB(red * 255, green * 255, blue * 255)
end

-- Creates a RGBA value (Red, Green, Blue, Alpha)
function RGBA_Public.new(Red: number?, Green: number?, Blue: number?, Alpha: number?): Type.RGBA
	Red = Red or 0
	Green = Green or 0
	Blue = Blue or 0
	Alpha = Alpha or 0

	local t = {
		Red = Red,
		Green = Green,
		Blue = Blue,
		Alpha = Alpha
	}

	return setmetatable(t, RGBA)
end

-- Converts a RGB value to a RGBA value (Red, Green, Blue, Alpha)
function RGBA_Public.fromRGB(Red: number?, Green: number?, Blue: number?): Type.RGBA
	Red = Red or 0
	Green = Green or 0
	Blue = Blue or 0

	if typeof(Red) == "number" then
		return RGBA_Public.new(Red, Green, Blue)
	end

	return RGBA_Public.new()
end

-- Converts a HSV value to a RGBA value (Red, Green, Blue, Alpha)
function RGBA_Public.fromHSV(Hue: number?, Saturation: number?, Value: number?): Type.RGBA

	Hue = Hue or 0
	Saturation = Saturation or 0
	Value = Value or 0

	if typeof(Hue) == "number" then
		local rgbHsv = hsvToRgb(Hue, Saturation, Value)
		return RGBA_Public.new(rgbHsv.R * 255, rgbHsv.G * 255, rgbHsv.B*255)
	end

	return RGBA_Public.new()
end

-- Converts a HEX value to a RGBA value (Red, Green, Blue, Alpha)
function RGBA_Public.fromHex(HexValue: string?): Type.RGBA
	HexValue = HexValue or "#FFFFFF"

	if typeof(HexValue) == "string" then
		return RGBA_Public.fromRGB(Color3.fromHex(HexValue))
	end

	return RGBA_Public.new()
end

-- Converts a RGBA value (Red, Green, Blue, Alpha) to a RGB value
function RGBA_Public.toRGB(Color: Type.RGBA): (Color3, number)
	local color = Color3.fromRGB(Color.Red, Color.Green, Color.Blue)

	return color, Color.Alpha / 255
end

RGBA_Public.WHITE = RGBA_Public.new(255, 255, 255, 0)
RGBA_Public.BLACK = RGBA_Public.new(0, 0, 0, 0)
RGBA_Public.RED = RGBA_Public.new(255, 0, 0, 0)
RGBA_Public.GREEN = RGBA_Public.new(0, 255, 0, 0)
RGBA_Public.BLUE = RGBA_Public.new(0, 0, 255, 0)
RGBA_Public.YELLOW = RGBA_Public.new(255, 255, 0, 0)
RGBA_Public.MAGENTA = RGBA_Public.new(255, 0, 255, 0)
RGBA_Public.CYAN = RGBA_Public.new(0, 255, 255, 0)
RGBA_Public.TRANSPARENT = RGBA_Public.new(0, 0, 0, 255)

function RGBA_Public.random(setR: number?, setG: number?, setB: number?, setA: number?): Type.RGBA
	local rand = Random.new()
	return RGBA_Public.new(setR or rand:NextInteger(0, 255), setG or rand:NextInteger(0, 255), setB or rand:NextInteger(0, 255), setA or rand:NextInteger(0, 255))
end


return RGBA_Public