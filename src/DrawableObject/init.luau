--!strict
--!native
--!optimize 2

local UserInputService = game:GetService("UserInputService")

local OSGL = script.Parent
local types = require(OSGL.types)
local color = require(OSGL.color)
local utils = require(OSGL.utils)
local config = require(OSGL.config)
local PixelStorage
do
    if config.useBufferPixelStorage then
        PixelStorage = require(script.buffer)
    else
        PixelStorage = require(script.default)
    end
end

local DrawableObject = {}
DrawableObject.__index = DrawableObject
DrawableObject.PixelStorage = PixelStorage

type DrawableObject<P> = types.DrawableObject<P>

function DrawableObject.GetRelativeMouse<P>(self: DrawableObject<P>): (boolean, number, number)
    local sizeFactor = self.size / self.renderer.Parent.AbsoluteSize
    local mousePosition = UserInputService:GetMouseLocation() - self.renderer.Parent.AbsolutePosition

    local relativeMousePosition = mousePosition * sizeFactor
    local isInWindow = relativeMousePosition.X > 0 and relativeMousePosition.Y > 0

    return isInWindow, math.round(relativeMousePosition.X), math.round(relativeMousePosition.Y)
end

function DrawableObject.ReadPixel<P>(self: DrawableObject<P>, x: number, y: number): types.Color
    return self.pixelStorage:ReadPixel(x, y, self.sizeX)
end

function DrawableObject.WritePixel<P>(self: DrawableObject<P>, x: number, y: number, newColor: types.Color)
    self.pixelStorage:WritePixel(x, y, self.sizeX, newColor)
end

function DrawableObject.Tint<P>(self: DrawableObject<P>, tint: types.Color, tintFactor: number)
    self:TintRegion(tint, tintFactor, 0, 0, self.sizeX - 1, self.sizeY - 1)
end

function DrawableObject.TintRegion<P>(
    self: DrawableObject<P>,
    tint: types.Color,
    tintFactor: number,
    x: number,
    y: number,
    width: number,
    height: number
)
    local tintR = color.r(tint)
    local tintG = color.g(tint)
    local tintB = color.b(tint)
    local tintA = color.a(tint)

    for x = x, x + width do
        for y = y, y + height do
            local pixelColor = self.pixelStorage:ReadPixel(x, y, self.sizeX)

            self.pixelStorage:WritePixel(
                x,
                y,
                self.sizeX,
                color.new(
                    utils.lerp(color.r(pixelColor), tintR, tintFactor),
                    utils.lerp(color.g(pixelColor), tintG, tintFactor),
                    utils.lerp(color.b(pixelColor), tintB, tintFactor),
                    utils.lerp(color.a(pixelColor), tintA, tintFactor)
                )
            )
        end
    end
end

function DrawableObject.FloodFill<P>(
    self: DrawableObject<P>,
    newColor: types.Color,
    x: number?,
    y: number?
)
    x = x or 0
    y = y or 0

    local sizeX, sizeY = self.sizeX, self.sizeY
    local originalColor = self:ReadPixel(x, y)
    local pixelStorage = self.pixelStorage

    -- Creates more than enough memory, better optimization.
    local checked = table.create(self.sizeX * self.sizeY, false)
    local stack = table.create(self.sizeX * self.sizeY, 0)
    stack[1] = pixelStorage:GetIndex(x, y, sizeX)

    local MAX_INDEX = pixelStorage:GetIndex(sizeX - 1, sizeY - 1, sizeX)
    while #stack > 0 do
        local currentIndex = stack[#stack]
        stack[#stack] = nil

        if checked[currentIndex] or currentIndex < 0 or currentIndex > MAX_INDEX then
            continue
        end
        checked[currentIndex] = true

        if pixelStorage:ReadIndex(currentIndex) ~= originalColor then
            continue;
        end
        pixelStorage:WriteIndex(currentIndex, newColor)

        stack[#stack + 1] = pixelStorage:OffsetIndex(currentIndex, 1, 0, sizeX)
        stack[#stack + 1] = pixelStorage:OffsetIndex(currentIndex, -1, 0, sizeX)
        stack[#stack + 1] = pixelStorage:OffsetIndex(currentIndex, 0, 1, sizeX)
        stack[#stack + 1] = pixelStorage:OffsetIndex(currentIndex, 0, -1, sizeX)
    end
end

return DrawableObject
