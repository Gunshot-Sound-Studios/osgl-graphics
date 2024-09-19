local OSGL = script.Parent.Parent
local types = require(OSGL.types)

return function(SIZE_X: number, window: types.Drawable, x: number, y: number, color: types.Color)
	window:WritePixel(x, y, color)
end
