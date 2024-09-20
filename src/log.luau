------------------------------------------------------------
-- OSGL v1.2b - Open-Source-Graphical-Library
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

local debug = debug
local warn = warn
local error = error

local log = {}

function log.typeCheckArgument(fnName: string, argName: string, argument: any, expectedType: string)
    if not argument or not argument:isA(expectedType) then
        log.error(`Argument '{argName}' of function '{fnName}' was not passed or was not of type '{expectedType}'.`)
    end

    return
end

local DIVIDE_ERR = "\n------ OSGL Error ------\n"
function log.error(message: string)
	local stack = `Stack: {debug.traceback(nil, 2)}`
    return log.doLog(error, DIVIDE_ERR, message, stack)
end

function log.cassert(value: boolean, message: string)
    if not value then log.error(message) end
end

local DIVIDE_WARN = "\n------ OSGL Warn ------\n"
function log.warn(message: string)
	local stack = `Stack: {debug.traceback(nil, 2)}`
    return log.doLog(warn, DIVIDE_WARN, message, stack)
end


function log.doLog(logType: any, header: string, message: string, stack: string)
    logType(`{header}{message}{header}{stack}`, logType == error and 0 or "")
end

return log
