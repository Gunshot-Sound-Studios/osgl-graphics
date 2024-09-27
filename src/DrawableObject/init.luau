--!strict
--!native
--!optimize 2

local UserInputService = game:GetService("UserInputService")

local OSGL = script.Parent
local types = require(OSGL.types)
local privateTypes = require(script.types)
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

type DrawableObject<P> = types.Drawable<P>

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

return DrawableObject
