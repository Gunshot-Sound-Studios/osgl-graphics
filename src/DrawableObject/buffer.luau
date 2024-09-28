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
    local bufferLength = buffer.len(self.buffer)
    local current_size = 4
    local numCopies = math.ceil(math.log(bufferLength / 4, 2))

    buffer.writeu32(self.buffer, 0, clearColor)

    for _ = 1, numCopies do
        local copy_size = math.min(current_size, bufferLength - current_size)
        buffer.copy(self.buffer, current_size, self.buffer, 0, copy_size)

        current_size += copy_size
    end
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

function PixelStorage.ReadIndex(self: PixelStorage, i: number): Pixel
    return buffer.readu32(self.buffer, i)
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
    buffer.writeu32(self.buffer, i, newColor)
end

function PixelStorage.GetIndex(self: PixelStorage, x: number, y: number, sizeX: number): number
    return (y * sizeX + x) * 4
end

function PixelStorage.OffsetIndex(
    _: PixelStorage,
    i: number,
    x: number,
    y: number,
    sizeX: number
): number
    return i + (y * sizeX + x) * 4
end

return PixelStorage
