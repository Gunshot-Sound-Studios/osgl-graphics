-- Standalone script showcasing OSGL

-- OSGL v1.5b - Open-Source Graphical Library

-- OSGL is provided 'as-is' without any warranty. Use at your own risk.
-- Everyone is free to use, modify, and redistribute OSGL.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local Texture = OSGL.Texture

local player = Players.LocalPlayer
assert(player)

-- Define window dimensions
local WIDTH = 9
local HEIGHT = 9

-- Create ImageLabel & ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.fromScale(.5, .5)
ImageLabel.Size = UDim2.fromOffset(420, 420)
ImageLabel.Parent = ScreenGui
ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated

-- Create the window
local window = Window.new(ImageLabel, { sizeX = WIDTH, sizeY = HEIGHT })
window.targetFPS = 244

-- local baseTexture = Texture.new(9, 9)
-- local mouth = Texture.from(script.mouth)
-- local eye = Texture.from(script.eye)

-- Texture.draw(baseTexture, mouth, 0, 0)
-- -- Texture.draw(baseTexture, eye, 1, 3)
-- Texture.draw(baseTexture, eye, 7, 3)

-- Texture.draw(window, baseTexture, 0, 0)
-- window:Render()

local s = Texture.from(script["6"])
local f = Texture.from(script["4"])

--Texture.draw(s, f, 0, 0)
Texture.draw(window, s, 0, 0)
window:Render()