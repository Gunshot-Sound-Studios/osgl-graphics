-- Script

local UserInputService = game:GetService("UserInputService")
local finished = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SIZE_X = 1000
local SIZE_Y = 1000

local OSGL = require(ReplicatedStorage.OSGL)
local window = OSGL.Window
local color = OSGL.color
local Sprite = OSGL.Sprite
local Texture = OSGL.texture

local myWindow = window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window, { sizeX = SIZE_X, sizeY = SIZE_Y })

for x = 0, SIZE_X - 1 do
    for y = 0, SIZE_Y - 1 do
        myWindow:WritePixel(x, y, color.new(math.random(255), math.random(255), math.random(255)))
    end
end

while myWindow:IsOpen() do
    myWindow:Clear(color.BLACK)
    myWindow:Render()
end