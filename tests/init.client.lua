--!optimize 2
-- ^^ This flag optimises

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local color = OSGL.color

local myWindow = Window.new(windowUi, { sizeX = 50, sizeY = 50 })
myWindow:Clear(color.BLACK)
myWindow:Render()