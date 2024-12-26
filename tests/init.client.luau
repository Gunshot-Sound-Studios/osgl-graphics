local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local screenGui = plr.PlayerGui:WaitForChild("ScreenGui")

local window = screenGui.Window
local A = screenGui.A
local B = screenGui.B

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local texture = OSGL.Texture
local draw = OSGL.draw
local color = OSGL.color


local config = { sizeX = SIZE_X, sizeY = SIZE_Y }
local myWindow = Window.new(window, config)
myWindow.targetFPS = 275

local txt = texture.fromAssetId(94762137675783)
local newTexture = texture.scale(txt, 3)

while task.wait() do
    for x = 0, SIZE_X-1 do
        for y = 0, SIZE_Y-1 do
            draw.pixel(myWindow, x, y, color.RED)
        end
    end

    myWindow:Render()
end