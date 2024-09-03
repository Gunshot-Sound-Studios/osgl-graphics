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

local myWindow = Window.new(windowUi, { sizeX = 8, sizeY = 4 })
myWindow:Clear(color.BLUE)
myWindow:Resize(4, 4)
myWindow:Render() 
draw.pixel(myWindow, 0, 0, color.RED)
myWindow:Render()
myWindow:Resize(8, 4) --// Changes width to 100
myWindow:Render()

-- Runs every heartbeat
-- while myWindow:IsOpen() do
--     -- Render here

--     myWindow:Clear(color.WHITE)
--     draw.pixel(myWindow, 49, 24, color.BLUE)
--     -- Stop rendering here

--     myWindow:Render()
-- end
