--!native
--!optimize 2

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").ImageLabel

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local draw = OSGL.draw
local color = OSGL.color

local myWindow = Window.new(windowUi, { sizeX = SIZE_X, sizeY = SIZE_Y })

while myWindow:IsOpen() do
    myWindow:Clear(color.TRANSPARENT)

    draw.rectangle(myWindow, {
        xPos = math.random(0, SIZE_X),
        yPos = math.random(0, SIZE_Y),
        width = 800,
        height = 900,
        fillColor = color.WHITE,
        strokeColor = color.RED,
        strokeThickness = 50,
    })

    myWindow:Render()
end

-- print("The window has been destroyed.")