local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local fillPolygon = require(OSGL.draw.fillPolygon)
local writePixel = require(OSGL.draw.writePixel)

return function<P>(
	window: types.Drawable<P>,
	rectangle: {
		xPos: number,
		yPos: number,
		width: number,
		height: number,
		fillColor: types.Color?,
		strokeColor: types.Color?,
		strokeThickness: number?,
		rotation: number?,
	}
)
	rectangle.fillColor = rectangle.fillColor or color.TRANSPARENT
	rectangle.rotation = rectangle.rotation or 0
	rectangle.strokeColor = rectangle.strokeColor or color.TRANSPARENT
	rectangle.strokeThickness = rectangle.strokeThickness or 0

	local strokeLength = if rectangle.strokeColor ~= color.TRANSPARENT then rectangle.strokeThickness else 0

	local sizeX, sizeY = window.sizeX, window.sizeY

	local centerX = rectangle.xPos + rectangle.width / 2
	local centerY = rectangle.yPos + rectangle.height / 2

	if rectangle.rotation % 90 == 0 then
		local width, height

		if rectangle.rotation % 180 == 0 then
			width, height = rectangle.width, rectangle.height
		else
			width, height = rectangle.height, rectangle.width
		end

		width += strokeLength
		height += strokeLength

		for x = 1, width do
			x += rectangle.xPos
			if x >= sizeX then
				break
			end

			for y = 1, height do
				y += rectangle.yPos
				if y >= sizeY then
					break
				end

				local pixelColor = if x > width or y > height then rectangle.strokeColor else rectangle.fillColor

				writePixel(sizeX, window, x, y, pixelColor)
			end
		end

		return
	end

	local radians = rectangle.rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local function rotatePoint(x, y)
		local relativeX = x - centerX
		local relativeY = y - centerY
		local rotatedX = relativeX * cosTheta - relativeY * sinTheta
		local rotatedY = relativeX * sinTheta + relativeY * cosTheta
		return centerX + rotatedX, centerY + rotatedY
	end

	local x0, y0 = rotatePoint(rectangle.xPos, rectangle.yPos)
	local x1, y1 = rotatePoint(rectangle.xPos + rectangle.width, rectangle.yPos)
	local x2, y2 = rotatePoint(rectangle.xPos + rectangle.width, rectangle.yPos + rectangle.height)
	local x3, y3 = rotatePoint(rectangle.xPos, rectangle.yPos + rectangle.height)

	fillPolygon({
		{ x0, y0 },
		{ x1, y1 },
		{ x2, y2 },
		{ x3, y3 },
	}, window, rectangle.fillColor)
end
