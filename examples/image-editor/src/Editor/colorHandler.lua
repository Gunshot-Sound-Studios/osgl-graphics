local OSGL = require(script.Parent.Parent.OSGL)
local color = OSGL.color
local OSGLTypes = OSGL.types

local colorHandler = {}

function colorHandler.toHex(rgba: OSGLTypes.Color): string
	return string.format("#%02X%02X%02X", color.r(rgba) * 0xFF, color.g(rgba) * 0xFF, color.b(rgba) * 0xFF)
end

function colorHandler.r(UI)
	local colorProp = UI.propertiesUi.color
	local R = tonumber(colorProp.R_Input.Text) or 0

	return R
end

function colorHandler.g(UI)
	local colorProp = UI.propertiesUi.color
	local G = tonumber(colorProp.G_Input.Text) or 0

	return G
end

function colorHandler.b(UI)
	local colorProp = UI.propertiesUi.color
	local B = tonumber(colorProp.B_Input.Text) or 0

	return B
end

function colorHandler.getRGB(UI)
	return color.new(colorHandler.r(UI), colorHandler.g(UI), colorHandler.b(UI))
end

return colorHandler
