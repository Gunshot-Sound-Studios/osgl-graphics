-- Script

local UserInputService = game:GetService("UserInputService")
local finished = false

UserInputService.WindowFocusReleased:Connect(function()
	if not finished then
		print("WHY WINDOW RELEASED? THIS WILL MAKE IT INACCURATE")
	end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.OSGL)
local window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

local myWindow = window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window, { sizeX = 1024, sizeY = 1024 })

draw.circle(myWindow, { centerX = 0, centerY = 0, radius = 500, fillColor = color.RED })
draw.tint(myWindow, color.GREEN, .1)

myWindow:Render()