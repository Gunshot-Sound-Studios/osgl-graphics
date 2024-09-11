local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local writePixel = require(OSGL.draw.writePixel)

return function(
	window: types.Drawable,
	circle: {
		centerX: number,
		centerY: number,
		radius: number,
		fillColor: types.Color?,
		strokeColor: types.Color?,
		strokeThickness: number?,
		rotation: number?,
	}
)
	circle.fillColor = circle.fillColor or color.BLACK
	circle.rotation = circle.rotation or 0
	circle.strokeColor = circle.strokeColor or color.TRANSPARENT
	circle.strokeThickness = circle.strokeThickness or 0

	local radius = circle.radius
	local strokeThickness = if circle.strokeColor ~= color.TRANSPARENT then circle.strokeThickness else 0

	local sizeX, sizeY = window.sizeX, window.sizeY
	local radians = circle.rotation * (math.pi / 180)
	local cosTheta = math.cos(radians)
	local sinTheta = math.sin(radians)

	local radiusSquared = radius * radius
	local totalRadius = strokeThickness + radius
	local strokeSquared = totalRadius * totalRadius

	for y = -totalRadius, totalRadius do
		local ySquared = y * y

		for x = -totalRadius, totalRadius do
			local distance = x * x + ySquared

			if distance <= strokeSquared then
				local pixelColor = if distance <= radiusSquared then circle.fillColor else circle.strokeColor

				local rotatedX = x * cosTheta - y * sinTheta
				local rotatedY = x * sinTheta + y * cosTheta

				local pixelX = math.floor(circle.centerX + rotatedX + 0.5) -- Snap to nearest pixel
				local pixelY = math.floor(circle.centerY + rotatedY + 0.5)

				-- Bounds check and pixel writing
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					writePixel(sizeX, window, pixelX, pixelY, pixelColor)
				end
			end
		end
	end
end
