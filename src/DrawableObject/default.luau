local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local privateTypes = require(OSGL.DrawableObject.types)

local PixelStorage = {} :: privateTypes.PixelStorageBuilder<Pixel>
PixelStorage.__index = PixelStorage

type Pixel = types.Color
type PixelStorage = privateTypes.PixelStorage<Pixel> & {
    pixels: { Pixel }
}

function PixelStorage.new(sizeX: number, sizeY: number)
    local self = setmetatable({
        pixels = table.create(sizeX * sizeY, 0),
    }, PixelStorage)

    return self
end

function PixelStorage.Render(self: PixelStorage, image: EditableImage, size: Vector2)
	local final = table.create(#self.pixels * 4, 0) :: { number }
	local n = math.round(#final / 2)

	for i, pixelColor in ipairs(self.pixels) do
		if i % n == 0 then
			task.wait()
		end

		local i = (i - 1) * 4
		final[i + 1] = color.r(pixelColor)
		final[i + 2] = color.g(pixelColor)
		final[i + 3] = color.b(pixelColor)
		final[i + 4] = color.a(pixelColor)
	end

	image:WritePixels(Vector2.zero, size, final)
end

function PixelStorage.Clear(self: PixelStorage, clearColor: Pixel)
    self.pixels = table.create(#self.pixels, clearColor)
end

function PixelStorage.Resize(
    self: PixelStorage,
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

function PixelStorage.ReadPixel(
    self: PixelStorage,
    x: number,
    y: number,
    sizeX: number
): Pixel
    return self.pixels[(y * sizeX + x) + 1]
end

function PixelStorage.ReadIndex(self: PixelStorage, i: number): Pixel
    return self.pixels[i]
end

function PixelStorage.WritePixel(
    self: PixelStorage,
    x: number,
    y: number,
    sizeX: number,
    newColor: Pixel
)
    self.pixels[(y * sizeX + x) + 1] = newColor
end

function PixelStorage.WriteIndex(self: PixelStorage, i: number, newColor: Pixel)
    self.pixels[i] = newColor
end

function PixelStorage.GetIndex(self: PixelStorage, x: number, y: number, sizeX: number): number
    return (y * sizeX + x) + 1
end

return PixelStorage
