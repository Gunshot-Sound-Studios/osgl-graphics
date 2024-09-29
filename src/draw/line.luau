local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local writePixel = require(OSGL.draw.writePixel)

return function<P>(
	window: types.DrawableObject<P>,
	line: {
		startX: number,
		startY: number,
		stopX: number,
		stopY: number,
		thickness: number?,
		color: types.Color?,
	}
)
	line.thickness = line.thickness or 1
	line.color = line.color or color.BLACK

	local sizeX, sizeY = window.sizeX, window.sizeY

	local dx = line.stopX - line.startX
	local dy = line.stopY - line.startY

	local steps = math.max(math.abs(dx), math.abs(dy))

	local xIncrement = dx / steps
	local yIncrement = dy / steps

	local x = line.startX
	local y = line.startY

	local function drawThickPoint(px: number, py: number, thickness: number)
		local halfThickness = thickness / 2
		for offsetX = -halfThickness, halfThickness do
			for offsetY = -halfThickness, halfThickness do
				local pixelX = math.floor(px + offsetX + 0.5)
				local pixelY = math.floor(py + offsetY + 0.5)
				if pixelX >= 0 and pixelX < sizeX and pixelY >= 0 and pixelY < sizeY then
					writePixel(sizeX, window, pixelX, pixelY, line.color)
				end
			end
		end
	end

	for _ = 0, steps do
		drawThickPoint(x, y, line.thickness)
		x += xIncrement
		y += yIncrement
	end
end
