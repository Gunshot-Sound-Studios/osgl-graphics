local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local writePixel = require(OSGL.draw.writePixel)

return function(corners: { { number } }, window: types.Drawable, fillColor: types.Color)
	-- These are temporary, cause
	-- if i calculate it, it takes up
	-- like 10FPS

	local sizeX = window.sizeX
	local maxY = window.sizeY

    for y = 0, maxY do
        local intersections = {}

        for i = 1, #corners do
            local p1 = corners[i]
            local p2 = corners[i % #corners + 1]

            if (p1[2] <= y and p2[2] > y) or (p2[2] <= y and p1[2] > y) then
                local t = (y - p1[2]) / (p2[2] - p1[2])
                local intersectX = p1[1] + t * (p2[1] - p1[1])
                table.insert(intersections, intersectX)
            end
        end

        table.sort(intersections)

        for i = 1, #intersections - 1, 2 do
            local startX = math.max(0, math.floor(intersections[i]))
            local endX = math.min(sizeX - 1, math.ceil(intersections[i + 1]))

            for x = startX, endX do
                writePixel(sizeX, window, x, y, fillColor)
            end
        end
    end
end
