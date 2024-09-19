local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local privateTypes = require(OSGL.window.types)

local PixelStorage = {} :: PixelStorage
PixelStorage.__index = PixelStorage

type Pixel = types.Color
type Pixels = { Pixel }
type PixelStorage = privateTypes.PixelStorage<Pixel, Pixels> & {}

function PixelStorage.new(sizeX: number, sizeY: number)
    local self = setmetatable({
        pixels = table.create(sizeX * sizeY, 0),
    }, PixelStorage)

    return self
end

function PixelStorage:Render(image: EditableImage)
	local final = table.create(#self.pixels * 4, 0) :: { number }
	local n = math.round(#final / 2)

	for i, color in ipairs(self.pixels) do
		if i % n == 0 then
			task.wait()
		end

		local i = (i - 1) * 4
		final[i + 1] = bit32.rshift(color, 24) / 255
		final[i + 2] = bit32.band(bit32.rshift(color, 16), 0xFF) / 255
		final[i + 3] = bit32.band(bit32.rshift(color, 8), 0xFF) / 255
		final[i + 4] = bit32.band(color, 0xFF) / 255
	end

	image:WritePixels(Vector2.zero, self.size, final)
end

function PixelStorage:Clear(clearColor: Pixel)
    self.pixels = table.create(self.sizeX * self.sizeY, clearColor)
end

function PixelStorage:Resize(
    oldWidth: number,
    oldHeight: number,
    newWidth: number,
    newHeight: number
)
	local resizedPixels = table.create(newWidth * newHeight, 0)

	for y = 0, newHeight - 1 do
        if y > oldHeight then
            break
        end

		for x = 0, newWidth - 1 do
			if x > oldWidth then
                break
			end

            local oldIndex = (y * oldWidth) + x + 1
            local newIndex = (y * newWidth) + x + 1

            resizedPixels[newIndex] = self.pixels[oldIndex]
		end
	end

	self.pixels = resizedPixels
end

function PixelStorage:ReadPixel(x: number, y: number): Pixel
    return self.pixels[(y * self.sizeX + x) + 1]
end

function PixelStorage:WritePixel(x: number, y: number, newColor: Pixel)
    self.pixels[(y * self.sizeX + x) + 1] = newColor
end

return PixelStorage
