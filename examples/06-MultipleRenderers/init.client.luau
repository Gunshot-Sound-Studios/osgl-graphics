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

local player = Players.LocalPlayer
assert(player)

-- Define window dimensions
local WIDTH = 3
local HEIGHT = 3

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
ImageLabel.Size = UDim2.fromOffset(420, 420)
ImageLabel.Parent = ScreenGui
ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated

local RendererA = Instance.new("ImageLabel")
RendererA.AnchorPoint = Vector2.new(0.5, 0.5)
RendererA.Position = UDim2.fromScale(0.25, 0.5)
RendererA.Size = UDim2.fromOffset(200, 200)
RendererA.Parent = ScreenGui
RendererA.ResampleMode = Enum.ResamplerMode.Pixelated

local RendererB = Instance.new("ImageLabel")
RendererB.AnchorPoint = Vector2.new(0.5, 0.5)
RendererB.Position = UDim2.fromScale(0.75, 0.5)
RendererB.Size = UDim2.fromOffset(200, 200)
RendererB.Parent = ScreenGui
RendererB.ResampleMode = Enum.ResamplerMode.Pixelated

local ToggleRendering = Instance.new("TextButton")
ToggleRendering.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleRendering.Position = UDim2.fromScale(0.5, 0.125)
ToggleRendering.Size = UDim2.fromOffset(200, 50)
ToggleRendering.TextScaled = true
ToggleRendering.Text = "Toggle Rendering on A & B"
ToggleRendering.Parent = ScreenGui

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244

window:AddRenderer(RendererA, RendererB)

local enabled = true
ToggleRendering.MouseButton1Click:Connect(function()
	enabled = not enabled
    if enabled then
        window:AddRenderer(RendererA, RendererB)
    else
        window:RemoveRenderer(RendererA, RendererB)
    end
end)

local frames = script.frames
local video = Video.from({ frames.A, frames.B, frames.C })
video.frameRate = 6
video.loop = true

video:PlaySync(function(texture)
	Texture.draw(window, texture, 0, 0)
	window:Render()
end)
