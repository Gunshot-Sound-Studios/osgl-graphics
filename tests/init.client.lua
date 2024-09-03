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

-- Runs every heartbeat
local rot = 0

while myWindow:IsOpen() do

    -- Render here
    myWindow:Clear(color.TRANSPARENT)

    draw.circle(myWindow, {
        centerX = math.random(0, SIZE_X),
        centerY = math.random(0, SIZE_Y),
        radius = 400,
        fillColor = color.WHITE,
        strokeColor = color.RED,
        strokeThickness = 50,
    })
    
    -- Stop rendering here

    myWindow:Render()
    rot += 1
end

-- print("The window has been destroyed.")