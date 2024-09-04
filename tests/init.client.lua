--!optimize 2
-- ^^ This flag optimises 


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window

local SIZE_X = 1024
local SIZE_Y = 1024

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local draw = OSGL.draw
local color = OSGL.color

local myWindow = Window.new(windowUi, { sizeX = SIZE_X, sizeY = SIZE_Y })
myWindow:SkipUnchangedRender(false)

while myWindow:IsOpen() do
	for y = 0, 1023 do
		 
		for x = 0, 1023 do
			local R, G, B = math.random(0, 255), math.random(0, 255), math.random(0, 255)
			draw.pixel(myWindow, x, y, color.new(R, G, B))
		end
		
		if y % 300 == 0 then
			task.wait()
		end
	end
	
	myWindow:Render()
end

-- print("The window has been destroyed.")
