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
local points = { { 0, 0 }, { 900, 900 }, { 900, 450 } }
local colors = {
	color.RED,
	color.BLACK,
	color.BLUE,
	color.CYAN,
	color.GREEN,
	color.MAGENTA,
	color.WHITE,
	color.YELLOW,
}

-- Runs every heartbeat
while myWindow:IsOpen() do
	-- Render here
	-- Draws 100 tris at 2, 2, with a random color, onto "myWindow"
	-- This should run about 20FPS (atleast 20FPS on my laptop). Nice.
	for _ = 0, 100 do
		draw.points(myWindow, {
			points = points,
			fillColor = colors[math.random(1, 8)],
			x = 2,
			y = 2,
		})

		table.clear(points)
		for _ = 0, 2 do
			table.insert(points, { math.random(0, 900), math.random(0, 900) })
		end
	end
	-- Stop rendering here

	myWindow:Render()
	--myWindow:Clear()
end

print("The window has been destroyed.")
