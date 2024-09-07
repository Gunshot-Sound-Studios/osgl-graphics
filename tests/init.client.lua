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

local myWindow = Window.new(windowUi, { sizeX = SIZE_X, sizeY = SIZE_Y })
local txt = texture.from(script.Parent.st)
draw.circle(txt, {
	centerX = 250,
	centerY = 250,
	radius = 200,
	fillColor = color.RED
})


local spriteTest = sprite.new(txt)
while myWindow:IsOpen() do
	spriteTest:Draw(myWindow)
	myWindow:Render()
end

print("End.")
