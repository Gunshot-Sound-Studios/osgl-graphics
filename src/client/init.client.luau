local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OSGL = require(ReplicatedStorage.Shared.OSGL)
local Window = OSGL.Window
local Color = OSGL.Color
local Draw = OSGL.Draw

local myWindow = Window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").ImageLabel, { sizeX = 1024, sizeY = 1024 })

local rnd  = Random.new()
-- Runs every heartbeat
while myWindow:IsOpen() do
	-- Render here

	for X = 0, 1023 do
		for Y = 0, 1023 do
            local R, G, B = rnd:NextInteger(0, 255), rnd:NextInteger(0, 255), rnd:NextInteger(0, 255)
            Draw.pixel(myWindow, X, Y, Color.new(R, G, B))
		end
        
        if X % 200 == 0 then
            task.wait() 
        end
	end
	-- Stop rendering here

	myWindow:Render()
end

print("The window has been destroyed.")
