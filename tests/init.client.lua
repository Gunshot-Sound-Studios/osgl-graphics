--!native
--!optimize 2

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").ImageLabel

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local Sprite = OSGL.Sprite
local draw = OSGL.draw
local color = OSGL.color
local texture = OSGL.texture

local myWindow = Window.new(windowUi, { sizeX = SIZE_X, sizeY = SIZE_Y })
local txt = texture.from(script.spritetest)

local sprite = Sprite.new(txt)
sprite.color = color.RED

while myWindow:IsOpen() do
	myWindow:Clear(color.TRANSPARENT)

	sprite:Draw(myWindow)
	myWindow:Render()
end

-- print("The window has been destroyed.")
