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

local myWindow = Window.new(windowUi, { sizeX = 30, sizeY = 30 })

-- Runs every heartbeat
local rot = 0

while myWindow:IsOpen() do

    -- Render here
    -- Draw our 
    myWindow:Clear(color.TRANSPARENT)

    draw.line(myWindow, {
        startX = 0,
        startY = 0,
        stopX = 29,
        stopY = 29,
    })
    
    -- Stop rendering here

    myWindow:Render()
    rot += 1
end

-- print("The window has been destroyed.")