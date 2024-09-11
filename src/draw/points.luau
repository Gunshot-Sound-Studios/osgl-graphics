local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local log = require(OSGL.log)
local fillPolygon = require(OSGL.draw.fillPolygon)

return function(
	window: types.Drawable,
	points: { x: number, y: number, points: types.Points, fillColor: types.Color }
)
	log.cassert(points.x >= 0, "X position must be higher or equal to 0")
	log.cassert(points.y >= 0, "Y position must be higher or equal to 0")
	log.cassert(#points.points >= 3, "Shapes must have atleast 3 points")

	points.fillColor = points.fillColor or color.RED
	points.points = points.points or {}

	fillPolygon(points.points, window, points.fillColor)
end
