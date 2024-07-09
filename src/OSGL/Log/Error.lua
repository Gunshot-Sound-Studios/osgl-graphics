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

local Types = require(script.Parent.Parent.Types)

local ERROR_DIVIDE = "\n------ OSGL Error ------\n"

local OSGLErrorHandler = {}

local function describeStack()
	local stack = {}
	local blanksEncountered = 0 --// Roblox error!

	for errorIndex = 1, math.huge do
		local s, r = pcall(function() 
			error("", errorIndex) 	
		end)

		if r == "" then
			blanksEncountered += 1
			
			if blanksEncountered > 1 then
				break
			end
		end

		table.insert(stack, r)
	end
	
	local function parseErrorString(errorString: string)
		local mainPart, lineNumber = string.match(errorString, "(.+):(%d+)")

		local parts = {}
		for part in string.gmatch(mainPart or "", "[^%.]+") do
			table.insert(parts, part)
		end

		local header = parts[#parts - 1]
		local script = parts[#parts]

		return {
			Header = header,
			Script = script,
			Line = tonumber(lineNumber)
		}
	end
	
	for i, v in ipairs(stack) do
		if v == "" then stack[i] = nil continue end
		local parsedError = parseErrorString(v)
		if parsedError.Script == "Error" and parsedError.Header == "OSGL" then
			stack[i] = nil
			continue
		else
			stack[i] = `{parsedError.Header}/{parsedError.Script}.luau: Line {parsedError.Line}`
		end
	end
	
	local i = 1
	repeat
		if stack[i] == nil then
			table.remove(stack, i)
		else
			i += 1
		end
	until i == #stack
	
	return stack
end

function OSGLErrorHandler.new(Err: string | Types.Error): Types.Error
	if type(Err) == "string" then
		Err = {
			Message = Err,
		}
	end
	
	return Err :: Types.Error
end

function OSGLErrorHandler.display(Err: Types.Error, Config: { CustomFunc: (...string) -> ()?, ShowStack: boolean?, CustomDiv: string? }?)
	local describedStack = `Stack:\n\n{table.concat(describeStack(), "\n")}`
	
	local CustomFunc = error
	local div = ERROR_DIVIDE
	local stackLevel = 0
	
	if Config then
		if Config.CustomFunc then
			CustomFunc = Config.CustomFunc
		end
		
		if Config.ShowStack ~= nil and Config.ShowStack == false then
			describedStack = ""
			stackLevel = ""
		end
		
		if Config.CustomDiv then
			div = Config.CustomDiv
		end
	end
	
	
	
	CustomFunc(`{div}{Err.Message}\n{div}\n{describedStack}`, stackLevel)
end

return OSGLErrorHandler