-- Standalone script showcasing OSGL

-- OSGL v1.5b - Open-Source Graphical Library

-- OSGL is provided 'as-is' without any warranty. Use at your own risk.
-- Everyone is free to use, modify, and redistribute OSGL.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local player = Players.LocalPlayer
assert(player)

-- Define window dimensions
local WIDTH = 420
local HEIGHT = 420

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(.5, .5)
ImageLabel.Size = UDim2.fromOffset(WIDTH, HEIGHT)
ImageLabel.Parent = ScreenGui

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244

-- Draw
window
    :Clear(color.BLACK)
    :Draw()
    :Rectangle(0, 0, 150, 150, color.RED)
    :StopDrawing()
    :Render()