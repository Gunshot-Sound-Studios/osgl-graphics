-- Script

local UserInputService = game:GetService("UserInputService")
local finished = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local window = OSGL.Window
local color = OSGL.color
local Sprite = OSGL.Sprite
local Texture = OSGL.texture

local sprite = Sprite.new(Texture.from(script.Parent.ModuleScript))

local myWindow = window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window, { sizeX = SIZE_X, sizeY = SIZE_Y })

for x = 0, SIZE_X - 1 do
    for y = 0, SIZE_Y - 1 do
        myWindow:WritePixel(x, y, color.new(math.random(255), math.random(255), math.random(255)))
    end
end
sprite:Draw(myWindow)

myWindow:Render()
task.wait(1)
myWindow:Tint(color.RED, 0.5)
myWindow:Render()
