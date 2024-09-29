local OSGL = script.Parent.Parent
local types = require(OSGL.types)

return function<P>(SIZE_X: number, window: types.DrawableObject<P>, x: number, y: number, color: types.Color)
	window:WritePixel(x, y, color)
end
