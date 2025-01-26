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
local types = require(OSGL.types)
local utils = require(OSGL.utils)
local log = require(OSGL.log)
local draw = require(OSGL.draw)

--[=[
    @class Font

    The Font class handles loading and rendering of fonts.
]=]
local Font = {}

local function readBitNumber(n: number, position: number): number
	return bit32.extract(n, position, 1)
end

function splitStringWithEscapeSequences(input: string)
	local result = {}
	local i = 1
	local length = #input

	while i <= length do
		local char = input:sub(i, i)
		local nextChar = input:sub(i + 1, i + 1)

		if char == "\\" and (nextChar == "t" or nextChar == "n") then
			table.insert(result, "\\" .. nextChar)
			i = i + 2
		else
			table.insert(result, char)
			i = i + 1
		end
	end

	return result
end

function Font.Draw<T>(
	self: types.Font,
	object: types.DrawableObject<T>,
	text: string,
	x: number,
	y: number,
	color: types.Color
)
	local letters = splitStringWithEscapeSequences(text)

	local glyphs = self.glyphs
	local iSize = glyphs["i"][1]
    local iWidth = bit32.extract(iSize, 16, 16)

    local originalX = x

	for _, letter in ipairs(letters) do
		local glyph = glyphs[letter]

		if letter == " " then
			x += iWidth
			continue
		elseif letter == "\n" then
            x = originalX
            y += self.linePadding
            continue
        elseif letter == "\t" then
            x += iWidth * 4
            continue
		end

		if glyph then
			local size = glyph[1] :: number
			local height = bit32.extract(size, 0, 16)
			local width = bit32.extract(size, 16, 16)
			local pixelData = glyph[2]

			if typeof(pixelData) == "buffer" then
				local index = 0
				for fw = 1, width do
					for fh = 1, height do
						local bit = buffer.readu8(pixelData, index)
						if bit == 1 then
							draw.pixel(object, x + fw, y + fh, color)
						end

						index += 1
					end
				end
			else
				for fh = 1, height do
					for fw = 1, width do
						local bit = readBitNumber(pixelData[fw], fh)
						if bit == 1 then
							draw.pixel(object, x + fw, y + fh, color)
						end
					end
				end
			end

			x += width + self.spacing
		end
	end
end

function Font.from(data: types.StoredFont): types.Font
	local v = data.version
	if v and not table.find(utils.VALID_FONT_VERSIONS, v) then
		local fontVers = utils.VALID_FONT_VERSIONS

		log.error(
			"Font version mismatch. Expected any version from "
				.. fontVers[1]
				.. " to "
				.. fontVers[#fontVers]
				.. ", got version "
				.. v
				.. ". This may cause unexpected behavior."
		)
	end

	return {
		glyphs = data.letters,

		spacing = 5,
        linePadding = 0,

		Draw = Font.Draw,
	}
end

return Font
