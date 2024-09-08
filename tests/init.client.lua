--!optimize 2
-- ^^ This flag optimises

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local texture = OSGL.texture
local sprite = OSGL.Sprite
local draw = OSGL.draw
local color = OSGL.color

local myWindow = Window.new(windowUi, { sizeX = 50, sizeY = 50 })


-- Runs every heartbeat

myWindow:Clear(color.BLACK)
while myWindow:IsOpen() do
	local x, y = myWindow:GetRelativeMouse()
	
	if x > 0 and y > 0 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		draw.pixel(myWindow, x, y, color.RED)
	end

	myWindow:Render()
end

print("The window has been destroyed.")
