--!optimize 2
-- ^^ This flag optimises 

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local texture = OSGL.texture
local sprite = OSGL.Sprite
local draw = OSGL.draw
local color = OSGL.color

local myWindow = Window.new(windowUi, { sizeX = 1024, sizeY = 1024 })
-- An array of points (x, y)
local starPoints = {
    {0, 0},
	{600, 0},
	{600, 600},
	{0, 600}
}
-- Runs every heartbeat
while myWindow:IsOpen() do
	-- Render here
	-- Draws a triangle at 0, 0, with a red color, onto "myWindow"
	draw.points(myWindow, {
		points = starPoints,
		color = color.RED,
		x = 2,
		y = 2,
	})
	-- Stop rendering here

	myWindow:Render()
end

print("The window has been destroyed.")