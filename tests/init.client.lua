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

local myWindow = Window.new(windowUi, { sizeX = 50, sizeY = 50 })

local emptyTexture = texture.new(185, 436)

-- local txt = texture.from(script.sprite)
-- local mySprite = sprite.new(txt)
-- local secondSprite = sprite.new(emptyTexture)
-- -- mySprite:Draw(emptyTexture)

myWindow:Clear(color.MAGENTA)
draw.rectangle(myWindow, {
	xPos = 0,
	yPos = 0,
	width = 25,
	height = 25,
	fillColor = color.RED
})

print(texture.read(myWindow, 0, 0,  5, 5))
print(texture.read(myWindow, 30, 30,  5, 5))

-- Runs every heartbeat
while myWindow:IsOpen() do
	
	-- secondSprite:Draw(myWindow)
	myWindow:Render()

end

print("The window has been destroyed.")
