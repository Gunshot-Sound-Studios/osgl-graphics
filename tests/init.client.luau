-- Standalone script showcasing OSGL

-- OSGL v1.5b - Open-Source Graphical Library

-- OSGL is provided 'as-is' without any warranty. Use at your own risk.
-- Everyone is free to use, modify, and redistribute OSGL.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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
local WIDTH = 50 
local HEIGHT = 50

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui
ScreenGui.IgnoreGuiInset = false

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(.5, .5)
ImageLabel.Size = UDim2.fromOffset(400, 500)
ImageLabel.Parent = ScreenGui
ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated
ImageLabel.BackgroundTransparency = 0

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244
window.alphaBlendingMode = enum.AlphaBlendMode.Additive

RunService.Heartbeat:Connect(function(deltaTime)
    warn( window:GetRelativeMouseToRenderer(ImageLabel))
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local _, x, y = window:GetRelativeMouseToRenderer(ImageLabel)
        draw.pixel(window, x, y, color.BLACK)
        window:Render()
    end
end)