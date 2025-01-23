-- Standalone script showcasing OSGL

-- OSGL v1.5b - Open-Source Graphical Library

-- OSGL is provided 'as-is' without any warranty. Use at your own risk.
-- Everyone is free to use, modify, and redistribute OSGL.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local Texture = OSGL.Texture
local Video = OSGL.Video
local enum = OSGL.Enum
local color = OSGL.color
local draw = OSGL.draw
local Font = OSGL.Font

local player = Players.LocalPlayer
assert(player)

-- Define window dimensions
local WIDTH = 496 
local HEIGHT = 662

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(.5, .5)
ImageLabel.Size = UDim2.fromOffset(496, 662)
ImageLabel.Parent = ScreenGui
ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated
ImageLabel.BackgroundTransparency = 1

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244
window.alphaBlendingMode = enum.AlphaBlendMode.Additive

local newTxt = Texture.from(script.hand)
Texture.draw(window, newTxt, 0, 0)

window:Render()