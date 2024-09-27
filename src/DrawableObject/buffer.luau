local OSGL = script.Parent.Parent
local types = require(OSGL.types)
local privateTypes = require(OSGL.DrawableObject.types)

local PixelStorage = {} :: privateTypes.PixelStorageBuilder<Pixel>
PixelStorage.__index = PixelStorage

type Pixel = types.Color
type PixelStorage = privateTypes.PixelStorage<Pixel> & {
    buffer: buffer,
}

function PixelStorage.new(sizeX: number, sizeY: number)
    local self = setmetatable({
        buffer = buffer.create(sizeX * sizeY * 4),
    }, PixelStorage)

    return self
end

function PixelStorage.Render(self: PixelStorage, image: EditableImage, size: Vector2)
	image:WritePixelsBuffer(Vector2.zero, size, self.buffer)
end

function PixelStorage.Clear(self: PixelStorage, clearColor: Pixel)
    local color = buffer.create(4)
    buffer.writeu32(color, 0, clearColor)
    buffer.copy(self.buffer, 0, color)
end

function PixelStorage.Resize(
    self: PixelStorage,
    _: number,
    _: number,
    newWidth: number,
    newHeight: number
)
    local resizedBuffer = buffer.create(newWidth * newHeight * 4)
    buffer.copy(resizedBuffer, 0, self.buffer)

	self.buffer = resizedBuffer
end

function PixelStorage.ReadPixel(
    self: PixelStorage,
    x: number,
    y: number,
    sizeX: number
): Pixel
    return buffer.readu32(self.buffer, (y * sizeX + x) * 4)
end

function PixelStorage.WritePixel(
    self: PixelStorage,
    x: number,
    y: number,
    sizeX: number,
    newColor: Pixel
)
    buffer.writeu32(self.buffer, (y * sizeX + x) * 4, newColor)
end

function PixelStorage.WriteIndex(self: PixelStorage, i: number, newColor: Pixel)
    buffer.writeu32(self.buffer, i * 4, newColor)
end

return PixelStorage
